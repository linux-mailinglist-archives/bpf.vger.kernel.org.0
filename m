Return-Path: <bpf+bounces-72486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5463DC12B07
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 03:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEE0B35433F
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 02:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E584227991E;
	Tue, 28 Oct 2025 02:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzImj7CD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50872777FC
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 02:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761619692; cv=none; b=PwjLN8k81nbl1Y1cbqAIAxO7+ODEDzHDt4VqSq1faZPlvyEeKUvCa+zsLEiJtGjvRrHehlra8yYUxZOvYax5+nAbBmlb45Ej3/WYLetknFmS9Iw7RV+rR4zTB8+AGR/WN/S2wgCYXjnjaH+SmkexEw4K0iWfjLoBDNTtZTWvoQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761619692; c=relaxed/simple;
	bh=P133ugO0oRAJ5lqJ+kvgZ70C8wNhCC6C8esn00DpliA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJ4FmEPiXEfa05K5xb1AjuZlQsYbWeuEri3ChmCsJJnOJiyheL9Cf1k/DdygFnh5Nepu5ztVnqSwskCUXHtPZHPMRp1TDz4CcExhorqGEYuehWsmnfKTeVKovDrNWGyZrSwZRpBchkPopD/E/iKoJbVW8iaQJJcfoAER2bZqT30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzImj7CD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-290dc63fabbso52083565ad.0
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 19:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761619690; x=1762224490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnYoIohM8J7RUYGRyoc++DS+pfWvgx5L2qZ4JhdkzuU=;
        b=gzImj7CDCfOoJlsYVNtigzdtsH7YTcUlLcvl8Y7ncUcgjW4bZ4xtm4C7qVQNiHz04p
         cCzwKiUEgdxTF2w/tPde1nPqgAQnnncml96h1Ae9EPkWvM/WhZZuBb/Oybx2Einv5QKR
         1NEYjTgGDpfduwrQCzh3m759DEBMGSqgDslqKnhMO6rcWtA7kZ50x0fytiQP9uU0zrVW
         5WEGrAhXIANKhbaOdnHvVDTR9/WlMsFR5nJ5NQmnu8DsrRxK21jppS3MVp2lOzk8shxw
         621lDgMisBQO2raS8AApbbe1MklNQIQyuxIXYGj2VBmnrQ1nDG+wTzwYlktnNI9vQKlx
         hr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761619690; x=1762224490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnYoIohM8J7RUYGRyoc++DS+pfWvgx5L2qZ4JhdkzuU=;
        b=dsc+OSgZ72szwdPsQVZV9N7mLw6UR7nWb5RCkwJl9bjX5XGOtNCzMv5vrRGW7SHfHB
         nlXBuzFJ7tRomlcyrVj3ZZIUhWAHikDSDqdDXILmYvtoG9Zw/BgopiBHdhcpc8/q1NXj
         3O7bx0rBREI6zu2b/SVLiviDjy6peTSZlL4TKfKbdIM5JNeuKJPctMkVCa2EY4+FSq9f
         UoLnL3YBCkgjTlApgYz7wdotUEohzpC7QrbgKbDzqoyWWNjK77PrJ8H0B//2fAsGsyI3
         vLnZHcUhc6g/DO8L+AqmfVo28tacafGP5pZcbRg1zlolz/AGGFsLZ2bP7KezSsOID9/p
         f2FQ==
X-Gm-Message-State: AOJu0Yza77saPbKnZq6rE0Jxv4T1AxnwXH883uWdhnmlKXL/a1tI78EK
	hsfSXvZYuZoQM33iIlSuDzbvSaPchvT1fc7tyIxlVQSccJs7PzTLwMatcDiR/k3vYoFhRpAf8vb
	D2IjRhcHtOcLjz35l/nlf6zn6vckiGIY=
