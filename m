Return-Path: <bpf+bounces-59795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CDCACF892
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 22:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1248617103B
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 20:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0031FDA82;
	Thu,  5 Jun 2025 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9VWKlme"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E6717548
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749154032; cv=none; b=uSnt2kle8734szIzymqFGGr4yxrVIxq0/RhuIVB2mbAqPhyCGElG4AWzxe4ovGJapWb5KNrvP2KMF9ic08AF3gg2Vd9bJXhfZ0sWyoXOO7OI1x4+4SbiWLbSLSizB0qI462xhykIR35Ijm+hN70fhKDGHSvekm+DvFqANzHdcqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749154032; c=relaxed/simple;
	bh=4y6bOAh3LezccjBU81YEe9PRxtjG8v/L93iU2uHGhB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7zYrHLL3X1Hc1nKQe3ANVO5FAcpSywrROeMHIAENt/HADxYByAUmnhqIBEBHaeLYffS9gaBbYJ7xNFcfjld04fwe2cn+VJ5UTE/N5VQjbrTpQyYN4pk5M85HwQ+h8NqXNcMoOCIo/9gWapt/YCg7mT2EYSZOJZEFhVX9G41zxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9VWKlme; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2d46760950so1391638a12.3
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 13:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749154030; x=1749758830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJjbzVHFjg3Y6z8KCB32S7BynoUA2s/HHYlqsAeq6lk=;
        b=a9VWKlmewM5ZnhNN6Ifk/cBwpXC9h8dzE8RY9ZiJdVfafyINkgxuyBR9zzNjUbzXJv
         lzI8Sbq//mCNtWrTfx5EEiXwnIF2MJO5EXLN9Ei/MMRl2sC+IO1IODN+ZpzyWBMw9wJC
         g0+PJafJJtqRwqy7jYm0Ina6e8RnMJjfBqzKwsIcZ6vRfMWuyUYPPMqyjRbhDae51tXb
         AAqcnMoSJxAi1u71Y3xpVoIOvNR0h3ZbSSfm1DX/CU9Oo/uPRb0oL2f7qek8honndVgt
         ljticUDBsjVob70wGumMAlOWvUwaOfYzxEgTPL2Y5srfF0mpqFxIrvm/gDybaogSukGE
         ocqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749154030; x=1749758830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJjbzVHFjg3Y6z8KCB32S7BynoUA2s/HHYlqsAeq6lk=;
        b=A/ITod6LK2QmwLzBFQ/jFHSJXsKfjhpY7PDmEUizkS9vzASX7g2gwhOH7l45hHyaee
         XWQJk7ejhvyriMonMxm+E+zP9QpwOJN/oZMBegfui4NP5l9aQXfETkD+NhVMicnrC9M+
         7GyHrST94E8E2+yBqjglZea4jHxqkmCjgyRDLKqh/6y6QYS5n3lndRc/73Tiw/m1ppeq
         Cf4WwNbF77rl+RCq15VUFFZ4NnkrQklN7x1Fj2gAxtUd/5C5Qd+v32vNnZ252IyvolXy
         zB21SdoaR2FD/toJTywDR5g6d3P5twqRbMB4XF/PngPGKujzFAoYjK2TWeMBEmWgoplW
         Bhag==
X-Gm-Message-State: AOJu0YzQNAgwM4hY1SdAepIPcLoEV0sRVOKRmzMEGDSBiYZn1Mz1h3pB
	htYI0WWTw4tkfEiPR44myg4f0ZdxB6/GEMFQuyXiqkuF2gPVFsyPm4SgeLunr/VENSTZVc2RMHB
	ivNCLjF1+3xXBoW2s83gRgfkw1B62DxI=
X-Gm-Gg: ASbGncunlfTZ0hZ5DEWuRa27fj0Monl8VKTUamzfF7T+Nwy8ZKI3xmowrEs7vftukPY
	03BOyoXd9XHb0rTvWXnY6lZwpyyWFUAqP+87FjsfCvPON6422dI93Qvbb6M1MZIe7BfsqUkTMak
	boXlAP4hEZt4ZuG+EIT+EYfnPAxdXbLgOA6maQ5xttWCgKw5vD1NQI224KCk0=
