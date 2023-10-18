Return-Path: <bpf+bounces-12611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D797CEB42
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 00:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E242B212DC
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 22:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F75542C03;
	Wed, 18 Oct 2023 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="CNOQgF+/";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="eOl71qty"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A0A37143
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 22:29:09 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B52695
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 15:29:08 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 182C5C151981
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 15:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1697668148; bh=qQTtU/QgOXJedUV0e9VcDWBFtugySmudqsBYCnQjNew=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=CNOQgF+/FiJYzym7C9DhfkW5TJoXlDscw+W3DQCiGeT2SjNf9AK0tHrtEt3ExwIBP
	 MjfAc/ZKSsNFphC5/hz73aOJppp67vZfRnm7arMPcG4o6OLRqdSzJ7sz9N0PPSq4DY
	 JJvAIx3cANJpDTgsDoDnjX3aOBnPcs0GOL+sFEvQ=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Oct 18 15:29:07 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id BA5B4C151524;
	Wed, 18 Oct 2023 15:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1697668147; bh=qQTtU/QgOXJedUV0e9VcDWBFtugySmudqsBYCnQjNew=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=eOl71qty7MhTSexBqT9ZsxMI4oEK+WTx88M7Sr3yJZ6Lwdd/eyaksfAr2i9JApIwE
	 RSVW4iHrxHwqr92y1urszOrYdbc90wFgMFc65XZg5WfOgaqCmT1tq2pAZqX4G4LzWT
	 9KHhCYF2nECg3v1ZYVTCJ7AHlLPhEsLH0dhg/P/8=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id A38CDC151524
 for <bpf@ietfa.amsl.com>; Wed, 18 Oct 2023 15:29:06 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.406
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B6TE1BsXnJT1 for <bpf@ietfa.amsl.com>;
 Wed, 18 Oct 2023 15:29:02 -0700 (PDT)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 9944BC151087
 for <bpf@ietf.org>; Wed, 18 Oct 2023 15:29:02 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-66d122f6294so47363056d6.0
 for <bpf@ietf.org>; Wed, 18 Oct 2023 15:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697668141; x=1698272941;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u+kgU0/OVWAaw1sKs0CW5C18BLbSdEMvpGBE9X5n4Y4=;
 b=CSCdMFo4UCOLrXRjYrwv7kfNmbkn9oPOkFsSgMzUGGzMAX0F335dxNYszqZhGgxLbW
 nlFzyUCrtKGC8lWwLJpw3kZ8EqlEKimUUttBN/G8KDyqBfwlG3pIaZBOoVGHyBDaswwj
 WLqIHqXhHvQwy8obpU6kZtdy5u3ViH21BlCsNqSF9BhYD/mBArRzRHHDX/1XPPTdt+kO
 kUl5TU2w/I1uSV1XinAaH9aZk+vrYknNrVKrmDDQAx8oup/CoXVuIeA5xzE2MHFlGfDf
 B4MDXjTHgyykJI67iO2naQK0m/NOl/IO3Fs3kE0/i86nf1SpEL4PVjPddqbDfrr2bMPN
 +Bcg==
X-Gm-Message-State: AOJu0YxIB2eU7qgJt1M+U+3NSNw9BqoccQ+9yFBY2dPmtHyqiYSjRJmA
 sjOyXxeZvDjPwRSMqi3PqDU=
X-Google-Smtp-Source: AGHT+IFesjPkusA0tUPAzXZOoFWo5njxAWQVfZO19LlPnPXhHC4LLe7+rZYS4K1rzjjxcP3SjDe/+w==
X-Received: by 2002:a05:6214:c4e:b0:66d:55d9:9522 with SMTP id
 r14-20020a0562140c4e00b0066d55d99522mr559946qvj.23.1697668141552; 
 Wed, 18 Oct 2023 15:29:01 -0700 (PDT)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 bu11-20020ad455eb000000b0065afcf19e23sm286055qvb.62.2023.10.18.15.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:29:01 -0700 (PDT)
Date: Wed, 18 Oct 2023 17:28:59 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>,
 eddyz87@gmail.com
Message-ID: <20231018222859.GD4176@maniforge>
References: <20231017203020.1500-1-dthaler1968@googlemail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231017203020.1500-1-dthaler1968@googlemail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/r7wAktF6AG3idH8mg1KIaCTs3y4>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Define signed modulo as using truncated division
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

On Tue, Oct 17, 2023 at 08:30:20PM +0000, Dave Thaler wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> There's different mathematical definitions (truncated, floored,
> rounded, etc.) and different languages have chosen different
> definitions [0][1].  E.g., languages/libraries that follow Knuth
> use a different mathematical definition than C uses.  This
> patch specifies which definition BPF uses, as verified by
> Eduard [2] and others.
> 
> [0]: https://en.wikipedia.org/wiki/Modulo#Variants_of_the_definition
> [1]: https://torstencurdt.com/tech/posts/modulo-of-negative-numbers/
> [2]: https://lore.kernel.org/bpf/57e6fefadaf3b2995bb259fa8e711c7220ce5290.camel@gmail.com/
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>

Acked-by: David Vernet <void@manifault.com>

+cc Eduard as well in case he wants to take a look.

> ---
>  Documentation/bpf/standardization/instruction-set.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
> index c5d53a6e8c7..245b6defc29 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -283,6 +283,14 @@ For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``,
>  is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
>  interpreted as a 64-bit signed value.
>  
> +Note that there are varying definitions of the signed modulo operation
> +when the dividend or divisor are negative, where implementations often
> +vary by language such that Python, Ruby, etc.  differ from C, Go, Java,
> +etc. This specification requires that signed modulo use truncated division
> +(where -13 % 3 == -1) as implemented in C, Go, etc.:
> +
> +   a % n = a - n * trunc(a / n)
> +
>  The ``BPF_MOVSX`` instruction does a move operation with sign extension.
>  ``BPF_ALU | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into 32
>  bit operands, and zeroes the remaining upper 32 bits.
> -- 
> 2.33.4
> 
> 

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

