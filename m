Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E807F25B73B
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 01:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBXSv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 19:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBXSv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 19:18:51 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6CEC061244
        for <bpf@vger.kernel.org>; Wed,  2 Sep 2020 16:18:51 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DCEB414CFAAE2;
        Wed,  2 Sep 2020 16:02:03 -0700 (PDT)
Date:   Wed, 02 Sep 2020 16:18:49 -0700 (PDT)
Message-Id: <20200902.161849.1363975274756227714.davem@davemloft.net>
To:     alexei.starovoitov@gmail.com
Cc:     jose.marchesi@oracle.com, bpf@vger.kernel.org
Subject: Re: EF_BPF_GNU_XBPF
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200902203206.nx6ws4ixuo2bcic6@ast-mbp.dhcp.thefacebook.com>
References: <CAADnVQ+AZvXTSitF+Fj5ohYiKWERN2yrPtOLR9udKcBTHSZzxA@mail.gmail.com>
        <87y2ls0w41.fsf@oracle.com>
        <20200902203206.nx6ws4ixuo2bcic6@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Wed, 02 Sep 2020 16:02:04 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Sep 2020 13:32:06 -0700

> On Wed, Sep 02, 2020 at 10:19:58PM +0200, Jose E. Marchesi wrote:
>> 
>> As such, the property of being verifiable is irrelevant.
> 
> No. It's a fundamental property of BPF.
> If it's not verifiable it's not BPF. It's not xBPF either.
> Please call it something else and don't confuse people that your ISA
> has any overlap with BPF. It doesn't. It's not verifiable.

I have to agree with Alexei here.  You are trying to create something
which is not fundamentally BPF and it will create a lot of confusion
and hardship on people who are working on BPF when you publish
binaries with this machine type.

Please don't do stuff like this, thank you.
