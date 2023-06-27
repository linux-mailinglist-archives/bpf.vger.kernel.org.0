Return-Path: <bpf+bounces-3604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BEE7405EA
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 23:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC61D280CC5
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 21:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE8618B0F;
	Tue, 27 Jun 2023 21:47:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821EB46A8
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 21:47:00 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C1D10EC
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 14:46:45 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id C83A5C16B1E5
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1687902405; bh=8fQR0eRfIEG4+0EzB5VvMnn8eZs8q/anqa3HkwiPCI0=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=J8rwXTml2ZsUKxgyTjoxN2VkXLtkBa2+AKiXF9ZHEEEUNPvDFgScDh0aFcbW6RKWI
	 Vi9/sFkt1it0elserbp6XLIhcZ33BKAEo72mkSFiC24yQwCf0molBvEnUaGYlfdISB
	 skGjjy39GWaj1t6yok1lSOJQh3OozIl3hSol0gPU=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jun 27 14:46:45 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7FDE9C137393;
	Tue, 27 Jun 2023 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1687902405; bh=8fQR0eRfIEG4+0EzB5VvMnn8eZs8q/anqa3HkwiPCI0=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=J8rwXTml2ZsUKxgyTjoxN2VkXLtkBa2+AKiXF9ZHEEEUNPvDFgScDh0aFcbW6RKWI
	 Vi9/sFkt1it0elserbp6XLIhcZ33BKAEo72mkSFiC24yQwCf0molBvEnUaGYlfdISB
	 skGjjy39GWaj1t6yok1lSOJQh3OozIl3hSol0gPU=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id B716BC137393
 for <bpf@ietfa.amsl.com>; Tue, 27 Jun 2023 14:46:43 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.55
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PWgT0yV2-vkM for <bpf@ietfa.amsl.com>;
 Tue, 27 Jun 2023 14:46:40 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id F33EBC14CE4F
 for <bpf@ietf.org>; Tue, 27 Jun 2023 14:46:39 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7659dc74d91so321779585a.0
 for <bpf@ietf.org>; Tue, 27 Jun 2023 14:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687902399; x=1690494399;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zh/vLKlvgybTtSLVlX0FKigLg5YjrAfvbEYl5T6m3ww=;
 b=ZMyDK9IYQ9X/IEq90/98TExNoLYyVzp4Lh1mYS7I45GMf3x6HvYN4cQbnW3A9XQrca
 7OocduYxYl+tPXwJ4a54JGsOTkoRwRWXaCw6+ncDyz/gOJP0ZekTZDM81c5JMrREm2Sh
 C97WvcXWmOciSYU/FT41Vm2dWkzIqBQkiYCx9d091thfrvz7RUvggZMjKPMhdzumqNKD
 zn5ZgTAmKUKClAVctZXaAKpR07kfUcX1/k0zNcLlT4ROvbcRHnrXHk0ICG/kj07OXzST
 m0NIsCL+LV5kRfrcFW5aGU5Wk2lF0nNfCMqXKvIciYNWGFc7XobHYruSaYZ8ueP3bTUY
 z+sg==
X-Gm-Message-State: AC+VfDzyUnxv10zZdMYVvWtG3GGiGP7co+nqbq26B7eipZu7LDkOf9YU
 ZYP25OMtHw5hVkXi0yo23dg=
X-Google-Smtp-Source: ACHHUZ4QB+e3FSKn1DC909L0rT2IMazAGvbp4H1kVDbNnEDv5Q2b72C+X/6meBogwALNYdgji19Jzw==
X-Received: by 2002:a05:620a:1901:b0:765:22d4:b267 with SMTP id
 bj1-20020a05620a190100b0076522d4b267mr23029362qkb.52.1687902398892; 
 Tue, 27 Jun 2023 14:46:38 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:42de])
 by smtp.gmail.com with ESMTPSA id
 u12-20020ae9c00c000000b0076264532630sm4322119qkk.121.2023.06.27.14.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 14:46:38 -0700 (PDT)
Date: Tue, 27 Jun 2023 16:46:36 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Message-ID: <20230627214636.GC344037@maniforge>
References: <20230627213912.951-1-dthaler1968@googlemail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230627213912.951-1-dthaler1968@googlemail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/BDmEvGvp1hE1t-qi8qw2F649ZcE>
Subject: Re: [Bpf] [PATCH bpf-next] Fix definition of BPF_NEG operation
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

On Tue, Jun 27, 2023 at 09:39:12PM +0000, Dave Thaler wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Instruction is an arithmetic negative, not a bitwise inverse.
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>

Acked-by: David Vernet <void@manifault.com>

> ---
>  Documentation/bpf/instruction-set.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 6644842cd3e..751e657973f 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -165,7 +165,7 @@ BPF_OR    0x40   dst \|= src
>  BPF_AND   0x50   dst &= src
>  BPF_LSH   0x60   dst <<= (src & mask)
>  BPF_RSH   0x70   dst >>= (src & mask)
> -BPF_NEG   0x80   dst = ~src
> +BPF_NEG   0x80   dst = -src
>  BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
>  BPF_XOR   0xa0   dst ^= src
>  BPF_MOV   0xb0   dst = src
> -- 
> 2.33.4
> 
> -- 
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

