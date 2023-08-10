Return-Path: <bpf+bounces-7493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8926477828E
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 23:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559711C20DA5
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 21:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC0F23BD2;
	Thu, 10 Aug 2023 21:12:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC3F20F92
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 21:12:11 +0000 (UTC)
Received: from out-114.mta1.migadu.com (out-114.mta1.migadu.com [95.215.58.114])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5252738
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 14:12:09 -0700 (PDT)
Message-ID: <c111a5c3-89ca-8dec-81cb-8b878a5a97fe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691701927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uo30uOHi94c1Ffg4QdXUNk+nx+gtBmYC8pdfNEhBN4=;
	b=t2kUExpPiDpkYTXa9bMiLDqA6s22FHG8gBMitgylihBEGo9G5XqGLctE+cnFGWWY0+UteL
	s5X+8yrxx3bXd+b58FxN4mlmJ37rupQokBd3F/XgCkYlHacQPx/fAjndenxZ+7hEwfsE1Z
	90x8ZaLGejWEUflPcniOlLNdxwoFAvQ=
Date: Thu, 10 Aug 2023 17:12:03 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 11/14] bpf: Fix kfunc callback register type
 handling
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Dave Marchevsky <davemarchevsky@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>,
 David Vernet <void@manifault.com>
References: <20230809114116.3216687-1-memxor@gmail.com>
 <20230809114116.3216687-12-memxor@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <20230809114116.3216687-12-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/9/23 7:41 AM, Kumar Kartikeya Dwivedi wrote:
> The kfunc code to handle KF_ARG_PTR_TO_CALLBACK does not check the reg
> type before using reg->subprogno. This can accidently permit invalid
> pointers from being passed into callback helpers (e.g. silently from
> different paths). Likewise, reg->subprogno from the per-register type
> union may not be meaningful either. We need to reject any other type
> except PTR_TO_FUNC.
> 
> Cc: Dave Marchevsky <davemarchevsky@fb.com>
> Fixes: 5d92ddc3de1b ("bpf: Add callback validation to kfunc verifier logic")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>

