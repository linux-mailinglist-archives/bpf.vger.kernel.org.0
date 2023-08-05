Return-Path: <bpf+bounces-7075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAAB771015
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 16:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5362281563
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 14:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65613C14D;
	Sat,  5 Aug 2023 14:14:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DEEA947
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 14:14:33 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5E83C16
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 07:14:31 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-768054797f7so259417785a.2
        for <bpf@vger.kernel.org>; Sat, 05 Aug 2023 07:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691244870; x=1691849670;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAVDVCo+4slW4hCzfuwcLGF5uKTnDKfhS8R43/E39JY=;
        b=l0lUvvfTe+//UWg5N6HHK2vVvBSBK97lrqUVbfguRh8AE6VvO9s19g5MlQIsV1mZWK
         fkezhVnanVnBLhNJr0zHGSTBbpKnRK/C3iHwmMXgJHNm08IdExVUc5pkbLDg3Il5SzN+
         SZVbbUY+ZKC8XpglY7f+dRkwWkzjU/Y6K8Si2B6//GDmW2GX3MzlTp/vMlB0mRlVBt8R
         ueHvDiuu1gHl8f8+99TQGA7ANLxEcG2bMUloILnmTGUnFOhgmuxX0YSa/Q6rp9ZMy2Nl
         egQ8zMdk/ZdT9SBX+kr15mwZCQp3VX4zsET8aNHbN0CvhiVE+rUdE0tF2l/oRSkATQME
         mrUA==
X-Gm-Message-State: AOJu0YwCHnAANRRv+swPbCRLovQM5L4CJpEWmUdGZb4LiFPbVG4wDbHq
	cx8PJvERf9aVJWyx6VCPQix0A1jaI6FIZg==
X-Google-Smtp-Source: AGHT+IHCBxVgd48w6iqlEeqBCs606qitHNITcise7l3gLZ6N0bxTA7P4HEU4x6dzvk101D6crdiJLw==
X-Received: by 2002:ae9:df85:0:b0:760:6b8e:eba with SMTP id t127-20020ae9df85000000b007606b8e0ebamr5111468qkf.12.1691244870317;
        Sat, 05 Aug 2023 07:14:30 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:f01c])
        by smtp.gmail.com with ESMTPSA id m14-20020a0cf18e000000b0063d561ea04csm1427055qvl.102.2023.08.05.07.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 07:14:29 -0700 (PDT)
Date: Sat, 5 Aug 2023 09:14:27 -0500
From: David Vernet <void@manifault.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Subject: Re: [Bpf] [PATCH v3 1/2] bpf, docs: Formalize type notation and
 function semantics in ISA standard
Message-ID: <20230805141427.GC519395@maniforge>
References: <20230805030921.52035-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805030921.52035-1-hawkinsw@obs.cr>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
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

