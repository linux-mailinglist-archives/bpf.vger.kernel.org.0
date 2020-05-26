Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFA61E3225
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 00:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391771AbgEZWNs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 May 2020 18:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391125AbgEZWNs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 18:13:48 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A33C061A0F
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 15:13:48 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q8so5994851qkm.12
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RskS/ywYo1mauR2+lc/uPOundlZwHtm4wYaplerPXfE=;
        b=Fq8dH+kPrwDy/bP80j07Z0FL0gYg3KUPPP3Iw4JXGE9KvTZoSmwwWV0WbuHyVyt4Ss
         M46rfaXdSpDicBxCYAywfw3YD7DRV2+NXyTsRihNbx7aH14qa+gkn3v7eVxn7ekaDkF1
         eShchpDgEqNWfsFqOH6vgq+esHs1eOA17B3hDpF21QyRItzZMTyJCIs1vLhG95R7IGKI
         LIxVP+RofHtHs0LmniAAYl2tyKsWx+F8oAOx7DAQxhCSUTie6yauKrrcD0w7O1qrtqeZ
         m363mU9ULO/zTD3DredQAMwdrxhfY81gFG+eZ80xQ/zCfmInbg8/8g33sytQddnJg62h
         i7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RskS/ywYo1mauR2+lc/uPOundlZwHtm4wYaplerPXfE=;
        b=aqaqibc5rxmu3OZ4yAnrrUQiJPnU931HillgxY/KBe/FLloOrXVpzjIlBjEegm6ItD
         9B9NG7wftBzIo1bEH7AjJm0MtNWq4L6GtOmHLXYtOpaawlqgDnLJvBEhbcfRoDXs2bAH
         mZXm7A1P5q9sLohIuqSQZibuZkPUIpnbUZ2gtTdXQfea3W3al7CaNXZt5DdyjZFPDsOU
         xKmdfe0l83tpTafxXMjwoGkCgiEwuTrZaaABz5rpO1JC9kpIIL4jVR5bhoF9qtQwJrcD
         bfABgEnJauqdAqScFHTOyjxbvUzYcdTLAxPx/NMHGIGBmiDW6hACSNPDhb6KCRlktmn4
         JiaA==
X-Gm-Message-State: AOAM530pvrLR9ICXuoi37uTkaTD8T5r8WGn/2sko0Wheo6E7ulsclcJb
        Ux3k1wewBO+sCgFreYCuWRgWMo5iIvCR0U3OMgc=
X-Google-Smtp-Source: ABdhPJxSoFFPtTXNp+EeTGS6gpVhdsHvivhwC7fmHdcqoX1qwkRl3Twjv9w71C98uM1ulrZQmzBJ1319vfN6Abq7qUo=
X-Received: by 2002:a05:620a:247:: with SMTP id q7mr1135930qkn.36.1590531227351;
 Tue, 26 May 2020 15:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com> <20200522041310.233185-3-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200522041310.233185-3-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 May 2020 15:13:36 -0700
Message-ID: <CAEf4BzZb021L2Dyvp_6HN_rRqt6tOj4Tjpq4J7Nd8FpPV28rGQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] selftests/bpf: build bench.o for any $(OUTPUT)
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 21, 2020 at 9:14 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> bench.o is produced by implicit rule only if it's built in the same
> directory where bench.c is located. If OUTPUT points somewhere else,
> build fails.
>
> Make an explicit rule for it (factor out common part).
> Add bench.c as a dependency to make it source for CC.

If that's the case, then the similar problem would happen to
test_l4lb_noinline.o, test_xdp_noinline.o, and flow_dissector_load.o,
at least. Let's fix the implicit rule (or define our own, but generic
one), instead of ad-hoc fixing it for bench.o only.


>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 09700db35c2d..f0b7d41ed6dd 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -243,6 +243,11 @@ define GCC_BPF_BUILD_RULE
>         $(BPF_GCC) $3 $4 -O2 -c $1 -o $2
>  endef
>
> +define COMPILE_C_RULE
> +       $(call msg,CC,,$@)
> +       $(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
> +endef
> +
>  SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
>
>  # Set up extra TRUNNER_XXX "temporary" variables in the environment (relies on
> @@ -409,11 +414,11 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
>
>  # Benchmark runner
>  $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h
> -       $(call msg,CC,,$@)
> -       $(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
> +       $(COMPILE_C_RULE)
>  $(OUTPUT)/bench_rename.o: $(OUTPUT)/test_overhead.skel.h
>  $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.skel.h
> -$(OUTPUT)/bench.o: bench.h testing_helpers.h
> +$(OUTPUT)/bench.o: bench.c bench.h testing_helpers.h
> +       $(COMPILE_C_RULE)
>  $(OUTPUT)/bench: LDLIBS += -lm
>  $(OUTPUT)/bench: $(OUTPUT)/bench.o $(OUTPUT)/testing_helpers.o \
>                  $(OUTPUT)/bench_count.o \
> --
> 2.26.2
>
