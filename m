Return-Path: <bpf+bounces-7076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B8E771016
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 16:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02611C20A7D
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 14:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AFCC157;
	Sat,  5 Aug 2023 14:14:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C0EA947
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 14:14:35 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F06B3C16
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 07:14:34 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3C66FC151981
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691244874; bh=U4TR4kl6KPTDZMxl3E811ZBsrM+qTtFYcvVJrSylvfA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=FWr31Y77nTJmGJkUlX0T+QHjtEFsTwuAC85aZJ6epQrJD4qxw3S0gNx5XPt6Yi95K
	 F/kIOOlJj1xBCy8iWOXZxQ5n5EnFXlwLBImfgugwoZBpVQFLkUFltW5ZT9mXOvI/UU
	 rGySLT98tH4t2riuysCJMe0psXK+/+CeuYaBLCRo=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sat Aug  5 07:14:34 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id EC9A8C15108B;
	Sat,  5 Aug 2023 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691244874; bh=U4TR4kl6KPTDZMxl3E811ZBsrM+qTtFYcvVJrSylvfA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=FWr31Y77nTJmGJkUlX0T+QHjtEFsTwuAC85aZJ6epQrJD4qxw3S0gNx5XPt6Yi95K
	 F/kIOOlJj1xBCy8iWOXZxQ5n5EnFXlwLBImfgugwoZBpVQFLkUFltW5ZT9mXOvI/UU
	 rGySLT98tH4t2riuysCJMe0psXK+/+CeuYaBLCRo=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 2CF17C15108B
 for <bpf@ietfa.amsl.com>; Sat,  5 Aug 2023 07:14:32 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.41
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id anEHzrxU1aIi for <bpf@ietfa.amsl.com>;
 Sat,  5 Aug 2023 07:14:31 -0700 (PDT)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 7BAFEC15106C
 for <bpf@ietf.org>; Sat,  5 Aug 2023 07:14:31 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-765a7768f1dso260993885a.0
 for <bpf@ietf.org>; Sat, 05 Aug 2023 07:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691244870; x=1691849670;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sAVDVCo+4slW4hCzfuwcLGF5uKTnDKfhS8R43/E39JY=;
 b=MQ9L6fmbtXHbFdzDneMxh9d8HrEbC4/iV53vgb4Hb0OWJfZ8CnG3YOtBMaYyuVey+w
 4rPecilZI+RY0mLsrXsShaDPqNL1qJdsKiiEAnjltT87tdex1tLOqE72YusAwmjoRONf
 rdHTUjDfSS6Z8edRPIn0No2G3LIsmVzCM8mowMUGJFZe6M+LjIdx35BhC3Xpf/uH3vgu
 hxkHHU2nSViQnIvkM5Bd1I31lUOiUvf4L4iOYAmD0u1T5Qx10ekBFcMWr/YHU8ULLrLH
 26sL+lfDfwDCK+Z+Dx2KApHG3sGAgCpW+fqtm14ITe6/amGjIpRJjqMgXcohtw9zrqgz
 atmw==
X-Gm-Message-State: AOJu0Yyto5agMCseg+LKaDLkuLMyvH1KjGpdfcWWhKv/SMVtVajCcVmk
 9clh2SOpU3VEYwXddsRGOno=
X-Google-Smtp-Source: AGHT+IHCBxVgd48w6iqlEeqBCs606qitHNITcise7l3gLZ6N0bxTA7P4HEU4x6dzvk101D6crdiJLw==
X-Received: by 2002:ae9:df85:0:b0:760:6b8e:eba with SMTP id
 t127-20020ae9df85000000b007606b8e0ebamr5111468qkf.12.1691244870317; 
 Sat, 05 Aug 2023 07:14:30 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:f01c])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a0cf18e000000b0063d561ea04csm1427055qvl.102.2023.08.05.07.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 07:14:29 -0700 (PDT)
Date: Sat, 5 Aug 2023 09:14:27 -0500
From: David Vernet <void@manifault.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Message-ID: <20230805141427.GC519395@maniforge>
References: <20230805030921.52035-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230805030921.52035-1-hawkinsw@obs.cr>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/5hJyk80rOje0B_vPoKhpyZDaRDM>
Subject: Re: [Bpf] [PATCH v3 1/2] bpf,
 docs: Formalize type notation and function semantics in ISA standard
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 11:09:18PM -0400, Will Hawkins wrote:
> Give a single place where the shorthand for types are defined, the
> semantics of helper functions are described, and certain terms can
> be defined.
> 
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>

Hi Will,

This is looking great. Left a couple more comments below, let me know
what you think.

