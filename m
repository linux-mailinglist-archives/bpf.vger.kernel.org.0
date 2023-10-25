Return-Path: <bpf+bounces-13251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319D37D6E72
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 16:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD68281D4D
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 14:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7183128E28;
	Wed, 25 Oct 2023 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ht5aa0/4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9F15486
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:09:47 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A915B18A;
	Wed, 25 Oct 2023 07:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oX2JH2ikPucTLFQaYfUUdtTzCZBiZi9rxNDvwTgi884et5pfXAVZugQM0DkCa2qOsHy9eb5MM6lizLKhMWKWTj2sCl4WPUcFGos9z3fBcxk/E/x2SYn0w2N3YYlcYcDRgnFDNJpLCSCD/lBE2RFEl6r20C4ZZc1fpHVHrAjbMDw98zdo2cx1jUxotI7YJa2ajPI1NWfMFoxPWSYnpV7Wlobn1Zcf0wo8XYwZHN+Ul0FCGvB+uFGjsiAqO2AMUEk3+sCUWWdMVYnXL5no6uRSm0Oy6Xo4ynpKbrwLZh2zz57OSDroFDwMt1I1WzYZ2lzJmF0yabpIqN4CCyK/ab0qnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWK6DRKsxh22vDsaISY9sN+NfCNLXA50KY7/ofy61P8=;
 b=bPtde4sxFdFvapsGQZQiKCQ+s+waMG6QwJV5BWT9Yfbblm3imGhQVp1jW+ua5mRjssz5Cc/oL3Ib8rB6DgTs6DGn55ED05zKq5+bK9dkhYfoHRFpBhz6CxaduAMqH+BXGpmvz6lgmBs1/EWWwgI2z4lFya+KGbi6yU2WSPg6kn9MAmJQzDC475+9vhs8hrJxH8mRVmjyGNxCykrd35Fegq4bajhGRQ0nIk0nj6JbrnWiWMAr6GA7JXG5mUwoh8gWq7v3jUCh8+scfVBrOqKMxnAiN6p0voBEnnUsR3+dR+ynRsbLqyL6ev7+JICM2yyE/39HonkCBu4wcwiJUnSBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWK6DRKsxh22vDsaISY9sN+NfCNLXA50KY7/ofy61P8=;
 b=ht5aa0/4uHE8fUYCGa/mz9Hv/vsBImWXaMzZHCGzsjFhzCnkxWdhqAURwLbCD6cO1PTmq5svslPb1Rwvoe0AOb3pYHrp5dzBiZWikXentuHMSYlKQOyrMxPUI7wd9Ty1gfyhwqhUJdqBFNRfmR07772SS6/CcaHJ6qr8iLn3SBzUWg/ea/DjUGxYuzaiRMobSNAOlZGuDXHZzNT6YxqZECMi7wbkhihuyZi+bE76PldbdNnMjtTaV09D0pKbLCkjhv4crXUGdUDjGn5ZKvBrmqBqjZjSV4xCNeGKgZnGMrXifQvtIlmQGNUKq4CwNOWd8kEVW2Xc0lJVKUbD3Kz6gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by GV1PR04MB9101.eurprd04.prod.outlook.com (2603:10a6:150:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16; Wed, 25 Oct
 2023 14:09:38 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6933.011; Wed, 25 Oct 2023
 14:09:38 +0000
Date: Wed, 25 Oct 2023 22:09:27 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Hao Sun <sunhao.th@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf <bpf@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bpf: shift-out-of-bounds in tnum_rshift()
Message-ID: <ZTkhlwP-LkPkOjK2@u94a>
References: <CACkBjsY2q1_fUohD7hRmKGqv1MV=eP2f6XK8kjkYNw7BaiF8iQ@mail.gmail.com>
 <CACkBjsbYMC7PgoGDK71fnqJ3QMywrwoA5Ctzh84Ldp6U_+_Ygg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACkBjsbYMC7PgoGDK71fnqJ3QMywrwoA5Ctzh84Ldp6U_+_Ygg@mail.gmail.com>
X-ClientProxiedBy: TYAPR01CA0102.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::18) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|GV1PR04MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ad0da1-fbd8-41d5-b114-08dbd5640624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IDQt2yiX+PHp27PUPUsLdyWCMfgFlkk12T9IkBlNPh8dLKWbfJNmyNHPg9MnDeiYk69YR1ZnQLGsxtbbHZTVxj2lqM7C9GmRWFcw0KaBOXJ9iMXkhoWByPHKZ9wEyYoDJ3gVm8Ohj1zB+0ovroCGSvYfL7gaqjAwMK2YpQMd+pxG51StP6Zk6KVQ3Qc/fZPe9mWgsarKCcCOiN2lIL6zRyUscE+iPCrd4xWR20p+738VcCbpmTT8IvgcLxKJpC4pQuUIdXJz9nkJ6ceZEizvHmaT8CZXCv3bfArhRaHUfb4qJU1CxI+GxSIBHadNEN4y8HEi2FDJmdzSMvGZRvDzCjLPZAiVKcaVDf209Ma9bSmIo9YAzRiL5MsbWwNy1F2HYj3E214fzEANVfIlDe81oFqGNPalNHUQIVFmBkyTTIW5/pNfQBFEbrEbqH4j7Fu3GVATa0ang11kJkkgFKDPoM8xNFeq52Q+9UUF7dnL+R0GToRqR+ua/ey+jYGjisa2PAQvGHMw11Rr3ySLS4Dd/XjpfR4yeWprUfptkbuKf4w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(83380400001)(53546011)(6506007)(9686003)(6512007)(6666004)(478600001)(966005)(6486002)(54906003)(316002)(66946007)(66476007)(6916009)(66556008)(26005)(38100700002)(86362001)(4326008)(8936002)(41300700001)(8676002)(7416002)(2906002)(5660300002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTdhczBDUnlvN01YTmFYd2pCTmVmS3RNam5BL3p5bnFxSXYvSTJCVGZ5ZU9s?=
 =?utf-8?B?b0N3d2ZSUEx2RkVrUi9BNWJuNkxlazZYS3RHb0VmZnVVQWdDc1AyYUF1SVZC?=
 =?utf-8?B?MDRCYzdtSWpIZjZtYWhuY3p4Y0U1WFFNSlRSVXdicnAvMnZFUVIwZHp0aGpU?=
 =?utf-8?B?eTN3eVRZTnd5QkxqZzhHOEVXMmdXUTRTY0Fqc3l6RDNZNUVIbVRhUXJOS2xk?=
 =?utf-8?B?dFlubGkxMFR3VzZ6YmZKZlpHL2xzTFh6R2RIOS9iQzdqenVYeWNaUTdYSUQw?=
 =?utf-8?B?dFdaRnVIQlNBUHoyR09TWEJXWFpKTk5sMjhDa0w0VlhtVVljRlVZNEdwTWFW?=
 =?utf-8?B?NnBla0UyeU1sWEc2SDY4UTk5SUgyY0NLRitYcm1TU09CbStWbzRVa01Vb3c4?=
 =?utf-8?B?N1VLd0Y3aDlubzRzZGQxNE5ELzAyaU5VaURQR2NzVk1WdU83bmVoTFh1TXR2?=
 =?utf-8?B?Nm15c1hmcU5kWnZjK1FjWU1jK2dicFhCR3lBS2RkbWNKbVlIU3BiMHZpMGh3?=
 =?utf-8?B?UjlyYmMydHhVMlo5Ynd0c1FTM0F6ZER1amFLSDhsNzZLRHJnOGUwVzQxeUd6?=
 =?utf-8?B?VGtrbWszdHBPNkk5anFFMWd1dlBNbGlqejVqeTJYNWRoa3BLNncydkhMeVZR?=
 =?utf-8?B?K3kzbTB0VENub01tMUlaTkxHaXVTWGVmcDJCT2gvVWduRjZFWUNDY2lXQXZF?=
 =?utf-8?B?UnZ2bm9FNDRmNStwM3NDU2Y4ZHArR3VKUUZ6M29NVWFKRWhMR2Zjaml3NlFs?=
 =?utf-8?B?VFlpU0dwWU90RFEzTFR0YlZ3ajRxaGUrMEVmZkpEZDFsVjVUSHpMTjN2T0cv?=
 =?utf-8?B?K2FMNk5aNjZlNnRJR0wrSlpOb0NwVHhIQUhka2NLN3pwSytwSlFVUUpCeXhH?=
 =?utf-8?B?RHpjdWFMV3BCK2NnSk02dSs2N1ZUZng3YkduYnVwakttR1hMVDErOVZFK2xP?=
 =?utf-8?B?dGNDblVPZEhxTGxhbXBkM0xOczVNV3ZiUEtmZUZ6L1Y1a3hBSy9GREVUMjV0?=
 =?utf-8?B?aEVqd2hwL0tpTVNLZnJJMWJnYi9JRlBEbXFCKzlTNHBGK29uQUxud1k2YWVy?=
 =?utf-8?B?VFFDMVNRQm1jOE1NcFFqcU1yRkNtM2RFRkVyY3M1OHRKU3FoWHlJNXo3Mk5q?=
 =?utf-8?B?UVNJS0tBU0NEMGNrcGUwbnBwOWMxLzV4UDc0c0NiQUwra0tLQUMrUUgxZHdp?=
 =?utf-8?B?alMzbk1WS2IxVFVPMS8reTlqN0JlZHNzenVocnRkOHFjMThCcjB0VFlGaTd1?=
 =?utf-8?B?d3J5VnNpV3llVStRdlRMWklLeXRaRW4vak5JMlY3dEtQUDhDUFRtbk9rcWd3?=
 =?utf-8?B?YVNwRmNwQ1Fjb1BrV3RGSkcyS2ZVbkpzeS81TzRtUFFiNFVuWTg4Z1NiRW5R?=
 =?utf-8?B?eG5qK3RlZGptaUZWWThJcnVXblZFVTVveXU4N3FGVkxITmRIRGZNbGlxQmhC?=
 =?utf-8?B?TUZTMDIzNjRtV1UzNDN4T2o2QTRUbS84L3F1amtPNnZoLzFNRktxVTZwZ1Y3?=
 =?utf-8?B?bnhzL3pEQ2ZMbWQ2NzF5OGdjTGVoOFdtQ0EycUFmL2FWUFUrcllwcVJVRDdE?=
 =?utf-8?B?NlNOYUN5TVI3SmtzY29BVjczYVVZZ1BmREwwbXQ0RzZUM25KYlVvODh0Vm5K?=
 =?utf-8?B?RlB2ZkV0TVEzeEhnRFN5aU9DcTRZOXZxWUd4VlU0TjhrTWR4RWZOOXpjQ2dn?=
 =?utf-8?B?WWJUd1BFTjQ5TTlJZHlnazV1NTdSWk5QbnBUSDJPZzFoVm4wRy9VZGI5MTJP?=
 =?utf-8?B?OFNJVVZVcWRUalE4Z0Q0NU91ZEVjbnZ6M1BmTk9ndktVS3lVbnFBWjNMcXRh?=
 =?utf-8?B?Zk5tSmd1Q2h5RUVtTGdBczhIS0xMMWQ4ekVhbUhsNGJTQ0Vsb0RKQVh2dVdK?=
 =?utf-8?B?OGhaeFBKY1lxZk5rd1lDSmY3R2lUU2FkOWZLZnEvczFScGgzS2dTeFk3MEtS?=
 =?utf-8?B?R3hSS2EzRGQ5RDhoSzVYb1c3MXM4NEN5OWdiTEc2V2d4SUdiT1FqWTY0TUtk?=
 =?utf-8?B?VTJKRFpTMFNPL3doNEFCYjRyc3RsMXJUeEp3UjR3SXZzVHZJVnFDQmVJbERt?=
 =?utf-8?B?YTdwY0c2bVJaemt5OHUwYjBTN1B1WkJrSUxjYU9NY3Y2TXhKVmM1NEJvYnJy?=
 =?utf-8?Q?qPWuOx38MUqYvp7NhUdPg7V6x?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ad0da1-fbd8-41d5-b114-08dbd5640624
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 14:09:38.2972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNShgXhRX10eLWQ6hRNEuW8icPoVF3GrHCREDSVpjhUINOs76Us1H4uqINBORhD2ALAKPoflwhL1pL4AHvdVNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9101

Hi Hao,

On Wed, Oct 25, 2023 at 02:31:02PM +0200, Hao Sun wrote:
> On Tue, Oct 24, 2023 at 2:40 PM Hao Sun <sunhao.th@gmail.com> wrote:
> >
> > Hi,
> >
> > The following program can trigger a shift-out-of-bounds in
> > tnum_rshift(), called by scalar32_min_max_rsh():
> >
> > 0: (bc) w0.
= w1
> > 1: (bf) r2 = r0
> > 2: (18) r3 = 0xd
> > 4: (bc) w4 = w0
> > 5: (bf) r5 = r0
> > 6: (bf) r7 = r3
> > 7: (bf) r8 = r4
> > 8: (2f) r8 *= r5
> > 9: (cf) r5 s>>= r5
> > 10: (a6) if w8 < 0xfffffffb goto pc+10
> > 11: (1f) r7 -= r5
> > 12: (71) r6 = *(u8 *)(r1 +17)
> > 13: (5f) r3 &= r8
> > 14: (74) w2 >>= 30
> > 15: (1f) r7 -= r5
> > 16: (5d) if r8 != r6 goto pc+4
> > 17: (c7) r8 s>>= 5
> > 18: (cf) r0 s>>= r0
> > 19: (7f) r0 >>= r0
> > 20: (7c) w5 >>= w8         # shift-out-bounds here
> > 21: exit
> >
> 
> Here are the c macros for the above program in case anyone needs this:
> 
>         // 0: (bc) w0 = w1
>         BPF_MOV32_REG(BPF_REG_0, BPF_REG_1),
>         // 1: (bf) r2 = r0
>         BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
>         // 2: (18) r3 = 0xd
>         BPF_LD_IMM64(BPF_REG_3, 0xd),
>         // 4: (bc) w4 = w0
>         BPF_MOV32_REG(BPF_REG_4, BPF_REG_0),
>         // 5: (bf) r5 = r0
>         BPF_MOV64_REG(BPF_REG_5, BPF_REG_0),
>         // 6: (bf) r7 = r3
>         BPF_MOV64_REG(BPF_REG_7, BPF_REG_3),
>         // 7: (bf) r8 = r4
>         BPF_MOV64_REG(BPF_REG_8, BPF_REG_4),
>         // 8: (2f) r8 *= r5
>         BPF_ALU64_REG(BPF_MUL, BPF_REG_8, BPF_REG_5),
>         // 9: (cf) r5 s>>= r5
>         BPF_ALU64_REG(BPF_ARSH, BPF_REG_5, BPF_REG_5),
>         // 10: (a6) if w8 < 0xfffffffb goto pc+10
>         BPF_JMP32_IMM(BPF_JLT, BPF_REG_8, 0xfffffffb, 10),
>         // 11: (1f) r7 -= r5
>         BPF_ALU64_REG(BPF_SUB, BPF_REG_7, BPF_REG_5),
>         // 12: (71) r6 = *(u8 *)(r1 +17)
>         BPF_LDX_MEM(BPF_B, BPF_REG_6, BPF_REG_1, 17),
>         // 13: (5f) r3 &= r8
>         BPF_ALU64_REG(BPF_AND, BPF_REG_3, BPF_REG_8),
>         // 14: (74) w2 >>= 30
>         BPF_ALU32_IMM(BPF_RSH, BPF_REG_2, 30),
>         // 15: (1f) r7 -= r5
>         BPF_ALU64_REG(BPF_SUB, BPF_REG_7, BPF_REG_5),
>         // 16: (5d) if r8 != r6 goto pc+4
>         BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_6, 4),
>         // 17: (c7) r8 s>>= 5
>         BPF_ALU64_IMM(BPF_ARSH, BPF_REG_8, 5),
>         // 18: (cf) r0 s>>= r0
>         BPF_ALU64_REG(BPF_ARSH, BPF_REG_0, BPF_REG_0),
>         // 19: (7f) r0 >>= r0
>         BPF_ALU64_REG(BPF_RSH, BPF_REG_0, BPF_REG_0),
>         // 20: (7c) w5 >>= w8
>         BPF_ALU32_REG(BPF_RSH, BPF_REG_5, BPF_REG_8),
>         BPF_EXIT_INSN()
> 
> > After load:
> > ================================================================================
> > UBSAN: shift-out-of-bounds in kernel/bpf/tnum.c:44:9
> > shift exponent 255 is too large for 64-bit type 'long long unsigned int'
> > CPU: 2 PID: 8574 Comm: bpf-test Not tainted
> > 6.6.0-rc5-01400-g7c2f6c9fb91f-dirty #21
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x8e/0xb0 lib/dump_stack.c:106
> >  ubsan_epilogue lib/ubsan.c:217 [inline]
> >  __ubsan_handle_shift_out_of_bounds+0x15a/0x2f0 lib/ubsan.c:387
> >  tnum_rshift.cold+0x17/0x32 kernel/bpf/tnum.c:44
> >  scalar32_min_max_rsh kernel/bpf/verifier.c:12999 [inline]
> >  adjust_scalar_min_max_vals kernel/bpf/verifier.c:13224 [inline]
> >  adjust_reg_min_max_vals+0x1936/0x5d50 kernel/bpf/verifier.c:13338
> >  do_check kernel/bpf/verifier.c:16890 [inline]
> >  do_check_common+0x2f64/0xbb80 kernel/bpf/verifier.c:19563
> >  do_check_main kernel/bpf/verifier.c:19626 [inline]
> >  bpf_check+0x65cf/0xa9e0 kernel/bpf/verifier.c:20263
> >  bpf_prog_load+0x110e/0x1b20 kernel/bpf/syscall.c:2717
> >  __sys_bpf+0xfcf/0x4380 kernel/bpf/syscall.c:5365
> >  __do_sys_bpf kernel/bpf/syscall.c:5469 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:5467 [inline]
> >  __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:5467
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x5610511e23cd
> > Code: 24 80 00 00 00 48 0f 42 d0 48 89 94 24 68 0c 00 00 b8 41 01 00
> > 00 bf 05 00 00 00 ba 90 00 00 00 48 8d b44
> > RSP: 002b:00007f5357fc7820 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> > RAX: ffffffffffffffda RBX: 0000000000000095 RCX: 00005610511e23cd
> > RDX: 0000000000000090 RSI: 00007f5357fc8410 RDI: 0000000000000005
> > RBP: 0000000000000000 R08: 00007f5357fca458 R09: 00007f5350005520
> > R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000002b
> > R13: 0000000d00000000 R14: 000000000000002b R15: 000000000000002b
> >  </TASK>
> >
> > If remove insn #20, the verifier gives:
> >  -------- Verifier Log --------
> >  func#0 @0
> >  0: R1=ctx(off=0,imm=0) R10=fp0
> >  0: (bc) w0 = w1                       ;
> > R0_w=scalar(smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
> > R1=ctx(off=0,
> >  imm=0)
> >  1: (bf) r2 = r0                       ;
> > R0_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
> > 0xffffffff))
> >  R2_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
> >  2: (18) r3 = 0xd                      ; R3_w=13
> >  4: (bc) w4 = w0                       ;
> > R0_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
> > 0xffffffff))
> >  R4_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
> >  5: (bf) r5 = r0                       ;
> > R0_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
> > 0xffffffff))
> >  R5_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
> >  6: (bf) r7 = r3                       ; R3_w=13 R7_w=13
> >  7: (bf) r8 = r4                       ;
> > R4_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
> > 0xffffffff))
> >  R8_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
> >  8: (2f) r8 *= r5                      ;
> > R5_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
> > 0xffffffff))
> >  R8_w=scalar()
> >  9: (cf) r5 s>>= r5                    ; R5_w=scalar()
> >  10: (a6) if w8 < 0xfffffffb goto pc+9         ;
> > R8_w=scalar(smin=-9223372032559808520,umin=4294967288,smin32=-5,smax32=-1,
> >  umin32=4294967291,var_off=(0xfffffff8; 0xffffffff00000007))
> >  11: (1f) r7 -= r5                     ; R5_w=scalar() R7_w=scalar()
> >  12: (71) r6 = *(u8 *)(r1 +17)         ; R1=ctx(off=0,imm=0)
> > R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,
> >  var_off=(0x0; 0xff))
> >  13: (5f) r3 &= r8                     ;
> > R3_w=scalar(smin=umin=smin32=umin32=8,smax=umax=smax32=umax32=13,var_off=(0x8;
> >  0x5)) R8_w=scalar(smin=-9223372032559808520,umin=4294967288,smin32=-5,smax32=-1,umin32=4294967291,var_off=(0xffff)
> >  14: (74) w2 >>= 30                    ;
> > R2_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=3,var_off=(0x0;
> > 0x3))
> >  15: (1f) r7 -= r5                     ; R5_w=scalar() R7_w=scalar()
> >  16: (5d) if r8 != r6 goto pc+3        ;
> > R6_w=scalar(smin=umin=umin32=4294967288,smax=umax=umax32=255,smin32=-8,smax32=-1,
> >  var_off=(0xfffffff8; 0x7))
> > R8_w=scalar(smin=umin=4294967288,smax=umax=255,smin32=-5,smax32=-1,umin32=4294967291)

