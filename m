Return-Path: <bpf+bounces-62251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1212AF71FE
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 13:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1A018802FB
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 11:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DD02E3B00;
	Thu,  3 Jul 2025 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COv+lDtZ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4E32E266C
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751541824; cv=none; b=KlDDfTLr3qKz5PkN9gldj5qfPZWOSzETZsuKD6HkZ88DXtrtF9tEyWBsjNPapOPFiZHeQWJ1XTz6IHhyNqI0uN3+JeHJpliS5ZskDidiE4ql4czvae0YHYHhk8xYgjf9hYcc413euSwaLUOVB3/IiEvxHNJuMOTPGDnK6Vn18O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751541824; c=relaxed/simple;
	bh=qCJ/Od0uSXuN2KvuQPi0q2CGVCbCbEn3umxbnY7hirA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bnS5q+vMPrHo9wKeI2TQZaY2G48+6947pHHudXv/muAqhk7Moa510xCJtsMKmOBdYC/MEWKWaAbdBljryrvJPxMwOZoQPXOGYb3NANqDKBhcTMhd+c96n3Ox+J56YLq/nfNZODk1fWsk/u7wpbNg9xtgHvoayyEKeIh4ttIAYao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COv+lDtZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751541821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PIJzNJK0FfXDsC5luatCe5NaXC4y6NbBybHk8bPHUtM=;
	b=COv+lDtZjzgvfz/qJmHIG8WLdoRnLBnxMvPHwmot3c1b5Lk3E2ovlwGedyZZ7X4ZwAMHDh
	nq5iitqLxXbmZqO+n6GWkh0/kEBlnQmGGZipXinfnxOOV+kMF3W3pvfkLxVbUA37D8tsFj
	iqZW8RUNPlqy+O6w4kJriUBWsu6ieb8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-pCrIXZajOiWLkb8vn0DhTQ-1; Thu, 03 Jul 2025 07:23:38 -0400
X-MC-Unique: pCrIXZajOiWLkb8vn0DhTQ-1
X-Mimecast-MFC-AGG-ID: pCrIXZajOiWLkb8vn0DhTQ_1751541818
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5bb68b386so2168789385a.3
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 04:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751541818; x=1752146618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIJzNJK0FfXDsC5luatCe5NaXC4y6NbBybHk8bPHUtM=;
        b=hbnfYAInAzuPbdHLmCqHXV4zf7jVkoE4pTcYtmG0DI8BFiQdQ9TISoDnse4z9b0ZY0
         zXaCUveEF4c4VEDYyTl0IPoceKu9gH8QlY9u3EWppkTgIugzzBgbNbqUA41uyjEtAydl
         PKp5pFvGUmcTeAN7TLpmWi3kHY8KJqx5qn+MQRdVcsSsVKkFR2zkGwkVygWpY2DnoS1u
         kV2z2Y7gHc7wjpyrZ/H91VvCK5zmBrbJyiSWki/RYN5DDtUnF+8Xr32eQgufa1JiAqV3
         U/pKqbd0wq9jqvPc05+khWiH69d4TyU5j/hj+XGlsXi1YtSks0ByBgy6cYmS3z8mMr5e
         MDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCURdAk4Nr0XMijrZ0qq41Dm1t+smHXKjHUpO4J2MI6qX6CW1VZ4HKI7hZKnUzR5d+JUbIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTdj/R3qn63YiwahZi10lpsae27i1RypKPdkXfvjMEvP0BG0fd
	STc0mav5y/rGKQkaBIX/XIokyFIZVNTtnoGDcgTGAMzpr6PyvuJraTOpXnh603obOSCu9b38Gsz
	GT3wenEEhUKJyKtKbiwDun8fddxawRPMpB6jpRB9pzFkdV7jSFqeV4g==
X-Gm-Gg: ASbGncv6NAGJUuPR3vIaCn+yizTqrUY8/+2s3RVw/avfyT6fO6dC0mVPPHp4Xo5HBvg
	ahPZDwgPWLVT37kna9G7YmNNnnrAILCCz1VN2V9wWgXsVRa2JxTkJaqjiPadsB3812etDzfJZOn
	tQje9pUF9lpiESGF5/Zar3TSR0HsTLJndWc36D2PEc8OS3Vn/xjNfnsSw1pJ1zPpY2Qpx9sOKFp
	Br1LxX9SehILbY5XRqESjdiaTeyOU3jPB+qiltLbUV6zL0k41aM5+1QgCRpVZtT7PKTuwxbQCnX
	lvDo4VGfWqe0dqc6uflbiJuVwcRvIg==
X-Received: by 2002:a05:620a:8389:b0:7d4:3ac2:4c4 with SMTP id af79cd13be357-7d5d14909e9mr501464085a.50.1751541817644;
        Thu, 03 Jul 2025 04:23:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIhjpqSJkjkr7yySi+zSYYPuX82fx+PYQJJ7PyIEcTrA1s0zbfEWG0IS+SDm5LkMQyKv6eIg==
X-Received: by 2002:a05:620a:8389:b0:7d4:3ac2:4c4 with SMTP id af79cd13be357-7d5d14909e9mr501460785a.50.1751541817217;
        Thu, 03 Jul 2025 04:23:37 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.161.238])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44313925dsm1088725885a.24.2025.07.03.04.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:23:36 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net] vsock: fix `vsock_proto` declaration
Date: Thu,  3 Jul 2025 13:23:29 +0200
Message-ID: <20250703112329.28365-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

From commit 634f1a7110b4 ("vsock: support sockmap"), `struct proto
vsock_proto`, defined in af_vsock.c, is not static anymore, since it's
used by vsock_bpf.c.

If CONFIG_BPF_SYSCALL is not defined, `make C=2` will print a warning:
    $ make O=build C=2 W=1 net/vmw_vsock/
      ...
      CC [M]  net/vmw_vsock/af_vsock.o
      CHECK   ../net/vmw_vsock/af_vsock.c
    ../net/vmw_vsock/af_vsock.c:123:14: warning: symbol 'vsock_proto' was not declared. Should it be static?

Declare `vsock_proto` regardless of CONFIG_BPF_SYSCALL, since it's defined
in af_vsock.c, which is built regardless of CONFIG_BPF_SYSCALL.

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/net/af_vsock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d56e6e135158..d40e978126e3 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -243,8 +243,8 @@ int __vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
 int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
 			size_t len, int flags);
 
-#ifdef CONFIG_BPF_SYSCALL
 extern struct proto vsock_proto;
+#ifdef CONFIG_BPF_SYSCALL
 int vsock_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
 void __init vsock_bpf_build_proto(void);
 #else
-- 
2.50.0


