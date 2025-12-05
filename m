Return-Path: <bpf+bounces-76193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7809CA9A9D
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 00:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64099308331E
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 23:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC1921D3E4;
	Fri,  5 Dec 2025 23:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePUovHbI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B44D8CE
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 23:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764978719; cv=none; b=WJkWfWQjk8G/SX4Lb7W8qtCr+KosYlQcGGENGAxWViUSzwgylGClstvBggka0X48fx6P3AghawlDrtD50BHezzs8Wch13GUQETSKEcsyikio/jpvihafyepHbu3S66G9nk1mbR2PnB/0IRubdIqqlFgQKL46U0NTs9dgdHCgyDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764978719; c=relaxed/simple;
	bh=tZO8aasc5wG+Dm3Yxc8n1ChZbkNdMj8doPeKvpSw2Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAEhAkfHCDRYk0LqwysSW67NgY6Sq4vn4Iu0rCl6OXNYMeJk8AfNubTfVpp/2Hy5V490t0cx9qs6uYBTNUkw8iZNMFpYFvNZIBDO5fkwZ148/osLX0eoqxPmE8Y4SsvOJl015tEliKtc53byASToDkSMsagXwtXMqGm6QgR/93M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePUovHbI; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-343774bd9b4so2298272a91.2
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 15:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764978717; x=1765583517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnLPtVxd2+m41sbS9f4ZRxQiPjW0nbgvUsIfYmsWlNQ=;
        b=ePUovHbI2XaaBpR+/03N1RkRPqGuOnW2sKSTeV9W453SbBAdZsx/ezAXbx1bDXJRsR
         eh0MfscaI2zK97RpeA0wVY/+dVRCLA1MtG8QOxfTSUL7grG5jYOSy/0L5LbKCSC888oL
         kETtr33dKhw9lQ9kuMW9TpoqkxTO5SR0pVACnfRGOVfRGdzLrqE27NEqA0G1Yx/fGdIs
         SVgyRxlbeWDNUUlpudys9WkOKITg/tBZfpWylgtz/fxBBcb6/22nOdJGPRakeRsndNkv
         zcoyU3DaID38bCEHRyyWz8uplZeOmiu8lu3gBxJ1OW+WUpRLwRZ5YjZ60dxxnh0H2aib
         iS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764978717; x=1765583517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TnLPtVxd2+m41sbS9f4ZRxQiPjW0nbgvUsIfYmsWlNQ=;
        b=L+B3VzrAAl/FJxiVyBVkT3nsX5xwk9/J53xwnGI0v7ri9s9BuZb1VrKrLDPoU1Z5kw
         WPVigmz1olmdAeAM9BW4zP4Bo2BnkUlZctKs43RukJo7qRU17pYCT1m4n/Q1o8WUjnXP
         5ewDUIs2QSCK9qaCxVVaHDb4ND4t65x7wokzBe/LjAvi6MyrZsZDbjvjrjhUr0WbrJia
         4f8wu957MwQXYokBHuDMOt7fvn87FEjFQkNGR4+vEAkhb8Zr6gvbXBmJY/unOqBR0rFD
         jlXDL4cvIMqcd8cjyujXQa8yatqbxYm8uqa4w0xmQeKkXjSQRD4zMi7yn4zEoOjw19Ns
         pmpQ==
X-Gm-Message-State: AOJu0YxNgsZvGtnXlNSM+UoGVBOsouteTMx6vPkDkASMeAyJK49kc5PT
	SHX98JQ3WO+Epvdu8FawswSjzwhjAQtmpJPwdGfKh9x6Xuh5XUPr1iMG/YgeAdq4pULSnU8JFiZ
	Ya5zGTX0lbk56SHa+ZkPUais49/davNg=
X-Gm-Gg: ASbGncts/QBCL0oDuv90qQQobNxWqhSK6SVZtimdSs8uOqc6Lz/CwmXIcSndAiewYgB
	6IiOVxIo6+UIvDtMhW/vRfM0xXF3OySr7noQJ9PCGSdI2QsfiZOkxdk0m1Worwnc9zYVCXHPJAL
	wvHALKebyRd6EUqTChjHioqzVQxq1PmUEiyjMop6v133Po+hhsp6tgWaFjsjeGMa2WgIGFrN2ht
	3CkWKK9PtW4+cALWmi51KifBZgVfsbMUV1Q3ydaEk5NYrK4S3nsNlwbkSeEB0RAAwWXXnz3NC7h
	LsncM/6AuOA=
