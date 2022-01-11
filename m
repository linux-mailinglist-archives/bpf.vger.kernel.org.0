Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B8A48AFDB
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 15:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbiAKOqz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jan 2022 09:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238965AbiAKOqz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jan 2022 09:46:55 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86DCC06173F
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 06:46:54 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a5so29455578wrh.5
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 06:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KEH2lq/RKSL7Z8e/DJ6ppaDohrwi1U8ylmhTTurOjxI=;
        b=Intz+EhWtwPjyNxjVPJ856G8Sqofor7w4YuFU80smTpKzbniODPqmHfc2o8tVq+Fot
         eYW21FdNpCc67vf+Nla8tVbGXCJgctDnhNXyl9yOPdJeh5j7lMr0IcjLBf2dkC6vNGl1
         huM0ePTO4lZVSACbGWVzA+df6Z8czzkmUmSJ9t/sJvJbLc0Mtd0GGM68ZZACn4whQE5f
         +jVpZP7JGMk1ReKb6vKJJcxAlrvh7LvP3vTHmN3eMw+mWCQ6ixtgPhS3fmkbY6IyK473
         V7qXPflSjVshtVDSgsZFAbEN36vw9g4sYgsHPbWCNvPAaW8D9ycm6XM6aYu4DxtR7AQv
         9Scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KEH2lq/RKSL7Z8e/DJ6ppaDohrwi1U8ylmhTTurOjxI=;
        b=YDPFS3GxMqZU2EuBn+enKGRksjCg3vXSrYioMHyA8djdGlkzqDHz4M5E1xSrcb5aY7
         QESjB9LTZ3NdyXp3/N38lZMSeDxBc63VIisnRslJmGZ9HtIqW6DqRbIO1Yh9HUG4AyVH
         kSZuwxqWH/u8Jq7fQvgYJCcUERWLeAXIc65LqXPuhl//7rf6wxvcoY5etDAHrN4eVo1A
         WQ14F2Djt0u9CjtpsLyuwibuHZVkwKJGdCUAh2cq++4M8mUjGCLql2l4Zb+3AXI68NDQ
         6mOvRUKrT4Hi/WBx3yYsc21oysP+Z9hcoDJEpXbT+5PklQWyStMRyMqpTHXH+iToQn2/
         wOXQ==
X-Gm-Message-State: AOAM532/2JiEqTZDQVQkyXcUdZatfi6gH8hIPXMIlUpIA7oQXyonb83u
        tq97oiARal+NsK03sEzRkqAiKw==
X-Google-Smtp-Source: ABdhPJzCVqNLcPZzg/y/+Jh2CPsr3EREXnLLXYPklPGAEVM6lUTeMBPTfuy+g0C+O8fOGUwrGTvHGw==
X-Received: by 2002:a5d:4889:: with SMTP id g9mr4027435wrq.574.1641912413512;
        Tue, 11 Jan 2022 06:46:53 -0800 (PST)
Received: from ?IPv6:2a02:6b6d:f804:0:3b22:c269:f398:55da? ([2a02:6b6d:f804:0:3b22:c269:f398:55da])
        by smtp.gmail.com with ESMTPSA id h4sm9570824wrf.93.2022.01.11.06.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 06:46:53 -0800 (PST)
Subject: Re: [External] Re: [PATCH v3] bpf/scripts: add warning if the correct
 number of helpers are not auto-generated
To:     Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, joe@cilium.io,
        fam.zheng@bytedance.com, cong.wang@bytedance.com,
        alexei.starovoitov@gmail.com, song@kernel.org
References: <20220111110842.4071569-1-usama.arif@bytedance.com>
 <48eb7af7-86d6-6ce5-02d3-134393e87fcb@isovalent.com>
From:   Usama Arif <usama.arif@bytedance.com>
Message-ID: <4467c5b8-9cbe-331f-e4ef-0dc0059cc8f1@bytedance.com>
Date:   Tue, 11 Jan 2022 14:46:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <48eb7af7-86d6-6ce5-02d3-134393e87fcb@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/01/2022 11:35, Quentin Monnet wrote:
> 2022-01-11 11:08 UTC+0000 ~ Usama Arif <usama.arif@bytedance.com>
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
>> currently documented upstream functions, but can help in debugging
>> when developing new helpers when there might be missing or misformatted
>> documentation.
>>
>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>>
>> ---
>> v2->v3:
>> - Removed check if value is already in set (suggested by Song Liu)
>>
>> v1->v2:
>> - Fix CI error reported by Alexei Starovoitov
>> ---
>>   scripts/bpf_doc.py | 45 +++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 43 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>> index a6403ddf5de7..8d96f08ea7a6 100755
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
>> @@ -193,19 +195,40 @@ class HeaderParser(object):
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
>> +                self.desc_unique_helpers.add(proto['name'])
>>               except NoHelperFound:
>>                   break
>>   
>> +    def parse_define_helpers(self):
>> +        # Parse the number of FN(...) in #define __BPF_FUNC_MAPPER to compare
>> +        # later with the number of unique function names present in description
>> +        self.seek_to('#define __BPF_FUNC_MAPPER(FN)',
>> +                     'Could not find start of eBPF helper definition list')
> 
> Hi, and thanks!
> It might be worth a comment above the "seek_to()" to mention that
> "FN(unspec)" is skipped here due to seek_to() discarding the first line
> below the target (here, the first line below "#define
> __BPF_FUNC_MAPPER(FN)").

Thanks! added to v4.
> 
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
>> +
>>       def run(self):
>>           self.parse_syscall()
>> -        self.parse_helpers()
>> +        self.parse_desc_helpers()
>> +        self.parse_define_helpers()
>>           self.reader.close()
>>   
>>   ###############################################################################
>> @@ -509,6 +532,8 @@ class PrinterHelpers(Printer):
>>       """
>>       def __init__(self, parser):
>>           self.elements = parser.helpers
>> +        self.desc_unique_helpers = parser.desc_unique_helpers
>> +        self.define_unique_helpers = parser.define_unique_helpers
>>   
>>       type_fwds = [
>>               'struct bpf_fib_lookup',
>> @@ -628,6 +653,22 @@ class PrinterHelpers(Printer):
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
>> +
>> +
> 
> We should probably have the same error/warning when generating the man
> page for the helpers (print_header() in class PrinterHelpersRST)?
>
Thanks! added to v4.

>>           for fwd in self.type_fwds:
>>               print('%s;' % fwd)
>>           print('')
> 
> Thanks,
> Quentin
> 
