Return-Path: <bpf+bounces-52089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4090BA3E00F
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 17:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E6AB7B15A1
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 16:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438D71FF7D3;
	Thu, 20 Feb 2025 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/rK1fvi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21391FECB7
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067566; cv=none; b=Gaj0l9SuoJeCSH1EpMI7iGEO6mH8ym1luToZ+WJ/cplcWGONrJJ7YPIykrOsfvk5gHbs9aYTI9msHp9kqeBBS0l0DrjPgvXKYPqUg2Oib53coNKlwYtmDhXk5YKmSnyijYcPfsoJdxmRdVbd0mTl0F5C4pytftMs2kECimH/ZE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067566; c=relaxed/simple;
	bh=tbQOidXqp1yjFqLUCSWX8crAUrx2iQ0rJreGNuYlbL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sobGtv+SkqhTaYCiibKjgoZcuRVe34Hg/L8iBSl+oVQi8EmJFg3+Od5cjxCV7DmaXkLEr7XcawG9VoXHSGR4IMF6aNUpwzgNYCePQvJ7rorhwKWk7Rx4kgJaFZqtzcdWEuS9ssTKCvKelFBcIFYg7BdFz2STwRKEAUymtVJASa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/rK1fvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B03C4CEE3
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740067565;
	bh=tbQOidXqp1yjFqLUCSWX8crAUrx2iQ0rJreGNuYlbL8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m/rK1fvioJKITmDzocremsesXZz3e3ead3qQ6igOG9XT+0lIxT6smqihezdAhO6pP
	 H2t2JKXKfaLvlD1sXvvbNM0W+jF48wAamdttD5KOsjxafNUO2tRUEs0MttSBiw9Wk3
	 7K1obKe6sB+Xg3KqK/sr+ZAYLLQXodZ4eZE/i7zxit4Wl/3i/QW19B1jorruf9LODf
	 DQddjH+YUMmn1QvHncRXJ06ZMS/ntHwkkeWqZ3/Jjzxi4ypdLYCP6KEkN809XUXRSS
	 Xq06xsnOVz+HKAP6+6ILDt83YWjawqbs/Llaopb9m/OnYxRE+t84CrCJ6wvY87jiE0
	 KnSjNHb/bkxig==
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3cfe17f75dfso9701975ab.2
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 08:06:05 -0800 (PST)
X-Gm-Message-State: AOJu0YzBrgXrGBRrLzlob5jiKNM0o47ujhGMrDuNM0R5r78zXfiyBT9Y
	zS0p7QSuC6HWVPbBo3g5n/P/STaetiHwiMJiugmv31GHND/a0KeTgmG3jwldq97XoB3HGI4dOLz
	Fs9o9CcSJogC8VpsDspyr126UTjM=
X-Google-Smtp-Source: AGHT+IGCjRtCxJHa2y/0ZbX7E9e4xRAlgP1hvidrqdR2o4kxnZIaLRowzqOqz9+P2fkIxfWmwaMoDUOtecpgM/lPHM0=
X-Received: by 2002:a05:6e02:1c0f:b0:3d0:f31:3657 with SMTP id
 e9e14a558f8ab-3d2796b6803mr215159795ab.0.1740067564500; Thu, 20 Feb 2025
 08:06:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218080240.2431257-1-song@kernel.org> <55197030-7bf1-4bc8-ac58-0cc237b1eac7@huaweicloud.com>
In-Reply-To: <55197030-7bf1-4bc8-ac58-0cc237b1eac7@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Thu, 20 Feb 2025 08:05:53 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5fs_LvAoyzbGBJB-3y_OFhmk2iS1_nCuzX4qd16HpkxA@mail.gmail.com>
X-Gm-Features: AWEUYZnrHZ2KoaRoPnhLEg3zyOvmSxk0aQkUR8DKFbaArwkHTenyraHhCk54XT8
Message-ID: <CAPhsuW5fs_LvAoyzbGBJB-3y_OFhmk2iS1_nCuzX4qd16HpkxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: arm64: Silent "UBSAN: negation-overflow" warning
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	puranjay@kernel.org, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:35=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> On 2/18/2025 4:02 PM, Song Liu wrote:
> > With UBSAN, test_bpf.ko triggers warnings like:
> >
> > UBSAN: negation-overflow in arch/arm64/net/bpf_jit_comp.c:1333:28
> > negation of -2147483648 cannot be represented in type 's32' (aka 'int')=
:
> >
> > Silent these warnings by casting imm to u32 first.
> >
> > Fixes: fd868f148189 ("bpf, arm64: Optimize ADD,SUB,JMP BPF_K using arm6=
4 add/sub immediates")
>
> I doubt this is a bug fix since I checked the build result and found noth=
ing changed.

This is just to silence the UBSAN. We can remove the Fixes tag.

Thanks,
Song

> > Reported-by: Breno Leitao <leitao@debian.org>
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> >   arch/arm64/net/bpf_jit_comp.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_com=
p.c
> > index 8446848edddb..7409c8acbde3 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -272,7 +272,7 @@ static inline void emit_a64_add_i(const bool is64, =
const int dst, const int src,
> >   {
> >       if (is_addsub_imm(imm)) {
> >               emit(A64_ADD_I(is64, dst, src, imm), ctx);
> > -     } else if (is_addsub_imm(-imm)) {
> > +     } else if (is_addsub_imm(-(u32)imm)) {
> >               emit(A64_SUB_I(is64, dst, src, -imm), ctx);
> >       } else {
> >               emit_a64_mov_i(is64, tmp, imm, ctx);
> > @@ -1159,7 +1159,7 @@ static int build_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx,
> >       case BPF_ALU64 | BPF_SUB | BPF_K:
> >               if (is_addsub_imm(imm)) {
> >                       emit(A64_SUB_I(is64, dst, dst, imm), ctx);
> > -             } else if (is_addsub_imm(-imm)) {
> > +             } else if (is_addsub_imm(-(u32)imm)) {
> >                       emit(A64_ADD_I(is64, dst, dst, -imm), ctx);
> >               } else {
> >                       emit_a64_mov_i(is64, tmp, imm, ctx);
> > @@ -1330,7 +1330,7 @@ static int build_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx,
> >       case BPF_JMP32 | BPF_JSLE | BPF_K:
> >               if (is_addsub_imm(imm)) {
> >                       emit(A64_CMP_I(is64, dst, imm), ctx);
> > -             } else if (is_addsub_imm(-imm)) {
> > +             } else if (is_addsub_imm(-(u32)imm)) {
> >                       emit(A64_CMN_I(is64, dst, -imm), ctx);
> >               } else {
> >                       emit_a64_mov_i(is64, tmp, imm, ctx);
>

