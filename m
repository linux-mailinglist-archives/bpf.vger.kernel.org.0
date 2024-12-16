Return-Path: <bpf+bounces-47059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9BD9F390B
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 19:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425F1163D67
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 18:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C73E207A31;
	Mon, 16 Dec 2024 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1hJPhpz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A687207662;
	Mon, 16 Dec 2024 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734374038; cv=none; b=O8D5lcgb75hvLEsuyml2n/NIEnTbsUGezXuy3xt67muVI6/paT5Ghe7yBrPd3VNm49AfQcbQvCQ+aj8iO3bdDaII233xLrZeVJHqRQA2RVQrio7RHraEuLpUBhKEbv+5OEkWws0sVEE+cA3Lz1rY4KSSe3cTTs53bqoB57zqkwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734374038; c=relaxed/simple;
	bh=mAYIkWMq+q12YWRbO6dy5wlp3p8p4VoH+kxB1RORygc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/MEC6iRDlcKaqE1HCGc+z+DmJyUOnwcbYcO2keJdwpXNj807JtuW/fWFE/+0tt6+zE/A6mL0B9yba6rxiAo9xcBIZ7c2xOrEsPSIP1tpSRt1gjrCoNgc5EDqmjibA0Ey1+yeJyq+xIUCPqJrLI01ypMokhD1wprTfVQf/Tis6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1hJPhpz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso2150431f8f.0;
        Mon, 16 Dec 2024 10:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734374035; x=1734978835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwrnN8GfcXPZry6d8cAuBHyJqIiqU8pf/JYa0ijdGN4=;
        b=a1hJPhpz50rlWBvmEEq5k5xGbOOwv26vHqdQ9bZJOEa+6Bc2hKRAv2NuoZnZMpUqO9
         Alc+1dhM1L1wZiXxLBzGdfs+I+fwtGOkzohbJE2nBbeQBHyP+iWN45lAf0bzuAru/5pR
         YDlsHmVLPgou/hXgAPafh4ZIVGwGA39VpxQGxROmZmt96cMNQJvv13Qq/65WpedqhbxT
         e5N2dMChYaeymtg1/I5/Oqrxk9bH9pKnyCouIoU+5Xi3yluqAQbyDQPP5AKRf3x4ToY3
         BWSawVuQp3pFwDXvFxak5if11AUSIjjU3nAg//wD+TH067MlgbbWQ327ak5Zs2Jwv233
         gqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734374035; x=1734978835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwrnN8GfcXPZry6d8cAuBHyJqIiqU8pf/JYa0ijdGN4=;
        b=reOD2JxW05mfVGRuIeX6AT2GvblQ2JpJ61gjEbF3ATe06Cgb440+SDYVyqrvN+hLQZ
         tkasKG6cWqTRgMXNflZRBovqkdX/Nx2lnd5YM0aiD9NT7zOAWokWonvh25F2xBe5ZzTG
         5wvr7unzIEeeybU1v7eIltJ4hSbOEkuNm465pozyx4TqxXyEDwBKemBVIUQCPO7sggqW
         n/UD9z0W2B0NNdUTE0Y6dDQ+tyNzX2tdLFhRMT0xN/UW7lHIhc9R4kHiqhSgygSrA+IZ
         3ZTh/fjv/JDGx+2awC+bI7X7GkK3aYkwFACJ1avU1eqYJQ8OxB2gM4wJxqGewI9Zyfey
         w7Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVgTKgymK9mTOjkAmrH30hGxVkeR8jmUyFKi6r38bfV7BFIUstNwKlik1fECJ/2PlIIjYbf0crNDbOZW/RW@vger.kernel.org, AJvYcCW2Oe+xKm2VIWhrYQYXuA6nV3nypnwOIQArBOGC64tCdCSwJvivsfZPxkikY5sjq8TYf20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDM7YExLXYIUzS3/UoSbBORw9bnBdJ1ffV6gQw94mKLkNPHzl/
	sDH717aPCZOykX9xPZtfl10S7pIJu1uOrjrIyamoR40sqFXPgURxymUeSpyGQVIR22wjR3vwF+l
	8GG7+HXkYdRj8GKO7KFicJFNfjVg=
