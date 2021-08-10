Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2C83E7D56
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 18:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhHJQTu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 12:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhHJQTt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Aug 2021 12:19:49 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B2EC0613C1
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 09:19:27 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id w17so37119178ybl.11
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DTAshqWohnpHiP/QTpw352MTDZGiGY9mk3gv6p4K7Y4=;
        b=b2ohOF/mTEg4GAbExY14uF8Fw04VmQ/0oqpUy9hkdBXfKGZDIY8DTsdk5YCtYQreky
         FB45O63lzrIdZHjMINiXDgjpc3CcCuEEI9YElYCj1CyCzI6NO2SJavA3n+gdOv3Ws0bZ
         pkAtq3+N3xyCvKb7C7+9vxOvUs2OA79u6vt7llt5vHOzO8hAo0HflZQz8EJ5m7D4kP5b
         /Icrd8bTs++pJLA3qzi7u9g0uTZPhNFqtEfN82Pc3TPSMya3ntwNfqsg/nTGQsuC2o9N
         JULQjiDso9uAzREeYfYTmJDX2GxvLf5iaD077JvC586CL8w5elNb6GBqn7e1S67NTHHh
         j22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTAshqWohnpHiP/QTpw352MTDZGiGY9mk3gv6p4K7Y4=;
        b=hJk8LiHq03pJoklLKj1dUhfGtc14hkU3IKYcY3kRSVg/Z3sW59UaA1bNN19wt6iglD
         qAChL5gaj0slFvOpUyklPCt0tYNQEIIzSkQh5+EuqUy4intezKkdXwGVfGQ8GYJKl2pq
         V4U7u/3ZMI56JcXfv2OTeuC+o426xjafWbFCu4zP7gCtJoXkCwwbXSIRem04zHfHgtdB
         7uMN8HhDakQFZ2b8qryXKxviGiG6yGrr7C/Z303mOwD4uWLoCSnTGhCgBLXrVoOdqeCn
         M89wB1qxEgDRBUshpoC13ovK/NkAWqR68vPtJ8QSab3h2WlVC/+3smAIdnXdsNW+USWW
         cKlw==
X-Gm-Message-State: AOAM5301ULaWgFTQtL77yuTKDAc8ByqIsH4xXv879t4hQ8pFb/1VcyLZ
        SIOV7xQV4fkOzodzddq6Jw0/AoqbyqAIfl9lxHc=
X-Google-Smtp-Source: ABdhPJzWRimijTCoAxNi43hBLBogqOZEmk47iTwKC4BQXWtkOD8eksdmZ+VavdQSPEdFQCzugHquy+/3I1HQStPArXs=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr41015118ybg.347.1628612366473;
 Tue, 10 Aug 2021 09:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210810001625.1140255-1-fallentree@fb.com> <20210810001625.1140255-3-fallentree@fb.com>
In-Reply-To: <20210810001625.1140255-3-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Aug 2021 09:19:15 -0700
Message-ID: <CAEf4BzaO-jZ3=T4rZb9gojrL2hUfBg=jqgrSQLZLOqR0M3WZtQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/5] Add glob matching for test selector in test_progs.
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        sunyucong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 9, 2021 at 5:17 PM Yucong Sun <fallentree@fb.com> wrote:
>
> This patch adds glob matching to test selector, it accepts
> simple glob pattern "*", "?", "[]" to match the test names to run.

do we really need ? and []? I've been pretty happy so far in retsnoop
with supporting just these patterns:

1. exact match ('abc')
2. prefix match ('abc*')
3. suffix match ('*abc')
4. substring match ('*abc*')

See [0] for a naive but simple implementation for that logic. So far
with test_progs I've only needed two cases from the above: exact and
substring matches. So I'm leaning towards keeping it simple, actually.

But there is also an issue of backwards compatibility. People using
`test_progs -t substr` are used to substring matching logic, so with
this change you are breaking this, which will cause frustration, most
probably. So maybe let's add a new parameter to specify these globs.
E.g., maybe `-a <glob>` for whitelisting (allowlisting), and `-d
<glob>` for blacklisting (denylisting)? Also, instead of parsing
comma-separated lists as I did initially with -t, we should probably
just allow multiple occurences of -a and -d:

./test_progs -a '*core*' -a '*linux' -d 'core_autosize'

will allow all CO-RE tests except autosize one, plus will admit
vmlinux selftest.

Also, keep in mind that there are subtests within some tests, and
those should be matches with the same logic as well:

