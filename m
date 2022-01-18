Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B16D492C23
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 18:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiARRTD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 12:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243781AbiARRTD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Jan 2022 12:19:03 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD77C061574
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 09:19:02 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id e9-20020a05600c4e4900b0034d23cae3f0so7090023wmq.2
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 09:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w8nI0OX7xv4yU7lgRE0A12C0f0Gm6jLPcAsClASjQQo=;
        b=TJ8jePIG3KXuZHGod+epdFaCHMwLqyXAokowGyDf4oW00uMcbVZj9QpHI+SmF3gOKc
         hS1Ii2JCaE04Z+RQFunA2VzH6vizwl2KRrrAIvCHcOSp18ZfLDACgDQta7bRhahEttLp
         dhE0TZu+QACtQ/zdoi9Y78QOvEWRv+pEM/RP+A09S7PY2XzFTju7ZX8Jh+O9T1UWrMcT
         jjWQ0xNkTaBO2g45mPYdVwDj2KIO/kW+gxg6wc6NHNiF2gRZSdVsBSfDOf61imu/qZk7
         wRKUt4pBYW4UMp7004Vnc5QVuaKOT0y4m7XjkGWWqaE5Z0cxMfPqAo2L8brGEBkxbW6c
         wzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w8nI0OX7xv4yU7lgRE0A12C0f0Gm6jLPcAsClASjQQo=;
        b=RSFUKUrQuch9dYnA17ZhnFdgsvUGtE+spjGE8Kmaa1O7sw27w16w23uWKksmigtBO5
         1ILpFjExnmeiI7jWG2IiZhmEfQw1BmeRVkv8ue3/9wk7oyP9beIMDam86tgLE7Ol/T2l
         /GKEdXr8gaRo+qb4KmQcAeYIIeH/C5zHb019WU6aR55BKTsoLg0yMkXRW2hUWefRV4Gn
         FwfAwx/Ow+o/vEJJ4qTspwFn2gBKamHL4Ba8Cb7Tofs5z47CcTfOelCWtRd21Snkh97m
         hjBp1gShO79TEpm9Bq3gz/TpaDEIQdZwCONbCMq/eQ7ASrgmrEHHpKKis0Sv6GkTNfcY
         B18Q==
X-Gm-Message-State: AOAM5300gZdD792GKOqrkawBM51JwRDN9MIFiKdqLqbDqLrFNKNPrMov
        XpujhgJkwnKeyCDVg7JBUTBymA==
X-Google-Smtp-Source: ABdhPJx7JP0wZpFFolo/KKNkwcgKBuGwwJe+9qFP1RYay5VInCCJ3nZq53IJ5T8+kXR6IPoPRjnS7g==
X-Received: by 2002:a1c:ed01:: with SMTP id l1mr33717716wmh.185.1642526341113;
        Tue, 18 Jan 2022 09:19:01 -0800 (PST)
Received: from ?IPv6:2a02:6b6d:f804:0:d40a:ebf3:7c3b:c5af? ([2a02:6b6d:f804:0:d40a:ebf3:7c3b:c5af])
        by smtp.gmail.com with ESMTPSA id e4sm8500482wrq.63.2022.01.18.09.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 09:19:00 -0800 (PST)
Subject: Re: [External] Re: [PATCH bpf-next 2/2] bpf/scripts: Raise an
 exception if the correct number of sycalls are not generated
To:     Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, fam.zheng@bytedance.com,
        cong.wang@bytedance.com, song@kernel.org, andrii.nakryiko@gmail.com
References: <20220118115620.849425-1-usama.arif@bytedance.com>
 <20220118115620.849425-2-usama.arif@bytedance.com>
 <89eecd2f-ec30-c523-0c23-4c75b22a8beb@isovalent.com>
