Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C50659F581
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 10:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbiHXIpB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 04:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiHXIo6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 04:44:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFF564DE
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 01:44:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a4so19903434wrq.1
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 01:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=wQOWa7rdT2oJli000pa9mdD+712DRizPjw0cJ1SBCjg=;
        b=8E3l0a901PCzZddX73ctLTAfdQ9vKsjtsEdsHO2P+SyK+uEPnRdDusIwMMvMXgFvTT
         fb+jRLlBpRo6Ro6Z60N2mMuLCvtbz6adpcEcbTjM2FeGt4S8pJ+Tyr2Fm6e5HepEMNaX
         p6oAehP6Ezi+5I7y4qze0ToE13QsoNnofdbFLltTfsxmcdjKDQz2KVaOANb9pc9liMyz
         8K83P3mK2Ml9D4crrhIVEPvAe24KFpBf0uZrz8gmoeYeQbN7fogo6tORvk9QppJnDHJ0
         424bExfjTGGr1JaFaAUOqOMWI2l4nmpd2jOFYOkuTmyFzGd9Jxu7Mi9lzEqpLPuKRmDp
         gftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=wQOWa7rdT2oJli000pa9mdD+712DRizPjw0cJ1SBCjg=;
        b=CLSxTp06NPNAILzLzDLauI3aiWh+Snm3WRmhksfdCL/j8ZC/FatcfPtiqO2ickby+9
         ceN/iv3UHUF0g7D+Zz4O0Wj4xWHAHgIN5t1Uk2miUjhp7cFrTOC8VfUB1q7/LRXVYtG1
         FvaIeqoJzx90BDyp+uWqsC49BVcbj6rGhTMPGwGrCoxhK+GpyQAkCfTgY/W7XUhgift3
         DbankIx+NTkJjJ056uWWyvv7ZWJk3r9SFnCFiBX+YWNFNQQS8Eplo/Q6c2TlXqqJ0yc/
         b9KmYWS1xo4E2qeYlrTJ/NFzWAZ//lNjPziXEmVH7Hw93nV69iNDU3w1T9sFSEoyVBAJ
         m02w==
X-Gm-Message-State: ACgBeo2lStjm+TjLa8uY6x7TrYrBjgnbmMcgNgI2kS4YZrkcgoVEq/ib
        w60f+BzxndJQtsyG+2SU0FMC5g==
X-Google-Smtp-Source: AA6agR461GWu1tR+2La5jhfhTGgH4exqIQdcLKURELMkTINVIOdTC5uxdZAoxz4Yl4R0o0Snbrl/mQ==
X-Received: by 2002:a05:6000:1acd:b0:220:62c2:bc29 with SMTP id i13-20020a0560001acd00b0022062c2bc29mr15194743wry.620.1661330693520;
        Wed, 24 Aug 2022 01:44:53 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id q62-20020a1c4341000000b003a3442f1229sm1216041wma.29.2022.08.24.01.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 01:44:52 -0700 (PDT)
Message-ID: <53cd19db-3b51-2d7f-1968-c67027d28db9@isovalent.com>
Date:   Wed, 24 Aug 2022 09:44:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH bpf-next] bpf/scripts: use helper enum value instead of
 relying on comment order
Content-Language: en-GB
To:     Eyal Birger <eyal.birger@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <20220819091244.1001962-1-eyal.birger@gmail.com>
 <CACdoK4KY6W=CrBXGTBx=su7UZ6ryna2CsjNw=zeNWc_pXzkrrg@mail.gmail.com>
 <CAHsH6GsTuWKyRtira6jG7jfqh4VOwKh1oYkkGt=8w2u4rQJByA@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAHsH6GsTuWKyRtira6jG7jfqh4VOwKh1oYkkGt=8w2u4rQJByA@mail.gmail.com>
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

