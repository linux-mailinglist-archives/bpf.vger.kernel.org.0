Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CED640116
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 08:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiLBHgy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 02:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiLBHgq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 02:36:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17134AD302
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 23:36:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5EAC1CE1BBC
        for <bpf@vger.kernel.org>; Fri,  2 Dec 2022 07:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6118BC433D6
        for <bpf@vger.kernel.org>; Fri,  2 Dec 2022 07:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669966599;
        bh=4gC+LYWGNo0M0wXx6ZajcBB+ZV3nYJdm00Drw8bzQNw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KEotSknLF1PAI5oCADAUsUqrof+Y09715vhbvxDqQOb9SyN3hfsJ7Ex8i0o+rfmE/
         g0e0ye+a9Bo7b3kTZL9b/J2pJaHkbSPOKj3qottEcJteckp4OpFUSRjlJRVwNaCNp+
         nf+hp7tzAnaP3vAxcNOXZ+De1DRiH6j4hCtz6lc7jJIHXHeBC+mdIrhEFDkN/7ekAG
         VB4sFoQ1r5SFZLJsv59e3Pd129QoABbXX80xgFaKPZFeeFBazCbcqsahEp57Nd1quu
         nHuekFWJfTVuxAaUVQk77a8P+74n402eesuP2dZQrog0ZUXVXIo60sxU/VTViVgdNF
         myhxcEuuRHdWA==
Received: by mail-ej1-f44.google.com with SMTP id vp12so9628420ejc.8
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 23:36:39 -0800 (PST)
X-Gm-Message-State: ANoB5pkuWSSnWD31z4sBKpGtXuCbYxJ/ONR4CSQQyNh0T4t2JbY5NXR3
        AnpcbAUjcJWKL5hKYUXifidP9vePt+NJz67ezTc=
X-Google-Smtp-Source: AA0mqf5hE0rax1cH2Pw4BEPY9AYEYCpRuYWRnY2NmhJkuJrRXCyuuSl5Ue9HkAITWWfhWLLznLPQxO8Lno8zdAb9qFs=
X-Received: by 2002:a17:907:2c68:b0:7c0:999d:1767 with SMTP id
 ib8-20020a1709072c6800b007c0999d1767mr10592007ejc.301.1669966597638; Thu, 01
 Dec 2022 23:36:37 -0800 (PST)
MIME-Version: 1.0
References: <20221129161612.45765-1-laoar.shao@gmail.com> <CA+khW7jjfQOLnx6-4UyJ8sYTj12qzp_NmiZJ-uiSwGU754hbXg@mail.gmail.com>
 <CALOAHbCGSigE9vjvw6DczLbRF=TaQ3vmh6SHvMvoAChM_6Mdfg@mail.gmail.com>
 <CAPhsuW7B1fM=JYG0OeHPZU7isv+O2_OPc22EBsdC6ZNEWusqXA@mail.gmail.com>
 <CA+khW7gLUrBYLoCKPAOO8evofNjr97crX=Gw59FpZu-gM8FTHQ@mail.gmail.com>
 <CALOAHbCqR6Qmx9n4Sq9Vdh=9ba_L1nfh9BpAwnAMq2d9xHFiiQ@mail.gmail.com> <CA+khW7jSh8hOTBPjVFBXX0xi+BRadA+_GzAvW4wD1st33CmhMg@mail.gmail.com>
In-Reply-To: <CA+khW7jSh8hOTBPjVFBXX0xi+BRadA+_GzAvW4wD1st33CmhMg@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 1 Dec 2022 23:36:25 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6LcOftmLdSS8+WUkyPVH43XK-Ksq=BWJMCkWtZELb0rg@mail.gmail.com>
Message-ID: <CAPhsuW6LcOftmLdSS8+WUkyPVH43XK-Ksq=BWJMCkWtZELb0rg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Allow get bpf object with CAP_BPF
To:     Hao Luo <haoluo@google.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 1, 2022 at 9:36 PM Hao Luo <haoluo@google.com> wrote:
>
> On Thu, Dec 1, 2022 at 6:47 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Thu, Dec 1, 2022 at 8:38 AM Hao Luo <haoluo@google.com> wrote:
> <...>
> > > 3. IIRC, Song proposed introducing a namespace for BPF isolation, not
> > > just isolating IDs [1]. How does it relate to the BPF_ID namespace?
> > >
> > > [1] https://lore.kernel.org/all/CAPhsuW6c17p3XkzSxxo7YBW9LHjqerOqQvt7C1+S--8C9omeng@mail.gmail.com/
> >
> > I have looked through the slides of this proposal, but failed to
> > figure out how Song will design the BPF namespace. Maybe Song can give
> > us a better explanation.
> > Per my understanding, the goal of Song's proposal should be combined
> > by many namespaces and other isolation mechanisms.  For example, with
> > the help of PID namespace, we can make sure only the tasks in this
> > container can be traced by the bpf programs running in it.

The proposal didn't really go anywhere. LOL.

As Yafang said, it requires multiple mechanisms to work together, and thus
is very complicated. OTOH, we are not sure whether BPF tracing is still
useful when it is really safe. Specifically, probe_read is not safe, but really
useful.

A related idea is tracer namespace, presented by Mathieu Desnoyers at
LPC 2022. [2]

[2] https://lpc.events/event/16/contributions/1237/

> >
>
> Among the 5 items in [1], it looks like the third item "Limit which
> BPF programs are accessible to non-root users" is what you proposed
> here. The other items are more about isolation, I think. So, the
> question is, if we have a BPF_ID namespace, would that be sufficient
> for debugging in containers? If yes, at least it's something useful.
> We can start from the BPF_ID namespace, bring it for discussion, and
> gather other requirements gradually.

BPF_ID namespace is a better defined idea. I am not sure whether we
want the complexity of a namespace, though.

Thanks,
Song
