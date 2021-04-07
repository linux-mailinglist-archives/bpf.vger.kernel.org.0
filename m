Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7791C356D02
	for <lists+bpf@lfdr.de>; Wed,  7 Apr 2021 15:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbhDGNNh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Apr 2021 09:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232797AbhDGNNh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Apr 2021 09:13:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E2EE61242;
        Wed,  7 Apr 2021 13:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617801207;
        bh=ICPFzg58kKpJNMHwZgJBVHNTI7bhTkZtLs5jacpCd0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cMhrycHcNCIgDOzzoWCFpPErsVYtO3sQh5FT8VKwLNUHumUxd0jSYlnuVIc2E08gd
         sMGPsiEs3J+NtRfkCLO5XcuuDJm3JeoJ9UmcZjWswe80Jhk/Hta4kerWcwzEh0kqQT
         YIAJHkrvTgs7gIMqApfIdAsrAPSLwqbTke/MdY7DYAQb9hFTUMX2QM+dfQHR2fOhK0
         OCe1B03TaATg/nNL9ctH9hZb4EfdV/Hx00CuK7cDpekj7kcZ4Djx4/MqC3rmPSvohf
         2UzXDz9WiZKtyUNAHavi808Q9CZwpjiJxHbT/EW4okiR0zqUFb3NcNzFN0LHQMiQXp
         Fz1JZY8VP2CTQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8841A40647; Wed,  7 Apr 2021 10:13:24 -0300 (-03)
Date:   Wed, 7 Apr 2021 10:13:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf <bpf@vger.kernel.org>, kernel-team@fb.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH kbuild v4] kbuild: add an elfnote for whether vmlinux is
 built with lto
Message-ID: <YG2v9EY0WWp+bijr@kernel.org>
References: <20210401232723.3571287-1-yhs@fb.com>
 <CAKwvOdmX8d3XTzJFk5rN_PnOQYJ8bXMrh8DrhzqN=UBNdQiO3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmX8d3XTzJFk5rN_PnOQYJ8bXMrh8DrhzqN=UBNdQiO3g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Apr 02, 2021 at 11:07:10AM -0700, Nick Desaulniers escreveu:
> On Thu, Apr 1, 2021 at 4:27 PM Yonghong Song <yhs@fb.com> wrote:
> > Currently, clang LTO built vmlinux won't work with pahole.
> > LTO introduced cross-cu dwarf tag references and broke
> > current pahole model which handles one cu as a time.
> > The solution is to merge all cu's as one pahole cu as in [1].
> > We would like to do this merging only if cross-cu dwarf
> > references happens. The LTO build mode is a pretty good
> > indication for that.

> > In earlier version of this patch ([2]), clang flag
> > -grecord-gcc-switches is proposed to add to compilation flags
> > so pahole could detect "-flto" and then merging cu's.
> > This will increate the binary size of 1% without LTO though.

> > Arnaldo suggested to use a note to indicate the vmlinux
> > is built with LTO. Such a cheap way to get whether the vmlinux
> > is built with LTO or not helps pahole but is also useful
> > for tracing as LTO may inline/delete/demote global functions,
> > promote static functions, etc.

> > So this patch added an elfnote with a new type LINUX_ELFNOTE_LTO_INFO.
> > The owner of the note is "Linux".

> > With gcc 8.4.1 and clang trunk, without LTO, I got
> >   $ readelf -n vmlinux
> >   Displaying notes found in: .notes
> >     Owner                Data size        Description
> >   ...
> >     Linux                0x00000004       func
> >      description data: 00 00 00 00
> >   ...
> > With "readelf -x ".notes" vmlinux", I can verify the above "func"
> > with type code 0x101.
> >
> > With clang thin-LTO, I got the same as above except the following:
> >      description data: 01 00 00 00
> > which indicates the vmlinux is built with LTO.
> >
> >   [1] https://lore.kernel.org/bpf/20210325065316.3121287-1-yhs@fb.com/
> >   [2] https://lore.kernel.org/bpf/20210331001623.2778934-1-yhs@fb.com/
> >
> > Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> 
> LGTM thanks Yonghong!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks!

- Arnaldo
