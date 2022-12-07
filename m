Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0156457BE
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 11:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiLGK0o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 05:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiLGK0Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 05:26:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA75429C90
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 02:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670408666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fmvXrECUWDpk6CjKs72LNRaUpi6UQ7pNxjEBABaDBAw=;
        b=FV3tEec480EvesqpY/doiTvWnRUKpkY3wP5pAIPLcO1KzpUzqf5ASqmUh9jucRSgDCud/l
        3X7/j44IgR3VURgrCgpAVLCoWyGeKREzrsKb7ejQsUO9SB/LdNEyCCeRqIngK4r3xb35YT
        vkUxn2kZ02CISHDc1UwNYilXU+GROWQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-45-2aLBhrxpNV6FrOqH8N4aCg-1; Wed, 07 Dec 2022 05:24:24 -0500
X-MC-Unique: 2aLBhrxpNV6FrOqH8N4aCg-1
Received: by mail-wr1-f70.google.com with SMTP id o10-20020adfa10a000000b00241f603af8dso4100911wro.11
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 02:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmvXrECUWDpk6CjKs72LNRaUpi6UQ7pNxjEBABaDBAw=;
        b=qHFbz/+klWeuLZdKHfwrmVlnJ+DB7oSZF+/wrX0+7jiyvMrJ1pTVnztRMva3pn8gZ1
         FHYUu1yr7c2UCzuTPuAakwf/qrqmVFsm8fanzxmu6S8Eba/GC8CMg7DErZicDzx5nwVi
         mlz0ZwYku5B6CxymUByoXdfsXVw2pIb7t/VMlCJ7xNMhSrFmoB6edo1s4hqRvPgtgDHv
         e3urQEm/BdUSwvJHpScZWvWinm7Zc3Rj9iFsjyl2W017cs6KRZRqwoqGEkV818TJYEyY
         Ua8rl14K18J+gwYEZDaVraDDx5pGYtkVbI07vxp8X0JRfPIvID86RQ5fYn4JRa4U5Xe+
         z/jw==
X-Gm-Message-State: ANoB5plNmtST6XdNYjqH5rTvEN0DvAdER8oCLev/cCOM0oTL57NFCAIu
        TWjhvTKt9uqxj+Vygi17A2NfYmzkh1ObuG1cRun5oNfwKCJiIzk1bTZe2GXjGb2pTPsiySz3TtH
        ti0RAKn4n+A7V
X-Received: by 2002:a05:6000:81a:b0:242:6a15:e257 with SMTP id bt26-20020a056000081a00b002426a15e257mr6351930wrb.624.1670408663411;
        Wed, 07 Dec 2022 02:24:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7yuMyB4HeLgRx4qKqSu2DdpE8gVi8YNKTm3Lh1BRToR9uSlG3n+rU2LpoAoGJwem9ysaJsow==
X-Received: by 2002:a05:6000:81a:b0:242:6a15:e257 with SMTP id bt26-20020a056000081a00b002426a15e257mr6351917wrb.624.1670408663189;
        Wed, 07 Dec 2022 02:24:23 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-106-100.dyn.eolo.it. [146.241.106.100])
        by smtp.gmail.com with ESMTPSA id z8-20020adfdf88000000b002258235bda3sm19041944wrl.61.2022.12.07.02.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 02:24:22 -0800 (PST)
Message-ID: <db3d16ff19ee4558bf96e585e56661eb626163df.camel@redhat.com>
Subject: Re: [PATCH net-next 2/6] tsnep: Add XDP TX support
From:   Paolo Abeni <pabeni@redhat.com>
To:     Gerhard Engleder <gerhard@engleder-embedded.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com
Date:   Wed, 07 Dec 2022 11:24:21 +0100
In-Reply-To: <20221203215416.13465-3-gerhard@engleder-embedded.com>
References: <20221203215416.13465-1-gerhard@engleder-embedded.com>
         <20221203215416.13465-3-gerhard@engleder-embedded.com>
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
[...]
> +/* This function requires __netif_tx_lock is held by the caller. */
> +static int tsnep_xdp_xmit_frame_ring(struct xdp_frame *xdpf,
> +				     struct tsnep_tx *tx, bool dma_map)
> +{
> +	struct skb_shared_info *shinfo = xdp_get_shared_info_from_frame(xdpf);
> +	unsigned long flags;
> +	int count = 1;
> +	struct tsnep_tx_entry *entry;
> +	int length;
> +	int i;
> +	int retval;
> +
> +	if (unlikely(xdp_frame_has_frags(xdpf)))
> +		count += shinfo->nr_frags;
> +
> +	spin_lock_irqsave(&tx->lock, flags);

Not strictily related to this patch, but why are you using the _irqsafe
variant? it looks like all the locak users are either in process or BH
context.

Thanks!

Paolo

