Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7756E5ECF40
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 23:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiI0VYx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 17:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiI0VYw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 17:24:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9943725A;
        Tue, 27 Sep 2022 14:24:48 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c30so13715221edn.2;
        Tue, 27 Sep 2022 14:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=21hjlzcbCE4D/WGNTwy1KMbbepW/ZU9rYMRT5RsXApM=;
        b=diosena2FAPAd+jdoVjVzE+QxZtlLxhyeYBmcBIZK13SCvCnPUNfrNErkaR4r4A0uv
         HRyQqaxifKcGNNJhHBYUmhCOcd3yxyLO/bp7ggvNkV+TcwpI+QPXtO7C8gs8CXCCuJ1J
         cW42gJQOHcplz0H6g0bmSVBQEFwStDrVKDEGmf2vtwDhP1j6R/3eZDbDxPYXkXQnjFGE
         t6VNQK8F3V6PyzCyoyldAWcXfTMtSqpka9e2F9Ijv9/5itsFLPwW+EhD/a3tSS8cjbQB
         pAt1VxOieQihdzyLKFVxDxf5IVSoO9Z4WidtNrUUnayZePT9espSeTlcoaCcIbUWLlkJ
         oW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=21hjlzcbCE4D/WGNTwy1KMbbepW/ZU9rYMRT5RsXApM=;
        b=sdttjHqA05nh2YqLI7oTUM7HhfrNCrCPW+9PJKfxO3CSsfPiG1tSBemH9pHDVGtwIl
         L3sxnBFcj/xDaTXkGN+KHfvs0gGAb1MZVl9tEjmiIsyI/P4V1kzWR2o8fVyrJjYnvadU
         eOX+DB0A4digv5mc0DWPJ93hXl7EKl2PkGpB2ziEygRrXcxyTolQWXtmKX19IBMY7a4g
         XOeCw1594XxA9Ayq0v67CQ7FFLI9+5txgkcFqQjRmYMtKx1FahoG5unsQQ+LNMQqunht
         2jkr1txeYtmq+92uMZ6VlpB2F+P4LK8f/bgFaCm8vdCB9TucNGQyOmOCHKT1yogX4dzC
         ebLA==
X-Gm-Message-State: ACrzQf1TFreDBxl8/UVYe9YMg+HhOdZRIemXGSJHy3iJy/3Lqsnc1CYe
        EHcyMVPBB0aTdvoCQUVP+8k=
X-Google-Smtp-Source: AMsMyM7wkO/d5f3EEPLFktagcpA/dcJq72nXySk5s9q5ByfXjcAlV+z8XE5dVXLJ8LlQTjv1aMP6PQ==
X-Received: by 2002:a05:6402:2743:b0:453:ce66:56c8 with SMTP id z3-20020a056402274300b00453ce6656c8mr29070761edd.157.1664313887079;
        Tue, 27 Sep 2022 14:24:47 -0700 (PDT)
Received: from krava ([83.240.61.46])
        by smtp.gmail.com with ESMTPSA id q3-20020a170906144300b0077d37a5d401sm1321320ejc.33.2022.09.27.14.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 14:24:46 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 27 Sep 2022 23:24:44 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH -tip] bpf: Check flags for branch stack in
 bpf_read_branch_records helper
Message-ID: <YzNqHC+Cu7776Z/S@krava>
References: <20220927203259.590950-1-jolsa@kernel.org>
 <YzNhFKj7UoGcc5ky@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzNhFKj7UoGcc5ky@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 27, 2022 at 10:46:12PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 27, 2022 at 10:32:59PM +0200, Jiri Olsa wrote:
> > Recent commit [1] changed branch stack data indication from
> > br_stack pointer to sample_flags in perf_sample_data struct.
> > 
> > We need to check sample_flags for PERF_SAMPLE_BRANCH_STACK
> > bit for valid branch stack data.
> > 
> > [1] a9a931e26668 ("perf: Use sample_flags for branch stack")
> > 
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Fixes: a9a931e26668 ("perf: Use sample_flags for branch stack")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> > NOTE sending on top of tip/master because [1] is not
> >      merged in bpf-next/master yet
> 
> Shall I stick this in tip/perf/core right along with [1] then?

yes, sounds good

thanks,
jirka
