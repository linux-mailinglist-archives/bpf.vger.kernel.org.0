Return-Path: <bpf+bounces-10843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1182B7AE4DC
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 07:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id A25D71F25390
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 05:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB381C3D;
	Tue, 26 Sep 2023 05:07:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A941C10
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 05:07:49 +0000 (UTC)
Received: from out-203.mta1.migadu.com (out-203.mta1.migadu.com [95.215.58.203])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DD7E8
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 22:07:47 -0700 (PDT)
Message-ID: <70a8ba17-33af-1fc5-ddf7-dd118e6ce4f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695704866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I51lDFzK9p7v/X1UMg18TY8UZ+O3xUvlsKmg0bu+kuE=;
	b=KpKaAV4IdWXkZe7fQQQs0NeKrkDzc4MYRgbJ2gQw8NIuFzopvRh01ZsXcHYJcllv2mS+Il
	jKWmUTW8E6NklJGXBYJmsbOA6JUOdJMc1PnsK7AopDnVBxOiNj2/gO7ZvoMJDAfyBYKp3y
	YW5aZfqS8Tpyj5sXCEyh70ZBVelRT9o=
Date: Mon, 25 Sep 2023 22:07:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 bpf-next 5/9] bpf: udp: Implement batching for sockets
 iterator
Content-Language: en-US
To: Aditi Ghag <aditi.ghag@isovalent.com>
Cc: sdf@google.com, Martin KaFai Lau <martin.lau@kernel.org>,
 bpf@vger.kernel.org, Network Development <netdev@vger.kernel.org>
References: <20230519225157.760788-1-aditi.ghag@isovalent.com>
 <20230519225157.760788-6-aditi.ghag@isovalent.com>
 <f85fbac6-a1d7-3f63-9d0f-8eaa261ddb26@linux.dev>
 <0B548508-C9AD-476C-A934-5D9D9B5DECB0@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <0B548508-C9AD-476C-A934-5D9D9B5DECB0@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/25/23 4:34 PM, Aditi Ghag wrote:
> Just so that I understand the broken case better, are you doing something in your BPF iterator program so that "bpf_seq_read() can only get one sk at a time"?

ah, hit send too early.

Yes, bpf_seq_printf(). It is why I was suggesting to use the bpf_iter/udp[46] to 
reprod by adding start_reuseport_server(). Please see my earlier reply.

