Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB6048C228
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 11:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbiALKTa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 05:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239249AbiALKT2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 05:19:28 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF607C06173F
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 02:19:27 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q8so3220645wra.12
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 02:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AyoiwP7+x5FDk7LxIk1wfHtrbe4diIweVNAvYqujS6o=;
        b=qvb9Vm7fIVxry4JudG3Aum3FoEk5MMnVVCBLbBQF7VpM7It/Ley42oIpoVxPCHBkhJ
         CuBAAwKMXpojbQSHBU0ikxHKpbRylzYydQeQhjz7RD0m1TsnUq8xs+lJ7uh+34xdiujJ
         zQnBssOm4PfE/BfTmInSSPcgFc8lO67TdDBqSBoTn6TUXqcTtVFGfFx4+zBI4QVv2niy
         fSbykvViGSpEG3U/hkI3OfxGWyMrNCdtOAYnNS+0f+1p0nvJ/v+LsoxH7J2BxdecGDt8
         /CWePVHETjHPsNObUbm8C8S2GYtYp5jiy3XxfIjfSMrwVvUE3GZjHeHgw4WTKVY9AgWk
         kbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AyoiwP7+x5FDk7LxIk1wfHtrbe4diIweVNAvYqujS6o=;
        b=fYiaaEFtqFqKT87acb27EZUt794m3PvZ6vJKoWNmLE6KlHteJqfEWFysS9RFDStJXk
         y977szOVW5Ch4IvlETVkQBXs1j78up0CHy2Q+B5eHQzVJklQYKLKbC+D5QrMQnUnf607
         SUvjd+JOnYzDcnN8MY6GJs0msVGeCSkRcJC5AJeTaf8oLiQ/Hc8TjpSCQTmKcMnMaTS6
         BBTGhmszM+UG9n2yF2huwFMYCfU8hffiRtV3EcMr8SgOUQIVeYuQ7wy545dXu7qB2Mvu
         MRvXKp/fszdpLqNruP3e/rjAYq5VGoxYvGJ2OsKQCFMGTec64uNfleYFSKj6c33xwP5v
         aQfw==
X-Gm-Message-State: AOAM5331Ty6hagN69yym7TctVTXIhsOyXdJE9/hcrvMmydBuExMpbX5l
        4Zu+/fnE+MSGLJdslIsWR0Zl/w==
X-Google-Smtp-Source: ABdhPJyW//fZWSmKpeMD2qSGbytKR5aWArrlYU3TnI17eQpr7TZNq1erkLtOwKuBwaMBj0xRzN4YnQ==
X-Received: by 2002:a5d:644a:: with SMTP id d10mr7536644wrw.355.1641982766344;
        Wed, 12 Jan 2022 02:19:26 -0800 (PST)
Received: from ?IPv6:2a02:6b6d:f804:0:1381:d05e:375f:8daf? ([2a02:6b6d:f804:0:1381:d05e:375f:8daf])
        by smtp.gmail.com with ESMTPSA id m1sm1192370wrp.81.2022.01.12.02.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 02:19:26 -0800 (PST)
Subject: Re: [External] Re: [PATCH v5] bpf/scripts: add an error if the
 correct number of helpers are not generated
To:     Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, joe@cilium.io,
        fam.zheng@bytedance.com, cong.wang@bytedance.com,
        alexei.starovoitov@gmail.com, song@kernel.org
References: <20220111184418.196442-1-usama.arif@bytedance.com>
 <e5ad3ed1-3d4e-f4cc-6eb9-073c0cca11d4@isovalent.com>
