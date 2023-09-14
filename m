Return-Path: <bpf+bounces-10073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EA37A0C99
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 20:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB41C281BE2
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C34266B7;
	Thu, 14 Sep 2023 18:17:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0807518E1B;
	Thu, 14 Sep 2023 18:17:43 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1530C1FD7;
	Thu, 14 Sep 2023 11:17:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31ae6bf91a9so1231900f8f.2;
        Thu, 14 Sep 2023 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694715461; x=1695320261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slgEAK+XoFog52OsY7C5eWDU4QO7+bjpMrPdH4n5j/g=;
        b=jBkVvJPDPeCwON89BeCJ2C8gPNHQo40lZ4q+6QJK2AAQNFgxsTcK8eV4piGFIDeRXh
         gGkn91KfEYv85qdqU0tJEE6bXbvsh8EWM/Mhc/6t3iBm9TWQnPvc+ABjLzn0cyPKw2Sh
         kyUBhc49Mj3gn5OBLUYOBa7pdfr2f/fhPnUdRbv9zt1uoR6f0k/cio0HW0Rk2x9zAOUR
         KGS01A35+aQbsAU6FNev2CFAuYLlk+E4qqSVNbkfhpv5XRXxQ/Gf31RipF4Kc8zypJdd
         z2LoH+rFnpNAr7Qd+CRFhFsIqM63P/GtYYC6IPvUqe44j/I0mLCvWECA6Qhx+avV7hRk
         T2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694715461; x=1695320261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slgEAK+XoFog52OsY7C5eWDU4QO7+bjpMrPdH4n5j/g=;
        b=pMc9YU43pLzDMZ+QjOO285i4l8G8JhA9E/t8c3Q5tuvSfng9/EaE1nbga3BnE5Uc5s
         axdilaIGE03ojAikSB+c/wYYnNi6JeFqi9/axu0igAUlJY9FVnIBZWhSvGJHdUWXzKR7
         aVUSTLkNvXnyANw5TXSI3bAh1UGwPuuBTcBgmUCa+eKQrjpNGithmgPErOQU3ToQQXzX
         VBN15pTQeIQat/vmPVz5uIV+hI9OH8y5m3GF8LtP5utKnqo5xsCI8MVbO9lXv7MxBFDL
         YU0/SPOla6HqQpon7HgFyHWSeLdPVCu5IFObQga5G6CZRxWAX1MQgVemgRZkQ9SCKXQS
         kgow==
X-Gm-Message-State: AOJu0YzuyFo8JjlKq8nNvr936Iuj5EmhI6hKIaYvTn53srPU7AtiVDWP
	sHePTUh52SnbQrqwNwAK/arG3uA9daTP+J+UF1OPe+u4/Ak=
X-Google-Smtp-Source: AGHT+IHescFL/juEmVe99nxg45LPqBJUBmV9LSzGNUPX3mQ/Z61pHUW6jN6QvgQxmkHxa8Zup2aqNHQW/QMd/WIHwyM=
X-Received: by 2002:a5d:6a11:0:b0:31f:a256:4bbb with SMTP id
 m17-20020a5d6a11000000b0031fa2564bbbmr4596839wru.71.1694715461194; Thu, 14
 Sep 2023 11:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914124928.340701-1-asavkov@redhat.com>
In-Reply-To: <20230914124928.340701-1-asavkov@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Sep 2023 11:17:29 -0700
Message-ID: <CAEf4BzaAgSSj7W7S4uX=NormhaG1=ty8XumTRcSSEPd0XC4ocg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: skip module_fentry_shadow test
 when bpf_testmod is not available
To: Artem Savkov <asavkov@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	vmalik@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 5:49=E2=80=AFAM Artem Savkov <asavkov@redhat.com> w=
rote:
>
> This test relies on bpf_testmod, so skip it if the module is not availabl=
e.
>
> Fixes: aa3d65de4b900 ("bpf/selftests: Test fentry attachment to shadowed =
functions")
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  .../testing/selftests/bpf/prog_tests/module_fentry_shadow.c  | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.=
c b/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c
> index c7636e18b1ebd..cdd55e5340dec 100644
> --- a/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c
> +++ b/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c
> @@ -61,6 +61,11 @@ void test_module_fentry_shadow(void)
>         int link_fd[2] =3D {};
>         __s32 btf_id[2] =3D {};
>
> +        if (!env.has_testmod) {
> +                test__skip();
> +                return;
> +        }
> +

you used spaces for indentation, please don't do that. It was also
obvious if you looked at patchworks status ([0]). I fixed it up while
applying, but keep this in mind for the future. Thanks.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20230914124928.3=
40701-1-asavkov@redhat.com/

>         LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
>                 .expected_attach_type =3D BPF_TRACE_FENTRY,
>         );
> --
> 2.41.0
>

