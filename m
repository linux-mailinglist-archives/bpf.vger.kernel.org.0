Return-Path: <bpf+bounces-14273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF977E188F
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 03:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25FDE1C20A8B
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 02:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10B3659;
	Mon,  6 Nov 2023 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="5DJeVfM4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ADC630
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 02:22:34 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CB9C6
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 18:22:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NL+rB9eEQxXhaB7lADO/54MZEEQDvU4Sbr+5qSY5BQEdaUlIBP3+m+bqnM6j+IHMdWkH5NlJkqTX8dXKgBR6PSwfGcuMh66fNhU4kZAZpbbTqg5O676vO/NoPeDwfbpLZLrlJtcjlkQ5WD2QVy6Cn9AacC+2SJKMcpdka9lD0ma/Q4+j/A8osCKe6oUGoN894mcP9ku9+8qnFGJJIu7nWq8TU0ScC3GPr7KkyVNG35iFaoQwOKmsL3sUEA9DE4Xf7IuMIDH2geLASC8utNOETWumr4LVbr8hdBXCBODwa6m+7dNaVqpCsGWfDji0KjBZp/Qkh9oHJm/l+tfAmQZ6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKRFYKEt6uB9bdOLhgUAaPZ9MmL3uDj4PHWDWYud2oY=;
 b=CQKOXrziVYHJXwH7PQhYgGHUBRdCvHIkUc95IuPxRtCEXM/rWRtAvl4DMp7kjp6RoXx27Y9skaqtEDv96nUXI38hddFV4h3pFP2q/xwHPpivyAgSZNPaZRFwZzLx7VXz0+Q3kRaAoudjpgvfncySSVkssiITyYE3DWgCIojMDT71GC6TKpNAxPYUUTpqljFvwtgnrGY9SbjcSFDbT6/A2LeIMQ456i5gHQcewg6S6WTYo+xBabCPhdhCh3he2fBEsPv2QMfzKp7VkP3s+Cdy5bKDfD1O57kF9o9t5FzhFEUocq/xDJR+kTNczyM/E1gnQkDuh1gbVhYBk5houU33Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKRFYKEt6uB9bdOLhgUAaPZ9MmL3uDj4PHWDWYud2oY=;
 b=5DJeVfM4V41WRZUjmYMVrJcknZMN8N0EtYLzngS4LaczqDCLp3jCzB2+5gZ4Njr1N2jK3oktQPbYY0u88TJYBJTbyF1CHKl4A2SBEumjm593Qah/cOs1TsDM7/rK6neqRf1Xq+dSs7CyyYOeRoQex+pKOW8uRQ0pvMZWCdE6BpnhbMuSLD8cs1MZW5yy9RjGRoZfgk3T79odUJZf2W1VdwjF0LhU9wR+wjBPXdIc+cpuRTJqz+xxLc/BmEWd7DRpWk0LtnTKNA+wyzGFGKB/odPLv3OHB1qOgxONymg3v/zRYcoWWgRj0RhEBV/OQR1ti1skKWXnphrc6Jgke+nrJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PR3PR04MB7257.eurprd04.prod.outlook.com (2603:10a6:102:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.15; Mon, 6 Nov
 2023 02:22:29 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1%6]) with mapi id 15.20.6977.013; Mon, 6 Nov 2023
 02:22:29 +0000
Date: Mon, 6 Nov 2023 10:22:19 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next 01/13] bpf: generalize reg_set_min_max() to
 handle non-const register comparisons
Message-ID: <zl3ydzvvge6mof2uygaoifififziha3mrg5gnwjvngprjfdwxe@4wvcht7jb2pj>
References: <20231103000822.2509815-1-andrii@kernel.org>
 <20231103000822.2509815-2-andrii@kernel.org>
 <ZUSmxI9EoWjUyO_t@u94a>
 <CAEf4BzbLGn0eNmrZSTWGJsnVLFxfccTg3sjot8KXLeXhRFboGw@mail.gmail.com>
 <CAEf4Bzad0wKa5bvRu64Ybvgve-JVZvHPm2Ypvm9QJFW22Q3Sjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzad0wKa5bvRu64Ybvgve-JVZvHPm2Ypvm9QJFW22Q3Sjg@mail.gmail.com>
