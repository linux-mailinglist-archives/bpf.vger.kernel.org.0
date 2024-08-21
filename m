Return-Path: <bpf+bounces-37769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 797DC95A696
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 23:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245311F22437
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 21:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ED6175D25;
	Wed, 21 Aug 2024 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NUh76mnU"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F32178361
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275806; cv=none; b=HtXaevpvh9gJ/R9TDDSnVy6+YKvLI+6DZs6HbSmBDXnG092Ej4CG5+TLv+QCy3ET5bLEBA3Yib7VrWzMt9fvpewOodmPY2/0t378yc4O0gEmYmNFixUT/OBkB3uZ3qjb2XqFl3SgmsRbWg08G0ekmR3ShxxUHLKdOz6FOatGYZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275806; c=relaxed/simple;
	bh=27pDiIsVNvoMbAWwuRJ/5z2eInS8/fRSbEja4CgE5Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gVZkK0ppxozjoF/YPbHbSW1mol9pJOJIOCUxiifj3H65xIdECZVEE+0Paw+8iioh41nVy8zRmWa4LsqwHgCsz1mPAJWti8nQc/QUFImdfC1e0y84lX46eMm765GqYNMZVxxyAj9YKyhBL7Q7+Z/cg3OkRZpB8vooGiHCFB4N844=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NUh76mnU; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0de00576-e102-4586-8695-62f2bf37eb3f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724275802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXFDf2XYk15cjs0a57QWQ1ZTImPa4JMJGtnDnTjx6w0=;
	b=NUh76mnUHVFWEi8IX61k9wM5iseE7jghrsmlhPJaOjKY2ttKB+L4ig+/8q/c1fvm1s3xMc
	yP3SRqaJJnvmvkJlFi3as5lGqiRwRUur3W82EtQkcsn6ssD4NtQmDoaDrafdnpjfbguvR6
	wh1Ft3y2mlM3hmRD/KDbMcYVGbZAqdg=
Date: Wed, 21 Aug 2024 14:29:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] docs/bpf: Add constant values for linkages
Content-Language: en-GB
To: Will Hawkins <hawkinsw@obs.cr>, bpf@vger.kernel.org, bpf@ietf.org
References: <20240819223008.469271-1-hawkinsw@obs.cr>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240819223008.469271-1-hawkinsw@obs.cr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/19/24 3:30 PM, Will Hawkins wrote:
> Make the values of the symbolic constants that define the valid linkages
> for functions and variables explicit.
>
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> ---
>   Documentation/bpf/btf.rst | 44 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 257a7e1cdf5d..cce03f1e552a 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -368,7 +368,7 @@ No additional type data follow ``btf_type``.
>     * ``info.kind_flag``: 0
>     * ``info.kind``: BTF_KIND_FUNC
>     * ``info.vlen``: linkage information (BTF_FUNC_STATIC, BTF_FUNC_GLOBAL
> -                   or BTF_FUNC_EXTERN)
> +                   or BTF_FUNC_EXTERN - see :ref:`BTF_Function_Linkage_Constants`)
>     * ``type``: a BTF_KIND_FUNC_PROTO type
>   
>   No additional type data follow ``btf_type``.
> @@ -424,9 +424,9 @@ following data::
>           __u32   linkage;
>       };
>   
> -``struct btf_var`` encoding:
> -  * ``linkage``: currently only static variable 0, or globally allocated
> -                 variable in ELF sections 1
> +``btf_var.linkage`` may take the values: BTF_VAR_STATIC (for a static variable),
> +or BTF_VAR_GLOBAL_ALLOCATED (for a globally allocated variable stored in ELF sections 1) -

Let us remove the above '1', just say '(... stored in explicit ELF sections)'.

Actually, for btf_var linkage, we actually have 3 values. See

enum {
	BTF_VAR_STATIC = 0,
	BTF_VAR_GLOBAL_ALLOCATED = 1,
	BTF_VAR_GLOBAL_EXTERN = 2,
};

See https://github.com/torvalds/linux/blob/master/include/uapi/linux/btf.h#L150-L154

Similar to BTF_VAR_GLOBAL_ALLOCATED, BTF_VAR_GLOBAL_EXTERN is encoded in datasec only
if the variable is stored in explicit ELF sections.

Since you are touching this doc, could you add BTF_VAR_GLOBAL_EXTERN as well?

> +see :ref:`BTF_Var_Linkage_Constants`.
>   
>   Not all type of global variables are supported by LLVM at this point.
>   The following is currently available:
> @@ -549,6 +549,42 @@ The ``btf_enum64`` encoding:
>   If the original enum value is signed and the size is less than 8,
>   that value will be sign extended into 8 bytes.
>   
> +2.3 Constant Values
> +-------------------
> +
> +.. _BTF_Function_Linkage_Constants:
> +
> +2.3.1 Function Linkage Constant Values
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +.. list-table::
> +   :widths: 1 1
> +   :header-rows: 1
> +
> +   * - Name
> +     - Value
> +   * - ``BTF_FUNC_STATIC``
> +     - ``0``
> +   * - ``BTF_FUNC_GLOBAL``
> +     - ``1``
> +   * - ``BTF_FUNC_EXTERN``
> +     - ``2``
> +
> +.. _BTF_Var_Linkage_Constants:
> +
> +2.3.2 Variable Linkage Constant Values
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +.. list-table::
> +   :widths: 1 1
> +   :header-rows: 1
> +
> +   * - Name
> +     - Value
> +   * - ``BTF_VAR_STATIC``
> +     - ``0``
> +   * - ``BTF_VAR_GLOBAL_ALLOCATED``
> +     - ``1``
> +
> +

Form the above, could you use similar format as in Documentation/bpf/standardization/instruction-set.rst? For example,

.. table:: Instruction class

   =====  =====  ===============================  ===================================
   class  value  description                      reference
   =====  =====  ===============================  ===================================
   LD     0x0    non-standard load operations     `Load and store instructions`_
   LDX    0x1    load into register operations    `Load and store instructions`_
   ST     0x2    store from immediate operations  `Load and store instructions`_
   STX    0x3    store from register operations   `Load and store instructions`_
   ALU    0x4    32-bit arithmetic operations     `Arithmetic and jump instructions`_
   JMP    0x5    64-bit jump operations           `Arithmetic and jump instructions`_
   JMP32  0x6    32-bit jump operations           `Arithmetic and jump instructions`_
   ALU64  0x7    64-bit arithmetic operations     `Arithmetic and jump instructions`_
   =====  =====  ===============================  ===================================

I would like we have consistant table presentation between instruction set and btf.

>   3. BTF Kernel API
>   =================
>   

