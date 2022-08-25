Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DDC5A08C4
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 08:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiHYGTo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 02:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiHYGTm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 02:19:42 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19417A0241
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 23:19:42 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g189so2966714pgc.0
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 23:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc;
        bh=fkbcSf2QvoM1v7ga7p3BoCyFgPv97LPNk8LIaDWElhw=;
        b=I1JcOCvbPo289ue9TzwzKwcpIp/sdUMrn3Vg/zg+zOXqRJ/cC3avo5Gvz/idU4KwVU
         lorXTjGxNqOOvLlADm7CIbXftZ+bpos5A0enGg3uJd80aW5WcHF3Tbe/s5cH2fAPcpv2
         tQbALWmyvRqA3AWfc1zrEiuDHbVsX5AvA6NH02akud1jelm7S5CZa/S7tKSN0Uu874kw
         op3VAT2taNi9XhKDAmFNQYBzAyCfiFT5S78sMYsnMdLrEKpXFTuwczx/yql1gkLpcvXp
         LfMtTXCk8zEP3xGgykzzo+oZy5meyMlKZjS5UFEWyUZWyRxkqvi9lkenH1ZNMd9KOp2D
         RYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc;
        bh=fkbcSf2QvoM1v7ga7p3BoCyFgPv97LPNk8LIaDWElhw=;
        b=NcTcna18Z8W/0eiqe7y2ogH/cJ3goCUL3dMt7zMfME9qiq2L3rrGTx/+oQCDAHEz9D
         UkLY3xo50CAWbg3i84fVRTWgRsKb27pppn9oZqTRZoV31F3cC+wSns9AUHNTRYFK7ciI
         lVR03LkcomW+k4oqJ6XIOmrYbVLE+M5LWKTqugnxpqoSwc5VcU5TPJ5JMbhC2z5JRqkw
         BWHQ6f+UDfY0hrRZRGXPCiUINQiZ1WDbe13kY7jqg/yZ/IymvBKJr5/uUHnvRPo070xR
         8JhfzSZ4CWxQGiKsV4rCk7UVOL4iU/ga8bpDuKO9FUqHhWuwE8FlhkgXvP68TSKOPIEk
         eMOw==
X-Gm-Message-State: ACgBeo3TO+EEWU9w4acHbWhgtHR/Ow3xkjcceNe3/WF1gNb1cEnEXGjo
        wU2+8Qjx4+mwB93RD9AmrzGMMYt9USU=
X-Google-Smtp-Source: AA6agR75VHZT33VfNiVGIxvOaYf2thFZuOSLgesUQJfI97z/n4nRvHcivzVLifQjXbKgCNUh7lkDrg==
X-Received: by 2002:a63:834a:0:b0:42b:358f:640d with SMTP id h71-20020a63834a000000b0042b358f640dmr2077971pge.235.1661408381588;
        Wed, 24 Aug 2022 23:19:41 -0700 (PDT)
Received: from localhost ([98.97.36.33])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b0016d773aae60sm13863766plf.19.2022.08.24.23.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 23:19:40 -0700 (PDT)
Date:   Wed, 24 Aug 2022 23:19:39 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Message-ID: <6307147b5c97b_e1c39208d6@john.notmuch>
In-Reply-To: <d9bf2adc-96e6-c6cd-8d69-e381e8568e0b@fb.com>
References: <20220822094312.175448-1-eddyz87@gmail.com>
 <20220822094312.175448-2-eddyz87@gmail.com>
 <63055fa5a080e_292a8208db@john.notmuch>
 <d9bf2adc-96e6-c6cd-8d69-e381e8568e0b@fb.com>
Subject: Re: [PATCH RFC bpf-next 1/2] bpf: propagate nullness information for
 reg to reg comparisons
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
> 
> 
> On 8/23/22 4:15 PM, John Fastabend wrote:
> > Eduard Zingerman wrote:
> >> Propagate nullness information for branches of register to register
> >> equality compare instructions. The following rules are used:
> >> - suppose register A maybe null
> >> - suppose register B is not null
> >> - for JNE A, B, ... - A is not null in the false branch
> >> - for JEQ A, B, ... - A is not null in the true branch
> >>
> >> E.g. for program like below:
> >>
> >>    r6 = skb->sk;
> >>    r7 = sk_fullsock(r6);
> >>    r0 = sk_fullsock(r6);
> >>    if (r0 == 0) return 0;    (a)
> >>    if (r0 != r7) return 0;   (b)
> >>    *r7->type;                (c)
> >>    return 0;
> >>
> >> It is safe to dereference r7 at point (c), because of (a) and (b).
> > 
> > I think the idea makes sense. Perhaps Yonhong can comment seeing he was active
> > on the LLVM thread. I just scanned the LLVM side for now will take a look
> > in more detail in a bit.
> 
> The issue is discovered when making some changes in llvm compiler.
> I think it is good to add support in verifier so in the future
> if compiler generates such code patterns, user won't get
> surprised verification failure.
> 

I agree. Read the LLVM thread as well.
