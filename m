Return-Path: <bpf+bounces-61300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813DCAE4AFA
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 18:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181743B91CA
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA83129B781;
	Mon, 23 Jun 2025 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXcw2UMQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BDF28E607;
	Mon, 23 Jun 2025 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696018; cv=none; b=MGKJGu9O05GDqvONoxEgZNHXDPrLLksKSIjrUs/VBugHBt9FzJXsODktWkDxd9tFnCruCOi1240AJ0NkXGcf3y0491w15KWhpQT90jpPVQuaDWdyHk6L7Rr2kt+finXjEwdi1hZQk8qFzXG6qeiDBAwcGCTsqXuHZc+dbZkNVBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696018; c=relaxed/simple;
	bh=Y6SzHtj22EyMMF6v55IM7BONRXybPUbVypRpur/aCy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ts8utpPB73vCvlbhvZfWHLbEQrDTAXxK2dt0ltxEhzEmnctdPsUUFrdfTVlMBUTh/GGiwi4Js9bWFQU5zfd/G/V6oddr9og+Ke/Y/n5EFxMBTjwWFzQAtdX8TPdYPCkgCCegtJXUVuUkYRM8PyECOg1BuimKRPFWcy8mmx7/QdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXcw2UMQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4535fbe0299so23228415e9.3;
        Mon, 23 Jun 2025 09:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750696015; x=1751300815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSDtoA+3CYJQ9s5hNpx567tpNF7qKvZSoZnmnOpBoHs=;
        b=jXcw2UMQbPKr7BquXVVE21b6X41/M/todPAiNCv05KwtmYPtGdVs8rBbKmraN3jyui
         G/SgDmNYJmu667Tmdi9x1/ZyszJJV3mm84elXaV7V71idP1cpSHk1uo+TpPVOAP8Ef6K
         6HI9YeFM840gy0VCttMgVelyeq5NXVsfvi3vTa8REfuXlLbaTdDnup0ihiHDhvNDTsUX
         zdSQzBGlyj08XiTSQHkH6gDY5Ot/3uOun/Sp2VYm6HMqVO+PLx+5nukXXlZDLNpy6OUH
         VCHM+RfOCw0V6k/hB6rmBAwh0aVXeYYn0+jY1JvpP8V9JuasXV0vOusSlFgzRRtMsfVR
         IJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750696015; x=1751300815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSDtoA+3CYJQ9s5hNpx567tpNF7qKvZSoZnmnOpBoHs=;
        b=DwX0MEbRxK7VNd/OsdaM8QYM8FpsibzKEk4DZqth8zNstLovcDn7C5pfwMvIdjJ79m
         vcv61T433j+T5C8/JsqeIrzmJ3KAgXhFZU5DClQGLw7pu/hKe+keVUv2ckiuE9qxl04f
         ZWjyohF7El/dHXR4c1z6x0gswjS2MuxS023zIUCWHP+2JJeYv4TglC74yebfKoNswwbw
         ixktPuVVJPUUfxOi38eFR35RDlL3vmNh+sFiID0+odUba/j2oPnkphegvCF9rzcG5Bl9
         KmPwkGGzGn7xetN84my4KfqdgT3R4YfcaraEjpHGp/eYby7Gjufxn2wE/IO0oTlpUVE0
         ba7g==
X-Forwarded-Encrypted: i=1; AJvYcCU0KOjm3ZCyg8bW0KZXH8aGgr1iR05JlFNUrm2ZB6JfgOfYizJOy55w1Q9b+pikkMTn8pM=@vger.kernel.org, AJvYcCVwcNbzwDobViKBE0iLMi0XnKqjw+DeJy5YFyrwA5bNY2XqjftBx5vcYP8DKQvsRcML+X6zKOgtWqjkxHiI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ofZsjRUI1TxNoNYFyrhwDH3X6sXJBxDslFLQx527yWQeU+c6
	EpsAx5g6JtkOqacDXbXY8EgOOFuh0M2+GBlggw1PzF64nYRWlaU8juUoBJCa7aLc0OSfGQauKmO
	bMisPfaZFB6oXfzqHN6FEKQ81LySKnWk=
X-Gm-Gg: ASbGncvUI9v7Jdas+ix911E0Vk8kvszddq0RIUF+ClUPHZwdbCcJ4j2OSA0NXUm1x7H
	xyZtDs1lyiip8GgxKbgScGjo+I2shaI+7Pws0FTj5KLjczN2IUKD4UvPbE/ksq6e546MSSQtog4
	s24rEzOt5HaiY0JbWbqy3dG5T6jxfB+E5LUipRw4UmCDr9T3NrjIG7jlC3wMdGffndvAPUcw==
X-Google-Smtp-Source: AGHT+IGbrt6ZJ+UP+PNSqfWiWRPF0qzGEANYAlCONftPVh2oCHKU0PtQcpCabpvjSirIY4iHkuKjyEg2cgZvT7L9ZuI=
X-Received: by 2002:a05:600c:81c8:b0:441:d4e8:76cd with SMTP id
 5b1f17b1804b1-453659f6a8cmr128124955e9.29.1750696014331; Mon, 23 Jun 2025
 09:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621045501.101187-1-dongml2@chinatelecom.cn>
In-Reply-To: <20250621045501.101187-1-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Jun 2025 09:26:42 -0700
X-Gm-Features: Ac12FXwNQwTXTebPScXO5Y5esR9EWCRME1zD8mdwelhzYSda5beKDZc9-HxJRcU
Message-ID: <CAADnVQLz7-tVmJ7C3VdNDcL8y07Vyg5Ad+DhKAQ7odQAo_BO=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: make update_prog_stats always_inline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 9:57=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> The function update_prog_stats() will be called in the bpf trampoline.
> In most cases, it will be optimized by the compiler by making it inline.
> However, we can't rely on the compiler all the time, and just make it
> __always_inline to reduce the possible overhead.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v2:
> - split out __update_prog_stats() and make update_prog_stats()
>   __always_inline, as Alexei's advice
> ---
>  kernel/bpf/trampoline.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index c4b1a98ff726..1f92246117eb 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -911,18 +911,16 @@ static u64 notrace __bpf_prog_enter_recur(struct bp=
f_prog *prog, struct bpf_tram
>         return bpf_prog_start_time();
>  }
>
> -static void notrace update_prog_stats(struct bpf_prog *prog,
> -                                     u64 start)
> +static void notrace __update_prog_stats(struct bpf_prog *prog, u64 start=
)
>  {
>         struct bpf_prog_stats *stats;
>
> -       if (static_branch_unlikely(&bpf_stats_enabled_key) &&
> -           /* static_key could be enabled in __bpf_prog_enter*
> -            * and disabled in __bpf_prog_exit*.
> -            * And vice versa.
> -            * Hence check that 'start' is valid.
> -            */
> -           start > NO_START_TIME) {
> +       /* static_key could be enabled in __bpf_prog_enter*
> +        * and disabled in __bpf_prog_exit*.
> +        * And vice versa.
> +        * Hence check that 'start' is valid.
> +        */


Instead of old networking style I reformatted above to normal
kernel style comment.

> +       if (start > NO_START_TIME) {

and refactored it to <=3D and removed extra indent in below.
while applying.

