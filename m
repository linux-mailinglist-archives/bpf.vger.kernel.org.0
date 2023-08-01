Return-Path: <bpf+bounces-6504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3C476A631
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 03:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6ED281746
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 01:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7A5809;
	Tue,  1 Aug 2023 01:19:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9047E
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 01:19:48 +0000 (UTC)
Received: from out-120.mta0.migadu.com (out-120.mta0.migadu.com [91.218.175.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601B8114
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 18:19:47 -0700 (PDT)
Message-ID: <e2d06c78-1434-8322-1089-ba6355bb4c83@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690852785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sp0i1RgQ9gw8x/2U6jrgnozGlEnn3hAGm1IEtakX1jY=;
	b=TpMeFwVErvdasKSWiFlqtzXZbwnI6y+56xdQZearYbW2j4SPHxNXndh7AMIfmGlJlfH000
	Dgy9850anEaxUQ86HKsqWTuMAqcvFFFwgebZgCde3YvZc2uVR/c0NbHyzxAIo6tks7KLmM
	EvVVyqCMemTjp+MRwjVlj5LHHKftMY0=
Date: Mon, 31 Jul 2023 18:19:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: Fix map type error in sock_map_del_link
Content-Language: en-US
To: Xu Kuohai <xukuohai@huaweicloud.com>,
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <20230728105649.3978774-1-xukuohai@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230728105649.3978774-1-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/28/23 3:56 AM, Xu Kuohai wrote:
> sock_map_del_link() operates on both SOCKMAP and SOCKHASH, although
> both types have member named "progs", the offset of "progs" member in
> these two types is different, so "progs" should be accessed with the
> real map type.

The patch makes sense to me. Can a test be written to trigger it?

John, please review.


