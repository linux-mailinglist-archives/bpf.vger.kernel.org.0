Return-Path: <bpf+bounces-76782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F9ECC55A2
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 23:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AB6B30220D8
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C20322B62;
	Tue, 16 Dec 2025 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAsr90Ik"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B8430CDA9
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765924278; cv=none; b=ZR5of6SI+raLgFDG1Kmo8vA7UEPfXlMrutBkpoDsQvbhQsThw178UV8dyOvkypofO6b5JIiL6gGbV9bGianMGo6fBq45nbwV4W+NZ8TeHIp3mq45hGMxO2r0bmj7xWUNXffH98moKZYRt9G/OPq24D9u1BLKixEGRg53cXb+PU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765924278; c=relaxed/simple;
	bh=YNOaFx0sUqETGrczST3FjVoXaKzhv/pBaeREXK99zCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZkhfgdr+Tf4/HCH7VodqEh7Qy8PZR+6W2ESp4BREOBxT61VZIGGtv3Ad9Su3NUc+mw+U/1nTt7721307bi0ablBSoqrN7KxQDAMr3o6D5GsfaIKnCjsIj0HJQTCgKqcXbiH0AEM0qxoewO0qjoOgmyRwtPrCKD1boT2olOcPW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAsr90Ik; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34ccdcbe520so808270a91.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 14:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765924276; x=1766529076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBOhlmTepRkSDTIK9qj9a3Ov2dMmAx6ux3xIpuKjrHI=;
        b=lAsr90Ik6MlmwzUsAlZ9vkOamnUYAP80FTKLotkvviosFoCkL3m/5oJId0/vQip4Xy
         VetUhB0HHqfVLPJYkCSDsEAroNHytpkyD/4tpx9roaa0msTENWBwZNRwP2a0v/+b2O0x
         nJTX8IMW3zCPyX9OKRn3ghnspZuseskihn4215J0rZoEThKHrGRERys9FLecdXNOIeha
         30b/drjPrbiIqGRzmQw1VjL677f+TTEsEI3g6m/Sc6p5eg01a70awGmdIpBNjRRQarbp
         f+3caCM1C41g4/APZd4w3vBAGLK8hi6TDiuaDhTFT62hbBOcyqWrbq7CKecLGkf5vuC+
         9YiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765924276; x=1766529076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TBOhlmTepRkSDTIK9qj9a3Ov2dMmAx6ux3xIpuKjrHI=;
        b=fAaG3JWXehzAhKE8R8kDFtXQYA7x5O2MybBote32xpadun3gQk9YW74biD4HXHI9wb
         4Oi4rH4I5j07rXlJRUPFWQJ6LQavbLbTl7FrvVLXYLwKpJwqYeDay8jqX+YsbwCYXDcx
         1jAm2KK2xNuO0WSgYxUKreqy/fzFxoHkrS2ZvXaR3XHg1M+ovVJCWGon4CBjcQwOjUsc
         P3zixST8luvjizv9tPGA4BEss2RWSmqpXc8cORVqzb+xEbKp6Zsd0sC9KQvh4KY9KRQU
         oo3nYFHQD9S1xm12MnmGLGCzV7vy0TshABy3Y2cug5POnBRWIqgj8ArOm5GJUszFEk7a
         S7yA==
X-Gm-Message-State: AOJu0YxBly6LTUrcEBNkUupV4EW12Ov73ts4axz+pHOnt9W+2cCrGo2m
	GOp4rQH06K+5zyp7rm0q+ODENCQXj3kD1A66Lqg/M98l4Wr8zCjbeRLQowsrLaatRYxLC+rN/BO
	vGRWfcZL0F5fS9SmEACfeg38JUp9Ipyw=
X-Gm-Gg: AY/fxX6SAkjLQ8k/QMrHV2yFtfimuFK4vMqpFF9X4xRRirBzKC7hanRQfHhWsOOdn4+
	4ttNesfg2kJqq2GopeFyoCZmxCJ3p/32cDDJ43UUQD9Hrl7c4834O5X8txi+6Ez9FT/V/WCo/27
	lKaEcVrDI/gLMTcPiKc/P2e5uBn9v8UepD8tDj28tC0lxLN17qXgYTvqU6LvcYdmkCInX+KGkX9
	zfyum/JpgmlXIUYqHIAQkCgSMmmzTcUNWVGqttCikLk4t+yKnpBgeN4TRZ0rbrsHqyezqkSTAep
	TXfilUC0Hdg=
X-Google-Smtp-Source: AGHT+IG6GiSGktmdXX1SUif7WMe00N0PoxDFcQ8/vAaU42SN7ddp/FYw+185ZMWGh0HTU6PABDZKKCSKnVCAZzBw3io=
X-Received: by 2002:a17:90b:4c4d:b0:34c:2f01:2262 with SMTP id
 98e67ed59e1d1-34c2f0122bamr11964118a91.3.1765924275710; Tue, 16 Dec 2025
 14:31:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216222743.284378-1-emil@etsalapatis.com>
In-Reply-To: <20251216222743.284378-1-emil@etsalapatis.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 14:31:03 -0800
X-Gm-Features: AQt7F2oN3mVsd0bbG6UV4civhBZSRBXuoPzlL7dw7R8CdykMscSCA_BCk0LnRIY
Message-ID: <CAEf4BzaV-5kONdY-RK-4WE_tcVPHKj54QWstQLsxLJ_Mn+XGpQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: constify string pointers assigned to from str* functions
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, yonghong.song@linux.dev, 
	eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 2:28=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> For recent LLVM versions (e.g,. 4ed494e7282c3b36a35b8e0930fd2e14b7038167)
> compiling libbpf fails because it triggers -Werror=3Ddiscarded-qualifiers=
.
> Constify the stack char * variables used to store the pointers returned
> from strstr() and strchr() to fix this.
>
> No functional changes.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  tools/lib/bpf/libbpf.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>

the fix is already in bpf/master as

d70f79fef658 ("libbpf: Fix -Wdiscarded-qualifiers under C23")

Github version of libbpf has this already synced.

pw-bot: cr


> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6fba879492a8..1a52d818a76c 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8490,7 +8490,7 @@ static int kallsyms_cb(unsigned long long sym_addr,=
 char sym_type,
>         struct bpf_object *obj =3D ctx;
>         const struct btf_type *t;
>         struct extern_desc *ext;
> -       char *res;
> +       const char *res;
>
>         res =3D strstr(sym_name, ".llvm.");
>         if (sym_type =3D=3D 'd' && res)
> @@ -11824,7 +11824,8 @@ static int avail_kallsyms_cb(unsigned long long s=
ym_addr, char sym_type,
>                  *
>                  *   [0] fb6a421fb615 ("kallsyms: Match symbols exactly w=
ith CONFIG_LTO_CLANG")
>                  */
> -               char sym_trim[256], *psym_trim =3D sym_trim, *sym_sfx;
> +               char sym_trim[256], *psym_trim =3D sym_trim;
> +               const char *sym_sfx;
>
>                 if (!(sym_sfx =3D strstr(sym_name, ".llvm.")))
>                         return 0;
> @@ -12407,7 +12408,7 @@ static int resolve_full_path(const char *file, ch=
ar *result, size_t result_sz)
>                 if (!search_paths[i])
>                         continue;
>                 for (s =3D search_paths[i]; s !=3D NULL; s =3D strchr(s, =
':')) {
> -                       char *next_path;
> +                       const char *next_path;
>                         int seg_len;
>
>                         if (s[0] =3D=3D ':')
> --
> 2.49.0
>

