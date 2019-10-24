Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2BF1E28F4
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2019 05:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437329AbfJXDjH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Oct 2019 23:39:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36293 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408351AbfJXDjG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Oct 2019 23:39:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id j11so11140297plk.3
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2019 20:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W8sgLGjMxM6EuY1mpsS+9Tn33OqsmcrGz0uhv99VAHA=;
        b=T2bbeZtvsO039PfGe+EjPR125EqRdU9mKD894GYoR0zBnNNVcSR1u3DGiXZFKGUrwF
         Q1L4mEl5u7aBDGEgAvXjkzTOXSSGhbHMY7JwyTtpuA/1lUXfeioaDSSD5DwpPF81FKT1
         ajJMYUZOWHJQq3Czs4YHreOwy2CVWx9lD7yEqbXak5+nnWYpgJsNSp3cviar/kEx8g3A
         JL2eoJFhv69W7IpzFJO3QBiRSBRWpD2PYo0i6gZ0SVVJGOTgtJG3panMDXQqq/fdjcQQ
         JYHL/HihPBR2U1KB50B+TI1h2RA9YPd7A7tX1ZQWp7kanwYzwZ3TCAZYt7pKgxi2zf4H
         C+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W8sgLGjMxM6EuY1mpsS+9Tn33OqsmcrGz0uhv99VAHA=;
        b=QrzvpiZfO+dPbr9qWVB+fQB7tfP0iAK22MoUMmaQGIEsJM9DhWUBfsMInQH6xBubAc
         IAlJF7/KNFqVVpQdfw2OocaZOtlxhQ9hf0bC/tOryaKDKMqp7jZcn0vfF5FQZw87WZ0N
         uCZ0rpH9G4UR3LV2y+u8/rmWMzH6Fc6BSMaL7yNAWkJp5JXDf1wXwRiYrJJCpn+k3v9a
         NLUtMlPBtJ9OFwPjU4dQMOFh8/inpNaMMfkcZO28MrcGwJ15C75O924f4ctt1BWfcAX1
         5DmCq2d8GynXTqbamm6bm19lpuS9+13jPz/vlkMmaAhC6Fo7rw2wzMcibYtPWbol4nEc
         VV1A==
X-Gm-Message-State: APjAAAX+x2vUnbFVqyxymUDGLeqNWiljwJqMm3GigHoz5eqcDkgWsSDf
        N74gPO+wVP7oZgjVNAuz4lTPWj4voPmgvQ==
X-Google-Smtp-Source: APXvYqzjuWYGP5CVydefv3aAYM4Zf7GeakbWEIFeuKC0sgKLKckuazE4qo+gNK3oOsra0rup9w7uiQ==
X-Received: by 2002:a17:902:968f:: with SMTP id n15mr13304176plp.191.1571888344349;
        Wed, 23 Oct 2019 20:39:04 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id b17sm9759144pfr.17.2019.10.23.20.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 20:39:03 -0700 (PDT)
Subject: Re: [Kgdb-bugreport] [PATCH] kernel: convert switch/case fallthrough
 comments to fallthrough;
To:     Joe Perches <joe@perches.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pm@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org
References: <f31b38b9ad515a138edaecf85701b1e3db064114.camel@perches.com>
 <20191021090909.yjyed4qodjjcioqc@holly.lan>
 <bff0a1c4fc69b83c763ffbce42a0152e1573499a.camel@perches.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2808c960-6178-17b8-23d7-a6945987a658@kernel.dk>
Date:   Wed, 23 Oct 2019 21:39:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bff0a1c4fc69b83c763ffbce42a0152e1573499a.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/23/19 12:49 PM, Joe Perches wrote:
> On Mon, 2019-10-21 at 10:09 +0100, Daniel Thompson wrote:
>> On Fri, Oct 18, 2019 at 09:35:08AM -0700, Joe Perches wrote:
>>> Use the new pseudo keyword "fallthrough;" and not the
>>> various /* fallthrough */ style comments.
>>>
>>> Signed-off-by: Joe Perches <joe@perches.com>
>>> ---
>>>
>>> This is a single patch for the kernel/ source tree,
>>> which would otherwise be sent through as separate
>>> patches to 19 maintainer sections.
>>
>> For the kernel/debug/ files:
>>
>> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
>>
>> Will you be putting this in an immutable branch once you've collected
>> enough acks?
> 
> No, I expect Linus will either run the script
> or apply this patch one day.

Please coordinate and get something like this run/applied a few days
before -rc1 to cause the least amount of needless merge issues.

-- 
Jens Axboe

