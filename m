Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE21C59F70D
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 12:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbiHXKDl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 06:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbiHXKDk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 06:03:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4266D792FA
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 03:03:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id az27so97403wrb.6
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 03:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=hpkQClx2U3WMFWDpJRIIbE1m3GiaymdO0UTCrhEbhZ4=;
        b=pfprznr6RN0UUGm2DPCM1vmH+JndLHMEa4S/g7vEa51wrpHRHsDTiVYyCh5zJf7MbF
         OhpX9jnxwcHs5uL57jTz0j6wPumqE2EhlDVtWc8QsIwwdzJy182eo3EF7nqtQpd6TuI3
         sHzKlxkijziErK5eZ3P4g9UBJwQ/gLZiREhiC9kuRb1twbOB0HEVsE25vrxnazCAHuUf
         9ke49MesVopxb6yza6KmMeFAWJupmwtV9ne47d9c2GyBh6zVwoG1qkBThmfMGRY1c90y
         9ASnS+5QlZT45y6bczXgqOULKff1QkCwtDgTjjDMStESXXI+5hY+n6RgznvgNJKZhfQq
         cLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=hpkQClx2U3WMFWDpJRIIbE1m3GiaymdO0UTCrhEbhZ4=;
        b=uM88B3NqzwR4yAKW2JsyG7wFj0gVABmPjkEV+WvaTgdkdUA8Fzl4L7k+md2TwqMWa8
         C0Bnmy8OLi55ci6ri7/0Clqw4sABbyX+1kqkZL+CDA5wZr5AKZ4nEUz/EjQ/GDSPfsOE
         TARDd/YYAEAmOt2fl8lUZ4KLFuGRZVLd1iiqmFfAc4rHvmk7OcUSL0SOQjJx2JEU3RL/
         3vq2L2JeD39sJOLb+ZnMFeuo0/phxx9GlKa1AOXTH+7Ml6i46wob3I9ISf/DHVzQKgGo
         2ZjVNi2avzHcG2eWcFvkKzcUA+ElulUEz/osZMAzhc48PI1xhACNY+xPsG00KO54LOOa
         KNuQ==
X-Gm-Message-State: ACgBeo2aX/Qq69kx8IxCNS+s4gmZtTy4OTfGQGmUKOw3IvL2jOxOfOZ1
        hcyQ9py2SteadIl8FHIoH93Fmg==
X-Google-Smtp-Source: AA6agR5N/bLK9nV2eT1K+BF+OGCAuKm2BwmF9yTCvhTb3O7D0jS7mo3VRu/qXebFZdDoxHlAmtafVg==
X-Received: by 2002:a5d:648b:0:b0:222:cb51:a57 with SMTP id o11-20020a5d648b000000b00222cb510a57mr15619270wri.287.1661335417742;
        Wed, 24 Aug 2022 03:03:37 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id g12-20020adfa48c000000b00224f5bfa890sm17444707wrb.97.2022.08.24.03.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 03:03:37 -0700 (PDT)
Message-ID: <b1ffadd8-e782-dcf3-f9bd-13c86d55eb64@isovalent.com>
Date:   Wed, 24 Aug 2022 11:03:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH bpf-next,v2] bpf/scripts: assert helper enum value is
 aligned with comment order
Content-Language: en-GB
To:     Eyal Birger <eyal.birger@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
Cc:     bpf@vger.kernel.org
References: <20220824091940.1578705-1-eyal.birger@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220824091940.1578705-1-eyal.birger@gmail.com>
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

On 24/08/2022 10:19, Eyal Birger wrote:
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
> 
> v2: based on feedback from Quentin Monnet:
> - assert the current comment ordering
> - match only one FN in each line
> ---
>  scripts/bpf_doc.py | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index f4f3e7ec6d44..80dfb230459d 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -91,7 +91,7 @@ class HeaderParser(object):
>          self.helpers = []
>          self.commands = []
>          self.desc_unique_helpers = set()
> -        self.define_unique_helpers = []
> +        self.define_unique_helpers = {}
>          self.desc_syscalls = []
>          self.enum_syscalls = []
>  
> @@ -248,24 +248,24 @@ class HeaderParser(object):
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
> -        fn_defines_str = ''
> +        # Searches for one FN(\w+) define or a backslash for newline
> +        p = re.compile('\s*FN\((\w+)\)|\\\\')
> +        i = 1  # 'unspec' is skipped as mentioned above
>          while True:
>              capture = p.match(self.line)
>              if capture:
> -                fn_defines_str += self.line
> +                self.define_unique_helpers[capture.expand(r'bpf_\1')] = i
> +                i += 1
>              else:
>                  break
>              self.line = self.reader.readline()
> -        # Find the number of occurences of FN(\w+)
> -        self.define_unique_helpers = re.findall('FN\(\w+\)', fn_defines_str)
>  
>      def run(self):
>          self.parse_desc_syscall()
> @@ -608,6 +608,7 @@ class PrinterHelpers(Printer):
>      def __init__(self, parser):
>          self.elements = parser.helpers
>          self.elem_number_check(parser.desc_unique_helpers, parser.define_unique_helpers, 'helper', '__BPF_FUNC_MAPPER')
> +        self.define_unique_helpers = parser.define_unique_helpers
>  
>      type_fwds = [
>              'struct bpf_fib_lookup',
> @@ -796,7 +797,17 @@ class PrinterHelpers(Printer):
>              comma = ', '
>              print(one_arg, end='')
>  
> -        print(') = (void *) %d;' % len(self.seen_helpers))
> +        helper_val = self.define_unique_helpers[proto['name']]
> +
> +        # Assert helper description order is aligned with the enum value

Thanks! But this check should go in the parser, not in the printer. One
reason is that it won't show when generating the man page, with this
version; another reason is that it should return early and avoid
generating an incomplete, non-functional header if the assertion fails.

> +        desc_val = len(self.seen_helpers)
> +        if helper_val != desc_val:
> +            print("Helper %s comment order (#%d) must be aligned with its enum "
> +                  "order (#%d)" % (proto['name'], desc_val, helper_val),

Please don't split the string on two lines, never mind if it  goes over
80 characters. Makes it harder to grep otherwise.

Suggestion on the message: "with its enum order (<nb>)" -> "with its
position (<nb>) in enum bpf_func_id"?

> +                  file=sys.stderr)
> +            sys.exit(1)

Can we raise an Exception instead of printing to stderr + exiting?

> +
> +        print(') = (void *) %d;' % helper_val)
>          print('')
>  
>  ##############################################################################
