Return-Path: <bpf+bounces-7078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF4E771019
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 16:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4E71C20A26
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 14:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9CAC157;
	Sat,  5 Aug 2023 14:19:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB35A947
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 14:19:04 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DC04224
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 07:19:02 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A867FC15171F
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691245142; bh=eQo4dg1IHRGMyX0r91Wj85PTMHXVYT1RLVKnws2vJnc=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=NThel9Z7/LbeqnuxrDedwkbAuxtL7hquTjicjVlLOAofOXIK1wRqWLeXpJBZVPFEA
	 RQ3Bn3m4evjFVKfjlEA3Jpq5QbXQAUn9ojmTip56/hDOocJYJUTvcW6cCSBo816V7/
	 TcOfDnmPmuKp0QSeWKlygFlb1LAMFHkoYwJMnpv8=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sat Aug  5 07:19:02 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 77E12C1516E1;
	Sat,  5 Aug 2023 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691245142; bh=eQo4dg1IHRGMyX0r91Wj85PTMHXVYT1RLVKnws2vJnc=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=NThel9Z7/LbeqnuxrDedwkbAuxtL7hquTjicjVlLOAofOXIK1wRqWLeXpJBZVPFEA
	 RQ3Bn3m4evjFVKfjlEA3Jpq5QbXQAUn9ojmTip56/hDOocJYJUTvcW6cCSBo816V7/
	 TcOfDnmPmuKp0QSeWKlygFlb1LAMFHkoYwJMnpv8=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 30DC5C1516E1
 for <bpf@ietfa.amsl.com>; Sat,  5 Aug 2023 07:19:01 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.41
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MTwlthPPUJsR for <bpf@ietfa.amsl.com>;
 Sat,  5 Aug 2023 07:19:00 -0700 (PDT)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 5B722C1516E0
 for <bpf@ietf.org>; Sat,  5 Aug 2023 07:19:00 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-63d0228d32bso17586726d6.2
 for <bpf@ietf.org>; Sat, 05 Aug 2023 07:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691245139; x=1691849939;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b+bIsySnS9wekAcl86cah5jj1GBYy2hqAwy6Y6XUKhM=;
 b=aOYJQ0CiIaV80OZlW6d/5v0xbwjW6NnSSy0t4zy/eiv+C5kkkNtNu3NCTMQebtoCtu
 fl8CbXnxQoj50ypXtuUQQNuuHu4iV3j9l+ULlI1pwkGC3v8C6L0xMit52QVDRAMG+s6i
 oYQJQa90hAq44C3xsiy+g3Yxjtrh/mUe5OwlXII8ZKV7WlKsmklG6v4Y2hHY7IEh5ORh
 quEsTAZxvfS/OZuEbxkqk5guEFWrnWkaNqOqn1j1Enw6zFaXGa6x2v06r3+U4X+WDGhF
 9Q1MB5CHxMdgFDk8H1WHKNrtwkVaTt8TBq12SxCr2na1+s2bwDBQrFZp1OMM5SvCnnMy
 mkGw==
X-Gm-Message-State: AOJu0YzHVkIAJD40455sXPHHIix/yQHn4clYE3KVQCXsThEDf/h/jDJU
 Uy/6R7hPXRYlDLkHrVmQr4I=
X-Google-Smtp-Source: AGHT+IHDj9YQ2By/PhJo2kB7LNgsuLfPEtNwDQuXLbS6Y3zlbqQvoe2KxW6eqgQjDX/N2OvFUU8xLQ==
X-Received: by 2002:a0c:eb83:0:b0:63c:7584:a3c0 with SMTP id
 x3-20020a0ceb83000000b0063c7584a3c0mr4927831qvo.52.1691245139087; 
 Sat, 05 Aug 2023 07:18:59 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:f01c])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a0cb387000000b0061a68b5a8c4sm1475696qve.134.2023.08.05.07.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 07:18:58 -0700 (PDT)
Date: Sat, 5 Aug 2023 09:18:56 -0500
From: David Vernet <void@manifault.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Message-ID: <20230805141856.GD519395@maniforge>
References: <20230805030921.52035-1-hawkinsw@obs.cr>
 <20230805030921.52035-2-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230805030921.52035-2-hawkinsw@obs.cr>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/u5rOlDTh9o_xw_vrckisAonwB7A>
Subject: Re: [Bpf] [PATCH v3 2/2] bpf,
 docs: Fix small typo and define semantics of sign extension
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

