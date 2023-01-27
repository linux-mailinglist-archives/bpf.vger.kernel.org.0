Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E18C67E6DD
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 14:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjA0Nhf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 08:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjA0Nhe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 08:37:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6008243E
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 05:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674826601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJB9LE0tuXgyuCIjXl/2aZyvwEk7MvMImJpS89Wbe5A=;
        b=QbHCo+UXdkokTuQr+rlFXSdPxiLJVAeeBS5K/+3xfJwZVK+fSjFvFlzs504j2vvoQzNFXa
        C8YdPJgRvb+AoZaW6GZ6axJRw7wlMci7nlbDKK+DCzGhdBCdZJijJKHZq9F+0IlIHyCwYG
        BAe+QZOc7bULeCLMINXC6atYt3WJQ0I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-XoXRGrMIMmaDm_9qexKj7Q-1; Fri, 27 Jan 2023 08:36:40 -0500
X-MC-Unique: XoXRGrMIMmaDm_9qexKj7Q-1
Received: by mail-ed1-f72.google.com with SMTP id b6-20020a056402278600b0049e41edf3cfso3567185ede.2
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 05:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJB9LE0tuXgyuCIjXl/2aZyvwEk7MvMImJpS89Wbe5A=;
        b=m74FiB9P3LzrqxLYOZ1ut4LnE8aPhQMNLJdXweRh+ZSoGhkWuZt+HkGTGwvqzOzLo/
         vrtK+97Gzktl0DlIdLzb7y5VscCxpSS12/2WQXJUPMqxQO4J8AiYBBrsu+XKx7MDDCj2
         b33mhGsQGGA29dR4lRvfnqccGp77kWfH0zXO5Zgk0QYBOq25GWkZ+r7dPOJA1AQeklNK
         vQczT2fY42JSk77d+i3ieKW5qL+zlZfqQQWmHRiiwuqFafb9990hrv3jLeaWk3Q9IefF
         3uaQHRZ31e0KmS2UaeMBrJ62/fjlyTNWxyfWQODZsU6S8zGs1//kiw9zV7HgPGTVYpCS
         o/Ig==
X-Gm-Message-State: AFqh2kqUcEUUCh1qGHxJBGBHynuDh+rT1yjJ+54D4q5fa1B1PErHN/mO
        2cFIGeWoPNWFWcJh82xgmwBdNYmICSytlXGX01g9YDjixG+yfy4dMv3rgirmRi7nVqr3qmEcspn
        40m/h+9bsFsB/
X-Received: by 2002:a17:906:ddb:b0:7b2:757a:1411 with SMTP id p27-20020a1709060ddb00b007b2757a1411mr47579282eji.9.1674826597232;
        Fri, 27 Jan 2023 05:36:37 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs1AgAjEZgzHSTez/9Qk9KtC1cc7ZiCE9gJcKePZsGA28Y0mTiFVBm6+/bkTAssk/QX3EbcUA==
X-Received: by 2002:a17:906:ddb:b0:7b2:757a:1411 with SMTP id p27-20020a1709060ddb00b007b2757a1411mr47579269eji.9.1674826597031;
        Fri, 27 Jan 2023 05:36:37 -0800 (PST)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id e24-20020a17090681d800b0087bda70d3efsm745872ejx.118.2023.01.27.05.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 05:36:36 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <150ce627-856d-d85a-61da-951ba3754537@redhat.com>
Date:   Fri, 27 Jan 2023 14:36:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Properly enable hwtstamp in
 xdp_hw_metadata
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20230126225030.510629-1-sdf@google.com>
In-Reply-To: <20230126225030.510629-1-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 26/01/2023 23.50, Stanislav Fomichev wrote:
> The existing timestamping_enable() is a no-op because it applies
> to the socket-related path that we are not verifying here
> anymore. (but still leaving the code around hoping we can
> have xdp->skb path verified here as well)
> 
>    poll: 1 (0)
>    xsk_ring_cons__peek: 1
>    0xf64788: rx_desc[0]->addr=100000000008000 addr=8100 comp_addr=8000
>    rx_hash: 3697961069
>    rx_timestamp:  1674657672142214773 (sec:1674657672.1422)
>    XDP RX-time:   1674657709561774876 (sec:1674657709.5618) delta sec:37.4196
>    AF_XDP time:   1674657709561871034 (sec:1674657709.5619) delta
> sec:0.0001 (96.158 usec)
>    0xf64788: complete idx=8 addr=8000
> 

