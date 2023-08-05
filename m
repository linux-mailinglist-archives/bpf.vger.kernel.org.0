Return-Path: <bpf+bounces-7077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FBA771018
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 16:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3171C20A96
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 14:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAA0C14D;
	Sat,  5 Aug 2023 14:19:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4541A947
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 14:19:01 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4393C16
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 07:19:00 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-76cd8dab98fso228117885a.3
        for <bpf@vger.kernel.org>; Sat, 05 Aug 2023 07:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691245139; x=1691849939;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+bIsySnS9wekAcl86cah5jj1GBYy2hqAwy6Y6XUKhM=;
        b=ike79hMYjfz/EevAKvM26czF2lEuZsNOel3W3cfthfFqcjzZmDWwcshQJZFYgFHTiE
         DnezZK2Sj67ZojOi2wXsS6cIvpV7ut5KxGbcrXhTdhob6hqL8NopKozzEAsAk7O+jJv4
         mS6+uv0XtrkPGcc3Skk1Ziy9TIfw8tZWynPbDYJM/6w3iUFQCtNP0eA0YrKGhordhCrg
         M7o0MY3j4OR9oGq8ef87TA7InVmyfFeml6i3JJtmMLnp8SCoGsAjEaxlNTgg68QZ/hCj
         TGhWdD9e90TXEKXqZCMBl0dtPV79wykebLkI/5akxiKnkXbibk8QTTcrVu3i+uTZZM4S
         xM7g==
X-Gm-Message-State: AOJu0Yz+POArn/zxP/CuYBF6llmRk9cDc8NS/+lPpfq4YoU6v3sxxC2P
	JawuAuY4eBc1gZYqUs4VcnM=
X-Google-Smtp-Source: AGHT+IHDj9YQ2By/PhJo2kB7LNgsuLfPEtNwDQuXLbS6Y3zlbqQvoe2KxW6eqgQjDX/N2OvFUU8xLQ==
X-Received: by 2002:a0c:eb83:0:b0:63c:7584:a3c0 with SMTP id x3-20020a0ceb83000000b0063c7584a3c0mr4927831qvo.52.1691245139087;
        Sat, 05 Aug 2023 07:18:59 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:f01c])
        by smtp.gmail.com with ESMTPSA id t7-20020a0cb387000000b0061a68b5a8c4sm1475696qve.134.2023.08.05.07.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 07:18:58 -0700 (PDT)
Date: Sat, 5 Aug 2023 09:18:56 -0500
From: David Vernet <void@manifault.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Subject: Re: [Bpf] [PATCH v3 2/2] bpf, docs: Fix small typo and define
 semantics of sign extension
Message-ID: <20230805141856.GD519395@maniforge>
References: <20230805030921.52035-1-hawkinsw@obs.cr>
 <20230805030921.52035-2-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805030921.52035-2-hawkinsw@obs.cr>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 11:09:19PM -0400, Will Hawkins wrote:
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>

Hi Will,

Given that this is a separate patch, it should also have its own commit
summary as it would be merged as a separate commit to the kernel.

- David

> ---
>  .../bpf/standardization/instruction-set.rst   | 31 ++++++++++++++++---
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
> index fe296f35e5a7..6f3b34ef7b7c 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -73,6 +73,27 @@ Functions
>    format and returns the equivalent number with the same bit width but
>    opposite endianness.
>  
> +
> +Definitions
> +-----------
> +
> +.. glossary::
> +
> +  Sign Extend
> +    To `sign extend an` ``X`` `-bit number, A, to a` ``Y`` `-bit number, B  ,` means to
> +
> +    #. Copy all ``X`` bits from `A` to the lower ``X`` bits of `B`.
> +    #. Set the value of the remaining ``Y`` - ``X`` bits of `B` to the value of
> +       the  most-significant bit of `A`.
> +
> +.. admonition:: Example
> +
> +  Sign extend an 8-bit number ``A`` to a 16-bit number ``B`` on a big-endian platform:
> +  ::
> +
> +    A:          10000110
> +    B: 11111111 10000110
> +
>  Registers and calling convention
>  ================================
>  
> @@ -263,17 +284,17 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
>  Note that most instructions have instruction offset of 0. Only three instructions
>  (``BPF_SDIV``, ``BPF_SMOD``, ``BPF_MOVSX``) have a non-zero offset.
>  
> -The devision and modulo operations support both unsigned and signed flavors.
> +The division and modulo operations support both unsigned and signed flavors.
>  
>  For unsigned operations (``BPF_DIV`` and ``BPF_MOD``), for ``BPF_ALU``,
>  'imm' is interpreted as a 32-bit unsigned value. For ``BPF_ALU64``,
> -'imm' is first sign extended from 32 to 64 bits, and then interpreted as
> -a 64-bit unsigned value.
> +'imm' is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
> +interpreted as a 64-bit unsigned value.
>  
>  For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``,
>  'imm' is interpreted as a 32-bit signed value. For ``BPF_ALU64``, 'imm'
> -is first sign extended from 32 to 64 bits, and then interpreted as a
> -64-bit signed value.
> +is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
> +interpreted as a 64-bit signed value.
>  
>  The ``BPF_MOVSX`` instruction does a move operation with sign extension.
>  ``BPF_ALU | BPF_MOVSX`` sign extends 8-bit and 16-bit operands into 32

There are some other places where we say e.g. "sign extend", "sign
extending", etc. Can we link those places to your handy new section as
well, please?

Thanks,
David

