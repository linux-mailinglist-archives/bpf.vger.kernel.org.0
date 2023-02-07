Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0707868D164
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 09:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjBGIT4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 03:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBGITz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 03:19:55 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E8E37B66
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 00:19:54 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id z13so2956130wmp.2
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 00:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFBEAheuH1Gux48xXH6ZnHmHywCo4Og/dsbi8p29ApA=;
        b=L62lBlCevcQX+cyB+jvCpmQSJsJRjbKXArMei2yPHqwyeMLSNqPmu6uht3FGPWQTYN
         ih6WnlV+eDuVNbQcPkqRvYyjeNw4Km+CX3YARQi29VCOejkXipQFAMAFhUhXRy57Cbot
         eps2ijAIMeN5CCK6mWsZDfzhdcjn0iJK8esIsETlIjI42imxRZNXteYOE7Ua6jJaxj4D
         XRcexZ9UksYkgaMN3zJzIzGYeBt0W4Hakq2PdZ8UiVOOrIzt130a37hKih04vZdAFLtm
         WRjdNWeBvHZA//4WqUbEqCo5Dsvzn5cvRiuUTz3pOyUqbHs4bW93ZFy6dincxSu3n1om
         xoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFBEAheuH1Gux48xXH6ZnHmHywCo4Og/dsbi8p29ApA=;
        b=EpTuoDnJkihEaBmhv2JO3dxDHZ29Ehg7FtLrUQMd6paoeIhjnEQIQr9i49vrjUXleL
         w+YCFS2vLOmr3ykgrt6EbEp6nj/7nXv2EYGaSnnSeIif1QtNphfndVwhxm5f509KpvFV
         g4aDIao35QAj0auJPV5Z53K5Ubsnsuloo+qEsxsOeA5Aa8R3tp27yzyWqQZriq9/H8LB
         QhsN4Ztj+YgZrba2IRwyYQja5b7U6fi7prJLmVj/zhdasoxxzkfEH8xccKNqz6I2KHJY
         7kz2sxgkiNmlOy2NgdaeG2XdtnIEg/X6dy4p+N5skliqBD+K6VMClnPK4bnIVq4hiouw
         TRmQ==
X-Gm-Message-State: AO0yUKWEgQr1LifyRH7hJy+/mXdVmU5aYZI6q9+2jqCbNh0VNq3cp8d5
        Igk4ofTNG5Rl0Xg3NKRiNhU=
X-Google-Smtp-Source: AK7set9xjpA88V3BAZDFSz9KyrEis50wM90dLKwfx1DqIopKLxyvIZ7kwhwkdhZ0bpxBP/tWLxIHAg==
X-Received: by 2002:a05:600c:44c4:b0:3de:1d31:1044 with SMTP id f4-20020a05600c44c400b003de1d311044mr2380718wmo.22.1675757992966;
        Tue, 07 Feb 2023 00:19:52 -0800 (PST)
Received: from jondnuc ([87.68.177.114])
        by smtp.gmail.com with ESMTPSA id i3-20020a5d5223000000b002bfae1398bbsm10612407wra.42.2023.02.07.00.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 00:19:52 -0800 (PST)
Date:   Tue, 7 Feb 2023 10:19:51 +0200
From:   Jon Doron <arilou@gmail.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        Jon Doron <jond@wiz.io>
Subject: Re: [PATCH bpf-next v3] libbpf: Add sample_period to creation options
Message-ID: <Y+IJpw+bCwAwW3Fs@jondnuc>
References: <20230206133532.2973474-1-arilou@gmail.com>
 <b79b2fac-bfb5-7c8b-1649-b6ad768861e3@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b79b2fac-bfb5-7c8b-1649-b6ad768861e3@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/02/2023, Yonghong Song wrote:
>
>
>On 2/6/23 5:35 AM, Jon Doron wrote:
>>From: Jon Doron <jond@wiz.io>
>>
>>Add option to set when the perf buffer should wake up, by default the
>>perf buffer becomes signaled for every event that is being pushed to it.
>>
>>In case of a high throughput of events it will be more efficient to wake
>>up only once you have X events ready to be read.
>>
>>So your application can wakeup once and drain the entire perf buffer.
>>
>>Signed-off-by: Jon Doron <jond@wiz.io>
>
>LGTM  with one possible change below.
>
>Acked-by: Yonghong Song <yhs@fb.com>
>
>>---
>>  tools/lib/bpf/libbpf.c | 9 +++++++--
>>  tools/lib/bpf/libbpf.h | 3 ++-
>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>
>>diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>index eed5cec6f510..cd0bce5482b2 100644
>>--- a/tools/lib/bpf/libbpf.c
>>+++ b/tools/lib/bpf/libbpf.c
>>@@ -11710,17 +11710,22 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
>>  	const size_t attr_sz = sizeof(struct perf_event_attr);
>>  	struct perf_buffer_params p = {};
>>  	struct perf_event_attr attr;
>>+	__u32 sample_period;
>>  	if (!OPTS_VALID(opts, perf_buffer_opts))
>>  		return libbpf_err_ptr(-EINVAL);
>>+	sample_period = OPTS_GET(opts, sample_period, 1);
>>+	if (!sample_period)
>>+		sample_period = 1;
>>+
>>  	memset(&attr, 0, attr_sz);
>>  	attr.size = attr_sz;
>>  	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
>>  	attr.type = PERF_TYPE_SOFTWARE;
>>  	attr.sample_type = PERF_SAMPLE_RAW;
>>-	attr.sample_period = 1;
>>-	attr.wakeup_events = 1;
>>+	attr.sample_period = sample_period;
>>+	attr.wakeup_events = sample_period;
>>  	p.attr = &attr;
>>  	p.sample_cb = sample_cb;
>>diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>>index 8777ff21ea1d..5d3b75a5acde 100644
>>--- a/tools/lib/bpf/libbpf.h
>>+++ b/tools/lib/bpf/libbpf.h
>>@@ -1246,8 +1246,9 @@ typedef void (*perf_buffer_lost_fn)(void *ctx, int cpu, __u64 cnt);
>>  /* common use perf buffer options */
>>  struct perf_buffer_opts {
>>  	size_t sz;
>>+	__u32 sample_period;
>>  };
>
>The data structure now may be 16 bytes for 64bit system and we have
>4 byte padding at the end which could be arbitrary value. The libbpf
>convention is to add "size_t :0;" at the end of structure to zero
>out tail padding during declaration.
>

Done

>>-#define perf_buffer_opts__last_field sz
>>+#define perf_buffer_opts__last_field sample_period
>>  /**
>>   * @brief **perf_buffer__new()** creates BPF perfbuf manager for a specified