From:   Usama Arif <usama.arif@bytedance.com>
Message-ID: <5a7239bc-67e9-d381-ef81-24c1215db9f8@bytedance.com>
Date:   Tue, 18 Jan 2022 17:19:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <89eecd2f-ec30-c523-0c23-4c75b22a8beb@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 18/01/2022 16:04, Quentin Monnet wrote:
> 2022-01-18 11:56 UTC+0000 ~ Usama Arif <usama.arif@bytedance.com>
>> Currently the syscalls rst and subsequently man page are auto-generated
>> using function documentation present in bpf.h. If the documentation for the
>> syscall is missing or doesn't follow a specific format, then that syscall
>> is not dumped in the auto-generated rst.
>>
>> This patch checks the number of syscalls documented within the header file
>> with those present as part of the enum bpf_cmd and raises an Exception if
>> they don't match. It is not needed with the currently documented upstream
>> syscalls, but can help in debugging when developing new syscalls when
>> there might be missing or misformatted documentation.
>>
>> The function helper_number_check is moved to the Printer parent
>> class and renamed to elem_number_check as all the most derived children
>> classes are using this function now.
>>
>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> 
> Thanks for the follow-up, looks good and seems to work well. Please find
> just a few nitpicks below.
> 
>> ---
>>   scripts/bpf_doc.py | 88 ++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 61 insertions(+), 27 deletions(-)
>>
>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>> index 20441e5d2..11304427e 100755
>> --- a/scripts/bpf_doc.py
>> +++ b/scripts/bpf_doc.py
>> @@ -89,6 +89,8 @@ class HeaderParser(object):
>>           self.commands = []
>>           self.desc_unique_helpers = set()
>>           self.define_unique_helpers = []
>> +        self.desc_syscalls = []
>> +        self.enum_syscalls = []
>>   
>>       def parse_element(self):
>>           proto    = self.parse_symbol()
>> @@ -103,7 +105,7 @@ class HeaderParser(object):
>>           return Helper(proto=proto, desc=desc, ret=ret)
>>   
>>       def parse_symbol(self):
>> -        p = re.compile(' \* ?(.+)$')
>> +        p = re.compile(' \* ?(BPF\w+)$')
>>           capture = p.match(self.line)
>>           if not capture:
>>               raise NoSyscallCommandFound
>> @@ -181,26 +183,55 @@ class HeaderParser(object):
>>               raise Exception("No return found for " + proto)
>>           return ret
>>   
>> -    def seek_to(self, target, help_message):
>> +    def seek_to(self, target, help_message, discard_lines = 1):
>>           self.reader.seek(0)
>>           offset = self.reader.read().find(target)
>>           if offset == -1:
>>               raise Exception(help_message)
>>           self.reader.seek(offset)
>>           self.reader.readline()
>> -        self.reader.readline()
>> +        for _ in range(discard_lines):
>> +            self.reader.readline()
>>           self.line = self.reader.readline()
>>   
>> -    def parse_syscall(self):
>> +    def parse_desc_syscall(self):
>>           self.seek_to('* DOC: eBPF Syscall Commands',
>>                        'Could not find start of eBPF syscall descriptions list')
>>           while True:
>>               try:
>>                   command = self.parse_element()
>>                   self.commands.append(command)
>> +                self.desc_syscalls.append(command.proto)
>> +
>>               except NoSyscallCommandFound:
>>                   break
>>   
>> +    def parse_enum_syscall(self):
>> +        self.seek_to('enum bpf_cmd {',
>> +                     'Could not find start of bpf_cmd enum', 0)
>> +        # Searches for either one or more BPF\w+ enums
>> +        bpf_p = re.compile('\s*(BPF\w+)+')
>> +        # Searches for an enum entry assigned to another entry,
>> +        # for e.g. BPF_PROG_RUN = BPF_PROG_TEST_RUN, which is
>> +        # not documented hence should be skipped in check to
>> +        # determine if the right number of syscalls are documented
> 
> Sounds good. If you respin, would you mind taking this opportunity to
> add, at the end of BPF_PROG_TEST_RUN's description in
> {tools/,}include/uapi/linux/bpf.h, that BPF_PROG_RUN is an alias to this
> command? It may be useful for users looking for BPF_PROG_RUN in the
> generated man page.

Thanks for the reviews! Added in v2.

> 
>> +        assign_p = re.compile('\s*(BPF\w+)\s*=\s*(BPF\w+)')
>> +        bpf_cmd_str = ''
>> +        while True:
>> +            capture = assign_p.match(self.line)
>> +            if capture:
>> +                # Skip line if an enum entry is assigned to another entry
>> +                self.line = self.reader.readline()
>> +                continue
>> +            capture = bpf_p.match(self.line)
>> +            if capture:
>> +                bpf_cmd_str += self.line
>> +            else:
>> +                break
>> +            self.line = self.reader.readline()
>> +        # Find the number of occurences of BPF\w+
>> +        self.enum_syscalls = re.findall('(BPF\w+)+', bpf_cmd_str)
>> +
>>       def parse_desc_helpers(self):
>>           self.seek_to('* Start of BPF helper function descriptions:',
>>                        'Could not find start of eBPF helper descriptions list')
>> @@ -234,7 +265,8 @@ class HeaderParser(object):
>>           self.define_unique_helpers = re.findall('FN\(\w+\)', fn_defines_str)
>>   
>>       def run(self):
>> -        self.parse_syscall()
>> +        self.parse_desc_syscall()
>> +        self.parse_enum_syscall()
>>           self.parse_desc_helpers()
>>           self.parse_define_helpers()
>>           self.reader.close()
>> @@ -266,6 +298,27 @@ class Printer(object):
>>               self.print_one(elem)
>>           self.print_footer()
>>   
>> +    def elem_number_check(self, desc_unique_elem, define_unique_elem, type, instance):
>> +        """
>> +        Checks the number of helpers/syscalls documented within the header file
>> +        description with those defined as part of enum/macro and raise an
>> +        Exception if they don't match.
>> +        """
>> +        nr_desc_unique_elem = len(desc_unique_elem)
>> +        nr_define_unique_elem = len(define_unique_elem)
>> +        if nr_desc_unique_elem != nr_define_unique_elem:
>> +            exception_msg = '''
>> +    The number of unique %s in description (%d) doesn\'t match the number of unique %s defined in %s (%d)
>> +    ''' % (type, nr_desc_unique_elem, type, instance, nr_define_unique_elem)
> 
> Nit: I think you didn't mean to indent the two lines above?

Thanks, removed indent here and below in v2.
> 
>> +            if nr_desc_unique_elem < nr_define_unique_elem:
>> +                # Function description is parsed until no helper is found (which can be due to
>> +                # misformatting). Hence, only print the first missing/misformatted helper/enum.
>> +                exception_msg += '''
>> +    The description for %s is not present or formatted correctly.
>> +    ''' % (define_unique_elem[nr_desc_unique_elem])
> 
> Same thing for the indent
> 
>> +            print(define_unique_elem)
>> +            print(desc_unique_elem)
> 
> These two objects should accompany the error message from the Exception.
> Did you consider adding them to exception_msg? If not convenient, should
> we at least send them to stderr instead of stdout?
> 

They were debug prints that i was using while writing the patch. I 
should have removed them before sending to the mailing list! Removed in 
v2, Thanks!

>> +            raise Exception(exception_msg)
