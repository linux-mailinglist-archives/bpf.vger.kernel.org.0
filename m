Return-Path: <bpf+bounces-19741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0273830BD6
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 18:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49A0CB224EB
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 17:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FD722611;
	Wed, 17 Jan 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n84nGxTl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F5225D1;
	Wed, 17 Jan 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705512043; cv=none; b=Y+nldQHgSVjZ+CR6rG/gsrzOmRbQ2ASG1ZnveZX5XRZbYDjYVaf4XjB+3QibZ8VZpfN/HKw0d97Z5d+hirIPPzfAEazMdQlIljNUnIP9hCOhJXOgrQQ/xki32egPajmnUX0MIJ758uz5QTunAf7lpC8rVWPNeDHWACJY1i3ZWdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705512043; c=relaxed/simple;
	bh=PJ+rmEVufpKJK7ECKejpevEIw04o5RmMCUfmqWdgfYA=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=lQ5LUwyv3jq+hB1mLc55iGmnAclxf0vXnVS8T347bxryxYxKJ/6ZRKOC3+RIVt/GzT15Y34JCiUogVKRwzZQEEg41838Hts+cpzhopmCb7iO8sZbDchS9oae2Rr4d4on6DYc3IVeyH6cp8yt0yImlvbfNqc4r8o8WPFwbJtKmr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n84nGxTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22A4C43394;
	Wed, 17 Jan 2024 17:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705512042;
	bh=PJ+rmEVufpKJK7ECKejpevEIw04o5RmMCUfmqWdgfYA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n84nGxTlQzqYATBfX/bwXAVjLaPoqbuwNMsnqS9bma7YsiFVqFJvMvv21EW+n2O/Y
	 LFKrGGgJcM+boD/EoHhLprgzUZFltjCK29BETXyD7+uHcD6f8HLtZDvtPjC3zKaWky
	 TsuKIKZZ5aFeMzZXAvbezlMMvOA0SagXfBHPdG1d8D2wg+YA76e2sABuh6IsQkbUdg
	 LKp7MNyCY3AelzuHF3wDBYtJ4RMAWUtHsOBs8yFyYOyKpjGtO/zf1n6iNjaGO4vJ5k
	 AYTR/0ZwefiPrGoAiAkkB5v9yqJecIKVZQ584F93Vk+3nUXLgIm+n58JsoNeLaQ2z/
	 UlpIMuBO88OIw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cca5d81826so147690561fa.2;
        Wed, 17 Jan 2024 09:20:42 -0800 (PST)
X-Gm-Message-State: AOJu0YxvCnijtCXayx2y97uV4NH7u44rkjrIFlkxGy154WMmVV5U2Xv7
	1rDw3gHyXol3PvN3sK23llTMRO6B8p13U3Mlw0s=
X-Google-Smtp-Source: AGHT+IGWX8Q7kIeReZ1qlFFAmoXEkNjfJOJA/MMkOeb2LWn3zknnJyvhTG046Opvn1prfXImsNgRRSgq8fIZUlkJ+JQ=
X-Received: by 2002:a2e:904c:0:b0:2cd:fe3:1f86 with SMTP id
 n12-20020a2e904c000000b002cd0fe31f86mr4393999ljg.80.1705512040844; Wed, 17
 Jan 2024 09:20:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117111000.12763-1-yangtiezhu@loongson.cn> <20240117111000.12763-4-yangtiezhu@loongson.cn>
In-Reply-To: <20240117111000.12763-4-yangtiezhu@loongson.cn>
From: Song Liu <song@kernel.org>
Date: Wed, 17 Jan 2024 09:20:29 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6mWoQQ1M-uPE_i+RWv=t5GaVqUDAObWgpEC-PCYSbwHQ@mail.gmail.com>
Message-ID: <CAPhsuW6mWoQQ1M-uPE_i+RWv=t5GaVqUDAObWgpEC-PCYSbwHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Skip callback tests if jit
 is disabled in test_verifier
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 3:10=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
[...]
> @@ -1622,6 +1624,16 @@ static void do_test_single(struct bpf_test *test, =
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
> +

I would put this chunk above "alignment_prevented_execution =3D 0;".

@@ -1619,6 +1621,16 @@ static void do_test_single(struct bpf_test
*test, bool unpriv,
                goto close_fds;
        }

+       if (fd_prog < 0 && saved_errno =3D=3D EINVAL && jit_disabled) {
+               for (i =3D 0; i < prog_len; i++, prog++) {
+                       if (!insn_is_pseudo_func(prog))
+                               continue;
+                       printf("SKIP (callbacks are not allowed in
non-JITed programs)\n");
+                       skips++;
+                       goto close_fds;
+               }
+       }
+
        alignment_prevented_execution =3D 0;

        if (expected_ret =3D=3D ACCEPT || expected_ret =3D=3D VERBOSE_ACCEP=
T) {

Other than this,

Acked-by: Song Liu <song@kernel.org>

Thanks,
Song

