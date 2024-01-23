Return-Path: <bpf+bounces-20061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF52B838165
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 03:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD2C1C288AF
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 02:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B43314A4C9;
	Tue, 23 Jan 2024 01:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ma4D/dru"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CEE137C55;
	Tue, 23 Jan 2024 01:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972122; cv=none; b=BjtnVAmmjlQ1YGf0LiJFHZ/9A/Vmu5vwtTUnmSchgmZmkvGZr8m9IB8WdVVWwKexnuzT4ddRvpfsCzdkx1pZXtaCHOYkhLr6TorO+F64mz68UPhKkprpRxvynr8gwD9LWZ4NogVDU+JTTu9Fl15MTHN7p+3BPVYo529kZwmWQ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972122; c=relaxed/simple;
	bh=bElHn3Ne4EZ7jmc6RVYt5Mc6GOw7OXeye11ZwW0DRsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJ6+nh2erPCnjX8axFs9X7pAgFRCFj/4c8rk9fOkRy/eleWTIvHPjdSJFfy2rcq5yIyKxGntmREdx2fGMmxbS6Juf8IST2OZMaCUxHPfjSQZvV2wXBvXulLbLIv7XmUpzWZcBQbZAWqVL9hLB7lQtkhkyN6xeMxxMk86JoQR3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ma4D/dru; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29041f26e28so1836002a91.0;
        Mon, 22 Jan 2024 17:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705972120; x=1706576920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHzTbBApEZLhBHNLNyXnHBhEyGzYJo3QN6fnH0aPyEg=;
        b=ma4D/druzVZOw3gHeoijDEpNEjBqfTS7VLYHnN4+o0nes3DxsbOqdXJ6d9m0MuY88S
         OfaaRBFohvoCeyv+B4iPwBsVY+Iw/Yn54BcnQ3Q2gWJ14AkmvQ9Y6b9/OoEs+WqdJVf3
         CPJ6jowxUnoI6xB43CK5VHeOUCm9CGBhA17oorbK7OomfFs+3Y1YXoWCRenik6pVQhYt
         8mAjRcluAvv9fGQ2vwl6Y+NOMNBf/dE7+SVZhTV7e3dcOpS07XO/8XX/ebmMroARKE2L
         1kUMC5NLcw0+S4iD7I3TNSlE0dwwURxyJiE8z3iSpiqlyXICVajrArkLtQZzG8Cjwjft
         b2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705972120; x=1706576920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHzTbBApEZLhBHNLNyXnHBhEyGzYJo3QN6fnH0aPyEg=;
        b=vnejYVz3OTgLQ/McvWH2+E/iZItp95HPd6G/TyEyuEg26jxDtGeESw8wh8EHMLbIdn
         NlZThaplty/CYmp7rnaRS8uY5u2ZM2rHDLCCr/yT8cXkNLGneSQzRp6HwV6+lgDyGJls
         rhCS39o6o6reZYmXtfQQ++6pdazX/0Z6d76hMCZlEJHpAyCMNC/hnQ4nF9sxUpX8N/Vm
         fSFGiNE2+a62tFrTUlrsIB4KEAWL439REQvaWkS4p+lVWCTHXxMR/NciWlDd2nXzNpFr
         Wt8m+CApmoTCOWQgCAhkr0QrdanNt3kvEN28rGrCEYkuOWtd6N3f2hIHv5S85TsyaboG
         ZtyQ==
X-Gm-Message-State: AOJu0YxcmwWsxRXkrm1QL9RSrSwhb0gZKGAq6EnrGrGOCjSSOqvPpMTT
	uDRiY0PPkr9VuQeKpSwi52lmRXZXCldpsP/Czv3okkG47rmvkL9goNPt1+Vws3of2Fvawb441ov
	XdRg8MKaDdbFxGeTtIV8NigbASHM=
