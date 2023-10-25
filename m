Return-Path: <bpf+bounces-13252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 844FF7D6E8C
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 16:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36509281D2E
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 14:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FEB28E3B;
	Wed, 25 Oct 2023 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="pkLB1Jlc"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4E118B08
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:18:31 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732E8132;
	Wed, 25 Oct 2023 07:18:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahvjxymlZHlWueupc2xRCUuQxEd2xggKOgDCyVlhxtyOnXVUJkobIZIX2vFbT/rVbSDM9trtpLMemijnxT4rdZd4yonWKdu8+SkujDmnyiTmu6wb3P5Y8VEhaxbIZY7XF2SJwP44znS2R0FBT/yjTgZlYTD3l7p+W+u8oe/CNAju2omu3cA1YTnToeTnmrLCtpzdRHXOVpOdhZhcE8/egAfiaetOjE48/sMZDTsB4ZyC7jKhcRx2yRcivRJrlmvMFZbaT/qQBEt+6Oo8Qxf4Yt/cRyKXceR3BRDyFYUIjlEA6ZGQ5NIRkbZtG0A8Mlj/Q5noGYZIOXlUk24CMgvWbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnP7DZlJEDNHh/wMYKyzqYUJTIarAhkTGTGBrM7KENg=;
 b=I3l3c8J7/Gz7xAtTyrMnEYQD88EFc3Y5wgso5xiWDEi5GT3hFNKc411XQOf+F9w99AzsfK03sH12hq3JlTmOlJHnc7ii37LbwiiqJ6kVdHlR4VOMBOeEf7m+3RnWfNhKgXcmYiChnCPul4hwmO4E7x1VaUN6I60MhJlEkkCGkEze1eABCpgX0gm3sQCr3DvaRaoU1dVCYgsNc9XIY99A9OUx+jIdDB+5/1gzY+U3uKyyIFg7zNnEM5w/fE9Fd1ikl8BbE8g4Z5gD4uMGSjL/scivmjznTVgejNs5+JJJtOZZaVcZDAr5siakWbU+8F+mvp67mOjONINwTKqA6ZGiXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnP7DZlJEDNHh/wMYKyzqYUJTIarAhkTGTGBrM7KENg=;
 b=pkLB1JlcN/GGOVVvKong/KKDv3KAw2JHSWunYEk2HuQjDKmHUW65Tx/A0mHTqVkHiyShdhb8a5T6Dh2Mpqy5KhIDUIOMMCR/3PaX/OBdUXozs7IrwH0uPYmP6f7+by5IrIfXOeLqSKK3VacBdFbrViT53/gI5HWCD4Nek4n5CpTbAzIY4d0VSEaiR1jrazqGzq1KE5+zp3D+/DCOwoPJHHjbCPZBkjKGMm9cEi0rzUkmvmejNsSp140wjefiKqvnI7rvyoC56AArGpumdUe1TpbyU0HGQqvILmlHKbXB2Lv/CKUF/YR0F+Ks9EfdACgNxDErdxwf5eV8ixVmig5eKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AS8PR04MB9061.eurprd04.prod.outlook.com (2603:10a6:20b:444::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Wed, 25 Oct
 2023 14:18:26 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6933.011; Wed, 25 Oct 2023
 14:18:25 +0000
Date: Wed, 25 Oct 2023 22:18:13 +0800
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
Message-ID: <ZTkjpRZlsXekJuLW@u94a>
References: <CACkBjsY2q1_fUohD7hRmKGqv1MV=eP2f6XK8kjkYNw7BaiF8iQ@mail.gmail.com>
 <CACkBjsbYMC7PgoGDK71fnqJ3QMywrwoA5Ctzh84Ldp6U_+_Ygg@mail.gmail.com>
 <ZTkhlwP-LkPkOjK2@u94a>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTkhlwP-LkPkOjK2@u94a>
X-ClientProxiedBy: TY2PR06CA0038.apcprd06.prod.outlook.com
 (2603:1096:404:2e::26) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AS8PR04MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: c87b69dc-2e7b-4ca6-7e8a-08dbd56540a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pfyOPN0FHNGXJvXNr5mUZbTNIpOhmPK89dsEBlIkqoo0ntiZ+tj5cS3O9T9xWkRgLoxE3RENEWM81MWXHQZi76SLaczegOkIde16mPZKHgS7lp0tX7Lr1iFETBrD0lp1qjfl7DFnYfkLprDCUrMMiiBDgkeqj/DdV85OFhzAu87qB0AUXnmhQM2mDJC89phsrFcXKt5wl0LZyeKJ3B2UMAMUvTgEy4agKhEY85FXsxosAO7aQqBTzijOk0rhQqXZTue9l12mgqtreSLDEJ15RgcVsmK3BXqfdtm00WUw47SB+4Wj3oJ8YWRr6NJ1w+NsDTHjONNcKwDf7kvUnSMZsajcOa42G1Si3KxJJELxersK73fji3Ellr3ZUvLKotkweOBNpyLSvn11dLTDy7QmGAFNPGRdVQgaXk+qND6md1fKWSW8NUOzBcmn828QyEY6TDjhKAzVHxQ7978UDPu70lMgzRWsE9g4lkI9qg6nLjam6QXUw5Lm8mI99QDUMeHCYjzoIZRm8U+lUXHT/7s8vHCisbJO4lxIfGw5GyyqrPM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(66556008)(966005)(86362001)(66946007)(478600001)(316002)(6916009)(6486002)(66476007)(54906003)(4326008)(83380400001)(8936002)(8676002)(7416002)(5660300002)(6666004)(9686003)(38100700002)(2906002)(6512007)(53546011)(26005)(6506007)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnlNV1RMdnZUL1pOUlo5eVRSSEpwVUd1cnRtdGZ0RTk5eUhUNVJCbnRLMXZN?=
 =?utf-8?B?d0dDMFRCNGZydU8zWnQxeXR0cDJub3FFZktrd3M5TEUxRWhCeU9td2NjRUlU?=
 =?utf-8?B?dWRzWDJ4MmVDV3RUOG80OVhFeWM0aW41NFFGNU1JYVQ5OHZqQlIycmp4MHNZ?=
 =?utf-8?B?ckNKZVRDejE5MERrYS9uSTJyaGgxWWdVMWprTmxXbjRkTXlNdTJjT3ovSVVH?=
 =?utf-8?B?a0t1TFpqQUlzNEhxbHZMT0syVVpFL05YVDlxOTlpbGJFbjBhOG1NTEJYSUtn?=
 =?utf-8?B?MGFwQUhyakRzcFlJOEJqWEQvNUY5WWU5cmd5Q1RKcDlSbnF2VXJhOXBaY1lq?=
 =?utf-8?B?T1FiN1A5YlVHWlBIU3hOU3NEQWw4VWpCemJEQm1HbEtwMDRNWXBIZ3ZmejE5?=
 =?utf-8?B?aVJKdktKb0dZdkZJNnUzTmJNTVVqUTlOT0w0VDYrTzZYVkJUNFE0N0tEeGsx?=
 =?utf-8?B?c2Q4SWtWN1VSYmw3Zm54V1R1L1c3cFZuWk9CbmFMUlVZaUF5RVptWGc1YUhn?=
 =?utf-8?B?T0lXdElLNjZ6cW1Xd2ZnZ2V3Z3RIVStSczBZTFBNd2ZHYVdWTUptTlEwejNS?=
 =?utf-8?B?aFd4Wk1FOGdwN1ZXZ3ZNL2VHQWYxck9adERMWG1FQklIRXJkblZ5cFZIa2VY?=
 =?utf-8?B?eVp2dzcreWF6RFF0WEVNWnpFSnRzSHlIU0I1REF6MW8xbDBoSis3OWhyWWFp?=
 =?utf-8?B?VFdzQ3ZUTzVmaTQxbk9jazYzZmdaWUhwUktycWR3YXFIS3kyUHZ1ekRoMmJ5?=
 =?utf-8?B?dStVbnk5Umppd3hxY1JjbmoyaGJrVjZVeVlhWFZsRm5OdHVzKzJvUExqbW9v?=
 =?utf-8?B?emFvT3E4eEtuc3FGTzJHS3BCYTRJdWZmQTlpMVljdGZkY0ZGYkUyRGU1NHBw?=
 =?utf-8?B?aGlDUVVTUkxUV0NHR3NTRkdsbVZSREN3NllEczdrbXlFNERYUnFwR1JpbnFo?=
 =?utf-8?B?YURhai9JN1pPNzJNcm1qaVoyV1NPd29HS0VCdjZLNGRXdzVWWmJvcmVzZzFz?=
 =?utf-8?B?dVlNZzMrRi9QRHVhWGN6VFJ1WmZQTklDOHVpY0UxZzdmTC9QTU9yM3gxeWZ6?=
 =?utf-8?B?WkxWdyt2MUd6TzRBdThSeXV1cCtaQUVWK0NCdTFuK091ZXFnWTd2RzNPcXVu?=
 =?utf-8?B?UHcxMDVudlJaaS9ZMEl1NWo0YUY5VEVwRFcxSC9yY1M1NjBSRTVYYWtWeTQ4?=
 =?utf-8?B?OEpicXdKaUM0NGNRRVVuMFZsQmtLQzJlNUloMDFVYXNxRlJIWUpjL0N0K0Nw?=
 =?utf-8?B?d1FLenpVa25DWFhsVDBFNlBjclNwWStOc205OHB3TWJOUFh5UlIvY0diSFJ6?=
 =?utf-8?B?anVXbjE4aFpuZ3dYS0JJS1hDek5VL2dWcHNtMFMxV1QycUpxTS9sSUVuU0Na?=
 =?utf-8?B?NjZKRS9rSFRkZVBCOS9VODVQTWtVY3V0czFoRnE2R2poUDlFZXh0dnAyOFVh?=
 =?utf-8?B?Nisyd0Q4YjcrSlJqSDhpVXZMRFM1aXByV05Ec3lqYUZ3V1BJdXZWTjkyQTdS?=
 =?utf-8?B?eURhOHRzWWVKUmJpWjZzT1lrb0JjQ3VMRitXcDZnQ05KYXFJWklzbTJXbnhs?=
 =?utf-8?B?WGRiNnFoSFh1aDlzcGF6NExCeWdLOG8xTjkyclh5WVdDN3h1ZEthS25Ec0F6?=
 =?utf-8?B?UjdqMEluLzBrYkVXRDlWU3hZc0V6aVEwdlo0KzVXZHNVMWxJSFcrTFZCZWRH?=
 =?utf-8?B?QkRIdldxdmp6QTY4NDJqa0JPZFBmR0NvdEZzVi83dDlSaEZTajZKSitzNXF6?=
 =?utf-8?B?UWtxd0U4TzdmOGEwaVZ6Q3lCaVFZMXFNckpGQkFoek1GL0xKei9PeGVXMmg4?=
 =?utf-8?B?TFRrMURNTTlFcUhaNzA3S3d0T2FQZElRcGMrUHpHa1poQ3lhc3VCdVJzSit3?=
 =?utf-8?B?VnRleGx5bWpYQUhScmNMQzdqZHhzbllXNjVPcTByanRKZ2Q1TXQ2RUdNRzVK?=
 =?utf-8?B?ZTVldkFYZmRPRm1FUWNsaXd1VmxyMnUrc1RPemRHcml6QkVFNHh4eStaeGRa?=
 =?utf-8?B?eUdDdXJrblpYUXNTOGcydkxmOTJLTE56NHNpU1BTdXhhRjRQbEJzOWZxSGpx?=
 =?utf-8?B?M2FPdTdoV3JtNUwyUlFSL21jY28rWkptOHJLU0pOZXVFVFNSSi9WaVVnVHdP?=
 =?utf-8?Q?Z6Z8TCQa/bbRGiiGr8UKU7BpG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87b69dc-2e7b-4ca6-7e8a-08dbd56540a4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 14:18:25.9381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dO/AnwsBajAAYSrLiwdJ7PtV3Txhqv/w43Mt6Ac770a0l65ku7yzDmZA8fo/Ypd6fH2rkkzTZlyHYjh7i+AUcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9061

On Wed, Oct 25, 2023 at 10:09:27PM +0800, Shung-Hsi Yu wrote:
> Hi Hao,
> 
> On Wed, Oct 25, 2023 at 02:31:02PM +0200, Hao Sun wrote:
> > On Tue, Oct 24, 2023 at 2:40 PM Hao Sun <sunhao.th@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > The following program can trigger a shift-out-of-bounds in
> > > tnum_rshift(), called by scalar32_min_max_rsh():
> > >
> > > 0: (bc) w0.
> = w1
> > > 1: (bf) r2 = r0
> > > 2: (18) r3 = 0xd
> > > 4: (bc) w4 = w0
> > > 5: (bf) r5 = r0
> > > 6: (bf) r7 = r3
> > > 7: (bf) r8 = r4
> > > 8: (2f) r8 *= r5
> > > 9: (cf) r5 s>>= r5
> > > 10: (a6) if w8 < 0xfffffffb goto pc+10
> > > 11: (1f) r7 -= r5
> > > 12: (71) r6 = *(u8 *)(r1 +17)
> > > 13: (5f) r3 &= r8
> > > 14: (74) w2 >>= 30
> > > 15: (1f) r7 -= r5
> > > 16: (5d) if r8 != r6 goto pc+4
> > > 17: (c7) r8 s>>= 5
> > > 18: (cf) r0 s>>= r0
> > > 19: (7f) r0 >>= r0
> > > 20: (7c) w5 >>= w8         # shift-out-bounds here
> > > 21: exit
> > >
> > 
> > Here are the c macros for the above program in case anyone needs this:
> > 
> >         // 0: (bc) w0 = w1
> >         BPF_MOV32_REG(BPF_REG_0, BPF_REG_1),
> >         // 1: (bf) r2 = r0
> >         BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
> >         // 2: (18) r3 = 0xd
> >         BPF_LD_IMM64(BPF_REG_3, 0xd),
> >         // 4: (bc) w4 = w0
> >         BPF_MOV32_REG(BPF_REG_4, BPF_REG_0),
> >         // 5: (bf) r5 = r0
> >         BPF_MOV64_REG(BPF_REG_5, BPF_REG_0),
> >         // 6: (bf) r7 = r3
> >         BPF_MOV64_REG(BPF_REG_7, BPF_REG_3),
> >         // 7: (bf) r8 = r4
> >         BPF_MOV64_REG(BPF_REG_8, BPF_REG_4),
> >         // 8: (2f) r8 *= r5
> >         BPF_ALU64_REG(BPF_MUL, BPF_REG_8, BPF_REG_5),
> >         // 9: (cf) r5 s>>= r5
> >         BPF_ALU64_REG(BPF_ARSH, BPF_REG_5, BPF_REG_5),
> >         // 10: (a6) if w8 < 0xfffffffb goto pc+10
> >         BPF_JMP32_IMM(BPF_JLT, BPF_REG_8, 0xfffffffb, 10),
> >         // 11: (1f) r7 -= r5
> >         BPF_ALU64_REG(BPF_SUB, BPF_REG_7, BPF_REG_5),
> >         // 12: (71) r6 = *(u8 *)(r1 +17)
> >         BPF_LDX_MEM(BPF_B, BPF_REG_6, BPF_REG_1, 17),
> >         // 13: (5f) r3 &= r8
> >         BPF_ALU64_REG(BPF_AND, BPF_REG_3, BPF_REG_8),
> >         // 14: (74) w2 >>= 30
> >         BPF_ALU32_IMM(BPF_RSH, BPF_REG_2, 30),
> >         // 15: (1f) r7 -= r5
> >         BPF_ALU64_REG(BPF_SUB, BPF_REG_7, BPF_REG_5),
> >         // 16: (5d) if r8 != r6 goto pc+4
> >         BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_6, 4),
> >         // 17: (c7) r8 s>>= 5
> >         BPF_ALU64_IMM(BPF_ARSH, BPF_REG_8, 5),
> >         // 18: (cf) r0 s>>= r0
> >         BPF_ALU64_REG(BPF_ARSH, BPF_REG_0, BPF_REG_0),
> >         // 19: (7f) r0 >>= r0
> >         BPF_ALU64_REG(BPF_RSH, BPF_REG_0, BPF_REG_0),
> >         // 20: (7c) w5 >>= w8
> >         BPF_ALU32_REG(BPF_RSH, BPF_REG_5, BPF_REG_8),
> >         BPF_EXIT_INSN()
> > 
> > > After load:
> > > ================================================================================
> > > UBSAN: shift-out-of-bounds in kernel/bpf/tnum.c:44:9
> > > shift exponent 255 is too large for 64-bit type 'long long unsigned int'
> > > CPU: 2 PID: 8574 Comm: bpf-test Not tainted
> > > 6.6.0-rc5-01400-g7c2f6c9fb91f-dirty #21
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0x8e/0xb0 lib/dump_stack.c:106
> > >  ubsan_epilogue lib/ubsan.c:217 [inline]
> > >  __ubsan_handle_shift_out_of_bounds+0x15a/0x2f0 lib/ubsan.c:387
> > >  tnum_rshift.cold+0x17/0x32 kernel/bpf/tnum.c:44
> > >  scalar32_min_max_rsh kernel/bpf/verifier.c:12999 [inline]
> > >  adjust_scalar_min_max_vals kernel/bpf/verifier.c:13224 [inline]
> > >  adjust_reg_min_max_vals+0x1936/0x5d50 kernel/bpf/verifier.c:13338
> > >  do_check kernel/bpf/verifier.c:16890 [inline]
> > >  do_check_common+0x2f64/0xbb80 kernel/bpf/verifier.c:19563
> > >  do_check_main kernel/bpf/verifier.c:19626 [inline]
> > >  bpf_check+0x65cf/0xa9e0 kernel/bpf/verifier.c:20263
> > >  bpf_prog_load+0x110e/0x1b20 kernel/bpf/syscall.c:2717
> > >  __sys_bpf+0xfcf/0x4380 kernel/bpf/syscall.c:5365
> > >  __do_sys_bpf kernel/bpf/syscall.c:5469 [inline]
> > >  __se_sys_bpf kernel/bpf/syscall.c:5467 [inline]
> > >  __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:5467
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > RIP: 0033:0x5610511e23cd
> > > Code: 24 80 00 00 00 48 0f 42 d0 48 89 94 24 68 0c 00 00 b8 41 01 00
> > > 00 bf 05 00 00 00 ba 90 00 00 00 48 8d b44
> > > RSP: 002b:00007f5357fc7820 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> > > RAX: ffffffffffffffda RBX: 0000000000000095 RCX: 00005610511e23cd
> > > RDX: 0000000000000090 RSI: 00007f5357fc8410 RDI: 0000000000000005
> > > RBP: 0000000000000000 R08: 00007f5357fca458 R09: 00007f5350005520
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000002b
> > > R13: 0000000d00000000 R14: 000000000000002b R15: 000000000000002b
> > >  </TASK>
> > >
> > > If remove insn #20, the verifier gives:
> > >  -------- Verifier Log --------
> > >  func#0 @0
> > >  0: R1=ctx(off=0,imm=0) R10=fp0
> > >  0: (bc) w0 = w1                       ;
> > > R0_w=scalar(smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
> > > R1=ctx(off=0,
> > >  imm=0)
> > >  1: (bf) r2 = r0                       ;
> > > R0_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
> > > 0xffffffff))
> > >  R2_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
> > >  2: (18) r3 = 0xd                      ; R3_w=13
> > >  4: (bc) w4 = w0                       ;
> > > R0_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
> > > 0xffffffff))
> > >  R4_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
> > >  5: (bf) r5 = r0                       ;
> > > R0_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
> > > 0xffffffff))
> > >  R5_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
> > >  6: (bf) r7 = r3                       ; R3_w=13 R7_w=13
> > >  7: (bf) r8 = r4                       ;
> > > R4_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
> > > 0xffffffff))
> > >  R8_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
> > >  8: (2f) r8 *= r5                      ;
> > > R5_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
> > > 0xffffffff))
> > >  R8_w=scalar()
> > >  9: (cf) r5 s>>= r5                    ; R5_w=scalar()
> > >  10: (a6) if w8 < 0xfffffffb goto pc+9         ;
> > > R8_w=scalar(smin=-9223372032559808520,umin=4294967288,smin32=-5,smax32=-1,
> > >  umin32=4294967291,var_off=(0xfffffff8; 0xffffffff00000007))
> > >  11: (1f) r7 -= r5                     ; R5_w=scalar() R7_w=scalar()
> > >  12: (71) r6 = *(u8 *)(r1 +17)         ; R1=ctx(off=0,imm=0)
> > > R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,
> > >  var_off=(0x0; 0xff))
> > >  13: (5f) r3 &= r8                     ;
> > > R3_w=scalar(smin=umin=smin32=umin32=8,smax=umax=smax32=umax32=13,var_off=(0x8;
> > >  0x5)) R8_w=scalar(smin=-9223372032559808520,umin=4294967288,smin32=-5,smax32=-1,umin32=4294967291,var_off=(0xffff)
> > >  14: (74) w2 >>= 30                    ;
> > > R2_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=3,var_off=(0x0;
> > > 0x3))
> > >  15: (1f) r7 -= r5                     ; R5_w=scalar() R7_w=scalar()
> > >  16: (5d) if r8 != r6 goto pc+3        ;
> > > R6_w=scalar(smin=umin=umin32=4294967288,smax=umax=umax32=255,smin32=-8,smax32=-1,
> > >  var_off=(0xfffffff8; 0x7))
> > > R8_w=scalar(smin=umin=4294967288,smax=umax=255,smin32=-5,smax32=-1,umin32=4294967291)
> 
> Seems like the root cause is a bug with range tracking, before instruction
> 16, R8_w was
> 
>   R8_w=scalar(smin=-9223372032559808520,umin=4294967288,smin32=-5,smax32=-1,umin32=4294967291,var_off=(0xffff)
> 
> But after instruction 16 it becomes
> 
>   R8_w=scalar(smin=umin=4294967288,smax=umax=255,smin32=-5,smax32=-1,umin32=4294967291)
> 
> Where smin_value > smax_value, and umin_value > umax_value (among other
> things). This should be the main problem.
> 
> The verifier operates on the assumption that smin_value <= smax_value and
> umin_value <= umax_value, and if that assumption is not upheld then all kind
> of things can go wrong.
> 
> Maybe Andrii may already has this worked out in the range-vs-range that he
> has mentioned[1] he'll be sending soon.
> 
> 1: https://lore.kernel.org/bpf/CAEf4BzbJ3hZCSt4nLCZCV4cxV60+kddiSMsy7-9ou_RaQV7B8A@mail.gmail.com/
> 
> > >  17: (c7) r8 s>>= 5                    ; R8_w=134217727
> > >  18: (cf) r0 s>>= r0                   ; R0_w=scalar()
> > >  19: (7f) r0 >>= r0                    ; R0=scalar()
> > >  20: (95) exit
> > >
> > >  from 16 to 20: safe
> > >
> > >  from 10 to 20: safe
> > >  processed 22 insns (limit 1000000) max_states_per_insn 0 total_states
> > > 1 peak_states 1 mark_read 1
> > > -------- End of Verifier Log --------
> > >
> > > In adjust_scalar_min_max_vals(), src_reg.umax_value is 7, thus pass
> > > the check here:
> > >          if (umax_val >= insn_bitness) {
> > >              /* Shifts greater than 31 or 63 are undefined.
> > >               * This includes shifts by a negative number.
> > >               */
> > >              mark_reg_unknown(env, regs, insn->dst_reg);
> > >              break;
> > >          }
> > >
> > > However in scalar32_min_max_rsh(), both src_reg->u32_min_value and
> > > src_reg->u32_max_value is 134217727, causing tnum_rsh() shit by 255.
> > >
> > > Should we check if(src_reg->u32_max_value < insn_bitness) before calling
> > > scalar32_min_max_rsh(), rather than only checking umax_val? Or, is it
> > > because issues somewhere else, incorrectly setting u32_min_value to
> > > 34217727
> 
> Checking umax_val alone is be enough and we don't need to add a check for
> u32_max_value, because (when we have correct range tracking) u32_max_value
> should always be smaller than u32_value. So the fix needed here is to have
> correct range tracking.

Since you are running fuzzer on BPF verifier, it may be be helpful to check
that the following conditions are always met:
- umin <= umax
- smin <= smax
- u32_min <= u32_max
- s32_min <= s32_max
- u32_max <= umax
- smin <= s32_min
- s32_max <= smax

If any of these condition is not upheld then it should be a range tracking
bug.

> > > Best
> > > Hao Sun

