Return-Path: <bpf+bounces-37759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EBE95A51A
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 21:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB601C224AC
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 19:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFCD16DEC7;
	Wed, 21 Aug 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f42yzLik"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7651679CD
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267445; cv=none; b=QBznSeWSPZim2g1QdfH4lhJbcm3tr+j4XfEAYMf/CE/mVTsGlCbFdOJIlNofFNF8WopdcQuuIXvcgbaqVg/p9BjwtH4hQuzWQYu46pygtXkvYu7PuaXP5pWVvWqD12mXj6okpUgOLa8CSwaa8A06nHtPfEwIj3XHwqtqTd1Tpl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267445; c=relaxed/simple;
	bh=2VQgX8t2fgENmIWuV2manYPDqTyj5kPcG2NiI22okTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjWXxAMXZcuPFRszaJVyx5nfMKuWsR6VVuaWOuXTFMFu8LEQ1KCDEaGBrpntnWaxS2LxY6JcGZslSiuj1Toyitbx0IYWjiZIa375NrPzZjeFfpUASnuFLNQ2JVnLM0BQh4dIUEuQwEqiKbZSiNXaR72goM4PGtLXJHVLs/YJDZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f42yzLik; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3bd8784d3so5257667a91.3
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 12:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724267444; x=1724872244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeDFddAcMa33MO29Sdjh9H9A8OlI9fn4PCLkpHA83Eo=;
        b=f42yzLikREjjYWNyUM4LIlky97F/3vw64HtwLeggQXBCL8c1pCeVXWzcDqyxNfd8Sz
         Opfbdae6laOa/wLfL7sGz+Bw19OfBBuS4vo1WatBDt32NjWXXgUp4WmsGoWuTjMbBOhd
         pRcRB7eCoALxiSq6qP3UUWn6DwDKUy37QwIoBTSysiALWmoLJNWYPt/XqOcRwx8dxqup
         KW0xBdYy2W0qY7W5Ze/X8KQj0UDlh7gQ6lS9e5CfkYEQnIxH+qBL9hcVUmz/Q7EC7/zH
         7IfQeHW8xD71hDVnXSNTLrL3nZ3IXYln9wlUcxh9umpPcQQR6pl8nIZRT80mzukxA+B8
         H7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724267444; x=1724872244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeDFddAcMa33MO29Sdjh9H9A8OlI9fn4PCLkpHA83Eo=;
        b=waoxwDrDgO/J913YmDJcD1KoiFsHRDzXljtSlnycfiXvesd/Lei/RoXWSq9XDhCarj
         vkAUEWtJCJl2/+4Whf2NM8FyASj4+5pZnODxdanQPh65S35OD9RIYDr3/qSL1xdA/NVq
         a63U6JrTMcuwE3yqCKCuSzxVczSUbnIAbxskQtijfu+ENZ7FnU6M79bP2aUFaLq6LSUJ
         dZ892jAY0chkCunjpJAV+UiTZkeX267n150o0cI0jgEbqWeTPUkhQi9yWU1O6L1Sbw1N
         EiYegm6zweN1xjalEk4d9d/cdoJhySFPCOtFmERAYzFNxmkl+G++mSTu93tLug6xSe1a
         W9Vw==
X-Gm-Message-State: AOJu0YzsFyH/iorOewPGM31F8HJFjdsCVbBefJBe4UplFBwVFRqjF+ZE
	qndnMwtBLn5/W9agEZjE8MEtZKw9zRjXHtIYm6MkyptImzvyc+eykQFSjxkZflx02QAzQEFXFsr
	F2OTeAOuqc/nlZ0Nrm9KMri9ZxJ8=
