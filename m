Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2651A691254
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 21:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjBIU7E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 15:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjBIU7C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 15:59:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029006ADC7
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 12:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675976295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BDZuMv0cyMgXrbGMVIJjQf6uurXxR3KvzMvBCEl1dG8=;
        b=SotnV0Z74keSJNARjHf+zhMzItCkoshZlMVw9Tj/gi1FTwTxQqvziw3iv2ENIhxwe5Vd2x
        UqDHyJBvbQBE4TStm7eQrqwHKOmG1JK98Ly+zXElRQqfKT5xZJ4kbTuUH/FTmykiwz/nQp
        6Mjxdsj47jMIyT3eqBjZS0VczSfYuwg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-381-afMMo4bwM0CUWItZv5bfoA-1; Thu, 09 Feb 2023 15:58:13 -0500
X-MC-Unique: afMMo4bwM0CUWItZv5bfoA-1
Received: by mail-ed1-f71.google.com with SMTP id g19-20020a056402115300b004a26cc7f6cbso2241989edw.4
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 12:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDZuMv0cyMgXrbGMVIJjQf6uurXxR3KvzMvBCEl1dG8=;
        b=FFMfhvBgfbzeLnIutGj8/V0rV1BOHY+WhEUJYv2FSO4c+XsCdzEEp7yYx6upwXFxvu
         /bld74/BqBDDGucF80XbUw4YkLkI7HejQo4n67v9JaubAIaSlkNnKd1J5M61x9JjLat2
         c5PddpvxUNCQu/DVmYyGSnmLsdCSQ7N6gsqLQQoapcqaBYiVCZJq8zYOoP60FyUFw1c1
         647zvKe4z3nHagMSPSFdWwpqEPE7TClO9ozi+md3BS0Pj39DQuOHPnaxR6ZurzKdNK/a
         C3xQaMnh6kLYMJGW5jzgCLedv3i+pl/BqSzNIXaAlcyqOeAvT4zztdtjDw2OTzSRSm5h
         84+Q==
X-Gm-Message-State: AO0yUKWAuPvFxpYkQOb/JqxFOqixRZEP4+Ntged3QEkG4w/VSAy/Rpby
        q8yUQH1IZZQlLjtKhrnTjN92tXHfflSNA49EIOhBR+rr+zX5zevbHixWMMpBY5EoqeNCs0T0QRt
        kSKi8Ev7/8yZq1rvYgw==
X-Received: by 2002:a50:f609:0:b0:4ab:25a3:6657 with SMTP id c9-20020a50f609000000b004ab25a36657mr1864568edn.22.1675976291201;
        Thu, 09 Feb 2023 12:58:11 -0800 (PST)
X-Google-Smtp-Source: AK7set/JDa5gJ8k53X+CCbIN/HJHEPavoZU81+194X/Y87Dd0W6io3LHdig3Q/hqN0QRQg4e6o93KQ==
X-Received: by 2002:a50:f609:0:b0:4ab:25a3:6657 with SMTP id c9-20020a50f609000000b004ab25a36657mr1864513edn.22.1675976290346;
        Thu, 09 Feb 2023 12:58:10 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 18-20020a508e12000000b004aacac472f7sm1280115edw.27.2023.02.09.12.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 12:58:09 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BFE36973E3B; Thu,  9 Feb 2023 21:58:07 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, test_run: fix &xdp_frame misplacement for
 LIVE_FRAMES
In-Reply-To: <6db57eb4-02c2-9443-b9eb-21c499142c98@intel.com>
References: <20230209172827.874728-1-alexandr.lobakin@intel.com>
 <6db57eb4-02c2-9443-b9eb-21c499142c98@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 09 Feb 2023 21:58:07 +0100
Message-ID: <87sffe7e00.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexander Lobakin <alexandr.lobakin@intel.com> writes:

> From: Alexander Lobakin <alexandr.lobakin@intel.com>
> Date: Thu, 9 Feb 2023 18:28:27 +0100
>
>> &xdp_buff and &xdp_frame are bound in a way that
>> 
>> xdp_buff->data_hard_start == xdp_frame
>
> [...]
>
>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>> index 2723623429ac..c3cce7a8d47d 100644
>> --- a/net/bpf/test_run.c
>> +++ b/net/bpf/test_run.c
>> @@ -97,8 +97,11 @@ static bool bpf_test_timer_continue(struct bpf_test_timer *t, int iterations,
>>  struct xdp_page_head {
>>  	struct xdp_buff orig_ctx;
>>  	struct xdp_buff ctx;
>> -	struct xdp_frame frm;
>> -	u8 data[];
>> +	union {
>> +		/* ::data_hard_start starts here */
>> +		DECLARE_FLEX_ARRAY(struct xdp_frame, frm);
>> +		DECLARE_FLEX_ARRAY(u8, data);
>> +	};
>
> BTW, xdp_frame here starts at 112 byte offset, i.e. in 16 bytes a
> cacheline boundary is hit, so xdp_frame gets sliced into halves: 16
> bytes in CL1 + 24 bytes in CL2. Maybe we'd better align this union to
> %NET_SKB_PAD / %SMP_CACHE_BYTES / ... to avoid this?

Hmm, IIRC my reasoning was that both those cache lines will be touched
by the code in xdp_test_run_batch(), so it wouldn't matter? But if
there's a performance benefit I don't mind adding an explicit alignment
annotation, certainly!

> (but in bpf-next probably)

Yeah...

-Toke

