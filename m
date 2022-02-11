Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7737F4B3149
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 00:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354174AbiBKXdJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 18:33:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354173AbiBKXdI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 18:33:08 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7E4C66
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 15:33:06 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id w7so13298332ioj.5
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 15:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRYrYeWrcUIGVrh7Yi0UjDHuASJm37EvZyCwuvfPA+g=;
        b=RkCAe2AeXy8WcMefTslOrws5eanaH/cu3X+b6BSa2UHxdUADcdkbcsDRrp1/nhP0Lh
         XZXnSjtCY19yaOIDlJ64uJIYUvOoyp5nrnFk5FFlwtYSdW09Z0sxZ7lPRc8ejOUNTwBB
         YGOQQJ3sqlA6FpZCAcJ193/HtHw7J113gkG3/VUOgpE2qiJnwLLQsLEdeUemGY/5gTzF
         wwwbCCqH19CD1xn/p387tE4f4OqQLLpF8f1o4HqlOEqFW/DD6xGzIEk2LY0RnNSf6jIR
         ffRpL6ucEkcIFV4LPHfoztR77rFY8PHLhMUCZ1gpvo1EpYQkoLz0ZaU7UoqC9OMfYyEu
         Bh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRYrYeWrcUIGVrh7Yi0UjDHuASJm37EvZyCwuvfPA+g=;
        b=Y7WxSf6nkbVpWaY84pzdk1eRr0Uy5uyK311VGLS8+Y0ifSOVMVBWOa76ubxUMaMcIe
         HA40Uav6iIpIwsgzbQOZpIkMdY5ZSm+AeJF/6QZSOl75w+l+UIMGklHQp3yRcpq/O38t
         gQ6uy7iZpCT47NoNf9vUw6dVEfTozL88vHOIYldTRAU5UJ4VcQ6Ez25cwkrPXZ3LZjei
         FngQRyBttzXOZjOQ6SZ7efEEzHgdajQ1K726b0kMONrTyJDOZ07lbm1aWIeLvYy9vo5I
         6Tf0tgNOF08lAY1zIFsqPMRAzBw8ZGfDdIyfXbMduz9tnG3+2UGt9CQQmyZ4xzAeStxs
         G7xg==
X-Gm-Message-State: AOAM532jpup2QCW3nSul09V4hyPVRcjUNfG+DIgrcegT38y/gj12mR+F
        Y28aO6qsnXqaXnBGG6GBm9CXEY1R0Bql5bdJiOo=
X-Google-Smtp-Source: ABdhPJw+DEVbvFZ7lXB1KfiPh4b9cKJwC0B5fvMJ6CDi7fViZ1yhC7nmG1N9cOwF1Ew/o0pSieXZ0hx35AlNKaF7X+A=
X-Received: by 2002:a02:2422:: with SMTP id f34mr2110157jaa.237.1644622385914;
 Fri, 11 Feb 2022 15:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20220211225007.2693813-1-andrii@kernel.org> <20220211225007.2693813-2-andrii@kernel.org>
 <20220211231559.shm25hmwuuacvvmg@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220211231559.shm25hmwuuacvvmg@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Feb 2022 15:32:54 -0800
Message-ID: <CAEf4BzZK5ZExUMnzAJFA0ObTp1BfzjTgpyOUoRNWFUO=N+23Jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: add C++-specific open/load/etc
 skeleton wrappers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Fri, Feb 11, 2022 at 3:16 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Feb 11, 2022 at 02:50:06PM -0800, Andrii Nakryiko wrote:
> >               }                                                           \n\
> >                                                                           \n\
> > -             #endif /* %s */                                             \n\
> > +             #ifdef __cplusplus                                          \n\
> > +             struct %1$s *%1$s::open() { return %1$s__open(); }          \n\
> > +             struct %1$s *%1$s::open(const struct bpf_object_open_opts *opts) { return %1$s__open_opts(opts); }\n\
>
> Why two methods? instead of "opts = nullptr" ?

Because my C++ is rusty :) I'll drop no-arg version in v2.
