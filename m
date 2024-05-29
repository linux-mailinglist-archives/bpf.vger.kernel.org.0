Return-Path: <bpf+bounces-30851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A718D3C18
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 18:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00BA51F22C1F
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 16:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D2A181D10;
	Wed, 29 May 2024 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmCVMSMD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1F9E576
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716999543; cv=none; b=SAJ0H05BLZjNH8OU1gFXklZ9s2Ri5/UZijMzJDsmM6EWJo8RHXzVVi1wgVDBybjDcufYtEPA5relh7CBkzXODcK7RqcUQifhQMY8G9S4iybV8QySp3wD/hBzJwNA9A+zY40j3CvUmJgqHMooWr4elUuKBP4F7NWAqpK4GcfCvXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716999543; c=relaxed/simple;
	bh=9ftfjghXz8ckra+CgIBQjHccfHc+p00ER805Imq54rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8aB+PnlbDM9jtcQeTFWcA9dGsRkWlteY/FDVCZAH7BHAeDzA8GqMFTMIgcS3RJrIFc/LnWKHjozVWjPW0V4y9CnA2qltbncP5vwB82ljr0h9+BZ7I7OIh2+ZKvgo1R2QejwEr1ACMX65YI6EQzqQKhuAsn4Zosw+KvNG1vNjTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmCVMSMD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so778655e9.1
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716999540; x=1717604340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oU2Cgwgz8Rl7lzGL+Rwb3+iV2s8nO4kYWP4piubBSYQ=;
        b=HmCVMSMD5DKeTEiwWjH3I4aL7sN0MAft01GyjDj7WUSbE0jodwhzhys6gtE7LZ4pjZ
         q+u4FDM5S1LUK7IafSVXGZkmxpJnorw2/4ldglFTFjH9LjfTdmKoQpXxGkBsRpgouMpB
         bl3khg7vTpW+eky3pXPvZtslqGxTaUP5Ei8FgBuTziayNSZKuckXPuE9vBdccUl7WqAO
         879ALOa5GYYn/rXE0qBIuvCI3JbDYHStJQNdM0H2R0G6EA6aofKLCROFB7+B+wRP2Q6h
         SqhlfSCdFH2riJN3k6VEq8Oq8LE7J1Eb49l++6ZJWaObO99P7dhrbvwJWJZT+I3087o4
         QtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716999540; x=1717604340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oU2Cgwgz8Rl7lzGL+Rwb3+iV2s8nO4kYWP4piubBSYQ=;
        b=Kzcm5vHvrW09YT5rHioNFp5/zJtFtnQDfBon/UYa+nggy1qOhVV+9Jv176yWiV3860
         b9bzEJRliHtQkKnA9riyZcWWnTdgbt8k/RO66xXa/6iV30BfrwUg7qmFnAS5CzmjSthG
         6Ehk6clUG2dHIOffJRHURLBocYUGrPrqMkmuiSMWfYAWjdatmwM7dIPmb0pQhHGJ9/z9
         a/uqSnJJi8pe+KLSCkHkN47OpQJVuNbT4tJ+v2uMUwSL5PSiO2l/Lt0XZVi7NTAOhK3w
         UWYl71/tDq89gFx7sWIz5ahIUtY8TI266ByuRLu3tvDBCDUIyv4yI/3OIPwxvHBOpHp1
         k8JA==
X-Gm-Message-State: AOJu0YyfZntCTvALYYgzFXf4hYTyVk+hKzGrIrtYDjUgucQeXczKQeQx
	SOxHTS3x9+saAGDv6vOQSLBtVNbaQlpyiEWRKYrram/RmlRLEQpX72iJohzIaU6We7ULjOUqYsb
	4tHakQ0lK+jNe1GGnHrorsfhj1os=
X-Google-Smtp-Source: AGHT+IE4wVT3RRnGhzcSPsDy5ZXXsEJIWpbUJn4lPVzX5mAo265kSAzHwkDV41zM+r2T8dxjlnBfK0O74gckOwXpMK8=
X-Received: by 2002:a05:600c:3548:b0:41f:c5c5:c9df with SMTP id
 5b1f17b1804b1-42122b00e42mr25834085e9.14.1716999540293; Wed, 29 May 2024
 09:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529124412.VZAF98oL@linutronix.de>
In-Reply-To: <20240529124412.VZAF98oL@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 May 2024 09:18:48 -0700
Message-ID: <CAADnVQKdAo-=DMMyLJaAR_CHBZq=W=LsYxk=Tna2G+tXLnfLqg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Use an UNUSED id for bpf_session_cookie without FPROBE
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Viktor Malik <vmalik@redhat.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 5:44=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> bpf_session_cookie() is only available with CONFIG_FPROBE=3Dy leading to
> an unresolved symbol otherwise.
>
> Use BTF_ID_UNUSED instead of bpf_session_cookie for CONFIG_FPROBE=3Dn.
>
> Fixes: 5c919acef8514 ("bpf: Add support for kprobe session cookie")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/bpf/verifier.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 77da1f438becc..436f72bfcb9b9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11124,7 +11124,11 @@ BTF_ID(func, bpf_iter_css_task_new)
>  #else
>  BTF_ID_UNUSED
>  #endif
> +#ifdef CONFIG_FPROBE
>  BTF_ID(func, bpf_session_cookie)
> +#else
> +BTF_ID_UNUSED
> +#endif

Instead of this fix..
Jiri,
maybe remove ifdef CONFIG_FPROBE hiding of this kfunc
in kernel/tace/bpf_trace.c ?
The less ifdef-s the better. imo

