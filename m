Return-Path: <bpf+bounces-69532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C35B9976C
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 12:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10774A1631
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 10:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB862E03EB;
	Wed, 24 Sep 2025 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="NSo2ei98"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62872D8DD9;
	Wed, 24 Sep 2025 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710488; cv=none; b=R04LzK0CzMq+i7Udsk9u35ua2epsrw61qwqvFwQqFLkaPdlYIj++2sq9WsYpMQd+aSL1UCuyWLpe1FXqJPaxJjsFEvOJqjm5MD5TQghXzLQ4HEUnKN7/a/Bq3NtcXaxweR7XTEpUvGChZz3331uRVSc9/CqdZS8C4ziCiYS2wQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710488; c=relaxed/simple;
	bh=SXNkwbM4Ppq5SlqoyIdFSADrFFQzosrp23uUX1mVuoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YT6dCSOSCD4pgNgKLwjXyCEFiBlJMCKPAN4SLYlFK+v/Xs+pDtSeCYeQw5/MqtnjNHcpHSwN8AmkU+Q4euqSZBtI8u6k+S6IeF0IYiHtdrp4W5lVVMV/+FSm7rAmx2vid94SGhjVBG1OLldq1umhSfgzL+QnyvnFHTBXRf1n7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=NSo2ei98; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=t9qSVhFeLdVxOnAZTYy4HBDY+NnG6XKevYGfnTG+roQ=; b=NSo2ei98yj4Ck8wf5C+ussNO7y
	IcX5WoIzErWas3UIajQVtzITYXvVbjM+iXfGoLptg5gCLuKiRiOM/rCxwoBppnOvfQGuI/UEJrMB3
	qkDyobwOvVEkvid/HhTluHZWgyRElgxblmI8kWtkMi++JyMy0j/JtnSEx3cYrx4busBFdXgQh17Ib
	ouuPs0PgCuaOp1CBx75JjQ7p9ra1qJFDl8S3OrIoI6Hnu/pekhHgh4Wk1DO8XVQwNnD7R/lZ/8pqd
	gkemb/5WtDnoJT1CJCwvzsv5Y3EZrQwyD1ogjS2URzbV9S7YaG2733e5+gXkT/YJq0IVDiQ4AFW1y
	u73C7ZNg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1v1Mvl-000NXK-2c;
	Wed, 24 Sep 2025 12:41:01 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1v1Mvk-0004xd-27;
	Wed, 24 Sep 2025 12:41:00 +0200
