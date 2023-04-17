Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8006E480A
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 14:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjDQMlf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 08:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjDQMlR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 08:41:17 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29D5AD24
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 05:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZU2DG8bdK/piLzwghuWNmBBDzNhrxSoe4wHj2l+V+MsLmGN2LGxgfClslru/38prvnHRLHwIf4QUEdL6357lDEUKDvEszsaedOdiJY6cE0vsHbT/e3OjZpQE9YTmV2H1euX22JE5kyx71poSRbAccTASmW35A/LZ3tDBDJMGSxwLD1isHaJqGF7ORCaq63lk8plfNCkhRwc+sWf+x6eXPwXV2wOsqAWFqtJpGwSQR6ABiEb+VbZN695zkPVycKNuSkRz6mlBQXO1bAXUcntnSB/v9RkDvdvZimRt0CRdei9GfE4j2d2v2+WjwQr3Co/rqxFBc95WldyGniNMn8WOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOD/HIfXg4jeB1CnSXYgH4Yp4zPOPwwiTADA1uxkGRg=;
 b=HwlBhc8DPQoMhIE80KhlF26mQl3GQ/RbPtfZsbN+0Kwc++/KwJIOYeJj70AvGOCOThnqy96vFgcTcnKA2Or7wt16nIAbguPW1TGo7kZuSRuUqhFF1Z2g4HI80O4DuSuucXRQ1CO67KYIfcRBpbRU2lKh0W6t5VXNt+FuloMdhMX/YlUqLAvrEmPGly3Xe1CF5245YdtyBTI7NKmxpgmDWaRHn1Ao1VHUxwK6Ud6+s231bQ7NZxS0CBg+LRg/P1id8JQMNUqghDGRcb9DLgAESS2yfawxKcVZ7vln6e+cltk0eKY2ZGzVEzUXgCmPOcn2HI6RTs+lTSFyr6K6tEi+kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOD/HIfXg4jeB1CnSXYgH4Yp4zPOPwwiTADA1uxkGRg=;
 b=3rZ5XAXfxdftRF7FmE1WtEA+UdWx+zKUeAlXFnDhbvRhd/TfbKErJ644SD8MdeXvu7Z6w4FurbnyZy5N9/JcoUfivM/yaAwaog3eumPllY6TqqPCZ7KNu5qHXufJmQvL9rRGUJY2oa88HeAHo6d6Z8wCvuyRtfF3j8Rb4NNgZwjji1S7G8rjaEkpoJcN2ZNmdTeuH+cZZHvayaKTEdxxWw5WFiD654ReQKoH1ljSKEA6LJpaKWyDFzHCFRnEmQ7BiB8iCrGXavK7Oso26oqxGIX/SKN9eWBuSR7rIdY2sZDWVHi5rJCWWrJ0J6Yt2r9ydciitMyfXOlGzkJs+Ygr1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DU2PR04MB9148.eurprd04.prod.outlook.com (2603:10a6:10:2f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 12:40:54 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::e4c4:247e:4a08:7ed2]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::e4c4:247e:4a08:7ed2%2]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 12:40:53 +0000
Date:   Mon, 17 Apr 2023 20:40:48 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Improve verifier u32 scalar equality
 checking
