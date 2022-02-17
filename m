Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869794BAC0B
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 22:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiBQVro (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 16:47:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiBQVrn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 16:47:43 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9054C102423;
        Thu, 17 Feb 2022 13:47:28 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id c23so624849ioi.4;
        Thu, 17 Feb 2022 13:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YYu50T47m2X15x/aJyA+exabFEHDtWyNBqkWcs49TkU=;
        b=ev4QrgJP8rMw+DRyRssNZyhsWtgCHd0RnHRTdh98a+lZvx7PZSRjSZOGd/SYWZoA3j
         9k2wVHuezrkp7wr2A9zgdwYFDfN+uK9Vj08D4PrvbAyztMfHFwc1rL0PB7xvPanEoyxe
         t4D7GYrWNS4z8PoKUlj5nqK2QvoMOAKWfEAo1DL7hyIoPbmvQiPN3d/Gapm7GIQfYYug
         ote3EnGwgPhWWV1/sc/LmwJ0vWq8RwB5/4D5oen9vKWSwnIPHyvSMliw0WGn1OJZF0Oa
         H+BTaYlcVq68fmxJ1R+UXZh6gP75/RaO1G6USm6FbycX8L4skjZnXWXuJ5vXnLf1bYqX
         GwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYu50T47m2X15x/aJyA+exabFEHDtWyNBqkWcs49TkU=;
        b=jjRxObVztPxG2x+oA9kImdSY/qZ5fa4X+ravrUm2LNXMyVJ6GHSC42lHBWGJoojXND
         nsRnEqllqvQ016+ma1RzZMsQyYBM1+CPxxDCVNhq4C+MCr+UjaKqVr8LomTS+qXbhDdF
         oXkFo4bV/Lss+M0JYytTqytMtAeEKwlE0U8i84dO0eaRa9j5CgLETEklT7VtylhcS40Z
         M42l8ANGpFUNufrPe5Xl2zAuyTPhwTKcdw4FI7WPVqiVdD6RT86NODvj/H7JqcH2t5FJ
         Um5YHBXGqY6Fe5ooOk1Kmj49LXovYUgXtJBvACCVFBGrX6kGyxEtiXudefOZ5VcQp62j
         WJ2w==
X-Gm-Message-State: AOAM531ogTTmGyiKT/1WNTVonzZgVkzVpCJVd3rkNIkfIAccDUQ91SQz
        LNbXEk0mzAxcoXwBKc84VbM0x+2iy1DuJD/Z6BQ=
X-Google-Smtp-Source: ABdhPJzd+vhvEi+KPD/izA7Sc2KQlgP5/XgADNTkal1UP6wv3bPi1YaAgCjZOyPAYgF8PEVAkWJVDzzK65N+Bh1feSs=
X-Received: by 2002:a05:6638:22c3:b0:30a:2226:e601 with SMTP id
 j3-20020a05663822c300b0030a2226e601mr3291883jat.237.1645134448000; Thu, 17
 Feb 2022 13:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20220217131916.50615-1-jolsa@kernel.org> <20220217131916.50615-2-jolsa@kernel.org>
In-Reply-To: <20220217131916.50615-2-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Feb 2022 13:47:16 -0800
Message-ID: <CAEf4BzboYd4y53KjKwNMCqE6oV9ms0zbtKCGweEGtjZvCe1f0w@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf tools: Remove bpf_program__set_priv/bpf_program__priv
 usage
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 17, 2022 at 5:19 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Both bpf_program__set_priv/bpf_program__priv are deprecated
> and will be eventually removed.
>
> Using hashmap to replace that functionality.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/bpf-loader.c | 91 +++++++++++++++++++++++++++++-------
>  1 file changed, 75 insertions(+), 16 deletions(-)
>

[...]

> +
> +static int program_set_priv(struct bpf_program *prog, void *priv)
> +{
> +       void *old_priv;
> +
> +       if (!bpf_program_hash) {
> +               bpf_program_hash = hashmap__new(ptr_hash, ptr_equal, NULL);
> +               if (!bpf_program_hash)

should use IS_ERR here

> +                       return -ENOMEM;
> +       }
> +
> +       old_priv = program_priv(prog);
> +       if (old_priv) {
> +               clear_prog_priv(prog, old_priv);
> +               return hashmap__set(bpf_program_hash, prog, priv, NULL, NULL);
> +       }
> +       return hashmap__add(bpf_program_hash, prog, priv);
>  }

[...]
