Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AA95B3C7E
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 17:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiIIP7q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 11:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiIIP7n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 11:59:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B20A1BE
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 08:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84AC562060
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 15:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70B6C433C1
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662739170;
        bh=ZHsLAWGvQWhYL6GNYnsHZqNDZDu93v7rq8g6qKx4/3Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=omSINE90XbvquXUJyAnOk1ngFIwSXpMJPiTC2I8e2StU9tNe8YGTZVltZD8OSkMYc
         nKqKtrsx4It3RAJ3DwAIFlI+mn6PyTEEb5eLw7KFLKg4sSAT9RQ5SESyp+HCmEd9CW
         wQgAFfbqkPppOSV4k7Mgdi1HzXo2Nlc67yN0GGPEEXlV5g1AoHuOLY4GNiyRFQYj+m
         ZGg4GSXhrmnKgGz6rfQ9DU0etenOAT8DpiYwZQHnZOUfkLhmgxR1BlyMqVXTxLopa5
         /MCUtBgV+dtNIA/51YA/lwQdKbYj2WrImd7roavKYg2oycZlrAsLyVhWoMxnWXQPVm
         lHAYpS4w0QxgQ==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1274ec87ad5so5100054fac.0
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 08:59:30 -0700 (PDT)
X-Gm-Message-State: ACgBeo3AordFyUqF5j/+wl+1EJfBW/63YmVFQoteugOHh7wFm6w2tn2p
        1JhvWQ9M8O3wJpWT4/Eb0O7Bufrp3vk4DwPeAg0=
X-Google-Smtp-Source: AA6agR5SxPqK3xYE2Yq8/bHdy/e14Rx38Aw9RoKGXfs0qii8Boqhq5Y7hTwtU6HJQh9Y169uqAwb8zPwflDC1heHkV4=
X-Received: by 2002:a05:6870:32d2:b0:127:f0b4:418f with SMTP id
 r18-20020a05687032d200b00127f0b4418fmr5623537oac.22.1662739170086; Fri, 09
 Sep 2022 08:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
 <20220908000254.3079129-2-joannelkoong@gmail.com> <CAPhsuW4kKjpPLJueKH1_jqpJp2XqaCZPr5X+dS6G=5JXpqFqwg@mail.gmail.com>
 <CAADnVQJBKsiuDV18KaSqAzQvXhS7TcpOxMpEPqLyh2K2wd_tSg@mail.gmail.com>
In-Reply-To: <CAADnVQJBKsiuDV18KaSqAzQvXhS7TcpOxMpEPqLyh2K2wd_tSg@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 9 Sep 2022 16:59:19 +0100
X-Gmail-Original-Message-ID: <CAPhsuW6Q0pYOshF_1gxKZNdzsWMTw0UrWT+dZVLxDFXk+eHWog@mail.gmail.com>
Message-ID: <CAPhsuW6Q0pYOshF_1gxKZNdzsWMTw0UrWT+dZVLxDFXk+eHWog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/8] bpf: Add bpf_dynptr_data_rdonly
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, martin.lau@kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 9, 2022 at 4:32 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 9, 2022 at 8:29 AM Song Liu <song@kernel.org> wrote:
> >
> > On Thu, Sep 8, 2022 at 1:10 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> > >

[...]

> >
> > Let's return NULL for void* type.
> >
> > >
> > > -       if (bpf_dynptr_is_rdonly(ptr))
> > > +       if (writable && bpf_dynptr_is_rdonly(ptr))
> > >                 return 0;
> > ditto
> > >
> > >         type = bpf_dynptr_get_type(ptr);
> > > @@ -1610,13 +1610,31 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len
> > >                 /* if the requested data in across fragments, then it cannot
> > >                  * be accessed directly - bpf_xdp_pointer will return NULL
> > >                  */
> > > -               return (unsigned long)bpf_xdp_pointer(ptr->data,
> > > -                                                     ptr->offset + offset, len);
> > > +               return bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);
> > >         default:
> > > -               WARN_ONCE(true, "bpf_dynptr_data: unknown dynptr type %d\n", type);
> > > +               WARN_ONCE(true, "__bpf_dynptr_data: unknown dynptr type %d\n", type);
> >
> > Let's use __func__ so we don't have to change this again.
> >
> > WARN_ONCE(true, "%s: unknown dynptr type %d\n", __func__, type);
>
> WARN includes file and line automatically.
> Do we really need func here too?

I think func is helpful when I read a slightly different version of the
code and line number changes. (Well, maybe I shouldn't do this.)

I won't mind if we remove it. We just shouldn't hard code it manually.

Thanks,
Song
