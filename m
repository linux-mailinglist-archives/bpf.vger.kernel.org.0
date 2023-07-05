Return-Path: <bpf+bounces-4053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9097A7484D8
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 15:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916C21C20B18
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 13:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7320B79F0;
	Wed,  5 Jul 2023 13:20:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEF279D9
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 13:20:38 +0000 (UTC)
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36499170A
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 06:20:36 -0700 (PDT)
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qH2Qq-00GJNP-KO; Wed, 05 Jul 2023 13:20:34 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qH2Qp-00Cdft-LB; Wed, 05 Jul 2023 14:20:33 +0100
Message-ID: <3490d887-ae2d-df07-fcdb-67b05b87f611@cambridgegreys.com>
Date: Wed, 5 Jul 2023 14:20:31 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] bpf: make ringbuf available to modules
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
References: <20230705091958.2949447-1-anton.ivanov@cambridgegreys.com>
 <04e08645-d793-c32a-36d4-8335002f24ca@iogearbox.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <04e08645-d793-c32a-36d4-8335002f24ca@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -2.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 05/07/2023 12:41, Daniel Borkmann wrote:
> On 7/5/23 11:19 AM, anton.ivanov@cambridgegreys.com wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> Ringbuf which was developed as a part of BPF infrastructure is
>> a very nice, clean, simple and consise API to relay information
>> from the kernel to userspace. It can be used in critical sections,
>> interrupt handlers, etc.
>>
>> This patch exports ringbuf functionality to make it available to
>> kernel modules.
>>
>> Demo: https://github.com/kot-begemot-uk/bpfnic-ng
>>
>> The demo ships to userspace hardware offload notifications
>> without any mallocs, any workqueue and/or delayed work which
>> is normally needed to handle these. As a result it is ~ 150
>> lines of code instead of the 500+ usually needed to achieve the
>> same result.
>>
>> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Given this is only for out-of-tree code, we cannot merge this patch.

The out of tree code is simply a demo what you can do with ringbuf outside BPF.

Ringbuf can save anyone writing a device driver quite a lot of work. It is a "ready made" IPC with userspace which requires half the code of any alternative (character device drivers, shared memory, etc).

What I am proposing is that it to make it generic and not BPF only.

> 
> Thanks,
> Daniel
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

