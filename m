Return-Path: <bpf+bounces-61316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEC1AE514E
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 23:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B784419DD
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 21:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECAF1DDC04;
	Mon, 23 Jun 2025 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbVL85Mx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509691EE7C6;
	Mon, 23 Jun 2025 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714366; cv=none; b=hE1KnMoOJZGahHbyknoiPPHpAURHn1+TTMC7gdjgor6tpSHNwB4305x3hyKhNTnOSz+IGLEgLt5dXNBrd625P7CNHUl54LElgxnIBEISfoy0de64p2t4NVRhvtCGyMZOyMr+6vJaAmhC70YKPAiOeiKtAjdhSlOf/a9tlcTEEmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714366; c=relaxed/simple;
	bh=4zh+xxbkoRglr6aW4XThIl6PEdJzTzddhl4ZBhve3YM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6QweyJt1D5yXoy5HXEkCybX7enOVPu9jgA2D0ODsiMQJ346f5l69QIEHncmFSCS+8Shtpld4sUgwUGhN3R+A6qQXU9dvmVpQRMf/dMdx4Rnj1l/J/48vxFvveGrhiI54RRfUmK3SJICwtRWVsy6+NMkewqmy4hD2sK0udZapHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbVL85Mx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso2575313f8f.0;
        Mon, 23 Jun 2025 14:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750714362; x=1751319162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoeN7Nd7LhLzbX2MmQNc/Ha98bARr1ZjkS1yCdPK5m8=;
        b=kbVL85Mx1uxptPPNwhT6sk1JdC3sHQ1P6NAsLpnI9XwhgIyEhnmrymzwznDolwWLPe
         ZcwzsnxD2o0HDHt/R+vJObLMDa1SX14eYGhFpqaqsc7KzyY6Lff9nq9pQM3friP/XdTw
         VkzbWqQwrXVOCsOyscmJap2SWOq62nqi3HfzuFNCy0ZbL7yXigsj/D0aALqdqC1VgB57
         +oGEgHqikY1Xn13rCp/0jX9pYnaWAatrdfJtwDZR8c94xlo+S16rGMiO9agJz8IStUci
         H3tNCaxqkGlDkujsUTHob14tpWCNhV7FRUa0eBQSMD/cVT0AT53vLI3uKVzcVkCCeXQ4
         MKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750714362; x=1751319162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoeN7Nd7LhLzbX2MmQNc/Ha98bARr1ZjkS1yCdPK5m8=;
        b=MYFdsfTx82UolfSeisaMsV89e546Xt/rzPsW7BlNMkuAlMO746636bfAKt8nXGD/Rf
         Z7PYOlh10U33QqXtgV2dnkBf3PDUx/+u9IYF9pG8tj86oHzVSXZOLtJVpirhhSKRRmtP
         kyTVwllWTetnCtiHuS3b+oj6Wlfrdu1cWOx7/R3B6Y8gv6DicUa/FPIkLNbnyjjCnOLr
         QHlE1uUqRMnas+j/NgvzjBhHwVcjmHI/MWvH9PN0/86AY3lqP8Z4mrrSSMgfeBI5l46K
         xGGbmJNGItav9IOxEeChZir3CFM1Vd2TVkaXHUqVfZsf9ESS3nm8/AFLRN572dTKg2AS
         cVvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxm9r5cxZixHKxc5XnmavS4AX3mgdTyIdmae5Le8IEEW6gPBd6CS2UkOL04LRoXZHKvFs=@vger.kernel.org, AJvYcCV39q0FJPPJgoEzeI3KSahL/xG70ru/MIs30RIC7StsrFYLBfnAGIan6ba4Q34t9AxHbSSJ0kGCZfN9NF4l@vger.kernel.org
X-Gm-Message-State: AOJu0YxA4+KBWsYtRUOBAAsJulI+fG2/D+twaEyQkbqUAli5WjkjhlT3
	NU9YfdoCsOGFvFjj4eh2Tw7z3EXV8SXdvSqHh2dqZe4xNBz8bOY0mDZGlMfcfvIEf07kVI0/aUA
	nL2jiwnkKXWgdz7tu3nWyCUwvkQ0phWwMBYG7
