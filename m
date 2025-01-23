Return-Path: <bpf+bounces-49578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DDCA1A7CE
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 17:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7FA1889566
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD75212D6E;
	Thu, 23 Jan 2025 16:24:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705F51C5D4D
	for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737649444; cv=none; b=YEsaEADBa07O1xX75sb8+doINcSTT6VpyvRQQuXjFX6eLmGpwIOREw7QPvl2SmNgp6AvR7563sKpnvLQCS0jOYedjcQOAG9VHE7eYyz+HYXFUrZqfkYGxeWK3k3PufaF6c2q+Iav4EmbKsbyanEsvDs1y9egS50QFVJSZcpx0yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737649444; c=relaxed/simple;
	bh=UmKaijHwJDO0AKXaqq1BZSfBtmzjB5zSUjBPv/pLVAo=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=BIv4lDRXpxMSVsWQUK6okXJciFHYGS16ZqdWpE9tYrA3cyTd0t+zmeWvnIOOa+YgbjhJvC9Q/Kzq7JLDGn7yHT7Nj8UMd4mtvRUE/Gg6YO4eqi4xuMM0ZBDPgJRPaH4GfAodn5LomDGObUujzWTtf9Zn0EmylxKZLnapiDK1Pf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tazfT-0004Em-FP; Thu, 23 Jan 2025 17:02:55 +0100
Received: from [2a0d:3344:1523:1f10:f118:b2d4:edbb:54af]
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tazfT-000PE6-0p;
	Thu, 23 Jan 2025 17:02:55 +0100
Message-ID: <dae862ec-43b5-41a0-8edf-46c59071cdda@hetzner-cloud.de>
Date: Thu, 23 Jan 2025 17:02:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Autocrypt: addr=marcus.wichelmann@hetzner-cloud.de; keydata=
 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
 wySmewx3h/yfMh0aFxHhvLPxrO2IEQ==
To: bpf@vger.kernel.org
Cc: Stanislav Fomichev <sdf@google.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: RX metadata kfuncs cause kernel panic with XDP generic mode
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27527/Thu Jan 23 10:44:17 2025)

Hey there,

while taking a closer look at how the RX metadata kfuncs are implemented in the mlx5 and ice drivers,
I suspected a bug and, after testing, could in fact produce a NULL pointer dereference.

The mlx5 driver implements the RX metadata kfuncs like, for example, bpf_xdp_metadata_rx_vlan_tag by
casting the xdp_md pointer from the function argument to an mlx5e_xdp_buff pointer. This is needed to
get access to the packet metadata. See mlx5e_xdp_rx_vlan_tag for example. The ice driver works similarly.

This is fine, because normally these drivers always create a full mlx5e_xdp_buff struct when allocating
the xdp_buff struct. But when a device-bound XDP program is attached to the mlx5 netdevice in generic mode,
the xdp_buff is not allocated by the mlx5 driver but as a part of the do_xdp_generic implementation.

Now, when a packet comes in and the XDP program tries to call one of these kfuncs, the kfunc implementation
will try to dereference pointers inside the mlx5e_xdp_buff struct which is not fully allocated, leading to a
NULL pointer dereference.

There is probably a check missing somewhere that prevents the use of these kfuncs in the scope of
do_xdp_generic? Or may there be another way to implement the RX metadata kfuncs in the driver that does not
involve casting the xdp_buff pointer?

Here is how this can be reproduced:


eBPF program:

#include <bpf.h>

extern int bpf_xdp_metadata_rx_vlan_tag(
     const struct xdp_md *ctx, __be16 *vlan_proto, __u16 *vlan_tci) __ksym;

SEC("xdp")
int ingress(struct xdp_md *ctx) {
   __be16 vlan_proto;
   __u16 vlan_tci;
   if (bpf_xdp_metadata_rx_vlan_tag(ctx, &vlan_proto, &vlan_tci) != 0) {
     return XDP_ABORTED;
   }

   return XDP_DROP;
}

char _license[] SEC("license") = "GPL";


Load and attach it as a device-bound program to a mlx5 NIC in XDP-generic mode:

# bpftool prog load crash.o /sys/fs/bpf/crash xdpmeta_dev mlx5-conx5-1
# bpftool net attach xdpgeneric pinned /sys/fs/bpf/crash dev mlx5-conx5-1

Then make sure a packet is coming in on that NIC port so the XDP program gets called:

# ping -I mlx5-conx5-2 1.1.1.1

In my testing environment, mlx5-conx5-2 and mlx5-conx5-1 are directly connected.

Kernel output:

Unable to handle kernel NULL pointer dereference at virtual address 000000000000001d
Mem abort info:
   ESR = 0x0000000096000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x04: level 0 translation fault
Data abort info:
   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000008035e557000
[000000000000001d] pgd=0000000000000000, p4d=0000000000000000

This was reproduced with Linux 6.12 mainline (adc2186).

-- 
Best regards,
Marcus Wichelmann
Linux Networking Specialist
Team SDN

______________________________

Hetzner Cloud GmbH
Feringastraße 12A
85774 Unterföhring
Germany

Phone: +49 89 381690 150
E-Mail: marcus.wichelmann@hetzner-cloud.de

Handelsregister München HRB 226782
Geschäftsführer: Sebastian Färber, Markus Kalmuk

------------------
For information on the processing of your personal
data in the context of this contact, please see
https://hetzner-cloud.de/datenschutz
------------------