X-Gm-Gg: ASbGncuiL2RwcTmH0tA1w4e+U4st7Db8uzpurSAFFDdJYZ1b96uz+RCvQ165i+ullOT
	cHBRKtsL/NKtk9vFG6lTtL3MejjCkSi5YUbr8zy/vwK3XwES+CtcSROVBZ1mX/UB8uBDQ+aUURy
	euvIH6/sQDvylNepA2unRVXiZukwXSPYn7vg1XVrU/pnhH6hoT7wr07SgZMUzoZ5ZspUBxsSG0c
	37OTEya8Gdf1QS4jraG+iKSbLzIRjeFWA4f5CB6XoGe9WFY9HzeRw+pxIYH
X-Google-Smtp-Source: AGHT+IE4OTc4CA2DMSnqzZKdRIGhx0wcSiu1XDTn7Sh5xQejZHo0av83/Iw3z8vBvKt+g94pGgRUZK0ns4wrg492iyE=
X-Received: by 2002:a17:903:2341:b0:24b:11c8:2d05 with SMTP id
 d9443c01a7336-294cb528896mr22043145ad.45.1761619690073; Mon, 27 Oct 2025
 19:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018035738.4039621-1-xukuohai@huaweicloud.com> <20251018035738.4039621-3-xukuohai@huaweicloud.com>
In-Reply-To: <20251018035738.4039621-3-xukuohai@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Oct 2025 19:47:56 -0700
X-Gm-Features: AWmQ_bmLTA50C693ybQEZwxVuvvyvhN5Wgujlf7YTL-MKZh4dRU6wFOApfcV9no
Message-ID: <CAEf4BzZQfSBTqPwHE7fMTO1CbuoCYkFthUkCGvq3qT5CnT3-Eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Add overwrite mode test
 for BPF ring buffer
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 9:04=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> Add overwrite mode test for BPF ring buffer. The test creates a BPF ring
> buffer in overwrite mode, then repeatedly reserves and commits records
> to check if the ring buffer works as expected both before and after
> overwriting occurs.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |  3 +-
>  .../selftests/bpf/prog_tests/ringbuf.c        | 64 ++++++++++++
>  .../bpf/progs/test_ringbuf_overwrite.c        | 98 +++++++++++++++++++
>  3 files changed, 164 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_overwr=
ite.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index f00587d4ede6..43d133bf514d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -498,7 +498,8 @@ LINKED_SKELS :=3D test_static_linked.skel.h linked_fu=
ncs.skel.h               \
>
>  LSKELS :=3D fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c =
 \
>         core_kern.c core_kern_overflow.c test_ringbuf.c                 \
> -       test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c
> +       test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
> +       test_ringbuf_overwrite.c
>
>  LSKELS_SIGNED :=3D fentry_test.c fexit_test.c atomics.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/tes=
ting/selftests/bpf/prog_tests/ringbuf.c
> index d1e4cb28a72c..5264af1dc768 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> @@ -17,6 +17,7 @@
>  #include "test_ringbuf_n.lskel.h"
>  #include "test_ringbuf_map_key.lskel.h"
>  #include "test_ringbuf_write.lskel.h"
> +#include "test_ringbuf_overwrite.lskel.h"
>
>  #define EDONE 7777
>
> @@ -497,6 +498,67 @@ static void ringbuf_map_key_subtest(void)
>         test_ringbuf_map_key_lskel__destroy(skel_map_key);
>  }
>
> +static void ringbuf_overwrite_mode_subtest(void)
> +{
> +       unsigned long size, len1, len2, len3, len4, len5;
> +       unsigned long expect_avail_data, expect_prod_pos, expect_over_pos=
;
> +       struct test_ringbuf_overwrite_lskel *skel;
> +       int err;
> +
> +       skel =3D test_ringbuf_overwrite_lskel__open();
> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> +               return;
> +
> +       size =3D 0x1000;

this will fail on architecture with page size !=3D 4KB, I adjusted this
to use page_size, len1 to page_size / 2 and len2 to page_size / 4

> +       len1 =3D 0x800;
> +       len2 =3D 0x400;
> +       len3 =3D size - len1 - len2 - BPF_RINGBUF_HDR_SZ * 3; /* 0x3e8 */
> +       len4 =3D len3 - 8; /* 0x3e0 */
> +       len5 =3D len3; /* retry with len3 */
> +

[...]