From:   Usama Arif <usama.arif@bytedance.com>
Message-ID: <e3d4673b-08be-09fd-0a87-b679713146b5@bytedance.com>
Date:   Wed, 12 Jan 2022 10:19:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e5ad3ed1-3d4e-f4cc-6eb9-073c0cca11d4@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/01/2022 10:01, Quentin Monnet wrote:
> 2022-01-11 18:44 UTC+0000 ~ Usama Arif <usama.arif@bytedance.com>
>> Currently bpf_helper_defs.h and the bpf helpers man page are auto-generated
>> using function documentation present in bpf.h. If the documentation for the
>> helper is missing or doesn't follow a specific format for e.g. if a function
>> is documented as:
>>   * long bpf_kallsyms_lookup_name( const char *name, int name_sz, int flags, u64 *res )
>> instead of
>>   * long bpf_kallsyms_lookup_name(const char *name, int name_sz, int flags, u64 *res)
>> (notice the extra space at the start and end of function arguments)
>> then that helper is not dumped in the auto-generated header and results in
>> an invalid call during eBPF runtime, even if all the code specific to the
>> helper is correct.
>>
>> This patch checks the number of functions documented within the header file
>> with those present as part of #define __BPF_FUNC_MAPPER and generates an
>> error in the header file and the man page if they don't match. It is not
>> needed with the currently documented upstream functions, but can help in
>> debugging when developing new helpers when there might be missing or
>> misformatted documentation.
>>
>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>>
>> ---
>> v4->v5:
>> - Converted warning to error incase of missing/misformatted helper doc
>>    (suggested by Song Liu)
> 
> I don't think it was converted to an error in the sense that Song meant
> it? Unless I'm missing something you simply changed the message so that
> it prints "error" instead of "warning", but the script still goes on
> without returning any error code, and a failure won't be detected by the
> CI for example.
> 
> Could you make the script break out on errors, and print a message to
> stderr so that it's visible even if the generated output is redirected
> to a file, please?
> 

