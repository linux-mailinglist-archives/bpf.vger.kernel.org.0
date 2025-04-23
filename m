Return-Path: <bpf+bounces-56498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957F9A991EB
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA776467941
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC3F293B73;
	Wed, 23 Apr 2025 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+0NWU4p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4953E293B5A;
	Wed, 23 Apr 2025 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421651; cv=none; b=hfkH+/4x6csHKvfUCXKMZhWmjyMWt7kQFgIsqm0MELdjcumGuIbAp9PE8FUu4ef0POkUIRngxqn+eFdmmlzgcHx/EvzMR4QWeTYG+JgQsBuU/+XoZD5kiU3gCAMmZUwLt8VEn0Wohiiw9gF6a10TwuxzSScD2F44f9k2o4uWa9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421651; c=relaxed/simple;
	bh=VDfwmOCVRoGoEsvlBNbRNn+5O+sBsS7veCm7PZofIIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuWSobq+eIulT1G9LQQ/XWuVnD4S3jx54LbhR3qbeuP4SUEeb1At5Ri9FW9aFygqKL16zqSDQ4N3N+4+rv3vDfimgwO/SJBZqi5EoWab5dqXq0hXokf9oxe1i1QHhVxNR2tTE4d23ehEClKbKHS9OziVCjLqBIM7DSbV3kBa4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+0NWU4p; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-af28bc68846so5626391a12.1;
        Wed, 23 Apr 2025 08:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745421648; x=1746026448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ay1hJ+xxSveKW4SXff1bMvJ/IKV12NveP9f4RrvhN6c=;
        b=P+0NWU4p827RUysOZ6f6emFPBXhjR+uHsAF8SZVsLTvNe0nKajbhhnlZUEL+siKpo0
         rCQq1TPV+MNE+lR44Y7lxYyR9TiAk8I3yKs2455vIIoyjCgJUASx8P2cMkScquNSCLee
         eKGUVaDx/difRU0xlqCHzLKm59BY4QeE37wAQ12HIcJoZUPOYj5HLRCUK2/g6PzPqGTA
         wfl4pR6ZLz+sZZf1O/i6KLImnDkW/DpZcYP+WmvNrNVdIEM4z+zgJmBBSODTmu1fTK93
         w++d4tJ4Wmss1eTHC7kk2UBDuy/bpsWxrfA+X+otekKhdoIAHDFqOm6pfKbYOYkXLGMh
         5isQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745421648; x=1746026448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay1hJ+xxSveKW4SXff1bMvJ/IKV12NveP9f4RrvhN6c=;
        b=S+c5U7xOsvguR8rrKMyV4OrBC5K5T2tQgpakp6Kjz3advc8q4uKRDEz8oNr6QMa9U2
         QKZdlCdaicNshhmW6JH6eSuY2x2muNV8AZclMxLPmDas+eWV9jeRAlSplbLkcj96iXHW
         THbBzz0g2vI0M9uUHnGMHGecYVr7qjwZ8bqPgWRMAx24XP2ZQ88Jo5WkZdPOQKg+ATP2
         78wIgS5y8nf1u8K9LF+thBqHz6fnkNFZ/Eng7Z598k+aEtdTDj9BUl1R+0+lG4dMJk9o
         VKS26TLr2G79dDMDkLlm6v6Qgi5sPuBOTMPfQmqCg/P480lVrI3qGsn9ZuD81tBiUCQl
         gGdw==
X-Forwarded-Encrypted: i=1; AJvYcCUDZjf4TW7BISok2+voIgHwABx/p0fseeUa1BG90Qkyvn9Rir94yY7aYUwE5SXcTUDwX4TyoDw76Bh4E5gF@vger.kernel.org, AJvYcCUd1d2gRysVL0MfiKpfXQMmRccJVPa328qTSJ0j1MHWFSf07GbDzbTGO3Jbrj90hiGm3vQ=@vger.kernel.org, AJvYcCVT6sGdRQlPeoFG1/WFt0Prvuz8nno90AbhNKjKWMA2/QENxxPBoiwsrM8JzzsptUUWTUL4kOaE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/PUV3LmLNALL0tdgi/2Xo9DsNYrd1hKb/UrYxNmve05BF7DQL
	QnrsVOlYYHtNNRrbvFMqIOxbSFnX3y9gFCTPxOLZdIPgUeyu5DlkREKpTm1N9BQ=
