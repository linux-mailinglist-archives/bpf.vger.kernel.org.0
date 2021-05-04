Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810813730FA
	for <lists+bpf@lfdr.de>; Tue,  4 May 2021 21:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhEDTqT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 15:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232535AbhEDTqT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 May 2021 15:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620157523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tfzPIb13S4HHhK8UG3dOlIDhClIn947SERNDpuf2glM=;
        b=dtefJkJpebsHqb+AdsAOEifAWizXldJHKeLtbIm+qWzEZaIVXaRfHixg5rRzJhKE3QiWaz
        aqRgroN3sY3uGzWejmwqCZeUEEguRmTgpwGFm+IrgW25CUwgmFGsdqv74xEsGwo//Uqhj5
        3xR2GQIPaSnm0XQewdia6aJ+e+r7Fmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-95LXqmt8NnO-MJdM86Agog-1; Tue, 04 May 2021 15:45:21 -0400
X-MC-Unique: 95LXqmt8NnO-MJdM86Agog-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5D53801B13;
        Tue,  4 May 2021 19:45:19 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-112-137.ams2.redhat.com [10.36.112.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1088E5C1B4;
        Tue,  4 May 2021 19:45:15 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Zack Weinberg <zackw@panix.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>,
        Joseph Myers <joseph@codesourcery.com>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [RFC v2] bpf.2: Use standard types and attributes
References: <20210423230609.13519-1-alx.manpages@gmail.com>
        <20210504110519.16097-1-alx.manpages@gmail.com>
        <CAADnVQLdW=jH1CUP02jokEu3Sh+=xKsCXvjA19kfz7KOn9mzkA@mail.gmail.com>
        <YJFZHW2afbAMVOmE@kroah.com>
        <69fb22e0-84bd-47fb-35b5-537a7d39c692@gmail.com>
        <YJFxArfp8wN3ILJb@kroah.com>
        <CAKCAbMg_eRCsD-HYmryL8XEuZcaM1Qdfp4XD85QKT6To+h3QcQ@mail.gmail.com>
        <6740a229-842e-b368-86eb-defc786b3658@gmail.com>
Date:   Tue, 04 May 2021 21:45:31 +0200
In-Reply-To: <6740a229-842e-b368-86eb-defc786b3658@gmail.com> (Alejandro
        Colomar's message of "Tue, 4 May 2021 20:54:07 +0200")
Message-ID: <87r1imgu5g.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

* Alejandro Colomar:

> The thing is, in all of those threads, the only reasons to avoid
> <stdint.h> types in the kernel (at least, the only explicitly
> mentioned ones) are (a bit simplified, but this is the general idea of
> those threads):
>
> * Possibly breaking something in such a big automated change.
> * Namespace collision with userspace (the C standard allows defining
>   uint32_t for nefarious purposes as long as you don't include
>  <stdint.h>.   POSIX prohibits that, though)
> * Uglier

__u64 can't be formatted with %llu on all architectures.  That's not
true for uint64_t, where you have to use %lu on some architectures to
avoid compiler warnings (and technically undefined behavior).  There are
preprocessor macros to get the expected format specifiers, but they are
clunky.  I don't know if the problem applies to uint32_t.  It does
happen with size_t and ptrdiff_t on 32-bit targets (both vary between
int and long).

Thanks,
Florian

