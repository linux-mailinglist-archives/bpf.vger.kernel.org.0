Return-Path: <bpf+bounces-39615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BF89755C7
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 16:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39D51F2189F
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 14:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8A41A7ADE;
	Wed, 11 Sep 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfJ/crhN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B121A3054;
	Wed, 11 Sep 2024 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065575; cv=none; b=aK0AihAgs0H6tBfRon4RGwx95K460KPPaT44LXIRJmlBe/KZeQK/reHL+4inUnRt6d9HUP2KLm4jD41dV9entJDtSti/M6+EFv+THvDPryNBv/SpbqI1ZRclTuBJu/g4pDrXMY1zdHDg88LQ2LXT7neJTj+Ts/WL5nAnBQmBRbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065575; c=relaxed/simple;
	bh=uHPvQ/qOTwwhiS35MIvUjkK5D5Xn64AsuaL5f0tYq1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rn0ujF6gkJMHa+/JjyOhWj2iPZILZ8rltqGopkvCp/fORI20FTZYPtBI28Sd2q5Fb+8/R2u9UPs0PrI+ES6RQayDx4Gj1J4KYxvQtZNQaChcwVpVSm4aN5YiTO6Q36CHtbsQghZ5OxRBkWepIAdDYQlLDrC5h9LsktL2qJk+HVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfJ/crhN; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-656d8b346d2so4403551a12.2;
        Wed, 11 Sep 2024 07:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726065573; x=1726670373; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uHPvQ/qOTwwhiS35MIvUjkK5D5Xn64AsuaL5f0tYq1g=;
        b=XfJ/crhN+QW6Yruog5ppoptdtgavczn9Q8KCwRksu3u60krOPL+0yW6O6t5Z2YY49B
         iBrVQNZo4PODHx9bqmvaULWvXUwKh4PaoPLdpgk6sA510pED0erU50K4ujVTuKv5cdGm
         cRwVPqEC23KtnS7hzVqoAg9Y6GMt2hhty3yAXgJUYPzEcZNm2EGNqna2BOqg4Vdw/UKG
         FbYncv92SQ+ltQXaaYB3QGkQnJJaKqNFUvvoyJTqSkvD6YqY5W3+prTJ2d0xd8qD/T+h
         Wthfq53C1+ouMMz8jPdkVZnchpyBCYdM92J4cGsN2J0pUPZ3rLeJf7Si0kJF5j6iHS1a
         nR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726065573; x=1726670373;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHPvQ/qOTwwhiS35MIvUjkK5D5Xn64AsuaL5f0tYq1g=;
        b=ncTP4mfTFPenh9/EjLt8d9r74H/Vzz2OwWLyJB6HhWlFqjp3niUQ+Zbcfwm+yerHHQ
         dVqKybGkKBjDM2kUhY7THrSsVvZZqwR9Jfe3OSk75ODgnFXJOl8kiC59K0Yk6qfet4LR
         nhyJjd4IeAc10CCcq9B7jOmKLfEkMpeRWOiYs1844LzD+8Y7FbEy0MwRGr+/uHjTjB4c
         ANbLVTHvnk4EOSOT5AuG7rNlzFVQsrgxm+LEHqqj7J4JkJN54TidU36e2cjnSnyKMI8q
         /XDckIUPMKIu9Mzdn0azGfAId473Fq1LsNfp2+DL+zx1gTY70wd3W4CR8lBHuKI/Gx/G
         bFBg==
X-Forwarded-Encrypted: i=1; AJvYcCUvvjmqwKgFFD31dcmCqNGrgHsSpvrjyDyFPjmhwW11tVfmMzCCgnYLjheNW5LXfOxV9qg3D72SOA==@vger.kernel.org, AJvYcCUxLJPRagVEjylmq7qdW4gVHmbYl7QJcGfXE3xNrnD8o14qXl9/Nr+Cdlsi75E8iFATKSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3G3rzVo+dHDB89FBuC8cIFzNfOo81XwZP0kgr27r7Xw4NquG2
	i9skkZeYyLfnkrUDwx4GAtlYgGyCslTeLY8MW6rLJnx4b/81u1E=
X-Google-Smtp-Source: AGHT+IEDt8imX/5nYS2hKxrQc8EzQ1QISpcZOS7Fqr/l/5GBtqk7ozE0oZ/t7/VHXoLrbyQgWJ+LPg==
X-Received: by 2002:a05:6a20:e605:b0:1cf:489a:52c1 with SMTP id adf61e73a8af0-1cf5e097936mr6090482637.18.1726065573490;
        Wed, 11 Sep 2024 07:39:33 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af25646sm481145ad.58.2024.09.11.07.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:39:32 -0700 (PDT)
Date: Wed, 11 Sep 2024 07:39:32 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: tianmuyang <tianmuyang@huawei.com>
Cc: "alan.maguire@oracle.com" <alan.maguire@oracle.com>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"arnaldo.melo@gmail.com" <arnaldo.melo@gmail.com>,
	"ast@kernel.org" <ast@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"Yanan (Euler)" <yanan@huawei.com>,
	"Wuchangye (EulerOS)" <wuchangye@huawei.com>,
	Xiesongyang <xiesongyang@huawei.com>,
	"kongweibin (A)" <kongweibin2@huawei.com>,
	"zhangmingyi (C)" <zhangmingyi5@huawei.com>,
	"liwei (H)" <liwei883@huawei.com>
Subject: Re: Adding new fields to xsk_tx_metadata
Message-ID: <ZuGrpG6N_OINizBm@mini-arch>
References: <7835e88690ad424cbf644bf3cb0610b5@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7835e88690ad424cbf644bf3cb0610b5@huawei.com>

On 09/11, tianmuyang wrote:
> Hi all:
> We want to add some fields to xsk_tx_metadata such as gso_type & gso_size, in order to transfer control fields when handling jumbo frames passing between VMs. My questions are:
> 1. Has the community discussed about adding new fields to xsk_tx_metadata？

There has been some discussion of exploring AF_XDP segmentation offloads in
https://lore.kernel.org/bpf/3190e03c-ea5d-69fb-48e5-6cc45b1ed521@redhat.com/

> 2. Is it appropriate to add such fields(like gso_type) to xsk_tx_metadata？Since current fields seem to be generally hardware-related.

GSO is also HW-related. GSO does all the plumbing to allow the stack use
HW segmentation. So, in the end, if we end up exposing it to AF_XDP,
there has to be some HW (or driver) that implements the support.

