Return-Path: <bpf+bounces-56582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3028A9AAFB
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 12:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD7D3AEDCE
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A249226CF4;
	Thu, 24 Apr 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8Oh4uvi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9876B221260;
	Thu, 24 Apr 2025 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491803; cv=none; b=SiWEAycNuzDeuRi+HTVamt0CBeXjGCTPsOjNdcLgEosKJ92mbjRvexA6oRJbRI/fq65Rdx46wFdfbNQGdpUrO/sj4TPjMAdtOrDNKWPp/IIgj+sQ+L6x955bjaZFCepYT9gu4dy+/dfvdZK+q+f1lIZBHPlQFarOseVV2gjj6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491803; c=relaxed/simple;
	bh=wA8lVB4aYxVAiaL/w8CUnf3RB0WE0OrhGgeiAdwLQDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1z8Ill/a7Lhn1PAPe8NkkhDfYYiDo+UoG0FK0IzUgMGcjymB6/9bS+Hkunq8WZ8eSHN24NZgwc0/rnumbD33D+giiOo+WoYgNtJhh3eZ2nbgFO9HbdwKodUCzSwlSyvPm7YABrh+DtodI9Uf2pLz2d7qwWiPbbWCpPGu9EU3Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8Oh4uvi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so782817b3a.1;
        Thu, 24 Apr 2025 03:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745491801; x=1746096601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBx30bACzPdvynzARNCXR72Us1nQHSIhvQyy+Kz/fPk=;
        b=Z8Oh4uviq4Vlle9Ytc31Idx8xsgE698scpwOcmR97VQvaFadb6kD1zhwbV56zx6pvn
         0Whr2tqt6rzuSEHDEOJog/wjTf3jXG6nHrpZZOXzCFAYkWpct5y0RNZrN9wVmkcykIdH
         CQaWdhmzybv5qmI5MDP+0l0IM1lmBmDXHj+kgkeCI8ERW8ZhM0vUildx4vcRoAVEX9Ln
         QLmA8QCuv5UE9or5FEj+sYIUFFf8nUFI9VBB4ApCMXvDcO4MO/GYOEjWhTIQGW8VihmQ
         RIJ+gs1mzFh2cvE7aozUgm19TBBrl8Nd3Jh7kk9skM6tzA+ntvEwERBU2sTFelJJzKEH
         Msyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745491801; x=1746096601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBx30bACzPdvynzARNCXR72Us1nQHSIhvQyy+Kz/fPk=;
        b=j6KOIA5y/koaIVo/81k7fYXPoWavRBWDTyTW0lUtkL8uz9/hoH3LRuG6dirLobP0P2
         J2x0seLpe99SIRK1pqilDfGMkz2IwGPaC46sZX/WxEYirn3aTPZSN/K2ItxZWEetRblg
         NCzfDyjiaDtig/72GqHV/a9J/Ho/wq2A9gJqMOFR2KsFMnhVROooPGOJ8NpObL6u8E0d
         hqhK+MSIJUlDVx+ULrmq207FZdgMQqJ0p9k1Vxn2M2S19729ReRLSdMLgjCXJxj0leVr
         X1HUvPksnIATbS3KHNvfX0XmiBtVz7U3n5APPh1X3Uuaa58k9RVIuabAMftxyz9S0Kst
         SrpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpdFlJgTNd+e9jRPGgj/5BAGJdIB7FLV0bNbCNOcsajZfObeppxyinNfW5leauMklOSDLxub6b@vger.kernel.org, AJvYcCW3WsxbxUCk+3pqkuS2+FOtiocR6/vyUZMkUKh0/8PRrllrJChwXQZU05Zs2cwc3M3Oz4DUDnQ2bybQrXKq@vger.kernel.org, AJvYcCXkLPTEoGaBWzcnPuvyLl3Wg9mzksvF1gyqLHUjapa+jFUravusUNXbOwUFNbYGaNfF91M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFZrEzuQDkgsZ87YE6LHYiKueKrda+uNBqYqIl2t9jrrjHEXek
	/fuwiyUZ9LZg9KzzlVlqTNRvTg76w9eVQV6Nd4611LHYHDdIjBgE
