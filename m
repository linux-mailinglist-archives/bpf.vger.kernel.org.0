Return-Path: <bpf+bounces-3603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD317405E4
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 23:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AB8281147
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 21:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E1F18AE6;
	Tue, 27 Jun 2023 21:46:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2646A8
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 21:46:46 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0222D4E
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 14:46:40 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7658430eb5dso374160085a.2
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 14:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687902399; x=1690494399;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zh/vLKlvgybTtSLVlX0FKigLg5YjrAfvbEYl5T6m3ww=;
        b=MgEwbwjLkwCXb3kKU3oDMGh4urNhUs3sZElKqOC5YDNFeD4Nqp9AkOzvmrIRmkvTyD
         ZzQS9nNM0YZe4/lY/ZMAO477iYqX+2U5PoLv9WzkiI+21W+Q1yZKBnV/hfTKX/iOCjSR
         HnKcNnczrPOWbL+YfX6hk1IQnu8iwFVUtUah4V9G+L2xSEb7h88+qGsMtgNpR/TspCgS
         sAyRennuLApsmeuHy2G6pce+LGS6BdzPAeVgi9RlJzZrqRqv4gJw5qqqGNAIopo2hV4M
         DShqjPOsu9rrTfTXRLEGA4VrHSlK6eB2joXYSe9nYfxwHRBngyigXIoGDeszF5OMKbpN
         DLQw==
X-Gm-Message-State: AC+VfDxU+2afKSGKklwGA2BeUaiy2P/UjlluMX3IR0KUKNESGyS5hdEE
	71E2FywohKuiYLWLbbv7bGotf5O7T6ggSbA8
X-Google-Smtp-Source: ACHHUZ4QB+e3FSKn1DC909L0rT2IMazAGvbp4H1kVDbNnEDv5Q2b72C+X/6meBogwALNYdgji19Jzw==
X-Received: by 2002:a05:620a:1901:b0:765:22d4:b267 with SMTP id bj1-20020a05620a190100b0076522d4b267mr23029362qkb.52.1687902398892;
        Tue, 27 Jun 2023 14:46:38 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:42de])
        by smtp.gmail.com with ESMTPSA id u12-20020ae9c00c000000b0076264532630sm4322119qkk.121.2023.06.27.14.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 14:46:38 -0700 (PDT)
Date: Tue, 27 Jun 2023 16:46:36 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: Re: [Bpf] [PATCH bpf-next] Fix definition of BPF_NEG operation
Message-ID: <20230627214636.GC344037@maniforge>
References: <20230627213912.951-1-dthaler1968@googlemail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627213912.951-1-dthaler1968@googlemail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
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