X-Google-Smtp-Source: AGHT+IECYf5+A0DiSY2McXf+f/hz+Alv/IlpSfujai+yXydMAVIb3uJFdpjh4iKfl7B4UT9Lmv3iL86LuYbwLCm1TtE=
X-Received: by 2002:a17:90b:2750:b0:349:9dc4:fa35 with SMTP id
 98e67ed59e1d1-349a2622069mr595234a91.25.1764978716793; Fri, 05 Dec 2025
 15:51:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128002205.1167572-1-mikhail.v.gavrilov@gmail.com> <fa4ec6c228a314a9f0995f80225a4c0e4d8ac2c9.1764341791.git.mikhail.v.gavrilov@gmail.com>
In-Reply-To: <fa4ec6c228a314a9f0995f80225a4c0e4d8ac2c9.1764341791.git.mikhail.v.gavrilov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Dec 2025 15:51:44 -0800
X-Gm-Features: AWmQ_bkyv538DCFIlQho4HJ7x9k2WVJ3X4sEs1X_Ha5tTZpq4g44_00-xYmSLd8
Message-ID: <CAEf4BzYOhiddakWzVGe1CYt2GZ+a57kT4EyujhoiTQN6Mc6uLg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] tools/lib/bpf: fix -Wdiscarded-qualifiers
 under C23
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, netdev@vger.kernel.org, fweimer@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 6:59=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> glibc =E2=89=A5 2.42 (GCC 15) defaults to -std=3Dgnu23, which promotes
> -Wdiscarded-qualifiers to an error in the default hardening flags
> of Fedora Rawhide, Arch Linux, openSUSE Tumbleweed, Gentoo, etc.
>
> In C23, strstr() and strchr() return "const char *" in most cases,
> making previous implicit casts invalid.
>
> This breaks the build of tools/bpf/resolve_btfids on pristine
> upstream kernel when using GCC 15 + glibc 2.42+.
>
> Fix the three remaining instances with explicit casts.
>
> No functional changes.
>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2417601
> Suggested-by: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>
> ---
> v2:
> - Declare `res` as `const char *` =E2=80=94 never modified.
> - Keep `sym_sfx` as `char *` and cast =E2=80=94 it is advanced in the loo=
p.
> - Cast `next_path` =E2=80=94 declared as `char *` earlier in the function=
.
>   Changing it to const would require refactoring the whole function,
>   which is not justified for a tools/ file.
> ---
>  tools/lib/bpf/libbpf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index dd3b2f57082d..22ccd50e9978 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8245,7 +8245,7 @@ static int kallsyms_cb(unsigned long long sym_addr,=
 char sym_type,
>         struct bpf_object *obj =3D ctx;
>         const struct btf_type *t;
>         struct extern_desc *ext;
> -       char *res;
> +       const char *res;
>
>         res =3D strstr(sym_name, ".llvm.");
>         if (sym_type =3D=3D 'd' && res)
> @@ -11576,7 +11576,7 @@ static int avail_kallsyms_cb(unsigned long long s=
ym_addr, char sym_type,
>                  */
>                 char sym_trim[256], *psym_trim =3D sym_trim, *sym_sfx;

const char *sym_sfx; instead of unnecessary cast

>
> -               if (!(sym_sfx =3D strstr(sym_name, ".llvm.")))
> +               if (!(sym_sfx =3D (char *)strstr(sym_name, ".llvm.")))  /=
* needs mutation */
>                         return 0;
>
>                 /* psym_trim vs sym_trim dance is done to avoid pointer v=
s array
> @@ -12164,7 +12164,7 @@ static int resolve_full_path(const char *file, ch=
ar *result, size_t result_sz)
>
>                         if (s[0] =3D=3D ':')
>                                 s++;
> -                       next_path =3D strchr(s, ':');
> +                       next_path =3D (char *)strchr(s, ':');   /* declar=
ed as char * above */

same here, next_path should be const char *

pw-bot: cr


>                         seg_len =3D next_path ? next_path - s : strlen(s)=
;
>                         if (!seg_len)
>                                 continue;
> --
> 2.52.0
>

