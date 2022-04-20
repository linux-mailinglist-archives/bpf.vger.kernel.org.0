Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16036508E15
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 19:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380897AbiDTRM6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 13:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244679AbiDTRM6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 13:12:58 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60D465CD
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 10:10:11 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id i26so843266uap.6
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/iFiImZlWQe9JGsO+lz8pkv0hCRZDcmPJd0jXOXf70=;
        b=PaYGfbZvD5edbw1/VfspUgs6tr8yIz6J9pw+/PfmbJB+oEe2SWrk02A/z4gwFxQEqg
         3gqG9mPZxhMifvxVaqAW6DWbRkTsccVgL4pfj1YUNp21APJX0aMIWqsR9WukCEKJ11cD
         IpfbSkJAfvkhDuOupetT2cC2YPDT6ky9fbBqbc10Uj8EMiFcIR6zbdCHzKcbJ2Ym/8+V
         XwfixGMIQd9CfrPnkzLJvu+6kq/Z4J1LzQVTNXMbvb1/RQ6jPXDsq68iO6XfHKEKFdO/
         ylf7l88qd68fnqTg2jfOe4IArwuR1JHzunLO384ZWE+kH7UP7o2X5hBjJwFbzUPMiac/
         YorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/iFiImZlWQe9JGsO+lz8pkv0hCRZDcmPJd0jXOXf70=;
        b=JFC2Wa4eSJCrXRb3fVqokgxHg00WwJnBgcCXTlB+4hfMaJm9MN8atCgdIYbaUjpK3j
         nQNzADd8YWN7TnNxNWqdvlhE1SuRpFI9UtnBqLaHDW1aL+yzGqg0tBfnXTlrFKwIetIx
         /H445zs6QyOcxGU4kwStbl3w+NIBVbc2kWboSU65ZMzWC74DpVVSD1OdGbCdlAQTT4vc
         b6ZHc21k6jCkgvnXvqTpVEFvdrTp17RGsPFfxNyrdgCAjpPwnkNtueRySOpufsJzkEw1
         ZdkpNao87DEJ8HGJeFR3XxKsfYTtZuwLnLg/VDr51/lOyDfu+cwCb5z41By4GGhglOmw
         VLPg==
X-Gm-Message-State: AOAM533K7w65yVVompTDjvzHj/ZdJ5GUJ4E/c3nVeXvUSLXkHbrZVoe4
        uVc7lKdfDkZGLiNWpVpK8de4vQkx/mHsHWpP5gg=
X-Google-Smtp-Source: ABdhPJzex+WAfdwdJDnbIY44lTtptKSR6in2bzCX4A3CT9l0FJ7kDlSitOHB8IsW8YefZoHLobsCcxlD+xurm5g1CnE=
X-Received: by 2002:ab0:4870:0:b0:35d:49af:f381 with SMTP id
 c45-20020ab04870000000b0035d49aff381mr5860553uad.77.1650474610746; Wed, 20
 Apr 2022 10:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220322154231.55044-1-fankaixi.li@bytedance.com>
 <20220322154231.55044-4-fankaixi.li@bytedance.com> <20220324193755.vbtg2dvi4x3rysx2@kafai-mbp>
 <CAEEdnKFbq=TpmrXtFi8A-pPcLS-pRS2TT_726v7S52XMX6crQA@mail.gmail.com>
 <CAEEdnKH2g0gZ5y2x_1BCK1MHt6_r=_RLw18=apbwpn9+Thi7nA@mail.gmail.com>
 <20220407175333.tnmk4am3hzpfhept@kafai-mbp.dhcp.thefacebook.com> <20220415231155.GA9900@bytedance>
In-Reply-To: <20220415231155.GA9900@bytedance>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Apr 2022 10:09:59 -0700
Message-ID: <CAEf4BzbFT1Sdb4fijyU4WELP64rX1K8dWwMu6CDcDkMXTwqHfQ@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 3/3] selftests/bpf: add ipv6 vxlan
 tunnel source testcase
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        =?UTF-8?B?6IyD5byA5Zac?= <fankaixi.li@bytedance.com>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 15, 2022 at 4:12 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
>
> Hi Martin,
>
> On Thu, Apr 07, 2022 at 10:53:33AM -0700, Martin KaFai Lau wrote:
> > The .sh is not run by CI also.
>
> Just curious: by "CI", did you mean libbpf-ci [1] ?
>
> If so, why doesn't libbpf-ci run these .sh tests?  Recently we triggered
> a bug (see [2]) in ip6_gre by running test_tunnel.sh.  I think it
> could've been spotted much sooner if test_tunnel.sh was being run.
>

If you convert test_tunnel.sh into a test inside test_progs, we'll be
running it regularly.

> [1] https://github.com/libbpf/libbpf/actions/workflows/test.yml
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=ab198e1d0dd8
>
> Thanks,
> Peilin Ye
>
