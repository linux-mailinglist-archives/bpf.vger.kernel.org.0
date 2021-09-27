Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C5D41946A
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 14:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhI0MlO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 08:41:14 -0400
Received: from www62.your-server.de ([213.133.104.62]:38760 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbhI0MlK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 08:41:10 -0400
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mUpuq-000Gip-5x; Mon, 27 Sep 2021 14:39:28 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     alexei.starovoitov@gmail.com
Cc:     andrii@kernel.org, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        syzbot+df709157a4ecaf192b03@syzkaller.appspotmail.com,
        syzbot+533f389d4026d86a2a95@syzkaller.appspotmail.com,
        Tejun Heo <tj@kernel.org>, Stanislav Fomichev <sdf@google.com>
Subject: [PATCH bpf v2 1/2] bpf, cgroup: Assign cgroup in cgroup_sk_alloc when called from interrupt
Date:   Mon, 27 Sep 2021 14:39:20 +0200
Message-Id: <20210927123921.21535-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26305/Mon Sep 27 11:04:42 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If cgroup_sk_alloc() is called from interrupt context, then just assign the
root cgroup to skcd->cgroup. Prior to commit 8520e224f547 ("bpf, cgroups:
Fix cgroup v2 fallback on v1/v2 mixed mode") we would just return, and later
on in sock_cgroup_ptr(), we were NULL-testing the cgroup in fast-path, and
iff indeed NULL returning the root cgroup (v ?: &cgrp_dfl_root.cgrp). Rather
than re-adding the NULL-test to the fast-path we can just assign it once from
cgroup_sk_alloc() given v1/v2 handling has been simplified. The migration from
NULL test with returning &cgrp_dfl_root.cgrp to assigning &cgrp_dfl_root.cgrp
directly does /not/ change behavior for callers of sock_cgroup_ptr().

syzkaller was able to trigger a splat in the legacy netrom code base, where
the RX handler in nr_rx_frame() calls nr_make_new() which calls sk_alloc()
and therefore cgroup_sk_alloc() with in_interrupt() condition. Thus the NULL
skcd->cgroup, where it trips over on cgroup_sk_free() side given it expects
a non-NULL object. There are a few other candidates aside from netrom which
have similar pattern where in their accept-like implementation, they just call
to sk_alloc() and thus cgroup_sk_alloc() instead of sk_clone_lock() with the
corresponding cgroup_sk_clone() which then inherits the cgroup from the parent
socket. None of them are related to core protocols where BPF cgroup programs
are running from. However, in future, they should follow to implement a similar
inheritance mechanism.

Additionally, with a !CONFIG_CGROUP_NET_PRIO and !CONFIG_CGROUP_NET_CLASSID
configuration, the same issue was exposed also prior to 8520e224f547 due to
commit e876ecc67db8 ("cgroup: memcg: net: do not associate sock with unrelated
cgroup") which added the early in_interrupt() return back then.

Fixes: 8520e224f547 ("bpf, cgroups: Fix cgroup v2 fallback on v1/v2 mixed mode")
Fixes: e876ecc67db8 ("cgroup: memcg: net: do not associate sock with unrelated cgroup")
Reported-by: syzbot+df709157a4ecaf192b03@syzkaller.appspotmail.com
Reported-by: syzbot+533f389d4026d86a2a95@syzkaller.appspotmail.com
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: syzbot+df709157a4ecaf192b03@syzkaller.appspotmail.com
Tested-by: syzbot+533f389d4026d86a2a95@syzkaller.appspotmail.com
Cc: Tejun Heo <tj@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
---
 v1 -> v2:
   - Note down more details about the issue in commit message (Tejun)

 kernel/cgroup/cgroup.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8afa8690d288..570b0c97392a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6574,22 +6574,29 @@ int cgroup_parse_float(const char *input, unsigned dec_shift, s64 *v)
 
 void cgroup_sk_alloc(struct sock_cgroup_data *skcd)
 {
-	/* Don't associate the sock with unrelated interrupted task's cgroup. */
-	if (in_interrupt())
-		return;
+	struct cgroup *cgroup;
 
 	rcu_read_lock();
+	/* Don't associate the sock with unrelated interrupted task's cgroup. */
+	if (in_interrupt()) {
+		cgroup = &cgrp_dfl_root.cgrp;
+		cgroup_get(cgroup);
+		goto out;
+	}
+
 	while (true) {
 		struct css_set *cset;
 
 		cset = task_css_set(current);
 		if (likely(cgroup_tryget(cset->dfl_cgrp))) {
-			skcd->cgroup = cset->dfl_cgrp;
-			cgroup_bpf_get(cset->dfl_cgrp);
+			cgroup = cset->dfl_cgrp;
 			break;
 		}
 		cpu_relax();
 	}
+out:
+	skcd->cgroup = cgroup;
+	cgroup_bpf_get(cgroup);
 	rcu_read_unlock();
 }
 
-- 
2.27.0

