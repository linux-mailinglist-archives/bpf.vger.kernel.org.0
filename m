Return-Path: <bpf+bounces-17732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 911968122E1
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D951C2144D
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 23:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3962677B47;
	Wed, 13 Dec 2023 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN9Q8vyb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8216DDB
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 15:33:49 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c2a444311so72723145e9.2
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 15:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702510428; x=1703115228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwS4QoeDisZZ+AfMroyYHNuWHP1EELroD7YCslNhpwI=;
        b=MN9Q8vybmUgXUo5QXZfAUGdmyqMoW8jkF2aAuq/LRnQDQfU5t2psiHJaILgY1Z9OFZ
         ruxZiGUyVxrAdfEVS5sda15JOW66h/ewsRfjny1iaJPRlCMTJx/dNG3uTH4Z+0OH0W/S
         832BK3O3huQC72nxE7JMrx9NEAvkOTQVz0I7bjvOSAoXYHNNGciopd289TBbMvj44TFk
         UiJTRKLk7kg7EpH6+oQrDLMn3ssURHWTbhiDLdkU9/BRr4IzkZpjS6XRWRYF8OBXA4fC
         KP9nNzhF++gTsZXsFes3bsBYXL5m+xGpPOS//EcJgDdSsj+Q8O9tXjrxKN9NuyuL/tHd
         bf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702510428; x=1703115228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwS4QoeDisZZ+AfMroyYHNuWHP1EELroD7YCslNhpwI=;
        b=IRir/qNG3jgdxYPD9nYffxW/CqhHxn2jM2UJXrqiotiTxI8WM/Ae7hfBfrdyHncj1D
         MbKKdqV90E0p3AZ9fSZE2p4jtWpdsU3s6LSpGcTFaQ3JbjiSOE2JZ52nU8RJOW6ZcaHk
         ES6RT1cxsIYVhd0z8yHRo9eQcYGiNMW7GsWFrpr/rt0nnRQw6CIUe3xNCRjRKyG5aqHx
         diVkAk0ftk482r2gpBgUg9za1o7UuSkl6gUh6+78B7+Ifq/dMhUyUI5s3AKmVtPpxAPu
         ldZW1pcdLhxbBj9HaMO89KtfnqFqFIj5p+L48qmkvqdUeCiAEmQm1vCUYUOQu/u6UW9Z
         l28g==
X-Gm-Message-State: AOJu0YwEZLqWdbjc+vZ1u1Gpq+Cxw8z3AptHtmqBHSelcDKjAcbaJr0e
	s/liaSP9AqIu589UcbOg3/KcjmVw16D9sg/OdLg=
X-Google-Smtp-Source: AGHT+IFtqwUf1ccCNDfdLPcrDp0vJoDcDeUMbAlknKiW+MAlEgp3sq5BZV3RZ2EQfCqtvPJZmOXtMtODCp13/Mx3eYg=
X-Received: by 2002:a05:600c:2483:b0:40c:3314:5be0 with SMTP id
 3-20020a05600c248300b0040c33145be0mr2073455wms.295.1702510427761; Wed, 13 Dec
 2023 15:33:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213112531.3775079-1-houtao@huaweicloud.com> <20231213112531.3775079-5-houtao@huaweicloud.com>
In-Reply-To: <20231213112531.3775079-5-houtao@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Dec 2023 15:33:36 -0800
Message-ID: <CAEf4BzbHu3t+Bg3wA2ZMWzw3PTgMtaq0w-McjU3Hje=GUTYK8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Add test for abnormal cnt
 during multi-kprobe attachment
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, xingwei lee <xrivendell7@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 3:24=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> If an abnormally huge cnt is used for multi-kprobes attachment, the
> following warning will be reported:
>
>   ------------[ cut here ]------------
>   WARNING: CPU: 1 PID: 392 at mm/util.c:632 kvmalloc_node+0xd9/0xe0
>   Modules linked in: bpf_testmod(O)
>   CPU: 1 PID: 392 Comm: test_progs Tainted: G ...... 6.7.0-rc3+ #32
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>   ......
>   RIP: 0010:kvmalloc_node+0xd9/0xe0
>    ? __warn+0x89/0x150
>    ? kvmalloc_node+0xd9/0xe0
>    bpf_kprobe_multi_link_attach+0x87/0x670
>    __sys_bpf+0x2a28/0x2bc0
>    __x64_sys_bpf+0x1a/0x30
>    do_syscall_64+0x36/0xb0
>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
>   RIP: 0033:0x7fbe067f0e0d
>   ......
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
>
> So add a test to ensure the warning is fixed.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  .../selftests/bpf/prog_tests/kprobe_multi_test.c   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> index 4041cfa670eb..802554d4ee24 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> @@ -300,6 +300,20 @@ static void test_attach_api_fails(void)
>         if (!ASSERT_EQ(libbpf_get_error(link), -EINVAL, "fail_5_error"))
>                 goto cleanup;
>
> +       /* fail_6 - abnormal cnt */
> +       opts.addrs =3D (const unsigned long *) addrs;
> +       opts.syms =3D NULL;
> +       opts.cnt =3D INT_MAX;
> +       opts.cookies =3D NULL;
> +
> +       link =3D bpf_program__attach_kprobe_multi_opts(skel->progs.test_k=
probe_manual,
> +                                                    NULL, &opts);
> +       if (!ASSERT_ERR_PTR(link, "fail_6"))
> +               goto cleanup;
> +
> +       if (!ASSERT_EQ(libbpf_get_error(link), -EINVAL, "fail_6_error"))

this is unreliable, store errno right after the operation before
ASSERT_xxx() macros

> +               goto cleanup;
> +
>  cleanup:
>         bpf_link__destroy(link);
>         kprobe_multi__destroy(skel);
> --
> 2.29.2
>

