Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A4F5856F1
	for <lists+bpf@lfdr.de>; Sat, 30 Jul 2022 00:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239540AbiG2WtK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 18:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiG2WtH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 18:49:07 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271B683F35
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 15:49:06 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id e12so2102489qkl.2
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 15:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PHjNC5/MEnwibKTgt66y4B8QHXUMZZ8F7xsD/e5vT8=;
        b=h5vuR3bE9y86uyovtmo+yMSm360p7Vfl+m/49LSoNn6riovGoQldvmVXCT7DMuEA+M
         IxaHvlgpbrKuzx2KC81SJNf6wnUn5SDvFoEVVZT+mYB5ZvGliFP4XHH3cVBpAOFOrFrD
         +HlGmxArwenxwq3vCI6EkqRmtcu2JHfggoQLhMQ02F5fv3eM0WUfr+OfmUW1HqKpsrEW
         u47RbtzG0G/WyvxcmydCuApqYXvYxUxf5TSTMstpcA5rC6TrJdpHCoTL0AWFsqU2NE4N
         cH2+YQIN6Zw7OPF2QJ+/zrQj2UvKU33Fw8i1un0LliOyo9O6HWW/q8wJcqATrNPgKyrY
         JcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PHjNC5/MEnwibKTgt66y4B8QHXUMZZ8F7xsD/e5vT8=;
        b=tQdk8CYo73GiXuDSJ9V3DViy+5rlm5dVlrTAVDKfxqz149gFyjYeRbIvckWSYCZEl8
         bM1XMutqRTz4az7nvKM1G4fDrT/r5siDSqSDs8fMkRseWzC/go7o/gakJiABu5mqiKhf
         y+EHgC1I36q67+GPSi/H3jRNF/6f1NAAK3G+wQ3uLsxhqCpyonXVnErk4ozULkNafBMT
         hK52Mbrtt4jIOcbs6m6JouOGFmpjsKwOmbpwdvv5rhOTHYz8iqKKOWZkP0m08Tks5k+v
         qQFwlgs/gtjU3quGf6Toigi7S6seoPgF6sL0lApdWbRJqfPcdmaBfoHvk3wHny2rWYwv
         GEpQ==
X-Gm-Message-State: AJIora/jdlcHYTXmt2DP+AjO+BEQiyQCRrZszTJjUVzsYz8ZMOXtePd4
        GbtNEmbA5UgWt8A4zj9lM8ElU52Kj8QD7ZABgvL5AQ==
X-Google-Smtp-Source: AGRyM1uerL6gJ1ZFWTeneCIa8WSwBLci00q0rhU6N0/noz4neg/CzP0j0yv4ifJ1Sjs4tut+nLC5fMrK/suZn65SJSU=
X-Received: by 2002:a05:620a:f0e:b0:6b5:48f6:91da with SMTP id
 v14-20020a05620a0f0e00b006b548f691damr4443449qkl.446.1659134945084; Fri, 29
 Jul 2022 15:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+khW7iknv0hcn-D2tRt8HFseUnyTV7BwpohQHtEyctbA1k27w@mail.gmail.com>
 <20220729224254.1798-1-liulin063@gmail.com>
In-Reply-To: <20220729224254.1798-1-liulin063@gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 29 Jul 2022 15:48:54 -0700
Message-ID: <CA+khW7iLeSZPweZEz_tfP+LRtpvZbfvstZWgUbNrEDK-Ntxyxw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Do more tight ALU bounds tracking
To:     Youlin Li <liulin063@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 29, 2022 at 3:43 PM Youlin Li <liulin063@gmail.com> wrote:
>
> In adjust_scalar_min_max_vals(), let 32bit bounds learn from 64bit bounds
> to get more tight bounds tracking. Similar operation can be found in
> reg_set_min_max().
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

Looks good to me. Thanks Youlin.

Acked-by: Hao Luo <haoluo@google.com>

Hao