On 24/08/2022 00:05, Eyal Birger wrote:
> Hi Quentin,
> 
> On Tue, Aug 23, 2022 at 11:49 PM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> On Fri, 19 Aug 2022 at 10:13, Eyal Birger <eyal.birger@gmail.com> wrote:
>>>
>>> The helper value is ABI as defined by enum bpf_func_id.
>>> As bpf_helper_defs.h is used for the userpace part, it must be consistent
>>> with this enum.
>>>
>>> Before this change, the enumerated value was derived from the comment
>>> order, which assumes comments are always appended, however, there doesn't
>>> seem to be an enforcement anywhere for maintaining a strict order.
>>>
>>> When adding new helpers it is very puzzling when the userspace application
>>> breaks in weird places if the comment is inserted instead of appended -
>>> because the generated helper ABI is incorrect and shifted.
>>>
>>> This commit attempts to ease this by always using bpf_func_id order as
>>> the helper value.
>>>
>>> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
>>> ---
>>>  scripts/bpf_doc.py | 19 ++++++++++---------
>>>  1 file changed, 10 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>>> index dfb260de17a8..7797aa032eca 100755
>>> --- a/scripts/bpf_doc.py
>>> +++ b/scripts/bpf_doc.py
>>> @@ -88,7 +88,7 @@ class HeaderParser(object):
>>>          self.helpers = []
>>>          self.commands = []
>>>          self.desc_unique_helpers = set()
>>> -        self.define_unique_helpers = []
>>> +        self.define_unique_helpers = {}
>>>          self.desc_syscalls = []
>>>          self.enum_syscalls = []
>>>
>>> @@ -245,24 +245,24 @@ class HeaderParser(object):
>>>                  break
>>>
>>>      def parse_define_helpers(self):
>>> -        # Parse the number of FN(...) in #define __BPF_FUNC_MAPPER to compare
>>> -        # later with the number of unique function names present in description.
>>> +        # Parse FN(...) in #define __BPF_FUNC_MAPPER to compare later with the
>>> +        # number of unique function names present in description and use the
>>> +        # correct enumeration value.
>>>          # Note: seek_to(..) discards the first line below the target search text,
>>>          # resulting in FN(unspec) being skipped and not added to self.define_unique_helpers.
>>>          self.seek_to('#define __BPF_FUNC_MAPPER(FN)',
>>>                       'Could not find start of eBPF helper definition list')
>>>          # Searches for either one or more FN(\w+) defines or a backslash for newline
>>> -        p = re.compile('\s*(FN\(\w+\))+|\\\\')
>>> -        fn_defines_str = ''
>>> +        p = re.compile('\s*FN\((\w+)\)+|\\\\')
>>
>> Nit: I think the second '+' should be removed, I don't think you can
>> have consecutive "FN(...)" without at least a comma. But you didn't
>> add and it is harmless, so it can be a follow-up or wait until a
>> future clean-up.
>>
> 
> Sure. I can remove that.
> 
>>> +        i = 1  # 'unspec' is skipped as mentioned above
>>>          while True:
>>>              capture = p.match(self.line)
>>>              if capture:
>>> -                fn_defines_str += self.line
>>> +                self.define_unique_helpers[capture.expand(r'bpf_\1')] = i
>>> +                i += 1
>>>              else:
>>>                  break
>>>              self.line = self.reader.readline()
>>> -        # Find the number of occurences of FN(\w+)
>>> -        self.define_unique_helpers = re.findall('FN\(\w+\)', fn_defines_str)
>>>
>>>      def run(self):
>>>          self.parse_desc_syscall()
>>> @@ -573,6 +573,7 @@ class PrinterHelpers(Printer):
>>>      def __init__(self, parser):
>>>          self.elements = parser.helpers
>>>          self.elem_number_check(parser.desc_unique_helpers, parser.define_unique_helpers, 'helper', '__BPF_FUNC_MAPPER')
>>> +        self.define_unique_helpers = parser.define_unique_helpers
>>>
>>>      type_fwds = [
>>>              'struct bpf_fib_lookup',
>>> @@ -761,7 +762,7 @@ class PrinterHelpers(Printer):
>>>              comma = ', '
>>>              print(one_arg, end='')
>>>
>>> -        print(') = (void *) %d;' % len(self.seen_helpers))
>>> +        print(') = (void *) %d;' % self.define_unique_helpers[proto['name']])
>>>          print('')
>>
>> The code seems correct and should make the script more robust, and I
>> checked that the man page and header file are generated identically.
>>
>> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> 
> Thanks for the review.
> 
>>
>> However, I would recommend against inserting the description of new
>> helpers in the middle of the current documentation. Having the helpers
>> listed in order of creation is maybe not ideal, but at least they are
>> ordered, and the list remains consistent with the items of enum
>> bpf_func_id. I'm not opposed to reworking the list to have them
>> displayed in a more logical order, but in that case I think we should
>> reorganise the whole list, not just start inserting new descriptions
>> in the middle.
>>
> 
> I understand. Personally I don't mind the fact that they're ordered
> relative to their enum value, only that this is implicitly enforced.
> 
> Since we know both the enum value and the comment value, would it be
> acceptible to add an assertion here so that at least wrongful insertions
> break the file generation instead of skewing the values?

As I understand it, your patch already solves the issue by making sure
we use the correct value even if the descriptions do not come in the
same order as the enum items. Do you mean adding an additional check to
enforce that the description items are in the same order, in addition to
your patch?

I don't have a strong opinion, if anything I'd say it's probably not the
role of this script to ensure that the description items are in a
particular order (provided your patch is applied and the values are
correct). I'm not sure we want to strongly enforce the order; I would
definitely recommend against inserting new items in the middle, but at
the same time I wouldn't oppose some reorganisation into logical
sections. On the other hand, it's probably cleaner to have the
definitions in the generated header file listed in the correct order of
the enum values, so why not having the assertion for now, and lifting it
if we ever want to rework the order.

Quentin
