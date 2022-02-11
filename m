Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4374B4B2E05
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 20:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353001AbiBKTvf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 14:51:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352986AbiBKTve (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 14:51:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1729B2A1
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 11:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644609092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bne5fux8udNCXVzeyZDnPjq+FWuos4KPEoOYJ7iDvq8=;
        b=PsWPT4FGfuPMF/p+19DCtEaD5ukAjqAWzNpExLPFMFR1yvXQHlucCW7AhU2szDBqLYIa8o
        toajuVW10/rO08Oyp3m3YbqZYQTaCktSY2I6zasutsCls8MS/n7WZOv0hI8JQN2km56Pff
        P/Ey9K+XATluU/rNEv9UzYZMHKOHuWg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-fjgKdyphOySUbj6F85gMYg-1; Fri, 11 Feb 2022 14:51:29 -0500
X-MC-Unique: fjgKdyphOySUbj6F85gMYg-1
Received: by mail-ej1-f71.google.com with SMTP id la22-20020a170907781600b006a7884de505so4547467ejc.7
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 11:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bne5fux8udNCXVzeyZDnPjq+FWuos4KPEoOYJ7iDvq8=;
        b=b6l0BYker7hIIA8Nr5ket9SgA19mPVBpP9hYVntB9r9BiYwN1aQw9AHmPZKYVeCU19
         Sull2P5bdQATY5RJQbmSNvqrSnTecNIRDIHYOp0I7M1la7eFBU9otyJ4JPA9DXDinIe3
         sO0qBsjdntWm8TMgmK70u1m2LW3wUf0SsZ+b4EsezN9uq8FWHtk0RTdu+GX9vEKbv82q
         44TkOTLQEIr92M3Z0vg15Y3WZ2zk1fNjdTOQR0VHFgBexPWtGG3RnJbgh/0siXOB8nze
         psMiQ+CJEE6JJ7h8PUKEASAPi+Rf0mt05n5YtjRm+DG9526V+AtmX0Y5bt4R3Tgdw5WS
         hzMA==
X-Gm-Message-State: AOAM530uIYE3/+1Vqk995EwWN86CBQj0P+fOMkY7mpK4H6ECnk90ANdx
        darwtcf7NF1GhSM5RbDJ1fElmw1Vmb+6ZKG0mkLK7ynKhywWkHsgaewWWsIxWa2ySGpQWJ1coMz
        D9OgVzJNEVGc1
X-Received: by 2002:a17:906:c149:: with SMTP id dp9mr2692368ejc.57.1644609088012;
        Fri, 11 Feb 2022 11:51:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw79y+nQK1hJW6XGH9Bj3uYGaHaUO6u5ZDRgmeAfs+pFpPU0EZk6tjQKly3FwpXi1BcLZV7jg==
X-Received: by 2002:a17:906:c149:: with SMTP id dp9mr2692332ejc.57.1644609087131;
        Fri, 11 Feb 2022 11:51:27 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a8sm4958833edy.94.2022.02.11.11.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 11:51:26 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D0159102D8C; Fri, 11 Feb 2022 20:51:25 +0100 (CET)
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
Subject: [PATCH bpf-next] libbpf: Use dynamically allocated buffer when receiving netlink messages
Date:   Fri, 11 Feb 2022 20:51:00 +0100
Message-Id: <20220211195101.591642-1-toke@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Reported-by: Zhiqian Guan <zhguan@redhat.com>
Fixes: 8bbb77b7c7a2 ("libbpf: Add various netlink helpers")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/netlink.c | 55 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index c39c37f99d5c..9a6e95206bf0 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -87,22 +87,70 @@ enum {
 	NL_DONE,
 };
 
+static int __libbpf_netlink_recvmsg(int sock, struct msghdr *mhdr, int flags)
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
+static int libbpf_netlink_recvmsg(int sock, struct msghdr *mhdr, char **buf)
+{
+	struct iovec *iov = mhdr->msg_iov;
+	void *nbuf;
+	int len;
+
+	len = __libbpf_netlink_recvmsg(sock, mhdr, MSG_PEEK | MSG_TRUNC);
+	if (len < 0)
+		return len;
+
+	if (len < 4096)
+		len = 4096;
+
+	if (len > iov->iov_len) {
+		nbuf = realloc(iov->iov_base, len);
+		if (!nbuf) {
+			free(iov->iov_base);
+			return -ENOMEM;
+		}
+		iov->iov_base = nbuf;
+		iov->iov_len = len;
+	}
+
+	len = __libbpf_netlink_recvmsg(sock, mhdr, 0);
+	if (len > 0)
+		*buf = iov->iov_base;
+	return len;
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
+	char *buf;
+
 
 	while (multipart) {
 start:
 		multipart = false;
-		len = recv(sock, buf, sizeof(buf), 0);
+		len = libbpf_netlink_recvmsg(sock, &mhdr, &buf);
 		if (len < 0) {
-			ret = -errno;
+			ret = len;
 			goto done;
 		}
 
@@ -151,6 +199,7 @@ static int libbpf_netlink_recv(int sock, __u32 nl_pid, int seq,
 	}
 	ret = 0;
 done:
+	free(iov.iov_base);
 	return ret;
 }
 
-- 
2.35.1

