Return-Path: <bpf+bounces-60951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D020AADF0C7
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 17:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47EA47A1884
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832D42EE97E;
	Wed, 18 Jun 2025 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clMQPrqe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA7216A95B
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259440; cv=none; b=PaZwVPVoIgIsEfsulFM4DshZu5hk2irsNak8n2LaBUj2gE2C91EX+ciBCAj3vNyr0uqS2duPN13PkWlMyNLksImb/hJYOJVShVyQA6HKoRKdt5pWTK8roC7vclgxp1+NGg3/uUPfQirSrT8diWaFJdYTtxBe1vXjasmFJoGYxrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259440; c=relaxed/simple;
	bh=1L8SSDc03Msw3Ti/A8GPma4nS+bZbONzRnzxr66b1V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwwADF5uiQjzgw1mrDoqswhmB4z4Q7I19QP2FQt/UCdpuUPDpSuHKxzONVYIWez7GK72UuYottQb78vPsfov1VIFuqPfFIL613SM0AWhvfg9IhovFby0n/y7Fy44PVZ4VK9Q7jgBbcgPNdAeAbYrJvO08XgZWEp3VaYbt2pgJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clMQPrqe; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-453066fad06so53167935e9.2
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750259427; x=1750864227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0Jw2A3wrLE8p/thMzFm+ApEh6PtJflGxW5xlxNP30I=;
        b=clMQPrqe+FMjTa6HCY79ktTY/uKMi35WmgaIBqKFgUonjT58tiqLJ8n+K1cbXfOovu
         yAtXcpoEGJ4Sl0xU75kzFDwfHoicZEfBKymfK9yQS5tMMQEAhNmfNp9QAoNykzhg03Vl
         M8eAvJHHEZkwSmVrh1kU18flSuoDIInLsysZn3CELGp1+JVcXK8/MGC3LRVwK7Ya8Onf
         x/qyMb4QKfs23h1MmpXf8pzsks0YOpub4D930Y/lRrwBR+jgdoo04eemtWZav9yKoO3j
         Pn1uU4TZbWTq3uosG/IRORXCWci+Mur7umgoaBdS0Kzf9j5gVBJKtO3+o1Lm/+i7WoFc
         L+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750259427; x=1750864227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0Jw2A3wrLE8p/thMzFm+ApEh6PtJflGxW5xlxNP30I=;
        b=xLL4zfUTrMJoNDynn9s9zpAhY2jjPeC/R3VDmZ03Tp0b5433cIMH+O8z39owYbNDGF
         8wzk0qtBmCZi1/4qLKwp/7Ch5fZZj1/WOU2DTqaeyjglNteRaRi/6lqw3+85ahIqoO+U
         AQ7Y4b+7gxTuzkAfXtmr/GFnsAwl3n4yIrShpEo/gakF+xcjPCmHpE7tUGDNm/g9f9Rh
         Gu2s3o+4EccWObUA+PqHrHPNeQsBxGtiMyTI1Br3Mf107Y70qDuMNN2nSf/CFpCUQehm
         U65Jrza1REFaHFIVS6EfNOf9HQWzfPoELDxg7guPsHE4w0omhGLyqp9ux8oavHCkKjZz
         pjHQ==
X-Gm-Message-State: AOJu0YwPbR5mEiW8CNTZ97pH4lYlnza5pQYlizK+cdqGQAPcjtgFikq3
	LuH90oRB6vXvao/MDWkes7mWjGXf+6OxjpKrxb/f4u0m3R7Z8r6gOv31
X-Gm-Gg: ASbGncvsxjQQHpShxptuXhvlE1QFQkMHIMbEBX7zcCYEpvfgW9ysHp8Uxj5ZwyAbdgJ
	4cPt7G0fZm0c7JfwV0Z+Vgq8UMErxWMxHy5i9S9jsZaz78b8uGdcqlKyJXDnverGpzfOFfJpXYB
	gDxUIR3M0ox5dTib78Dj+TcBDa9RBaz0/vhJUVefh/1lIqvYF9UKmLteCn5JTu9s52nAMSUchgr
	H6zx/5QvBNz5o0GvB+g6eW4VcGBlYkujWPhGW/Uo+IefSyTyB93aEsi51K3DRuSJoER7ppHwOa1
	thyvFVy3dJ4wPJD2OqZIbFBUY5GIGTXxlFfVQpI7f4/BCzN7RF4uAcIKDrpeIeMCqBBehRJTyQ=
	=
X-Google-Smtp-Source: AGHT+IFNDf/fetoJrgOYLjSi09U/3FGOFsywMjythgbm5Rzh1cDvGJ7TvCZMqdquAGADw9ggPhTEZA==
X-Received: by 2002:a05:600c:3541:b0:442:f4a3:b5f2 with SMTP id 5b1f17b1804b1-4533ca42734mr167214485e9.6.1750259427517;
        Wed, 18 Jun 2025 08:10:27 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ead2449sm3785e9.30.2025.06.18.08.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 08:10:27 -0700 (PDT)
Date: Wed, 18 Jun 2025 15:16:11 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [RFC bpf-next 3/9] selftests/bpf: add selftests for new insn_set
 map
Message-ID: <aFLYO5xlJvDsxiGt@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-4-a.s.protopopov@gmail.com>
 <bf18e12a52cf013b96f8aaa88b062e6bb48ba36c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf18e12a52cf013b96f8aaa88b062e6bb48ba36c.camel@gmail.com>

On 25/06/18 04:04AM, Eduard Zingerman wrote:
> On Sun, 2025-06-15 at 08:59 +0000, Anton Protopopov wrote:
> > Tests are split in two parts.
> > 
> > The `bpf_insn_set_ops` test checks that the map is managed properly:
> > 
> >   * Incorrect instruction indexes are rejected
> >   * Non-sorted and non-unique indexes are rejected
> >   * Unfrozen maps are not accepted
> >   * Two programs can't use the same map
> >   * BPF progs can't operate the map
> > 
> > The `bpf_insn_set_reloc` part validates, as best as it can do it from user
> > space, that instructions are relocated properly:
> > 
> >   * no relocations => map is the same
> >   * expected relocations when instructions are added
> >   * expected relocations when instructions are deleted
> >   * expected relocations when multiple functions are present
> > 
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> 
> Nit: term "relocation" is ambiguous, in BPF context first thing that
>      comes to mind are ELF relocations that allow CO-RE to work.

Thanks, agree. I will try to find other words for the desriptions

> [...]
> 
> 