Message-ID: <5d139efa-c78e-4323-b79d-bbf566ac19b8@iogearbox.net>
Date: Wed, 24 Sep 2025 12:41:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 19/20] netkit: Add xsk support for af_xdp
 applications
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 David Wei <dw@davidwei.uk>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-20-daniel@iogearbox.net> <87zfalpf8w.fsf@toke.dk>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 xsFNBGNAkI0BEADiPFmKwpD3+vG5nsOznvJgrxUPJhFE46hARXWYbCxLxpbf2nehmtgnYpAN
 2HY+OJmdspBntWzGX8lnXF6eFUYLOoQpugoJHbehn9c0Dcictj8tc28MGMzxh4aK02H99KA8
 VaRBIDhmR7NJxLWAg9PgneTFzl2lRnycv8vSzj35L+W6XT7wDKoV4KtMr3Szu3g68OBbp1TV
 HbJH8qe2rl2QKOkysTFRXgpu/haWGs1BPpzKH/ua59+lVQt3ZupePpmzBEkevJK3iwR95TYF
 06Ltpw9ArW/g3KF0kFUQkGXYXe/icyzHrH1Yxqar/hsJhYImqoGRSKs1VLA5WkRI6KebfpJ+
 RK7Jxrt02AxZkivjAdIifFvarPPu0ydxxDAmgCq5mYJ5I/+BY0DdCAaZezKQvKw+RUEvXmbL
 94IfAwTFA1RAAuZw3Rz5SNVz7p4FzD54G4pWr3mUv7l6dV7W5DnnuohG1x6qCp+/3O619R26
 1a7Zh2HlrcNZfUmUUcpaRPP7sPkBBLhJfqjUzc2oHRNpK/1mQ/+mD9CjVFNz9OAGD0xFzNUo
 yOFu/N8EQfYD9lwntxM0dl+QPjYsH81H6zw6ofq+jVKcEMI/JAgFMU0EnxrtQKH7WXxhO4hx
 3DFM7Ui90hbExlFrXELyl/ahlll8gfrXY2cevtQsoJDvQLbv7QARAQABzSZEYW5pZWwgQm9y
 a21hbm4gPGRhbmllbEBpb2dlYXJib3gubmV0PsLBkQQTAQoAOxYhBCrUdtCTcZyapV2h+93z
 cY/jfzlXBQJjQJCNAhsDBQkHhM4ACAsJCAcNDAsKBRUKCQgLAh4BAheAAAoJEN3zcY/jfzlX
 dkUQAIFayRgjML1jnwKs7kvfbRxf11VI57EAG8a0IvxDlNKDcz74mH66HMyhMhPqCPBqphB5
 ZUjN4N5I7iMYB/oWUeohbuudH4+v6ebzzmgx/EO+jWksP3gBPmBeeaPv7xOvN/pPDSe/0Ywp
 dHpl3Np2dS6uVOMnyIsvmUGyclqWpJgPoVaXrVGgyuer5RpE/a3HJWlCBvFUnk19pwDMMZ8t
 0fk9O47HmGh9Ts3O8pGibfdREcPYeGGqRKRbaXvcRO1g5n5x8cmTm0sQYr2xhB01RJqWrgcj
 ve1TxcBG/eVMmBJefgCCkSs1suriihfjjLmJDCp9XI/FpXGiVoDS54TTQiKQinqtzP0jv+TH
 1Ku+6x7EjLoLH24ISGyHRmtXJrR/1Ou22t0qhCbtcT1gKmDbTj5TcqbnNMGWhRRTxgOCYvG0
 0P2U6+wNj3HFZ7DePRNQ08bM38t8MUpQw4Z2SkM+jdqrPC4f/5S8JzodCu4x80YHfcYSt+Jj
 ipu1Ve5/ftGlrSECvy80ZTKinwxj6lC3tei1bkI8RgWZClRnr06pirlvimJ4R0IghnvifGQb
 M1HwVbht8oyUEkOtUR0i0DMjk3M2NoZ0A3tTWAlAH8Y3y2H8yzRrKOsIuiyKye9pWZQbCDu4
 ZDKELR2+8LUh+ja1RVLMvtFxfh07w9Ha46LmRhpCzsFNBGNAkI0BEADJh65bNBGNPLM7cFVS
 nYG8tqT+hIxtR4Z8HQEGseAbqNDjCpKA8wsxQIp0dpaLyvrx4TAb/vWIlLCxNu8Wv4W1JOST
 wI+PIUCbO/UFxRy3hTNlb3zzmeKpd0detH49bP/Ag6F7iHTwQQRwEOECKKaOH52tiJeNvvyJ
 pPKSKRhmUuFKMhyRVK57ryUDgowlG/SPgxK9/Jto1SHS1VfQYKhzMn4pWFu0ILEQ5x8a0RoX
 k9p9XkwmXRYcENhC1P3nW4q1xHHlCkiqvrjmWSbSVFYRHHkbeUbh6GYuCuhqLe6SEJtqJW2l
 EVhf5AOp7eguba23h82M8PC4cYFl5moLAaNcPHsdBaQZznZ6NndTtmUENPiQc2EHjHrrZI5l
 kRx9hvDcV3Xnk7ie0eAZDmDEbMLvI13AvjqoabONZxra5YcPqxV2Biv0OYp+OiqavBwmk48Z
 P63kTxLddd7qSWbAArBoOd0wxZGZ6mV8Ci/ob8tV4rLSR/UOUi+9QnkxnJor14OfYkJKxot5
 hWdJ3MYXjmcHjImBWplOyRiB81JbVf567MQlanforHd1r0ITzMHYONmRghrQvzlaMQrs0V0H
 5/sIufaiDh7rLeZSimeVyoFvwvQPx5sXhjViaHa+zHZExP9jhS/WWfFE881fNK9qqV8pi+li
 2uov8g5yD6hh+EPH6wARAQABwsF8BBgBCgAmFiEEKtR20JNxnJqlXaH73fNxj+N/OVcFAmNA
 kI0CGwwFCQeEzgAACgkQ3fNxj+N/OVfFMhAA2zXBUzMLWgTm6iHKAPfz3xEmjtwCF2Qv/TT3
 KqNUfU3/0VN2HjMABNZR+q3apm+jq76y0iWroTun8Lxo7g89/VDPLSCT0Nb7+VSuVR/nXfk8
 R+OoXQgXFRimYMqtP+LmyYM5V0VsuSsJTSnLbJTyCJVu8lvk3T9B0BywVmSFddumv3/pLZGn
 17EoKEWg4lraXjPXnV/zaaLdV5c3Olmnj8vh+14HnU5Cnw/dLS8/e8DHozkhcEftOf+puCIl
 Awo8txxtLq3H7KtA0c9kbSDpS+z/oT2S+WtRfucI+WN9XhvKmHkDV6+zNSH1FrZbP9FbLtoE
 T8qBdyk//d0GrGnOrPA3Yyka8epd/bXA0js9EuNknyNsHwaFrW4jpGAaIl62iYgb0jCtmoK/
 rCsv2dqS6Hi8w0s23IGjz51cdhdHzkFwuc8/WxI1ewacNNtfGnorXMh6N0g7E/r21pPeMDFs
 rUD9YI1Je/WifL/HbIubHCCdK8/N7rblgUrZJMG3W+7vAvZsOh/6VTZeP4wCe7Gs/cJhE2gI
 DmGcR+7rQvbFQC4zQxEjo8fNaTwjpzLM9NIp4vG9SDIqAm20MXzLBAeVkofixCsosUWUODxP
 owLbpg7pFRJGL9YyEHpS7MGPb3jSLzucMAFXgoI8rVqoq6si2sxr2l0VsNH5o3NgoAgJNIg=
