Return-Path: <bpf+bounces-1447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BDD716AE7
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 19:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B51281264
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 17:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5811200DC;
	Tue, 30 May 2023 17:27:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB491F179
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 17:27:45 +0000 (UTC)
Received: from out-42.mta1.migadu.com (out-42.mta1.migadu.com [IPv6:2001:41d0:203:375::2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A926819D
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 10:27:24 -0700 (PDT)
Message-ID: <cf3903b0-9258-d000-c8b4-1f196ea726c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1685467337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCpNn1zuOOOB1U1un5lu/DMODvqsYcaAOG8UvzGY5Ls=;
	b=q7ZEJAVS8OUjYkF4ejz/ybet42V2MnQlddCR6uDxQ5iX6CHj7CmsWISL2ia07tQolKbaYi
	0mFW8hLVzNXKlICVv/worZ1NuAR9Kd+7JxNXvZ3LhEB/aOv3nIYOCOqkK4BE1LtwyYO8X3
	i1vsL/FEYwboUlbi/gNx+I0/VUrhYXE=
Date: Tue, 30 May 2023 10:22:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] samples/bpf: fixup xdp_redirect tool to be
 able to support xdp multibuffer
Content-Language: en-US
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: brouer@redhat.com, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Nimrod Oren <noren@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, drosen@google.com,
 Joanne Koong <joannelkoong@gmail.com>, henning.fehrmann@aei.mpg.de,
 oliver.behnke@aei.mpg.de, Jesper Dangaard Brouer <jbrouer@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>
References: <20230529110608.597534-1-tariqt@nvidia.com>
 <20230529110608.597534-2-tariqt@nvidia.com>
 <63d91da7-4040-a766-dcd7-bccbb4c02ef4@redhat.com>
 <4ceac69b-d2ae-91b5-1b24-b02c8faa902b@gmail.com>
 <3168b14c-c9c1-b11b-2500-2ff2451eb81c@redhat.com>
 <dc19366d-8516-9f2a-b6ed-d9323e9250c9@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <dc19366d-8516-9f2a-b6ed-d9323e9250c9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/30/23 6:40 AM, Tariq Toukan wrote:
>>> I initiated a discussion on this topic a few months ago. dynptr was accepted 
>>> since then, but I'm not aware of any in-progress followup work that addresses 
>>> this.
>>>
>>
>> Are you saying some more work is needed on dynptr?
>>
> 
> AFAIU yes.
> But I might be wrong... I need to revisit this.
> Do you think/know that dynptr can be used immediately?

Not sure if you are aware of the bpf_dynptr_slice[_rdwr]() which could be useful 
here. It only does a copy when the requested slice is across different frags:
https://lore.kernel.org/all/20230301154953.641654-10-joannelkoong@gmail.com/


