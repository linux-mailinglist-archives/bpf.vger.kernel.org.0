Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDBD485FEA
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 05:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiAFEg5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 23:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiAFEg5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jan 2022 23:36:57 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365D6C061245
        for <bpf@vger.kernel.org>; Wed,  5 Jan 2022 20:36:57 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id v18so1164689ilm.11
        for <bpf@vger.kernel.org>; Wed, 05 Jan 2022 20:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V5Gz/Lm74xsGzFFZJ98TeBfFRA4N5UapnfUH8FCQnTU=;
        b=N6FDoX+MVX+sEoCwaWlHHcapQxYgdezw3D6vrVDF0IhnbljcUONLbjZPf10VzlOa6z
         cD6gUlu6mcGzUdaUiS2TsCoOTWc2gfVoGqwNmmeDh7jG6XuicNInaQYRECyDh9sqGH9a
         z9dVJi1IkgyxPZASgVUgPGeNp6xKRxUhP7ppg0Hm60MFle6aceJ3+v78Q8AR16JorI3i
         mTgMDT4/IHDh1BT5PsPHsaHLlI0DSdhNaVLnHpjevxUeCoJdj0TTlDu5rIFW0ABMKxqL
         XOWXMmRLSjqAjKKWIHl2SQUStBiVlAFZ6P2G5Wyj1LuJgZAlzZWcPuPcLszt99v0Y17n
         +0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V5Gz/Lm74xsGzFFZJ98TeBfFRA4N5UapnfUH8FCQnTU=;
        b=xwmx8fQVZr+5Uds1tM6lMUFZ3LrqFT4vUsGBDUS9jz2TounrMMErrGGclUi2Ibf+7l
         uWus1aTZd7lqxt7kORBhILFiNQQ9oMiLBXxtbxK+x5wp+utnt5KPL7BxZ79KLHXBwbaE
         1Tv9To+C2NNjHJYIF98iSkGWQyIlFme9hshb7ym7WOlHHSMZITLI49HAbo8bi5sdyqdK
         rVGJ/zMHlZixIQy+dt95++r9U8n4ghJ8vf2sHzu5v3BDhadWauVykECI3MMeQzHf2YRQ
         u6jzQtzHoJMhsTbQbvyWvA2F5VXyh/KfWzXM1uFYQg/+SFeJc7wxgnLmmDvTBVFJsnYo
         CzUA==
X-Gm-Message-State: AOAM5333yyzrosw+umB0WSwHIMa+oZt+u37F79RLY5ojVHnsfd0slv6J
        DkJrIA69aUR8og2lXLGFpJ9vIA+GYnFb0XZZTr8=
X-Google-Smtp-Source: ABdhPJz7jDM5O2m4VzfCLw7p40bYrWnJBbckozNqZ4XnCes1cDZsDrHRSTnS7SD7hQg5M5RXUOMvSErNTSWke4pGp9k=
X-Received: by 2002:a05:6e02:1a24:: with SMTP id g4mr23926957ile.71.1641443816647;
 Wed, 05 Jan 2022 20:36:56 -0800 (PST)
MIME-Version: 1.0
References: <CAO15rPnCtpSgH_Nucb=Zkp04iMS1w8uYiFGgbP4LG1rujmd9HA@mail.gmail.com>
 <5fa06774-2480-ee73-a7a6-f0e6eb760545@fb.com>
In-Reply-To: <5fa06774-2480-ee73-a7a6-f0e6eb760545@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Jan 2022 20:36:45 -0800
Message-ID: <CAEf4BzYHTLRarRrGK22JUsA6SO3HuvMfSgQVGGWmZdYeNE3RDA@mail.gmail.com>
Subject: Re: Verification error on bpf_map_lookup_elem with BPF_CORE_READ
To:     Yonghong Song <yhs@fb.com>
Cc:     Tal Lossos <tallossos@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 4, 2022 at 9:18 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/4/22 3:35 AM, Tal Lossos wrote:
> > Hello!
> > I=E2=80=99ve encountered a weird behaviour of verification error regard=
ing
> > using bpf_map_lookup_elem (specifically bpf_inode_storage_get in my
> > use case) and BPF_CORE_READ as a key.
> > For example, if I=E2=80=99m using an inode_storage map, and let=E2=80=
=99s say that I=E2=80=99m
> > using a hook that has a dentry named =E2=80=9Cdentry=E2=80=9D in the co=
ntext, If I
> > will try to use bpf_inode_storage_get, the only way I could do it is
> > by passing dentry->d_inode as the key arg, and if I will try to do it
> > in the CO-RE way by using BPF_CORE_READ(dentry, d_inode) as the key I
> > will fail (because the key is a =E2=80=9Cinv=E2=80=9D (scalar) and not =
=E2=80=9Cptr_=E2=80=9D -
> > https://elixir.bootlin.com/linux/v5.11/source/kernel/bpf/bpf_inode_stor=
age.c#L266 ):
> > struct
> > {
> >      __uint(type, BPF_MAP_TYPE_INODE_STORAGE);
> >      __uint(map_flags, BPF_F_NO_PREALLOC);
> >      __type(key, int);
> >      __type(value, value_t);
> > } inode_storage_map SEC(".maps");
> >
> > SEC("lsm/inode_rename")
> > int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_de=
ntry,
> >       struct inode *new_dir, struct dentry *new_dentry,
> >       unsigned int flags)
> > {
> > struct value_t *storage;
> >
> > storage =3D bpf_inode_storage_get(&inode_storage_map,
> > old_dentry->d_inode, 0, 0); // this will work
> >    storage =3D bpf_inode_storage_get(&inode_storage_map,
> > BPF_CORE_READ(old_dentry, d_inode), 0, 0); // this won't work
> >      ...
> > }
> >  From a quick glimpse into the verifier sources I can assume that the
> > BPF_CORE_READ macro (which calls bpf_core_read), returns a =E2=80=9Csca=
lar=E2=80=9D
> > (is it because ebpf helpers counts as =E2=80=9Cglobal functions=E2=80=
=9D?) thus
> > failing the verification.
> > This behaviour is kind of weird because I would expect to be allowed

As Yonghong explained, BPF_CORE_READ() always returns unknown scalar
that verifier cannot trust. All due to the underlying
probe_read_kernel(). BPF_CORE_READ() was never supposed to work for
such cases, it's not weird once you realize that BPF_CORE_READ() is
able to probe read an arbitrary memory location.

> > to call bpf_inode_storage_get with the BPF_CORE_READ (=E2=80=99s output=
) as
> > the key arg.
> > May I have some clarification on this please?
>
> The reason is BPF_CORE_READ macro eventually used
>    bpf_probe_read_kernel()
> to read the the old_dentry->d_inode (adjusted after relocation).
> The BTF_ID type information with read-result of bpf_probe_read_kernel()
> is lost in verifier and that is why you hit the above verification
> failure. CORE predates fentry/fexit so bpf_probe_read_kernel() is
> used to relocatable kernel memory accesses.
>
> But now we have direct memory access.
> To resolve the above issue, I think we might need libbpf to
> directly modify the offset in the instruction based on
> relocation records. For example, the original old_dentry->dinode
> code looks like
>      r1 =3D *(u64 *)(r2 + 32)
> there will be a relocation against offset "32".
> libbpf could directly adjust "32" based on relocation information.

I think libbpf supports that already. So if you use direct memory
reads on dentry type marked with
__attribute__((preserve_access_index)) it should work.

>
> >
> > Thanks.
