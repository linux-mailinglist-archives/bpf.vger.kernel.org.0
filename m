Return-Path: <bpf+bounces-3874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE22A745C7A
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 14:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4191C209A4
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 12:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8DEEAF4;
	Mon,  3 Jul 2023 12:46:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89310DF4C
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 12:46:36 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7ADFD
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 05:46:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-314319c0d3eso1864455f8f.0
        for <bpf@vger.kernel.org>; Mon, 03 Jul 2023 05:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688388393; x=1690980393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c/79rfMRjpcwLCOmyx92ptoqeCBOS3BP6XcahjrCSAk=;
        b=hSCpnp9yUnzVAFZ4O8bs/QvQ5pUMK17iyGi99r2c/pe1HrbY2+ej9D2V1XR/fYvbIV
         A/yN3jsqX4ROVNjPL2H+0QTv8UcpMh3/en2zcjYN85JMoX7IJ8rIrCd9tc93MfKtHwdY
         8OPFTz6J4gPWX7Av3gcxFoJoi/2DXjaZIN/2TJY7M4DfoMlcx0OpN1POtAH75tksA7Yb
         xIl9fekIJa4BNC/sA6OBlFwQ3o+4XquAnDxYP8VHOKqyEiJ5rHgbTnHVUisc3xJ+1uBL
         t3cxiglooe9WX2yTxqXkncBug5Kw9+rgR+ccWZKIDuYz+KomMuJJL84eYPTMOIdF67Is
         Exkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688388393; x=1690980393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/79rfMRjpcwLCOmyx92ptoqeCBOS3BP6XcahjrCSAk=;
        b=M3Ur13e/0vrPfC4ETiqUKzvVeHaQdvkvw+jPMZbTzD1OuJ/GbhiYdMZnFlZ4W+CNrb
         u6QMD5XVX/cPc++q6QXmVQ8gQUCYs9xzvbQTnMdIfrLD76NzWx58mF0+zT5GqV4Kma9s
         4YmRTK8iz+Juag59dK1lHvG4ZcHAYwhLZjrowXd9warjPj3YWOfm14ZhgF65vGBpVFlr
         x0LPuOodk9FOxVa88IMWXlUHs7zODLuoHXUpKO/61D/tUI7+0acFDQpZ4Z2oSLeOcJdO
         7eymf1y/Ctdmf3Uk/Xk3iCW8sMgTnzujOkIIjzq6Juvc5+9+d7JRnQ7z1xSZVCQG/8Nt
         Srpw==
X-Gm-Message-State: ABy/qLbIUpetXL2hcdtn3OBgjb23q7oIDXMokzraCPYgLfiEdqnfv6QB
	NHjQcLgvHGOnmibFymvTuTZMEg==
X-Google-Smtp-Source: APBJJlFKvCGlRhkpK4us53cBFtT4zZ/fnBK9/a4aEGOPnNXkNQ8FNrgDBBOqv4bnTejmfq33R8m9/Q==
X-Received: by 2002:adf:f60c:0:b0:313:e741:1caa with SMTP id t12-20020adff60c000000b00313e7411caamr9199998wrp.25.1688388393212;
        Mon, 03 Jul 2023 05:46:33 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b3-20020a056000054300b002c70ce264bfsm25687679wrf.76.2023.07.03.05.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:46:31 -0700 (PDT)
Date: Mon, 3 Jul 2023 15:46:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ian Rogers <irogers@google.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/13] perf parse-events: Remove unused
 PE_PMU_EVENT_FAKE token
Message-ID: <4eba81ec-14e8-4204-8429-4b686881a9df@kadam.mountain>
References: <20230627181030.95608-2-irogers@google.com>
 <8dab7522-31de-2137-7474-991885932308@web.de>
 <CAP-5=fVxTYpiXgxDKX1q7ELoAPnAisajWcNOhAp19TZDwnA0oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVxTYpiXgxDKX1q7ELoAPnAisajWcNOhAp19TZDwnA0oA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 10:05:22AM -0700, Ian Rogers wrote:
> On Fri, Jun 30, 2023 at 9:35 AM Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > > Removed by commit 70c90e4a6b2f ("perf parse-events: Avoid scanning
> > > PMUs before parsing").
> >
> > Will the chances ever grow to add another imperative change suggestion?
> >
> > See also:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.4#n94
> 
> 
> Sorry, I can't parse this.

Markus is banned from vger.  Just ignore him.

regards,
dan carpenter