X-Gm-Gg: ASbGnctW4CNyvy1dnAIv29FLje0FMVCXR+NeUZ9nM2/izdfAIaE1g9aCBzHqc0EGxFO
	09vambzwoOt80Q56r5LwgZA1viEWkYzf8B7tUXo8cShvFV4DfvDW9DQ==
X-Google-Smtp-Source: AGHT+IFbTvBEsR7GbcqMwhVUCM0LGmMwKZN/QmxaWoM22j//+BleI9x0TqYsefMmXF50Vzw86cp9q6FWnByXbOMKNoc=
X-Received: by 2002:a05:6000:471e:b0:386:391e:bc75 with SMTP id
 ffacd0b85a97d-38880ac7742mr10660230f8f.16.1734374034202; Mon, 16 Dec 2024
 10:33:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216104615.503706-1-arighi@nvidia.com> <5e7c4b07-f5f0-400f-a84f-36699f867a4a@iogearbox.net>
 <Z2BiWTcp-CnC5cCz@gpd3> <49407656def0054fb62c47907c2338bfc36df47e.camel@gmail.com>
In-Reply-To: <49407656def0054fb62c47907c2338bfc36df47e.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 16 Dec 2024 10:33:43 -0800
Message-ID: <CAADnVQ+1=3U_gusnrfVD3QrQirg5Bzwawje9nD2f-nvrYJH=JA@mail.gmail.com>
Subject: Re: [PATCH] bpf: do not inline bpf_get_smp_processor_id() with
 CONFIG_SMP disabled
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrea Righi <arighi@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 10:27=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2024-12-16 at 18:24 +0100, Andrea Righi wrote:
> > On Mon, Dec 16, 2024 at 05:16:33PM +0100, Daniel Borkmann wrote:
> > > On 12/16/24 11:46 AM, Andrea Righi wrote:
> > > > Calling bpf_get_smp_processor_id() in a kernel with CONFIG_SMP disa=
bled
> > > > can trigger the following bug, as pcpu_hot is unavailable:
> > > >
> > > > [    8.471774] BUG: unable to handle page fault for address: 000000=
00936a290c
> > > > [    8.471849] #PF: supervisor read access in kernel mode
> > > > [    8.471881] #PF: error_code(0x0000) - not-present page
> > > >
> > > > Fix by preventing the inlining of bpf_get_smp_processor_id() when
> > > > CONFIG_SMP disabled.
> > > >
> > > > Fixes: 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper=
")
> > > > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > >
> > > lgtm, but can't we instead do sth like this :
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index f7f892a52a37..761c70899754 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -21281,11 +21281,15 @@ static int do_misc_fixups(struct bpf_verifi=
er_env *env)
> > >                      * changed in some incompatible and hard to suppo=
rt
> > >                      * way, it's fine to back out this inlining logic
> > >                      */
> > > +#ifdef CONFIG_SMP
> > >                     insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32)(un=
signed long)&pcpu_hot.cpu_number);
> > >                     insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, B=
PF_REG_0);
> > >                     insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF=
_REG_0, 0);
> > >                     cnt =3D 3;
> > > -
> > > +#else
> > > +                   BPF_ALU32_REG(BPF_XOR, BPF_REG_0, BPF_REG_0),
> > > +                   cnt =3D 1;
> > > +#endif
> > >                     new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
> > >                     if (!new_prog)
> > >                             return -ENOMEM;
> >
> > That works as well (just tested) and it's probably better since we're
> > basically inlining the return 0. Do you want me to send a v2 with this?
>
> I think both Andrea's and Daniel's versions of the fix are good.
> Note, however, that I missed one more configuration variable when
> making bpf_get_smp_processor_id() inlinable: CONFIG_DEBUG_PREEMPT.
>
> Helper body:
>
>     BPF_CALL_0(bpf_get_smp_processor_id)
>     {
>         return smp_processor_id();
>     }
>
> smp_processor_id definition:
>
>     #ifdef CONFIG_DEBUG_PREEMPT
>       extern unsigned int debug_smp_processor_id(void);
>     # define smp_processor_id() debug_smp_processor_id()
>     #else
>     # define smp_processor_id() __smp_processor_id()
>     #endif

No. It's fine as-is.
We inline raw_smp_processor_id().