In-Reply-To: <87zfalpf8w.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27772/Wed Sep 24 10:26:55 2025)

On 9/23/25 1:42 PM, Toke Høiland-Jørgensen wrote:
> Daniel Borkmann <daniel@iogearbox.net> writes:
> 
>> Enable support for AF_XDP applications to operate on a netkit device.
>> The goal is that AF_XDP applications can natively consume AF_XDP
>> from network namespaces. The use-case from Cilium side is to support
>> Kubernetes KubeVirt VMs through QEMU's AF_XDP backend. KubeVirt is a
>> virtual machine management add-on for Kubernetes which aims to provide
>> a common ground for virtualization. KubeVirt spawns the VMs inside
>> Kubernetes Pods which reside in their own network namespace just like
>> regular Pods.
>>
>> Raw QEMU AF_XDP backend example with eth0 being a physical device with
>> 16 queues where netkit is bound to the last queue (for multi-queue RSS
>> context can be used if supported by the driver):
>>
>>    # ethtool -X eth0 start 0 equal 15
>>    # ethtool -X eth0 start 15 equal 1 context new
>>    # ethtool --config-ntuple eth0 flow-type ether \
>>              src 00:00:00:00:00:00 \
>>              src-mask ff:ff:ff:ff:ff:ff \
>>              dst $mac dst-mask 00:00:00:00:00:00 \
>>              proto 0 proto-mask 0xffff action 15
>>    # ip netns add foo
>>    # ip link add numrxqueues 2 nk type netkit single
>>    # ynl-bind eth0 15 nk
>>    # ip link set nk netns foo
>>    # ip netns exec foo ip link set lo up
>>    # ip netns exec foo ip link set nk up
>>    # ip netns exec foo qemu-system-x86_64 \
>>            -kernel $kernel \
>>            -drive file=${image_name},index=0,media=disk,format=raw \
>>            -append "root=/dev/sda rw console=ttyS0" \
>>            -cpu host \
>>            -m $memory \
>>            -enable-kvm \
>>            -device virtio-net-pci,netdev=net0,mac=$mac \
>>            -netdev af-xdp,ifname=nk,id=net0,mode=native,queues=1,start-queue=1,inhibit=on,map-path=$dir/xsks_map \
>>            -nographic
> 
> So AFAICT, this example relies on the control plane installing an XDP
> program on the physical NIC which will redirect into the right socket;
> and since in this example, qemu will install the XSK socket at index 1
> in the xsk map, that XDP program will also need to be aware of the queue
> index mapping. I can see from your qemu commit[0] that there's support
> on the qemu side for specifying an offset into the map to avoid having
> to do this translation in the XDP program, but at the very least that
> makes this example incomplete, no?
> 
> However, even with a complete example, this breaks isolation in the
> sense that the entire XSK map is visible inside the pod, so a
> misbehaving qemu could interfere with traffic on other queues (by
> clearing the map, say). Which seems less than ideal?

For getting to a first starting point to connect all things with KubeVirt,
bind mounting the xsk map from Cilium into the VM launcher Pod which acts
as a regular K8s Pod while not perfect, its not a big issue given its out
of reach from the application sitting inside the VM (and some of the
control plane aspects are baked in the launcher Pod already), so the
isolation barrier is still VM. Eventually my goal is to have a xdp/xsk
redirect extension where we don't need to have the xsk map, and can just
derive the target xsk through the rxq we received traffic on.

> Taking a step back, for AF_XDP we already support decoupling the
> application-side access to the redirected packets from the interface,
> through the use of sockets. Meaning that your use case here could just
> as well be served by the control plane setting up AF_XDP socket(s) on
> the physical NIC and passing those into qemu, in which case we don't
> need this whole queue proxying dance at all.

Cilium should not act as a proxy handing out xsk sockets. Existing
applications expect a netdev from kernel side and should not need to
rewrite just to implement one CNI's protocol. Also, all the memory
should not be accounted against Cilium but rather the application Pod
itself which is consuming af_xdp. Further, on up/downgrades we expect
the data plane to being completely decoupled from the control plane,
if Cilium would own the sockets that would be disruptive which is nogo.

> So, erm, what am I missing that makes this worth it (for AF_XDP; I can
> see how it is useful for other things)? :)
Yeap there are other use cases we've seen from Cilium users as well,
e.g. running dpdk applications on top of af_xdp in regular k8s Pods.

