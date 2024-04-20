Return-Path: <bpf+bounces-27302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D96398ABB13
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 12:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680E8B219FC
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 10:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EC723778;
	Sat, 20 Apr 2024 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/+V/7uF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE8314AAD;
	Sat, 20 Apr 2024 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713610092; cv=none; b=d+E04RYOhwWjTF82mjs/BMCjNFdkxYFv5jgEFSp5oIxnqNqJLyMvuohujBfcFmlCc1Ix/HBpy0LFyj1qW+HmNO+oba4W+gME4DqQUijfv6lD//3EvpacNMhvfJlMKr1zj0GsBnrnSHmJbyvxKrdi524a2pelPOzr3h9kFnz8MeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713610092; c=relaxed/simple;
	bh=jNg+7q5hQGaAyxrDmn41mxy7nujMQxN0TmPbND5IUEo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=unqQUgCGwYbuwL22q+5l04eLAzuRKk27mKDGZBOSZ7lf0BdcMWr7pMo80mD7d8vkgPtMMXKW8YWC1MNk4d5sFQXraqiofoeUUkQoHIimm80+0q9RfYCV6Utdso9tILTH8wPyu+gWVX8MA9eL35CCJp4v9AZtehjJZxtuVDqajgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/+V/7uF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso2727708b3a.0;
        Sat, 20 Apr 2024 03:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713610091; x=1714214891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hcsay8D4TMgcjGkhbnAL4YVYKVWmPH6dx7pchfzwdoE=;
        b=F/+V/7uFZQtQtLHswDkid1a7xmapD0nQLyvmMyayVPLWr6bAqlhAkbsb3nZi0jM9qz
         yWdiQsFykZ+p5F0AJdK+FoI5Br1tNj35ZFToWFZLc6OxqrIGE2nzRW22s0wZiAYsvVDz
         xTtq14mMvi/SXzKr3RsxPDLkkaAxSvzFVjkKJdSPvwR9AlRhnzQ7iKfu4SoX0+aC405R
         QKgbIT+IcqOB1uBTCOr+6AEd9plL1gk3TyAXAt9rhHB85HCfUiKOESWNLbmcEOIIQJbq
         GiT7Nn+1sno0zwOrLSMXBIYXxyp8Hq6g/ABj/iIzRVACMG3r1gEMC1YRviWfUXj31vJD
         A1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713610091; x=1714214891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hcsay8D4TMgcjGkhbnAL4YVYKVWmPH6dx7pchfzwdoE=;
        b=RZkCE66H63NAftpXEMrF/V5Dln0le9B4yG/f9ZUlA7Cm5doDVnFet0yJHr6rr4m9pl
         d1xA8+J+tPvzsvt9Nzc3cxxS1XYoPtnk17mit2dNF3hbSbr2QO3y+u7Sjp2OVNV79PNv
         GUrMjEurPHTOEhCGFcZbtnLqDtJ+ezhgqmprLYFagk19VF3bO0pdf5+Ov9Kd27vga1/H
         Gz9T+xos3kAOHI5YOu4dQj0BFUIP3CAlwgdvzngrv1jk6fdIo44t3S14aBGEvwNJn+2L
         vGcsEV6wUfCiNuyDS5Fz2/QgDBNi0T/MixvwMxKJTyI+sFklON9p1ebTu7fxqQPZZ4pf
         HzaA==
X-Forwarded-Encrypted: i=1; AJvYcCWgeKCmOGq0ef5lSMTZJemDmznTjLJ3DSjOinsEaWGDB3e2nSchMF99Mmgs+kEctrYaji3/hOySmk8hXFnz/tg+QKiRZI5d1mNBJjUd4yaTqpSFh4caHf2vkduYkeH2YZKYFWFX45D/GKehTMrFsqu19nngIb/2xi3RYSkzup0jOoQpREu/4/r9qNbJ/s5s//dHLv1d
X-Gm-Message-State: AOJu0Yw7tDziXzPgtHEiN5SmmKYvgw1gdj5eVzcQe8phOeN2bfOGZSgC
	kBGQBuBbRz8fNJX7BRH7xm42j+omeLY3vTO6YnrcHdadMQIAMAZ+
X-Google-Smtp-Source: AGHT+IEau1qzK4+P1iuKa2n0Drjr08hToCxSYpQcyvbBeCyNvLKaTcFudg7IQNvigY9ktbtxj118Qw==
X-Received: by 2002:aa7:8888:0:b0:6ed:6056:c7c8 with SMTP id z8-20020aa78888000000b006ed6056c7c8mr6844039pfe.16.1713610090814;
        Sat, 20 Apr 2024 03:48:10 -0700 (PDT)
Received: from cobalts-mbp.tail68382.ts.net ([211.15.241.33])
        by smtp.gmail.com with ESMTPSA id r30-20020a638f5e000000b005f7f51967e9sm2921496pgn.27.2024.04.20.03.48.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 20 Apr 2024 03:48:10 -0700 (PDT)
From: Lex Siegel <usiegl00@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] xprtsock: Fix a loop in xs_tcp_setup_socket()
Date: Sat, 20 Apr 2024 19:48:01 +0900
Message-Id: <20240420104801.94701-1-usiegl00@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

When using a bpf on kernel_connect(), the call can return -EPERM.
This causes xs_tcp_setup_socket() to loop forever, filling up the
syslog and causing the kernel to freeze up.

Signed-off-by: Lex Siegel <usiegl00@gmail.com>
---
 net/sunrpc/xprtsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index bb9b747d58a1..47b254806a08 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2446,6 +2446,8 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 		/* Happens, for instance, if the user specified a link
 		 * local IPv6 address without a scope-id.
 		 */
+	case -EPERM:
+		/* Happens, for instance, if a bpf is preventing the connect */
 	case -ECONNREFUSED:
 	case -ECONNRESET:
 	case -ENETDOWN:
-- 
2.39.3


