Return-Path: <bpf+bounces-6608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAD276BDE0
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 21:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1259281B0C
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 19:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7221253A9;
	Tue,  1 Aug 2023 19:36:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC116235B3
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 19:36:32 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A587919AA
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 12:36:30 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B3B3AC17EB58
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 12:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690918556; bh=cxDtKyiSPMNkQZ8D2oQFWlUp9tkJ15Zt60jFpYqtpxM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=tfNofF2hD+m6JyYKrA62mDRe5Rv3Qz7UIuME2XZh4nuBTKr9qGHdFw9hMPgTaNB/K
	 VLHnBP6m+wr7MsflAr8hLIp35n/w0/zIgQXYj0OJpW8qP6jftA1uE5cTDydI5/L8KF
	 mC5+vCne31DpBdLUT1I5IxOlJRhAIH7IUU1pN5vM=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Aug  1 12:35:56 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2A12AC131943;
	Tue,  1 Aug 2023 12:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690918556; bh=cxDtKyiSPMNkQZ8D2oQFWlUp9tkJ15Zt60jFpYqtpxM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=tfNofF2hD+m6JyYKrA62mDRe5Rv3Qz7UIuME2XZh4nuBTKr9qGHdFw9hMPgTaNB/K
	 VLHnBP6m+wr7MsflAr8hLIp35n/w0/zIgQXYj0OJpW8qP6jftA1uE5cTDydI5/L8KF
	 mC5+vCne31DpBdLUT1I5IxOlJRhAIH7IUU1pN5vM=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 30EFBC151548
 for <bpf@ietfa.amsl.com>; Tue,  1 Aug 2023 12:35:53 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.407
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GVBx0p6ULb6u for <bpf@ietfa.amsl.com>;
 Tue,  1 Aug 2023 12:35:49 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 6755BC15155A
 for <bpf@ietf.org>; Tue,  1 Aug 2023 12:35:49 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-76c845dc5beso261336485a.1
 for <bpf@ietf.org>; Tue, 01 Aug 2023 12:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690918548; x=1691523348;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nlhhS7kfbla9qv0NmNoYHsZTH4ZpHkrh0WDGmda+xFQ=;
 b=BHmj1LPxJHz/4d3v8/0Bh9AH6S0MoL9CXOkqo9Q/Pkg6RNJMKO19MkIlFiDH555R87
 DRS4KiyIDiVbI5BsrOORWMags+b4J+PPTzlw02yRWnwTV2RyPHiQ6S1QGFVaYciKNvtC
 BvDUnJWcXZmhUKXjyL98mJj1FWqeC8183LNYSKlqkUrbtMcCHQHD3Xo3egK3bSIXpO+U
 b+aYre5uN96hjedEqm8Gdm7V3nGq6nrPsJ4Es9qFhfG6Uu37LKQeijV8czY+18PTsFp4
 Bs4tr73p0nb6UyeiCn6BxhPDphNnU1oH0d1fFXyufa4UXN/pEVfZHA6RT25MErVbW3cl
 Gflw==
X-Gm-Message-State: ABy/qLa2iMDDIM3+WkPoFkRg0r7u02izPaYHzsXY3Fhl1dJVCc44wbU4
 00T/KPyhRmFlF2Cvl6syrvECkLixN0urWg==
X-Google-Smtp-Source: APBJJlHnZXDWKX2G01ajPmOo5e2Ovpdqap9eK2GdkQpeSIUh9TZkEHLTqh6h7u5kth7U9YFzESPRkQ==
X-Received: by 2002:a05:620a:1a24:b0:767:35a:5f19 with SMTP id
 bk36-20020a05620a1a2400b00767035a5f19mr13017374qkb.14.1690918548235; 
 Tue, 01 Aug 2023 12:35:48 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:e145])
 by smtp.gmail.com with ESMTPSA id
 l22-20020ac87256000000b00403eab8b7cesm4595943qtp.16.2023.08.01.12.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Aug 2023 12:35:40 -0700 (PDT)
Date: Tue, 1 Aug 2023 14:35:38 -0500
From: David Vernet <void@manifault.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Message-ID: <20230801193538.GA472124@maniforge>
References: <20230730035156.2728106-1-hawkinsw@obs.cr>
 <20230730035156.2728106-2-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230730035156.2728106-2-hawkinsw@obs.cr>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/338Bl1UKWhLHhQcKW4CgBHVFGW4>
Subject: Re: [Bpf] [PATCH 1/1] bpf,
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