> ---
>  .../bpf/standardization/instruction-set.rst   | 79 +++++++++++++++++--
>  1 file changed, 71 insertions(+), 8 deletions(-)
> 
>  Changelog:
>    v1 -> v2:
> 	   - Remove change to Sphinx version
> 		 - Address David's comments
> 		 - Address Dave's comments
>    v2 -> v3:
> 	   - Add information about sign extending
> 
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
> index 655494ac7af6..fe296f35e5a7 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -10,9 +10,68 @@ This document specifies version 1.0 of the eBPF instruction set.
>  Documentation conventions
>  =========================
>  
> -For brevity, this document uses the type notion "u64", "u32", etc.
> -to mean an unsigned integer whose width is the specified number of bits,
> -and "s32", etc. to mean a signed integer of the specified number of bits.
> +For brevity and consistency, this document refers to families
> +of types using a shorthand syntax and refers to several expository,
> +mnemonic functions when describing the semantics of opcodes. The range

Hmm, I wonder if it's slightly more accurate to say that those functions
are describing the semantics of "instructions" rather than "opcodes",
given that the value in the immediate for the byte swap instructions
dictate the width. What do you think?

> +of valid values for those types and the semantics of those functions
> +are defined in the following subsections.
> +
> +Types
> +-----
> +This document refers to integer types with a notation of the form `SN`
> +that succinctly defines whether their values are signed or unsigned

Suggestion: I don't think we need the word "succinctly" here. I'm also
inclined to suggest that we avoid using the word "define" here, as the
notation itself isn't really defining the values of the types, but is
rather just a shorthand.

> +numbers and the bit widths:

What do you think about this phrasing:

This document refers to integer types with the notation `SN` to specify
a type's signedness and bit width respectively.

Feel free to disagree. My thinking here is that it might make more sense
to explain the notation as an informal shorthand rather than as a formal
defnition, as making it a formal definition might open its own can of
worms (e.g. we would probably also have to define what signedness means,
etc).

> +
> +=== =======
> +`S` Meaning
> +=== =======
> +`u` unsigned
> +`s` signed
> +=== =======
> +
> +===== =========
> +`N`   Bit width
> +===== =========
> +`8`   8 bits
> +`16`  16 bits
> +`32`  32 bits
> +`64`  64 bits
> +`128` 128 bits
> +===== =========

Is it by any chance possible to put these two tables on the same row?
Not sure if rst is up to that challenge, and if not feel free to ignore.

> +
> +For example, `u32` is a type whose valid values are all the 32-bit unsigned
> +numbers and `s16` is a types whose valid values are all the 16-bit signed
> +numbers.
> +
> +Functions
> +---------
> +* `htobe16`: Takes an unsigned 16-bit number in host-endian format and
> +  returns the equivalent number as an unsigned 16-bit number in big-endian
> +  format.
> +* `htobe32`: Takes an unsigned 32-bit number in host-endian format and
> +  returns the equivalent number as an unsigned 32-bit number in big-endian
> +  format.
> +* `htobe64`: Takes an unsigned 64-bit number in host-endian format and
> +  returns the equivalent number as an unsigned 64-bit number in big-endian
> +  format.
> +* `htole16`: Takes an unsigned 16-bit number in host-endian format and
> +  returns the equivalent number as an unsigned 16-bit number in little-endian
> +  format.
> +* `htole32`: Takes an unsigned 32-bit number in host-endian format and
> +  returns the equivalent number as an unsigned 32-bit number in little-endian
> +  format.
> +* `htole64`: Takes an unsigned 64-bit number in host-endian format and
> +  returns the equivalent number as an unsigned 64-bit number in little-endian
> +  format.
> +* `bswap16`: Takes an unsigned 16-bit number in either big- or little-endian
> +  format and returns the equivalent number with the same bit width but
> +  opposite endianness.
> +* `bswap32`: Takes an unsigned 32-bit number in either big- or little-endian
> +  format and returns the equivalent number with the same bit width but
> +  opposite endianness.
> +* `bswap64`: Takes an unsigned 64-bit number in either big- or little-endian
> +  format and returns the equivalent number with the same bit width but
> +  opposite endianness.

Upon further reflection, maybe this belongs in the Byte swap
instructions section of the document? The types make sense to list above
because they're ubiquitous throughout the doc, but these are really 100%
specific to byte swap.

>  
>  Registers and calling convention
>  ================================
> @@ -252,19 +311,23 @@ are supported: 16, 32 and 64.
>  
>  Examples:
>  
> -``BPF_ALU | BPF_TO_LE | BPF_END`` with imm = 16 means::
> +``BPF_ALU | BPF_TO_LE | BPF_END`` with imm = 16/32/64 means::
>  
>    dst = htole16(dst)
> +  dst = htole32(dst)
> +  dst = htole64(dst)
>  
> -``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 64 means::
> +``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 16/32/64 means::
>  
> +  dst = htobe16(dst)
> +  dst = htobe32(dst)
>    dst = htobe64(dst)
>  
>  ``BPF_ALU64 | BPF_TO_LE | BPF_END`` with imm = 16/32/64 means::
>  
> -  dst = bswap16 dst
> -  dst = bswap32 dst
> -  dst = bswap64 dst
> +  dst = bswap16(dst)
> +  dst = bswap32(dst)
> +  dst = bswap64(dst)
>  

[...]

- David

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

