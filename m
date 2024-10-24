Return-Path: <bpf+bounces-43059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51449AEBEC
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 18:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B8328477E
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F611FAEE1;
	Thu, 24 Oct 2024 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVD2XSrs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562171F9EC6
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787088; cv=none; b=OKmLffDcLQXaI8KcYCVaKkBr9rdW59aZwgGpBWSpefZ2SGf/vsVFC/+ECsSN3ZhENa2aPfckQbVagXMQXiNQpRZQtNqFjF1I6N4HUSq/aLXKtSAOKyGnXZDs8ecyTklCNfgaKUT8XDfdtw+0U1sw141VswHpVNDPnOxYQqk1NhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787088; c=relaxed/simple;
	bh=EuY3pZXMJjDI8gOLyzucYLFjgfT/ItBbAUaMIZcAL1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNO949+KHIen1mG/a0QYRXtOui/fpvLImLoN5DBoprX9SzuKBz76R8CfGWa3u80JTVkiRWFMu5oUDPjP8K1tVGBA+rb9HTRTOApvsNPsqlMJqM/32K+0UMWA813Gwmpi/y0v2TQ5XkT4rdmPD716Nx56RcjKR/vJJpJW7IHSUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVD2XSrs; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d8901cb98so1485559f8f.0
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 09:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729787084; x=1730391884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ll4GC/Z+nsHOSL1Eq+RD0EPZsJaL6027ckST22ktgk=;
        b=gVD2XSrsXK6EeELhAkwObHm8ne4Ju3x/yBFaPibEdnr3hhSx0cJZ/7O0jdwXs/p9CK
         sCKFHmMcqhtCRpIKd/eB66kz4/l7AWwfLiB2WY5crf/YvUTlRTY8m9iuFUun+wJKCuAz
         kLa1R0qCi8Eo7TtSDsuzvSVG1bbmJvZ9caJj6atdW7EGkO7iMdbG8NRo3g9e7uH3QITs
         1vHyw5ghDsnun0aIkQL+vOCVfT/KpyosOCiMxyuCwyW1IDw4+7zGjVBz7Zj0J+l8GbWI
         6MFmfASGhZjJhX0siV1iHviRZieGjyOOXDfsVeBn/Tm9TIi9SlgFLh9/lVh/d6yWdTZO
         D0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729787084; x=1730391884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ll4GC/Z+nsHOSL1Eq+RD0EPZsJaL6027ckST22ktgk=;
        b=ghDqpS0CMdE2YA4W6hGOCNM1vkjAFgqCXgL5PqsgVTchdMlIpHYEAifw3DPj//wMoB
         FgfUuNNKRhmH7fvjUGeW1samT7xaOn27zrr86pH/u8hMvR5flElzcnWN96IsZOcFHSoi
         h4pY53KJvMzgGgG6kno6jA4NsToPLJkKo1jV771vB1NkWG8zP0yyrCuDBwViJZhUEOLN
         15N3m0wSKbySv6wH2e1UvZTLfQ/bAnzK5vr85EXvE/eQmwiOiY9mG66GIX1CZIelEMdN
         d63bT8eRjNVyAFhbrXO5hxnmAQdHXh9ayhdZuAmyGEZOp2oZwsxF8+QitePOyX4jg53o
         kz/w==
X-Forwarded-Encrypted: i=1; AJvYcCV7ScPqcMrYDU6o+s/rmNdZoy/b6ufCqpg0ZdkTv+VXoY1McEJ91mS+JShlGnQ/AWuJhWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YybfFPV1Ps5WaXkhHRQNbaz4oEQ07nr+Bwc49F1E8/1xv119SJw
	2eVe8rbZ7XSpF5FovzsIW8WUjEf1gpqF51UVCpuG8P8FCRWPY3Ky4VkeawlU6EZh9C5b61p5DbP
	epdxVfX0rgZRv4iivpbUobLdAcUc=
X-Google-Smtp-Source: AGHT+IE6yaGrr6D8biWQ/8kA/SbDNpPPefW5qxNaY83edHlmZV3ZNgLnpvIIARvcssk1h4h2GEo6irsBCBElsx8qu14=
X-Received: by 2002:adf:f7d1:0:b0:37d:3baa:9f34 with SMTP id
 ffacd0b85a97d-3803ab67450mr2253587f8f.1.1729787084103; Thu, 24 Oct 2024
 09:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019092709.128359-1-xukuohai@huaweicloud.com>
 <CAADnVQLOY-eHby6CMNXr3FvwPm85W-tWDxiWnRaR_U_=71ADuA@mail.gmail.com>
 <CANk7y0jiuiHSMTEZ_JCb4QpEPzhkK4ikicDGFa1F30DinZta8A@mail.gmail.com>
 <7226e7b8-ed73-4adb-9016-30031f1121ca@huaweicloud.com> <47082e78-e234-4487-95f2-0066e19f21dd@huaweicloud.com>
