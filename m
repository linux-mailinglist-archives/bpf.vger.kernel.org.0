Return-Path: <bpf+bounces-10817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D217AE24A
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 01:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 454761C208DF
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E304262B5;
	Mon, 25 Sep 2023 23:31:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D026299
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 23:31:09 +0000 (UTC)
Received: from out-192.mta1.migadu.com (out-192.mta1.migadu.com [95.215.58.192])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CDD101
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 16:31:08 -0700 (PDT)
Message-ID: <c757e1cc-2fc9-17e1-6d34-a15e4236fe12@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695684667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Apcsm1UO1bNEZWCZB1oKEOqllVX7WrQxDtFYb2GQFuw=;
	b=hzq/PjSbN9pYz0VryrU3hVMUmXJxK4fsx3Oi2uYX2eVWq8o9O0XDaGUEP0AJ6e8NUpeQhQ
	mFwVvzHkS1EEHLHuNJMbXOboL6MXrgNgwKOeDaMXLSv6TlP6ryNg8x1X22cWNH4OdpTTdA
	XyHtM5QPnFdqH227d7SHAvaPnwdxMmM=
Date: Mon, 25 Sep 2023 16:31:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v3 03/11] bpf: add register and unregister
 functions for struct_ops.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230920155923.151136-1-thinker.li@gmail.com>
 <20230920155923.151136-4-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230920155923.151136-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/20/23 8:59 AM, thinker.li@gmail.com wrote:
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES

CONFIG_DEBUG_INFO_BTF_MODULES is probably too restrictive. bpf_tcp_ca does not 
necessary need CONFIG_DEBUG_INFO_BTF_MODULES

> +int register_bpf_struct_ops(struct bpf_struct_ops_mod *mod);
> +#endif


