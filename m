Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F164848C1DF
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 11:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352367AbiALKBf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 05:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239371AbiALKBG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 05:01:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9DAC061748
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 02:01:05 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d19so3284267wrb.0
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 02:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m0duNmEDi9QruU4ZoxBug508vCw5m/al6Jv5Uvf3yxs=;
        b=ntiCFpiaiuRt+EfiKKvjSWSj1vMHi/irsGMZDT92QgAYmAXUCRdRtXurk71wmxeyg4
         iOSbrw/5ocyOpUMu7WANqS/7mJy9BX2yySqeAU57LRV+UeDd56r4+ccWLapE58rknN9R
         iH4cGd5XULcmSwVGfyNGN8xElG7jBw5uRhiRhDvaSHz+qBZaogxraFPpJLcAMS171ngY
         8enAnd1EJKZZulOZK5sLVtuzwtq6wqeoHMO4upimDc6W65qwc30FCsUxTrjh69I4BCit
         pOwKZvGin7ZoqRzV7YIs2S4QzVyfkIQQ/2ZBc5wDzQHIpFYu6X7xle1nshCcjbmWpydM
         r9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m0duNmEDi9QruU4ZoxBug508vCw5m/al6Jv5Uvf3yxs=;
        b=SQifGeuY+27MKJe7+alY+qS5FEN+fmI7iggX9HclLBU3fzuqNrzlc9/7PwmzRuqstk
         gNxqAvtcAJEXz9nGOkdlqhjJpKEr90qaspG7RiprRud5b6IsRpIcAXh9evQ7sngowMcp
         BSqqx41P7nfS9odnWNBIcOObpT6X+jFPjU+sm0btfawl7y0ZloWmy3KUdu2pL8hTorCx
         gXZVX7VRCPWpltYBEFlaIcwi5cok/MkreyRSCpCtZyVFP7YAoEzaaB3frMBTwBpplP0R
         Lf/2Yf24e+0LiBO0kd6frKhpZLsj9evZYLkk//UwacJh2BftZ+15rKEWRuFuW6OHMU2Z
         Swdg==
X-Gm-Message-State: AOAM532xU6IMZk9hnEyZoNdskP2BmRbaOgnJ7xkZsdvfWFTQAVuoWoxg
        Vm8HTfhhEjhDWIGeWb4HtWTiL/S81hSnIw==
X-Google-Smtp-Source: ABdhPJzWzWwG/zhwukvO4/fHlcg/wUHdHaU3jI/nznJjYzQclW7jz5/ce9Elpnl+zD2c9+WfHGZgXw==
X-Received: by 2002:a05:6000:1b89:: with SMTP id r9mr1791790wru.21.1641981664035;
        Wed, 12 Jan 2022 02:01:04 -0800 (PST)
Received: from [192.168.1.8] ([149.86.79.168])
        by smtp.gmail.com with ESMTPSA id w7sm5991420wrv.96.2022.01.12.02.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 02:01:03 -0800 (PST)
Message-ID: <e5ad3ed1-3d4e-f4cc-6eb9-073c0cca11d4@isovalent.com>
Date:   Wed, 12 Jan 2022 10:01:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v5] bpf/scripts: add an error if the correct number of
 helpers are not generated
Content-Language: en-GB
To:     Usama Arif <usama.arif@bytedance.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, joe@cilium.io,
        fam.zheng@bytedance.com, cong.wang@bytedance.com,
        alexei.starovoitov@gmail.com, song@kernel.org
References: <20220111184418.196442-1-usama.arif@bytedance.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220111184418.196442-1-usama.arif@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-01-11 18:44 UTC+0000 ~ Usama Arif <usama.arif@bytedance.com>
> Currently bpf_helper_defs.h and the bpf helpers man page are auto-generated
> using function documentation present in bpf.h. If the documentation for the
> helper is missing or doesn't follow a specific format for e.g. if a function
> is documented as:
>  * long bpf_kallsyms_lookup_name( const char *name, int name_sz, int flags, u64 *res )
> instead of
>  * long bpf_kallsyms_lookup_name(const char *name, int name_sz, int flags, u64 *res)
> (notice the extra space at the start and end of function arguments)
> then that helper is not dumped in the auto-generated header and results in
> an invalid call during eBPF runtime, even if all the code specific to the
> helper is correct.
> 
> This patch checks the number of functions documented within the header file
> with those present as part of #define __BPF_FUNC_MAPPER and generates an
> error in the header file and the man page if they don't match. It is not
> needed with the currently documented upstream functions, but can help in
> debugging when developing new helpers when there might be missing or
> misformatted documentation.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> 
> ---
> v4->v5:
> - Converted warning to error incase of missing/misformatted helper doc
>   (suggested by Song Liu)