In-Reply-To: <47082e78-e234-4487-95f2-0066e19f21dd@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 24 Oct 2024 09:24:32 -0700
Message-ID: <CAADnVQKcwTstR5y3e1wNj-Agq7DuPNYOdQWkf33cLOBYiYGiug@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, arm64: Fix stack frame construction for
 struct_ops trampoline
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Puranjay Mohan <puranjay@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 6:48=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> On 10/23/2024 11:16 AM, Xu Kuohai wrote:
> > On 10/23/2024 7:37 AM, Puranjay Mohan wrote:
> >> On Wed, Oct 23, 2024 at 12:50=E2=80=AFAM Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com> wrote:
> >>>
> >>> On Sat, Oct 19, 2024 at 2:15=E2=80=AFAM Xu Kuohai <xukuohai@huaweiclo=
ud.com> wrote:
> >>>>
> >>>> From: Xu Kuohai <xukuohai@huawei.com>
> >>>>
> >>>> The callsite layout for arm64 fentry is:
> >>>>
> >>>> mov x9, lr
> >>>> nop
> >>>>
> >>>> When a bpf prog is attached, the nop instruction is patched to a cal=
l
> >>>> to bpf trampoline:
> >>>>
> >>>> mov x9, lr
> >>>> bl <bpf trampoline>
> >>>>
> >>>> This passes two return addresses to bpf trampoline: the return addre=
ss
> >>>> for the traced function/prog, stored in x9, and the return address f=
or
> >>>> the bpf trampoline, stored in lr. To ensure stacktrace works properl=
y,
> >>>> the bpf trampoline constructs two fake function stack frames using x=
9
> >>>> and lr.
> >>>>
> >>>> However, struct_ops progs are used as function callbacks and are inv=
oked
> >>>> directly, without x9 being set as the fentry callsite does. Therefor=
e,
> >>>> only one stack frame should be constructed using lr for struct_ops.
> >>>
> >>> Are you saying that currently stack unwinder on arm64 is
> >>> completely broken for struct_ops progs ?
> >>> or it shows an extra frame that doesn't have to be shown ?
> >>>
> >>> If former then it's certainly a bpf tree material.
> >>> If latter then bpf-next will do.
> >>> Pls clarify.
> >>
> >> It is not completely broken, only an extra garbage frame is shown
> >> between the caller of the trampoline and its caller.
> >>
> >
> > Yep, exactly. Here is a perf script sample, where tcp_ack+0x404
> > is the garbage frame.
> >
> > ffffffc0801a04b4 bpf_prog_50992e55a0f655a9_bpf_cubic_cong_avoid+0x98 (b=
pf_prog_50992e55a0f655a9_bpf_cubic_cong_avoid)
> > ffffffc0801a228c [unknown] ([kernel.kallsyms]) // bpf trampoline
> > ffffffd08d362590 tcp_ack+0x798 ([kernel.kallsyms]) // caller for bpf tr=
ampoline
> > ffffffd08d3621fc tcp_ack+0x404 ([kernel.kallsyms]) // garbage frame
> > ffffffd08d36452c tcp_rcv_established+0x4ac ([kernel.kallsyms])
> > ffffffd08d375c58 tcp_v4_do_rcv+0x1f0 ([kernel.kallsyms])
> > ffffffd08d378630 tcp_v4_rcv+0xeb8 ([kernel.kallsyms])
> > ...
> >
> > And this sample also shows that there is no symbol for the
> > struct_ops bpf trampoline. Maybe we should add symbol for it?
> >
>
> Emm, stack unwinder on x86 is completely broken for struct_ops
> progs.
>
> It's because the following function returns 0 for a struct_ops
> bpf trampoline address as there is no corresponding kernel symbol,
> which causes the address not to be recognized as kerneltext. As
> a result, the winder stops on ip =3D=3D 0.
>
> unsigned long unwind_get_return_address(struct unwind_state *state)
> {
>          if (unwind_done(state))
>                  return 0;
>
>          return __kernel_text_address(state->ip) ? state->ip : 0;
> }
>
> Here is an example of broken stack trace from perf sampling, where
> only one stack frame is captured:
>
> ffffffffc000cfb4 bpf_prog_e60d93d3ec88d5ef_bpf_cubic_cong_avoid+0x78 (bpf=
_prog_e60d93d3ec88d5ef_bpf_cubic_cong_avoid)
> (no more frames)

you mean arch_stack_walk() won't see anything after ip=3D0,
but dump_stack() will still print the rest with "?" (as unreliable).

That's bad indeed.

> To fix it, I think kernel symbol should be added for struct_ops
> trampoline.

Makes sense. Pls send a patch.


As far as this patch please add an earlier example of double tcp_ack trace
to commit log and resubmit targeting bpf-next.

