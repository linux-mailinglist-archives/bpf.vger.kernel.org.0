Return-Path: <bpf+bounces-44898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C19F79C9915
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 01:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B49283EB5
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69C963B9;
	Fri, 15 Nov 2024 00:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAs2yRVS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAC38472
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 00:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731630012; cv=none; b=PH0YjVBKGKbGbhLcRa7Fz1CR9dS2s/FDhRXXbk3LS1SNx4KU8+XHUuyB4LHDISmVu3ghMF9juWqNiwDc1xcg5c9Jbd+8WIMIAyuznlbutsYk/ZLfAiH5siNPkV74Q6NOBEPgbgrksjPske3aISWkNOzcQdw13aLth80+atu3fZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731630012; c=relaxed/simple;
	bh=oaaPgpkc5c4BGMKGWhUzrqXhj3xUOtXF+CSLJ9OIdTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSTA9a5QKrarUnuUb23UhY+mmEXreNJ8NDNWjCd5CIN+IUYavJTHR/CIe9Uy3hG2JrM1lRXLA2F/aAq9x+0VcBPy4kBuOfXz8XPxJkqnFC5LVdPKMq/ck/rQhUTAyrSNVXGmNB+S3x+oCVyZ/3KiCSgWPIgTv7Nz+9qKz6aHCK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAs2yRVS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2114214c63eso11209855ad.3
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 16:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731630010; x=1732234810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVXk9csVTpwTxfWgpXZzxUlKk7jUBw+9vWIogapqCPc=;
        b=lAs2yRVSSKJiDpRrlrTmTAAlFA/gAlkm/eF6fkDUtouXa2Hm+qaydZ+NmgHF0N/KIt
         sZM+svS7LeBMVLfqyCemPigA+YT02WbXg6Ea2mvTgsomDNjyPLnjxb94oojHoZhv38F7
         XvtDjSTBmmNvnzMKn887hNFj2LyP6KcYVaYmAuGIzgty3ImFpmp1JK1ThQFjzeDy8sZ4
         zZWw72P6zStPPFxx04ncOSoX4ILnVuDHDPzxCgKuQb1757S8wmzdWV0GxPfS+812Kyxd
         KPFtcq2GVGxcGic+yaQ92ztf97+UMIdb3Zt/kMKujnnrn3eANNNok6XEf7/cgsBo9CTR
         m3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731630010; x=1732234810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVXk9csVTpwTxfWgpXZzxUlKk7jUBw+9vWIogapqCPc=;
        b=XX08zFBH2mGTF9n9EIC08ILeLXKeJDDDjVxsQquJlSIvMWJtUmmHvAHv0DOxDbiRsh
         QLEpLV/bFixJ6Dxmlu0WfpDS9WR0ngYvc159YxxB85eoPvwUGKE8SmAdJAdm9Oh/bvTw
         3GGSwidjdHIul/SxPTnRptwcm3KflQY+3ghBfqtEUhJKmRvcohOcDyFbOjSLoMqAftUi
         +57oX/KReYm0n0OsN+SZj/n4ZUYiXcsgtGmdHzi22Eaelfb2waFLnrpRrN6TzW51bLDz
         ipaOuR6SkITmwT1njhcRB4z0hpWbTPsi3SDt0E3oZgadso4d/riX45xUZFV+Wn880frR
         7NzA==
X-Gm-Message-State: AOJu0Yzg4YfMm1ZmymvqNcx2dR213o4NerGQdNq6YhlaR0Yzg/0vcVVT
	zmXHuNewTBHmOWRPO0la23tEcaD8Oif7VCtmtFDvvw9n2tE1hvM8bYwPFm8z6IZ4s25BU0z8wCi
	Js5JQvJM+Zq0n8M+WSQ52xqK76DM=
X-Google-Smtp-Source: AGHT+IGQWWSF5sXEKO1Hmsftqsz+aK+34X9ddNvI+B2soxbeofyu3hy5ur+9KgowCuVOTejr/CVJ0HHsxdpslYGOYXY=
X-Received: by 2002:a17:902:d505:b0:20c:e8df:2516 with SMTP id
 d9443c01a7336-211d0ebf407mr11734875ad.42.1731630010179; Thu, 14 Nov 2024
 16:20:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107175040.1659341-1-eddyz87@gmail.com> <20241107175040.1659341-2-eddyz87@gmail.com>
 <0f0cf220fa711f0bd376bdb167c035e53dd409f9.camel@gmail.com> <CAEf4BzYUMMOdfwsWovDqQMgDnd8eGQVEyJLVRvqzmSwsZoW-wA@mail.gmail.com>
In-Reply-To: <CAEf4BzYUMMOdfwsWovDqQMgDnd8eGQVEyJLVRvqzmSwsZoW-wA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Nov 2024 16:19:58 -0800
Message-ID: <CAEf4Bza57teg+vOc_P2Fk02gEFPY69u7yPRzksr4GRVvS7o1Cg@mail.gmail.com>
Subject: Re: [RFC bpf-next 01/11] bpf: use branch predictions in opt_hard_wire_dead_code_branches()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 4:17=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 14, 2024 at 2:20=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Thu, 2024-11-07 at 09:50 -0800, Eduard Zingerman wrote:
> > > Consider dead code elimination problem for program like below:
> > >
> > >     main:
> > >       1: r1 =3D 42
> > >       2: call <subprogram>;
> > >       3: exit
> > >
> > >     subprogram:
> > >       4: r0 =3D 1
> > >       5: if r1 !=3D 42 goto +1
> > >       6: r0 =3D 2
> > >       7: exit;
> > >
> > > Here verifier would visit every instruction and thus
> > > bpf_insn_aux_data->seen flag would be set for both true (7)
> > > and falltrhough (6) branches of conditional (5).
> > > Hence opt_hard_wire_dead_code_branches() will not replace
> > > conditional (5) with unconditional jump.
> >
> > [...]
> >
> > Had an off-list discussion with Alexei yesterday,
> > here are some answers to questions raised:
> > - The patches #1,2 with opt_hard_wire_dead_code_branches() changes are
> >   not necessary for dynptr_slice kfunc inlining / branch removal.
> >   I will drop these patches and adjust test cases.
> > - Did some measurements for dynptr_slice call using simple benchmark
> >   from patch #11:
> >   - baseline:
> >     76.167 =C2=B1 0.030M/s million calls per second;
> >   - with call inlining, but without branch pruning (only patch #3):
> >     101.198 =C2=B1 0.101M/s million calls per second;
> >   - with call inlining and with branch pruning (full patch-set):
> >     116.935 =C2=B1 0.142M/s million calls per second.
> >
>
> This true/false logic seems generally useful not just for this use
> case, is there anything wrong with landing it? Seems pretty
> straightforward. I'd split it from the kfunc inlining and land
> independently.

I was also always hoping that we'll eventually optimize the following patte=
rn:

r1 =3D *(global var)
if r1 =3D=3D 1 /* always 1 or 0 */
   goto +...
...


This is extremely common with .rodata global variables, and while the
branches are dead code eliminated, memory reads are not. Not sure how
involved it would be to do this.

