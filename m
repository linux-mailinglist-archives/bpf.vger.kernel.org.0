Return-Path: <bpf+bounces-38293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65771962DBD
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 18:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B81CB214CF
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D361A3BBB;
	Wed, 28 Aug 2024 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmtdJVrf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5557C16087B;
	Wed, 28 Aug 2024 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862814; cv=none; b=GoYwptQ1qUNI0s0wPVdaiMeyK83T15dC0ILces4teL2w5/Fbk/IkcO+1hAkt4LlK013JxiVR+RiY30XAtLZq+6S11lQ77OpBuwrehz7H7a8FxHqQCcyf6Dq86sP358vzrutZWM8ZLYczH96oUaIjYFBgRLoC1OAnXGO7AEEOdW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862814; c=relaxed/simple;
	bh=aQ0KQce/2N+M0hzwi9uNRhtlX3s6yHVhTY+57+7wVFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnllW9VXb3KEzp2v7t7SQuWcCOobhidIhoPjU9k0BCux21Iv6N+9z6WT7CeyjdVMByIJhVCAg0rfjNkEyCuZZsgqKgfL/k6jSjHJ+TMTnbCjcluAEhCvV/6Anh1BL48AOPRsAM3gjPcCC7wrRawlHzDi/+ywdI4C/LFAngC+5mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmtdJVrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10F7C51EE4;
	Wed, 28 Aug 2024 16:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724862813;
	bh=aQ0KQce/2N+M0hzwi9uNRhtlX3s6yHVhTY+57+7wVFw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AmtdJVrfR+SHUriKR+drxuFbQqIr8aYtBCbIQFzBq08u+RnJsbWcLtqaDtaO3U6BB
	 IoNQUZYPeHzCOkOnK7713ApEWtgGxuH4ejJawISLkWBEeIGT+ZUlIOiHhTAActiRMl
	 lQS2LKas+2hkv+voyfc9YhRxtzcp5wpP5SrF4dR5SchyuZMcAR2jS8azB5U3WRAZJ2
	 0YoCtiN0ys4tftuZbeiuiChyCfFalFdoToIQqn9+KgsTPTEJa0AIoTW+5p4pd/ZajO
	 n3THZtP5vzTqLoF2fSnooz0EaZUGJCnyeGdJ8SVC3HLiWKBX8pBeIT/ykyzP6mim+B
	 bgZkkSfaUzNFA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f01b8738dso5420491e87.1;
        Wed, 28 Aug 2024 09:33:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6cUnJVdAaAC0WixJM8+7m/0viCABj8JwzpchCaeEov6Vw1QKO+3Mu9FbH5C7e09TmGmI=@vger.kernel.org, AJvYcCV8k1dNl2suvVQzfz4hydl0qCFXyzcE9y9/k11fCgmrCn/mkEvNCLM/8kQcD2rScFP4ACcK8kuBf6ccYXKR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz085NdqEuqWC+/Yy1kCgCNDKQ6jtJeM5Pt7EZzqcg6lJpjm0z4
	psjXqQrpOlvDWDDYf7fqsgRafMPu2oXqzdTaHVT1NyqQgqdRAK2L60FVESkOqeRAQF35QxW4898
	39jWM4wN4c9YyqO/crMow+Og0qFY=
X-Google-Smtp-Source: AGHT+IEivT+dFM5X9bkSS+rjeKookYXGG3XPFDxUb3v78gdnX6Q0KTbaBY3D7g7x3B3QOY/xE9GdPTRtg/RS5n69tUY=
X-Received: by 2002:a05:6512:3ba3:b0:52c:e01f:3665 with SMTP id
 2adb3069b0e04-53438783dd9mr12258894e87.25.1724862812470; Wed, 28 Aug 2024
 09:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828152559.4101550-1-legion@kernel.org>
In-Reply-To: <20240828152559.4101550-1-legion@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 29 Aug 2024 01:32:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQju8OeqW_8JtNXAQWow8Ho8778Rq-Y_v22PSrbB39L0g@mail.gmail.com>
Message-ID: <CAK7LNAQju8OeqW_8JtNXAQWow8Ho8778Rq-Y_v22PSrbB39L0g@mail.gmail.com>
Subject: Re: [PATCH v1] bpf: Add missing force_checksrc macro
To: Alexey Gladkov <legion@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 12:42=E2=80=AFAM Alexey Gladkov <legion@kernel.org>=
 wrote:
>
> According to the documentation, when building a kernel with the C=3D2
> parameter, all source files should be checked. But this does not happen
> for the kernel/bpf/ directory.
>
> $ touch kernel/bpf/core.o
> $ make C=3D2 CHECK=3Dtrue kernel/bpf/core.o
>
> Outputs:
>
>   CHECK   scripts/mod/empty.c
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   CC      kernel/bpf/core.o
>
> As can be seen the compilation is done, but CHECK is not executed. This
> happens because kernel/bpf/Makefile has defined its own rule for
> compilation and forgotten the macro that does the check.
>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>


NACK.


This Makefile is already screwed up.

There is no need to duplicate the build code.

Please remove the last 6 lines of kernel/bpf/Makefile



See the following code as an example:
arch/arm/boot/compressed/fdt_rw.c




Like this:

$ cat kernel/bpf/btf_iter.c
#include "../../tools/lib/bpf/btf_iter.c"


Same for
kernel/bpf/btf_relocate.c
kernel/bpf/relo_core.c









> ---
>  kernel/bpf/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 0291eef9ce92..f0ba6bf73bb6 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -58,3 +58,4 @@ vpath %.c $(srctree)/kernel/bpf:$(srctree)/tools/lib/bp=
f
>
>  $(obj)/%.o: %.c FORCE
>         $(call if_changed_rule,cc_o_c)
> +       $(call cmd,force_checksrc)
> --
> 2.46.0
>
>


--=20
Best Regards
Masahiro Yamada

