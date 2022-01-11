Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79CC48AC93
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 12:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbiAKLgB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jan 2022 06:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbiAKLgB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jan 2022 06:36:01 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B55FC06173F
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 03:36:01 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u21so43358566edd.5
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 03:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AyPJWPDXTaNcb82be5DIbATHvNPY9tLFiDADEizbFnM=;
        b=RRgCau/DZONFCzkZ06B68In1/Lb7/67jmTZrmsvqcfYvTqhBC9fxbeoS8UeLJQ0Wuc
         rXZxKJORNB44V3wGtxZqQYLbthKcB4L4kJ1IIvMslMQOBJ+aZDOn+lONu8oBd4y5rVI4
         4YaU7bHFj6isjbyIyfbXCXXxdGV+aGP0tv75cVBgduZ6w+YK7Di9LjH3ifsT+B52Dw8T
         WSZDRZb/D3YrrkJhHXtfBaGPC/gCJpcGEvTRsZGyqmOaxLTGKTfBsLhFrCI6TMS+Uo9k
         lOHjw2iqgpwHsR20m5DAKpuXywdYQM0cs+t7VjdOEpCmPSxv8ddp6MaKU3JT82YXF0hZ
         GJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AyPJWPDXTaNcb82be5DIbATHvNPY9tLFiDADEizbFnM=;
        b=esPrCflzziV2Z422MyI2jCULvA7qXv4pnj5uNJxEO+M1zlyw3Rh64m6DZFeorU7YXR
         1t5OZUNUGzyaCLTsTg58U2EmNf+YDx2pn7wL8jGGFHKygAxBilr/WaDEzlqa0HHDULqT
         aebOzMltAawg1gNZiXbRBowOrPITsjO41pT+8tF6Knr2/gIXpXJyt6fNdla4xMtLQCcY
         Rd4o+TZAkseAqD8fXg5V8PUTqVtY1L3ymj/SEa+iWP0cgyB5st+IETOEeW0tzAYTVb6t
         D/+94vpcO12ae9MX2rrpPNY5nd+8TQA/o/n6GAfYe51uw4dgOz9OE9DNCN0TnX7MaEBI
         +OFg==
X-Gm-Message-State: AOAM5301nto2opqAOZravx999AqPFvyAx1ZsXOZ5iA3lrtTVt+pHK9bM
        UieGnc+t5R5Z+8NfiV3RAeBIdQ==
X-Google-Smtp-Source: ABdhPJwo1kvWDVGc/6XvO2Obne+2lnIFHWmprLTg1YEY7TWWhoBethZWOH3NZXaKTpIZ3U1/KgP0/w==
X-Received: by 2002:a05:6402:349:: with SMTP id r9mr3818276edw.204.1641900959640;
        Tue, 11 Jan 2022 03:35:59 -0800 (PST)
Received: from [192.168.1.8] ([149.86.64.198])
        by smtp.gmail.com with ESMTPSA id ky5sm3449349ejc.204.2022.01.11.03.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 03:35:59 -0800 (PST)
Message-ID: <48eb7af7-86d6-6ce5-02d3-134393e87fcb@isovalent.com>
Date:   Tue, 11 Jan 2022 11:35:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3] bpf/scripts: add warning if the correct number of
 helpers are not auto-generated
Content-Language: en-GB
To:     Usama Arif <usama.arif@bytedance.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, joe@cilium.io,
        fam.zheng@bytedance.com, cong.wang@bytedance.com,
        alexei.starovoitov@gmail.com, song@kernel.org
