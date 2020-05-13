Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9DC1D060A
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 06:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgEMEZU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 00:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbgEMEZT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 00:25:19 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C15C061A0C
        for <bpf@vger.kernel.org>; Tue, 12 May 2020 21:25:19 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id y42so9716754qth.0
        for <bpf@vger.kernel.org>; Tue, 12 May 2020 21:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ThUe2AoGibvJhkzcTd466pkzmZabzXCm/0lZtp7eIc4=;
        b=fDTHIXpqg4nwyQ30mtuzavw8+PTtU5QYg+AVTPCxs0241RAUicUzBIT7PszmX6R3L9
         c02CBgmg2mAuDVH6lYI7s08dYIoNtpSENe9TE2LwoOh2qQdA9WiY3rQwm5PpF/jiem9W
         WpdN5Fu3xZzaMF7aGXxuUGqquFK4xdPIPZZ2IBvJeZKheHQzx79S9MGOzDlSLboUCLol
         iA9lX/Pdr1z8KBqGZVEn5zRtJZQtLxpPNmGWt5efIjInKQPS1wpSiguZdqZ08u2aFcR0
         mPUg/xLBm+3S5r3cs5Nf0PTNBChK2pr4Nw8wNsp/lMBt52pQ8pnGTGgYcsCA4oUspwOz
         oZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThUe2AoGibvJhkzcTd466pkzmZabzXCm/0lZtp7eIc4=;
        b=UJ4jIcjyHz80yD9Os+UXs3U50cpyTdrooG1esuhtwkDAi6EiV7SWtl3urAzvj0z0id
         cLp6s0GZkhtLfAGvpa4ai+YGHW05WmUNG7NM1ZZnjENXJiEjmVq6CQ0ebRoG2F+mwZQY
         Ucv6sw+dpKiOXQp+l5U0Yo7gpyRJkxJFThQX+Z/C+Uu5GJNnyR6mP6RXCL9gwEIYEoEW
         QNg5FCmk6JOEyUz12ejuRi4MzGd2rhzG5Jvm1mGdjlcs7+lQ6+sbsGC3ltIQ+pmtQGCV
         90qwob+8ow3DDQJzDVN8q8/w4qu1WJkg1Z0xxbwP5C90Gr15eLOD8Py2GUx30eaRctRJ
         HWFQ==
X-Gm-Message-State: AGi0PuZMPr6uiCwTvSOhteZ98ryk2oTIDyh+yivpYaQJwUYFglINFSpt
        L5Wbjsv07get8bfREqc9jfdNouiBRPAGuQJ8cLY=
X-Google-Smtp-Source: APiQypL/oQK+Dn081lbszS4eF2vhaD+vuwMBJI1n2DSQGHikntGEIN2q1CTq0NbkpHOrH5WlQ+c7D8AkmNF//RfL7xE=
X-Received: by 2002:aed:24a1:: with SMTP id t30mr11620766qtc.93.1589343918517;
 Tue, 12 May 2020 21:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200513021722.7787-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200513021722.7787-1-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 May 2020 21:25:07 -0700
Message-ID: <CAEf4BzZMCF8uxRARc7qBSrStotO73PF2FPajMrna2sSWe7ZDQg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: install generated test progs
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 12, 2020 at 7:18 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Before commit 74b5a5968fe8 ("selftests/bpf: Replace test_progs and
> test_maps w/ general rule") selftests/bpf used generic install
> target from selftests/lib.mk to install generated bpf test progs by
> mentioning them in TEST_GEN_FILES variable.
>
> Take that functionality back.
>
> Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and
> test_maps w/ general rule")
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---

Thanks for fixing!

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 7729892e0b04..c9a07cc7dede 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -263,6 +263,7 @@ TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o, $$(TRUNNER_BPF_SRCS)
>  TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,      \
>                                  $$(filter-out $(SKEL_BLACKLIST),       \
>                                                $$(TRUNNER_BPF_SRCS)))
> +TEST_GEN_FILES += $$(TRUNNER_BPF_OBJS)
>
>  # Evaluate rules now with extra TRUNNER_XXX variables above already defined
>  $$(eval $$(call DEFINE_TEST_RUNNER_RULES,$1,$2))
> --
> 2.26.2
>
