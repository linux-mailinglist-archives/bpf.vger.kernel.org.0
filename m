Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE5A33F5FC
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 17:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhCQQqG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 12:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbhCQQpz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Mar 2021 12:45:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A49C06174A
        for <bpf@vger.kernel.org>; Wed, 17 Mar 2021 09:45:54 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id y1so3979331ljm.10
        for <bpf@vger.kernel.org>; Wed, 17 Mar 2021 09:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Z/CsV2ufS440gwkb9MRs8lU8pRQgByiiPLU8x4xbLs=;
        b=uhGuTDyhqfjeK0/NtWCNePOvfeC+9ziAQ0J1ixkrnhEo2vDxTEEyul+qMX0PwCubE3
         Ot95rVLHp2Rl8+Cs5DvD04LpAg5uBYENpYxqVfIDvAxc1yoihNKsG3ZbAo/5T7tTEMUv
         u+i470ux4F7dIa3d6tPDEYbQotapR8mW1ZrBeQfCifXW2dH8vwkWAIifP1ZMOPQqUmtz
         ZR7do+uFnMEoNuZ09j8Mr4n4hy3uDnSMcJsePc63tZyivspvMP6kE8GJTtgx2ID0gwz6
         4NLIedvWTrgqgYV5KQOsTMpP73XwdUXLYQQzgtSoJlv7MQINFkaOsPlB+bo77poeu8kK
         LOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Z/CsV2ufS440gwkb9MRs8lU8pRQgByiiPLU8x4xbLs=;
        b=qTW3U2tH8gDmHxEuujHF+zSxLoknjI2AP9NCNCpDa9cUhjgtQ3guY1Y8CPgMRljEcY
         dudJ+Al9m+65qvsA76uXxSAYCqns4kwp1ac7I19a3fkS4UL1QoXAt1c4ZK7wjmG4OUUs
         AJR+ULv7AFZgkTr+yc2EtvJOy9urHj2ROy6H4lzK71tZv5gVYFrNkb/oHU/Pw10iYMqE
         ZDoUSeZENH1yGI/KCU6i2rX5JR2mRzZ1TJPPK1px9wqffqsv1k5U1Sja/ITXCAbt71PO
         6U0IBFw0pd8o8sm84/VztVP3uBO4JwDmz4BfO7jsTGASM99uIfi5nhWskC9uSUqZkUkf
         DarA==
X-Gm-Message-State: AOAM533Opdi87cqwLs9TbXf73t050NqmtAzzSGVbQuBLyT9uJWMm1KR6
        s6gJZc+GbNOKkEkeBbcV1e+LIJR2wFI+i79Grvc=
X-Google-Smtp-Source: ABdhPJzxx8A1H9DvQ1CUhJoKRvCpkKU2GT9foFoTtIQV2KBV2W+QxkJ0KZwLisAzeHEznXTAU4md26hFunaqBCV/Itk=
X-Received: by 2002:a2e:b817:: with SMTP id u23mr2865106ljo.44.1615999553317;
 Wed, 17 Mar 2021 09:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210317042906.1011232-1-yhs@fb.com> <CAADnVQLY1ftbZxFqAMSN4amWoYZN0ka3DyVLXAWhgsTO7V9V+Q@mail.gmail.com>
 <58a10cec-180b-d8d5-e1d3-de9b695a8878@fb.com>
In-Reply-To: <58a10cec-180b-d8d5-e1d3-de9b695a8878@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 17 Mar 2021 09:45:42 -0700
Message-ID: <CAADnVQ+hUjX-Hk9=9X+=ii1SusfsZJrsxXUn4krH1bUvNjuVRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: net: emit anonymous enum with
 BPF_TCP_CLOSE value explicitly
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 16, 2021 at 10:58 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 3/16/21 10:44 PM, Alexei Starovoitov wrote:
> > On Tue, Mar 16, 2021 at 9:29 PM Yonghong Song <yhs@fb.com> wrote:
> >> +       BTF_TYPE_EMIT_ENUM(BPF_TCP_ESTABLISHED);
> >> +
> >> +       return 0;
> >> +}
> >> +late_initcall(bpf_emit_btf_type);
> >
> > I think if we burn a dummy function on this it would be a wrong
> > pattern to follow.
>
> Maybe we can pick another initcall to piggyback?
>
> > This is just a nop C statement.
> > Typically we add BUILD_BUG_ON near the places that rely on that constraint.
> > There is such a function already. It's tcp_set_state() as you pointed out.
> > It's not using BTF of course, but I would move above BTF_TYPE_EMIT_ENUM there.
> > I'm not sure why you're calling it "pollute net/ipv4/tcp.c".
>
> This is the minor reason. I first coded in that place and feel awkward
> where we have macro referenced above and we still emit a BTF_TYPE_EMIT
> below although with some comments.
>
> The major reason is I think we may have some uapi type/enum's (e.g., in
> uapi/linux/bpf.h) which will be used in bpf program but not in kernel
> itself. So we cannot generate types in vmlinux btf because of this. So I
> used this case to find a place to generate these btf types.
> BPF_TCP_CLOSE is actually such an example, it happens we have a
> BUILD_BUG_ON in kernel to access it.
> Maybe I am too forward looking?

It's great to be forward looking :)
I'm just having a hard time justifying an empty function with single 'ret' insn
that actually will be called at init time and it will stay empty like this for
foreseeable future. Static analysis tools and whatnot will start sending
patches to remove that empty function.