References: <20220111110842.4071569-1-usama.arif@bytedance.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220111110842.4071569-1-usama.arif@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-01-11 11:08 UTC+0000 ~ Usama Arif <usama.arif@bytedance.com>
> Currently bpf_helper_defs.h is auto-generated using function documentation
> present in bpf.h. If the documentation for the helper is missing
> or doesn't follow a specific format for e.g. if a function is documented
> as:
>  * long bpf_kallsyms_lookup_name( const char *name, int name_sz, int flags, u64 *res )
> instead of
>  * long bpf_kallsyms_lookup_name(const char *name, int name_sz, int flags, u64 *res)
> (notice the extra space at the start and end of function arguments)
> then that helper is not dumped in the auto-generated header and results in
> an invalid call during eBPF runtime, even if all the code specific to the
> helper is correct.
> 
> This patch checks the number of functions documented within the header file
> with those present as part of #define __BPF_FUNC_MAPPER and generates a
> warning in the header file if they don't match. It is not needed with the
> currently documented upstream functions, but can help in debugging
> when developing new helpers when there might be missing or misformatted
> documentation.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> 
> ---
> v2->v3:
> - Removed check if value is already in set (suggested by Song Liu)
> 
> v1->v2:
> - Fix CI error reported by Alexei Starovoitov
> ---
>  scripts/bpf_doc.py | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index a6403ddf5de7..8d96f08ea7a6 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -87,6 +87,8 @@ class HeaderParser(object):
>          self.line = ''
>          self.helpers = []
>          self.commands = []
> +        self.desc_unique_helpers = set()
> +        self.define_unique_helpers = []
>  
>      def parse_element(self):
>          proto    = self.parse_symbol()
> @@ -193,19 +195,40 @@ class HeaderParser(object):
>              except NoSyscallCommandFound:
>                  break
>  
> -    def parse_helpers(self):
> +    def parse_desc_helpers(self):
>          self.seek_to('* Start of BPF helper function descriptions:',
>                       'Could not find start of eBPF helper descriptions list')
>          while True:
>              try:
>                  helper = self.parse_helper()
>                  self.helpers.append(helper)
> +                proto = helper.proto_break_down()
> +                self.desc_unique_helpers.add(proto['name'])
>              except NoHelperFound:
>                  break
>  
> +    def parse_define_helpers(self):
> +        # Parse the number of FN(...) in #define __BPF_FUNC_MAPPER to compare
> +        # later with the number of unique function names present in description
> +        self.seek_to('#define __BPF_FUNC_MAPPER(FN)',
> +                     'Could not find start of eBPF helper definition list')

Hi, and thanks!
It might be worth a comment above the "seek_to()" to mention that
"FN(unspec)" is skipped here due to seek_to() discarding the first line
below the target (here, the first line below "#define
__BPF_FUNC_MAPPER(FN)").

> +        # Searches for either one or more FN(\w+) defines or a backslash for newline
> +        p = re.compile('\s*(FN\(\w+\))+|\\\\')
> +        fn_defines_str = ''
> +        while True:
> +            capture = p.match(self.line)
> +            if capture:
> +                fn_defines_str += self.line
> +            else:
> +                break
> +            self.line = self.reader.readline()
> +        # Find the number of occurences of FN(\w+)
> +        self.define_unique_helpers = re.findall('FN\(\w+\)', fn_defines_str)
> +
>      def run(self):
>          self.parse_syscall()
> -        self.parse_helpers()
> +        self.parse_desc_helpers()
> +        self.parse_define_helpers()
>          self.reader.close()
>  
>  ###############################################################################
> @@ -509,6 +532,8 @@ class PrinterHelpers(Printer):
>      """
>      def __init__(self, parser):
>          self.elements = parser.helpers
> +        self.desc_unique_helpers = parser.desc_unique_helpers
> +        self.define_unique_helpers = parser.define_unique_helpers
>  
>      type_fwds = [
>              'struct bpf_fib_lookup',
> @@ -628,6 +653,22 @@ class PrinterHelpers(Printer):
>  /* Forward declarations of BPF structs */'''
>  
>          print(header)
> +
> +        nr_desc_unique_helpers = len(self.desc_unique_helpers)
> +        nr_define_unique_helpers = len(self.define_unique_helpers)
> +        if nr_desc_unique_helpers != nr_define_unique_helpers:
> +            header_warning = '''
> +#warning The number of unique helpers in description (%d) don\'t match the number of unique helpers defined in __BPF_FUNC_MAPPER (%d)
> +''' % (nr_desc_unique_helpers, nr_define_unique_helpers)
> +            if nr_desc_unique_helpers < nr_define_unique_helpers:
> +                # Function description is parsed until no helper is found (which can be due to
> +                # misformatting). Hence, only print the first missing/misformatted function.
> +                header_warning += '''
> +#warning The description for %s is not present or formatted correctly.
> +''' % (self.define_unique_helpers[nr_desc_unique_helpers])
> +            print(header_warning)
> +
> +

We should probably have the same error/warning when generating the man
page for the helpers (print_header() in class PrinterHelpersRST)?

>          for fwd in self.type_fwds:
>              print('%s;' % fwd)
>          print('')

Thanks,
Quentin
