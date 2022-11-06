Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D400061DFF1
	for <lists+bpf@lfdr.de>; Sun,  6 Nov 2022 02:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKFBxp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Nov 2022 21:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKFBxo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Nov 2022 21:53:44 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2702D101E2
        for <bpf@vger.kernel.org>; Sat,  5 Nov 2022 18:53:44 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so4722007otb.8
        for <bpf@vger.kernel.org>; Sat, 05 Nov 2022 18:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4RjUL9GIVQIAdPM/QA+rb/e4Gr7L6zBnkJTHg7HWU5c=;
        b=gASbQi4GGnBA9elxMwautB6BT/LQVl0tSxT2m/9FXsxDJ2dRkFK5VXvbu3PIjw7bC2
         XpG7MHfhpZTrVvSWJZtsXFTxwnNUYWFmM2IMSJFA0SgAjrg/mhjl0wdv7I5fuFjAvzOm
         EL96vpsoJv1crG9xJ8SGaX360P6TE3RTqiTp3L1FRP1cXB0m/zfiJZS7eu7vm7VZjtoK
         dCV7o3x/m1FqynYUy8GvVogZHAuse4vWfPyOq6gg6X+DgmnIhElgyN6MnUdJ42UeB9x2
         ASlDCGUmze6xUeulmyHSJDKJ1gw1YXZ+xlmiWbn0/dktNDz0+E3ddHP9wtf1I0L63wwU
         s2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RjUL9GIVQIAdPM/QA+rb/e4Gr7L6zBnkJTHg7HWU5c=;
        b=KbX+Vi0EmEs/D87un4VgR+7ZjSTLSxOZyDqMGIbeA028jxFOKl+4PXlwJ7iwtwTZeH
         YLNfhic59ih0x76OpjzBxs5vNheWYi+vasNjVS6cg3nLWkZmeOhOhwXD6Hy7EmGAyL1R
         i+4OCiXRJQjRPZrRnXpAF4SszoqgVunu9kdpoyVg1XxDOPpv8GOZUlwdmpbLJsRzn9yV
         1EE0OOpS684BpEPHdyhc3gFFDLFKYJhLw+q96YKs2yiBSjOc+1/e0KZPxmujwgqKYllY
         vz/+GEePWbBb7JaoTxzbT1AdancrBZ0bQ8wYHGYarx5Dg1NsBFh2HdK/5F+AmkGhC/pK
         HN+A==
X-Gm-Message-State: ACrzQf0VDeXSDJ3F4CgoYxYRYEmX5fJSdwGMQ18eT2IocsEez0sO2yJV
        AUMOZ+JSrQe1oREdF07qq7UbWCJ9lRU49Ux0gvY=
X-Google-Smtp-Source: AMsMyM7N2prDrHLirOhR0T4mQSNn2wue+g7TUjJR1TXizoRZYkipffreC4R5CJyCxqX79oi4N4faBmXGHpYiY+aGWO8=
X-Received: by 2002:a05:6830:1419:b0:66a:a9d0:e37b with SMTP id
 v25-20020a056830141900b0066aa9d0e37bmr21788674otp.326.1667699623446; Sat, 05
 Nov 2022 18:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221103191013.1236066-1-memxor@gmail.com> <20221103191013.1236066-23-memxor@gmail.com>
 <d3765c8e-3b1b-3ea4-8612-34b8580bc892@meta.com> <20221104074248.olfotqiujxz75hzd@apollo>
 <65edb881-f877-2d90-2d5c-46fad3a41251@meta.com> <CAADnVQJbMzkYAPC8vzRHjO1jMjx=MXPMTuwfV8tYdL0vfYSSoA@mail.gmail.com>
In-Reply-To: <CAADnVQJbMzkYAPC8vzRHjO1jMjx=MXPMTuwfV8tYdL0vfYSSoA@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Sun, 6 Nov 2022 07:23:08 +0530
Message-ID: <CAP01T74OOEoDYAfCXd+nL555h2TB9J4QX70CAb7qYJwhCLMtxg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 22/24] bpf: Introduce single ownership BPF
 linked list API
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@meta.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Delyan Kratunov <delyank@meta.com>
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

On Sat, 5 Nov 2022 at 23:46, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 4, 2022 at 7:15 PM Dave Marchevsky <davemarchevsky@meta.com> wrote:
> >
> > > I was contemplating whether to simply drop this whole set_release_on_unlock
> > > logic entirely. Not sure it's worth the added complexity, atleast for now. Once
> > > you push you simply lose ownership of the object and any registers are
> > > immediately killed.
> >
> > I think that being able to read / modify the datastructure node after it's been
> > added is pretty critical, at least from a UX perspective.
> >
> > Totally fine with it being dropped from the series and experimented with
> > later, though.
>
> Kumar,
> please split release_on_unlock logic into separate patch.
> afaics it doesn't have to be introduced together with these kfuncs.

Ack.