X-Google-Smtp-Source: AGHT+IHaJU/HUx3FIV5dxViyHivmsfCnlqq8/0E+5Mjc1ziDY85SM2D1q5hftq8WN4JBRrEyXeXYpVHsNT0V3NHPHFs=
X-Received: by 2002:a17:90a:304e:b0:28e:7b66:73e4 with SMTP id
 q14-20020a17090a304e00b0028e7b6673e4mr2001910pjl.5.1705972120588; Mon, 22 Jan
 2024 17:08:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122075700.7120-1-yangtiezhu@loongson.cn> <20240122075700.7120-4-yangtiezhu@loongson.cn>
In-Reply-To: <20240122075700.7120-4-yangtiezhu@loongson.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Jan 2024 17:08:28 -0800
Message-ID: <CAEf4Bzaj=W3tUbfKRbQ3JgYqXimthVOs9uvmj4YxkbDhE3v0SA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/3] selftests/bpf: Skip callback tests if jit
 is disabled in test_verifier
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Hou Tao <houtao@huaweicloud.com>, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 11:57=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
> If CONFIG_BPF_JIT_ALWAYS_ON is not set and bpf_jit_enable is 0, there
> exist 6 failed tests.
>
>   [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
>   [root@linux bpf]# echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled
>   [root@linux bpf]# ./test_verifier | grep FAIL
>   #106/p inline simple bpf_loop call FAIL
>   #107/p don't inline bpf_loop call, flags non-zero FAIL
>   #108/p don't inline bpf_loop call, callback non-constant FAIL
>   #109/p bpf_loop_inline and a dead func FAIL
>   #110/p bpf_loop_inline stack locations for loop vars FAIL
>   #111/p inline bpf_loop call in a big program FAIL
>   Summary: 768 PASSED, 15 SKIPPED, 6 FAILED
>
> The test log shows that callbacks are not allowed in non-JITed programs,
> interpreter doesn't support them yet, thus these tests should be skipped
> if jit is disabled, just handle this case in do_test_single().
>
> With this patch:
>
>   [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
>   [root@linux bpf]# echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled
>   [root@linux bpf]# ./test_verifier | grep FAIL
>   Summary: 768 PASSED, 21 SKIPPED, 0 FAILED
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Acked-by: Hou Tao <houtao1@huawei.com>
> Acked-by: Song Liu <song@kernel.org>
> ---
>  tools/testing/selftests/bpf/test_verifier.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/=
selftests/bpf/test_verifier.c
> index 1a09fc34d093..cf05448cfe13 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -74,6 +74,7 @@
>                     1ULL << CAP_BPF)
>  #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
>  static bool unpriv_disabled =3D false;
> +static bool jit_disabled;
>  static int skips;
>  static bool verbose =3D false;
>  static int verif_log_level =3D 0;
> @@ -1622,6 +1623,16 @@ static void do_test_single(struct bpf_test *test, =
bool unpriv,
>         alignment_prevented_execution =3D 0;
>
>         if (expected_ret =3D=3D ACCEPT || expected_ret =3D=3D VERBOSE_ACC=
EPT) {
> +               if (fd_prog < 0 && saved_errno =3D=3D EINVAL && jit_disab=
led) {
> +                       for (i =3D 0; i < prog_len; i++, prog++) {
> +                               if (!insn_is_pseudo_func(prog))
> +                                       continue;
> +                               printf("SKIP (callbacks are not allowed i=
n non-JITed programs)\n");
> +                               skips++;
> +                               goto close_fds;
> +                       }
> +               }

Wouldn't it be better to add an explicit flag to those tests to mark
that they require JIT enabled, instead of trying to derive this from
analysing their BPF instructions?


> +
>                 if (fd_prog < 0) {
>                         printf("FAIL\nFailed to load prog '%s'!\n",
>                                strerror(saved_errno));
> @@ -1844,6 +1855,8 @@ int main(int argc, char **argv)
>                 return EXIT_FAILURE;
>         }
>
> +       jit_disabled =3D !is_jit_enabled();
> +
>         /* Use libbpf 1.0 API mode */
>         libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
>
> --
> 2.42.0
>

