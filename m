Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AC0530BF0
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 11:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiEWILn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiEWILi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 04:11:38 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660D9B35
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 01:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1653293495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2MM3N5svHMtUEvcGXasPNXfddhMLnluM34nhs8YJlBc=;
        b=NrS3emsvaTjAGZjCcdNVBIvbfamdDQzcAKmld86ZI/Rb83KeKE5jSp6qEdLQbLSHaG/TMP
        cVmxyWhWGy+FHIUyq55FfdxCCsgxyK+Rcc9TqzLyct+UVH3tOS3iV9naFZMO3V9IbSDaAb
        sDI6LoiAbZFEsvy0l8/IytYb53ItMpY=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-aXdqb0_sMG-joiafrWsO-w-1; Mon, 23 May 2022 10:11:34 +0200
X-MC-Unique: aXdqb0_sMG-joiafrWsO-w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S114x6VNf+P57gnqtUoJv5eot6NVTHGmVw+LaPKJb33U0Xi376jczYevBB5iS9anMBgYV0PHVKbc8gvSYD9fIqwn0RxNZQ26ut9bUVMEbVLLSH8JytICM2S9XhJAtl72J8Nl73IzNj0KvBC+3JkXlfliPpE7x6wx/5hzXj+aVCmr346qE0ZnTR+iflSsj2RbuB3NQZ9ACS8n9TI1LsXCpUtjie83VYg+zQ5X+ZzayzpVw8e619Tz3q8HtrTrkoZ4gd8Sr7xnYK3z+89Gl1Gcn+BV5ydH5yBMOx4lFNVqATaptJxbWLMv9Yqnpzdiq5896LtV2KREYCTDwmVp8FTzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MM3N5svHMtUEvcGXasPNXfddhMLnluM34nhs8YJlBc=;
 b=dfjxG0SoxVrQWoOmb1zS29K4vwqO6JXYlPcWmoi4go91C/Ihm8+p3tIWsB9/iGhBczKsFstvntQbDieLk8x04TaGaH3+m525JBJ8UpJzgU78sBDhTkyIC32O6pOCzTwN6/YuyquzPsSr52v6V6HJ7AYNRjH9aNHrfSL+zpqyjj4SzhQk8BpoWdAje4aRIUlfEPLcA+lSKExmCmKHb3LO1DQQ2CddV84gipXsxjeSwpGeHdiB7lFt4gsjf79XwUIklOOIIVHFOH9azc6PC5KrsR+WnmqY02yi8zPDPVSHdfOJaNJZEivVYLmkCK2N46Gw4oYTFq0tv5sVcdfdXO6OLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by HE1PR0401MB2444.eurprd04.prod.outlook.com (2603:10a6:3:83::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 08:11:33 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::40a2:1b77:8319:a7fa]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::40a2:1b77:8319:a7fa%5]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 08:11:33 +0000
