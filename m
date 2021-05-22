Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515F638D743
	for <lists+bpf@lfdr.de>; Sat, 22 May 2021 21:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhEVTi1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 May 2021 15:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhEVTi1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 May 2021 15:38:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B15C061574;
        Sat, 22 May 2021 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=J77Q+/00dHZROE3h+kG9CJ0WG5qNx1OHZMBspyoORGw=; b=Es2Tgm07Yj46PWzOmQ2R97Vbh9
        R2XSBLdlIB9+ZK0s8DB8vkVx7vPhOhm0qC4BUfglWM/oIkY4Qqaen57IQ3fLUcfwkqMfCg7RCAfyo
        ULd3UgcuvcZ86ZH1iVqr2eag+CkA3NwlO1erZocmGl4HGckOzS9iRc3cM2R6rSs/rLWWTpB2Xbl5y
        ooDD6bMVAolFe2kMQKDP79PSOzyjWrF19ckes3VHgLs4TFdES63qK0eBy4BSbANlCIagMqhKtw1Jx
        mA3dkY9/fyXjy0epWyoxK24Xo72f654W0L/w4eNdIILExLyOOVpZ0BKc6+E4o0RdRNrZoW7Bffnwg
        WxYd70Pw==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkXQ3-000BgY-Oi; Sat, 22 May 2021 19:36:19 +0000
Subject: Re: Failed to start load kernel modules on 5.13.0-rc2-next-20210521
To:     Hritik Vijay <hritikxx8@gmail.com>
Cc:     linux-next@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
References: <YKlWqLh61Rxid7l9@Journey.localdomain>
 <21727ead-5092-8900-74e9-ee73774b0b97@infradead.org>
 <YKlcxO3ofPEr6ak7@Journey.localdomain>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <52f77a79-5042-eca7-f80e-657ac1c515de@infradead.org>
Date:   Sat, 22 May 2021 12:36:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YKlcxO3ofPEr6ak7@Journey.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/22/21 12:34 PM, Hritik Vijay wrote:
> On Sat, May 22, 2021 at 12:28:25PM -0700, Randy Dunlap wrote:
>> Hi,
>> Here is a reply to a similar message/problem:
>> https://lore.kernel.org/lkml/CAEf4BzZuU2TYMapSy7s3=D8iYtVw_N+=hh2ZMGG9w6N0G1HvbA@mail.gmail.com/
>>
>> so it looks like Andrii is still debugging this problem.
>>
>> -- 
>> ~Randy
> 
> Hi Randy. Thank you so much. All this time I was wondering if I'm
> messing up the compilation/boot somehow. I am not sure how to follow the
> thread. Perhaps sending a reply to the linked mail should do the trick,
> yes?

It should, yes.

-- 
~Randy

