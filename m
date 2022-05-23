Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29ED530B8F
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 11:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiEWIS0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 04:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiEWISZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 04:18:25 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB9EE022
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 01:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1653293899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DntHUj7knWLLm7c/5EUgn2jH1JaZAqHS6oosM0tRN64=;
        b=K3aGoESSbkWdbGOse5wvtH/rHlEpLpIzj59etK1c+U+RnJRi+URxzivq9UZbVd5brdoDuz
        fyh9VTJTP0Fm1nNcunntSpJr6vd5dEC9U8fWvO5QFf1Cz0X0GZLkmJ3cYL56T+YbGi1xQh
        ckEh/1fehRIxfz9GJmlCIWgDq4Do++w=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-yiUwkdZdNQ2I-tmKvC1bEQ-1; Mon, 23 May 2022 10:18:18 +0200
X-MC-Unique: yiUwkdZdNQ2I-tmKvC1bEQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huqqokJf3AKxBSlOFgpocxGJ83Z5PowLwVJV0l9Ahf296bNGhq2vrqdvp4EL02sx9xS6Xkj0P21FYCvthVeYc1wj2RLZv/hVansLxXXP2p9ccHaMOsADImGDA8fK4a7Jpchbyl7AmqxZCcjjtUkqv6QquEO5NItbL/emrP8Mj7vR2A4L0qI1dHIZXEWYGCRcmGVxIoVOjmv7E17tfg5pBr1x8LSkivlVIk3LqjJ+vqXyQJx9nxgDT7+3/OasO48+lPdLIjipMyt6Npu7DbDoDTBcBlzorlEgSV4KHJYhDI5FdWbev85efnELtXCpgmftXcRmio3KqgwuTOkICmI08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DntHUj7knWLLm7c/5EUgn2jH1JaZAqHS6oosM0tRN64=;
 b=Zu7loikURZlQKlr7mlkqj7S0+m8xwvn2R9IBLMms4uayGlYfsMQ2eC/I9W/AgIT44fummcDWMAPX0F+1c+xa3HnTe9xOTnRNpEna59kHmq3O5P3Qi43DP6By7M5qjz+HajuJZp8dyasnQ83WRtl5jBgiVV1BLvKU5w3ejS5l23Z9ajZm1Knha4JCNKUXz6TY/5O4Fs5AbGd5ZehjImBBdwaH9EH5p/+47ITCE+A2Q1yaj2XrOEjHjVzTVvVSMNyGqT+UcsFFLv27K51WjWAT91cRgalROawxKWstTSY60Qekx8rEwElO5/thUzFEPYIRwV60yTru6/HMHIq/+SQWXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by DB7PR04MB5017.eurprd04.prod.outlook.com (2603:10a6:10:1b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.21; Mon, 23 May
 2022 08:18:15 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::40a2:1b77:8319:a7fa]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::40a2:1b77:8319:a7fa%5]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 08:18:15 +0000
Date:   Mon, 23 May 2022 16:18:10 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Vincent Li <vincent.mc.li@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: libbpf: failed to load program 'vxlan_get_tunnel_src'
Message-ID: <YotDQtN4qhqBVi22@syu-laptop>
References: <CAK3+h2xA+K-yby7m+3Hp1G6qinafZPW1OB=Uk5-AKxUfztBtEA@mail.gmail.com>
 <YotBr8cRTx8qt8Ot@syu-laptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YotBr8cRTx8qt8Ot@syu-laptop>
X-ClientProxiedBy: AS9PR06CA0527.eurprd06.prod.outlook.com
 (2603:10a6:20b:49d::27) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73c8d7a7-bd32-4be3-7f64-08da3c94c915
