Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE565322631
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 08:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhBWHMA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 02:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhBWHL5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 02:11:57 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02548C061574
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 23:11:16 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id m188so15449533yba.13
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 23:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QPogSEJLGckkQLknsa1qWE5YCxmceuiPq+QcNoxb9cg=;
        b=lZzKU3ioC4/PqJVZaTLoCWRUesN8nsnq75Pzm5LN8KIxltdLNIWV+qKNaKlNAleUwL
         2upbgWOawnBrxy6wfP+Fr5aB1qfBzvvw6vTvz/l/UPhDC6IbyohqYWOYeNvUFLOgAEIC
         fy2PnyOIl0CunkWiAYOTQJ7/jj4fx4nxBBq2uCEnZ7ZTneqfTRGAW9XE6CQ1rFOk/dkJ
         TOL62zQkdSs2AZkXsr5CeWNUoaFyhteR9hlrQgM2cNXz5lVLeaywfEBqIHWx8wJqzICA
         C7Ffd5pX44vBbgQxEHntxuc0v0JcZyCgj1eceSb3mucT9XhbDVjFUyXk4Wpwkeg1EZje
         HYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QPogSEJLGckkQLknsa1qWE5YCxmceuiPq+QcNoxb9cg=;
        b=mZTlDFEqu/fDmZs6Yu0ub3iiEtaR21jT4QDe6Y0cxyXLINWigM85BIlafQ6Vg3RkXw
         /NyLrFctUM8rjTEHRhGg6WBXyxX7SXVlM7ugqTiGr3zU0Ib5MszNJ2KUobhOJExdQlsj
         yn0FVqci/JAnefjaolgGxNeYqMUgnocCPsKrjiDoIl+X7iRYzdwUD3961v8u2WXmV+Br
         Wb+gPS6R8xcEwQ1M+G348CKZ5IT8hYsD0ryloYe5CmXBVQzZ4MscM9kBiwjMU2tsPFtO
         lkJpWBvKnQNu096KYnOdMIJu4iZYKzRJGrd4wK0Qy8uEkqBPaalpqhPgnCeX3Zun+Oy/
         NbJA==
X-Gm-Message-State: AOAM532Uh9Ew4RqrUFsAoSuHbTwGmTL2ass+ZKM/YMlKrOmig7fmckXA
        U1Mhl7shp/bLm/ut15LOSFxGCY5fDfY8CtJrNPE=
X-Google-Smtp-Source: ABdhPJx6Z1Feo7I9WixALjanpdFRVlSpJHxZIl01D68DtdMn8UiYbtv0Tg0bIqcNdS4xZ5zh4Um3/F27/Wo7MNRah9Y=
X-Received: by 2002:a25:3d46:: with SMTP id k67mr6725963yba.510.1614064276224;
 Mon, 22 Feb 2021 23:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20210222214917.83629-1-iii@linux.ibm.com> <20210222214917.83629-7-iii@linux.ibm.com>
In-Reply-To: <20210222214917.83629-7-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Feb 2021 23:11:05 -0800
Message-ID: <CAEf4BzY+f77raXGrJN3Nz2To2EC0Td9zwaO2bYKS+W-ZftY9-Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 6/7] selftest/bpf: Add BTF_KIND_FLOAT tests
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 22, 2021 at 1:52 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Test the good variants as well as the potential malformed ones.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---

Would be nice to have BTF dumping and dedup tests added/adjusted as well.

>  tools/testing/selftests/bpf/btf_helpers.c    |   4 +
>  tools/testing/selftests/bpf/prog_tests/btf.c | 129 +++++++++++++++++++
>  tools/testing/selftests/bpf/test_btf.h       |   3 +
>  3 files changed, 136 insertions(+)
>

[...]