X-Gm-Gg: ASbGncsPe9IXHhMNZm/9G0wC0NvVI2a5qI+ZV/JUpg/AmKHbnxHQPsLYvVAt4vr6IT6
	K2S6jvnqSAyO0dCKLt8PH0HiZSBLEdsACbc7twHauwFmoLnczNBcPhLsD35X6FlwVqibhQ+KaVh
	6oGAfR9nByppqMjF+/kEwZWdvwP5MA7+AV4gcv9rSbkhkLe4j1si24hH+Ldpljc/kYurryd8c9/
	97AeOAi8LAjGzUzEYcFq2Nq4N/k7znafO9Qjf2QB/uPMIDk+eu1faHccI6wXa139ksN2K3cpcu2
	4tgJgsGXE66u1neOo985LetqLOHawgFixgdmjRhrUVU9LAuYsZAx0OD3
X-Google-Smtp-Source: AGHT+IEKfU0nmB/5B++mOPco6o12mEI223xQ9pX0CSxCbN6AdMo/5JJmz5Z+hAnFqSKkbj1bMDNHrA==
X-Received: by 2002:a05:6a00:278f:b0:736:31cf:2590 with SMTP id d2e1a72fcca58-73e247d82e6mr3056625b3a.16.1745491800945;
        Thu, 24 Apr 2025 03:50:00 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:f632:6238:46f4:702e])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73e25941bbbsm1120138b3a.65.2025.04.24.03.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:50:00 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v5 2/3] selftests: net: add flag to force zerocopy mode in xdp_helper
Date: Thu, 24 Apr 2025 17:47:15 +0700
Message-ID: <20250424104716.40453-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424104716.40453-1-minhquangbui99@gmail.com>
References: <20250424104716.40453-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds an optional -z flag to xdp_helper. When this flag is
provided, the XDP socket binding is forced to be in zerocopy mode.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 tools/testing/selftests/net/lib/xdp_helper.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_helper.c b/tools/testing/selftests/net/lib/xdp_helper.c
index aeed25914104..f21536ab95ba 100644
--- a/tools/testing/selftests/net/lib/xdp_helper.c
+++ b/tools/testing/selftests/net/lib/xdp_helper.c
@@ -62,6 +62,12 @@ static void ksft_wait(void)
 		close(fd);
 }
 
+static void print_usage(const char *bin)
+{
+	fprintf(stderr, "Usage: %s ifindex queue_id [-z]\n\n"
+		"where:\n\t-z: force zerocopy mode", bin);
+}
+
 /* this is a simple helper program that creates an XDP socket and does the
  * minimum necessary to get bind() to succeed.
  *
@@ -81,8 +87,8 @@ int main(int argc, char **argv)
 	int sock_fd;
 	int queue;
 
-	if (argc != 3) {
-		fprintf(stderr, "Usage: %s ifindex queue_id\n", argv[0]);
+	if (argc != 3 && argc != 4) {
+		print_usage(argv[0]);
 		return 1;
 	}
 
@@ -132,6 +138,15 @@ int main(int argc, char **argv)
 	sxdp.sxdp_queue_id = queue;
 	sxdp.sxdp_flags = 0;
 
+	if (argc > 3) {
+		if (!strcmp(argv[3], "-z")) {
+			sxdp.sxdp_flags = XDP_ZEROCOPY;
+		} else {
+			print_usage(argv[0]);
+			return 1;
+		}
+	}
+
 	if (bind(sock_fd, (struct sockaddr *)&sxdp, sizeof(sxdp)) != 0) {
 		munmap(umem_area, UMEM_SZ);
 		perror("bind failed");
-- 
2.43.0


