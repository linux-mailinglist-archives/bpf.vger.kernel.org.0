Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA3F669580
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 12:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241192AbjAMLaH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 06:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjAML3j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 06:29:39 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F338E7D9C0;
        Fri, 13 Jan 2023 03:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QiDBE7QfqwbOQGvzFGPyeg41joEHACtfkGqj5wqGLwg=; b=JCRP7BzfTidqbfbybLpKWnV5N/
        Mp1Xzl0fOmQvgET+5IIjszaU9sGgJjnp3kxUu52jLbNVZ9C/0hL44Q5yv4n7m66+5fW7zH7BHCiFs
        gf5aa0v29w1iw1f34v9dMimcY1DiLf1ug+bzSmIvV8YIw8qHbHK4U4ol3or/ArWij0DzIbbt1Pwyj
        5h+p7a5i6WqXvO8V/vlBD0ryi73gH1tg9n2/0ZP1hp795iz4n8DgY2TWkyr3HxHi4BMSg7xY2NAxF
        Jwu4JlLZ6B58w/8iC2maLVYQaRLh4bBWzoXwO+xgLf5gongc0YNZv/v7mfXaqnKII1QT++Ga9csQy
        8CWQvKTw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pGI5P-004KjY-16;
        Fri, 13 Jan 2023 11:19:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 61B9C3001F7;
        Fri, 13 Jan 2023 12:19:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F98F2CCEBAD8; Fri, 13 Jan 2023 12:19:11 +0100 (CET)
Date:   Fri, 13 Jan 2023 12:19:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>,
        linux-s390@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 3/8] perf/core: Add perf_sample_save_raw_data() helper
Message-ID: <Y8E+L3DSYu0k8+e0@hirez.programming.kicks-ass.net>
References: <20230112214015.1014857-1-namhyung@kernel.org>
 <20230112214015.1014857-4-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112214015.1014857-4-namhyung@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 12, 2023 at 01:40:10PM -0800, Namhyung Kim wrote:
> @@ -1182,6 +1187,29 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
>  	data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
>  }
>  
> +static inline void perf_sample_save_raw_data(struct perf_sample_data *data,
> +					     struct perf_raw_record *raw)
> +{
> +	struct perf_raw_frag *frag = &raw->frag;
> +	u32 sum = 0;
> +	int size;
> +
> +	do {
> +		sum += frag->size;
> +		if (perf_raw_frag_last(frag))
> +			break;
> +		frag = frag->next;
> +	} while (1);
> +
> +	size = round_up(sum + sizeof(u32), sizeof(u64));
> +	raw->size = size - sizeof(u32);
> +	frag->pad = raw->size - sum;
> +
> +	data->raw = raw;
> +	data->dyn_size += size;
> +	data->sample_flags |= PERF_SAMPLE_RAW;
> +}

This might be a wee big for inline, but I suppose it doesn't matter too
much.
