Return-Path: <bpf+bounces-37891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDE595BDD3
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 19:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6468C285232
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 17:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E968A1CF2B4;
	Thu, 22 Aug 2024 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/+FeapO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A61CCEFB
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349503; cv=none; b=ptA9qq9c5pYM8ARbNBD2GV4zt+uZVbu57owa2Yh0LgPXfp80A7CMwTAmJItuuPbZC8CgTmR5BoNC/KBGZFPqMyk5kS2ZyIxcE78HwkF64fF8qQ9Xcc3rOrSk1kb52iaLjOxTnYqhC4u7Eg1T0VNhRltBpEsmPDEl9zGtxcY/VZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349503; c=relaxed/simple;
	bh=i+A+5VWlHpu207ZC6od20szw2uMiZNs8TT2FlplcRhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ReIbAYVwuD98VoEJKo99Zz/xQdIo1hfFqPG2gfMG3FdfQjAmiclnpnS7o25I2r68fdcxduGF4mCSLd6B8YQ/7PqM/0lR6kRs4S7RAd4zistJI+rjE2CzmyDId5e/X2NmFoWgL5/vV8Ygq/6VAG8S7wn1WBekLhOnNuEghugrs38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/+FeapO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-429e29933aaso8059935e9.0
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724349500; x=1724954300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIxIYKC7ciSX1vxMieUzTtT76V7VZNKc0B8cmqjlzM4=;
        b=T/+FeapOgly+GaCByduRvisUVdhRJSRkaVX06wq15roC93S3+d266Qq35Tsq6+JrW9
         B/kDKHSqOXQoIer5lINCYc4IggMJw1c5HuLHrp/G02uz9Oyqt4yfWIvy9FOy81NVPb5m
         Dzf1gVJ/ZNFuXX/abW7wanZDvdsRte8cN8TBRCWnjAt6MpuqnA0HZ4P+qA2AyNZX49p0
         Ol5v7zI8poo6lHDBeHAQ8SP2mlkZa6s1Zof5ZGkAZbQrirL099WT+NxJJyH3EImEut72
         FPVbCSBhKOkKPuNncdfPOAbexzftOApT3GEZjJJCBzpLLLenv91IDV7uXOlZO/UTNSVd
         Dv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724349500; x=1724954300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIxIYKC7ciSX1vxMieUzTtT76V7VZNKc0B8cmqjlzM4=;
        b=BLG+ioOwmUAk1XCXDdEZa6QUwX4Bivz4LOaLt3T5DDkxrGi0XMUQZqjMJArN27MMye
         Gf1O/vaPrAFSNP9zlumo7kwLRgKZZW2/JNRitcVBmDjBCXpKzOZJE4LY6+X+nF1BuCxt
         md7F6gbs8/GLXP5c/dIUGEoYaeO9iWU3R8XSyyTbDGF3NiIBs6z6nufoVGJMH8k2H/aN
         VcofKUGr1X7dLIIGRQnDDkf5pG3eSSViC7k+GskB2tm0+c5SUVKmL2d66+zB8TNHCCcL
         ToZt6jNGRQZ/9gVXIte0lWp0+Vhavq86EgcKagL0U/5Ld06aSPMIpHgeQkSjBAoVUQcz
         Pq2Q==
X-Gm-Message-State: AOJu0Ywcw4Ca4YuoYNKHFB1UfjPjyXRQxmLc0QmaLXaAx92GG40kl6cI
	V85rEFOHrKVZPUsadHNMP7woautMDj+sPei4YKIruxjglsXGp3LW4SQlOrX5UxTiStYWg0AW5IS
	StpRJ/MaTqFC8qyXz6Hi5MyQCX3k=
X-Google-Smtp-Source: AGHT+IGmICgqdObevK4rHtOCGA9uTCNaEQwPDyBY2uZNYshK0oKC1OLUX2bN974eMVCNZmZ29unspRAOxJ2Nhf8XWoM=
X-Received: by 2002:a5d:4fce:0:b0:371:876a:a98a with SMTP id
 ffacd0b85a97d-37308c12e50mr1770157f8f.14.1724349499795; Thu, 22 Aug 2024
 10:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821233440.1855263-1-martin.lau@linux.dev>
 <20240821233440.1855263-8-martin.lau@linux.dev> <CAADnVQK4LUVsKQYHdaw0x9-CryA0wQX6stkvhFnNoDh1tt0jhg@mail.gmail.com>
 <7a4aa80b-b5fe-4f9a-95a3-743d2a218927@linux.dev> <CAADnVQ+b1Y3cb4mEMWMPw32=+q5_Gb26Ejuqj+=_LMwGvjROkw@mail.gmail.com>
 <8bb13887-ba3e-4814-b342-219313d734e2@linux.dev>
