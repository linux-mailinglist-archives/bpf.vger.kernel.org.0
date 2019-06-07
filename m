Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38C9638266
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2019 03:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfFGBbT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 21:31:19 -0400
Received: from hermes.domdv.de ([193.102.202.1]:4428 "EHLO hermes.domdv.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfFGBbT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 21:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=domdv.de;
         s=dk3; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Rts1gOAQ0HTbua7Z/H/gno/iyHzPVEAsa7+ia6jiHvA=; b=U2PXSANQbTq2rAZuQxpud7qeLl
        BzhjwuVX+kC0Dmk6zESyug9h946t6E1eUDjGLlQAfrgmgA1F0WEIPVqY8fLbZBpjQ1TxN+5skghCr
        WMDOUvFPedMzcy4DEnoQgyfyzqeVZ3wavW44mY7c/H3TqQUc+9L/Ih0ckERqQDTENgIM=;
Received: from [fd06:8443:81a1:74b0::212] (port=3860 helo=castor.lan.domdv.de)
        by zeus.domdv.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <ast@domdv.de>)
        id 1hZ3is-0006HW-9P; Fri, 07 Jun 2019 03:31:14 +0200
Received: from woody.lan.domdv.de ([10.1.9.28] helo=host028-server-9.lan.domdv.de)
        by castor.lan.domdv.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <ast@domdv.de>)
        id 1hZ3iB-000117-KL; Fri, 07 Jun 2019 03:30:31 +0200
Message-ID: <9917583f188315a5e6f961146c65b3d8371cc05e.camel@domdv.de>
Subject: Re: eBPF verifier slowness, more than 2 cpu seconds for about 600
 instructions
From:   Andreas Steinmetz <ast@domdv.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Date:   Fri, 07 Jun 2019 03:30:46 +0200
In-Reply-To: <CAADnVQKJr-=gZM2hAG-Zi3WA3oxSU_S6Nh54qG+z6Bi8m2e3PA@mail.gmail.com>
References: <f0179a5f61ecd32efcea10ae05eb6aa3a151f791.camel@domdv.de>
         <CAADnVQLmrF579H6-TAdMK8wDM9eUz2rP3F6LmhkSW4yuVKJnPg@mail.gmail.com>
         <e9f7226d1066cb0e86b60ad3d84cf7908f12a1cc.camel@domdv.de>
         <CAADnVQKJr-=gZM2hAG-Zi3WA3oxSU_S6Nh54qG+z6Bi8m2e3PA@mail.gmail.com>
