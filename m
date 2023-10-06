Return-Path: <bpf+bounces-11546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725A17BBD51
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 18:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E749A282274
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 16:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE89A28E24;
	Fri,  6 Oct 2023 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="fZBikOJh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5BC208A3
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 16:55:14 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37135AD
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=C6YDbKfwLao1+5ajAr2NiSNqGdQ1MPxr69cDHkEB6fk=; b=fZBikOJh9hfuTq7SwUl5abgPJU
	mp/DDeLaUENPl6uGS9z5wWvah2zme8fbJsMQgCPxIL0F59bhqCMrSx2SO+PV6vTaTiyFvlsrEdsJW
	cAGiWLtTr5t2eht1VFfIuR/6cOy6ah8ETisNhgYU7vrgw4/hiRfhrePuNc3wbccV3CyCP3Zyzf22T
	LrwMtqD7J2jNBU8pTKw6YAiK6XhPVssN6RxTSjMvDXxBQ+PEGZB4Iebx93kMutywzq7ls/wP0qYRE
	M4sjH7eysmVUBj5G1uqzRU83y3lVCK9lGk4qzNgRrdi4WJb4uhf90tvdm5RP5xdwhVgcI3Gs0Efp6
	Ph0cuaQg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qoo6S-000Kz0-F4; Fri, 06 Oct 2023 18:55:04 +0200
Received: from [178.197.249.17] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qoo6R-0006al-UZ; Fri, 06 Oct 2023 18:55:04 +0200
Subject: Re: [PATCH bpf-next] bpf: Inherit system settings for CPU security
 mitigations
To: KP Singh <kpsingh@kernel.org>, Song Liu <song@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 yonghong.song@linux.dev, sdf@google.com, haoluo@google.com,
 jolsa@kernel.org, bpf@vger.kernel.org, Luis Gerhorst <gerhorst@cs.fau.de>
References: <20231005084123.1338-1-laoar.shao@gmail.com>
 <CAPhsuW70-kKGT1RQRGYG0b6zixKTzaU_-SUfvhhrwO3y_WZcBw@mail.gmail.com>
 <CACYkzJ7Yq4QXnosqVTAtfqssUiG_+rsHouy=-iwTOZd5oEXgBg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a3ad62c3-c523-fc40-fc4c-1197c34b79b9@iogearbox.net>
Date: Fri, 6 Oct 2023 18:55:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACYkzJ7Yq4QXnosqVTAtfqssUiG_+rsHouy=-iwTOZd5oEXgBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27053/Fri Oct  6 09:44:40 2023)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/6/23 1:30 AM, KP Singh wrote:
> On Thu, Oct 5, 2023 at 8:02 PM Song Liu <song@kernel.org> wrote:
>> On Thu, Oct 5, 2023 at 1:41 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>>>
>>> Currently, there exists a system-wide setting related to CPU security
>>> mitigations, denoted as 'mitigations='. When set to 'mitigations=off', it
>>> deactivates all optional CPU mitigations. Therefore, if we implement a
>>> system-wide 'mitigations=off' setting, it should inherently bypass Spectre
>>> v1 and Spectre v4 in the BPF subsystem.
>>>
>>> Please note that there is also a 'nospectre_v1' setting on x86 and ppc
>>> architectures, though it is not currently exported. For the time being,
>>> let's disregard it.

 From reading, the cpu_mitigations_off() is a more generic toggle to turn these
generally off, so going via cpu_mitigations_off() is fine in our case and does
not leave some corner cases behind. I presume you mean above that in future the
BPF side could respect some more fine-tuned settings, though it probably might
need some more coordination wrt archs to abstract sth generic out of it.

>>> This idea emerged during our discussion about potential Spectre v1 attacks
>>> with Luis[1].
>>>
>>> [1]. https://lore.kernel.org/bpf/b4fc15f7-b204-767e-ebb9-fdb4233961fb@iogearbox.net/
>>>
>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>> Cc: Luis Gerhorst <gerhorst@cs.fau.de>
>>
>> Acked-by: Song Liu <song@kernel.org>
>>
> 
> Acked-by: KP Singh <kpsingh@kernel.org>

Thanks,
Daniel

