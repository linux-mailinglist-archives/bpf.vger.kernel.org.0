Return-Path: <bpf+bounces-12960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8D67D2781
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 02:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5238A1C2089C
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 00:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3363F1877;
	Mon, 23 Oct 2023 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFSH30Ne"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA83F15B9;
	Mon, 23 Oct 2023 00:30:30 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0CAE4;
	Sun, 22 Oct 2023 17:30:29 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-57bc2c2f13dso1795289eaf.2;
        Sun, 22 Oct 2023 17:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698021029; x=1698625829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m6eLSnzZZg7H+GrqfiJCsD1swb5+c3g7YWXl8du2HyA=;
        b=MFSH30Ne+8ARp5lbO5HEXWCe10WXEMU9SXC2oWtFfZ0nHB6TMqiHqYWrgxP5WcCabS
         LvoueEueEERps4SS+GIClEAIoI1BfwS1t+LnAxY8LzEou1iQOKAmjk31N3zDWv/OjtZC
         IYDBAsMoYo5VHv2S0RHwJB27OJZzHDR3L3nCNGTOjbnWBIDIZm9ENK7LKaw9k/VHalQu
         yiIhdM5M5QaNCsQvGdYJHEWJ0aJvWXs0C1tgR4BHC/06a2WfRP7+3XMUmhGFH0UAgr6Y
         zj9dSe1SEOCiC3XYuxWBF0Qfqx7jcmx1Ic0sNkxXduf1ie5QB4mP/vRuP/WaSRpEo25g
         Eudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698021029; x=1698625829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6eLSnzZZg7H+GrqfiJCsD1swb5+c3g7YWXl8du2HyA=;
        b=iS2gvWwoAa1zfv4Lxe7oZJBaYEOrWDUrEq3vZWWJyG/Mug10SOBLOPKK6XkHdFzvIe
         r3T10t6ZiJ7HwIjtPNkl0Bpq0vkLCrIDgUL6R41c9awATibtagHh0MkTmntHaizJr4SV
         l11NsIhQG7JYPJH7J7M2dBIaHVH5xsn5J5lvIyfU9QBQFJYZ2bG0iFCxF6WY9bu3JGRv
         5mozDIG59d03u7uhN3bqMQlv1wKvpCTSV9CzRe6lTC2bRxG/9RtrBHSaZKhctOz+A+v2
         9+8WK6FEw/0orrHOuk2zjEmXmmnJ6gd+wysYEzX5EAaiwzpfN2rYz2krILwEFrQg6sU7
         Xzpw==
X-Gm-Message-State: AOJu0Yzx2IaStU5l0u/uaC5wEODaCATJj0Nf8fzGSWqAm1PpTH3sDwqL
	Bgv+8Pn6pDcNvCxSkUDBivU=
X-Google-Smtp-Source: AGHT+IHJmePMTS+VW+Lh+vsvi3jAsr62Wg/9ZlsEWGmuo5olAGKcTROr+WxyW46bc51uAB5aGDxkFQ==
X-Received: by 2002:a05:6358:7a6:b0:168:e364:70af with SMTP id n38-20020a05635807a600b00168e36470afmr605342rwj.25.1698021028781;
        Sun, 22 Oct 2023 17:30:28 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id j33-20020a632321000000b0058563287aedsm4779378pgj.72.2023.10.22.17.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 17:30:28 -0700 (PDT)
Message-ID: <f486476c-8109-4dfb-8ef0-bfd7a36c003e@gmail.com>
Date: Sun, 22 Oct 2023 21:30:20 -0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] kbuild: avoid too many execution of
 scripts/pahole-flags.sh
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alex Gaynor <alex.gaynor@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Andrii Nakryiko <andrii@kernel.org>, Benno Lossin <benno.lossin@proton.me>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Gary Guo <gary@garyguo.net>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nicolas Schier <nicolas@fjasle.eu>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@google.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20231017103742.130927-1-masahiroy@kernel.org>
 <20231017103742.130927-2-masahiroy@kernel.org>
Content-Language: en-US
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231017103742.130927-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/23 07:37, Masahiro Yamada wrote:
> scripts/pahole-flags.sh is executed so many times.
> 
> You can check how many times it is invoked during the build, as follows:
> 
>    $ cat <<EOF >> scripts/pahole-flags.sh
>    > echo "scripts/pahole-flags.sh was executed" >&2
>    > EOF
> 
>    $ make -s
>    scripts/pahole-flags.sh was executed
>    scripts/pahole-flags.sh was executed
>    scripts/pahole-flags.sh was executed
>    scripts/pahole-flags.sh was executed
>    scripts/pahole-flags.sh was executed
>      [ lots of repeated lines suppressed... ]
> 
> This scripts is exectuted more than 20 times during the kernel build
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
> [...]
> +include-$(CONFIG_DEBUG_INFO_BTF)+= scripts/Makefile.btf

Would have used a tab.

> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

