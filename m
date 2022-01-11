Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5920548AC45
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 12:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbiAKLRw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jan 2022 06:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238612AbiAKLRv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jan 2022 06:17:51 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22142C06173F
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 03:17:51 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k18so32225920wrg.11
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 03:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mb0/wRYd/+9Nxm4Gsw9lR3SkwUNjzyXUVZYsN0pQ42k=;
        b=0s2vYvsKJJPZN+ytgP/RwTMy8FFQX4ZeFL+oGb3y2KtnJ0CyvrrBiVGD9T2zJrS0xX
         GB5gXvkAue8NO800r/uoCqgsE2OuuX6Bhbra1d23iZmoJY/fs8lHiEx2R9lW5yLvLVzC
         ZbOaU047gDiq2qkg0dtUcSiL0gwIss2bw66GZ7axIWsGg6qrdt9ouJ5Fpaky6aGISHDC
         AtzijppiwYNejtBd2bsS9ulSE29d2doER3JNSbkzXc3gmFvftuBr+ZdkTbvxtJiPn4aw
         BQ9yoAkLAw7jJ+mFHObbbwbiCvbvlK3JSblNL45Fs45GLaFTESO1pK/5+k+RY/0KpxEB
         byGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mb0/wRYd/+9Nxm4Gsw9lR3SkwUNjzyXUVZYsN0pQ42k=;
        b=ppjNOVtpNJkIH2ZqUz9wmQuRZzrptecA9uV+3aE8LmLUD7XBNM5QlW7Dr5OxlKt4bz
         p0n/fYCcgv2WijWJfErDQ4XokDYF/9Va4wTM34unXI0KJ8gP22AJ5iCaVIY9GjCQRZAy
         +4Z/eMGUGXeSQc+2Ka+vbKMUdxDGknpQ53dyUawUEwto6hTO/WzharJO9MjmJEU1dSh8
         Jejvyiaqmpaii2j6V2q+q5qpTq73OrpSN1tAKRGsxZpeXyFYEmAfbBEo5to8WsbbvuNb
         WuKRPCi5j7DNF+MLN81hpkvy0GdFre/3lnQXGE04OhTVWXPcn3rls0iY2IRbp+o1qOa3
         5nEQ==
X-Gm-Message-State: AOAM5301o0fgiByVEA9/EEIeM1fZkCs3N3Og+ofQOFjRT00mkixjEHEs
        T1PEsB0atF1QMiMFTXrc/AV/8DeVW1N4zg==
X-Google-Smtp-Source: ABdhPJx3A93VjBw5VbLoKr6LtotwsRQfSaRJphVmMiOQhFgPbgln7OFBMwIDTs5wMW3UspvoYlV6Gw==
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr3359392wrz.127.1641899869696;
        Tue, 11 Jan 2022 03:17:49 -0800 (PST)
Received: from ?IPv6:2a02:6b6d:f804:0:3b22:c269:f398:55da? ([2a02:6b6d:f804:0:3b22:c269:f398:55da])
        by smtp.gmail.com with ESMTPSA id g1sm9591088wri.103.2022.01.11.03.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 03:17:49 -0800 (PST)
Subject: Re: [PATCH v2] bpf/scripts: add warning if the correct number of
 helpers are not auto-generated
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, joe@cilium.io,
        fam.zheng@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20220110143102.3466150-1-usama.arif@bytedance.com>
 <CAPhsuW58rPRsiKXmUNWa11ROzM5GpwbgAGxm80bgiOGPfmu0qg@mail.gmail.com>
From:   Usama Arif <usama.arif@bytedance.com>
Message-ID: <8e512316-d99f-1e17-0132-39608afaffa2@bytedance.com>
Date:   Tue, 11 Jan 2022 11:17:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW58rPRsiKXmUNWa11ROzM5GpwbgAGxm80bgiOGPfmu0qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/01/2022 22:43, Song Liu wrote:
> On Mon, Jan 10, 2022 at 6:31 AM Usama Arif <usama.arif@bytedance.com> wrote:
>>
>> Currently bpf_helper_defs.h is auto-generated using function documentation
>> present in bpf.h. If the documentation for the helper is missing
>> or doesn't follow a specific format for e.g. if a function is documented
>> as:
>>   * long bpf_kallsyms_lookup_name( const char *name, int name_sz, int flags, u64 *res )
>> instead of
>>   * long bpf_kallsyms_lookup_name(const char *name, int name_sz, int flags, u64 *res)
>> (notice the extra space at the start and end of function arguments)
>> then that helper is not dumped in the auto-generated header and results in
>> an invalid call during eBPF runtime, even if all the code specific to the
>> helper is correct.
>>
>> This patch checks the number of functions documented within the header file
>> with those present as part of #define __BPF_FUNC_MAPPER and generates a
>> warning in the header file if they don't match. It is not needed with the
> 
> Shall we fail instead of warning?
> 