Organization: D.O.M. Datenverarbeitung GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Below is the source in question. It may look a bit strange but I
had to extract it from the project and preset parameters to fixed
values.
It takes from 2.8 to 4.5 seconds to load, depending on the processor.
Just compile and run the code below.
---------------------- CUT HERE --------------------
/*
 ==============================================================================
 Assembler source, results in data as stated below (actually an include in the
 original code). To modify, use https://github.com/not1337/ebpf2c
 ==============================================================================
name tce_filter
static
const
upcase
size
export tce_mac_map
export tce_eth_map
export tce_src_map
export tce_dst_map
export tce_src_pre
export tce_dst_pre
export tce_eth_mtu
export tce_dst_dev
export tce_v4_mtu
export tce_v6_mtu
export tce_v4_icmp
export tce_v6_icmp
export tce_mss_mtu
export tce_v4_mark
export tce_v4_and
export tce_v4_cmp
export tce_v6_mark
export tce_v6_and
export tce_v6_cmp
export tce_excl_mark
export tce_excl_and
export tce_excl_cmp
export tce_incl_mark
export tce_incl_and
export tce_incl_cmp
export tce_mac_hack
export tce_no_drop
preamble
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/ipv6.h>
#include <linux/in.h>
#include <linux/icmp.h>
#include <linux/icmpv6.h>
#ifndef __NETINET_UDP_H
#include <linux/udp.h>
#endif
#ifndef NETLINK_NETLINK_H_
#include <linux/tcp.h>
#endif
#include <linux/bpf.h>
#include <linux/pkt_cls.h>
#include <sys/types.h>
#include <stddef.h>

#ifndef SCTP_HEADER_DEFINED
#define SCTP_HEADER_DEFINED
#pragma pack(1)

struct sctphdr
{       
	u_int16_t source;
	u_int16_t dest;
	u_int32_t vtag;
	u_int32_t chksum;
};

#pragma pack()
#endif

#if __BYTE_ORDER == __LITTLE_ENDIAN
#include <byteswap.h>
#define BE16CONST(a)	__bswap_constant_16(a)
#elif __BYTE_ORDER == __BIG_ENDIAN
#define BE16CONST(a)	a
#else
#error "Please define __BYTE_ORDER for your system"
#endif

#define SKB(a)		offsetof(struct __sk_buff,a)
#define ETHSRC		offsetof(struct ethhdr,h_source)
#define ETHDST		offsetof(struct ethhdr,h_dest)
#define ETHPROTO	offsetof(struct ethhdr,h_proto)
#define IPV4MIN		ETH_HLEN+sizeof(struct iphdr)
#define IPV4VERS	ETH_HLEN
#define IPV4CHKSUM	ETH_HLEN+offsetof(struct iphdr,check)
#define IPV4PROTO	ETH_HLEN+offsetof(struct iphdr,protocol)
#define IPV4LEN		ETH_HLEN+offsetof(struct iphdr,tot_len)
#define IPV4SRC		ETH_HLEN+offsetof(struct iphdr,saddr)
#define IPV4DST		ETH_HLEN+offsetof(struct iphdr,daddr)
#define IPV4SIZE	sizeof(struct iphdr)+sizeof(struct icmphdr)+\
			sizeof(struct iphdr)+8
#define REDIR4SIZE	ETH_HLEN+sizeof(struct iphdr)+sizeof(struct icmphdr)+\
			sizeof(struct iphdr)+8
#define ICMP4DATA	ETH_HLEN+sizeof(struct iphdr)+sizeof(struct icmphdr)
#define ICMP4SIZE	sizeof(struct iphdr)+sizeof(struct icmphdr)+8
#define ICMP4TYPE	IPV4MIN+offsetof(struct icmphdr,type)
#define ICMP4CODE	IPV4MIN+offsetof(struct icmphdr,code)
#define ICMP4CHKSUM	IPV4MIN+offsetof(struct icmphdr,checksum)
#define ICMP4UNUSED	IPV4MIN+offsetof(struct icmphdr,un.frag.__unused)
#define ICMP4MTU	IPV4MIN+offsetof(struct icmphdr,un.frag.mtu)

#define IPV6MIN		ETH_HLEN+sizeof(struct ipv6hdr)
#define IPV6VERS	ETH_HLEN
#define IPV6PROTO	ETH_HLEN+offsetof(struct ipv6hdr,nexthdr)
#define IPV6LEN		ETH_HLEN+offsetof(struct ipv6hdr,payload_len)
#define REDIR6SIZE	ETH_HLEN+sizeof(struct ipv6hdr)+\
			sizeof(struct icmp6hdr)+sizeof(struct ipv6hdr)+8
#define ICMP6DATA	ETH_HLEN+sizeof(struct ipv6hdr)+sizeof(struct icmp6hdr)
#define ICMP6TYPE	IPV6MIN+offsetof(struct icmp6hdr,icmp6_type)
#define ICMP6CODE	IPV6MIN+offsetof(struct icmp6hdr,icmp6_code)
#define ICMP6CHKSUM	IPV6MIN+offsetof(struct icmp6hdr,icmp6_cksum)
#define ICMP6MTU	IPV6MIN+offsetof(struct icmp6hdr,icmp6_dataun.un_data32)
#define IPV6SRC		ETH_HLEN+offsetof(struct ipv6hdr,saddr)
#define IPV6DST		ETH_HLEN+offsetof(struct ipv6hdr,daddr)
#define IPV6SIZE	sizeof(struct icmp6hdr)+sizeof(struct ipv6hdr)+8
code
		;
		; save context (skb access)
		;
		movd	r6,r1
		;
		; load packet pointers
		;
		ldxw    r9,r6,#SKB(data_end)
		ldxw    r8,r6,#SKB(data)
		;
		; do not use __sk_buff length, that may be wrong, calculate
		; length from packet pointers instead
		;
		movd	r7,r9
		subd	r7,r8
		;
		; try to pull in packet if too few data, ok this is not perfect
		; as we need actually need more data than tested here, but
		; chances are that if we can advance at least into the ip
		; header we will probably be able to access the protocol
		; headers, too, lateron
		;
		movd	r0,r8
		addd	r0,#ETH_HLEN+offsetof(struct iphdr,protocol)+1
		jle	r0,r9,work
		movd	r2,#0
		fcall	BPF_FUNC_skb_pull_data
		ldxw	r9,r6,#SKB(data_end)
		ldxw	r8,r6,#SKB(data)
		movd	r7,r9
		subd	r7,r8
		;
		; skip if still smaller than ethernet header
		;
		movd	r0,r8
		addd	r0,#ETH_HLEN
		jgt	r0,r9,skip
		;
		; load mac destination address
		;
work:		ldxw	r1,r8,#ETHDST
		ldxh	r0,r8,#ETHDST+4
		lshd	r1,#32
		ord	r1,r0
		;
		; lookup mac address, skip if not found, otherwise load
		; prohibit info from map
		;
		stxd	r10,r1,#-8
		movd	r2,r10
tce_mac_map:	ldmap	r1,#0
		addd	r2,#-8
		fcall	BPF_FUNC_map_lookup_elem
		jeq	r0,#0,skip
		ldxb	r2,r0,#0
		;
		; load and process mtu enforcement info, save on stack
		;
		ldxb	r3,r0,#1
		ldxh	r4,r0,#2
		movw	r5,r4
		jne	r2,#0,mtustore
		subw	r5,r3
mtustore:	stxh	r10,r4,#-12
		stxh	r10,r5,#-10
		;
		; handle IPv4 and IPv6, check if communication is prohibited
		; via unencrypted device
		;
		ldxh	r0,r8,#ETHPROTO
		movd	r1,r0
		lshd	r1,#32
		ord	r7,r1
		jeq	r2,#0,noprohib
		ldi64	r3,#0x0001000000000000
		lshd	r3,r2
		ord	r7,r3
noprohib:	jeq	r0,#BE16CONST(ETH_P_IPV6),ipv6
		jeq	r0,#BE16CONST(ETH_P_IP),ipv4
		;
		; always skip ARP, RARP and MACsec
		;
		jeq	r0,#BE16CONST(ETH_P_ARP),skip
		jeq	r0,#BE16CONST(ETH_P_RARP),skip
		jeq	r0,#BE16CONST(ETH_P_MACSEC),skip
		;
		; include other protocols as requested
		;
		stxh	r10,r0,#-2
		movd	r2,r10
tce_eth_map:	ldmap	r1,#0
		addd	r2,#-2
		fcall	BPF_FUNC_map_lookup_elem
		jne	r0,#0,chkprohib
		ja	skip
		;
		; skip if incomplete IPv4 header
		;
ipv4:		movd	r1,r8
		addd	r1,#IPV4MIN
		jgt	r1,r9,tce_no_drop
		;
		; skip if not IPv4 or too short
		;
		ldxb	r0,r8,#IPV4VERS
		movw	r4,r0
		andw	r0,#0xf0
		andw	r4,#0xf
		jne	r0,#0x40,tce_no_drop
		jlt	r4,#5,tce_no_drop
		;
		; get pointer into payload
		;
		lshd	r4,#2
		addd	r4,#ETH_HLEN
		addd	r4,r8
		;
		; get and process protocol 
		;
		ldxb	r0,r8,#IPV4PROTO
		jne	r0,#IPPROTO_ICMP,common
		;
		; include/exclude icmp as configured - yes, we need
		; zombie register moves for verifier fright night
		;
tce_v4_icmp:	movw	r1,#0
		movd	r8,r4
tce_v4_mark:	movw	r0,#0
		jeq	r1,#0,skip
		jeq	r0,#0,domtu
		ldxw	r1,r6,#SKB(mark)
tce_v4_and:	movw	r0,#0
tce_v4_cmp:	movw	r2,#0
		andw	r1,r0
		jeq	r1,r2,skip
		ja	domtu
		;
		; skip if not IPv6 or too short
		;
ipv6:		movd	r4,#IPV6MIN
		addd	r4,r8
		jgt	r4,r9,tce_no_drop
		ldxb	r0,r8,#IPV6VERS
		andw	r0,#0xf0
		jne	r0,#0x60,tce_no_drop
		;
		; load protocol
		;
		ldxb	r0,r8,#IPV6PROTO
		jne	r0,#IPPROTO_ICMPV6,skipopt
		;
		; never redirect icmpv6 informational messages except
		; echo request and echo reply
		;
		movd	r1,r8
		addd	r1,#ICMP6DATA
		jgt	r1,r9,skip
		ldxb	r0,r8,#ICMP6TYPE
		jgt	r0,#129,skip
		;
		; include/exclude icmpv6 as configured - yes, we need
		; zombie register moves for verifier fright night
		;
tce_v6_icmp:	movw	r1,#0
		movd	r8,r4
tce_v6_mark:	movw	r0,#0
		jeq	r1,#0,skip
		jeq	r0,#0,domtu
		ldxw	r1,r6,#SKB(mark)
tce_v6_and:	movw	r0,#0
tce_v6_cmp:	movw	r2,#0
		andw	r1,r0
		jeq	r1,r2,skip
		ja	domtu
		;
		; skip optional first extension header
		;
skipopt:	jeq	r0,#0,skiphdr1
		jeq	r0,#60,skiphdr1
		jeq	r0,#43,skiphdr1
		jne	r0,#44,common
		addd	r4,#8
		jgt	r4,r9,tce_no_drop
		ldxb	r0,r4,#-8
		ja	nexthdr1
skiphdr1:	addd	r4,#8
		jgt	r4,r9,tce_no_drop
		ldxb	r1,r4,#-7
		ldxb	r0,r4,#-8
		addd	r4,r1
		jgt	r4,r9,tce_no_drop
		;
		; skip optional second extension header
		;
nexthdr1:	jeq	r0,#0,skiphdr2
		jeq	r0,#60,skiphdr2
		jeq	r0,#43,skiphdr2
		jne	r0,#44,common
		addd	r4,#8
		jgt	r4,r9,tce_no_drop
		ldxb	r0,r4,#-8
		ja	nexthdr2
skiphdr2:	addd	r4,#8
		jgt	r4,r9,tce_no_drop
		ldxb	r1,r4,#-7
		ldxb	r0,r4,#-8
		addd	r4,r1
		jgt	r4,r9,tce_no_drop
		;
		; skip optional third extension header
		;
nexthdr2:	jeq	r0,#0,skiphdr3
		jeq	r0,#60,skiphdr3
		jeq	r0,#43,skiphdr3
		jne	r0,#44,common
		addd	r4,#8
		jgt	r4,r9,tce_no_drop
		ldxb	r0,r4,#-8
		ja	nexthdr3
skiphdr3:	addd	r4,#8
		jgt	r4,r9,tce_no_drop
		ldxb	r1,r4,#-7
		ldxb	r0,r4,#-8
		addd	r4,r1
		jgt	r4,r9,tce_no_drop
		;
		; skip optional fourth extension header
		;
nexthdr3:	jeq	r0,#0,skiphdr4
		jeq	r0,#60,skiphdr4
		jeq	r0,#43,skiphdr4
		jne	r0,#44,common
		addd	r4,#8
		jgt	r4,r9,tce_no_drop
		ldxb	r0,r4,#-8
		ja	common
skiphdr4:	addd	r4,#8
		jgt	r4,r9,tce_no_drop
		ldxb	r1,r4,#-7
		ldxb	r0,r4,#-8
		addd	r4,r1
		jgt	r4,r9,tce_no_drop
		;
		; handle mark based exclude
		;
common:		ldxw	r5,r6,#SKB(mark)
tce_excl_mark:	movw	r2,#0
		jeq	r2,#0,tce_incl_mark
		movw	r1,r5
tce_excl_and:	movw	r2,#0
tce_excl_cmp:	movw	r3,#0
		andw	r1,r2
		jeq	r1,r3,skip
		;
		; handle mark based include
		;
tce_incl_mark:	movw	r2,#0
		jeq	r2,#0,dopayload
		movw	r1,r5
tce_incl_and:	movw	r2,#0
tce_incl_cmp:	movw	r3,#0
		andw	r1,r2
		jeq	r1,r3,domtu
		;
		; process payload type
		;
dopayload:	jeq	r0,#IPPROTO_TCP,tcp
		jeq	r0,#IPPROTO_UDP,udp
		jne	r0,#IPPROTO_SCTP,skip
		;
		; skip if too short for sctp header
		;
		movd	r2,#sizeof(struct sctphdr)
		addd	r2,r4
		jgt	r2,r9,tce_no_drop
		;
		; get source and destination port
		;
		ldxh	r1,r4,#offsetof(struct sctphdr,source)
		ldxh	r0,r4,#offsetof(struct sctphdr,dest)
		ja	store
		;
		; skip if too short for tcp header
		;
tcp:		movd	r2,#sizeof(struct tcphdr)
		addd	r2,r4
		jgt	r2,r9,tce_no_drop
		;
		; check and memorize SYN and SYN-ACK
		;
		ldxb	r0,r4,#13
		andw	r0,#7
		jne	r0,#2,nosyn
		ldi64	r0,#0x0001000000000000
		ord	r7,r0
		;
		; get source and destination port
		;
nosyn:		ldxh	r1,r4,#offsetof(struct tcphdr,source)
		ldxh	r0,r4,#offsetof(struct tcphdr,dest)
		ja	store
		;
		; skip if too short for udp header
		;
udp:		movd	r2,#sizeof(struct udphdr)
		addd	r2,r4
		jgt	r2,r9,tce_no_drop
		;
		; get source and destination port
		;
		ldxh	r1,r4,#offsetof(struct udphdr,source)
		ldxh	r0,r4,#offsetof(struct udphdr,dest)
		;
		; prepare further processing and keep our precious
		; payload pointer save from verifier assassination
		;
store:		hxbe	r1,#16
		hxbe	r0,#16
		stxw	r10,r0,#-8
		movd	r8,r4
		;
		; skip if source port in exclusion map
		;
		movw	r9,r1
		rshw	r1,#10
		movd	r3,#1
		lshd	r3,r1
tce_src_pre:	ldi64	r2,#0
		jset	r2,r3,srcchk
		ja	dodst
srcchk:		movw	r3,r9
		movd	r2,r10
		rshw	r3,#6
		stxw	r10,r3,#-4
tce_src_map:	ldmap	r1,#0
		addd	r2,#-4
		fcall	BPF_FUNC_map_lookup_elem
		jeq	r0,#0,dodst
		ldxd	r1,r0,#0
		andw	r9,#0x3f
		movd	r3,#1
		lshd	r3,r9
		jset	r1,r3,chkenforce
		;
		; skip if destination port in exclusion map
		;
dodst:		ldxw	r1,r10,#-8
		movw	r9,r1
		rshw	r1,#10
		movd	r3,#1
		lshd	r3,r1
tce_dst_pre:	ldi64	r2,#0
		jset	r2,r3,dstchk
		ja	domtu
dstchk:		movw	r3,r9
		movd	r2,r10
		rshw	r3,#6
		stxw	r10,r3,#-4
tce_dst_map:	ldmap	r1,#0
		addd	r2,#-4
		fcall	BPF_FUNC_map_lookup_elem
		jeq	r0,#0,domtu
		ldxd	r1,r0,#0
		andw	r9,#0x3f
		movd	r3,#1
		lshd	r3,r9
		jset	r1,r3,chkenforce
		;
		; send icmp if too large for target device mtu
		;
domtu:		ldxh	r0,r10,#-10
		movw	r5,r7
		jeq	r0,#0,tce_eth_mtu
		jle	r5,r0,noenforce
		subw	r0,#ETH_HLEN
		stxh	r10,r0,#-10
		ja	over
noenforce:	subw	r0,#IPV4MIN+sizeof(struct tcphdr)
		movw	r1,#0
		stxh	r10,r0,#-12
		stxh	r10,r1,#-10
tce_eth_mtu:	jgt	r5,#0,over
		;
		; check for TCP SYN or SYN-ACK for mss clamping
		;
		ldi64	r0,#0x0001000000000000
		jset	r7,r0,domss
		ja	chkprohib
		;
		; handle oversize if enforced (ignore mss clamping, the
		; peer must be configured to do so)
		;
chkenforce:	ldxh	r0,r10,#-12
		movw	r5,r7
		jeq	r0,#0,skip
		jle	r5,r0,skip
		subw	r0,#ETH_HLEN
		stxh	r10,r0,#-10
		ja	over
		;
		; restore packet access pointers - oh well yes, why not
		; spend some cycles on unneeded arithmetics, dear
		; verifier
		;
domss:		movd	r0,r8
		ldxw    r9,r6,#SKB(data_end)
		addd	r0,#sizeof(struct tcphdr)
		jgt	r0,r9,tce_no_drop
		;
		; get tcp header size
		;
		ldxb	r5,r8,#12
		rshd	r5,#2
		andd	r5,#0x3c
		;
		; drop if incomplete tcp header
		;
		movd	r0,r5
		jlt	r5,#20,tce_no_drop
		addd	r0,r8
		jgt	r0,r9,tce_no_drop
		;
		; we treat the tcp options wrong here and hope that padding
		; is done at the end only and that the syn options do have
		; their default length - variability is not part of the
		; verifier's world
		;
		; check first option for mss
		;
		movw	r4,#24
		jgt	r4,r5,chkprohib
		movd	r3,r8
		addd	r3,r4
		jgt	r3,r9,chkprohib
		ldxb	r1,r3,#-4
		jeq	r1,#2,mssopt
		jeq	r1,#1,adj1a
		jeq	r1,#3,adj1b
		jeq	r1,#8,adj1c
		jne	r1,#4,chkprohib
		ldxb	r1,r3,#-3
		jne	r1,#2,chkprohib
		addd	r4,#2
		ja	chkopt2
adj1a:		addd	r4,#1
		ja	chkopt2
adj1b:		ldxb	r1,r3,#-3
		jne	r1,#3,chkprohib
		addd	r4,#3
		ja	chkopt2
adj1c:		ldxb	r1,r3,#-3
		jne	r1,#10,chkprohib
		addd	r4,#10
		;
		; check second option for mss
		;
chkopt2:	jgt	r4,r5,chkprohib
		movd	r3,r8
		addd	r3,r4
		jgt	r3,r9,chkprohib
		ldxb	r1,r3,#-4
		jeq	r1,#2,mssopt
		jeq	r1,#1,adj2a
		jeq	r1,#3,adj2b
		jeq	r1,#8,adj2c
		jne	r1,#4,chkprohib
		ldxb	r1,r3,#-3
		jne	r1,#2,chkprohib
		addd	r4,#2
		ja	chkopt3
adj2a:		addd	r4,#1
		ja	chkopt3
adj2b:		ldxb	r1,r3,#-3
		jne	r1,#3,chkprohib
		addd	r4,#3
		ja	chkopt3
adj2c:		ldxb	r1,r3,#-3
		jne	r1,#10,chkprohib
		addd	r4,#10
		;
		; check third option for mss
		;
chkopt3:	jgt	r4,r5,chkprohib
		movd	r3,r8
		addd	r3,r4
		jgt	r3,r9,chkprohib
		ldxb	r1,r3,#-4
		jeq	r1,#2,mssopt
		jeq	r1,#1,adj3a
		jeq	r1,#3,adj3b
		jeq	r1,#8,adj3c
		jne	r1,#4,chkprohib
		ldxb	r1,r3,#-3
		jne	r1,#2,chkprohib
		addd	r4,#2
		ja	chkopt4
adj3a:		addd	r4,#1
		ja	chkopt4
adj3b:		ldxb	r1,r3,#-3
		jne	r1,#3,chkprohib
		addd	r4,#3
		ja	chkopt4
adj3c:		ldxb	r1,r3,#-3
		jne	r1,#10,chkprohib
		addd	r4,#10
		;
		; check fourth option for mss
		;
chkopt4:	jgt	r4,r5,chkprohib
		movd	r3,r8
		addd	r3,r4
		jgt	r3,r9,chkprohib
		ldxb	r1,r3,#-4
		jeq	r1,#2,mssopt
		jeq	r1,#1,adj4a
		jeq	r1,#3,adj4b
		jeq	r1,#8,adj4c
		jne	r1,#4,chkprohib
		ldxb	r1,r3,#-3
		jne	r1,#2,chkprohib
		addd	r4,#2
		ja	chkopt5
adj4a:		addd	r4,#1
		ja	chkopt5
adj4b:		ldxb	r1,r3,#-3
		jne	r1,#3,chkprohib
		addd	r4,#3
		ja	chkopt5
adj4c:		ldxb	r1,r3,#-3
		jne	r1,#10,chkprohib
		addd	r4,#10
		;
		; check fifth option for mss
		;
chkopt5:	jgt	r4,r5,chkprohib
		movd	r3,r8
		addd	r3,r4
		jgt	r3,r9,chkprohib
		ldxb	r1,r3,#-4
		jne	r1,#2,chkprohib
		;
		; check that the mss option has the default length and that
		; the mss value is not greater than the proto adjusted mtu
		;
mssopt:		ldxb	r0,r3,#-3
		movd	r5,r7
		ldxh	r1,r3,#-2
		jne	r0,#4,chkprohib
		rshd	r5,#32
		ldxh	r2,r10,#-12
tce_mss_mtu:	movw	r4,#0
		andw	r5,#0xffff
		jeq	r2,#0,dftmss
		jle	r4,r2,dftmss
		movw	r4,r2
dftmss:		hxbe	r1,#16
		jeq	r5,#BE16CONST(ETH_P_IP),cmpmss
		subw	r4,#20
cmpmss:		jge	r4,r1,chkprohib
		;
		; ok, we need to clamp the mss value and then
		; adjust the tcp checksum
		;
		movd	r2,r8
		ldxw    r0,r6,#SKB(data)
		hxbe	r4,#16
		addd	r2,#16
		stxh	r3,r4,#-2
		subd	r2,r0
		movd	r3,r1
		movw	r5,#2
		movd	r1,r6
		fcall	BPF_FUNC_l4_csum_replace
		jne	r0,#0,drop
		;
		; abort if communication with peer is prohibited
		;
chkprohib:	ldi64	r0,#0x0002000000000000
		jset	r7,r0,prohibited
		;
		; pass on packet in mtu check and mss clamp mode
		;
		lshd	r0,#1
		jset	r7,r0,skip
		;
		; proceed according to broadcast hack being enabled or not
		;
tce_mac_hack:	movw	r0,#0
		jeq	r0,#0,tce_dst_dev
		;
		; load packet pointers
		;
		ldxw    r9,r6,#SKB(data_end)
		ldxw    r8,r6,#SKB(data)
		;
		; skip if smaller than ethernet header (happy verifier)
		;
		movd	r0,r8
		addd	r0,#ETH_HLEN
		jgt	r0,r9,tce_dst_dev
		;
		; set ethernet source broadcast bit
		;
		ldxb	r0,r8,#ETHSRC
		orw	r0,#1
		stxb	r8,r0,#ETHSRC
		;
		; redirect to target device
		;
tce_dst_dev:	movd	r1,#0
		movd	r2,#0
		fcall	BPF_FUNC_redirect
		exit
		;
		; skip or drop according to user request
		;
tce_no_drop:	movw	r0,#0
		jeq	r0,#0,drop
		ja	skip
		;
		; slow path from here on: select according to ethernet proto
		;
prohibited:	rshd	r7,#32
		ldxw	r8,r6,#SKB(data)
		andw	r7,#0xffff
		ldxw	r9,r6,#SKB(data_end)
		jeq	r7,#BE16CONST(ETH_P_IP),nov4
		jeq	r7,#BE16CONST(ETH_P_IPV6),nov6
		ja	drop
		;
		; drop if incomplete IPv4 header
		;
nov4:		movd	r1,r8
		addd	r1,#IPV4MIN
		jgt	r1,r9,drop
		;
		; drop if not IPv4 or too short
		;
		ldxb	r0,r8,#IPV4VERS
		movw	r4,r0
		andw	r0,#0xf0
		andw	r4,#0xf
		jne	r0,#0x40,drop
		jlt	r4,#5,drop
		;
		; prepare icmp type and code
		;
		movw	r8,#ICMP_DEST_UNREACH
		movw	r9,#ICMP_PKT_FILTERED
		ja	doicmp
		;
		; drop if not IPv6 or too short
		;
nov6:		movd	r4,#IPV6MIN
		addd	r4,r8
		jgt	r4,r9,drop
		ldxb	r0,r8,#IPV6VERS
		andw	r0,#0xf0
		jne	r0,#0x60,drop
		;
		; prepare icmpv6 type and code
		;
		movw	r8,#ICMPV6_DEST_UNREACH
		movw	r9,#ICMPV6_ADM_PROHIBITED
		ja	doicmpv6
		;
		; slow path from here on: select according to ethernet
		; proto again
		;
over:		rshd	r7,#32
		andw	r7,#0xffff
		jeq	r7,#BE16CONST(ETH_P_IP),v4
		jeq	r7,#BE16CONST(ETH_P_IPV6),v6
		ja	skip
		;
		; IPv4: not really RFC compliant but good enough.
		; We cannot handle IPv4 options due to verifier
		; dumbness (it chokes on variable packet size).
		; As we can't fragment ourselves we ignore DF and
		; pretend it is always set.
		;
		; preset icmp type and code
		;
v4:		movw	r8,#ICMP_DEST_UNREACH
		movw	r9,#ICMP_FRAG_NEEDED
		;
		; resize packet for fragmentation needed icmp
		;
doicmp:		movd	r1,r6
		movd	r2,#REDIR4SIZE
		movd	r3,#0
		fcall	BPF_FUNC_skb_change_tail
		jne	r0,#0,drop
		;
		; make verifier happy
		;
		ldxw	r7,r6,#SKB(data)
		ldxw	r1,r6,#SKB(data_end)
		movd	r2,r7
		addd	r2,#REDIR4SIZE
		jgt	r2,r1,drop
		;
		; drop if icmp in reply to icmp
		;
		ldxb	r0,r7,#IPV4PROTO
		jeq	r0,#IPPROTO_ICMP,drop
		;
		; swap source and destination mac
		;
		ldxw	r0,r7,#0
		ldxh	r1,r7,#4
		ldxw	r2,r7,#6
		ldxh	r3,r7,#10
		stxw	r7,r2,#0
		stxh	r7,r3,#4
		stxw	r7,r0,#6
		stxh	r7,r1,#10
		;
		; copy original header to icmp payload - yes, we happily
		; pretend that there's no ip options
		;
		ldxd	r0,r7,#ETH_HLEN
		ldxd	r1,r7,#ETH_HLEN+8
		ldxd	r2,r7,#ETH_HLEN+16
		ldxw	r3,r7,#ETH_HLEN+24
		stxd	r7,r0,#ICMP4DATA
		stxd	r7,r1,#ICMP4DATA+8
		stxd	r7,r2,#ICMP4DATA+16
		stxw	r7,r3,#ICMP4DATA+24
		;
		; prepare icmp header
		;
		ldxh	r3,r10,#-10
		movw	r2,#0
		jne	r3,#0,v4enforced
tce_v4_mtu:	movw	r3,#0
v4enforced:	hxbe	r3,#16
		stxb	r7,r8,#ICMP4TYPE
		stxb	r7,r9,#ICMP4CODE
		stxh	r7,r2,#ICMP4CHKSUM
		stxh	r7,r2,#ICMP4UNUSED
		stxh	r7,r3,#ICMP4MTU
		;
		; kill ip options for good...
		;
		movd	r0,#0x45
		stxb	r7,r0,#IPV4VERS
		stxb	r7,r0,#ICMP4DATA
		;
		; create icmp checksum
		;
		movd	r1,#0
		movd	r2,#0
		movd	r3,r7
		addd	r3,#IPV4MIN
		movd	r4,#ICMP4SIZE
		movd	r5,#0
		fcall	BPF_FUNC_csum_diff
		jslt	r0,#0,drop
		movd	r1,r0
		andd	r0,#0xffff
		rshd	r1,#16
		addd	r0,r1
		movd	r1,r0
		andd	r0,#0xffff
		rshd	r1,#16
		addd	r0,r1
		xord	r0,#-1
		stxh	r7,r0,#ICMP4CHKSUM
		;
		; swap ip source and destination
		;
		ldxw	r0,r7,#IPV4SRC
		ldxw	r1,r7,#IPV4DST
		stxw	r7,r1,#IPV4SRC
		stxw	r7,r0,#IPV4DST
		;
		; adjust ip header for icmp reply
		;
		movd	r0,#IPV4SIZE
		hxbe	r0,#16
		movd	r1,#IPPROTO_ICMP
		movd	r2,#0
		stxh	r7,r0,#IPV4LEN
		stxb	r7,r1,#IPV4PROTO
		stxh	r7,r2,#IPV4CHKSUM
		;
		; create ip header checksum
		;
		movd	r1,#0
		movd	r2,#0
		movd	r3,r7
		addd	r3,#ETH_HLEN
		movd	r4,#sizeof(struct iphdr)
		movd	r5,#0
		fcall	BPF_FUNC_csum_diff
		jslt	r0,#0,drop
		movd	r1,r0
		andd	r0,#0xffff
		rshd	r1,#16
		addd	r0,r1
		movd	r1,r0
		andd	r0,#0xffff
		rshd	r1,#16
		addd	r0,r1
		xord	r0,#-1
		stxh	r7,r0,#IPV4CHKSUM
		;
		; return icmp fragmentation needed to original sender
		;
		ja	redir
		;
		; IPv6: not really RFC compliant but good enough.
		; We have to deal with verifier dumbness. Thus
		; we can't return the required packet data but
		; stick to a working minimum.
		;
		; preset icmp type and code
		;
v6:		movw	r8,#ICMPV6_PKT_TOOBIG
		movw	r9,#0
		;
		; resize packet for packet too big icmp
		;
doicmpv6:	movd	r1,r6
		movd	r2,#REDIR6SIZE
		movd	r3,#0
		fcall	BPF_FUNC_skb_change_tail
		jne	r0,#0,drop
		;
		; make verifier happy
		;
		ldxw	r7,r6,#SKB(data)
		ldxw	r1,r6,#SKB(data_end)
		movd	r2,r7
		addd	r2,#REDIR6SIZE
		jgt	r2,r1,drop
		;
		; drop if icmpv6 in reply to icmpv6
		;
		ldxb	r0,r7,#IPV6PROTO
		jeq	r0,#IPPROTO_ICMPV6,drop
		;
		; swap source and destination mac
		;
		ldxw	r0,r7,#0
		ldxh	r1,r7,#4
		ldxw	r2,r7,#6
		ldxh	r3,r7,#10
		stxw	r7,r2,#0
		stxh	r7,r3,#4
		stxw	r7,r0,#6
		stxh	r7,r1,#10
		;
		; copy original header to icmp payload - yes, we ignore
		; the RFC stated length (no loop, no fun)
		;
		ldxd	r0,r7,#ETH_HLEN
		ldxd	r1,r7,#ETH_HLEN+8
		ldxd	r2,r7,#ETH_HLEN+16
		ldxd	r3,r7,#ETH_HLEN+24
		ldxd	r4,r7,#ETH_HLEN+32
		ldxd	r5,r7,#ETH_HLEN+40
		stxd	r7,r0,#ICMP6DATA
		stxd	r7,r1,#ICMP6DATA+8
		stxd	r7,r2,#ICMP6DATA+16
		stxd	r7,r3,#ICMP6DATA+24
		stxd	r7,r4,#ICMP6DATA+32
		stxd	r7,r5,#ICMP6DATA+40
		;
		; prepare icmp header
		;
		movd	r1,#0
		movd	r2,#0
		jeq	r8,#ICMPV6_DEST_UNREACH,nomtu
		ldxh	r2,r10,#-10
		jne	r2,#0,v6enforced
tce_v6_mtu:	movd	r2,#0
v6enforced:	hxbe	r2,#32
nomtu:		stxb	r7,r8,#ICMP6TYPE
		stxb	r7,r9,#ICMP6CODE
		stxh	r7,r1,#ICMP6CHKSUM
		stxw	r7,r2,#ICMP6MTU
		;
		; swap ipv6 source and destination
		;
		ldxd	r0,r7,#IPV6SRC
		ldxd	r1,r7,#IPV6SRC+8
		ldxd	r2,r7,#IPV6DST
		ldxd	r3,r7,#IPV6DST+8
		stxd	r7,r2,#IPV6SRC
		stxd	r7,r3,#IPV6SRC+8
		stxd	r7,r0,#IPV6DST
		stxd	r7,r1,#IPV6DST+8
		;
		; add ipv6 addresses to checksum
		;
		movd	r1,#0
		movd	r2,#0
		movd	r3,r7
		addd	r3,#IPV6SRC
		movd	r4,#32
		movd	r5,#0
		fcall	BPF_FUNC_csum_diff
		jslt	r0,#0,drop
		;
		; create pseudo header artificial part
		;
		movd	r3,r10
		addd	r3,#-8
		movd	r1,#0
		stxd	r3,r1,#0
		movd	r1,#IPV6SIZE
		stxb	r3,r1,#3
		movd	r1,#IPPROTO_ICMPV6
		stxb	r3,r1,#7
		;
		; adjust ipv6 header for icmp reply
		;
		movd	r1,#IPPROTO_ICMPV6
		stxb	r7,r1,#IPV6PROTO
		movd	r1,#IPV6SIZE
		hxbe	r1,#16
		stxh	r7,r1,#IPV6LEN
		;
		; add artificial part of pseudo header to checksum
		;
		movd	r1,#0
		movd	r2,#0
		movd	r3,r10
		addd	r3,#-8
		movd	r4,#8
		movd	r5,r0
		fcall	BPF_FUNC_csum_diff
		jslt	r0,#0,drop
		;
		; add icmp message to checksum
		;
		movd	r1,#0
		movd	r2,#0
		movd	r3,r7
		addd	r3,#IPV6MIN
		movd	r4,#IPV6SIZE
		movd	r5,r0
		fcall	BPF_FUNC_csum_diff
		jslt	r0,#0,drop
		;
		; finish and store checksum
		;
		movd	r1,r0
		andd	r0,#0xffff
		rshd	r1,#16
		addd	r0,r1
		movd	r1,r0
		andd	r0,#0xffff
		rshd	r1,#16
		addd	r0,r1
		xord	r0,#-1
		stxh	r7,r0,#ICMP6CHKSUM
		;
		; return icmp packet too big to original sender
		;
redir:		movd	r1,r6
		ldxw	r2,r6,#SKB(ifindex)
		movd	r3,#BPF_F_INGRESS
		fcall	BPF_FUNC_clone_redirect
		;
		; drop original packet
		;
drop:		movd	r0,#TC_ACT_SHOT
		exit
		;
		; pass on original packet
		;
skip:		movd	r0,#TC_ACT_UNSPEC
		exit
 ==============================================================================
*/
#include <sys/timerfd.h>
#include <sys/signalfd.h>
#include <sys/epoll.h>
#include <sys/prctl.h>
#include <sys/resource.h>
#include <sys/ptrace.h>
#include <sys/mman.h>
#include <sys/capability.h>
#include <sys/utsname.h>
#include <sys/wait.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <sys/uio.h>
#include <sys/times.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <linux/version.h>
#include <linux/fib_rules.h>
#include <net/ethernet.h>
#include <net/if.h>
#include <poll.h>
#include <unistd.h>
#include <stdlib.h>
#include <signal.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>