X-ClientProxiedBy: FR5P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::20) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PR3PR04MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: b701ced0-0848-48dc-2ee0-08dbde6f3965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IUY8Y53w2rMbobTNNDFTcsei07zuv5ztgTP+w8MhD0DSK4W83d7hA3SBni7+oYJHoRaz5gLx2ts1cstPhJOjf4szy4u8PMafvhM6ymTsoyuRmpOcJOzUOe2ehsMjub5GY+VwH8ppVjt89XU7wgbA38Eytilr13eZLASj4Ls2A2cDlUdEQpiT2DG8T7X1cX5LmoCo/gSvd4lvHhtVQbSlUSHM+zLdem338x4i5s/VMqucEJj3NzcPnHAuV6Oyesyxt10Q57r6qGjrzSB32qk4Kf7KzUyiCHc/H2C5wGOni1OAcxff+rdHaLbVh9xL3SXQeflsDNei8Q3jlLCzBcR0Xz/KWb0BR0AQRTrRD6A0myKOQ01bP1/ggLzU75j6Dni4AYZqJyQDJB2ca0yl0fat7/dAri9jqsHksLpc6wvdFO6syiAztdFl9ZZUFHIGvGLP43EYR8bJnGG8oA/bFAZpPsIFOdLvw9IdtcUCrOItI7wZSWfWKVnPIn7qD5VzOtWfCAfl0Y9bzzqnd9Z+rnIkGmFHsjCJlpfS2ao3TzWTsLzFnxlldbHv6qdX/HTZWYWl97yULJut3BByInAD00Hjzbv7E+BZgqKQhTiKNQC0Ag0dxQnLxLi3hmrx3SjCXOliYUIXL4Nld3bDGzrYiMBU3Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(39860400002)(366004)(136003)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(38100700002)(6666004)(6506007)(53546011)(83380400001)(5930299018)(9686003)(6512007)(66899024)(86362001)(41300700001)(2906002)(6486002)(8676002)(4326008)(8936002)(5660300002)(6916009)(66476007)(66556008)(316002)(66946007)(478600001)(966005)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDNLN2prWjVZUWhpU2hKVEEyVEFwYXVMKzd2aWN0V1NkOWhsTDd2T2dFMEU3?=
 =?utf-8?B?aEkrT09jYkJUSjN1Tyt4UXZ6eVpuVExkQjNrWmhjb01TWXFZaVpURjRmL2tQ?=
 =?utf-8?B?Y1pGamdoUnlxNkFPdzBteHhUYUtLbUFKTkxvSDlrbXN1WmRVSVhQb1FZaXBq?=
 =?utf-8?B?OE9GaU5PZGZkY2pkOFo5c2N6TEpjb05aYjdhMDZBNG4zbVFIUENtZUpwNlJn?=
 =?utf-8?B?Z1dpcS95SUNyK0RtQW9ESno5RUR1ZFk5NE40M09BZ1lLQ2xYTVhpNjcrY21E?=
 =?utf-8?B?M1cxa1E1OVNzM1oxSlJZU1JTR0RKVXovZGRhVkhTUUUwdVNsTml6ZmduNW00?=
 =?utf-8?B?VVI1amducy83b20wUEVsNk1vVENjZXpVallZUzBVSVZxRGkxVHpyTjF0OC96?=
 =?utf-8?B?Rng4RHBnVjJ2dWdmaHhSRjl0V0xmdTArQzJxOG9uWHdna3pGMDcvWC9uVktm?=
 =?utf-8?B?NHQ2dTdqNnJiUDQyNmZ3SUV0ayt1U2k2emRTRzYxdjNIZHNqT1ZPR2txZVJY?=
 =?utf-8?B?NmRqbi9uZ1RHekh3NzV1MTlLUlN4czlnYVhMU0dHVUlaY2FjNHM4QkdvTEVK?=
 =?utf-8?B?bGQydDlsL2Rxb3J1aDh0TGZTUUlLTjFzak0wYkV0VWVPMk9ORFBid0NzN1Aw?=
 =?utf-8?B?UEkrd2N4bStNNDNEYzFFTS9IeDVJT0dzcWp4eFNwdzhOOFFOaFZsMjdPTHgw?=
 =?utf-8?B?SVF6M2VkOGw2T3ZzZ3diVlZPZ2htUG1ubmh4ZVQwdUVNMUtGdndxSnVBYmx1?=
 =?utf-8?B?TWM5RlNEVnNuUFRIeGJEZ2Jkc3lKUHZUWStGT0d1ZGs0L3RKZzFVOHRwcHE4?=
 =?utf-8?B?bG90MDI3aGJqMDY2RmdNN1k0b285MEQrMmJxbDBibkwrcHJKOVNWYWJXRUlq?=
 =?utf-8?B?ZCtSR3hjeWprYWFmcEhpbXRwUFRkUEJWMEhlbFdzMmJMclhhSHUyckpqTENQ?=
 =?utf-8?B?TTVYdkgrU1ZBeFE3NW90TnVpbHlUVy9JYUk0V2t1cmRaWkMrWWVnZnBTSFlT?=
 =?utf-8?B?elU1SlZ3WDVDb2xYQlZscTFiNnJrVU4vZzNCcmdacHc0endGcEhvWWpiUTJ0?=
 =?utf-8?B?OXdPNmZhc2F2V0RrRHhUWG5ZeUJnTGFMM0t5b1AxeUFHUE1xYTdQc2lybXFy?=
 =?utf-8?B?L1B1V0dQT0dXRjMzbFdUWmZ5M0FNTWE3MGswU0Raem1SZFJMM2puamVxTDVz?=
 =?utf-8?B?c0lSVDI3SVRoWEhZRHV4S2NHa2xIYTNGSzhvYWNtQTNsak53NU5zNkd2MFo0?=
 =?utf-8?B?VlVIaG4vUU8rMk92cnlVMnJjQUowREhwVkxORTc5OVFQaTdPSmpsVm1DTG55?=
 =?utf-8?B?ZW5rYVpDZ0xIYjl4ODBvZ0hJVWV3VmVsRFNNaWNNMXJoSGRCS2FQZXRVRWht?=
 =?utf-8?B?SWJlYTVNTDNRMXR1ZTg5aVpvOGlFVnIralZvR3kwKzBlN2VHMC9iaUUycXY2?=
 =?utf-8?B?ekwxSnF0Y0NyVXYxbTdvQ1B6dWJ5V00vVVRQS25yOHpLL0JIRFN0TGNhN2l3?=
 =?utf-8?B?cWVUZDFueE1WNkxjbWlKeU5pN25oeG05UEdyTmhOeEd3cm16VWlDWDdnNXYv?=
 =?utf-8?B?cG5rTXk5OG9PcWdCbk8yUXk5WU41S0h6bFVubHhQb1daWFUzMm1JT1YvMFJh?=
 =?utf-8?B?ZmZEZGxWNTZXSzh0TnlSWVJRQVFLSGJ0TnNhQitHWG8xeVZmNU4wQkNtQ3BD?=
 =?utf-8?B?NEIyMkNMUE14UTZpUEFtNlJxR3dpSFNQNWxOR0JOSTY2VUpzTVV1NzV2bWR6?=
 =?utf-8?B?VzRYMnhncG5RQmNsR0VJdTdxN2REYkcxVDlvR28wU0pvd0JDZmpWajJ5K1VU?=
 =?utf-8?B?cDBqTW9tVnlPTEUyL2phY0ZNZDdCdGhMOWs4SEorQzNxUjd4em9UeFI0MHVs?=
 =?utf-8?B?cngxNUdOUnFmZ2gxb0wzeCtuSkw5S0ZEVzVlTWM0aElFL1RUUm5PK3FOR0R0?=
 =?utf-8?B?TzJ6MnpKOEZaeDFRd1o1bHhIWkRKSzNqYjlFYlJqLzRKMmV4dXNNSmdvdDBi?=
 =?utf-8?B?Uk5kSmw4a2lxMGhOcmoxTThTb1JFN3hxOWJiSVM2bU43ME1INGZyMTZLRDdK?=
 =?utf-8?B?MEFPZUlsN3YwR0JtVWdhdlZleVRZNi92N3grMWNremVWZXV4eUFqcVJSN2p5?=
 =?utf-8?B?cUxHTEI0cXVhNFl2UFFLSi9Ba29KTm9kc0ZzN2V1MjVvUXByajlNdGV3WnBJ?=
 =?utf-8?B?VEFLMDZjQjM0WmdDc0JTT3hnb0QzZXJHeUVLZXJIV1Nxa2NJRHJScThOWUtp?=
 =?utf-8?B?QjJFa3AzUk5mdWFIVDVuTzFlNVlBPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b701ced0-0848-48dc-2ee0-08dbde6f3965
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 02:22:29.1813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTUlcGmXx2T1Y+hYFxnsDErECfsIqac99MYPGSiVWdznjwWitsScI71HE2V7Kbrq+NojEy3DAIq37OP+LN/tNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7257

