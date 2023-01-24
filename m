Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9606F679D67
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 16:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjAXP06 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 10:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbjAXP05 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 10:26:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6C42449E
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 07:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674573964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FUJyCyAKYGRjpKDQcowW9bwvdIvaMrIk3rgeMaf99ks=;
        b=RuB/UaRKhAo4hUrpBcfaDloklwZnvZa9yVBvTbEnO4yPjA4gtZ5hDBwIndU0t7HucR8D1i
        zadma06BJQHuFPVfkIXO3sbWbkEgXLEcrvN3D11TRYj2HiiK8x9oL3ypoVMj1pd3Mhwsgf
        TvA4H7gH1kzbBs8qwVGVUpSmCMXmtFU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-378-2wQxZt24P52ttiiXEwe_tQ-1; Tue, 24 Jan 2023 10:26:02 -0500
X-MC-Unique: 2wQxZt24P52ttiiXEwe_tQ-1
Received: by mail-ej1-f69.google.com with SMTP id hc30-20020a170907169e00b0086d90ee8b17so10138562ejc.10
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 07:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUJyCyAKYGRjpKDQcowW9bwvdIvaMrIk3rgeMaf99ks=;
        b=gTUooeIbhSvixlGWCwhTzGg9CrVReHXKVmOWZOojYt9Q8IO8+VM7t60eJt2b4wHoIH
         f5jSZAUOlsraMJ25kK+wYiK1B4gn9XSVw4zz3bokR9YiU+QZtwP6Y9OCW/GkewqfIQu+
         LA76r053nS1MUXZZOQ87IuYWK1D3m/1+bCTzyUGHwdD5WU2M6d7KxVet7GoX0Usz9cnf
         aGiIdNPJHQzDOgP1EjRDKsPx9/U/CnadvvyE3jgnd0hAjdZ3JiS78Ww9D3HBD8GLEmvq
         V9W5NCFTrQgtuJYY+eL0gDNzlY4i1S3CenN6znqyxvrY2v0wOnmLE6X9PjkeKN6VZBMH
         fdEg==
X-Gm-Message-State: AFqh2kpTy2G4qIHHy3u8YD6n/OI+a09+Mf19KuqowzbBKj6ZU0oNKIc4
        nwCingmrTfcWbRQ0EhjAvg/qZ884AdBCYSKA/tGCbVcp3xufkHmBfr33Qpy7N+H5dXPbXlnRJM3
        aACshrNqtVjbI
X-Received: by 2002:a17:906:3ac5:b0:84d:207d:c00e with SMTP id z5-20020a1709063ac500b0084d207dc00emr28546459ejd.46.1674573960871;
        Tue, 24 Jan 2023 07:26:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtsIFzsBlh5TtYNTcaOqaVCCuGDCweP542aGQdEh50yP3946LVxecl33lOuTfWC0ROJOtWZdw==
X-Received: by 2002:a17:906:3ac5:b0:84d:207d:c00e with SMTP id z5-20020a1709063ac500b0084d207dc00emr28546429ejd.46.1674573960658;
        Tue, 24 Jan 2023 07:26:00 -0800 (PST)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709063d5200b00870ab0c946fsm1024473ejf.131.2023.01.24.07.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 07:26:00 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <71be95ee-b522-b3db-105a-0f25d8dc52cb@redhat.com>
Date:   Tue, 24 Jan 2023 16:25:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 17/17] selftests/bpf: Simple program to dump
 XDP RX metadata
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20230119221536.3349901-1-sdf@google.com>
 <20230119221536.3349901-18-sdf@google.com>
In-Reply-To: <20230119221536.3349901-18-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Testing this on mlx5 and I'm not getting the RX-timestamp.
See command details below.

On 19/01/2023 23.15, Stanislav Fomichev wrote:
> To be used for verification of driver implementations. Note that
> the skb path is gone from the series, but I'm still keeping the
> implementation for any possible future work.
> 
> $ xdp_hw_metadata <ifname>

sudo ./xdp_hw_metadata mlx5p1

Output:
[...cut ...]
open bpf program...
load bpf program...
prepare skb endpoint...
XXX timestamping_enable(): setsockopt(SO_TIMESTAMPING) ret:0
prepare xsk map...
map[0] = 3
map[1] = 4
map[2] = 5
map[3] = 6
map[4] = 7
map[5] = 8
attach bpf program...
poll: 0 (0)
poll: 0 (0)
poll: 0 (0)
poll: 1 (0)
xsk_ring_cons__peek: 1
0x1821788: rx_desc[0]->addr=100000000008000 addr=8100 comp_addr=8000
rx_timestamp: 0
rx_hash: 2773355807
0x1821788: complete idx=8 addr=8000
poll: 0 (0)

The trace_pipe:

$ sudo cat /sys/kernel/debug/tracing/trace_pipe
           <idle>-0       [005] ..s2.  2722.884762: bpf_trace_printk: 
forwarding UDP:9091 to AF_XDP
           <idle>-0       [005] ..s2.  2722.884771: bpf_trace_printk: 
populated rx_hash with 2773355807


> On the other machine:
> 
> $ echo -n xdp | nc -u -q1 <target> 9091 # for AF_XDP

Fixing the source-port to see if RX-hash remains the same.

  $ echo xdp | nc --source-port=2000 --udp 198.18.1.1 9091

> $ echo -n skb | nc -u -q1 <target> 9092 # for skb
> 
> Sample output:
> 
>    # xdp
>    xsk_ring_cons__peek: 1
>    0x19f9090: rx_desc[0]->addr=100000000008000 addr=8100 comp_addr=8000
>    rx_timestamp_supported: 1
>    rx_timestamp: 1667850075063948829
>    0x19f9090: complete idx=8 addr=8000

xsk_ring_cons__peek: 1
0x1821788: rx_desc[0]->addr=100000000008000 addr=8100 comp_addr=8000
rx_timestamp: 0
rx_hash: 2773355807
0x1821788: complete idx=8 addr=8000

It doesn't look like hardware RX-timestamps are getting enabled.

[... cut to relevant code ...]

> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> new file mode 100644
> index 000000000000..0008f0f239e8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> @@ -0,0 +1,403 @@
[...]

> +static void timestamping_enable(int fd, int val)
> +{
> +	int ret;
> +
> +	ret = setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING, &val, sizeof(val));
> +	if (ret < 0)
> +		error(-1, errno, "setsockopt(SO_TIMESTAMPING)");
> +}
> +
> +int main(int argc, char *argv[])
> +{
[...]

> +	printf("prepare skb endpoint...\n");
> +	server_fd = start_server(AF_INET6, SOCK_DGRAM, NULL, 9092, 1000);
> +	if (server_fd < 0)
> +		error(-1, errno, "start_server");
> +	timestamping_enable(server_fd,
> +			    SOF_TIMESTAMPING_SOFTWARE |
> +			    SOF_TIMESTAMPING_RAW_HARDWARE);
> +

I don't think this timestamping_enable() with these flags are enough to
enable hardware timestamping.

--Jesper

