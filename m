Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570F155D0B2
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbiF0Uaj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 16:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbiF0Uai (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 16:30:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F9A55B0
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 13:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A98346177B
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 20:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C76BC34115;
        Mon, 27 Jun 2022 20:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361837;
        bh=zQ5Xm6WxfYYxuqJj4oC+HWypoDOzlOZCdGNB/hGtR5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k/MpaU9+K0NeiGGD1o7hQA+blhQzkcMzkpz6WCPd6eK8jXv/7j6TnL0YrDDMjwohf
         kA9gDNEWSDQ3I2wGtRo4/ddmurduH/T9arMk2b4kcPPIuMfQPZ4RVLrojoSG+/pC+a
         OB3Usnx/UYBCE4bmhDuapNhX2TiwQWPa4Xu3hryuW4+h+x8neYpaJhm2isAO4TNJcn
         5mbdwjeVlhPldHNfr71BI97r6z8tC0Gn/BAmkrQKNW63KIfH8H5jtJnJxn+8dcJoLC
         OO75N53xxRuWXjvfsdzPHobsMoUQ90/InWXPzelAZhENIMer1QeBo+XJaqURyAThuS
         P6zNHsgi3TeDQ==
Date:   Mon, 27 Jun 2022 13:30:27 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Mykola Lysenko <mykolal@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH bpf] bpf, docs: Better scale maintenance of BPF
 subsystem
Message-ID: <20220627133027.1e141f11@kernel.org>
In-Reply-To: <CAADnVQLOS4kvmcp+aaX6gtDUCUfoL906K+Y4KUZOsYBDso_xMw@mail.gmail.com>
References: <5bdc73e7f5a087299589944fa074563cdf2c2c1a.1656353995.git.daniel@iogearbox.net>
        <20220627122535.6020f23e@kicinski-fedora-PC1C0HJN>
        <CAADnVQLOS4kvmcp+aaX6gtDUCUfoL906K+Y4KUZOsYBDso_xMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 27 Jun 2022 12:57:21 -0700 Alexei Starovoitov wrote:
> And that's a good thing.

My concern is that folks will rebel against populating the CC list if
they never receive feedback from the CCed. I often have to go and
manually trim the CC list because I don't think Jiri, KP, Yonghong etc.
care about my random TLS patch, or removal of a driver which happens 
to contain the letters "bpf". I was hoping the delegation you're
performing could help with the large Cc list. Would you perhaps
consider moving the K/N regexes to the "Core" entry? It'd lower 
the pain of false positives.

> vger continues to cause trouble and it doesn't sound that the fix is coming.
> So having everyone directly cc-ed is the only option we have.

Yeah, Exhibit A - vger is lagging right now...
I guess the "real fix" is on the vger, trying to massage MAINTAINERS
now is not a great use of time..
