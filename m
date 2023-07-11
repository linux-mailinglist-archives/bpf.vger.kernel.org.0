Return-Path: <bpf+bounces-4786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4417E74F722
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 19:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32EA2818E6
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 17:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CDF1E516;
	Tue, 11 Jul 2023 17:23:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157A17FE0
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 17:23:07 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED095170A;
	Tue, 11 Jul 2023 10:22:42 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 0EA415C007D;
	Tue, 11 Jul 2023 13:22:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 11 Jul 2023 13:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1689096142; x=1689182542; bh=WVuQD8F16q+8KpkRXUZfCZXz1Vbx2RrVytD
	1O4kCmYE=; b=Z9nqXzX77m6gQD3BPliH5EP/1qdo75FV8gW/EU/f13H7zNT7JQt
	8PZC0CZLyIlDTCrBj/Smo0OqcndyK1K5JHlzClVY+s1Mplvu16IIMUE6rITaxtMV
	8oJ3mevxtINrvAKzDZtBfNeebRLgkKXZH4gK1QaKyqxVeclkFAHA86cC+E7haWyf
	UDLUjZx0zDEzgPlAjiHGn8Bk0a8sWLe8SmeAgngNQbjSIV0N56edv9V8lzpugg21
	EMOuIDwxx2rSwNVQtiBHP6B4SOBRetiLS0Qwu4jK7+ggLy16q7BuzKycbWEnZjdd
	M/+PcitRiR4Nb9jxg9tRbcupdu+1k2jWiDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1689096142; x=1689182542; bh=WVuQD8F16q+8KpkRXUZfCZXz1Vbx2RrVytD
	1O4kCmYE=; b=jCe2kUA8fhmQT2/vhwHddfoBVjVRMZXXCVH35gCyMesgcvm3T4u
	295KaMluRX/o4yOuK1rhOqcpZCPsohH+VJMgAXV1ISHl/BAZ2o83dmmKr76H53az
	wKExqr6xxi3C1sXTn+6v7QoBmqTaruZwf+verZsvBs03ShG0CnlhYR7PZUbR9XXT
	etxxz0ySlDmc6b7VrEiPV2I1vlzGxIi/e2sU2HctVSIsCl9d+49CoBA0ogijWAu8
	yB0Nb8trWqr1vvJAafhQ/SeZsfLDk2+DDC1FZwmQeJzhxYFTPeJmCDoGgvpWbabJ
	uWDTQnoFgaRiWWSXINj16+76u1wLEBQfLHg==
X-ME-Sender: <xms:y4-tZPpEVFpxwk6dps3xmwBpPlKEtHdoeOXivrQAoKI4509t3cUtHg>
    <xme:y4-tZJoWSNYc2yfQPtf0NtEFc1t3P7UydMvfizEOpktXJoAI-RBpy73dUFXTxNLuU
    Q2GbFAYnadUHMO57Q>
X-ME-Received: <xmr:y4-tZMNTWFrU_jXup6FkAOI9wterJxzWU5y6iMp0Tw4TA66lygeO4THXJwvd0RI_2VybHBmpIcZNVFfQoIz8JhEOKrSnwmMPhP8e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedtgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedtgfeuueeukeeikefgieeukeffleetkeekkeeggeffvedt
    vdejueehueeuleefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:y4-tZC5IhGm4l5cfzU-3zK9rCyuReZsZpGXIZ6836n1PbDDl_EFjTg>
    <xmx:y4-tZO7T13BUjKnijF_OmGDSrJm1UsEaYBDMb_rHp3oSqnKPHJaX1g>
    <xmx:y4-tZKismzi8TrVmXw2jUjgQvq37iNG_n8gvx9BejqR2GU7JxLU1dg>
    <xmx:zo-tZMvPZYVb-B14YtJrcub1W-VeXz_BJF9tgIaq4eiidV6u-kv5Qg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jul 2023 13:22:18 -0400 (EDT)
Date: Tue, 11 Jul 2023 11:22:17 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrea Righi <andrea.righi@canonical.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	llvm@lists.linux.dev, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] btf, scripts: rust: drop is_rust_module.sh
Message-ID: <56yvbhhiij3t5tsvnjcrrpbpvnezi2bm2w5c5xkrvwgix2arq2@ku3curqk7b5u>
References: <20230704052136.155445-1-andrea.righi@canonical.com>
 <CANiq72k6um58AAydgkzhkmAdd8t1quzeGaPsR7-pS_ZXYf0-YQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72k6um58AAydgkzhkmAdd8t1quzeGaPsR7-pS_ZXYf0-YQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Miguel, Andrea,

On Tue, Jul 11, 2023 at 04:39:27PM +0200, Miguel Ojeda wrote:
> On Tue, Jul 4, 2023 at 7:21 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > With commit c1177979af9c ("btf, scripts: Exclude Rust CUs with pahole")
> > we are now able to use pahole directly to identify Rust compilation
> > units (CUs) and exclude them from generating BTF debugging information
> > (when DEBUG_INFO_BTF is enabled).
> >
> > And if pahole doesn't support the --lang-exclude flag, we can't enable
> > both RUST and DEBUG_INFO_BTF at the same time.
> >
> > So, in any case, the script is_rust_module.sh is just redundant and we
> > can drop it.
> >
> > NOTE: we may also be able to drop the "Rust loadable module" mark
> > inside Rust modules, but it seems safer to keep it for now to make sure
> > we are not breaking any external tool that may potentially rely on it.
> 
> Just to recall the history of these changes:
> 
>   - The script got added in order to skip the BTF generation in the
> `BTF [M]` step (under `DEBUG_INFO_BTF_MODULES`, which depends on
> `DEBUG_INFO_BTF`).
> 
>   - A few months later, it was noticed that C modules couldn't be
> loaded if Rust was enabled, due to the base BTF info in `vmlinux`.
> That triggered the eventual addition of `--lang_exclude=` to `pahole`,
> but meanwhile, we made `DEBUG_INFO_BTF` and `RUST` exclusive.
> 
>   - Now, this patch removes the script because having a newer `pahole`
> also correctly skips the Rust CUs in the `BTF [M]` steps (i.e. and not
> just the `vmlinux` one), since we pass `--lang_exclude=` to both cases
> (`link-vmlinux.sh` and `Makefile.modfinal`), if I understand correctly
> (the script could, in principle, have been removed even before
> `pahole` got the new feature, given the exclusivity of the options).
> 
> If this is all correct, then the patch looks good to me. I am Cc'ing
> Arnaldo, Martin and the BPF list.

I believe I authored the original script. This all sounds right to me.

Acked-by: Daniel Xu <dxu@dxuuu.xyz>

Thanks,
Daniel

