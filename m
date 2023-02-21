Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D6569DF58
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 12:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbjBULy5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 06:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjBULyt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 06:54:49 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED8E22018;
        Tue, 21 Feb 2023 03:54:40 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id o12so16520629edb.9;
        Tue, 21 Feb 2023 03:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DTe8w2Mu6IFu1qfOCr6RAIZxVkPkGvhO9qq+1dA1D+g=;
        b=di0kkbeWcnUXsfPLDd7d8jWp0B5VvuE12Bp5jRLRVlS8nzcN405crfm5JYYl3GYEN9
         jcIRoW8ztg2zb7SB8JtGeC7QN6DCLx/lmBtqwp3OplmDzpVN4cyQuy2104AYg+BtOqIx
         RevDfYnoEOW6OPmMzv23cCTtGVe51l5oHB0OMC7z/dsJrVIuuFVUhcPijIGHcG9zL4o/
         Mkl5PJ0oMkXyaTvgnhh6WQewaxwuc+7vrC/JdvWnX4aXfZnM7qfmBCF4511GSaAcr9h8
         6bGB4Kvyq6oeOGDbQEz5DR676kIVkkTawCTVftwY7Qns5+NbTzK1058A4aUuSy5B5r2g
         qpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTe8w2Mu6IFu1qfOCr6RAIZxVkPkGvhO9qq+1dA1D+g=;
        b=UbxU8un5H752iDkjuHp1Xt0vz7PzdXPeUnJrTZF9Vo5x5o58tj5L4jN7gdK3V7mG2U
         2ciBw+iud0SfrpIlqT2DKAs/t00JbLpNlWhNixbY2OQxUEh2TL9NNngdK1qoVnuB5Zlb
         DfeXueJNtcEhKWiSP/s57dFBdOW9FE37IXoWP3owdpf4l610ukY9SXURxsryXv4CTS6o
         HLAv1EE6Qv7zFrOGxahkIN8iN95tCKbcT+g44uGucyVNGN8VnpSh11R/Ppwcko5P+tZK
         9RUO2TbPEE8l4Av4w0p4Upps+MLU2PSrkWCSxLx020F7qpvs8Q0tERANDtv3YahxhQAn
         KDtw==
X-Gm-Message-State: AO0yUKWo1RyNR0UjrRLcoLYdu1wEithQ4pdT1GKEWd8L17/TUEVUpjTl
        MgWb0XHuXfxzha4WgkYzj4w=
X-Google-Smtp-Source: AK7set+TpnDRd5Ij1SkE2P58yfgSGqSHJaJ/klSqdNy3MZnqNVmt9BcYBtUzrJ0hjRStF7VDBFQXCQ==
X-Received: by 2002:a17:907:2147:b0:8b1:3a18:9daf with SMTP id rk7-20020a170907214700b008b13a189dafmr11303826ejb.74.1676980479054;
        Tue, 21 Feb 2023 03:54:39 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id h20-20020a1709070b1400b008b907006d5dsm5025677ejl.173.2023.02.21.03.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 03:54:38 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 21 Feb 2023 12:54:36 +0100
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/8] perf bpf filter: Implement event sample filtering
Message-ID: <Y/Sw/NGEvPJ9XdtN@krava>
References: <20230219061329.1001079-1-namhyung@kernel.org>
 <20230219061329.1001079-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219061329.1001079-3-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 18, 2023 at 10:13:23PM -0800, Namhyung Kim wrote:

SNIP

> +#define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
> +
> +int perf_bpf_filter__prepare(struct evsel *evsel)
> +{
> +	int i, x, y, fd;
> +	struct sample_filter_bpf *skel;
> +	struct bpf_program *prog;
> +	struct bpf_link *link;
> +	struct perf_bpf_filter_expr *expr;
> +
> +	skel = sample_filter_bpf__open();
> +	if (!skel) {
> +		pr_err("Failed to open perf sample-filter BPF skeleton\n");
> +		return -1;
> +	}
> +
> +	bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);

is this needed? max_entries is defined in the bpf object

jirka

> +
> +	if (sample_filter_bpf__load(skel) < 0) {
> +		pr_err("Failed to load perf sample-filter BPF skeleton\n");
> +		return -1;
> +	}
> +
> +	i = 0;
> +	fd = bpf_map__fd(skel->maps.filters);
> +	list_for_each_entry(expr, &evsel->bpf_filters, list) {
> +		struct perf_bpf_filter_entry entry = {
> +			.op = expr->op,
> +			.flags = expr->sample_flags,
> +			.value = expr->val,
> +		};
> +		bpf_map_update_elem(fd, &i, &entry, BPF_ANY);
> +		i++;
> +	}
> +
> +	prog = skel->progs.perf_sample_filter;
> +	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
> +		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
> +			link = bpf_program__attach_perf_event(prog, FD(evsel, x, y));
> +			if (IS_ERR(link)) {
> +				pr_err("Failed to attach perf sample-filter program\n");
> +				return PTR_ERR(link);
> +			}
> +		}
> +	}
> +	evsel->bpf_skel = skel;
> +	return 0;
> +}
> +

SNIP
