Return-Path: <bpf+bounces-1885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDEB7232EF
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 00:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EB4281494
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 22:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A199D27729;
	Mon,  5 Jun 2023 22:07:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF932770C
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 22:07:36 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2599EC;
	Mon,  5 Jun 2023 15:07:34 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b1af9ef7a9so47447821fa.1;
        Mon, 05 Jun 2023 15:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686002853; x=1688594853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVq54lH3E2ODLnxs1hYNz0RLN2+8uJFJjH0uysXpNaE=;
        b=SVFhye3wWzm9siCPJAPvhmdYPJHXs984VZI3RhfJKGXLNHQXWFj8QiLUgcnmHACMjN
         ovtw27BBo0HlbmNBo30Mzy7FP2Qe7+ft5RCnmx+w7TmCB4kVCZcRIhjdPvq+4W2Xhhv3
         Iu626Cy4UPw6hg4mx9JIRa5LdeAUtZCoztGGpG7KUX4EYbdgGEC5/01k/yxltardorxe
         u6ds1wDIpaMZJyQx7m4IsJK+PVwe8LLI/ZqmJB+X6EthP2LKi0w0VAmduv2vJozgwpwi
         AznaFke/N0u4NfvisJfPpoOnRXaoyXEsZcRu+MLkdPtn6PK74hLn7r5EzCEES/Rk78gX
         YUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686002853; x=1688594853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVq54lH3E2ODLnxs1hYNz0RLN2+8uJFJjH0uysXpNaE=;
        b=dVH1+Mu1Hj3c9P+/0yJwzF0er+x8RGceevoiEUoNSpuq2VUKIfdIwyldSDu4HBrKx9
         JMnPiqzmOHPmi1qIZj8q/Jv650YY/v3V8lqUNm+wNzmQk3dDfp2iMAQz01cLTYwivCFA
         man9Se84EFQ3JDoKhOizWzfrsUPksASNnX+TBauLm6Vn2neC1toan2MSw6xusVaEgVGP
         VvXLjrIC8zpnlZlOu+S9xXxyVzY4Xn9RajJKwOuxzwIX9irTgGcVN3NE0MDIavN3t4Ff
         5UpbHe+EYUR+1HPw0W+L7hMHYRanTSX/eEfa6H8/mgObJfw6E46wBGUkiCOEMi0izvx0
         GZLQ==
X-Gm-Message-State: AC+VfDwfJ1w6E+G6VGO81Qb6LXGfy99UXiUSnwCR+qkiZ15kyouYM/tE
	Xu828RfD+gBayS4M6Qg6p5+cBmnAI3xLuhRDTh0=
X-Google-Smtp-Source: ACHHUZ59AXy2Fss5gsVw6c3+SVAkH1T0wfIiLNNBfO5iUP/nORAbNklHb2QBGc4sDSw2qq4U/dMLpKeb3+Qpy7XbChQ=
X-Received: by 2002:a2e:a406:0:b0:2b1:e6eb:1ba2 with SMTP id
 p6-20020a2ea406000000b002b1e6eb1ba2mr364843ljn.22.1686002852835; Mon, 05 Jun
 2023 15:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230605200508.1888874-1-void@manifault.com> <20230605200508.1888874-2-void@manifault.com>
In-Reply-To: <20230605200508.1888874-2-void@manifault.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jun 2023 15:07:21 -0700
Message-ID: <CAADnVQLZkUFtCwZEaRKMrdnDJzj-9_7fMYY9P55MndiNTrSnkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test bpf_for_each_map_elem on BPF_MAP_TYPE_HASH_OF_MAPS
To: David Vernet <void@manifault.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Dave Marchevsky <davemarchevsky@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 5, 2023 at 1:05=E2=80=AFPM David Vernet <void@manifault.com> wr=
ote:
>
> +
> +static __u64 set_invoked(struct bpf_map *map, __u64 *key, __u64 *val, st=
ruct callback_ctx *ctx)
> +{
> +       struct bpf_map *inner_map;
> +
> +       ctx->invoked =3D true;
> +       inner_map =3D bpf_map_lookup_elem(map, key);
> +       if (!inner_map) {
> +               ctx->failed =3D true;
> +               return 1;
> +       }

This doesn't look right. 'val' is not 'u64 *'.
It probably should be 'struct bpf_map *',
so lookup shouldn't be necessary.

map_set_for_each_callback_args() just sets it to PTR_TO_MAP_VALUE.
It probably should be CONST_PTR_TO_MAP.
Also for normal hash map for_each_elem 'val' is writeable.
It shouldn't be in this case.
So to cleanly support iterating hash_of_maps patch 1 needs more work.

