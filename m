Return-Path: <bpf+bounces-2378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7D172BE55
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 12:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF25E28111C
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 10:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC33C18C2A;
	Mon, 12 Jun 2023 10:06:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D1E18B07
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 10:06:42 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD5C4EFC
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 03:06:19 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-66577752f05so641842b3a.0
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 03:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686564308; x=1689156308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FBOb/U0RqfC5AxKUFvKlMDVQJb0zRdeSC6F/8xGEJFw=;
        b=LBQ3BljnQGxIzf87eWYR5E5Qak8frDZ78Lod4++Bh8iZ4VII5iXjAoj4BhKBnrAk3J
         veJthmMisy1tJoT50qACfrqjypIPLD+ncUDbLjtIo20RJlhRXrzggnO3OEOyJrVKrQ4K
         Az1yBCopvMuCCnRUlcXpb1eK3v2QNQ+FzU5yocBH9KhR3La53av/CM5HSHJQULbHIi1q
         dm+pkp9bjgLGDeNDTFXDXC6IQKsgr7g/8zy3lgqZeBPh166HySqNtzgFBLdAVTvlytJI
         f1RUtjZwqTlwXSgSoiPZLY4dQsiS19fLQYwckxmdM1EpWf30zOf/bm9JbCuSD0soEsXK
         uXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564308; x=1689156308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBOb/U0RqfC5AxKUFvKlMDVQJb0zRdeSC6F/8xGEJFw=;
        b=bmpjhCBx3GdNq0IXrK55iNO41794WxRwpnXOpP/iE4ePNrwGZI8CVjyj4KfAjOrdkt
         NhDpf3fN9cmFxPzRK6a45SFBDIZfxISiTKutV8A3GHiaNHkGXaac+fLlkJciYstGqEkg
         XWTSWLG5i6lLJkBJxvVqFXQ4YIJDEym6x+hFLQnq86Hz7GCQnBKnNaB7MghvutOmgEAL
         yB/dcdFpqS0eVdlWcJ15eBef2eeNUoD22Sho14q0EndHCLxel8ZsAITIuoZ3Z4/4KYuE
         EmTBVievtbO8BJyFVvlTZovs8rVw2DZLn8NpRMHKIjHLXnZbj9WUz1S5CddxTLht/m2U
         Nt0Q==
X-Gm-Message-State: AC+VfDzcT9uOcJkUPrLVAhq45spNobZ+AcfjOwosgeRFGcvQiAU/e5DI
	E0JipOGN72Ay+J9tMBMpiXMEBw==
X-Google-Smtp-Source: ACHHUZ4KCzP/G4lYu52oALkIYWunkw8ZVaCyIXstDCU3a451MIoJ4eGWvKOqUJaHFn+xmbS8zXrglA==
X-Received: by 2002:a17:902:daca:b0:1ae:5b7:e437 with SMTP id q10-20020a170902daca00b001ae05b7e437mr7314292plx.4.1686564307842;
        Mon, 12 Jun 2023 03:05:07 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-201.hinet-ip.hinet.net. [211.75.219.201])
        by smtp.gmail.com with ESMTPSA id u24-20020a170902a61800b001ae5d21f760sm7832848plq.146.2023.06.12.03.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 03:05:07 -0700 (PDT)
Date: Mon, 12 Jun 2023 18:05:02 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: alexander.shishkin@linux.intel.com, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
	jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH 1/2] perf/core: Bail out early if the request AUX area is
 out of bound
Message-ID: <20230612100502.GE217089@leoy-huanghe.lan>
References: <20230612052452.53425-1-xueshuai@linux.alibaba.com>
 <20230612052452.53425-2-xueshuai@linux.alibaba.com>
 <20230612073821.GB217089@leoy-huanghe.lan>
 <5fe7c14e-4dd4-3e7f-ece4-75da36c3b6c3@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fe7c14e-4dd4-3e7f-ece4-75da36c3b6c3@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 12, 2023 at 04:35:07PM +0800, Shuai Xue wrote:

[...]

> > Furthermore, I believe the AUX trace pages are only mapped for VMA
> > (continuous virtual address), the kernel will defer to map to physical
> > pages (which means it's not necessarily continuous physical pages)
> > when handling data abort caused by accessing the pages.
> 
> I don't know why the rb->aux_pages is limit to allocated with continuous physical pages.
> so I just add a check to avoid oops and report a proper error code -EINVAL to
> user.
> 
> I would like to use vmalloc() family to replace kmalloc() so that we could support
> allocate a more large AUX area if it is not necessarily continuous physical pages.
> Should we remove the restriction?

As you said, we are now able to support a maximum AUX trace buffer
size of up to 2GiB, and AUX trace buffer is per CPU wise.

Seems to me, 2GiB AUX buffer per CPU is big enough for most tracing
scenarios, right?  Except you can provide profiling scenario which
must use bigger buffer size.

Another factor is the allocation of buffers from kmalloc() offers better
performance compared to allocation from vmalloc(), this is also
important for perf core layer.

Thanks,
Leo

