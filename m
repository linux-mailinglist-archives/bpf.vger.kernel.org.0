Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720EE4276CE
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 05:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhJIDKG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 23:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhJIDKG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 23:10:06 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3969FC061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 20:08:10 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id s64so25033310yba.11
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 20:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6wZhJtq4h3ns7cM0dw5TH3anEFmthEaRdO7w8qmJkps=;
        b=hM38Q25B+A0Aq5EZxgBcpj/q+Wm2iyvkt274wB1cUvHGhOk9y/GNloNFl+cm0vSseY
         /lytMQD3pI+nGgG+fiz872htBFq+mOL1oPB/y1WGDsXs84NWqf0TdyNAY14limJHHoEL
         EG/2Lv76n/FJggOIKVe6rY3mdvn6GKGuhmN7Uut9EkVGHucKm+zWiVkQqIaI4Iv7CqTM
         ZG3+Zy7VK5fl6JPpOxl7QsZnL3tfuF9y4sNCDNUV/usP9W0+/eqiTLvLyVo0qppoimyL
         8AaQ+RJDK/Rj/jBMXKeAV/xlogTzxgzAJIGpxIle1D0iB2X1j+WGnS3cGf7ANcrnw+31
         GQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6wZhJtq4h3ns7cM0dw5TH3anEFmthEaRdO7w8qmJkps=;
        b=EDVed46p1SXsZpVQh2h/TGmRVPkwRUEe+M8OK48anzA3Si3ieo7vFdGnezENrcjhem
         u/gL9WKCROyuC9C8BqoUBUL6Vvx9LcfGZblz2RkTuxyLgf1ZBLPagqplVB5YVnCM7zxS
         /aJOIR7Cnr8kvJFHix7rTNPYo1jLKXnXeQY0bye0XootsM/sTjI5Fno8MnMOA5ltw+30
         tj5XO4Y+w5RXcVg9NtRyT3TUB+jZROGfLfKqDwgrRoz8bVRJ7K+mYgaHcgkfxx5JoQy7
         cDGuKDrZWU2vj9nE4wqpv9OjxygYbzeY+EgR8KlXhmxME5Mh3LgaCx+zpkdP/SjBsacR
         v+sw==
X-Gm-Message-State: AOAM5331TS9GU78C7ukcdNBhvGGKQkzeBOf3taBTOz7EyCsoOq0iJTJx
        Vc7oQe0v+RC+roGrh21Q1dILqCbtp3SwYze3NAQ=
X-Google-Smtp-Source: ABdhPJys1ylQmc4Tt0jLrp8gDhY8VTct0tl7q/pM+87Ob+WFyNDGaIiF3mZaDRsllB2HJNuwg26cMccqfH6RiSbSf4I=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr7543007ybj.504.1633748889420;
 Fri, 08 Oct 2021 20:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211007173329.381754-1-iii@linux.ibm.com> <CAPhsuW51tYCC99NVVF3iWarE9qza-sAv1wP456Ooy_bvw8+JMA@mail.gmail.com>
In-Reply-To: <CAPhsuW51tYCC99NVVF3iWarE9qza-sAv1wP456Ooy_bvw8+JMA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 20:07:56 -0700
Message-ID: <CAEf4BzYMNAqyZyXR+RJWhC0DTh8gae7E8WKYPX19dqPF+eoUkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, selftests: Skip verifier tests that fail to
 load with ENOTSUPP
To:     Song Liu <song@kernel.org>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 7, 2021 at 3:28 PM Song Liu <song@kernel.org> wrote:
>
> On Thu, Oct 7, 2021 at 12:44 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > The verifier tests added in commit c48e51c8b07a ("bpf: selftests: Add
> > selftests for module kfunc support") fail on s390, since the JIT does
> > not support calling kernel functions. This is most likely an issue for
> > all the other non-Intel arches, as well as on Intel with
> > !CONFIG_DEBUG_INFO_BTF or !CONFIG_BPF_JIT.
> >
> > Trying to check for messages from all the possible add_kfunc_call()
> > failure cases in test_verifier looks pointless, so do a much simpler
> > thing instead: just like it's already done in do_prog_test_run(), skip
> > the tests that fail to load with ENOTSUPP.
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>
> Acked-by: Song Liu <songliubraving@fb.com>

Applied to bpf-next, thanks.
