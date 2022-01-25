Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD0A49ABF9
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 06:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbiAYFtC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 00:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238935AbiAYFqi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 00:46:38 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A7BC035456
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 20:06:23 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id v74so14912451pfc.1
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 20:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dEF6b3Ugv6J965Xw+B5fepuJ/VFbAOycmCFtYxAAeGM=;
        b=oCbbP5aeocniONQebDYdLjS1SnmkOwNBhHRBqwBlpzSuQD2qALC+VDvfFli0ay9MXG
         qcDCs1zk1udVacmvD0qoEWPCOb72OiU37leGw7Vdl8A+vIGlTNgGXiZvsttqR6D0idUy
         qe6gcN+cVv5fhp4f8HY4Fy7uPC8ibFCppz5okG0itZQZlXMPxMhTBcghMItGF1Rj0Kl9
         xHYmQ0/8SB3imT/ln3RyGyCMdMkSTPf2AUEnMse7D+f/E2fkfTxnCBO52HWdZvSW24Hd
         hu8d7k/QsEpE/p9m5RF8Sz1hqt3FBQB3reFcqcn2yDb1TBtDHBKVygzLHs5Tf88yWtoI
         aJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dEF6b3Ugv6J965Xw+B5fepuJ/VFbAOycmCFtYxAAeGM=;
        b=SRu/MZmsNiYV/TlA3dCim6by5wQ3eu/NSLvI5fafXCXasrlW17LlZeznqE9MPAN6eL
         XP6eKek/tPdb9vCxcfGDYQ+AVl48Dl5lXcUbMY+twzop0HwQC5DU0qL2bSXFU5gdACLw
         MU/ap8F6rHjBryIHXhiYwGdmNPYARTurp00KqO4DINxk5EBmD9280MmoHN5jdT9mDLFy
         LoZe0tnU8ErSoqMZ6zL8YhO8QJ5Yw8FdF0Tm5LKrLdSatQZ1q+i/lkR0w1TF7dX2/cK3
         am4qqTk32FYpC2NLFPuVhRrLvGlQO49Xuc9iV4HaKVwshbZ9XRNqqxuDq8U6q5QIU57W
         B6mA==
X-Gm-Message-State: AOAM531wvN1/8IIeMrC79b7e6SwyEqfB3ZqNK4xD9NePCW00+Xb8s1eh
        HSjHfus4TSI6EdJ2ZJV5N5gGWbZdgAu8g98H510=
X-Google-Smtp-Source: ABdhPJw10/WsNhruDRz7M4eCoeAhmkMTtJOpViVRfGaGbqKJoD1vbcEVXrZ6BoyssHQ5KqMSgVmj+xKQ+XVyRFjEMfw=
X-Received: by 2002:a63:1ca:: with SMTP id 193mr13744660pgb.497.1643083583010;
 Mon, 24 Jan 2022 20:06:23 -0800 (PST)
MIME-Version: 1.0
References: <20220113233158.1582743-1-kennyyu@fb.com> <20220124185403.468466-1-kennyyu@fb.com>
 <20220124185403.468466-3-kennyyu@fb.com> <CAEf4BzbQQNH1=UGNLBhb8bXZzdE7uHviJ3k8vEKDg_72407aYg@mail.gmail.com>
In-Reply-To: <CAEf4BzbQQNH1=UGNLBhb8bXZzdE7uHviJ3k8vEKDg_72407aYg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 24 Jan 2022 20:06:11 -0800
Message-ID: <CAADnVQ+yLBxCpeC92Z+xzDK-K3Tj1cLUmzGSdkL0m=Sna6FL0Q@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 2/4] bpf: Add bpf_copy_from_user_task() helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kenny Yu <kennyyu@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Gabriele <phoenix1987@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 24, 2022 at 2:18 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jan 24, 2022 at 10:54 AM Kenny Yu <kennyyu@fb.com> wrote:
> >
> > This adds a helper for bpf programs to read the memory of other
> > tasks.
> >
> > As an example use case at Meta, we are using a bpf task iterator program
> > and this new helper to print C++ async stack traces for all threads of
> > a given process.
> >
> > Signed-off-by: Kenny Yu <kennyyu@fb.com>
> > ---
>
> LGTM.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> >  include/linux/bpf.h            |  1 +
> >  include/uapi/linux/bpf.h       | 11 +++++++++++
> >  kernel/bpf/helpers.c           | 34 ++++++++++++++++++++++++++++++++++
> >  kernel/trace/bpf_trace.c       |  2 ++
> >  tools/include/uapi/linux/bpf.h | 11 +++++++++++
> >  5 files changed, 59 insertions(+)
> >
>
> [...]
>
> > +       ret = access_process_vm(tsk, (unsigned long)user_ptr, dst, size, 0);
> > +       if (ret == size)
> > +               return 0;
> > +
> > +       memset(dst, 0, size);
> > +       /* Return -EFAULT for partial read */
> > +       return (ret < 0) ? ret : -EFAULT;
>
> nit: unnecessary ()

I fixed it while applying.
Also added a few unlikely().

Thanks everyone!
