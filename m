Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338611B4878
	for <lists+bpf@lfdr.de>; Wed, 22 Apr 2020 17:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgDVPWE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Apr 2020 11:22:04 -0400
Received: from q2relay63.mxroute.com ([160.202.107.63]:41571 "EHLO
        q2relay63.mxroute.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgDVPWE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Apr 2020 11:22:04 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Apr 2020 11:22:04 EDT
Received: from qps ([162.219.26.146] 162-219-26-146.quickpacket.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by q2relay63.mxroute.com (ZoneMTA) with ESMTPSA id 171a276a1ca000f364.001
 for <bpf@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Wed, 22 Apr 2020 15:16:56 +0000
X-Zone-Loop: d97ce3f8b061c7292832c4a69511e61f49938811023f
Received: from filter003.mxroute.com ([168.235.111.26] 168-235-111-26.cloud.ramnode.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by qps (ZoneMTA) with ESMTPA id 171a26b7f010000d83.001
 for <bpf@vger.kernel.org>;
 Wed, 22 Apr 2020 15:04:46 +0000
X-Zone-Loop: a9ecf06f14bce0d7570ba393f5d538e8ce45c57b4612
X-Originating-IP: [162.219.26.146]
Received: from ocean.mxroute.com (ocean.mxroute.com [195.201.59.214])
        by filter003.mxroute.com (Postfix) with ESMTPS id E7FA060056
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2020 15:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gflclan.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QEmsNWsQEOReXThiqJmQr5amzJ2bOuI7TffzrW1M+fU=; b=QzKjDQqFE38X7myOiRZL/FUC/D
        jateKciydQDolT5fQ3CBvMuqLe9edvXO161rg9lviXlRGEWhNuG/cGOE6nuCczOOsqhVS2694+zHf
        XfeluhtCbtSlrBfIpmibWdxoHLED92Kcnn3vO8QXRLS4AQHajGmpgCCIdjEoKifH5e9aRsR4psNFs
        ZF/pe5HM8LNzh9+fP1aQeRaJ+H9VgwlXntlyXT3ppbaLFtvVq0gFbuVlIehrU2pQPOBkWjqIoyrSl
        H7UUm33Ohc67LZWjLXoNpW489bIViH6gXWAX1uNL2+h3cbeeMIiNAvrCeG2yXtCJ/1hHbn6+O82Wc
        kLlah8iw==;
Subject: Re: Bpfilter Development
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <ac739c9c-f377-129f-1d4b-6c4c7e15f83d@gflclan.com>
 <871roh9jsu.fsf@toke.dk>
From:   Christian Deacon <gamemann@gflclan.com>
Message-ID: <abc35979-c44e-da12-e891-5409f587cee9@gflclan.com>
Date:   Wed, 22 Apr 2020 10:04:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <871roh9jsu.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-OutGoing-Spam-Status: No, score=-10.0
X-AuthUser: gamemann@gflclan.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey Toke,


Thank you for your response!


Regarding the ETA rule, I will keep that noted in the future.


Thank you for the information regarding Bpfilter as well. It appears the 
development towards this has stopped at least temporarily. We will be 
looking into using XDP-native in this case! I will also take a look at 
the XDP-filter project you linked to see how everything is done, etc.


Thanks again!


On 4/21/2020 6:09 AM, Toke Høiland-Jørgensen wrote:
> Christian Deacon <gamemann@gflclan.com> writes:
>
>> Hey everyone,
>>
>>
>> I apologize if this is the incorrect place to address this. I couldn't
>> find any mailing list for Bpfilter specifically. If there is a better
>> place to address this, suggestions are welcomed and appreciated!
>>
>>
>> I was wondering if Bpfilter is still under development or if the project
>> development is at a halt. I am planning out my next major project that
>> will be responsible for forwarding traffic and blocking (D)DoS attacks
>> based off of filtering rules. As of right now, I'm trying to decide
>> whether to use Bpfilter or XDP-native for blocking malicious traffic.
>> With the project's current layout, I feel it would be easier using
>> something like Bpfilter for this. However, I'm not sure when this will
>> be completely developed to the point it'd be usable with my application.
>> If this project is under development, is there any ETA on when it will
>> be officially supported and in a usable state for most applications
>> (specifically for dropping malicious traffic)?
> As a general rule I think you will find that there are very few upstream
> developers who will commit to any ETA other than "when it's done". As
> for bpfilter specifically, I am not aware of anyone actively working on
> it at all...
>
>> One last question I had is if there were any estimates on how fast
>> Bpfilter would be compared to XDP-native when dropping malicious
>> packets. I'd assume they would see similar performance, but I'm not
>> entirely sure.
> I would expect that XDP would be significantly faster (as long as you
> are using hardware with native XDP support in the driver). For DDOS
> filtering specifically, I think it would be a no-brainer to just go with
> XDP.
>
> Feel free to use xdp-filter as a starting point:
>
> https://github.com/xdp-project/xdp-tools/tree/master/xdp-filter
>
> It's pretty dumb as far as expressing the filtering rules themselves are
> concerned, but it does demonstrate how you might structure such a
> program, including how to only load the BPF code needed to support the
> active filtering rules. Pull requests always welcome to improve it as
> well, of course :)
>
> -Toke
>
