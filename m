Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529454B3182
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 00:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiBKXtd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 18:49:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354113AbiBKXtc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 18:49:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA507D5C
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 15:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644623369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VaVa3IZjf7+uYxHUheHWgkeVbJt7d2Z3wLlfkOHIfJM=;
        b=dDsiPR+r0ZXK/qMsxA9sIHNcBtCf6j5qLE6FLpqgG8qS3gW0lvcBiI1cYnCFegGCQ875oN
        627BPv9vQ2LskUMPo3P3xiWh5EbDJ1ynut8yspDRsfPIFbe4Dv2tvEcbe9Z5vYphMECABI
        vao/QLhDoCyAupT8wpKuHEcr4dg4QSI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-UvXnh8xPO_m0rZPOmgsb1g-1; Fri, 11 Feb 2022 18:49:28 -0500
X-MC-Unique: UvXnh8xPO_m0rZPOmgsb1g-1
Received: by mail-ed1-f72.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso6249446edt.20
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 15:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VaVa3IZjf7+uYxHUheHWgkeVbJt7d2Z3wLlfkOHIfJM=;
        b=OuM7QgIZWiDQ6VTCM0TmClv1GdpaqOg3b3A0u07hIWZU1R4Emptm0pCAX/xT4ofHgA
         hTSCyqlqloSQMUAslVqE1LFdyCA/K5BJ6SFTKh8jfPmDyRBVfWv1A7RwD6LcVrR6dwFq
         b2tikp0VFSMWeEGdc2JfZiTqDd4SXoQ8L0o3dQwDoKKBw1qGdZldlFuwefGBzqhnVjfe
         A/zy2ylEkRfMXDb7qa6NPOtldOh5IyNW5ydNxoJwowtIxU8s/4g95AhZUvgy0dG5icE+
         WRuPBJ4iT2qs+wChPa12hyhXgfbvIPgyDPf5UWcc2xm61VU3aC4pEz5I6rhTEBVdGVgj
         s0+w==
X-Gm-Message-State: AOAM530tF1M8CxcJa/FhEnq8k9ldkTrON5Q+QAWzHeRcdxQ5MyiqTD2P
        inUj9pw5d8mRfx7lpNaCLJ+iWCv7pD/537t1JOdJ3EyFhnpJ6qrv5z7df0QvDvc/zSF2qElJrDC
        6X7+vKvWvO5WU
X-Received: by 2002:aa7:cf06:: with SMTP id a6mr4494897edy.16.1644623367154;
        Fri, 11 Feb 2022 15:49:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEvCHEZ5ak2IQ0WT7TSoOvRodrsyMf34SG04BqYfuVd9+lhJbIzh9399k9MbHmC65JqYQYXQ==
X-Received: by 2002:aa7:cf06:: with SMTP id a6mr4494868edy.16.1644623366829;
        Fri, 11 Feb 2022 15:49:26 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id vp8sm7509868ejb.85.2022.02.11.15.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 15:49:26 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AC738102E4F; Sat, 12 Feb 2022 00:49:25 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Zhiqian Guan <zhguan@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v2] libbpf: Use dynamically allocated buffer when receiving netlink messages
Date:   Sat, 12 Feb 2022 00:48:19 +0100
Message-Id: <20220211234819.612288-1-toke@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When receiving netlink messages, libbpf was using a statically allocated
stack buffer of 4k bytes. This happened to work fine on systems with a 4k
page size, but on systems with larger page sizes it can lead to truncated
messages. The user-visible impact of this was that libbpf would insist no
XDP program was attached to some interfaces because that bit of the netlink
message got chopped off.

Fix this by switching to a dynamically allocated buffer; we borrow the
approach from iproute2 of using recvmsg() with MSG_PEEK|MSG_TRUNC to get
the actual size of the pending message before receiving it, adjusting the
buffer as necessary. While we're at it, also add retries on interrupted
system calls around the recvmsg() call.

v2:
  - Move peek logic to libbpf_netlink_recv(), don't double free on ENOMEM.

Reported-by: Zhiqian Guan <zhguan@redhat.com>
Fixes: 8bbb77b7c7a2 ("libbpf: Add various netlink helpers")
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/netlink.c | 55 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index c39c37f99d5c..a598061f6fea 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -87,29 +87,75 @@ enum {
 	NL_DONE,
 };
 
+static int netlink_recvmsg(int sock, struct msghdr *mhdr, int flags)
+{
+	int len;
+
+	do {
+		len = recvmsg(sock, mhdr, flags);
+	} while (len < 0 && (errno == EINTR || errno == EAGAIN));
+
+	if (len < 0)
+		return -errno;
+	return len;
+}
+
+static int alloc_iov(struct iovec *iov, int len)
+{
+	void *nbuf;
+
+	nbuf = realloc(iov->iov_base, len);
+	if (!nbuf)
+		return -ENOMEM;
+
+	iov->iov_base = nbuf;
+	iov->iov_len = len;
+	return 0;
+}
+
 static int libbpf_netlink_recv(int sock, __u32 nl_pid, int seq,
 			       __dump_nlmsg_t _fn, libbpf_dump_nlmsg_t fn,
 			       void *cookie)
 {
+	struct iovec iov = {};
+	struct msghdr mhdr = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
 	bool multipart = true;
 	struct nlmsgerr *err;
 	struct nlmsghdr *nh;
-	char buf[4096];
 	int len, ret;
 
+	ret = alloc_iov(&iov, 4096);
+	if (ret)
+		goto done;
+
 	while (multipart) {
 start:
 		multipart = false;
-		len = recv(sock, buf, sizeof(buf), 0);
+		len = netlink_recvmsg(sock, &mhdr, MSG_PEEK | MSG_TRUNC);
+		if (len < 0) {
+			ret = len;
+			goto done;
+		}
+
+		if (len > iov.iov_len) {
+			ret = alloc_iov(&iov, len);
+			if (ret)
+				goto done;
+		}
+
+		len = netlink_recvmsg(sock, &mhdr, 0);
 		if (len < 0) {
-			ret = -errno;
+			ret = len;
 			goto done;
 		}
 
 		if (len == 0)
 			break;
 
-		for (nh = (struct nlmsghdr *)buf; NLMSG_OK(nh, len);
+		for (nh = (struct nlmsghdr *)iov.iov_base; NLMSG_OK(nh, len);
 		     nh = NLMSG_NEXT(nh, len)) {
 			if (nh->nlmsg_pid != nl_pid) {
 				ret = -LIBBPF_ERRNO__WRNGPID;
@@ -151,6 +197,7 @@ static int libbpf_netlink_recv(int sock, __u32 nl_pid, int seq,
 	}
 	ret = 0;
 done:
+	free(iov.iov_base);
 	return ret;
 }
 
-- 
2.35.1