./test_progs -a 'core_reloc/size*'

should run:

#32/58 size:OK
#32/59 size___diff_sz:OK
#32/60 size___err_ambiguous:OK


It gets a bit trickier with globs for both test and subtest, e.g.
'*core*/size*' -- should it match just core_reloc/size* tests as
above? Or also core_retro, core_extern, etc tests even though they
don't have subtests starting with 'size'? I'd say the latter is more
desirable, but I haven't checked how hard that would be to support.


  [0] https://github.com/anakryiko/retsnoop/blob/2e6217f7a82f421fcf3481cc401390605066ab26/src/mass_attacher.c#L982-L1015

>
> The glob matching function is copied from perf/util/string.c
>
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 94 +++++++++++++++++++++++-
>  1 file changed, 92 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 74dde0af1592..c5bffd2e78ae 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -13,6 +13,96 @@
>  #include <execinfo.h> /* backtrace */
>  #include <linux/membarrier.h>
>
> +// Copied from perf/util/string.c
> +
> +/* Character class matching */
> +static bool __match_charclass(const char *pat, char c, const char **npat)
> +{
> +       bool complement = false, ret = true;
> +
> +       if (*pat == '!') {
> +               complement = true;
> +               pat++;
> +       }
> +       if (*pat++ == c) /* First character is special */
> +               goto end;
> +
> +       while (*pat && *pat != ']') { /* Matching */
> +               if (*pat == '-' && *(pat + 1) != ']') { /* Range */
> +                       if (*(pat - 1) <= c && c <= *(pat + 1))
> +                               goto end;
> +                       if (*(pat - 1) > *(pat + 1))
> +                               goto error;
> +                       pat += 2;
> +               } else if (*pat++ == c)
> +                       goto end;
> +       }
> +       if (!*pat)
> +               goto error;
> +       ret = false;
> +
> +end:
> +       while (*pat && *pat != ']') /* Searching closing */
> +               pat++;
> +       if (!*pat)
> +               goto error;
> +       *npat = pat + 1;
> +       return complement ? !ret : ret;
> +
> +error:
> +       return false;
> +}
> +
> +// Copied from perf/util/string.c
> +/* Glob/lazy pattern matching */
> +static bool __match_glob(const char *str, const char *pat, bool ignore_space,
> +                        bool case_ins)
> +{
> +       while (*str && *pat && *pat != '*') {
> +               if (ignore_space) {
> +                       /* Ignore spaces for lazy matching */
> +                       if (isspace(*str)) {
> +                               str++;
> +                               continue;
> +                       }
> +                       if (isspace(*pat)) {
> +                               pat++;
> +                               continue;
> +                       }
> +               }
> +               if (*pat == '?') { /* Matches any single character */
> +                       str++;
> +                       pat++;
> +                       continue;
> +               } else if (*pat == '[') /* Character classes/Ranges */
> +                       if (__match_charclass(pat + 1, *str, &pat)) {
> +                               str++;
> +                               continue;
> +                       } else
> +                               return false;
> +               else if (*pat == '\\') /* Escaped char match as normal char */
> +                       pat++;
> +               if (case_ins) {
> +                       if (tolower(*str) != tolower(*pat))
> +                               return false;
> +               } else if (*str != *pat)
> +                       return false;
> +               str++;
> +               pat++;
> +       }
> +       /* Check wild card */
> +       if (*pat == '*') {
> +               while (*pat == '*')
> +                       pat++;
> +               if (!*pat) /* Tail wild card matches all */
> +                       return true;
> +               while (*str)
> +                       if (__match_glob(str++, pat, ignore_space, case_ins))
> +                               return true;
> +       }
> +       return !*str && !*pat;
> +}
> +
>  #define EXIT_NO_TEST           2
>  #define EXIT_ERR_SETUP_INFRA   3
>
> @@ -55,12 +145,12 @@ static bool should_run(struct test_selector *sel, int num, const char *name)
>         int i;
>
>         for (i = 0; i < sel->blacklist.cnt; i++) {
> -               if (strstr(name, sel->blacklist.strs[i]))
> +               if (__match_glob(name, sel->blacklist.strs[i], false, false))
>                         return false;
>         }
>
>         for (i = 0; i < sel->whitelist.cnt; i++) {
> -               if (strstr(name, sel->whitelist.strs[i]))
> +               if (__match_glob(name, sel->whitelist.strs[i], false, false))
>                         return true;
>         }
>
> --
> 2.30.2
>
