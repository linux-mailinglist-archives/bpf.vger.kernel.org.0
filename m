Return-Path: <bpf+bounces-16607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5414A803CA9
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 19:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD7728116D
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 18:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8A82EB1E;
	Mon,  4 Dec 2023 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9i425bs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1DACA
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 10:19:19 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1975fe7befso506044466b.2
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 10:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701713958; x=1702318758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBmL8CqJL7nZ1zB9BrA4aRp1e1MzF3UvMRlbrg7ov+0=;
        b=L9i425bs0OSpDWCDmOfg12BGqT/kE3in5T1H3R6jwF93Oh3AlsR5S8lYmWHVXFiTIH
         YWjz2b+mPUaSF4AW7YfCBQ1wX4UqyRWFB1Bhhl6Q3z/ix2HDf3So5fBn+W5jTMfY6+3c
         T4Yw/sWpUb1gz55fqLswBe9aPut/mW+PZs84GpAAQ2hU5fCwhmGTMQzBC2zkT/CbWeoL
         SsF3V19Bl56ORcRjSFtDoVuKuBu116ucaa1GA44XBmlHUZBSnSUu+HkPyxXLamSLwBft
         a6uizwt6DYFTofYdrtb25uYp+Rj986zX+DXrMRr0weDvojG86nnTEdRucdksGjUm38aF
         tR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701713958; x=1702318758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBmL8CqJL7nZ1zB9BrA4aRp1e1MzF3UvMRlbrg7ov+0=;
        b=ULpswzgubWsBtvi3OBlr2M01jUxNi6Of34s/DZqexi0gnFYiUMPIpBTbpseCHeQuVG
         psTP7NMsmwfgJjPExfOBmkPsLCjZ3Lqy20dijKOB5tUVsHXCBakziUTWL3kzP2aQCE/C
         /4IqyB183cAwaEI42YBxz+bgxLsqDwj90DkDHCRgYDPldhc8ZaV6UyWs+A4YyxK+IrtD
         q2Cc0ualIcQFMZc5VbI7Vg/Bm4/VaZMxS5V84MpHN/OW3/8KgXsFtNjeBWeks/nFCJ3R
         cuynSdS4ScHB1HyK0Y5Fbh2YNuVdztpH8O8cw7HH9w+5eeTVjfTgWHDT1xCVUKYhBMRh
         8A3g==
X-Gm-Message-State: AOJu0YzN+MT6Zik2zWRCaOWj5+oNBpp+YuDEL8lDhbEh1wNcSnLWvAt9
	hbC+oD8XCIpZO63KNWuSEH8wjLcgFOQ0Y6uU47AP4dVV
X-Google-Smtp-Source: AGHT+IEQ3sumgUfYmir21XqaybNFFQU/bF0YgGonHo83/p96pw4Hv4/tHU+MMeRqapTdyIdXqcZFcTiMIVE0gLMDur8=
X-Received: by 2002:a17:906:51d1:b0:a17:3087:b976 with SMTP id
 v17-20020a17090651d100b00a173087b976mr748803ejk.6.1701713958233; Mon, 04 Dec
 2023 10:19:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231202230558.1648708-1-andreimatei1@gmail.com> <20231202230558.1648708-4-andreimatei1@gmail.com>
In-Reply-To: <20231202230558.1648708-4-andreimatei1@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Dec 2023 10:19:06 -0800
Message-ID: <CAEf4BzbT-UBaigkGeimFOTUqadVMbUFJJ7g2gfR-Au3xxHd6Yg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 3/3] bpf: minor cleanup around stack bounds
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com, eddyz87@gmail.com, 
	kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 2, 2023 at 3:07=E2=80=AFPM Andrei Matei <andreimatei1@gmail.com=
> wrote:
>
> Push the rounding up of stack offsets into the function responsible for
> growing the stack, rather than relying on all the callers to do it.
> Uncertainty about whether the callers did it or not tripped up people in
> a previous review.
> ---
>  kernel/bpf/verifier.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bdef4e981dc0..5417c5ad3d88 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1690,6 +1690,9 @@ static int resize_reference_state(struct bpf_func_s=
tate *state, size_t n)
>   */
>  static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_fun=
c_state *state, int size)
>  {
> +       // The stack size is always a multiple of BPF_REG_SIZE.

let's not use C++-style comments

> +       size =3D round_up(size, BPF_REG_SIZE);
> +

C89 style doesn't allow variable declarations intermixed with code, so
you'll have to do this after declaring variables


>         size_t old_n =3D state->allocated_stack / BPF_REG_SIZE, n =3D siz=
e / BPF_REG_SIZE;
>
>         if (old_n >=3D n)
> @@ -6828,7 +6831,10 @@ static int check_stack_access_within_bounds(
>                 return err;
>         }
>
> -       return grow_stack_state(env, state, round_up(-min_off, BPF_REG_SI=
ZE));
> +       /* Note that there is no stack access with offset zero, so the ne=
eded stack
> +        * size is -min_off, not -min_off+1.
> +        */
> +       return grow_stack_state(env, state, -min_off /* size */);

hmm.. there is still a grow_stack_state() call in
check_stack_write_fixed_off(), right? Which is not necessary because
we do check_stack_access_within_bounds() before that one. Can you drop
it as part of patch #2?


>  }
>
>  /* check whether memory at (regno + off) is accessible for t =3D (read |=
 write)
> --
> 2.40.1
>

