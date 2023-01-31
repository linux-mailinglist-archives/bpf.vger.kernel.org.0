Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067D7682B1B
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 12:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjAaLF6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 06:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjAaLF5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 06:05:57 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894D82D4B
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 03:05:56 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p26so29254952ejx.13
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 03:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZ1a2vBgcWVBYzhVCYmRX1fS1ufPzUPUTgJwuv+7j6I=;
        b=uMgS4w8lhKTtbUYARCEguKBP5FjtXAiwK0kPBkMga4CgjWST4kHHmshlY7P++e3xDp
         0NZR1NebVyIFEvd7f7DlHnIlePIUz9Vo7nuhFdFNUYwzD0XaJOXf+SQdaJtMtOmbtz/u
         G1aVNS81SSwLnACkj07mw/LGZzq3eKXSTaOyRgsbydwDQk5Ke946dUPdthxZ2ybWbfKk
         K6/R/NeJrsgQ4tJjkugVZUEJRN1pOliRhDHyRIC8cx2eglQhQoXXkO2UiomtXRSHbLRh
         C7nbpETgIC7NokHPfRLaYYy6hkFA99YPkLs8rF8YNjh8ylgDvDzkpFNC7C9MVXO5EGLn
         5Bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZ1a2vBgcWVBYzhVCYmRX1fS1ufPzUPUTgJwuv+7j6I=;
        b=Mj6AiZKOC8a52bG+J73FaYHAJMlRTss0MQxpsg/nKcp1j8vE4rWXOxcagFPK7lm05s
         ebPSaG1XNIfBk9hy9C4Ni9PtpSBB6GccVRYnppTcMwtpKT6DtLZ12xUCexk2T8jJOT2/
         j+awxEj2j9eMpU+U43D/5WFQb/hc/0mktU7VdGTqLzJDiK/QxY2Gn6EaGb1rp6qPNSyT
         C2ajl6KKin3WQoCf3hv1ScXjPMfNT+negbSrLj5nINm3KOXwXqguFmCXiYTJ1uJpga/J
         W9D5Vi8iX1bJhsK0vLH8iqeGqenFdIzd2qY0CoUipkDghjj4MGx849nbL9/5br+NgDw4
         vXUg==
X-Gm-Message-State: AO0yUKXaK1D5/6HkxkavWq38MxFpVsd0DLsy02JlWEYzE6EGKhmOY66N
        rgfJqvwGfzFrni1wEh41EhZrBA==
X-Google-Smtp-Source: AK7set/MsbnI4wUimvYvEqNvGxQLBpwgtnBbLMScHiB9337BgSQI5EUbrjLflonVS3k3m6O/vawi2w==
X-Received: by 2002:a17:906:544e:b0:7b2:c227:126d with SMTP id d14-20020a170906544e00b007b2c227126dmr2556744ejp.20.1675163155141;
        Tue, 31 Jan 2023 03:05:55 -0800 (PST)
Received: from lavr ([2a02:168:f656:0:fa3:6e35:7858:23ee])
        by smtp.gmail.com with ESMTPSA id w4-20020a170906184400b0087758f5ecd1sm8158284eje.194.2023.01.31.03.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 03:05:54 -0800 (PST)
Date:   Tue, 31 Jan 2023 12:05:53 +0100
From:   Anton Protopopov <aspsk@isovalent.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 6/6] selftest/bpf/benchs: Add benchmark for
 hashmap lookups
Message-ID: <Y9j2EccwJnOsiFuV@lavr>
References: <20230127181457.21389-1-aspsk@isovalent.com>
 <20230127181457.21389-7-aspsk@isovalent.com>
 <23c1f484-380a-c112-86a1-5e104fb981f9@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23c1f484-380a-c112-86a1-5e104fb981f9@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23/01/30 04:22, Martin KaFai Lau wrote:
> On 1/27/23 10:14 AM, Anton Protopopov wrote:
> > +/* The number of slots to store times */
> > +#define NR_SLOTS 32
> > +
> > +/* Configured by userspace */
> > +u64 nr_entries;
> > +u64 nr_loops;
> > +u32 __attribute__((__aligned__(8))) key[256];
> > +
> > +/* Filled by us */
> > +u64 __attribute__((__aligned__(256))) percpu_times_index[NR_SLOTS]; > +u64 __attribute__((__aligned__(256))) percpu_times[256][NR_SLOTS];
> > +
> > +static inline void patch_key(u32 i)
> > +{
> > +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> > +	key[0] = i + 1;
> > +#else
> > +	key[0] = __builtin_bswap32(i + 1);
> > +#endif
> > +	/* the rest of key is random and is configured by userspace */
> > +}
> > +
> > +static int lookup_callback(__u32 index, u32 *unused)
> > +{
> > +	patch_key(index);
> > +	return bpf_map_lookup_elem(&hash_map_bench, key) ? 0 : 1;
> > +}
> > +
> > +static int loop_lookup_callback(__u32 index, u32 *unused)
> > +{
> > +	return bpf_loop(nr_entries, lookup_callback, NULL, 0) ? 0 : 1;
> > +}
> > +
> > +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> > +int benchmark(void *ctx)
> > +{
> > +	u32 cpu = bpf_get_smp_processor_id();
> > +	u32 times_index;
> > +	u64 start_time;
> > +
> > +	times_index = percpu_times_index[cpu & 255] % NR_SLOTS;
> 
> percpu_times_index only has NR_SLOTS (32) elements?

Yes, the idea was the following. One measurement (bpf prog execution) takes
about 20-80 ms (depending on the key/map size). So in 2-3 seconds we can get
about NR_SLOTS elements. For me 32 looked like enough to get stats for this
benchmark. Do you think this is better to make the NR_SLOTS
bigger/configurable?

> > +	start_time = bpf_ktime_get_ns();
> > +	bpf_loop(nr_loops, loop_lookup_callback, NULL, 0);
> > +	percpu_times[cpu & 255][times_index] = bpf_ktime_get_ns() - start_time;
> > +	percpu_times_index[cpu & 255] += 1;
> > +	return 0;
> > +}
> 
