Return-Path: <bpf+bounces-675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 341BC70597C
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 23:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93425281384
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 21:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92985271F7;
	Tue, 16 May 2023 21:30:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54477290EA
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 21:30:58 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ACC6E88
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 14:30:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-965fc25f009so2413421266b.3
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 14:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684272655; x=1686864655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D305YLtWoV5cRc/VfuidUIjZ7QnYzoh+OGde0637/I=;
        b=To/K60+ZlRjQu5IAIOOO11HIKfz3kTxXlitqgKE+cru5dg0bem3M1flV7DBB2BufXD
         7Qq8MMd1U5mx7nQqfVBuL1q7Fobed5eN7DsMQR7gtaOXf+/7RZyDg4mytk1Nw6exOrAl
         O+RS58WzCraMb8/fNw4SJOO8uVD12mYyMFbaF/R4e/PEb5noekESQDI4CwhnL1XR9n4Y
         /fdOJipk/sMOe+TtmbMtoCDXmV5opfQ4jao0qyYYBMDr7lQn1jSPQ+txMX73+rL9+4zp
         wTCsN8pYGXSOUwc6NgGW6Sz/QzRQkk3qBqtuxgLIenEmnF5RL5gO5EksHQqhiHCYIej4
         GAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684272655; x=1686864655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5D305YLtWoV5cRc/VfuidUIjZ7QnYzoh+OGde0637/I=;
        b=C8OJqcBok+ASmUhSmjPiMGjG9DLdJdfhVrqlV2PkUb0pVmYaxZLOkJTyFESu0i2Zbo
         Z8YJHVJg7WDN6fHKaB4BoWQx+KSa5GOIuK5qkiRu7MmrqLoqM9kxmAIthyKgqvHgqhjd
         jTAnAGuYhmiZtAIoEDsJircKUBgQv9axRAWEGcjzE5FKAMQs0wCVe9EKO/XMyt3kuitm
         VKXRLGXRbQQ/QyYG8sfiD8KtzYiIe2qSXPb7AOo3KXnHZsjdt/stgqkRJyEk0RZgEyY6
         s/HMNYMD3Ea2oBcYRwWYrveDWquwh3uPimprsUxX2yeMWOIQsWSgdtdlB7f0UZaMPmbF
         moNQ==
X-Gm-Message-State: AC+VfDyOmeabWy3Tlo6xEKLUyGEPtDDuhBe7MwQE0VgdobFwvXvZs9ww
	wRwaY2NEr5MIHWcLD4p0FuNx5XgapL4UMbpz6Fs=
X-Google-Smtp-Source: ACHHUZ5Skb1/rVDr0Wxtk7Nzd7/cZ/vHPhvfCd4iqWTfEi6rRdHn8aD2oT0SHZaf03qY9l3xg1bzpe8tKM5Jp9nc0k0=
X-Received: by 2002:a17:907:70a:b0:953:9024:1b50 with SMTP id
 xb10-20020a170907070a00b0095390241b50mr33290274ejb.74.1684272654634; Tue, 16
 May 2023 14:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230512103354.48374-1-quentin@isovalent.com> <20230512103354.48374-5-quentin@isovalent.com>
In-Reply-To: <20230512103354.48374-5-quentin@isovalent.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 May 2023 14:30:42 -0700
Message-ID: <CAEf4BzZ=wp81zdfTTWefiuq2O28aLiHc5Vq88D4hGeb=qy6zJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] bpftool: use a local bpf_perf_event_value to
 fix accessing its fields
To: Quentin Monnet <quentin@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	=?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Alexander Lobakin <alobakin@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 12, 2023 at 3:34=E2=80=AFAM Quentin Monnet <quentin@isovalent.c=
om> wrote:
>
> From: Alexander Lobakin <alobakin@pm.me>
>
> Fix the following error when building bpftool:
>
>   CLANG   profiler.bpf.o
>   CLANG   pid_iter.bpf.o
> skeleton/profiler.bpf.c:18:21: error: invalid application of 'sizeof' to =
an incomplete type 'struct bpf_perf_event_value'
>         __uint(value_size, sizeof(struct bpf_perf_event_value));
>                            ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helpers.h:13:39: note:=
 expanded from macro '__uint'
> tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helper_defs.h:7:8: not=
e: forward declaration of 'struct bpf_perf_event_value'
> struct bpf_perf_event_value;
>        ^
>
> struct bpf_perf_event_value is being used in the kernel only when
> CONFIG_BPF_EVENTS is enabled, so it misses a BTF entry then.
> Define struct bpf_perf_event_value___local with the
> `preserve_access_index` attribute inside the pid_iter BPF prog to
> allow compiling on any configs. It is a full mirror of a UAPI
> structure, so is compatible both with and w/o CO-RE.
> bpf_perf_event_read_value() requires a pointer of the original type,
> so a cast is needed.
>
> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> ---

What's the point of using vmlinux.h at all if we redefine every single
type? bpf_perf_event_value is part of BPF UAPI, so if we included
linux/bpf.h header we'd get it.

This feels a bit split-brained. We either drop vmlinux.h completely
and use UAPI headers + CO-RE-relocatable definitions of internal
types, or we make sure that vmlinux.h does work (e.g., by pre-checking
in a very small version of it). Both using vmlinux.h and not relying
on it having necessary types seems like the worst of both worlds?...


Quentin, can you see if you can come up with some simple way to use
vmlinux.h if building from inside kernel repo, but using a minimized
vmlinux.h generated using `bpftool gen min_core_btf` when building
from Github mirror? Sync script could also generate this minimal
vmlinux.h automatically, presumably?


>  tools/bpf/bpftool/skeleton/profiler.bpf.c | 27 ++++++++++++++---------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>

[...]

