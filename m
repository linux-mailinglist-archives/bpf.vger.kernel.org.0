Return-Path: <bpf+bounces-13380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0EC7D8C4F
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 01:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C9F1C20FDA
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 23:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550DC3FE4B;
	Thu, 26 Oct 2023 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pa/+ip/r"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4793C6B2
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:47:33 +0000 (UTC)
X-Greylist: delayed 549 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 16:47:31 PDT
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2DB198
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 16:47:31 -0700 (PDT)
Message-ID: <f83be9ab-1330-d3ef-027f-8f57a20a0be7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698363499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xyDx6SYFHwXREYfb7xsQZ37vKYEXyK9hRajFcpR3cJ0=;
	b=Pa/+ip/rwMzao2EeI2h/8FKTaKd8xzcvMOPmvWQDN243RzOOl+qQpVedgk4XIYOX6Alz8X
	SalhboXPejPwUlMOJaNSzLPS594ojFS2pGmTI8KgrOseIatuX1oaCWrY7HOcQZTeVWzNLh
	xtG8v0tiCN31LNiCeGkYiaKQk+WHgpE=
Date: Fri, 27 Oct 2023 00:38:17 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: add skcipher API support to TC/XDP
 programs
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Vadim Fedorenko <vadfed@meta.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
References: <20231026015938.276743-1-vadfed@meta.com>
 <CAADnVQJ6E+YFoZdtyTUHGHvMevW+wGnGsZRgve_-zY3MedjbjQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAADnVQJ6E+YFoZdtyTUHGHvMevW+wGnGsZRgve_-zY3MedjbjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 26.10.2023 23:53, Alexei Starovoitov wrote:
> On Wed, Oct 25, 2023 at 6:59 PM Vadim Fedorenko <vadfed@meta.com> wrote:
>>
>> +__bpf_kfunc struct bpf_crypto_skcipher_ctx *
>> +bpf_crypto_skcipher_ctx_create(const struct bpf_dynptr_kern *algo, const struct bpf_dynptr_kern *key,
>> +                              int *err)
>> +{
>> +       struct bpf_crypto_skcipher_ctx *ctx;
>> +
>> +       if (__bpf_dynptr_size(algo) > CRYPTO_MAX_ALG_NAME) {
>> +               *err = -EINVAL;
>> +               return NULL;
>> +       }
>> +
>> +       if (!crypto_has_skcipher(algo->data, CRYPTO_ALG_TYPE_SKCIPHER, CRYPTO_ALG_TYPE_MASK)) {
>> +               *err = -EOPNOTSUPP;
>> +               return NULL;
>> +       }
>> +
>> +       ctx = bpf_mem_cache_alloc(&bpf_crypto_ctx_ma);
> 
> Since this kfunc is sleepable, just kmalloc(GFP_KERNEL) here.
> No need to use bpf_mem_alloc.

I was thinking about adding GFP_ATOMIC allocation option to
crypto_alloc_sync_skcipher, it's already implemented for cloning skcipher
object. Then the code can be reused for both sleepable (expect module loading)
and non-sleepable (fail if there is no crypto module loaded) variants without
any changes. But I can implement different allocators for different options.

