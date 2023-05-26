Return-Path: <bpf+bounces-1292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADED71207C
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 08:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C280281674
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 06:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293275669;
	Fri, 26 May 2023 06:53:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058CB53A0
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 06:53:12 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDA7AD;
	Thu, 25 May 2023 23:53:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b011cffe7fso1710555ad.1;
        Thu, 25 May 2023 23:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685083991; x=1687675991;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhgPHBRfrFbllTEWP/7rhf7JubE15swpXRJxG4NX2SU=;
        b=otEd7naekpqQVL9gmTAOKnw+M+aU6LJr6kClb8Rj0Pp7ZIa7kW1godawweZf7p+2m+
         ijg95ghhXeOYmndR3a+ssJ7iQApQP0C6XlBlNWcOFiY7QbUmmbrCVwQb2wNqFBr8L+U8
         0r/4pICSVvVgQoIzfPC9o/VSZirDhTLh4iQl2jMHNzEvdtWX66sK6gpOdztUycGdVVjQ
         GwT45dPdCkEoiKrYhy2eQEVMV2/vDvsmCutLabOU/CnNqlMJ6DrIg2pdfJ9qk4EGf5fT
         ojRbMmq8PhoM12Gk3dypemdft6YzBKaQvgJvFkHPiNSk8CQ6q9aGlDItXNQPAUnr13QU
         tMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685083991; x=1687675991;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FhgPHBRfrFbllTEWP/7rhf7JubE15swpXRJxG4NX2SU=;
        b=YryVCjFtO3nVlf2hjLIhQT/M0HwPWVSsfJojMuNQI+UmEZm1NkbzCdvuNUcu45Uko5
         ZrbxNC2jwP1Ji7xKfSWZxGJYtLR+UfprnHS6/g/KSNro8wnOIX7BfSJfKuqR0xwD6JMo
         b/yTdW/er5Y+MY+XbtbXzPMn3sxHlsnOeJxRloOGtMce43o/Aoc4BHkev/ToEkwRSmD+
         TCaGjH+pltGs98GT6FtSQyInkyspJitFnhhFLbZl1Yg2pdAIozLZjdtRkZLTPAn7AIyJ
         BePAayYVXXS1rljNQMer7EE4/Lp4V4Nuj/6KQXZvu4NRrIsIWng8El7pzT/Q1CwJCPuu
         4Vlw==
X-Gm-Message-State: AC+VfDzNfUC1Uggoa5vcVPoKTE8vACR4Qb5BM/jTzT48pL8ur3SW5bTh
	+qDT+DsKhFDaZEZy7Iwm5Xc=
X-Google-Smtp-Source: ACHHUZ5FxN4/aChKs2p3DpXwSW/h5KMNhBNs+G6GphMNltwiFt7kwu/SsnxF23ODS2XueD3eZ32MCA==
X-Received: by 2002:a17:903:2092:b0:1ab:1a6:34bc with SMTP id d18-20020a170903209200b001ab01a634bcmr1133666plc.9.1685083990657;
        Thu, 25 May 2023 23:53:10 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10:17de:b2c5:b0ad:62a7])
        by smtp.gmail.com with ESMTPSA id g4-20020a170902740400b001b01448ba72sm450174pll.215.2023.05.25.23.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 23:53:10 -0700 (PDT)
Date: Thu, 25 May 2023 23:53:09 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org, 
 Song Liu <song@kernel.org>, 
 bpf@vger.kernel.org
Message-ID: <64705755d6ae_2023020859@john.notmuch>
In-Reply-To: <20230525000307.3202449-1-namhyung@kernel.org>
References: <20230525000307.3202449-1-namhyung@kernel.org>
Subject: RE: [PATCH] perf bpf filter: Fix a broken perf sample data naming in
 BPF
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Namhyung Kim wrote:
> BPF CO-RE requires 3 underscores for the ignored suffix rule but it
> mistakenly used only 2.  Let's fix it.
> 
> Fixes: 3a8b8fc31748 ("perf bpf filter: Support pre-5.16 kernels where 'mem_hops' isn't in 'union perf_mem_data_src'")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_skel/sample_filter.bpf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> index cffe493af1ed..fb94f5280626 100644
> --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
> +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> @@ -25,7 +25,7 @@ struct perf_sample_data___new {
>  } __attribute__((preserve_access_index));
>  
>  /* new kernel perf_mem_data_src definition */
> -union perf_mem_data_src__new {
> +union perf_mem_data_src___new {
>  	__u64 val;
>  	struct {
>  		__u64   mem_op:5,	/* type of opcode */
> @@ -108,7 +108,7 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
>  		if (entry->part == 7)
>  			return kctx->data->data_src.mem_blk;
>  		if (entry->part == 8) {
> -			union perf_mem_data_src__new *data = (void *)&kctx->data->data_src;
> +			union perf_mem_data_src___new *data = (void *)&kctx->data->data_src;
>  
>  			if (bpf_core_field_exists(data->mem_hops))
>  				return data->mem_hops;
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog
> 
> 

Acked-by: John Fastabend <john.fastabend@gmail.com>