In-Reply-To: <8bb13887-ba3e-4814-b342-219313d734e2@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Aug 2024 10:58:08 -0700
Message-ID: <CAADnVQLBWs+Tq4Czy3T=yt0LgX7VU2mVhzE1GCLMq_v_S_-D8w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 7/8] bpf: Allow pro/epilogue to call kfunc
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Amery Hung <ameryhung@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 10:38=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 8/22/24 6:47 AM, Alexei Starovoitov wrote:
> > On Wed, Aug 21, 2024 at 11:10=E2=80=AFPM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> >>
> >> On 8/21/24 6:32 PM, Alexei Starovoitov wrote:
> >>> On Wed, Aug 21, 2024 at 4:35=E2=80=AFPM Martin KaFai Lau <martin.lau@=
linux.dev> wrote:
> >>>>
> >>>> From: Martin KaFai Lau <martin.lau@kernel.org>
> >>>>
> >>>> The existing prologue has been able to call bpf helper but not a kfu=
nc.
> >>>> This patch allows the prologue/epilogue to call the kfunc.
> >>>>
> >>>> The subsystem that implements the .gen_prologue and .gen_epilogue
> >>>> can add the BPF_PSEUDO_KFUNC_CALL instruction with insn->imm
> >>>> set to the btf func_id of the kfunc call. This part is the same
> >>>> as the bpf prog loaded from the sys_bpf.
> >>>
> >>> I don't understand the value of this feature, since it seems
> >>> pretty hard to use.
> >>> The module (qdisc-bpf or else) would need to do something
> >>> like patch 8/8:
> >>> +BTF_ID_LIST(st_ops_epilogue_kfunc_list)
> >>> +BTF_ID(func, bpf_kfunc_st_ops_inc10)
> >>> +BTF_ID(func, bpf_kfunc_st_ops_inc100)
> >>>
> >>> just to be able to:
> >>>     BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0,
> >>>                  st_ops_epilogue_kfunc_list[0]);
> >>>
> >>> So a bunch of extra work on the module side and
> >>> a bunch of work in this patch to enable such a pattern,
> >>> but what is the value?
> >>>
> >>> gen_epilogue() can call arbitrary kernel function.
> >>> It doesn't have to be a helper.
> >>> kfunc-s provide calling convention conversion from bpf to native,
> >>> but the same thing is achieved by BPF_CALL_N macro.
> >>> The module can use that macro without adding an actual bpf helper
> >>> to uapi bpf.h.
> >>> Then in gen_epilogue() the extra bpf insn can use:
> >>> BPF_EMIT_CALL(module_provided_helper_that_is_not_helper)
> >>> which will use
> >>> BPF_CALL_IMM(x) ((void *)(x) - (void *)__bpf_call_base)
> >>
> >> BPF_EMIT_CALL() was my earlier thought. I switched to the kfunc in thi=
s patch
> >> because of the bpf_jit_supports_far_kfunc_call() support for the kerne=
l module.
> >> Using kfunc call will make supporting it the same.
> >
> > I believe far calls are typically slower,
> > so it may be a foot gun.
> > If something like qdisc-bpf adding a function call to bpf_exit
> > it will be called every time the program is called, so
> > it needs to be really fast.
> > Allowing such callable funcs in modules may be a performance issue
> > that we'd need to fix.
> > So imo making a design requirement that such funcs for gen_epilogoue()
> > need to be in kernel text is a good thing.
>
> Agreed. Make sense.
>
> >
> >> I think the future bpf-qdisc can enforce built-in. bpf-tcp-cc has alre=
ady been
> >> built-in only also. I think the hid_bpf is built-in only also.
> >
> > I don't think hid_bpf has any need for such gen_epilogue() adjustment.
> > tcp-bpf-cc probably doesn't need it either.
> > it's cleaner to fix up on the kernel side, no?
>
> tcp-bpf-cc can use it to fix snd_cwnd. We have seen a mistake that snd_cw=
nd was
> set to 0 (or negative, can't remember which one). >1 ops of the
> tcp_congestion_ops may update the snd_cwnd, so there will be multiple pla=
ces it
> needs to do an extra check/fix in the kernel. It is usually not the fast =
path,
> so may be ok.
>
> It is not catastrophic as skb->dev. kfunc was not introduced at that time=
 also.
> Otherwise, having a kfunc to set the snd_cwnd instead could have been an =
option.
>
> > qdisc-bpf and ->dev stuff is probably the only upcoming user.
>
> For skb->dev, may be having a dedicated kfuncs for skb->dev manipulation =
is the
> way to go? The example could be operations that need to touch the
> skb->rbnode/dev sharing pointer.
>
> For fixing ->dev in the kernel, there are multiple places doing ->dequeue=
 and
> not sure if we need to include the child->dequeue also. This fixing could=
 be
> refactored to a kernel function and probably need to a static key in this=
 fast
> path case.
>
> > And that's a separate discussion. I'm not sure such gen_epilogoue()
> > concept is really that great.
> > Especially considering all the complexity involved.
>
> I am curious on the problem you pointed out at patch 1 regardless, I am g=
oing to
> give it a try and remove the kfunc call. I made kfunc call separated at p=
atch 7
> and 8 :)
>
> If it still looks too complex or there is no value on gen_epilogue, I am =
fine to
> table this set.

I think the patches 1-6 are fine and good to go.
Mainly because they simplify landing of qdisc-bpf.
Once all pieces are there we may revisit the need for gen_epilogoue()
and whether there is an alternative.
I would only drop 7 and 8 for now until it's absolutely needed.

