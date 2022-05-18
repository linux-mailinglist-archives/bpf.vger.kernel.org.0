Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA8252BD46
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 16:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbiERNbr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237967AbiERNbq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 09:31:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1168934650
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 06:31:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w4so2706560wrg.12
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 06:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=oSzTrk2MWG03IFEkRjj+Bvhq5SI1uyW/JXov8b5N7UY=;
        b=3QYH0ZyfUpKtSQPLGw78ePJSKahyqrC7zdXD2P3ZjEkP6jhupGUWvRxqIORA2ybMZw
         btQz+TKVGoqJEVbZY2aTIJkOhZYMDZt0Jfss7uZReUM3x1glzCndHjsEPjECK/scWdwC
         3lNLtt1pdGqUXkse+Gwkg6YxmI2H4EKOJm9Xpv2aQLCuw/vhYQnxZ7N+48jJ/Z9kfIw+
         LqDMqJz3YqyU6SAwwclXaMxgpjRKci+XrmkMeW61eqBt/YZ26XfB59u7LOKeM0gwmw5v
         NmVqeT78Pvt2Ms+iGYwZKxQ2WGy9W5zC/koQXzlbfFhWtPlxfP+fd+KJSnYkQP8ihUSo
         GDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=oSzTrk2MWG03IFEkRjj+Bvhq5SI1uyW/JXov8b5N7UY=;
        b=f40MpXFzfEyqzONk56pAMJPKn59jiVtgLYWZhjSXQOHCG6EzUtVQvi1QnPnrdnGBi6
         QggCakf3I6dIKyw8+lZIBbVDpLNGEp11rW6d96x04cGvq+Thkz8w23pEiJGRIWzLfjQv
         3vKPLx+AU0OtDwu761pHyXP0ns34fiOnq7dlWktl8EVrdPgbA8rPqY8DF31zaUZVxOJG
         vNkvR6KQiI0hKjKLPU5/1OXyhjTiwisZujSou+1rGlL9q8p3BT6JELPS+ejdi6GzoJyA
         9Bv5eupyQ4BQ7RV46ugk55QS7I4mT79qyVGPu5X2j9DTpcmWgw0y4Jqfp9O/kemrwOJW
         YuLA==
X-Gm-Message-State: AOAM532MuOIG22fm6xXK06DQdCC7mIpnskzhUwbNrr3q+GxU5kPyh1BH
        P88pDPtnsvglsFJrS2rV2ToyAQ==
X-Google-Smtp-Source: ABdhPJx8OiioEkNi/dMaRbOxrdU4XUiwn6BL5A5Ah+HEfiVsapLuiDjydJHcstrqoez4CuWIeycN6w==
X-Received: by 2002:adf:e70a:0:b0:20d:e3e:f79f with SMTP id c10-20020adfe70a000000b0020d0e3ef79fmr11010947wrm.105.1652880703176;
        Wed, 18 May 2022 06:31:43 -0700 (PDT)
Received: from [192.168.178.21] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id ay1-20020a05600c1e0100b0039706782e06sm1793154wmb.33.2022.05.18.06.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 06:31:42 -0700 (PDT)
Message-ID: <1198532c-3be3-badd-cfc2-052aa435d697@isovalent.com>
Date:   Wed, 18 May 2022 14:31:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH bpf-next 09/12] bpftool: Use libbpf_bpf_attach_type_str
To:     =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220516173540.3520665-1-deso@posteo.net>
 <20220516173540.3520665-10-deso@posteo.net>
 <CAEf4BzYXxSerQnw3U5SKU10HAbM1KrTj9z_DvX+tQqaq7+2CUQ@mail.gmail.com>
 <a1a518b6-4006-7a65-178d-6100ada34a2d@isovalent.com>
 <20220517185427.tafxhqk7vplj6ie4@devvm5318.vll0.facebook.com>
