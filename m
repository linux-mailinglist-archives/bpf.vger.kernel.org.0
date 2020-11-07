Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0602AA313
	for <lists+bpf@lfdr.de>; Sat,  7 Nov 2020 08:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgKGHpy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 7 Nov 2020 02:45:54 -0500
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:24315 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgKGHpy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 7 Nov 2020 02:45:54 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id B1DC16662F7;
        Sat,  7 Nov 2020 15:45:49 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH v3 bpf] trace: bpf: Fix passing zero to PTR_ERR()
Date:   Sat,  7 Nov 2020 15:45:44 +0800
Message-Id: <1604735144-686-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGR8eGBkZT05IGEgaVkpNS09MSE5KTktJQkpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nzo6Vjo6HD8YHRwTNTkSCyJK
        TQowCUJVSlVKTUtPTEhOSk5LTUJIVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFJS05PNwY+
X-HM-Tid: 0a75a1ab28649373kuwsb1dc16662f7
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is a bug when passing zero to PTR_ERR() and return.
Fix smatch err.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4517c8b..5113fd4
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1198,7 +1198,7 @@ static int bpf_btf_printf_prepare(struct btf_ptr *ptr, u32 btf_ptr_size,
 	*btf = bpf_get_btf_vmlinux();
 
 	if (IS_ERR_OR_NULL(*btf))
-		return PTR_ERR(*btf);
+		return IS_ERR(*btf) ? PTR_ERR(*btf) : -EINVAL;
 
 	if (ptr->type_id > 0)
 		*btf_id = ptr->type_id;
-- 
2.7.4