On Fri, Nov 03, 2023 at 01:48:32PM -0700, Andrii Nakryiko wrote:
> On Fri, Nov 3, 2023 at 1:39 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Fri, Nov 3, 2023 at 12:52 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > > On Thu, Nov 02, 2023 at 05:08:10PM -0700, Andrii Nakryiko wrote:
> > > > Generalize bounds adjustment logic of reg_set_min_max() to handle not
> > > > just register vs constant case, but in general any register vs any
> > > > register cases. For most of the operations it's trivial extension based
> > > > on range vs range comparison logic, we just need to properly pick
> > > > min/max of a range to compare against min/max of the other range.
> > > >
> > > > For BPF_JSET we keep the original capabilities, just make sure JSET is
> > > > integrated in the common framework. This is manifested in the
> > > > internal-only BPF_KSET + BPF_X "opcode" to allow for simpler and more
> > >                     ^ typo?
> > >
> > > Two more comments below
> > >
> > > > uniform rev_opcode() handling. See the code for details. This allows to
> > > > reuse the same code exactly both for TRUE and FALSE branches without
> > > > explicitly handling both conditions with custom code.
> > > >
> > > > Note also that now we don't need a special handling of BPF_JEQ/BPF_JNE
> > > > case none of the registers are constants. This is now just a normal
> > > > generic case handled by reg_set_min_max().
> > > >
> > > > To make tnum handling cleaner, tnum_with_subreg() helper is added, as
> > > > that's a common operator when dealing with 32-bit subregister bounds.
> > > > This keeps the overall logic much less noisy when it comes to tnums.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  include/linux/tnum.h  |   4 +
> > > >  kernel/bpf/tnum.c     |   7 +-
> > > >  kernel/bpf/verifier.c | 327 ++++++++++++++++++++----------------------
> > > >  3 files changed, 165 insertions(+), 173 deletions(-)

