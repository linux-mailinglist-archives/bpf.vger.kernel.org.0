Return-Path: <bpf+bounces-13302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF9B7D7CFA
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 08:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBF4281EE2
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 06:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2872F3C1D;
	Thu, 26 Oct 2023 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="jbmRuoiZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C988BF9
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 06:44:47 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408A7AC;
	Wed, 25 Oct 2023 23:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbMqiuRl9D87sN0jh/AgB4hj3uu7rjJLtxB3qcef+Hm5TVCXKY7tJE2pdULkHjnUEZC9VL1Wi7dQTqMP6K/MpFeDvv6dC1nmyhna+Y1tRcqsgwkY5dY3Fb2N8I2dT4MoIEtkbnlqnyFZL0TwF7wm4kbKaH9Wd8+dYed0S1n2JZvXORBRs8s5aRsquSkLKiWO05j0AJ7NWRZVuWPqOjFfCsFQFqdMFv07EVkZUNlbjvEdNfVmx1vUipR5BjL9X6KbRnFD9vkI7pteZE/IEN0ghwIzEsp9ZVWQtwLqZi9xp564hqk9IbxYoYBQewFHCkzDxDK17gfKweICLI50yXJqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzMqxCEibg/Kylhunnsd6jhbcwGMZY0DzYql7178XWE=;
 b=Tv095Y7DbsoFiwat/VgyPNpsfgptNvyyLIxclgLtbIew4aEYxuz8vzY0+hiSA87BXTtsiQHO6dZeTimPFocP/DvQN+9iRmO9YrhtvbVjQX2BbKO+FskWLnsw7zRAD6s7IkNVPqbsC3dCskbr93psGOzn8gy9kMLW2MeLkue/vrtqvlJ9UyUJ32sJyy5hDPcSbl3RNQmJy9IqSIQ2uZdgE4/PqIOx5vY7GvizaY4zePKpMQB0302cehkUw7AGAALedNplnDLB+3g49iD5Pgs0KDH6ZtGkdCtkSzOBkDzQRZ2lRwY1cO9YMUEKL6fxDIVjihs5SpcFMcVtBAmoFl97LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzMqxCEibg/Kylhunnsd6jhbcwGMZY0DzYql7178XWE=;
 b=jbmRuoiZjYwqObXIQDzjnHNi3H5BwbDCty5r+7bpiJOfjtQ4DNm2NG50DZk/csfSrQZwe1rDEPm/Qeu3ABRl4HbOzp3tp34u8UCxT+ACcMekUDr3nZsJTZxJ8rv2mnk6Pfeg8PAXg7aEiNUE1u5t8LO4j5YKYlS1fmuYZg7yImUxuIY/X+jOFDSV58TDNqXOVfd9eZxikDgLl+rsO0nCAgq9yB9kZr1CQAtHKRKp5GDwAnVJMKix0JJkbW11p6b+oadQXJkkZ/frsyvygANi64g90cL+Pjg+72zTjxI67SRWqnQNbArU0zZwWO0SOyy8hpjNjLbnXf8kmXE0ycyiVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AS1PR04MB9583.eurprd04.prod.outlook.com (2603:10a6:20b:472::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16; Thu, 26 Oct
 2023 06:44:42 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.008; Thu, 26 Oct 2023
 06:44:41 +0000
Date: Thu, 26 Oct 2023 14:44:31 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Hao Sun <sunhao.th@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf <bpf@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bpf: shift-out-of-bounds in tnum_rshift()
Message-ID: <ZToKz8NOLK-yV8dt@u94a>
References: <CACkBjsY2q1_fUohD7hRmKGqv1MV=eP2f6XK8kjkYNw7BaiF8iQ@mail.gmail.com>
 <CACkBjsbYMC7PgoGDK71fnqJ3QMywrwoA5Ctzh84Ldp6U_+_Ygg@mail.gmail.com>
 <ZTkhlwP-LkPkOjK2@u94a>
 <8731196c9a847ff35073a2034662d3306cea805f.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8731196c9a847ff35073a2034662d3306cea805f.camel@gmail.com>
X-ClientProxiedBy: FR3P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::10) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AS1PR04MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ccf0c4b-da97-4942-282b-08dbd5ef07c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eIoX8T2d6tao3ml4Z/HZRXUYt6qpOuwX4Lqapup2iHoWXczzGxKSZ3oZ+GsNv2x447od0B/KYjDrKNCtw8TOQDCXbsEZI5JPoEcZMsVFhbDxPeKLt2EqlIr0J7rErYyD10SSLpsCUlH8qbllRugI0i7k/kZnwNjSp/yT+vTX3PZm7bonzKndUNvA+Bpnlaq1l1Vg4vKmNsXZvdLyu/3BYKPQz7H8S+5ZzJZI4tw3Q+0DOB3TZZcawAy1EagyGRHuuTNjdiS4k3pNeddhydSIV9n5VwY8dLldRmnTTglE8xlFZiL2jDZlfc4DvqT3eK/uszNUCDVpX0wVTtokfwQqkGiC+0w0elFP0dY6KVxGjUFqiV4ye8H3WB3UyoZrpT40+4+7xLIFd1B30qXO2ei2SZ6xcoTEmE36SR8qfUBVZ5c/qKFCfpdSCVHccJhhtvhTt0zmjQM/s0Kmp7GJ8YAyZfA/hjWxCf/MDUvOA648jpfNupYMKFT/y0JuBVf6KWowL0qYJb/1jl+bO2UU/st8qNhrFqovOG2Fq6gqqJ8DWiw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(366004)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(83380400001)(38100700002)(26005)(6916009)(316002)(66476007)(66556008)(66946007)(54906003)(7416002)(4001150100001)(2906002)(30864003)(4326008)(8936002)(8676002)(41300700001)(6666004)(66899024)(5660300002)(33716001)(6506007)(6512007)(53546011)(966005)(6486002)(9686003)(478600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEZhbCtDa01CanJCQUc0U3h0Vi83QTNwQk5LMFRJZlVRWDVvY3lrMnp6RDA3?=
 =?utf-8?B?d0tYYnRkYkdOOWNMM213WDl3bnE5SktrSTAwOEt3Z25CY2JhT1UvdUhCSmY0?=
 =?utf-8?B?Zm1sQTNyWWVFTnhGaXlSdkg4WFNid1dBT3V3c1cwTnM3OHJ4UThlLzhkUFRQ?=
 =?utf-8?B?VG1NaHNWRXN5YXpzUElaWUlweVk2ejBrOGZRTEtvTTNWMnpWa01BV284bXJZ?=
 =?utf-8?B?QTZOQmRpYXM3MjRmTEVTcnI2OWlWZjNTNC8zVUg0NTNoL1psZllzaVZNUkNU?=
 =?utf-8?B?cklFanAxODc4bHJPbEdMdmpXL256bUwyQStCNTBZZkQ2NlBZbDIzdnVwbnR3?=
 =?utf-8?B?Qk1XMDAvdG9nd293QVZiaTZtKzM0R3YxSHhVdnFndkRkVDcxWUlmU3pEcHZJ?=
 =?utf-8?B?QXptMDJkNlI0TnJ5UUdhajF3aEU1RE5VcnMyZDFkckVOaFJIYzJTYUdPOUlV?=
 =?utf-8?B?dFdxMGliT1FieDM4WnNBbWhQajMrRnFQemsybjZBalhhN2RKTXlyMnlpY1hD?=
 =?utf-8?B?ZE5KYWVHdzJ2dDkxbnJQaXBIVmlwSm5yMVI1UWZHampVN2hrUmhnaUR0YXdI?=
 =?utf-8?B?ZTZKekNtRlJLUlF3dnVtbmZ4VGR3U0NkN1pzb3lGZGFMRzJNOXcxOVFXUUlX?=
 =?utf-8?B?am9QaGs1OVA4UkRISlVHWERhY1Y4ajJFdFcrZ1ExN2R2WElzLzJMRVhRb2pK?=
 =?utf-8?B?aVlrQ2lRVEpTWnNTK3FLZTdWWDdZdTc1MFpFNG96RXJlekRtUEFpaStxT0pn?=
 =?utf-8?B?a2p6dlllOEwyZjlpcUU1SWkzc050LzVaTk9ad2p4ejMwNWVkZnZjSkplaWMv?=
 =?utf-8?B?Sm55NjFhREg2NFdJUnh0Q2tNRHpJaC9UVFhSaG5HNXZsV3hxT1QydnIwWDRJ?=
 =?utf-8?B?YjdzWXI2aUhud2FSZHhISmFtV1J0ZkU5UjVWc2tZdzY1UG50TUY1a2FtOFEw?=
 =?utf-8?B?K2N1enZLc3hxVHZSaXdCUEtNbDJ6aEhRZTNpU1JLbFZ3SWxBYVJuOFhMNHYr?=
 =?utf-8?B?TGdvQ2NPNXkxemozREVIUDFHSlFGdnYwQWZlRkVXV2Q5ZkUvT3IzY1ZPVHdU?=
 =?utf-8?B?NXpsUG9LTm4vT0ZpRUczSkpKd2UxcWduSmV3TGhBKzlOdFplSW5Ba0ZVUEcr?=
 =?utf-8?B?MWhJb1I1ZkZTZFNZa1Q5RW5PWXRKT1B2cXd2dGNPYkU0cW9nSThYQVdTWDNu?=
 =?utf-8?B?VTIvS0RZZFMvQ2JnQjNGWHd3QXExTkRqcVI1czBDU2RZbWFIWGVpS1RSdnZi?=
 =?utf-8?B?Y2t3cU14NWh1UTVMQUVLR2hMNnlHWmVSalBPclVSbGdxTGtwTW8yZW5zMWV0?=
 =?utf-8?B?QndtaG9ld2s4ZHRKZnM2aFBuRWFHemwrYWI0NHhzdFNvT2prU1hxRzg3K3Ju?=
 =?utf-8?B?TGZ3a09aaHNvZWt1UHpZcStjTWE1cUlMa2NhcnZMWCsrMXEyaHI2TGo1T2tE?=
 =?utf-8?B?eVpMbzVSWUJUelpuYjUvb3NzczNTK3pFL1VjbEVIdHN2TUZiRWo0ZW1xeG9M?=
 =?utf-8?B?VjIxTElqYkVQQktnK0g1U21Va3A0L3F3YzlHdDRSTElBT05pelVyeVhjYmhF?=
 =?utf-8?B?N1BIdTJ4VlQ3eVJhZWMrdzF5d3MyQVorS2tMam1EVHZ5TmgrL3A5QVo5dmor?=
 =?utf-8?B?MUlhSFp2WGdFbEFaYjJiaW5pWDZ3REVsem1BeUd2ZFRtYWRGYi90NDI5YWRa?=
 =?utf-8?B?WnBVVzlVU25CTmhiWHd0d1V0SzQ0U3U3ZGZkSDdOZXJDcjJNU3ErYjZTbmJG?=
 =?utf-8?B?WDZGSVh0VDlDQWtDVVB2N0V3ZDc1Tm1RZW1nTGtIVG8wU1BuWDdNSHMweW9Y?=
 =?utf-8?B?b3g5TFNDcW5ZdGVZZUZRSXl2NktidkNPZlAwdHExcjdKVHZHQW0vTmUxbFph?=
 =?utf-8?B?T01lNUhiVVFRWXBncHFydjVZZ2NEYkFPbzgyd2R1RnlCeGJyK2VqTkdoeTky?=
 =?utf-8?B?WTNlN1hUSW9Ka1R6ZFA1ZExxUHBTKy85ejFZSlB6VE1OTFB5UnJ5b3N0NnRI?=
 =?utf-8?B?dnFVYW8vNkZkMjZaN1NqWUZ4Y0F6cXdzdlpJcERHcHM1R1pWZWdhRnZkeWRU?=
 =?utf-8?B?MjZ4ZkpZS2JmTW1JUG04bXpDQm8wcHRyMUdoZ2NsV3JUVk1ENlR0VExrb1g1?=
 =?utf-8?Q?yFJ/d4wcGwNe9i1tYNFpp1IQZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccf0c4b-da97-4942-282b-08dbd5ef07c7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 06:44:40.9039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuOOB0UWf2Jcf774nVQWQxBtHZhTo2mUe56PQXdlCLX4Vhw8mxjjfc/fSCkNjI1vttXjQkznRda7bAKJ5nH7rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9583

Hi Andrii,

The fix needed here to address the "non-overlapping ranges in
__reg_combine_min_max()" issue sounds like something you'd already have in
the range-vs-range series you mentioned previously. Maybe you've already got
a patch for this?

On Thu, Oct 26, 2023 at 12:59:19AM +0300, Eduard Zingerman wrote:
> On Wed, 2023-10-25 at 22:09 +0800, Shung-Hsi Yu wrote:
> > Hi Hao,
> > On Wed, Oct 25, 2023 at 02:31:02PM +0200, Hao Sun wrote:
> > > On Tue, Oct 24, 2023 at 2:40 PM Hao Sun <sunhao.th@gmail.com> wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > The following program can trigger a shift-out-of-bounds in
> > > > tnum_rshift(), called by scalar32_min_max_rsh():
> > > > 
> > > > 0: (bc) w0.
> > = w1
> > > > 1: (bf) r2 = r0
> > > > 2: (18) r3 = 0xd
> > > > 4: (bc) w4 = w0
> > > > 5: (bf) r5 = r0
> > > > 6: (bf) r7 = r3
> > > > 7: (bf) r8 = r4
> > > > 8: (2f) r8 *= r5
> > > > 9: (cf) r5 s>>= r5
> > > > 10: (a6) if w8 < 0xfffffffb goto pc+10
> > > > 11: (1f) r7 -= r5
> > > > 12: (71) r6 = *(u8 *)(r1 +17)
> > > > 13: (5f) r3 &= r8
> > > > 14: (74) w2 >>= 30
> > > > 15: (1f) r7 -= r5
> > > > 16: (5d) if r8 != r6 goto pc+4
> > > > 17: (c7) r8 s>>= 5
> > > > 18: (cf) r0 s>>= r0
> > > > 19: (7f) r0 >>= r0
> > > > 20: (7c) w5 >>= w8         # shift-out-bounds here
> > > > 21: exit
> > > > 
> > > 
> > > Here are the c macros for the above program in case anyone needs this:
> > > 
> > >         // 0: (bc) w0 = w1
> > >         BPF_MOV32_REG(BPF_REG_0, BPF_REG_1),
> > >         // 1: (bf) r2 = r0
> > >         BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
> > >         // 2: (18) r3 = 0xd
> > >         BPF_LD_IMM64(BPF_REG_3, 0xd),
> > >         // 4: (bc) w4 = w0
> > >         BPF_MOV32_REG(BPF_REG_4, BPF_REG_0),
> > >         // 5: (bf) r5 = r0
> > >         BPF_MOV64_REG(BPF_REG_5, BPF_REG_0),
> > >         // 6: (bf) r7 = r3
> > >         BPF_MOV64_REG(BPF_REG_7, BPF_REG_3),
> > >         // 7: (bf) r8 = r4
> > >         BPF_MOV64_REG(BPF_REG_8, BPF_REG_4),
> > >         // 8: (2f) r8 *= r5
> > >         BPF_ALU64_REG(BPF_MUL, BPF_REG_8, BPF_REG_5),
> > >         // 9: (cf) r5 s>>= r5
> > >         BPF_ALU64_REG(BPF_ARSH, BPF_REG_5, BPF_REG_5),
> > >         // 10: (a6) if w8 < 0xfffffffb goto pc+10
> > >         BPF_JMP32_IMM(BPF_JLT, BPF_REG_8, 0xfffffffb, 10),
> > >         // 11: (1f) r7 -= r5
> > >         BPF_ALU64_REG(BPF_SUB, BPF_REG_7, BPF_REG_5),
> > >         // 12: (71) r6 = *(u8 *)(r1 +17)
> > >         BPF_LDX_MEM(BPF_B, BPF_REG_6, BPF_REG_1, 17),
> > >         // 13: (5f) r3 &= r8
> > >         BPF_ALU64_REG(BPF_AND, BPF_REG_3, BPF_REG_8),
> > >         // 14: (74) w2 >>= 30
> > >         BPF_ALU32_IMM(BPF_RSH, BPF_REG_2, 30),
> > >         // 15: (1f) r7 -= r5
> > >         BPF_ALU64_REG(BPF_SUB, BPF_REG_7, BPF_REG_5),
> > >         // 16: (5d) if r8 != r6 goto pc+4
> > >         BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_6, 4),
> > >         // 17: (c7) r8 s>>= 5
> > >         BPF_ALU64_IMM(BPF_ARSH, BPF_REG_8, 5),
> > >         // 18: (cf) r0 s>>= r0
> > >         BPF_ALU64_REG(BPF_ARSH, BPF_REG_0, BPF_REG_0),
> > >         // 19: (7f) r0 >>= r0
> > >         BPF_ALU64_REG(BPF_RSH, BPF_REG_0, BPF_REG_0),
> > >         // 20: (7c) w5 >>= w8
> > >         BPF_ALU32_REG(BPF_RSH, BPF_REG_5, BPF_REG_8),
> > >         BPF_EXIT_INSN()
> > > 
> > > > After load:
> > > > ================================================================================
> > > > UBSAN: shift-out-of-bounds in kernel/bpf/tnum.c:44:9
> > > > shift exponent 255 is too large for 64-bit type 'long long unsigned int'
> > > > CPU: 2 PID: 8574 Comm: bpf-test Not tainted
> > > > 6.6.0-rc5-01400-g7c2f6c9fb91f-dirty #21
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> > > > Call Trace:
> > > >  <TASK>
> > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > >  dump_stack_lvl+0x8e/0xb0 lib/dump_stack.c:106
> > > >  ubsan_epilogue lib/ubsan.c:217 [inline]
> > > >  __ubsan_handle_shift_out_of_bounds+0x15a/0x2f0 lib/ubsan.c:387
> > > >  tnum_rshift.cold+0x17/0x32 kernel/bpf/tnum.c:44
> > > >  scalar32_min_max_rsh kernel/bpf/verifier.c:12999 [inline]
> > > >  adjust_scalar_min_max_vals kernel/bpf/verifier.c:13224 [inline]
> > > >  adjust_reg_min_max_vals+0x1936/0x5d50 kernel/bpf/verifier.c:13338
> > > >  do_check kernel/bpf/verifier.c:16890 [inline]
> > > >  do_check_common+0x2f64/0xbb80 kernel/bpf/verifier.c:19563
> > > >  do_check_main kernel/bpf/verifier.c:19626 [inline]
> > > >  bpf_check+0x65cf/0xa9e0 kernel/bpf/verifier.c:20263
> > > >  bpf_prog_load+0x110e/0x1b20 kernel/bpf/syscall.c:2717
> > > >  __sys_bpf+0xfcf/0x4380 kernel/bpf/syscall.c:5365
> > > >  __do_sys_bpf kernel/bpf/syscall.c:5469 [inline]
> > > >  __se_sys_bpf kernel/bpf/syscall.c:5467 [inline]
> > > >  __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:5467
> > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > >  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> > > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > > RIP: 0033:0x5610511e23cd
> > > > Code: 24 80 00 00 00 48 0f 42 d0 48 89 94 24 68 0c 00 00 b8 41 01 00
> > > > 00 bf 05 00 00 00 ba 90 00 00 00 48 8d b44
> > > > RSP: 002b:00007f5357fc7820 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> > > > RAX: ffffffffffffffda RBX: 0000000000000095 RCX: 00005610511e23cd
> > > > RDX: 0000000000000090 RSI: 00007f5357fc8410 RDI: 0000000000000005
> > > > RBP: 0000000000000000 R08: 00007f5357fca458 R09: 00007f5350005520
> > > > R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000002b
> > > > R13: 0000000d00000000 R14: 000000000000002b R15: 000000000000002b
> > > >  </TASK>
> > > > 
> > > > If remove insn #20, the verifier gives:
> > > >  -------- Verifier Log --------
> > > >  func#0 @0
> > > >  0: R1=ctx(off=0,imm=0) R10=fp0
> > > >  0: (bc) w0 = w1                       ;
> > > > R0_w=scalar(smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
> > > > R1=ctx(off=0,
> > > >  imm=0)
> > > >  1: (bf) r2 = r0                       ;
> > > > R0_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
> > > > 0xffffffff))
> > > >  R2_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
> > > >  2: (18) r3 = 0xd                      ; R3_w=13
> > > >  4: (bc) w4 = w0                       ;
> > > > R0_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
> > > > 0xffffffff))
> > > >  R4_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
> > > >  5: (bf) r5 = r0                       ;
> > > > R0_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
> > > > 0xffffffff))
> > > >  R5_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
> > > >  6: (bf) r7 = r3                       ; R3_w=13 R7_w=13
> > > >  7: (bf) r8 = r4                       ;
> > > > R4_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
> > > > 0xffffffff))
> > > >  R8_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
> > > >  8: (2f) r8 *= r5                      ;
> > > > R5_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
> > > > 0xffffffff))
> > > >  R8_w=scalar()
> > > >  9: (cf) r5 s>>= r5                    ; R5_w=scalar()
> > > >  10: (a6) if w8 < 0xfffffffb goto pc+9         ;
> > > > R8_w=scalar(smin=-9223372032559808520,umin=4294967288,smin32=-5,smax32=-1,
> > > >  umin32=4294967291,var_off=(0xfffffff8; 0xffffffff00000007))
> > > >  11: (1f) r7 -= r5                     ; R5_w=scalar() R7_w=scalar()
> > > >  12: (71) r6 = *(u8 *)(r1 +17)         ; R1=ctx(off=0,imm=0)
> > > > R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,
> > > >  var_off=(0x0; 0xff))
> > > >  13: (5f) r3 &= r8                     ;
> > > > R3_w=scalar(smin=umin=smin32=umin32=8,smax=umax=smax32=umax32=13,var_off=(0x8;
> > > >  0x5)) R8_w=scalar(smin=-9223372032559808520,umin=4294967288,smin32=-5,smax32=-1,umin32=4294967291,var_off=(0xffff)
> > > >  14: (74) w2 >>= 30                    ;
> > > > R2_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=3,var_off=(0x0;
> > > > 0x3))
> > > >  15: (1f) r7 -= r5                     ; R5_w=scalar() R7_w=scalar()
> > > >  16: (5d) if r8 != r6 goto pc+3        ;
> > > > R6_w=scalar(smin=umin=umin32=4294967288,smax=umax=umax32=255,smin32=-8,smax32=-1,
> > > >  var_off=(0xfffffff8; 0x7))
> > > > R8_w=scalar(smin=umin=4294967288,smax=umax=255,smin32=-5,smax32=-1,umin32=4294967291)
> > 
> > Seems like the root cause is a bug with range tracking, before instruction
> > 16, R8_w was
> > 
> >   R8_w=scalar(smin=-9223372032559808520,umin=4294967288,smin32=-5,smax32=-1,umin32=4294967291,var_off=(0xffff)
> > 
> > But after instruction 16 it becomes
> > 
> >   R8_w=scalar(smin=umin=4294967288,smax=umax=255,smin32=-5,smax32=-1,umin32=4294967291)
> > 
> > Where smin_value > smax_value, and umin_value > umax_value (among other
> > things). This should be the main problem.
> > 
> > The verifier operates on the assumption that smin_value <= smax_value and
> > umin_value <= umax_value, and if that assumption is not upheld then all kind
> > of things can go wrong.
> > 
> > Maybe Andrii may already has this worked out in the range-vs-range that he
> > has mentioned[1] he'll be sending soon.
> > 
> > 1: https://lore.kernel.org/bpf/CAEf4BzbJ3hZCSt4nLCZCV4cxV60+kddiSMsy7-9ou_RaQV7B8A@mail.gmail.com/
> > 
> > > >  17: (c7) r8 s>>= 5                    ; R8_w=134217727
> > > >  18: (cf) r0 s>>= r0                   ; R0_w=scalar()
> > > >  19: (7f) r0 >>= r0                    ; R0=scalar()
> > > >  20: (95) exit
> > > > 
> > > >  from 16 to 20: safe
> > > > 
> > > >  from 10 to 20: safe
> > > >  processed 22 insns (limit 1000000) max_states_per_insn 0 total_states
> > > > 1 peak_states 1 mark_read 1
> > > > -------- End of Verifier Log --------
> > > > 
> > > > In adjust_scalar_min_max_vals(), src_reg.umax_value is 7, thus pass
> > > > the check here:
> > > >          if (umax_val >= insn_bitness) {
> > > >              /* Shifts greater than 31 or 63 are undefined.
> > > >               * This includes shifts by a negative number.
> > > >               */
> > > >              mark_reg_unknown(env, regs, insn->dst_reg);
> > > >              break;
> > > >          }
> > > > 
> > > > However in scalar32_min_max_rsh(), both src_reg->u32_min_value and
> > > > src_reg->u32_max_value is 134217727, causing tnum_rsh() shit by 255.
> > > > 
> > > > Should we check if(src_reg->u32_max_value < insn_bitness) before calling
> > > > scalar32_min_max_rsh(), rather than only checking umax_val? Or, is it
> > > > because issues somewhere else, incorrectly setting u32_min_value to
> > > > 34217727
> > 
> > Checking umax_val alone is be enough and we don't need to add a check for
> > u32_max_value, because (when we have correct range tracking) u32_max_value
> > should always be smaller than u32_value. So the fix needed here is to have
> > correct range tracking.
> 
> Hello,
> 
> Sorry, I haven't noticed your reply when replying in a sibling thread.

That's something I struggle with too :)

> I agree with your analysis, I think the culprit here is inability of
> __reg_combine_min_max() to deal with non-overlapping ranges.
> 
> Consider example below:
> 
> SEC("?tp")
> __success __retval(0)
> __naked void large_shifts(void)
> {
>         asm volatile ("                 \
>         call %[bpf_get_prandom_u32];    \
>         r8 = r0;                        \
>         r6 = r0;                        \
>         r6 &= 0x00f;                    \
>         r8 &= 0xf00;                    \
>         r8 |= 0x0ff;                    \
>         if r8 != r6 goto +1;            \
>         w0 >>= w8;       /* shift-out-bounds here */    \
>         exit;                           \
> "       :
>         : __imm(bpf_get_prandom_u32)
>         : __clobber_all);
> }
> 
> Here the ranges before 'if' are {0,15} for R6 and {255,4095} for R8.
> 
> And here is the code of __reg_combine_min_max():
> 
> 	...
> 	src_reg->umin_value = dst_reg->umin_value = max(src_reg->umin_value,
> 							dst_reg->umin_value);
> 	src_reg->umax_value = dst_reg->umax_value = min(src_reg->umax_value,
> 							dst_reg->umax_value);
> 	...
> 
> This code would be executed when 'if' is processed from the following call-chain:
> - check_cond_jmp_op
>   - reg_combine_min_max
>     - __reg_combine_min_max
> 
> The src_reg is R6 and dst_reg is R8, the min/max assignments above
> would produce umin_value > umax_value for any ranges {a,b}, {c,d}
> where a < b < c < d.
> 
> Non-overlapping ranges can get to reg_combine_min_max() because
> check_cond_jmp_op() does predictions only when one of the operands of
> the comparison is constant.
> 
> I think the way to fix this bug is to:
> - teach check_cond_jmp_op() to do predictions when ranges of operands
>   do not overlap;
> - add assertion to __reg_combine_min_max() to make sure that only
>   operands with overlapping ranges are passed as arguments.
> 
> wdyt?

Agree on both points above. For the assertion in __reg_combine_min_max() I
think verbose("BUG...") plus __mark_reg_unknown() on both src_reg and
dst_reg should be enough.

