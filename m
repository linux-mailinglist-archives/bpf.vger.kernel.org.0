Return-Path: <bpf+bounces-20501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4383483EFFF
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 21:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED720283DBC
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 20:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C23154A6;
	Sat, 27 Jan 2024 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YaOfuRds"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBC914A9F
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 20:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706387574; cv=none; b=WoAsdGzLmePNbTIYupRiAU7MrbjOWfODeBs17eHYa31qri0C7mQg+s6/0QpIwKyVoE19pn64pdXsx0wkcSJhkgsf+M3uyGm5JdJkhO0y38gXgQpGHsKTGQ61lloVK3yB5a5+3Wk+4T5BTXaT6c8qz9YoMVnOCWkCbkLh59rFMvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706387574; c=relaxed/simple;
	bh=ZRyXnwXznotbgAVEc33A9aJ5NdXJMSQ8SHSPR6PvX0Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hjTEwUh7EvoE8NefPtKS3eUJXsau+CRTTuyK1sVvhFnHYKeF3rXhsdH0y6lB2MP2iP2DMvW3U+OiQXybXh+x3rripiCbT/bS+6Ghw5OywBLmYe7VBqDx7oHB9x/leocO7rqP9XivpMSUpJvXwi2cB26K28+t8frXwEeEBj3Iv48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YaOfuRds; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <36259711-a4de-41b9-9cc0-2bd6d22c5ff4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706387569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7tAlQm/R/ZPro4Oq5N+M5HRvxxbQVrdPu8+wA1wsG7w=;
	b=YaOfuRds003HjYfWgdASHDbf94ROhGWo41qmvYkI64cKP2ANCMMaCrf0JEJO3JJFykpPhS
	UmqcTeSkHpgsCGclYy3ASohcfxbTIFK4MTDykMvvwEOqARwsxqs4f7JmHhqPmis2moX70n
	eCVHJLeDXJa67BRgVxUCmAbSfw3syDQ=
Date: Sat, 27 Jan 2024 12:32:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] [docs/bpf] Improve documentation of 64-bit
 immediate instructions
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, Dave Thaler <dthaler1968@gmail.com>
References: <20240127194629.737589-1-yonghong.song@linux.dev>
In-Reply-To: <20240127194629.737589-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/27/24 11:46 AM, Yonghong Song wrote:
> For 64-bit immediate instruction, 'BPF_IMM | BPF_DW | BPF_LD' and
> src_reg=[0-6], the current documentation describes the 64-bit
> immediate is constructed by
>    imm64 = (next_imm << 32) | imm
>
> But actually imm64 is only used when src_reg=0. For all other
> variants (src_reg != 0), 'imm' and 'next_imm' have separate special
> encoding requirement and imm64 cannot be easily used to describe
> instruction semantics.
>
> This patch clarifies that 64-bit immediate instructions use
> two 32-bit immediate values instead of a 64-bit immediate value,
> so later describing individual 64-bit immediate instructions
> becomes less confusing.

Sorry, for subject, [docs/bpf] is wrong. It should be
   [PATCH bpf-next] docs/bpf: Improve documentation of 64-bit immediate instructions

>
> Acked-by: Dave Thaler <dthaler1968@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   .../bpf/standardization/instruction-set.rst         | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
> index af43227b6ee4..fceacca46299 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -166,7 +166,7 @@ Note that most instructions do not use all of the fields.
>   Unused fields shall be cleared to zero.
>   
>   As discussed below in `64-bit immediate instructions`_, a 64-bit immediate
> -instruction uses a 64-bit immediate value that is constructed as follows.
> +instruction uses two 32-bit immediate values that are constructed as follows.
>   The 64 bits following the basic instruction contain a pseudo instruction
>   using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
>   and imm containing the high 32 bits of the immediate value.
> @@ -181,13 +181,8 @@ This is depicted in the following figure::
>                                      '--------------'
>                                     pseudo instruction
>   
> -Thus the 64-bit immediate value is constructed as follows:
> -
> -  imm64 = (next_imm << 32) | imm
> -
> -where 'next_imm' refers to the imm value of the pseudo instruction
> -following the basic instruction.  The unused bytes in the pseudo
> -instruction are reserved and shall be cleared to zero.
> +Here, the imm value of the pseudo instruction is called 'next_imm'. The unused
> +bytes in the pseudo instruction are reserved and shall be cleared to zero.
>   
>   Instruction classes
>   -------------------
> @@ -590,7 +585,7 @@ defined further below:
>   =========================  ======  ===  =========================================  ===========  ==============
>   opcode construction        opcode  src  pseudocode                                 imm type     dst type
>   =========================  ======  ===  =========================================  ===========  ==============
> -BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = imm64                                integer      integer
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = (next_imm << 32) | imm               integer      integer
>   BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst = map_by_fd(imm)                       map fd       map
>   BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst = map_val(map_by_fd(imm)) + next_imm   map fd       data pointer
>   BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = var_addr(imm)                        variable id  data pointer