Date:   Mon, 23 May 2022 16:11:27 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Vincent Li <vincent.mc.li@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: libbpf: failed to load program 'vxlan_get_tunnel_src'
Message-ID: <YotBr8cRTx8qt8Ot@syu-laptop>
References: <CAK3+h2xA+K-yby7m+3Hp1G6qinafZPW1OB=Uk5-AKxUfztBtEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK3+h2xA+K-yby7m+3Hp1G6qinafZPW1OB=Uk5-AKxUfztBtEA@mail.gmail.com>
X-ClientProxiedBy: AM6PR10CA0089.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::30) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd366aec-61d8-4b0e-581d-08da3c93d929
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2444:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0401MB24445702E331E4E4C52E0A86BFD49@HE1PR0401MB2444.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7IKFyhoIJ6jV0jS9PamwkhToHnTfvbUDPx/vK1i8vZH0lxSH0r9wQupL2zqAIyzObwMBLrgGVczQ12EfGPCuxEYGn6+PdopGRF0iAG/YJuquVZaZqUb87DCCbLQSDaYKEpBMa8ISAyynkK5pe8pQkxTil6zM+qbM/JQsMTXls9qo8rv6Yo31P22LCv24nfKWMA1/bHiDRvyorQAzkqIt1aLz4CwD0TNSqcHj3ieKJ5c/87x36pGVtt4CJXl9/9sjDX5JOlQNbsztqNMMknp31uQ4X02m8cS5BM091iiAXt7B65KPoYpq2TxMf3B+GV42jOlhBarlkzkAvpalAWHmkQXWGohHOd8YuVtD16PhmOpn8lhrp+EASAFJk4sYvGIHLqJ4d/t49pZISKE9P1cPOYbwddQ0Tn9K3chMRpFSTckWqwyyIbCQ53MtjloPRQQFFikSA1EqN80zu0iKbUNnpe2PydSUzvLajsYeverUgF/JaE6iDlcRFGjjobaFAaoR0tHKbFDI1+2S+B+gShKjJu/joRzigMj5buV3vy3KCjq2yW3B9rd9Rn3NSlbwyBYeMWJC+4D7xcsIOgBeBlaLAkuZq7jRYjjtLYF3wCVHTAJgARtDzHiGLkHt5OWdECGZiuwN5l1me3VGTepQNSTvUkz2PV6+rpBqn7ey0I2IKKYfCadwrKIFnK484daFxomcEpCa4e7uC46q90VrXS3XBf06NlzRWNBgC86NHT2hmNUGAuOTmVLaak+FF+O8ABH3hhZm7xC/r5YO4BvKjeIfWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4326008)(316002)(66946007)(5660300002)(6916009)(8676002)(66476007)(66556008)(38100700002)(966005)(86362001)(6506007)(33716001)(83380400001)(186003)(8936002)(2906002)(9686003)(6512007)(26005)(6486002)(6666004)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3hTeG15b0cxcEFISW13MnV6WjhRKzhESjhVN0djZElTeHQvMTd0V2Z3TFJC?=
 =?utf-8?B?NTM0TStCYUsrcWNiYkwwZ3VSNFB0aDVHcTBHRHR6d3VxTm9WbWJXUGxWendt?=
 =?utf-8?B?cVAvd0NmZXVRVXJKMTJlc0YzZFY0eE51MmdZZ2VzcTVlb244VFE4aG81WEFJ?=
 =?utf-8?B?QVgvZXQzR3lZRnpMdzJQL2dPVFpiMEJxbWgyZ0ljelZpWSt1VjUrY042aEMr?=
 =?utf-8?B?Qkc2djYxcjJISlBic3pZb2pPdW9WVEM4MWV4OWVOZjJ4NWJmQk5jT1ViRjN6?=
 =?utf-8?B?T2FlQWZUeXJhNVhtQk9hK3RRVE1hVW5KSEpKUEltRFdWQ243YkhvK0prbG1D?=
 =?utf-8?B?UGU4K1F2dUh4eTBCdWFwTmNhck1aeGtFeDE1UEhaZ1ZSVFE2M0ZReDRZY2V5?=
 =?utf-8?B?ekRLcHZnUWdWOVlMVUF6YXlwNFJ0bXB1a0Q3Q1JYYklNRHN3TVhYT1F0Znpj?=
 =?utf-8?B?VldGZ1lIVk5PMzJUdGE3UzJBQ0gwaGhyZjN1WmxWWFE3UUQxSm5jQUZ2SUg5?=
 =?utf-8?B?Z05GZXJTUytzWkNqTVRWQ29UNHdUY1ZpV0xKSkZVaVNuTExka3ZQa2Jabk15?=
 =?utf-8?B?d2g4clJScVNVdEU4VDBxN010ZHFHQit0WTNjaVI5aEE0Z3ZzMkhXcXdPajNy?=
 =?utf-8?B?K3EySUZveXVjR2FQVzF3dEJTbzdENUt1c1lPbk5JSmcrVC8xOWZIdlpLa0J3?=
 =?utf-8?B?K1lvdEFnaHJOTjV6ekVzYWZac0dsNk1wVDZLU0RyZEFva1MzNFBvMDIrdDZX?=
 =?utf-8?B?L09TaVhoS3NPM2lnNFBQdFB3eW8xdzNwSDJrTndGS1ZZU1BrVlFhWER3MHdx?=
 =?utf-8?B?c3JlWU53RGZ0NUtuR291ZjJzMmFmWEdiZ3RLQ1BIUnE4VzY3OG1rbTZ5Sk9K?=
 =?utf-8?B?QnRDam4rcVpmTlJuZ24rdVVhSll6UnJrZkxZQ3g3Wkh1bW1UenZ4S2U1RVBW?=
 =?utf-8?B?YklXSzdUNTBYakppVGNoU3JCVUpJVWRnRm04MGh2ZjZVckhINlJHY0dCanRJ?=
 =?utf-8?B?VFVqNDh1UGRJWkNJOFhkRWhjQWtBamU0UXRqMllaWWVkVXhEUlJQSHpmTnNW?=
 =?utf-8?B?d2YzZnArbmk4ZDVjaWZFNXF6Y3hIdTQ0TEh4TlUvRVNabUNCM2NlTTZxd29L?=
 =?utf-8?B?eEUxNmFvQVNDTzYvSkk5YTRvdGtNRGk1L1BSc3RMUDBreDdZU294aWhvREFv?=
 =?utf-8?B?TjI0elZ2RmQzbnkrdkZKUWFTMXVSWmMzcHZLY3dUMHNoSUthSDFUMWtHMGFG?=
 =?utf-8?B?Sk9VeWhXdVpyRFd6Q3RvOUhhTkl2czc1UkpabmFGVmpHMXVGK0NHOUhuelJ2?=
 =?utf-8?B?V2Y5QVY1cGdkMG1yVHNUREFkYU5QYWhaQzdQZFd1OHdrc0hJRnVLZVpBMFJs?=
 =?utf-8?B?ZHlGMlQvandsMndiL0lBMTFNdVFFNUNnb1U5Z3hhQ1crSDllMGxDNjJFM1hp?=
 =?utf-8?B?c1N4MXBxSmNjYU5hT0thVWwyakYrZE0wRDhkMS9idlhpY1hlN1R4Vit1NGQw?=
 =?utf-8?B?Nk1YKzYvK2pUcDZ4Z2tOYzA2djdrcTBDOTIwRkpYY1JEbFlQREhySVZmSURy?=
 =?utf-8?B?ZWtza2N2UVNaUjh0U01UeWZDMUZhcjdicjBYUkRveFlGWXhzaDRtd0p6dmda?=
 =?utf-8?B?dXZraEQ5UC8wb01kMVpjN3UyRFJPSkVyVXNuYUtzR1pyVDJOdVNHSUo3eVpa?=
 =?utf-8?B?a2VVeTAwc2VhZjdiTHdzY0NIelQzeGhleFFoMVlIditJMTZNd0lIRUhCak9O?=
 =?utf-8?B?WGNxMXBPSndYZStlOU9GemNJaWp2dmVGYU9GSXc3dFEzVTFKQ3RHTk1HdXdk?=
 =?utf-8?B?dis3eEpmb2FZY08vL252K2pQK1RCRkdpR1ljc0h2QjFZVnp4akhIK1RXdmxs?=
 =?utf-8?B?RE40aFVhK1hhTzRQT2JhWVQ5WWRhUzkwcEE5Um1SckpnbXdlMTY2R3hOclZ4?=
 =?utf-8?B?VVVHcjQySmNDVS8yMkVTWGxWWCs5VWh4M2lURm1janIxeHA3Umt6MGJzRjFt?=
 =?utf-8?B?eS9SRnNYWnZ1NDVFdE5sTkRKbUtTVGtWREVEZ1NmZHR5ZHd0c2hpYVdWZ0kr?=
 =?utf-8?B?MTl2UlFLKyt2amg1M3V3WlR6NDZLcGtMT3lmcmZNc2JOc1ROSHpsNE05QTBy?=
 =?utf-8?B?ajZGdzhBdExaeGNuVnFQa282STFkb3IxWU9lNmsrak9tMXNDZ3lGNDFLak1v?=
 =?utf-8?B?NVRWRE5KZWRnZUd3U0VzZFRWZVR5Y0RwR3Z3YmhCWk5zN1QrVk1hRnVwK24x?=
 =?utf-8?B?a1dCWlJXZkhDNUpzaWpjTkxBUHQ1ZHd5aGp4NHB0bTFEZkN4aXpzVmdjVTdk?=
 =?utf-8?B?OVZLUlEwSnJ2MXZZdFc1QS9CMkR1WTJUU1NITHJNVDg0SWNXdjNiUT09?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd366aec-61d8-4b0e-581d-08da3c93d929
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 08:11:33.0851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4mSIxi7TtrU7WLK3tAXf+g5xzzNNP7BC4DVv2iT67BEQqyFBQgHDz7HYzfWZRmZYrpzBzn7ZylyICVrhBM6ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2444
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 19, 2022 at 08:25:00AM -0700, Vincent Li wrote:
> Hi,
> 
> Here is my step to run bpf selftest on Ubuntu 20.04.2 LTS
> 
> git clone https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> cd bpf-next; cp /boot/config-5.10.0-051000-generic .config; yes "" |
> make oldconfig; make bzImage; make modules; cd
> tools/testing/selftests/bpf/; make

