Return-Path: <bpf+bounces-6108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2410576604B
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 01:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DA5281A4B
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 23:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28F41ED5A;
	Thu, 27 Jul 2023 23:44:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE90E57A;
	Thu, 27 Jul 2023 23:44:44 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6142D70;
	Thu, 27 Jul 2023 16:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=JNLi5VZ5u15SeU34PKfgp04ZTBcnUk6/4EC6ZxqAHzc=; b=eEw+qP2598e8KSb8q42vSBNegh
	xmYll+6xQEIYKdgIkUmH5rfWzJBFpjJzGNIrwfooz6Fh2eC+YJTP8brTId7RqhylddO8+GQOrmI4t
	I5rXGW9jRx5DALL19CIyBKH6nnuwc5rJfWKHwgczAkOvqZA77mgBtuY9MtHF6qBrr627jVaJTfhmn
	fIXorj6wXmS6+bPTaUl1n64o4P4vw7kwpcSsatgzW+0N/MkCwRDqhvwZqIOHkpHDl6sxyapa0Mt8q
	5bNbK3+3CRNHvzjCYMhp29iZ2s1iVTofx4fOwgTTcOr9OliR66Olar1vQj+87+a7kKXQGPFBDy9y7
	c0QZtysg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qPAer-000BRI-3A; Fri, 28 Jul 2023 01:44:37 +0200
Received: from [14.202.107.205] (helo=192-168-1-115.tpgi.com.au)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qPAeq-000JSA-32; Fri, 28 Jul 2023 01:44:36 +0200
Subject: Re: [syzbot] [bpf?] WARNING: ODEBUG bug in tcx_uninstall
To: Leon Romanovsky <leon@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>,
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
 <1f91fe12-f9ff-06c8-4a5b-52dc21e6df05@linux.dev>
 <20230727054145.GY11388@unreal>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d2a76d59-3282-d4ac-fbe5-40b0a07dbc51@iogearbox.net>
Date: Fri, 28 Jul 2023 01:44:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230727054145.GY11388@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26982/Thu Jul 27 09:29:43 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/27/23 7:41 AM, Leon Romanovsky wrote:
> On Wed, Jul 26, 2023 at 04:33:40PM -0700, Martin KaFai Lau wrote:
>> On 7/26/23 11:16 AM, Martin KaFai Lau wrote:
>>> On 7/26/23 10:01 AM, Leon Romanovsky wrote:
>>>> On Wed, Jul 26, 2023 at 08:23:12AM -0700, Jakub Kicinski wrote:
>>>>> On Wed, 26 Jul 2023 10:12:54 +0300 Leon Romanovsky wrote:
>>>>>>> Thanks, I'll take a look this evening.
>>>>>>
>>>>>> Did anybody post a fix for that?
>>>>>>
>>>>>> We are experiencing the following kernel panic in netdev commit
>>>>>> b57e0d48b300 (net-next/main) Merge branch '100GbE' of
>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
>>>>>
>>>>> Not that I know, looks like this is with Daniel's previous fix already
>>>>> present, and syzbot is hitting it, too :(
>>>>
>>>> My naive workaround which restored our regression runs is:
>>>>
>>>> diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
>>>> index 69a272712b29..10c9ab830702 100644
>>>> --- a/kernel/bpf/tcx.c
>>>> +++ b/kernel/bpf/tcx.c
>>>> @@ -111,6 +111,7 @@ void tcx_uninstall(struct net_device *dev, bool ingress)
>>>>                           bpf_prog_put(tuple.prog);
>>>>                   tcx_skeys_dec(ingress);
>>>>           }
>>>> -       WARN_ON_ONCE(tcx_entry(entry)->miniq_active);
>>>> +       tcx_miniq_set_active(entry, false);
>>>
>>> Thanks for the report. I will look into it.
>>
>> I don't see how that may be triggered for now after Daniel's recent fix in
>> commit dc644b540a2d ("tcx: Fix splat in ingress_destroy upon
>> tcx_entry_free").
> 
> Both our regression and syzbot have this fix in the trees.
> 
>> Do you have a small reproducible case? Thanks.
> 
> Unfortunately no.

Thanks for the report, we found the root cause and will send a fix in the next
day or two.

Best,
Daniel

