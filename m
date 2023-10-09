Return-Path: <bpf+bounces-11682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D12257BD4EA
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 10:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7641C20BA0
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 08:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C683D14F98;
	Mon,  9 Oct 2023 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="JMtE051B"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FE411737;
	Mon,  9 Oct 2023 08:11:14 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A2794;
	Mon,  9 Oct 2023 01:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MAhYKm5OVeLXwnJLUNyL0PqtEGFycbwWz6QcecLkjXE=; b=JMtE051BPVkeUo/f7+epzEUZKh
	qJKBuaDpkSu7NB0obo3lvCO/l425nJO8Vsv+74leeFInH6gNY34sVYZmrYfb99pbxxI9P4vRaVqqs
	kaDUjWhJsfdjkF1XfGH2E2bBt80qRhznccgKwTZNWUWQAM1xZANKoc8iwxbsa14+2pzrGLj1Td9Kr
	d78eK6khYMzLGVM6BIMRVoqjSxbghhff23+WXjtIpMhc7vvaIWC1R8YrPCPHjGi5Aq+g4TtzPTSKk
	QIqm1sbNSrVH9+iydJpyawAPs0YwdDyzZ2A4Ue0BnnFG3aiDUH0dL7scNGKlw2DdJGvFV3FD+vL6s
	EKPKM8Cw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qplM1-000BFD-SG; Mon, 09 Oct 2023 10:11:05 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qplM1-000QjB-Fv; Mon, 09 Oct 2023 10:11:05 +0200
Subject: Re: [PATCH net-next 1/2] net, tc: Make tc-related drop reason more
 flexible
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 jhs@mojatatu.com, victor@mojatatu.com, martin.lau@linux.dev, dxu@dxuuu.xyz
References: <20231006190956.18810-1-daniel@iogearbox.net>
 <ZSLmkPxB9mHBT52v@pop-os.localdomain>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ca8d1a59-eb28-5a10-f261-a1b97e4156fc@iogearbox.net>
Date: Mon, 9 Oct 2023 10:11:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZSLmkPxB9mHBT52v@pop-os.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27055/Sun Oct  8 09:39:49 2023)
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/8/23 7:27 PM, Cong Wang wrote:
> On Fri, Oct 06, 2023 at 09:09:55PM +0200, Daniel Borkmann wrote:
>> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>> index c7318c73cfd6..90774cb2ac03 100644
>> --- a/include/net/sch_generic.h
>> +++ b/include/net/sch_generic.h
>> @@ -324,7 +324,6 @@ struct Qdisc_ops {
>>   	struct module		*owner;
>>   };
>>   
>> -
>>   struct tcf_result {
>>   	union {
>>   		struct {
>> @@ -332,8 +331,8 @@ struct tcf_result {
>>   			u32		classid;
>>   		};
>>   		const struct tcf_proto *goto_tp;
>> -
>>   	};
>> +	enum skb_drop_reason		drop_reason;
>>   };
>>   
>>   struct tcf_chain;
>> @@ -667,6 +666,12 @@ static inline int tc_classid_to_hwtc(struct net_device *dev, u32 classid)
>>   	return (hwtc < netdev_get_num_tc(dev)) ? hwtc : -EINVAL;
>>   }
>>   
>> +static inline void tc_set_drop_reason(struct tcf_result *res,
>> +				      enum skb_drop_reason reason)
>> +{
>> +	res->drop_reason = reason;
>> +}
>> +
> 
> Since this helper is for TC filters and actions, include/net/pkt_cls.h
> is a better place for it?

Makes sense, will move it in a v2 (and also rename into tcf_set_drop_reason).

Thanks,
Daniel

