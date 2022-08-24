Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370B15A0051
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 19:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiHXRZa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 13:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240117AbiHXRZZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 13:25:25 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DE27C50E
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 10:25:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bq11so15041521wrb.12
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 10:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=FFrhza5Xqbpjx/cOVobgarXWGmcBTrGB33VVs3GEt8w=;
        b=j5n4H8tLnhyg5Ch0ZhBQqD7x3w2t9OybOXqbZK1YbX+aShZeQjbsnZHfo48gC3H1xY
         cc+jQLncmRi4gUgih61EKkWyX6wcZY0ww7aVFdyEpKDIwNhaR5IMhIaLyPiQh3Wye6V7
         IdQwX8V6xUSmO+ZAMfCG3WzjIMGfAhD0MzyZI01x/ogIWW+mFOeAnZefhBy3kOZhxYPB
         oQorktVlQj/YY2SAx10OaVqHpaVyOQCKkhh+uzitbm8syAdLmzaiwEKYiULCSUeT6BY7
         nVAq/7K+8Zw+73nXeM4pob7dTzP7hKrhzSJBLntsWD5JOLkNa/QQhgHnYaJFOfu2RMbd
         NcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=FFrhza5Xqbpjx/cOVobgarXWGmcBTrGB33VVs3GEt8w=;
        b=NtsVoaPFa5orxtmZXSomNnEw7dVVkaIhxQrhUgaydoClOA8qyUarDvFJtNf0IzXxH8
         AoVXH7Chx2pWjM37Tmfx1L8Grm3wTLF9hYRslS8BhStn/RvGOO9lWpejNa9uDFwsCc9s
         08Pf98ZNWGSNOul78E4xiCqxS4ZDX9BV1cbH8dZi7temTZh17rcjjfTKkzGBm5NdEqyE
         RfZ0cCu3FGgX+vRpMyfYbdOPX3S1uwO8RX8AVcGhdVQmZsNjaVhJRLkzVrd+Ui+Si6dX
         VNaMJC7R59K766hzoAdwi+k80Q3yrBzPOWMMgIXT+tS7ycd5K0wTobAfjKhtxe3U9GvZ
         ZTCA==
X-Gm-Message-State: ACgBeo1py9rS0cUzG21/ejFjbRYuiMvO0JsfOdQPwZn70jlXGUDnsco8
        YOUydWks5zw11K/xUT4W3OMOhA==
X-Google-Smtp-Source: AA6agR4zuhZIWB8h1VWPikzBSsAKvlz37RuLQsLF5IwKBzM0VFg94goq+bxtqf+8OIcExaHKPJsQEA==
X-Received: by 2002:adf:f6cb:0:b0:220:7859:7bf with SMTP id y11-20020adff6cb000000b00220785907bfmr111582wrp.683.1661361922822;
        Wed, 24 Aug 2022 10:25:22 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id bp25-20020a5d5a99000000b0021f0c0c62d1sm17247045wrb.13.2022.08.24.10.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 10:25:22 -0700 (PDT)
Message-ID: <796fc289-9c98-9e12-fe9a-1e8c9cd4e8e7@isovalent.com>
Date:   Wed, 24 Aug 2022 18:25:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH bpf-next,v3] bpf/scripts: assert helper enum value is
 aligned with comment order
