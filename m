Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D991A3787
	for <lists+bpf@lfdr.de>; Thu,  9 Apr 2020 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgDIPw0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Apr 2020 11:52:26 -0400
Received: from chi01-209.mxroute.com ([45.152.178.209]:33433 "EHLO
        chi01-209.mxroute.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbgDIPwZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Apr 2020 11:52:25 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Apr 2020 11:52:23 EDT
Received: from filter004.mxroute.com ([149.28.56.236] 149.28.56.236.vultr.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by chi01-209.mxroute.com (ZoneMTA) with ESMTPSA id 1715f9fc0eb0001c89.001
 for <bpf@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Thu, 09 Apr 2020 15:47:17 +0000
X-Zone-Loop: 377b15de067944803233ca0397149d1b53c381c558ee
X-Originating-IP: [149.28.56.236]
Received: from ocean.mxroute.com (ocean.mxroute.com [195.201.59.214])
        by filter004.mxroute.com (Postfix) with ESMTPS id F3B113EDA5
        for <bpf@vger.kernel.org>; Thu,  9 Apr 2020 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gflclan.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HOHJoeZiNyQK3cssVJ/p6h9Ldq7qrvKC5bwX03h2Lgo=; b=dtVsqqHnU14i3anN57xI9fgvVv
        EYVZ7h+wt+fCAToxqUZMLKqvFIl4twkVeV4cfhip6O3F6dEe7+BMw4m6XvLsp3KrKB+A3Edm2clXW
        DnnHtl6g+5zPOuhFxzGcnRmKRV0B4oH2NDFS+BjQm3TSRVZFHZTIBn2I+2pr+CAEcKssCLxy2aPUV
        D1JFc2dT3y92Xi407ibPP43nBlQX7TvO/+3WsBNIoxnoXc6X/Z+ffB45T9aFpv0abC0dxwmVuOvL6
        Flv54+aYi03yPUFEl3bs4abSkpOHeGcYMDyaDSwbSlMaFZUcqzdZANvZ6Jr4m5LcKhl3r0LuL2ejO
        MIEPYzoQ==;
Subject: Re: [EXT] Re: TC BPF Program Crashing With Bnx2x Drivers
To:     Ariel Elior <aelior@marvell.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     Sudarsana Reddy Kalluru <skalluru@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Vitaly Mireyno <vmireyno@marvell.com>
References: <853f67f9-6713-a354-07f7-513d654ede91@gflclan.com>
 <c3c44050-132e-44f7-1611-95d30b0b4b47@iogearbox.net>
 <0a96d4ee-e875-e89c-e6bb-e6b62061abdd@gflclan.com>
 <54d3af61-8f00-6f65-23a4-0f1d5a9aba8e@iogearbox.net>
 <DM5PR18MB1484D3C1E98E68F2A7775550C4C10@DM5PR18MB1484.namprd18.prod.outlook.com>
From:   Christian Deacon <gamemann@gflclan.com>
Message-ID: <ec81c40f-64c7-f5cb-6b1e-d3ea6e465613@gflclan.com>
Date:   Thu, 9 Apr 2020 10:47:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <DM5PR18MB1484D3C1E98E68F2A7775550C4C10@DM5PR18MB1484.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-OutGoing-Spam-Status: No, score=-10.0
X-AuthUser: gamemann@gflclan.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey Daniel and Ariel,

Thank you for your responses!

Here's the output from `ethtool -k eth0`:

```
Features for eth0:
rx-checksumming: on
tx-checksumming: on
         tx-checksum-ipv4: on
         tx-checksum-ip-generic: off [fixed]
         tx-checksum-ipv6: on
         tx-checksum-fcoe-crc: off [fixed]
         tx-checksum-sctp: off [fixed]
scatter-gather: on
         tx-scatter-gather: on
         tx-scatter-gather-fraglist: off [fixed]
tcp-segmentation-offload: off
         tx-tcp-segmentation: off
         tx-tcp-ecn-segmentation: off
         tx-tcp-mangleid-segmentation: off
         tx-tcp6-segmentation: off
udp-fragmentation-offload: off
generic-segmentation-offload: on
generic-receive-offload: on
large-receive-offload: off
rx-vlan-offload: on [fixed]
tx-vlan-offload: on
ntuple-filters: off [fixed]
receive-hashing: on
highdma: on [fixed]
rx-vlan-filter: on
vlan-challenged: off [fixed]
tx-lockless: off [fixed]
netns-local: off [fixed]
tx-gso-robust: off [fixed]
tx-fcoe-segmentation: off [fixed]
tx-gre-segmentation: on
tx-gre-csum-segmentation: on
tx-ipxip4-segmentation: on
tx-ipxip6-segmentation: off [fixed]
tx-udp_tnl-segmentation: on
tx-udp_tnl-csum-segmentation: on
tx-gso-partial: on
tx-sctp-segmentation: off [fixed]
tx-esp-segmentation: off [fixed]
tx-udp-segmentation: off [fixed]
fcoe-mtu: off [fixed]
tx-nocache-copy: off
loopback: off
rx-fcs: off [fixed]
rx-all: off [fixed]
tx-vlan-stag-hw-insert: off [fixed]
rx-vlan-stag-hw-parse: off [fixed]
rx-vlan-stag-filter: off [fixed]
l2-fwd-offload: off [fixed]
hw-tc-offload: off [fixed]
esp-hw-offload: off [fixed]
esp-tx-csum-hw-offload: off [fixed]
rx-udp_tunnel-port-offload: on
tls-hw-tx-offload: off [fixed]
tls-hw-rx-offload: off [fixed]
rx-gro-hw: off
tls-hw-record: off [fixed]
rx-gro-list: off
```

It looks like TX GSO (partial) is enabled. I will ask the individual who 
ran into this issue to see if they want to debug this issue further on 
their machine. The problem is their machine is used in production at the 
moment. Unfortunately, I don't have any test machines with these 
specific network drivers.

Thank you!


On 4/9/2020 6:34 AM, Ariel Elior wrote:
>> -----Original Message-----
>> From: Daniel Borkmann <daniel@iogearbox.net>
>> Sent: Thursday, April 9, 2020 2:58 AM
>> To: Christian Deacon <gamemann@gflclan.com>; bpf@vger.kernel.org
>> Cc: Ariel Elior <aelior@marvell.com>; Sudarsana Reddy Kalluru
>> <skalluru@marvell.com>
>> Subject: [EXT] Re: TC BPF Program Crashing With Bnx2x Drivers
>>
>> External Email
>>
>> ----------------------------------------------------------------------
>> On 4/9/20 1:30 AM, Christian Deacon wrote:
>>> Hey Daniel,
>>>
>>>
>>> Thank you for your response and I'm glad I'm in the correct area!
>>>
>>>
>>> When the individual ran:
>>>
>>>
>>> ```
>>>
>>> ethtool -K eth0 tso off
>>>
>>> ```
>>>
>>>
>>> The program started operating without crashing. It has been around 20
>> minutes so far and no crash. Therefore, I'd assume that stopped the crashing
>> considering it usually crashed 20 - 30 seconds after starting the program each
>> time beforehand. I'm not entirely sure what TSO does with this network driver,
>> but I'll try doing some research.
>>
>> Yep, don't think it should crash anymore after you turned it off and it survived
>> since then. ;)
>> I presume GSO is still on in your case, right (check via `ethtool -k eth0`)?
>>
>>> I was suspecting it may be the 'bpf_skb_adjust_room()' function as well since
>> I'm using a mode that was implemented in later kernels. This function removes
>> the outer IP header in my program from the outgoing IPIP packet. I'm not sure
>> what would be causing the crashing, though.
>>
>> Probably bnx2x folks might be able to help but as mentioned looks like the tso
>> handling in there
>> has an issue with the ipip which leads to the nic hang eventually.
>>
> Hi,
> Thanks for reporting this.
> I would expect the ipip is indeed the root of the problem.
> If you can provide us with the output of ethtool -d after this problem
> happens we may be able to better understand the issue, and perhaps
> offer a resolution.
>
> A description of how the SKB might look like in this case can also help
> point us in the right direction.
>
> Thanks,
> Ariel
>
>>> Thank you again for all the help!
>>>
>>>
>>> On 4/8/2020 5:58 PM, Daniel Borkmann wrote:
>>>> [ +Cc bnx2x maintainers who might help to make sense for the
>> bnx2x_panic_dump ]
>>>> On 4/8/20 7:15 PM, Christian Deacon wrote:
>>>>> Hey everyone,
>>>>>
>>>>>
>>>>> I apologize if this is the wrong mailing list. I wasn't able to find any mailing
>> list for TC BPF specifically. If it is the wrong mailing list, any guidance to the
>> correct mailing list would be appreciated.
>>>> BPF list is totally fine, thanks for bringing it up here.
>>>>
>>>>> I made a TC BPF program which has source code available on GitHub here:
>>>>>
>>>>>
>>>>> https://urldefense.proofpoint.com/v2/url?u=https-
>> 3A__github.com_gamemann_IPIPDirect-
>> 2DTC&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=cWBgNIFUifZRx2xhypdcaY
>> rfIsMGt93NxP1r8GQtC0s&m=aHiupgqaqlOKEppMZdqaGUEB4t_e1S3B_xTDt0pX
>> BN0&s=PMLEYiQ4jWRofwazJ6L_xzEyztbYfeniy0S3J3HjQsA&e=
>>>>>
>>>>> I installed this program on several machines of mine running Ubuntu 18.04
>> and Debian 10. I've used kernels from 5.4 to 5.6.2. The network drivers used on
>> these machines include Virtio, e1000e, and e1000. Things have been running
>> stable for 3 - 4 days now without any issues.
>>>>>
>>>>> Another individual is trying to get this to work on their machine with
>> Debian 10 and they've tried a backport kernel of 5.4.0 along with a manually
>> built 5.6.2 kernel. I've built the 5.6.2 kernel for them, tested it on my machine,
>> and everything worked fine. The only difference is this machine is using bnx2x
>> network drivers. Here is the output from `lshw -class network`:
>>>>>
>>>>> ```
>>>>>
>>>>> *-network:0
>>>>>      description: Ethernet interface
>>>>>      product: NetXtreme II BCM57810 10 Gigabit Ethernet
>>>>>      vendor: Broadcom Limited
>>>>>      physical id: 0
>>>>>      bus info: pci@0000:04:00.0
>>>>>      logical name: eth0
>>>>>      version: 11
>>>>>      serial:  xx:xx:xx:xx:xx:xx
>>>>>      size: 10Gbit/s
>>>>>      width: 64 bits
>>>>>      clock: 33MHz
>>>>>      capabilities: pm vpd msix pciexpress bus_master cap_list rom ethernet
>> physical fibre autonegotiation
>>>>>      configuration: autonegotiation=on broadcast=yes driver=bnx2x
>> driverversion=1.713.36-0 storm 7.13.11.0 duplex=full firmware=mbi 7.14.79 bc
>> 7.13.75 ip=xxx.xxx.xxx.xxx latency=0 link=yes multicast=yes port=fibre
>> speed=10Gbit/s
>>>>>      resources: irq:117 memory:f6000000-f67fffff memory:f5800000-f5ffffff
>> memory:f57f0000-f57fffff memory:f1000000-f107ffff
>>>>> *-network:1 DISABLED
>>>>>      description: Ethernet interface
>>>>>      product: NetXtreme II BCM57810 10 Gigabit Ethernet
>>>>>      vendor: Broadcom Limited
>>>>>      physical id: 0.1
>>>>>      bus info: pci@0000:04:00.1
>>>>>      logical name: eth1
>>>>>      version: 11
>>>>>      serial: xx:xx:xx:xx:xx:xx
>>>>>      width: 64 bits
>>>>>      clock: 33MHz
>>>>>      capabilities: pm vpd msix pciexpress bus_master cap_list rom ethernet
>> physical fibre autonegotiation
>>>>>      configuration: autonegotiation=on broadcast=yes driver=bnx2x
>> driverversion=1.713.36-0 storm 7.13.11.0 firmware=mbi 7.14.79 bc 7.13.75
>> latency=0 link=no multicast=yes port=fibre
>>>>>      resources: irq:128 memory:f4800000-f4ffffff memory:f4000000-f47fffff
>> memory:f3ff0000-f3ffffff memory:f1080000-f10fffff
>>>>> ```
>>>>>
>>>>>
>>>>> When the program is loaded on their machine, it is working properly for 20
>> - 30 seconds. However, it eventually crashes the network driver and network
>> access to the machine is completely lost. I found the following in the `kern.log`
>> file (it is very long, I apologize):
>>>>>
>>>>> ```
>>>>>
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.253584] bnx2x:
>> [bnx2x_stats_update:1232(eth0)]storm stats were not updated for 3 times
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.253698] bnx2x:
>> [bnx2x_stats_update:1233(eth0)]driver assert
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.253768] bnx2x:
>> [bnx2x_panic_dump:917(eth0)]begin crash dump -----------------
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.253854] bnx2x:
>> [bnx2x_panic_dump:927(eth0)]def_idx(0x46f)  def_att_idx(0x8)
>> attn_state(0x0)  spq_prod_idx(0x88) next_stats_cnt(0x457)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.253994] bnx2x:
>> [bnx2x_panic_dump:932(eth0)]DSB: attn bits(0x0)  ack(0x10) id(0x0) idx(0x8)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.254094] bnx2x:
>> [bnx2x_panic_dump:933(eth0)]     def (0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x473 0x0
>> 0x0 0x0 0x0 0x0 0x0 0x0 0x0)  igu_sb_id(0x0) igu_seg_id(0x1)
>> pf_id(0x0)  vnic_id(0x0)  vf_id(0xff)  vf_valid (0x0) state(0x1)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.254323] bnx2x:
>> [bnx2x_panic_dump:984(eth0)]fp0: rx_bd_prod(0x102b) rx_bd_cons(0xe64)
>> rx_comp_prod(0x1677)  rx_comp_cons(0x14ab) *rx_cons_sb(0x14ac)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.254476] bnx2x:
>> [bnx2x_panic_dump:987(eth0)]     rx_sge_prod(0x0) last_max_sge(0x0)
>> fp_hc_idx(0x8d48)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.254580] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp0: tx_pkt_prod(0x8756)
>> tx_pkt_cons(0x8735)  tx_bd_prod(0xc86f)  tx_bd_cons(0xc82b)
>> *tx_cons_sb(0x8735)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.254735] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp0: tx_pkt_prod(0x0) tx_pkt_cons(0x0)
>> tx_bd_prod(0x0)  tx_bd_cons(0x0) *tx_cons_sb(0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.254874] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp0: tx_pkt_prod(0x0) tx_pkt_cons(0x0)
>> tx_bd_prod(0x0)  tx_bd_cons(0x0) *tx_cons_sb(0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.255015] bnx2x:
>> [bnx2x_panic_dump:1015(eth0)]     run indexes (0x8d48 0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.255019] bnx2x:
>> [bnx2x_panic_dump:1021(eth0)]     indexes (0x0 0x14ac 0x0 0x0 0x0 0x8735
>> 0x0 0x0)pf_id(0x0)  vf_id(0xff)  vf_valid(0x0) vnic_id(0x0) same_igu_sb_1b(0x1)
>> state(0x1)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.255285] SM[0] __flags (0x0)
>> igu_sb_id (0x2)  igu_seg_id(0x0) time_to_expire (0x43ddd960)
>> timer_value(0xff)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.255288] SM[1] __flags (0x0)
>> igu_sb_id (0x2)  igu_seg_id(0x0) time_to_expire (0x43aa48a0)
>> timer_value(0xff)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.255290] INDEX[0] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.255291] INDEX[1] flags
>> (0x2) timeout (0x6)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.255293] INDEX[2] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.255295] INDEX[3] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.255296] INDEX[4] flags
>> (0x1) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.255298] INDEX[5] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.255300] INDEX[6] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.255302] INDEX[7] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.255308] bnx2x:
>> [bnx2x_panic_dump:984(eth0)]fp1: rx_bd_prod(0x1267) rx_bd_cons(0xa0)
>> rx_comp_prod(0x18ba)  rx_comp_cons(0x16ee) *rx_cons_sb(0x16ee)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.255461] bnx2x:
>> [bnx2x_panic_dump:987(eth0)]     rx_sge_prod(0x0) last_max_sge(0x0)
>> fp_hc_idx(0xf62)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.255566] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp1: tx_pkt_prod(0x952) tx_pkt_cons(0x946)
>> tx_bd_prod(0x4d0c)  tx_bd_cons(0x4cf2) *tx_cons_sb(0x946)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.255726] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp1: tx_pkt_prod(0x0) tx_pkt_cons(0x0)
>> tx_bd_prod(0x0)  tx_bd_cons(0x0) *tx_cons_sb(0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.255863] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp1: tx_pkt_prod(0x0) tx_pkt_cons(0x0)
>> tx_bd_prod(0x0)  tx_bd_cons(0x0) *tx_cons_sb(0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256002] bnx2x:
>> [bnx2x_panic_dump:1015(eth0)]     run indexes (0xf62 0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256006] bnx2x:
>> [bnx2x_panic_dump:1021(eth0)]     indexes (0x0 0x16ee 0x0 0x0 0x0 0x946 0x0
>> 0x0)pf_id(0x0)  vf_id(0xff)  vf_valid(0x0) vnic_id(0x0) same_igu_sb_1b(0x1)
>> state(0x1)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256276] SM[0] __flags (0x0)
>> igu_sb_id (0x3)  igu_seg_id(0x0) time_to_expire (0x43ddd31b)
>> timer_value(0xff)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256279] SM[1] __flags (0x0)
>> igu_sb_id (0x3)  igu_seg_id(0x0) time_to_expire (0x43aa5b45)
>> timer_value(0xff)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256280] INDEX[0] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256282] INDEX[1] flags
>> (0x2) timeout (0x6)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256284] INDEX[2] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256285] INDEX[3] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256287] INDEX[4] flags
>> (0x1) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256288] INDEX[5] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256290] INDEX[6] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256291] INDEX[7] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256296] bnx2x:
>> [bnx2x_panic_dump:984(eth0)]fp2: rx_bd_prod(0xc0b) rx_bd_cons(0xa44)
>> rx_comp_prod(0x124b)  rx_comp_cons(0x107e) *rx_cons_sb(0x107e)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256446] bnx2x:
>> [bnx2x_panic_dump:987(eth0)]     rx_sge_prod(0x0) last_max_sge(0x0)
>> fp_hc_idx(0x1b0b)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256554] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp2: tx_pkt_prod(0x19f8)
>> tx_pkt_cons(0x19ef)  tx_bd_prod(0xc3cc)  tx_bd_cons(0xc3b9)
>> *tx_cons_sb(0x19ef)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256709] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp2: tx_pkt_prod(0x0) tx_pkt_cons(0x0)
>> tx_bd_prod(0x0)  tx_bd_cons(0x0) *tx_cons_sb(0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256842] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp2: tx_pkt_prod(0x0) tx_pkt_cons(0x0)
>> tx_bd_prod(0x0)  tx_bd_cons(0x0) *tx_cons_sb(0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256979] bnx2x:
>> [bnx2x_panic_dump:1015(eth0)]     run indexes (0x1b0b 0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.256982] bnx2x:
>> [bnx2x_panic_dump:1021(eth0)]     indexes (0x0 0x107e 0x0 0x0 0x0 0x19ef 0x0
>> 0x0)pf_id(0x0)  vf_id(0xff)  vf_valid(0x0) vnic_id(0x0) same_igu_sb_1b(0x1)
>> state(0x1)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.257263] SM[0] __flags (0x0)
>> igu_sb_id (0x4)  igu_seg_id(0x0) time_to_expire (0x43dddc4c)
>> timer_value(0xff)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.257265] SM[1] __flags (0x0)
>> igu_sb_id (0x4)  igu_seg_id(0x0) time_to_expire (0x43aa538f)
>> timer_value(0xff)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.257267] INDEX[0] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.257269] INDEX[1] flags
>> (0x2) timeout (0x6)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.257271] INDEX[2] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.257272] INDEX[3] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.257274] INDEX[4] flags
>> (0x1) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.257275] INDEX[5] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.257277] INDEX[6] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.257278] INDEX[7] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.257283] bnx2x:
>> [bnx2x_panic_dump:984(eth0)]fp3: rx_bd_prod(0x4c7c) rx_bd_cons(0xab5)
>> rx_comp_prod(0x5074)  rx_comp_cons(0x4ea8) *rx_cons_sb(0x4ea8)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.266351] bnx2x:
>> [bnx2x_panic_dump:987(eth0)]     rx_sge_prod(0x0) last_max_sge(0x0)
>> fp_hc_idx(0xd3ec)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.270245] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp3: tx_pkt_prod(0x93b8)
>> tx_pkt_cons(0x93a3)  tx_bd_prod(0x268b)  tx_bd_cons(0x265b)
>> *tx_cons_sb(0x93a3)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.277423] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp3: tx_pkt_prod(0x0) tx_pkt_cons(0x0)
>> tx_bd_prod(0x0)  tx_bd_cons(0x0) *tx_cons_sb(0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.282796] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp3: tx_pkt_prod(0x0) tx_pkt_cons(0x0)
>> tx_bd_prod(0x0)  tx_bd_cons(0x0) *tx_cons_sb(0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.291180] bnx2x:
>> [bnx2x_panic_dump:1015(eth0)]     run indexes (0xd3ee 0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.291184] bnx2x:
>> [bnx2x_panic_dump:1021(eth0)]     indexes (0x0 0x4eaf 0x0 0x0 0x0 0x93a3 0x0
>> 0x0)pf_id(0x0)  vf_id(0xff)  vf_valid(0x0) vnic_id(0x0) same_igu_sb_1b(0x1)
>> state(0x1)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.300220] SM[0] __flags (0x0)
>> igu_sb_id (0x5)  igu_seg_id(0x0) time_to_expire (0x43de684c)
>> timer_value(0xff)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.300227] SM[1] __flags (0x0)
>> igu_sb_id (0x5)  igu_seg_id(0x0) time_to_expire (0x43aa5299)
>> timer_value(0xff)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.300229] INDEX[0] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.300231] INDEX[1] flags
>> (0x2) timeout (0x6)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.300232] INDEX[2] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.300233] INDEX[3] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.300235] INDEX[4] flags
>> (0x1) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.300236] INDEX[5] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.300238] INDEX[6] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.300239] INDEX[7] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.300245] bnx2x:
>> [bnx2x_panic_dump:984(eth0)]fp4: rx_bd_prod(0xb458) rx_bd_cons(0x291)
>> rx_comp_prod(0xb98d)  rx_comp_cons(0xb7c1) *rx_cons_sb(0xb7c1)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.308272] bnx2x:
>> [bnx2x_panic_dump:987(eth0)]     rx_sge_prod(0x0) last_max_sge(0x0)
>> fp_hc_idx(0x6dfb)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.311107] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp4: tx_pkt_prod(0xc32a)
>> tx_pkt_cons(0xc317)  tx_bd_prod(0x5727)  tx_bd_cons(0x56ff)
>> *tx_cons_sb(0xc317)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.318786] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp4: tx_pkt_prod(0x0) tx_pkt_cons(0x0)
>> tx_bd_prod(0x0)  tx_bd_cons(0x0) *tx_cons_sb(0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.327491] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp4: tx_pkt_prod(0x0) tx_pkt_cons(0x0)
>> tx_bd_prod(0x0)  tx_bd_cons(0x0) *tx_cons_sb(0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.336062] bnx2x:
>> [bnx2x_panic_dump:1015(eth0)]     run indexes (0x6e02 0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.336066] bnx2x:
>> [bnx2x_panic_dump:1021(eth0)]     indexes (0x0 0xb7c9 0x0 0x0 0x0 0xc317
>> 0x0 0x0)pf_id(0x0)  vf_id(0xff)  vf_valid(0x0) vnic_id(0x0) same_igu_sb_1b(0x1)
>> state(0x1)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.345048] SM[0] __flags (0x0)
>> igu_sb_id (0x6)  igu_seg_id(0x0) time_to_expire (0x43df1a5a)
>> timer_value(0xff)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.345052] SM[1] __flags (0x0)
>> igu_sb_id (0x6)  igu_seg_id(0x0) time_to_expire (0x43aa4993)
>> timer_value(0xff)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.345054] INDEX[0] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.345055] INDEX[1] flags
>> (0x2) timeout (0x6)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.345057] INDEX[2] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.345059] INDEX[3] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.345061] INDEX[4] flags
>> (0x1) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.345062] INDEX[5] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.345064] INDEX[6] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.345066] INDEX[7] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.345071] bnx2x:
>> [bnx2x_panic_dump:984(eth0)]fp5: rx_bd_prod(0x4bfb) rx_bd_cons(0xa36)
>> rx_comp_prod(0x4ff3)  rx_comp_cons(0x4e27) *rx_cons_sb(0x4e27)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.352421] bnx2x:
>> [bnx2x_panic_dump:987(eth0)]     rx_sge_prod(0x0) last_max_sge(0x0)
>> fp_hc_idx(0x2a26)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.355184] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp5: tx_pkt_prod(0xe5da)
>> tx_pkt_cons(0xe5c8)  tx_bd_prod(0x1041)  tx_bd_cons(0x1019)
>> *tx_cons_sb(0xe5c8)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.362160] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp5: tx_pkt_prod(0x0) tx_pkt_cons(0x0)
>> tx_bd_prod(0x0)  tx_bd_cons(0x0) *tx_cons_sb(0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.371350] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp5: tx_pkt_prod(0x0) tx_pkt_cons(0x0)
>> tx_bd_prod(0x0)  tx_bd_cons(0x0) *tx_cons_sb(0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.379219] bnx2x:
>> [bnx2x_panic_dump:1015(eth0)]     run indexes (0x2a2b 0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.379223] bnx2x:
>> [bnx2x_panic_dump:1021(eth0)]     indexes (0x0 0x4e2d 0x0 0x0 0x0 0xe5c8
>> 0x0 0x0)pf_id(0x0)  vf_id(0xff)  vf_valid(0x0) vnic_id(0x0) same_igu_sb_1b(0x1)
>> state(0x1)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.387666] SM[0] __flags (0x0)
>> igu_sb_id (0x7)  igu_seg_id(0x0) time_to_expire (0x43dfc253)
>> timer_value(0xff)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.387668] SM[1] __flags (0x0)
>> igu_sb_id (0x7)  igu_seg_id(0x0) time_to_expire (0x43aa4ff2) timer_value(0xff)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.387669] INDEX[0] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.387670] INDEX[1] flags
>> (0x2) timeout (0x6)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.387671] INDEX[2] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.387673] INDEX[3] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.387674] INDEX[4] flags
>> (0x1) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.387675] INDEX[5] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.387676] INDEX[6] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.387677] INDEX[7] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.387681] bnx2x:
>> [bnx2x_panic_dump:984(eth0)]fp6: rx_bd_prod(0x1e90) rx_bd_cons(0xcc9)
>> rx_comp_prod(0x2e2d)  rx_comp_cons(0x2c61) *rx_cons_sb(0x2c61)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.396441] bnx2x:
>> [bnx2x_panic_dump:987(eth0)]     rx_sge_prod(0x0) last_max_sge(0x0)
>> fp_hc_idx(0xb60)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.399248] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp6: tx_pkt_prod(0xf788)
>> tx_pkt_cons(0xf770)  tx_bd_prod(0x2535)  tx_bd_cons(0x2504)
>> *tx_cons_sb(0xf770)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.405697] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp6: tx_pkt_prod(0x0) tx_pkt_cons(0x0)
>> tx_bd_prod(0x0)  tx_bd_cons(0x0) *tx_cons_sb(0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.414921] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp6: tx_pkt_prod(0x0) tx_pkt_cons(0x0)
>> tx_bd_prod(0x0)  tx_bd_cons(0x0) *tx_cons_sb(0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.422686] bnx2x:
>> [bnx2x_panic_dump:1015(eth0)]     run indexes (0xb73 0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.422690] bnx2x:
>> [bnx2x_panic_dump:1021(eth0)]     indexes (0x0 0x2c81 0x0 0x0 0x0 0xf770 0x0
>> 0x0)pf_id(0x0)  vf_id(0xff)  vf_valid(0x0) vnic_id(0x0) same_igu_sb_1b(0x1)
>> state(0x1)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.431523] SM[0] __flags (0x0)
>> igu_sb_id (0x8)  igu_seg_id(0x0) time_to_expire (0x43e075b8)
>> timer_value(0xff)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.431525] SM[1] __flags (0x0)
>> igu_sb_id (0x8)  igu_seg_id(0x0) time_to_expire (0x43aa4229)
>> timer_value(0xff)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.431527] INDEX[0] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.431528] INDEX[1] flags
>> (0x2) timeout (0x6)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.431529] INDEX[2] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.431530] INDEX[3] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.431531] INDEX[4] flags
>> (0x1) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.431532] INDEX[5] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.431533] INDEX[6] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.431534] INDEX[7] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.431539] bnx2x:
>> [bnx2x_panic_dump:984(eth0)]fp7: rx_bd_prod(0x6f3d) rx_bd_cons(0xd76)
>> rx_comp_prod(0x7094)  rx_comp_cons(0x6ec8) *rx_cons_sb(0x6ec8)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.439505] bnx2x:
>> [bnx2x_panic_dump:987(eth0)]     rx_sge_prod(0x0) last_max_sge(0x0)
>> fp_hc_idx(0x685f)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.443056] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp7: tx_pkt_prod(0xc7) tx_pkt_cons(0xb7)
>> tx_bd_prod(0x1412)  tx_bd_cons(0x13f0) *tx_cons_sb(0xb7)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.448817] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp7: tx_pkt_prod(0x0) tx_pkt_cons(0x0)
>> tx_bd_prod(0x0)  tx_bd_cons(0x0) *tx_cons_sb(0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.455960] bnx2x:
>> [bnx2x_panic_dump:1004(eth0)]fp7: tx_pkt_prod(0x0) tx_pkt_cons(0x0)
>> tx_bd_prod(0x0)  tx_bd_cons(0x0) *tx_cons_sb(0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.458546] bnx2x:
>> [bnx2x_panic_dump:1015(eth0)]     run indexes (0x6860 0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.458548] bnx2x:
>> [bnx2x_panic_dump:1021(eth0)]     indexes (0x0 0x6eca 0x0 0x0 0x0 0xb7 0x0
>> 0x0)pf_id(0x0)  vf_id(0xff)  vf_valid(0x0) vnic_id(0x0) same_igu_sb_1b(0x1)
>> state(0x1)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.462410] SM[0] __flags (0x0)
>> igu_sb_id (0x9)  igu_seg_id(0x0) time_to_expire (0x43e0f737)
>> timer_value(0xff)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.462413] SM[1] __flags (0x0)
>> igu_sb_id (0x9)  igu_seg_id(0x0) time_to_expire (0x43aa51f7)
>> timer_value(0xff)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.462413] INDEX[0] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.462414] INDEX[1] flags
>> (0x2) timeout (0x6)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.462414] INDEX[2] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.462415] INDEX[3] flags
>> (0x0) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.462415] INDEX[4] flags
>> (0x1) timeout (0x0)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.462416] INDEX[5] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.462416] INDEX[6] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.462417] INDEX[7] flags
>> (0x3) timeout (0xc)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.462422] bnx2x 0000:04:00.0
>> eth0: bc 7.13.75
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.464103] begin fw dump
>> (mark 0x3c6748)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] 0x0
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] En Vaux
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] M lic key
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] [0.0]lldp strt dis
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] [1.0]lldp strt dis
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] pf_num 0: d89d
>> 67723b38
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] WC loaded OK
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] link_init[0.0]:NO-
>> LFA(1)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] init_phy[0.0]: done
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] link_init[1.0]:NO-
>> LFA(1)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] init_phy[1.0]: done
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] evnt[0.0] 0x0-
>>> 0x1000
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] evnt[0.0] 0x1000-
>>> 0x0
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] link_update[0.0]:
>> (rc 0) link 1 speed 0x2710
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] clp exit
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] p0: DCC OV 0x7d1
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] p0: DCC OV 0x7d1
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] [0:0] Resetting link
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] link_init[0.0]:NO-
>> LFA(1)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] init_phy[0.0]: done
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] [1:0] Resetting link
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] clp exit
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] p0: DCC OV 0x7d1
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] p0: DCC OV 0x7d1
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] link_init[1.0]:NO-
>> LFA(1)
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] init_phy[1.0]: done
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466164] [0:0] Resetting link
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466328] 7d2 data=63b
>> ibft=0
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466328] f0:
>> UNLOAD_REQ_WOL_DIS 0x1
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466328] f0:drv
>> msg=20010000,rsp=20100001
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466328] f0: UNLOAD_DONE
>> 0x2 2
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466328] Vaux 1
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466328] f0:drv
>> msg=21000000,rsp=21100002
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466328] f1:
>> UNLOAD_REQ_WOL_DIS 0x1
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466328] f1:drv
>> msg=20010000,rsp=20100001
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466328] f1: UNLOAD_DONE
>> 0x2 2
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466365] Vaux 0
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466365] f1:drv
>> msg=21000000,rsp=21100002
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466365] f0: LOAD_REQ 0x3
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466365] 0.0:PMF->f0
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466365] f0:drv
>> msg=10000000,rsp=10130003
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466365] f0: LOAD_DONE
>> 0x4
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466365] Ap▒Af0:drv
>> msg=11000000,rsp=11100004
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466365] evnt[0.0] 0x0-
>>> 0x1000
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466365] evnt[0.0] 0x1000-
>>> 0x0
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466365] f0: LNK_CHANGED
>> 0x5
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466365] f0:drv
>> msg=1000000,rsp=1100005
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466408] ver_query_tlv p0:
>> cap_grp1 0x7
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466408] f0: dcc status 0x301
>> config 0x640a0102
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466408] f0: DCC_OK
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466408] f0:drv
>> msg=30000000,rsp=30100006
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466408] ocbb_etoc 1 ffffffff
>> 0
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466408] Num ports 2,
>> Num_ether_func 1, fcoe 0 iscsi 2
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466408] Func instance err 1,
>> fcoe 0 iscsi 2 ports 2 pf_num 8
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466408] ibft_host_addr is
>> not initialized
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466408] ibft_host_addr is
>> not initialized
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466408] OCBB size:
>> ETOC=7d2 data=5ac ibft=0
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466408] ocbb_etoc ffffffff
>> ffffffff 0
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466408] Num ports 2,
>> Num_ether_func 1, fcoe 0 iscsi 2
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466476] Func instance err 1,
>> fcoe 0 iscsi 2 ports 2 pf_num 8
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466476] ibft_host_addr is
>> not initialized
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466476] ibft_host_addr is
>> not initialized
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466476] OCBB size:
>> ETOC=7d2 data=5ac ibft=0
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466503] 0x0
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466503] En Vaux
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466503] M lic key
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466503] [0.0]lldp
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.466504] end of fw dump
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.468695] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x0 = 0x00000000
>> 0x00000000 0x00000001 0x00020027
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.470147] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x1 = 0x00021bbb
>> 0x00000008 0x01000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.471374] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x2 = 0x00026e41
>> 0x00000000 0x01000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.472559] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x3 = 0x0002762e
>> 0x00000000 0x04000008 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.473738] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x4 = 0x00027db6
>> 0x00000000 0x04000010 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.474874] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x5 = 0x000285b0
>> 0x00000000 0x01000001 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.476006] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x6 = 0x00028d52
>> 0x00000000 0x04000009 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.477112] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x7 = 0x00029568
>> 0x00000000 0x04000011 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.478350] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x8 = 0x00029ce7
>> 0x00000000 0x01000002 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.480084] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x9 = 0x0002a4e9
>> 0x00000000 0x0400000a 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.481806] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0xa = 0x0002ac77
>> 0x00000000 0x04000012 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.482830] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0xb = 0x0002b475
>> 0x00000000 0x01000003 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.483823] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0xc = 0x0002bc12
>> 0x00000000 0x0400000b 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.484791] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0xd = 0x0002c405
>> 0x00000000 0x04000013 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.485747] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0xe = 0x0002cbba
>> 0x00000000 0x01000004 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.486667] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0xf = 0x0002d3a7
>> 0x00000000 0x0400000c 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.487559] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x10 = 0x0002db4c
>> 0x00000000 0x04000014 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.488432] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x11 = 0x0002e342
>> 0x00000000 0x01000005 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.489307] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x12 = 0x0002eae5
>> 0x00000000 0x0400000d 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.490173] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x13 = 0x0002f2d4
>> 0x00000000 0x04000015 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.490997] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x14 = 0x0002fa88
>> 0x00000000 0x01000006 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.491794] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x15 = 0x0003027c
>> 0x00000000 0x0400000e 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.492578] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x16 = 0x00030a1e
>> 0x00000000 0x04000016 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.493542] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x17 = 0x00031212
>> 0x00000000 0x01000007 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.494769] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x18 = 0x000319bd
>> 0x00000000 0x0400000f 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.495967] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x19 = 0x000321ad
>> 0x00000000 0x04000017 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.496798] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x1a = 0x00032959
>> 0x00000000 0x0c000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.497456] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x1b = 0x000329d1
>> 0x00000000 0x09000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.498106] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x1c = 0x00042320
>> 0x00000000 0x0b000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.498713] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x1d = 0x00042326
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.499319] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x1e = 0x000423cb
>> 0x00000008 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.499896] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x1f = 0x000437b2
>> 0x00000000 0x0b000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.500447] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x20 = 0x000437b8
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.500975] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x21 = 0x0004f98e
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.501477] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x22 = 0x00054523
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.501971] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x23 = 0x0005901a
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.502434] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x24 = 0x0005da81
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.502869] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x25 = 0x0006255f
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.503277] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x26 = 0x0006715c
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.503672] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x27 = 0x0006bb1b
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.504028] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x28 = 0x000704c9
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.504358] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x29 = 0x00074f54
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.504684] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x2a = 0x00079973
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.504985] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x2b = 0x0007e3bf
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.505257] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x2c = 0x00082d78
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.505519] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x2d = 0x00087928
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.505789] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x2e = 0x000b6597
>> 0x00000000 0x0b000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.506041] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x2f = 0x000b659d
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.506267] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x30 = 0x000ba2c7
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.506489] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]XSTORM_ASSERT_INDEX 0x31 = 0x0029ff1f
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.506712] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x0 = 0x00000000
>> 0x00000000 0x00000001 0x00020027
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.506944] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x1 = 0x00021bbf
>> 0x00000008 0x01000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.507179] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x2 = 0x00026e45
>> 0x00000000 0x01000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.507411] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x3 = 0x00027631
>> 0x00000000 0x04000008 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.507645] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x4 = 0x00027db9
>> 0x00000000 0x04000010 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.507878] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x5 = 0x000285b3
>> 0x00000000 0x01000001 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.508186] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x6 = 0x00028d55
>> 0x00000000 0x04000009 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.508541] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x7 = 0x0002956b
>> 0x00000000 0x04000011 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.508926] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x8 = 0x00029ceb
>> 0x00000000 0x01000002 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.509304] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x9 = 0x0002a4ec
>> 0x00000000 0x0400000a 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.509699] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0xa = 0x0002ac7a
>> 0x00000000 0x04000012 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.510073] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0xb = 0x0002b479
>> 0x00000000 0x01000003 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.510473] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0xc = 0x0002bc15
>> 0x00000000 0x0400000b 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.510854] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0xd = 0x0002c408
>> 0x00000000 0x04000013 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.511224] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0xe = 0x0002cbbd
>> 0x00000000 0x01000004 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.511578] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0xf = 0x0002d3aa
>> 0x00000000 0x0400000c 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.511903] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x10 = 0x0002db50
>> 0x00000000 0x04000014 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.512295] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x11 = 0x0002e345
>> 0x00000000 0x01000005 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.512691] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x12 = 0x0002eae8
>> 0x00000000 0x0400000d 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.513083] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x13 = 0x0002f2d7
>> 0x00000000 0x04000015 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.513490] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x14 = 0x0002fa8c
>> 0x00000000 0x01000006 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.513908] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x15 = 0x0003027f
>> 0x00000000 0x0400000e 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.514296] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x16 = 0x00030a21
>> 0x00000000 0x04000016 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.514551] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x17 = 0x00031216
>> 0x00000000 0x01000007 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.514784] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x18 = 0x000319c0
>> 0x00000000 0x0400000f 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.515016] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x19 = 0x000321b0
>> 0x00000000 0x04000017 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.515248] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x1a = 0x0003295a
>> 0x00000000 0x0c000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.515481] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x1b = 0x000329d4
>> 0x00000000 0x09000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.515713] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x1c = 0x00042323
>> 0x00000000 0x0b000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.515944] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x1d = 0x00042329
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.516173] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x1e = 0x000423cb
>> 0x00000008 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.516402] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x1f = 0x000437b5
>> 0x00000000 0x0b000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.516631] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x20 = 0x000437bb
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.516860] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x21 = 0x0004f991
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.517088] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x22 = 0x00054526
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.517318] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x23 = 0x0005901d
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.517546] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x24 = 0x0005da84
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.517789] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x25 = 0x00062562
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.518018] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x26 = 0x0006715f
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.518261] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x27 = 0x0006bb1e
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.518490] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x28 = 0x000704cc
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.518720] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x29 = 0x00074f57
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.518949] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x2a = 0x00079976
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.519178] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x2b = 0x0007e3c2
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.519407] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x2c = 0x00082d7b
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.519637] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x2d = 0x0008792b
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.519864] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x2e = 0x000b659b
>> 0x00000000 0x0b000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.520091] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x2f = 0x000b65a1
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.520309] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x30 = 0x000ba2ca
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.520524] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]TSTORM_ASSERT_INDEX 0x31 = 0x0029ff22
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.520752] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x0 = 0x00000000
>> 0x00000000 0x00000001 0x00020027
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.520976] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x1 = 0x00021bc2
>> 0x00000008 0x01000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.521202] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x2 = 0x00026e47
>> 0x00000000 0x01000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.521427] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x3 = 0x00027632
>> 0x00000000 0x04000008 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.521665] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x4 = 0x00027dba
>> 0x00000000 0x04000010 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.521893] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x5 = 0x000285b5
>> 0x00000000 0x01000001 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.522118] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x6 = 0x00028d55
>> 0x00000000 0x04000009 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.522343] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x7 = 0x0002956c
>> 0x00000000 0x04000011 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.522570] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x8 = 0x00029cec
>> 0x00000000 0x01000002 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.522794] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x9 = 0x0002a4ec
>> 0x00000000 0x0400000a 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.523048] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0xa = 0x0002ac7a
>> 0x00000000 0x04000012 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.523399] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0xb = 0x0002b47b
>> 0x00000000 0x01000003 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.523752] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0xc = 0x0002bc15
>> 0x00000000 0x0400000b 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.524123] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0xd = 0x0002c409
>> 0x00000000 0x04000013 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.524482] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0xe = 0x0002cbbf
>> 0x00000000 0x01000004 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.524835] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0xf = 0x0002d3aa
>> 0x00000000 0x0400000c 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.525198] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x10 = 0x0002db50
>> 0x00000000 0x04000014 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.525578] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x11 = 0x0002e347
>> 0x00000000 0x01000005 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.525950] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x12 = 0x0002eae8
>> 0x00000000 0x0400000d 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.526320] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x13 = 0x0002f2d7
>> 0x00000000 0x04000015 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.526697] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x14 = 0x0002fa8e
>> 0x00000000 0x01000006 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.527056] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x15 = 0x00030280
>> 0x00000000 0x0400000e 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.527357] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x16 = 0x00030a21
>> 0x00000000 0x04000016 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.527584] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x17 = 0x00031218
>> 0x00000000 0x01000007 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.527810] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x18 = 0x000319c1
>> 0x00000000 0x0400000f 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.528035] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x19 = 0x000321b0
>> 0x00000000 0x04000017 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.528266] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x1a = 0x0003295c
>> 0x00000000 0x0c000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.528502] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x1b = 0x000329d7
>> 0x00000000 0x09000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.528729] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x1c = 0x00042326
>> 0x00000000 0x0b000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.528954] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x1d = 0x0004232c
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.529179] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x1e = 0x000423cd
>> 0x00000008 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.529404] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x1f = 0x000437b8
>> 0x00000000 0x0b000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.529648] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x20 = 0x000437be
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.529877] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x21 = 0x0004f994
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.530105] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x22 = 0x00054529
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.530331] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x23 = 0x00059020
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.530558] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x24 = 0x0005da87
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.530786] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x25 = 0x00062565
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.531012] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x26 = 0x00067161
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.531241] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x27 = 0x0006bb21
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.531467] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x28 = 0x000704cf
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.531694] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x29 = 0x00074f5a
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.531921] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x2a = 0x00079978
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.532149] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x2b = 0x0007e3c5
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.532378] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x2c = 0x00082d7e
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.532606] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x2d = 0x0008792e
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.532844] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x2e = 0x000b659e
>> 0x00000000 0x0b000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.533070] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x2f = 0x000b65a4
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.533287] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x30 = 0x000ba2cd
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.533502] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]CSTORM_ASSERT_INDEX 0x31 = 0x0029ff26
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.533726] bnx2x:
>> [bnx2x_mc_assert:720(eth0)]USTORM_ASSERT_LIST_INDEX 0x62
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.533951] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x0 = 0x00021bc1
>> 0x00000008 0x01000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.534193] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x1 = 0x00026e47
>> 0x00000000 0x01000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.534434] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x2 = 0x00027632
>> 0x00000000 0x04000008 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.534675] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x3 = 0x00027dba
>> 0x00000000 0x04000010 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.534917] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x4 = 0x000285b5
>> 0x00000000 0x01000001 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.535159] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x5 = 0x00028d56
>> 0x00000000 0x04000009 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.535402] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x6 = 0x0002956c
>> 0x00000000 0x04000011 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.535645] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x7 = 0x00029ced
>> 0x00000000 0x01000002 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.535899] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x8 = 0x0002a4ec
>> 0x00000000 0x0400000a 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.536142] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x9 = 0x0002ac7b
>> 0x00000000 0x04000012 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.536395] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0xa = 0x0002b47b
>> 0x00000000 0x01000003 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.536638] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0xb = 0x0002bc15
>> 0x00000000 0x0400000b 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.536893] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0xc = 0x0002c409
>> 0x00000000 0x04000013 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.537128] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0xd = 0x0002cbbf
>> 0x00000000 0x01000004 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.537362] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0xe = 0x0002d3aa
>> 0x00000000 0x0400000c 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.537612] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0xf = 0x0002db50
>> 0x00000000 0x04000014 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.537848] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x10 = 0x0002e347
>> 0x00000000 0x01000005 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.538159] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x11 = 0x0002eae8
>> 0x00000000 0x0400000d 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.538527] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x12 = 0x0002f2d7
>> 0x00000000 0x04000015 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.538907] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x13 = 0x0002fa8e
>> 0x00000000 0x01000006 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.539312] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x14 = 0x00030280
>> 0x00000000 0x0400000e 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.539702] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x15 = 0x00030a21
>> 0x00000000 0x04000016 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.540102] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x16 = 0x00031218
>> 0x00000000 0x01000007 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.540498] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x17 = 0x000319c1
>> 0x00000000 0x0400000f 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.540888] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x18 = 0x000321b0
>> 0x00000000 0x04000017 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.541286] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x19 = 0x0003295c
>> 0x00000000 0x0c000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.541688] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x1a = 0x000329d7
>> 0x00000000 0x09000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.542022] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x1b = 0x00042326
>> 0x00000000 0x0b000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.542266] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x1c = 0x0004232b
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.542509] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x1d = 0x000423cd
>> 0x00000008 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.542751] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x1e = 0x000437b8
>> 0x00000000 0x0b000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.543008] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x1f = 0x000437be
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.543263] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x20 = 0x0004f994
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.543506] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x21 = 0x00054529
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.543751] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x22 = 0x00059020
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.543996] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x23 = 0x0005da86
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.544240] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x24 = 0x00062564
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.544483] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x25 = 0x00067161
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.544727] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x26 = 0x0006bb21
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.544971] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x27 = 0x000704cf
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.545216] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x28 = 0x00074f5a
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.545459] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x29 = 0x00079978
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.545718] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x2a = 0x0007e3c5
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.545964] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x2b = 0x00082d7d
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.546206] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x2c = 0x0008792e
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.546451] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x2d = 0x000b659e
>> 0x00000000 0x0b000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.546693] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x2e = 0x000b65a4
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.546920] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x2f = 0x000ba2cd
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.547135] bnx2x:
>> [bnx2x_mc_assert:736(eth0)]USTORM_ASSERT_INDEX 0x30 = 0x0029ff26
>> 0x00000000 0x0a000000 0x000200ac
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.547362] bnx2x:
>> [bnx2x_mc_assert:750(eth0)]Chip Revision: everest3, FW Version: 7_13_11
>>>>> Apr  8 17:53:48 serverhostname kernel: [ 1150.547585] bnx2x:
>> [bnx2x_panic_dump:1180(eth0)]end crash dump -----------------
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185533] ------------[ cut here
>> ]------------
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185539] NETDEV
>> WATCHDOG: eth0 (bnx2x): transmit queue 0 timed out
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185571] WARNING: CPU: 25
>> PID: 0 at net/sched/sch_generic.c:448 dev_watchdog+0x253/0x260
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185573] Modules linked in:
>> cls_bpf algif_hash af_alg sch_ingress ts_bm xt_tcpudp ts_kmp xt_string
>> nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
>> ipip tunnel4 ip_tunnel nft_counter nf_tables nfnetlink intel_rapl_msr
>> intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp
>> ipmi_ssif coretemp kvm_intel kvm irqbypass cpufreq_powersave
>> cpufreq_conservative crct10dif_pclmul cpufreq_userspace crc32_pclmul
>> ghash_clmulni_intel aesni_intel mgag200 crypto_simd drm_vram_helper
>> cryptd ttm glue_helper drm_kms_helper intel_cstate intel_uncore drm
>> intel_rapl_perf joydev evdev ipmi_si sg ioatdma serio_raw i2c_algo_bit
>> ipmi_devintf pcspkr iTCO_wdt hpwdt iTCO_vendor_support hpilo watchdog dca
>> ipmi_msghandler acpi_power_meter button binfmt_misc ip_tables x_tables
>> autofs4 ext4 crc16 mbcache jbd2 hid_generic usbhid hid sd_mod bnx2x
>> uhci_hcd hpsa ehci_pci ehci_hcd scsi_transport_sas psmouse usbcore scsi_mod
>> ptp
>>>>> pps_core mdio libcrc32c lpc_ich crc32c_generic mfd_core
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185635] usb_common
>> crc32c_intel video
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185642] CPU: 25 PID: 0
>> Comm: swapper/25 Not tainted 5.4.0-0.bpo.4-amd64 #1 Debian 5.4.19-
>> 1~bpo10+1
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185643] Hardware name:
>> HP ProLiant BL460c Gen8, BIOS I31 05/21/2018
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185648] RIP:
>> 0010:dev_watchdog+0x253/0x260
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185651] Code: 48 85 c0 75
>> e4 eb 9d 4c 89 ef c6 05 ec 3e a8 00 01 e8 e1 e4 fa ff 89 d9 4c 89 ee 48 c7 c7 c8
>> 0e 13 8f 48 89 c2 e8 d6 86 a0 ff <0f> 0b e9 7c ff ff ff 66 0f 1f 44 00 00 0f 1f 44
>> 00 00 41 57 41 56
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185653] RSP:
>> 0018:ffff9e2f4380ce88 EFLAGS: 00010282
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185656] RAX:
>> 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000006
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185657] RDX:
>> 0000000000000007 RSI: 0000000000000086 RDI: ffff91a92f7d7680
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185659] RBP:
>> ffff91a92bbf845c R08: 000000000000064e R09: 0000000000000004
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185660] R10:
>> 0000000000000000 R11: 0000000000000001 R12: ffff91a92bbcf100
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185662] R13:
>> ffff91a92bbf8000 R14: ffff91a92bbf8480 R15: 000000000000005b
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185665] FS:
>> 0000000000000000(0000) GS:ffff91a92f7c0000(0000)
>> knlGS:0000000000000000
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185666] CS:  0010 DS: 0000
>> ES: 0000 CR0: 0000000080050033
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185668] CR2:
>> 00000000ced16240 CR3: 0000000417a0a003 CR4: 00000000001606e0
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185669] Call Trace:
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185674] <IRQ>
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185681]  ?
>> pfifo_fast_enqueue+0x140/0x140
>>>>> Apr�� 8 17:53:52 serverhostname kernel: [ 1154.185688]
>> call_timer_fn+0x2d/0x130
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185691]
>> run_timer_softirq+0x1a6/0x430
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185695]  ?
>> __hrtimer_run_queues+0x130/0x280
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185700]  ?
>> recalibrate_cpu_khz+0x10/0x10
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185703]  ?
>> ktime_get+0x36/0xa0
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185709]
>> __do_softirq+0xdf/0x2e5
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185716] irq_exit+0xa3/0xb0
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185721]
>> smp_apic_timer_interrupt+0x74/0x130
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185725]
>> apic_timer_interrupt+0xf/0x20
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185727] </IRQ>
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185734] RIP:
>> 0010:cpuidle_enter_state+0xbc/0x450
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185736] Code: e8 b9 86 ad
>> ff 80 7c 24 13 00 74 17 9c 58 0f 1f 44 00 00 f6 c4 02 0f 85 67 03 00 00 31 ff e8
>> 2b b1 b3 ff fb 66 0f 1f 44 00 00 <45> 85 e4 0f 88 92 02 00 00 49 63 cc 4c 8b 3c
>> 24 4c 2b 7c 24 08 48
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185738] RSP:
>> 0018:ffff9e2f4327fe78 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185740] RAX:
>> ffff91a92f7ea6c0 RBX: ffffffff8f2b7a40 RCX: 000000000000001f
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185742] RDX:
>> 0000010cbad136e6 RSI: 000000003333348b RDI: 0000000000000000
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185743] RBP:
>> ffffbe2b3eff8200 R08: 0000000000000002 R09: 0000000000029f40
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185745] R10:
>> 0059ffb91faccf15 R11: ffff91a92f7e9580 R12: 0000000000000004
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185746] R13:
>> ffffffff8f2b7bd8 R14: 0000000000000004 R15: 0000000000000000
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185752]  ?
>> cpuidle_enter_state+0x97/0x450
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185756]
>> cpuidle_enter+0x29/0x40
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185761]
>> do_idle+0x228/0x270
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185765]
>> cpu_startup_entry+0x19/0x20
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185769]
>> start_secondary+0x15f/0x1b0
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185774]
>> secondary_startup_64+0xa4/0xb0
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185778] ---[ end trace
>> 43b1706a27024516 ]---
>>>>> Apr  8 17:53:52 serverhostname kernel: [ 1154.185828] bnx2x:
>> [bnx2x_sp_rtnl_task:10330(eth0)]Indicating link is down due to Tx-timeout
>>>>> Apr  8 17:53:54 serverhostname kernel: [ 1156.071098] bnx2x:
>> [bnx2x_clean_tx_queue:1204(eth0)]timeout waiting for queue[0]: txdata-
>>> tx_pkt_prod(34646) != txdata->tx_pkt_cons(34613)
>>>>> Apr  8 17:53:56 serverhostname kernel: [ 1157.961524] bnx2x:
>> [bnx2x_clean_tx_queue:1204(eth0)]timeout waiting for queue[1]: txdata-
>>> tx_pkt_prod(2386) != txdata->tx_pkt_cons(2374)
>>>>> Apr  8 17:53:58 serverhostname kernel: [ 1159.858694] bnx2x:
>> [bnx2x_clean_tx_queue:1204(eth0)]timeout waiting for queue[2]: txdata-
>>> tx_pkt_prod(6648) != txdata->tx_pkt_cons(6639)
>>>>> Apr  8 17:54:00 serverhostname kernel: [ 1161.772522] bnx2x:
>> [bnx2x_clean_tx_queue:1204(eth0)]timeout waiting for queue[3]: txdata-
>>> tx_pkt_prod(37816) != txdata->tx_pkt_cons(37795)
>>>>> Apr  8 17:54:02 serverhostname kernel: [ 1163.683181] bnx2x:
>> [bnx2x_clean_tx_queue:1204(eth0)]timeout waiting for queue[4]: txdata-
>>> tx_pkt_prod(49962) != txdata->tx_pkt_cons(49943)
>>>>> Apr  8 17:54:02 serverhostname kernel: [ 1164.459899] TCP:
>> request_sock_TCP: Possible SYN flooding on port 27015. Sending cookies. Check
>> SNMP counters.
>>>>> Apr  8 17:54:03 serverhostname kernel: [ 1165.457470] TCP:
>> request_sock_TCP: Possible SYN flooding on port 27015. Sending cookies. Check
>> SNMP counters.
>>>>> Apr  8 17:54:03 serverhostname kernel: [ 1165.461819] TCP:
>> request_sock_TCP: Possible SYN flooding on port 27015. Sending cookies. Check
>> SNMP counters.
>>>>> Apr  8 17:54:03 serverhostname kernel: [ 1165.469797] TCP:
>> request_sock_TCP: Possible SYN flooding on port 27015. Sending cookies. Check
>> SNMP counters.
>>>>> Apr  8 17:54:03 serverhostname kernel: [ 1165.469832] TCP:
>> request_sock_TCP: Possible SYN flooding on port 27015. Sending cookies. Check
>> SNMP counters.
>>>>> Apr  8 17:54:03 serverhostname kernel: [ 1165.470011] TCP:
>> request_sock_TCP: Possible SYN flooding on port 27015. Sending cookies. Check
>> SNMP counters.
>>>>> Apr  8 17:54:03 serverhostname kernel: [ 1165.482640] TCP:
>> request_sock_TCP: Possible SYN flooding on port 27015. Sending cookies. Check
>> SNMP counters.
>>>>> Apr  8 17:54:03 serverhostname kernel: [ 1165.482683] TCP:
>> request_sock_TCP: Possible SYN flooding on port 27015. Sending cookies. Check
>> SNMP counters.
>>>>> Apr  8 17:54:03 serverhostname kernel: [ 1165.484735] TCP:
>> request_sock_TCP: Possible SYN flooding on port 27015. Sending cookies. Check
>> SNMP counters.
>>>>> Apr  8 17:54:03 serverhostname kernel: [ 1165.487322] TCP:
>> request_sock_TCP: Possible SYN flooding on port 27015. Sending cookies. Check
>> SNMP counters.
>>>>> Apr  8 17:54:04 serverhostname kernel: [ 1165.573405] bnx2x:
>> [bnx2x_clean_tx_queue:1204(eth0)]timeout waiting for queue[5]: txdata-
>>> tx_pkt_prod(58842) != txdata->tx_pkt_cons(58824)
>>>>> Apr  8 17:54:05 serverhostname kernel: [ 1167.483398] bnx2x:
>> [bnx2x_clean_tx_queue:1204(eth0)]timeout waiting for queue[6]: txdata-
>>> tx_pkt_prod(63368) != txdata->tx_pkt_cons(63344)
>>>>> Apr  8 17:54:07 serverhostname kernel: [ 1169.411378] bnx2x:
>> [bnx2x_clean_tx_queue:1204(eth0)]timeout waiting for queue[7]: txdata-
>>> tx_pkt_prod(199) != txdata->tx_pkt_cons(183)
>>>>> Apr  8 17:54:09 serverhostname kernel: [ 1171.316654] bnx2x:
>> [bnx2x_clean_tx_queue:1204(eth0)]timeout waiting for queue[0]: txdata-
>>> tx_pkt_prod(34646) != txdata->tx_pkt_cons(34613)
>>>>> Apr  8 17:54:09 serverhostname kernel: [ 1171.476484] net_ratelimit: 11
>> callbacks suppressed
>>>>> Apr  8 17:54:09 serverhostname kernel: [ 1171.476487] TCP:
>> request_sock_TCP: Possible SYN flooding on port 27015. Sending cookies. Check
>> SNMP counters.
>>>>> Apr  8 17:54:09 serverhostname kernel: [ 1171.481018] TCP:
>> request_sock_TCP: Possible SYN flooding on port 27015. Sending cookies. Check
>> SNMP counters.
>>>>> Apr  8 17:54:11 serverhostname kernel: [ 1173.229309] bnx2x:
>> [bnx2x_clean_tx_queue:1204(eth0)]timeout waiting for queue[1]: txdata-
>>> tx_pkt_prod(2386) != txdata->tx_pkt_cons(2374)
>>>>> Apr  8 17:54:12 serverhostname kernel: [ 1174.479480] TCP:
>> request_sock_TCP: Possible SYN flooding on port 27015. Sending cookies. Check
>> SNMP counters.
>>>>> Apr  8 17:54:12 serverhostname kernel: [ 1174.483879] TCP:
>> request_sock_TCP: Possible SYN flooding on port 27015. Sending cookies. Check
>> SNMP counters.
>>>>> Apr  8 17:54:13 serverhostname kernel: [ 1175.136214] bnx2x:
>> [bnx2x_clean_tx_queue:1204(eth0)]timeout waiting for queue[2]: txdata-
>>> tx_pkt_prod(6648) != txdata->tx_pkt_cons(6639)
>>>>> Apr  8 17:54:15 serverhostname kernel: [ 1177.036533] bnx2x:
>> [bnx2x_clean_tx_queue:1204(eth0)]timeout waiting for queue[3]: txdata-
>>> tx_pkt_prod(37816) != txdata->tx_pkt_cons(37795)
>>>>> Apr  8 17:54:15 serverhostname kernel: [ 1177.483111] TCP:
>> request_sock_TCP: Possible SYN flooding on port 27015. Sending cookies. Check
>> SNMP counters.
>>>>> Apr  8 17:54:15 serverhostname kernel: [ 1177.487417] TCP:
>> request_sock_TCP: Possible SYN flooding on port 27015. Sending cookies. Check
>> SNMP counters.
>>>>> Apr  8 17:54:17 serverhostname kernel: [ 1178.971188] bnx2x:
>> [bnx2x_clean_tx_queue:1204(eth0)]timeout waiting for queue[4]: txdata-
>>> tx_pkt_prod(49962) != txdata->tx_pkt_cons(49943)
>>>>> Apr  8 17:54:19 serverhostname kernel: [ 1180.859460] bnx2x:
>> [bnx2x_clean_tx_queue:1204(eth0)]timeout waiting for queue[5]: txdata-
>>> tx_pkt_prod(58842) != txdata->tx_pkt_cons(58824)
>>>>> ```
>>>>>
>>>>>
>>>>> A reboot is required to get connectivity back to the machine. I've tried
>> looking around for any bug reports on this and found a couple, but I don't
>> believe they were related to crashing with TC BPF programs and these were in
>> earlier kernels (apparently it should be resolved in the kernels we've tried). I'm
>> also unable to pinpoint the issue itself in the logs above.
>>>>>
>>>>> The individual has tried firmware upgrades for the network drivers, but no
>> luck. We are compiling the TC BPF program from source on the machine via
>> the following commands:
>>>>>
>>>>> ```
>>>>>
>>>>> git clone https://urldefense.proofpoint.com/v2/url?u=https-
>> 3A__github.com_gamemann_IPIPDirect-
>> 2DTC.git&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=cWBgNIFUifZRx2xhypd
>> caYrfIsMGt93NxP1r8GQtC0s&m=aHiupgqaqlOKEppMZdqaGUEB4t_e1S3B_xTDt
>> 0pXBN0&s=ZEo-YuwrIN1v05-l1OaV78RtQgWgNBv9kNkf_RIVE4w&e=
>>>>> cd IPIPDirect-TC/
>>>>>
>>>>> git submodule update --init
>>>>>
>>>>> make
>>>>>
>>>>> make install
>>>>>
>>>>> ```
>>>>>
>>>>>
>>>>> The program is loaded via:
>>>>>
>>>>>
>>>>> ```
>>>>>
>>>>> IPIPDirect_Loader eth0
>>>>>
>>>>> ```
>>>>>
>>>>>
>>>>> Has anybody else ran into this issues with BPF programs using bnx2x
>> network drivers before? I'm unsure if this is something with my program's code
>> or a bug with the network drivers. I also tried changing 'TC_ACT_SHOT' to
>> 'TC_ACT_OK' in my TC BPF program's code, but the network drivers still crash
>> after 20 - 30 seconds.
>>>>>
>>>>> Any help is highly appreciated and thank you for your time!
>>>> Looks like a driver issue. I don't have a bnx2x available for testing, but
>> presumably from your
>>>> program it might be the bpf_skb_adjust_room() call that could be causing
>> trouble for the driver?
>>>> Hm, what happens if you disable TSO on the bnx2x NIC (I presume it's
>> default on in your setup)?
>>>> Would the bnx2x crash disappear in that case (ethtool -K <dev> tso off)?
>>>>
>>>> Thanks,
>>>> Daniel