I am ok with either warning or error. The only thing with error is that 
it will cause the eBPF program to fail compilation even if its not using 
the helper with missing/misformatted doc, which i thought might be a bit 
extreme as the eBPF program will work if it doesnt use it.
If error is recommended approach i can send v4 with #error replacing 
#warning.

>> currently documented upstream functions, but can help in debugging
>> when developing new helpers when there might be missing or misformatted
>> documentation.
>>
>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>>
>> ---
>> v1->v2:
>> - Fix CI error reported by Alexei Starovoitov
>> ---
>>   scripts/bpf_doc.py | 46 ++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 44 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>> index a6403ddf5de7..e426d2a727cb 100755
>> --- a/scripts/bpf_doc.py
>> +++ b/scripts/bpf_doc.py
>> @@ -87,6 +87,8 @@ class HeaderParser(object):
>>           self.line = ''
>>           self.helpers = []
>>           self.commands = []
>> +        self.desc_unique_helpers = set()
>> +        self.define_unique_helpers = []
>>
>>       def parse_element(self):
>>           proto    = self.parse_symbol()
>> @@ -193,19 +195,41 @@ class HeaderParser(object):
>>               except NoSyscallCommandFound:
>>                   break
>>
>> -    def parse_helpers(self):
>> +    def parse_desc_helpers(self):
>>           self.seek_to('* Start of BPF helper function descriptions:',
>>                        'Could not find start of eBPF helper descriptions list')
>>           while True:
>>               try:
>>                   helper = self.parse_helper()
>>                   self.helpers.append(helper)
>> +                proto = helper.proto_break_down()
>> +                if proto['name'] not in self.desc_unique_helpers:
> 
> The "not in" check is unnecessary for set().
> 

Thanks! removed in v3.

>> +                    self.desc_unique_helpers.add(proto['name'])
>>               except NoHelperFound:
>>                   break
>>
>> +    def parse_define_helpers(self):
>> +        # Parse the number of FN(...) in #define __BPF_FUNC_MAPPER to compare
>> +        # later with the number of unique function names present in description
>> +        self.seek_to('#define __BPF_FUNC_MAPPER(FN)',
>> +                     'Could not find start of eBPF helper definition list')
>> +        # Searches for either one or more FN(\w+) defines or a backslash for newline
>> +        p = re.compile('\s*(FN\(\w+\))+|\\\\')
>> +        fn_defines_str = ''
>> +        while True:
>> +            capture = p.match(self.line)
>> +            if capture:
>> +                fn_defines_str += self.line
>> +            else:
>> +                break
>> +            self.line = self.reader.readline()
>> +        # Find the number of occurences of FN(\w+)
>> +        self.define_unique_helpers = re.findall('FN\(\w+\)', fn_defines_str)
> 
> How about we only save nr_define_unique_helpers in self?
> 

self.define_unique_helpers is used to give the first 
missing/misformatted helper to print in "#warning The description for %s 
is not present or formatted correctly" below.

>> +
>>       def run(self):
>>           self.parse_syscall()
>> -        self.parse_helpers()
>> +        self.parse_desc_helpers()
>> +        self.parse_define_helpers()
>>           self.reader.close()
>>
>>   ###############################################################################
>> @@ -509,6 +533,8 @@ class PrinterHelpers(Printer):
>>       """
>>       def __init__(self, parser):
>>           self.elements = parser.helpers
>> +        self.desc_unique_helpers = parser.desc_unique_helpers
>> +        self.define_unique_helpers = parser.define_unique_helpers
>>
>>       type_fwds = [
>>               'struct bpf_fib_lookup',
>> @@ -628,6 +654,22 @@ class PrinterHelpers(Printer):
>>   /* Forward declarations of BPF structs */'''
>>
>>           print(header)
>> +
>> +        nr_desc_unique_helpers = len(self.desc_unique_helpers)
>> +        nr_define_unique_helpers = len(self.define_unique_helpers)
>> +        if nr_desc_unique_helpers != nr_define_unique_helpers:
>> +            header_warning = '''
>> +#warning The number of unique helpers in description (%d) don\'t match the number of unique helpers defined in __BPF_FUNC_MAPPER (%d)
>> +''' % (nr_desc_unique_helpers, nr_define_unique_helpers)
>> +            if nr_desc_unique_helpers < nr_define_unique_helpers:
>> +                # Function description is parsed until no helper is found (which can be due to
>> +                # misformatting). Hence, only print the first missing/misformatted function.
>> +                header_warning += '''
>> +#warning The description for %s is not present or formatted correctly.
>> +''' % (self.define_unique_helpers[nr_desc_unique_helpers])
>> +            print(header_warning)

self.define_unique_helpers is used here for getting the name of the 
first missing/misformatted helper.

>> +
>> +
>>           for fwd in self.type_fwds:
>>               print('%s;' % fwd)
>>           print('')
>> --
>> 2.25.1
>>