X-Gm-Gg: ASbGnctJAeNeisMdvVsYyRwURVQdOFhk9ChBqKTUZKJ955xZzB0vmEH38rFrMci0vag
	D4ntkDMOnVXiQySMZvbpWlkc8Pl5pzlnqJPmWJyRRSDoisQy5FNbXLt/YA2UzbEjgDeNhnvaDdi
	4NqE1ajY31BLulnVMeEteOpCh7qmrxEM8/BsSgkdFXiSahnHfSQomHR2sUKQi83JkGCRGIHkze
X-Google-Smtp-Source: AGHT+IHYwRQkSwfYn+DatykzGLdl98MLgaiclDKQwzz/wbEtLLzMcNSSHTjTZPByDoVpnJOhNqcPOCT91iY0sddpOk4=
X-Received: by 2002:a05:6000:144e:b0:3a5:3b14:1ba3 with SMTP id
 ffacd0b85a97d-3a6d132ba15mr4470376f8f.49.1750714362340; Mon, 23 Jun 2025
 14:32:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620113846.3950478-1-arnd@kernel.org>
In-Reply-To: <20250620113846.3950478-1-arnd@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Jun 2025 14:32:31 -0700
X-Gm-Features: Ac12FXzBGTpanj8qtABM0kpcQOKFRs4cKdB6Bn1jYDSFFE0H-M5iNHkCgZ5hK9M
Message-ID: <CAADnVQKAT3UPzcpzkJ6_-powz4YTiDAku4-a+++hrhYdJUnLiw@mail.gmail.com>
Subject: Re: [PATCH] bpf: turn off sanitizer in do_misc_fixups for old clang
To: Arnd Bergmann <arnd@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Luis Gerhorst <luis.gerhorst@fau.de>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 4:38=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang versions before version 18 manage to badly optimize the bpf
> verifier, with lots of variable spills leading to excessive stack
> usage in addition to likely rather slow code:
>
> kernel/bpf/verifier.c:23936:5: error: stack frame size (2096) exceeds lim=
it (1280) in 'bpf_check' [-Werror,-Wframe-larger-than]
> kernel/bpf/verifier.c:21563:12: error: stack frame size (1984) exceeds li=
mit (1280) in 'do_misc_fixups' [-Werror,-Wframe-larger-than]
>
> Turn off the sanitizer in the two functions that suffer the most from
> this when using one of the affected clang version.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/bpf/verifier.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2fa797a6d6a2..7724c7a56d79 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19810,7 +19810,14 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
>         return 0;
>  }
>
> -static int do_check(struct bpf_verifier_env *env)
> +#if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 180100
> +/* old clang versions cause excessive stack usage here */
> +#define __workaround_kasan  __disable_sanitizer_instrumentation
> +#else
> +#define __workaround_kasan
> +#endif
> +
> +static __workaround_kasan int do_check(struct bpf_verifier_env *env)

This looks too hacky for a workaround.
Let's figure out what's causing such excessive stack usage and fix it.
We did some of this work in
commit 6f606ffd6dd7 ("bpf: Move insn_buf[16] to bpf_verifier_env")
and similar.
Looks like it wasn't enough or more stack usage crept in since then.

Also make sure you're using the latest bpf-next.
A bunch of code was moved out of do_check().
So I bet the current bpf-next/master doesn't have a problem
with this particular function.
In my kasan build do_check() is now fully inlined.
do_check_common() is not and it's using 512 bytes of stack.

>  {
>         bool pop_log =3D !(env->log.level & BPF_LOG_LEVEL2);
>         struct bpf_verifier_state *state =3D env->cur_state;
> @@ -21817,7 +21824,7 @@ static int add_hidden_subprog(struct bpf_verifier=
_env *env, struct bpf_insn *pat
>  /* Do various post-verification rewrites in a single program pass.
>   * These rewrites simplify JIT and interpreter implementations.
>   */
> -static int do_misc_fixups(struct bpf_verifier_env *env)
> +static __workaround_kasan int do_misc_fixups(struct bpf_verifier_env *en=
v)

This one is using 832 byte of stack with kasan.
Which is indeed high.
Big chunk seems to be coming from chk_and_sdiv[] and chk_and_smod[].

Yonghong,
looks like you contributed that piece of code.
Pls see how to reduce stack size here.
Daniel used this pattern in earlier commits. Looks like
we took it too far.

