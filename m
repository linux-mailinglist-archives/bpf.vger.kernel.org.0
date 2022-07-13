Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0632A572AC9
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 03:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiGMB0X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 21:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbiGMB0H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 21:26:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F6BBBD09
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 18:26:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id mf4so16140491ejc.3
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 18:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlLcMLFvxfqij4FG70W/Bw9jvrhcYlunIbQ7VlhmKPg=;
        b=Wf6OgoflkWi08/aYPnLfbu02AgryaQxFrTv2txYyepf2deDwikiuN3zJF2fkrRokaW
         CjR+pMYXY6/nFCvCsa5+2AnzLBQZjqKdQqOSfEOR6CmdA7uuhzxVyGwhDESqJcDTBipz
         lqrN6HiZnW9Gql8Btr0esn7P1GSn28QzA04+R1iJlpMGR7z+z1Xh2vCVHlX0ocBSvyUR
         RviLHo43XeF6V6l5JSFMxz8GasX24ZD485wVH6rKRquQTb8Ng65jE0w373qbUU1fhHQM
         wGltJtltMhRbsQV7x+oAWyI1nbud8PHz53pvQVZARgUvCqkxDv5+9WF8oUyn2bMIZCfO
         91cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlLcMLFvxfqij4FG70W/Bw9jvrhcYlunIbQ7VlhmKPg=;
        b=rymaLqzn506ZhIoxS7KAic4WxTxRGQfPpJDjNqs9qo20j+sBgprPxl9WbdqeJyFeih
         OagPleBmOGhkDkfdI5MvaWbkMdiTwK2dsbkLRUIIHLKJDh9yHYF8Wj0dYirVvwJBS12N
         tMSwJ52gl+sCDyY3BLKFpKtCk4xDV4eudA2vt9LDVgwyMnbzgYPKURFwFDbhOFg9NBjD
         iujRIhJdO88o6FIBbqQmqsBhltzDrItOhYwsL4nMTc0YCkwpyYpFgNqjPwpratBA13MD
         AXALVKyFu3svIbJYZXk3IBAEYhDREXvfeEQc4tuz1cXhP48rkufbYcd2GiP08rbHvWDJ
         oEYQ==
X-Gm-Message-State: AJIora90y4C40BM5gFW6RvLPxnNX+Ay5fkMccXg5lXeOFs3P05gifFEC
        /M3xg2RdsBgBZ0y0gfjfH0sXiyf8f+JjHZ4QsEo=
X-Google-Smtp-Source: AGRyM1tbpTW+h0CU01FToIZ1UHCUisFuTSFGU4ZzQOAEyJmKXt5GnIHxYv5yhjSiwSJEwWhX8FDiJws0jte2geeOFX4=
X-Received: by 2002:a17:907:c14:b0:72b:6762:de34 with SMTP id
 ga20-20020a1709070c1400b0072b6762de34mr991834ejc.94.1657675564979; Tue, 12
 Jul 2022 18:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220712210603.123791-1-joannelkoong@gmail.com>
 <Ys35McCz+TZEdorp@google.com> <CAJnrk1bVEBXUUjp71+VFaYrRqsDharKRfpvb1theJQ-fP5+EKQ@mail.gmail.com>
 <CA+khW7jL+ajYEBXO_ge5gTHZ9ga+pAAzpvHSjyh+NtK=GL3RXg@mail.gmail.com>
In-Reply-To: <CA+khW7jL+ajYEBXO_ge5gTHZ9ga+pAAzpvHSjyh+NtK=GL3RXg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 12 Jul 2022 18:25:53 -0700
Message-ID: <CAADnVQKD54uwr0H8od60BAiBDMEoNcOi3fmxYUiDp6G9dzLQNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Tidy up verifier check_func_arg()
To:     Hao Luo <haoluo@google.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
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

On Tue, Jul 12, 2022 at 6:20 PM Hao Luo <haoluo@google.com> wrote:
>
> On Tue, Jul 12, 2022 at 6:10 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > On Tue, Jul 12, 2022 at 3:44 PM <sdf@google.com> wrote:
> > >
> > > On 07/12, Joanne Koong wrote:
> > > > This patch does two things:
> > >
> > > > 1. For matching against the arg type, the match should be against the
> > > > base type of the arg type, since the arg type can have different
> > > > bpf_type_flags set on it.
> > >
> > > Does this need a fixes tag? Something around the following maybe:
> > >
> > > Fixes: d639b9d13a39 ("bpf: Introduce composable reg, ret and arg types.")
> > >
> > > ?
> > I will add that tag. Thanks!
>
> Joanne and Stan, IMO this is not necessary. I think this change is a
> cleanup rather than a fix.

I don't see the bug easier.
The helper types that are compared directly as arg_type
instead of base_type(arg_type) were all without flags so far.
So I don't think the patch changes behavior or fixes anything today.
It looks like a good future proofing change though.
Am I missing something?
