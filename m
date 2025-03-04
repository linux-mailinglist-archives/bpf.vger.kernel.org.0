Return-Path: <bpf+bounces-53246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACBBA4EFA8
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 22:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DA416F215
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 21:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4287526FDAB;
	Tue,  4 Mar 2025 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="qrI6QoXU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA111DB125
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741125470; cv=none; b=H8yKLlbTMsHZihQc9FjK5n2tdJu5plxS29iVzsam8X6Pf344riTCN6AdXt6240Xf2gxe4s9ZmjuCJQ/+kB0YEh/TOp7Bz+5XTtNFt52v9yE7LneUV/UglyjQmZhEfFlYsg5IoEzRPlgpCsmMr7wg5NZZonN2pUK8defLbH+4dvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741125470; c=relaxed/simple;
	bh=ZprjjAv4of4DheT9e4BmvdWosaz/33jNZe54sPsErFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gimzc2AiFlOJuDgpN5SWFX+Y0fxE7+ympb71HO6hjKs4Q+DAT/hzQMTgYd/dpeC8c3bW6EzV5C+T6SQaDrCbWtnE3igiD3Ycd/NT2fdsp2OFnd+DfJ9VaUaK633kzTLEZFbMtNWThE+PderVacD9xjGPVupeQZ0UclsM9/TG7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=qrI6QoXU; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6fd719f9e0dso24594517b3.1
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 13:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741125467; x=1741730267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CE2rgjTCJRuRdeYpKDhzY3yjxL0HL58E11vVouz4olw=;
        b=qrI6QoXUscItWC3uDlffAg25MnM/i2sjbHhy57KGQZal9pcPMllWnFKQLQ29J/uKbL
         jbPHd2+NL5dCMx64imTNToTXU2CsNMc1s2DlJigKCHEg14EDGEgJEhYmi88OnyxZqiqS
         DO0YbWFn0VPs4YDE9IoA7x0jej/eFUjY7ksiz2YfwBeAxZzdx+Aa/pgDCBB7gtmaV650
         ngnPCLi2BQJvGNSNvSNA2Vc23Zh565/mDw4hcUGJZFzuC19EjsBU/OP/tePeGItuNwxb
         J68IPl/oZhb5YTw+qaqOh5ZaNAvvb3vhELiUnKzrWmaUFYqYcH5JpaoxDvUttu37zKWW
         9YCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741125467; x=1741730267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE2rgjTCJRuRdeYpKDhzY3yjxL0HL58E11vVouz4olw=;
        b=l85Tm2HmgvhmYB1t0OSeZkgBaUIrYTMb7nfF3x0kATSDQrG/gRst5rbar3fyJ5kPd3
         DcJOYsWkIhinpOs09MTdLuZ+U5EGFIM6QXG/OX4CeMnes0+iz0nUBMbavHTOpBcgDWlk
         ON/EareriMW0jD8tty7FNMC5KY7+moN9bxLuSN2ETFB5wy1vXOlVsB+ZyJGaxLoxyjoJ
         8BV9BvTF1nkVEey+BEAKj0D3I+Na5bVh4wc91ICpXmb3DT/xm32rkwW5M22RDZ3wyqpj
         61AF0mzR9ifHaMqam7J19s5trcZpfa/VxnssSqlAyfoW53NfpecjV8ZEDv721ljYweH+
         wRPw==
X-Gm-Message-State: AOJu0Yxssi3DOwLL/aLPcGl4kgh/wJ1bcYZwuhX4Kx40Q6wBCFIAIQin
	EPVkFB+cikWofA/gcSo8qok6LqIy58Hg2Tn3rrm6YVlx4bRTms65SRk6NPimc5/zlLF6WGiuxLM
	Y3e45yYQXnNbuhSiu25iDGJdFw9sVK9MCUPRucJbGYQ3qMKR8zWfUqQ==
X-Gm-Gg: ASbGncvZkRebF+B78l2AQMaHLkwvbrjxr2mcCzkWhpAM+5+ZzQEAoLNE0eDZGnbXTIG
	YnyZjkNJvXBgDHf6grqFT9sFY0akh4ooPFwFLAY4xa4zrkE8nWKhBXtf7xZ1wdtWsC6YpQrLVOk
	gdwByt9HFTCi2aEecMhVnKIxMPJFY=
