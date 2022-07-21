Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828BE57D376
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 20:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiGUSkf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 14:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGUSke (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 14:40:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058ED19C2E;
        Thu, 21 Jul 2022 11:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=h/0A4RGH/zY+Ku8k/xauLxj65JhhDPY8gyI7dZDUJxY=; b=r0Y/tgeKdXYQmdSUjAH9KbS93X
        vneKr4mr3bjCT7CCsam6XRRDD/RKG5jTl6ONbGY1POmL8GodKZ4FvulV0XYKbG8KLVYLODEUaoMOP
        N55IcydIZ3VgNmD8sYc86zSpBUXVK1xCRMlp2oIPSt4R4S6qVnUGl1RIqCuBrTyM5k+nOBVP3PZrG
        soBqLHLzM1woHLIT8w66dF7flt8zHo2LGCZgcmVXKG4ByJ6b8RH5fc4ff6b9EHHeZLAdhlkSFzUDb
        odKzDKOv+AA1SfAedVyrqqa91b2twUjiLWpWcuRTIckeKp5dXNcm8Wtkhyj1CrDWyk/STmtj6Umop
        SKmMgiOg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEb5k-00BVq1-CS; Thu, 21 Jul 2022 18:40:08 +0000
Message-ID: <6ca59494-cc64-d85c-98e8-e9bef2a04c15@infradead.org>
Date:   Thu, 21 Jul 2022 11:40:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] docs: Fix typo in comment
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, Slark Xiao <slark_xiao@163.com>,
        kafai <kafai@fb.com>
Cc:     Baoquan He <bhe@redhat.com>, vgoyal <vgoyal@redhat.com>,
        dyoung <dyoung@redhat.com>, ast <ast@kernel.org>,
        daniel <daniel@iogearbox.net>, andrii <andrii@kernel.org>,
        "martin.lau" <martin.lau@linux.dev>, song <song@kernel.org>,
        yhs <yhs@fb.com>, "john.fastabend" <john.fastabend@gmail.com>,
        kpsingh <kpsingh@kernel.org>, sdf <sdf@google.com>,
        haoluo <haoluo@google.com>, jolsa <jolsa@kernel.org>,
        "william.gray" <william.gray@linaro.org>,
        dhowells <dhowells@redhat.com>, peterz <peterz@infradead.org>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        longman <longman@redhat.com>,
        "boqun.feng" <boqun.feng@gmail.com>, tglx <tglx@linutronix.de>,
        bigeasy <bigeasy@linutronix.de>,
        kexec <kexec@lists.infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>
References: <20220721015605.20651-1-slark_xiao@163.com>
 <20220721154110.fqp7n6f7ij22vayp@kafai-mbp.dhcp.thefacebook.com>
 <21cac0ea.18f.182218041f7.Coremail.slark_xiao@163.com>
 <874jzamhxe.fsf@meer.lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <874jzamhxe.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/21/22 11:36, Jonathan Corbet wrote:
> "Slark Xiao" <slark_xiao@163.com> writes:
> 
>> May I know the maintainer of one subsystem could merge the changes
>> contains lots of subsystem?  I also know this could be filtered by
>> grep and sed command, but that patch would have dozens of maintainers
>> and reviewers.
> 
> Certainly I don't think I can merge a patch touching 166 files across
> the tree.  This will need to be broken down by subsystem, and you may
> well find that there are some maintainers who don't want to deal with
> this type of minor fix.

We have also seen cases where "the the" should be replaced by "then the"
or some other pair of words, so some of these changes could fall into
that category.

-- 
~Randy
