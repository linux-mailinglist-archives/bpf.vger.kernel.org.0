Return-Path: <bpf+bounces-4771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7578C74F276
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 16:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30BBC2813F4
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 14:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5491801F;
	Tue, 11 Jul 2023 14:39:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65501A5C
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 14:39:41 +0000 (UTC)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADFB9C;
	Tue, 11 Jul 2023 07:39:40 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so6926405276.3;
        Tue, 11 Jul 2023 07:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689086379; x=1691678379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtTSHdQg0YCAtxJ0hEuqKRNYfw6pZc0XMvsle82y98s=;
        b=TLY7AgKRbyH6OnSPJ9DlYOyb0tY23mdMyNZyMPVQJwFRFxmkYyuycEFFv+r/0Cvlfb
         cXnx3pUDbdhdB7JFCxLw/wc6DL1DOGuRiVXpgQnfv4YwuUYgXrKKu7bP/wCEWApMmnKP
         363lfl8o7ZY/Kuwm48ioU2u57auUY5mW0De/lS9s7niiohlZMXlpdHCiMJjD3Ap5VleT
         eOeLUp6uGt9gg36d7ytKY/RoctpWa4iTtqdAY8AW2AOin6OdgNJYcg85NLtjI7XwOcG8
         MEsChbAT2uHZoPFSIR9QSVpHTXER9HL7JpuF7BEMOXCxmsASFZwQY4L9YnZlomyeRaQx
         8K0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689086379; x=1691678379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtTSHdQg0YCAtxJ0hEuqKRNYfw6pZc0XMvsle82y98s=;
        b=W2cPojTkSNbduliA6dsOUVSgAockwugoWP5RWndjEqL07DSbFK09dmooqVk1JDrXZu
         08tMQLQkBc+724eQPM0MzSyBIvfyfpJcQ8P8NpJXQ28bwpJ3hj/oKjMdvwP8fzKi3DRt
         oNd3M5wQWhfUhKAZ7xDJRXYWVtmFYNbwUESVkaj/LLBcBKBFMTnECQqr8qE0PqqrsjNb
         EAtKGg9ak9ivxHMqjMXPUapVh2s6lTP13CV7NHHjnRRWKJb0mXIygaEzYpCjs+Fvndz/
         mlc9HVjqPj9fvNZHZe7YIstnf+UUSMJ7/XWii9CbIb/B+7dKbxq7VQNefVw0flkh4TqR
         ugiQ==
X-Gm-Message-State: ABy/qLbvxJ2aOHdmRfU5r94RCBrpQg2o6THlttsWlBTFUe3q1Vh6sjYa
	PZQCyyzEYxMU2zYM8lrNu3wks3J1PQlGNppb04p7jTn0pcM=
X-Google-Smtp-Source: APBJJlHt7LkksBX4dKb9ZjFQYZ4KsGxHurwvB30A58g+4iZVeHoPPXjmuXGg/AHzUHUgF9d+bkWo55Sr+FzdfGbqS+g=
X-Received: by 2002:a0d:fb03:0:b0:565:cf47:7331 with SMTP id
 l3-20020a0dfb03000000b00565cf477331mr19036939ywf.2.1689086379216; Tue, 11 Jul
 2023 07:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230704052136.155445-1-andrea.righi@canonical.com>
In-Reply-To: <20230704052136.155445-1-andrea.righi@canonical.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Jul 2023 16:39:27 +0200
Message-ID: <CANiq72k6um58AAydgkzhkmAdd8t1quzeGaPsR7-pS_ZXYf0-YQ@mail.gmail.com>
Subject: Re: [PATCH] btf, scripts: rust: drop is_rust_module.sh
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	llvm@lists.linux.dev, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 4, 2023 at 7:21=E2=80=AFAM Andrea Righi <andrea.righi@canonical=
.com> wrote:
>
> With commit c1177979af9c ("btf, scripts: Exclude Rust CUs with pahole")
> we are now able to use pahole directly to identify Rust compilation
> units (CUs) and exclude them from generating BTF debugging information
> (when DEBUG_INFO_BTF is enabled).
>
> And if pahole doesn't support the --lang-exclude flag, we can't enable
> both RUST and DEBUG_INFO_BTF at the same time.
>
> So, in any case, the script is_rust_module.sh is just redundant and we
> can drop it.
>
> NOTE: we may also be able to drop the "Rust loadable module" mark
> inside Rust modules, but it seems safer to keep it for now to make sure
> we are not breaking any external tool that may potentially rely on it.

Just to recall the history of these changes:

  - The script got added in order to skip the BTF generation in the
`BTF [M]` step (under `DEBUG_INFO_BTF_MODULES`, which depends on
`DEBUG_INFO_BTF`).

  - A few months later, it was noticed that C modules couldn't be
loaded if Rust was enabled, due to the base BTF info in `vmlinux`.
That triggered the eventual addition of `--lang_exclude=3D` to `pahole`,
but meanwhile, we made `DEBUG_INFO_BTF` and `RUST` exclusive.

  - Now, this patch removes the script because having a newer `pahole`
also correctly skips the Rust CUs in the `BTF [M]` steps (i.e. and not
just the `vmlinux` one), since we pass `--lang_exclude=3D` to both cases
(`link-vmlinux.sh` and `Makefile.modfinal`), if I understand correctly
(the script could, in principle, have been removed even before
`pahole` got the new feature, given the exclusivity of the options).

If this is all correct, then the patch looks good to me. I am Cc'ing
Arnaldo, Martin and the BPF list.

If this goes through the Rust tree, I will also pick the older `Reviewed-by=
`s.

Thanks!

Cheers,
Miguel