X-MS-TrafficTypeDiagnostic: DB7PR04MB5017:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB5017A6146339A956DA0C9F28BFD49@DB7PR04MB5017.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HogdWchfqiM+Yg874WOFF5oZWQbKeagc1qRvUxhDgb0IgQPhx9Zhhilgh5a3xtqhuOSIdawNw+SsC4tNX7H6aBdsck8EQHPvhMBiHr26JiERAPY7lPn+rJkjfpg6gM3bUs6n36mmQY0DcuYqE3Rhnl0AMj65X3Q9o0qywCsg+pGWkJ++GGaLusOmFHI3Fl6HxNYJRUD5WGHB4OwYqTOhqSa6MfIwxVW7Lloot82Db6bMYr7qBPNqQ5GxfoZ066xmhL1IKE1e8SRy3nxlgcYTJVjyd9rwpei2p2nQuWA9iBa1xlwvNHCM1O0zp6n9zMGuynzqnewGOsyoatBRjHH0G2wcKxjRSrPfUZFjmkMfM9IRwYdZP5fgWnLl/yoFEaTrewplsoJ18A+ZueUysRVC1tIuiWAYZOk/VpY9kyZN3D9knLJ7cI5q3cOr05lAqlJ4yaGCBZPg6yH/WceRjbdCF/ko8JMaeo24qq0RpONQFdVABf319nxc9aXGOn6VA1GPvicRyYWqKaFEndfqjUdeD1WeAlbjW0aF30eOZSyFr20S2zi2V3iLzDJ9FTk+MTFN36pAo34/R7AbZVVAwjZsnP+zbLzyM9Nr8DnRwK/qPLjbiZDMwQQsive6CYyYftGHX6U+MzKZN6W7q8//yYEobJpETW13oKMZz5oMkyh9v/RPS1Znbrigm3fmT3zBihhuaf08AoQ+n48HxyrWLJ0eP9mOGSdqC42c21SUK0Kd2lpCQJXv98pPQPAH9w2g4rbmFfhKBjygDSs64guhKsfy/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(33716001)(966005)(4326008)(86362001)(8676002)(66556008)(66946007)(66476007)(6486002)(6916009)(316002)(186003)(83380400001)(26005)(6506007)(6512007)(38100700002)(9686003)(6666004)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0VtU0g3K2owMDJwSVZGc3g2ZGhQdzZXLzBhVW4rc1pTRjgzSmVlQWg3Q1ZY?=
 =?utf-8?B?QXVOc2dTVWczN1I0ZXJzbENYZ1U1em9OOEtRRUR4dzI2WjZ6RFdxMWZkRGJn?=
 =?utf-8?B?ZWRITHh2a0dMa1ovMGF4ZHF6bjZjeis1RHVHY1QxQjFjNVgyYlI4aUNqQUxF?=
 =?utf-8?B?cXd6MHEzUVBkWS9IOHlwUG82SUhWcUpnYkxVNHFxdXNDdlBmSDhPemN5aFpi?=
 =?utf-8?B?eFpkZjRBU3dtZmRBZTNYTDhqeERkVnFoOXdJdVlMZGVYSUYyTmV4cFVnQUJM?=
 =?utf-8?B?WDZ4eHlqTFV1OTlqYy9Qa3pWa1hsekRndFk4eCtOWG94NlRmSk9EYktLZE1a?=
 =?utf-8?B?MTI5VlF4VjM2eFhLSlRscXlaTWthdFBqZmptdXlhU2JkZ1hlendqY0lVNTN5?=
 =?utf-8?B?NCsydGdBa3Q5YWRZU01MN0duZUd6OFpKZEpyUG9VSEJ4blZLSTY5RHN2aXor?=
 =?utf-8?B?MzZPWUZtVGVucnlUaUFRSDBYdmtYNDdOQk9TdVJKVTFlTlF2S3ZGZTBOR2lD?=
 =?utf-8?B?cERWLytYUko0Q1ZobGRES3IrQVVSVHNHVlhNazF3NjBXVXM4QVMzazZnYjlV?=
 =?utf-8?B?c3ZPRnRoMnFvMWNIOGZma2N6cS8vbGJPSnhLbFdoQ0wzdHZ4Nk50MlRJWWx5?=
 =?utf-8?B?VEtGU2txMENoME81Szh5Nk81SnB6dXVPMk51RUdpYWVBZUlBamYvajVaWVFJ?=
 =?utf-8?B?TjdPbGY3SmNTaTR3QjdPNTFXamlRRUs2WHJGeUhFemdWWXBpdG9CeFlTbnJJ?=
 =?utf-8?B?dGQ2N1k0OExZWWYyOGFBdldORXF0aVpWbytVQVBmanZBQ25TQkE3MHN6K3ds?=
 =?utf-8?B?c05FbDhxOGZRNlVJZGVib0ZNWkRRMG1laWxmVkNlYThPRktRcHpGSnZ6Y2VS?=
 =?utf-8?B?b1ZnamdsWmxXbDk2M0hCc2Myd0trUFZtR3cvODlyeEZDL3VSVzlrNHJ1aWZu?=
 =?utf-8?B?dHV6dDl4T1NodzhTajhHbnhqMEkweVVteGkzR2R3UXBlKzZrdmViZlhlWXlh?=
 =?utf-8?B?N2ZTRzlmUytaTkdNc1VwL1RyWVVYWjNCQURFbE85RWhDTEM4TzdZYnBnaitK?=
 =?utf-8?B?T201b1RBblQ2UVlleUdlakNNdkNpVEJFTzhCakZsUXJXUlc1NHMwRFVpVkdy?=
 =?utf-8?B?MC9Tems5MkdYVFlsbXRmK2pod3VSNFJmbGMzMndacWJHbGhZdlRTZm5Ndlow?=
 =?utf-8?B?QmFNWGNqcHdOZXZsUXRjQmc1Z0JWV21IeWhEQzU3dnpXOW9FdlllY25qYTcx?=
 =?utf-8?B?SGtLQzVvVEhXZSs4aktOL0FRdWI1aUQ1TWl4NHNEN3pMeEVyV1RaVGxxTVlT?=
 =?utf-8?B?Q0VZZ2J0bGd2RGU0VXUvRWloT1VJYmpIbUZ3T29qakdGWWk2VXc5ZTRPWDdL?=
 =?utf-8?B?UGxXTWpGQ2NpeTd4OHg2TExJdGtZa1RtLzJETi9PVkhyeGFmNWpuMlZTSXh4?=
 =?utf-8?B?bHc4YktPYlNuaGthZFhlVG04TWNRVEV3MkxhVFptRzVuRi9VRElHRm5OTEJO?=
 =?utf-8?B?cWQwRW4xNjU4cFMxd2doV1F3WHJSTHhINE5YTmNmQXM5MjN1VVVlcXlEbmxY?=
 =?utf-8?B?amRsZ2tZdnVJb1lSRTZhS2g1dkF5NEtYV1FZMTZ3RjJRajlORVZhWDBEa2or?=
 =?utf-8?B?RUV2RTdEUGVkM1VtNVRMeHF5UDFDMFU1alVCMlNQalc2VENiZm1EMm5XNDlx?=
 =?utf-8?B?azhrWkwzZXJDL0ozVkozNXZoRmcrWisybnppVjB6ajlXTEY1b01tUG8zMWl0?=
 =?utf-8?B?V3N2eU8wVzE5ZklnT2ZtQkNFbUdhMGJOUXBab2E1MFJWOUl0UmFtOGJTa3do?=
 =?utf-8?B?QlYxc1pXY0FWdU1pYlZIYURONnNMVDZqVGIzY25XZUhVRlozMFhMeVN6bGtP?=
 =?utf-8?B?UmxCWjFTZVJ1SkU3WGhFMWc1TS9CNzNZbTJSNWJZV1haTXJuaVZDbmpWUElE?=
 =?utf-8?B?YXQ3SWs4RVgrYWJGRkt6ZWJXZ2hwZldCVE5LY21Nd2QrcDVtVFd2T1ZVZkV0?=
 =?utf-8?B?N29LanNqUEhUUlQyOXlGZWxyaW9tYktjTHZSOHdscHdvNXJQY3VobDhPL294?=
 =?utf-8?B?b0N3SlRIWEhiSThIV09ZeGhGL05yTzNYK2RWNlN5TUVDZ3dVQXpwVEFqM1Rv?=
 =?utf-8?B?TW1xMFpFdGkzY0oxWmh3a1k5bU1LSDBpYm1wbkZpTmt0NWdsOUNnZDRYcVRO?=
 =?utf-8?B?SC8wSmhLVEV2endQbkh3SWpzV3ptNDlSR3FTZU5MUkxIL2pKZkdJRkdKbUhr?=
 =?utf-8?B?VWl4OVFLVWVTbUVpNHQ2aHZzcWpUNmNtcU9RWXJaWGhUNUtRWDhyL3g5K2xu?=
 =?utf-8?B?YXlLdWRQQjlQRTh3WUM5QnEzcjhmbnh5Z0Z3TzloNXFtQ1hNcUZsZz09?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c8d7a7-bd32-4be3-7f64-08da3c94c915
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 08:18:15.4208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eca6g89pOp7xqpdEu0HyH+x5D83S+YI1XsVeXwVwsbc4pyKpQ69J+6a4OucTuTCYFThRVYkkFUcsbP3qGPPTEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5017
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 23, 2022 at 04:11:27PM +0800, Shung-Hsi Yu wrote:
> On Thu, May 19, 2022 at 08:25:00AM -0700, Vincent Li wrote:
> > Hi,
> > 
> > Here is my step to run bpf selftest on Ubuntu 20.04.2 LTS
> > 
> > git clone https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> > cd bpf-next; cp /boot/config-5.10.0-051000-generic .config; yes "" |
> > make oldconfig; make bzImage; make modules; cd
> > tools/testing/selftests/bpf/; make
> 
> [snip...]
> 
> > ; bpf_printk("vxlan key %d local ip 0x%x remote ip 0x%x gbp 0x%x\n",
> > 
> > 46: (7b) *(u64 *)(r10 -88) = r2
> > 
> > 47: (7b) *(u64 *)(r10 -72) = r1
> > 
> > 48: (61) r1 = *(u32 *)(r10 -48)
> > 
> > 49: (7b) *(u64 *)(r10 -96) = r1
> > 
> > 50: (61) r1 = *(u32 *)(r10 -44)
> > 
> > 51: (7b) *(u64 *)(r10 -80) = r1
> > 
> > 52: (bf) r3 = r10
> > 
> > 53: (07) r3 += -96
> > 
> > 54: (18) r1 = 0xffffabaec02c82af
> > 
> > 56: (b4) w2 = 52
> > 
> > 57: (b4) w4 = 32
> > 
> > 58: (85) call unknown#177
> > 
> > invalid func unknown#177
> 
> This should be the reason that why vxlan_get_tunnel_src fails to load, the
> kernel does not recognize the helper function that the program is trying to
> call.

Just realized Andrii already pointed this out in an earlier email. Consider
this an expanded answer to his then :)

