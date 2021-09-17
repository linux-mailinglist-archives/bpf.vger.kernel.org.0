Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C0040FEC7
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 19:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhIQRql (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 13:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbhIQRqj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 13:46:39 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9C4C061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 10:45:17 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b64so19982487qkg.0
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 10:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KPuouTePfXIs9ptnoV9Zge61E3akNWWMtQE1GdB7XHk=;
        b=XquGnmYkvfRnatOZq/1Yqx7Jg6Fn0NKPmxXf0k3B1CGe/I/fWa6xF0owOBVqXhDlC5
         S9QfvsOtxAGhGc9TI2NQb2LxSyP/PqIBQx4skub1zkqL5oVsE/C7mbvYqFfV98sMWt9r
         MV0je+K1DzkGvhLyeU7afJHWWJYMgOVYut8uOAPKUv5N6qPDS/uflp8VPJPFm7J3PeVR
         P9ktYOSIGMR6XyJlcSNBH/ipiAQz0wXpDg9J8FqG3e0au1osR87h1ZJiUmsSG3wQwIWx
         Po4JFQR57XgjccfEEUPZkHgyURc6vsnYxR5CRawO077ikCt/FXe1RCXJvW1EnyptNJO+
         N/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KPuouTePfXIs9ptnoV9Zge61E3akNWWMtQE1GdB7XHk=;
        b=0dn5o3lGnywJhlRzarUKh31c1eZ47ZKrcIU7l1vMR5RAS0XDNnkh28PXMpmtfUunS5
         8ANlnsoTrTBvuIh/i2mrH5wkqhWAPQzWmsQoqhuWfZa7lmJA1C0cCK1uXWHT6jPwwT5Q
         sLxOm491e3Gkz5QAUIjEUO4kJIHdTx+grgmM25VN6mIvGPAyfVGNJQEBRrc2ZQZshYMf
         L3MqLGPTDsukORM82ICHknyEoZu3dY5fmL7tsRsyfi+k3SdyPPi5xs9FalkzBCocKORF
         9ymsnnOGUJnStpgG/M4CYPsjXbguCIVT47v4DCUh7boCQJoXKND+jAV//ZlHJticIQFE
         uWOg==
X-Gm-Message-State: AOAM533wj7Zl6Wr9nmSDlTQTJly2BQG1x9L/GATOfoWqrv+t1HO39flI
        mmWWAt4nNXUpFSIT1j6tkjHI9ThIbR/VHIxJuGXZUEEB
X-Google-Smtp-Source: ABdhPJwwPqSbtsXPzyiht/lTCUQnkSabBZ61sWK8bWfoS0gA0BsO7Y6wmL8Nwu2N+e72G39jMWOnPxn2PogOr/ZlMh8=
X-Received: by 2002:a25:1bc5:: with SMTP id b188mr14779038ybb.267.1631900716576;
 Fri, 17 Sep 2021 10:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210909133153.48994-1-mcroce@linux.microsoft.com>
 <20210909133153.48994-3-mcroce@linux.microsoft.com> <20210909182301.javodesbocpianzd@ast-mbp.dhcp.thefacebook.com>
 <CAFnufp3Gx11kknVZhZ+MxdpYJKg6awiCpssFoyUcyFrvQ8=eqw@mail.gmail.com> <CAADnVQ+j2zZecHSuc46HZ=wYmwqFEqDuO=xgfirguKKUWAJCBg@mail.gmail.com>
In-Reply-To: <CAADnVQ+j2zZecHSuc46HZ=wYmwqFEqDuO=xgfirguKKUWAJCBg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Sep 2021 10:45:05 -0700
Message-ID: <CAEf4BzaRuU5Zj3h1vRqjTf-vKghsYsLPdmJ+q7Knz9pGoBYyTA@mail.gmail.com>
Subject: Re: [RFC bpf 2/2] btf: adapt relo_core for kernel compilation
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 16, 2021 at 9:12 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 16, 2021 at 6:22 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> >
> > How can we share the helpers source too instead of duplicating it?
>
> Ideally. Yes.
> Andrii pointed out that libbpf's btf.h is installed,
> so it's part of libbpf api.
> Therefore it's safer to rename kernel helpers with equivalent meaning
> instead of risking libbpf renames.
>
> >
> > Indeed, I found a small difference between the userspace and kernel code.
> >
> > In tools/lib/bpf/btf.h we have btf_is_mod() which returns true for
> > { BTF_KIND_VOLATILE, BTF_KIND_CONST, BTF_KIND_RESTRICT },
> > while in kernel/bpf/btf.c we have btf_type_is_modifier() which returns
> > true also for BTF_KIND_TYPEDEF.
> >
> > Which is the right one?
>
> btf_is_mod() is part of libbpf btf.h, so we cannot change it.
> btf_type_is_modifier() is kernel internal helper.
> It doesn't need to change and doesn't need to match.

libbpf's btf_is_mod() is not including typedef because there are cases
where typedef shouldn't be skipped. I see one such case in btf_dump.c.
So typedef is certainly not just a modifier from libbpf's point of
view. Kernel doesn't care, though, which is why this difference
exists.

> The equivalent helpers are
> skip_mods_and_typedefs() in the libbpf
> and
> btf_type_skip_modifiers() in the kernel.
> In this case it's probably better to search-and-replace in libbpf.

27 uses in kernel vs 42 in libbpf, so, technically, libbpf should win.
I don't mind mass-renaming of internal helpers, I'd just prefer the
name of the function to reflect the actual logic (where as I pointed
out above, libbpf knows and cares about the distinction between
modifiers (const, volatile, restrict) and typedef). Should we rename
both to btf_type_skip_mods_and_typedefs() or
btf_type_skip_mods_typedefs()?

BTW, kernel might need to start caring about typedefs separately from
modifiers in the context of btf_tag work by Yonghong. Typedefs might
have btf_tags associated with them, I think.

> In most other cases kernel search-and-replace will be necessary.
> For example:
> btf_type_vlen->btf_vlen
> btf_type_member->btf_members