/* ========================================================================== */
/*                        assembler output follows                            */
/* ========================================================================== */
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/ipv6.h>
#include <linux/in.h>
#include <linux/icmp.h>
#include <linux/icmpv6.h>
#ifndef __NETINET_UDP_H
#include <linux/udp.h>
#endif
#ifndef NETLINK_NETLINK_H_
#include <linux/tcp.h>
#endif
#include <linux/bpf.h>
#include <linux/pkt_cls.h>
#include <sys/types.h>
#include <stddef.h>

#ifndef SCTP_HEADER_DEFINED
#define SCTP_HEADER_DEFINED
#pragma pack(1)

struct sctphdr
{       
	u_int16_t source;
	u_int16_t dest;
	u_int32_t vtag;
	u_int32_t chksum;
};

#pragma pack()
#endif

#if __BYTE_ORDER == __LITTLE_ENDIAN
#include <byteswap.h>
#define BE16CONST(a)	__bswap_constant_16(a)
#elif __BYTE_ORDER == __BIG_ENDIAN
#define BE16CONST(a)	a
#else
#error "Please define __BYTE_ORDER for your system"
#endif

#define SKB(a)		offsetof(struct __sk_buff,a)
#define ETHSRC		offsetof(struct ethhdr,h_source)
#define ETHDST		offsetof(struct ethhdr,h_dest)
#define ETHPROTO	offsetof(struct ethhdr,h_proto)
#define IPV4MIN		ETH_HLEN+sizeof(struct iphdr)
#define IPV4VERS	ETH_HLEN
#define IPV4CHKSUM	ETH_HLEN+offsetof(struct iphdr,check)
#define IPV4PROTO	ETH_HLEN+offsetof(struct iphdr,protocol)
#define IPV4LEN		ETH_HLEN+offsetof(struct iphdr,tot_len)
#define IPV4SRC		ETH_HLEN+offsetof(struct iphdr,saddr)
#define IPV4DST		ETH_HLEN+offsetof(struct iphdr,daddr)
#define IPV4SIZE	sizeof(struct iphdr)+sizeof(struct icmphdr)+\
			sizeof(struct iphdr)+8