Content-Language: en-GB
To:     Eyal Birger <eyal.birger@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
Cc:     bpf@vger.kernel.org
References: <20220824122623.1599477-1-eyal.birger@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220824122623.1599477-1-eyal.birger@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24/08/2022 13:26, Eyal Birger wrote:
> The helper value is ABI as defined by enum bpf_func_id.
> As bpf_helper_defs.h is used for the userpace part, it must be consistent
> with this enum.
> 
> Before this change the comments order was used by the bpf_doc script in
> order to set the helper values defined in the helpers file.
> 
> When adding new helpers it is very puzzling when the userspace application
> breaks in weird places if the comment is inserted instead of appended -
> because the generated helper ABI is incorrect and shifted.
> 
> This commit sets the helper value to the enum value.
> 
> In addition it is currently the practice to have the comments appended
> and kept in the same order as the enum. As such, add an assertion
> validating the comment order is consistent with enum value.
> 
> In case a different comments ordering is desired, this assertion can
> be lifted.
> 
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> 
> ---
> v3: based on feedback from Quentin Monnet:
> - move assertion to parser
> - avoid using define_unique_helpers as elem_number_check() relies on
>   it being an array
> - set enum_val in helper object instead of passing as a dict to the
>   printer
> 
> v2: based on feedback from Quentin Monnet:
> - assert the current comment ordering
> - match only one FN in each line
> ---
>  scripts/bpf_doc.py | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index f4f3e7ec6d44..114b2a60afc8 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -50,6 +50,10 @@ class Helper(APIElement):
>      @desc: textual description of the helper function
>      @ret: description of the return value of the helper function
>      """
> +    def __init__(self, *args, **kwargs):
> +        super().__init__(*args, **kwargs)
> +        self.enum_value = None

Should this be self.enum_val?
Looks good otherwise.

> +
>      def proto_break_down(self):
>          """
>          Break down helper function protocol into smaller chunks: return type,
> @@ -92,6 +96,7 @@ class HeaderParser(object):
>          self.commands = []
>          self.desc_unique_helpers = set()
>          self.define_unique_helpers = []
> +        self.helper_enum_vals = {}
>          self.desc_syscalls = []
>          self.enum_syscalls = []
>  
> @@ -248,30 +253,54 @@ class HeaderParser(object):
>                  break
>  
>      def parse_define_helpers(self):
> -        # Parse the number of FN(...) in #define __BPF_FUNC_MAPPER to compare
> -        # later with the number of unique function names present in description.
> +        # Parse FN(...) in #define __BPF_FUNC_MAPPER to compare later with the
> +        # number of unique function names present in description and use the
> +        # correct enumeration value.
>          # Note: seek_to(..) discards the first line below the target search text,
>          # resulting in FN(unspec) being skipped and not added to self.define_unique_helpers.
>          self.seek_to('#define __BPF_FUNC_MAPPER(FN)',
>                       'Could not find start of eBPF helper definition list')
> -        # Searches for either one or more FN(\w+) defines or a backslash for newline
> -        p = re.compile('\s*(FN\(\w+\))+|\\\\')
> +        # Searches for one FN(\w+) define or a backslash for newline
> +        p = re.compile('\s*FN\((\w+)\)|\\\\')
>          fn_defines_str = ''
> +        i = 1  # 'unspec' is skipped as mentioned above
>          while True:
>              capture = p.match(self.line)
>              if capture:
>                  fn_defines_str += self.line
> +                self.helper_enum_vals[capture.expand(r'bpf_\1')] = i
> +                i += 1
>              else:
>                  break
>              self.line = self.reader.readline()
>          # Find the number of occurences of FN(\w+)
>          self.define_unique_helpers = re.findall('FN\(\w+\)', fn_defines_str)
>  
> +    def assign_helper_values(self):
> +        seen_helpers = set()
> +        for helper in self.helpers:
> +            proto = helper.proto_break_down()
> +            name = proto['name']
> +            try:
> +                enum_val = self.helper_enum_vals[name]
> +            except KeyError:
> +                raise Exception("Helper %s is missing from enum bpf_func_id" % name)
> +
> +            # Enforce current practice of having the descriptions ordered
> +            # by enum value.
> +            seen_helpers.add(name)
> +            desc_val = len(seen_helpers)
> +            if desc_val != enum_val:
> +                raise Exception("Helper %s comment order (#%d) must be aligned with its position (#%d) in enum bpf_func_id" % (name, desc_val, enum_val))
> +
> +            helper.enum_val = enum_val
> +
>      def run(self):
>          self.parse_desc_syscall()
>          self.parse_enum_syscall()
>          self.parse_desc_helpers()
>          self.parse_define_helpers()
> +        self.assign_helper_values()
>          self.reader.close()
>  
>  ###############################################################################
> @@ -796,7 +825,7 @@ class PrinterHelpers(Printer):
>              comma = ', '
>              print(one_arg, end='')
>  
> -        print(') = (void *) %d;' % len(self.seen_helpers))
> +        print(') = (void *) %d;' % helper.enum_val)
>          print('')
>  
>  ###############################################################################