It does now print an error to stdout while building an eBPF application. 
For e.g. if you introduce a space in the doc as in the commit message like:

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ba5af15e25f5..5bf80dbb820b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4908,7 +4908,7 @@ union bpf_attr {
   *
   *             **-ENOENT** if architecture does not support branch 
records.
   *
- * long bpf_trace_vprintk(const char *fmt, u32 fmt_size, const void 
*data, u32 data_len)
+ * long bpf_trace_vprintk( const char *fmt, u32 fmt_size, const void 
*data, u32 data_len)
   *     Description
   *             Behaves like **bpf_trace_printk**\ () helper, but takes 
an array of u64
   *             to format and can handle more format args as a result.
@@ -4938,6 +4938,12 @@ union bpf_attr {
   *             **-ENOENT** if symbol is not found.
   *
   *             **-EPERM** if caller does not have permission to obtain 
kernel address.

and build samples/bpf:

make  LLVM_STRIP=llvm-strip-13 M=samples/bpf > /tmp/samplesbuild.out

you get the following at stderr returning an error code

make[2]: *** [Makefile:186: 
/data/usaari01/ebpf/linux/samples/bpf/bpftool/pid_iter.bpf.o] Error 1
make[2]: *** Waiting for unfinished jobs....
In file included from skeleton/profiler.bpf.c:4:
In file included from 
/data/usaari01/ebpf/linux/samples/bpf/bpftool//bootstrap/libbpf//include/bpf/bpf_helpers.h:11:
/data/usaari01/ebpf/linux/samples/bpf/bpftool//bootstrap/libbpf//include/bpf/bpf_helper_defs.h:5:2: 
error: The number of unique helpers in description (176) don't match the 
number of unique helpers defined in __BPF_FUNC_MAPPER (180)
#error The number of unique helpers in description (176) don't match the 
number of unique helpers defined in __BPF_FUNC_MAPPER (180)
  ^
/data/usaari01/ebpf/linux/samples/bpf/bpftool//bootstrap/libbpf//include/bpf/bpf_helper_defs.h:7:2: 
error: The description for FN(trace_vprintk) is not present or formatted 
correctly.
#error The description for FN(trace_vprintk) is not present or formatted 
correctly.
  ^

But i am guessing that you want an error while the script is run as well?
If we do this:
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index adf08fa963a4..4ce982ce58f2 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -397,6 +397,7 @@ HELPERS
      The description for %s is not present or formatted correctly.
  ''' % (self.define_unique_helpers[nr_desc_unique_helpers])
              print(header_error)
+            print(header_error, file = sys.stderr)

          print(header_description)

@@ -693,6 +694,7 @@ class PrinterHelpers(Printer):
  #error The description for %s is not present or formatted correctly.
  ''' % (self.define_unique_helpers[nr_desc_unique_helpers])
              print(header_error)
+            print(header_error, file = sys.stderr)

          for fwd in self.type_fwds:
              print('%s;' % fwd)

then an error will be printed while the script is run and also later 
while the eBPF application is compiled. I can send this in next version 
if thats the preference?

>>
>> v3->v4:
>> - Added comments to make code clearer
>> - Added warning to man page as well (suggested by Quentin Monnet)
>>
>> v2->v3:
>> - Removed check if value is already in set (suggested by Song Liu)
>>
>> v1->v2:
>> - Fix CI error reported by Alexei Starovoitov
>> ---
>>   scripts/bpf_doc.py | 74 +++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 70 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>> index a6403ddf5de7..adf08fa963a4 100755
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
>> @@ -193,19 +195,42 @@ class HeaderParser(object):
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
>> +        # later with the number of unique function names present in description.
>> +        # Note: seek_to(..) discards the first line below the target search text,
>> +        # resulting in FN(unspec) being skipped and not added to self.define_unique_helpers.
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
>> +
>>       def run(self):
>>           self.parse_syscall()
>> -        self.parse_helpers()
>> +        self.parse_desc_helpers()
>> +        self.parse_define_helpers()
>>           self.reader.close()
>>   
>>   ###############################################################################
>> @@ -305,9 +330,11 @@ class PrinterHelpersRST(PrinterRST):
>>       """
>>       def __init__(self, parser):
>>           self.elements = parser.helpers
>> +        self.desc_unique_helpers = parser.desc_unique_helpers
>> +        self.define_unique_helpers = parser.define_unique_helpers
>>   
>>       def print_header(self):
>> -        header = '''\
>> +        header_name = '''\
>>   ===========
>>   BPF-HELPERS
>>   ===========
>> @@ -317,6 +344,8 @@ list of eBPF helper functions
>>   
>>   :Manual section: 7
>>   
>> +'''
>> +        header_description = '''
>>   DESCRIPTION
>>   ===========
>>   
>> @@ -349,7 +378,27 @@ HELPERS
>>   =======
>>   '''
>>           PrinterRST.print_license(self)
>> -        print(header)
>> +
>> +        print(header_name)
>> +
>> +        # Add an error if the correct number of helpers are not auto-generated.
>> +        nr_desc_unique_helpers = len(self.desc_unique_helpers)
>> +        nr_define_unique_helpers = len(self.define_unique_helpers)
>> +        if nr_desc_unique_helpers != nr_define_unique_helpers:
>> +            header_error = '''
>> +.. error::
>> +    The number of unique helpers in description (%d) don\'t match the number of unique helpers defined in __BPF_FUNC_MAPPER (%d)
> 
> don\'t -> doesn\'t
> 
>> +''' % (nr_desc_unique_helpers, nr_define_unique_helpers)
>> +            if nr_desc_unique_helpers < nr_define_unique_helpers:
>> +                # Function description is parsed until no helper is found (which can be due to
>> +                # misformatting). Hence, only print the first missing/misformatted function.
>> +                header_error += '''
>> +.. error::
>> +    The description for %s is not present or formatted correctly.
>> +''' % (self.define_unique_helpers[nr_desc_unique_helpers])
>> +            print(header_error)
>> +
>> +        print(header_description)
>>   
>>       def print_footer(self):
>>           footer = '''
>> @@ -509,6 +558,8 @@ class PrinterHelpers(Printer):
>>       """
>>       def __init__(self, parser):
>>           self.elements = parser.helpers
>> +        self.desc_unique_helpers = parser.desc_unique_helpers
>> +        self.define_unique_helpers = parser.define_unique_helpers
>>   
>>       type_fwds = [
>>               'struct bpf_fib_lookup',
>> @@ -628,6 +679,21 @@ class PrinterHelpers(Printer):
>>   /* Forward declarations of BPF structs */'''
>>   
>>           print(header)
>> +
>> +        nr_desc_unique_helpers = len(self.desc_unique_helpers)
>> +        nr_define_unique_helpers = len(self.define_unique_helpers)
>> +        if nr_desc_unique_helpers != nr_define_unique_helpers:
>> +            header_error = '''
>> +#error The number of unique helpers in description (%d) don\'t match the number of unique helpers defined in __BPF_FUNC_MAPPER (%d)
>> +''' % (nr_desc_unique_helpers, nr_define_unique_helpers)
>> +            if nr_desc_unique_helpers < nr_define_unique_helpers:
>> +                # Function description is parsed until no helper is found (which can be due to
>> +                # misformatting). Hence, only print the first missing/misformatted function.
>> +                header_error += '''
>> +#error The description for %s is not present or formatted correctly.
>> +''' % (self.define_unique_helpers[nr_desc_unique_helpers])
>> +            print(header_error)
>> +
>>           for fwd in self.type_fwds:
>>               print('%s;' % fwd)
>>           print('')
> 