#define REDIR4SIZE	ETH_HLEN+sizeof(struct iphdr)+sizeof(struct icmphdr)+\
			sizeof(struct iphdr)+8
#define ICMP4DATA	ETH_HLEN+sizeof(struct iphdr)+sizeof(struct icmphdr)
#define ICMP4SIZE	sizeof(struct iphdr)+sizeof(struct icmphdr)+8
#define ICMP4TYPE	IPV4MIN+offsetof(struct icmphdr,type)
#define ICMP4CODE	IPV4MIN+offsetof(struct icmphdr,code)
#define ICMP4CHKSUM	IPV4MIN+offsetof(struct icmphdr,checksum)
#define ICMP4UNUSED	IPV4MIN+offsetof(struct icmphdr,un.frag.__unused)
#define ICMP4MTU	IPV4MIN+offsetof(struct icmphdr,un.frag.mtu)

#define IPV6MIN		ETH_HLEN+sizeof(struct ipv6hdr)
#define IPV6VERS	ETH_HLEN
#define IPV6PROTO	ETH_HLEN+offsetof(struct ipv6hdr,nexthdr)
#define IPV6LEN		ETH_HLEN+offsetof(struct ipv6hdr,payload_len)
#define REDIR6SIZE	ETH_HLEN+sizeof(struct ipv6hdr)+\
			sizeof(struct icmp6hdr)+sizeof(struct ipv6hdr)+8
