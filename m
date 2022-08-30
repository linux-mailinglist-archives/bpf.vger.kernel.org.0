Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448885A585D
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 02:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiH3ATZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 20:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiH3ATY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 20:19:24 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5697C742
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 17:19:23 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id j6so3792083qvu.10
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 17:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+IcUApVhhRXn9dL/Sn9lQ7owQd37yO7YZ+ZOj1J1q9c=;
        b=icKnWS+4zvyLBC2dPq3Jw3kDx+SdPoS9gqv5cR59cRvHUjDeKnl06BAse9dQOTFqpF
         t2b8cvzyqfXN+vVN0w94czWiNhW3qigbU7WugRjslUoUPKfjdIZUW6rXaodBZFRE0CUR
         pKyCeWZ/AWqrOj7fO5LOJVIFy/m1hA6HESsMqvYnjYN/yv2BrGjVK44oIxPDNWfC53d1
         nQv0pY0EH7HXyO2cQUfZj2mGZ38D5rem6rasFohmD1kcXB7kfPk+KFCzVmq8u4kKVSX7
         eMKBxZI+sv+z+gCUxC01usErbm/53WD+Oram6DXVcZT/nfI6NrSXKlRUKi4SpOsvZ+fX
         CLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+IcUApVhhRXn9dL/Sn9lQ7owQd37yO7YZ+ZOj1J1q9c=;
        b=f3Asoa6f2km7ibsxZligX0CMhcbtLLgq+HCMGhSyI0EiG0/QWVJnETQzCzycCZZ8dt
         xcaAIkBeK4pScnWqlWdoWyxPr4ClAFL8b+R4skkbaSE36ZcuuFy8w/1f93QkWMvredq8
         hT+4pl125E83lbNVr+/OAXwMHWCtYt+MPMqWg+7mv7Tq3tb/O2gTNkW1AAhbPcB/RbNW
         O/XCv84hvX3Up4UyR0jvZbT8AeiyJRpLYZBF8FWDA6Qw2yddpo2g8wp5tQXkvWEIJdlX
         bQqFOSD/Zf3yMrnaOfFctHPeleNe75LLteHcm3fFf6mZOXB2yYDeYVURACX+J79cKqH4
         Wu6A==
X-Gm-Message-State: ACgBeo2nw4R6ZYDUHPxtz58aVLiortEI/apffpSR2Vc9Nb+Wv1qOCvIt
        6CY5yzuMz1ef9EqWWHd15b/oP0wC5t0bIVaFMydy5g==
X-Google-Smtp-Source: AA6agR4Y3pl4AL6jDWxeFGLq6zw6x354o0nLyKVJpRyFb31x6dDr3vcYj89e35kThJWIY0DkknrAVcJSk1i2Ibm9fiY=
X-Received: by 2002:a05:6214:2267:b0:474:8ff7:a21c with SMTP id
 gs7-20020a056214226700b004748ff7a21cmr13080856qvb.56.1661818762403; Mon, 29
 Aug 2022 17:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <5d2addca-10e5-f7a6-9efd-43322eec8347@iogearbox.net> <20220827135711.21507-1-liulin063@gmail.com>
In-Reply-To: <20220827135711.21507-1-liulin063@gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 29 Aug 2022 17:19:10 -0700
Message-ID: <CA+khW7hb5GgeT_ph_OijXR6F3oYRqsEV=SDvzShmwYCnFdUqjw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Do more tight ALU bounds tracking
To:     Youlin Li <liulin063@gmail.com>
Cc:     daniel@iogearbox.net, ast@kernel.org, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Youlin,

On Sat, Aug 27, 2022 at 6:57 AM Youlin Li <liulin063@gmail.com> wrote:
>
> In adjust_scalar_min_max_vals(), let 32bit bounds learn from 64bit bounds
> to get more tight bounds tracking. Similar operation can be found in
> reg_set_min_max().
>
> Note that we cannot simply add a call to __reg_combine_64_into_32(). In
> previous versions of the code, when __reg_combine_64_into_32() was
> called, the 32bit boundary was completely deduced from the 64bit
> boundary, so there was a call to __mark_reg32_unbounded() in
> __reg_combine_64_into_32(). But in adjust_scalar_min_max_vals(), the 32bit
> bounds are already calculated to some extent, and __mark_reg32_unbounded()
> will eliminate these information.
>
> Simply copying a code without __mark_reg32_unbounded() should work.
>
> Also, we can now fold reg_bounds_sync() into zext_32_to_64().
>
> Before:
>
>     func#0 @0
>     0: R1=ctx(off=0,imm=0) R10=fp0
>     0: (b7) r0 = 0                        ; R0_w=0
>     1: (b7) r1 = 0                        ; R1_w=0
>     2: (87) r1 = -r1                      ; R1_w=scalar()
>     3: (87) r1 = -r1                      ; R1_w=scalar()
>     4: (c7) r1 s>>= 63                    ; R1_w=scalar(smin=-1,smax=0)
>     5: (07) r1 += 2                       ; R1_w=scalar(umin=1,umax=2,var_off=(0x0; 0xffffffff))  <--- [*]
>     6: (95) exit
>
> It can be seen that even if the 64bit bounds is clear here, the 32bit
> bounds is still in the state of 'UNKNOWN'.
>
> After:
>
>     func#0 @0
>     0: R1=ctx(off=0,imm=0) R10=fp0
>     0: (b7) r0 = 0                        ; R0_w=0
>     1: (b7) r1 = 0                        ; R1_w=0
>     2: (87) r1 = -r1                      ; R1_w=scalar()
>     3: (87) r1 = -r1                      ; R1_w=scalar()
>     4: (c7) r1 s>>= 63                    ; R1_w=scalar(smin=-1,smax=0)
>     5: (07) r1 += 2                       ; R1_w=scalar(umin=1,umax=2,var_off=(0x0; 0x3))  <--- [*]
>     6: (95) exit
>
> Signed-off-by: Youlin Li <liulin063@gmail.com>
> ---

It might be better to put the code that performs the actual bounds
deduction into a helper function. It avoids code duplication. But the
current version looks fine to me. Thanks for the patch!

Acked-by: Hao Luo <haoluo@google.com>
