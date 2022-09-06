Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E22A5AF103
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 18:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbiIFQrd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 12:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238243AbiIFQrB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 12:47:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2194817069
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 09:28:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pj10so1433995pjb.2
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 09:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=B1tJnaSq5B/t3yPTU483R+WqjIq3j1MpuJsYb9B/pbQ=;
        b=EOGnj+ex+mzb1QoXlxZmruTtPMsY2GGHaDg6tLc51/sZheXmtecxOiixUNY15/0fYq
         noa2G6Yrg4B9m58yntwEO9QsKjr/SEqIXxy+7fZoF0MTfq/v9KjRTkmBuFrBwq3bg3M+
         /vUFe+VcGA8Ra5nxQNXhy49vrfYEJFxTuiPQJMpG4qwyhBjcEPgzO0sZmZzABu6i8Lzf
         pelBU6CfS8kbtywOtM/zEix0kwn/PZ5A8cKH+Gh/hZOxtfPmp3FfycS+YAnTFESvSU6I
         bafdbPysbjl1hcJZsmfAAsLOOYzS5npRXHR8C4Buf58R2k/4tHxAPhXEiw1qwzmMyG/k
         IY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=B1tJnaSq5B/t3yPTU483R+WqjIq3j1MpuJsYb9B/pbQ=;
        b=ZQ2qWvCMUJnqup0u0HpD+Mro4on8OgDHk+vQkdBCKfxpJ9sGFUtIE6wh7OrbQslLIF
         TH7dxatAF+DpVLQPoeu3T6Epru5uyYUhz00Oa5DQ7EecHiOATdeTaN50fFM7SrVKbwOw
         1Om4nGPyJw63cmtdQqaLNPDTjjs90AjVSwQklRP5LdTa13XZQFCkPGn+TzZS7v47TFug
         LTzyrqXhjRTjzvufEI0DiJrmwUmm8isKfyfuh5GHP68GfH0qzjshkbris/SAVHbgRtRv
         /7Trp2yOwmpEb7y4jyBtdvgblCOLuelMJM7vHSuyjlXgEGuVbI5uWveWH+LR8FWGVuMl
         Fmdw==
X-Gm-Message-State: ACgBeo2VDMvBUqKboU6W5/wZJjcAHpC0dfjJGOkf3xHmPIfbQeBXzZ1n
        MwKVZp1oWlVIp+hIjwebIR2yERibJegHxZJeST45eQ==
X-Google-Smtp-Source: AA6agR6PTzR1b20iQrk5gA/zq+HQjYuIpQS11sd+axJYGleAlkydltfAkZ/aF1MGRPonz5RvWUjCnoRsN5MjVgpDybU=
X-Received: by 2002:a17:90b:388e:b0:1f5:40d4:828d with SMTP id
 mu14-20020a17090b388e00b001f540d4828dmr26456732pjb.31.1662481704429; Tue, 06
 Sep 2022 09:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <CABG=zsBEh-P4NXk23eBJw7eajB5YJeRS7oPXnTAzs=yob4EMoQ@mail.gmail.com>
 <Yw/aYIR3mBABN75G@google.com> <CABG=zsCTiqt4QuPo70xiGePh1F4ntyNh4-bsVh_DKvSw=CkWjA@mail.gmail.com>
In-Reply-To: <CABG=zsCTiqt4QuPo70xiGePh1F4ntyNh4-bsVh_DKvSw=CkWjA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 6 Sep 2022 09:28:13 -0700
Message-ID: <CAKH8qBvVhkrXdesEUmDAeLG+LUWO=-j-d40F_V4Laq7rB1ScZQ@mail.gmail.com>
Subject: Re: [RFC] Socket termination for policy enforcement and load-balancing
To:     Aditi Ghag <aditivghag@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Sun, Sep 4, 2022 at 10:41 AM Aditi Ghag <aditivghag@gmail.com> wrote:
>
> On Wed, Aug 31, 2022 at 3:02 PM <sdf@google.com> wrote:
> >
> > On 08/31, Aditi Ghag wrote:
> > [...]
> >
> > > - The sock_destroy API added for similar Android use cases is
> > > effective in tearing down sockets. The API is behind the
> > > CONFIG_INET_DIAG_DESTROY config that's disabled by default, and
> > > currently exposed via SOCK_DIAG netlink infrastructure in userspace.
> > > The sock destroy handlers for TCP and UDP protocols send ECONNABORTED
> > > error code to sockets related to the abort state as mentioned in RFC
> > > 793.
> >
> > > - Add unreachable routes for deleted backends. I experimented with
> > > this approach with my colleague, Nikolay Aleksandrov. We found that
> > > TCP and connected UDP sockets in the established state simply ignore
> > > the ICMP error messages, and continue to send data in the presence of
> > > such routes. My read is that applications are ignoring the ICMP errors
> > > reported on sockets [2].
> >
> > [..]
> >
> > > - Use BPF (sockets) iterator to identify sockets connected to a
> > > deleted backend. The BPF (sockets) iterator is network namespace aware
> > > so we'll either need to enter every possible container network
> > > namespace to identify the affected connections, or adapt the iterator
> > > to be without netns checks [3]. This was discussed with my colleague
> > > Daniel Borkmann based on the feedback he shared from the LSFMMBPF
> > > conference discussions.
> >
> > Maybe something worth fixing as well even if you end up using netlink?
> > Having to manually go over all networking namespaces (if I want
> > to iterate over all sockets on the host) doesn't seem feasible?
>
> SOCK_DIAG netlink infrastructure also has similar netns checks. The
> iterator approach
> would allow us to invoke sock destroy handlers from BPF though.

Sorry, I think I wasn't clear enough.
I meant that having a mode to iterate over all sockets on the host
regardless of the namespace might be useful.
Martin suggests the same in [1], I'll follow that thread :-)

[1] https://lore.kernel.org/bpf/20220831230157.7lchomcdxmvq3qqw@kafai-mbp.dhcp.thefacebook.com