I don't think it was converted to an error in the sense that Song meant
it? Unless I'm missing something you simply changed the message so that
it prints "error" instead of "warning", but the script still goes on
without returning any error code, and a failure won't be detected by the
CI for example.

Could you make the script break out on errors, and print a message to
stderr so that it's visible even if the generated output is redirected
to a file, please?

> 
> v3->v4:
> - Added comments to make code clearer
> - Added warning to man page as well (suggested by Quentin Monnet)
> 
> v2->v3:
> - Removed check if value is already in set (suggested by Song Liu)
> 
> v1->v2:
> - Fix CI error reported by Alexei Starovoitov
> ---
>  scripts/bpf_doc.py | 74 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index a6403ddf5de7..adf08fa963a4 100755
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
> @@ -193,19 +195,42 @@ class HeaderParser(object):
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
> +        # later with the number of unique function names present in description.
> +        # Note: seek_to(..) discards the first line below the target search text,
> +        # resulting in FN(unspec) being skipped and not added to self.define_unique_helpers.
> +        self.seek_to('#define __BPF_FUNC_MAPPER(FN)',
> +                     'Could not find start of eBPF helper definition list')
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
> @@ -305,9 +330,11 @@ class PrinterHelpersRST(PrinterRST):
>      """
>      def __init__(self, parser):
>          self.elements = parser.helpers
> +        self.desc_unique_helpers = parser.desc_unique_helpers
> +        self.define_unique_helpers = parser.define_unique_helpers
>  
>      def print_header(self):
> -        header = '''\
> +        header_name = '''\
>  ===========
>  BPF-HELPERS
>  ===========
> @@ -317,6 +344,8 @@ list of eBPF helper functions
>  
>  :Manual section: 7
>  
> +'''
> +        header_description = '''
>  DESCRIPTION
>  ===========
>  
> @@ -349,7 +378,27 @@ HELPERS
>  =======
>  '''
>          PrinterRST.print_license(self)
> -        print(header)
> +
> +        print(header_name)
> +
> +        # Add an error if the correct number of helpers are not auto-generated.
> +        nr_desc_unique_helpers = len(self.desc_unique_helpers)
> +        nr_define_unique_helpers = len(self.define_unique_helpers)
> +        if nr_desc_unique_helpers != nr_define_unique_helpers:
> +            header_error = '''
> +.. error::
> +    The number of unique helpers in description (%d) don\'t match the number of unique helpers defined in __BPF_FUNC_MAPPER (%d)

don\'t -> doesn\'t

> +''' % (nr_desc_unique_helpers, nr_define_unique_helpers)
> +            if nr_desc_unique_helpers < nr_define_unique_helpers:
> +                # Function description is parsed until no helper is found (which can be due to
> +                # misformatting). Hence, only print the first missing/misformatted function.
> +                header_error += '''
> +.. error::
> +    The description for %s is not present or formatted correctly.
> +''' % (self.define_unique_helpers[nr_desc_unique_helpers])
> +            print(header_error)
> +
> +        print(header_description)
>  
>      def print_footer(self):
>          footer = '''
> @@ -509,6 +558,8 @@ class PrinterHelpers(Printer):
>      """
>      def __init__(self, parser):
>          self.elements = parser.helpers
> +        self.desc_unique_helpers = parser.desc_unique_helpers
> +        self.define_unique_helpers = parser.define_unique_helpers
>  
>      type_fwds = [
>              'struct bpf_fib_lookup',
> @@ -628,6 +679,21 @@ class PrinterHelpers(Printer):
>  /* Forward declarations of BPF structs */'''
>  
>          print(header)
> +
> +        nr_desc_unique_helpers = len(self.desc_unique_helpers)
> +        nr_define_unique_helpers = len(self.define_unique_helpers)
> +        if nr_desc_unique_helpers != nr_define_unique_helpers:
> +            header_error = '''
> +#error The number of unique helpers in description (%d) don\'t match the number of unique helpers defined in __BPF_FUNC_MAPPER (%d)
> +''' % (nr_desc_unique_helpers, nr_define_unique_helpers)
> +            if nr_desc_unique_helpers < nr_define_unique_helpers:
> +                # Function description is parsed until no helper is found (which can be due to
> +                # misformatting). Hence, only print the first missing/misformatted function.
> +                header_error += '''
> +#error The description for %s is not present or formatted correctly.
> +''' % (self.define_unique_helpers[nr_desc_unique_helpers])
> +            print(header_error)
> +
>          for fwd in self.type_fwds:
>              print('%s;' % fwd)
>          print('')

