Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34AD509E88
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 13:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378812AbiDULaZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 07:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiDULaZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 07:30:25 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3843622502
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 04:27:36 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e194so4906184iof.11
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 04:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nuH1MZCWqf03V9B/hvn0N6YSO4WZWCXvLqj8XbCk/30=;
        b=LedFieKt5zaRua5zqKOnwccQggAo3KbJfnn2AWzNhiUo1OZP8vbLPdvrEeYtewBcX2
         qm8vU+G32yNjhKXPklBEx/MI3yKyGPJNLPAybUAdB7wAyvqP519HqOsJd4SMHAsuRp8S
         0TEX8ht3SLDQuFqkdJor1mftcMhGbYyApbSUiQNvGtwWvNBYrDHwp1ls9jjX7VXLr/qR
         zaCFne7okSyIfA8oK1qYkXkx4y8gyPkXWmqzmPONezrHWYfkrTvho51Qt9lz1AZSv+Js
         3OEyy1latM2PZ3CCoLwAYncxsjrfHEl1wq/HG7WNwSeThv87w3s893oHVkqMTUI54Xev
         bs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nuH1MZCWqf03V9B/hvn0N6YSO4WZWCXvLqj8XbCk/30=;
        b=3riw7ENDqKhDdYaz8z9u3aH4qFTqVvXe4KGcPAXGPTr8hpoNvXXNOnMmMeIliNxtzV
         wEFIaz1C4HCJloL+csDOsPdhQU9IaH6NahQXk/dFzuWzRirmxxEhaSRJl4GWpSv8vd65
         o5/vQ3B3G2aj/27cE9Vm2lWwXwLpUXBNvP4cRYByTz3/Zf8mXVF+/ENF0MSQE6ARsSmc
         42EXzKReZD/tFEZZMdgxdlqa4kbO7V+D1/meMNc+c92ZbkWQT92qFOWijv6wNAIVt9QK
         72jvpSK+IdMiA0y2BJuTXKGCIPzNcLucZFXoODQXrsQ5osNIXOf1r6Y2sufjX+A3sltk
         oFFw==
X-Gm-Message-State: AOAM533A42hYXJvCG8h8NYzIAFkwB2l1Zl/dJMimv6l+7K7ZHqaSSfSc
        nx54wly2JfJ5/SkQiCp6UemkIH3etNkM0gh5udJAig==
X-Google-Smtp-Source: ABdhPJwv84nw6c8fF2RM45atO5hGkMc9qNM89LL2CfS5ORffdwdY75LTHPoUL6/t7IsIt1uvfArLkRXsZL6JZcz7L2c=
X-Received: by 2002:a5d:8b45:0:b0:641:2e54:7367 with SMTP id
 c5-20020a5d8b45000000b006412e547367mr10675957iot.20.1650540455689; Thu, 21
 Apr 2022 04:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220322154231.55044-1-fankaixi.li@bytedance.com>
 <20220322154231.55044-4-fankaixi.li@bytedance.com> <20220324193755.vbtg2dvi4x3rysx2@kafai-mbp>
 <CAEEdnKFbq=TpmrXtFi8A-pPcLS-pRS2TT_726v7S52XMX6crQA@mail.gmail.com>
 <CAEEdnKH2g0gZ5y2x_1BCK1MHt6_r=_RLw18=apbwpn9+Thi7nA@mail.gmail.com>
 <20220407175333.tnmk4am3hzpfhept@kafai-mbp.dhcp.thefacebook.com>
 <20220415231155.GA9900@bytedance> <CAEf4BzbFT1Sdb4fijyU4WELP64rX1K8dWwMu6CDcDkMXTwqHfQ@mail.gmail.com>
 <20220420175407.GA22312@bytedance>
In-Reply-To: <20220420175407.GA22312@bytedance>
From:   =?UTF-8?B?6IyD5byA5Zac?= <fankaixi.li@bytedance.com>
Date:   Thu, 21 Apr 2022 19:27:24 +0800
Message-ID: <CAEEdnKEVkXyUH1z+cROAQ+FUuc_FNWkJFTkKpePvBXccihn=tw@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 3/3] selftests/bpf: add ipv6 vxlan
 tunnel source testcase
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Peilin Ye <yepeilin.cs@gmail.com> =E4=BA=8E2022=E5=B9=B44=E6=9C=8821=E6=97=
=A5=E5=91=A8=E5=9B=9B 01:54=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Andrii,
>
> On Wed, Apr 20, 2022 at 10:09:59AM -0700, Andrii Nakryiko wrote:
> > On Fri, Apr 15, 2022 at 4:12 PM Peilin Ye <yepeilin.cs@gmail.com> wrote=
:
> > > On Thu, Apr 07, 2022 at 10:53:33AM -0700, Martin KaFai Lau wrote:
> > > > The .sh is not run by CI also.
> > >
> > > Just curious: by "CI", did you mean libbpf-ci [1] ?
> > >
> > > If so, why doesn't libbpf-ci run these .sh tests?  Recently we trigge=
red
> > > a bug (see [2]) in ip6_gre by running test_tunnel.sh.  I think it
> > > could've been spotted much sooner if test_tunnel.sh was being run.
> >
> > If you convert test_tunnel.sh into a test inside test_progs, we'll be
> > running it regularly.
>
> Thanks!  I think Kaixi is working on this.
>
> Peilin Ye
>

Hi Peilin and Andrii,

Yes. I am working on it.
Thanks.
