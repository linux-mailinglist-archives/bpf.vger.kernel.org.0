Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BAD4F9766
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 15:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbiDHN6U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 09:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbiDHN6U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 09:58:20 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7587A27FE1
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 06:56:16 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id x4so10646557iop.7
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 06:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jrw2vXbbJ+SLz6O31zbsVVFLo++RRvLeVIS2iJ94tDM=;
        b=vCqaiJPIMIk4983NrHJgZqbKK2fXM4sZlfx2DYT37wCfR2r0R6t+kuSn6Pyacvx7FU
         a/YY91MCrJ+X8czEi063anrne79fWzLr42ZHZqdp0OW9FdtXgWAcHgcwPBuJNIh3RdDN
         gBqkjfxOjyrrZ+l+nn8l+868DBOL+TqZGgSMsbIHr+ToibypICbF9FAFeHWg0DDyPUgL
         ItgaJEkDCfjd5aXRVxwksEAKQAlLKwyPv/W/Fec/MEexgK387FcsFWlUNnrjXYcznn8z
         OoHDIzp7XDaIf/QRZT91stKoSoC++c2kDkgc6kNhBTZ/LqJghBPsenW6Ma4KLILcMn6a
         j8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jrw2vXbbJ+SLz6O31zbsVVFLo++RRvLeVIS2iJ94tDM=;
        b=JCgOrmt7ojBx2qNNRr3ojr/ScwlGVsLcNMI5WWc96LsgDzgSq6U+NbzlPKPeWbjoQF
         tWGvk59E2RJHy0ObUqhMl/o3keE5FQ2jGlX0EExaGGnKMOje3KkNPc2zwYEIXKIVmaST
         h0ZomcwQO9jOP3UN4CvaiSVFvi0q3rJVV+nO6kj/IZjsWKHiA73f3pKbcf0OETGBMGBD
         EhIjl//K9GP512n4VjORx8ly4LOhiyAA3w4XU8GrdHBzMQFxEGP5pqkrltX16UDnzDMI
         6LQwUSm1nYbxISEQcMlPZEdqQvKYdykeOEGw85yHz6R3lRRiSCZMfHGDuep1lNF5/FmW
         UWMw==
X-Gm-Message-State: AOAM533y1AoPtkb/LueKTlggv4LcI7Wzk7loMdcSnUT+VJzw7yFrrVB0
        vbk8s7ULvz/+/d+C72vSnbO6Cnft3Cii1OIb6yXm8w==
X-Google-Smtp-Source: ABdhPJy1UKYGthAvyTDr4s4UcaQeyvUNorizUpLS0GEvOAH5geuz+Tk57PugW6f2JGv/PPjwmez3dpHfMA1MV+K2Dhs=
X-Received: by 2002:a05:6602:2c0b:b0:63d:dfb2:9a95 with SMTP id
 w11-20020a0566022c0b00b0063ddfb29a95mr8711393iov.93.1649426175934; Fri, 08
 Apr 2022 06:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220322154231.55044-1-fankaixi.li@bytedance.com>
 <20220322154231.55044-4-fankaixi.li@bytedance.com> <20220324193755.vbtg2dvi4x3rysx2@kafai-mbp>
 <CAEEdnKFbq=TpmrXtFi8A-pPcLS-pRS2TT_726v7S52XMX6crQA@mail.gmail.com>
 <CAEEdnKH2g0gZ5y2x_1BCK1MHt6_r=_RLw18=apbwpn9+Thi7nA@mail.gmail.com> <20220407175333.tnmk4am3hzpfhept@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220407175333.tnmk4am3hzpfhept@kafai-mbp.dhcp.thefacebook.com>
From:   =?UTF-8?B?6IyD5byA5Zac?= <fankaixi.li@bytedance.com>
Date:   Fri, 8 Apr 2022 21:56:04 +0800
Message-ID: <CAEEdnKFC9ZYHydSLd4=0ose4sMBqJJ1cDs8N5HYT=BRdKp8_xA@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 3/3] selftests/bpf: add ipv6 vxlan
 tunnel source testcase
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     yhs@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, bpf@vger.kernel.org, shuah@kernel.org,
        ast@kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <kafai@fb.com> =E4=BA=8E2022=E5=B9=B44=E6=9C=888=E6=97=A5=
=E5=91=A8=E4=BA=94 01:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Apr 06, 2022 at 04:03:32PM +0800, =E8=8C=83=E5=BC=80=E5=96=9C wro=
te:
> > Hi Martin KaFai Lau and Yonghong,
> >
> > I have prepared v3 patches for tunnel source ip feature. Some obviously
> > errors have been fixed. But there are three problems left. They makes m=
e
> > copy tunnel test cases and put tunnel source ip test codes into them.
> > I put these three problems here:
> >
> > I have tried to use bpf_printk in bpf kernel code. But the object file =
could
> > not be loaded by tc filter command. There are .relxxx section such as
> > .relgre_set_tunnel in the output of objdump.  The tc filter says it cou=
ld
> > not find the dedicated section.
> > So I still use bpf_trace_printk now.
> >
> > I have tried to use a bpf map "local_ip_array" to store tunnel source i=
p
> > address. Userspace code change tunnel source ip by updating map
> > "local_ip_array" in the middle of test. Kernel bpf code get the tunnel =
source
> > ip by looking up the map. But the object file could not be loaded by tc=
 filter
> > command also. The verifier says "R1 type=3Dscalar expected=3Dmap_ptr" w=
hen
> > calling "bpf_map_lookup_elem" helper function. I check the assembly cod=
e
> > that the r1 register value is 0 when calling "bpf_map_lookup_elem".
> > I write a tiny bpf loader for this test. But It's too heavy.
> >
> > I have read test cases in prog_tests directory. They use c code to repl=
ace
> > shell command to create network namespace and ping. Also functions like
> > "test_tc_peer__load" are used to load bpf code. It's more complicate th=
an
> > shell commands. And there are many duplicate funtions like create_ns in
> > some files.
> > The code in test_progs.c are common functions not test cases.
> > Maybe we could move tunnel test code to it in the future until the test
> > framework is complete.
> Regarding the "test_tc_peer__load" is more complicated than shell,
> it is the skeleton and a better way to load bpf to do test.
> It makes the user space test easier to write, e.g. the bpf_printk+grep
> for capturing error can go away and replace it with checking some
> bpf's global variables instead.  All newly added tests are using it.
>
> There are examples in prog_tests/ (i.e. test_progs) doing similar things =
as
> the test_tunnel.sh, e.g. creating netns, adding veth, tc filter...etc.
> For example, take a look at tc_redirect.c and how it avoids the tc bpf
> loading issues that you have seen.
>
> The .sh is not run by CI also.  I also only run test_progs regularly.
> I was also not sure if test_tunnel.sh should further be extended, so
> did not mention it.  However, based on the issues you are seeing from
> making common changes to the bpf prog, it is clear that it should be done
> in prog_tests/ (i.e. test_progs) instead.  At least start with the
> two new tests that you are adding in patch 2 and 3 instead of further
> extending the test_tunnel.sh.  That will setup a base to move
> all test_tunnel.sh to prog_tests/ eventually.

OK. Get it. I will move them to test_progs step by step.
Many thanks.
