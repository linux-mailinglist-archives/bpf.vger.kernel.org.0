Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C770B349ADD
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 21:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhCYULM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 16:11:12 -0400
Received: from forward2-smtp.messagingengine.com ([66.111.4.226]:37729 "EHLO
        forward2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230357AbhCYUK6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Mar 2021 16:10:58 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Mar 2021 16:10:58 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailforward.nyi.internal (Postfix) with ESMTP id 33F851940C8A;
        Thu, 25 Mar 2021 16:01:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 25 Mar 2021 16:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=xUY8JMHE5Bq0HoQzfWchmt1/xTlcguEpCokZz3eSh
        QQ=; b=ETjj/GCiTmzgHNL4JccjZ0HHr3WcJkKzFq6YR3IOSkDkOtKqHdiEuuIz1
        xUb/cN355pRpsyKZOWqFLbNN6cymeGgWDw7jOqA99yaItLelgjAeA8XFg7apaH7I
        XNw9rrOHrUT2CO70zdJo6f5lOJo5OgU1ij7s34VEBfZEaezkA36VYutX2Ffhc6fN
        GEW+1N0+tBY0/dCZDbUanYb+Frkt1/DtWlLhnIRFxSn6OwFNkbKToIeS17WrNb3i
        Cu06DhYJcMDm+Ibi4vgGrhfaVKLK6JZz9lDB7/o3iYh1/81EB9hzSLzrmpuQ17w+
        BxFdrUVuEk8GbvDyiSWuc+8Sgwrww==
X-ME-Sender: <xms:H-xcYI20W63G45N9fnrt5nW95usWaifuTs5UbI8WcV1S-Bg2Jdew7w>
    <xme:H-xcYMtA08cEeRyhq4o9RYMJp5XMKvLS1P9aHo_cA90j2tYEsjNuF0NTHB-uvFZTO
    4SKGUK7xWwqDP9SWd4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehtddgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeftrghf
    rggvlhcuffgrvhhiugcuvfhinhhotghouceorhgrfhgrvghlughtihhnohgtohesuhgsuh
    hnthhurdgtohhmqeenucggtffrrghtthgvrhhnpeevjeekudeijefhfeehuefhgeeiueei
    ffeiieehgfdvvdethfffffeuueehhfegveenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmnecukfhppedukeelrddurdduieekrddugeejnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprhgrfhgrvghlughtihhnohgtohesuhgsuhhnth
    hurdgtohhm
X-ME-Proxy: <xmx:H-xcYA7wHlg_-WYbXSdvn8QVOkc-6y7866XwMaKU1xTBxwHbsydnww>
    <xmx:H-xcYFLSPvasYvewoTokK970H3wNt5dMr2abOPNNKyemS03oapTvng>
    <xmx:H-xcYI68FzLjrpsZdqAefmfCRFuy7aDJZ8wZj0b6xWlaa47Avur74Q>
    <xmx:IOxcYE6V4Fe7nTsY53qP8W2mIG53s49rh2c6vKRoxHqjvoeWpcbwZw>
Received: from ibmmac.local (unknown [189.1.168.147])
        by mail.messagingengine.com (Postfix) with ESMTPA id DA7C7240065;
        Thu, 25 Mar 2021 16:01:34 -0400 (EDT)
Subject: Re: [PATCH v3 bpf-next] libbpf: add bpf object kern_version attribute
 setter
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     andrii.nakryiko@gmail.com,
        Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
        bpf@vger.kernel.org
References: <20210323040952.2118241-1-rafaeldtinoco@ubuntu.com>
 <60597d21d7eed_45ba42086@john-XPS-13-9370.notmuch>
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Message-ID: <a286bddf-8217-57e3-30bf-a09f3de2592e@ubuntu.com>
Date:   Thu, 25 Mar 2021 17:01:32 -0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <60597d21d7eed_45ba42086@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>> Unfortunately some distros don't have their kernel version defined
>> accurately in <linux/version.h> due to different long term support
>> reasons.
>>
>> It is important to have a way to override the bpf kern_version
>> attribute during runtime: some old kernels might still check for
>> kern_version attribute during bpf_prog_load().
>>
>> Signed-off-by: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
>> ---
>>   tools/lib/bpf/libbpf.c   | 10 ++++++++++
>>   tools/lib/bpf/libbpf.h   |  1 +
>>   tools/lib/bpf/libbpf.map |  1 +
>>   3 files changed, 12 insertions(+)
>>
> 
> Hi Andrii and Rafael,
> 
> Did you consider making kernel version an attribute of the load
> API, bpf_prog_load_xattr()? This feels slightly more natural
> to me, to tell the API the kernel you need at load time.

Hi John,

This is how I'm using:
https://github.com/rafaeldtinoco/portablebpf/blob/master/mine.c#L285

> Although, I don't use the skeleton pieces so maybe it would be
> awkward for that usage.

having a xxx_bpf object:

xxx_bpf__open_and_load() -> xxx_bpf__load() -> 
bpf_object__load_skeleton() -> bpf_object_load() -> bpf_object__loadxattr()

We would have to add kern_version to 'bpf_object_skeleton' struct, to be 
passed to 'bpf_object__load_skeleton()' to have it passed on.

I'll let Andrii to see what he prefers.

Note:

Reason for all this (including the legacy kprobe logic, in other commit) 
is to continue the 
https://github.com/rafaeldtinoco/conntracker/tree/poc-cmd project, 
making sure it supports 4.x kernels. Still adding bpf support to it 
(identify task/pid per flow) and will replace the libnf* usage with bpf 
after that.

Thanks
-rafaeldtinoco
