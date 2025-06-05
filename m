Return-Path: <bpf+bounces-59769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFC3ACF443
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 18:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D8E77A367D
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 16:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C4320D4F9;
	Thu,  5 Jun 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlIpjcJz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC08D1F91D6
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140891; cv=none; b=pEy6umEPxuHc5xbJZVvD6mA7UKi8cFk4D6Cb1Binyqv/oqA9Mf2zdR3a59JHJtoQ59yaDRtlRZR1YLPEaTkbTi3bCWhXhPcwN/RTScdWPyUpoWvuyN7VXwc6XvNwmw1l6nZ8ldWyf8KKS/wkhPLcXMPN2jHEp2qrTFHOl7mT3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140891; c=relaxed/simple;
	bh=g5t/olr55aSwW+HLd38avmEAm+zq+Q4KZjLtxJkXZPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVzu6FNW+8GhkMMjqvkzrvmCmfPhoxCy4Wyym8Nt6TUR2bda74JEpt6eUJqCZk6xEgXly0WRH2iQbLPCGyQq5gVxYT744v3BRYQruHZg4GxFnqJILMaM017bcFGjOODXdWWaqjka7ob6outAoCEBCR5AFe3RDUQKMelcnBDzzic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlIpjcJz; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747fc7506d4so1348701b3a.0
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 09:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749140889; x=1749745689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gf6eJ5quJ74zPQ6211v+isFEmHY4WXbh4VTLL+uY7Kk=;
        b=VlIpjcJz/MrYRmY6fCG/jfamDqoVOS8IS6MFfm4mn7uoCWrF1B/y6tGL4I18pjyRba
         sL0ywnTc5MHDdHmiAiU9Py5vKL0lb7komR5bmrj65S/9IRnR/gXXRTH5yT8zaEZvy2ru
         DrsXBy/KpsXhKn1V55E58YhZwpZLcmEX+ZW9i2Bzlnw8qNke21YFOTFoB1zNqOxu9WYZ
         ognRrTsAO8VclJNGW88v9oEeYxyImCWs2JPm3m8WLM8QO5Q5ynwxafreishfsxHnETok
         P/twPkOkiUY5WYVd6JvuA9pDs+cbevEeLTTh6ybnqTf8RgUk6ySAJXfrB6sp7IIC0pc8
         I/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749140889; x=1749745689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gf6eJ5quJ74zPQ6211v+isFEmHY4WXbh4VTLL+uY7Kk=;
        b=OPGKYQ5ZyD12mL5ijKIIkrYdIox+IhJFwbKtU/LozV+kk7uoyZ2ZhiSqQTxRcLRkrF
         9DOiYPeThOGWrma+TAEQfNWFPPdTdXGgv108INdHJtFh9G/HtNLxrebt2TXMFdi7AKOI
         Rs7bEAvUyjeEMK68n27TYc4TNwNfSSY146XggZ6BIrh9LZFsh0ErvaGmCxcFP+FgOR2n
         59lFV5jK7vOH1sfeKJqtOdHY522PJgS6G7j3EFLYWryN/HdT8zSD7aZM3JjX/E55Smm4
         VIp+9hhQCr8jkwvj9dEIz2BUhrSxrPeIYTo+j6LPObbfGmixleLom8ctjXkHrhyfqvMe
         GxnA==
X-Forwarded-Encrypted: i=1; AJvYcCU1QDF27cUpCHRh9iSg3qlu52Q1kwIX4WlLVopCa6xjE0JqpeFjz93zDvgTMCI2xA18eag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX2Iae8YMv1vVmHjy/PzV7+f8ZSMhMOdGFZU0T1JhS7uZLmRL6
	E5Tbjtw/OU2VwCBOsFKD7tvr3flqdkU2QNpor11+GCq/NkhbaoMRSW0iPo1ZXCQQJWuxheqiEwu
	gkIiwLww2LuzaFB/1izcCEmtgiZ3sbYc=
