Return-Path: <bpf+bounces-43418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9389B5479
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 21:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A2E280D8B
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 20:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32522076B3;
	Tue, 29 Oct 2024 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoaMAFjs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9C1200108
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235198; cv=none; b=eVR54MqMCisF54YwRDf2scqN+19SdaDxblRohvsfQLVamjgkveFZ+xbQ7aSoUxIn+JeE7TlYo26xVewe+cOTjsaeK0bl8CZu7tL4sqj02P2VIbbxG50ZQbq+jWOb+L+XJnCg3KBvSSNwk9jibQMuaJqyFPqSgMQIp/PDZkNiDSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235198; c=relaxed/simple;
	bh=v2QX+b0nQRkj5dqNLpgSIqYySw8nXgmMw/fpaj4LFH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5ompBagYkC7f8Rpxt8ef48olGT2i8aUrowy+vsi3Wp+PAuc4Up/FVjheYohoN2EmGUB39ibPMHbvMAhTDXGYBMqUGOfDI36FUKFkCPYmP+pl3CHgt7H+aJuzyKYJQ5TmQtu77OY2/hgqm+iAEqkqPe0I8aTNpiHD7ibXeTrv9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoaMAFjs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315eac969aso1628855e9.1
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 13:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730235194; x=1730839994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i19ivA4mC+uDrBoI/WHWPT7ZCA1WlXqk63z6rCMtIoI=;
        b=QoaMAFjs5mXcxb2TzXQs/ZXG8jiePW322+AK0Lf+aoL/DlYWeKtKSWu40GBTnQzwI/
         d+ZODzvRx/1BfOG50OAbUIBDWuBGHmZpc6aTK8wqHSvhKdK+4mfJPcUmN8mK0cB41fuR
         EPEetitgbu303cONyOoiDu8D0dgPmOC0CxbkcQjFYlG2E/oc1IdRKQR69IIRYYg9+hRp
         P/RTp4yajWeYP5pg4TQBLvIJWrMh9ndBLRne4il7rQIgXOHES6S055SAl9XzdNL+hrlk
         NVRYTdzsVaO8QZD46JlPLvKV1ASxlcVUllStgc/ieX6aN4GMr5b856uLy6vVnAhn0tba
         N5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730235194; x=1730839994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i19ivA4mC+uDrBoI/WHWPT7ZCA1WlXqk63z6rCMtIoI=;
        b=GMHotFmi2BSsjvmzXqfvWz3Gdkwj4UDkiT4xi5R7glRuxG8xSsyG9SEqLlIYF5ERj2
         yPscl9NlIamaxnloWKI+G9mdvxmZxBrjGb8xQdYJNswEFNzyysR+kihZrSmO/CE+bk6M
         2h7HEeYxcl3dEybOSVSN7uF9fgXWy2vFBwomU2/r3erUYj9SGJ/foHhh2heWrvm1mQRv
         vmFvoNChLLtkpDNbKke5IKLCrpOXMK1vfaGH+s/yFytIPrM8LC191Fi5HOBLejg6aKtw
         6po4anrQJjuEbgfsfotyXYQcc55bXALI0kFFTS06wd7kVNlqn/dzQxLhz2QSjdte1Yu9
         chLA==
X-Gm-Message-State: AOJu0YyPQ1LZt0jjlULaYukhk2vMs5ZpjfF5Px8DvZ0PHlIcjv9VGN33
	hqnqK4ahfu+XQDgVRCmODjXlUTQZyqc4+/rlYN4KGHLjDzY2pClCds+Vo8VrLiK3tvvO+aMj4JV
	w2TOdTXu6zpd2IGtvBh5P8cleP+g=
X-Google-Smtp-Source: AGHT+IE3mbCxLXai+fmuLUmQrNcDshuoPU3SMEU7H15fsVy98mjspMblGB5euF8yIEll0FyU7ZCWrzOIZAVMioDY8zg=
X-Received: by 2002:a05:600c:4750:b0:42c:ae4e:a96c with SMTP id
 5b1f17b1804b1-431b583b414mr30006155e9.16.1730235194286; Tue, 29 Oct 2024
 13:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025013233.804027-1-houtao@huaweicloud.com> <20241025013233.804027-4-houtao@huaweicloud.com>
