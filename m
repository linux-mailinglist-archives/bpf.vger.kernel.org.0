Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3C4F18911D
	for <lists+bpf@lfdr.de>; Tue, 17 Mar 2020 23:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCQWNK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Mar 2020 18:13:10 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39009 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgCQWNK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Mar 2020 18:13:10 -0400
Received: by mail-qv1-f67.google.com with SMTP id v38so7805461qvf.6
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2020 15:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jYtKM+AJEiNhxjCPl+CECY47VWbqHsYvJIkeymeA3KI=;
        b=syoS5BFM9N7zw2uCSE3NGWgkSWjK/pDTaoQU3HnmJGj5BSl1cAwpCWLgx3JG1Akzjr
         Ub9bK2FwoZKiK1N+z7KQq1wzEAJrplvx6SVYhcvEatkRvpLcMoVUT0LuWQjNFSdbetRw
         6wUeEHCiR+7pwyCaQgfvLnZ10MQRln4jvQSgCLMR3nMsNjxpQQMKfYvw9WJvirGZ7tiC
         co4eTJAbFc6Y3DIKeda23fbh1iP8LJI9UfxdVAetImsJRqpoqTqAXlMY83HaOKMaZ2uj
         zTUeBhR2WfN2KuW+IR/RA1TtlLmzs+mXbvaAzC/Ba1vhN8W4Ssd0SOF2jupeuItoX1SW
         b5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYtKM+AJEiNhxjCPl+CECY47VWbqHsYvJIkeymeA3KI=;
        b=W9GeBPpGM/QXHALV/hykBnrawwXDaQCoS3TwClN+pjZvwEYS2gv5L6EiQpEC+BjnK1
         qijad0tOkAcG1Cbyjd6pMqsw5ryXPOlKcPhXj7revB+4Z19/LPstX7HQPWG0k/oL5SpG
         UiHwxTlJfsEjDH18WUPhi43cT1cZcSMkVJ1PIZ1XAUC7hMlDYAVvJrg5uOiMx/iavqO0
         csA4k/OD9ZzoQ3LAa6GND134lHJN8WX/imiAKmCw24hX44xOLhMz8NNQjJiHG89eTAFh
         QYECvf3C8K7bjtKNvtmQsBny28Bjqg/5tzmfoXRQQM8ZrgoEkHxj5z+iKmeXVe4hBSRo
         vVKA==
X-Gm-Message-State: ANhLgQ0Vjq6aYJGYLxyUVHl99fau3XNvLR48NgkP8dMRgb+ZvSHy9Blp
        3puv3fnpIsckuzvblgTW2wM0V6nr1vkJksLNT8M5Tg==
X-Google-Smtp-Source: ADFU+vtIQPg+X6wyaOCiRPwNMRJDvxCFPtNBsCVJh2SdG03yp/dphs2tG+v3P1MISNNxw/lajQaHCi30U3sbSGcBFIA=
X-Received: by 2002:a0c:f60e:: with SMTP id r14mr1384288qvm.43.1584483188748;
 Tue, 17 Mar 2020 15:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200317211649.o4fzaxrzy6qxvz4f@google.com> <20200317215100.GC2459609@mini-arch.hsd1.ca.comcast.net>
 <20200317220136.srrt6rpxdjhptu23@google.com> <CAKwvOd=gaX1CBTirziwK8MxQuERTqH65xMBHNzRXHR4uOTY4bw@mail.gmail.com>
In-Reply-To: <CAKwvOd=gaX1CBTirziwK8MxQuERTqH65xMBHNzRXHR4uOTY4bw@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 17 Mar 2020 15:12:56 -0700
Message-ID: <CAKH8qBteBDQp_Jw2RhM5u6x2q75+PtRwX6jZZQggjpeohWQEzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] bpf: Support llvm-objcopy and llvm-objdump
 for vmlinux BTF
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Fangrui Song <maskray@google.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 17, 2020 at 3:08 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Mar 17, 2020 at 3:01 PM Fangrui Song <maskray@google.com> wrote:
> >
> > On 2020-03-17, Stanislav Fomichev wrote:
> > >Please keep small changelog here, for example:
> > >
> > >v5:
> > >* rebased on top of bpfnext
> >
> > Thanks for the tip. Add them at the bottom?
>
> "Below the fold" see this patch I just sent out:
> https://lore.kernel.org/lkml/20200317215515.226917-1-ndesaulniers@google.com/T/#u
> grep "Changes"
>
> $ git format-patch -v2 HEAD~
> $ vim 0001-...patch
> <manually add changelog "below the fold">
BPF subtree prefers the changelog in the commit body, not the comments
(iow, before ---).
Add them at the end of you message, see, for example:
https://lore.kernel.org/bpf/a428fb88-9b53-27dd-a195-497755944921@iogearbox.net/T/

> --
> Thanks,
> ~Nick Desaulniers
