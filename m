Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1B6E2844
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 18:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjDNQ0P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 12:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjDNQ0L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 12:26:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2893580
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 09:26:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id bi22-20020a05600c3d9600b003f0ad935166so2748443wmb.4
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 09:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681489569; x=1684081569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QVqsv1za6e/zUOVKQjprn3HsPAV78HFDgrrmzoZ9Dc=;
        b=b27QUfzW9ra/5AcL1P5rBfo4qxN0/GWFGbqsnR360Ol3PO2RPDv9wVeF6JWQkOt4qu
         hzKA4vsvNdmsbJRJd4NxBYn6mSPwCmoCEu/rUt8KKXvkW4DKqNy+MRbF02MlGFqG4L79
         /oFQ6vAx+HBAqoVYruIEFJ2wPTvX6M826vqPEzRc0FHrQ7fYlXFkTXoBdRmlhnnsUIVY
         V+3fHEL9nHdwYqygAVRv5nBOx5Bu4ggGrjJDf2CVP0KmLhhIJL5tlXyoCEaVKJwOBq05
         wlDjf1ujelRZmmk7sdFkUNG6+Dqk0QPbe+KjSfKWIXDU/8eyn4w/ycpDKQCcjHLK5znT
         Mawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681489569; x=1684081569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QVqsv1za6e/zUOVKQjprn3HsPAV78HFDgrrmzoZ9Dc=;
        b=IGl4ulh9rVeug5n8ulMJoWRnSr08X3C/44PlzqRRqALkbV2/TLSgKcj4I3OMLpJGxX
         d7mVHJJLd2MAWNasGNMtWras96259uf4uftXTmjZ/a2Gyjr9yTHrLeJthxA8C3/QpR/W
         i9Zzo4e61/i2iSFikT9ZjZNvUbBjfn1LVP31ShyC2+OMqjgaShoIp4RMoqC1dnj27nBQ
         sonJwimir2Zz6G09xjkLXMx9J5CiimQCgS6ThY1UhdD79/A8J3axNYQU8cSGj9TSjdDC
         prUtJkCj/tegwpIiTb6563w/WBd5Wym+/BYov/l3c+y+Bg7ob48/tUmy6BhdSS2ISTj9
         qx+A==
X-Gm-Message-State: AAQBX9fIJjkHvnhOZ+8VO84mZ2NaDLXlX/2DZB0ywR46Nh8BMPCU2htJ
        1YJjS80TEoY3h0UfSmev7Fuf5A==
X-Google-Smtp-Source: AKy350YxXdZgZk/cK4PxdX2uBWEPg6+suyNNMrpWNoX5GHykqZnQ/n20jTwpBzW/MGM1rePCQnTSng==
X-Received: by 2002:a7b:c7c7:0:b0:3f0:7db5:607e with SMTP id z7-20020a7bc7c7000000b003f07db5607emr4714057wmk.37.1681489568683;
        Fri, 14 Apr 2023 09:26:08 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:d040:969c:6e8e:e95d? ([2a02:8011:e80c:0:d040:969c:6e8e:e95d])
        by smtp.gmail.com with ESMTPSA id l10-20020a7bc34a000000b003eeb1d6a470sm4628669wmj.13.2023.04.14.09.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 09:26:08 -0700 (PDT)
Message-ID: <c8168a87-7c98-caf9-5bf3-5779120b3121@isovalent.com>
Date:   Fri, 14 Apr 2023 17:26:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: LLVM not detected in bpfutil due to LLVM 16 requiring c++17
Content-Language: en-GB
To:     Nathan Chancellor <nathan@kernel.org>,
        No Name <xbjfk.github@gmail.com>
Cc:     linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        llvm@lists.linux.dev, bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <CALS7K9V1j6ufrQ=6nGjyHQCWb7-YiqNdctBWk8og1gW_q4C4dA@mail.gmail.com>
 <20230414154333.GA1931632@dev-arch.thelio-3990X>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230414154333.GA1931632@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Nathan, Reagan, thanks for the report and CC,

2023-04-14 08:43 UTC-0700 ~ Nathan Chancellor <nathan@kernel.org>
> Hi Reagan,
> 
> On Fri, Apr 14, 2023 at 10:36:35PM +1200, No Name wrote:
>> This is my first time reporting a bug, so apologies if I get something wrong.
> 
> Thanks for the report! "See something, say something", even if it is not
> quite right out of the gate, we can get down to the bottom of it.
> 
>> In tools/build/feature/Makefile, line 342, the c++ std is set to
>> gnu++14, whereas LLVM 16 now requires c++17 to include the headers.
>> This results in the llvm feature being falsely disabled for bpfutil.
> 
> I cannot find any reference to bpfutil either in tree or when doing a
> web search, did you mean bpftool? I am going to assume yes, so I have
> gone ahead and added Quentin (the maintainer of bpftool in MAINTAINERS)
> and bpf@vger.kernel.org to the thread.
> 
>> Perhaps the --cxxflags, --ldflags and --libs options of llvm-config
>> should instead?
> 
> The tools system is pretty much Greek to me, so I am hoping someone else
> will have a better idea of what is going on and how to fix it.
> 
> For the record, I think I see the issue you are talking about on Fedora,
> which has clang-16, whereas I do not see the same issue on Arch Linux,
> which still has clang-15.
> 
>   $ clang --version | head -1
>   clang version 15.0.7
> 
>   $ make -C tools/bpf/bpftool -j(nproc) -s
> 
>   Auto-detecting system features:
>   ...                         clang-bpf-co-re: [ on  ]
>   ...                                    llvm: [ on  ]
>   ...                                  libcap: [ on  ]
>   ...                                  libbfd: [ on  ]
> 
> compared to
> 
>   $ clang --version | head -1
>   clang version 16.0.0 (Fedora 16.0.0-1.fc39)
> 
>   $ make -C tools/bpf/bpftool -j(nproc) -s
> 
>   Auto-detecting system features:
>   ...                         clang-bpf-co-re: [ on  ]
>   ...                                    llvm: [ OFF ]
>   ...                                  libcap: [ on  ]
>   ...                                  libbfd: [ on  ]
> 
> This is the output of tools/build/feature/test-llvm.make.output on my
> machine, which seems to confirm that the headers expect to be compiled
> with '-std=c++17', but that is just a superficial observation at this
> point.
> 

+Cc Arnaldo, as I believe perf uses the 'llvm' feature as well.

I noticed the same on my machine some time ago, but haven't investigated
yet. The error I get in test-llvm.make.output seems to be exactly the same.

I confirm I can fix detection by using '-std=c++17' instead. It looks
like the version was bumped earlier in commit d0d0f0c12461 ("tools: Bump
minimum LLVM C++ std to GNU++14").

Reagan's suggestion to use '$(shell $(LLVM_CONFIG) --cxxflags)' instead
of specifying the standard manually works as well on my setup, and looks
cleaner to me. But I'm not sure of the impact this change would have,
and if it might break other setups.

As far as I could find, perf and bpftool are the only users for this
feature?

Quentin

