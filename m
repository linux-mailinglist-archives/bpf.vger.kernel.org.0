Return-Path: <bpf+bounces-8664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD83A788DC1
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 19:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5AC81C20E3E
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 17:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552018032;
	Fri, 25 Aug 2023 17:23:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBA9107A8
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 17:23:56 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CA12121
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 10:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8VEscD0/HvQGJoamae87wVN2yMUL11EnQW3YZzZwoPE=; b=oMTOpKL68MMmPyCTITqcqcZWZB
	qaJ+fh1Y+/zae7f+PJEd6Fi/mUxlzN70TjAh7oNyhvE5H1DeFt1NgXV6yEBMICiJhbe1oC5+Z3ebi
	a/tRyM4wr09cnXV4MQi6zPfjlFs9uEvdaoxJDxRVDpPzhrWbTrskZWH/dh/VwxR8Xdocq0FawEWUS
	lxxUm7Hjp/HlLk2Zi7512YkYwoqg7g6njL5/4o178E4o8sfMdfkekYndWULIkMWZI8EI2MyAKps4k
	+NosiPsMfIAFLdDcxGjmbslSM5367LPNmXZD5B75o7nLNCOE3B9E5NtYI3yk3KJ5I4n+TUEMf8J2U
	/tyrug/A==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qZaXI-000D4n-CY; Fri, 25 Aug 2023 19:23:52 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qZaXI-000UEm-Ct; Fri, 25 Aug 2023 19:23:52 +0200
Subject: Re: [PATCH bpf-next v3] libbpf: handle producer position overflow
To: Andrew Werner <awerner32@gmail.com>
Cc: bpf@vger.kernel.org, kernel-team@dataexmachina.dev,
 alexei.starovoitov@gmail.com, andrii@kernel.org, olsajiri@gmail.com,
 houtao@huaweicloud.com, void@manifault.com
References: <20230824220907.1172808-1-awerner32@gmail.com>
 <ce26e0c1-7d05-1572-dfc9-10d251fde86f@iogearbox.net>
 <CA+vRuzPsN=1xgvAaP6PrMaiLb7U+B5g1t2eBSnqZRC-XQ2EkzA@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <257a7f97-a587-adf4-dfb8-e32a8f8e44b7@iogearbox.net>
Date: Fri, 25 Aug 2023 19:23:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CA+vRuzPsN=1xgvAaP6PrMaiLb7U+B5g1t2eBSnqZRC-XQ2EkzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27011/Fri Aug 25 09:40:47 2023)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/25/23 6:39 PM, Andrew Werner wrote:
> On Fri, Aug 25, 2023 at 11:28 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 8/25/23 12:09 AM, Andrew Werner wrote:
>>> Before this patch, the producer position could overflow `unsigned
>>> long`, in which case libbpf would forever stop processing new writes to
>>> the ringbuf. Similarly, overflows of the producer position could result
>>> in __bpf_user_ringbuf_peek not discovering available data. This patch
>>> addresses that bug by computing using the signed delta between the
>>> consumer and producer position to determine if data is available; the
>>> delta computation is robust to overflow.
>>>
>>> A more defensive check could be to ensure that the delta is within
>>> the allowed range, but such defensive checks are neither present in
>>> the kernel side code nor in libbpf. The overflow that this patch
>>> handles can occur while the producer and consumer follow a correct
>>> protocol.
>>>
>>> Secondarily, the type used to represent the positions in the
>>> user_ring_buffer functions in both libbpf and the kernel has been
>>> changed from u64 to unsigned long to match the type used in the
>>> kernel's representation of the structure. The change occurs in the
>>
>> Hm, but won't this mismatch for 64bit kernel and 32bit user space? Why
>> not fixate both on u64 instead so types are consistent?
> 
> Sure. It feels like if we do that then we'd break existing 32bit
> big-endian clients, though I am not sure those exist. Concretely, the
> request here would be to change the kernel structure and all library
> usages to use u64, right?

Yes, to align all consistently on u64. From your diff, I read that for
the kernel its the case already.

Thanks,
Daniel

