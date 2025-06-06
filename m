Return-Path: <bpf+bounces-59925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9257BAD0930
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 22:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF896189F140
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 20:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C7A2185A0;
	Fri,  6 Jun 2025 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9DjOLmA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419201DE887
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243213; cv=none; b=oGFBkmgkBc41Rsi8nLdarLzSdzRXXlpIdj+Hu16UwGf1McR9LD8EohOAylnKnKnrnVkZiBAkt7Sg9XS93CFe1D3OcpTAgud05zD7u9P6MnmiuWYgXv2kDSrIq5MOnne3W73UKq9GwojvtygBYM6wwi10MFvsOkWrs0TS9oViS7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243213; c=relaxed/simple;
	bh=F9LTagr2Fh2zelSLKCBCTnQXJQiDTJ+cMAhBOnqgrJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9wZAp100302Hj8NnvcwVtdsDJGaZDkBktg5svC69JiFvsRlI1kznYKgXs2kLdp7Nn5i96cRgTgsmiQMM3GT4BbgK9ON+Bz0j2YcY5xqItXoD5R3LtKUVILMnLZu7JdL0ZRR+MUmZanM9Xkv84N0xnJ52mdek84p5W+BHMlz2B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9DjOLmA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso23518465e9.2
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 13:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749243209; x=1749848009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MignPCS61pk0vm1qQ1ywny+6GXztivphDQcMBkvPhs=;
        b=F9DjOLmA7t+hYXbTKmxSqpXu0+kMYTO/EmqTEm9qTFyHhUFV0x3pG0ZXk6o1V9CEVk
         zeqPvcs7DMUZ9q+r1GtF22u6rDBuI/bDt7flTCCggPm8PcGXIsbUzjRiUHn8qsTYf6+C
         ewCfEMUlQYLOpIyeTnMcdRttTmBNsFt9b+6rR/A2/zFdIdG3RVk6cCyUUkV9f/0srjYj
         E5ws2ue5pB0xN9cz2f4bWBGtRH6Lm3tVrp7u6Dd6BRjBn0JmawIWkkc/yKIb8DpYcLxF
         UIvOhbeEGpvGC9hXpo2qVIijH00g98ZHGbm8TtA1xMjFIvx6UnU+jDuQYfPKcrlPIl+E
         MO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749243209; x=1749848009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MignPCS61pk0vm1qQ1ywny+6GXztivphDQcMBkvPhs=;
        b=oljeukzJQEdYtEXaDkKVpY1xJnh2dT7PNlbCCI0PkaQsY9EZe02dwZNCzTzCfiOz0x
         whlp812HpsJbsB844l1QQ3ovMjDxI/mbdfmhDNg8AOdWM7vHzE8kacvjOS/jL2WZkctg
         InG+iiINR+RFHd6drj9Ypr4pk1Z1LbGoVR2NmlZLLU1fFudH49RsAL6zDATM3rKji3+t
         25BZqf10QRLYkFQssyioOJ6KxoSyY6huUKsCri9ifEHh1c4AOAxOQ8ERHu0WijCStCSg
         rqNOh9q1Zu16Rt/zSIywhGFblNZPz2+fB407UH7xw+7cL2LqYMjS8exXn/rEAwr4i1Lr
         pHWw==
X-Gm-Message-State: AOJu0YzhmLNg4cwqgJjwrFZfHVOAombiRYf8K5fMZtJ6oELJ7mjpkDjj
	JMK+6bnCU+Rkxu07sKxlTsciIx8Ig9L+JAzF0CIgmz8UGh9d8aKJ3jkACjD1CDEtvlUi6a0GnrA
	T1a5bZEGjaspENvVCx1uGwD5FFzM6JLI=
X-Gm-Gg: ASbGncuIDA27oUYOcjEFQtDbKO4WrNqMcvvKvwKZdsOzj67fHkBlqhCrG3tVn+ESFKg
	eV1HBwMfbLTqUgztHK8qAt8GV30nKv8HPncgKyvWRIrO5jqGaLZSEHVaICA34x6YwmTGk9ALcGT
	PS6TLsvVlgMMCC5QoG791VGMIRjZN8sQDGo+iB/Ze/lbZV/dn3yintyKgg8HwwvQDb6nbUIcgY
X-Google-Smtp-Source: AGHT+IH0Uwi2rZs/k5R5FlcTrVg6hIogZnXUjzd+I9T0HapIr9+cg7fCcWG9Wjajf0JbxqF8OaEDM/chwbJWrNbqGn8=
X-Received: by 2002:a5d:64c5:0:b0:3a5:2ec5:35a9 with SMTP id
 ffacd0b85a97d-3a531882274mr3667273f8f.3.1749243209237; Fri, 06 Jun 2025
 13:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606174139.3036576-1-yonghong.song@linux.dev> <20250606174155.3037298-1-yonghong.song@linux.dev>
In-Reply-To: <20250606174155.3037298-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Jun 2025 13:53:18 -0700
X-Gm-Features: AX0GCFukYwVVWQKzQdaH4iDeO_zvZfmRCiIp7TeJ7_T6tUNHon-13SYbIm2gHCw
Message-ID: <CAADnVQJ+eOP7N4ihV6fkOQHiEc6fkH4qkcJnHogUoLWexsj-PA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Fix ringbuf/ringbuf_write
 test failure with arm64 64KB page size
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 10:42=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> The ringbuf max_entries must be PAGE_ALIGNED. See kernel function
> ringbuf_map_alloc(). So for arm64 64KB page size, adjust max_entries
> properly.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/prog_tests/ringbuf.c       | 5 +++--
>  tools/testing/selftests/bpf/progs/test_ringbuf_write.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/tes=
ting/selftests/bpf/prog_tests/ringbuf.c
> index da430df45aa4..89fd3401a23e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> @@ -97,7 +97,8 @@ static void ringbuf_write_subtest(void)
>         if (!ASSERT_OK_PTR(skel, "skel_open"))
>                 return;
>
> -       skel->maps.ringbuf.max_entries =3D 0x4000;
> +       skel->maps.ringbuf.max_entries =3D 4 * page_size;
> +       skel->rodata->reserve_size =3D 3 * page_size;
>
>         err =3D test_ringbuf_write_lskel__load(skel);
>         if (!ASSERT_OK(err, "skel_load"))
> @@ -108,7 +109,7 @@ static void ringbuf_write_subtest(void)
>         mmap_ptr =3D mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SH=
ARED, rb_fd, 0);
>         if (!ASSERT_OK_PTR(mmap_ptr, "rw_cons_pos"))
>                 goto cleanup;
> -       *mmap_ptr =3D 0x3000;
> +       *mmap_ptr =3D 3 * page_size;
>         ASSERT_OK(munmap(mmap_ptr, page_size), "unmap_rw");
>
>         skel->bss->pid =3D getpid();
> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_write.c b/too=
ls/testing/selftests/bpf/progs/test_ringbuf_write.c
> index 350513c0e4c9..9acef7afbe8a 100644
> --- a/tools/testing/selftests/bpf/progs/test_ringbuf_write.c
> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_write.c
> @@ -12,6 +12,7 @@ struct {
>
>  /* inputs */
>  int pid =3D 0;
> +const volatile int reserve_size =3D 0;

See CI failure:
|test_ringbuf_write.bpf.o|test_ringbuf_write|success -> failure (!!)|+0.00 =
% |

I think it's better to init reserve_size with some reasonable
constant to keep veristat happy.

pw-bot: cr

