Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E9D514E04
	for <lists+bpf@lfdr.de>; Fri, 29 Apr 2022 16:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377752AbiD2OuL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Apr 2022 10:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377869AbiD2OuG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Apr 2022 10:50:06 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37121A1464
        for <bpf@vger.kernel.org>; Fri, 29 Apr 2022 07:46:47 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id o5so4123589ils.11
        for <bpf@vger.kernel.org>; Fri, 29 Apr 2022 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A7TVUwrrFYaNXbQvva6H/HX6gz1/1eCNjj2BOKVoe6s=;
        b=k0MP9pyxu+pljzAGhtSXsm4MiL6/pd5AjUdRH+BFuhlpbInr6EIfN3Sieg5wuy+6k6
         ySDxPJkaTQ+1H8e6YwXgG0Zl4hH9Aq7rE+rwNX36LHNf88d+s7Z2Iu7pF8oP5AVoH3uW
         8laiGVelSI6fGqx3MKzfJgCKIMOlVGy3wmpfd3DmxvtR8Jy2PDM/MBDLjLDX3wP/MD9Z
         rJBCCV9+CmaDY5KQTuFdMXaVzUQyh1EGjT907ApI98+nCF9KfOsCM8kLHWmCJa32fr2Z
         ov82fUc8jzLs4OduRKFOz35zI/WagGzg56EYetsQYE807itElD9bLQU0a3Yn0D5/0XDV
         jaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A7TVUwrrFYaNXbQvva6H/HX6gz1/1eCNjj2BOKVoe6s=;
        b=dwfX/JN8lelEm/Cju45KNZTQGETKPjzFjehdUJelrn4xeSec+e3bu867o+2XKZnrQd
         ExLEYihgyxgS/nE7tkMLenh0vSdg+BZP6+0GXu4EdmoMCVg48z8b+cfGGt0XBQhYPusy
         YO7RNJ8Oqn2mTjdtsv+yWcJlFnIabEs3U54aPJsTAys9Qm/JLRke5m51FNUHDRIUZTVq
         4g/o4HyYS8B7IrUC62WR6xWErBufvNPTorgYH3B2l/fQxoSOLfJ+NlDmuIaMYzQ1J79w
         4PTeOLqgyi0nIZnfVi0uNXHElQuylo7BuUeXUvq9EaA4kn+P0nktLMruF0S1zqWOZuQt
         k8NA==
X-Gm-Message-State: AOAM5300kvDbYb82Cs54c6B8ETZpH/yKrISu1bs1+NBgtMXHFONIFErw
        CwOLENCkuQWdBeBHBTa4xwQkYNprG1kbFN8udpS3Zw==
X-Google-Smtp-Source: ABdhPJw011+WdqimhvrzHyr6d+jg1rEQ4VnoNPpO3nZieV+AeC2Mr0f+I5uz6YY/8MPXs2/cF8os6039yALb6pVfziA=
X-Received: by 2002:a05:6e02:1788:b0:2cd:7dbf:9b30 with SMTP id
 y8-20020a056e02178800b002cd7dbf9b30mr13421798ilu.44.1651243606608; Fri, 29
 Apr 2022 07:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220422120259.10185-1-fankaixi.li@bytedance.com>
 <20220422120259.10185-3-fankaixi.li@bytedance.com> <CAADnVQL9=XivjNeg3CyE67N3cp6xB+cetUhWG6b+DtXo-6x0VA@mail.gmail.com>
 <CAEEdnKFjUQeZGYFF+gAtqEeyCzdz=5A91w-PFgAjsS-nkZ6BXw@mail.gmail.com>
 <CAADnVQL2j-sLdDr+ZRHakKo8SVrKofCq3ffQJ8Fpqvr0gEXHPg@mail.gmail.com>
 <CAEEdnKG-HeAhWrATMTOYKa7_OdKXs4NjrVrQpcxFXSicgNY1mw@mail.gmail.com> <20220426182451.jjqo6eifnhz6ptfn@MacBook-Pro.local>
In-Reply-To: <20220426182451.jjqo6eifnhz6ptfn@MacBook-Pro.local>
From:   Kaixi Fan <fankaixi.li@bytedance.com>
Date:   Fri, 29 Apr 2022 22:46:35 +0800
Message-ID: <CAEEdnKF_U-aSEzbTLysOVsZBh2dTy54q=L-p7vZsDFD-nqWaug@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v5 2/3] selftests/bpf: Move vxlan
 tunnel testcases to test_progs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2022=E5=B9=B44=
=E6=9C=8827=E6=97=A5=E5=91=A8=E4=B8=89 02:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Apr 24, 2022 at 11:32:07AM +0800, Kaixi Fan wrote:
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2022=E5=B9=
=B44=E6=9C=8824=E6=97=A5=E5=91=A8=E6=97=A5 10:57=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Fri, Apr 22, 2022 at 7:51 PM Kaixi Fan <fankaixi.li@bytedance.com>=
 wrote:
> > > >
> > > > Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2022=E5=
=B9=B44=E6=9C=8823=E6=97=A5=E5=91=A8=E5=85=AD 08:37=E5=86=99=E9=81=93=EF=BC=
=9A
> > > > >
> > > > > On Fri, Apr 22, 2022 at 5:04 AM <fankaixi.li@bytedance.com> wrote=
:
> > > > > > +#define VXLAN_TUNL_DEV0 "vxlan00"
> > > > > > +#define VXLAN_TUNL_DEV1 "vxlan11"
> > > > > > +#define IP6VXLAN_TUNL_DEV0 "ip6vxlan00"
> > > > > > +#define IP6VXLAN_TUNL_DEV1 "ip6vxlan11"
> > > > > > +
> > > > > > +#define SRC_INGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/test_tunnel_=
ingress_src"
> > > > > > +#define SRC_EGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/test_tunnel_e=
gress_src"
> > > > > > +#define DST_EGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/test_tunnel_e=
gress_dst"
> > > > > > +
> > > > > > +#define PING_ARGS "-c 3 -w 10 -q"
> > > >
> > > > Thanks for the suggestion.
> > > >
> > > > >
> > > > > Thanks for moving the test to test_progs,
> > > > > but its runtime is excessive.
> > > > >
> > > > > time ./test_progs -t tunnel
> > > > > #195 tunnel:OK
> > > > > Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> > > > >
> > > > > real    0m26.530s
> > > > > user    0m0.075s
> > > > > sys    0m1.317s
> > > > >
> > > > > Please find a way to test the functionality in a second or so.
> > > >
> > > > Hi Alexei,
> > > > Do you mean the sys time should be in a second ?
> > >
> > > real time.
> > > sys time is already there.
> > > The big delta between real and sys time highlights
> > > inefficiency of the test. The test sleeps most of the time.
> >
> > The tunnel test includes many types of tunnel testcases.  Add a new
> > tunnel testcase would increase test time.
> > So the real time could not be reduced into a second.
> > The test code calls many shell commands to setup test environments. It
> > may be the reason why there is a big
> > delta bettween real and sys time.
>
> Try reducing the number of shell commands.
> For example, instead create+teardwon of netns keep it the same across
> different tunnel tests and clean up once.
>
> > Reduce the ping packet interval would reduce the real and sys time
> > significantly.
> > real 0m7.088s
> > user 0m0.062s
> > sys 0m0.119s
>
> Please try to reduce it further. Clearly all 7 seconds CPU mainly sleeps.

Hi Alexei,

I try to reduce test time to 3.3s by use libbpf api to attach tc programs a=
nd
remove some shell commands. These will be included in a serials v6
patches.

Thanks.
