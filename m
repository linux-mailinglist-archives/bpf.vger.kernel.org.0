Return-Path: <bpf+bounces-17418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2500780D2C0
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 17:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9994281A4B
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DEF48CEB;
	Mon, 11 Dec 2023 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEPbbDbg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC7F8E
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 08:51:11 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-334af3b3ddfso4467670f8f.3
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 08:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702313470; x=1702918270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PezGjfWJWomYjjk0qIhamzqzT2GeU2Wd8N0w76gZiws=;
        b=jEPbbDbgT9WqCaSmNDd3o2etf1ZliGwyu1N4/Kl939LSd4gdBV+yoj9s8iT6+VaKgx
         JbBnX/4GFeiqH/hBlq2Cd+Va2DAc0shc3NK0T8qxfQ91btJU8P/INhgQG+VXDnd53GoO
         c4l7KNoHeQmHid9SPU3NMlQVrAanYUj02vpaFc0HOhEv+g4xGzygpxR8xsOnsRMVLc/H
         lmmlJjHIDjropCvUOgM/UP4TvGoQPUWZ46O1dMH9hDa9qK7O1t9yJ+ny+sye2EbizTvG
         eVquvzastKjPIE881PegERsgITnynOfy4SVrLz7xFO9lwKW5xhgQKOON136nxIIyTEh7
         IQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702313470; x=1702918270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PezGjfWJWomYjjk0qIhamzqzT2GeU2Wd8N0w76gZiws=;
        b=B0d8hqam2ZlkYJU9q6aG9GDd57iIVi8HIbbzPlFc4TemcE/uQXImG1dp0DJFQRNYFC
         j+gge6j/EYDF4LMvLDQ6LA/fIqUlqJlYqN9FBWVtDJGei+1mj1fGRg6beIx9G7XukMvQ
         UWScREhGUc7Pf1PSwAN2BuzTZyOoF52deWl92Pv5Pp4S/cL2QgUZJKHmMYxliZKXIQ4f
         omFkP2OPBTjicIYrCXZsXTsoonLbU3XMV5mCHapk8tn1LEOG5xTV+4oIV/1Wnv9YdU59
         wUvstHpEAhCjMV+pyDWcc9l06/zkwJK8u3MG5GOh4nn90C01hG28WZh3mzgUlkRexD79
         FI4Q==
X-Gm-Message-State: AOJu0Yyus99D6Rg4IACAifFCpq1riQGs0Of6ADCzNqWPIcmuhM/10xt1
	VK1Klo0Xx+/joa2ODbDzCT0gbxAGPoUa8UCbHKScUjzCKLE=
X-Google-Smtp-Source: AGHT+IGqEpiDUoAzJAyj9cW1l2XlMT4rjoPrN56M544U6dfFPfWydeQLuXu+WTD1Z1vLsWMzvkoxThyFc7LnM6iF1gY=
X-Received: by 2002:a05:6000:1946:b0:336:eac:c753 with SMTP id
 e6-20020a056000194600b003360eacc753mr2573269wry.122.1702313470020; Mon, 11
 Dec 2023 08:51:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211112843.4147157-1-houtao@huaweicloud.com> <20231211112843.4147157-2-houtao@huaweicloud.com>
In-Reply-To: <20231211112843.4147157-2-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Dec 2023 08:50:58 -0800
Message-ID: <CAADnVQKYE7ijTtcWrdsGpTNvS0r-TTXgkw8-R5U7rWTj+-kqAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Use __GFP_NOWARN for kvcalloc when
 attaching multiple uprobes
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, xingwei lee <xrivendell7@gmail.com>, 
	Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 3:27=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> An abnormally big cnt may be passed to link_create.uprobe_multi.cnt,
> and it will trigger the following warning in kvmalloc_node():
>
>         if (unlikely(size > INT_MAX)) {
>                 WARN_ON_ONCE(!(flags & __GFP_NOWARN));
>                 return NULL;
>         }
>
> Fix the warning by using __GFP_NOWARN when invoking kvzalloc() in
> bpf_uprobe_multi_link_attach().
>
> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Closes: https://lore.kernel.org/bpf/CABOYnLwwJY=3DyFAGie59LFsUsBAgHfroVqb=
zZ5edAXbFE3YiNVA@mail.gmail.com
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/trace/bpf_trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 774cf476a892..07b9b5896d6c 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3378,7 +3378,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>         err =3D -ENOMEM;
>
>         link =3D kzalloc(sizeof(*link), GFP_KERNEL);
> -       uprobes =3D kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL);
> +       uprobes =3D kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL | __GFP_NO=
WARN);

__GFP_NOWARN will hide actual malloc failures.
Let's limit cnt instead. Both for k and u multi probes.