X-Gm-Gg: ASbGncs3Ca81JSZ//g68lOeyPjr014aejHUIeyJCVOEWYFeQjalAmXQvQjaq/CCXM8d
	n3EOGFxGuU1qJ7OMxXoWwMb9qDM2hJyds5yQzLxCy4nFmJX/CH46Tdsig0QgIU/S6rXA+jOa8jJ
	oPr5L1MUadqql8N68/EWTRMNpL5Zxe6ajCw0LuaWKZY8A2ULEN
X-Google-Smtp-Source: AGHT+IENchaYP/X3n1K7uZynOifCYAU/6nnziUCSrS4+9xXdfH6LMxq2gOoC2XiP/FKlELNOgMs3zYFH8QJQOoq2k1c=
X-Received: by 2002:a05:6a00:882:b0:742:9fea:a2d1 with SMTP id
 d2e1a72fcca58-74827f379bbmr442147b3a.23.1749140888938; Thu, 05 Jun 2025
 09:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604222729.3351946-1-isolodrai@meta.com>
In-Reply-To: <20250604222729.3351946-1-isolodrai@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Jun 2025 09:27:55 -0700
X-Gm-Features: AX0GCFtAzA-gJVZVjldA7HsUSNVAKqfhz9Ws-1Nl6OYOB58yO5ceaQ9fZMc76BY
Message-ID: <CAEf4Bza6gOAWq9uXD8kxksNo=2h96jNSd2RCGar8YHLvN8MdvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: make reg_not_null() true for CONST_PTR_TO_MAP
To: ihor.solodrai@linux.dev
Cc: andrii@kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, 
	yonghong.song@linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 3:28=E2=80=AFPM Ihor Solodrai <isolodrai@meta.com> w=
rote:
>
> When reg->type is CONST_PTR_TO_MAP, it can not be null. However the
> verifier explores the branches under rX =3D=3D 0 in check_cond_jmp_op()
> even if reg->type is CONST_PTR_TO_MAP, because it was not checked for
> in reg_not_null().
>
> Fix this by adding CONST_PTR_TO_MAP to the set of types that are
> considered non nullable in reg_not_null().
>
> An old "unpriv: cmp map pointer with zero" selftest fails with this
> change, because now early out correctly triggers in
> check_cond_jmp_op(), making the verification to pass.
>
> In practice verifier may allow pointer to null comparison in unpriv,
> since in many cases the relevant branch and comparison op are removed
> as dead code. So change the expected test result to __success_unpriv.
>
> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> ---
>  kernel/bpf/verifier.c                               | 3 ++-
>  tools/testing/selftests/bpf/progs/verifier_unpriv.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>

LGTM, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a7d6e0c5928b..0c100e430744 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -405,7 +405,8 @@ static bool reg_not_null(const struct bpf_reg_state *=
reg)
>                 type =3D=3D PTR_TO_MAP_KEY ||
>                 type =3D=3D PTR_TO_SOCK_COMMON ||
>                 (type =3D=3D PTR_TO_BTF_ID && is_trusted_reg(reg)) ||
> -               type =3D=3D PTR_TO_MEM;
> +               type =3D=3D PTR_TO_MEM ||
> +               type =3D=3D CONST_PTR_TO_MAP;
>  }
>
>  static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg=
)
> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/=
testing/selftests/bpf/progs/verifier_unpriv.c
> index a4a5e2071604..28200f068ce5 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> @@ -619,7 +619,7 @@ __naked void pass_pointer_to_tail_call(void)
>
>  SEC("socket")
>  __description("unpriv: cmp map pointer with zero")
> -__success __failure_unpriv __msg_unpriv("R1 pointer comparison")
> +__success __success_unpriv
>  __retval(0)
>  __naked void cmp_map_pointer_with_zero(void)
>  {
> --
> 2.47.1
>