#define ICMP6DATA	ETH_HLEN+sizeof(struct ipv6hdr)+sizeof(struct icmp6hdr)
#define ICMP6TYPE	IPV6MIN+offsetof(struct icmp6hdr,icmp6_type)
#define ICMP6CODE	IPV6MIN+offsetof(struct icmp6hdr,icmp6_code)
#define ICMP6CHKSUM	IPV6MIN+offsetof(struct icmp6hdr,icmp6_cksum)
#define ICMP6MTU	IPV6MIN+offsetof(struct icmp6hdr,icmp6_dataun.un_data32)
#define IPV6SRC		ETH_HLEN+offsetof(struct ipv6hdr,saddr)
#define IPV6DST		ETH_HLEN+offsetof(struct ipv6hdr,daddr)
#define IPV6SIZE	sizeof(struct icmp6hdr)+sizeof(struct ipv6hdr)+8

static const struct bpf_insn tce_filter[]={
{0xbf,6,1,0,0},
{0x61,9,6,SKB(data_end),0},
{0x61,8,6,SKB(data),0},
{0xbf,7,9,0,0},
{0x1f,7,8,0,0},
{0xbf,0,8,0,0},
{0x07,0,0,0,ETH_HLEN+offsetof(struct iphdr,protocol)+1},
{0xbd,0,9,9,0},
{0xb7,2,0,0,0},
{0x85,0,0,0,BPF_FUNC_skb_pull_data},
{0x61,9,6,SKB(data_end),0},
{0x61,8,6,SKB(data),0},
{0xbf,7,9,0,0},
{0x1f,7,8,0,0},
{0xbf,0,8,0,0},
{0x07,0,0,0,ETH_HLEN},
{0x2d,0,9,647,0},
{0x61,1,8,ETHDST,0},
{0x69,0,8,ETHDST+4,0},
{0x67,1,0,0,32},
{0x4f,1,0,0,0},
{0x7b,10,1,-8,0},
{0xbf,2,10,0,0},
{0x18,1,1,0,(u_int32_t)(0)},
{0x00,0,0,0,((u_int64_t)(0))>>32},
{0x07,2,0,0,-8},
{0x85,0,0,0,BPF_FUNC_map_lookup_elem},
{0x15,0,0,636,0},
{0x71,2,0,0,0},
{0x71,3,0,1,0},
{0x69,4,0,2,0},
{0xbc,5,4,0,0},
{0x55,2,0,1,0},
{0x1c,5,3,0,0},
{0x6b,10,4,-12,0},
{0x6b,10,5,-10,0},
{0x69,0,8,ETHPROTO,0},
{0xbf,1,0,0,0},
{0x67,1,0,0,32},
{0x4f,7,1,0,0},
{0x15,2,0,4,0},
{0x18,3,0,0,(u_int32_t)(0x0001000000000000)},
{0x00,0,0,0,((u_int64_t)(0x0001000000000000))>>32},
{0x6f,3,2,0,0},
{0x4f,7,3,0,0},
{0x15,0,0,37,BE16CONST(ETH_P_IPV6)},
{0x15,0,0,11,BE16CONST(ETH_P_IP)},
{0x15,0,0,616,BE16CONST(ETH_P_ARP)},
{0x15,0,0,615,BE16CONST(ETH_P_RARP)},
{0x15,0,0,614,BE16CONST(ETH_P_MACSEC)},
{0x6b,10,0,-2,0},
{0xbf,2,10,0,0},
{0x18,1,1,0,(u_int32_t)(0)},
{0x00,0,0,0,((u_int64_t)(0))>>32},
{0x07,2,0,0,-2},
{0x85,0,0,0,BPF_FUNC_map_lookup_elem},
{0x55,0,0,355,0},
{0x05,0,0,606,0},
{0xbf,1,8,0,0},
{0x07,1,0,0,IPV4MIN},
{0x2d,1,9,370,0},
{0x71,0,8,IPV4VERS,0},
{0xbc,4,0,0,0},
{0x54,0,0,0,0xf0},
{0x54,4,0,0,0xf},
{0x55,0,0,365,0x40},
{0xa5,4,0,364,5},
{0x67,4,0,0,2},
{0x07,4,0,0,ETH_HLEN},
{0x0f,4,8,0,0},
{0x71,0,8,IPV4PROTO,0},
{0x55,0,0,91,IPPROTO_ICMP},
{0xb4,1,0,0,0},
{0xbf,8,4,0,0},
{0xb4,0,0,0,0},
{0x15,1,0,588,0},
{0x15,0,0,176,0},
{0x61,1,6,SKB(mark),0},
{0xb4,0,0,0,0},
{0xb4,2,0,0,0},
{0x5c,1,0,0,0},
{0x1d,1,2,582,0},
{0x05,0,0,170,0},
{0xb7,4,0,0,IPV6MIN},
{0x0f,4,8,0,0},
{0x2d,4,9,345,0},
{0x71,0,8,IPV6VERS,0},
{0x54,0,0,0,0xf0},
{0x55,0,0,342,0x60},
{0x71,0,8,IPV6PROTO,0},
{0x55,0,0,16,IPPROTO_ICMPV6},
{0xbf,1,8,0,0},
{0x07,1,0,0,ICMP6DATA},
{0x2d,1,9,570,0},
{0x71,0,8,ICMP6TYPE,0},
{0x25,0,0,568,129},
{0xb4,1,0,0,0},
{0xbf,8,4,0,0},
{0xb4,0,0,0,0},
{0x15,1,0,564,0},
{0x15,0,0,152,0},
{0x61,1,6,SKB(mark),0},
{0xb4,0,0,0,0},
{0xb4,2,0,0,0},
{0x5c,1,0,0,0},
{0x1d,1,2,558,0},
{0x05,0,0,146,0},
{0x15,0,0,7,0},
{0x15,0,0,6,60},
{0x15,0,0,5,43},
{0x55,0,0,52,44},
{0x07,4,0,0,8},
{0x2d,4,9,318,0},
{0x71,0,4,-8,0},
{0x05,0,0,6,0},
{0x07,4,0,0,8},
{0x2d,4,9,314,0},
{0x71,1,4,-7,0},
{0x71,0,4,-8,0},
{0x0f,4,1,0,0},
{0x2d,4,9,310,0},
{0x15,0,0,7,0},
{0x15,0,0,6,60},
{0x15,0,0,5,43},
{0x55,0,0,38,44},
{0x07,4,0,0,8},
{0x2d,4,9,304,0},
{0x71,0,4,-8,0},
{0x05,0,0,6,0},
{0x07,4,0,0,8},
{0x2d,4,9,300,0},
{0x71,1,4,-7,0},
{0x71,0,4,-8,0},
{0x0f,4,1,0,0},
{0x2d,4,9,296,0},
{0x15,0,0,7,0},
{0x15,0,0,6,60},
{0x15,0,0,5,43},
{0x55,0,0,24,44},
{0x07,4,0,0,8},
{0x2d,4,9,290,0},
{0x71,0,4,-8,0},
{0x05,0,0,6,0},
{0x07,4,0,0,8},
{0x2d,4,9,286,0},
{0x71,1,4,-7,0},
{0x71,0,4,-8,0},
{0x0f,4,1,0,0},
{0x2d,4,9,282,0},
{0x15,0,0,7,0},
{0x15,0,0,6,60},
{0x15,0,0,5,43},
{0x55,0,0,10,44},
{0x07,4,0,0,8},
{0x2d,4,9,276,0},
{0x71,0,4,-8,0},
{0x05,0,0,6,0},
{0x07,4,0,0,8},
{0x2d,4,9,272,0},
{0x71,1,4,-7,0},
{0x71,0,4,-8,0},
{0x0f,4,1,0,0},
{0x2d,4,9,268,0},
{0x61,5,6,SKB(mark),0},
{0xb4,2,0,0,0},
{0x15,2,0,5,0},
{0xbc,1,5,0,0},
{0xb4,2,0,0,0},
{0xb4,3,0,0,0},
{0x5c,1,2,0,0},
{0x1d,1,3,493,0},
{0xb4,2,0,0,0},
{0x15,2,0,5,0},
{0xbc,1,5,0,0},
{0xb4,2,0,0,0},
{0xb4,3,0,0,0},
{0x5c,1,2,0,0},
{0x1d,1,3,75,0},
{0x15,0,0,8,IPPROTO_TCP},
{0x15,0,0,19,IPPROTO_UDP},
{0x55,0,0,483,IPPROTO_SCTP},
{0xb7,2,0,0,sizeof(struct sctphdr)},
{0x0f,2,4,0,0},
{0x2d,2,9,247,0},
{0x69,1,4,offsetof(struct sctphdr,source),0},
{0x69,0,4,offsetof(struct sctphdr,dest),0},
{0x05,0,0,17,0},
{0xb7,2,0,0,sizeof(struct tcphdr)},
{0x0f,2,4,0,0},
{0x2d,2,9,241,0},
{0x71,0,4,13,0},
{0x54,0,0,0,7},
{0x55,0,0,3,2},
{0x18,0,0,0,(u_int32_t)(0x0001000000000000)},
{0x00,0,0,0,((u_int64_t)(0x0001000000000000))>>32},
{0x4f,7,0,0,0},
{0x69,1,4,offsetof(struct tcphdr,source),0},
{0x69,0,4,offsetof(struct tcphdr,dest),0},
{0x05,0,0,5,0},
{0xb7,2,0,0,sizeof(struct udphdr)},
{0x0f,2,4,0,0},
{0x2d,2,9,229,0},
{0x69,1,4,offsetof(struct udphdr,source),0},
{0x69,0,4,offsetof(struct udphdr,dest),0},
{0xdc,1,0,0,16},
{0xdc,0,0,0,16},
{0x63,10,0,-8,0},
{0xbf,8,4,0,0},
{0xbc,9,1,0,0},
{0x74,1,0,0,10},
{0xb7,3,0,0,1},
{0x6f,3,1,0,0},
{0x18,2,0,0,(u_int32_t)(0)},
{0x00,0,0,0,((u_int64_t)(0))>>32},
{0x4d,2,3,1,0},
{0x05,0,0,14,0},
{0xbc,3,9,0,0},
{0xbf,2,10,0,0},
{0x74,3,0,0,6},
{0x63,10,3,-4,0},
{0x18,1,1,0,(u_int32_t)(0)},
{0x00,0,0,0,((u_int64_t)(0))>>32},
{0x07,2,0,0,-4},
{0x85,0,0,0,BPF_FUNC_map_lookup_elem},
{0x15,0,0,5,0},
{0x79,1,0,0,0},
{0x54,9,0,0,0x3f},
{0xb7,3,0,0,1},
{0x6f,3,9,0,0},
{0x4d,1,3,39,0},
{0x61,1,10,-8,0},
{0xbc,9,1,0,0},
{0x74,1,0,0,10},
{0xb7,3,0,0,1},
{0x6f,3,1,0,0},
{0x18,2,0,0,(u_int32_t)(0)},
{0x00,0,0,0,((u_int64_t)(0))>>32},
{0x4d,2,3,1,0},
{0x05,0,0,14,0},
{0xbc,3,9,0,0},
{0xbf,2,10,0,0},
{0x74,3,0,0,6},
{0x63,10,3,-4,0},
{0x18,1,1,0,(u_int32_t)(0)},
{0x00,0,0,0,((u_int64_t)(0))>>32},
{0x07,2,0,0,-4},
{0x85,0,0,0,BPF_FUNC_map_lookup_elem},
{0x15,0,0,5,0},
{0x79,1,0,0,0},
{0x54,9,0,0,0x3f},
{0xb7,3,0,0,1},
{0x6f,3,9,0,0},
{0x4d,1,3,16,0},
{0x69,0,10,-10,0},
{0xbc,5,7,0,0},
{0x15,0,0,8,0},
{0xbd,5,0,3,0},
{0x14,0,0,0,ETH_HLEN},
{0x6b,10,0,-10,0},
{0x05,0,0,202,0},
{0x14,0,0,0,IPV4MIN+sizeof(struct tcphdr)},
{0xb4,1,0,0,0},
{0x6b,10,0,-12,0},
{0x6b,10,1,-10,0},
{0x25,5,0,197,0},
{0x18,0,0,0,(u_int32_t)(0x0001000000000000)},
{0x00,0,0,0,((u_int64_t)(0x0001000000000000))>>32},
{0x4d,7,0,8,0},
{0x05,0,0,143,0},
{0x69,0,10,-12,0},
{0xbc,5,7,0,0},
{0x15,0,0,392,0},
{0xbd,5,0,391,0},
{0x14,0,0,0,ETH_HLEN},
{0x6b,10,0,-10,0},
{0x05,0,0,186,0},
{0xbf,0,8,0,0},
{0x61,9,6,SKB(data_end),0},
{0x07,0,0,0,sizeof(struct tcphdr)},
{0x2d,0,9,151,0},
{0x71,5,8,12,0},
{0x77,5,0,0,2},
{0x57,5,0,0,0x3c},
{0xbf,0,5,0,0},
{0xa5,5,0,146,20},
{0x0f,0,8,0,0},
{0x2d,0,9,144,0},
{0xb4,4,0,0,24},
{0x2d,4,5,123,0},
{0xbf,3,8,0,0},
{0x0f,3,4,0,0},
{0x2d,3,9,120,0},
{0x71,1,3,-4,0},
{0x15,1,0,92,2},
{0x15,1,0,7,1},
{0x15,1,0,8,3},
{0x15,1,0,11,8},
{0x55,1,0,114,4},
{0x71,1,3,-3,0},
{0x55,1,0,112,2},
{0x07,4,0,0,2},
{0x05,0,0,9,0},
{0x07,4,0,0,1},
{0x05,0,0,7,0},
{0x71,1,3,-3,0},
{0x55,1,0,106,3},
{0x07,4,0,0,3},
{0x05,0,0,3,0},
{0x71,1,3,-3,0},
{0x55,1,0,102,10},
{0x07,4,0,0,10},
{0x2d,4,5,100,0},
{0xbf,3,8,0,0},
{0x0f,3,4,0,0},
{0x2d,3,9,97,0},
{0x71,1,3,-4,0},
{0x15,1,0,69,2},
{0x15,1,0,7,1},
{0x15,1,0,8,3},
{0x15,1,0,11,8},
{0x55,1,0,91,4},
{0x71,1,3,-3,0},
{0x55,1,0,89,2},
{0x07,4,0,0,2},
{0x05,0,0,9,0},
{0x07,4,0,0,1},
{0x05,0,0,7,0},
{0x71,1,3,-3,0},
{0x55,1,0,83,3},
{0x07,4,0,0,3},
{0x05,0,0,3,0},
{0x71,1,3,-3,0},
{0x55,1,0,79,10},
{0x07,4,0,0,10},
{0x2d,4,5,77,0},
{0xbf,3,8,0,0},
{0x0f,3,4,0,0},
{0x2d,3,9,74,0},
{0x71,1,3,-4,0},
{0x15,1,0,46,2},
{0x15,1,0,7,1},
{0x15,1,0,8,3},
{0x15,1,0,11,8},
{0x55,1,0,68,4},
{0x71,1,3,-3,0},
{0x55,1,0,66,2},
{0x07,4,0,0,2},
{0x05,0,0,9,0},
{0x07,4,0,0,1},
{0x05,0,0,7,0},
{0x71,1,3,-3,0},
{0x55,1,0,60,3},
{0x07,4,0,0,3},
{0x05,0,0,3,0},
{0x71,1,3,-3,0},
{0x55,1,0,56,10},
{0x07,4,0,0,10},
{0x2d,4,5,54,0},
{0xbf,3,8,0,0},
{0x0f,3,4,0,0},
{0x2d,3,9,51,0},
{0x71,1,3,-4,0},
{0x15,1,0,23,2},
{0x15,1,0,7,1},
{0x15,1,0,8,3},
{0x15,1,0,11,8},
{0x55,1,0,45,4},
{0x71,1,3,-3,0},
{0x55,1,0,43,2},
{0x07,4,0,0,2},
{0x05,0,0,9,0},
{0x07,4,0,0,1},
{0x05,0,0,7,0},
{0x71,1,3,-3,0},
{0x55,1,0,37,3},
{0x07,4,0,0,3},
{0x05,0,0,3,0},
{0x71,1,3,-3,0},
{0x55,1,0,33,10},
{0x07,4,0,0,10},
{0x2d,4,5,31,0},
{0xbf,3,8,0,0},
{0x0f,3,4,0,0},
{0x2d,3,9,28,0},
{0x71,1,3,-4,0},
{0x55,1,0,26,2},
{0x71,0,3,-3,0},
{0xbf,5,7,0,0},
{0x69,1,3,-2,0},
{0x55,0,0,22,4},
{0x77,5,0,0,32},
{0x69,2,10,-12,0},
{0xb4,4,0,0,0},
{0x54,5,0,0,0xffff},
{0x15,2,0,2,0},
{0xbd,4,2,1,0},
{0xbc,4,2,0,0},
{0xdc,1,0,0,16},
{0x15,5,0,1,BE16CONST(ETH_P_IP)},
{0x14,4,0,0,20},
{0x3d,4,1,11,0},
{0xbf,2,8,0,0},
{0x61,0,6,SKB(data),0},
{0xdc,4,0,0,16},
{0x07,2,0,0,16},
{0x6b,3,4,-2,0},
{0x1f,2,0,0,0},
{0xbf,3,1,0,0},
{0xb4,5,0,0,2},
{0xbf,1,6,0,0},
{0x85,0,0,0,BPF_FUNC_l4_csum_replace},
{0x55,0,0,250,0},
{0x18,0,0,0,(u_int32_t)(0x0002000000000000)},
{0x00,0,0,0,((u_int64_t)(0x0002000000000000))>>32},
{0x4d,7,0,19,0},
{0x67,0,0,0,1},
{0x4d,7,0,247,0},
{0xb4,0,0,0,0},
{0x15,0,0,8,0},
{0x61,9,6,SKB(data_end),0},
{0x61,8,6,SKB(data),0},
{0xbf,0,8,0,0},
{0x07,0,0,0,ETH_HLEN},
{0x2d,0,9,3,0},
{0x71,0,8,ETHSRC,0},
{0x44,0,0,0,1},
{0x73,8,0,ETHSRC,0},
{0xb7,1,0,0,0},
{0xb7,2,0,0,0},
{0x85,0,0,0,BPF_FUNC_redirect},
{0x95,0,0,0,0},
{0xb4,0,0,0,0},
{0x15,0,0,229,0},
{0x05,0,0,230,0},
{0x77,7,0,0,32},
{0x61,8,6,SKB(data),0},
{0x54,7,0,0,0xffff},
{0x61,9,6,SKB(data_end),0},
{0x15,7,0,2,BE16CONST(ETH_P_IP)},
{0x15,7,0,13,BE16CONST(ETH_P_IPV6)},
{0x05,0,0,221,0},
{0xbf,1,8,0,0},
{0x07,1,0,0,IPV4MIN},
{0x2d,1,9,218,0},
{0x71,0,8,IPV4VERS,0},
{0xbc,4,0,0,0},
{0x54,0,0,0,0xf0},
{0x54,4,0,0,0xf},
{0x55,0,0,213,0x40},
{0xa5,4,0,212,5},
{0xb4,8,0,0,ICMP_DEST_UNREACH},
{0xb4,9,0,0,ICMP_PKT_FILTERED},
{0x05,0,0,16,0},
{0xb7,4,0,0,IPV6MIN},
{0x0f,4,8,0,0},
{0x2d,4,9,206,0},
{0x71,0,8,IPV6VERS,0},
{0x54,0,0,0,0xf0},
{0x55,0,0,203,0x60},
{0xb4,8,0,0,ICMPV6_DEST_UNREACH},
{0xb4,9,0,0,ICMPV6_ADM_PROHIBITED},
{0x05,0,0,98,0},
{0x77,7,0,0,32},
{0x54,7,0,0,0xffff},
{0x15,7,0,2,BE16CONST(ETH_P_IP)},
{0x15,7,0,92,BE16CONST(ETH_P_IPV6)},
{0x05,0,0,197,0},
{0xb4,8,0,0,ICMP_DEST_UNREACH},
{0xb4,9,0,0,ICMP_FRAG_NEEDED},
{0xbf,1,6,0,0},
{0xb7,2,0,0,REDIR4SIZE},
{0xb7,3,0,0,0},
{0x85,0,0,0,BPF_FUNC_skb_change_tail},
{0x55,0,0,188,0},
{0x61,7,6,SKB(data),0},
{0x61,1,6,SKB(data_end),0},
{0xbf,2,7,0,0},
{0x07,2,0,0,REDIR4SIZE},
{0x2d,2,1,183,0},
{0x71,0,7,IPV4PROTO,0},
{0x15,0,0,181,IPPROTO_ICMP},
{0x61,0,7,0,0},
{0x69,1,7,4,0},
{0x61,2,7,6,0},
{0x69,3,7,10,0},
{0x63,7,2,0,0},
{0x6b,7,3,4,0},
{0x63,7,0,6,0},
{0x6b,7,1,10,0},
{0x79,0,7,ETH_HLEN,0},
{0x79,1,7,ETH_HLEN+8,0},
{0x79,2,7,ETH_HLEN+16,0},
{0x61,3,7,ETH_HLEN+24,0},
{0x7b,7,0,ICMP4DATA,0},
{0x7b,7,1,ICMP4DATA+8,0},
{0x7b,7,2,ICMP4DATA+16,0},
{0x63,7,3,ICMP4DATA+24,0},
{0x69,3,10,-10,0},
{0xb4,2,0,0,0},
{0x55,3,0,1,0},
{0xb4,3,0,0,0},
{0xdc,3,0,0,16},
{0x73,7,8,ICMP4TYPE,0},
{0x73,7,9,ICMP4CODE,0},
{0x6b,7,2,ICMP4CHKSUM,0},
{0x6b,7,2,ICMP4UNUSED,0},
{0x6b,7,3,ICMP4MTU,0},
{0xb7,0,0,0,0x45},
{0x73,7,0,IPV4VERS,0},
{0x73,7,0,ICMP4DATA,0},
{0xb7,1,0,0,0},
{0xb7,2,0,0,0},
{0xbf,3,7,0,0},
{0x07,3,0,0,IPV4MIN},
{0xb7,4,0,0,ICMP4SIZE},
{0xb7,5,0,0,0},
{0x85,0,0,0,BPF_FUNC_csum_diff},
{0xc5,0,0,144,0},
{0xbf,1,0,0,0},
{0x57,0,0,0,0xffff},
{0x77,1,0,0,16},
{0x0f,0,1,0,0},
{0xbf,1,0,0,0},
{0x57,0,0,0,0xffff},
{0x77,1,0,0,16},
{0x0f,0,1,0,0},
{0xa7,0,0,0,-1},
{0x6b,7,0,ICMP4CHKSUM,0},
{0x61,0,7,IPV4SRC,0},
{0x61,1,7,IPV4DST,0},
{0x63,7,1,IPV4SRC,0},
{0x63,7,0,IPV4DST,0},
{0xb7,0,0,0,IPV4SIZE},
{0xdc,0,0,0,16},
{0xb7,1,0,0,IPPROTO_ICMP},
{0xb7,2,0,0,0},
{0x6b,7,0,IPV4LEN,0},
{0x73,7,1,IPV4PROTO,0},
{0x6b,7,2,IPV4CHKSUM,0},
{0xb7,1,0,0,0},
{0xb7,2,0,0,0},
{0xbf,3,7,0,0},
{0x07,3,0,0,ETH_HLEN},
{0xb7,4,0,0,sizeof(struct iphdr)},
{0xb7,5,0,0,0},
{0x85,0,0,0,BPF_FUNC_csum_diff},
{0xc5,0,0,115,0},
{0xbf,1,0,0,0},
{0x57,0,0,0,0xffff},
{0x77,1,0,0,16},
{0x0f,0,1,0,0},
{0xbf,1,0,0,0},
{0x57,0,0,0,0xffff},
{0x77,1,0,0,16},
{0x0f,0,1,0,0},
{0xa7,0,0,0,-1},
{0x6b,7,0,IPV4CHKSUM,0},
{0x05,0,0,100,0},
{0xb4,8,0,0,ICMPV6_PKT_TOOBIG},
{0xb4,9,0,0,0},
{0xbf,1,6,0,0},
{0xb7,2,0,0,REDIR6SIZE},
{0xb7,3,0,0,0},
{0x85,0,0,0,BPF_FUNC_skb_change_tail},
{0x55,0,0,97,0},
{0x61,7,6,SKB(data),0},
{0x61,1,6,SKB(data_end),0},
{0xbf,2,7,0,0},
{0x07,2,0,0,REDIR6SIZE},
{0x2d,2,1,92,0},
{0x71,0,7,IPV6PROTO,0},
{0x15,0,0,90,IPPROTO_ICMPV6},
{0x61,0,7,0,0},
{0x69,1,7,4,0},
{0x61,2,7,6,0},
{0x69,3,7,10,0},
{0x63,7,2,0,0},
{0x6b,7,3,4,0},
{0x63,7,0,6,0},
{0x6b,7,1,10,0},
{0x79,0,7,ETH_HLEN,0},
{0x79,1,7,ETH_HLEN+8,0},
{0x79,2,7,ETH_HLEN+16,0},
{0x79,3,7,ETH_HLEN+24,0},
{0x79,4,7,ETH_HLEN+32,0},
{0x79,5,7,ETH_HLEN+40,0},
{0x7b,7,0,ICMP6DATA,0},
{0x7b,7,1,ICMP6DATA+8,0},
{0x7b,7,2,ICMP6DATA+16,0},
{0x7b,7,3,ICMP6DATA+24,0},
{0x7b,7,4,ICMP6DATA+32,0},
{0x7b,7,5,ICMP6DATA+40,0},
{0xb7,1,0,0,0},
{0xb7,2,0,0,0},
{0x15,8,0,4,ICMPV6_DEST_UNREACH},
{0x69,2,10,-10,0},
{0x55,2,0,1,0},
{0xb7,2,0,0,0},
{0xdc,2,0,0,32},
{0x73,7,8,ICMP6TYPE,0},
{0x73,7,9,ICMP6CODE,0},
{0x6b,7,1,ICMP6CHKSUM,0},
{0x63,7,2,ICMP6MTU,0},
{0x79,0,7,IPV6SRC,0},
{0x79,1,7,IPV6SRC+8,0},
{0x79,2,7,IPV6DST,0},
{0x79,3,7,IPV6DST+8,0},
{0x7b,7,2,IPV6SRC,0},
{0x7b,7,3,IPV6SRC+8,0},
{0x7b,7,0,IPV6DST,0},
{0x7b,7,1,IPV6DST+8,0},
{0xb7,1,0,0,0},
{0xb7,2,0,0,0},
{0xbf,3,7,0,0},
{0x07,3,0,0,IPV6SRC},
{0xb7,4,0,0,32},
{0xb7,5,0,0,0},
{0x85,0,0,0,BPF_FUNC_csum_diff},
{0xc5,0,0,43,0},
{0xbf,3,10,0,0},
{0x07,3,0,0,-8},
{0xb7,1,0,0,0},
{0x7b,3,1,0,0},
{0xb7,1,0,0,IPV6SIZE},
{0x73,3,1,3,0},
{0xb7,1,0,0,IPPROTO_ICMPV6},
{0x73,3,1,7,0},
{0xb7,1,0,0,IPPROTO_ICMPV6},
{0x73,7,1,IPV6PROTO,0},
{0xb7,1,0,0,IPV6SIZE},
{0xdc,1,0,0,16},
{0x6b,7,1,IPV6LEN,0},
{0xb7,1,0,0,0},
{0xb7,2,0,0,0},
{0xbf,3,10,0,0},
{0x07,3,0,0,-8},
{0xb7,4,0,0,8},
{0xbf,5,0,0,0},
{0x85,0,0,0,BPF_FUNC_csum_diff},
{0xc5,0,0,22,0},
{0xb7,1,0,0,0},
{0xb7,2,0,0,0},
{0xbf,3,7,0,0},
{0x07,3,0,0,IPV6MIN},
{0xb7,4,0,0,IPV6SIZE},
{0xbf,5,0,0,0},
{0x85,0,0,0,BPF_FUNC_csum_diff},
{0xc5,0,0,14,0},
{0xbf,1,0,0,0},
{0x57,0,0,0,0xffff},
{0x77,1,0,0,16},
{0x0f,0,1,0,0},
{0xbf,1,0,0,0},
{0x57,0,0,0,0xffff},
{0x77,1,0,0,16},
{0x0f,0,1,0,0},
{0xa7,0,0,0,-1},
{0x6b,7,0,ICMP6CHKSUM,0},
{0xbf,1,6,0,0},
{0x61,2,6,SKB(ifindex),0},
{0xb7,3,0,0,BPF_F_INGRESS},
{0x85,0,0,0,BPF_FUNC_clone_redirect},
{0xb7,0,0,0,TC_ACT_SHOT},
{0x95,0,0,0,0},
{0xb7,0,0,0,TC_ACT_UNSPEC},
{0x95,0,0,0,0},
};
#define TCE_FILTER_SIZE 666
#define TCE_MAC_MAP_L 23
#define TCE_MAC_MAP_H 24
#define TCE_ETH_MAP_L 52
#define TCE_ETH_MAP_H 53
#define TCE_SRC_MAP_L 220
#define TCE_SRC_MAP_H 221
#define TCE_DST_MAP_L 243
#define TCE_DST_MAP_H 244
#define TCE_SRC_PRE_L 212
#define TCE_SRC_PRE_H 213
#define TCE_DST_PRE_L 235
#define TCE_DST_PRE_H 236
#define TCE_ETH_MTU 264
#define TCE_DST_DEV 427
#define TCE_V4_MTU 500
#define TCE_V6_MTU 597
#define TCE_V4_ICMP 72
#define TCE_V6_ICMP 96
#define TCE_MSS_MTU 392
#define TCE_V4_MARK 74
#define TCE_V4_AND 78
#define TCE_V4_CMP 79
#define TCE_V6_MARK 98
#define TCE_V6_AND 102
#define TCE_V6_CMP 103
#define TCE_EXCL_MARK 164
#define TCE_EXCL_AND 167
#define TCE_EXCL_CMP 168
#define TCE_INCL_MARK 171
#define TCE_INCL_AND 174
#define TCE_INCL_CMP 175
#define TCE_MAC_HACK 417
#define TCE_NO_DROP 431
/* ========================================================================== */

