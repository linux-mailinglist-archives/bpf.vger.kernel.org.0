Return-Path: <bpf+bounces-69272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C43B937BE
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 00:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A154445B6
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 22:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFCD27F018;
	Mon, 22 Sep 2025 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXk+Kjyz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C802B9A7
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758580266; cv=none; b=bdi0Z1nU0q2z/CkP2wIQlGyZNGKRcEARyPWvkLVEG3coMxvQR4irUcTDa0PFgU+HuFIu+ml9M5tuQt+Shz3bhFpPGUUgFllK6KqaHImTJPVrVjz3+Pv7GQRVhFHunJrQLk9Kks8+2aQL1dJArincy0T6JFRUrSY1uz9lPyPN1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758580266; c=relaxed/simple;
	bh=f0Pf+/Nz8S8Bgu/9V/G5zu53Iw6Z7pQM1xGQ4Qrv/rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZsRxl7QoPyxNI7MlqC0yYMgrJHKbEwfeURaVMPOHp6Ne/7DVwbGlBgOmngTI5/vawtD1nBXtNcwsS2DjepQ0MbcqJIAe6ydC6B9gDACVLteHt1lgV5d+RqXrMdmd8r++kEMlq6jZXq2buMqH3fuyFHbUEQ64tKerinx8MritdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXk+Kjyz; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-723ad237d1eso45821277b3.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 15:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758580264; x=1759185064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbtiN+WRaWrszvI4A9cJYkitcyxTdDcwVBjMTfPz09w=;
        b=nXk+KjyzxdB7ECI3DSN/XtsU/9bTQodwoFKlf3Hah+7J4pqKWNinspaLgiaV13h29K
         w6PIHpowizatZ3kMBcRq//R/lSfXZ4u/zPsmXUgBlg7VvxpNIUDXZBKkHnxNGf80+Zaw
         5hS345nwQKCSUScfLe+QfSVH1XBEGrCxtwYsmbia/AT8bjbt7UE6mpglPUgrnoBUjOP9
         zQ+lPMcueFsRtx3gLbgA0GogrzyASPRBjLm8EM6TVhqnuL1Vvzn8U4W5YruMfS50l8fU
         EY/Lkq5aPych8U7t2hWlwhDfCMA444Iz1wxh/DMNYr3gm3DK3bv/PF6VcjFxVnxRhEU2
         OPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758580264; x=1759185064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbtiN+WRaWrszvI4A9cJYkitcyxTdDcwVBjMTfPz09w=;
        b=FpTghlPzwdIb5d6neqMH5ZM1/BY090/Zvkn4rnwKO1gUMMMeocgWlV1/E5gcdFOaiw
         Tnn/QEPXC+agpvLTKIEmCxEz45yBhCCngfKqWb72NSvvIO9KpvQ51Dl0IPkZtCfQYmra
         GMxbWDdEane9g2TWWZ/Cwcb6jJ4M926qpqysIXTRfUYZvNlLgidJ80TfSI/lqREPZ15P
         BDkVBL8ylsT9FscSo4U85LlgHMOTFKLPRhN6OMSGXDA8AfhAl6ECdbftHgm12QIMORFL
         9yoB/5m8gtWv2q8wvLj+d3tz5ujuCCzxPZzN7+AXj7xWJAWCqR56Si9OPAbvkO31zJAA
         RK7g==
X-Gm-Message-State: AOJu0YwNN08d4vvVMgoy85mcaWHYC6q1QVDHxpBQzWHXM5f5M+jYa4jm
	TeH82edZYU5GZ2hb3t8CpWK1+8jiXlY8LydBMaogTiO2hod1Za1jzLIuRW1OgPt05taDP18fk2o
	mQh3f+v4tGGwuQ61FIaI5hKYxfoN6V58=
X-Gm-Gg: ASbGncvEr6yW01U/pXpOig9iKLav0F1QOs3EIk9kZZePaycw2blNXyPboL8OdP0Z3Zf
	WTUy0HGXGBUODWClHP51XlVcrMgr88/sqgw4oUZyyb4bzgfbi32+zkl0eZc+rSN4oR+qxWTEV7Q
	TqVmAXaTQlZZLyVH0pkqmQOpKYpoBcQWJpzyaJPRxgprGJjEPMMcKaUE8NfX+46zxTLclXcWoJc
	XaAisVkjBNTyrtdEiGczm8=
