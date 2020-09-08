Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69552620EB
	for <lists+bpf@lfdr.de>; Tue,  8 Sep 2020 22:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgIHUSX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Sep 2020 16:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbgIHUSX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Sep 2020 16:18:23 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C497C061573;
        Tue,  8 Sep 2020 13:18:22 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id r7so285480ybl.6;
        Tue, 08 Sep 2020 13:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQJN/DWPIdyI373HrJDDwFfguuQqMXjivTUOJl5vaKM=;
        b=MmjF1tZJs6a4XKY0p+rE7V9wumD38XphBr8L9pa+4M9VOgUDfRavWAuG6Ib/y4vQd0
         cGyY7cuGHE5bLg9nplPW4oXl8jWTTZsiy1paH6cL5FNO7qKVqAFbIom/FV540dTfO5zL
         athWGespVV0ICge843/sdKR+xryCeqrm5/hGEh5XdmFcLlBJSbWo2rfuMAdxTSh+vpwW
         2BlD9l1wvXgVXQ16Yedc5ujzKv1Po5PdCOswDPCZ8shLWhNMQESepxbisQMh+RDx8CKM
         BNbMMim/TSkIQZ/y/1pW0vtyBk5dLGOyI3IXgWjg0VpdfspCA8aQZUGfaYXPZVabbU9P
         iuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQJN/DWPIdyI373HrJDDwFfguuQqMXjivTUOJl5vaKM=;
        b=aPhPYaEwkTCCaGI5B/YIjdIne8lvMqU3QQUWQDwXv2yzZyk4c458KTL96ntkUS3RUd
         SGSNvaDKoIKcrdX4MarvzV9uraQ4QzYkzNA7u9qzkteGq+uj5qauQKKxXwE6mMuqWoNR
         UX4Oe9eJWUZMBaYpnS50eEpRPz2dD7tN4ow8za/Ua2eNTazYW70D+SAZI/Xqc5OcUkws
         UH5muM3M0bVbxUT/44i+v5K/6gmb1P2D4meHp8kj9BZwYsP6xulIuFE0o0z+tfNcEKof
         PgOw7ZAzCSFlswtdeNXOt6x84Wh4Qwser7b72cWRvEithnIf9O4+0WAPuVptj+4gr6bu
         onlQ==
X-Gm-Message-State: AOAM532edjLQ9mwhZahFs54JSfIMkXFrQ1Y260xxLy13FCYKHgFK5ihU
        ogkeyfOf3x4Reqg1x/wq4boMHwbeZNiGpGXTkcc=
X-Google-Smtp-Source: ABdhPJwvznq8jD2dlu9qG+NWXdRMAuyyllk+dwBzU2Bbpq+uyXtW5J8mzY6KyyhqIFh4fDW/+0uVwvbJ/e5C+RT7ROU=
X-Received: by 2002:a25:cb57:: with SMTP id b84mr861599ybg.425.1599596301830;
 Tue, 08 Sep 2020 13:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGftE8ipAacAnm9xMHFabXCL-XrCXGmOsX-Nsjvz9wnh3Zx-w@mail.gmail.com>
 <9e99c5301fbbb4f5f601b69816ee1dc9ab0df948.camel@linux.ibm.com>
In-Reply-To: <9e99c5301fbbb4f5f601b69816ee1dc9ab0df948.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Sep 2020 13:18:11 -0700
Message-ID: <CAEf4Bza9tZ-Jj0dj9Ne0fmxa95t=9XxxJR+Ce=6hDmw_d8uVFA@mail.gmail.com>
Subject: Re: Problem with endianess of pahole BTF output for vmlinux
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Tony Ambardar <tony.ambardar@gmail.com>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 7, 2020 at 9:02 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Sat, 2020-09-05 at 21:16 -0700, Tony Ambardar wrote:
> > Hello,
> >
> > I'm using GCC 8.4.0, binutils 2.34 and pahole 1.17, compiling on an
> > Ubuntu/x86_64 host and targeting both little- and big-endian mips
> > running on malta/qemu. When cross-compiling Linux 5.4.x LTS and
> > testing bpftool/BTF functionality on the target, I encounter errors
> > on
> > big-endian targets:
> >
> > > root@OpenWrt:/# bpftool btf dump file /sys/kernel/btf/vmlinux
> > > libbpf: failed to get EHDR from /sys/kernel/btf/vmlinux
> > > Error: failed to load BTF from /sys/kernel/btf/vmlinux: No error
> > > information
> >
> > After investigating, the problem appears to be that "pahole -J"
> > running on the x86_64 little-endian host will always generate raw BTF
> > of native endianness (based on BTF magic), which causes the error
> > above on big-endian targets.
> >
> > Is this expected? Is DEBUG_INFO_BTF supported in general when
> > cross-compiling? How does one generate BTF encoded for the target
> > endianness with pahole?

Yes, it's expected, unfortunately. Right now cross-compiling to a
different endianness isn't supported. You can cross-compile only if
target endianness matches host endianness.

> >
> > Thanks for any feedback or suggestions,
> > Tony
>
> We have the same problem on s390, and I'm not aware of any solution at
> the moment. It would be great if we could figure out how to resolve
> this.

I'm working on extending BTF APIs in libbpf at the moment. Switching
endianness would be rather easy once all that is done. With these new
APIs it will be possible to switch pahole to use libbpf APIs to
produce BTF output and support arbitrary endianness as well. Right
now, I'd rather avoid implementing this in pahole, libbpf is a much
better place for this (and will require ongoing updates if/when we
introduce new types and fields to BTF).

Hope this plan works for you guys.

>
> Best regards,
> Ilya
>
