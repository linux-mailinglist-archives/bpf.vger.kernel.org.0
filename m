Return-Path: <bpf+bounces-4118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84420748F14
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 22:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B533B1C20C02
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 20:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E311426C;
	Wed,  5 Jul 2023 20:40:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E02F38
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 20:40:51 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F28A19AA
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/fifbWuDHoNHAcIjRv3drkHu8ohdeevQzF2oktWj9Io=; b=G9uO9jJwBSadMmycckNc+mmykH
	EACvs3a9OS5OZib3vrgZ/oIa3ZM7fcIGrhynO/Jex2epRa4F4+cy0owfc7j7Ms8zncXkY18XzzMum
	fhgVHrNNlFIBMYojP+PfVSeens8FS7CQCD6eNfDibPDYy4A9sYbxoKh6Q8cp6adm3v3kptXpXoYfM
	nqQ6bZJXw5QZCf/hg3i40O5TdA4ddgLbRxh1rjTfK6Qsqez4LTxawev1rFPLg+Pp+1t1ctVwP/N8M
	1zyNrkp8b3QHYZ6skrxzMmmXHEKXfK8EL45eeTKMCDjizfysT+2ly9ZXtDjresHhC0cPCQqfF/lz4
	2swqf7fQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qH9It-000JFc-SM; Wed, 05 Jul 2023 22:40:48 +0200
Received: from [178.197.249.31] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qH9It-000WNG-Kt; Wed, 05 Jul 2023 22:40:47 +0200
Subject: Re: [PATCH] bpf: make ringbuf available to modules
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, bpf@vger.kernel.org
References: <20230705091958.2949447-1-anton.ivanov@cambridgegreys.com>
 <04e08645-d793-c32a-36d4-8335002f24ca@iogearbox.net>
 <3490d887-ae2d-df07-fcdb-67b05b87f611@cambridgegreys.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d283109d-8c49-4bbd-bb16-8927c47c69fb@iogearbox.net>
Date: Wed, 5 Jul 2023 22:40:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3490d887-ae2d-df07-fcdb-67b05b87f611@cambridgegreys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26960/Wed Jul  5 09:29:05 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/5/23 3:20 PM, Anton Ivanov wrote:
> On 05/07/2023 12:41, Daniel Borkmann wrote:
>> On 7/5/23 11:19 AM, anton.ivanov@cambridgegreys.com wrote:
>>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>>
>>> Ringbuf which was developed as a part of BPF infrastructure is
>>> a very nice, clean, simple and consise API to relay information
>>> from the kernel to userspace. It can be used in critical sections,
>>> interrupt handlers, etc.
>>>
>>> This patch exports ringbuf functionality to make it available to
>>> kernel modules.
>>>
>>> Demo: https://github.com/kot-begemot-uk/bpfnic-ng
>>>
>>> The demo ships to userspace hardware offload notifications
>>> without any mallocs, any workqueue and/or delayed work which
>>> is normally needed to handle these. As a result it is ~ 150
>>> lines of code instead of the 500+ usually needed to achieve the
>>> same result.
>>>
>>> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> Given this is only for out-of-tree code, we cannot merge this patch.
> 
> The out of tree code is simply a demo what you can do with ringbuf outside BPF.
> 
> Ringbuf can save anyone writing a device driver quite a lot of work. It is a "ready made" IPC with userspace which requires half the code of any alternative (character device drivers, shared memory, etc).
> 
> What I am proposing is that it to make it generic and not BPF only.

That is probably an okay goal (depends on the concrete situation / proposal),
but still this needs to be in upstream tree given we cannot cater for anything
out-of-tree and exporting symbols without good reason for an in-tree user is
and always has been a red flag.

Thanks,
Daniel

