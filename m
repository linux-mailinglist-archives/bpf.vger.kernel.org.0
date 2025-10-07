Return-Path: <bpf+bounces-70491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E396ABC0224
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 06:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4043AA0E2
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 04:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E3B20FAAB;
	Tue,  7 Oct 2025 04:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhTqT8nk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFE21E1E12
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 04:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759810143; cv=none; b=UoB64iAxDiMIFa3PXHnjKPcEXNpCp/aT8srDzmoOKQXU+yQWlRRzOJ21Us2WQ0yVT7OoDDZsMceQKsVw8bZKYSRT7eCNM+hNjRuOnOfr3ruaEa8/YlVPYxl1iDsHSdfXr0symAbWzGjb7hLQ6pXULXaUTG2LEohfVpStgYoiPaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759810143; c=relaxed/simple;
	bh=432QvHvOj19tKWGrDdk4erAr4nKhVAMEK3WbFkC/IRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMOTvSQNizZQxwvvAu95WLWKyyUkxh8QhGb9gVLpxmgxlzpcp0WNPwAVUJKiywyVkMzTvD/Pf3eJo00fzV/b5C3aDn72jrsyr4VFu3ZxEOEeOChW9G5UiHUX1niOUEvSN755n4Jg8cmc6Dk5fR9MPHRNvgFqNkOL5LX4HbCKRAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhTqT8nk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so53618925e9.0
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 21:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759810140; x=1760414940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wK04lQWKr2DjWtJceprl3zo5tRNApv5guaFqKP5j6NI=;
        b=YhTqT8nk2g/L01i/OaUJ8+4bKkVsbeTIxroy6/QXn6yXZjlnyHFktbGs3ef6/FXWAz
         f1G6wiirRsDMVVyVhqUyIoXvJXp/7wHif4GPFxJDe+V4Qn2tCkBjyR09EZuN4XTh0a7n
         vLfCIWmVU36f0XTWlKoai9+jIwwNse36wv+2K9421mSjoTx0b2dNYk9H3LQfc+V2wK2R
         iwegy6d4dZGBMP5E7m52Ec4MdNIGKtsEklg5Hg2D0KOLKqEpWGkQG+TuuMfCLtklhcdW
         IurDnPcR8AsaeRaPnuSlaa2v+yudDtoo6AA/Nn8hi3Ur7FLzlBajTC4sZP6x6LQriJOJ
         MBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759810140; x=1760414940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK04lQWKr2DjWtJceprl3zo5tRNApv5guaFqKP5j6NI=;
        b=tQqd83jbcBXW+5nOm/Syj+XQm7qwwuysCBbhStmC7jdxrfk5RzyEC/W/BFwKP2kw8M
         k1ftfxpI+3lhS7qLyBRT8BBSpsIdcc0kOowfG16AFhX3yaWUyCPl3GJIiz5ck5MyPIDG
         8swUnF1sSVWSe0WUX7eIhyzWTrjwFDVzOcd03YrvSUwMgN1um4c1RabVlj9+IVFj2OPp
         MahxbOHfKxBg9o/LNWb/4PCO0ZpiLCOIVu/toR2qK/XkT/P0GtlV3imBHS/f000Ik/sC
         sZkEywdVxbDKPbg2emHY+E48EC5fWcmDqsIYaxf1m6Mz1mKcjIGw39yH/v677jy+R1Ya
         fprQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXbnF4WiQOTCYTawGjYrYSUNv8iMWKBMil0+KpLtmBXPRGzUCK64x2ElkRYirb/7s2tJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrcSKHL6CRQzMUU4C9iCRSQWiYwjlFlvg5nkgA7btMmIu8DxtL
	0AwdEvsQpJNa+k76Q5d35Yw0KZyLgbw6Qc68oDshyKXyZWGw4Jlo7nKFCrZdjgMV6/6ZT/my4/i
	CqmU2jYn5TbnC0PDkHcAAiUTbHEAFkXQ=
X-Gm-Gg: ASbGncsyDRxbs9qtUiKE/DoAsEBZziRdX7dM8kLY+3NVx3nDFJaWhkdjY3MuT1ySPEZ
	8qTTpPP3czn8Odd+6mAzTurV+9JwnpuuFQ2ZQGG9PUeFYDvko5OR42OGry7E2iXDEDk7fDCnpBs
	TxfC6RU6+dJHs2Y2SUxXb/wkRgnyCTqNfACYvQCTjV2lA13kbUfkn07nk7TIxRbpriLhvujYlrp
	5uj06lLnxQ01s0D2YKavKC8MaPumcsnXA3kggAcBdHskzICvEjSoQNl3S0LOlEeAWuDsGUKlQ==
X-Google-Smtp-Source: AGHT+IHYHh6bEmYuCmFai3v43g5P6gr1pDPCY9ygDD4iuTvWaHhchyjoP1nQ92EQruT44rG7ohu+X4LwmhENyChZTvU=
X-Received: by 2002:a05:600c:4e94:b0:46e:394b:4991 with SMTP id
 5b1f17b1804b1-46e71105457mr96964855e9.11.1759810140454; Mon, 06 Oct 2025
 21:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759804822.git.rongtao@cestc.cn> <tencent_6E59062E4249590597452A06AFCDA3098808@qq.com>
In-Reply-To: <tencent_6E59062E4249590597452A06AFCDA3098808@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Oct 2025 21:08:49 -0700
X-Gm-Features: AS18NWBUCpOWw8ZMVB20Bk2k82iz0iF-_IQG_RoaZfjQrcbZ-AoUhVqW_uV4EFY
Message-ID: <CAADnVQJFBR5ecewWdDhTqyXTMWH_QVEPCm2PXxV_3j1wa+tWMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_strcasestr,bpf_strncasestr kfuncs
To: Rong Tao <rtoax@foxmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 8:00=E2=80=AFPM Rong Tao <rtoax@foxmail.com> wrote:
>
> +/**
> + * bpf_strnstr - Find the first substring in a length-limited string, ig=
noring
> + *               the case of the characters
> + * @s1__ign: The string to be searched
> + * @s2__ign: The string to search for
> + * @len: the maximum number of characters to search
> + *
> + * Return:
> + * * >=3D0      - Index of the first character of the first occurrence o=
f @s2__ign
> + *              within the first @len characters of @s1__ign
> + * * %-ENOENT - @s2__ign not found in the first @len characters of @s1__=
ign
> + * * %-EFAULT - Cannot read one of the strings
> + * * %-E2BIG  - One of the strings is too large
> + * * %-ERANGE - One of the strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strncasestr(const char *s1__ign, const char *s2__ign=
,
> +                                                               size_t le=
n)

See AI review for the above part.

pw-bot: cr

