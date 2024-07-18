Return-Path: <bpf+bounces-34978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DB99345E2
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 03:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850DF1C21D88
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 01:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9AA15C9;
	Thu, 18 Jul 2024 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="qV31pRkg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921410F2
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 01:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721267068; cv=none; b=BO2Wuz7Ftpd679fMiNsNPj9KATn8j3CX8rN+4dxsqkPUUTGBj78YJrvLhZr954v2kIQsT8s3xX4n8BzYZ4Cg5SmGhM3fzjCockgYUv5J5Ze59GO5wAcL9X2rfVq5FUaNMkTSnuM3OnOCbUY1ab2K08QvyB6cVIfwKLiAXnGiK3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721267068; c=relaxed/simple;
	bh=SVgjKYZZWJ/teW/0ufGlYdulCGjBF+PLYX30lg60i3g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jML4InVgq/WyKa5O6fFPUM8kryvzJTFzwfa4AH52Le4Jdt5bW4hRJabto+C79iR0cIky4LcsVdQzdEJEpeBNVeejKYzRApwkEm56KrZIETgl8Zs78Ax7SvhgQRQGG0r+9KFDeuDmd/xSF3QUhyWG1GHFGjDkzyvZYln06GGLIiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=qV31pRkg; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so4844081fa.2
        for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 18:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1721267065; x=1721871865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I4ILsvQA2kLVbo7mUFNHlysjX/diYVr8b1qOwQ1lNOI=;
        b=qV31pRkg87ZGgw3A6yNg/nPjV4kqxExrLxPd1B8oSbfwEPsoHzoCnMkzUYaGoRF/Kc
         1rg02D/jDM817kVgqatwkSIeSHd/Y1VrFN6kwsenFP68hRM/iuxSZ26ATuz1IpBBpCsI
         iOiT1MwVWRHA5e0cQuY6DgJd5dSa3m/dPjf6UJn7FUSbUC9grRyAbpMvVGDY/z6EFuKu
         Q+R+jQfAOaeBj9PFkM5nAH4d2CWnmNNyKPr5lw5M7CSLWgIweNf3/Qhsi0gbX86wGx2o
         gWGHG3ru+fvVFLiFu9EiBcOfBvtTj9bPaQv7r6+7kDjTtIa0ZfhM5ZWrjouI/CNkCxAU
         YlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721267065; x=1721871865;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4ILsvQA2kLVbo7mUFNHlysjX/diYVr8b1qOwQ1lNOI=;
        b=I6hith+MAzfyjhTgXK1isH143kfjjKgBjX8cBKdvK79zfguxvrQ4cMLJN7IukTQh3O
         pgRVGDIe7R0/8k2gtFI2blI+ShXREEvCM5DG819VWQ1O79vd6GR+H8t8fyoI5lH/jDQj
         /b6UHFNb/XKerKCQD7h3J0bkkmv5DpMJCIhCn+876fVZYkDiZDwbtCLBviCG743wq386
         PeQiUo3l5lHM1Gaf37Q89DyQgtRcUn1oLR9OrhtjxlTsixIfzqWJ7tPwoeo8SW0uBmuM
         Y5Y0O+yySXyAlzLkWahX5Za4x0FA4XTPlml/H/7W0XktG4ClhaVWRQjguB3uaPMJkTJW
         xubg==
X-Gm-Message-State: AOJu0YwD1Yw1+QYRa8HBDjWzR8Y5MGZ//cSVXg46Pm/v6ZWne/gLcIiN
	Z4Tvbve8UYLBzUK5HdPd70/gdTPw8JH7bOJRi8Dgc6K4ifuyps7AL6RLqL0L+oPpu+BmoA8UvIv
	7IbY/IGaPPhEM8CYk3fixZHgyoQ2iRzwJXT3jvQ==
X-Google-Smtp-Source: AGHT+IFSUULNlziSzCdGv18KWWbsrgGw1j+Twq1u6U02s/VMu5zD1o1AxdYqBlDxI8Yl5Rz58fDJBNB/Wi8ytBjI0rI=
X-Received: by 2002:a2e:84d0:0:b0:2ec:3e02:972a with SMTP id
 38308e7fff4ca-2ef05c6faefmr5858301fa.11.1721267064673; Wed, 17 Jul 2024
 18:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Wed, 17 Jul 2024 18:44:13 -0700
Message-ID: <CAPPBnEYO4R+m+SpVc2gNj_x31R6fo1uJvj2bK2YS1P09GWT6kQ@mail.gmail.com>
Subject: [PATCH bpf-next] bpf/bpf_lru_list: make bpf_percpu_lru_pop_free safe
 in NMI
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Hsin-Wei Hung <hsinweih@uci.edu>, 
	Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"

bpf_percpu_lru_pop_free uses raw_spin_lock_irqsave. This function is
used by htab_percpu_lru_map_update_elem() which can be called from an
NMI. A deadlock can happen if a bpf program holding the lock is
interrupted by the same program in NMI. Use raw_spin_trylock_irqsave if
in NMI.

Fixes: 961578b63474 (bpf: Add percpu LRU list)
Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_lru_list.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index 3dabdd137d10..c4a9e861369b 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -412,7 +412,12 @@ static struct bpf_lru_node
*bpf_percpu_lru_pop_free(struct bpf_lru *lru,

        l = per_cpu_ptr(lru->percpu_lru, cpu);

-       raw_spin_lock_irqsave(&l->lock, flags);
+       if (in_nmi()) {
+               if (!raw_spin_trylock_irqsave(&l->lock, flags))
+                       return NULL;
+       } else {
+               raw_spin_lock_irqsave(&l->lock, flags);
+       }

        __bpf_lru_list_rotate(lru, l);