X-Google-Smtp-Source: AGHT+IFdH1w+ZNyAYLaHh3rhpX284bCYkkpquZUVSDR4yfWiQ2pvfmbptj19EIZR1rn5jw+Ke1XbuMsRmKdrWNNs1DU=
X-Received: by 2002:a05:690c:6108:b0:730:72a:7991 with SMTP id
 00721157ae682-75891e0901dmr3078527b3.4.1758580264279; Mon, 22 Sep 2025
 15:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919230952.3628709-1-ameryhung@gmail.com> <20250919230952.3628709-6-ameryhung@gmail.com>
 <10e5dd51-701d-498b-b1eb-68b23df191d9@linux.dev> <CAMB2axPU6Aoj6hfJcsS0W7CDL=bvAFLtPm2ZrsJef3w+aNoAXg@mail.gmail.com>
 <f870f375-f9a5-4c36-80df-8062ec3eddd3@linux.dev>
In-Reply-To: <f870f375-f9a5-4c36-80df-8062ec3eddd3@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 22 Sep 2025 15:30:52 -0700
X-Gm-Features: AS18NWBHImg6Ly3imtzQWTz-SmTtiB9vYWNL_EUtmU52MWLBZC06W9_OT3aaWKI
Message-ID: <CAMB2axNNc0p6kXgNQjQs-jsZ-NkKR==hY6OtoU6mxdHy-YqbvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 5/7] bpf: Support specifying linear xdp packet
 data size for BPF_PROG_TEST_RUN
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, paul.chaignon@gmail.com, 
	kuba@kernel.org, stfomichev@gmail.com, martin.lau@kernel.org, 
	mohsin.bashr@gmail.com, noren@nvidia.com, dtatulea@nvidia.com, 
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, 
	maciej.fijalkowski@intel.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:04=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/22/25 12:48 PM, Amery Hung wrote:
> >>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> >>> index 4a862d605386..0cbd3b898c45 100644
> >>> --- a/net/bpf/test_run.c
> >>> +++ b/net/bpf/test_run.c
> >>> @@ -665,7 +665,7 @@ static void *bpf_test_init(const union bpf_attr *=
kattr, u32 user_size,
> >>>        void __user *data_in =3D u64_to_user_ptr(kattr->test.data_in);
> >>>        void *data;
> >>>
> >>> -     if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - =
tailroom)
> >>> +     if (user_size > PAGE_SIZE - headroom - tailroom)
> >>>                return ERR_PTR(-EINVAL);
> >>>
> >>>        size =3D SKB_DATA_ALIGN(size);
> >>> @@ -1001,6 +1001,9 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog=
, const union bpf_attr *kattr,
> >>>            kattr->test.cpu || kattr->test.batch_size)
> >>>                return -EINVAL;
> >>>
> >>> +     if (size < ETH_HLEN)
> >>> +             return -EINVAL;
> >>> +
> >>>        data =3D bpf_test_init(kattr, kattr->test.data_size_in,
> >>>                             size, NET_SKB_PAD + NET_IP_ALIGN,
> >>>                             SKB_DATA_ALIGN(sizeof(struct skb_shared_i=
nfo)));
> >>> @@ -1246,13 +1249,15 @@ int bpf_prog_test_run_xdp(struct bpf_prog *pr=
og, const union bpf_attr *kattr,
> >>
> >> I just noticed it. It still needs a "size < ETH_HLEN" test at the begi=
nning of
> >> test_run_xdp. At least the do_live mode should still needs to have ETH=
_HLEN bytes.
> >
> > Make sense. I will add the check for live mode.
>
> The earlier comment wasn't clear, my bad. no need to limit the ETH_HLEN t=
est to
> live mode only. multi-frags or not, kattr->test.data_size_in should not b=
e <
> ETH_HLEN.
>

Right. It seems the current size check is also off. It allows empty
xdp_buff as long as metadata is larger than ETH_HLEN.

>