X-Gm-Gg: ASbGncvvgOTKp+9pZbTWxhHr6cxBedliTZpDUYJJTM39qPwVBYkBzvZzeUZJK356sa6
	yahtpp2nSLkukqtRMwbMjqk49cCwiDrLUtYV6wCViXW8zkrpC7CHJ8+2HzNbZfQ3aqPuh5MLWx3
	lr6ZXwNtv0F+idoikEqUa/yLr1q5Jq5mRAyTyeyEFVLIDLu5+nk1hjhyQhaJB4M28f9Y8DVmnt1
	n4bIzRW1lwsw8ok6V4I1JddG7S1ZIHKKF3m3s4z+KA+6K1PCrIxtzmixzZ7AqBvsszbCke2or3Q
	yE4/SJa5IlnCJqfa20hIFLva4Nl++quuG4YwHhVRcFZkHbIP0zXcujP3HE20QRrF0HvJoubuL7U
	1Gheyp6GLNhVroQ==
X-Google-Smtp-Source: AGHT+IF0njUnwLJs73OxHmEO22W7D/ZiIYfKXmFPNk7S0195rDOuNRKX5c2xxOZE+G0FANmjiFezMw==
X-Received: by 2002:a05:6a21:3a8d:b0:1f5:8cc8:9cc5 with SMTP id adf61e73a8af0-203cbd27edemr35835560637.34.1745421648443;
        Wed, 23 Apr 2025 08:20:48 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:933:3ee4:f75:4ee9? ([2001:ee0:4f0e:fb30:933:3ee4:f75:4ee9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db13a3396sm9277066a12.28.2025.04.23.08.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 08:20:47 -0700 (PDT)
Message-ID: <aac402b4-d04c-4d7e-91c8-ab6c20c9a74d@gmail.com>
Date: Wed, 23 Apr 2025 22:20:41 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] selftests: net: add a virtio_net deadlock selftest
To: Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250417072806.18660-1-minhquangbui99@gmail.com>
 <20250417072806.18660-5-minhquangbui99@gmail.com>
 <20250422184151.2fb4fffe@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250422184151.2fb4fffe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/23/25 08:41, Jakub Kicinski wrote:
> On Thu, 17 Apr 2025 14:28:06 +0700 Bui Quang Minh wrote:
>> The selftest reproduces the deadlock scenario when binding/unbinding XDP
>> program, XDP socket, rx ring resize on virtio_net interface.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   .../testing/selftests/drivers/net/hw/Makefile |  1 +
>>   .../selftests/drivers/net/hw/virtio_net.py    | 65 +++++++++++++++++++
>>   2 files changed, 66 insertions(+)
>>   create mode 100755 tools/testing/selftests/drivers/net/hw/virtio_net.py
>>
>> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
>> index 07cddb19ba35..b5af7c1412bf 100644
>> --- a/tools/testing/selftests/drivers/net/hw/Makefile
>> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
>> @@ -21,6 +21,7 @@ TEST_PROGS = \
>>   	rss_ctx.py \
>>   	rss_input_xfrm.py \
>>   	tso.py \
>> +	virtio_net.py \
> Maybe xsk_reconfig.py ? Other drivers will benefit from this test, too,
> and that's a more descriptive name.
>
>>   	#
>>   
>>   TEST_FILES := \
>> diff --git a/tools/testing/selftests/drivers/net/hw/virtio_net.py b/tools/testing/selftests/drivers/net/hw/virtio_net.py
>> new file mode 100755
>> index 000000000000..7cad7ab98635
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/net/hw/virtio_net.py
>> @@ -0,0 +1,65 @@
>> +#!/usr/bin/env python3
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +# This is intended to be run on a virtio-net guest interface.
>> +# The test binds the XDP socket to the interface without setting
>> +# the fill ring to trigger delayed refill_work. This helps to
>> +# make it easier to reproduce the deadlock when XDP program,
>> +# XDP socket bind/unbind, rx ring resize race with refill_work on
>> +# the buggy kernel.
>> +#
>> +# The Qemu command to setup virtio-net
>> +# -netdev tap,id=hostnet1,vhost=on,script=no,downscript=no
>> +# -device virtio-net-pci,netdev=hostnet1,iommu_platform=on,disable-legacy=on
>> +
>> +from lib.py import ksft_exit, ksft_run
>> +from lib.py import KsftSkipEx, KsftFailEx
>> +from lib.py import NetDrvEnv
>> +from lib.py import bkg, ip, cmd, ethtool
>> +import re
>> +
>> +def _get_rx_ring_entries(cfg):
>> +    output = ethtool(f"-g {cfg.ifname}").stdout
>> +    values = re.findall(r'RX:\s+(\d+)', output)
> no need for the regexps, ethtool -g supports json formatting:
>
> 	output = ethtool(f"-g {cfg.ifname}", json=True)[0]
> 	return output["rx"]
>
> ?
>
>> +    return int(values[1])
>> +
>> +def setup_xsk(cfg, xdp_queue_id = 0) -> bkg:
>> +    # Probe for support
>> +    xdp = cmd(f'{cfg.net_lib_dir / "xdp_helper"} - -', fail=False)
>> +    if xdp.ret == 255:
>> +        raise KsftSkipEx('AF_XDP unsupported')
>> +    elif xdp.ret > 0:
>> +        raise KsftFailEx('unable to create AF_XDP socket')
>> +
>> +    try:
>> +        xsk_bkg = bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} ' \
>> +                      '{xdp_queue_id} -z', ksft_wait=3)
> This process will time out after 3 seconds but the test really
> shouldn't leave things running after it exits. Don't worry about
> the couple of seconds of execution time. Wrap each test in
>
> 	with bkg(f"... the exec info ... "):
> 		# test code here
>
> The bkg() class has an __exit__() handle once the test finishes
> and leaves the with block it will terminate.

