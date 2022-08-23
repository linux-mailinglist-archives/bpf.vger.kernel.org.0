Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4907259E800
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 18:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245406AbiHWQsi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 12:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245503AbiHWQrc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 12:47:32 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4334D9F8D3
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 07:23:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so9679989wme.1
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ph0yVvHaJftkep4xaaP5tQjh94KpIWZ3IWizXSWvL8M=;
        b=LLiIOHOYEjKXH3wQGmAbFDPscs+DAYZqPU5z+w2o243A7gB4qUpKZ5WslwtWkamp8K
         6ACwQUyuc/71CiXbkMlWhUknVwu2FSSX/UqDbYEGFit37WP2A7yZEiI/LbBQNc/ZcQKq
         1LoHjbbyKhU1+9OphpFMRqVapxRaBv3KHR78AydSPvD1xcqM3WQfH7jGZ44mNU3xdPMI
         w4oKFhXx3f9r9WuTIRDY3+ferQlCLHOj8oyt8WuSQEeyKhSnk2WiSsYAU4lE9Wydlssj
         3pQHoo9zdX2LFZsSvbcul1dNoO4pCHfZ3mga7d/Cf5BboYkg0mRLw4vS3WzOumGxSeqv
         qW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ph0yVvHaJftkep4xaaP5tQjh94KpIWZ3IWizXSWvL8M=;
        b=4qcFqBcetu+QrPW73lHVCdp10d7yNv7y1/A3G0EHQzZUBXGPvmisEX+9B/qFFYIaek
         ydY2lzq8q5jwK3ozJ7XKfHO2FqkL1xeTCx4HdYFda1GQn7pQbM011ybgJG5l2uSd9XA5
         VRotwpGhkAPPnZo+ZcnWmIdNJ2UDLMMcwYsVeF51bK2Zc+2RInq/jGKg1jqpyvq9/uWh
         KBUNretvEvNr7LAVxi3t05qdXhiHMzw3aL4BR4UwBgP9rLcIOzexNxXNvKXVYJc4IcL/
         hfAKnYJf0Q0cro/tPoUYtAvn0dU1AmV6PmooQQiBLT0olhH74+r7gGb0Jwnq6Lw+R1zO
         8IEA==
X-Gm-Message-State: ACgBeo1GE9boHOOkGr6gQrKniWPQV2sxXmJrTp5c19TgIX30WeMLljcx
        8sx7kYu90k4O6KiXDVdzSI83ZQ==
X-Google-Smtp-Source: AA6agR7VA6vrReXbJe8qczSO/bO7bkXixvXGV0l8w6XT4IZxJdTM0+wC6HLg7VU1wdcQVi2JXG2Rrw==
X-Received: by 2002:a05:600c:1d16:b0:3a6:1fa1:41f7 with SMTP id l22-20020a05600c1d1600b003a61fa141f7mr2312227wms.103.1661264589800;
        Tue, 23 Aug 2022 07:23:09 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id b10-20020a05600c4e0a00b003a603fbad5bsm18881716wmq.45.2022.08.23.07.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 07:23:09 -0700 (PDT)
Message-ID: <1c07206a-25c5-9621-afd5-d64913fece13@isovalent.com>
Date:   Tue, 23 Aug 2022 15:23:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH bpf-next] scripts/bpf: Fix attributes for bpf-helpers(7)
 man page
Content-Language: en-GB
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
References: <20220823084719.13613-1-quentin@isovalent.com>
 <a9533d19-8266-8eed-63ec-82aa07ce83d0@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <a9533d19-8266-8eed-63ec-82aa07ce83d0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23/08/2022 13:26, Alejandro Colomar wrote:
> Hi Quentin,
> 
> On 8/23/22 10:47, Quentin Monnet wrote:
>> The bpf-helpers(7) manual page shipped in the man-pages project is
>> generated from the documentation contained in the BPF UAPI header, in
>> the Linux repository, parsed by script/bpf_doc.py and then fed to
>> rst2man.
>>
>> After a recent update of that page [0], Alejandro reported that the
>> linter used to validate the man pages complains about the generated
>> document [1]. The header for the page is supposed to contain some
>> attributes that we do not set correctly with the script. This commit
>> updates some of them; please refer to the previous discussion for the
>> meaning of those fields and the value we use (tl;dr: setting "Version"
>> to "Linux" seems acceptable).
>>
>> Before:
>>
>>      $ ./scripts/bpf_doc.py helpers | rst2man | grep '\.TH'
>>      .TH BPF-HELPERS 7 "" "" ""
>>
>> After:
>>
>>      $ ./scripts/bpf_doc.py helpers | rst2man | grep '\.TH'
>>      .TH BPF-HELPERS 7 "" "Linux" "Linux Programmer's Manual"
>>
>> Note that this commit does not update the date field. This date should
>> ideally be updated when generating the page to the date of the last edit
>> of the documentation (which we can maybe approximate to the last edit of
>> the BPF UAPI header). There is a --date option in rst2man; it does not
>> update that field, but Alejandro raised an issue about it [2] so it
>> might do in the future. Anyway, we just leave the date empty for now.
>>
>> [0]
>> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/man7/bpf-helpers.7?id=19c7f78393f2b038e76099f87335ddf43a87f039
>> [1]
>> https://lore.kernel.org/all/20220721110821.8240-1-alx.manpages@gmail.com/t/#m8e689a822e03f6e2530a0d6de9d128401916c5de
>> [2] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1016527
>>
>> Cc: Alejandro Colomar <alx.manpages@gmail.com>
>> Reported-by: Alejandro Colomar <alx.manpages@gmail.com>
>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> 
> Heh, we very recently changed the .TH line in the Linux man-pages for
> consistency with tradition and most other manual pages out there):
> 
> <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=7bd6328fd40871ad75cbc3b6aa5d4a4b70f53ac7>
> <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=45186a5da74285d72199744eb5d2888fe348f680>

Wow, I'm two days late!

> 
> So, we now omit the last (5th) argument to .TH,
> and the Version one really contains a version now.
> I'll comment below with what I think you should do.
> 
> An example may show it better:
> 
> $ grep ^.TH <man2/membarrier.2
> .TH MEMBARRIER 2 2021-08-27 "Linux man-pages (unreleased)"
> 
> Of course, that '(unreleased)' is replaced by the actual version at the
> time of `make dist` (creating the tarball).
> 
> 
>> ---
>>   scripts/bpf_doc.py | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>> index dfb260de17a8..e66ef4f56e95 100755
>> --- a/scripts/bpf_doc.py
>> +++ b/scripts/bpf_doc.py
>> @@ -378,6 +378,8 @@ list of eBPF helper functions
>>  
>> -------------------------------------------------------------------------------
>>     :Manual section: 7
>> +:Manual group: Linux Programmer's Manual
> 
> Remove "Manual group" completely.  If we don't specify that, groff(1)
> (or mandoc(1)) will produce sane defaults.  For section 7, it uses
> "Miscellaneous Information Manual".
> 
> I will report a bug to rst2man(1) that it shouldn't leave the field as
> "" if not specified, but it should just not add the field at all if not
> specified.
> 
>> +:Version: Linux
> 
> You could append the version here.  Or maybe put a placeholder that the
> script should fill with information from the makefile or git-describe(1)?

So if I understand correctly, running bpf_doc.py should currently
produce the following string:

    .TH BPF-HELPERS 7 "" "Linux (5.19.0)" ""

Is this what you expect?

I can make the script call "make kernelversion" to produce the above.
I'm not 100% convinced it should be the role of that script vs. when
copying it (we risk having some inaccuracies, for example I generated
the above from the bpf-next, so it doesn't really correspond to 5.19),
but maybe it's easier that way and avoids adding another script in the
middle of the generation so OK.

Thanks,
Quentin