static inline int bpf_create_map(enum bpf_map_type map_type,
	unsigned int key_size,unsigned int value_size,unsigned int max_entries)
{
	union bpf_attr attr=
	{
		.map_type    = map_type,
		.key_size    = key_size,
		.value_size  = value_size,
		.max_entries = max_entries
	};

	return syscall(SYS_bpf,BPF_MAP_CREATE,&attr,sizeof(attr));
}

static int bpf_prog_load(enum bpf_prog_type type,const struct bpf_insn *insns,
	int insn_cnt,const char *license,int logsize)
{
	int r;
	char *ptr;

	union bpf_attr attr=
	{
		.prog_type = type,
		.insns     = ((u_int64_t)((unsigned long)insns)),
		.insn_cnt  = insn_cnt,
		.license   = ((u_int64_t)((unsigned long)license)),
	};

	if(logsize)
	{
		if(!(ptr=malloc(logsize)))return -1;
		*ptr=0;
		attr.log_buf=(u_int64_t)((unsigned long)ptr);
		attr.log_size=logsize;
		attr.log_level=1;
	}

	printf("BPF_PROG_LOAD start\n");

	if((r=syscall(SYS_bpf,BPF_PROG_LOAD,&attr,sizeof(attr)))==-1&&logsize)
	{
		r=errno;
		fprintf(stderr,"BPF ERROR TRACE:\n================\n%s\n",ptr);
		free(ptr);
		errno=r;
		return -1;
	}

	printf("BPF_PROG_LOAD done\n");

	if(logsize)free(ptr);
	
	return r;
}       

