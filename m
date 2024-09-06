Return-Path: <bpf+bounces-39165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 788F496FCFE
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 23:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD401F25A2B
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 21:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914651D61BE;
	Fri,  6 Sep 2024 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxwGptJe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DF71D4615
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 21:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725656622; cv=none; b=NARciuYqoWlApIOTChrIlV673tzWql6JNCV6EUd62mCmeKdN4csiAZhC3OY6/cmOWQ8KA/i9lHovksYZaXYIBT3Y1mHLj58Avzck1ESd3YjpZKHuvEiio2ua+U3R2kDc9PBCR6Y9j521CEGnnD7YoOfpnqlmebU97wLchVyqQNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725656622; c=relaxed/simple;
	bh=VtCCRL1aRYs8ICi4b5yqsbma2NArLTo1FmVkY8WRzgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdF9/eegIuid08bcGLRGhIkK9wcZavbDwQO1bNkbgMCTMMhgfzntg/nxHZ40+FyAGs0lEDOR8nSEGIwP0J9KwgyS+99WQtrDlIKjy9S4NFDI5dAEdhj5Jehx73G9nmtbq55iKzpS5VNqmKEToAAQTaJMbOrMbjwGHEgrSEhF1QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxwGptJe; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d86f71353dso1784075a91.2
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 14:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725656620; x=1726261420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/vnYWVKdtRARtaowbQ5wRR6RF7owGySGnzZIGsS8cU=;
        b=AxwGptJeFJyR1Vv385rgafTzcHaQ2FOxBtZmsAVtyBbs6Gjy/jqM4NOpJANQDRWiyC
         y7iTcnUDyKOKcxEz8PEF0mrOyHXMPAyvAkiK4pezvo23dpi+stPa15AxaFUltkPWZlb7
         mgpZ6XPTdVxYo0O6Bfzrga+4f4klcTOjxSsjjAGH0ypCqeCf944N3efbOODIj3FCKZJ7
         dy9vORLrtbE2YD1u+K+PZdhht3pD7P7c6SoMqDbOw+WPQiyRVXGEAz1J5bNs2GPZ7Bs+
         7YavGgNvXdnvAuoKxs/HVEWFQdu++HJNI4aJ3QbrLgfZclWGD/YF4nC1F3P8gfA3ugZ/
         ZFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725656620; x=1726261420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/vnYWVKdtRARtaowbQ5wRR6RF7owGySGnzZIGsS8cU=;
        b=rIKb9Udt/jnb5m2GnwC/lu3BoczXsmH9B3CfxukZjIO4e0TKQLOoGmUbnFTwmbsEQR
         KUzpc2dyNL39YmTyRkDp87pOTDMBX9Crl13Wtp8CbXB7O09S9faaPw6j/0v46a817W3D
         WkcQbZ27oEEjHaSggpKNBiB6p62hESbqmR1E4y4xUD44IxeWAxEs+MllkCC1fWUn0Tiq
         1D5arAUu8/Z9QGEwj3kHth7kD7RE/gguCE/so+5xbHysoLNPOFgCceUdUGFn+EIvLLMa
         b1ygYsCCIzPmWjvUD84inXr5U9MoJRAXRs7V6ncWl8YuSM3ma0H02N+cpgLVcwEIahxj
         uZkw==
X-Gm-Message-State: AOJu0YyrkRvqCWya13JTMUNIiYychTAqOjalg917QDtg/2BoEsVzEZgV
	tKybk0luUnBHJF8b9QTmXLv0oQlq1XgeNC/ED8KLfzYHkRmyhh1ERz7EN8H2lIP/dZSGu9nhIGs
	dvPoR6Z2V2UyWAuqb2KH98Ljuah4=
X-Google-Smtp-Source: AGHT+IFWVDuLV5UZCo1dVowRq98EmQug3t9HwYH2TYnEdL/aVqFbyV88dS+nLT1UC9X/qVbEkK4FiGlc9OJKOYLhv6A=
X-Received: by 2002:a17:90b:2252:b0:2d8:7572:4bc1 with SMTP id
 98e67ed59e1d1-2daffa3aaf9mr481951a91.1.1725656620016; Fri, 06 Sep 2024
 14:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906135608.26477-1-daniel@iogearbox.net> <20240906135608.26477-6-daniel@iogearbox.net>
In-Reply-To: <20240906135608.26477-6-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Sep 2024 14:03:20 -0700
Message-ID: <CAEf4BzaPzhs_gjJEjOM-oCqps5S4Eg6qif-joOBAzyiQ9qLRew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/8] selftests/bpf: Fix ARG_PTR_TO_LONG
 {half-,}uninitialized test
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, shung-hsi.yu@suse.com, andrii@kernel.org, 
	ast@kernel.org, kongln9170@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 6:56=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> The assumption of 'in privileged mode reads from uninitialized stack loca=
tions
> are permitted' is not quite correct since the verifier was probing for re=
ad
> access rather than write access. Both tests need to be annotated as __suc=
cess
> for privileged and unprivileged.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  tools/testing/selftests/bpf/progs/verifier_int_ptr.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c b/tools=
/testing/selftests/bpf/progs/verifier_int_ptr.c
> index 9fc3fae5cd83..87206803c025 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
> @@ -8,7 +8,6 @@
>  SEC("socket")
>  __description("ARG_PTR_TO_LONG uninitialized")
>  __success
> -__failure_unpriv __msg_unpriv("invalid indirect read from stack R4 off -=
16+0 size 8")
>  __naked void arg_ptr_to_long_uninitialized(void)
>  {
>         asm volatile ("                                 \
> @@ -36,9 +35,7 @@ __naked void arg_ptr_to_long_uninitialized(void)
>
>  SEC("socket")
>  __description("ARG_PTR_TO_LONG half-uninitialized")
> -/* in privileged mode reads from uninitialized stack locations are permi=
tted */
> -__success __failure_unpriv
> -__msg_unpriv("invalid indirect read from stack R4 off -16+4 size 8")
> +__success
>  __retval(0)
>  __naked void ptr_to_long_half_uninitialized(void)
>  {
> --
> 2.43.0
>

