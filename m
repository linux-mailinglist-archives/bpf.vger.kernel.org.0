Return-Path: <bpf+bounces-21219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C677849A81
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 13:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4999D282064
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 12:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CB41C6B7;
	Mon,  5 Feb 2024 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSWD+h12"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90C61C6BD;
	Mon,  5 Feb 2024 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136591; cv=none; b=DBABgNv/3mJLaBCKJ8SgMXAK4Q+Wmp26qiCHYrmIv5y+PyKKKAKT4fa57hgJqtZAuGaf7WL5R6GQyeXbQy147vOGHgkVl9L5oyhLTA0OJ3ltsnJKvMRvFlwsk2PjsJR8QsSVXXIymUbfEDUSM8JwBOSWgFOfEAGGRBip+lgSSnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136591; c=relaxed/simple;
	bh=+N61wH1FlvdLRyWlH81aXLfys/5abbkvK6A+n0JcPFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kyn0UBbVqArefpUYpACjglsk3SZ9sXPGDURtjK24G7HGTe2z16reMU1FvmCM3mtERf9JNNRjHJUEaTUr7OID4YkZ94pjWQK9dB/vYy5qAaOCm+vd4ROp09PbfsCHqeBA7CC4CVD2An1jjOY6H4Swq7rlCRQvFlDwca+HGJUaXHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSWD+h12; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fc82b57f3so7522425e9.0;
        Mon, 05 Feb 2024 04:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707136588; x=1707741388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNfht/WVqOsZBwFoIC7E1qjr4wLeLuYf19c+R+i3dho=;
        b=TSWD+h12syMexcUOJFy8ZvR+mAP4m13gw/SBfugwMSexiYol1NXrS+91j7VCe/y/1n
         vdtgkboZ9Qqc5aFUwA2wdm/vO5yba82ShJ5IKePmYrz9cMbCQwyt5O5gjfB7Hpe0ag1+
         NkY5vACnFCsATHc+U9+6ayKQL73Spap9BUDvvEDu2ruGL/kXZCTVBc3Op7XOavIJaLz+
         2bRUGigOgjP9KGjB08RBa/TFJCYAjf31gicLdJvTz/FQNGyOm8fPnb6qo3DW3RqNT27d
         /qRpMmlGV8PE+xPPznqTGqwvXVnjfuLwf8+U8EqvrFdF4dl40/EowQoKjjBsYg1NveJE
         X4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136588; x=1707741388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNfht/WVqOsZBwFoIC7E1qjr4wLeLuYf19c+R+i3dho=;
        b=V6PLJ8g5z3AWwh5fyAmFmw5vPFoczBHeMskkksU/785c40M/KDT0J98KGEfXTQFzQA
         IFcT4gigr1QIgUm4Dp33ti8/ok3/bfAS/M/8Ke/zLaXLwW1+t0/i5WMihjskXP2buyBF
         I0pMMF15CXZbaAfiWIz/wzE3YSJmgOBdd2jDH3f2Ia2Jv0gKr9X7r7Vcs2k4BWylIYfp
         fRlSn1H+9HtpuPRLDzGSd0kbaS/bjW3LR6swot2TMpxgHqs6fFbfLQUB7ZNfGT96KHlK
         e8Sn+5tAvwPKLtW+qNtXzneKdaTNiezIOmzipvzaD/VxWvHCTPKMmT0F7Qb5fZd8LFvC
         Ua1w==
X-Gm-Message-State: AOJu0Ywal2Ev1rGHbUD6Gj/MtEP9WKTJYftKMgr6U6DCTo5esZ1mI2uM
	ksxc2O51gwAcM+ULF1gznJEuf/KNAH3m+IAGDB2FYmn4VUuEWQwf
X-Google-Smtp-Source: AGHT+IEaHLYfWsB20EA6pcEIcfrJH08aAvIC52H+PV15t5bKPJfibB5qNwXV4h+PpJ+QipvCRKYxcg==
X-Received: by 2002:adf:edc6:0:b0:33a:e3dd:490 with SMTP id v6-20020adfedc6000000b0033ae3dd0490mr8924364wro.6.1707136587744;
        Mon, 05 Feb 2024 04:36:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWGPbEBNksSjqHIVuqfd2EDna7a+U0QGEtLRf3QBDVJxSSRL3S/d8BG+b3agA/9qZCWGT9w05UhIxpp08hKngr+f4xEjFkGPu5DBRmjnDm2dbILHwI4m79V+lRhUoFW4PPy9LHiI40OVysyw2SVN9NZx2n2oCRN3vdgGmpybdpltgJN6NHHZs2MJ51HXFHGpYXM8W/sXz337s2WnZK9Z9fylD6sQd24XrIQthgYLRgpNvbpWOJvNcfIZnGkxnAFNr/AMBhdDQ==
Received: from localhost.localdomain (c188-149-162-200.bredband.tele2.se. [188.149.162.200])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d400a000000b0033b17880eacsm7892894wrp.56.2024.02.05.04.36.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 04:36:27 -0800 (PST)
From: Magnus Karlsson <magnus.karlsson@gmail.com>
To: magnus.karlsson@intel.com,
	bjorn@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	yuvale@radware.com
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/2] xsk: support redirect to any socket bound to the same umem
Date: Mon,  5 Feb 2024 13:35:49 +0100
Message-ID: <20240205123553.22180-1-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set adds support for directing a packet to any socket bound
to the same umem. This makes it possible to use the XDP program to
select what socket the packet should be received on. The user can
populate the XSKMAP with various sockets and as long as they share the
same umem, the XDP program can pick any one of them.

The implementation is straight-forward. Instead of testing that the
incoming packet is targeting the same device and queue id as the
socket is bound to, just check that the umem the packet was received
on is the same as the socket we want it to be received on. This
guarantees that the redirect is legal as it is already in the correct
umem.

Patch #1 implements the feature and patch #2 adds documentation.

Thanks: Magnus

Magnus Karlsson (2):
  xsk: support redirect to any socket bound to the same umem
  xsk: document ability to redirect to any socket bound to the same umem

 Documentation/networking/af_xdp.rst | 33 +++++++++++++++++------------
 net/xdp/xsk.c                       |  5 ++++-
 2 files changed, 23 insertions(+), 15 deletions(-)


base-commit: 2a79690eae953daaac232f93e6c5ac47ac539f2d
--
2.42.0

