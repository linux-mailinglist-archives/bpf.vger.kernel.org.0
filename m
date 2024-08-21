Return-Path: <bpf+bounces-37750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C49795A422
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 19:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4E01C20E42
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 17:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B031537D1;
	Wed, 21 Aug 2024 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRpPLcds"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4335B4206B
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724262386; cv=none; b=mm/D9K7lhmoRwGv950/TzOqRzDY0udzIwrhhVL6tiDp4yY2oOpFq3paNeuBbl7w6EYQUixtyAC1BHTc8IFet4PfvUITJz/D3GDleurToRMbW6GhestX0NzUR0y3e6pQDrcVt/Woz5f3xr/x3+11Zwh1PNOGkbjZOvZpndVX+88E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724262386; c=relaxed/simple;
	bh=fSwNU97z7xVieguAi0kBuAItOD6KzaPnBmvpmbfGNro=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jXIUk+i0vVMWhprVaYmCFZRCBuY92MBJCTDVWvpjKq6dA7aGz5xXwbHuCgFXqo59co1LfDEnxuDVyyZpGEBTBgCMXzQ6KAUTsGBqeymcrQ81q0Ndt9MFSm6Hukk1SbLkXL9FFnxmnzPDOx/vI7vSGBe6FouR9ttr/2QVW4TFV1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRpPLcds; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7a18ba4143bso4619795a12.2
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 10:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724262384; x=1724867184; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gD9cMYO73Tgg3wlLhO6m0C759rRNQxTJ+cpI/Y6/UeU=;
        b=aRpPLcdsoSY4aAWw1oAUkfBufqAIeUxjb7gKGPwjGCJHqeYTmnGLwwDQ9MUfjUZglq
         s5GM5zT2zBFBknPqv1PBYx8GuzETAbDcvEeN3n421JFviXpTJJ3AzErM6+ccgMh5D6s9
         FPgbMd0SFi6CZS8NO6F2D7qKTqUaJ52ouH3AdiL2AaQyBDkHubRTFKx0TCiJWGys3MRq
         /X/zvyTUqSeMn+YFb7enFoKnPs+yIgIis95Nwoj8CrxXZvPEoZPJ525o/2mPpikHe1/7
         d+zPq/eQ6ZMFGBRhB8Pj2Q1w8Qr8iYSUOVyZzj3aMrrcX6AsWYL4DX9uoD/+JYIIyYvh
         ydow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724262384; x=1724867184;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gD9cMYO73Tgg3wlLhO6m0C759rRNQxTJ+cpI/Y6/UeU=;
        b=gWhCy6fraRT+u5rc2O8KZcsEtfwQuF16y8+5ptRxJLq0or7JDU7FLrG+f1DVgoW4G6
         26odOnkK9j9C7ip76Jsp4wx9VS1W6LgF41dsiJwb/yYp31pBDANioKv9wQRFGwwy7TY1
         DeJ7YFNTzIFp8ndlNXHcEnBUKRNKmlukQBjcK1AxWEZjFavgsGMnVRBzt0MJxX+LeecI
         Avrvjk3fdmiIlqMunHTmnA0Hto2uDsc7ohahBVIuRaaIkP9NVpItGEKKWbCyLTpvpLs7
         sKQWvAg5h8wEoh7rVu4ViFxPXF3xefG/Djw2m0dyuKMl7zGlcV6590o/9EPApM46eIgt
         9BUg==
X-Gm-Message-State: AOJu0Yze2lpo4mrRk7J2O7LcGHvzrX0kcYNCT4CuwbRxfyjTloxnSi79
	XQ2SeSZfm1uqL+g+L4VaxwtsbvVImWtoIk6WiStGTnefbf1TnxbosRsjYZ74
X-Google-Smtp-Source: AGHT+IEkTV/1pv58NVApHG2yGJbmslJGmTktc3Vax2x2OrX93/E9kX7PWiA0gBTTYjb13Gp2exRCIg==
X-Received: by 2002:a05:6a21:918a:b0:1c6:a83c:d5db with SMTP id adf61e73a8af0-1cad7fd2893mr3269725637.31.1724262384340;
        Wed, 21 Aug 2024 10:46:24 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef6f1csm10172167b3a.128.2024.08.21.10.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:46:23 -0700 (PDT)
Message-ID: <a36a3307e4102c8f05df4e1d9fd44fc7b4f77c32.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: bpf_core_calc_relo_insn() should verify
 relocation type id
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, Liu RuiTong <cnitlrt@gmail.com>
Date: Wed, 21 Aug 2024 10:46:18 -0700
In-Reply-To: <CAEf4BzYxrD-sEe2UE7HBFBAOxd1gW9cYLwjxjTKH8_vdxQzO_Q@mail.gmail.com>
References: <20240821164620.1056362-1-eddyz87@gmail.com>
	 <CAEf4BzYxrD-sEe2UE7HBFBAOxd1gW9cYLwjxjTKH8_vdxQzO_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 09:59 -0700, Andrii Nakryiko wrote:

[...]

> > Fixes: 74753e1462e7 ("libbpf: Replace btf__type_by_id() with btf_type_b=
y_id().")
> > Reported-by: Liu RuiTong <cnitlrt@gmail.com>
> > Closes: https://lore.kernel.org/bpf/CAK55_s6do7C+DVwbwY_7nKfUz0YLDoiA1v=
6X3Y9+p0sWzipFSA@mail.gmail.com/
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  tools/lib/bpf/relo_core.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> > index 63a4d5ad12d1..a04724831ebc 100644
> > --- a/tools/lib/bpf/relo_core.c
> > +++ b/tools/lib/bpf/relo_core.c
> > @@ -1297,6 +1297,11 @@ int bpf_core_calc_relo_insn(const char *prog_nam=
e,
> >=20
> >         local_id =3D relo->type_id;
> >         local_type =3D btf_type_by_id(local_btf, local_id);
> > +       if (!local_type) {
>=20
> This is a meaningless check at least for libbpf's implementation of
> btf_type_by_id(), it never returns NULL. Commit you point to in Fixes
> tag clearly states the differences.

That is not true on kernel side.
bpf_core_calc_relo_insn() is called from bpf_core_apply():

int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *re=
lo,
                   int relo_idx, void *insn)
{
        bool need_cands =3D relo->kind !=3D BPF_CORE_TYPE_ID_LOCAL;
        ...
        if (need_cands) {
                ...
                // code below would report an error if relo->type_id is bog=
us
                cc =3D bpf_core_find_cands(ctx, relo->type_id);
                if (IS_ERR(cc)) {
                        bpf_log(ctx->log, "target candidate search failed f=
or %d\n",
                                relo->type_id);
                        err =3D PTR_ERR(cc);
                        goto out;
                }
                ...
        }

        err =3D bpf_core_calc_relo_insn((void *)ctx->log, relo, relo_idx, c=
tx->btf, &cands, specs,
                                      &targ_res);
        ...
}

If `need_cands` is false the bogus type_id could reach into bpf_core_calc_r=
elo_insn().
Which is exactly the case with repro submitted by Liu.
There is also a simplified repro here:
https://github.com/kernel-patches/bpf/commit/017a9dcf17e572f9b7c32aa62a81df=
8ef41cef17
But I can't submit it as a test yet.

>=20
> So you'd need to validate local_id directly against number of types in
> local_btf.

How is this better than a null check?

>=20
> pw-bot: cr
>=20
>=20
> > +               pr_warn("prog '%s': relo #%d: bad type id %u\n",
>=20
> nit: this part of CO-RE-related code normally uses [%u] "syntax" to
> point to BTF type IDs, please adjust for consistency

Ok


