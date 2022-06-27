Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF9B55D30F
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbiF0T5j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 15:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiF0T5g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 15:57:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B3B1AF15
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 12:57:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z19so14552874edb.11
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 12:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C/bXqWu7hlNu4r71zrCFpu+OhWq9zFL7q5yNRYHIGDY=;
        b=kxs/9JiZpt1zKm99h600arpF9Q8EE8dgJIRKZPYt4A7i/3TLr5l5ZQilZjDFrnwJ12
         CXEPexXNx+hk6ABFsU5sdWpIwGp85fXHn31S1o2/FygQyq8hPsXlZ/2CkxXUIiMR6Zd4
         ZlaKMw+TZvCVdVaHHaTdB8tThNrnF/w5k06hDDVnH3QBEf49m4tFPIZ5y3jyr4CJH/QY
         A3/iUsjuvUmhXpdQunrkjuHRlN92+UyQajJKn5EgycEvZABQN3njXqOdsO/jmoXceuuQ
         r8wOjkYyHncOSWvT7idr7gPR9h3Ayqumln5uqVf7n4p+9MQuhaILb6U8+PcoW+QFKIl9
         izhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/bXqWu7hlNu4r71zrCFpu+OhWq9zFL7q5yNRYHIGDY=;
        b=FmRJWGqZBMMGuJC+fahmVufcH8saWb8a1sK5nnnvYiJjUJN9DjD0dtkyksheMpX3P8
         uP38u9qvSRw74BYtmEoYfl6DVLcc2CwLjFwVMyiVHuygCcdcW487MaEvYrkN85wmXt8/
         dqldd6pxFnKKEunmN/g2aewBgQlZpCIMZef+AvU07wc/ec+6KAAK5jMYxpKd+9g5QMqJ
         GJy/0JYmNk6cu7IZRxECX32Q/Z3BpJ6yu0/GDdMufsE7SB9NlcvYi0R2IzjK0RqDX3qL
         0s8p0R5MlUkI9rf6175l5wXd9dUaXeMIV5kRX7lS5qsiaFTMbzgxZPHhaoExSS87Gyvl
         ulZw==
X-Gm-Message-State: AJIora+5w47vS442mKMT23nEmCHk52syExZNFypHUEHlooTcxFC0fcTh
        5ZqCBGJHAXCd8IzUxen/P3cP3Tk9wFMsf/YctAs=
X-Google-Smtp-Source: AGRyM1uzkr/zaWp7iFakqPzSdXMJl8nw+phUG99viufu7IlxDFMygRaT8VLCQ2jfv0QIC6FnYrsxH0eSxcPdlh8UC+E=
X-Received: by 2002:a05:6402:3487:b0:435:b0d2:606e with SMTP id
 v7-20020a056402348700b00435b0d2606emr19259759edc.66.1656359853720; Mon, 27
 Jun 2022 12:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <5bdc73e7f5a087299589944fa074563cdf2c2c1a.1656353995.git.daniel@iogearbox.net>
 <20220627122535.6020f23e@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20220627122535.6020f23e@kicinski-fedora-PC1C0HJN>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 27 Jun 2022 12:57:21 -0700
Message-ID: <CAADnVQLOS4kvmcp+aaX6gtDUCUfoL906K+Y4KUZOsYBDso_xMw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, docs: Better scale maintenance of BPF subsystem
To:     Jakub Kicinski <kuba@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 27, 2022 at 12:26 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 27 Jun 2022 20:22:55 +0200 Daniel Borkmann wrote:
> > -BPF (Safe dynamic programs and tools)
> > +BPF [GENERAL] (Safe Dynamic Programs and Tools)
> >  M:   Alexei Starovoitov <ast@kernel.org>
> >  M:   Daniel Borkmann <daniel@iogearbox.net>
> >  M:   Andrii Nakryiko <andrii@kernel.org>
> > -R:   Martin KaFai Lau <kafai@fb.com>
> > -R:   Song Liu <songliubraving@fb.com>
> > +R:   Martin KaFai Lau <martin.lau@linux.dev>
> > +R:   Song Liu <song@kernel.org>
> >  R:   Yonghong Song <yhs@fb.com>
> >  R:   John Fastabend <john.fastabend@gmail.com>
> >  R:   KP Singh <kpsingh@kernel.org>
> > -L:   netdev@vger.kernel.org
> > +R:   Stanislav Fomichev <sdf@google.com>
> > +R:   Hao Luo <haoluo@google.com>
> > +R:   Jiri Olsa <jolsa@kernel.org>
> >  L:   bpf@vger.kernel.org
> >  S:   Supported
> >  W:   https://bpf.io/
>
> Can we pause and think a bit about the purpose for this entry? I've been
> trying to make people obey get_maintainer.pl but having to CC 11 people
> is a asking a lot - especially that this entry regexp-keys on BPF (K:
> bpf N: bpf). So any patch that as much as uses the letters "bpf" gets
> an enormous CC list.

And that's a good thing.
vger continues to cause trouble and it doesn't sound that the fix is coming.
So having everyone directly cc-ed is the only option we have.
