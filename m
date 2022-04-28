Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C73512F9B
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 11:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiD1Jtk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 05:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347957AbiD1Jfx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 05:35:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4117E95486
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 02:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651138358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OG6hUPY6sAUTqTJViKJ1E1LWjNyEwooQAig3aG1iSlg=;
        b=bSdVaS0yvXXpcbDElCVtDBaDx0k1hLCEBJ30qU6Th/pqqSu19XujxA1FEMqmwRtlmyyEwJ
        YLVSf6reCB8icoY9UilVO5q9FfpYCGyxGTyOgO93umwDCBspKUgGPTFf7DyWzODfM31bh8
        1cFarfsOSA5R9Qh58WE7Xddpipg+Po4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-OOYY35mwOa-uGHrV6DL_WA-1; Thu, 28 Apr 2022 05:32:36 -0400
X-MC-Unique: OOYY35mwOa-uGHrV6DL_WA-1
Received: by mail-qv1-f69.google.com with SMTP id 33-20020a0c8024000000b0043d17ffb0bdso3260895qva.18
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 02:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=OG6hUPY6sAUTqTJViKJ1E1LWjNyEwooQAig3aG1iSlg=;
        b=Nu9BYUPGWYUb/JhPWJFVJ3Gr1gCw9IOhN5m3YqUh5F014/tSAjb+Bd6PwxnXCADTf3
         kf+GvSQi8pKC4ARSKaU4nKPAxbZVAAL54w4mm4ETFR5GGO+lknFRDv8uvnIGple2XJ9B
         lCnQjcI6mUTyUNZ+3EEMhfdV3JJo4/MQg9B4RyLhLfv50A7JbAMEu2IN1pEgOicTc6Ve
         0N0o4juxrLz1tq8ueSTaWAoRUSG1X5GVAoOAl4kOs6mNWEk7fq53TFancRH0PNmPWw3b
         /ZiUGdX6V72cyRTlNok/fEhniBdadCp3FjRtH3E0a0kK63R748+3+um1QWa6W0upsc9I
         Zxxw==
X-Gm-Message-State: AOAM531Ow1VJerOvmzMN4bUCYnMnfFnm0bT/kj3+k+gPdD5Tl3tuFmRV
        oZ+8S4AJLojWQpAVu392bGwO05gInczV0vPPWNMyTXVNMK0TbwMgqOyCDJ9OeVI7kQiBjDixWM3
        OQ4SeZeXqc+KZ
X-Received: by 2002:a05:622a:2cb:b0:2f3:646b:54b6 with SMTP id a11-20020a05622a02cb00b002f3646b54b6mr15456779qtx.380.1651138356473;
        Thu, 28 Apr 2022 02:32:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJ3J0ImF+LM/cJTr/TdEmv6YBtIqlv1bBiDK6w9j0coe0CvNV+LL3YO5hh7fcCBb3x5O7y0w==
X-Received: by 2002:a05:622a:2cb:b0:2f3:646b:54b6 with SMTP id a11-20020a05622a02cb00b002f3646b54b6mr15456733qtx.380.1651138356147;
        Thu, 28 Apr 2022 02:32:36 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-117-160.dyn.eolo.it. [146.241.117.160])
        by smtp.gmail.com with ESMTPSA id k66-20020a37ba45000000b0069c5adb2f2fsm9620433qkf.6.2022.04.28.02.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 02:32:35 -0700 (PDT)
Message-ID: <c499d01d51095ae338cbc63179bdc0e1606cbfef.camel@redhat.com>
Subject: Re: [PATCH net-next v5 08/18] net: sparx5: Replace usage of found
 with dedicated list iterator variable
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com, Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Casper Andersson <casper.casan@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Colin Ian King <colin.king@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Xu Wang <vulab@iscas.ac.cn>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, bpf@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Date:   Thu, 28 Apr 2022 11:32:28 +0200
In-Reply-To: <20220427160635.420492-9-jakobkoschel@gmail.com>
References: <20220427160635.420492-1-jakobkoschel@gmail.com>
         <20220427160635.420492-9-jakobkoschel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Wed, 2022-04-27 at 18:06 +0200, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  .../microchip/sparx5/sparx5_mactable.c        | 25 +++++++++----------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
> index a5837dbe0c7e..bb8d9ce79ac2 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
> @@ -362,8 +362,7 @@ static void sparx5_mact_handle_entry(struct sparx5 *sparx5,
>  				     unsigned char mac[ETH_ALEN],
>  				     u16 vid, u32 cfg2)
>  {
> -	struct sparx5_mact_entry *mact_entry;
> -	bool found = false;
> +	struct sparx5_mact_entry *mact_entry = NULL, *iter;
>  	u16 port;
>  
>  	if (LRN_MAC_ACCESS_CFG_2_MAC_ENTRY_ADDR_TYPE_GET(cfg2) !=
> @@ -378,28 +377,28 @@ static void sparx5_mact_handle_entry(struct sparx5 *sparx5,
>  		return;
>  
>  	mutex_lock(&sparx5->mact_lock);
> -	list_for_each_entry(mact_entry, &sparx5->mact_entries, list) {
> -		if (mact_entry->vid == vid &&
> -		    ether_addr_equal(mac, mact_entry->mac)) {
> -			found = true;
> -			mact_entry->flags |= MAC_ENT_ALIVE;
> -			if (mact_entry->port != port) {
> +	list_for_each_entry(iter, &sparx5->mact_entries, list) {
> +		if (iter->vid == vid &&
> +		    ether_addr_equal(mac, iter->mac)) {

I'm sorry for the late feedback.

If you move the 'mact_entry = iter;' statement here, the diffstat will
be slightly smaller and the patch more readable, IMHO.

There is similar situation in the next patch.

Cheers,

Paolo