X-Google-Smtp-Source: AGHT+IHFFWsRB6vVfyN3r4dMGXItvf0myLGbORLld3U8dHyyYls/6DWzW9eDmxSn9b5QuJpiH1tI1EqyvgjXt8FmXYQ=
X-Received: by 2002:a17:90b:4b4a:b0:2d4:921:dff1 with SMTP id
 98e67ed59e1d1-2d5e9a64825mr3465314a91.20.1724267443634; Wed, 21 Aug 2024
 12:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821164620.1056362-1-eddyz87@gmail.com> <CAEf4BzYxrD-sEe2UE7HBFBAOxd1gW9cYLwjxjTKH8_vdxQzO_Q@mail.gmail.com>
 <a36a3307e4102c8f05df4e1d9fd44fc7b4f77c32.camel@gmail.com>
In-Reply-To: <a36a3307e4102c8f05df4e1d9fd44fc7b4f77c32.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Aug 2024 12:10:31 -0700
Message-ID: <CAEf4BzZ9sYeYANVNd1RDZWc_4EqS4cpsc+DfSqnLBp9Qfh0VaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: bpf_core_calc_relo_insn() should verify
 relocation type id
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, Liu RuiTong <cnitlrt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:46=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2024-08-21 at 09:59 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > Fixes: 74753e1462e7 ("libbpf: Replace btf__type_by_id() with btf_type=
_by_id().")
> > > Reported-by: Liu RuiTong <cnitlrt@gmail.com>
> > > Closes: https://lore.kernel.org/bpf/CAK55_s6do7C+DVwbwY_7nKfUz0YLDoiA=
1v6X3Y9+p0sWzipFSA@mail.gmail.com/
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  tools/lib/bpf/relo_core.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> > > index 63a4d5ad12d1..a04724831ebc 100644
> > > --- a/tools/lib/bpf/relo_core.c
> > > +++ b/tools/lib/bpf/relo_core.c
> > > @@ -1297,6 +1297,11 @@ int bpf_core_calc_relo_insn(const char *prog_n=
ame,
> > >
> > >         local_id =3D relo->type_id;
> > >         local_type =3D btf_type_by_id(local_btf, local_id);
> > > +       if (!local_type) {
> >
> > This is a meaningless check at least for libbpf's implementation of
> > btf_type_by_id(), it never returns NULL. Commit you point to in Fixes
> > tag clearly states the differences.
>
> That is not true on kernel side.
> bpf_core_calc_relo_insn() is called from bpf_core_apply():
>
> int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *=
relo,
>                    int relo_idx, void *insn)
> {
>         bool need_cands =3D relo->kind !=3D BPF_CORE_TYPE_ID_LOCAL;
>         ...
>         if (need_cands) {
>                 ...
>                 // code below would report an error if relo->type_id is b=
ogus
>                 cc =3D bpf_core_find_cands(ctx, relo->type_id);
>                 if (IS_ERR(cc)) {
>                         bpf_log(ctx->log, "target candidate search failed=
 for %d\n",
>                                 relo->type_id);
>                         err =3D PTR_ERR(cc);
>                         goto out;
>                 }
>                 ...
>         }
>
>         err =3D bpf_core_calc_relo_insn((void *)ctx->log, relo, relo_idx,=
 ctx->btf, &cands, specs,
>                                       &targ_res);
>         ...
> }
>
> If `need_cands` is false the bogus type_id could reach into bpf_core_calc=
_relo_insn().
> Which is exactly the case with repro submitted by Liu.
> There is also a simplified repro here:
> https://github.com/kernel-patches/bpf/commit/017a9dcf17e572f9b7c32aa62a81=
df8ef41cef17
> But I can't submit it as a test yet.
>
> >
> > So you'd need to validate local_id directly against number of types in
> > local_btf.
>
> How is this better than a null check?
>

because id check will be useful for both kernel and libbpf sides?..

> >
> > pw-bot: cr
> >
> >
> > > +               pr_warn("prog '%s': relo #%d: bad type id %u\n",
> >
> > nit: this part of CO-RE-related code normally uses [%u] "syntax" to
> > point to BTF type IDs, please adjust for consistency
>
> Ok
>