Message-ID: <ZD0+ULVuyhDtl8Aq@syu-laptop.lan>
References: <20230416232808.2387432-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230416232808.2387432-1-yhs@fb.com>
X-ClientProxiedBy: FR0P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::7) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DU2PR04MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: e29b2a08-67c8-48aa-ef7f-08db3f40fba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXQUqA3pYx/qSJRhTqo8o+Wm18MyEGa2RTrZuCHjqps7eoEosHb8V+8pboEkYi7hzgVDBnoTmj6AObfc8z+7z4dr0duhR4N+zMArc56Uo9OfRBoJV3XGuX1Ah9hgNwsse0ez+Z0P4FFilkQB+b5M7ENBFUn34WNHTED9ABga0OyJ3+53xxx2lEIqxCfURMSlp5OOB3U4AlH7+bm96o7WdVGVkJV3jM2KmrGY5pSs9vpBpKlq/9bR7B/LQUdibSPoWfXkcX3tKEIiyo5mrnxbs7I1DTMQsaHwMA3H0pKVlcGU77YRogm6dUtoqXXDsARY7Ao/QM2d2kqwwQHOlo//9f5E3wQgawVgL79bDuLfkDHFzHdntiODDYayFMvP597wnMATw4kcbjI9GVcyb3FV1mWw4NpmRtlBJW7olVSEFnjynvaCguxBzimN3jD7CC75Q6dVHXH/fSDxYF5yI0EL2slutrt7Ps2/zL49zwVWJfgKqAvyUaEDeN2nWUtIxZmw3/kmbsL4J8SsaKZitaT+Ox96lTaCnqoujQjTOMB2F0GxMMVr8IPoxLBn8altexVbY7X3KindyhiZ9jc6FiyufPehYUUTFH1kso/LNkRsKC0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199021)(66946007)(66556008)(66476007)(4326008)(6916009)(478600001)(316002)(54906003)(5660300002)(8676002)(8936002)(41300700001)(38100700002)(966005)(186003)(83380400001)(9686003)(6666004)(6486002)(26005)(6512007)(6506007)(86362001)(36756003)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGRFN2JOU044K1ZpZjI5ZHdXVVpsMmlrQXRuRCsvTnZDMmxhNFpudkJIZ2tD?=
 =?utf-8?B?QzNvRTY3K0hPZERlMFJhb0J0ZTZGWHFyckFmK2ZEVUFqYVlsZEVCMXhiTFRN?=
 =?utf-8?B?S0VXa0JQQkY3aUNHQ1haejF3OVhhK21TOXo0ZTVRdEhZQ2pvR01LeHFWbnJP?=
 =?utf-8?B?TXRaNWJoeUlhZnpJM1ZrMUsvVjE4R2E2OTYwSjlvblY1NkFFa0VBVXhsWThI?=
 =?utf-8?B?ZWVaUHp4WS8xS1lpTWlwT1NtZXF4Q08xK3krZlFOUGJid2tibkNMbS9iVS9E?=
 =?utf-8?B?eE9EU3VQdXFlbkRwWTlZR1QvbC9CZ09jaG1wRjR4T20zNHBFMExCQVlVWlFh?=
 =?utf-8?B?b2Npczg3MzRxWWJLNk5JeDRsVTVoellIT0VUd242U2UzbVVOMzdSOG1nZk9B?=
 =?utf-8?B?eU1DMGY1VGVrZ2U3ekNtdkJZUktpZnlLc281MkhLYjBnNzFCT01UandVVlZX?=
 =?utf-8?B?ZERiQmdyOFFZWGp5SFQ3TGFKajVHeHZsVEVSUkxqTFFqdURNU1lQQ2N1eXpT?=
 =?utf-8?B?aXdzTS92dGozUVVUT0lZQTRSWDRRZ3gzRDNNa0dzZjgxUW44enF5clRQdXdH?=
 =?utf-8?B?YlpoOXpXbnJpa2g1Z3JEQ0ZkbXZPQ21Tb2locFE3NkVEb3IySndsMk15WmRU?=
 =?utf-8?B?T2xYZExrcnZyczJYSmZlY2Z2UlBlc1FrRUU4QURLVDViZzR1aVlSK3E4RU1h?=
 =?utf-8?B?cWphdS9jWXV2V2JVbWpSTFpMTEIyV3lqVllYTGZzUjFYNTlPSGNtNTBHZENr?=
 =?utf-8?B?a2lpQkZDb0pZNjYzNExGdHdSOHk1cU5nNGQvZlFkUCtmdEd1ZGRlL1Q1NEhx?=
 =?utf-8?B?V3dPNTBFaTRmTHV6a1V3R2c1SFVEUXA3V3BhcTZuMysrT3VGaTVJTzl1WUta?=
 =?utf-8?B?RStoZzJQTzcyUHBYQ1pTUmc0aDdOWEZNYWwrNVpnMzNZTUNxb2lMVWdDSVhT?=
 =?utf-8?B?MEFVNTQwMmJPTTZtcHQvWU94R0piQ1lMVWxoTVppL0kvUmxvT1BXa1dZMUYr?=
 =?utf-8?B?QXdXdUYwTW0yL0V2dUZGVjdqQVYzdTdQWS9La0lKRkhhN1pqNjdoSnFqclMr?=
 =?utf-8?B?ZWZoL3BLdUJ0a1RjSGFxK1pueG4yK1RQQjFlelY3TGtHcHJXU093d2prNGt5?=
 =?utf-8?B?RHF2a045Z2I2eWxNRHQ3S0Npc0s1MWZXaEhYRXdiQngvWHA5NlNOWjgxd3pW?=
 =?utf-8?B?TlV5aytXUTE2Rnp4UlhMSkhzSjlXZnE4SU1Qb3kvaDUrOHoySGJDWmdBcjF4?=
 =?utf-8?B?M2J5N1ZldGhrMG8zc0Ywa3E3VUN4OXBYVVRudWlxYmxCWm5MZmg0NlFPb2RG?=
 =?utf-8?B?dXplYkI0WEtyS3JZcjh1aW9LaVQrZ0N0Wk5RN3c5dCtKV1NFYm41ZVJNVXhJ?=
 =?utf-8?B?YTg3NFN3WjZRR3JIMGRuRTFwNVdPUUZyVEYyNHQxYWhURHlSWVBtNnYyelFX?=
 =?utf-8?B?QUNIejRDeTcrRmJPbFhJckRFRHUwTEtIOUMzNTBpVm9PU0U5YkJNOHZjTnFl?=
 =?utf-8?B?bjExNVV0WXZwUzZyRUVTMTlUWW9xemlidlhIWUJWc2lxKzlyaVQ5eVY2b0lO?=
 =?utf-8?B?UzFpTkZNVVI1NDlYZVRramo4VTRmQXB4WXhpalRVdlFkcVRPemJOT1BrRVIv?=
 =?utf-8?B?R0c3RzREY0orTko0Sm9OdUlBb1ByNE9KN2wzeDU1RitSZ29Ia0d0bHBiVmhD?=
 =?utf-8?B?MjBYREF5ZzZXZThMRjVtSlkrRXJuZHNkSDIreU5NVGlrTTBnVlNMM0VJYXhz?=
 =?utf-8?B?bkhwK2g2RmMwZVFJU1dnaHpQbldEZzJmNURKanZRakJZTzk5aDR1N21sOW40?=
 =?utf-8?B?NG5TY1RDcFlVVko0VDFBWlpKY3lsQk5aYkpvMlNtVmdTOVcvbFRCdDZ5Z2RL?=
 =?utf-8?B?WnUvV2pST2pRUVBNR1lMci9EVlI5TFk4RVdTcyszNjFEdFc0YXh0R0M1VFlz?=
 =?utf-8?B?Z1VsVVRvRk56R2JEODJYb205ZGRrYmRTZUp0a292QWMrTWl5Mk5ON0YySEdi?=
 =?utf-8?B?T2toSTJOOTFCV2NYVUJnYk1KMTl3M0R6ZXkrVVFyK3NQbGt6K0pkdXAwZzY1?=
 =?utf-8?B?a01aRjQxdE5BTDdWZjRxQnRFa1duNEhnYzNmOTEzeEZNakc2Q1dzaHhkUmFF?=
 =?utf-8?Q?6wUbxa1kXTBziCX1RcoP1JjaT?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29b2a08-67c8-48aa-ef7f-08db3f40fba3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 12:40:53.7466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGJMJvuT+ii16Omlwd6YEaHHE3Mju/2XYwdrC4sCMCb7pdYktm829SQzRdLL/pKHQQGYgTQxSrJPTnR4xY1Rkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9148
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 16, 2023 at 04:28:08PM -0700, Yonghong Song wrote:
> In [1], I tried to remove bpf-specific codes to prevent certain
> llvm optimizations, and add llvm TTI (target transform info) hooks
> to prevent those optimizations. During this process, I found
> if I enable llvm SimplifyCFG:shouldFoldTwoEntryPHINode
> transformation, I will hit the following verification failure with selftests:
> 
>   ...
>   8: (18) r1 = 0xffffc900001b2230       ; R1_w=map_value(off=560,ks=4,vs=564,imm=0)
>   10: (61) r1 = *(u32 *)(r1 +0)         ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>   ; if (skb->tstamp == EGRESS_ENDHOST_MAGIC)
>   11: (79) r2 = *(u64 *)(r6 +152)       ; R2_w=scalar() R6=ctx(off=0,imm=0)
>   ; if (skb->tstamp == EGRESS_ENDHOST_MAGIC)
>   12: (55) if r2 != 0xb9fbeef goto pc+10        ; R2_w=195018479
>   13: (bc) w2 = w1                      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>   ; if (test < __NR_TESTS)
>   14: (a6) if w1 < 0x9 goto pc+1 16: R0=2 R1_w=scalar(umax=8,var_off=(0x0; 0xf)) R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(off=0,imm=0) R10=fp0
>   ;
>   16: (27) r2 *= 28                     ; R2_w=scalar(umax=120259084260,var_off=(0x0; 0x1ffffffffc),s32_max=2147483644,u32_max=-4)
>   17: (18) r3 = 0xffffc900001b2118      ; R3_w=map_value(off=280,ks=4,vs=564,imm=0)
>   19: (0f) r3 += r2                     ; R2_w=scalar(umax=120259084260,var_off=(0x0; 0x1ffffffffc),s32_max=2147483644,u32_max=-4) R3_w=map_value(off=280,ks=4,vs=564,umax=120259084260,var_off=(0x0; 0x1ffffffffc),s32_max=2147483644,u32_max=-4)
>   20: (61) r2 = *(u32 *)(r3 +0)
>   R3 unbounded memory access, make sure to bounds check any such access
>   processed 97 insns (limit 1000000) max_states_per_insn 1 total_states 10 peak_states 10 mark_read 6
>   -- END PROG LOAD LOG --
>   libbpf: prog 'ingress_fwdns_prio100': failed to load: -13
>   libbpf: failed to load object 'test_tc_dtime'
>   libbpf: failed to load BPF skeleton 'test_tc_dtime': -13
>   ...
> 
> At insn 14, with condition 'w1 < 9', register r1 is changed from an arbitrary
> u32 value to `scalar(umax=8,var_off=(0x0; 0xf))`. Register r2, however, remains
> as an arbitrary u32 value. Current verifier won't claim r1/r2 equality if
> the previous mov is alu32 ('w2 = w1').
> 
> If r1 upper 32bit value is not 0, we indeed cannot clamin r1/r2 equality
> after 'w2 = w1'. But in this particular case, we know r1 upper 32bit value
> is 0, so it is safe to claim r1/r2 equality. This patch exactly did this.
> For a 32bit subreg mov, if the src register upper 32bit is 0,
> it is okay to claim equality between src and dst registers.