[snip...]

> ; bpf_printk("vxlan key %d local ip 0x%x remote ip 0x%x gbp 0x%x\n",
> 
> 46: (7b) *(u64 *)(r10 -88) = r2
> 
> 47: (7b) *(u64 *)(r10 -72) = r1
> 
> 48: (61) r1 = *(u32 *)(r10 -48)
> 
> 49: (7b) *(u64 *)(r10 -96) = r1
> 
> 50: (61) r1 = *(u32 *)(r10 -44)
> 
> 51: (7b) *(u64 *)(r10 -80) = r1
> 
> 52: (bf) r3 = r10
> 
> 53: (07) r3 += -96
> 
> 54: (18) r1 = 0xffffabaec02c82af
> 
> 56: (b4) w2 = 52
> 
> 57: (b4) w4 = 32
> 
> 58: (85) call unknown#177
> 
> invalid func unknown#177

This should be the reason that why vxlan_get_tunnel_src fails to load, the
kernel does not recognize the helper function that the program is trying to
call.

And that helper function is bpf_trace_vprintk (determined with v5.17.4
vmlinux).

 $ bpftool btf dump file /sys/kernel/btf/vmlinux format c | grep -e 'BPF_FUNC_.* 177,'
 	BPF_FUNC_trace_vprintk = 177,

Based on your description you're using a v5.10-based kernel, which explains
why it doesn't have bpf_trace_vprintk(), since it was not added until commit
10aceb629e19 ("bpf: Add bpf_trace_vprintk helper") in v5.16.

The call to bpf_trace_vprintk() comes from the bpf_printk() call, which is
actually a macro that uses either bpf_trace_printk() or bpf_trace_vprintk()
depending on the number of arguments given[1].

In general I think it'd make more sense to run bpf-next selftests on a
bpf-next kernel, either compile and install on the machine that you're
testing on or use tools/testing/selftests/bpf/vmtest.sh which spins up a VM
with suitable environment (though I haven't tried vmtest.sh myself).


Shung-Hsi

1: https://github.com/libbpf/libbpf/blob/master/src/bpf_helpers.h

> processed 64 insns (limit 1000000) max_states_per_insn 1 total_states
> 5 peak_states 5 mark_read 2
> 
> -- END PROG LOAD LOG --
> 
> libbpf: failed to load program 'vxlan_get_tunnel_src'
> 
> libbpf: failed to load object 'test_tunnel_kern'
> 
> libbpf: failed to load BPF skeleton 'test_tunnel_kern': -22
> 
> test_ip6vxlan_tunnel:FAIL:test_tunnel_kern__open_and_load unexpected error: -22
> 
> serial_test_tunnel:PASS:pthread_join 0 nsec
> 
> #198/2     tunnel/ip6vxlan_tunnel:FAIL
> 
> #198       tunnel:FAIL
> 
> Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
> 

