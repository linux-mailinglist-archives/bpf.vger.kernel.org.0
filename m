Return-Path: <bpf+bounces-11538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F35087BB9C7
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 15:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C812824E8
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 13:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8057623773;
	Fri,  6 Oct 2023 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="RJcsAjiP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CD91F959;
	Fri,  6 Oct 2023 13:49:40 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F396B135;
	Fri,  6 Oct 2023 06:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=EMKBEqiamOxTULnJPCzFxoddQySa+gvPBQoU35DrMOY=; b=RJcsAjiPdNmP/FXEXmoZp/+zJX
	JpLOfLzhKJyc1jjBSCWVocoVUPHOnKHKZrAfVvdqeHPUUuQQOSnhZpEXBISW+ePV23IgXHbfhEpa8
	6LAph5xb0o/wzbShdGOHTlo3MGmUymESWmcXKxIHwvyzjDiCl+gCwb5NEpSuPm9jZiPPQkB83gjJi
	lumZwpANXXJAkqePYUHxiBaVEf39nTFvJ9JYfOL/wsAc7muhYQ9Y/xPSKvg1lamkTUf+loArXsbk/
	xCPBxGJzQR0DWF3Y6i5+ttAPM3w8vsvHof9DwlR09i01VwJ23Ixdkza9OEMCVwA/C4Cdo0C9ys1QN
	TK95hDuA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qolCi-0000IW-88; Fri, 06 Oct 2023 15:49:20 +0200
Received: from [178.197.249.17] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qolCh-000KPs-LB; Fri, 06 Oct 2023 15:49:19 +0200
Subject: Re: [PATCH net-next 1/1] net/sched: Disambiguate verdict from return
 code
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira
 <victor@mojatatu.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 paulb@nvidia.com, netdev@vger.kernel.org, kernel@mojatatu.com,
 martin.lau@linux.dev, bpf@vger.kernel.org
References: <20230919145951.352548-1-victor@mojatatu.com>
 <beb5e6f3-e2a1-637d-e06d-247b36474e95@iogearbox.net>
 <CAM0EoMncgehpwCOxaUUKhOP7V0DyJtbDP9Q5aUkMG2h5dmfQJA@mail.gmail.com>
 <97f318a1-072d-80c2-7de7-6d0d71ca0b10@iogearbox.net>
 <CAM0EoMnPVxYA=7jn6AU7D3cJJbY5eeMLOxCrj4UJcFr=pCZ+Aw@mail.gmail.com>
 <1df2e804-5d58-026c-5daa-413a3605c129@iogearbox.net>
 <CAM0EoM=SH8i_-veiyUtT6Wd4V7DxNm-tF9sP2BURqN5B2yRRVQ@mail.gmail.com>
 <cb4db95b-89ff-02ef-f36f-7a8b0edc5863@iogearbox.net>
 <CAM0EoMkYCaxHT22-b8N6u7A=2SUydNp9vDcio29rPrHibTVH5Q@mail.gmail.com>
 <96532f62-6927-326c-8470-daa1c4ab9699@iogearbox.net>
 <CAM0EoMkUFcw7k0vX3oH8SHDoXW=DD-h2MkUE-3_MssXvP_uJbA@mail.gmail.com>
 <2ce3a5a1-375d-43a6-052d-d44d7b4a4bf8@iogearbox.net>
 <20231006063233.74345d36@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <686dd999-bee4-ecf8-8dc4-c85a098c4a92@iogearbox.net>
Date: Fri, 6 Oct 2023 15:49:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231006063233.74345d36@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27053/Fri Oct  6 09:44:40 2023)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/6/23 3:32 PM, Jakub Kicinski wrote:
> On Fri, 6 Oct 2023 13:18:40 +0200 Daniel Borkmann wrote:
>> That should be possible with some work this way, agree. I've been toying a bit
>> more on this issue, and actually there is an even better way which would cleanly
>> solve all use cases and we likely would utilize it for bpf as well in future.
>> I wasn't aware of it before, but the drop reason actually has per-subsystem infra
>> already which so far only mac80211 and ovs makes use of.
> 
> FWIW I'm not sure if leaning into the subsys specific error codes for
> something as core as TC is a good direction. I'd think that what
> matters to the user is was it an intentional policy drop or some form
> of an error / exception. More detailed info can come from stats.
> 
> Maybe I'm overly conservative because I don't care about debugging
> mac80211 or ovs but do very much care about TC :) And I think Alastair
> (bpftrace) is working on auto-prettifying enums when bpftrace outputs
> maps. So we can do something like:
> 
> $ bpftrace -e 'tracepoint:skb:kfree_skb { @[args->reason] = count(); }'
> Attaching 1 probe...
> ^C
> 
> @[SKB_DROP_REASON_TC_INGRESS]: 2
> @[SKB_CONSUMED]: 34
> 
>    ^^^^^^^^^^^^ names!!
> 
> Auto-magically.

Very cool!

> Which will no longer work with the "pack multiple values into
> the reason" scheme of subsys-specific values :(

Too bad, do you happen to know why it won't work? Given they went into the
length of extending this for subsystems, they presumably would also like to
benefit from above. :/

> What I'm saying is that there is a trade-off here between providing
> as much info as possible vs basic user getting intelligible data..

Makes sense. I think we can drop that aspect for the subsys specific error
codes. Fwiw, TCP has 22 drop codes in the core section alone, so this should
be fine if you think it's better. The rest of the patch shown should still
apply the same way. I can tweak it to use the core section for codes, and
then it can be successively extended if that looks good to you - unless you
are saying from above, that just one error code is better and then going via
detailed stats for specific errors is preferred.

Thanks,
Daniel

