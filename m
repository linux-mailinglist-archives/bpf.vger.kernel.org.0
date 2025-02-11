Return-Path: <bpf+bounces-51134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8280CA30993
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 12:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9D207A3E63
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5181F4262;
	Tue, 11 Feb 2025 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZBlU3Ff"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DE11FA854
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272198; cv=none; b=iQXDf5+hYDnn18RZcDYXhKuOF2i/PGm8pvm9wfAf4re6uExHUHc5maessvvlEYiTD+QcD3qeUZr5aPOnPofctvfuSvcg0p81p1xReGNZje7IJv00akw4LBjeBUROXDrr4Ni51b94Du4cIEtjhLhL93Ducffw3w8XhHK9zZqXAlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272198; c=relaxed/simple;
	bh=rpSIJr2tTA1mlR4YLGpeZyR2NSRJg92WBS/isaUQecs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X75KIT4LFPfgPtOMYwYxRtqH6iORm/4Vre2dh3iGpr7gSE9B8k0Q4BXfJDCu0S+V8wF12QP0TbsWCDLGM3bRUAlzU/6TrUSNzCQFAUw0FDH1yzeB6Dm5tP33Jbjtqq0IIulzRTtmeoAj3LyNEteYP3hqwTgPf4PlK/xYiGEXI3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZBlU3Ff; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739272195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7ZAQ07RxJ7O5uwhTtT4Uoh1NwPTNjnj401gSfYgfTY=;
	b=QZBlU3FfPLoI3p8Yjz4Xs/nl9U417yAB6wu/giRTdj6Z/w9t5Axvl7RK+nu/biTSmOXUqb
	hQTBvdJf8BfVEi9dkWGDrZ4OLNk1Ety37Qk1Z0YUY0qL+AEv7Bu8uR8lR7v/T0/6j7UUX2
	kMp3xMB4VqlP345+MhPTUMO6B/LeWzA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-nc3-mflXMFywcmajiJuBhg-1; Tue, 11 Feb 2025 06:09:54 -0500
X-MC-Unique: nc3-mflXMFywcmajiJuBhg-1
X-Mimecast-MFC-AGG-ID: nc3-mflXMFywcmajiJuBhg_1739272193
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43943bd1409so14315755e9.3
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 03:09:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739272193; x=1739876993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7ZAQ07RxJ7O5uwhTtT4Uoh1NwPTNjnj401gSfYgfTY=;
        b=oOR4AStWveqSs2wy2f9IcqTEgXiKveDPCr8ch9ExxQRlDigWKoX/u9kxxKlhp52sOV
         aw9Q9zYRO+fTth/MSOCqB5R/4e51Do+UGs2bC5cAaBqFZXK3jBDhk2XVSJzMB0Sf85kD
         KBfTLsBZ7AAliAVJjr8Zbh0b8FslglF/aqUPXZPjk+fnDAkphMEwNN1qQV8DZ8ilvclt
         3qU0nMxr0K8K9CfK6RpHxc95ABcHRUMMVasfr8WHz3g8nzbSGaGstEi2u1rARgdQf7Lg
         7sE0rb96hkKbiu6zGGC9SXstjS90sEYvDuNO+mEXfRYboMZ1T2HynKobZ4i4/vkzx7zz
         6RXA==
X-Forwarded-Encrypted: i=1; AJvYcCUDYIZC5Aecq3PZOcP51j57A4cttIaJhos09PWw3hvYkP+FmAJvOwwDvJiH+kxOpeWQ0EA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiY/25I557Y/3M3WYB3o9+ul3jfnY82ppKR02OwCBQIAINuxlQ
	fF1Trlpd9SKJJj356S7HvyZ1MsTI/siJjX0XFEYbunjEHcJHnZ3hkzO01QZLRAt9z2UamYX0JAZ
	FoN4wdlOIXDqTDP/LNb6hk+batHqWUlCcnSLV/cNmBXtzOh7oDA==
X-Gm-Gg: ASbGncvHtKzh4YB5zGcZyf5rUVuRDt19oGFgcjCHBxwwBfLsjgbxCQ6tcwZD4GTR9kp
	Nsae1zyb+ec96nlG4QtbWE/QtAE4/gVRlVmFq9uMUyRiThFTriQ8Jmc2s9BQmJ195hJ3saQpj/2
	AHtf9AGN/IzNWMzD+nZzoDEGwinKot13TCf7+XFMjL2+NjBvN/r8XjFIVNFwtSltwN+4AyUJqDh
	uYRMdLQ0H/E4lFkJPGA5vJ85FYFc5uxrw5V2cjSL2SrbEQwyOwgJORk2toqaxcYMuDSdWK8V4th
	QOp1Trz5U8gOQe5qCwm52SgFKgGFc3A9LfY=
X-Received: by 2002:a05:600c:1c92:b0:439:4589:1abc with SMTP id 5b1f17b1804b1-43945891eaemr64632605e9.14.1739272192985;
        Tue, 11 Feb 2025 03:09:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRBY/4tHNCW+QPAjUDCl4IZPK/+epAOWrGOIX9oOcIs3K9+fGAdS9SP2ebLTN01yGe5jkbBA==
X-Received: by 2002:a05:600c:1c92:b0:439:4589:1abc with SMTP id 5b1f17b1804b1-43945891eaemr64632275e9.14.1739272192560;
        Tue, 11 Feb 2025 03:09:52 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd6080926sm8461760f8f.83.2025.02.11.03.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 03:09:52 -0800 (PST)