In-Reply-To: <20241025013233.804027-4-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 29 Oct 2024 13:53:03 -0700
Message-ID: <CAADnVQKvHXEv_-MZpZBMPdDtptQuTjHhMUd0j+3j2DqhMV=w_g@mail.gmail.com>
Subject: Re: [PATCH bpf v3 3/5] bpf: Check the validity of nr_words in bpf_iter_bits_new()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Hou Tao <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 6:20=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Check the validity of nr_words in bpf_iter_bits_new(). Without this
> check, when multiplication overflow occurs for nr_bits (e.g., when
> nr_words =3D 0x0400-0001, nr_bits becomes 64), stack corruption may occur
> due to bpf_probe_read_kernel_common(..., nr_bytes =3D 0x2000-0008).
>
> Fix it by limiting the maximum value of nr_words to 511. The value is
> derived from the current implementation of BPF memory allocator. To
> ensure compatibility if the BPF memory allocator's size limitation
> changes in the future, use the helper bpf_mem_alloc_check_size() to
> check whether nr_bytes is too larger. And return -E2BIG instead of
> -ENOMEM for oversized nr_bytes.
>
> Fixes: 4665415975b0 ("bpf: Add bits iterator")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/helpers.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 40ef6a56619f..daec74820dbe 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2851,6 +2851,8 @@ struct bpf_iter_bits {
>         __u64 __opaque[2];
>  } __aligned(8);
>
> +#define BITS_ITER_NR_WORDS_MAX 511
> +
>  struct bpf_iter_bits_kern {
>         union {
>                 unsigned long *bits;
> @@ -2865,7 +2867,8 @@ struct bpf_iter_bits_kern {
>   * @it: The new bpf_iter_bits to be created
>   * @unsafe_ptr__ign: A pointer pointing to a memory area to be iterated =
over
>   * @nr_words: The size of the specified memory area, measured in 8-byte =
units.
> - * Due to the limitation of memalloc, it can't be greater than 512.
> + * The maximum value of @nr_words is @BITS_ITER_NR_WORDS_MAX. This limit=
 may be
> + * further reduced by the BPF memory allocator implementation.
>   *
>   * This function initializes a new bpf_iter_bits structure for iterating=
 over
>   * a memory area which is specified by the @unsafe_ptr__ign and @nr_word=
s. It
> @@ -2878,8 +2881,7 @@ __bpf_kfunc int
>  bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, =
u32 nr_words)
>  {
>         struct bpf_iter_bits_kern *kit =3D (void *)it;
> -       u32 nr_bytes =3D nr_words * sizeof(u64);
> -       u32 nr_bits =3D BYTES_TO_BITS(nr_bytes);
> +       u32 nr_bytes, nr_bits;
>         int err;
>
>         BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) !=3D sizeof(struct=
 bpf_iter_bits));
> @@ -2892,9 +2894,14 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const =
u64 *unsafe_ptr__ign, u32 nr_w
>
>         if (!unsafe_ptr__ign || !nr_words)
>                 return -EINVAL;
> +       if (nr_words > BITS_ITER_NR_WORDS_MAX)
> +               return -E2BIG;
> +
> +       nr_bytes =3D nr_words * sizeof(u64);
> +       nr_bits =3D BYTES_TO_BITS(nr_bytes);

The check for nr_words is good, but moving computation after 'if'
feels like code churn and nothing else.
Even if nr_words is large, it's fine to do the math.

>
>         /* Optimization for u64 mask */
> -       if (nr_bits =3D=3D 64) {
> +       if (nr_words =3D=3D 1) {

This is also unnecessary churn.

Also it seems it's causing a warn on 32-bit:
https://netdev.bots.linux.dev/static/nipa/902902/13849894/build_32bit/

pw-bot: cr

>                 err =3D bpf_probe_read_kernel_common(&kit->bits_copy, nr_=
bytes, unsafe_ptr__ign);
>                 if (err)
>                         return -EFAULT;
> @@ -2903,6 +2910,9 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u=
64 *unsafe_ptr__ign, u32 nr_w
>                 return 0;
>         }
>
> +       if (bpf_mem_alloc_check_size(false, nr_bytes))
> +               return -E2BIG;
> +
>         /* Fallback to memalloc */
>         kit->bits =3D bpf_mem_alloc(&bpf_global_ma, nr_bytes);
>         if (!kit->bits)
> --
> 2.29.2
>

