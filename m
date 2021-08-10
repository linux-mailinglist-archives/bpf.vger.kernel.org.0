Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7960A3E7D12
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 18:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbhHJQDb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 12:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbhHJQDU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Aug 2021 12:03:20 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1C5C0613C1
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 09:02:58 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r72so18799099iod.6
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6M6en2Ee71SR3RvluB6vGpwRU55s2fahqDIgqdFuyFU=;
        b=YR01vciOlTLQsrWGxFi/90FRUlSCgcrv8sL4r/ciyCr+rf+kaFsOBBJdhkCHR4Eyf8
         ztYGbp/AJhSBvwZU8CIDnbTwRvwZj/ZK2uQ3rqMh8xWkLl4S28ESLjWs8/Bts9TLi2vP
         aGStE0H4/pit88ffAI4WDnfQ5zDSnvWkBZ9f3S/RcLVQFx2ZwzHL5RAFPsBnqXNGWtjl
         tv1CyXzF2Hpydjca6cXSynC9tnPC8lv/w3AKoZ174O+n5ZuoJn8tMQ8HS//aSWn4wwTB
         AawFLb/R8wI4SPV2oPzDur/Ru6Qav+OQl4XwvKTUHszXuVmpdoIB/1xZeKip6L2j2Lzz
         cPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6M6en2Ee71SR3RvluB6vGpwRU55s2fahqDIgqdFuyFU=;
        b=cPkhkucPyVlJBu+D52D2eVNF6bnZ+EL7dH/9TJvMbnT6mTHKSYR6mjQimK9W9PBGPD
         QJpteBMHtxL8VuxrIzkK+7wTsgA6P6qyQjL3nG5e0u2vnH+9aBIC+LQoinc0oy6gCUzr
         1LoQV1M+rDGW91Ka6FsbuygCjAEgDjZN9YRcz5LzVC4VUH0wAe2Bv6Inp2QI6HroyyUr
         unDUC7oGdjrcTFzSNu6eUQy6yWiGFcbTpe0wglUuDP3n4QkwUfAkwfLvhOHWAxZJLnyM
         qzAiQuVWJ8BxQNSWqoRvL883wt9fQAvjeZP4U0TkgdYHeegUxX7pzZFXY1Vt4EGyLdzf
         vOWg==
X-Gm-Message-State: AOAM530jx8frEoibRtSN2kFnLRI6A4o6xEKvDs0WiroYiH3dFEjXdW/X
        FoYLcN5sVstcWP9kd54/j/9/lN5jFXkMnZqv7D0=
X-Google-Smtp-Source: ABdhPJyDS1Hp6DCe6/+aLd4abpw71EF+PPgQ42wPC3XDgERhae4Szkk05EtDjBF8as5Xg6qwL6PiNOhqCsnySPSdYPg=
X-Received: by 2002:a02:1d04:: with SMTP id 4mr2447825jaj.98.1628611378197;
 Tue, 10 Aug 2021 09:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210810001625.1140255-1-fallentree@fb.com> <20210810001625.1140255-2-fallentree@fb.com>
In-Reply-To: <20210810001625.1140255-2-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Aug 2021 09:02:47 -0700
Message-ID: <CAEf4BzbpZMiXicGDUzrh0dmgmNEbDzPCvSU=YkCNeu5UE128XQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/5] Skip loading bpf_testmod when using -l to
 list tests.
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        sunyucong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 9, 2021 at 5:17 PM Yucong Sun <fallentree@fb.com> wrote:
>
> This patch remove bpf_testmod load test when using "-l", making output
> cleaner.
>
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 6f103106a39b..74dde0af1592 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -754,10 +754,12 @@ int main(int argc, char **argv)
>
>         save_netns();
>         stdio_hijack();
> -       env.has_testmod = true;
> -       if (load_bpf_testmod()) {

could keep this to minimal changes by just doing

if (!env.list_test_names && load_bpf_testmod()) { ... }

env.has_testmod = true doesn't make difference for listing tests (and
in the future we might want to assume that testmod is available to be
able to list all tests and subtests, including those that depend on
testmod).

> -               fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
> -               env.has_testmod = false;
> +       if (!env.list_test_names) {
> +               env.has_testmod = true;
> +               if (load_bpf_testmod()) {
> +                       fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
> +                       env.has_testmod = false;
> +               }
>         }
>         for (i = 0; i < prog_test_cnt; i++) {
>                 struct prog_test_def *test = &prog_test_defs[i];
> --
> 2.30.2
>
