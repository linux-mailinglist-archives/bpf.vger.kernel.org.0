Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6663E199F77
	for <lists+bpf@lfdr.de>; Tue, 31 Mar 2020 21:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgCaTwq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Mar 2020 15:52:46 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:35478 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgCaTwq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Mar 2020 15:52:46 -0400
Received: by mail-qv1-f68.google.com with SMTP id q73so11565577qvq.2;
        Tue, 31 Mar 2020 12:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=koHaz81lhgaXvonX4hggctipHiIr1mGPAtaGs6zrD+k=;
        b=rQFIT72Et7kZxvV9ZT3qf2ai3odXDA+Rw5lBTGYKfT+zcq9+3mmWUQQTnApBLrQlp9
         uwfmGPNZNgHrsCE3XwLFl7juRRAwwKRPBWstIv+zzDOY5AK1CaG+jDkC1ILk3+hkvVWx
         hxgi8aDjdtkbyXlNU5Osjy9hzHjlvYn3flsqGLZ68rJKu6Lc63ucjDBiCJOZqQF0+5rk
         8CtxZD+4608C2N/bQjEpmxHSq3UZ9zYW1hNjAzNsxoNe7Pio9EYKlcXQ2Voh+9gGXkeN
         cMe1cLQke6eieaREOjSACS6aRhLYoLetGBF201SPbq8FJr0NLJS/jE8mAJm+X+XXFzXX
         VIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=koHaz81lhgaXvonX4hggctipHiIr1mGPAtaGs6zrD+k=;
        b=T7AKpf+X7ZRxbvQKkgVvBcf/0+mk4mDWtE38tKPExmIrfsJNQaET6T9MR8aSKkXS3P
         22aIYHNELXlFrqvwdLdvkGK1+cxWccNH4sZYERR31kpOPyURTUZ/HVX/wQ1WE9oBYJ8D
         njxUaG1779LMmFvomS6tRGtgBbXXHAyrsIUnl2CmMfajEtz+R4NP0xEzKmAV9kNzy0wR
         5fFIPsmihkNFhbN40mtkp2BUSdDl/rDzx5qrPhhAWXo+cF7l4FBMgP8CGbLYyRAoMNPY
         yA1ga/ZZBfBbpWGmf2GaQqlxRhf131zOC2/CeEEYoSGRmn+I+a5DFarAn0kMn2001Wub
         9MfQ==
X-Gm-Message-State: ANhLgQ1nQPhHJmCS0uDP9dMdZlqmwgXw/d2vzpj3TUnOCDjShT7ScX45
        7qJmsUDTXcoP1FnNRI8xxR9m2CisWfJZ1ybCLIG9+el0hqo=
X-Google-Smtp-Source: ADFU+vt1v6vuUyeI2qgZMpH4ZL3/iH3gkayh1/w7Q3qPbXyl/kgZ71PnSOlm8lwdtt/9c6lhZHQ7qRgfHri9Ixre7Cs=
X-Received: by 2002:ad4:4182:: with SMTP id e2mr17704518qvp.247.1585684365293;
 Tue, 31 Mar 2020 12:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200331164719.15930-1-slava@bacher09.org> <CAEf4BzadnfAwfa1D0jZb=01Ou783GpK_U7PAYeEJca-L9kdnVA@mail.gmail.com>
In-Reply-To: <CAEf4BzadnfAwfa1D0jZb=01Ou783GpK_U7PAYeEJca-L9kdnVA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 Mar 2020 12:52:34 -0700
Message-ID: <CAEf4BzaAZ5Qop0z8r+SBNQyPtt0+EpKy9Q0EkcSDkTZw54Bnaw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: disable DEBUG_INFO_SPLIT when BTF is on
To:     Slava Bacherikov <slava@bacher09.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 31, 2020 at 12:45 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Mar 31, 2020 at 9:57 AM Slava Bacherikov <slava@bacher09.org> wrote:
> >
> > Currently turning on DEBUG_INFO_SPLIT when DEBUG_INFO_BTF is also
> > enabled will produce invalid btf file, since gen_btf function in
> > link-vmlinux.sh script doesn't handle *.dwo files.
> >
> > Signed-off-by: Slava Bacherikov <slava@bacher09.org>
> > ---
> >  lib/Kconfig.debug | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index f61d834e02fe..a9429ef5eec8 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -223,6 +223,7 @@ config DEBUG_INFO_DWARF4
> >  config DEBUG_INFO_BTF
> >         bool "Generate BTF typeinfo"
> >         depends on DEBUG_INFO
> > +       depends on !DEBUG_INFO_SPLIT
>
> Thanks for following up! This looks good, but I think there are more
> DWARF-related configs that should be banned. See [0] and [1]. If you
> don't mind, let's use your patch to disable all of them in one go. So
> can you please update and disable DEBUG_INFO_REDUCED and
> GCC_PLUGIN_RANDSTRUCT? Thanks!
>
>   [0] https://lore.kernel.org/bpf/202003311110.2B08091E@keescook
>   [1] https://lore.kernel.org/bpf/a2b1a025-6a70-c3a5-fc19-155f0266946a@fb.com
>

I guess at this point it should go against bpf tree, so please update
header to [PATCH v2 bpf]. Please also add Reported-by and Fixes tag:

Reported-by: Jann Horn <jannh@google.com>
Reported-by: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Fixes: e83b9f55448a ("kbuild: add ability to generate BTF type info
for vmlinux")

Thanks!

>
> >         help
> >           Generate deduplicated BTF type information from DWARF debug info.
> >           Turning this on expects presence of pahole tool, which will convert
> > --
> > 2.24.1
> >
