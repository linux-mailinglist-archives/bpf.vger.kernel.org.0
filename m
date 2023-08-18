Return-Path: <bpf+bounces-8098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4487812DC
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 20:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B596B1C21363
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 18:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2861B7E0;
	Fri, 18 Aug 2023 18:26:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9F04437
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 18:26:36 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3BC2D70
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 11:26:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc7b25c699so9217975ad.1
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 11:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1692383195; x=1692987995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcFAZflDlOYN7Mi+gmxf/1TGrccvrcOqmFuDIIIwWuI=;
        b=BegrPfGhEFi0/Lq95pJAepLJC/sFJ5l0KzFPNp6nf5r7eF4o7qMSzYyiL/IqDM0yJp
         yHofAYIvQkR/nB0IvWu4yuzthtJ5TdFwU/cwQxPIC1Uc9MsuZsYZdBn3/mYUTNF2eE97
         xhAfn1XYCeF+cjCKm30eQU3GjZUJQjmmeZrUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692383195; x=1692987995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcFAZflDlOYN7Mi+gmxf/1TGrccvrcOqmFuDIIIwWuI=;
        b=U8CIWwBJkpRSz7oQeNbo06cZDcLOXb0+utX1KcHgYQzwjnG7GUZEfHBH+ZOx+Tv2Yz
         IFoQYbnard12Q34iAD0dd2Stkt/FzvOzWYPmVeODS9rWMfIg2ZZKoWZ5+upar73muYzf
         CfXObeohqsm+vTbc+BFxjR6zRFc0a7CiEfnzXB61ny9mIHooAp9IiW4dbnsJBtpV6gWo
         rQDlUhsk9RbTWtkTCibqc9umjjNsDTdE3BNYW7z78BQqQ/Nc2YU50Mk5QL3NmaRtUptU
         SsrSyhty7qRqW+mr1VzMo1waprII7+0027i3w1HJT2eO2xH0t7rW8RorVaDZuSi5FiYO
         z1Sw==
X-Gm-Message-State: AOJu0Ywj8sR1QYgHD4qHkQa/vJucPILGd6QOTN14rtiG3zlyK7knqtXq
	WeIJ4SAmCbXg/dmpsR1dHyJhBPu0RjD0jHEclA64yQ==
X-Google-Smtp-Source: AGHT+IEf0xiHKIoTYTtJUDBeRCGw50Kdw0W2its63GmEzeWVh5raY7C0dZJkA4LlbrMrDGeigeFi4kpTanOWv57yBUk=
X-Received: by 2002:a17:903:278f:b0:1b9:d2fc:ba9f with SMTP id
 jw15-20020a170903278f00b001b9d2fcba9fmr2901412plb.11.1692383194842; Fri, 18
 Aug 2023 11:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814172809.1361446-1-yonghong.song@linux.dev> <20230814172928.1373311-1-yonghong.song@linux.dev>
In-Reply-To: <20230814172928.1373311-1-yonghong.song@linux.dev>
From: Zvi Effron <zeffron@riotgames.com>
Date: Fri, 18 Aug 2023 11:26:22 -0700
Message-ID: <CAC1LvL26-Gb-baphJoKUwdigR4rCqBYDz4D3JxGM+e3W9RTR+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 15/15] bpf: Mark BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
 deprecated
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 10:30=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> Now 'BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE + local percpu ptr'

I found this commit message very confusing until I realized there was a typ=
o
here. Shouldn't this be "Now 'BPF_MAP_TYPE_CGRP_STORAGE + local percpu ptr'=
"?

> can cover all BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE functionality
> and more. So mark BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE deprecated.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
> include/uapi/linux/bpf.h | 9 ++++++++-
> tools/include/uapi/linux/bpf.h | 9 ++++++++-
> 2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d21deb46f49f..5d1bb6b42ea2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -932,7 +932,14 @@ enum bpf_map_type {
> */
> BPF_MAP_TYPE_CGROUP_STORAGE =3D BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
> BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
> - BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
> + BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED,
> + /* BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE is available to bpf programs
> + * attaching to a cgroup. The new mechanism (BPF_MAP_TYPE_CGRP_STORAGE +
> + * local percpu kptr) supports all BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
> + * functionality and more. So mark * BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
> + * deprecated.
> + */
> + BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE =3D BPF_MAP_TYPE_PERCPU_CGROUP_STORA=
GE_DEPRECATED,
> BPF_MAP_TYPE_QUEUE,
> BPF_MAP_TYPE_STACK,
> BPF_MAP_TYPE_SK_STORAGE,
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index d21deb46f49f..5d1bb6b42ea2 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -932,7 +932,14 @@ enum bpf_map_type {
> */
> BPF_MAP_TYPE_CGROUP_STORAGE =3D BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
> BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
> - BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
> + BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED,
> + /* BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE is available to bpf programs
> + * attaching to a cgroup. The new mechanism (BPF_MAP_TYPE_CGRP_STORAGE +
> + * local percpu kptr) supports all BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
> + * functionality and more. So mark * BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
> + * deprecated.
> + */
> + BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE =3D BPF_MAP_TYPE_PERCPU_CGROUP_STORA=
GE_DEPRECATED,
> BPF_MAP_TYPE_QUEUE,
> BPF_MAP_TYPE_STACK,
> BPF_MAP_TYPE_SK_STORAGE,
> --
> 2.34.1
>
>

