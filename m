Return-Path: <bpf+bounces-28277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 008168B7E76
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 19:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6591F21675
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 17:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA62180A74;
	Tue, 30 Apr 2024 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B75uWSGS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E31802CB
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498159; cv=none; b=u5t1/ptB50i18080uj6QkiJ0jTGZ5URS764LUL63fjZJHiR2WFYg7Etx125QWJSZr13kDEfh3Jaa+q+Fx+XoWpppvbpBdULbNe7wMa82JqpNobQBA6KYMmmPMowQDSGLpYlHxBBiwT/quraePI2pqvfVAuzC0zYzzu/Ka32Nb9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498159; c=relaxed/simple;
	bh=5tktIXb+MUwmV20l51Q5vg+gpB3EEyu/BC4zn6UHatQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIuncuLqBT78A2KF8trMZgQmfg9BwU2oE+HF+cUOiBKE8fwS6s1AmxUIo9clFyoG3kKKAJBz6c17muM4Tu3EQTTgperg5r/nT1fjJiS2ZzyAjm5+Qz0DXO6OqpZLItuG7Pshkm5xEaGFULeTNm4zvBR4Zj8Ni2R8cLoHDq8Tq0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B75uWSGS; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2a2d82537efso4156793a91.2
        for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714498158; x=1715102958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H884YrU0PbIE0t/7QVzUBz/bKEwwpRV9/B/5wBomXEc=;
        b=B75uWSGS3VoFMKqTZrVGmyo7QbvZxRKR8N1+zQPFfjUNH8UTDGSKt379R0/nYGU5L1
         m5BDw3PHT/iyNqUQ5FKA6Ak6bPVP4IW3z7ymAH2o+uWPs8yzryBMMY8hlgIIWn9OHWqp
         lagH8AX+BD3oVylWExpy9Yp2bNQ/kOD4p28xl9CNGYQTwjC7RuNSKbvMI32JSXjB3tOd
         lo0gVfXCP48/2mMuFUFmB59th5ByugtvfUQjtzQFzCkLOSwO6H8WDHSwCAa1Nb+FUPzh
         U/4qknbWLz/Kaes8S+TMFDMBcs6wSYTvLm63lsoQHy4KH7ZVN3gKzQh8asWHfLpdEJOh
         I/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498158; x=1715102958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H884YrU0PbIE0t/7QVzUBz/bKEwwpRV9/B/5wBomXEc=;
        b=ZOq39MbHLBl37me199cTMhm/Lieyg2OqRzXlY22lns52pQZCaV9mx0MV+KxTZA0qxX
         GiUl48+mA9FyMwqUUygyw7hVExv7czlBONyxGwYmW1iTcKYM5EdNvMvjx3ys0albIZBe
         Z+fR9f3BwqVZbSJlXfDJ8vkmi9DekcnR/xFLEgA0kDicmGL8eFgLSZ+QoYy/lq72POem
         nezhMyfKKCWQmRjTnWVMqAddh8z+eV4RRCQG1DsUiMMjq/PrUbmIQaIIjf7Wuw5zGbf5
         NmsOxHfkrUEHPbjFXkQetwr89wKCIEALPY/RGZ/L2xrmT+mKt9KzAc/pEh2UH6+/D4aS
         r33A==
X-Forwarded-Encrypted: i=1; AJvYcCVj5JrXVnvehylIkKY1PkUsagkQ9Snr+vKqlgnatvNXJy85PCff7LTIexG/+KZf09ABSzZ9ZVCBg437TZ2HReKuvFeC
X-Gm-Message-State: AOJu0YxM1Fb9WoBwtaZ69s+QNApE1mCm6Hbp746ZbtlK0W+W0NQe5FBk
	CJBchGiZI6SWz4ADvkyyso1CwamWzyN7ma8snhOn0E2EcmbJCKdPVt3qw7ZyY5vM7eH8zZYw+TM
	m1Br9Gof943ooZJ3BrfIVssTyVZNq7w==
X-Google-Smtp-Source: AGHT+IFEmmn8ruQfiyw1KhAf2Lj8Kq8Smb1EYR3lpnlq+uKC+yLDSRo/8h+4C0az/cqU0G8FumFYHz97mIFbbKUl2dc=
X-Received: by 2002:a17:90b:4b46:b0:2a2:5db5:b1ed with SMTP id
 mi6-20020a17090b4b4600b002a25db5b1edmr180320pjb.17.1714498157672; Tue, 30 Apr
 2024 10:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430112830.1184228-1-jolsa@kernel.org> <20240430112830.1184228-7-jolsa@kernel.org>
In-Reply-To: <20240430112830.1184228-7-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Apr 2024 10:29:05 -0700
Message-ID: <CAEf4BzYiBDDEPjAbW+anv8uoAdwjyUrOAeFeEXKXSBj_0wOTqQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 6/7] selftests/bpf: Add kprobe session test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Viktor Malik <vmalik@redhat.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 4:29=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding kprobe session test and testing that the entry program
> return value controls execution of the return probe program.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/bpf_kfuncs.h      |  2 +
>  .../bpf/prog_tests/kprobe_multi_test.c        | 39 ++++++++++
>  .../bpf/progs/kprobe_multi_session.c          | 78 +++++++++++++++++++
>  3 files changed, 119 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sessio=
n.c
>

Given the things I mentioned below were the only "problems" I found, I
applied the patch and fixed those issues up while applying. Thanks a
lot for working on this! Excited about this feature, it's been asked
by our internal customers for a while as well. Looking forward to
uprobe session program type!

> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/sel=
ftests/bpf/bpf_kfuncs.h
> index 14ebe7d9e1a3..180030b5d828 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -75,4 +75,6 @@ extern void bpf_key_put(struct bpf_key *key) __ksym;
>  extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
>                                       struct bpf_dynptr *sig_ptr,
>                                       struct bpf_key *trusted_keyring) __=
ksym;
> +
> +extern bool bpf_session_is_return(void) __ksym;

should be __weak, always make it __weak. vmlinux.h with kfuncs is coming

same for another kfunc in next patch

>  #endif

[...]

> +static const void *kfuncs[8] =3D {
> +       &bpf_fentry_test1,
> +       &bpf_fentry_test2,
> +       &bpf_fentry_test3,
> +       &bpf_fentry_test4,
> +       &bpf_fentry_test5,
> +       &bpf_fentry_test6,
> +       &bpf_fentry_test7,
> +       &bpf_fentry_test8,
> +};
> +

this is not supposed to work :) I don't think libbpf support this kind
of relocations in data section.

The only reason it works in practice is because compiler completely
inlines access to this array and so code just has unrolled loop
(thanks to "static const" and -O2).

This is a bit fragile, though. It might keep working, of course
(though I'm not sure if -O1 would still work), but I'd feel a bit more
comfortable if you define and initialize this array inside the
function (then it will be guaranteed to work with libbpf logic)

[...]

