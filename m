Return-Path: <bpf+bounces-19512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E032482CEEB
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 23:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F7F1F22034
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 22:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D60ED297;
	Sat, 13 Jan 2024 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Owi53i4v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229E36AC0
	for <bpf@vger.kernel.org>; Sat, 13 Jan 2024 22:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-336755f1688so6544560f8f.0
        for <bpf@vger.kernel.org>; Sat, 13 Jan 2024 14:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705185590; x=1705790390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIxBCHWzf3xTjk6Mm5zY6H9naRAle6Hltd88KP5Giow=;
        b=Owi53i4vN4KmgWSgFGpJsZShhCtZ3ubLJbNZot7hlP+B9SkWbOlI5oqlpehLO8N5Ra
         Arz98UnrYXRmhxZlJmzpI/F+dWlLWBc7Mqcw4nOjR1NSjZUYBG2qU4iiu/i8ayAn/H6H
         FR6d3K7+r2bnli75qews2mQ8/4PuOzDDDEFqOrHOIMkt+sieykr1l7EZj+3QIL9nFrNY
         tEsmEHwtPAslVIa1fmQ2hlYp3Z15PAKKloia0qA82VrYvn+xFyJTFeHf6ujy6r8Yt9qh
         zKWlWJOh5PozwK26+v0XdZTdgnKV82J+CJiVmJXustR37D0KM6KMI3pokS8obEcs9lXh
         8U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705185590; x=1705790390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIxBCHWzf3xTjk6Mm5zY6H9naRAle6Hltd88KP5Giow=;
        b=NTsPsaPZAa4ZhpfqfM9Bhl4DtYKGJ6cJUFuLIYBL4kdTv+lJqlG02vx7DS544MCyqN
         9N3As1wvE1tOpML5crkCamYvheFE3PAUzcaZjHfvjPMdiQg3Qkx80TUFSvSEZ9cxEPrt
         S6omBMh6WyV6XKEsBEUy1OJKtvkFeNZTMKl7MODuDqTHGihf10U2AKzoQ4aMiFM53NaV
         or7HPTBdHVjC3wo+bTHnl/71xABsaULSoKasE9643ERsdUeVQhC4rQwBebIOl+j5lKkY
         9hd4FCDl5zyGnKcoTCUg3GAfbmwXzPkMwPSmZDyyfJZzK+xAtBDsFdHo3607oFNkGmca
         dkug==
X-Gm-Message-State: AOJu0YyhO4j+SP+ozJdHvySd2VibMC7gH+4/eq6CCf+8DAVVcC8aIUOf
	URMYj0nggkdq9OAWYyvH8aGBaEQ32+AJocXiFyI=
X-Google-Smtp-Source: AGHT+IEz2etVQnbEAlcDX2HIQjsCCNbbLY99Bk39ThZvj6IyUAAJK096p2k9pFGor4hdie4+DDmPBhIn7oaNApxKPfE=
X-Received: by 2002:a5d:6dcd:0:b0:337:70c5:8fcc with SMTP id
 d13-20020a5d6dcd000000b0033770c58fccmr1766540wrz.116.1705185590069; Sat, 13
 Jan 2024 14:39:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111052136.3440417-1-yonghong.song@linux.dev>
In-Reply-To: <20240111052136.3440417-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 13 Jan 2024 14:39:38 -0800
Message-ID: <CAADnVQL9djzwkJ9k053ZA6Ck_K47eKsfAgmtEU-d9r-OBtG=Zg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: Fix an incorrect statement in verifier.rst
To: Yonghong Song <yonghong.song@linux.dev>, Eddy Z <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 9:21=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> In verifier.rst, I found an incorrect statement (maybe a typo) in section
> 'Liveness marks tracking'. Basically, the wrong register is attributed
> to have a read mark. This may confuse the user.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  Documentation/bpf/verifier.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.=
rst
> index f0ec19db301c..356894399fbf 100644
> --- a/Documentation/bpf/verifier.rst
> +++ b/Documentation/bpf/verifier.rst
> @@ -562,7 +562,7 @@ works::
>    * ``checkpoint[0].r1`` is marked as read;
>
>  * At instruction #5 exit is reached and ``checkpoint[0]`` can now be pro=
cessed
> -  by ``clean_live_states()``. After this processing ``checkpoint[0].r0``=
 has a
> +  by ``clean_live_states()``. After this processing ``checkpoint[0].r1``=
 has a
>    read mark and all other registers and stack slots are marked as ``NOT_=
INIT``
>    or ``STACK_INVALID``

The typo fix looks correct to me.

Eduard,
since you're the author of this line. Pls double check.

