Return-Path: <bpf+bounces-70669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D6DBC9D35
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 17:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB4613500FA
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 15:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF142153D2;
	Thu,  9 Oct 2025 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+HXYPVN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD351EF38E
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024324; cv=none; b=Y6ikB5EA2V/0J0rT0vc3Tu//Mkck7E3BupLnLPa6vpyK0e3kDzpqWd+y4eYQewrcXaYXsEtYf+M1cxEG0MjbBMV5p+PrXUq90EVyVADblLJUX2P/SXc5cUPhNthO6wi0W/omm7wnRu4Wdoic6Jq8MkiOHLS076UfF2+++LiVELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024324; c=relaxed/simple;
	bh=z7Ea42APZZ2MsKzMNHUw5tv/fNDz5o3iaIrDzYK/1yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCbbOmrgeSODmLzUG4x5Hc9VXsU8FCmOd0OrYCx1tvOud5X/fh+oWmBDZYL0D+HufHpuoiKZxOpURdk7eBIqIGrE0P78BoLH2mZqdacmprTTnxbQuUia6fk5FS15Awd1glddLoSOap4Ah/YV1PS7z/BD2xdSXG5StS8Rfn6stBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+HXYPVN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so7970745e9.1
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760024321; x=1760629121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQkxYFoW3fhngqbDfc7FB4prxB/MP3/9y4tccx7Eb9g=;
        b=O+HXYPVN9SvN2fTQVzIPaulOZ9CQoHxoUCyr0db+DRN4+4x4Md18h3/qOd01aYQKxw
         vF1oZN0D+OAwRCvQCveGmHKtSgUQ5leHSsf1MofbWE1hgs0xjsFKaZ4LLs/+jE4Vzo0B
         FWuddK8KVxRv+QpOFWMu5UqAIObB8VN4Qu/ES9sYPm8MBw0sbKL8kyjdKgIZHMmmxcmM
         R2rdd5wEnTS0DqrDKAqVcLnrnxWwdvx1FrXFytXSU/d4ZLrbcEag0Ops5jrQCPynKn1L
         z4lCH2kNHAT4BK8kPhSuL15Bh53t5szqG1H4OftIXsFIwjEf1Fedvx1Gokv3Mo4AhYu1
         qEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760024321; x=1760629121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQkxYFoW3fhngqbDfc7FB4prxB/MP3/9y4tccx7Eb9g=;
        b=T8oQS2Sso2+Ns15wvBAbgEeBv2NQlVkvXVDfiPY87imlUNze+xCTenIXfp+j2uHLUO
         atAGRorOtkrpv3o7ZeHZtldp9yvNyFzLAizyFrHIJl7JXFGL/8dcwbbmG6zi4x0HeCEE
         uc184D9KY6YLF4atpqGgBEl5zDyjioFSHEyu8olfFOQVlEotQsyBlkSUstzx6SbvEAj7
         zBVGL/YMOxyEgXo+3HNIMXXDLLnoAWsn1wzIrkDX5yTIv1vtwtROJocUAD2ih4ptim+T
         7VQu0w8LyjrLF6FRHOuLnETX9M90lQIYOlnoZaTXgMC7HLSTtDtqlfGfpwzBCcjHa8zo
         6aag==
X-Forwarded-Encrypted: i=1; AJvYcCUFcEQ1acWRSaXQUuT/lfLeef+DJ4gs5dJ8YI4DjtrLqGkFjQvADbZ9GRh08qvZxwobTU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpY4TfgXJNjeeu1lKFWYxWEBPflHfNcDj0dlnkGMreJ4Tbgx8z
	PJrTu+jpbzTqe5NbTfBq7TQ+SY634YlZ/k/qxrL/g3/VHilqWSWEgctHk/Ek8Rm//vevSLD2p8t
	W5wHKjIkbeSoX4b17+5Mdm5uioA6ENVg=
X-Gm-Gg: ASbGncuW5iMSuLMDMZ3tEnMBYNQDU6f22bgBOTBH3VBn3am/KkGBOAAvmpBWoHZqIbD
	YNKxEzCpAmk+aedAYyr2aQGPM0YERAX2WdmyoBt8OtFcK27T8KHrSMl/Np1DgO5YwEp57I8+WGF
	Psp5ZvlqeCG6e3adXSq9zUSlgKD81bUtFA0JQWIAcaRBDF42593xOofOCf1yQPxFkB31ueMhsXM
	kH7ywkTVlHOr7NX8Hyr1d88812I0mnOrXemi9EYbbasJqHZbjCQVxQ7fXCl4OQ/
X-Google-Smtp-Source: AGHT+IGgrqYYOGBGtMKaRbrc/kVHY5g2aEmz2TaX4Ez0CcvauPu8X0DUtsfzwWEzS+JPm41ng44Mvzj/hW7vj8aqNdg=
X-Received: by 2002:a05:600c:608d:b0:46e:6d5f:f59 with SMTP id
 5b1f17b1804b1-46fa9a8b2aemr50381095e9.4.1760024321223; Thu, 09 Oct 2025
 08:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009062330.26436-1-chensong_2000@189.cn>
In-Reply-To: <20251009062330.26436-1-chensong_2000@189.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Oct 2025 08:38:28 -0700
X-Gm-Features: AS18NWDLz_Sock_v4Ibb74lme2e9ww0rt5f8tkGNzURm2GEz_dE_DJlg716IyM0
Message-ID: <CAADnVQL=FSax6b1qOG5G=9Lz-FScQWHAS=YZ+=b86Skvyeqing@mail.gmail.com>
Subject: Re: [PATCH] kernel/bpf/syscall: use IS_FD_HASH in bpf_map_update_value
To: chensong_2000@189.cn
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 11:23=E2=80=AFPM <chensong_2000@189.cn> wrote:
>
> From: Song Chen <chensong_2000@189.cn>
>
> If IS_FD_HASH is defined on the top of the file, then use it to replace
> "map->map_type =3D=3D BPF_MAP_TYPE_HASH_OF_MAPS".
>
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---
>  kernel/bpf/syscall.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0fbfa8532c39..2c194a73aeda 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -154,8 +154,7 @@ static void maybe_wait_bpf_programs(struct bpf_map *m=
ap)
>          * time can be very long and userspace may think it will hang for=
ever,
>          * so don't handle sleepable BPF programs now.
>          */
> -       if (map->map_type =3D=3D BPF_MAP_TYPE_HASH_OF_MAPS ||
> -           map->map_type =3D=3D BPF_MAP_TYPE_ARRAY_OF_MAPS)
> +       if (IS_FD_HASH(map) || map->map_type =3D=3D BPF_MAP_TYPE_ARRAY_OF=
_MAPS)
>                 synchronize_rcu();
>  }
>
> @@ -274,7 +273,7 @@ static int bpf_map_update_value(struct bpf_map *map, =
struct file *map_file,
>         } else if (IS_FD_ARRAY(map)) {
>                 err =3D bpf_fd_array_map_update_elem(map, map_file, key, =
value,
>                                                    flags);
> -       } else if (map->map_type =3D=3D BPF_MAP_TYPE_HASH_OF_MAPS) {
> +       } else if (/(map)) {

Let's not. It only obfuscates the code in this case.

pw-bot: cr

