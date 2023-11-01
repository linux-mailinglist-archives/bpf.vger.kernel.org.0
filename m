Return-Path: <bpf+bounces-13837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B717DE7BF
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 22:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C6E5B21004
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 21:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6E71BDC3;
	Wed,  1 Nov 2023 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHLNcJLN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A4623BC
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 21:56:59 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDA2121
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 14:56:57 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-542d654d03cso404813a12.1
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 14:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698875816; x=1699480616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5NJUGN0LQY294mw52WpqesR+lKoZCEizi//k0LJx3o=;
        b=KHLNcJLNA5TvtPw3gweWP5hd97kSstQVef/YEGQaGn8hc7IlogMUyKmF6Ts9P8rqZy
         MzuItsuk0sOblJ6Q4cMeYEnD+6Dq8aGwqyWWnTXVJmhUXq8BTEAKI8BxB59TMFh4OUGY
         xnhkipuYTTBQebH9pdm4tKc4mP37hLuuiBCYC+sV8+yppTPFp1BMNHhF6CyCaEnIEOdX
         XveMc65YSWe+CbgqVqXHFaheyozPnx3Hx1+bs9n8WL0iOXbbjBeG1yoDDUO27FJqhQ/O
         aeh7YWonNOuXwp7Ib4lpDlnbWOYAw39R3EdfesEZ/BYwZkkgAHXjDwCedsEw/Bec2eMr
         j2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698875816; x=1699480616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5NJUGN0LQY294mw52WpqesR+lKoZCEizi//k0LJx3o=;
        b=OfMRMTglx/txfyyAxodErk0Ogy5KXW0Hv9rkJNwrjnsGLt7+LI72NdJmnnckCz11Va
         LiB8Vioup+h/wgiVURTmYEgU2XB0bRRazGEO7zJiT/5trO41vpcT37M+YIRw+U2l+f7s
         NrpZOxNKpjWJYFxlgGC6rmn6JOzNSOEWekfEZ8plEYzlINmhjphQ/e4zUEAZ6kEjCQ5M
         gzyV9wNhqj+X4ZaKMfdRUKow+wSUXEgmZfR6Z3qp3Uq9Uuivt/E634IMIDtCv7pnkFD/
         XxnOWbe8UDH7Rii0ZCPtGNBdJ3QA2NEziMEAB9TF9c2KnNYDUOqdoPpOC4FJhMV5uvXN
         DQGA==
X-Gm-Message-State: AOJu0Yx/eJKuv4bNE0xzavIARGDdkTjMk/LPov6C9RnPplz4lQJipZic
	XCenujfxMcpRsMKg7nJIU/PYfd6KhhytxIqtuy0=
X-Google-Smtp-Source: AGHT+IGvP1Uoy2dmyH17u2lPQUfXHcSnnelRlpV6y3yGxmMLVnRVNkR+wS9ah1kln3LR2Zqpk/PBu327sTthEyWsDZw=
X-Received: by 2002:a17:907:d19:b0:9c7:5651:9018 with SMTP id
 gn25-20020a1709070d1900b009c756519018mr3218499ejc.68.1698875815914; Wed, 01
 Nov 2023 14:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023220030.2556229-1-davemarchevsky@fb.com> <20231023220030.2556229-2-davemarchevsky@fb.com>
In-Reply-To: <20231023220030.2556229-2-davemarchevsky@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Nov 2023 14:56:44 -0700
Message-ID: <CAEf4BzZb-8cUGhtm2buxL-OiqJ8sFvVS9-GRk-u0KaMKbJktcA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/4] bpf: Fix btf_get_field_type to fail for
 multiple bpf_refcount fields
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 3:00=E2=80=AFPM Dave Marchevsky <davemarchevsky@fb.=
com> wrote:
>
> If a struct has a bpf_refcount field, the refcount controls lifetime of
> the entire struct. Currently there's no usecase or support for multiple
> bpf_refcount fields in a struct.
>
> bpf_spin_lock and bpf_timer fields don't support multiples either, but
> with better error behavior. Parsing BTF w/ a struct containing multiple
> {bpf_spin_lock, bpf_timer} fields fails in btf_get_field_type, while
> multiple bpf_refcount fields doesn't fail BTF parsing at all, instead
> triggering a WARN_ON_ONCE in btf_parse_fields, with the verifier using
> the last bpf_refcount field to actually do refcounting.
>
> This patch changes bpf_refcount handling in btf_get_field_type to use
> same error logic as bpf_spin_lock and bpf_timer. Since it's being used
> 3x and is boilerplatey, the logic is shoved into
> field_mask_test_name_check_seen helper macro.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Fixes: d54730b50bae ("bpf: Introduce opaque bpf_refcount struct and add b=
tf_record plumbing")
> ---
>  kernel/bpf/btf.c | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 15d71d2986d3..975ef8e73393 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3374,8 +3374,17 @@ btf_find_graph_root(const struct btf *btf, const s=
truct btf_type *pt,
>         return BTF_FIELD_FOUND;
>  }
>

[...]

