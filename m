Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9392E5F5A96
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 21:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiJET0v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 15:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiJET0Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 15:26:25 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276452E6BE;
        Wed,  5 Oct 2022 12:26:22 -0700 (PDT)
Message-ID: <e29082a8-bbd5-6ee3-34bf-c16d0f6ed45a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664997981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QMx+O6txVBe6luUxFtYr48kQl9eo/xhJDN4obDY8Fu0=;
        b=TVQ7WSKIYLk8sekzjs9PzAb8BZRHfT8BJN1XLn1pFh7SYlGh5DNlsAOwlsH/fq3If4lnmn
        Tiqv0H4TYDBHjVL6IvjbJofYt6frQpqOYhhPocnKfvt7JQaZCaijE8n4wNscW9LFdWR2s3
        DEx9xZ3gHyzqtWb8JJu5eNsuXeSTCDk=
Date:   Wed, 5 Oct 2022 12:26:07 -0700
MIME-Version: 1.0
Subject: Re: [PATCH RFCv2 bpf-next 00/18] XDP-hints: XDP gaining access to HW
 offload hints via BTF
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Jesper Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        xdp-hints@xdp-project.net, larysa.zaremba@intel.com,
        memxor@gmail.com, Lorenzo Bianconi <lorenzo@kernel.org>,
        mtahhan@redhat.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dave@dtucker.co.uk, Magnus Karlsson <magnus.karlsson@intel.com>,
        bjorn@kernel.org, Jakub Kicinski <kuba@kernel.org>
References: <166256538687.1434226.15760041133601409770.stgit@firesoul>
 <Yzt2YhbCBe8fYHWQ@google.com>
 <35fcfb25-583a-e923-6eee-e8bbcc19db17@redhat.com>
 <CAKH8qBuYVk7QwVOSYrhMNnaKFKGd7M9bopDyNp6-SnN6hSeTDQ@mail.gmail.com>
 <5ccff6fa-0d50-c436-b891-ab797fe7e3c4@linux.dev>
 <20221004175952.6e4aade7@kernel.org>
 <CAKH8qBtdAeHqbWa33yO-MMgC2+h2qehFn8Y_C6ZC1=YsjQS-Bw@mail.gmail.com>
 <20221004182451.6804b8ca@kernel.org>
 <CAKH8qBtTPNULZDLd2n1r2o7XZwvs_q5OkNqhdq0A+b5zkHRNMw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAKH8qBtTPNULZDLd2n1r2o7XZwvs_q5OkNqhdq0A+b5zkHRNMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/4/22 7:15 PM, Stanislav Fomichev wrote:
> On Tue, Oct 4, 2022 at 6:24 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Tue, 4 Oct 2022 18:02:56 -0700 Stanislav Fomichev wrote:
>>> +1, sounds like a good alternative (got your reply while typing)
>>> I'm not too versed in the rx_desc/rx_queue area, but seems like worst
>>> case that bpf_xdp_get_hwtstamp can probably receive a xdp_md ctx and
>>> parse it out from the pre-populated metadata?
>>
>> I'd think so, worst case the driver can put xdp_md into a struct
>> and container_of() to get to its own stack with whatever fields
>> it needs.
> 
> Ack, seems like something worth exploring then.
> 
> The only issue I see with that is that we'd probably have to extend
> the loading api to pass target xdp device so we can pre-generate
> per-device bytecode for those kfuncs? 

There is an existing attr->prog_ifindex for dev offload purpose.  May be we can 
re-purpose/re-use some of the offload API.  How this kfunc can be presented also 
needs some thoughts, could be a new ndo_xxx.... not sure.
> And this potentially will block attaching the same program 
 > to different drivers/devices?
> Or, Martin, did you maybe have something better in mind?

If the kfunc/helper is inline, then it will have to be per device.  Unless the 
bpf prog chooses not to inline which could be an option but I am also not sure 
how often the user wants to 'attach' a loaded xdp prog to a different device. 
To some extend, the CO-RE hints-loading-code will have to be per device also, no?

Why I asked the kfunc/helper approach is because, from the set, it seems the 
hints has already been available at the driver.  The specific knowledge that the 
xdp prog missing is how to get the hints from the rx_desc/rx_queue.  The 
straight forward way to me is to make them (rx_desc/rx_queue) available to xdp 
prog and have kfunc/helper to extract the hints from them only if the xdp prog 
needs it.  The xdp prog can selectively get what hints it needs and then 
optionally store them into the meta area in any layout.

NETIF_F_XDP_HINTS_BIT probably won't be needed and one less thing to worry in 
production.

> 
>>> Btw, do we also need to think about the redirect case? What happens
>>> when I redirect one frame from a device A with one metadata format to
>>> a device B with another?
>>
>> If there is a program on Tx then it'd be trivial - just do the
>> info <-> descriptor translation in the opposite direction than Rx.

+1

>> TBH I'm not sure how it'd be done in the current approach, either.

Yeah, I think we need more selftest to show how things work.

> 
> Yeah, I don't think it magically works in any case. I'm just trying to
> understand whether it's something we care to support out of the box or
> can punt to the bpf programs themselves and say "if you care about
> forwarding metadata, somehow agree on the format yourself".
> 
>> Now I questioned the BTF way and mentioned the Tx-side program in
>> a single thread, I better stop talking...
> 
> Forget about btf, hail to the new king - kfunc :-D

