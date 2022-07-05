Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1652B56711D
	for <lists+bpf@lfdr.de>; Tue,  5 Jul 2022 16:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiGEOeR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Jul 2022 10:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiGEOeQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jul 2022 10:34:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E79C38B6
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 07:34:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b26so17876255wrc.2
        for <bpf@vger.kernel.org>; Tue, 05 Jul 2022 07:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=neO/j+HJyzs7QhvJAWtH5V8/341+rEvQ5kA5JjlOD0E=;
        b=exS13Imt8UeKR/MS2j9FQocrQCOejU9rHmWPgIuFym7NE6pklPq3s2gqmM/Lzmci3J
         /0emX5TeM3pfDB+ud7PHDEVoCpZNDuMhyNR7VGEQpiSPK97MQsBJpVNZppI4xmh9tiXt
         UbSYwRdlYKs4JVkczQG958se8NNMCtwv/zchGmMcBPHHyHLyVRMjUUBO3oz0CG0LNUW5
         SSAy5fl87jKds1fW7nVfwAvPqdrFvf1K0sh3kvN2tGqyCsa0R5hV9R13i8B9iFmwORQW
         RrEshhe6aw8VYgTewMmvi6eyA5dUC99Aq0UDjq06CuxwnHkuFNFLxpiSqODOjT4T57qN
         PwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=neO/j+HJyzs7QhvJAWtH5V8/341+rEvQ5kA5JjlOD0E=;
        b=aHoN4lgoN+02+UqQe2tjIcim5+C5Tf5OxK7MixlEtn+Gf7I7n1GvPuUpLOhCf1c7ig
         7q+MqpZgDvsRWTi/nCGJ1hLFWGMQDnXIsPw2b2kFxbeLJhxUblzzBGqDJRFNMRudKvkS
         rombjusRdy9SfOBCILyMgoHtLHcH4n1mKiB/Zlj8KqcpMp91N3owEDpQoxL1JXZutX9M
         ckNOKiXxrR8Lw5QiALPmblGL4XxaxJsgK8GAmP/f4jOF7fP1E2Wo7o7nS4CxteLUZWev
         oI1xoeayEidoBCzJLDCu4kOczZi7a/EJSRIurHA6Yjs51mGK94n2Cvmg3DYdu8ydsAes
         eYeQ==
X-Gm-Message-State: AJIora+Xlwd3/mSlemzmrzT0rFUBiwscDQg2wrn+4TT2lCO/QZOGFWId
        PO9E0yzDUIVwWBoVnzkSd41h0Dh7YPq6vXAH
X-Google-Smtp-Source: AGRyM1sbFu5iagL2XbnL6riGyMRwonUOhEAbBCBEOwiR9W5ifuMecpMiHXe860rPKQFdEMKRjPBXSw==
X-Received: by 2002:a5d:4891:0:b0:21b:88c9:69ae with SMTP id g17-20020a5d4891000000b0021b88c969aemr33083557wrq.84.1657031653998;
        Tue, 05 Jul 2022 07:34:13 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id bd16-20020a05600c1f1000b003a18ecfcd8csm14156383wmb.19.2022.07.05.07.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 07:34:13 -0700 (PDT)
Message-ID: <ae8feec0-3c0f-d4f4-64e9-588df2d02d24@isovalent.com>
Date:   Tue, 5 Jul 2022 15:34:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: libbfd feature autodetection
Content-Language: en-GB
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Hao Luo <haoluo@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <aa98e9e1a7f440779d509046021d0c1c@huawei.com>
 <CA+khW7i39MXy4aTFCGeu+85Shyd47A+0w5EAA5qL7v+n4S74dA@mail.gmail.com>
 <6f501b451d4a4f3882ee9aa662964310@huawei.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <6f501b451d4a4f3882ee9aa662964310@huawei.com>
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

On 01/07/2022 08:10, Roberto Sassu wrote:
>> From: Hao Luo [mailto:haoluo@google.com]
>> Sent: Thursday, June 30, 2022 7:29 PM
>> Hi Roberto,
>>
>> On Thu, Jun 30, 2022 at 6:55 AM Roberto Sassu <roberto.sassu@huawei.com>
>> wrote:
>>>
>>> Hi everyone
>>>
>>> I'm testing a modified version of bpftool with the CI.
>>>
>>> Unfortunately, it does not work due to autodetection
>>> of libbfd in the build environment, but not in the virtual
>>> machine that actually executes the tests.
>>>
>>> What the proper solution should be?
>>
>> Can you elaborate by not working? do you mean bpftool doesn't build?
>> or bpftool builds, but doesn't behave as you expect when it runs. On
>> my side, when I built bpftool, libbfd was not detected, but I can
>> still bpftool successfully.
> 
> Hi Hao
> 
> in Github Actions, the build environment has support for
> libbfd. When bpftool is compiled, libbfd is linked to it.
> 
> However, the run-time environment is different, is an ad hoc
> image made by the eBPF maintainers, which does not have
> libbfd.
> 
> When a test executes bpftool, I get the following message:
> 
> 2022-06-28T16:15:14.8548432Z ./bpftool_nobootstrap: error while loading shared libraries: libbfd-2.34-system.so: cannot open shared object file: No such file or directory
> 
> I solved with this:
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index e32a28fe8bc1..d44f4d34f046 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -242,7 +242,9 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
>  		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/			       \
>  		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/		       \
>  		    LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/			       \
> -		    prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install-bin
> +		    prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install-bin	       \
> +		    FEATURE_TESTS='disassembler-four-args zlib libcap clang-bpf-co-re'	\

(disassembler-four-args can probably be removed too, the file using it
shouldn't be compiled if libbfd support if not present.)

> +		    FEATURE_DISPLAY='disassembler-four-args zlib libcap clang-bpf-co-re'
> 
> but I'm not sure it is the right approach.

Hi Roberto,

I don't think we have another solution for intentionally disabling
bpftool's feature at build time at the moment. For the context: I
submitted a patch last week to do just this [0], but in the end we
preferred to avoid encouraging distributions to remove features.

But I agree it's not ideal. We shouldn't have to pass all existing
bpftool's features to the selftests Makefile.

Daniel, what would you think of an alternative approach: instead of
having variables with obvious names like BPFTOOL_FEATURE_NO_LIBCAP, we
could maybe have a FEATURE_IGNORE in bpftool's Makefile and filter out
its contents from FEATURE_TESTS/FEATURE_DISPLAY before running the
tests? Given that features can already be edited as in the above patch,
it wouldn't change much what we can do but would be cleaner here?

Quentin

[0]
https://lore.kernel.org/bpf/CACdoK4LTgpcuS9Sgk6F-9=cP09aACxJN4iTXJ=39OohPcBKXAg@mail.gmail.com/T/#t