> And that helper function is bpf_trace_vprintk (determined with v5.17.4
> vmlinux).
> 
>  $ bpftool btf dump file /sys/kernel/btf/vmlinux format c | grep -e 'BPF_FUNC_.* 177,'
>  	BPF_FUNC_trace_vprintk = 177,
> 
> Based on your description you're using a v5.10-based kernel, which explains
> why it doesn't have bpf_trace_vprintk(), since it was not added until commit
> 10aceb629e19 ("bpf: Add bpf_trace_vprintk helper") in v5.16.
> 
> The call to bpf_trace_vprintk() comes from the bpf_printk() call, which is
> actually a macro that uses either bpf_trace_printk() or bpf_trace_vprintk()
> depending on the number of arguments given[1].
> 
> In general I think it'd make more sense to run bpf-next selftests on a
> bpf-next kernel, either compile and install on the machine that you're
> testing on or use tools/testing/selftests/bpf/vmtest.sh which spins up a VM
> with suitable environment (though I haven't tried vmtest.sh myself).
> 
> 
> Shung-Hsi
> 
> 1: https://github.com/libbpf/libbpf/blob/master/src/bpf_helpers.h
> 
> > processed 64 insns (limit 1000000) max_states_per_insn 1 total_states
> > 5 peak_states 5 mark_read 2
> > 
> > -- END PROG LOAD LOG --
> > 
> > libbpf: failed to load program 'vxlan_get_tunnel_src'
> > 
> > libbpf: failed to load object 'test_tunnel_kern'
> > 
> > libbpf: failed to load BPF skeleton 'test_tunnel_kern': -22
> > 
> > test_ip6vxlan_tunnel:FAIL:test_tunnel_kern__open_and_load unexpected error: -22
> > 
> > serial_test_tunnel:PASS:pthread_join 0 nsec
> > 
> > #198/2     tunnel/ip6vxlan_tunnel:FAIL
> > 
> > #198       tunnel:FAIL
> > 
> > Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
> > 
> 
> 

