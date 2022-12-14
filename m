Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6AA64CEE4
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 18:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbiLNRcp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 12:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLNRcm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 12:32:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC12D13F95
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 09:32:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 927BC61B72
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 17:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1047C433D2;
        Wed, 14 Dec 2022 17:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671039161;
        bh=W9dmg5mV4vsgMs56S1e/9f9u8kddWVLXQDaLv7oA3y4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=d/SCRAV77uV74eBMdO2zjjeX4fukamgIg00DNgcIb2N++1BlM+s1AklMsV+prfoiJ
         NCYZ90L+AvzpexV7heItqYjK/F/b8BwaQVQZDWQpJ54IU5Kwv7H+NjZr4J+ofII7k5
         CB8rFb3dV8QeNq3wwFBIyv4zCO1FbuQqRDNNMyMTx4+NBzYqM3+NrbmeeoMvQrMv9b
         5HL0hzypF/ivOLtEvbu8eL3ObSQyDNz1TloXDoIFNBUSrmrCav2xMsQqBV1jSW0g0G
         FUxzg/5Vor6H3c6JmhRWlPKhsp7b3f20hmqvQjDKrMSQ1uvuxkOGyvSWAs0J6pnNHE
         e0Shs7AJrQ+2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9F8A05C0327; Wed, 14 Dec 2022 09:32:40 -0800 (PST)
Date:   Wed, 14 Dec 2022 09:32:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf: Synchronize dispatcher update with
 bpf_dispatcher_xdp_func
Message-ID: <20221214173240.GW4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221214123542.1389719-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214123542.1389719-1-jolsa@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 14, 2022 at 01:35:42PM +0100, Jiri Olsa wrote:
> Hao Sun reported crash in dispatcher image [1].
> 
> Currently we don't have any sync between bpf_dispatcher_update and
> bpf_dispatcher_xdp_func, so following race is possible:
> 
>  cpu 0:                               cpu 1:
> 
>  bpf_prog_run_xdp
>    ...
>    bpf_dispatcher_xdp_func
>      in image at offset 0x0
> 
>                                       bpf_dispatcher_update
>                                         update image at offset 0x800
>                                       bpf_dispatcher_update
>                                         update image at offset 0x0
> 
>      in image at offset 0x0 -> crash
> 
> Fixing this by synchronizing dispatcher image update (which is done
> in bpf_dispatcher_update function) with bpf_dispatcher_xdp_func that
> reads and execute the dispatcher image.
> 
> Calling synchronize_rcu after updating and installing new image ensures
> that readers leave old image before it's changed in the next dispatcher
> update. The update itself is locked with dispatcher's mutex.
> 
> The bpf_prog_run_xdp is called under local_bh_disable and synchronize_rcu
> will wait for it to leave [2].
> 
> [1] https://lore.kernel.org/bpf/Y5SFho7ZYXr9ifRn@krava/T/#m00c29ece654bc9f332a17df493bbca33e702896c
> [2] https://lore.kernel.org/bpf/0B62D35A-E695-4B7A-A0D4-774767544C1A@gmail.com/T/#mff43e2c003ae99f4a38f353c7969be4c7162e877
> 
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

From an RCU viewpoint:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/bpf/dispatcher.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
> index c19719f48ce0..fa3e9225aedc 100644
> --- a/kernel/bpf/dispatcher.c
> +++ b/kernel/bpf/dispatcher.c
> @@ -125,6 +125,11 @@ static void bpf_dispatcher_update(struct bpf_dispatcher *d, int prev_num_progs)
>  
>  	__BPF_DISPATCHER_UPDATE(d, new ?: (void *)&bpf_dispatcher_nop_func);
>  
> +	/* Make sure all the callers executing the previous/old half of the
> +	 * image leave it, so following update call can modify it safely.
> +	 */
> +	synchronize_rcu();
> +
>  	if (new)
>  		d->image_off = noff;
>  }
> -- 
> 2.38.1
> 
