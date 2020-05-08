Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D571CBA0F
	for <lists+bpf@lfdr.de>; Fri,  8 May 2020 23:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgEHVrL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 May 2020 17:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgEHVrJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 May 2020 17:47:09 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658CBC061A0C
        for <bpf@vger.kernel.org>; Fri,  8 May 2020 14:47:08 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s9so2451068qkm.6
        for <bpf@vger.kernel.org>; Fri, 08 May 2020 14:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2EGUf4F67MUAGK/xlR8yypqJXlC3EPSjxXN+zsxp6yc=;
        b=dTVyRSdweQs+wOXQOc8dOTffJ9imDo2IJYAxnveRJLOg9LJ/34cYPGsgkfUx9j40UQ
         TjSZNVZoihWH04AVU8S7DLEQJI3fqSKDmB15wKEOzBvWwTonOYCqytDKcxQpFE3bkY+R
         14wJCUhivEpgaNil9YEh5twWr/sMByW3yX17ZGOblw4CRuN2V1qCmEauM14G9Peh0DcH
         nzm2rcBD5Og4Zn+GFmcS1lyJNJEi2iLxYSXmIWswfhcy5DJ7xt9UB0dsNcB5s+kCC0St
         /tqOdjkhJ3a1UOgPfbkcqtlXEm3bZcDWCHcN4bPIeaY1ZdvvdqrbpuDgtiBTrvH/qlfV
         6nUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2EGUf4F67MUAGK/xlR8yypqJXlC3EPSjxXN+zsxp6yc=;
        b=BQXcLH8PS9AzM0Qdh5sGEFwEZKCRz8UqVgUCkfzlNONdhYayCzCmgLHsKZzVVP6yB9
         IZDsOXCQQPHq7yxflKG3m/PV0TvdMkdYO1+0+pFb1x+LA8O3AOhcai79z6sczp99ybRg
         J056FZIfNbSOiZs2XFrnNevhwv0tAl+ipK7NXNzhrdKfOtzMud2BT4UFafVpoXkO31yL
         Y7PwRBYew0wpKKPKIZrI3UyVmh3NMnENRPikqRpVJxI3DGvKJ1ok43ni1BGiv48vPnjr
         YzO7HevCvl7HMBLxYAqf+YKCxmI1sP7rq5WO4xfvjSFpTiO3ZcZJoCJUrdA5yWfegLO8
         Z+Sg==
X-Gm-Message-State: AGi0PuZk1fKvh6v3w/w2ok2wDPBtOE2s0K2KOhJXnyAZCqx8D9zAnbZJ
        isd8/OLTEFUOuHAtt+AfqKbAxaxEw9Y8TE52rbg=
X-Google-Smtp-Source: APiQypLL5Cq1t/EYIoNQXAlXiSSZCqaQKYgj2W2M9kALjcq5fxu8r7Y3o2DWTHD/KxguGuvul1yhc9efK/0j2MLVjkk=
X-Received: by 2002:a37:68f:: with SMTP id 137mr5001917qkg.36.1588974427544;
 Fri, 08 May 2020 14:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200507145652.190823-1-yauheni.kaliuta@redhat.com> <20200507145652.190823-2-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200507145652.190823-2-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 May 2020 14:46:56 -0700
Message-ID: <CAEf4BzYPDKfJLSGVQucgRuDUyzwizQHAWyUWWGsq6ZvgRUO0yg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "libbpf: Fix readelf output parsing on powerpc
 with recent binutils"
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Justin Forbes <jmforbes@linuxtx.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Aurelien Jarno <aurelien@aurel32.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 7, 2020 at 7:57 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> The patch makes it fail on the output when the comment is printed
> after the symbol name (RHEL8 powerpc):
>
> 400: 000000000000c714   144 FUNC    GLOBAL DEFAULT    1 bpf_object__open_file@LIBBPF_0.0.4         [<localentry>: 8]
>
> But after commit aa915931ac3e ("libbpf: Fix readelf output parsing
> for Fedora") it is not needed anymore, the parsing should work in
> both cases.
>
> This reverts commit 3464afdf11f9a1e031e7858a05351ceca1792fea.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---

Looks good, though would be nice to have people originally involved in
those fixes you mentioned to confirm it works fine still. Added them
to cc.

If no one shouts loudly in next few days:

Acked-by: Andrii Nakryiko <andriin@fb.com>


>  tools/lib/bpf/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index aee7f1a83c77..908dac9eb562 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -149,7 +149,7 @@ TAGS_PROG := $(if $(shell which etags 2>/dev/null),etags,ctags)
>  GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
>                            cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' | \
>                            sed 's/\[.*\]//' | \
> -                          awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}' | \
> +                          awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$8}' | \
>                            sort -u | wc -l)
>  VERSIONED_SYM_COUNT = $(shell readelf -s --wide $(OUTPUT)libbpf.so | \
>                               grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
> @@ -216,7 +216,7 @@ check_abi: $(OUTPUT)libbpf.so
>                 readelf -s --wide $(BPF_IN_SHARED) |                     \
>                     cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' |   \
>                     sed 's/\[.*\]//' |                                   \
> -                   awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}'|  \
> +                   awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$8}'|   \
>                     sort -u > $(OUTPUT)libbpf_global_syms.tmp;           \
>                 readelf -s --wide $(OUTPUT)libbpf.so |                   \
>                     grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |             \
> --
> 2.26.2
>
