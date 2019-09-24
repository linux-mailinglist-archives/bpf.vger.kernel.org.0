Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31FD0BCC95
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2019 18:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfIXQj1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Sep 2019 12:39:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44048 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbfIXQj1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Sep 2019 12:39:27 -0400
Received: by mail-io1-f68.google.com with SMTP id j4so5992173iog.11
        for <bpf@vger.kernel.org>; Tue, 24 Sep 2019 09:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aQXjcttbLiJ66376wUArCGw4+fMYjer27LHa16Xc6r0=;
        b=U7w52Z0Fp8BOUxTOn/qWC98gNV4cup4wa+YgUKx5VVMQVMnJj8wSE6W0dbRjCKKm2H
         pviOHtF2QyPwud9ic8nsDjDwD7azHH5eETtdUlmx56xv/AbX4fpGaO9UyjWZdYBui+yg
         uJO8cqDV6t+pjPvBHAnKgUEV8VxziirI1kPVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aQXjcttbLiJ66376wUArCGw4+fMYjer27LHa16Xc6r0=;
        b=k9CuhOLfEDU/grbdg2ft02MA24eplntEBxXP/nqJ0EoT0Szc2WurzD0YP8wW1Mu4my
         IZ28ZN1pr8akhjq7P7cOayxAKNX+JJpxoJkiuMQ8Ovy2JkeA3j+LAaRCvWyaPP2EYZJX
         ypXz3t8i6zsna/TU+VdOTD9KO0H3Q8v9fXWwenpN8vf2TbXVjssmhR4eae/2pwVwC3E1
         nC+XosCDqLzhJw5VbGxoQtvgXtBRILIYbvKAPrakuCUuYUJczWniYr+e03HZ6Wn2E4NA
         aDmb05Tep/VjyWkRvUbTxYrhNYRyTQTISjTLVI6rN6c14zKFd3LRjKnVE+UbgkU+fsr1
         pPvA==
X-Gm-Message-State: APjAAAUtB67m/E7snCKA22pDuB3rbW5W943GVx2zsVE90ddTFDH2tPXF
        yqPjmnzAO3eTiHOaJPnVLWdJJg==
X-Google-Smtp-Source: APXvYqzBLrOYjDVzR8fRyI2p2F4LP7qEI6zo8Yubh6Ub7ZXmgn7T702iWitKfSKlU8c7GRrUZGZWYw==
X-Received: by 2002:a6b:c895:: with SMTP id y143mr4301975iof.271.1569343164692;
        Tue, 24 Sep 2019 09:39:24 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m5sm1755446ioh.69.2019.09.24.09.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 09:39:23 -0700 (PDT)
Subject: Re: Linux 5.4 - bpf test build fails
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <742ecabe-45ce-cf6e-2540-25d6dc23c45f@linuxfoundation.org>
 <1d1bbc01-5cf4-72e6-76b3-754d23366c8f@arm.com>
 <34a9bd63-a251-0b4f-73b6-06b9bbf9d3fa@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a603ee8e-b0af-6506-0667-77269b0951b2@linuxfoundation.org>
Date:   Tue, 24 Sep 2019 10:39:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <34a9bd63-a251-0b4f-73b6-06b9bbf9d3fa@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/24/19 10:03 AM, Shuah Khan wrote:
> On 9/24/19 9:52 AM, Cristian Marussi wrote:
>> Hi Shuah
>>
>> On 24/09/2019 16:26, Shuah Khan wrote:
>>> Hi Alexei and Daniel,
>>>
>>> bpf test doesn't build on Linux 5.4 mainline. Do you know what's
>>> happening here.
>>>
>>>
>>> make -C tools/testing/selftests/bpf/
>>
>> side question, since I'm writing arm64/ tests.
>>
>> my "build-testcases" following the KSFT docs are:
>>
>> make kselftest
>> make TARGETS=arm64 kselftest
>> make -C tools/testing/selftests/
>> make -C tools/testing/selftests/ INSTALL_PATH=<install-path> install
>> make TARGETS=arm64 -C tools/testing/selftests/
>> make TARGETS=arm64 -C tools/testing/selftests/ 
>> INSTALL_PATH=<install-path> install
>> ./kselftest_install.sh <install-path>

Cristian,

That being said, I definitely want to see this list limited to
a few options.

One problem is that if somebody wants to do just a build, there
is no option from the main makefile. I have sent support for that
a few months ago and the patch didn't got lost it appears. I am
working on resending those patches. The same is true for install.
I sent in a patch for that a while back and I am going to resend.
These will make it easier for users.

I would really want to get to supporting only these options:

These are supported now:

make kselftest
make TARGETS=arm64 kselftest (one or more targets)

Replace the following:

make -C tools/testing/selftests/ with

make kselftes_build option from main makefile

Replace this:
make -C tools/testing/selftests/ INSTALL_PATH=<install-path> install

with
make kselftest_install

That way we can support all the use-cases from the main Makefile

thanks,
-- Shuah


