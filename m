Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068B66911DB
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 21:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjBIUGD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 15:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjBIUFk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 15:05:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D503E69537
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 12:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675973084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d0BqT8tPuat49tgSWN97OHDZtonJw6ZWxWI/LJDmqzg=;
        b=GpBXWVJwQPLiO1CaPW0JXlt4lAfcvz6pyb9Nf36OeDVlXkEBMVmK1yBRxD+5rCpF4xsKMY
        W+s+kuoqjyQW/gvllKtvI8eS/5xcESpl0hFtWEgEe42dF6zjvK2I4himbvP65RoouYO9Xc
        0n7iwMN2uhA7+S9b08dVMvlJW3VATFY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-161-GcARo2PaNQiWuQOoi37LvA-1; Thu, 09 Feb 2023 15:04:43 -0500
X-MC-Unique: GcARo2PaNQiWuQOoi37LvA-1
Received: by mail-ej1-f71.google.com with SMTP id wz4-20020a170906fe4400b0084c7e7eb6d0so2166164ejb.19
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 12:04:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0BqT8tPuat49tgSWN97OHDZtonJw6ZWxWI/LJDmqzg=;
        b=vEHa4UiAHKuznd57T9K06MbLUHmSiqQzTB0e/041cT00LgedxCGi9I6/6Rp6Zmw5SW
         NlqoNqwv0lbF0EzmxlTmV/a3HpqZnMH/pMZC+Mjm01aBX/4pfMb0f15TAtZacCzfcwFh
         Yrn5AhjrYMAk+gQ2l2iOdpHBjT0LqJxAi7GqT9wVBbfei0Y7PzQjzsco/vIobCuB7WZ9
         ZUJAHxVYMUIDmp3TGd1X5k4bSimofKogWBAt9p5st27EESiJggyMdT2vkmH1oNPdnuuz
         fk5FEW4of6CBXqaxsJPxkZenVph9ORzvSPR84fGt+1h643lbxSMxAarNQ6XC7MraxrNy
         wn9g==
X-Gm-Message-State: AO0yUKVg/1lulJJkI3KvG2jQoJ7491ydfpBp4DzQGJ7S2RDleEQnylNs
        bgXFX3wfA4jtONG40XolxBq9VhAqpSbb5SBz2RN3S7ybnxrtXFkkm0O/4yLSQkr+5xYf1gSB30t
        LNd3ce/svAIASOTz15Q==
X-Received: by 2002:a17:907:98b7:b0:881:44e3:baae with SMTP id ju23-20020a17090798b700b0088144e3baaemr11499915ejc.54.1675973081145;
        Thu, 09 Feb 2023 12:04:41 -0800 (PST)
X-Google-Smtp-Source: AK7set/yf2CES5+C5nHAOSi4QKD1/IdjrsGDmNgVrkYJEE5A5Npz3f8tWssmZbfx7CJ76YM7FVy3QA==
X-Received: by 2002:a17:907:98b7:b0:881:44e3:baae with SMTP id ju23-20020a17090798b700b0088144e3baaemr11499894ejc.54.1675973080879;
        Thu, 09 Feb 2023 12:04:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id n16-20020a1709062bd000b008af2a7438acsm1270734ejg.188.2023.02.09.12.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 12:04:40 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6DDD0973E1D; Thu,  9 Feb 2023 21:04:38 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, test_run: fix &xdp_frame misplacement for
 LIVE_FRAMES
In-Reply-To: <20230209172827.874728-1-alexandr.lobakin@intel.com>
References: <20230209172827.874728-1-alexandr.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 09 Feb 2023 21:04:38 +0100
Message-ID: <87v8ka7gh5.fsf@toke.dk>
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

> &xdp_buff and &xdp_frame are bound in a way that
>
> xdp_buff->data_hard_start == xdp_frame
>
> It's always the case and e.g. xdp_convert_buff_to_frame() relies on
> this.
> IOW, the following:
>
> 	for (u32 i = 0; i < 0xdead; i++) {
> 		xdpf = xdp_convert_buff_to_frame(&xdp);
> 		xdp_convert_frame_to_buff(xdpf, &xdp);
> 	}
>
> shouldn't ever modify @xdpf's contents or the pointer itself.
> However, "live packet" code wrongly treats &xdp_frame as part of its
> context placed *before* the data_hard_start. With such flow,
> data_hard_start is sizeof(*xdpf) off to the right and no longer points
> to the XDP frame.

Oh, nice find!

> Instead of replacing `sizeof(ctx)` with `offsetof(ctx, xdpf)` in several
> places and praying that there are no more miscalcs left somewhere in the
> code, unionize ::frm with ::data in a flex array, so that both starts
> pointing to the actual data_hard_start and the XDP frame actually starts
> being a part of it, i.e. a part of the headroom, not the context.
> A nice side effect is that the maximum frame size for this mode gets
> increased by 40 bytes, as xdp_buff::frame_sz includes everything from
> data_hard_start (-> includes xdpf already) to the end of XDP/skb shared
> info.

I like the union approach, however...

> (was found while testing XDP traffic generator on ice, which calls
>  xdp_convert_frame_to_buff() for each XDP frame)
>
> Fixes: b530e9e1063e ("bpf: Add "live packet" mode for XDP in BPF_PROG_RUN")
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---
>  net/bpf/test_run.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 2723623429ac..c3cce7a8d47d 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -97,8 +97,11 @@ static bool bpf_test_timer_continue(struct bpf_test_timer *t, int iterations,
>  struct xdp_page_head {
>  	struct xdp_buff orig_ctx;
>  	struct xdp_buff ctx;
> -	struct xdp_frame frm;
> -	u8 data[];
> +	union {
> +		/* ::data_hard_start starts here */
> +		DECLARE_FLEX_ARRAY(struct xdp_frame, frm);
> +		DECLARE_FLEX_ARRAY(u8, data);
> +	};

...why does the xdp_frame need to be a flex array? Shouldn't this just be:

 +	union {
 +		/* ::data_hard_start starts here */
 +		struct xdp_frame frm;
 +		DECLARE_FLEX_ARRAY(u8, data);
 +	};

which would also get rid of the other three hunks of the patch?

-Toke

