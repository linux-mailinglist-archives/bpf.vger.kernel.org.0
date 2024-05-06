Return-Path: <bpf+bounces-28734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B748BD816
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 01:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6552AB21C15
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 23:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C0615B990;
	Mon,  6 May 2024 23:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ljc0PDeD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6060457C9A
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 23:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715037314; cv=none; b=XbEyzmVLT1UDsj07v5nAtLyyXiHCE8wWOcudJMUGTImwX0BwAE8YfEjP1Xw4GrvEP37Qmfe7506zFDAllrwglGAr/Da6dwtsl42l1c5lhnsAj8AFhl1pTCmRtyJWfsw4Err9ouEv6/5YnaqaruoBYL+QSdg97yddvQcYvmCjhv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715037314; c=relaxed/simple;
	bh=Y0nQ2k17NHXmEV0P0iGoNACbaIbr6Kv/zhoy81GEHoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHJJw93+4rX+RKU+O0+LcpwxrzDJWiSSqO1YtDX6KQHOoMY6WWDkCdeRooSc0uLI2rZczbAaY5vc5/tWqEHlIdO4fo3M+zqPR55reyPxowFB8nIGDrXTqyYmlF5/OYHL+LKifTzu4qLR9a17ajfJyZocmNuuB31H2Ougr8WhvPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ljc0PDeD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b3f5fcecc1so1968727a91.1
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 16:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715037313; x=1715642113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htOD6h0mJABcmUAZn58+/66JdEPxleWucl8hl1MJ0RE=;
        b=Ljc0PDeDzFA9RcMYiiH+0CtoYEcP5342rjrzFCLU0NjFdLZJg+nDwf5pjbpfrJtTep
         OSQ6ZY1xBdFC0ONljTAQtr2ij0F8EgHIO70XYAfckJFFOkImygE34Zzkaa3FvRk6pP6z
         yYyFXA9n6OGgNk8tPVk4cLzvS1fRIeXTOOnVC3VlwjNoI3xwYkrfRuoWSS0OX1IMVc4A
         fn6w1FOjr5UM6NAR6sg+tiw3jSlPRJdWExr2gpHgp5J/gaA46UkNZL+nYJMhJHmpAe14
         +j80rERSnCDt/B/ELpgXHySLGoTrGMuisz6UoePcJakdPZfMAsjfbS+jsDOm7ktlWmQg
         zlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715037313; x=1715642113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htOD6h0mJABcmUAZn58+/66JdEPxleWucl8hl1MJ0RE=;
        b=V4do2nEx5uCp4huT3OjvfgxXa1UalO6EBe791z8JqJ3Cn9iCnnoK9BQNUhmyCBHE06
         kqHA2eUNmcdIm7/fDMrS0tI4hrY6zhoHlhP3CjVxi1RG3Ky/O9RLyhr6tLrdHj3SeIAG
         E3jSdoDHangyGge06btgA35jJIepSFauxiPED91tYth9vaKtsdnl9gujFdV1Pm4Gt31M
         VQUPVM/eiOsga99AmgfsoZEpTdBi3bg1d16weJp9hGW6xeiMYeKyXA5L/h7F5/TbyVUO
         GV4ap9ub6jNEifb0C1WHBskL/K7DtY7ocV5jHn+IjdbWWUi8zM7lloKK4uWa34DIWJH9
         HCdw==
X-Forwarded-Encrypted: i=1; AJvYcCXxDYkmOHe0s5+JLIviRTQq4DC9GZhcgr4sNe1dP74agAxxjD/zRNL1+ihMlNXFqaa8D8n5t4SWOwsQG6ZtcfDsfZpY
X-Gm-Message-State: AOJu0YwRBYWObQIx1YBY+ya4bTu+exy9mk76XDppILX9bvY4zy1T+F/R
	Bk9V24Uv7af4SICNargypjZTavpF/w8+ahX2anKrGRUuur6qhgXPlUWl7KyIiPWKb7yfaLQEbR9
	suHqYTWprZVa9y6r7ovj4YlkE/80=
X-Google-Smtp-Source: AGHT+IEW0yNH3035BflMbI2DEPBYMhbY2ZBCOxnWKVx4IPPudqFDmV6LXtapMfdqzSy098QJsS4IyASMGBkeN2uRNWs=
X-Received: by 2002:a17:90b:4d8b:b0:2b3:2a3b:e4fb with SMTP id
 oj11-20020a17090b4d8b00b002b32a3be4fbmr8357133pjb.24.1715037312479; Mon, 06
 May 2024 16:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501175035.2476830-1-alan.maguire@oracle.com>
In-Reply-To: <20240501175035.2476830-1-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 May 2024 16:15:00 -0700
Message-ID: <CAEf4BzZPSer7EhZ1uJjQQEhPPo7U+dJJbQuBN+1bnJN64LyPRQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] kbuild,bpf: switch to using --btf_features for
 pahole v1.26 and later
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, eddyz87@gmail.com, 
	mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, houtao1@huawei.com, 
	bpf@vger.kernel.org, masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 10:51=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> The btf_features list can be used for pahole v1.26 and later -
> it is useful because if a feature is not yet implemented it will
> not exit with a failure message.  This will allow us to add feature
> requests to the pahole options without having to check pahole versions
> in future; if the version of pahole supports the feature it will be
> added.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  scripts/Makefile.btf | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index 82377e470aed..8e6a9d4b492e 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -12,8 +12,11 @@ pahole-flags-$(call test-ge, $(pahole-ver), 121)     +=
=3D --btf_gen_floats
>
>  pahole-flags-$(call test-ge, $(pahole-ver), 122)       +=3D -j
>
> -pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D --lang_exclu=
de=3Drust
> -
>  pahole-flags-$(call test-ge, $(pahole-ver), 125)       +=3D --skip_encod=
ing_btf_inconsistent_proto --btf_gen_optimized

given starting from 1.26 we use --btf-features, this should be `=3D=3D
1.25` condition, not `>=3D 1.25`, right? It doesn't hurt right now, but
it's best to be explicitly that below `-j --btf_features=3D...` is all
that's necessary.

pw-bot: cr


>
> +# Switch to using --btf_features for v1.26 and later.
> +pahole-flags-$(call test-ge, $(pahole-ver), 126)       =3D -j --btf_feat=
ures=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consi=
stent_func
> +
> +pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D --lang_exclu=
de=3Drust
> +
>  export PAHOLE_FLAGS :=3D $(pahole-flags-y)
> --
> 2.39.3
>

