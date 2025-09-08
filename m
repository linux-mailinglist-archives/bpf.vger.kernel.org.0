Return-Path: <bpf+bounces-67760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392ABB4974D
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79B6201D40
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB6B3164A3;
	Mon,  8 Sep 2025 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzKRey9N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066B313E0B
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353003; cv=none; b=fFQyRWZmUCs2vab8CpPHQml/5k1rfqZ5xnwjz59mbM2JIc43DsJlPcpa8lEPNSlpWq+1tXuYoNs0ZW0nNr7+QA9fdGHWzHvDoMKgiOEQtIL4h5ugCV3goyLTDmXAlwz9P6akHIlWcVHwXlNcAnhNKc069o3KCPpBtbBmrA1kdaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353003; c=relaxed/simple;
	bh=mkuNlIrFC2yQD3qbQr2AQR2FtKo3hTeugvnOFix5rzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TipvkYAnXTI5Vm1AFZjD60TGiLVBvHMD1w4A/P0mHIKEi9bVYSYh10+Ha1bJPONo3zGXHO61eAf0ujWNbIseDRqBSsWu1CguISCEQzyCyVgr7S8n421znmcypVkWLuYT4AHvDQwGl4SXLTi6JSkWQWP3LBiZfecBfrJHG+V/STQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzKRey9N; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso39930325e9.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 10:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757353000; x=1757957800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5q7nZud5CctmZIwdY1ZKBJkSyfJNosLjDP9DnD36X8=;
        b=GzKRey9NqpMuPrOg0Gxg0/eygWkFZQiYekg1rFeTchqMgPsdvXrXch+bqSmqgEUm45
         lucFEmm8xk+NTHhHUoKPPrkBtVMpkPUket7SR83hLF9BENp73VYTroGoK6j9yR2+I55W
         8K4n416vqWbqMH4sNMQuSYPyOxUZsobrPqP2x64h7g/0NxEF/CMpPO5BKTuwvjT/yeJQ
         FVDhsnAUoZUk6lJBR6tSj4IRl3WM0ObkRqoQ8imYjBVj69HEOKBkhcnlb0cJHv49kNDv
         T5HmfVXMY1qKLAH1N9BbUqrQvqb2Ghkfy915xUEyTZrQp8e9+5a/SW3qZocUp/A9e0Ka
         wFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757353000; x=1757957800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5q7nZud5CctmZIwdY1ZKBJkSyfJNosLjDP9DnD36X8=;
        b=rHj12OBDHsH44XDeye2qg66ZIivVS8IjbQ9YXZWxfLB8h5dyXDsOhrb9gqaL+R+gRK
         2+0ir6ZpZ6BvPQxT6CjGBnmvdn30NLlhuVv/bVXECVeaKdgMn23YqcJKdjPN4dtrulRZ
         M/ZJC1gBZYnfGBd4JltIYJaBRN1vT8TYLJ3tK4BChGi7848eXxppR4ILqfsmBXw6+xrw
         r11tTFwvq4herYuXphLg+1QkA/7dZCqiP2btVVzEQWfRu0ZS0KcNC8yJqnoIgzo0PJRe
         ws2YAIBwmCPcx3jfLjeWaEHmXAMV0A6DEBXcQTvSToS5zB7N4fdhB3Gk8UIDKRmszSjQ
         u+kQ==
X-Gm-Message-State: AOJu0YzYFjOlI9NAYpI/HTS4vt6KoaFiRJJmtnEs9drW7HrBkLsHlCUv
	SjGU5vquwhtjAa4R2P2DsQHO9EXZ8Ur2RwLl1CZxTJNX0IRMivdYBLalC0Ln4/RI4Y3Zf+2ZqpY
	Ohs8LQsWOpU75RzCXK1dXFLamB12PxgU=
X-Gm-Gg: ASbGnctCyJKDpHahtCP87J8HxwmRaMjU74Af4AzKUdAuNl+RM/FYJO0M/pcndfpmw8c
	wj9YDXblmRdS3PLl2cjzHxyiPt+WyjXwmkCWpsbc3qea9G8zRUXfEPqFREZ15Um6eEeU9WTDR5e
	sDTgJuCWUn7pXCa583e1lFsLFtcoRjEX/+mBebFMYXFUFXr3MXSD/yVd+wnTIdtuS21orDqltTT
	8kgcISEVdW3nlFxQN5uyUn5b/HjgowWQ3OApl9x+UzhiVI=
X-Google-Smtp-Source: AGHT+IFspyvaRH4Z9HhXGi1MAhq+XRtIv+EIQDtGjj39/SrFDhskdcnGjhSGGDSBH/fKu3y9qOXFk6gbFzvO+4gYdnQ=
X-Received: by 2002:a05:6000:1449:b0:3e2:804b:bfcd with SMTP id
 ffacd0b85a97d-3e642bb7cb5mr7248889f8f.19.1757352999674; Mon, 08 Sep 2025
 10:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908143644.30993-1-leon.hwang@linux.dev> <20250908143644.30993-3-leon.hwang@linux.dev>
In-Reply-To: <20250908143644.30993-3-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Sep 2025 10:36:28 -0700
X-Gm-Features: AS18NWBTin2WE81HoWlsyiLa6qP5FV8TtKQa7D1ISqJOJbGLQNGvHpoktvnq85s
Message-ID: <CAADnVQ+iyKQAPAEAFhS-cgfRZyTorgiV57QTBdQiUengx2y2kA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/9] bpf: Introduce internal
 bpf_map_check_op_flags helper function
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 7:37=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> It is to unify map flags checking for lookup_elem, update_elem,
> lookup_batch and update_batch APIs.
>
> Therefore, it will be convenient to check BPF_F_CPU and BPF_F_ALL_CPUS
> flags in it for these APIs in next patch.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h  | 31 +++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c | 34 +++++++++++-----------------------
>  2 files changed, 42 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index ce523a49dc20c..55c98c7d52510 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3735,4 +3735,35 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, =
unsigned long ip, const char *
>                            const char **linep, int *nump);
>  struct bpf_prog *bpf_prog_find_from_stack(void);
>
> +static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags,=
 u64 allowed_flags)
> +{
> +       if (flags & ~allowed_flags)
> +               return -EINVAL;
> +
> +       if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BP=
F_SPIN_LOCK))
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static inline int bpf_map_check_lookup_flags(struct bpf_map *map, u64 fl=
ags)
> +{
> +       return bpf_map_check_op_flags(map, flags, BPF_F_LOCK);
> +}
> +
> +static inline int bpf_map_check_update_flags(struct bpf_map *map, u64 fl=
ags)
> +{
> +       return bpf_map_check_op_flags(map, flags, ~0);
> +}
> +
> +static inline int bpf_map_check_lookup_batch_flags(struct bpf_map *map, =
u64 flags)
> +{
> +       return bpf_map_check_lookup_flags(map, flags);
> +}
> +
> +static inline int bpf_map_check_update_batch_flags(struct bpf_map *map, =
u64 flags)
> +{
> +       return bpf_map_check_op_flags(map, flags, BPF_F_LOCK);
> +}

I don't like these pointless wrappers.
They make the code less readable.

