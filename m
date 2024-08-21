Return-Path: <bpf+bounces-37760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D14F95A54A
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 21:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F661F22D1D
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 19:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70AC16DEA7;
	Wed, 21 Aug 2024 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3AbeFTo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A80516A92F
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268541; cv=none; b=kVfHxSlLrr5CypSweSXO7FnZSSf1C0Dh2bMuEY5CJOZcJRGevWpCG0BgECzHxryW3sQMHDLJ4CXRwVyBiO4WGsmdHSnPEaWcuEFN9EBjoiI8FxfSe/B+5sHnCXmtCMM1d/uOdS2OmnxaCJG1G37sXNN3Knpat98t99KoaNSDbSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268541; c=relaxed/simple;
	bh=yMAPpm9ELunVOvATuA2VBcrln8wTilbvXtY5XgyW+0s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rkPheIaQ2JRojS2iVrH/s0spCZwFW0rArxgJZMHm3EgAdZ7BHtnJmCt4q/6Dm2nlaoxdquv5vJ47Jc1Blm/XxDhzO1a4udrDx9s7/DGBt5pdi5DdU3IgYICHObFtnDLIBU6UV/XKvnIjXi7P2pDi312fBY2TZzXkBNSuveaVkTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3AbeFTo; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7143165f23fso26216b3a.1
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 12:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724268539; x=1724873339; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uqaacYyVxYBIrdGUZRtw0WCD+KlNrDFCu3xNqxr7ARI=;
        b=R3AbeFToDXTtHGyMaip3HDOo0yTrGkr4mRM9xIekiCR7G1oTMxZ1s+V0y4rj7fVlST
         oCEAF6+hax6RFv9JftaJqdcp+VRFdmlbkSgYazQvc9mF6f/+JU/KYKM4Y4e0l5u3lgXj
         50Eb+9I173aA1XNS1B+U8o/mv6YHDsYMFsHR7RuHQyzCBE9f+jb8EidWDgXxvjPMhlNV
         qMFiAl1lcOjllJtQo58K1C1gT+LNMz8myENV0GYqwaGU7bnkalyZ4Km6yoXCSTAYztix
         NQDtm9sRGFc6M0wq+EInfKkPwf1iJpRYs1G+GfkAPzRGLHyFhvxskK25vaJ+a7yETT00
         Jcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724268539; x=1724873339;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uqaacYyVxYBIrdGUZRtw0WCD+KlNrDFCu3xNqxr7ARI=;
        b=qa8Prp114SLx36uyZzmfLBJ1LXhrtpJW6rsAVsA5Nq0tlAtRC7YEMhHuCGskyCEAiE
         6nx+B5caIz1MI87WKmrTkxFyJ5WZI4TkMimBusYLyUdkWGn8Gh8jq4uwJTHSpSkBAx+6
         0eyALunESRC16MBQfpOc+XNgx/YVa90K9B4vcBqTxHM1bgGI/9kiWTX9qYhIO2bsYhJK
         Kh1LL5JJL9Mp+gb34zzkTFtbraZVd1sg75bQuRxYmJkcP2I0bD5XpUnBGOtdVi/54mI0
         TTzS7b6THuUYP8beUfdu09/7ZDF4jdyWVqN3e10+8tBRGQb2/Kya3Wv3NekRs6750z+b
         xf5w==
X-Gm-Message-State: AOJu0Yx9ovoNHrtMTfqwA7JA+/KCGSF5r6hCUJ5SjZcgJiMp2R4qqLcf
	iYAWf4P0DhcZaE147tKDmV7U05ObQYnMirDmMQRERFLTtfOEPaY88KscZ+BW
X-Google-Smtp-Source: AGHT+IGOCjJXXHgb+SpSQd7LXbFooUGvNKAP3YG/JFaBAMeCbbg3UQJGvwr2AVxxHdVbdWA7d5aXVg==
X-Received: by 2002:a05:6a00:1391:b0:714:29d7:94c0 with SMTP id d2e1a72fcca58-71429d79ab8mr2525684b3a.11.1724268539114;
        Wed, 21 Aug 2024 12:28:59 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430a3cesm2842b3a.169.2024.08.21.12.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 12:28:58 -0700 (PDT)
