Return-Path: <bpf+bounces-6607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9A876BDDD
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 21:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04011C20858
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 19:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0F925172;
	Tue,  1 Aug 2023 19:35:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD3B2515E
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 19:35:50 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C4619A8
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 12:35:49 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-76c845dc5beso261336385a.1
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 12:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690918548; x=1691523348;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlhhS7kfbla9qv0NmNoYHsZTH4ZpHkrh0WDGmda+xFQ=;
        b=KbVJYOFCFKmdAUqFn+3zD12tNp7Vo5/tfJTymse5q8ofEVT8aM6kaf9QKsST7XzCeN
         iYAXCWUE5eC90hsGrD7uDQHwhp7alViznLtZQFDorc7uDnZ/vgEUjPCCM6JwC344GdV6
         YYS5anb/Djmc//tATZL3+3sKzPFWRl7GO0xivTceqD8ShAAffDooprhROjJU1WLZ5jlw
         d2C535ksQhddu/cxqwJuSIq8JGTBPal/BiW7o1IlDM3/rKxpMOGmkKiD6/nPy6h4C03B
         zW6cY10kl7rpj3f/a6+OIK6OVKuYAmM3GCDSEJySCG8n8o+UE6seICUzlnxWOB9S6152
         Kopw==
X-Gm-Message-State: ABy/qLbA68tP0JeyixEeEZyl7CUrsZ7eLpobvYjwkGnW/3HfWKQZwOkC
	z619MmvVouben0UQ10vYQUo=
X-Google-Smtp-Source: APBJJlHnZXDWKX2G01ajPmOo5e2Ovpdqap9eK2GdkQpeSIUh9TZkEHLTqh6h7u5kth7U9YFzESPRkQ==
X-Received: by 2002:a05:620a:1a24:b0:767:35a:5f19 with SMTP id bk36-20020a05620a1a2400b00767035a5f19mr13017374qkb.14.1690918548235;
        Tue, 01 Aug 2023 12:35:48 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:e145])
        by smtp.gmail.com with ESMTPSA id l22-20020ac87256000000b00403eab8b7cesm4595943qtp.16.2023.08.01.12.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 12:35:40 -0700 (PDT)
Date: Tue, 1 Aug 2023 14:35:38 -0500
From: David Vernet <void@manifault.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Subject: Re: [Bpf] [PATCH 1/1] bpf, docs: Formalize type notation and
 function semantics in ISA standard
Message-ID: <20230801193538.GA472124@maniforge>
References: <20230730035156.2728106-1-hawkinsw@obs.cr>
 <20230730035156.2728106-2-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730035156.2728106-2-hawkinsw@obs.cr>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 29, 2023 at 11:51:56PM -0400, Will Hawkins wrote:
> Give a single place where the shorthand for types are defined and the
> semantics of helper functions are described.
> 
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> ---
>  .../bpf/standardization/instruction-set.rst   | 65 ++++++++++++++++++-
>  Documentation/sphinx/requirements.txt         |  2 +-
>  2 files changed, 63 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
> index fb8154cedd84..97378388e20b 100644
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
> +of types using a shorthand syntax and refers to several helper
> +functions when explaining the semantics of opcodes. The range

nit: Can we use a different term than "helper functions" here, just
because it's an overloaded term for BPF. Maybe "shorthand functions" or
"mnemonic functions"? Or just "functions"?

> +of valid values for those types and the semantics of those functions
> +are defined in the following subsections.
> +
> +Types
> +-----
> +This document refers to integer types with a notation of the form `SX`

I suggest replacing `SX` with `Sn`, as `SX` is short for sign-extension
in several instructions.

> +that succinctly defines whether their values are signed or unsigned
> +numbers and the bit widths:
> +
> +=== =======
> +`S` Meaning
> +=== =======
> +`u` unsigned
> +`s` signed
> +=== =======
> +
> +===== =========
> +`X`   Bit width
> +===== =========
> +`8`   8 bits
> +`16`  16 bits
> +`32`  32 bits
> +`64`  64 bits
> +`128` 128 bits
> +===== =========
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

Hmm, some of these functions aren't actually used elsewhere in the
document. Maybe update the hto{b,l}eN examples later in the Byte swap
instructions section to match bswapN where all widths are illustrated in
the example?

> +* `bswap16`: Takes an unsigned 16-bit number in either big- or little-endian
> +  format and returns the equivalent number with the same bit width but
> +  opposite endianness.
> +* `bswap32`: Takes an unsigned 32-bit number in either big- or little-endian
> +  format and returns the equivalent number with the same bit width but
> +  opposite endianness.
> +* `bswap64`: Takes an unsigned 64-bit number in either big- or little-endian
> +  format and returns the equivalent number with the same bit width but
> +  opposite endianness.
>  
>  Registers and calling convention
>  ================================
> diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
> index 335b53df35e2..9479c5c2e338 100644
> --- a/Documentation/sphinx/requirements.txt
> +++ b/Documentation/sphinx/requirements.txt
> @@ -1,3 +1,3 @@
>  # jinja2>=3.1 is not compatible with Sphinx<4.0
>  jinja2<3.1
> -Sphinx==2.4.4
> +Sphinx==7.1.1

I don't think we can unilaterally update the whole kernel docs tree to
require a new version of Sphinx like this. Could you please clarify why
you needed to update it? Was it for the tables or something?

> -- 
> 2.40.1
> 
> -- 
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf

