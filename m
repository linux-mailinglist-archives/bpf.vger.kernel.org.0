Return-Path: <bpf+bounces-60364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37638AD5EFA
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 21:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A8F189E8D5
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 19:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B1D29B772;
	Wed, 11 Jun 2025 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk7MgERN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3AC28B41A
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749669901; cv=none; b=WvbvZBR8ZlHIR7eDBdv1/0H85Cq/kSH4OpT9uKqB6welgit8lrC7k6HSYvfwTRW6cZPTG8Ewo5Gsova8EdXZ/DrNRNT/PukzevNp26IlcbIUBAAU4ipl1ChpI8w4r+5v1fjppk7cjt3LHoetB7Du0qaiYqQd/g9PbOxCuATz7po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749669901; c=relaxed/simple;
	bh=1KEUuOWIoMMMaS7jwbT6VP/xgFNf3RU0+NAYdyPQPIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEQVqUApl54icG1Feg+vatBa5uNXShawhnTqf4RP1X0il6Vr0AqLf39ma45uzUKtJAmA/ff2LtIfVETXYKQL+YeQEkefmFEaGIs+EVejCkWheQAyVPQrMrIkRgHoXW7dmifHxaeKFBHl+bMui3majqYHPu+/+5OV6Jb6IogwAKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fk7MgERN; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a54700a463so96225f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 12:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749669898; x=1750274698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjjLT6rBuOStoM59Ft4DetMCIPLuL/q8OmCXsGYJN7Q=;
        b=fk7MgERNT1T4zqzU4DRwyH8Zl3b+DWc6yANJ3nKETs1+RtE+13bUD7Q4JsCGEfV3Ez
         sHecsOMxT0q0bBJp9GBehEUYqwzq1/1E5lNwjlS46iA+BoX41nadADkEcNhRT1BT8z8A
         irExHID3orBmBHvoCusGh6G8IM2hUaEStJYDTvDlbgcUKwBGbPWWhbdG1qsD7gd6JSED
         SNwuGfnVhT+3Dm/u1Mq2N1eLq/LybYxCJ2psCnA6VSq/rB+G1QbCQ703rkzzpCzzZVtc
         tzozqjxCrB1C5ORM8x8kXnuB0VgTzh22X0AlU5DLWTy8k+nHSMVINAE4/zV0P+KrYmk7
         /Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749669898; x=1750274698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjjLT6rBuOStoM59Ft4DetMCIPLuL/q8OmCXsGYJN7Q=;
        b=T1lI39DeN0PyfvnY3vJEdeJt3F3BhxY64ZMLxYjeAe6MQCs7FkKgWEqK14W98+8cyU
         0akI7Tw6dW894oSHpuYFT7+ZvUkwLPHrLt5Y0v/k1WNtJTXmNJRdXWXkE9PPfFSGXdVD
         KBAPjHILfC0alfSserDdU8p3xaME9KUBePK0LpgOCFUT39oIEFqEiOrAQrqPWv/fOZnH
         Sw7lw7jOX4v7oGl4wOk6SRYthlBhB2Ya0ABc+JLatE51TBlv72wTg3zv7CGiIKRuwUHI
         2qVY8NJWzB72VXXoF0N2g+ke3iAZ8YD88tboLmjEo/KlQlX9y1S9q97bgC5ziCTbtopL
         sDWw==
X-Gm-Message-State: AOJu0Yxcl0uI9nM0GgOcpB2H+7Pg6V9c0swJKnpE3QURpATNI6unC/BT
	K6+zSxnmz7WLbkJDF2O9GDq9XXEICc+w5MHifPuFJ+Eg3OjEFUP4AixzlH8t2+xmhTHWUwojaRq
	bZGVVmdBPdLzfyoR+5bJS/CynwMT3HWs=
X-Gm-Gg: ASbGncv6jlEvG/Ytu8Md4GL9wG1lvOlJECCEUpKmBcdC9qzSelBP/Y7cr8u+fiai15N
	ntqqgL769el/nVJTGXjEuo4vEuQkcuqoSSA8fS8Q3Gjn6SLJyi34DsrIRKrj4o+uCG/ObZTPnM8
	MhK6qtfmqmh7h9aGy5IRLJImz/bLpEKzSAvXCVZFW5sZv3PTMbhNFzlrAhyRlSo1YYisYvACZT
