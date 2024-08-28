Return-Path: <bpf+bounces-38325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7167963559
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 01:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668872857CC
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 23:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27971AD9E2;
	Wed, 28 Aug 2024 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffmpdcvy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F4F16B739
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 23:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887541; cv=none; b=irChTAhvec8wXHC2psOHgAVK7yjRjv7+BcL0t8y2gcPPodei9IKhfqU9tnNKMHuGvwK+AEd+sD4Zl+i11VF8nPISKOYwkHqsnUd2i6DVA+fY5QpC9bskEcRqs31kAGeIz21BIqWqNafzXSSELKj9ercyYU4VdHOkF2T/0o60xYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887541; c=relaxed/simple;
	bh=EDsLC7vMHq2WqkE+2tThdyo8ALML5+WE1LgqzgrZ9Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMpAfOY22T5gn3wtdtrt/2nB2kczesfZjBeBuhU0YjHhudQjHczse9vITGfoXfFeMrbSmL4NIHHAF1n1t6Pa2LgZ/5GlKV9iviJua35hmPOwpSD9v93h4CWZ+YIu7ilfL7XsKC7naN5aCf2y62KFezt80dfHK+65rvwQAVO+2HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffmpdcvy; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3717ff2358eso23270f8f.1
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 16:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724887538; x=1725492338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wb1lDbrliR1DqaH6Q9wr5ZZmzhSo30zMdtmjAnOa9s=;
        b=ffmpdcvySofqWrQ4/v1QIMeqRYJJk1HieF57ZW0/2ErpTEw3mF5uTVfcKSWyIoVw+2
         GopNTrxdv+AsoLd0ny8+mmvzk3j7g8XAGJH9FgQjzJMo9VzGjPnxRK9p7awFc4yiMaYT
         mmWZA8G2Sk6BMDeEQhhgR8C3Tgl7ZsuVd9dNTnKVIIBvrCTm+WpnOlXP/SDBI8+fQpUZ
         kB2jvzbGo8tbW/vK5CYlg8Mlqq1Mqr/WzeapMFOUlKILl3wJ5DPr23vqS98QBKITVlZz
         4LlL2qG2ASLERxur2Y+6b3cJU0uLG38hopHU1Ou5EbyFKQrKmMrNZ6biwfd6JAseZ/w0
         HBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724887538; x=1725492338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wb1lDbrliR1DqaH6Q9wr5ZZmzhSo30zMdtmjAnOa9s=;
        b=RO7wCD/zZJwi6Kq1kMhJ4IUvcNRL6Ske1M1vwtyKaiZUZheYsib2fBsbqyhCNEmI6M
         BOmPYjQhLc0Jq0Nm79t03PZa85C+mXXJ2ZBjSbxnIhcsaeWiVZdZok9O2eom6Ss7Cq1s
         ccjRvgmxd2ef5oWrLruJNtI+ePHXBKCCQ+PvN7P8Km+Xgqha23V8KlfFgI8MI+5ZxEzl
         GgP4tIgRe1gWXxRla9kNKuwJfivJ7PUFSOItIRLfpMFjHmxnbkXxKMwAOnA+E3BSTJZ/
         r3xtl5PPEr3Ci1Pb22m0sCf8ivbTZwL1Ho7jGL4RY4ojWJ6aFSydU4wQZNz/6bv6eqtS
         5Kqw==
X-Forwarded-Encrypted: i=1; AJvYcCUPgdoIjrP/jLqnUjRh0a2PFEXXbo9TU7QsibQr77WMlR0h9TMuOZZ49Ow9L08fnPbptCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSA8+RcLUJNWSlO8C6tMVSm9UzO5mBEyL4DHwkh9M4tg58jKlZ
	oc2r5jZUsZus0QZ/oCN8OzcjHjeWia/blVbR3OWjpujUxHTVjnNjfTLJo8g2rwAmiMHg7h8e46K
	mUBWR9OS+BVMduto4HHHSFsqjkkE=
X-Google-Smtp-Source: AGHT+IEsKuzKaQ0WDwNquVLp61iKNcZUJA7MOukoAxe7GkbizOzt9Hc4bdOWrnLfCfQJ97FYYKtQuHXMnZMMHI7Tsdw=
X-Received: by 2002:a5d:6446:0:b0:371:8e65:59bd with SMTP id
 ffacd0b85a97d-3749b57fee3mr553985f8f.42.1724887537906; Wed, 28 Aug 2024
 16:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828174608.377204-1-ihor.solodrai@pm.me> <20240828174608.377204-2-ihor.solodrai@pm.me>
 <b48f348c76dd5b724384aef7c7c067877b28ee5b.camel@gmail.com>
In-Reply-To: <b48f348c76dd5b724384aef7c7c067877b28ee5b.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Aug 2024 16:25:27 -0700
Message-ID: <CAADnVQ+9-Exx7__VTU9GZFuQ2nOWj29PrOvDWg-g00jfqmTOfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: do not update vmlinux.h unnecessarily
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Mykola Lysenko <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 3:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-08-28 at 17:46 +0000, Ihor Solodrai wrote:
> > %.bpf.o objects depend on vmlinux.h, which makes them transitively
> > dependent on unnecessary libbpf headers. However vmlinux.h doesn't
> > actually change as often.
> >
> > When generating vmlinux.h, compare it to a previous version and update
> > it only if there are changes.
> >
> > Example of build time improvement (after first clean build):
> >   $ touch ../../../lib/bpf/bpf.h
> >   $ time make -j8
> > Before: real  1m37.592s
> > After:  real  0m27.310s
> >
> > Notice that %.bpf.o gen step is skipped if vmlinux.h hasn't changed.
> >
> > Link: https://lore.kernel.org/bpf/CAEf4BzY1z5cC7BKye8=3DA8aTVxpsCzD=3Dp=
1jdTfKC7i0XVuYoHUQ@mail.gmail.com
> >
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> > ---
>
> Unfortunately, I think that this is a half-measure.
> E.g. the following command forces tests rebuild for me:
>
>   touch ../../../../kernel/bpf/verifier.c; \
>   make -j22 -C ../../../../; \
>   time make test_progs
>
> To workaround this we need to enable reproducible_build option:
>
>     diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>     index b75f09f3f424..8cd648f3e32b 100644
>     --- a/scripts/Makefile.btf
>     +++ b/scripts/Makefile.btf
>     @@ -19,7 +19,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)   =
   +=3D --skip_encoding_btf_inconsis
>      else
>
>      # Switch to using --btf_features for v1.26 and later.
>     -pahole-flags-$(call test-ge, $(pahole-ver), 126)  =3D -j --btf_featu=
res=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consis=
tent_func,decl_tag_kfuncs
>     +pahole-flags-$(call test-ge, $(pahole-ver), 126)  =3D -j --btf_featu=
res=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consis=
tent_func,decl_tag_kfuncs,reproducible_build
>
>      ifneq ($(KBUILD_EXTMOD),)
>      module-pahole-flags-$(call test-ge, $(pahole-ver), 126) +=3D --btf_f=
eatures=3Ddistilled_base
>
> Question to the mailing list: do we want this?

I don't think so. Too drastic just to save rebuild time.

imo the patch is good enough as-is.

