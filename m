Return-Path: <bpf+bounces-57948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D68DAB1F17
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 23:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC791C28897
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 21:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1F023F413;
	Fri,  9 May 2025 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPfLLelG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B8231A21
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746826402; cv=none; b=ERmH3SUVObGuaeK+mF+er82IGmJTgw8lHXAOomOIS1SYhJphUzIKERS1Zma727nOkM1/ORvf8gE5PCprsc3DYSV6pW8xX3fcIf3vPDcuOV6nvmqhZ/TGRJT/QlgGEVo/k/5BoFKi7g6h7MNTOP+y6uhAl+UD1vo48UB5ph93XGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746826402; c=relaxed/simple;
	bh=w9YoJU/TOByOQLeKPYVdr5SXijM2TnOVpsZcUTu6kVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGHQr4VoSBiDV+Hg//17mz2LSiDDJ6mxeNFSZwws9RZ+G8qLQf4chTVoX8wcnYrIEAlkRo9MMOPF1jFY3spnrBhrOOGd7TitzJqzc+yEkPm9VORckGHQVM+c1h3I2kmvtKhl9InmFycjWM+JhZOB8DjI4rvoglzmG8rUf9ly9a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPfLLelG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7399838db7fso2664024b3a.0
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 14:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746826400; x=1747431200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUPiGKi4FgEC1gqnQJCPadFndmGnDEz5spwL7ERF0B8=;
        b=WPfLLelG5D0qxchZ423t9ZDMrn/VH3DcPwEWJu4LpTuw2s5Nx49qw1D1HZOh86aa7R
         NMJbuHFrfYkchZosicawcKCI/BUkHL/BS8F7eE6WraYLo3PRF5lfArgrELYm3t3cS9Lz
         QfXXeotL3OProF/UkbAoeHTnDCmu2pLfO5Hsy2Tj8xhM9B/2rQ29Y6NgcTz99Ppa9MVM
         oCh9S2Og6NLdGVkAt3mEBcsRfPSO6UVCSqNXDMHGWVorkaFlJnFa4+Ffk3r7VGcPS9Ae
         zGKm25Wb+MIH2nccSCtgo6TL6/AOBsqglAcCRdkHNQyiWRJzMe3kuWYD8mG14cYDsFWd
         thAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746826400; x=1747431200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUPiGKi4FgEC1gqnQJCPadFndmGnDEz5spwL7ERF0B8=;
        b=TTUJJpf68RbtWPsPKc8EM/M0DErTcILli0mzpHWzAJt8h1IKHLudLRU/yQG04V1SgL
         upUNjS0Lc0fOLirt3n6MryywLE81XKGrxhVyeCHe+VSLDOKPakqkv9czzGnknV5lnjND
         HKoXLrB91mtIUGdNCWty3fWtq8kLRBxLWDZZ8ilX90Co+mN3HyIZLTjQ3kCbF1aBjDbZ
         PRQ8YqOaaoi6EdBH1B/ggHkGIE+Kp0iIpc/dW66fmdwmWuu5C7u0c6IsLZlvin2VShtp
         F1IeMTmSgPRIVPVHshPnUH+QHgjHXimOOJTIZme6VX7vedj/QZzVaDBX9NpoDnBcIi7k
         2lMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbCuKT+LSGUdrlXQe5H+glTzFHh9opnwi6N3eegE59B9/pO+j4iq2LEnhjuRtUlu80S4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtd0+B535zfFkMyYAUlfQfiDSprqFz1Iz8DbhF+l0tomHCzVZ0
	LSw0Mbzmdn/P2hjPOET1gGx0ipEzUat6VHPynTJ6SW0l+OLs1VeYkLC6bg+QuvBBwpZt3lUt7DK
	HABtBjAyTNgXEUh8wVfwRmcNhSOuFA65n