X-Google-Smtp-Source: AGHT+IHGO01923shTlMVmeXP77mTGojoLjuak4c25FOK68ySVx1UC+5hik+6R5Ez064lLgk/RAAcAdAPalhkjatrEj4=
X-Received: by 2002:a05:6000:2207:b0:3a0:b565:a2cb with SMTP id
 ffacd0b85a97d-3a56087efccmr525155f8f.1.1749669897634; Wed, 11 Jun 2025
 12:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611171519.2033193-1-yonghong.song@linux.dev> <20250611171524.2033657-1-yonghong.song@linux.dev>
In-Reply-To: <20250611171524.2033657-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Jun 2025 12:24:45 -0700
X-Gm-Features: AX0GCFscvslHHnfxxPzc9-Qo6EBnDGtRl1HWz0Hh_ZNY5JidIJEWjHjGjT7hdRg
Message-ID: <CAADnVQL3mBq_45EZcjFQeNMAeJXzT=TMAQo+1XpTcZxWLrTdkg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Fix an issue in bpf_prog_test_run_xdp
 when page size greater than 4K
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 10:15=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> The bpf selftest xdp_adjust_tail/xdp_adjust_frags_tail_grow failed on
> arm64 with 64KB page:
>    xdp_adjust_tail/xdp_adjust_frags_tail_grow:FAIL
>
> In bpf_prog_test_run_xdp(), the xdp->frame_sz is set to 4K, but later on
> when constructing frags, with 64K page size, the frag data_len could
> be more than 4K. This will cause problems in bpf_xdp_frags_increase_tail(=
).
>
> To fix the failure, the xdp->frame_sz is set to be PAGE_SIZE so kernel
> can test different page size properly. With the kernel change, the user
> space and bpf prog needs adjustment. Currently, the MAX_SKB_FRAGS default
> value is 17, so for 4K page, the maximum packet size will be less than 68=
K.
> To test 64K page, a bigger maximum packet size than 68K is desired. So tw=
o
> different functions are implemented for subtest xdp_adjust_frags_tail_gro=
w.
> Depending on different page size, different data input/output sizes are u=
sed
> to adapt with different page size.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  net/bpf/test_run.c                            |  2 +-
>  .../bpf/prog_tests/xdp_adjust_tail.c          | 95 +++++++++++++++++--
>  .../bpf/progs/test_xdp_adjust_tail_grow.c     |  8 +-
>  3 files changed, 96 insertions(+), 9 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index aaf13a7d58ed..9728dbd4c66c 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1255,7 +1255,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, co=
nst union bpf_attr *kattr,
>                 headroom -=3D ctx->data;
>         }
>
> -       max_data_sz =3D 4096 - headroom - tailroom;
> +       max_data_sz =3D PAGE_SIZE - headroom - tailroom;
>         if (size > max_data_sz) {
>                 /* disallow live data mode for jumbo frames */
>                 if (do_live)
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/t=
ools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
> index e361129402a1..133bde28a489 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
> @@ -37,21 +37,25 @@ static void test_xdp_adjust_tail_shrink(void)
>         bpf_object__close(obj);
>  }
>
> -static void test_xdp_adjust_tail_grow(void)
> +static void test_xdp_adjust_tail_grow(bool is_64k_pagesize)
>  {
>         const char *file =3D "./test_xdp_adjust_tail_grow.bpf.o";
>         struct bpf_object *obj;
> -       char buf[4096]; /* avoid segfault: large buf to hold grow results=
 */
> +       char buf[8192]; /* avoid segfault: large buf to hold grow results=
 */
>         __u32 expect_sz;
>         int err, prog_fd;
>         LIBBPF_OPTS(bpf_test_run_opts, topts,
>                 .data_in =3D &pkt_v4,
> -               .data_size_in =3D sizeof(pkt_v4),
>                 .data_out =3D buf,
>                 .data_size_out =3D sizeof(buf),
>                 .repeat =3D 1,
>         );
>
> +       if (is_64k_pagesize)
> +               topts.data_size_in =3D sizeof(pkt_v4) - 1;
> +       else
> +               topts.data_size_in =3D sizeof(pkt_v4);

Please add a comment that magic data size is a special
signal to bpf prog:

>         if (data_len =3D=3D 54) { /* sizeof(pkt_v4) */
> -               offset =3D 4096; /* test too large offset */
> +               offset =3D 4096; /* test too large offset, 4k page size *=
/
> +       } else if (data_len =3D=3D 53) { /* sizeof(pkt_v4) - 1 */
> +               offset =3D 65536; /* test too large offset, 64k page size=
 */
>         } else if (data_len =3D=3D 74) { /* sizeof(pkt_v6) */
>                 offset =3D 40;

and comment about 90000, 90001 sizes.