Message-ID: <13afab27-2066-4912-b8f6-15ee4846e802@redhat.com>
Date: Tue, 11 Feb 2025 12:09:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/3] selftests: drv-net: Test queue xsk
 attribute
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: stfomichev@gmail.com, horms@kernel.org, kuba@kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 "open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)"
 <bpf@vger.kernel.org>
References: <20250210193903.16235-1-jdamato@fastly.com>
 <20250210193903.16235-4-jdamato@fastly.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250210193903.16235-4-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/25 8:38 PM, Joe Damato wrote:
> +def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
> +    test_dir = os.path.dirname(os.path.realpath(__file__))
> +    xdp = subprocess.Popen([f"{test_dir}/xdp_helper", f"{cfg.ifindex}", f"{xdp_queue_id}"],
> +                           stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1,
> +                           text=True)
> +    defer(xdp.kill)
> +
> +    stdout, stderr = xdp.communicate(timeout=10)
> +    rx = tx = False
> +
> +    queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
> +    if not queues:
> +        raise KsftSkipEx("Netlink reports no queues")
> +
> +    for q in queues:
> +        if q['id'] == 0:
> +            if q['type'] == 'rx':
> +                rx = True
> +            if q['type'] == 'tx':
> +                tx = True
> +
> +            ksft_eq(q['xsk'], {})
> +        else:
> +            if 'xsk' in q:
> +                _fail("Check failed: xsk attribute set.")
> +
> +    ksft_eq(rx, True)
> +    ksft_eq(tx, True)

This causes self-test failures:

https://netdev-3.bots.linux.dev/vmksft-net-drv/results/987742/4-queues-py/stdout

but I really haven't done any real investigation here.

/P

>  
>  def get_queues(cfg, nl) -> None:
>      snl = NetdevFamily(recv_size=4096)
> @@ -81,7 +112,7 @@ def check_down(cfg, nl) -> None:
>  
>  def main() -> None:
>      with NetDrvEnv(__file__, queue_count=100) as cfg:
> -        ksft_run([get_queues, addremove_queues, check_down], args=(cfg, NetdevFamily()))
> +        ksft_run([get_queues, addremove_queues, check_down, check_xdp], args=(cfg, NetdevFamily()))
>      ksft_exit()
>  
>  
> diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/drivers/net/xdp_helper.c
> new file mode 100644
> index 000000000000..b04d4e0ea30a
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/xdp_helper.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include <sys/socket.h>
> +#include <linux/if_xdp.h>
> +#include <linux/if_link.h>
> +#include <net/if.h>
> +#include <inttypes.h>
> +
> +#define UMEM_SZ (1U << 16)
> +#define NUM_DESC (UMEM_SZ / 2048)
> +
> +/* this is a simple helper program that creates an XDP socket and does the
> + * minimum necessary to get bind() to succeed.
> + *
> + * this test program is not intended to actually process packets, but could be
> + * extended in the future if that is actually needed.
> + *
> + * it is used by queues.py to ensure the xsk netlinux attribute is set
> + * correctly.
> + */
> +int main(int argc, char **argv)
> +{
> +	struct xdp_umem_reg umem_reg = { 0 };
> +	struct sockaddr_xdp sxdp = { 0 };
> +	int num_desc = NUM_DESC;
> +	void *umem_area;
> +	int ifindex;
> +	int sock_fd;
> +	int queue;
> +	char byte;
> +
> +	if (argc != 3) {
> +		fprintf(stderr, "Usage: %s ifindex queue_id", argv[0]);
> +		return 1;
> +	}
> +
> +	sock_fd = socket(AF_XDP, SOCK_RAW, 0);
> +	if (sock_fd < 0) {
> +		perror("socket creation failed");
> +		return 1;
> +	}
> +
> +	ifindex = atoi(argv[1]);
> +	queue = atoi(argv[2]);
> +
> +	umem_area = mmap(NULL, UMEM_SZ, PROT_READ | PROT_WRITE, MAP_PRIVATE |
> +			MAP_ANONYMOUS, -1, 0);
> +	if (umem_area == MAP_FAILED)
> +		return -1;
> +
> +	umem_reg.addr = (uintptr_t)umem_area;
> +	umem_reg.len = UMEM_SZ;
> +	umem_reg.chunk_size = 2048;
> +	umem_reg.headroom = 0;
> +
> +	setsockopt(sock_fd, SOL_XDP, XDP_UMEM_REG, &umem_reg,
> +		   sizeof(umem_reg));
> +	setsockopt(sock_fd, SOL_XDP, XDP_UMEM_FILL_RING, &num_desc,
> +		   sizeof(num_desc));
> +	setsockopt(sock_fd, SOL_XDP, XDP_UMEM_COMPLETION_RING, &num_desc,
> +		   sizeof(num_desc));
> +	setsockopt(sock_fd, SOL_XDP, XDP_RX_RING, &num_desc, sizeof(num_desc));
> +
> +	sxdp.sxdp_family = AF_XDP;
> +	sxdp.sxdp_ifindex = ifindex;
> +	sxdp.sxdp_queue_id = queue;
> +	sxdp.sxdp_flags = 0;
> +
> +	if (bind(sock_fd, (struct sockaddr *)&sxdp, sizeof(sxdp)) != 0) {
> +		perror("bind failed");
> +		close(sock_fd);
> +		return 1;
> +	}
> +
> +	/* give the parent program some data when the socket is ready*/
> +	fprintf(stdout, "%d\n", sock_fd);
> +
> +	/* parent program will write a byte to stdin when its ready for this
> +	 * helper to exit
> +	 */
> +	read(STDIN_FILENO, &byte, 1);
> +
> +	close(sock_fd);
> +	return 0;
> +}


