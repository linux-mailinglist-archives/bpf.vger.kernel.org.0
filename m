Return-Path: <bpf+bounces-65583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C61E6B256EF
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 00:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434751BC21A5
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BB230275E;
	Wed, 13 Aug 2025 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/B19HLK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1202BE05B;
	Wed, 13 Aug 2025 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125100; cv=none; b=rddKesYuJ8mCiiYvsw7VAcqC8kmqpuw21k/7aZLLD4it9uW+ygjRUyQ6J0N3SFyaDLFNaPTVIiQDRViDEs8lUAfYToqSlWDRRrm9IMCgGFSlrBIx5d0C+uGGXUdWJRaswXQpRMvb5EDc/EqRES9cHuEnMpIPl3D/12F0eFlGwlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125100; c=relaxed/simple;
	bh=OV/ycrOYoNGwhQ5MzDYQKEDIUDuWrki4AJ0O9zrmkks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r618nIQiqqgfI4VhKYwwx8JS+JvVQAhz4jyIy5BSZDdi0nt15VUmFl9JD+aYTdWHGZ+IdfI0Q8huWxO1FdqKOwqod/zxeWV7jwf3fex1wOeMsVc9YQXA+ybCnvVNzFLnYJkgAZgVyXBG+Su1CEusPGQEgRmNaL3SlL9/LNSb2Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/B19HLK; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-323266d2d9eso334229a91.0;
        Wed, 13 Aug 2025 15:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755125098; x=1755729898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yd35egmN4CDcVZKEMWmqSyca6/vnlaqT06CZE8Rd4hc=;
        b=b/B19HLKmeclIMpF/h9ynnFPSbai4TyF0+cGjyYgkSN4/fYxCcsVshp8WUylYKHx0o
         vhzu7FM50kd9ziDUsQY0opEMudqxwXcT+QBCzZRlpVfOwyJ92t3l2VzpdRvFgXOfCvJI
         fmHGV8G9FUenajIUidXLU3R59sBP/kVePriV1YCFj5zkI2F8qyTudnPLDIEY6JEAYcXz
         DpG58DZeGiEYwF9mUNVfzCYaRacK3S4clF9rnl2ig56k4l6Y6CLNDaXBxRMKr1H8UpOu
         G4QBWEaxcFSLR6yZsWekX1dcbFzlc8jdliomwIRojmTiBFRS5xnmej6cj0LM3L3Mjx6v
         NgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755125098; x=1755729898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yd35egmN4CDcVZKEMWmqSyca6/vnlaqT06CZE8Rd4hc=;
        b=DyskXqycyMnrEyoeW/1MFK8b4ywU2IWvtunZ/NLv8I4Vo0eXxW9S5X5u3fLXTFFg14
         WklDH2VA9O3kH28XLy7zpikWR+mzKSuU1MW7ffM6LDMS1fDy7bYB5L5XGLkboTQqfVRy
         8mZNsWSqp/jRdO7SHtspm9PXllZUTmmzkQ/WOVDSNZI5gurks+YZEQXoqVoVYwHbhGhY
         +Zav1epinrREKeeD86lOGPm7PBUxLOIRHy0vENfkqG2leBMqi1vIkNKow47WNHNSSStj
         cWavNchTxf7Gm7qDji2wWrETbPU+vevxEggu4OigJ3IasooDS1sXHyy45yeVghexn6/5
         LMQg==
X-Forwarded-Encrypted: i=1; AJvYcCUEhgystEJlRjcHNzAv6V93tSG0nRS4U7WEbwqXqAUxRfdgZJ0JZhocHU5XRA0O1tFmce0=@vger.kernel.org, AJvYcCWqNgsjuE64C4qrDYkXOjkZBE2RXG0phNE8ZV3wHCHrklUCzQ3mVgQojux0VZUg7oS4tcXXJQBnDSEnVBqzzAbPLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjC10bwWmgr8edomsB0zNyANrdOvsLtCoaFN1MMrlwQk1n7tSu
	EZ/yxl/CyTKHLiDKTMJ3wzHRFiIu2sJXfaNVRYeGDLf6wptcvNb1dsnB2KQ379eNcWc7PbAqg0K
	g4h+UUwdS3jsPhiitBqpRpEZTvyH/ozE=