...]

> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 2197385d91dc..52934080042c 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -14379,218 +14379,211 @@ static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_state *reg
> > > >       return is_scalar_branch_taken(reg1, reg2, opcode, is_jmp32);
> > > >  }
> > > >
> > > > -/* Adjusts the register min/max values in the case that the dst_reg and
> > > > - * src_reg are both SCALAR_VALUE registers (or we are simply doing a BPF_K
> > > > - * check, in which case we havea fake SCALAR_VALUE representing insn->imm).
> > > > - * Technically we can do similar adjustments for pointers to the same object,
> > > > - * but we don't support that right now.
> > > > +/* Opcode that corresponds to a *false* branch condition.
> > > > + * E.g., if r1 < r2, then reverse (false) condition is r1 >= r2
> > > >   */
> > > > -static void reg_set_min_max(struct bpf_reg_state *true_reg1,
> > > > -                         struct bpf_reg_state *true_reg2,
> > > > -                         struct bpf_reg_state *false_reg1,
> > > > -                         struct bpf_reg_state *false_reg2,
> > > > -                         u8 opcode, bool is_jmp32)
> > > > +static u8 rev_opcode(u8 opcode)
> > >
> > > Nit: rev_opcode and flip_opcode seems like a possible source of confusing
> > > down the line. Flip and reverse are often interchangable, i.e. "flip the
> > > order" and "reverse the order" is the same thing.
> > >
> > > Maybe "neg_opcode" or "neg_cond_opcode"?
> >
> > neg has too strong connotation with BPF_NEG, so not really happy with
> > this one.

That's true.

> > In selftest I used "complement_op", but it's also quite arbitrary.
> >
> > > Or do it the otherway around, keep rev_opcode but rename flip_opcode.
> >
> > how about flip_opcode -> swap_opcode? and then keep reg_opcode as is?
> 
> nah, swap_opcode sounds wrong as well. I guess I'll just leave it as is for now.

I don't have any better suggestion in mind, so no objection here.

> > >
> > > One more comment about BPF_JSET below
> >
> > please trim big chunks of code you are not commenting on to keep
> > emails a bit shorter

Noted, will do so next time.