Message-ID: <98527d7adc2cc4880524caecc2f6e6d022bac210.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: bpf_core_calc_relo_insn() should verify
 relocation type id
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, Liu RuiTong <cnitlrt@gmail.com>
Date: Wed, 21 Aug 2024 12:28:53 -0700
In-Reply-To: <CAEf4BzZ9sYeYANVNd1RDZWc_4EqS4cpsc+DfSqnLBp9Qfh0VaA@mail.gmail.com>
References: <20240821164620.1056362-1-eddyz87@gmail.com>
	 <CAEf4BzYxrD-sEe2UE7HBFBAOxd1gW9cYLwjxjTKH8_vdxQzO_Q@mail.gmail.com>
	 <a36a3307e4102c8f05df4e1d9fd44fc7b4f77c32.camel@gmail.com>
	 <CAEf4BzZ9sYeYANVNd1RDZWc_4EqS4cpsc+DfSqnLBp9Qfh0VaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 12:10 -0700, Andrii Nakryiko wrote:
> On Wed, Aug 21, 2024 at 10:46=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Wed, 2024-08-21 at 09:59 -0700, Andrii Nakryiko wrote:
> >=20
> > [...]
> >=20
> > > > Fixes: 74753e1462e7 ("libbpf: Replace btf__type_by_id() with btf_ty=
pe_by_id().")
> > > > Reported-by: Liu RuiTong <cnitlrt@gmail.com>
> > > > Closes: https://lore.kernel.org/bpf/CAK55_s6do7C+DVwbwY_7nKfUz0YLDo=
iA1v6X3Y9+p0sWzipFSA@mail.gmail.com/
> > > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > ---
> > > >  tools/lib/bpf/relo_core.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >=20
> > > > diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> > > > index 63a4d5ad12d1..a04724831ebc 100644
> > > > --- a/tools/lib/bpf/relo_core.c
> > > > +++ b/tools/lib/bpf/relo_core.c
> > > > @@ -1297,6 +1297,11 @@ int bpf_core_calc_relo_insn(const char *prog=
_name,
> > > >=20
> > > >         local_id =3D relo->type_id;
> > > >         local_type =3D btf_type_by_id(local_btf, local_id);
> > > > +       if (!local_type) {
> > >=20
> > > This is a meaningless check at least for libbpf's implementation of
> > > btf_type_by_id(), it never returns NULL. Commit you point to in Fixes
> > > tag clearly states the differences.
> >=20
> > That is not true on kernel side.
> > bpf_core_calc_relo_insn() is called from bpf_core_apply():
> >=20
> > int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo=
 *relo,
> >                    int relo_idx, void *insn)
> > {
> >         bool need_cands =3D relo->kind !=3D BPF_CORE_TYPE_ID_LOCAL;
> >         ...
> >         if (need_cands) {
> >                 ...
> >                 // code below would report an error if relo->type_id is=
 bogus
> >                 cc =3D bpf_core_find_cands(ctx, relo->type_id);
> >                 if (IS_ERR(cc)) {
> >                         bpf_log(ctx->log, "target candidate search fail=
ed for %d\n",
> >                                 relo->type_id);
> >                         err =3D PTR_ERR(cc);
> >                         goto out;
> >                 }
> >                 ...
> >         }
> >=20
> >         err =3D bpf_core_calc_relo_insn((void *)ctx->log, relo, relo_id=
x, ctx->btf, &cands, specs,
> >                                       &targ_res);
> >         ...
> > }
> >=20
> > If `need_cands` is false the bogus type_id could reach into bpf_core_ca=
lc_relo_insn().
> > Which is exactly the case with repro submitted by Liu.
> > There is also a simplified repro here:
> > https://github.com/kernel-patches/bpf/commit/017a9dcf17e572f9b7c32aa62a=
81df8ef41cef17
> > But I can't submit it as a test yet.
> >=20
> > >=20
> > > So you'd need to validate local_id directly against number of types i=
n
> > > local_btf.
> >=20
> > How is this better than a null check?
> >=20
>=20
> because id check will be useful for both kernel and libbpf sides?..

This would require a special case for BPF_CORE_TYPE_ID_LOCAL in
bpf_core_calc_relo_insn(). If you don't like this null check I'll
modify bpf_core_apply() instead to always check relo->type_id and
report and error.

This would also be in the line with what bpf_core_resolve_relo()
does on libbpf side.

[...]


