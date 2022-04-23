Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7F150C6C7
	for <lists+bpf@lfdr.de>; Sat, 23 Apr 2022 04:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiDWCyT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 22:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiDWCyS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 22:54:18 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8D863527
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 19:51:22 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h83so10415489iof.8
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 19:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bi+EhZ5a7EyQyvLdhnekEay65R8iKFSKpl/u1MjI+qM=;
        b=FXqkMFlc1XlaDLaN/7fJya2gVxYU9WpDEsD4CfDt7kDHxab3Z0bgibil6dmSSFZjHu
         bclVLKcaMQS7QfJt/tM1EGAXkB/dPTV7qohRK0D9Ity3B7+H0CvvOlX7026iyMNToP4O
         SxtPGj+5Cxov5C9vqaCjKbLclhIsO16ZLdPGGFWCPBg6zic6PJQcMuIz03OQ+po8fw3O
         agQIKYn3YfvOVWnVGzGu16NaayEhyQm+TpUrXWmTUthPzTz9kFFMxCB2SJHOvLIcayy6
         EVxIoESw25z6xG0WMiKtj1FTl+/k8feAGh3werlAGSZJRUnONs3AHiKmK9bjOwc5vSoS
         NwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bi+EhZ5a7EyQyvLdhnekEay65R8iKFSKpl/u1MjI+qM=;
        b=OOXgixqMP+uZrhCQf6Hmg7ACDHYnhkT+QFa5ioYSbqIwtpcodUjh4r50SiSsgcCgHl
         03aHlQ4aqnSNAEQocEZZ7vsDxD7RUwrSmclU3Ua/bWN69uLnXhg1a5XEzO8cVR/C/DMX
         PbyiO1a/586ckwwnlZ4Rin/u1uEhEdFel26qfGmhBWj8RApJz4axOgFLunAQ6y259Ons
         FS25VcW+x3JrMM5mLZys15FPIu0/PGN//kHAha0AuE7b+3EEn8O1tsOdfueEeDpZrMDh
         E04t3OmvGLVtAj43J9N5NgtTMBnIgAEwXEHvwESHsENVbk/GcVNnIHYDvIeaY+as06yE
         ogpg==
X-Gm-Message-State: AOAM533Xo/V1QbRSXybiF1uyBI7UDQhU6kiC46knw2FMuk50a1nBy1ER
        XA4yix2ZNFdMNTr2r8Q41tje/ymkd/zkNMSkw2IPrQ==
X-Google-Smtp-Source: ABdhPJxAGLNMiZqvLNqde8ePGnI2aPJXv8kK6b4x73SkOGjJ4YhbjMg1N6sjnBWZusRRcQVuOegz2Je95JJYaYjpukQ=
X-Received: by 2002:a05:6638:d0a:b0:328:73fb:b1d1 with SMTP id
 q10-20020a0566380d0a00b0032873fbb1d1mr3316218jaj.132.1650682279988; Fri, 22
 Apr 2022 19:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220422120259.10185-1-fankaixi.li@bytedance.com>
 <20220422120259.10185-3-fankaixi.li@bytedance.com> <CAADnVQL9=XivjNeg3CyE67N3cp6xB+cetUhWG6b+DtXo-6x0VA@mail.gmail.com>
In-Reply-To: <CAADnVQL9=XivjNeg3CyE67N3cp6xB+cetUhWG6b+DtXo-6x0VA@mail.gmail.com>
From:   Kaixi Fan <fankaixi.li@bytedance.com>
Date:   Sat, 23 Apr 2022 10:51:08 +0800
Message-ID: <CAEEdnKFjUQeZGYFF+gAtqEeyCzdz=5A91w-PFgAjsS-nkZ6BXw@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2022=E5=B9=B44=
=E6=9C=8823=E6=97=A5=E5=91=A8=E5=85=AD 08:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Apr 22, 2022 at 5:04 AM <fankaixi.li@bytedance.com> wrote:
> > +#define VXLAN_TUNL_DEV0 "vxlan00"
> > +#define VXLAN_TUNL_DEV1 "vxlan11"
> > +#define IP6VXLAN_TUNL_DEV0 "ip6vxlan00"
> > +#define IP6VXLAN_TUNL_DEV1 "ip6vxlan11"
> > +
> > +#define SRC_INGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/test_tunnel_ingress_=
src"
> > +#define SRC_EGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/test_tunnel_egress_sr=
c"
> > +#define DST_EGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/test_tunnel_egress_ds=
t"
> > +
> > +#define PING_ARGS "-c 3 -w 10 -q"

Thanks for the suggestion.

>
> Thanks for moving the test to test_progs,
> but its runtime is excessive.
>
> time ./test_progs -t tunnel
> #195 tunnel:OK
> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>
> real    0m26.530s
> user    0m0.075s
> sys    0m1.317s
>
> Please find a way to test the functionality in a second or so.

Hi Alexei,
Do you mean the sys time should be in a second ?
Thanks.
