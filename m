Return-Path: <bpf+bounces-37048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15909508FF
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 17:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 524ECB27AF9
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBC11A072B;
	Tue, 13 Aug 2024 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hd6j4/bm"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0DD1A071F
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562741; cv=none; b=fTN9JNWiUBDD6CVMg2L2U6/I1IwSzhHCLZGZimEK00uy0gsJVxEOVI12bdrbscaf53G4GNw2TeFe8FPgNwSGCoITjWkw15xFjwkMzJTjhpl6/9fxV56I6/TTtOH24QCc+NToqAElCOeEWlKMMpQK8cobPuIwxB7/lO/J6L+D1II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562741; c=relaxed/simple;
	bh=mxHq/5EUcyhgedYifQgGr+iOrVpFzjFryPlXatYl4sg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kum3zKD6lIocdRt3EsAhYHvlwltbAZyd1A+G9GoBXhSSARvNORlFM2LCBpsAZht9kMDldAOKPvGPrEjevVVIlaJtDtpZj3u7kzJPi+Y9VcaV+FhZsZWPd8Lhuwe347hG4zLx0PigByuzKLfodePxmjgwzNh6nHo4l0972GQHu2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hd6j4/bm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723562738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=I0nMtqh5iidb3sneVEeyHU76edxYtexTc0QHqAomIJQ=;
	b=Hd6j4/bmVdOeuosXUSc75O0sz0AhUfeS1ivKz96WTW7axMY/YkHuayNSFRaMfX/AW1hNqX
	xAcLmbm4g9LmoUqvRcRgmwaYk0vAvLeD7It6z84EhL9/5YcCFXyjbrg0BPipX6kUu1RUgz
	ARWWGalNFJS2WBdiTknX3awRhQkNXJE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-996ghpllPvagZ2IuCcEghQ-1; Tue,
 13 Aug 2024 11:25:33 -0400
X-MC-Unique: 996ghpllPvagZ2IuCcEghQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 869D619541A8;
	Tue, 13 Aug 2024 15:25:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.159])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9E8B719560A3;
	Tue, 13 Aug 2024 15:25:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 13 Aug 2024 17:25:28 +0200 (CEST)
Date: Tue, 13 Aug 2024 17:25:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH tip/perf/core] bpf: fix use-after-free in
 bpf_uprobe_multi_link_attach()
Message-ID: <20240813152524.GA7292@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

If bpf_link_prime() fails, bpf_uprobe_multi_link_attach() goes to the
error_free label and frees the array of bpf_uprobe's without calling
bpf_uprobe_unregister().

This leaks bpf_uprobe->uprobe and worse, this frees bpf_uprobe->consumer
without removing it from the uprobe->consumers list.

Cc: stable@vger.kernel.org
Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Reported-by: syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000382d39061f59f2dd@google.com/
Tested-by: syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/trace/bpf_trace.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4e391daafa64..90cd30e9723e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3484,17 +3484,20 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 						    &uprobes[i].consumer);
 		if (IS_ERR(uprobes[i].uprobe)) {
 			err = PTR_ERR(uprobes[i].uprobe);
-			bpf_uprobe_unregister(uprobes, i);
-			goto error_free;
+			link->cnt = i;
+			goto error_unregister;
 		}
 	}
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err)
-		goto error_free;
+		goto error_unregister;
 
 	return bpf_link_settle(&link_primer);
 
+error_unregister:
+	bpf_uprobe_unregister(uprobes, link->cnt);
+
 error_free:
 	kvfree(uprobes);
 	kfree(link);
-- 
2.25.1.362.g51ebf55



