Return-Path: <bpf+bounces-6024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF5376429C
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 01:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C521281FBA
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 23:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60439DDB9;
	Wed, 26 Jul 2023 23:33:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C2E1BF13
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 23:33:56 +0000 (UTC)
Received: from out-19.mta0.migadu.com (out-19.mta0.migadu.com [91.218.175.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47722726
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 16:33:48 -0700 (PDT)
Message-ID: <1f91fe12-f9ff-06c8-4a5b-52dc21e6df05@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690414427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ag5ykdsFX9AwSYVql7wNkpXHMYBpUjCvWu9v3wp5JbY=;
	b=LRUggixEdn36elXOsCQvVZq8wUo0UpPRxXVkwZM7QFQaT8mR1UrZteCuwUf1PB44weS+7K
	aNeCRkyUwCNBp8oN/X9Xh7zD8PIkwhd1s/cUneoZTlcV4uD2+CC7B1InBV4MEIygRy7Sth
	PblYzXyrZvFa1ZwGFF61ghfhSfDquJs=
Date: Wed, 26 Jul 2023 16:33:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] WARNING: ODEBUG bug in tcx_uninstall
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 syzbot <syzbot+14736e249bce46091c18@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com,
 Gal Pressman <gal@nvidia.com>
References: <000000000000ee69e80600ec7cc7@google.com>
 <91396dc0-23e4-6c81-f8d8-f6427eaa52b0@iogearbox.net>
 <20230726071254.GA1380402@unreal> <20230726082312.1600053e@kernel.org>
 <20230726170133.GX11388@unreal>
 <896cbaf8-c23d-e51a-6f5e-1e6d0383aed0@linux.dev>
In-Reply-To: <896cbaf8-c23d-e51a-6f5e-1e6d0383aed0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/26/23 11:16 AM, Martin KaFai Lau wrote:
> On 7/26/23 10:01 AM, Leon Romanovsky wrote:
>> On Wed, Jul 26, 2023 at 08:23:12AM -0700, Jakub Kicinski wrote:
>>> On Wed, 26 Jul 2023 10:12:54 +0300 Leon Romanovsky wrote:
>>>>> Thanks, I'll take a look this evening.
>>>>
>>>> Did anybody post a fix for that?
>>>>
>>>> We are experiencing the following kernel panic in netdev commit
>>>> b57e0d48b300 (net-next/main) Merge branch '100GbE' of 
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
>>>
>>> Not that I know, looks like this is with Daniel's previous fix already
>>> present, and syzbot is hitting it, too :(
>>
>> My naive workaround which restored our regression runs is:
>>
>> diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
>> index 69a272712b29..10c9ab830702 100644
>> --- a/kernel/bpf/tcx.c
>> +++ b/kernel/bpf/tcx.c
>> @@ -111,6 +111,7 @@ void tcx_uninstall(struct net_device *dev, bool ingress)
>>                          bpf_prog_put(tuple.prog);
>>                  tcx_skeys_dec(ingress);
>>          }
>> -       WARN_ON_ONCE(tcx_entry(entry)->miniq_active);
>> +       tcx_miniq_set_active(entry, false);
> 
> Thanks for the report. I will look into it.

I don't see how that may be triggered for now after Daniel's recent fix in 
commit dc644b540a2d ("tcx: Fix splat in ingress_destroy upon tcx_entry_free"). 
Do you have a small reproducible case? Thanks.

> 
>>          tcx_entry_free(entry);
>>   }
>>
> 
> 


