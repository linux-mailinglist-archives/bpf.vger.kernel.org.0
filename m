Return-Path: <bpf+bounces-12406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E23CA7CC345
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 14:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C97FB211D2
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 12:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C8142C02;
	Tue, 17 Oct 2023 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="DLTrj+tO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BFF42C00;
	Tue, 17 Oct 2023 12:35:22 +0000 (UTC)
X-Greylist: delayed 317 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Oct 2023 05:35:20 PDT
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C54F2;
	Tue, 17 Oct 2023 05:35:20 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 17 Oct 2023 14:29:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1697545797; bh=zLahxL+QXI3rfdx1iiel7NusxwDfyi7i9OT70ttG0sI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLTrj+tOPB+cWfqo3Be1jRRCeHJzMzOdcWFEiMSPuJTH7boM/qyMZ+F31owpydLTi
	 /dRJjk+1yCfUM9I46b96H/x9MmxF7O7mDQFUcKv6QvqT2d+0e2Qnca4cq+FVb/pu4T
	 K4z+p/lIETLJdQmp5ev7O8R0hWHNAnt+uxQ05Tc4=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 8F52280C3A;
	Tue, 17 Oct 2023 14:29:57 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 7A521180CD9; Tue, 17 Oct 2023 14:29:57 +0200 (CEST)
Date: Tue, 17 Oct 2023 14:29:57 +0200
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Benno Lossin <benno.lossin@proton.me>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>, Gary Guo <gary@garyguo.net>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] kbuild: avoid too many execution of
 scripts/pahole-flags.sh
Message-ID: <ZS5+RcXh766bgHz3@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Benno Lossin <benno.lossin@proton.me>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>, Gary Guo <gary@garyguo.net>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	rust-for-linux@vger.kernel.org
References: <20231017103742.130927-1-masahiroy@kernel.org>
 <20231017103742.130927-2-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231017103742.130927-2-masahiroy@kernel.org>
X-purgate-ID: 149429::1697545797-CBE3C0EE-94F75A2F/0/0
X-purgate-type: clean
X-purgate-size: 1635
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Subject: kbuild: avoid too many execution of scripts/pahole-flags.sh
executions?

On Tue, Oct 17, 2023 at 07:37:40PM +0900, Masahiro Yamada wrote:
> scripts/pahole-flags.sh is executed so many times.
> 
> You can check how many times it is invoked during the build, as follows:
> 
>   $ cat <<EOF >> scripts/pahole-flags.sh
>   > echo "scripts/pahole-flags.sh was executed" >&2
>   > EOF
> 
>   $ make -s
>   scripts/pahole-flags.sh was executed
>   scripts/pahole-flags.sh was executed
>   scripts/pahole-flags.sh was executed
>   scripts/pahole-flags.sh was executed
>   scripts/pahole-flags.sh was executed
>     [ lots of repeated lines suppressed... ]
> 
> This scripts is exectuted more than 20 times during the kernel build

executed

> because PAHOLE_FLAGS is a recursively expanded variable and exported
> to sub-processes.
> 
> With the GNU Make >= 4.4, it is executed more than 60 times because
> exported variables are also passed to other $(shell ) invocations.
> Without careful coding, it is known to cause an exponential fork
> explosion. [1]
> 
> The use of $(shell ) in an exported recursive variable is likely wrong
> because $(shell ) is always evaluated due to the 'export' keyword, and
> the evaluation can occur multiple times by the nature of recursive
> variables.
> 
> Convert the shell script to a Makefile, which is included only when
> CONFIG_DEBUG_INFO_BTF=y.
> 
> [1]: https://savannah.gnu.org/bugs/index.php?64746
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Thanks, looks good to me!

Reviewed-by: Nicolas Schier <n.schier@avm.de>

