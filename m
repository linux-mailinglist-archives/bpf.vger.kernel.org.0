Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF05686298
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 10:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjBAJNB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 04:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjBAJMx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 04:12:53 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906A330CC
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 01:12:51 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id mf7so30670098ejc.6
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 01:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RwbI1hEPZADxJUV2ETKOmJ3CGKru4d1XtGxqFgIdXZQ=;
        b=OV8zMmUDmWowc8d8xf4XQMCKnoZBWBvvzaLGN8IA1jxHvtk/16ed4QBnWp7UCbizMh
         mMYd71Owu2hlxKFxh2U+dZyA8lY0v206iL4GSAaaw2xEovM68of1H6l1Fi68K3ndkrb0
         8hllVftC91Xy0RVuNjvL7VKo4OktPWxFVpTLcSmZEHm0t2TnVrfp2S/PUAa9WuGymrYK
         M+aMV+PMShvsiA+9YUamOJI3x24TTYm5Su12P1sxOHjDN1KNiH044CmCF7YtL1HUZBf0
         KFA3weLHxTnChEOg+9G0X8YWAB/7+4P3s89dVBk+PWsE/yegiXGjiUpprYf6qHFYpXtU
         wyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwbI1hEPZADxJUV2ETKOmJ3CGKru4d1XtGxqFgIdXZQ=;
        b=h+K6fftEfsW3sfXATBPNSA4/fwH63ME6TlMT9uBg7S6LotXD+HSFrqqoA87ujZu47b
         FpQuSomoi3Q2Gts+d0YktzTfILKyAeYqXqdyzR46dvF93h2IRJlqXuXzUZr1X2kLe+by
         g+yNi5RniDPkw9fXh1laL460ieTPs9EPz6ZVzubyC216edLBqNSRttSUR5Dm692io0f8
         8IqOfDtvyO09DkyE9arSjmJEnUnzEnPRVCg6kJpcNshP9UJlx8rXr9lypEhteYDZ9sea
         HuEjccb0Y7g100iynXBQVs05bdBLiOxG5909ba+Ko+G4ePqA5LeWKQuMhzWsXhxn4lvj
         0oiw==
X-Gm-Message-State: AO0yUKXhyLORFDKEt2YE6VTNlrB0NFWqp6PUwRjpoAyLjdpw+MnSgfkx
        K6dKUL9vZlwjlMnf9M2hNdXNUQ==
X-Google-Smtp-Source: AK7set+ErhRDb4bogUECFkDjAJfuwPUDPtbnP2diE+Si237jfxqFIcV3dAk+pGRd0hkUeWx7E+7guA==
X-Received: by 2002:a17:906:7955:b0:878:5d34:3c41 with SMTP id l21-20020a170906795500b008785d343c41mr2084078ejo.71.1675242770139;
        Wed, 01 Feb 2023 01:12:50 -0800 (PST)
Received: from lavr ([2a02:168:f656:0:309:d5c3:e99a:94ef])
        by smtp.gmail.com with ESMTPSA id h17-20020a1709066d9100b0087856bd9dbbsm9832018ejt.97.2023.02.01.01.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 01:12:49 -0800 (PST)
Date:   Wed, 1 Feb 2023 10:12:48 +0100
From:   Anton Protopopov <aspsk@isovalent.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 6/6] selftest/bpf/benchs: Add benchmark for
 hashmap lookups
Message-ID: <Y9otECycCEKMZ6sw@lavr>
References: <20230127181457.21389-1-aspsk@isovalent.com>
 <20230127181457.21389-7-aspsk@isovalent.com>
 <23c1f484-380a-c112-86a1-5e104fb981f9@linux.dev>
 <Y9j2EccwJnOsiFuV@lavr>
 <6faf60d9-b125-2bde-715b-f0bd3b637777@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6faf60d9-b125-2bde-715b-f0bd3b637777@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23/01/31 02:50, Martin KaFai Lau wrote:
> On 1/31/23 3:05 AM, Anton Protopopov wrote:
> > On 23/01/30 04:22, Martin KaFai Lau wrote:
> > > On 1/27/23 10:14 AM, Anton Protopopov wrote:
> > > > +/* The number of slots to store times */
> > > > +#define NR_SLOTS 32
> > > > +
> > > > +/* Configured by userspace */
> > > > +u64 nr_entries;
> > > > +u64 nr_loops;
> > > > +u32 __attribute__((__aligned__(8))) key[256];
> > > > +
> > > > +/* Filled by us */
> > > > +u64 __attribute__((__aligned__(256))) percpu_times_index[NR_SLOTS]; > +u64 __attribute__((__aligned__(256))) percpu_times[256][NR_SLOTS];
> > > > +
> > > > +static inline void patch_key(u32 i)
> > > > +{
> > > > +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> > > > +	key[0] = i + 1;
> > > > +#else
> > > > +	key[0] = __builtin_bswap32(i + 1);
> > > > +#endif
> > > > +	/* the rest of key is random and is configured by userspace */
> > > > +}
> > > > +
> > > > +static int lookup_callback(__u32 index, u32 *unused)
> > > > +{
> > > > +	patch_key(index);
> > > > +	return bpf_map_lookup_elem(&hash_map_bench, key) ? 0 : 1;
> > > > +}
> > > > +
> > > > +static int loop_lookup_callback(__u32 index, u32 *unused)
> > > > +{
> > > > +	return bpf_loop(nr_entries, lookup_callback, NULL, 0) ? 0 : 1;
> > > > +}
> > > > +
> > > > +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> > > > +int benchmark(void *ctx)
> > > > +{
> > > > +	u32 cpu = bpf_get_smp_processor_id();
> > > > +	u32 times_index;
> > > > +	u64 start_time;
> > > > +
> > > > +	times_index = percpu_times_index[cpu & 255] % NR_SLOTS;
> > > 
> > > percpu_times_index only has NR_SLOTS (32) elements?
> > 
> > Yes, the idea was the following. One measurement (bpf prog execution) takes
> > about 20-80 ms (depending on the key/map size). So in 2-3 seconds we can get
> > about NR_SLOTS elements. For me 32 looked like enough to get stats for this
> > benchmark. Do you think this is better to make the NR_SLOTS
> > bigger/configurable?
> 
> I thought percpu_times_index[] is the next slot to use for a particular cpu
> in percpu_times[256][NR_SLOTS]. 256 is the max number of cpu supported? It
> is doing "cpu" & 255 also. Should it be sized as percpu_times_index[256]
> instead then?
> 
> May be #define what 256 is here such that it can have a self describe name.

Oh, thanks! Of course, percpu_times_index is of wrong size,
I will fix this and use names instead of numbers.

> > 
> > > > +	start_time = bpf_ktime_get_ns();
> > > > +	bpf_loop(nr_loops, loop_lookup_callback, NULL, 0);
> > > > +	percpu_times[cpu & 255][times_index] = bpf_ktime_get_ns() - start_time;
> > > > +	percpu_times_index[cpu & 255] += 1;
> > > > +	return 0;
> > > > +}
> > > 
> 
