Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F435106CE
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 20:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbiDZS2F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 14:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351241AbiDZS2E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 14:28:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883DC197FBA
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 11:24:56 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c12so30992107plr.6
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XtzYzShMVyd+kyzwCJxTHJDRp0RuH/SYetmF/PF7R9M=;
        b=jNr5yb/P/y1J3TS8LV+BN4FcQEgoS9CftoHtqJV1h9zTBJKh8QoriNgM8BaQF/blKg
         3Cyd0OBaTieIbYYgcBtRUU0qN3IiHbPmhM4wZd29bqWNOYgeGj/tP/L1Wdsfac/F729w
         sxGoBuWv+h5lHXuaa4Vm4YR6ag0YCEeBw8azTwYtgC7RoAo/bOrJqtPsP4LRNTX4m8uC
         +vikv2W6OKm49RoApnu1+tM2ycOHWob9nWtbfkXNlecJ4uFv2lM0usbOl3mG22pSlyOC
         7JQO4CKk+tK8jkqplPC4PVW6GbIermVxJZLCPNzO8Y4eQyhLeHlIF0Q7pCgDDh6XX5hd
         532Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XtzYzShMVyd+kyzwCJxTHJDRp0RuH/SYetmF/PF7R9M=;
        b=YgvuqMV5KQSsK5D0ziNzU6Qrg3qMfJRapeN+/4RwnAXVuSSAZ+Y6deDsFyIGknInR+
         B3bvPwdyQrd2fV5FAKCk97TCblybSVhTcF6e47ukhaGNXSr9e++VPi4MDz/XyYJ36Ywv
         gc65xOPFfbhCHd5Hgaz/VLn/KznU2xVqMVF6mB6sWQ9TaZyP0I+fkdt9MxVHZoR+EfzV
         n9dWIsm3KUVpBHeEDLVbYOQn2DWAIgL4SfiJZVSKCAPo3WYxFKZzUpauk0QRmhuczfw6
         AkS8hLnBmocozRpyo1YinxKgvmp1T7eSPgg1QOCty6GAVKXPOsftXZYaYgTwJiYju6rJ
         mkow==
X-Gm-Message-State: AOAM5303UVkWPlFYl9OHfk4U/qDTeze0JjSh7Nesv1e/2tDRlRc/R8I1
        IK0AWM7iadS1RxNouN3CcK4=
X-Google-Smtp-Source: ABdhPJxYRWuqvcN4i4YI5bA+jjoigEu8vxba9viHECOUCU2WmNd/+2cISNZQmfqh/KuXnm3plIF+Yg==
X-Received: by 2002:a17:90a:df0f:b0:1d9:2372:b55e with SMTP id gp15-20020a17090adf0f00b001d92372b55emr22592933pjb.104.1650997495340;
        Tue, 26 Apr 2022 11:24:55 -0700 (PDT)
Received: from MacBook-Pro.local ([2620:10d:c090:500::2:3e5a])
        by smtp.gmail.com with ESMTPSA id b4-20020a62a104000000b0050cf012cba1sm15970136pff.91.2022.04.26.11.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:24:54 -0700 (PDT)
Date:   Tue, 26 Apr 2022 11:24:51 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kaixi Fan <fankaixi.li@bytedance.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [External] [PATCH bpf-next v5 2/3] selftests/bpf: Move vxlan
 tunnel testcases to test_progs
Message-ID: <20220426182451.jjqo6eifnhz6ptfn@MacBook-Pro.local>
References: <20220422120259.10185-1-fankaixi.li@bytedance.com>
 <20220422120259.10185-3-fankaixi.li@bytedance.com>
 <CAADnVQL9=XivjNeg3CyE67N3cp6xB+cetUhWG6b+DtXo-6x0VA@mail.gmail.com>
 <CAEEdnKFjUQeZGYFF+gAtqEeyCzdz=5A91w-PFgAjsS-nkZ6BXw@mail.gmail.com>
 <CAADnVQL2j-sLdDr+ZRHakKo8SVrKofCq3ffQJ8Fpqvr0gEXHPg@mail.gmail.com>
 <CAEEdnKG-HeAhWrATMTOYKa7_OdKXs4NjrVrQpcxFXSicgNY1mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEdnKG-HeAhWrATMTOYKa7_OdKXs4NjrVrQpcxFXSicgNY1mw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 24, 2022 at 11:32:07AM +0800, Kaixi Fan wrote:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> 于2022年4月24日周日 10:57写道：
> >
> > On Fri, Apr 22, 2022 at 7:51 PM Kaixi Fan <fankaixi.li@bytedance.com> wrote:
> > >
> > > Alexei Starovoitov <alexei.starovoitov@gmail.com> 于2022年4月23日周六 08:37写道：
> > > >
> > > > On Fri, Apr 22, 2022 at 5:04 AM <fankaixi.li@bytedance.com> wrote:
> > > > > +#define VXLAN_TUNL_DEV0 "vxlan00"
> > > > > +#define VXLAN_TUNL_DEV1 "vxlan11"
> > > > > +#define IP6VXLAN_TUNL_DEV0 "ip6vxlan00"
> > > > > +#define IP6VXLAN_TUNL_DEV1 "ip6vxlan11"
> > > > > +
> > > > > +#define SRC_INGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/test_tunnel_ingress_src"
> > > > > +#define SRC_EGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/test_tunnel_egress_src"
> > > > > +#define DST_EGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/test_tunnel_egress_dst"
> > > > > +
> > > > > +#define PING_ARGS "-c 3 -w 10 -q"
> > >
> > > Thanks for the suggestion.
> > >
> > > >
> > > > Thanks for moving the test to test_progs,
> > > > but its runtime is excessive.
> > > >
> > > > time ./test_progs -t tunnel
> > > > #195 tunnel:OK
> > > > Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> > > >
> > > > real    0m26.530s
> > > > user    0m0.075s
> > > > sys    0m1.317s
> > > >
> > > > Please find a way to test the functionality in a second or so.
> > >
> > > Hi Alexei,
> > > Do you mean the sys time should be in a second ?
> >
> > real time.
> > sys time is already there.
> > The big delta between real and sys time highlights
> > inefficiency of the test. The test sleeps most of the time.
> 
> The tunnel test includes many types of tunnel testcases.  Add a new
> tunnel testcase would increase test time.
> So the real time could not be reduced into a second.
> The test code calls many shell commands to setup test environments. It
> may be the reason why there is a big
> delta bettween real and sys time.

Try reducing the number of shell commands.
For example, instead create+teardwon of netns keep it the same across
different tunnel tests and clean up once.

> Reduce the ping packet interval would reduce the real and sys time
> significantly.
> real 0m7.088s
> user 0m0.062s
> sys 0m0.119s

Please try to reduce it further. Clearly all 7 seconds CPU mainly sleeps.
