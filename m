Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA77467AB19
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 08:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjAYHlH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 02:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbjAYHlG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 02:41:06 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47B3273C
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 23:41:04 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso2185244wmb.0
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 23:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+N11uRe/OGJr/nDUHCQ1k0367Pwj+F1So6zggxHnAzw=;
        b=Hq4WpW9cM61cCpiB36HEmBtnRV+YPrl2/dNszwnMvBjfleCnP+TlMTA0QRvR4atcUj
         dIi8FjOE/JGAmDyBLYLXIVF0czUAw4kyzcEEv7APbl+/tICbH4qSLaoQtSAKO6ebbNcr
         MTb6x7rHuKKZs+AZjCJTYIaaKqkQSIUbRU+8ehXfPb7CuruckZ7P7xzA/2XA0ROwBKNu
         1L9XEzVPUusYsKo81EyW836qnpEbplyoa+u7MtxCJgsRwvFfUw+5rUOKBpW23f+fU8yg
         tZ6um3GSQfFHUR9A0FM85me/1pEKLs7grTkIpOMuI0LTL8Z6TIkqgPyBeWf1V7F/wNqL
         ZrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+N11uRe/OGJr/nDUHCQ1k0367Pwj+F1So6zggxHnAzw=;
        b=YyY3hcwGaPlVSSRLZN333O31aePuwbVkA8C9OFzluxDVTs1C0xuJRvZzM+abp3/Aob
         MnOm1ejWZg8ha1CfnozUE2HENEhoaiA8szw/YyZmUbw5XKshdPTqXunrIlY96CtqDrqj
         p/Mps2BsPrgVl1k+r2v5MliP3ASyje3iypPe1T9CkhVC69nFa6+fb7SY7hF3YC8lVRX5
         N3IFjrmvAxluhe7cpkfjn2sMgLuy1frpfrgJI6bO7sh+wijLBpj2B/skV1cQA2TLPF9H
         LzdauLg9RAHhkpWkqvWuWzhyxIEFwa06oJmcB7hXYFNMHGfL03AdDZmFWzRgc/ZWbENz
         miuQ==
X-Gm-Message-State: AFqh2kqbgDX/fQwQQshmae8C1UH2n6vPotYItSBnKkF5liI1VE1LZd45
        QJplun3oj1m3kB2ujRiSOkE=
X-Google-Smtp-Source: AMrXdXvJsKYbipIiM1IBz3vEUqcTDx7hjDL+Ub2pp7o7ZkvHx+CeX8hqwGwWyWAPIc7fdtF+KNh+sw==
X-Received: by 2002:a7b:c45a:0:b0:3d1:ed41:57c0 with SMTP id l26-20020a7bc45a000000b003d1ed4157c0mr38466165wmi.30.1674632463110;
        Tue, 24 Jan 2023 23:41:03 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bc350000000b003d9aa76dc6asm1294233wmj.0.2023.01.24.23.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 23:41:02 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 25 Jan 2023 08:41:00 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: Move kernel test kfuncs into
 bpf_testmod
Message-ID: <Y9DdDIpVfQ2f+b70@krava>
References: <20230124143626.250719-1-jolsa@kernel.org>
 <CAADnVQLpk2-fcjgkOssuaT82Pdtu1KzgnxjHXiBV1TJzYXjtWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLpk2-fcjgkOssuaT82Pdtu1KzgnxjHXiBV1TJzYXjtWQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 24, 2023 at 07:49:38PM -0800, Alexei Starovoitov wrote:
> On Tue, Jan 24, 2023 at 6:36 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > I noticed several times in discussions that we should move test kfuncs
> > into kernel module, now perhaps even more pressing with all the kfunc
> > effort. This patchset moves all the test kfuncs into bpf_testmod.
> >
> > I added bpf_testmod/bpf_testmod_kfunc.h header that is shared between
> > bpf_testmod kernel module and BPF programs, which brings some difficulties
> > with __ksym define. But I'm not sure having separate headers for BPF
> > programs and for kernel module would be better.
> 
> This part looks fine and overall it's great.
> Thanks a lot for working on this.
> But see failing tests.
> test_progs-no_alu32 -t cb_refs

oops, forgot about alu32 :-\ will check

jirka

> is consistently failing.
> Also it seems it introduces instability into other tests.
> BPF CI isn't happy.