Again for the record, this output is from my devel version of
xdp_hw_metadata and not what is currently upstream.

Small nit below, which is too late as this is already applied.

> Also, maybe something to archive here, see [0] for Jesper's note
> about NIC vs host clock delta.
> 
> 0: https://lore.kernel.org/bpf/f3a116dc-1b14-3432-ad20-a36179ef0608@redhat.com/
> 
> v2:
> - Restore original value (Martin)
> 
> Fixes: 297a3f124155 ("selftests/bpf: Simple program to dump XDP RX metadata")
> Reported-by: Jesper Dangaard Brouer <jbrouer@redhat.com>
> Tested-by: Jesper Dangaard Brouer <jbrouer@redhat.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>   tools/testing/selftests/bpf/xdp_hw_metadata.c | 45 ++++++++++++++++++-
>   1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> index 0008f0f239e8..3823b1c499cc 100644
> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> @@ -24,6 +24,7 @@
>   #include <linux/net_tstamp.h>
>   #include <linux/udp.h>
>   #include <linux/sockios.h>
> +#include <linux/net_tstamp.h>
>   #include <sys/mman.h>
>   #include <net/if.h>
>   #include <poll.h>
> @@ -278,13 +279,53 @@ static int rxq_num(const char *ifname)
>   
>   	ret = ioctl(fd, SIOCETHTOOL, &ifr);
>   	if (ret < 0)
> -		error(-1, errno, "socket");
> +		error(-1, errno, "ioctl(SIOCETHTOOL)");
>   
>   	close(fd);
>   
>   	return ch.rx_count + ch.combined_count;
>   }
>   
> +static void hwtstamp_ioctl(int op, const char *ifname, struct hwtstamp_config *cfg)
> +{
> +	struct ifreq ifr = {
> +		.ifr_data = (void *)cfg,
> +	};
> +	strcpy(ifr.ifr_name, ifname);

I would use strncpy like:

  strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);

> +	int fd, ret;
> +
> +	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
> +	if (fd < 0)
> +		error(-1, errno, "socket");
> +
> +	ret = ioctl(fd, op, &ifr);
> +	if (ret < 0)
> +		error(-1, errno, "ioctl(%d)", op);
> +
> +	close(fd);
> +}
> +
> +static struct hwtstamp_config saved_hwtstamp_cfg;
> +static const char *saved_hwtstamp_ifname;
> +
> +static void hwtstamp_restore(void)
> +{
> +	hwtstamp_ioctl(SIOCSHWTSTAMP, saved_hwtstamp_ifname, &saved_hwtstamp_cfg);
> +}
> +
> +static void hwtstamp_enable(const char *ifname)
> +{
> +	struct hwtstamp_config cfg = {
> +		.rx_filter = HWTSTAMP_FILTER_ALL,
> +	};
> +
> +	hwtstamp_ioctl(SIOCGHWTSTAMP, ifname, &saved_hwtstamp_cfg);
> +	saved_hwtstamp_ifname = strdup(ifname);
> +	atexit(hwtstamp_restore);
> +
> +	hwtstamp_ioctl(SIOCSHWTSTAMP, ifname, &cfg);
> +}
> +
>   static void cleanup(void)
>   {
>   	LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
> @@ -341,6 +382,8 @@ int main(int argc, char *argv[])
>   
>   	printf("rxq: %d\n", rxq);
>   
> +	hwtstamp_enable(ifname);
> +
>   	rx_xsk = malloc(sizeof(struct xsk) * rxq);
>   	if (!rx_xsk)
>   		error(-1, ENOMEM, "malloc");