typedef struct
{
	int offset;
	int value;
} BPFPARAM;

typedef struct
{
	int which;
	int len;
	int nfds;
	int nparams;
	BPFPARAM params[0];
} BPFREQ;

static int helper;

static int ebpf_helper(void)
{
	int len;
	int nfds;
	int max;
	int bpf;
	int sv[2];
	int *fds;
	BPFREQ *req;
	const struct bpf_insn *ptr;
	struct bpf_insn *code;
	struct cmsghdr *cmsg;
	struct msghdr msg;
	struct iovec iov;
	uint8_t bfr[sizeof(BPFREQ)+32*sizeof(BPFPARAM)];
	union
	{
		uint8_t ctrl[sizeof(struct cmsghdr)+8*sizeof(int)];
	} u;

	if(socketpair(AF_UNIX,SOCK_SEQPACKET|SOCK_CLOEXEC,0,sv))return -1;

	switch(fork())
	{
	case -1:close(sv[0]);
		close(sv[1]);
		return -1;

	default:close(sv[0]);
		helper=sv[1];
		return 0;

	case 0: close(sv[1]);
		req=(BPFREQ *)bfr;
	}

	msg.msg_name=NULL;
	msg.msg_namelen=0;
	msg.msg_iov=&iov;
	msg.msg_iovlen=1;
	iov.iov_base=bfr;
	cmsg=(struct cmsghdr *)u.ctrl;
	fds=(int *)(&cmsg[1]);

	while(1)
	{
		nfds=0;
		code=NULL;
		msg.msg_control=u.ctrl;
		msg.msg_controllen=sizeof(u.ctrl);
		iov.iov_len=sizeof(bfr);
		memset(u.ctrl,0,sizeof(u.ctrl));

		if((len=recvmsg(sv[0],&msg,0))<=0)break;

		if(msg.msg_controllen>=sizeof(struct cmsghdr)&&
			cmsg->cmsg_len>=sizeof(struct cmsghdr))
		{
			if(cmsg->cmsg_level!=SOL_SOCKET||
				cmsg->cmsg_type!=SCM_RIGHTS)goto fail;
			nfds=cmsg->cmsg_len-sizeof(struct cmsghdr);
			nfds/=sizeof(int);
			if(cmsg->cmsg_len!=
				sizeof(struct cmsghdr)+nfds*sizeof(int))
					goto fail;
		}

		if(len<sizeof(BPFREQ))goto fail;
		if(len<sizeof(BPFREQ)+req->nparams*sizeof(BPFPARAM))goto fail;
		if(req->nfds>req->nparams)goto fail;
		if(req->nfds!=nfds)goto fail;

		switch(req->which)
		{
		case 1: max=TCE_FILTER_SIZE;
			ptr=tce_filter;
			bpf=BPF_PROG_TYPE_SCHED_CLS;
			break;

		default:goto fail;
		}

		if(!(code=malloc(max*sizeof(ptr[0]))))goto fail;
		memcpy(code,ptr,max*sizeof(ptr[0]));

		for(len=0;len<req->nparams;len++)
		{
			if(req->params[len].offset<0||
				req->params[len].offset>=max)goto fail;
			if(len<req->nfds)
			{
				if(req->params[len].value>=req->nfds)goto fail;
				code[req->params[len].offset].imm=
					fds[req->params[len].value];
			}
			else code[req->params[len].offset].imm=
				req->params[len].value;
		}

		if((bpf=bpf_prog_load(bpf,code,max,"GPL",0))==-1)goto fail;

		free(code);

		for(len=0;len<nfds;len++)close(fds[len]);

		fds[0]=bpf;
		cmsg->cmsg_len=sizeof(struct cmsghdr)+sizeof(int);
		cmsg->cmsg_level=SOL_SOCKET;
		cmsg->cmsg_type=SCM_RIGHTS;

		msg.msg_control=u.ctrl;
		msg.msg_controllen=sizeof(struct cmsghdr)+sizeof(int);
		bfr[0]=1;
		goto xmit;

fail:		if(code)free(code);
		for(len=0;len<nfds;len++)close(fds[len]);
		msg.msg_control=NULL;
		msg.msg_controllen=0;
		bfr[0]=0;

xmit:		iov.iov_len=1;
		len=sendmsg(sv[0],&msg,0);
		if(msg.msg_controllen)close(fds[0]);
		if(len!=1)break;
	}

	close(sv[0]);
	exit(0);
}