Content-Language: en-GB
In-Reply-To: <20220517185427.tafxhqk7vplj6ie4@devvm5318.vll0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-05-17 18:54 UTC+0000 ~ Daniel Müller <deso@posteo.net>
> On Tue, May 17, 2022 at 03:18:41PM +0100, Quentin Monnet wrote:
>> 2022-05-16 16:41 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
>>> On Mon, May 16, 2022 at 10:36 AM Daniel Müller <deso@posteo.net> wrote:
>>>>
>>>> This change switches bpftool over to using the recently introduced
>>>> libbpf_bpf_attach_type_str function instead of maintaining its own
>>>> string representation for the bpf_attach_type enum.
>>>>
>>>> Note that contrary to other enum types, the variant names that bpftool
>>>> maps bpf_attach_type to do not follow a simple to follow rule. With
>>>> bpf_prog_type, for example, the textual representation can easily be
>>>> inferred by stripping the BPF_PROG_TYPE_ prefix and lowercasing the
>>>> remaining string. bpf_attach_type violates this rule for various
>>>> variants. In order to not brake compatibility (these textual
>>>> representations appear in JSON and are used to parse user input), we
>>>> introduce a program local bpf_attach_type_str that overrides the
>>>> variants in question.
>>>> We should consider removing this function and expect the libbpf string
>>>> representation with the next backwards compatibility breaking release,
>>>> if possible.
>>>>
>>>> Signed-off-by: Daniel Müller <deso@posteo.net>
>>>> ---
>>>
>>> Quentin, any opinion on this approach? Should we fallback to libbpf's
>>> API for all the future cases or it's better to keep bpftool's own
>>> attach_type mapping?
>> Hi Andrii, Daniel,
> 
> Hi Quentin,
> 
>> Thanks for the ping! I'm unsure what's best, to be honest. Maybe we
>> should look at bpftool's inputs and outputs separately.
>>
>> For attach types printed as part of the output:
>>
>> Thinking about it, I'd say go for the libbpf API, and make the change
>> now. As much as we all dislike breaking things for user space, I believe
>> that on the long term, we would benefit from having a more consistent
>> naming scheme for those strings (prefix + lowercase attach type); and
>> more importantly, if querying the string from libbpf spreads to other
>> tools, these will be the reference strings for the attach types and it
>> will be a pain to convert bpftool's specific exceptions to "regular"
>> textual representations to interface with other tools.
>>
>> And if we must break things, I'd as well have it synchronised with the
>> release of libbpf 1.0, so I'd say let's just change it now? Note that
>> we're now tagging bpftool releases on the GitHub mirror (I did 6.8.0
>> earlier today), so at least that's one place where we can have a
>> changelog and mention breaking changes.
> 
> Thanks for the feedback. This sounds good to me. I can make the change. But do
> you think we should do it as part of this stack? We could make this very stack a
> behavior preserving step (that can reasonably stand on its own). Given the
> additional changes to tests & documentation that you mention below, it would
> make sense to me to keep individual patches in this series similar in nature.
> I'd be happy to author a follow-on, but can also amend this series if that's
> preferred. Please let me know your preference.

So I would have a slight preference for having everything together, but
at the same time I understand that the current patchset is already in
a good state and that you don't want to "overgrow" it too much. So
follow-up is fine by me, mostly (see next paragraph), if it lands before
libbpf v1.0 is released. If I understand correctly, you would have the
addition of the new names as an alternative for input parameters in this
set, and follow-up with the breaking changes (using the new names for
output, and switching to new names for input in docs) as a follow-up, is
this correct?

Still, the tests in test_bpftool_synctypes.py should be updated in this
PR, because the bpftool tests in the CI break otherwise [0]. This is due
to the removal of the lists of names in bpftool: the test parses them to
compare the lists with what's present in UAPI bpf.h, bpftool man pages,
etc. I believe it would be best to keep this in a running state.

[0]
https://github.com/kernel-patches/bpf/runs/6459959177?check_suite_focus=true#step:6:678

> 
>> Now for the attach types parsed as input parameters:
>>
>> I wonder if it would be worth supporting the two values for attach types
>> where they differ, so that we would avoid breaking bpftool commands
>> themselves? It's a bit more code, but then the list would be relatively
>> short, and not expected to grow. We can update the documentation to
>> mention only the new names, and just keep the short compat list hidden.
> 
> Yes, that should be easily possible. I do have a similar question to above,
> though (as it involves updating documentation for new preference): can/should
> that be a separate patch?
> 
>> Some additional notes on the patch:
>>
>> There is also attach_type_strings[] in prog.c where strings for attach
>> types are re-defined, this time for when non cgroup-related programs are
>> attached (through "bpftool prog attach"). It's used for parsing the
>> input, so should be treated the same as the attach list in commons.c.
> 
> Good point. If we want to use libbpf text representations moving forward then I
> can adjust this array as well. Do I assume correctly that we would want to keep
> the existing variants as hidden fallbacks here too, as you mentioned above?

Yes, exactly.

>> If changing the attach type names, we should also update the following:
>> - man pages: tools/bpf/bpftool/Documentation/bpftool-{cgroup,prog}.rst
>> - interactive help (cgroup.c:HELP_SPEC_ATTACH_TYPES + prog.c:do_help())
>> - bash completion: tools/bpf/bpftool/bash-completion/bpftool
>>
>> Some of the tests in
>> tools/testing/selftests/bpf/test_bpftool_synctypes.py, related to
>> keeping those lists up-to-date, will also need to be modified to parse
>> the names from libbpf instead of bpftool sources. I can help with that
>> if necessary.
> 
> Sounds good; will do that here or as a follow-on (and reach out to you if I need
> assistance), depending on your preference as inquired above.

Sounds like a plan :)
Thanks,
Quentin
