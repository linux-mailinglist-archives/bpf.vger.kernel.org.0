Return-Path: <bpf+bounces-11566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B237BBFEA
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 21:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A612820DC
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDE741A9B;
	Fri,  6 Oct 2023 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="E4RKP6YN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A40B405DA;
	Fri,  6 Oct 2023 19:59:20 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74E383;
	Fri,  6 Oct 2023 12:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Y/6TvrWnw0mxUbKL7RCkA0LXmxr8SH68FBrbg7m/goM=; b=E4RKP6YNBvmtvFbg/pP+hf+67v
	IGrUjx2U6HiuQd3jjSegStl02v/lOplNiLkZdTvl2PHpfIypdWE7MqW2QPhw2s87lbhnRho7xIBBu
	8r6oyzHzPJrK0EtVnxCZOJK0MfwVaDBDPuzbz1YfHW1907MrqOnOGPtvL2XBuWLMlZCtQQgHwdSj3
	DD2E2neLnFeUYPuHuM57MSVigLnDM0emVzamgtGAAv3lvLz8S6I6uZ812Nb2lwvPcWQEsioQuC1sb
	uH3g1CkZQi8AVCTWVt9qTaKsAfP05b3vp4V8ceTq1/n5YTDlPiGq7ggtf00baLuy1Jf9VXoEppbK0
	FkTFqPxw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qoqyb-000E5M-IT; Fri, 06 Oct 2023 21:59:09 +0200
Received: from [178.197.249.17] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qoqyb-000My3-21; Fri, 06 Oct 2023 21:59:09 +0200
Subject: Re: [PATCH net-next 1/1] net/sched: Disambiguate verdict from return
 code
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Victor Nogueira <victor@mojatatu.com>,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, paulb@nvidia.com,
 netdev@vger.kernel.org, kernel@mojatatu.com, martin.lau@linux.dev,
 bpf@vger.kernel.org
References: <20230919145951.352548-1-victor@mojatatu.com>
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
 <686dd999-bee4-ecf8-8dc4-c85a098c4a92@iogearbox.net>
 <20231006071215.4a28b348@kernel.org>
 <CAM0EoM=SHrPg2j3pmp-CG7v1g_7KaENEjgdwQ7HWOhN3NxUnng@mail.gmail.com>
 <647b0742-8806-cb66-d880-3d25fd9c3480@iogearbox.net>
 <CAM0EoMkUv8P5ATy9qsJi_N12oGF-BEq_rrHPt=XB_4+5FC3YNw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <584a0df1-c967-8fe6-7e5a-6378de628424@iogearbox.net>
Date: Fri, 6 Oct 2023 21:59:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMkUv8P5ATy9qsJi_N12oGF-BEq_rrHPt=XB_4+5FC3YNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27053/Fri Oct  6 09:44:40 2023)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/6/23 9:39 PM, Jamal Hadi Salim wrote:
> On Fri, Oct 6, 2023 at 11:45 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 10/6/23 5:25 PM, Jamal Hadi Salim wrote:
>>> On Fri, Oct 6, 2023 at 10:12 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>> On Fri, 6 Oct 2023 15:49:18 +0200 Daniel Borkmann wrote:
>>>>>> Which will no longer work with the "pack multiple values into
>>>>>> the reason" scheme of subsys-specific values :(
>>>>>
>>>>> Too bad, do you happen to know why it won't work?
>>>>
>>>> I'm just guessing but the reason is enum skb_drop_reason
>>>> and the values of subsystem specific reasons won't be part
>>>> of that enum.
>>>
>>> IIUC, this would gives us the readability and never require any
>>> changes to bpftrace, whereas the major:minor encoding would require
>>> further logic in bpftrace.
>>
>> Makes sense, agree.
>>
>>>>> Given they went into the
>>>>> length of extending this for subsystems, they presumably would also like to
>>>>> benefit from above. :/
>>>>>
>>>>>> What I'm saying is that there is a trade-off here between providing
>>>>>> as much info as possible vs basic user getting intelligible data..
>>>>>
>>>>> Makes sense. I think we can drop that aspect for the subsys specific error
>>>>> codes. Fwiw, TCP has 22 drop codes in the core section alone, so this should
>>>>> be fine if you think it's better. The rest of the patch shown should still
>>>>> apply the same way. I can tweak it to use the core section for codes, and
>>>>> then it can be successively extended if that looks good to you - unless you
>>>>> are saying from above, that just one error code is better and then going via
>>>>> detailed stats for specific errors is preferred.
>>>>
>>>> No, no, multiple reasons are perfectly fine. The non-technical
>>>> advantage of mac80211 error codes being separate is that there
>>>> are no git conflicts when we add new ones. TC codes can just
>>>> be added to the main enum like TCP 🤷️
>>>
>>> We still need to differentiate policy vs error - I suppose we could go
>>> with Daniel's idea of introducing TC_ACT_ABORT/ERROR and ensure all
>>> the callees set the drop_reason.
>>
>> I've simplified the set (attached). The disambiguation could eventually be on
>> SKB_DROP_REASON_TC_{INGRESS,EGRESS} == intentional drop vs SKB_DROP_REASON_TC_ERROR_*
>> which indicates an internal error code once these are covered on all locations.
>> There could probably also be just a SKB_DROP_REASON_TC_ERROR which could act as
>> a catch-all for the time being to initially mark all error locations with something
>> generic. I think this should be flexible where you wouldn't need extra TC_ACT_ABORT.
> 
> I think this should work - either Victor or myself will work on a followup.

Sounds great, thanks!

Cheers,
Daniel

