Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F841659ABA
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 17:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiL3Qza (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Dec 2022 11:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbiL3Qz2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Dec 2022 11:55:28 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1BD13DEA;
        Fri, 30 Dec 2022 08:55:28 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r26so25915050edc.5;
        Fri, 30 Dec 2022 08:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gXIxdrho2cp5BvQ6jclvgZIjfYUVkry/Z7hhpGyIo8c=;
        b=hZ21w0OoN57mx5fQkz+Gbxo17U4bgjZAwRjkjwTFW/Ohc1uY5O0HKqUdAfDUuINthI
         qPU+fZBialSgJD6ftkwxr+lpATXMgkqLPxp/YKBQi+a4j+Wa0Kto6CbiFIEW9q/aT0vq
         53yNuUO9IfxfQQCKkuhqNNejYDHV+LY6GxNkqtd+9Dx/ZksS3Tpw0DQuDbu3ZUXWQ9Ij
         imCpAisPPsJV/Ip9bBJO6jXYTBFusgfG/HzbUi0BDtSMqKXlTSu5vN1gjC4MI90mIhEw
         jecSC2cmhwxxP8JVMc5M2PgOGtuSe8I8FJu5LSCrLFLt/6wWYncv4mDiDF93uYX/rfIC
         bzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXIxdrho2cp5BvQ6jclvgZIjfYUVkry/Z7hhpGyIo8c=;
        b=HZbj4c7aH8txj9PPXkYSDcSPWCyaFeK4AqhtvQpf4LEkMlQz301RC32I9yI4nD0mAr
         5vJ6QEsLTAU46EF/aA5qndhbHLAVzK6fH6sPRgAdd+hYnd2lMJizcZmLGO6eG129Rc8N
         QqbLpsVe7Nc3b68M5NJBQvD6qOAQxsEfgaUOG5QMn2IPPruK5xxCPAaITkx/9Y5t+o4+
         Xj8qMs8OzQBp7cw8WoRA0YzSNqWfgY6em12Ve3IN6pYJWlLosjedX4XSKbCL1nwiRysL
         /Wwxvjqum3aid/L6v6F1BefVFptYriPqOaGndeBh2VQ4Kcupyp6EEzq+7qbSbltzxSWe
         FIUw==
X-Gm-Message-State: AFqh2kqB1x2fxF5HJanIAN2peL5X3pKPPV05ItzyOxUGl6cXW2RjX8b6
        t88yUPIH8zbxOBjBgipykYBw/7ENCJRnhwJ0FCU=
X-Google-Smtp-Source: AMrXdXuuzjtyfJbTaA6P03neGS0Q+IxT2rNy6hkAQv08ssInIvtTvmwYaPdvZk16n4z24gXXh1bPyV3NwM+1s3rdkeY=
X-Received: by 2002:a05:6402:50d:b0:46a:a12a:4dcd with SMTP id
 m13-20020a056402050d00b0046aa12a4dcdmr3913913edv.338.1672419326524; Fri, 30
 Dec 2022 08:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20221222043507.33037-1-sunhao.th@gmail.com> <ef46c1f6-0939-c2ed-3efb-c3c5f28d1931@meta.com>
 <73E3CA9E-F67E-429F-A2DB-C77649E32D7A@gmail.com>
In-Reply-To: <73E3CA9E-F67E-429F-A2DB-C77649E32D7A@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 30 Dec 2022 08:55:15 -0800
Message-ID: <CAADnVQ+EMzAmeKvivFKvqCNj6H9X-1rBtBBnjRzDiNvkocsc6A@mail.gmail.com>
Subject: Re: kernel panic: Attempted to kill init!
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Dec 30, 2022 at 1:54 AM Hao Sun <sunhao.th@gmail.com> wrote:
>
>
>
> > On 28 Dec 2022, at 2:35 PM, Yonghong Song <yhs@meta.com> wrote:
> >
> >
> >
> > On 12/21/22 8:35 PM, Hao Sun wrote:
> >> Hi,
> >> This crash can be triggered by executing the C reproducer for
> >> multiple times, which just keep loading the following prog as
> >> raw tracepoint into kmem_cache_free().
> >> The prog send SIGSEGV to current via bpf_send_signal_thread(),
> >> after load this, whoever tries to free mem would trigger this,
> >> kernel crashed when this happens to init.
> >> Seems we should filter init out in bpf_send_signal_common() by
> >> is_global_init(current), or maybe we should check this in the
> >> verifier?
> >
> > The helper is just to send a particular signal to *current*
> > thread. In typical use case, it is never a good idea to send
> > the signal to a *random* thread. In certain cases, maybe user
> > indeed wants to send the signal to init thread to observe
> > something. Note that such destructive side effect already
> > exists in the bpf land. For example, for a xdp program,
> > it could drop all packets to make machine not responsive
> > to ssh etc. Therefore, I recommend to keep the existing
> > bpf_send_signal_common() helper behavior.
>
> Sound the two are different cases. Not responsive in XDP seems like
> an intended behaviour, panic caused by killing init is buggy. If the
> last thread of global init was killed, kernel panic immediately.

I don't get it. How was it possible that this prog was
executed with current == pid 1 ?
