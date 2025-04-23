Return-Path: <bpf+bounces-56527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D46A99700
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 19:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C735A2093
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CF628C5AF;
	Wed, 23 Apr 2025 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeOFqkJU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF8041C69
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430618; cv=none; b=QhTIblO3jcr8pZC8CjQKBH4gCd9mbQoShTQsjKkGyu1njbvxZtwNpIAG6ui6OIhHZKI7urlxa8Z6WcCFQyuqMae/vhgjB3pGJD/cRd95cQpIHmk9q715OGgk3BAHvWS1dqqJF9ejJWmDO7Qk2JRLToNR+q5fbAOluFYFLBV+Bqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430618; c=relaxed/simple;
	bh=jqMKgPVAxLSyiRX9tHcVmDYHE3ODKsr/wBKFpiLQwzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXIJtTQpY6Uc05slrMumH49B1e1WkdTxyUPO+c2tkai9/Yfl7VZawk+RShUf6mTUF0ToOML56/IjxnfXiIupM4U+lczLfN7b5LNZdZnIqVWSIWlCyIHwswr5k/njWYnD9tlay5OWSsEZYu+HefEP9MgJUu/dxSo1qY2T3LzWPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeOFqkJU; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-acbb85ce788so28728366b.3
        for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 10:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745430615; x=1746035415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezWPNK87OJKj0qBenlKvsjX89ssosWBAW88BwcS7S8E=;
        b=AeOFqkJU4DNJL9Lbo9YaUkLQH1jyfso0I2Dokpp4/7HI+Ozqdz0bJ1IEVN32ekWVGI
         uc7anMVIyIkGh+y0u9l4lBDS7ov0TXLLUUQvhITOWS93pilz6Fb5z3n72zfLJPQ5fYyP
         bF6DyhtRDcigrvgQ/GsuWWO2cWZ1FA8Fwom77/X6VSCtDO9U20c5TfddWz915HyMOjic
         HmJH43ARsyd/e0bQNg5TejAieHus+bXmYzQt0mCCR+seugTtKZl0n0lm+yvPYPoVkT7f
         IxmgS34is9LJl2a8yz2Jj7h75UIkKhjmoqTqug+xYpSD9l9BEsL1czUDi+kaI+1/3PTM
         Skfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430615; x=1746035415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezWPNK87OJKj0qBenlKvsjX89ssosWBAW88BwcS7S8E=;
        b=W4TyguvmzYkju4w9ciCV92F4cfU86q3j1+xMw43S7sGQkgfewHBX8PAEPz1UZupybX
         pnLBm7c99A1nBHavGemI8a9hezMmRz17pcjeT9iJQfpSTENSQZr3HKnrmNZ53a+e4ppK
         TjGuBmVQ4EBMglq4FqsaybiQACPfnDf1mjXow6BU6Ybs74jXf8DbIJz12T1L6k/NKzAq
         yQMv5kZWBm48wqAJnyP9dS/uq4XOtT2AESoC6K3aT0c7Nu5jC9WTtXnsQz43k8BdlbZL
         6SVwPUOI3zWEUKNZFHZE4mUglnO5ze4DfFiJfGJbCYCvFGoqhxA8jOaOexn6ADTnXLZS
         tFnA==
X-Forwarded-Encrypted: i=1; AJvYcCWNOOZ2CzDr0be7WIdeb48GzMUJpehmd1rSZU/vwg8FtGFDtSI/qMZhEL6XNpyvIu8lYlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHT2qrXujbCZHBc8wXEbo0wsqBUW8Pz9vjj76UvPulIf6DkEp
	CCGw5miM9ye66no7DTo6E1twy6XLMkG/rXf8pwwsNxkpDQcl+hnAhfTWO41s9ai2DFxjIbL1MOW
	pzcWVEMg+vgyqC63NEd8ZvBfpjD8=
X-Gm-Gg: ASbGncss8F7c24tQQtrniEYwLsuIHLxb+e2GrDX1YwrLHl/rr5L2ZU97vVTeRcBhETM
	skN6NSMIy8Gv+Q1W+S/hElCDcLUHuEhPy3PwgfoVXzLnZyje/nKfq9mvhmKGKckRDUEDmykK7to
	vMyy5yjZ9NLvEkt7BQR31G+Ju0W4M27uI96XbCJQ==
X-Google-Smtp-Source: AGHT+IGkVpqRRGnPdAJIB+p2Aw2nMrofCtZ9TLFhScoU9CxS0u5OzCLxVHv04UAH0RrNuEK37a+7G2xv1kZAskSw5F8=
X-Received: by 2002:a17:907:6e9e:b0:aca:d4af:39ed with SMTP id
 a640c23a62f3a-ace54e6cceemr2910466b.4.1745430614879; Wed, 23 Apr 2025
 10:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUW31vpS=R3zM6G4FMkzuiQovqtd+e-8ihwsK_A-QtSSYg@mail.gmail.com>
In-Reply-To: <CA+icZUW31vpS=R3zM6G4FMkzuiQovqtd+e-8ihwsK_A-QtSSYg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Apr 2025 10:50:00 -0700
X-Gm-Features: ATxdqUG1G0Wk7QrPEwHryEt6dBVL0vbQWLjcs0mglGsPWjEAxLOnYRBoLdqvlK4
Message-ID: <CAEf4BzadoMS7RPL26J2U_NyQUXnwVEmP+TxHU6D8R4AKvWSGsA@mail.gmail.com>
Subject: Re: pahole v1.30 and libbpf: Introduce kflag for type_tags and
 decl_tags in BTF
To: sedat.dilek@gmail.com
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Alan Maguire <alan.maguire@oracle.com>, 
	Jiri Olsa <jolsa@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	cavok@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 11:58=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.com=
