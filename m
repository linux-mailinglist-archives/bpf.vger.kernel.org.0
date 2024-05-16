Return-Path: <bpf+bounces-29873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D038C7CBE
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 20:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B35D1F21B31
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 18:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5428156F29;
	Thu, 16 May 2024 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b="SAr3X54e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373EDEDE
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715885822; cv=none; b=pQhnY6tLf5wteLEU0K0E7yk/CCY9lBZx/cz8j6gBIgg9Tlp6hnD+E/xXHnTX9ZsZqxjn8ojiGvHTC9bYfjQR3d9gnQTjiJ0w0HId01Ax9YV0RH3eIcqc9IHRKNggsJHTJX3jsJ8bs0jdVi20DVrpqOiz57pHaNSt9B6I8XOR4TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715885822; c=relaxed/simple;
	bh=BPy5up0pNhY6Tj/5eNml/GhSQfWIswNpDv1niMg4LaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U39DaZHsWLJlPPGG4uKJGXbVOcQtKd1sLpwMnX8QpxGNQpTqiG+mRgD/CiM/ghk1wMVQxo0iyiZjwo0fYDf5LygBXq/KNL4TCAaovYsaHaCaadSmDH5v7JtpH/1/zRaT/3SiWQSusVk5lfUnuivfcQByIsb1qbpRp6mPi+QM85E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com; spf=pass smtp.mailfrom=riotgames.com; dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b=SAr3X54e; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riotgames.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c9936cb7a8so339246b6e.2
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 11:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1715885819; x=1716490619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPy5up0pNhY6Tj/5eNml/GhSQfWIswNpDv1niMg4LaE=;
        b=SAr3X54edXdtsUrJx4xsmoDSVF/kN2x2y4jDSVyGOPGdm1tvvr3ev6paSpH8MlMqYw
         O+MUpWnapie5uubsVcsQ922xoSHXvZr6xRljT906nZauTyY+o/We1J8tP0Mv84rgpKoC
         SJkpSZx9B8cOmRpyzXhzU/jK5TfO1zqbJKsas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715885819; x=1716490619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPy5up0pNhY6Tj/5eNml/GhSQfWIswNpDv1niMg4LaE=;
        b=n/B/KRL/SDA/uAeae0rE8Kh4Tr/aXJxuqCoQsVwrM1MWsGGUB/+iJAWiwdI+/RtoCd
         yXzHwiQH9zchwnztmNhfrvHDRAw1iIVZGPmennVuvGxNKDft54Rn44Kvsxdp0pDY529Q
         KupJodcV/Hg95P1rn2SCmjheRA2UVoAoEiG+9k0qE8QOjGlp3oTnGXUEcUvywJbcSuD0
         JBM/lRG5NSojkJYnQ+oj0UqOetxsDe617Kss7MT0wiDRfBsNbjpw4dGf1Zi2Ns1W+1q9
         AmAhqPHC01yEuN2yoiWqY0OMq1Az39pjNHkdZbt1j+0kZQ3Boob6cFD+KESbSWXyccBM
         Y3SA==
X-Gm-Message-State: AOJu0Yxb1Pec0n/jqfrcKp30T4qH/RvW6TL0A2YWQJ0KHQ7EKlbzyif3
	HHNMMKrBAgaOtG41Amb7cBqlvH+w52ioq3rVxs1tdicEdg/vrJh0L4GroPaz1yb2v+yecBBGh1e
	oMF7Tqzor8rsB8Efrxn0yKSN9bnUJfbOPSRPMaw==
X-Google-Smtp-Source: AGHT+IHrUlpF5OQmu/ti1fZKpz6IBt+BvBM88mnIVhC9j/tv8lGleQGtNoA2fv8OmREW9BhrHIdbl5LrncbpEcguS8c=
X-Received: by 2002:a05:6808:a86:b0:3c8:61a9:629 with SMTP id
 5614622812f47-3c997024b98mr19597142b6e.1.1715885819283; Thu, 16 May 2024
 11:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509150541.81799-1-hffilwlqm@gmail.com> <20240509150541.81799-4-hffilwlqm@gmail.com>
 <a6b60575-6342-4ce7-9652-2a7438a3e1f4@gmail.com>
In-Reply-To: <a6b60575-6342-4ce7-9652-2a7438a3e1f4@gmail.com>
From: Zvi Effron <zeffron@riotgames.com>
Date: Thu, 16 May 2024 11:56:47 -0700
Message-ID: <CAC1LvL27bXu5zbPj+wO1hQCGvdHooUbQchiwwawyd+iokKc42Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/5] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, maciej.fijalkowski@intel.com, jakub@cloudflare.com, 
	pulehui@huawei.com, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 8:28=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
