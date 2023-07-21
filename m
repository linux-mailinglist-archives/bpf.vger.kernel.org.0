Return-Path: <bpf+bounces-5647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8943175D172
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 20:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAAB01C217BC
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 18:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB6E1EA93;
	Fri, 21 Jul 2023 18:37:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6427F1D
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 18:37:45 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559EA30C8;
	Fri, 21 Jul 2023 11:37:44 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8bd586086so16844175ad.2;
        Fri, 21 Jul 2023 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689964664; x=1690569464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N41yylWGWk71mjRvficRYzreADvXSZZyopesyI5c/L0=;
        b=ItOwTjjykBhLM1ay/9YyR+ZsbNhldD2jAOoNzfbst+7UcSlEKQCo6wgI31GHcZeW5R
         3u0X0YBFTisbwOojTVKXdzM7F+Rx1Y9364uz8fMYZNm87AKf3UYKBpIsvOiCE4OWkK6A
         1oisXWXlNX5C/J1KbqxucVShx30LOG6J8VI+Ew8aK112TPju3avalwMqCkGvLiFRDdiW
         CHL/JxOmQjrzXyilHzB8i95MrJ+vr02J8B7ht9/pjcvP7VzcDiApl6uDuhK/edX+TNRv
         PKt2iZeYacNw6dPGnXG7rtYR9NbLC/t2sk/pa6s9Kt19umFNLhu15dbB5ziqjivdTEqF
         +QnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689964664; x=1690569464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N41yylWGWk71mjRvficRYzreADvXSZZyopesyI5c/L0=;
        b=jQyw9eOc9IxfE5bJrHWmjclA+qydVOH8UYHFujJyxyiJtf29HU+dxWLjXFcwCN7cER
         aLYObzdsolhxO+HyY3Z4mTBYQgit5VeX90Q56vbVTqDU5Qgdf5lnksh+aRckEC3qJ82S
         yLu2n7978g3yt+yf1IbU3Wd+P+RrUa12wXnS3j/rQQzJnT/qulzyLaxpc6NVgZ2q/l45
         3JuU02ZrANyUJhW5WM/iTGFy5OlsBjsiqBEvY5JAKsA64sC5m6/9+wyyiPiI9qLSAGlG
         Vd6B0B9amUdNlH0WYYdpRTlbKyKwWr9ofMYIOdBXBnJHOMNzgJhvjm/YtJ98YQO1a6dI
         OSlQ==
X-Gm-Message-State: ABy/qLagP20upHv9BdmAJfYO2jgU/cvNtgM84zIwSoT9ESLyTbRbLGk5
	ncFJ7NeMHyJDS8j0bI+1fqo=
X-Google-Smtp-Source: APBJJlFK6CZrZMkCL+nsu5Sg8SMHY9EMPqQvH9QY2wSeL9Dj4fDuQCzK/6dXQPmDjxKEXsIxINu5mA==
X-Received: by 2002:a17:902:e74a:b0:1b8:9b1d:9e24 with SMTP id p10-20020a170902e74a00b001b89b1d9e24mr3276832plf.22.1689964663568;
        Fri, 21 Jul 2023 11:37:43 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f7c700b001b8528da516sm3842958plw.116.2023.07.21.11.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 11:37:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 21 Jul 2023 08:37:41 -1000
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCHSET v4] sched: Implement BPF extensible scheduler class
Message-ID: <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
References: <20230711011412.100319-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

It's been more than half a year since the initial posting of the patchset
and we are now at the fourth iteration. There have been some reviews around
specifics (should be all addressed now except for the ones Andrea raised on
this iteration) but none at high level. There also were some in-person and
off-list discussions. Some, I believe, are addressed by the cover letter but
it'd be nonetheless useful to delve into them on-list.

On our side, we've been diligently experimenting. A lot of our earlier
experiments were focused on improving work conservation which led to the CFS
shared runqueue patchset that David Vernet is currently working on. The
workqueue experiments which led to PeterZ's SIS_NODE patch was also informed
by the same work conservation experiments. We also played with soft affinity
which is inspired by Julia's nest scheduler. Another thing we recently
learned was that at least for our web workload, L1/2 locality doesn't matter
much. This is an area of on-going experiments.

We are comfortable with the current API. Everything we tried fit pretty
well. It will continue to evolve but sched_ext now seems mature enough for
initial inclusion. I suppose lack of response doesn't indicate tacit
agreement from everyone, so what are you guys all thinking?

Thanks.

--
tejun

