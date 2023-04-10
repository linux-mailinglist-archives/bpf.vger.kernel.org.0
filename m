Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EA36DCA2A
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 19:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjDJRqy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 13:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDJRqs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 13:46:48 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29A41710
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 10:46:47 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id bl15so4774360qtb.10
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 10:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681148807; x=1683740807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mrRs31phPA5+DqSUyElWajujtWs9Dd7GGSnY/zYetkM=;
        b=VwnXDVPatIWWwJK2q5z9pQW43jY8PltN6Qt0QGOIxHjmyqst5fBxAzJcSb4q2KkL3j
         JFpeTA29tCCCF25biEgvFpn6bLygwXi3a4lcUXMUrhV8TKvUebt0r7iX7/EjOmxLmbjt
         bS/HSeHythMv0T2JR6glYLZIvFBFiBvUX/nDrQD2/OKhBhibtbXqUutraGaQsBT2ES/p
         jzIBs5v9/5kJFCXs+5u4zCyE2NL2TLM/w5r6rEbl6rIUQP4VlWYU2hX0Tc261eQd3TcE
         OwuO7jsUFiqLbmB/20BAGX4iDYnyPOzsUgu6qMNLvajRuaPkcJZIWCRZ4+gf8V/UnR/3
         IDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681148807; x=1683740807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mrRs31phPA5+DqSUyElWajujtWs9Dd7GGSnY/zYetkM=;
        b=lNg4Cu7S5idVrNf0oI9yZckha1ynCt9JQ1mdTj+g5BCQs8QW/yMFNaVwB2sVBPB+LD
         9iS8UYyuFUfAwad5jWT9h5qbWQe/Q2sY3MUAzUmqhV73vwzrHhnamw/TVF9sZIvnfVtf
         k4BXn5jFXlO3scrRg5wAqFMqK3f1WBi+4bZFj0w9k6FfF9RsEmedbTPGrlmDYhhz6c4i
         VlawCCt7iXHdmoxQLlqQXG+USCg9x7bcXPgeIW/gdrzx6jQBIHmWHqgcbK/bthP/TAMQ
         xE5rhkj/ROzI7XFTCHuDxP7LapAaTTBEg17/6zC+bknfGlLOxJT19+tIEfQqG/EOXvpm
         9pWg==
X-Gm-Message-State: AAQBX9dPwxnJUx2VCrIgCEuiVOxaCf+hkREjWYv6Xf66EONCP2xhOtzU
        SX3Ci4yz7MftFvxXeOYCFLLvGCveH31OGkD3703keg==
X-Google-Smtp-Source: AKy350alS310Ba3Y0g4aJrVyPIfeiBYeZphbBmgxcjnfZMp/B1nPxBr1Bw1UgEaDEbQVMSYH5/ZR8g==
X-Received: by 2002:a05:622a:30a:b0:3bf:d0c7:12df with SMTP id q10-20020a05622a030a00b003bfd0c712dfmr17468869qtw.63.1681148806677;
        Mon, 10 Apr 2023 10:46:46 -0700 (PDT)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id 20-20020a370b14000000b0074680682acdsm3420790qkl.76.2023.04.10.10.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 10:46:46 -0700 (PDT)
Message-ID: <b4cb3423-b18d-8fad-7355-d8aa66ccfe4c@google.com>
Date:   Mon, 10 Apr 2023 13:46:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: inline ASM helpers for proving bounds checks
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org
References: <1d286b16-4d57-d667-e62c-00d6cb0d956d@google.com>
 <CAEf4BzY8QnPqv7Sn0RYkf4exfQ_dEHtHejLkHJyx2swq4LAs4w@mail.gmail.com>
From:   Barret Rhoden <brho@google.com>
In-Reply-To: <CAEf4BzY8QnPqv7Sn0RYkf4exfQ_dEHtHejLkHJyx2swq4LAs4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-18.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/28/23 17:32, Andrii Nakryiko wrote:
> This one looks pretty useful and common (especially to work around
> Clang's smartness). I have related set of helpers waiting it's time,
> see [0]. I'd say we should think about some good naming of them,
> document them properly (including various gotchas), and include them
> (initially) in bpf_misc.h and start using them in selftests. 

sounds good to me.

any preference for a name?  bpf_index_array()?
- no need to say "bounded".
- want to begin with bpf_.
- sticking with your clamp style, "index" would be the verb.  (instead 
of e.g. bpf_array_index, which sounds like it has something to do with a 
BPF array".

i'm up for anything though.  =)

> yeah, I'm hesitant about this one. It is very similar to
> bpf_clam_xxx() macros I referenced above, probably we should use those
> instead.

totally agree.  i can switch my stuff to use the clamp, which covers all 
of the use cases/signedness.  btw, good to know the "s<" is 
signed-less-than.  i imagine i'd have had trouble with that.  =)

thanks,

barret


