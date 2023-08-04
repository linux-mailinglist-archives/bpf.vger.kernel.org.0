Return-Path: <bpf+bounces-6967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D260A76FC4C
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 10:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBA21C21716
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 08:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C84B9448;
	Fri,  4 Aug 2023 08:46:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365676FAD
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 08:46:56 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD55F49E3
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 01:46:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bba54f7eefso20042385ad.1
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 01:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691138810; x=1691743610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mbSOiRVGFEbD9EWXxTVJOnnHg8d+rDuu3/77qsuWGAY=;
        b=mTKhUE+JGonMOrp+U11/tBMX4H8FfKWZQStdZ0kGgD8kXE9e2eR4Lv18vxWCf6mTaP
         LY4+qiYOxC93FwIpDIrSVCHyuTioULNkFXF2a+QoLha2SqYwyGJSPi5CYA9ytoYbWiPW
         q69JBWaOPmKfdVCpn9ErI0fOYXnIqNPkOxFFiFr/sQhA0r1mpDJl06kqmUjFk+D3RXdq
         xNTn6w7VxyaZ+F5V8UiwV/yLIVghhC0I0zlGsdZ44Z4pL7lqIgGSirXCKk/uJHvo0Ly6
         LZEroLsSRhFsdiS4VKrRWsgDQrjgi0BjTuymSJkIf7vVGJm2XR5KnJlyry9ZjiCIIzPk
         aTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138810; x=1691743610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbSOiRVGFEbD9EWXxTVJOnnHg8d+rDuu3/77qsuWGAY=;
        b=dxZeXVHIr7oPHKOuYonV4s/CPrx64LWRTlpNMGN8pRCr+MD0oV5KdGU8/gYQ3zXwHE
         858fyksSwMAJw9B19Z+StTAK9XmJYChrEbBiu3oNhXIGjKpOWoldWo3U2ZrcIM++TTa0
         fjb7P89/qcRx6q4nLLfzEvLnqDz3jBbNezn5GtpyUE3lOoTsnwqwicEtzu0LhR3XfneC
         3oM1K92J+PPkLw28W18xM6bh1gttQKM58+9wyDRGuRJCjz3yqfhTduKvu6jqz2xC4AE4
         JP0HrZEk82FR9oMj1aWjiQ+VD+X97Yl6r5/BUS0SdOCAPB0rHklaUnY9oHdL9ENXp3RL
         uFzQ==
X-Gm-Message-State: AOJu0YyWS87KDHQx2HEdk/Lf/i4HkaBElRJd5ExZjjktZYcd2ZtwQAEl
	/cGPPaBYxW+R06CPDBWJo5UhgQ==
X-Google-Smtp-Source: AGHT+IGR60gw8YUIy3tAbLMT54aqn9AAI5w43Ca2RZvHrPtaJgaKasmhKnHdgjtyfY5BfJujf3bf9g==
X-Received: by 2002:a17:902:d492:b0:1b8:a67f:1c15 with SMTP id c18-20020a170902d49200b001b8a67f1c15mr1607154plg.25.1691138810102;
        Fri, 04 Aug 2023 01:46:50 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.39.102])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f7c400b001b8a3a0c928sm1203861plw.181.2023.08.04.01.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:46:49 -0700 (PDT)
Date: Fri, 4 Aug 2023 16:46:43 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: alexander.shishkin@linux.intel.com, peterz@infradead.org,
	james.clark@arm.com, mingo@redhat.com,
	baolin.wang@linux.alibaba.com, acme@kernel.org,
	mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	nathan@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 2/2] perf record: Update docs regarding the maximum
 limitation of AUX area
Message-ID: <20230804084643.GA589820@leoy-yangtze.lan>
References: <20230804072945.85731-1-xueshuai@linux.alibaba.com>
 <20230804072945.85731-3-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804072945.85731-3-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 03:29:45PM +0800, Shuai Xue wrote:
> The maximum AUX area is limited by the page size of the system. Update
> the documentation to reflect this.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 680396c56bd1..b0ee7b63da0e 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -292,6 +292,9 @@ OPTIONS
>  	Also, by adding a comma, the number of mmap pages for AUX
>  	area tracing can be specified.
>  
> +	The maximum AUX area is limited by the page size of the system. For
> +	example with 4K pages configured, the maximum is 2GiB.
> +

This statement is incorrect as it fails to give out prerequisites.

E.g., on Arm64, for 4KiB, 16KiB or 64KiB base page size, different page
size has different default values for MAX_ORDER.  Furthermore, MAX_ORDER
can be set by config ARCH_FORCE_MAX_ORDER, thus we cannot arbitrarily
say the maximum allocation size is 2GiB for 4KiB page size.

Maybe we could consider to use a formula to present the avaliable
maximum buffer size:

     PAGE_SIZE << MAX_ORDER
   ( ---------------------- ) * PAGE_SIZE
      sizeof(page_pointer)

   PAGE_SIZE << MAX_ORDER : the size of maximal physically
   contiguous allocations, which is the maximum size can be
   allocated by slab/slub.

Thanks,
Leo

>  -g::
>  	Enables call-graph (stack chain/backtrace) recording for both
>  	kernel space and user space.
> -- 
> 2.39.3
> 