> > [...]
> >
> > > >               if (is_jmp32) {
> > > > -                     __mark_reg32_known(false_reg1, uval32);
> > > > -                     false_32off = tnum_subreg(false_reg1->var_off);
> > > > +                     if (opcode & BPF_X)
> > > > +                             t = tnum_and(tnum_subreg(reg1->var_off), tnum_const(~val));
> > > > +                     else
> > > > +                             t = tnum_or(tnum_subreg(reg1->var_off), tnum_const(val));
> > > > +                     reg1->var_off = tnum_with_subreg(reg1->var_off, t);
> > > >               } else {
> > > > -                     ___mark_reg_known(false_reg1, uval);
> > > > -                     false_64off = false_reg1->var_off;
> > > > +                     if (opcode & BPF_X)
> > > > +                             reg1->var_off = tnum_and(reg1->var_off, tnum_const(~val));
> > > > +                     else
> > > > +                             reg1->var_off = tnum_or(reg1->var_off, tnum_const(val));
> > > >               }
> > > >               break;
> > >
> > > Since you're already adding a tnum helper, I think we can add one more
> > > for BPF_JSET here
> > >
> > >         struct tnum tnum_neg(struct tnum a)
> > >         {
> > >                 return TNUM(~a.value, a.mask);
> > >         }
> > >
> >
> > I'm not sure what tnum_neg() does (even if the correct
> > implementation), but either way I'd like to minimize touching tnum
> > stuff, it's too tricky :) we can address that as a separate patch if
> > you'd like

Tricky, but not as tricky as this patchset :)

Seizing this change chance for some shameless self-promotion of slides I
had on tnum

  https://docs.google.com/presentation/d/1Nz2AIvYwAi3rgMNiLV_bn5JjulHJynu9JHulNrTJuZU/edit#slide=id.g16cabc3ff80_0_87

I've send out the tnum change as RFC for now[0]; will resend it along
with the changes proposed here once this patchset or its successor is
merged as suggested.

0: https://lore.kernel.org/bpf/20231106021119.10455-1-shung-hsi.yu@suse.com/

> > > So instead of getting a value out of tnum then putting the value back
> > > into tnum again
> > >
> > >     u64 val;
> > >     val = reg_const_value(reg2, is_jmp32);
> > >     tnum_ops(..., tnum_const(val or ~val);
> > >
> > > Keep the value in tnum and process it as-is if possible
> > >
> > >     tnum_ops(..., reg2->var_off or tnum_neg(reg2->var_off));
> >
> > >
> > > And with that hopefully make this fragment short enough that we don't
> > > mind duplicate a bit of code to seperate the BPF_JSET case from the
> > > BPF_JSET | BPF_X case. IMO a conditional is_power_of_2 check followed by
> > > two level of branching is a bit too much to follow, it is better to have
> > > them seperated just like how you're doing it for the others already.
> >
> > I can split those two cases without any new tnum helpers, the
> > duplicated part is just const checking, basically, no big deal
> >
> > >
> > > I.e. something like the follow
> > >
> > >         case BPF_JSET: {
> > >                 if (!is_reg_const(reg2, is_jmp32))
> > >                         swap(reg1, reg2);
> > >                 if (!is_reg_const(reg2, is_jmp32))
> > >                         break;
> > >                 /* comment */
> > >                 if (!is_power_of_2(reg_const_value(reg2, is_jmp32))
> > >                         break;
> > >
> > >                 if (is_jmp32) {
> > >                         t = tnum_or(tnum_subreg(reg1->var_off), tnum_subreg(reg2->var_off));
> > >                         reg1->var_off = tnum_with_subreg(reg1->var_off, t);
> > >                 } else {
> > >                         reg1->var_off = tnum_or(reg1->var_off, reg2->var_off);
> > >                 }
> > >                 break;
> > >         }
> > >         case BPF_JSET | BPF_X: {
> > >                 if (!is_reg_const(reg2, is_jmp32))
> > >                         swap(reg1, reg2);
> > >                 if (!is_reg_const(reg2, is_jmp32))
> > >                         break;
> > >
> > >                 if (is_jmp32) {
> > >                         /* a slightly long line ... */
> > >                         t = tnum_and(tnum_subreg(reg1->var_off), tnum_neg(tnum_subreg(reg2->var_off)));
> > >                         reg1->var_off = tnum_with_subreg(reg1->var_off, t);
> > >                 } else {
> > >                         reg1->var_off = tnum_and(reg1->var_off, tnum_neg(reg2->var_off));
> > >                 }
> > >                 break;
> > >         }
> > >
> > > > ...

