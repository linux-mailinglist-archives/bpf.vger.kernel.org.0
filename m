Return-Path: <bpf+bounces-8638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA738788CE7
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE451C2100C
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E14417721;
	Fri, 25 Aug 2023 16:01:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FF52571
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:00:59 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A23211B
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=vnjw3jjN+ERB4/yHX2huqbV1rQdPO3tdDUhqeViyfg8=; b=CYa71ZFIKSgF7DUIdXgqOhcZyE
	ysjNQ+m48fqu1b5dKJ4pHCa2UT25mWmMHJUOq8/WKVSC5n1SuIcBWCUOcuZuwpyz2vMNWFpVvEyW8
	bMlPLI75nNfkHOcm8uQcKWK+sDRFHSP7tEPwgU1j7UZshHvlV8QtKHxCybA9M4ERdnpIFd0oh+uVI
	0ZmLO1gu8baaASJzj5bJTaNb8aa8/Rggwwl4TXMwTSR5xVkYwGTcxwwvUZOAA7wA2niRKGv8Ic4Cr
	xB4ahzEM+X/CGgCmFIdAAf+e7uRbMDAbMQPgXsPfoGUOvIpgloRGwXXZmzI4dEJkfb+m4DRAZt6RP
	d64o1Nlg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qZZF0-0004Bt-0C; Fri, 25 Aug 2023 18:00:54 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qZZEz-000AfT-WA; Fri, 25 Aug 2023 18:00:54 +0200
Subject: Re: [PATCH bpf-next v3] libbpf: handle producer position overflow
To: Hou Tao <houtao@huaweicloud.com>, Andrew Werner <awerner32@gmail.com>,
 bpf@vger.kernel.org
Cc: kernel-team@dataexmachina.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, olsajiri@gmail.com, void@manifault.com
References: <20230824220907.1172808-1-awerner32@gmail.com>
 <a811af2f-3c5d-64dc-c49a-f865b2de9967@huaweicloud.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <94944fe2-a085-d171-8947-a62d84e0daf4@iogearbox.net>
Date: Fri, 25 Aug 2023 18:00:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a811af2f-3c5d-64dc-c49a-f865b2de9967@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27011/Fri Aug 25 09:40:47 2023)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/25/23 5:17 AM, Hou Tao wrote:
> On 8/25/2023 6:09 AM, Andrew Werner wrote:
>> Before this patch, the producer position could overflow `unsigned
>> long`, in which case libbpf would forever stop processing new writes to
>> the ringbuf. Similarly, overflows of the producer position could result
>> in __bpf_user_ringbuf_peek not discovering available data. This patch
>> addresses that bug by computing using the signed delta between the
>> consumer and producer position to determine if data is available; the
>> delta computation is robust to overflow.
>>
>> A more defensive check could be to ensure that the delta is within
>> the allowed range, but such defensive checks are neither present in
>> the kernel side code nor in libbpf. The overflow that this patch
>> handles can occur while the producer and consumer follow a correct
>> protocol.
>>
>> Secondarily, the type used to represent the positions in the
>> user_ring_buffer functions in both libbpf and the kernel has been
>> changed from u64 to unsigned long to match the type used in the
>> kernel's representation of the structure. The change occurs in the
>> same patch because it's required to align the data availability
>> calculations between the userspace producing ringbuf and the bpf
>> producing ringbuf.
> 
> Because the changes include both the change for ring buffer and user
> ring buffer. I think it is better to split the changes into three
> patches to ease the backports of these changes: one patch for change in
> libbpf for ring buffer, and another two patches for changes in libbpf
> and kernel for user ring buffer.

Splitting off the kernel parts into a separate patch would indeed be
good so that stable team can pull it. (Pls also add a Fixes tag.)

Thanks,
Daniel