> wrote:
>
> [ QUESTION ]
>
> How to check if libbpf API functions
>  * btf__add_decl_attr()
>  * btf__add_type_attr()
> work as expected with pahole v1.30?

What does it mean "work as expected"?

Can you be a bit more explicit about what is the problem and what
doesn't work? I didn't get that from the below investigation notes,
sorry.

>
> Looks like I need Linux version >=3D v6.15-rc1?
>
> dileks@iniza:~/src/linux/git$ git log --oneline -1
> 51d1b1d42841c557dabde5b140ae20774591e6dc
> 51d1b1d42841 libbpf: Introduce kflag for type_tags and decl_tags in BTF
>
> Add the following functions to libbpf API:
>  * btf__add_type_attr()
>  * btf__add_decl_attr()
>
> dileks@iniza:~/src/linux/git$ git describe --contains
> 51d1b1d42841c557dabde5b140ae20774591e6dc
> v6.15-rc1~98^2~87^2~5
>
> Currently, I use Debian-kernel v6.12.22 and want to build a selfmade
> v6.12.24 (when it is released).
>
> If you need further information, please let me know.
>
> Best Thanks,
> -Sedat-
>
> P.S.: My investigations
>
> [ DEBIAN PAHOLE ]
>
> Debian/unstable AMD64 ships on my request pahole version 1.30-1.
> This version was built against libbpf-dev version (1:1.5.0-2)
>
> Link: https://packages.debian.org/sid/pahole
> Link: https://packages.debian.org/sid/libbpf-dev
> Link: https://bugs.debian.org/1103000
>
>
> [ SELFMADE PAHOLE ]
>
> Prereq: libbpf API version >=3D 1.6.0
>
> dileks@iniza:~/src/pahole/git$ git describe
> v1.29-16-gb45268b74da1
>
> dileks@iniza:~/src/pahole/git$ git log --oneline -1
> b45268b74da1 (HEAD -> pahole-v1.30, tag: v1.30, origin/next,
> origin/master, origin/HEAD, master) Prep 1.30
>
> root# /opt/pahole/bin/pahole --version
> v1.30
>
> INFO: git describe should report v1.30
>
>
> [ BUILD INSTRUCTIONS ]
>
> VER=3D"1.30"
> PREFIX=3D"/opt/pahole-$VER"
> PREFIX_CMAKE_OPTS=3D"-DCMAKE_INSTALL_PREFIX=3D$PREFIX"
>
> echo $PREFIX_CMAKE_OPTS
>
> cd ..
> mkdir build
> cd build
>
> # NOTE: See upstream commit "CMakeList.txt: Respect CMAKE_INSTALL_LIBDIR"
> ##cmake $PREFIX_CMAKE_OPTS -D__LIB=3Dlib ../git
> LC_ALL=3DC.UTF-8 cmake $PREFIX_CMAKE_OPTS ../git
> make
> sudo make install
>
> NOTE: Do NOT forget to run `ldconfig` as root (see below).
>
>
> [ LDCONFIG ]
>
> File: /etc/ld.so.conf.d/a-local-pahole.conf
>
> # pahole lib configuration
> /opt/pahole/lib
>
> root# cd /opt
> root# ln -sf pahole-$VER pahole
> root# ldconfig
> root# ldconfig --print-cache | grep pahole
>
>
> [ PAHOLE - CMAKE LOG (LIBBPF) ]
>
> [...]
> -- Submodule update
> Submodule 'lib/bpf' (https://github.com/libbpf/libbpf) registered for
> path 'lib/bpf'
> Cloning into '/home/dileks/src/pahole/git/lib/bpf'...
> Submodule path 'lib/bpf': checked out '42a6ef63161a8dc4288172b27f3870e50b=
3606f7'
> -- Submodule update - done
>
> Link: https://web.git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?=
h=3Dv1.30&id=3Dfe2dcd28ba9d348744ee93fed43cbed5dc0d6a43
>
>
> [ BTF FEATURES ]
>
> root# /opt/pahole/bin/pahole --usage | grep feature
>            [--btf_encode_force] [--btf_features=3DFEATURE_LIST]
>            [--btf_features_strict=3DFEATURE_LIST_STRICT] [--btf_gen_all]
>            [--skip_missing] [--sort] [--structs] [--supported_btf_feature=
s]
>
> NOTE: --btf_feature*s* (all options plural) VS. commit 40e82f5be9a7
> ("pahole: Introduce --btf_feature=3Dattributes")
>
> root# /opt/pahole/bin/pahole --supported_btf_features
> encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent=
_func,decl_tag_kfuncs,reproducible_build,distilled_base,global_var,attribut=
es
>
> NOTE: Supported =3D attributes
>
>
> [ LIBBPF API VERSION >=3D 1.6.0 ]
>
> Link: https://web.git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?=
h=3Dv1.30&id=3Dfe2dcd28ba9d348744ee93fed43cbed5dc0d6a43
>
> commit fe2dcd28ba9d348744ee93fed43cbed5dc0d6a43 ("pahole: Sync with
> libbpf mainline")
>
> Pull recently added libbpf API functions:
>  * btf__add_decl_attr()
>  * btf__add_type_attr()
>
> root# llvm-dwarfdump-19 /opt/pahole/bin/pahole | grep btf | grep add
>                DW_AT_name      ("btf__add_type_attr")
>                DW_AT_name      ("btf__add_enum64")
>
>
> [ pahole.git - lib/bpf/src/libbpf.map ]
>
> LIBBPF_1.6.0 {
>        global:
>                bpf_linker__add_buf;
>                bpf_linker__add_fd;
>                bpf_linker__new_fd;
>                btf__add_decl_attr;
>                btf__add_type_attr;
> } LIBBPF_1.5.0;
>
> -EOT-

