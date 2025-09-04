Return-Path: <bpf+bounces-67510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D83B44961
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 00:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1780A1C25DFF
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 22:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ED72E7F21;
	Thu,  4 Sep 2025 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmZnVF1/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633F22E717C;
	Thu,  4 Sep 2025 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024218; cv=none; b=sKxt3Hys3GS0lnLm7GxvDQE3rDXzRUmcJc+Q/9y3QUBCwbufM2dJ9YI4fooy+H8UX7E3YnYBTc2cnTI2oHZuJ4GKo1V5IFYWKDx8ssCMzU+c2pNpC+G/dT3jI/j9gVUW38g81OdCI+4tFs58ctG3htrGijU16dlrznNc7Gy3ndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024218; c=relaxed/simple;
	bh=nnquELMyGJbkTU1GWLEvcWZCtv0bj3S2OYGGleoWMJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIvRcKhgy8lFe0gCQv1Iyxm1M9ba+Otxg1ro8EsxPo9LOaiRS992E/VV3A1h3uIa3XRvNT/Sh82nj0pblwUwNSLurmTDuNeu+fb/+3HMAy3LAnxD+5L1xySxhMk8rJx3rSNhHh8cmLOzmd0TOpup1FWTdJvtMfTf0Y01NGSrexs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmZnVF1/; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e9c50598296so1453353276.1;
        Thu, 04 Sep 2025 15:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757024216; x=1757629016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnquELMyGJbkTU1GWLEvcWZCtv0bj3S2OYGGleoWMJg=;
        b=hmZnVF1/ccc9bGaORDakqTeEjW1X+rIPUgDR7SFJ6srsTL7VJiz/7t5mpghdfxJ6qj
         3Pw+zNA981LCWl0baAM4JoWVletyfl1ADZh6Xi+Rsm9rkzOtb6oCQoIVjgFortF0HbmB
         ez57B5IZZ/SQ6Mm/yXTxl21ZFQbayuOyZzshIulHjwJtuc6X8LQ2pV0v0pZouMbb4H1x
         HZINVi39GvXt0KIuVUK2j5J71BKnwoh3dFlwja65MAy6Nee+QNDXp8/V7rqhx5+z1dRH
         CwiAPtiZyRm6k/uxTIODatUSKeT1BJFz5rP0hcVxEZdUfMVNS7QuVrt9xgUyZO1laEoH
         8fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757024216; x=1757629016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnquELMyGJbkTU1GWLEvcWZCtv0bj3S2OYGGleoWMJg=;
        b=bh2UQR2wvzXKJc4E6uMVhQJkurxIY6ard+FOvliwaCP0aQ/Xq2OrO4d73D9DD4J/1f
         eknQKk9kVEJ1gRpBuIiHZ6aE0Ty+nORsOMYLCM8Epwr6vnO/Nn/0E46OSjCnhrywKT1k
         k3v+6pRjUdaZRCVoW0ODSg/vdADFZ38DTW3VMqc+c39giGXJaEG+mJQ7gCc7qt3YQTU4
         EHdtajwp6tCujOOmeNkjCOPBMck7XFFtuKSnDYIrY5YuAXVPYUrunx6YfFoexji/CYNU
         lC4NcpDHmLBtWCpNd8gD0Jr0YtOS3XiCdr92W7RYqgosIxBKHrfeATQEB44ciQsMEVGf
         iF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWr3dKTSwOTb96g9fzrBBJaHY4w+Ujs18A9ZKKo03nl000/5i5f/cMT3YFaBmksMk43LQNFZWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFqaqNevM8JMSIELaBChM8owXxbSsBPrymW3szh6Q0LC9DdpD1
	vXN+t9iW2ZI3fGjgweFv9sU0RXrR+rK5DF341vIctfxe3Tv0EEUf6XWvSrWGOs6gJ+pVt6kXOM3
	3n5PXy7OIu4HF33ipgh9U/7vrJwDPzek=
X-Gm-Gg: ASbGncucTqaAj4OGIdntj4RVylK8X7fRBkfdXQu9ELB5urib8wJgVDvbstoW7GhesMp
	yEZV2secldPxfui4VUCN/XETfvEDXwwoGdhkALOqPGCFquHntjfbDFPVw48TIj7pRwuHC2BDPdi
	EJR86amBMTZ3B2e3SHu17gSUFh6gLoS+RijF4KozW98KDooyq4oXio0DoCPqdvn3Tz/Q+IeC7D1
	4UtK5c=
X-Google-Smtp-Source: AGHT+IFPe/o5bgxRYvYorrq47EKpuQMGFUgyZsTgNI2v/ceyRZWMyCdN+EanIES/vlKg7BmMWsiU8cnJuYKLTL3qRBw=
X-Received: by 2002:a05:690c:338d:b0:725:68f5:8771 with SMTP id
 00721157ae682-72568f589f5mr11826327b3.37.1757024216080; Thu, 04 Sep 2025
 15:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825193918.3445531-1-ameryhung@gmail.com> <7695218f-2193-47f8-82ac-fc843a3a56b0@nvidia.com>
In-Reply-To: <7695218f-2193-47f8-82ac-fc843a3a56b0@nvidia.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 4 Sep 2025 15:16:45 -0700
X-Gm-Features: Ac12FXzJA_79IqwmpBM2LPRJxEaU6PHAETTWI5occrSW829FwV2_anu6XoKikBY
Message-ID: <CAMB2axMk63AAv13q2QREn--ee-SMCwjhtv_iPN8EsrjN1L5EMw@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 0/7] Add kfunc bpf_xdp_pull_data
To: Nimrod Oren <noren@nvidia.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, kuba@kernel.org, 
	martin.lau@kernel.org, mohsin.bashr@gmail.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, mbloch@nvidia.com, maciej.fijalkowski@intel.com, 
	kernel-team@meta.com, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 6:39=E2=80=AFAM Nimrod Oren <noren@nvidia.com> wrot=
e:
>
> On 25/08/2025 22:39, Amery Hung wrote:
> > This patchset introduces a new kfunc bpf_xdp_pull_data() to allow
> > pulling nonlinear xdp data. This may be useful when a driver places
> > headers in fragments. When an xdp program would like to keep parsing
> > packet headers using direct packet access, it can call
> > bpf_xdp_pull_data() to make the header available in the linear data
> > area. The kfunc can also be used to decapsulate the header in the
> > nonlinear data, as currently there is no easy way to do this.
>
> I'm currently working on a series that converts the xdp_native program
> to use dynptr for accessing header data. If accepted, it should provide
> better performance, since dynptr can access without copying the data.
>
> > This patchset also tries to fix an issue in the mlx5e driver. The drive=
r
> > curretly assumes the packet layout to be unchanged after xdp program
> > runs and may generate packet with corrupted data or trigger kernel warn=
ing
> > if xdp programs calls layout-changing kfunc such as bpf_xdp_adjust_tail=
(),
> > bpf_xdp_adjust_head() or bpf_xdp_pull_data() introduced in this set.
>
> Thanks for working on this!
>
> > Tested with the added bpf selftest using bpf test_run and also on
> > mlx5e with the tools/testing/selftests/drivers/net/xdp.py. mlx5e with
> > striding RQ will produce xdp_buff with empty linear data.
> > xdp.test_xdp_native_pass_mb would fail to parse the header before this
> > patchset.
>
> I got a crash when testing this series with the xdp_dummy program from
> tools/testing/selftests/net/lib/. Need to make sure we're not breaking
> compatibility for programs that keep the linear part empty.

ping.py test ran successfully for me. Is this what you tried but
crashed the kernel?

