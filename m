Return-Path: <bpf+bounces-7406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADCB776CC0
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 01:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E994E28150C
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 23:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C513F1E519;
	Wed,  9 Aug 2023 23:22:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9549E1E50C;
	Wed,  9 Aug 2023 23:22:53 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F4CE7C;
	Wed,  9 Aug 2023 16:22:52 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-584034c706dso5105127b3.1;
        Wed, 09 Aug 2023 16:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691623372; x=1692228172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eX5nWD6nwZ0YC8lAKmlrsyt9YLZW2gcQQXpVISIcYTw=;
        b=AJNodbB7pULEKvvBelok1Ue8AtbYE5YoY2LJFzSuTvJ2057iIwbUJkFxbNtk6HWbaG
         OIhJvq/ESdzOfHt51sFqcN2+IiZkiHstvhGAnaKI3CwLt+90qu87wZ32eeQjPiYJvucb
         pE9pwsVFYRtWQyJkrWEEUL7eFaLUFWu7DcC9fwHRy7dAu6A17Bp0yrcA0ccFkgkHHb/f
         kQNbKOrSQk+kU1CWvILxr81y/MuNUCLWIhhhsLaun/IfBf/U9VmjdYzN8K92DQd+7OCF
         TvDfMcBS+NG5fIpf/o6fopNkk/sTEBAdfVOTbVqyb3PF7EdSc45YGPyKCZL/4N7XePmQ
         i9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691623372; x=1692228172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eX5nWD6nwZ0YC8lAKmlrsyt9YLZW2gcQQXpVISIcYTw=;
        b=ScFKtiddaJdvEpFgu36JNMl4bxEVnfImmTQEnu1F7Oi7/jVFEO78gradjJHGMQC7kS
         LrjiwvD/+yiPLX18NefhL2CCCAQzzZ8TfUolfTMFQQdPtcIfCm0sJr1q3XsQ2ciZQWaJ
         8CkcUt8dtuofFFVND8aYDmDNFZIOWNhG1KchTSVRamoVx3z9kBTTt2XQgdvfkrvujnx4
         BpCAh42wUUzPrdWdf49+y/wNyZANDUblgjvpJL6Q6i3/+pklg3aN8vqx9sVoZ8//t3ZL
         WjF9JICDLVJ3PNB2fmlJsZy0Dlj2x9yw9IFFvyShjeeo8TyniC3vJVSEWnkPuMTFt154
         b/Ng==
X-Gm-Message-State: AOJu0YySg0jIAAYLLgf79tQayF46BIDYxbPJohd9DqL7VxgZLu+aUVzd
	tuu6oVj2WObkeQr3l74LKjpVe5QLIK7KEe1r0CE=
X-Google-Smtp-Source: AGHT+IFn55l2ROQqeZHkpSZOOhd0mCtO8jpn4+XKjy8ae5184Z1cAa3UXVDgV//VNUDCROb/2ZiZ84hhaM5qmlcmGAs=
X-Received: by 2002:a0d:d602:0:b0:559:ed0a:96c4 with SMTP id
 y2-20020a0dd602000000b00559ed0a96c4mr779650ywd.44.1691623372031; Wed, 09 Aug
 2023 16:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230704052136.155445-1-andrea.righi@canonical.com>
In-Reply-To: <20230704052136.155445-1-andrea.righi@canonical.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 10 Aug 2023 01:22:41 +0200
Message-ID: <CANiq72k8M=9rP_D_0Ew0hDbsx+qmO92oSyD_LDFnQCKnE3eq_Q@mail.gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
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
>
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>

Applied to `rust-next` -- thanks everyone, and Andrea and Daniel for
confirming my summary/recollection sounded right in the other message.

Cheers,
Miguel

