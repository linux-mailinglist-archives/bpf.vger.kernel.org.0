Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B58D6B20B4
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 10:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjCIJyC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 04:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjCIJxs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 04:53:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8162359D4
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 01:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678355576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZC60F9J+/jh7Rt22bZOYs1SB4PuLwf5icuQF2XcQSA=;
        b=ZuHUA5OeEeU//6R3tU646DTJQmHOpShz102v3u5ySlIBI8OBA+dB13w8oZ1KEW1O3ypXwF
        nrV8FkZIgjii+UV8H9NBQfhuNHFRSYMV3gfFqbeTRyLcBar2UMRWfcOrrp1pReoCvH2zEq
        c8OMISFbsGs9nTObpY8fWiFOzrzyGSM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-X-qAh2fpOK6vnk8xtjBcJw-1; Thu, 09 Mar 2023 04:52:55 -0500
X-MC-Unique: X-qAh2fpOK6vnk8xtjBcJw-1
Received: by mail-ed1-f71.google.com with SMTP id g2-20020a056402320200b004e98d45ee7dso2225429eda.0
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 01:52:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678355572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZC60F9J+/jh7Rt22bZOYs1SB4PuLwf5icuQF2XcQSA=;
        b=QKObErKxvxT1TppuwO7EYqbwZdekhX9Ks01FAox9jbkMMVARed4SVBOhSqJODpGuAj
         VBUXgrEgvxvQEzQKy14TFwfYDXDDH7MrkETCOLecSPFqGuZCvoXdy5Z8pf5nG2qa9u7q
         j2m/K3mtua0Nu8nzPjIo2a/CxzZDzsu9r89mU2n92rvz9hH8d3yWFh84OPTz537dXWs+
         VXFN/fZlKSQahpCy/ejM0RmBEbueuTIR/BQorF+2/zqJ1YDq4mrYkMOPK/aGJAV1i8nv
         e2yP7CJXqyvzArB9U4181VQbs/W92g1XOPt6BTEiRFsSKNSTAaWrvTZLqX90E9O8yOHh
         O9rQ==
X-Gm-Message-State: AO0yUKUfYvcJKeuawwUIZ0aAdtfGYFDslVNRwzkUhFkRaWDDeNLavJz0
        oP7A+T8qQ85nGnAffCjrPqePCevXR0XNHWI5N4av5ocwIYOExSovgkQYDroy800TzqIPkBpAQzi
        f+8R8tjjiHa0=
X-Received: by 2002:a05:6402:1b1a:b0:4bb:c14d:1803 with SMTP id by26-20020a0564021b1a00b004bbc14d1803mr17769872edb.30.1678355571798;
        Thu, 09 Mar 2023 01:52:51 -0800 (PST)
X-Google-Smtp-Source: AK7set/Z5uAUoSXOtoDyKcsad+5fmqmiX95Ebm5JlGv6RJ/EWCyP65e0Ufxrsy34jv3ACaANIatH7A==
X-Received: by 2002:a05:6402:1b1a:b0:4bb:c14d:1803 with SMTP id by26-20020a0564021b1a00b004bbc14d1803mr17769861edb.30.1678355571457;
        Thu, 09 Mar 2023 01:52:51 -0800 (PST)
Received: from [10.43.17.73] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id m30-20020a50d7de000000b004c13fe8fabfsm9331147edj.84.2023.03.09.01.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:52:51 -0800 (PST)
Message-ID: <21821216-f882-d036-776b-4a0c6473d2d4@redhat.com>
Date:   Thu, 9 Mar 2023 10:52:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v9 0/2] Fix attaching fentry/fexit/fmod_ret/lsm
 to modules
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <cover.1677583941.git.vmalik@redhat.com>
 <CAEf4BzY9h+ywcxo5=6WZbJzN=9_9UJ_fwKVEBDHWn=4PDPf33Q@mail.gmail.com>
From:   Viktor Malik <vmalik@redhat.com>
In-Reply-To: <CAEf4BzY9h+ywcxo5=6WZbJzN=9_9UJ_fwKVEBDHWn=4PDPf33Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/8/23 04:58, Andrii Nakryiko wrote:
> On Tue, Feb 28, 2023 at 4:27 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> I noticed that the verifier behaves incorrectly when attaching to fentry
>> of multiple functions of the same name located in different modules (or
>> in vmlinux). The reason for this is that if the target program is not
>> specified, the verifier will search kallsyms for the trampoline address
>> to attach to. The entire kallsyms is always searched, not respecting the
>> module in which the function to attach to is located.
>>
>> As Yonghong correctly pointed out, there is yet another issue - the
>> trampoline acquires the module reference in register_fentry which means
>> that if the module is unloaded between the place where the address is
>> found in the verifier and register_fentry, it is possible that another
>> module is loaded to the same address in the meantime, which may lead to
>> errors.
>>
>> This patch fixes the above issues by extracting the module name from the
>> BTF of the attachment target (which must be specified) and by doing the
>> search in kallsyms of the correct module. At the same time, the module
>> reference is acquired right after the address is found and only released
>> right before the program itself is unloaded.
>>
> 
> is it expected that your newly added test fails on arm64? See [0]
> 
>    [0] https://github.com/kernel-patches/bpf/actions/runs/4359596129/jobs/7621687719

I believe so, the test uses fentry and all fentry/fexit tests are
failing on arm64 with the same error (524) and are disabled in the CI.

> 
>> ---
>> Changes in v9:
>> - two small changes suggested by Jiri Olsa and Jiri's ack
>>
>> Changes in v8:
>> - added module_put to error paths in bpf_check_attach_target after the
>>    module reference is acquired
>>
>> Changes in v7:
>> - refactored the module reference manipulation (comments by Jiri Olsa)
>> - cleaned up the test (comments by Andrii Nakryiko)
>>
>> Changes in v6:
>> - storing the module reference inside bpf_prog_aux instead of
>>    bpf_trampoline and releasing it when the program is unloaded
>>    (suggested by Jiri Olsa)
>>
>> Changes in v5:
>> - fixed acquiring and releasing of module references by trampolines to
>>    prevent modules being unloaded between address lookup and trampoline
>>    allocation
>>
>> Changes in v4:
>> - reworked module kallsyms lookup approach using existing functions,
>>    verifier now calls btf_try_get_module to retrieve the module and
>>    find_kallsyms_symbol_value to get the symbol address (suggested by
>>    Alexei)
>> - included Jiri Olsa's comments
>> - improved description of the new test and added it as a comment into
>>    the test source
>>
>> Changes in v3:
>> - added trivial implementation for kallsyms_lookup_name_in_module() for
>>    !CONFIG_MODULES (noticed by test robot, fix suggested by Hao Luo)
>>
>> Changes in v2:
>> - introduced and used more space-efficient kallsyms lookup function,
>>    suggested by Jiri Olsa
>> - included Hao Luo's comments
>>
>>
>> Viktor Malik (2):
>>    bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules
>>    bpf/selftests: Test fentry attachment to shadowed functions
>>
>>   include/linux/bpf.h                           |   2 +
>>   kernel/bpf/syscall.c                          |   6 +
>>   kernel/bpf/trampoline.c                       |  28 ----
>>   kernel/bpf/verifier.c                         |  18 ++-
>>   kernel/module/internal.h                      |   5 +
>>   net/bpf/test_run.c                            |   5 +
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   6 +
>>   .../bpf/prog_tests/module_attach_shadow.c     | 128 ++++++++++++++++++
>>   8 files changed, 169 insertions(+), 29 deletions(-)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c
>>
>> --
>> 2.39.1
>>
> 