Perhaps mention in the above paragraph that this works because 32-bit ALU
operations clear the upper bits? Some along the line of

  A special case where r1/r2 equality can be claimed after 'w2 = w1' is when
  r1 upper 32bit value is 0. This is because 32bit ALU operations always
  clear the upper 32 bits of the destination, so 'w2 = w1' in this case is
  the same as 'r2 = r1'...

> With this patch, the above verification sequence becomes
> 
>   ...
>   8: (18) r1 = 0xffffc9000048e230       ; R1_w=map_value(off=560,ks=4,vs=564,imm=0)
>   10: (61) r1 = *(u32 *)(r1 +0)         ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>   ; if (skb->tstamp == EGRESS_ENDHOST_MAGIC)
>   11: (79) r2 = *(u64 *)(r6 +152)       ; R2_w=scalar() R6=ctx(off=0,imm=0)
>   ; if (skb->tstamp == EGRESS_ENDHOST_MAGIC)
>   12: (55) if r2 != 0xb9fbeef goto pc+10        ; R2_w=195018479
>   13: (bc) w2 = w1                      ; R1_w=scalar(id=6,umax=4294967295,var_off=(0x0; 0xffffffff)) R2_w=scalar(id=6,umax=4294967295,var_off=(0x0; 0xffffffff))
>   ; if (test < __NR_TESTS)
>   14: (a6) if w1 < 0x9 goto pc+1        ; R1_w=scalar(id=6,umin=9,umax=4294967295,var_off=(0x0; 0xffffffff))
>   ...
>   from 14 to 16: R0=2 R1_w=scalar(id=6,umax=8,var_off=(0x0; 0xf)) R2_w=scalar(id=6,umax=8,var_off=(0x0; 0xf)) R6=ctx(off=0,imm=0) R10=fp0
>   16: (27) r2 *= 28                     ; R2_w=scalar(umax=224,var_off=(0x0; 0xfc))
>   17: (18) r3 = 0xffffc9000048e118      ; R3_w=map_value(off=280,ks=4,vs=564,imm=0)
>   19: (0f) r3 += r2
>   20: (61) r2 = *(u32 *)(r3 +0)         ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R3_w=map_value(off=280,ks=4,vs=564,umax=224,var_off=(0x0; 0xfc),s32_max=252,u32_max=252)
>   ...
> 
> and eventually the bpf program can be verified successfully.
> 
>   [1] https://reviews.llvm.org/D147968
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

> ---
>  kernel/bpf/verifier.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d6db6de3e9ea..468f002d3248 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12409,12 +12409,17 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  						insn->src_reg);
>  					return -EACCES;
>  				} else if (src_reg->type == SCALAR_VALUE) {
> +					bool is_src_reg_u32 = src_reg->umax_value <= U32_MAX;
> +
> +					if (is_src_reg_u32 && !src_reg->id)
> +						src_reg->id = ++env->id_gen;
>  					copy_register_state(dst_reg, src_reg);
> -					/* Make sure ID is cleared otherwise
> +					/* Make sure ID is cleared if src_reg is not in u32 range otherwise
>  					 * dst_reg min/max could be incorrectly
>  					 * propagated into src_reg by find_equal_scalars()
>  					 */
> -					dst_reg->id = 0;
> +					if (!is_src_reg_u32)
> +						dst_reg->id = 0;
>  					dst_reg->live |= REG_LIVE_WRITTEN;
>  					dst_reg->subreg_def = env->insn_idx + 1;
>  				} else {
> -- 
> 2.34.1
> 
