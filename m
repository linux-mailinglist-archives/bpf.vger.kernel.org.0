Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDFA6EDB51
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 07:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjDYFpd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 01:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjDYFp1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 01:45:27 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616BEBB9D
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 22:45:18 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P4gV46012160;
        Mon, 24 Apr 2023 22:45:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=uZcbaytkWWGePin2/DHjU7xYnB7pHn+iTJrg4iMVJcU=;
 b=nJ0XaBm1JTISaEraDqqAIbBBXQWrnwXsJyDNXq4z3cnHB2LJ1HA2R5MnC/nvSlUMzggz
 iUgggIvh0CzDMVhpRsGkKf0EWYw7kddYpU4id/jc96hxPKRt8ws+DfYueYcQZg9eYxCS
 ENuEEvM4zmf7Aleh7w/9booDl4OY0uAxglwe8Z8mJkB9S2Q3p89jvPbTB9Lpw08sjVUf
 SEsuZpf84le+aLtu6K3i4ye/DMQOrwRZLoeb37ZyRnhs9zLnsiT7oLVk6I0Gz4CqKYGZ
 LPUUHtBqNJQnAbhGYwMOcEbXv/8b3+trWd1hr3CdPRSor6mowdrUqJWhTvPNoBM4/DGu ow== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q5vaqmtrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 22:45:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8TXF0V8juy742NevOFYW+VSgjLYtXLiIAehyAWVWkuYXI0OBYZg7U4mMjIDetU2/csZ9YuuiUMTOGs4dnWPiyVfzRwzwTHtpocY2TR+aaKaC1A9pEVZKycVqcfHsPvlGU4OLfy0wpsefETyGe7HO+W302eZIhsk9DiQ6Fp6ZQMwKXxX/41Sa6+wGe1vT8mV4JiaZE2zMuINN7Co2fHMHPY6EvXGrCYwFH4ozaTcv/A+IU7u0ZozhcASd81B+kYBFMEuk/iTKioHnyDIjV//OICMEjUFRskXhEtg8jRZp+XxtBmJPGJCRD3Ija/r/jyNf1s3+BXhOpaR1BZCZDj9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZcbaytkWWGePin2/DHjU7xYnB7pHn+iTJrg4iMVJcU=;
 b=fcHGhkCCHru3K7+fAxifHttehM5cdu+saUnkvHGoRzwqS22ATrWbqVzxrl/BFRB6g4hOEOaBvroLSgXOU2zHgOXtcvU7Z0mK+wNwiIfU+B6XVfn2L+z6T3HKLjhnys3j421qLqqJmv5RQhjW719CT5DwuGQmi4sHZZFroIsZvg4LJt7YHLBHhmtEzwlLXtX9AervLy2DDSE/ZPB1Dd97uROpnYF4LbdDBDph3Qa6LVdm2sh+oQtptpGlj7eWkqrtt5BskBh/99qqvcbQfv3rfvOMke9jR3waCFhFJQ/mWyG5Zq48pNancssOiHr1sQgkYz4XNk9O4AQt/frsEO2BCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW3PR15MB4042.namprd15.prod.outlook.com (2603:10b6:303:49::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 05:45:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 05:45:14 +0000
Message-ID: <e0a2d975-9160-57d1-1368-21df73ff3273@meta.com>
Date:   Mon, 24 Apr 2023 22:45:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 1/7] bpf: tcp: Avoid taking fast sock lock in iterator
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>, bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
 <20230418153148.2231644-2-aditi.ghag@isovalent.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230418153148.2231644-2-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:a03:255::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW3PR15MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: f8427ef6-2657-42d7-7867-08db45503d85
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cAKP6RKSTUGAlP91LHyHm/87zQ8yKi7C0t8JvyAnuZnWiudqKihuZB4R79QEFlX8eDeDGH1oHgMet3iGoW5hmg2PZDc+boAakcTWZo082/dK6AwGX56nN88rdFgfkBCl/d5PiO90wvzrc4v5Cts3MB1R6JND38WTtXQDLI/DHyJ43171M4OSVPxFvTFuqkSRiIqlM1NMB0rlbcF0RukDTR8/V8YpmizC4Eb8Di5COZJ3NPS03A0QFPGpO+FMQ5h/Iv/xEnrKuyCK0xnCgbBuTtBk7warHkFDAC3RQls7GYdvBmKka4hE4afm3vbOQTjO9jkFOq8d0WeGWdCB3LsdCeN9R8nvl9ODgEVgv4MoS23pcz1BstC/Mz9+lEaXQ8niij/QWRQz0omJSPNO0q6qUJZX2hWMSQ+AioLSZKJFBozWe3SxLFpQu53VIpbXdUPcHyqBf8NJSI5w3+uMPUmHJGHOl06SIPlHTPPvBJ/e3nw34R5XMkeBIu06NvVG7ipj/Hz5yMJbRtr7urXUgZ/aX+N5IslCCrsgTHAWCe2gsWlV6EPBfOfF866Wn8IRtGM/aP7dBlnsj+Kn9hW10CYUjgX9RKMTpj8WdiiOIhI+XWIAEEaGgTQXlp1Qtv9itS52OqWQzMqHhJBsknravj+2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(2906002)(6486002)(6512007)(6506007)(2616005)(6666004)(186003)(53546011)(66556008)(66476007)(66946007)(8676002)(8936002)(41300700001)(4326008)(316002)(478600001)(5660300002)(38100700002)(36756003)(86362001)(31696002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU9zSlM2YnkrRmJJcWwzbjFIMWRZbjV4NmkxKzdDY3lFQUgrREJTdG9UQ3l5?=
 =?utf-8?B?emtaMnRFUE9adFpsbStYai8zTkxEME40NGI5ekNXYjcwS1JTVS9IRDZRVVNM?=
 =?utf-8?B?SHpQdmdiNXFGeHQwOU5ob0xzUS9oSFZXTmZHVzE1TFh5NzJKUmpFeGNMR1di?=
 =?utf-8?B?MHEwVll5bGZ4THBod0hOZ1NFUVdZTkFJOFhOd2EvVWhIbzN3R1QxYkNsaXp0?=
 =?utf-8?B?ZFJid3k5czlMOElDQjRIMmVtVDBvWkR2ckFxdm1sTEdNdEt0WXlaeU45Qmcw?=
 =?utf-8?B?WjNWcEtvd1p2VEpMaGFBcm5jT1g0QVl4Ynh6NVE2WEdHZkFVOHg4U0FlY0ZL?=
 =?utf-8?B?bjltbUhiTWRrZkFIWmMrL3JkdjhFVHhBS3NocTA3Um92RnlsSVBwYnN4Vlh0?=
 =?utf-8?B?T2ZkdVZudmNHWi80ekVLQ0tBSzd3bVpkb1NiU01qY2NuSzJJcU1tbnVHK2lI?=
 =?utf-8?B?SE11UmwzSWRGMlgyVXVQMUw5SksrZ0IvN3NUTUNIWE9OMHdpQjVwSW1JTmZD?=
 =?utf-8?B?MEVhUWFOQld5amdFdFlJL1k5NFlEcFlmR1cwZEdPNXRiNHZIZlltOHRVY1J3?=
 =?utf-8?B?dW4yOW5XSmZiV1VlOHY0WFJjMVNVV2JMTXBoVDlZajhFV3FYekdNTGV6YzZ4?=
 =?utf-8?B?VW5hK0IyT0RwVHhmT250cDVlN3A2MzYrY25oYTBsU1QwK2VjK2Y3aW1jSXNh?=
 =?utf-8?B?dG9QOWpqYTlHYTRtRmtkUTJpSTY5UThsTFNqTis4dWptZmYvK3hadzJZcE5D?=
 =?utf-8?B?eVUzT25McUhmYUZxcXdFelBTZVN4cmUzZS9FS2VFNERSVnVOU2ZIeVlRNW1D?=
 =?utf-8?B?anZlMmV5clRkU0lTOXlzQTBkSXl4Q0IyNXY4K0Vxd2hKK3gzUElkM3YzL3BX?=
 =?utf-8?B?bkZvSStLVEhHT3hnUW5JYU93SzU3Tk5RZFhkQnFhT1VhUk5zbWtNSllwSmFz?=
 =?utf-8?B?S2hqL3dyVjRsQnMybllZR1dGOTFjRlFWcEJzMmM2UW1USEpVWVFYb1RCenBk?=
 =?utf-8?B?amhGY1JzdFFwK2YvNzhOZzhGUDNRTU9pVDVFQVV3eEM1b0ordTlnK1c3N2VG?=
 =?utf-8?B?bUdSMDhLdXp6WmNHcS93SUxoSUFsNGMwb0ZWV2I4NjZPY2w2L2IyaGtHL3Bi?=
 =?utf-8?B?NDlXbXVDbG9HWmZjNm5VVmxHMTFyMlhmU2xiN2xPR25ib3VZdy92WElWUHdp?=
 =?utf-8?B?UGd5eDc2R29YMDl2OHU2QTdtSU1JZ20xUXR0OGE4YlQrUFdPSFN2OGUyZzhY?=
 =?utf-8?B?dDZXSk5hdHhydEFBN0tjSnBhUjcyRTZpcjMwZzJkemllUXZYVzNYYVkxRjNr?=
 =?utf-8?B?WllFSWIvNGU4ZWpXVk1jUlNGMktNNllxSVE5T3M0L3VpZzdyWUgrNE0yQ2dr?=
 =?utf-8?B?a3pmY2pMRkJwWVA3cW9QblJzM0dvS2QwcWtuL3FrYmN2S1NrcjZwc1oyalZ2?=
 =?utf-8?B?RXBKOEJNOG5WSFdSV0d5djg4aG00UXhwYkhtdHU3cGZINGRmWEtPYzdTZ2xt?=
 =?utf-8?B?NUlMcDJTVzdYNUZUWHB2YVFaWlkzMHVpZ1c1QS9uRC85TG9sMC9GckcrL2ZF?=
 =?utf-8?B?dkFrdHl3YVFhaHJCSG9TT2JMaVB4U082MURPMmQ5Ky9zVjVlQ1A5SDFMQkZv?=
 =?utf-8?B?TVBDVXpMU2tUWkd1ZThRbUxxTmF4Mlg3OExnV3QxdHdTSXh5UUszUCtDVW0z?=
 =?utf-8?B?bmUvU3N6eE1MYkxyMmQ1YWFDT3VrOGtDUlhHVTRtbkV2ZEVvZ25mK21VYVlu?=
 =?utf-8?B?eUtqenAyWXNRenlCNnpUUk5nTm1icjNMa2NLSzhrajVoTVdtbXNUbGZxY1FL?=
 =?utf-8?B?TVVkVHNuV1kxdTd2NGVjaFdCQk5KZklPS2FyU2RsOEtXTmFHWnZXT1ZDWkVM?=
 =?utf-8?B?cGR0WDJVbHBJaG5rdHQ3aGxJQWJJajlVdU10aXgxNm0zemh4SG5uL3hqZlI2?=
 =?utf-8?B?WFlVakdnckp0bEQzOVR6bnVXZW53MkU4VVpYZklET3cySGt6dFE0eUhUNGh2?=
 =?utf-8?B?V1ZoQWtTVWEwUndXZW5lN3JmdnV5YlpHVXdYRkMxY1JUbmFUTTZVVGJRbkRm?=
 =?utf-8?B?WDl5M3pMQ25hRmpsUU1ycTBmOTN6M0RJUm1OamM5RG0zNnZWeUJkT0tyTEla?=
 =?utf-8?B?MnJhdFd5WUJmOWRPU2lKaGlrbTlFeVR1RXRwMWZZbHJvTzFRNUxVMkltOHdL?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8427ef6-2657-42d7-7867-08db45503d85
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 05:45:13.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItzK4aq044Br7SUrTUMlSNZG6zJT014tHQCvOS8ztgiO2Octw4Y4Y9A/fusOslXV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4042
X-Proofpoint-GUID: rpJStSzvkXVsZ3fohkDeKpOAsWAQQHih
X-Proofpoint-ORIG-GUID: rpJStSzvkXVsZ3fohkDeKpOAsWAQQHih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/18/23 8:31 AM, Aditi Ghag wrote:
> Previously, BPF TCP iterator was acquiring fast version of sock lock that
> disables the BH. This introduced a circular dependency with code paths that
> later acquire sockets hash table bucket lock.
> Replace the fast version of sock lock with slow that faciliates BPF
> programs executed from the iterator to destroy TCP listening sockets
> using the bpf_sock_destroy kfunc (implemened in follow-up commits).
> 
> Here is a stack trace that motivated this change:
> 
> ```
> 1) sock_lock with BH disabled + bucket lock
> 
> lock_acquire+0xcd/0x330
> _raw_spin_lock_bh+0x38/0x50
> inet_unhash+0x96/0xd0
> tcp_set_state+0x6a/0x210
> tcp_abort+0x12b/0x230
> bpf_prog_f4110fb1100e26b5_iter_tcp6_server+0xa3/0xaa
> bpf_iter_run_prog+0x1ff/0x340
> bpf_iter_tcp_seq_show+0xca/0x190
> bpf_seq_read+0x177/0x450
> vfs_read+0xc6/0x300
> ksys_read+0x69/0xf0
> do_syscall_64+0x3c/0x90
> entry_SYSCALL_64_after_hwframe+0x72/0xdc

IIUC, the above deadlock is due to

 > lock_acquire+0xcd/0x330
 > _raw_spin_lock_bh+0x38/0x50
 > inet_unhash+0x96/0xd0
 > tcp_set_state+0x6a/0x210
 > tcp_abort+0x12b/0x230
 > bpf_prog_f4110fb1100e26b5_iter_tcp6_server+0xa3/0xaa
 > bpf_iter_run_prog+0x1ff/0x340
 > ... lock_acquire for sock lock ...
 > bpf_iter_tcp_seq_show+0xca/0x190
 > bpf_seq_read+0x177/0x450
 > vfs_read+0xc6/0x300
 > ksys_read+0x69/0xf0
 > do_syscall_64+0x3c/0x90
 > entry_SYSCALL_64_after_hwframe+0x72/0xdc

I could be great to make it explicit with the stack trace so
it is clear where the circular dependency is.

> 
> 2) sock lock with BH enable
> 
> [    1.499968]   lock_acquire+0xcd/0x330
> [    1.500316]   _raw_spin_lock+0x33/0x40
> [    1.500670]   sk_clone_lock+0x146/0x520
> [    1.501030]   inet_csk_clone_lock+0x1b/0x110
> [    1.501433]   tcp_create_openreq_child+0x22/0x3f0
> [    1.501873]   tcp_v6_syn_recv_sock+0x96/0x940
> [    1.502284]   tcp_check_req+0x137/0x660
> [    1.502646]   tcp_v6_rcv+0xa63/0xe80
> [    1.502994]   ip6_protocol_deliver_rcu+0x78/0x590
> [    1.503434]   ip6_input_finish+0x72/0x140
> [    1.503818]   __netif_receive_skb_one_core+0x63/0xa0
> [    1.504281]   process_backlog+0x79/0x260
> [    1.504668]   __napi_poll.constprop.0+0x27/0x170
> [    1.505104]   net_rx_action+0x14a/0x2a0
> [    1.505469]   __do_softirq+0x165/0x510
> [    1.505842]   do_softirq+0xcd/0x100
> [    1.506172]   __local_bh_enable_ip+0xcc/0xf0
> [    1.506588]   ip6_finish_output2+0x2a8/0xb00
> [    1.506988]   ip6_finish_output+0x274/0x510
> [    1.507377]   ip6_xmit+0x319/0x9b0
> [    1.507726]   inet6_csk_xmit+0x12b/0x2b0
> [    1.508096]   __tcp_transmit_skb+0x549/0xc40
> [    1.508498]   tcp_rcv_state_process+0x362/0x1180

Similarly, it would be good to illustrate where is the
deadlock in this case.

> 
> ```
> 
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   net/ipv4/tcp_ipv4.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index ea370afa70ed..f2d370a9450f 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -2962,7 +2962,6 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
>   	struct bpf_iter_meta meta;
>   	struct bpf_prog *prog;
>   	struct sock *sk = v;
> -	bool slow;
>   	uid_t uid;
>   	int ret;
>   
> @@ -2970,7 +2969,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
>   		return 0;
>   
>   	if (sk_fullsock(sk))
> -		slow = lock_sock_fast(sk);
> +		lock_sock(sk);
>   
>   	if (unlikely(sk_unhashed(sk))) {
>   		ret = SEQ_SKIP;
> @@ -2994,7 +2993,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
>   
>   unlock:
>   	if (sk_fullsock(sk))
> -		unlock_sock_fast(sk, slow);
> +		release_sock(sk);
>   	return ret;
>   
>   }