I've tried to make the setup_xsk into each test. However, I've an issue 
that the XDP socket destruct waits for an RCU grace period as I see this 
sock's flag SOCK_RCU_FREE is set. So if we start the next test right 
away, we can have the error when setting up XDP socket again because 
previous XDP socket has not unbound the network interface's queue yet. I 
can resolve the issue by putting the sleep(1) after closing the socket 
in xdp_helper:

diff --git a/tools/testing/selftests/net/lib/xdp_helper.c 
b/tools/testing/selftests/net/lib/xdp_helper.c
index f21536ab95ba..e882bb22877f 100644
--- a/tools/testing/selftests/net/lib/xdp_helper.c
+++ b/tools/testing/selftests/net/lib/xdp_helper.c
@@ -162,5 +162,6 @@ int main(int argc, char **argv)
          */

         close(sock_fd);
+       sleep(1);
         return 0;
  }

Do you think it's enough or do you have a better suggestion here?

Thanks,
Quang Minh.

>
>> +        return xsk_bkg
>> +    except:
>> +        raise KsftSkipEx('Failed to bind XDP socket in zerocopy. ' \
>> +                         'Please consider adding iommu_platform=on ' \
>> +                         'when setting up virtio-net-pci')
>> +
>> +def check_xdp_bind(cfg):
>> +    ip(f"link set dev %s xdp obj %s sec xdp" %
>> +       (cfg.ifname, cfg.net_lib_dir / "xdp_dummy.bpf.o"))
>> +    ip(f"link set dev %s xdp off" % cfg.ifname)
>> +
>> +def check_rx_resize(cfg, queue_size = 128):
>> +    rx_ring = _get_rx_ring_entries(cfg)
>> +    ethtool(f"-G %s rx %d" % (cfg.ifname, queue_size))
>> +    ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring))
> Why guess the ring size? What if it's already 128? I usually do:
>
> 	rx_ring = _get_rx_ring_entries(cfg)
> 	ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring / 2))
> 	ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring))
>
> IOW flip between half or double and current.
>
>> +def main():
>> +    with NetDrvEnv(__file__, nsim_test=False) as cfg:
>> +        try:
>> +            xsk_bkg = setup_xsk(cfg)
>> +        except KsftSkipEx as e:
>> +            print(f"WARN: xsk pool is not set up, err: {e}")
>> +
>> +        ksft_run([check_xdp_bind, check_rx_resize],
>> +                 args=(cfg, ))
>> +    ksft_exit()
>> +
>> +if __name__ == "__main__":
>> +    main()


