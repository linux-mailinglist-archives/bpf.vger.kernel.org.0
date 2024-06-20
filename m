Return-Path: <bpf+bounces-32627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1389111A5
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 20:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F181F219D6
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF011B3F36;
	Thu, 20 Jun 2024 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuO+Y37e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6F539855
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909910; cv=none; b=NFU1dxVpm9yoVoUSUjbzZZhx/Z6+6hFbjnIIuqc7D7AXYCn+vAObVgIpvua3TRRe1P78iX6/xZO8D7Ay+bJEXTn7YXcpTKnBsKgNZwkhgD9tKr+oylLIsCjBC3oDOzOE5rcTD6UhYzfaqGScY6zRX7f5i7w2GCW8f746su79ZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909910; c=relaxed/simple;
	bh=/5y/H211b/TZ2DW8GEmphW8iX2CWfUdn79JzwWchr54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPe7XWI4rZyIIOmgFJsmK8bdj0GumifXY7yDuxebNqfVJBijD4suqk8xcTn0j8f2dQZleqGeclPbYHY7VoS1h8haOWaDD4c/7iHWqXeySADwqycVuFvD7v71LTpAqS5MB/v4p5z18AscXnVBGjHpeZ3pTvGprvLGxyXpGA4OXUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuO+Y37e; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c7b3c513f9so1089813a91.3
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718909908; x=1719514708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SmVgE7ikSzPJtCfEYvlOaWFLDNX/NyKAgRvjJ2xaME=;
        b=fuO+Y37etdu/wZymVNSG+bF/xjL1WvXBpjX1+m4jstA8XNEtXgYg0mtpRiatE465eC
         jOGsf0xHs1ENUi3Q5a1q0h4qpKUxK0iRcLAUzjmy2W3LKq5829EG2Zg1U7ZR6AFu3tYT
         ZdSQ/iTPb6kKKYduSKNzfeGdmTPJf+ezsswQHxu1FBEnF8rg4Bo2yRzuZNBAFbyO3fSE
         Uy3nLu95O30h/042Jshz6RwyudK4Nttv/1DPKRxImJNEmWTn8EcAxXMcIw8gUGbMgTD5
         P+qfiOwSPnuRslvTbygffKpMJ4r5GVAPDq5gcNT+x2FRH3sWsPM/fHnZCeeaGOm3wYD4
         iS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718909908; x=1719514708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SmVgE7ikSzPJtCfEYvlOaWFLDNX/NyKAgRvjJ2xaME=;
        b=eAzvpuQ1a+SNaFWDGx+n+KUY8HWqNIgce6lSVq5X20XuzgEOchX8gn2woSE6foYHS4
         UK5WkfsIYYOMsEFoOI8mRCxJSi7MTxteftwozQAspJJLOUkQSRWJJEzFKXSsxI97T1Bj
         hJgZlduJBbyHsB55EOn3mOtZViIfyActCpwxbaQzLvXbDCCTOiHclacSHGWuAFrpIauP
         SasCzW2J8m9n3znP4sFd/eWug3fHNay7i52obaxSxnUoRNDqE3boiy6oyKNHG5PvyINO
         d2aum6xdoXm4H5+bD7cMfxAo0Jt1ze//YF87Ww8g8XXLnUEUbLp0nJGNxjt41X+QkmfG
         9wsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi1MK97ncOIcmbZofWAeWuMF7krE9l0kBoIyaKaWzXzOmZun6lGPj8ycAlmnOZ5p9qw9ejaueR1KNAPsKh4558t53q
X-Gm-Message-State: AOJu0YwOiQJuwTwCIs99pdkNsRRb/aJ1IMY99cCFNe3gJeaD9RYsuAWw
	J7oRKEy+BErKbSqaG5/UZdX1jT81VCYhd/aS62vMOBxonMjbj86DLT7y+I1/HHar2c5XproFOik
	/I+GGaNSgBTQUuat4HlMxpmOjeao=
X-Google-Smtp-Source: AGHT+IEAlmLiMBc0SfOhK+gKnxwV4xY3L3EI5FR6KC1oxNB0hi6TTYhMUKZ3x++e5FFWNhbJfcXuIoox9Z1n8d5fBKU=
X-Received: by 2002:a17:90b:3104:b0:2c2:dd1d:ce6a with SMTP id
 98e67ed59e1d1-2c7b5dca8ccmr5525609a91.45.1718909908206; Thu, 20 Jun 2024
 11:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619081624.1620152-1-jolsa@kernel.org>
In-Reply-To: <20240619081624.1620152-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 20 Jun 2024 11:58:16 -0700
Message-ID: <CAEf4BzYJU8y7LtL=QBLSFOC3vP_W=vqAk+qpkCWfgMJ4y3fqhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Change bpf_session_cookie return value to
 __u64 *
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 1:16=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> This reverts [1] and changes return value for bpf_session_cookie
> in bpf selftests. Having long * might lead to problems on 32-bit
> architectures.
>
> Fixes: 2b8dd87332cd ("bpf: Make bpf_session_cookie() kfunc return long *"=
)
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c                                        | 2 +-
>  tools/testing/selftests/bpf/bpf_kfuncs.h                        | 2 +-
>  tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>

LGTM, thanks for the follow up!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 4b3fda456299..cd098846e251 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3530,7 +3530,7 @@ __bpf_kfunc bool bpf_session_is_return(void)
>         return session_ctx->is_return;
>  }
>
> -__bpf_kfunc long *bpf_session_cookie(void)
> +__bpf_kfunc __u64 *bpf_session_cookie(void)
>  {
>         struct bpf_session_run_ctx *session_ctx;
>
> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/sel=
ftests/bpf/bpf_kfuncs.h
> index be91a6919315..3b6675ab4086 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -77,5 +77,5 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr=
 *data_ptr,
>                                       struct bpf_key *trusted_keyring) __=
ksym;
>
>  extern bool bpf_session_is_return(void) __ksym __weak;
> -extern long *bpf_session_cookie(void) __ksym __weak;
> +extern __u64 *bpf_session_cookie(void) __ksym __weak;
>  #endif
> diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cooki=
e.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> index d49070803e22..0835b5edf685 100644
> --- a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> +++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> @@ -25,7 +25,7 @@ int BPF_PROG(trigger)
>
>  static int check_cookie(__u64 val, __u64 *result)
>  {
> -       long *cookie;
> +       __u64 *cookie;
>
>         if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
>                 return 1;
> --
> 2.45.2
>

