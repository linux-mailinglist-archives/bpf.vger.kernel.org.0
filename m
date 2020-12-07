Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED362D175D
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 18:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgLGRRw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 12:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgLGRRv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 12:17:51 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151BAC061749
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 09:17:11 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id e7so5563232ljg.10
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 09:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CEeZ2nmwSpyuPT6kc3jLgcOFT3oyPRfJO0jz7F9f9kg=;
        b=HB4V+kYfgV3pvqslRz8AVGRH7QWGP8KktexZ6gcHM6DI2YVdZy4kKM/bEKtIUJdTRD
         vik1wl9mBy7hfd8QSfze/YQm04Ite26vlAmYFEqNJ/yP9ydhQ6nhncDes9D64eW8z4hp
         hA5nX8AixoXE1I88114eMknZ0jStKCULTuzYKDCBROB+obDdAemDcIdnvGyLIFPwkcOn
         GV6VG6Q9mDh9NBr8D1IQZmqWCKxAmPqk5TZh//JLdKioBHZFMb27gIFa+YJibDJXuWCr
         sJRd8/MTXhS1ddD4ALIZXbnqC7+gGNwg1XIujaSXxbZGpfheRf+56s3iO3t+6MrXJ3k8
         S3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CEeZ2nmwSpyuPT6kc3jLgcOFT3oyPRfJO0jz7F9f9kg=;
        b=LXn8FqvX22YCWnv19E0roQnwKdYF29zy/sOIQMosOzGakcCmvBUo/ySF1zP3hJBWR9
         PAW5hchP3fA50pe20xDT+J/Dv6HecfQFCSq6c+ZBinSfUB7BFP3X4ezn4q2o7O5WvR6m
         86BJodm2srGIzMjG5NNJUNzwW1Se+OqYq6soQN5EDBrYP8yuQlnpnKRJ9VzMpWWB5xAs
         lEEEr2aFH/8vno1AXcK+q0n9uOeT6RB/9LvnEgx809F2Mm3Yo3pnUce3aJ9+vh2GHToC
         8jyubH3GxSxFvGga271zdoTj9JvOEOvE/CRw92k0HWH2SSDg7Rf1A56E4L9QhqWl7OuP
         sP8Q==
X-Gm-Message-State: AOAM532RA5IGh+MescuFAdf7UyC1s7vDbbLY+xvuW5yMJ/vkHlLgENkP
        q0XodT6EBzxxek3LTEAMVaBYRCWzBbLAs+svFTE=
X-Google-Smtp-Source: ABdhPJzkhNeQVjnwnRdfJBlHKVgajySIgQkToA241XKhTPJeF2JpizEXTzb2zs8N/74uhu1ePzlkipaSF6BViA9Z34M=
X-Received: by 2002:a2e:9681:: with SMTP id q1mr9142628lji.2.1607361429613;
 Mon, 07 Dec 2020 09:17:09 -0800 (PST)
MIME-Version: 1.0
References: <87lfeebwpu.fsf@toke.dk> <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com>
 <87r1o59aoc.fsf@toke.dk> <6801fcdb-932e-c185-22db-89987099b553@fb.com>
 <CAEf4BzZRu=sxEx7c8KGxSV1C6Aitrk01bSfabv5Bz+XUAMU6rg@mail.gmail.com>
 <875z5d7ufl.fsf@toke.dk> <CAADnVQ+qibC_8cDwaqOoAnL7CwXv85EjQ96Zcdtrm+86cgZq1g@mail.gmail.com>
 <878sa9619d.fsf@toke.dk> <CAADnVQKYaeF2KCC5SLBg3feUY_DBh-eq2_O=T10_+13z3wNm1Q@mail.gmail.com>
 <874kkx5zl5.fsf@toke.dk>
In-Reply-To: <874kkx5zl5.fsf@toke.dk>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 7 Dec 2020 09:16:57 -0800
Message-ID: <CAADnVQLGY26QfiZm8WvoeNJmBYOgVz_h-SjHLgoYqw=P4M4fLg@mail.gmail.com>
Subject: Re: Latest libbpf fails to load programs compiled with old LLVM
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 7, 2020 at 8:51 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Mon, Dec 7, 2020 at 8:15 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
> >>
> >> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> >>
> >> > On Mon, Dec 7, 2020 at 3:03 AM Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@redhat.com> wrote:
> >> >>
> >> >> Wait, what? This is a regression that *breaks people's programs* on
> >> >> compiler versions that are still very much in the wild! I mean, fin=
e if
> >> >> you don't want to support new features on such files, but then sure=
ly we
> >> >> can at least revert back to the old behaviour?
> >> >
> >> > Those folks that care about compiling with old llvm would have to st=
ick
> >> > to whatever loader they have instead of using libbpf.
> >> > It's not a backward compatibility breakage.
> >>
> >> What? It's a change in libbpf that breaks loading of existing BPF obje=
ct
> >> files that were working (with libbpf) before. If that's not a backward
> >> compatibility break then that term has lost all meaning.
> >
> > The user space library is not a kernel.
> > The library will change its interface. It will remove functions, featur=
es, etc.
> > That's what .map is for.
>
> Right, OK, so how do I use .map to get the old behaviour here? That's
> all I'm asking for, really...

Fix old llvm. The users would have to upgrade either from llvm 7.x to
7.x+1 or to llvm 10+.