static int loadbpf(int which,int len,int nfds,int *fds,
	int nparams,BPFPARAM *params)
{
	int *cfds;
	struct cmsghdr *cmsg;
	BPFREQ *req;
	struct msghdr msg;
	struct iovec iov[2];
	uint8_t bfr[sizeof(BPFREQ)];
	uint8_t ctrl[sizeof(struct cmsghdr)+8*sizeof(int)];

	if(nfds<0||nparams<0||nfds>8||nparams>32)return -1;

	req=(BPFREQ *)bfr;
	cmsg=(struct cmsghdr *)ctrl;
	cfds=(int *)(&cmsg[1]);

	req->which=which;
	req->len=len;
	req->nfds=nfds;
	req->nparams=nparams;

	msg.msg_name=NULL;
	msg.msg_namelen=0;
	msg.msg_iov=iov;
	msg.msg_iovlen=2;
	msg.msg_flags=0;
	iov[0].iov_base=bfr;
	iov[0].iov_len=sizeof(BPFREQ);
	iov[1].iov_base=params;
	iov[1].iov_len=nparams*sizeof(BPFPARAM);

	if(nfds)
	{
		msg.msg_control=ctrl;
		msg.msg_controllen=sizeof(struct cmsghdr)+nfds*sizeof(int);
		cmsg->cmsg_len=sizeof(struct cmsghdr)+nfds*sizeof(int);
		cmsg->cmsg_level=SOL_SOCKET;
		cmsg->cmsg_type=SCM_RIGHTS;
		memcpy(cfds,fds,nfds*sizeof(int));
	}
	else
	{
		msg.msg_control=NULL;
		msg.msg_controllen=0;
	}

	if(sendmsg(helper,&msg,0)!=iov[0].iov_len+iov[1].iov_len)return -1;
	msg.msg_control=ctrl;
	msg.msg_controllen=sizeof(struct cmsghdr)+sizeof(int);
	msg.msg_iovlen=1;
	iov[0].iov_len=sizeof(bfr);
	if(recvmsg(helper,&msg,0)!=1)return -1;
	if(!bfr[0]||msg.msg_controllen!=sizeof(struct cmsghdr)+sizeof(int)||
		cmsg->cmsg_len!=sizeof(struct cmsghdr)+sizeof(int)||
		cmsg->cmsg_level!=SOL_SOCKET||cmsg->cmsg_type!=SCM_RIGHTS)
			return -1;
	return cfds[0];
}

int main()
{
	int tcefd;
	int macmap;
	int srcemap;
	int dstemap;
	int ethmap;
	int fds[5];
	BPFPARAM params[29];

	if(ebpf_helper())return 1;

	if((macmap=bpf_create_map(BPF_MAP_TYPE_HASH,8,4,1))==-1)return 1;
	if((srcemap=bpf_create_map(BPF_MAP_TYPE_HASH,4,8,1))==-1)return 1;
	if((dstemap=bpf_create_map(BPF_MAP_TYPE_HASH,4,8,1))==-1)return 1;
	if((ethmap=bpf_create_map(BPF_MAP_TYPE_HASH,2,1,1))==-1)return 1;

	fds[0]=macmap;
	fds[1]=ethmap;
	fds[2]=srcemap;
	fds[3]=dstemap;
	params[0].offset=TCE_MAC_MAP_L;
	params[0].value=0;
	params[1].offset=TCE_ETH_MAP_L;
	params[1].value=1;
	params[2].offset=TCE_SRC_MAP_L;
	params[2].value=2;
	params[3].offset=TCE_DST_MAP_L;
	params[3].value=3;
	params[4].offset=TCE_SRC_PRE_L;
	params[4].value=0;
	params[5].offset=TCE_SRC_PRE_H;
	params[5].value=0;
	params[6].offset=TCE_DST_PRE_L;
	params[6].value=0;
	params[7].offset=TCE_DST_PRE_H;
	params[7].value=0;
	params[8].offset=TCE_DST_DEV;
	params[8].value=10;
	params[9].offset=TCE_V4_ICMP;
	params[9].value=1;
	params[10].offset=TCE_V6_ICMP;
	params[10].value=1;
	params[11].offset=TCE_ETH_MTU;
	params[11].value=ETH_HLEN+8918;
	params[12].offset=TCE_V4_MTU;
	params[12].value=8918;
	params[13].offset=TCE_V6_MTU;
	params[13].value=8918;
	params[14].offset=TCE_MSS_MTU;
	params[14].value=8918-sizeof(struct iphdr)-sizeof(struct tcphdr);
	params[15].offset=TCE_V4_MARK;
	params[15].value=0;
	params[16].offset=TCE_V4_AND;
	params[16].value=0;
	params[17].offset=TCE_V4_CMP;
	params[17].value=0;
	params[18].offset=TCE_V6_MARK;
	params[18].value=0;
	params[19].offset=TCE_V6_AND;
	params[19].value=0;
	params[20].offset=TCE_V6_CMP;
	params[20].value=0;
	params[21].offset=TCE_EXCL_MARK;
	params[21].value=0;
	params[22].offset=TCE_EXCL_AND;
	params[22].value=0;
	params[23].offset=TCE_EXCL_CMP;
	params[23].value=0;
	params[24].offset=TCE_INCL_MARK;
	params[24].value=0;
	params[25].offset=TCE_INCL_AND;
	params[25].value=0;
	params[26].offset=TCE_INCL_CMP;
	params[26].value=0;
	params[27].offset=TCE_NO_DROP;
	params[27].value=0;
	params[28].offset=TCE_MAC_HACK;
	params[28].value=0;

	if((tcefd=loadbpf(1,TCE_FILTER_SIZE,4,fds,29,params))==-1)
		return 1;
	return 0;
}

