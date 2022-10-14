Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E675FF2A7
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 18:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJNQzp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 12:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiJNQzn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 12:55:43 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A7B43311
        for <bpf@vger.kernel.org>; Fri, 14 Oct 2022 09:55:42 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id t21-20020a056a0021d500b0056358536cdeso3182019pfj.22
        for <bpf@vger.kernel.org>; Fri, 14 Oct 2022 09:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lwQ6+sA3W7MWd0vYC/9HRNB0kdytHGubSeaFZENr5nY=;
        b=GVIG8x8OIpWYulN7VSMqXxVDEKoHPUOUkR+1sTLzVXThxcghyxLdwMVke3uKtdLYbl
         ZWwN6u60+DEMLfyE081V/ryY7alg8/yQ7heFroiJeCU8Ry4EYZL34K2PiA3jQ4+B/Z/b
         lttRUGdvS2KgrwID001oZQuIYNAcD9RPud0MtUIRwPCgA0U+jsRnzPpAH3HM/xBXQbvv
         iz2gucrGsBF9UAVNQOQ6Jrf0vqGL+gW+At4aN47DnXGv8HTBvujw2+C4sMEyapiYzN0T
         6hbpFJS1BY8Z0dM3zHjXsKkngnOnc2TK2kRWP4FJOIljEaeJFRq09jv3JSZimTmLyTnu
         jmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwQ6+sA3W7MWd0vYC/9HRNB0kdytHGubSeaFZENr5nY=;
        b=EEw2G5Y9wzZzLnt3ZVVl83QZwzVUmm+aDFcrwfRqZ0twHwfOVgpDPBz2HEnIrEICRg
         IavnoE74x0lcWFS6U60e+DFiWsDVuTmTVD1G4ciNsW5UbC2DcBynf2B/6XqClIJIyqVO
         CF0nQaIp+Jc+EN5LPG+IM0cC1l3dFH1L69nrSL2GHFQjjrJgrKcWc7hY7+xWA4zLfcCw
         AKYfppRoa3xwJ05eDAIKsSQYyEziC2SWcmkhS7wkWceo04IJjy3B6Ak1ixDjGJ+zIikl
         TP3rYOok16AApzNdPY/swxYYsl8f+JTdgeE1ZTKnpXekUqjO+LUjr8J4CxgM7Puh3Hbn
         +JjA==
X-Gm-Message-State: ACrzQf0ye/HtoYesgakoabf4O2I+5tDhrjKi55h+Qjnzdx4WnkI9p/oe
        h7aPJC3girZazl6yU6Y2Bk6UyTk=
X-Google-Smtp-Source: AMsMyM5U/qSXWm55jZSu6FKaWYtQ898xkpZOYAX7yp++hCg6q20IswAvnpoh6urdHCwwISyhttKtq+4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:8607:0:b0:53b:13b5:2b6a with SMTP id
 p7-20020aa78607000000b0053b13b52b6amr6299861pfn.52.1665766541868; Fri, 14 Oct
 2022 09:55:41 -0700 (PDT)
Date:   Fri, 14 Oct 2022 09:55:40 -0700
In-Reply-To: <04d2eb4a-7365-495a-ab74-704febac2789@app.fastmail.com>
Mime-Version: 1.0
References: <20220715115559.139691-1-shaozhengchao@huawei.com>
 <20220914111936.19881-1-oss@lmb.io> <CAKH8qBujKnFh8_g+npxHpo7RGFshus3N0iysmVBohTtG1X2yow@mail.gmail.com>
 <5a3c5ea9-d557-6070-d778-1092f3c51257@huawei.com> <aec8ef40-260c-4ded-b806-d381a3075ff0@www.fastmail.com>
 <c416473b-af8b-3bf6-7ede-e1198b3496f5@huawei.com> <bc69e8a3-d474-451f-853e-1c936f776ef9@app.fastmail.com>
 <cf6a99a1-e77f-113d-101a-5b5a52111df5@huawei.com> <04d2eb4a-7365-495a-ab74-704febac2789@app.fastmail.com>
Message-ID: <Y0mUjLXEpVuheSUc@google.com>
Subject: Re: [PATCH v4,bpf-next] bpf: Don't redirect packets with invalid pkt_len
From:   sdf@google.com
To:     Lorenz Bauer <oss@lmb.io>
Cc:     shaozhengchao <shaozhengchao@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/14, Lorenz Bauer wrote:
> On Thu, 13 Oct 2022, at 11:44, shaozhengchao wrote:
> > 	Sorry, I haven't fully understood your intentions yet.
> > Can you explain it more detail?

> I'll try! Roughly, we do the following:

> 1. Create a BPF_PROG_TYPE_SOCKET_FILTER program that just returns 0
> 2. Load the program into the kernel
> 3. Call BPF_PROG_RUN with data_size_in == 14

> After your bugfix, it seems like step 3 is rejected due to data_size_in  
> == 14. We had to increase data_size_in to 15 to
> avoid this, see [0].

> This breaks user space, so it would be great if you could fix this in a  
> way that doesn't refuse BPF_PROG_RUN with

[..]

> data_size_in == 14. Since I don't understand the original problem very  
> well I can't tell you what the best fix is however.

The problem was that we were able to generate skb with len=0 via
BPF_PROG_RUN. Prohibiting those cases breaks backwards compatibility, so
we either have to:

a) (preferred?) accept inputs with <14, but maybe internally pad to 14
bytes to make the core stack happy
b) revert the patch and instead have length checks at runtime; doesn't seem  
to
be worth the penalty in the forwarding path because of some corner cases
like these ?


> 0:  
> https://github.com/cilium/ebpf/commit/a38fb6b5a46ab3b5639ea4d421232a10013596c0

> Thanks
> Lorenz
