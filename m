Return-Path: <bpf+bounces-69147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65809B8DD56
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 17:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BF2164DBE
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61561BC4E;
	Sun, 21 Sep 2025 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amdpVqlV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2212341AA
	for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758468691; cv=none; b=GQXw3odLHpDmEHEYD7bW5KygYoeMaMBFq2q7EPdJ6Z1eLspNQgQkTo2KWQ7bx3cx0L48QTRjpwPQqMOV5r8vpPf1H+cS0SPieAC5HCOMn/1N+kXWSSNfpmfdyc4gDW+yfkXOIPaam+yLvtnU4gV8T5VPeIAditCv6fu2o9IuEiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758468691; c=relaxed/simple;
	bh=7NCxv/9RiVkI4je3zWn63xsUqo8Q/S8SLXjy/jyDnPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZI+WhMwM6Q0e1vn2pct6e6M2n/yzQes9hJPpcnM5WAo6irNTzPSvPyqyqyWGA0rR0sFQJmexj4WGCdKyO9H5VDKSylNy8fpXqEncfCa3KdB7jV7nWGu7bt4lS30516BAZ2vJ1EyGxmEMcDjlbtbPEOPGMUYAVpau7q8A5aGHbsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amdpVqlV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-468973c184bso11415665e9.3
        for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 08:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758468688; x=1759073488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NCxv/9RiVkI4je3zWn63xsUqo8Q/S8SLXjy/jyDnPA=;
        b=amdpVqlVMxMWDehDaLSFAPFz03X2Px3BviI+5Xt5BDZNxO3OyraEeq134R+0WJqM1L
         pWFOUN9qlxB76Z1sMM0ShbERAcRS12tAdX0fAahDObsUBi2G20savy87ixeoUntSPCOx
         VriRkzensmK0cQH4s7AMV0eTZBQHkeTRl0B88Z4h+CqbtVGejyOCFS01yzxdfWpyW0pm
         RxT94cKRvpayQKDowW8e3+TUoMgRKz15QCA2LAQjSkK760cv+lmOOo5YuTQty1V9k+jh
         n5spTOVqxi80dOvU2ZIDP+UhOGBEpMXPzjGQhYC+ZB8knpkOnrXv5k6uBQ8Td0vQaOJY
         Gxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758468688; x=1759073488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NCxv/9RiVkI4je3zWn63xsUqo8Q/S8SLXjy/jyDnPA=;
        b=hC+YIsDEYiYsZykWIcXJisE03kbQfnnzWb4wuC0BA1GJD61esyricDJXc4HZ7W6/vQ
         sD5XxCYTTxLyZ+SJNWr+Zj6Mb4sYucqxARirzNIaBi4K6QooqhWdfgLhxb3Yu+vJAQeE
         HTCt1kJQk7jJ1xoXsO+8nbZCCdEB3qd80PjMtSu0rD8UoSCVIheCoMPgvI10EW60mLHV
         XbhfUmG/EZ3hJ0Wk6hdraGeiF2pEERUveFesPMlP7M2mS01GmtvjiqrFiakiTFw3BokI
         OxSoJg6fd93rckhn6dhNmVMF4tp2PHUSU0AXMU+p6TcGD9ohBFhdBiwhW0kx/wZ7OCxc
         9T7w==
X-Gm-Message-State: AOJu0Yxu8MOoxRpSQgtQOv+qwXwqv8av1rMn9Rlo6I0mdVLnvBQQVHsM
	Iuy4PnarvoTPhdtbkC61WlbYaLEFJOlWQBSrhL8LHrkzksph3z2gV7++021xew4TnLwtyRM3yAB
	IS4P7aYEWYbqwREXUclNvYMYF9Hh99Mc=
X-Gm-Gg: ASbGncveNXDE4Ym6yim46m+stlHv6xmUWXMQ8TkGX3UQ+gLaxSvWmYdng5u+TfMPjOW
	hMUTfHiyNB3sO1ziu5j/CGA+V0zvN+MJdAA0McdzaSHDYBqz99Wdn05oBqCkOpKjxd9vmZ4PnJa
	sJGqU4lS21qEb3B5VZSpde9efP8Vhcg9JST5aoj6Co9xJeEGOYN4EkUHSFtde/SCvDUheq2Mr/p
	icvwfB48h5CZO8urt2rjjzPq89qaZR7Uxpr
X-Google-Smtp-Source: AGHT+IFLDfCcS1KEU0zLGmnheBCJTR0xfgWuncwrkWZKOCe0PLEWQcbu/yMyLpB4WNBEi2oUGL+MFWe/fqSt5J8fK0M=
X-Received: by 2002:a05:600c:8b21:b0:45d:d56c:4ab5 with SMTP id
 5b1f17b1804b1-467e63be56fmr99171845e9.5.1758468687821; Sun, 21 Sep 2025
 08:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921133133.82062-1-kpsingh@kernel.org>
In-Reply-To: <20250921133133.82062-1-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 21 Sep 2025 08:31:16 -0700
X-Gm-Features: AS18NWCiKg8ZihT9tribG8q0rpDMrWLrdCn2ggSw-LMPm2iRIOMNJ9fehq0ibXU
Message-ID: <CAADnVQJdue2iX1fq+cBM8xkDHa8N3EXBZ-avFQ3VuasQ153fXg@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] Signed BPF programs
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 6:31=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote=
:
>
> # v4 -> v5
>
> * bpftool comments
> * Cleanup noise in calc_tag diff.

The patches 1-7 were already applied.
Please rebase and repost 8-12.
Also use [PATCH bpf-next v6] in the subject,
otherwise CI runs only half of the tests.

pw-bot: cr

