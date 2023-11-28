Return-Path: <bpf+bounces-16078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C002B7FC7E0
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 22:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C038D1C20F23
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 21:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B6E42ABA;
	Tue, 28 Nov 2023 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BDv0md5P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9153270B
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 13:24:16 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5c87663a873so87352147b3.2
        for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 13:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701206656; x=1701811456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NZ4ZfcVG31DCz1kBOhL2BhY9THtIfubL+pqFYyuiXxk=;
        b=BDv0md5P0cAjxtn3B6hGo/iAMsADEu8jMehWSbcrzh544ptST3yaJ9pwSuyxeLUpUo
         uq2vMpqJ8hUoNHAHLBfuO6cPhl3P25jaNTrkraKTpo2kBQRgkPQNjXtSkCO25ajQGF8f
         HP5Nlb3RquiUFhYzXVl2GNt2TB+WaWSQRfqEbsnoP2iVYaGqtqVm+F7iBO60cDVjYgp+
         Y++hctqATXG9ytDquZYyNSlsZ4rIq33PsTD5OgWwg8aqiFvgeumIwBh0lJz4A3kcWBhG
         iS6Quk+A92no91wMLdvITqZ3MOPcsiZ/ONcWRFa2UeOkDBidoI8sHyMBgHeSK5OfoEwT
         h6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701206656; x=1701811456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZ4ZfcVG31DCz1kBOhL2BhY9THtIfubL+pqFYyuiXxk=;
        b=gznamX6y8olFn1zbqeDuJNJ5sssyz8TVvPAhd0/6uUqiY2o+usljMW1NDlV8LZr0rn
         vgFri6IffBas+feU7GefrhdtpgUnVhEz/Zo9JbbI8aqNHSHt4cGmhp7r1nUYVE4NFxSM
         3mSqJKY9jAZKpZwyvpf6i2aDBrugIVixTq3/KDDbBmUjRAoFqb4zML8+JAllBDMNEzvO
         htLMNA7+wZ5CHoWu2vmqTKQWB/68lp3hkCbCmDg0vAh4EGPBzCp/9Egmb9+T3mdNoRO7
         Y8+R6iAbor3IgN0tA/nDUvntq7f1DooVuO29+hbmlacywEstFId5ggxY0z4q3QnfnbeJ
         1LsQ==
X-Gm-Message-State: AOJu0YwCyQ+ehWZkXrJyPUv/LsqcG5R+llxjyb+7VjHO91szE1YgDJh2
	woWkaKAsDBK5yuAzzNtkboR5N4I=
X-Google-Smtp-Source: AGHT+IFBe+siDTtpxnyoH4A5iGdYotXXZRa3NxFODg2aC7HbOZPyrOr68cEc+xM/qvBMvnwi3MclrmM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:ad23:0:b0:5be:a336:4a6 with SMTP id
 l35-20020a81ad23000000b005bea33604a6mr584855ywh.3.1701206655981; Tue, 28 Nov
 2023 13:24:15 -0800 (PST)
Date: Tue, 28 Nov 2023 13:24:14 -0800
In-Reply-To: <20231128092850.1545199-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231128092850.1545199-1-jolsa@kernel.org> <20231128092850.1545199-2-jolsa@kernel.org>
Message-ID: <ZWZafkt97qhgHynh@google.com>
Subject: Re: [PATCHv2 bpf 1/2] bpf: Add checkip argument to bpf_arch_text_poke
From: Stanislav Fomichev <sdf@google.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Hao Luo <haoluo@google.com>, Xu Kuohai <xukuohai@huawei.com>, Will Deacon <will@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Pu Lehui <pulehui@huawei.com>, 
	"=?utf-8?B?QmrDtnJuIFTDtnBlbA==?=" <bjorn@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>, Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="utf-8"

On 11/28, Jiri Olsa wrote:
> We need to be able to skip ip address check for caller in following
> changes. Adding checkip argument to allow that.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/arm64/net/bpf_jit_comp.c   |  3 ++-
>  arch/riscv/net/bpf_jit_comp64.c |  5 +++--
>  arch/s390/net/bpf_jit_comp.c    |  3 ++-
>  arch/x86/net/bpf_jit_comp.c     | 24 +++++++++++++-----------
>  include/linux/bpf.h             |  2 +-
>  kernel/bpf/arraymap.c           |  8 ++++----
>  kernel/bpf/core.c               |  2 +-
>  kernel/bpf/trampoline.c         | 12 ++++++------
>  8 files changed, 32 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 7d4af64e3982..b52549d18730 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2167,7 +2167,8 @@ static int gen_branch_or_nop(enum aarch64_insn_branch_type type, void *ip,
>   * locations during the patching process, making the patching process easier.
>   */
>  int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
> -		       void *old_addr, void *new_addr)
> +		       void *old_addr, void *new_addr,

[..]

> +		       bool checkip __maybe_unused)

Any idea why only riscv and x86 do this check?

Asking because maybe it makes sense to move this check into some
new generic bpf_text_poke and call it in the places where you currently
call checkip=true (and keep using bpf_arch_text_poke for checkip=false
case).

(don't see any issues with the current approach btw, just interested..)

