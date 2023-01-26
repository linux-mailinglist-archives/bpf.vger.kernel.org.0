Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CCC67C237
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 02:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjAZBMR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 20:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjAZBMQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 20:12:16 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D863A3EFDF
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 17:12:14 -0800 (PST)
Message-ID: <c2c7f7c7-4c36-c4de-332a-22531a53b7b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674695533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FfuyelD20RVnl7HUtltgark23lBP8IsFprA2j9s0jzk=;
        b=nOeDgaTUk2lAMb0J6e1zlv9qjMPXHNTk/7ABpeJ5vJzj0caxx/6Ntpg3TUrEt1SmUiBIhw
        GCe4VmrokSYCZ4TUktTrVMn4gMg6/uS/nzxur3n89jXz1/TR+nGQfSsIIvyyJyO0Jr0SLC
        uIuID6+L0rTpoygbT9qkd2sQVrjTxP4=
Date:   Wed, 25 Jan 2023 17:12:08 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Properly enable hwtstamp in
 xdp_hw_metadata
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        bpf@vger.kernel.org
References: <20230125223205.3933482-1-sdf@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230125223205.3933482-1-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/25/23 2:32 PM, Stanislav Fomichev wrote:
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
> Also, maybe something to archive here, see [0] for Jesper's note
> about NIC vs host clock delta.
> 
> 0: https://lore.kernel.org/bpf/f3a116dc-1b14-3432-ad20-a36179ef0608@redhat.com/
> 
> Fixes: 297a3f124155 ("selftests/bpf: Simple program to dump XDP RX metadata")
> Reported-by: Jesper Dangaard Brouer <jbrouer@redhat.com>
> Tested-by: Jesper Dangaard Brouer <jbrouer@redhat.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>   tools/testing/selftests/bpf/xdp_hw_metadata.c | 28 ++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> index 0008f0f239e8..dc899c53db5e 100644
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
> @@ -278,13 +279,36 @@ static int rxq_num(const char *ifname)
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
> +static void hwtstamp_enable(const char *ifname)
> +{
> +	struct hwtstamp_config cfg = {
> +		.rx_filter = HWTSTAMP_FILTER_ALL,
> +	};
> +
> +	struct ifreq ifr = {
> +		.ifr_data = (void *)&cfg,
> +	};
> +	strcpy(ifr.ifr_name, ifname);
> +	int fd, ret;
> +
> +	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
> +	if (fd < 0)
> +		error(-1, errno, "socket");
> +
> +	ret = ioctl(fd, SIOCSHWTSTAMP, &ifr);
> +	if (ret < 0)
> +		error(-1, errno, "ioctl(SIOCSHWTSTAMP)");
> +
> +	close(fd);
> +}
> +
>   static void cleanup(void)
>   {
>   	LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
> @@ -341,6 +365,8 @@ int main(int argc, char *argv[])
>   
>   	printf("rxq: %d\n", rxq);
>   
> +	hwtstamp_enable(ifname);

Will it to restore to the earlier setting when the process exits?

