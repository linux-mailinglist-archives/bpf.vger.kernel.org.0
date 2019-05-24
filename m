Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD8B29514
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 11:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389883AbfEXJrL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 05:47:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40481 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390046AbfEXJrK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 05:47:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id t4so1030540wrx.7
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E64qeAAP2w/n1CiuWrXNJxPZ0IE4ieybpsbyKIFdPp4=;
        b=YCmT73OhMqadHCsxbupiehVuLdYeS0GdV6wGDVliTAt+UAIFwSJG5ksCV9JZei00Qv
         wKJC+CQEJA97HfjQnhDco5JQMfwQfClgktX/3UFqI2V2PNAHtF3fkuaMgwdGyWl78fBL
         oNWESTXaSk1CF2KGG3BRjkMhR4zeMZPoRTlHVjeb5Fmc2wr/dijXyW1yJt/TkHzXTh3O
         QxYX5fNRQqMoKgJCxxdal9GMoBeUDzXoiVnHeaWVlXGsSrR3UdfPewdXl199VxjeRa94
         E+w5XCyF+Zn5lX8jpURmQI0pwt5rNi/toW4SP1D6PvRbPJ56VnMlwVzKruy1+roXhgAD
         Ldyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E64qeAAP2w/n1CiuWrXNJxPZ0IE4ieybpsbyKIFdPp4=;
        b=AgT10RfOukoYDzsoZGT1u3nWGJ+kCuj+Ai+rGxVkvE94oMwsJUW3daTUh43DL67yK6
         F2g7cUxCkfOfMhC6RqgPeLNer4j2OXFPvEUSmKUeEua86fDAljPodLx5A2wbFJ8wbh4P
         XD//6vhHoMNMCLQbELIXWekcYS8m3DYoD6ZdKedZ49EHqELoScV7LfRoT8Etfhlhob8l
         kOpNYF56nTQTMGuDjpRdP/AP5/gUHPrjT9Pt/JFHREedJ+I39jUWcg8qFVqKqsjDuDZX
         rhEJBm85e6atpoQmxLJBpRlmLxMRbYODueqm4bMEls/oAgr6fBXI2zToI9mAqrelZwX6
         bplg==
X-Gm-Message-State: APjAAAU5pdtNGMeJu2Sg0dqwDPA9lPKY5rOwdEayv/DNwqHspisOCujG
        /xMM7q8vhjcjE5lTcZB8tirqhQ==
X-Google-Smtp-Source: APXvYqzwTlJGYMu5ezO0pyXwGZFP5I39st2sl64KmFhSlgGgDobVm0jgtZ+9ygQ7y1Afn8Y2oBrSKQ==
X-Received: by 2002:a5d:68d2:: with SMTP id p18mr58094170wrw.56.1558691228815;
        Fri, 24 May 2019 02:47:08 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.20])
        by smtp.gmail.com with ESMTPSA id m206sm2201950wmf.21.2019.05.24.02.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 02:47:08 -0700 (PDT)
Subject: Re: [PATCH bpf-next v2 3/3] tools: bpftool: make -d option print
 debug output from verifier
To:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>
References: <20190523105426.3938-1-quentin.monnet@netronome.com>
 <20190523105426.3938-4-quentin.monnet@netronome.com>
 <aca2c9a8-9ae0-a5df-61b0-d0b79ecfa911@fb.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <e97e5b03-2bc5-a3c6-ad40-812b864fc425@netronome.com>
Date:   Fri, 24 May 2019 10:47:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <aca2c9a8-9ae0-a5df-61b0-d0b79ecfa911@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-05-23 16:38 UTC+0000 ~ Yonghong Song <yhs@fb.com>
> 
> 
> On 5/23/19 3:54 AM, Quentin Monnet wrote:
>> The "-d" option is used to require all logs available for bpftool. So
>> far it meant telling libbpf to print even debug-level information. But
>> there is another source of info that can be made more verbose: when we
>> attemt to load programs with bpftool, we can pass a log_level parameter
>> to the verifier in order to control the amount of information that is
>> printed to the console.
>>
>> Reuse the "-d" option to print all information the verifier can tell. At
>> this time, this means logs related to BPF_LOG_LEVEL1, BPF_LOG_LEVEL2 and
>> BPF_LOG_STATS. As mentioned in the discussion on the first version of
>> this set, these macros are internal to the kernel
>> (include/linux/bpf_verifier.h) and are not meant to be part of the
>> stable user API, therefore we simply use the related constants to print
>> whatever we can at this time, without trying to tell users what is
>> log_level1 or what is statistics.
>>
>> Verifier logs are only used when loading programs for now (in the
>> future: for loading BTF objects with bpftool?), so bpftool.rst and
>> bpftool-prog.rst are the only man pages to get the update.
> 
> The current BTF error log print out at warning level. So by default,
> it should print out error logs unless it is suppressed explicitly.

Understood, thanks! This is probably something we could change in
libbpf, to have it printed for debug log-level even when no error
occurred. But bpftool does not support loading BTF just yet anyway, so I
suppose it can wait.

Thanks for the review!
Quentin
