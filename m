Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2EC6457E4
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 11:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLGKbZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 05:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiLGKbM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 05:31:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4CF135
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 02:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670408992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jbx620gLeOSel9BhXLWySiUXyAHwun+ZwloNL3W64Q0=;
        b=Wzq4c599u5IS7cF4/632i0ktipcN0mKNjFMpDGO6bD+83CflQ7VgsRrxqvS7mG1TPndOj8
        tZLgurVJsriI//FtLRyQypDJV9ANoI1zo7BPhUqPBj1ALGrl8PEzIhOh7f7zRr9VTiIf3v
        dSlqhx74U3/uLtVtm+T8OPXe2Ye9sWQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-363-HVE9_aIQMtW05zokk31VaQ-1; Wed, 07 Dec 2022 05:29:51 -0500
X-MC-Unique: HVE9_aIQMtW05zokk31VaQ-1
Received: by mail-wm1-f71.google.com with SMTP id v188-20020a1cacc5000000b003cf76c4ae66so589437wme.7
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 02:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jbx620gLeOSel9BhXLWySiUXyAHwun+ZwloNL3W64Q0=;
        b=NFhUP2JLEuOcDo/t8VcBxI6vzdF+D95DoSdYwxIxQ5AYqmB/uPEiHhbNBaSHMHWe1V
         99OZT3hik14DienUFtUlzuxduqH+kJig2w/7HIvHCjqv/UXu/mfw/wRBEtjoPcXEIV8n
         wbK0WBIhyriMsqFHcVzaAn5bcFgLOHXY4wlnYa9tl7CRSi2l3xiO3pJr2eVrkeGRrofo
         5cgzrvcOiDUDS7WZ1+Qk9vR7GfKZRml6BdNKkauL0yWx1tY6+PS/USvQBGK5KkLgCAW8
         yOh9iQ6ofyD93BGzq/ntfEVplPQIYV9o9NO215C9HItQYfkwEFYoo35FNa1VEuqTdodE
         2iSg==
X-Gm-Message-State: ANoB5pn+D+z/EdMJaFfGdBMQb1xmFI015G7v3z7IxN89t4IMKzy9QKp7
        MnIyvfK0GCpionJFap0Jld7hd++IlDcOajEEbmgjBh4iXk+obxNVdUPPp2a73F/+GEuiaxEVX2x
        olra/pJfvGmCq
X-Received: by 2002:a5d:4143:0:b0:242:1551:9759 with SMTP id c3-20020a5d4143000000b0024215519759mr27557045wrq.476.1670408988824;
        Wed, 07 Dec 2022 02:29:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7w3De6nwn9QwmUklcg5FgZg0lboaZShQwv0tgeak2w13scTOZtUPKiMr8T18C4Si+fN9qhiA==
X-Received: by 2002:a5d:4143:0:b0:242:1551:9759 with SMTP id c3-20020a5d4143000000b0024215519759mr27557033wrq.476.1670408988586;
        Wed, 07 Dec 2022 02:29:48 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-106-100.dyn.eolo.it. [146.241.106.100])
        by smtp.gmail.com with ESMTPSA id i10-20020a1c540a000000b003d1f2c3e571sm1179006wmb.33.2022.12.07.02.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 02:29:48 -0800 (PST)
Message-ID: <21c752a196bae3977cc0f91182b6ae9cef9ed532.camel@redhat.com>
Subject: Re: [PATCH net-next 4/6] tsnep: Prepare RX buffer for XDP support
From:   Paolo Abeni <pabeni@redhat.com>
To:     Gerhard Engleder <gerhard@engleder-embedded.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com
Date:   Wed, 07 Dec 2022 11:29:46 +0100
In-Reply-To: <20221203215416.13465-5-gerhard@engleder-embedded.com>
References: <20221203215416.13465-1-gerhard@engleder-embedded.com>
         <20221203215416.13465-5-gerhard@engleder-embedded.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 2022-12-03 at 22:54 +0100, Gerhard Engleder wrote:
> @@ -808,6 +809,16 @@ static void tsnep_tx_close(struct tsnep_tx *tx)
>  	tsnep_tx_ring_cleanup(tx);
>  }
>  
> +static inline unsigned int tsnep_rx_offset(struct tsnep_rx *rx)
> +{
> +	struct tsnep_adapter *adapter = rx->adapter;
> +
> +	if (tsnep_xdp_is_enabled(adapter))
> +		return XDP_PACKET_HEADROOM;
> +
> +	return TSNEP_SKB_PAD;
> +}

please, no 'inline' in .c files, thanks!

Paolo