X-Google-Smtp-Source: AGHT+IFJu7I3rlvbHgJjIXTOpIjctsZVXGoWVaWMecwrdxHNpmLyaS+sEvN9EVVke6QDb6Iowqfo66025T8K3vj9/VA=
X-Received: by 2002:a05:690c:6988:b0:6fd:2062:c8a2 with SMTP id
 00721157ae682-6fda2f432b7mr17147967b3.11.1741125467191; Tue, 04 Mar 2025
 13:57:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228003321.1409285-1-emil@etsalapatis.com>
 <20250228003321.1409285-2-emil@etsalapatis.com> <9c51ec81-d7e3-679e-055d-8f82a73766ef@huaweicloud.com>
 <CABFh=a7U8ut-YE1kc=P60sqrG4ySXMcXKewpoKzAvpQoQz8pgg@mail.gmail.com> <c6725ecc-ffb5-9626-ca4f-146ab80b2070@huaweicloud.com>
In-Reply-To: <c6725ecc-ffb5-9626-ca4f-146ab80b2070@huaweicloud.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Tue, 4 Mar 2025 16:57:36 -0500
X-Gm-Features: AQ5f1JpGbCFy1tVuYzWp5f5DkXZ7ZmchzmCLx9Ar2EIXC_0xG2JQxeHBPdJzhVo
Message-ID: <CABFh=a6A2wo-kR1qsF2w41f1tXv+oG84_C-TVrKwL0QQzvDRhg@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: add kfunc for populating cpumask bits
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.de, eddyz87@gmail.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


On Tue, Mar 4, 2025 at 9:04=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 3/4/2025 11:18 AM, Emil Tsalapatis wrote:
> > Hi,
> >
> > On Fri, Feb 28, 2025 at 7:56=E2=80=AFPM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> Hi,
> >>
> >> On 2/28/2025 8:33 AM, Emil Tsalapatis wrote:
> >>> Add a helper kfunc that sets the bitmap of a bpf_cpumask from BPF
> >>> memory.
> >>>
> >>> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> >>> ---
> >>>  kernel/bpf/cpumask.c | 21 +++++++++++++++++++++
> >>>  1 file changed, 21 insertions(+)
> >>>
> >>> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> >>> index cfa1c18e3a48..a13839b3595f 100644
> >>> --- a/kernel/bpf/cpumask.c
> >>> +++ b/kernel/bpf/cpumask.c
> >>> @@ -420,6 +420,26 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct =
cpumask *cpumask)
> >>>       return cpumask_weight(cpumask);
> >>>  }
> >>>
> >>> +/**
> >>> + * bpf_cpumask_fill() - Populate the CPU mask from the contents of
> >>> + * a BPF memory region.
> >>> + *
> >>> + * @cpumask: The cpumask being populated.
> >>> + * @src: The BPF memory holding the bit pattern.
> >>> + * @src__sz: Length of the BPF memory region in bytes.
> >>> + *
> >>> + */
> >>> +__bpf_kfunc int bpf_cpumask_fill(struct cpumask *cpumask, void *src,=
 size_t src__sz)
> >>> +{
> >>> +     /* The memory region must be large enough to populate the entir=
e CPU mask. */
> >>> +     if (src__sz < BITS_TO_BYTES(nr_cpu_ids))
> >>> +             return -EACCES;
> >>> +
> >>> +     bitmap_copy(cpumask_bits(cpumask), src, nr_cpu_ids);
> >> Should we use src__sz < bitmap_size(nr_cpu_ids) instead ? Because in
> >> bitmap_copy(), it assumes the size of src should be bitmap_size(nr_cpu=
_ids).
> > This is a great catch, thank you. Comparing with
> > BITS_TO_BYTES(nr_cpu_ids) allows byte-aligned
> > masks through, even though bitmap_copy assumes all masks are long-align=
ed.
>
> Er, the long-aligned assumption raises another problem. Do we need to
> make the src pointer be long-aligned because bitmap_copy() may use "*dst
> =3D *src" to dereference the src pointer ? Or would it be better to use
> memcpy() to copy the cpumask directly ?

I would be fine with either, IMO the former is preferable. We are
rounding up the
size of the BPF-side CPU mask to the nearest long anyway, so it makes
sense for the
memory region to be long-aligned. The alternative would make the copy
slightly slower
on machines with nr_cpu_ids <=3D 64, though at least for sched_ext this
function should
be rare enough that the performance impact is be minimal.

If that makes sense, I will add an alignment check and an associated selfte=
st.




> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>>  __bpf_kfunc_end_defs();
> >>>
> >>>  BTF_KFUNCS_START(cpumask_kfunc_btf_ids)
> >>> @@ -448,6 +468,7 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
> >>>  BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
> >>>  BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
> >>>  BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
> >>> +BTF_ID_FLAGS(func, bpf_cpumask_fill, KF_RCU)
> >>>  BTF_KFUNCS_END(cpumask_kfunc_btf_ids)
> >>>
> >>>  static const struct btf_kfunc_id_set cpumask_kfunc_set =3D {
>

