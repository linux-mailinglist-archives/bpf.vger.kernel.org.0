Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022F24ACA37
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 21:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiBGUNv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 15:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241697AbiBGUKD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 15:10:03 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F42AC0401E5
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 12:10:02 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id s18so18338183ioa.12
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 12:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYsKrnJL9mwiDiXfpIHFUcCSC2eZ3d99tWm1ZLQlPTY=;
        b=KMTdOjMJslqXUxtn8x/noSNdgpIHnOXuZNMUv+Psf71qa2l9136FaErpSyNg5kWcU3
         t1G8gWfeX+lcR4GsO6+DRQGEhCHEbVDrz8GibMeuhd4AsWOTk/CdVWbc5855invRiceu
         zGLUtn9i+1HOuKTMQ7/hTzeouczT7s8Xf8CdDVufIXgt7B12h4XLievtgGIfVoq89i9H
         ASRoNH3YxyaBItO60Dxo3u9dVKnxwnQPZ8ccpisVDp0EiFfS/k9n9ZBgeNT2wQyizeOX
         yvC9qi0aWC3FyjmimzpgNBKsxcFAfkV0tV2ZDd+x86bFJRT9wFrRsyxL48poNB6+bKe8
         CK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYsKrnJL9mwiDiXfpIHFUcCSC2eZ3d99tWm1ZLQlPTY=;
        b=UJUQRGathjIVBgRQTRv2JLjz7D7DwGv3Sa+DJ5OcyDvKAH9giPURHwNos4HTWYBgXK
         eg7IKXptBBizU4YXT/OdNkP8te91aY8tWoVmecDTZXApT+18xJlJ0PZ2xOpe/dbNUVtz
         rpiOWSwQP7nD2LMKHAhXt6CsFbsvJ673gRHuF8OImzLlA76oX0dUztvlaGErvUwKCjZk
         r+LMOVmv/ImQPgVZGeULWW4M/6bf8onGG2MUj4f9pGxsxizqQy5r3Ql9iVUiqYHz33Q5
         l2+7d/d9ZZkGJCouujvjMKyn9U36FAE+cm6UDxgI0dxpwzDya1UEACHj1fnyqX6+at1y
         nzAQ==
X-Gm-Message-State: AOAM532VsbfcrSV0PzJ9EsaKiqW0H+71mAzobCjD6wZJZZlc5OVgQJqf
        mMvshqWRhnbmvna5Pg3gRLKvZYEGuYI3bF7OXRc=
X-Google-Smtp-Source: ABdhPJzE5d40plyACuRUCnLjBfKFfGUrJQdJuCcB/jUpF11F3EQ7v5Rh4UFS/WrFE20MX7iYiqlT1ZnbDvb/y1PLZSo=
X-Received: by 2002:a05:6602:2d86:: with SMTP id k6mr559618iow.79.1644264601731;
 Mon, 07 Feb 2022 12:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20220206145350.2069779-1-iii@linux.ibm.com> <CAEf4Bzb1To5+uLdRiJEJUJo4PckVDEBEtENC14Cuf-mkxrnxgA@mail.gmail.com>
 <5e4b012be25cbbb44ecb935de745e17ed5c16f28.camel@linux.ibm.com>
 <CAEf4BzZfn4-dbnRcsStu+EoKD12EoKCShcoAVH9Gj0mqieBAaw@mail.gmail.com> <YgDqYFsLwkWZvX0+@osiris>
In-Reply-To: <YgDqYFsLwkWZvX0+@osiris>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Feb 2022 12:09:50 -0800
Message-ID: <CAEf4Bzbj5YVFwtwtXXjYSQW5SzpmJY4z339z1wBxUuWFRw2PWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] Fix bpf_perf_event_data ABI breakage
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        bpf <bpf@vger.kernel.org>
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

On Mon, Feb 7, 2022 at 1:46 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> On Sun, Feb 06, 2022 at 10:23:19PM -0800, Andrii Nakryiko wrote:
> > I'm not sure the origins of the need for user_pt_regs (as opposed to
> > using pt_regs directly, like x86-64 does), but with CO-RE and
> > vmlinux.h it would be more reliable and straightforward to just stick
> > to kernel-internal struct pt_regs everywhere. And for non-CO-RE macros
> > maybe just using an offset within struct pt_regs (i.e.,
> > offsetofend(gprs)) would do it?
>
> user_pt_regs was introduced on s390 because struct pt_regs is _not_
> stable. Only the first n entries (aka user_pt_regs) are supposed to be
> stable.
>
> We could of course reduce struct pt_regs to the bare minimum, which seems
> to be the current user_pt_regs plus orig_gpr2; which semantically would
> match more or less what x86 has.
>
> Then move pt_regs to uapi, so it is clear that it cannot be changed
> anymore, and have additional data in a separate structure on the stack,
> which has pt_regs at the beginning, and access this additional data with
> container_of & friends.
>
> I guess that could work, even though this requires to keep user_pt_regs
> "for historical reasons".

It's just surprising and constraining that UAPI struct can be extended
by adding new fields at the end :( I'll let you guys decide it for
s390 and arm64. From libbpf's side, we have somewhat hacky ways to
work around that, it seems.