>
> On 2024/5/9 23:05, Leon Hwang wrote:
> > This patch fixes a tailcall issue caused by abusing the tailcall in
> > bpf2bpf feature.
> >
> > As we know, tail_call_cnt propagates by rax from caller to callee when
> > to call subprog in tailcall context. But, like the following example,
> > MAX_TAIL_CALL_CNT won't work because of missing tail_call_cnt
> > back-propagation from callee to caller.
> >
> > \#include <linux/bpf.h>
> > \#include <bpf/bpf_helpers.h>
> > \#include "bpf_legacy.h"
> >
> > struct {
> > __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> > __uint(max_entries, 1);
> > __uint(key_size, sizeof(__u32));
> > __uint(value_size, sizeof(__u32));
> > } jmp_table SEC(".maps");
> >
> > int count =3D 0;
> >
> > static __noinline
> > int subprog_tail1(struct __sk_buff *skb)
> > {
> > bpf_tail_call_static(skb, &jmp_table, 0);
> > return 0;
> > }
> >
> > static __noinline
> > int subprog_tail2(struct __sk_buff *skb)
> > {
> > bpf_tail_call_static(skb, &jmp_table, 0);
> > return 0;
> > }
> >
> > SEC("tc")
> > int entry(struct __sk_buff *skb)
> > {
> > volatile int ret =3D 1;
> >
> > count++;
> > subprog_tail1(skb);
> > subprog_tail2(skb);
> >
> > return ret;
> > }
> >
> > char __license[] SEC("license") =3D "GPL";
> >
> > At run time, the tail_call_cnt in entry() will be propagated to
> > subprog_tail1() and subprog_tail2(). But, when the tail_call_cnt in
> > subprog_tail1() updates when bpf_tail_call_static(), the tail_call_cnt
> > in entry() won't be updated at the same time. As a result, in entry(),
> > when tail_call_cnt in entry() is less than MAX_TAIL_CALL_CNT and
> > subprog_tail1() returns because of MAX_TAIL_CALL_CNT limit,
> > bpf_tail_call_static() in suprog_tail2() is able to run because the
> > tail_call_cnt in subprog_tail2() propagated from entry() is less than
> > MAX_TAIL_CALL_CNT.
> >
> > So, how many tailcalls are there for this case if no error happens?
> >
> > From top-down view, does it look like hierarchy layer and layer?
> >
> > With view, there will be 2+4+8+...+2^33 =3D 2^34 - 2 =3D 17,179,869,182
> > tailcalls for this case.
> >
> > How about there are N subprog_tail() in entry()? There will be almost
> > N^34 tailcalls.
> >
> > Then, in this patch, it resolves this case on x86_64.
> >
> > In stead of propagating tail_call_cnt from caller to callee, it
> > propagate its pointer, tail_call_cnt_ptr, tcc_ptr for short.
> >
> > However, where does it store tail_call_cnt?
> >
> > It stores tail_call_cnt on the stack of bpf prog's caller by the way in
> > previous patch "bpf: Introduce bpf_jit_supports_tail_call_cnt_ptr()".
> > Then, in bpf prog's prologue, it loads tcc_ptr from bpf_tail_call_run_c=
tx,
> > and restores the original ctx from bpf_tail_call_run_ctx meanwhile.
> >
> > Then, when a tailcall runs, it compares tail_call_cnt accessed by
> > tcc_ptr with MAX_TAIL_CALL_CNT and then increments tail_call_cnt at
> > tcc_ptr.
> >
> > Furthermore, when trampoline is the caller of bpf prog, it is required
> > to prepare tail_call_cnt and tail call run ctx on the stack of the
> > trampoline.
> >
>
> Oh, I missed a case here.
>
> This patch set is unable to provide tcc_ptr for freplace programs that
> use tail calls in bpf2bpf.
>
> How can this approach provide tcc_ptr for freplace programs?
>
> Achieving this is not straightforward. However, it is simpler to disable
> the use of tail calls in bpf2bpf for freplace programs, even though this
> is a desired feature for my project.
>
> Therefore, I will disable it in the v5 patch set.
>

Isn't this a breaking change such that it would effectively be a regression=
 for
any users already using tail_calls in bpf2bpf for freplace programs? And,
correct me if I'm wrong, but aren't those pieces of eBPF essentially consid=
ered
UAPI stable (unlike kfuncs)?

I appreciate that this is an esoteric use of eBPF, but as you said, you hav=
e a
use case for it, as does my team (although we haven't had a chance to imple=
ment
it yet), and if the two of us have use cases for it, I imagine other may ha=
ve
as well, and some of them might already have done their implementation.

> Thanks,
> Leon
>