X-Google-Smtp-Source: AGHT+IFz+IwDEPNyOyWA398lO9mfRRtWfu/tF6gqpK3Jmp2gtr3hecos38Qdu3cjcetl4MF4gz1JRzC+qQsEOM8/g9Y=
X-Received: by 2002:a05:6a20:1604:b0:21a:ef2f:100b with SMTP id
 adf61e73a8af0-21ee2618f6cmr746275637.24.1749154029877; Thu, 05 Jun 2025
 13:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-10-memxor@gmail.com>
In-Reply-To: <20250524011849.681425-10-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Jun 2025 13:06:57 -0700
X-Gm-Features: AX0GCFvvkz7D4TA7c-285zL0-TN_1GXgd2GizSqyW6aSYspVKTqmoalq2d6HfCY
Message-ID: <CAEf4BzZ1w1j4CQdLyqGV_v0OkFDHi9NL+5EFGQDBBRnHwCXudw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 09/11] libbpf: Introduce bpf_prog_stream_read()
 API
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 6:19=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Introduce a libbpf API so that users can read data from a given BPF
> stream for a BPF prog fd. For now, only the low-level syscall wrapper
> is provided, we can add a bpf_program__* accessor as a follow up if
> needed.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/lib/bpf/bpf.c      | 16 ++++++++++++++++
>  tools/lib/bpf/bpf.h      | 15 +++++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 32 insertions(+)
>

LGTM from libbpf side of things, but please see nits and questions below.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index a9c3e33d0f8a..4b9f3a2096c8 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -1331,3 +1331,19 @@ int bpf_token_create(int bpffs_fd, struct bpf_toke=
n_create_opts *opts)
>         fd =3D sys_bpf_fd(BPF_TOKEN_CREATE, &attr, attr_sz);
>         return libbpf_err_errno(fd);
>  }
> +
> +int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *stream_buf,=
 __u32 stream_buf_len)

nit: I'd use shorter and no less clear "buf" and "buf_len". If
anything, the buffer itself isn't really "a stream buffer", it's just
a buffer into which we copy stream data..

> +{
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_stream_=
read);
> +       union bpf_attr attr;
> +       int err;
> +
> +       memset(&attr, 0, attr_sz);
> +       attr.prog_stream_read.stream_buf =3D ptr_to_u64(stream_buf);
> +       attr.prog_stream_read.stream_buf_len =3D stream_buf_len;
> +       attr.prog_stream_read.stream_id =3D stream_id;
> +       attr.prog_stream_read.prog_fd =3D prog_fd;
> +
> +       err =3D sys_bpf(BPF_PROG_STREAM_READ_BY_FD, &attr, attr_sz);
> +       return libbpf_err_errno(err);
> +}
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 777627d33d25..9fa7be3d92d3 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -704,6 +704,21 @@ struct bpf_token_create_opts {
>  LIBBPF_API int bpf_token_create(int bpffs_fd,
>                                 struct bpf_token_create_opts *opts);
>
> +/**
> + * @brief **bpf_prog_stream_read** reads data from the BPF stream of a g=
iven BPF
> + * program.
> + *
> + * @param prog_fd FD for the BPF program whose BPF stream is to be read.
> + * @param stream_id ID of the BPF stream to be read.

Is it documented anywhere that 1 is BPF_STDOUT and 2 is BPF_STDERR?
That seems like an important user-visible thing, no? In patch #1 these
constants are kernel-internal, is that intentional? If yes, how are
users going to know which value to pass here?

> + * @param stream_buf Buffer to read data into from the BPF stream.
> + * @param stream_buf_len Maximum number of bytes to read from the BPF st=
ream.
> + *
> + * @return The number of bytes read, on success; negative error code, ot=
herwise
> + * (errno is also set to the error code)
> + */
> +LIBBPF_API int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *=
stream_buf,
> +                                   __u32 stream_buf_len);

Do you anticipate adding some extra parameters, flags, etc? Should we
add empty opts struct from the very beginning instead of later having
bpf_prog_stream_read() and bpf_prog_stream_read_opts() APIs?

> +
>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 1205f9a4fe04..4359527c8442 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -437,6 +437,7 @@ LIBBPF_1.6.0 {
>                 bpf_linker__add_fd;
>                 bpf_linker__new_fd;
>                 bpf_object__prepare;
> +               bpf_prog_stream_read;
>                 bpf_program__func_info;
>                 bpf_program__func_info_cnt;
>                 bpf_program__line_info;
> --
> 2.47.1
>