X-Gm-Gg: ASbGncus61BuPVSSIcx0JUZWSS5JcPY/cgJncSQN1Ws/VNnNOC6WWxiS8E0867p33B3
	3omOQGIpdNDbFwOtDmDI0o+C+mNAwSVWN45o4xNwhlOIzCOpTmce+cJ+c9995lKvt1MyWkvhV/Y
	0CWDtNT6/6jvUsxFtfLKEwnvxUo/5o6Vj/pT8vcwNYGkJzwcncbX9CXLoDN7A=
X-Google-Smtp-Source: AGHT+IFTz0yau7cJxBXu8tO0Xx0e53CMagzb2z1jxfVL509Qz18unkTNboRR0xYVmaSsl0hSLCDAVF5c/biTQO8h78A=
X-Received: by 2002:a05:6a21:3384:b0:1ee:b5f4:b1d7 with SMTP id
 adf61e73a8af0-215ab51e3e0mr7576505637.7.1746826399984; Fri, 09 May 2025
 14:33:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-11-memxor@gmail.com>
 <04332abfa1e08376c10c2830373638d545fba180.camel@gmail.com>
 <CAADnVQKN2S=yb_7NUO8bsu+7CxnaGyTML6gKcPS61EnCZtvG5g@mail.gmail.com>
 <9f417b403ef541af5bc8497897e4fbf88bd4023f.camel@gmail.com> <CAADnVQLOjzmhf1d81Nr9n0zXL1hj7CGeG5_8BySuNY0HxYanSg@mail.gmail.com>
In-Reply-To: <CAADnVQLOjzmhf1d81Nr9n0zXL1hj7CGeG5_8BySuNY0HxYanSg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 May 2025 14:33:06 -0700
X-Gm-Features: ATxdqUFyZETNojKHLzbbClFk-Imjj3ePtshrH7J465ZQfG1eewSGd9XHHtfW7d4
Message-ID: <CAEf4BzanV6=_HHVVNxC1Vfsg6R7XYPxsCdEqVXsyBvA4zrGzbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 10/11] bpftool: Add support for dumping streams
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 11:48=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, May 9, 2025 at 11:31=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Fri, 2025-05-09 at 10:31 -0700, Alexei Starovoitov wrote:
> >
> > [...]
> >
> > > How about we extend BPF_OBJ_GET_INFO_BY_FD to return stream data?
> > > Or add a new command ?
> >
> > You mean like this:
> >
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
> > index 71d5ac83cf5d..25ac28d11af5 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -6610,6 +6610,10 @@ struct bpf_prog_info {
> >         __u32 verified_insns;
> >         __u32 attach_btf_obj_id;
> >         __u32 attach_btf_id;
> > +       __u32 stdout_len; /* length of the buffer passed in 'stdout' */
> > +       __u32 stderr_len; /* length of the buffer passed in 'stderr' */
> > +       __aligned_u64 stdout;
> > +       __aligned_u64 stderr;
> >  } __attribute__((aligned(8)));
> >
> > And return -EAGAIN if there is more data to read?
>
> Exactly.
> The only concern that all other __aligned_u64 will probably be zero,
> but kernel will still fill in all other non-pointer fields and
> that information will be re-populated again and again,
> so new command might be cleaner.

+1, but I'd allow reading only either stdout or stderr per each
command invocation to keep things simple API-wise (e.g., which stream
got EAGAIN, if you asked for both?) I haven't read carefully enough to
know if we'll allow creating custom streams beyond stderr/stdout, but
this would scale to that more naturally as well.



>
> > Imo, having this in syscall is more convenient for the end users.
> >
> > Alternatively, are files in bpffs considered to be stable API?
> > E.g. having something like /sys/fs/bpf/<prog-id>/std{err,out} .
>
> yeah. Ideally the user would just 'cat /sys/.../stdout',
> but we don't auto create pseudo files when progs are loaded.
> Maybe we should.
> 'bpftool prog show' will become 'ls' in some directory.

