Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150EB2078F9
	for <lists+bpf@lfdr.de>; Wed, 24 Jun 2020 18:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404885AbgFXQXL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jun 2020 12:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404723AbgFXQXL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jun 2020 12:23:11 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C001EC0613ED
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2020 09:23:11 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id s21so2313150oic.9
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2020 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3dDW1JKBhkhDXwU/i8u3/S0XHEs1yQQBBDrmoehDAVE=;
        b=qGSVVcS1dWMWOpmEwg8RmYFLKMaY9TvfytN4zW0OJnLbjW49I6K5twHHJdVf+UyrKe
         XRTUUxF0ddCNOKVxE2eLz5rhxoGccl2vMBItIjC8jQg/94AckSBvcuPO1Bo1avkzZBCH
         fUaQm1uQUnP+BZl8Uaj3Bmufb/SHqU33AVUzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dDW1JKBhkhDXwU/i8u3/S0XHEs1yQQBBDrmoehDAVE=;
        b=HCQt4VXyVkJJei0AvFxFjPNd4ZAf+8xIlpb44xsA4UuIhH3FtkoWf+ZjYUQStXfRow
         TiIA8K7sqWBfyKrcZL/+IQ6QiL/+NnozfGpwhqHX+OvJ211SWGvNpybmHW6mwpUp5qFp
         UTLBW0VdN4biR7IVWp45rpxCRxjNcdZogRKMyPzQYMKjREDIVG/ZBVhLC+vTmClX0oMd
         XImT3y7zfSabry2ROUnG8k4aoe9n2dUIfj8hmHzZrk1bd9wyAWAcnaNxYZoeV4Mqr5DO
         OSJ5dw7j3KBm7AGOzxetAZvDyAt5yiV3LS4rHgKhD1KprU9z0vrhkb8pJ8GN/VDxphBl
         dQCg==
X-Gm-Message-State: AOAM530tsO0grv6qakOuH33JFCJAwIbe29nS0nVFnplMCMtUhArqBSa5
        YwIfsbSiWuQM+u4ijC+pYs3n2UWYkLHZgD5JDyvkRg==
X-Google-Smtp-Source: ABdhPJxPrquYfsHLe+2acfIL+e6vWH2E1ClxXg6x+dcP5wITB6QZFh4MAcJuDh/BOMDhcwx0qJOyQEoT8bWriAsXFdI=
X-Received: by 2002:a05:6808:34f:: with SMTP id j15mr4927088oie.102.1593015791041;
 Wed, 24 Jun 2020 09:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-cinpz=U+8tjV-GMWuth71jrOYLQ05Q7_c34TCeMJxMg@mail.gmail.com>
 <20200624160659.GA20203@kernel.org>
In-Reply-To: <20200624160659.GA20203@kernel.org>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 24 Jun 2020 17:22:59 +0100
Message-ID: <CACAyw9-zLLDJ4vXo7jGS_XoYsiiv4c5NmUCjCnAf0eZBXU3dVA@mail.gmail.com>
Subject: Re: pahole generates invalid BTF for code compiled with recent clang
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 24 Jun 2020 at 17:07, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Wed, Jun 24, 2020 at 12:05:50PM +0100, Lorenz Bauer escreveu:
> > Hi,
> >
> > If pahole -J is used on an ELF that has BTF info from clang, it
> > produces an invalid
> > output. This is because pahole rewrites the .BTF section (which
> > includes a new string
> > table) but it doesn't touch .BTF.ext at all.
>
> > To demonstrate, on a recent check out of bpf-next:
> >     $ cp connect4_prog.o connect4_pahole.o
> >     $ pahole -J connect4_pahole.o
> >     $ llvm-objcopy-10 --dump-section .BTF=pahole-btf.bin
> > --dump-section .BTF.ext=pahole-btf-ext.bin connect4_pahole.o
> >     $ llvm-objcopy-10 --dump-section .BTF=btf.bin --dump-section
> > .BTF.ext=btf-ext.bin connect4_prog.o
> >     $ sha1sum *.bin
> >     1b5c7407dd9fd13f969931d32f6b864849e66a68  btf.bin
> >     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  btf-ext.bin
> >     2a60767a3a037de66a8d963110601769fa0f198e  pahole-btf.bin
> >     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  pahole-btf-ext.bin
> >
> > This problem crops up when compiling old kernels like 4.19 which have
> > an extra pahole
> > build step with clang-10.
>
>
> > I think a possible fix is to strip .BTF.ext if .BTF is rewritten.
>
> Agreed.
>
> Longer term pahole needs to generate the .BTF.ext from DWARF, but then,
> if clang is generating it already, why use pahole -J?

Beats me, but then sometimes you don't have control over the workflow, see
my v4.19 kernel example.

>
> Does clang do deduplication for multi-object binaries?
>
> Also its nice to see that the BTF generated ends up with the same
> sha1sum, cool :-)

Unfortunately it's the .BTF.ext section that has the same sha1, because
pahole doesn't touch it ;(

>
> > Best
> > Lorenz
> >
> > --
> > Lorenz Bauer  |  Systems Engineer
> > 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
> >
> > www.cloudflare.com
>
> --
>
> - Arnaldo



-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
