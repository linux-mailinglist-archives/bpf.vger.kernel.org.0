Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C506E4473DE
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 17:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbhKGQnB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Nov 2021 11:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbhKGQnB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Nov 2021 11:43:01 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0126BC061570
        for <bpf@vger.kernel.org>; Sun,  7 Nov 2021 08:40:17 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id v138so37188807ybb.8
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 08:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VvbhK33IJJ7iQanMtv37jEro30KYtH8QWhC62S9aHC8=;
        b=UaYdZp/AbDjS9PDC+XrT7ltCRjEyCI+QVIHBHUcnIsPf9gP/pvRSnk0iMw6ZvSJ3Dv
         TUMcgcc9++VO0OgZOVBtOs8g/6tUKMTLB6cV3PNJevL0w8Il4T4PxG+vviUhmUfXIU60
         +xaA3ZjEwr+2A3MH3KtEPFFOzf+wUw4B1Xfv4w0/M6vWQcM8eZ54H4wIFu8J+57RO3LS
         QbFKMuo28GKA9+792GP1bT9pDsA+Uw86jgP2yN+D2JBfDyApddf4AI7pLZQqbCqMWjqU
         b2h1/VoyY2fsHiHSOU+etFM1Q4gt3DK39r4j8IcLcRlxC2KYffFR7VmVwKOMpbQbHLq9
         S9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VvbhK33IJJ7iQanMtv37jEro30KYtH8QWhC62S9aHC8=;
        b=PAFzLDP975h8qvzpya6bX29bpHAVYdMJxcCMTIHm53H7+2QOnDRkD0K9A1SXAsNUG3
         OeKG0G1ucAw/zJebEGsZDmcgZmBS4StyFswyaSbeRZeE53rldN241mO5rSyrC+z/G/XN
         fp5Lr4dmx5HY3QTWqSiWwJiyYsSJMw83NYfcu9UfwhTVTZw+AfDeJatIcjRqntM6HcFR
         ogTDUpbxVWkOBWwpHK8wTC1Gz1n3cn7Uwft8crgNIeSdBTq9zcJrIRy0ODGq2VkW1NIi
         JFjEcuN3s1hYundZTXCBnrfRGVaFu1Vf412OCrMe5ayyQg9jT+MxU0aMb9X/DPSL7TG+
         bK9w==
X-Gm-Message-State: AOAM530CJNRve5DL3rixwfzBJRmgfEXIw3C9hZR4Ncdhxob+D+wdtJLo
        tAf44AFx18Rhw08LQ7JKSCh6HY2l0EP7uJDLx30=
X-Google-Smtp-Source: ABdhPJz7qVm1oOSqP7TgZe3VUYDAkg+tQED/KvXAg6vj3Ap5g64GtrGvwASz0bE8wLov7xiA1lgqtL9E8cd2fWb3xPw=
X-Received: by 2002:a25:cec1:: with SMTP id x184mr71669636ybe.455.1636303217101;
 Sun, 07 Nov 2021 08:40:17 -0800 (PST)
MIME-Version: 1.0
References: <20211107040343.583332-1-andrii@kernel.org> <20211107040343.583332-5-andrii@kernel.org>
 <604aa1cc-53fe-631b-42fc-8ff76a2e3010@gmail.com>
In-Reply-To: <604aa1cc-53fe-631b-42fc-8ff76a2e3010@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 7 Nov 2021 08:40:06 -0800
Message-ID: <CAEf4Bzb-U79P4ub90H3YT1jg5-hv5Sn9=LChDbjVQjswnQNtKA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/9] selftests/bpf: free per-cpu values array
 in bpf_iter selftest
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 7, 2021 at 8:34 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Hi, Andrii
>
> On 2021/11/7 12:03 PM, Andrii Nakryiko wrote:
> > Array holding per-cpu values wasn't freed. Fix that.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > index 9454331aaf85..71c724a3f988 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > @@ -770,6 +770,7 @@ static void test_bpf_percpu_hash_map(void)
> >       bpf_link__destroy(link);
> >  out:
> >       bpf_iter_bpf_percpu_hash_map__destroy(skel);
> > +     free(val);
> >  }
> >
> >  static void test_bpf_array_map(void)
> >
>
> The val is allocated at the very beginning of this function,
> when bpf_iter_bpf_percpu_hash_map__open failed, the val still
> leaked.
>
> So we should have:
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 9454331aaf85..ee6727389ef6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -686,7 +686,7 @@ static void test_bpf_percpu_hash_map(void)
>  {
>         __u32 expected_key_a = 0, expected_key_b = 0;
>         DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> -       struct bpf_iter_bpf_percpu_hash_map *skel;
> +       struct bpf_iter_bpf_percpu_hash_map *skel = NULL;
>         int err, i, j, len, map_fd, iter_fd;
>         union bpf_iter_link_info linfo;
>         __u32 expected_val = 0;
> @@ -704,7 +704,7 @@ static void test_bpf_percpu_hash_map(void)
>         skel = bpf_iter_bpf_percpu_hash_map__open();
>         if (CHECK(!skel, "bpf_iter_bpf_percpu_hash_map__open",
>                   "skeleton open failed\n"))
> -               return;
> +               goto out;
>

I've just moved val = malloc() here and left early return intact. Same
effect, less undoing to do.

>         skel->rodata->num_cpus = bpf_num_possible_cpus();
>
> @@ -770,6 +770,7 @@ static void test_bpf_percpu_hash_map(void)
>         bpf_link__destroy(link);
>  out:
>         bpf_iter_bpf_percpu_hash_map__destroy(skel);
> +       free(val);
>  }
>
>  static void test_bpf_array_map(void)
>
> Right?

Right, thanks for spotting!

>
> Cheers,
> --
> Hengqi