Seems like the root cause is a bug with range tracking, before instruction
16, R8_w was

  R8_w=scalar(smin=-9223372032559808520,umin=4294967288,smin32=-5,smax32=-1,umin32=4294967291,var_off=(0xffff)

But after instruction 16 it becomes

  R8_w=scalar(smin=umin=4294967288,smax=umax=255,smin32=-5,smax32=-1,umin32=4294967291)

Where smin_value > smax_value, and umin_value > umax_value (among other
things). This should be the main problem.

The verifier operates on the assumption that smin_value <= smax_value and
umin_value <= umax_value, and if that assumption is not upheld then all kind
of things can go wrong.

Maybe Andrii may already has this worked out in the range-vs-range that he
has mentioned[1] he'll be sending soon.

1: https://lore.kernel.org/bpf/CAEf4BzbJ3hZCSt4nLCZCV4cxV60+kddiSMsy7-9ou_RaQV7B8A@mail.gmail.com/

> >  17: (c7) r8 s>>= 5                    ; R8_w=134217727
> >  18: (cf) r0 s>>= r0                   ; R0_w=scalar()
> >  19: (7f) r0 >>= r0                    ; R0=scalar()
> >  20: (95) exit
> >
> >  from 16 to 20: safe
> >
> >  from 10 to 20: safe
> >  processed 22 insns (limit 1000000) max_states_per_insn 0 total_states
> > 1 peak_states 1 mark_read 1
> > -------- End of Verifier Log --------
> >
> > In adjust_scalar_min_max_vals(), src_reg.umax_value is 7, thus pass
> > the check here:
> >          if (umax_val >= insn_bitness) {
> >              /* Shifts greater than 31 or 63 are undefined.
> >               * This includes shifts by a negative number.
> >               */
> >              mark_reg_unknown(env, regs, insn->dst_reg);
> >              break;
> >          }
> >
> > However in scalar32_min_max_rsh(), both src_reg->u32_min_value and
> > src_reg->u32_max_value is 134217727, causing tnum_rsh() shit by 255.
> >
> > Should we check if(src_reg->u32_max_value < insn_bitness) before calling
> > scalar32_min_max_rsh(), rather than only checking umax_val? Or, is it
> > because issues somewhere else, incorrectly setting u32_min_value to
> > 34217727

Checking umax_val alone is be enough and we don't need to add a check for
u32_max_value, because (when we have correct range tracking) u32_max_value
should always be smaller than u32_value. So the fix needed here is to have
correct range tracking.

> > Best
> > Hao Sun

