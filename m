Return-Path: <bpf+bounces-6038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE6C764520
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 06:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE6E282093
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 04:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1421FC5;
	Thu, 27 Jul 2023 04:52:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E92ED5
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 04:52:41 +0000 (UTC)
Received: from out-46.mta0.migadu.com (out-46.mta0.migadu.com [91.218.175.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ED41FFF
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 21:44:38 -0700 (PDT)
Message-ID: <9ac948b7-d32c-a567-c9ce-b7f67d65d8de@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690433076; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHf/rPiejTlDS8J/PyEwesEHB/1FXMYR12ydqrPT7uw=;
	b=vAlj70wQ0Jw4SLQgDcOC4b5nOUGww7Y7FI0f0oMHPewno3EGpDaMZ+iNg3H1YtKozPzs7X
	IHgpbu+3el+zF7JzzN7P3iflam8eaxBhtI03UIL7QxVOQs9p7FIMjC8bOEu9TZBXi0Sg6d
	sdNSEdzxAvEd6aI0pkqymqnhGSUAMzY=
Date: Wed, 26 Jul 2023 21:44:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH] bpf, docs: fix BPF_NEG entry in instruction-set.rst
Content-Language: en-US
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
References: <20230726092543.6362-1-jose.marchesi@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230726092543.6362-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/26/23 2:25 AM, Jose E. Marchesi wrote:
> This patch fixes the documentation of the BPF_NEG instruction to
> denote that it does not use the source register operand.
> 
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   Documentation/bpf/standardization/instruction-set.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
> index 751e657973f0..6ef5534b410a 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -165,7 +165,7 @@ BPF_OR    0x40   dst \|= src
>   BPF_AND   0x50   dst &= src
>   BPF_LSH   0x60   dst <<= (src & mask)
>   BPF_RSH   0x70   dst >>= (src & mask)
> -BPF_NEG   0x80   dst = -src
> +BPF_NEG   0x80   dst = -dst
>   BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
>   BPF_XOR   0xa0   dst ^= src
>   BPF_MOV   0xb0   dst = src

