Return-Path: <bpf+bounces-71235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B04DBEB0E2
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 19:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 131BB4E2647
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 17:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFDF30498F;
	Fri, 17 Oct 2025 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvUPL0lk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B812FA0EE
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721634; cv=none; b=jl/enWDxE6cJx/zqu4GrPIq4UNQALRXlNXG6Ta/9L1IXjXPGy4Kgbv3LWUX3ApaC4j74ute6S+MlYWuwuCGdzVfNCmqaPd16g66j60PDdzB6Y80yf7uy3cB4MqEvJk5poyV7s7ZxQ1tYHx6ylc2xQtq6JxMlAMYaYIFqHTWXeG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721634; c=relaxed/simple;
	bh=38APfVEhFgNJQtC9xpMbjPblo+/ZvzMJts2TmLGPnqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EaIW1W5w8leUs4cSp7n8F+IQlulQjiLh7lGLekItSP9iI6NXSTbMi88Rdg8vCzs+Mq+bh0CyamjW6FVY/qjieafwdpJ1WgpDSkETxOY3fkFEPtxTVbEEdCQhaOzwRIfPm/IACX4KwNCilQB+X5ph8NX0uHAXqkwMfy6mPfleXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvUPL0lk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so1599552f8f.3
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760721631; x=1761326431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/JD7ilbWdKJoamFy6d75aFxBhIfji9qRkffcEQrmBU=;
        b=gvUPL0lk/NvHvpE8x7UOfu8GlhAaaST4bwUur3dkiRWejrdVneqm0wp/+n/fPuMGrA
         G0juNVYALj0wUXShOGB37mJGbO6bZcGJni7m/ykbSU/brrDC0vqZwPtclgb+dMDRjusR
         UnICjLJBAkx826qI4LBIvWgjKFB0Q2aO/DXt+/o7K0opKoEXH+//Cgy2Dv/iuXXsj5vW
         gO9rKp4nhQKYWDegY/RskwvfruPne2ZZqcBAV7DXfqtOic7Or8TbSJoClu3oiI/cNdH4
         5MeumGtOlBtCo8qf0xWyj2iNB2Xb+yqZ5wJUpf7vTH809vkwsPe11btWo/rlGMA114YK
         VqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760721631; x=1761326431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/JD7ilbWdKJoamFy6d75aFxBhIfji9qRkffcEQrmBU=;
        b=vdysmtmTGjwyG0+dgkF+9FeW+FgffivT7rc3zo/TacGoV33GEROr4+v6ZSiXkVaNfm
         dzC+eKNzubTmmQDKBhTkx/zRS4Yp7npzHTyfWpLVmAekRTIFniys7JYlPbNf6KfCiBFh
         Y3i6SO64zq/qqpMG/fR+4vj+C8rwK7HCEr1wzqqc71mIPcDET0pJA/pfu2wudtCqq5zi
         9O3A9a0IuxFC2eJrToOGSZWR81xIceRcwQeOV03KcJ5vV5M0qrmbnDLkHG/B1jToFUCL
         Hg5m49vZjVcewZVoaVD26yViStEwZcFhbjv3V8RdcALbu+tlYTRUJMMCS6HYnQwSNUVs
         g7vA==
X-Forwarded-Encrypted: i=1; AJvYcCVYaaPyAz9c+sQyXJKSjSAeFrGjimFXjMvTaI39rVQhBUsioIn69exRAvAEgNYHvAdzBsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9JQOUU7t5sDXz7B09H7rcwU2i38tL/ndVJt+LYxNWgz4qXrD0
	2RuRWWVFvzQe0JNt2BaFDqgubCcZ/9EU2af2OfyhvDrepQAsaoD6sE0+JNMhFbgGbgYxOeDG5GQ
	ZO1v34CcYRZqhUP49COx7JDxN/b5gcrY=
X-Gm-Gg: ASbGncvXqff+VximphkSnC0L++IPrWOtIU7krsh/9jh+A1VbE4sX83oaADwa1p6t4fk
	hXHYD/42NF9RvWbuS1Ud7i6/x5NX78NbXp6KaUZ5ZA1JSakyXVsqFfe+3+6lPNYUxkgZKXpnC4S
	ROAR2r/Qlixyj56TIKUMCp4wK/W7Jx2Y3Kny7auHVQnWkrAKJuLCVmTINkBgkLnfR3ubeDmuzPe
	aeCWEa5XBQA6ibeCmIdA47p+qHIz/kXIK2QkAKbH8vhmAkjZhl0nO7Rb0E4Oec2y5O4E9NJlhuX
	EaxIA9u7GI666zqzyg==
X-Google-Smtp-Source: AGHT+IEXnCgwKH7gRsD5Y2TmkOK7NQ6/uJOgBWUykyzj5DkPpJxyOTNB5lyxbsY6LrB21TGx/14+ltRy9ugNfwT4Rv8=
X-Received: by 2002:a05:6000:4381:b0:406:87ba:997c with SMTP id
 ffacd0b85a97d-42704d9a02cmr3211524f8f.40.1760721630408; Fri, 17 Oct 2025
 10:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017092156.27270-1-yangtiezhu@loongson.cn>
In-Reply-To: <20251017092156.27270-1-yangtiezhu@loongson.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 17 Oct 2025 10:20:19 -0700
X-Gm-Features: AS18NWCGzBAbgYmrodlFlBvWORKj7llNgBsdnucr7BBrFvE8KwSmhxURQJ8Hhkc
Message-ID: <CAADnVQJjSNEuX=HJKrD=pefC4C9dQk2aqP+hnRscUEDTntVXyA@mail.gmail.com>
Subject: Re: [PATCH bpf v1] selftests/bpf: Fix set but not used errors
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 2:35=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> There are some set but not used errors under tools/testing/selftests/bpf
> when compiling with the latest upstream mainline GCC, add the compiler
> attribute __maybe_unused for the variables that may be used to fix the
> errors, compile tested only.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/bpf_cookie.c            | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/find_vma.c              | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/perf_branches.c         | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/perf_link.c             | 3 ++-
>  tools/testing/selftests/bpf/test_maps.h                        | 1 +
>  tools/testing/selftests/bpf/test_progs.h                       | 1 +
>  7 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops=
.c b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
> index d32e4edac930..2b8edf996126 100644
> --- a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
> +++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
> @@ -226,7 +226,8 @@ static void test_lpm_order(void)
>  static void test_lpm_map(int keysize)
>  {
>         LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags =3D BPF_F_NO_PR=
EALLOC);
> -       volatile size_t n_matches, n_matches_after_delete;
> +       /* To avoid a -Wunused-but-set-variable warning. */
> +       __maybe_unused volatile size_t n_matches, n_matches_after_delete;

I think it's better to disable the warning instead of hacking the tests.
Arguably it's a grey zone whether n_matches++ qualifies as a "use".
It's certainly not a nop, since it's a volatile variable.

pw-bot: cr

