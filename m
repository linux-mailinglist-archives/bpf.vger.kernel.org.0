Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98028664CE4
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 21:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjAJUAq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 15:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjAJUA2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 15:00:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E219BBC98
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 12:00:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r2so12944464wrv.7
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 12:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lap+FEQF2k7rxL4UQRH7fuZOTdN+cGPfdwGo30Wzqyg=;
        b=HJg86IB1MT5R2Wqj6SqVsSuU2NtqeRFGCMvaU7S3h18SgX1UKuCSAyMXV+ZYho5cV6
         RAEpipSeeTSyyJszO8K42drqmKKdb5nLPCju/76cZhNg304Y3G5UqEWz3Y0cv62JVf5V
         4oKTJSviivlavBia5rMusO2ycOB4rc7f9i4/ZStHuHCgRtlObh3SWDNClr+d/Z7KhD4O
         iiLo1TwhBul0+1OSqsXZMf9U8JYmxnM9crKVUXnelaPQ7sbv4W/ziGRTJ6WNTn+fhKJj
         5HZCJwTfj9qEcyB33IgRMqSb7pG2GE/vTnPRBEAQdSJi5r+C9ZpqhsH8JOQoePq+1t9V
         +KNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lap+FEQF2k7rxL4UQRH7fuZOTdN+cGPfdwGo30Wzqyg=;
        b=OQk2siopAjiVv+JJvThnrJq7aMNwjdWDvmiGn5qUDhZm/loPuTJvPJJl9CLSMtmTZ3
         FSApa8hkSI8ZKKgm16xbvLTSlyVE+kKtzWrWZ87X3KaLRU5tX3d9C0ja5jQNBmQb2KVO
         GuZ/rrVD6afo4jE59Y/cpGiP8evGKJo64MsKLGXFEUm9Ewz3FRGEpRgfwoJ50zN4aQaO
         oMy5KZA2+LBuhD23Joc89WeudefY7vzFAs0pyHaYx4rijsyzO2vT4VArs7lBTAgTUlbi
         CwUgohIO7+ekxBoVRX+8d2yXk9LJoQ7dT2ujtdD/D/g5aQnVtowbHMyAQLgUL11LMpbY
         ovWA==
X-Gm-Message-State: AFqh2krImMsUAJmJV/M9Px3fV7bhyKe+ltQQG9S9HJucNYGQksCbVTCY
        KEw9tL08SKZz+zH/8cgvgejgb/DQsn7wS1qvNpv7VQ==
X-Google-Smtp-Source: AMrXdXv8PBqo8N7wxaT8DMJKwydP5OX0tusDhDYoqCL6w+yFX45v+MZ2HinvpRypxu840u+s4BN265BjsE+RLYJg97o=
X-Received: by 2002:a05:6000:12cb:b0:28c:459a:d5d with SMTP id
 l11-20020a05600012cb00b0028c459a0d5dmr1571182wrx.654.1673380826237; Tue, 10
 Jan 2023 12:00:26 -0800 (PST)
MIME-Version: 1.0
References: <CAJ9a7ViGE3UJX02oA42A9TSTKsOozPzdHjyL+OSP4J-9dZFqrg@mail.gmail.com>
 <Y7hZccgOiueB31a+@kernel.org> <Y7hgKMDGzQlankL1@kernel.org>
 <Y7hgoVKBoulCbA4l@kernel.org> <CAP-5=fXPPSHvN6VYc=8tzBz4xtKg4Ofa17zV4pAk0ycorXje8w@mail.gmail.com>
 <Y7wuz6EOggZ8Wysb@kernel.org> <Y7xYimp0h4YT72/N@krava> <CAP-5=fXwO5_kK=pMV09jdAVw386CB0JwArD0BZd=B=xCyWSP1g@mail.gmail.com>
 <CAP-5=fVa51_URGsdDFVTzpyGmdDRj_Dj2EKPuDHNQ0BYgMSzUA@mail.gmail.com>
 <Y712sCnYBJobe2eY@kernel.org> <Y716Nt3c/Lc0Z4P5@kernel.org>
In-Reply-To: <Y716Nt3c/Lc0Z4P5@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 10 Jan 2023 12:00:13 -0800
Message-ID: <CAP-5=fV4wqgpazr0LpUzdPQ3RsKLNs8SXKttyBwvq2dhe9kPCw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf build: Properly guard libbpf includes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 10, 2023 at 6:46 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jan 10, 2023 at 11:31:12AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Jan 09, 2023 at 11:29:51AM -0800, Ian Rogers escreveu:
> > > On Mon, Jan 9, 2023 at 10:37 AM Ian Rogers <irogers@google.com> wrote:
> > > > -int libbpf_register_prog_handler(const char *sec __maybe_unused,
> > > > -                                 enum bpf_prog_type prog_type __maybe_unused,
> > > > -                                 enum bpf_attach_type exp_attach_type
> > > > __maybe_unused,
> > > > -                                 const struct
> > > > libbpf_prog_handler_opts *opts __maybe_unused)
> > > > +static int libbpf_register_prog_handler(const char *sec __maybe_unused,
> > > > +                                       enum bpf_prog_type prog_type
> > > > __maybe_unused,
> > > > +                                       enum bpf_attach_type
> > > > exp_attach_type __maybe_unused,
> > > > +                                       const void *opts __maybe_unused)
> > > > {
> > > >        pr_err("%s: not support, update libbpf\n", __func__);
> > > >        return -ENOTSUP;
> > > > ```
> > > >
> > > > There are some other fixes necessary too. I'll try to write the fuller
> > > > patch but I have no means for testing except for undefining
> > > > HAVE_LIBBPF_BPF_PROGRAM__SET_INSNS.
> > >
> > > So libbpf_prog_handler_opts is missing in the failing build, this
> > > points to a libbpf before 0.8. I'm somewhat concerned that to work
> > > around these linkage problems we're adding runtime errors - we may
> > > build but the functionality is totally crippled. Is it worth
> > > maintaining these broken builds or to just upfront fail the feature
> > > test?
>
> > Probably better to make the feature test disable bpf support while
> > emitting a warning that features such as a, b, and c won't we available.
>
> This would be the one-liner I think is appropriate for v6.2, ok?
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 9962ae23ab8c5868..5b87846759036f6f 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -589,6 +589,8 @@ ifndef NO_LIBELF
>            $(call feature_check,libbpf-bpf_program__set_insns)
>            ifeq ($(feature-libbpf-bpf_program__set_insns), 1)
>              CFLAGS += -DHAVE_LIBBPF_BPF_PROGRAM__SET_INSNS
> +          else
> +            dummy := $(error Error: libbpf devel library needs to be >= 0.8.0 to build with LIBBPF_DYNAMIC, update or build statically with the version that comes with the kernel sources);

It is ok. The intent/result should be the same as:
https://lore.kernel.org/lkml/20230109203424.1157561-2-irogers@google.com/
but it doesn't change a file outside of tools/perf. I think the change
above would be preferable for 6.3.

Thanks,
Ian

>            endif
>            $(call feature_check,libbpf-btf__raw_data)
>            ifeq ($(feature-libbpf-btf__raw_data), 1)
