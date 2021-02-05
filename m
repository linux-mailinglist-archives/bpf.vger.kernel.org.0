Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC6D31134B
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 22:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhBEVRt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 16:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbhBEVRo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 16:17:44 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091A9C06178B;
        Fri,  5 Feb 2021 13:17:02 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id o7so2602437ils.2;
        Fri, 05 Feb 2021 13:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=FGxzpwAkVg/sa9z4AuL5zfsiJ+ugd+iDv20cqXWFQPE=;
        b=HU/gpDurYLVCXKXtvrInofxgEEkUtVh9jpiE56NojazaFQc6YmX8haY9wUK7ppdqTl
         4g3DI+EWmN3bMEdyhUKcsI1sD/s59SE4T0ZQnekUZzUkmziBIDRG3jRPRhUvRJ/Ps+n8
         UkpjAcC++y/HSJCocNitRhNDAkJK3PECoitWcvGHBN2ndEnTpNfP3pYP6Poes2hEtM3s
         lgSWad4F1mJtnW7gQ5Ip5mGHQ50OH8aubSKELJNiGfJLR/iBebo6eiyviFgcitTrj0Rl
         +Hc+/ElnjtClXPTJdNgxNK5fqknOIp1rY1GqWqVoMH/mHwSTZeR8Nnjro80wDQsLIT0X
         FE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=FGxzpwAkVg/sa9z4AuL5zfsiJ+ugd+iDv20cqXWFQPE=;
        b=aNcW0w8soVl4UE1Ho9WymavxoozCXCvSsaZ/kp6wRZI0c1meQpGf20dD47XPVq5uSC
         7viXYoI42VIln7Ohz4nreUHSlFW+svrtdyKOc0oQvKFHLW0PN72qqdWrTTXPu09OOftH
         n3reZPwFA9MADFM3ADyvKjokfRm0rpeCQOjL9f7EHPkLN0/B6RAu4rM7CO4qPaTRqLn5
         vDGemUmgqyuJw5sVJFzW0AZh+HPCDhxl1U3zSx9Ey7MSi0egna8wus2qnTEsUFJJb9F+
         hD8bgVq8Uyf0x7iYc5CXUkk3JkI5Vqj134ORYsnfSaoy5FEwJhdLtmgnD+Q8apRTPxrT
         7Tfw==
X-Gm-Message-State: AOAM533ZPB4Ps1aagywvMe8/IQtzeKJ3K5Eq2YkYVft/xDt9Z4HzHcIc
        cMc2WQgV+E7zmuTA9wT5lmJdxD0CBhNqR7JNSU8=
X-Google-Smtp-Source: ABdhPJy/f/k0zeyTyn8eB8bR3iADA1E/CXe+UK28BO9+H0JwIsYQI082vDMqTDdYTT7/RNy5xRTjRMEztZkr6WslCXE=
X-Received: by 2002:a92:ce46:: with SMTP id a6mr5873923ilr.10.1612559821523;
 Fri, 05 Feb 2021 13:17:01 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <20210205211010.2764627-1-ndesaulniers@google.com>
In-Reply-To: <20210205211010.2764627-1-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 5 Feb 2021 22:16:50 +0100
Message-ID: <CA+icZUXkCC9U3PsYzqhzu7BZa-eE2kd53SfX2ODrr+N=QO6VvQ@mail.gmail.com>
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     andriin@fb.com, arnaldo.melo@gmail.com, berrange@redhat.com,
        bpf@vger.kernel.org, cavok@debian.org, dwarves@vger.kernel.org,
        jengelh@inai.de, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        mjw@redhat.com, omosnace@redhat.com, paul@paul-moore.com,
        tstellar@redhat.com, yhs@fb.com, zzam@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 5, 2021 at 10:10 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> > Hi,
> >
> > when building with pahole v1.20 and binutils v2.35.2 plus Clang
> > v12.0.0-rc1 and DWARF-v5 I see:
> > ...
> > + info BTF .btf.vmlinux.bin.o
> > + [  != silent_ ]
> > + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
> >  BTF     .btf.vmlinux.bin.o
> > + LLVM_OBJCOPY=/opt/binutils/bin/objcopy /opt/pahole/bin/pahole -J
> > .tmp_vmlinux.btf
> > [115] INT DW_ATE_unsigned_1 Error emitting BTF type
> > Encountered error while encoding BTF.
>
> Yes, I observe this error, too.
>
> https://gist.github.com/nickdesaulniers/ae8c9efbe4da69b1cf0dce138c1d2781
>
> via v9 of my DWARF v5 series, which should help make this easier to
> reproduce:
> https://lore.kernel.org/lkml/CA+icZUW3sg_PkbmKSFMs6EqwQV7=hvKuAgZSsbg=Qr6gTs7RbQ@mail.gmail.com/T/#m45ec7e6df4c4b5e9da034b95d7dfc8e2a0c81dac

Thanks Nick for confirming the error.

Ah, I see you passed:

make LLVM=1 LLVM_IAS=1 ...

Can you by chance try with KCFLAGS="-fbinutils-version=2.35"?

- Sedat -
