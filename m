Return-Path: <bpf+bounces-79446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 078CBD3A772
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 12:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70BBF308E28A
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 11:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C115F318B9A;
	Mon, 19 Jan 2026 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UxeO3Jbq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173E3318BB6
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823558; cv=none; b=IepH0kxKAYWSd7Bf6gfgtRBa/TvN12DL+IXr0Zj740kv3K/LmW3ydljO/F+KFYOKLi+BrisrvdZ3IplZCRGR5iFc7n33smYOzKYjQg+nRF9gcxwawETdSIcLSFvYjqNYn59nRjTf8ai1pjmpOic694OWQEpkrOpuAc12n0nJuZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823558; c=relaxed/simple;
	bh=uSEkHsH1REtKl3xcr1eJo/cD8PSr1EaGnbXhvaEtR94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PSzzMZv6ZLLiK6vUCwOBKE5AGU6tYPMt9c0N62Vq1pCZWbAea6hPNLGrPyZJ2kvYScobUSifA27gfBGHDQbd0fiGLiM4mm6ZyPUbDl5TD3EpkvVVaWj1JjpvaoM5WNK44EW32U/cXkF6pfs0N4C3xsprjpfBDvU6VdNLFa+JUcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UxeO3Jbq; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-81e86d7ff8eso318603b3a.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 03:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768823555; x=1769428355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dc2NcPIsYn4GHcEHnwWFmYEwoZXJ29FY+pyN3/3N0k8=;
        b=PGgBP1bh8HR2J1faJ/tIaVQeVTUzbNEJ9RVHSL8udVCggNJXI0rPSWdYucykBEkcS9
         mywYx6UccOcIXFwifLrQr0348NzJVhNOzdJRtGrYOn8XRR72QQ7yR+CLCi+EtUzstQ0g
         t0429QUtgV+ec9YuEMTRXZr4yNJgMrgjkyky+GLJ90GYaWr3hm0j9a7HPBP6mVCrTRLn
         zdFAIq0T5vE1mnORKGV+GDNLAtEOhiNn+di2aOOSMWBdW20CgBBe/W09GnDam1E9wPwt
         F+TbIe++CvNQOMSzuvvtMwzZ8XRsbg+XbjVJ1fB0iuJLdhofPD3y64bxCT1iBM9J77ov
         jYHA==
X-Forwarded-Encrypted: i=1; AJvYcCWVA9R8cjwNPp5X/EUvAybeA5XRqVq4c60WLYTbhQagM7BPHG1WRBppYlBpL7iY90RdoAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZv67xDRYylgvwtLWzlP2a8PADqNGRWPCAVjG/kL/984v0fDNU
	9qME+HBcgJhFIULDL2cQP6vODTg46mZWfHFKeIY1lOSOoIOGTXTGFAB+doMI3bHREsPsigpVMLb
	dG8DXO5b/I/B7FPGmG40PSoWK3PrC4dgf8m1KixRtEYHLlmnGCihFpjRaquHdlY9C0nyKt2o3E2
	wlAp2+VPtsOlG+SEqVwGXPSLxtb/TAUGeavq07FcIkWuUOy63mxGhAwgu/LKT0T/O2iu/jbBW6B
	/SxyxuQvJapDjQh2KpD0v1z4sE=
X-Gm-Gg: AZuq6aKw+n6YBikSyEhq+PN4tES7tiVPSEa1IvrTFVzy7hd+B48r4Wn0gusM4X4/Cqo
	0GtPoN0OWIG7yszQg/bfTbaSWmJ86gwCVYDzPxHWoBODRL574J6vy4gdof2H2dCVxFp+UjteyrT
	T4P7Xh96GTgtzFza+CIVX7lt7WW6sQNW8eXfAwxS4OOCm8vX2cVj1UlqCrxuZ+w1OBspNRQkD0q
	8t6kkJTLTgtcJOlBZC86NSsCvP8Mf4vZGwHhL60+3/1nmQH5XKdsClxPi2Y2NgMV7AsoRSKzlx3
	+KQANj7fvgMVIBQ4cqWOoVduANMSrPZ36JWBi+O9ffu73tUrXqZBI8W9wng4vUwwyFWftZjwbMR
	bEUApkZ+oj1B8poKZBX6jkj6b7XN1rkjLW33WMgoyfh/fYVOSeLdpTvFLyW8PL9Ui9jytPrKs1O
	8eCoB5VYC9AKCXakHFYM+R784xTHei3IisYJNRKBIkVKQY3RYWzFjA7W+0ZeGNPA==
X-Received: by 2002:a17:902:c409:b0:29f:f14:18a0 with SMTP id d9443c01a7336-2a7175cd02dmr79409295ad.4.1768823555359;
        Mon, 19 Jan 2026 03:52:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7190a2bcfsm15302075ad.1.2026.01.19.03.52.34
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 03:52:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c5265d479dso153296985a.2
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 03:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768823554; x=1769428354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc2NcPIsYn4GHcEHnwWFmYEwoZXJ29FY+pyN3/3N0k8=;
        b=UxeO3JbqnbXagaa7QFNEcZf0J3D1OxQh+2fttI5wqB4e5O1Z+VhtirxwdO6BOHHDSS
         4dy36JY+NXKgQ8vLaZirHMzge6FfSOUIGoStnbud/vY0o4eQveDCtwGlCOB6BjhUI6CT
         HnuvTQ9o7BPZfgAm6TCJSnHZ5vCb5Mi0FSRao=
X-Forwarded-Encrypted: i=1; AJvYcCVFm521Osnisp3RVY0rVQezMVvFFmjCSI8eCruMP1hoUFiiVoOEvdk3Q9K7z31Ym/fdqJM=@vger.kernel.org
X-Received: by 2002:a05:620a:178a:b0:8b2:1f8d:f11d with SMTP id af79cd13be357-8c6a6703cdcmr1146997085a.2.1768823554176;
        Mon, 19 Jan 2026 03:52:34 -0800 (PST)
X-Received: by 2002:a05:620a:178a:b0:8b2:1f8d:f11d with SMTP id af79cd13be357-8c6a6703cdcmr1146994885a.2.1768823553648;
        Mon, 19 Jan 2026 03:52:33 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71bf2b0sm772878885a.12.2026.01.19.03.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:52:32 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.15-v6.1 0/2] Backport fixes for CVE-2025-40149
Date: Mon, 19 Jan 2026 11:49:08 +0000
Message-ID: <20260119114910.1414976-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Following commit is a pre-requisite for the commit c65f27b9c
- 1dbf1d590 (net: Add locking to protect skb->dev access in ip_output)

Kuniyuki Iwashima (1):
  tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().

Sharath Chandra Vurukala (1):
  net: Add locking to protect skb->dev access in ip_output

 include/net/dst.h    | 12 ++++++++++++
 net/ipv4/ip_output.c | 16 +++++++++++-----
 net/tls/tls_device.c | 17 ++++++++++-------
 3 files changed, 33 insertions(+), 12 deletions(-)

-- 
2.43.7


