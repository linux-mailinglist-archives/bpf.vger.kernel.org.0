Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF37C324580
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 21:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbhBXU5g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 15:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhBXU5a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 15:57:30 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A65C061574
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 12:56:49 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id d9so3246028ybq.1
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 12:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZZ0NxlItm2peEp9ecdVW9gW1OodgQ5qKI7odWM+aag=;
        b=K8SLgyAOCez/Wu87Ok9Q4cswyHDwlP9c8cCy7jc5ztQXHngs2lXBOnSW84Ql3rXvIV
         9J0amjzqVsl9W3qvLJ5hpujQ4JgB/DWs5fJqHS7p6ZYIyAFFawhsA6NzOG4HUKndqrYM
         ReaS81Vow7izNToWBpH2VT9FJ7Fr5fVKgws0lGsu2/ki8ikBnXZV6b8q8ndwOu58L6Hg
         aD8rPpMpWtJCTdIpXalgRBWUxUfT53WW3+SW5riQ7vd4eYiK1j+dvMlubxLch6p89Z7S
         P9fUnO7EBWRm/wKRBH5k+zGFvU5JzJnZah/SQWc4SqO78lwkSOGqVvAJ5844NezbskUG
         k6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZZ0NxlItm2peEp9ecdVW9gW1OodgQ5qKI7odWM+aag=;
        b=cAQ5YVO3sPAHlJnVeKanDy6ZoaMQvgleXDBCTStW17EPPLFscCqsaDdxjUFBpTYhOz
         nL/+am3MqqKJRUIQ1dJaq5QaXGi2mWSvGW9XZx8XdZcbORkuCH9e9rbcJCiyEYkOUhLt
         24ol2yJqPOqCMWwgkiAptjPTXEbZ/ejq7d4zdkRdy20KHC8SkocVzHbfg8diDTaoDRU/
         wtWnL6t6KGk/s0YcrH6F+s2ElBQUgCLeHl7sKxedxm+Pil/K9r7U0Av4x/dH1ME2fgNO
         X8kNnMeYMaYQhrEd84JN6QONkQiYHb27FxiBk4QAsoSITSA2lI4SiCBoruLTHorBUrKS
         HUWQ==
X-Gm-Message-State: AOAM530wXqu5tZzAKPD/HPmQ6/btur3+wo24S0DCCNg/sXWy9eEN+O3e
        21kftpNuYthcZiXL2cYptZ9TZ/ICkbwZHS+fY6Y=
X-Google-Smtp-Source: ABdhPJwqDNmzkTDfBeRbBvFUcrvp/OqJMYDcxqZBTuCPo/Cr4un0eq27+WhsqlvEPeazfLHDtcizUlvYLLR1AY16cEM=
X-Received: by 2002:a25:abb2:: with SMTP id v47mr49658391ybi.425.1614200209147;
 Wed, 24 Feb 2021 12:56:49 -0800 (PST)
MIME-Version: 1.0
References: <20210223231459.99664-1-iii@linux.ibm.com> <20210223231459.99664-3-iii@linux.ibm.com>
In-Reply-To: <20210223231459.99664-3-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Feb 2021 12:56:38 -0800
Message-ID: <CAEf4BzZdD7gh4ehmH3k-Q_Dt-KtCfX5Xe5PUA93xpo3bS=NTiA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/8] libbpf: Add BTF_KIND_FLOAT support
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

On Tue, Feb 23, 2021 at 3:15 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> The logic follows that of BTF_KIND_INT most of the time. Sanitization
> replaces BTF_KIND_FLOATs with equally-sized empty BTF_KIND_STRUCTs on
> older kernels, for example, the following:
>
>     [4] FLOAT 'float' size=4
>
> becomes the following:
>
>     [4] STRUCT '(anon)' size=4 vlen=0
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/btf.c             | 51 ++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/btf.h             |  6 ++++
>  tools/lib/bpf/btf_dump.c        |  4 +++
>  tools/lib/bpf/libbpf.c          | 26 ++++++++++++++++-
>  tools/lib/bpf/libbpf.map        |  5 ++++
>  tools/lib/bpf/libbpf_internal.h |  2 ++
>  6 files changed, 92 insertions(+), 2 deletions(-)
>

[...]

>  /* it's completely legal to append BTF types with type IDs pointing forward to
>   * types that haven't been appended yet, so we only make sure that id looks
>   * sane, we can't guarantee that ID will always be valid
> @@ -1910,7 +1955,7 @@ static int btf_add_composite(struct btf *btf, int kind, const char *name, __u32
>   *   - *byte_sz* - size of the struct, in bytes;
>   *
>   * Struct initially has no fields in it. Fields can be added by
> - * btf__add_field() right after btf__add_struct() succeeds.
> + * btf__add_field() right after btf__add_struct() succeeds.

Was there some whitespacing problem on this line?

>   *
>   * Returns:
>   *   - >0, type ID of newly added BTF type;

[...]