X-Gm-Gg: ASbGnctPNsh58ZjnqK/ognSlAynxh89TYEigEC8SXWwvy9lqG238nZmu0AzEyWHnxgv
	Iqpe5JgbZaB0n/MSjF/e8/tDcvVvNu0b6uXNnlDCcJvFL6bKPTk0NleNdnsdycF0SZMC6NElQWx
	4e923y4SygECEV/i6asQ+2ZCWxpCyPE7QWPcXAaQVmSH3oFnYm2xvzy8nK9qnzZ25YBztDFKnxe
	EIEW+AravdXbhtb+MP/ck/LmUnekAGehw==
X-Google-Smtp-Source: AGHT+IEJ4gucRc0WVd7WCFDuWVfhyS5mg1YHXbANwvz4e0fcj21tvta+1mAsqKLmUq7uTcNuWUpFEP2FQGRJzud+2G4=
X-Received: by 2002:a17:90b:384e:b0:323:264f:bc42 with SMTP id
 98e67ed59e1d1-32327998e38mr1375144a91.3.1755125097905; Wed, 13 Aug 2025
 15:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813133832.755428-1-jolsa@kernel.org>
In-Reply-To: <20250813133832.755428-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Aug 2025 15:44:43 -0700
X-Gm-Features: Ac12FXzdPMZLJrtvyY1a9fVClNy9bi-m8rUfcsctoVtDz1T5yLFWSAXPYA9ismg
Message-ID: <CAEf4BzbRL47Qm1T1BQrvG6K3itqFHfSdXbOeFG5vKj4yB0QtbA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf] bpf: Check the helper function is valid in get_helper_proto
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 6:38=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> From: Jiri Olsa <olsajiri@gmail.com>
>
> syzbot reported an verifier bug [1] where the helper func pointer
> could be NULL due to disabled config option.
>
> As Alexei suggested we could check on that in get_helper_proto
> directly. Excluding tail_call helper from the check, because it
> is NULL by design and valid in all configs.
>
> [1] https://lore.kernel.org/bpf/68904050.050a0220.7f033.0001.GAE@google.c=
om/
> Reported-by: syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> v2 changes:
> - set bpf_tail_call_proto.func to -1 so we can skip the extra check [Andr=
ii]
>
>  kernel/bpf/core.c     | 5 ++++-
>  kernel/bpf/verifier.c | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 5d1650af899d..0f6e9a3d9960 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3024,7 +3024,10 @@ EXPORT_SYMBOL_GPL(bpf_event_output);
>
>  /* Always built-in helper functions. */
>  const struct bpf_func_proto bpf_tail_call_proto =3D {
> -       .func           =3D NULL,
> +       /* func is unused for tail_call, we set it to pass the
> +        * get_helper_proto check
> +        */
> +       .func           =3D (void *) 1,

we seem to have BPF_PTR_POISON in include/linux/poison.h, let's use
that instead of 1?

pw-bot: cr


>         .gpl_only       =3D false,
>         .ret_type       =3D RET_VOID,
>         .arg1_type      =3D ARG_PTR_TO_CTX,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c4f69a9e9af6..c89e2b1bc644 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11354,7 +11354,7 @@ static int get_helper_proto(struct bpf_verifier_e=
nv *env, int func_id,
>                 return -EINVAL;
>
>         *ptr =3D env->ops->get_func_proto(func_id, env->prog);
> -       return *ptr ? 0 : -EINVAL;
> +       return *ptr && (*ptr)->func ? 0 : -EINVAL;
>  }
>
>  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_in=
sn *insn,
> --
> 2.50.1
>

