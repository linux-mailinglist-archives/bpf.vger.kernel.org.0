Return-Path: <bpf+bounces-14067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 061AC7DFFC4
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 09:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA39B281E18
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 08:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD75E6FDA;
	Fri,  3 Nov 2023 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="1Q3NRSAa"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6C1549C
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 08:33:26 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D5B182
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 01:33:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnX/umKg4TEL32oJtRyQnPMMdCNJ4MQA+uAjPB6+AXqm31ze/y4tkd4JtqJmYeCmAjyUmGbZ0ND+OOEXhfmq9WoHwzn0vnCnv/FSi2hdb/ctpm01OO87JxT2BxzO2bg+DXmBoyeol4iWc0bKheqldblsCUspCz26dFo4La4zpSmZTpPxbEW6lq5UwzFshRv/vyL8ghN9y8BPMeQw7ihMUQvFLXYL/CqAsgfIpszobHLunnk5BfGof3wQ4QmCZ3dY7bB9AwE3G+0llQwiKkT+U6VbQV3w1f7IYw0w0mT6E/PBJLCge/dTEHlJhxB2dj24QV7k8UdT9cbiVsMUXvXiqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPwgNZlZlfD9xsWlIZxuYIjYZzCYd0VtQDbJKToaGrw=;
 b=PaoS0cCvzJ8nn8rQAG71Lui+nQxjJUkqVtmOBe2aoPR93XdZKNJxa9i94m1ZqlfNfI5B3KENIiW1g1HN+DW+2e240Z+f4NFPvxJ917AUAmNtQXmrroWSQFfGjwPXEgK1j+inr/DzvwU3ujmU2ljRwFfeuubDt10xcrwXp9GEMAgYbGFmMkcmjvfHXFEgzSEFToWJLBvBPz5xKnqpKM9GYLGPP43irKPLoPXSFiUOTukzQL5q9124x7EHZ7Jd8BpTTpenGsns3YJ7ZJWnI3EmfhTVOPe4Gyy4/3UVMf6aFZLA8asP0pnoI7ioDiXqhen1SlvnZ6GD7NoTRoDkta6ciQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPwgNZlZlfD9xsWlIZxuYIjYZzCYd0VtQDbJKToaGrw=;
 b=1Q3NRSAaPykL9ShRwvjesbe74gQFDW2qjDa7yqscp4Dl8jTLvVdJ09bp+i9R5HcNeQyA5mxQ91lNZNKPxdqMzY+ECN2PLVBEgsE0xnO6YTNOCYfXlGMUgYJGu97NHMVUykHkNupcajDF5UQ+1aAD1gzV+h5cy+cQ/NIjbJqpMTnMn/TXOs1j7+3fPMkngB1wLQkl0phhvT2ZhqA45QhsPoKEkDafZC4i9CUik/MicDTdY5ATsonBwz0reXohxnH5t5gxvI0MuMyPA/+7lwj1/J80CIpw/nyo8mEkx4dfJc18QJyGAbvbDnzJukBZ8SKuZ9L2rQ+XN+QiGQp32W42zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PAXPR04MB8719.eurprd04.prod.outlook.com (2603:10a6:102:21e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Fri, 3 Nov
 2023 08:33:15 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.019; Fri, 3 Nov 2023
 08:33:15 +0000
Date: Fri, 3 Nov 2023 16:33:06 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 01/13] bpf: generalize reg_set_min_max() to
 handle non-const register comparisons
Message-ID: <ZUSwQtfjCsKpbWcL@u94a>
References: <20231103000822.2509815-1-andrii@kernel.org>
 <20231103000822.2509815-2-andrii@kernel.org>
 <ZUSmxI9EoWjUyO_t@u94a>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUSmxI9EoWjUyO_t@u94a>
X-ClientProxiedBy: TYCPR01CA0134.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::13) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PAXPR04MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: d0921f2a-1ccb-4d28-4165-08dbdc478622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wci9ypwkX/6XmOscFh5/2c29Ga4+fgZItflC8TAmcjanzRSOf8vKI72dvDwf8WSpBe/38FP5PcIu0jgJlHfih7X6MT0VWOatUFv1GK0SfEkohOSDnIH5w/r09bu074Vjac4Gr27bWLVA2Law6Z+Q7Dk2vwPmn3IwLeKkew9saqLIr+1mnBPeZN8URNycvHZ9VklAyWpZO/+R0fV3gkGY46Vp+OASsLvprZnnu9kCOMnX3PXBsCY/UGX8PWrMgkwd+6AIxKXVGOl6uLXd3KoNOEz5Ryq5dmwhYRn/ZqnvRzVxsIhEaSYdj5o4UiQVofTts1WbHLrAHz1UswT8xD7wIav+dfzy6X540ncTAfRIBT9TLiYlYz8KJJE3BxTKQaSEizpy9djAGvkZoH1ztJzi73mGpUptEoBV7k9mVzwZfmVv4eCgttS1q55idsmpJt7B+R/8roUvhHl/8tqY2dULTf8WD4JrnS0p2XMnJMmZ8WfXsKkrwg7jrj7E7EDFMX1Hzu3v2ES9tqGGtSK7Nn7nlAaBgDa04CCA+A9JpwlC+FSS5GTbgBwJEVuA3+0ycg8AcnmNxT3OK3Qbl6TbC52s0YWHNpnx4Jg60BH0kCzMt0L6SqYlCMAGVLRbdonLdhfu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66899024)(4326008)(478600001)(9686003)(30864003)(86362001)(2906002)(41300700001)(5660300002)(6506007)(8936002)(83380400001)(6512007)(8676002)(6666004)(6916009)(26005)(316002)(66946007)(66476007)(6486002)(66556008)(38100700002)(33716001)(461764006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzBBTGd5cENpU1ZaVCtWaEFmMjFpbXQxeUpjTzA4T0M1ckJjMWhmdW10eFhv?=
 =?utf-8?B?MTVvcGlWQjQ3b1k5UHNDWHQ5czBqSjNibkQ5YXE2OWx6TDltYzlMdEp3R1Nw?=
 =?utf-8?B?VGcwMCsvcWxsYkc5Rm5BZ1pMOFlyNUdHaDNadFVsVG9pdWJFQVhoT1BGWFBz?=
 =?utf-8?B?cS9SQmJCMjRpSHE4VzBQcW9oa3IvZmQvNGlQTGxwak9OcktzaEJjUDdkc3M2?=
 =?utf-8?B?WWI0WDlFUkhGN2ZrMzBJK1BhaU1VN05MWnJLRmdjVXFWNFZoci95MHh2eURw?=
 =?utf-8?B?RWEwYTQ0TmlQOXBNUllyd2E0RkVTZEVycnRURnhsbEM3MU56N2VOVEY3TWM4?=
 =?utf-8?B?M211cTlOaDZlelBSTU9mVThRM2t1Y3d0YTRGcGwwRExkZE9IZGNWcEV0Vjdm?=
 =?utf-8?B?K3VYanVtL3Z0aVN2YWxGQTNhNVpZd1JuanJKRHdqS2RvRzJud1Vlb1laQVBI?=
 =?utf-8?B?a1pEdzIwd0E1bGRoVG8xbTd5RHJzYzNHZUd5Tnl0MTIzMFoxR2Ntck5nOG5K?=
 =?utf-8?B?Zmc1SjUrM2R3bzl0Z2tMbVppOTlYcy9zY0pvZWdXWGp3MGJzL1c5S2dRUWNG?=
 =?utf-8?B?RVI2QnZSbkd6VlBoaWhPTUMycFJwZUlBcExOdmY0MDB4R21EbEFEUmprdm4y?=
 =?utf-8?B?NW1qODVzcy83cXBmdUIzdEUyUExLY2EzdmQxekpCdkZRUVcvd012dHg3V2NK?=
 =?utf-8?B?VUFCY0tjYnhwZkVaMXpPL3FRRmZURi8vZ3ZGY2poYi8ycHlDazB1RElkVjBE?=
 =?utf-8?B?SWQ2ZkdqUGN2L21qSy9xcmhVdFV1UkV2TUFGUlQ0NGllbHhkVGw0bXVPdXMw?=
 =?utf-8?B?akpWQ3FubmNtd3VYUk80WlB1WFhkaDFoSkhxeExxQURRaGFndmFlb3NUaTNO?=
 =?utf-8?B?RW1QZHNFdHVCWnhhaHFWelU3S1ZVK3czcFRJN1ZpTmg2aGo4cjZTRThoVnpP?=
 =?utf-8?B?cnU0Ym9UbjQzd1M3bDVoWlc1MUJSeGZ3ZFJ2RUdDYTZpb2dFRjdXL3ltS21D?=
 =?utf-8?B?TUhnRXN0TTVkcWY4SFBnSU5QNGRuemNJQWpzMUlZY3NmQ2QvN3RRRHhJbGpN?=
 =?utf-8?B?MzZaaU01UHNFWGlvQ3RVMllxSTJEalN0bTdHdG9xVkhmanVJaDlNZnc3aUJz?=
 =?utf-8?B?aDhXTU8yaklVREpId3pXcFU2L0VheGJJRThQK2pyRWNVaktZZE1JZmU0dVFs?=
 =?utf-8?B?aXZoV0IxZlp4Z3ZXV2pVRlpRdHZqaVlNTm1BeExpb3lsbDlBOCtQN3FVU0R5?=
 =?utf-8?B?UEZWR1B1T3NmbWhnaTFQMnUzdkU4YmJiUWdUUEFzSTc0RzhBeUQ0c2lPb3U5?=
 =?utf-8?B?NFJvNUp1S2VBNUV6dGplbTF5QWlNRnd3ei9kY3JsU3VLSWc2dWhsWFN2Z0hi?=
 =?utf-8?B?aVhzVFkzZmQzVWdNWW44d25PNmNQVTdTVXNhNkY1OVpSVUlOT3FvYWpLbHMz?=
 =?utf-8?B?U3FYV0pXK2lQQldsT3RoSjhWUmF1YlRJRWJkMXl1bUNGVjlWZHJnTTBvZlNS?=
 =?utf-8?B?Mk5mdEE1Z0ZSSDU2cHRNbWtRZ3NqVWxVTEhjbHJVMUIwZlV3NUZPZHZ0V0Iw?=
 =?utf-8?B?L0gzRU40RzJacmhwNVV0K3FOWXdnM3RGNkZVSW11azdrVjVjOWRlM015aGR6?=
 =?utf-8?B?NmtDYVBSdzl3R3MzWG04MWN2Z09YczdKMG9xcTlTTzZMZkg3VGN3L3Y5a0Ra?=
 =?utf-8?B?U0dzakNoWm00R0kyL3BQdGlhekttbTAyN2NKQmFHWTkvMm9neENHTG5DZnV5?=
 =?utf-8?B?VFRIL2RBWlAxcHZoYWZvREZ3MmticmJJZUZ2d282UExUZTFqU25ka0RnZnc4?=
 =?utf-8?B?dlN3THU1amhVOXU5bngxTVJZRStwUy9TeUdLSWo5NTUzUHdidE1handsMW9K?=
 =?utf-8?B?eHFaeE1EOUNmZWoyME1raTQwdmNveXdjcC9XajI0SCtvVnhEMEMvVUhZN0w5?=
 =?utf-8?B?RzBjTlFjZG1WY0pkZUZCeEx3NFBsNnM3d0VhMXU5ZkNlT3VldXQ1QTFjeFZk?=
 =?utf-8?B?SVF5VTk1d2VQNHQxUmtzRDYzR1FMUHgyKzUwdVp2NEh1eUR3UHNHeEU5UHly?=
 =?utf-8?B?Zk9Tbmk3RGxYTVN3UDFXblZDdVJkRVduZEg3VGVRNE4raEFjdHF4SW80T1Zv?=
 =?utf-8?B?akhCSkQ3R3V4MDZ6TEZocjBNQk1JMGRsa1pRMElrd24rWHFpa2tVTW9ldDEy?=
 =?utf-8?B?ZHc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0921f2a-1ccb-4d28-4165-08dbdc478622
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 08:33:15.6214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVZN/XUuKYgkw6wiaMTWFFr1he6/xTKhOAkVxgHGF3k9jAHeSPBf023NY+DvqdzEvHb28xt3gAI3cgZM4m/uNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8719

On Fri, Nov 03, 2023 at 03:52:36PM +0800, Shung-Hsi Yu wrote:
> On Thu, Nov 02, 2023 at 05:08:10PM -0700, Andrii Nakryiko wrote:
> > Generalize bounds adjustment logic of reg_set_min_max() to handle not
> > just register vs constant case, but in general any register vs any
> > register cases. For most of the operations it's trivial extension based
> > on range vs range comparison logic, we just need to properly pick
> > min/max of a range to compare against min/max of the other range.
> > 
> > For BPF_JSET we keep the original capabilities, just make sure JSET is
> > integrated in the common framework. This is manifested in the
> > internal-only BPF_KSET + BPF_X "opcode" to allow for simpler and more
>                     ^ typo?
> 
> Two more comments below
> 
> > uniform rev_opcode() handling. See the code for details. This allows to
> > reuse the same code exactly both for TRUE and FALSE branches without
> > explicitly handling both conditions with custom code.
> > 
> > Note also that now we don't need a special handling of BPF_JEQ/BPF_JNE
> > case none of the registers are constants. This is now just a normal
> > generic case handled by reg_set_min_max().
> > 
> > To make tnum handling cleaner, tnum_with_subreg() helper is added, as
> > that's a common operator when dealing with 32-bit subregister bounds.
> > This keeps the overall logic much less noisy when it comes to tnums.
> > 
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/tnum.h  |   4 +
> >  kernel/bpf/tnum.c     |   7 +-
> >  kernel/bpf/verifier.c | 327 ++++++++++++++++++++----------------------
> >  3 files changed, 165 insertions(+), 173 deletions(-)
> > 
> > diff --git a/include/linux/tnum.h b/include/linux/tnum.h
> > index 1c3948a1d6ad..3c13240077b8 100644
> > --- a/include/linux/tnum.h
> > +++ b/include/linux/tnum.h
> > @@ -106,6 +106,10 @@ int tnum_sbin(char *str, size_t size, struct tnum a);
> >  struct tnum tnum_subreg(struct tnum a);
> >  /* Returns the tnum with the lower 32-bit subreg cleared */
> >  struct tnum tnum_clear_subreg(struct tnum a);
> > +/* Returns the tnum with the lower 32-bit subreg in *reg* set to the lower
> > + * 32-bit subreg in *subreg*
> > + */
> > +struct tnum tnum_with_subreg(struct tnum reg, struct tnum subreg);
> >  /* Returns the tnum with the lower 32-bit subreg set to value */
> >  struct tnum tnum_const_subreg(struct tnum a, u32 value);
> >  /* Returns true if 32-bit subreg @a is a known constant*/
> > diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> > index 3d7127f439a1..f4c91c9b27d7 100644
> > --- a/kernel/bpf/tnum.c
> > +++ b/kernel/bpf/tnum.c
> > @@ -208,7 +208,12 @@ struct tnum tnum_clear_subreg(struct tnum a)
> >  	return tnum_lshift(tnum_rshift(a, 32), 32);
> >  }
> >  
> > +struct tnum tnum_with_subreg(struct tnum reg, struct tnum subreg)
> > +{
> > +	return tnum_or(tnum_clear_subreg(reg), tnum_subreg(subreg));
> > +}
> > +
> >  struct tnum tnum_const_subreg(struct tnum a, u32 value)
> >  {
> > -	return tnum_or(tnum_clear_subreg(a), tnum_const(value));
> > +	return tnum_with_subreg(a, tnum_const(value));
> >  }
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2197385d91dc..52934080042c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -14379,218 +14379,211 @@ static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_state *reg
> >  	return is_scalar_branch_taken(reg1, reg2, opcode, is_jmp32);
> >  }
> >  
> > -/* Adjusts the register min/max values in the case that the dst_reg and
> > - * src_reg are both SCALAR_VALUE registers (or we are simply doing a BPF_K
> > - * check, in which case we havea fake SCALAR_VALUE representing insn->imm).
> > - * Technically we can do similar adjustments for pointers to the same object,
> > - * but we don't support that right now.
> > +/* Opcode that corresponds to a *false* branch condition.
> > + * E.g., if r1 < r2, then reverse (false) condition is r1 >= r2
> >   */
> > -static void reg_set_min_max(struct bpf_reg_state *true_reg1,
> > -			    struct bpf_reg_state *true_reg2,
> > -			    struct bpf_reg_state *false_reg1,
> > -			    struct bpf_reg_state *false_reg2,
> > -			    u8 opcode, bool is_jmp32)
> > +static u8 rev_opcode(u8 opcode)
> 
> Nit: rev_opcode and flip_opcode seems like a possible source of confusing
> down the line. Flip and reverse are often interchangable, i.e. "flip the
> order" and "reverse the order" is the same thing.
> 
> Maybe "neg_opcode" or "neg_cond_opcode"?
> 
> Or do it the otherway around, keep rev_opcode but rename flip_opcode.
> 
> One more comment about BPF_JSET below
> 
> >  {
> > -	struct tnum false_32off, false_64off;
> > -	struct tnum true_32off, true_64off;
> > -	u64 uval;
> > -	u32 uval32;
> > -	s64 sval;
> > -	s32 sval32;
> > -
> > -	/* If either register is a pointer, we can't learn anything about its
> > -	 * variable offset from the compare (unless they were a pointer into
> > -	 * the same object, but we don't bother with that).
> > +	switch (opcode) {
> > +	case BPF_JEQ:		return BPF_JNE;
> > +	case BPF_JNE:		return BPF_JEQ;
> > +	/* JSET doesn't have it's reverse opcode in BPF, so add
> > +	 * BPF_X flag to denote the reverse of that operation
> >  	 */
> > -	if (false_reg1->type != SCALAR_VALUE || false_reg2->type != SCALAR_VALUE)
> > -		return;
> > -
> > -	/* we expect right-hand registers (src ones) to be constants, for now */
> > -	if (!is_reg_const(false_reg2, is_jmp32)) {
> > -		opcode = flip_opcode(opcode);
> > -		swap(true_reg1, true_reg2);
> > -		swap(false_reg1, false_reg2);
> > +	case BPF_JSET:		return BPF_JSET | BPF_X;
> > +	case BPF_JSET | BPF_X:	return BPF_JSET;
> > +	case BPF_JGE:		return BPF_JLT;
> > +	case BPF_JGT:		return BPF_JLE;
> > +	case BPF_JLE:		return BPF_JGT;
> > +	case BPF_JLT:		return BPF_JGE;
> > +	case BPF_JSGE:		return BPF_JSLT;
> > +	case BPF_JSGT:		return BPF_JSLE;
> > +	case BPF_JSLE:		return BPF_JSGT;
> > +	case BPF_JSLT:		return BPF_JSGE;
> > +	default:		return 0;
> >  	}
> > -	if (!is_reg_const(false_reg2, is_jmp32))
> > -		return;
> > +}
> >  
> > -	false_32off = tnum_subreg(false_reg1->var_off);
> > -	false_64off = false_reg1->var_off;
> > -	true_32off = tnum_subreg(true_reg1->var_off);
> > -	true_64off = true_reg1->var_off;
> > -	uval = false_reg2->var_off.value;
> > -	uval32 = (u32)tnum_subreg(false_reg2->var_off).value;
> > -	sval = (s64)uval;
> > -	sval32 = (s32)uval32;
> > +/* Refine range knowledge for <reg1> <op> <reg>2 conditional operation. */
> > +static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state *reg2,
> > +				u8 opcode, bool is_jmp32)
> > +{
> > +	struct tnum t;
> >  
> >  	switch (opcode) {
> > -	/* JEQ/JNE comparison doesn't change the register equivalence.
> > -	 *
> > -	 * r1 = r2;
> > -	 * if (r1 == 42) goto label;
> > -	 * ...
> > -	 * label: // here both r1 and r2 are known to be 42.
> > -	 *
> > -	 * Hence when marking register as known preserve it's ID.
> > -	 */
> >  	case BPF_JEQ:
> >  		if (is_jmp32) {
> > -			__mark_reg32_known(true_reg1, uval32);
> > -			true_32off = tnum_subreg(true_reg1->var_off);
> > +			reg1->u32_min_value = max(reg1->u32_min_value, reg2->u32_min_value);
> > +			reg1->u32_max_value = min(reg1->u32_max_value, reg2->u32_max_value);
> > +			reg1->s32_min_value = max(reg1->s32_min_value, reg2->s32_min_value);
> > +			reg1->s32_max_value = min(reg1->s32_max_value, reg2->s32_max_value);
> > +			reg2->u32_min_value = reg1->u32_min_value;
> > +			reg2->u32_max_value = reg1->u32_max_value;
> > +			reg2->s32_min_value = reg1->s32_min_value;
> > +			reg2->s32_max_value = reg1->s32_max_value;
> > +
> > +			t = tnum_intersect(tnum_subreg(reg1->var_off), tnum_subreg(reg2->var_off));
> > +			reg1->var_off = tnum_with_subreg(reg1->var_off, t);
> > +			reg2->var_off = tnum_with_subreg(reg2->var_off, t);
> >  		} else {
> > -			___mark_reg_known(true_reg1, uval);
> > -			true_64off = true_reg1->var_off;
> > +			reg1->umin_value = max(reg1->umin_value, reg2->umin_value);
> > +			reg1->umax_value = min(reg1->umax_value, reg2->umax_value);
> > +			reg1->smin_value = max(reg1->smin_value, reg2->smin_value);
> > +			reg1->smax_value = min(reg1->smax_value, reg2->smax_value);
> > +			reg2->umin_value = reg1->umin_value;
> > +			reg2->umax_value = reg1->umax_value;
> > +			reg2->smin_value = reg1->smin_value;
> > +			reg2->smax_value = reg1->smax_value;
> > +
> > +			reg1->var_off = tnum_intersect(reg1->var_off, reg2->var_off);
> > +			reg2->var_off = reg1->var_off;
> >  		}
> >  		break;
> >  	case BPF_JNE:
> > +		/* we don't derive any new information for inequality yet */
> > +		break;
> > +	case BPF_JSET:
> > +	case BPF_JSET | BPF_X: { /* BPF_JSET and its reverse, see rev_opcode() */
> > +		u64 val;
> > +
> > +		if (!is_reg_const(reg2, is_jmp32))
> > +			swap(reg1, reg2);
> > +		if (!is_reg_const(reg2, is_jmp32))
> > +			break;
> > +
> > +		val = reg_const_value(reg2, is_jmp32);
> > +		/* BPF_JSET (i.e., TRUE branch, *not* BPF_JSET | BPF_X)
> > +		 * requires single bit to learn something useful. E.g., if we
> > +		 * know that `r1 & 0x3` is true, then which bits (0, 1, or both)
> > +		 * are actually set? We can learn something definite only if
> > +		 * it's a single-bit value to begin with.
> > +		 *
> > +		 * BPF_JSET | BPF_X (i.e., negation of BPF_JSET) doesn't have
> > +		 * this restriction. I.e., !(r1 & 0x3) means neither bit 0 nor
> > +		 * bit 1 is set, which we can readily use in adjustments.
> > +		 */
> > +		if (!(opcode & BPF_X) && !is_power_of_2(val))
> > +			break;
> > +
> >  		if (is_jmp32) {
> > -			__mark_reg32_known(false_reg1, uval32);
> > -			false_32off = tnum_subreg(false_reg1->var_off);
> > +			if (opcode & BPF_X)
> > +				t = tnum_and(tnum_subreg(reg1->var_off), tnum_const(~val));
> > +			else
> > +				t = tnum_or(tnum_subreg(reg1->var_off), tnum_const(val));
> > +			reg1->var_off = tnum_with_subreg(reg1->var_off, t);
> >  		} else {
> > -			___mark_reg_known(false_reg1, uval);
> > -			false_64off = false_reg1->var_off;
> > +			if (opcode & BPF_X)
> > +				reg1->var_off = tnum_and(reg1->var_off, tnum_const(~val));
> > +			else
> > +				reg1->var_off = tnum_or(reg1->var_off, tnum_const(val));
> >  		}
> >  		break;
> 
> Since you're already adding a tnum helper, I think we can add one more
> for BPF_JSET here
> 
> 	struct tnum tnum_neg(struct tnum a)
> 	{
> 		return TNUM(~a.value, a.mask);
> 	}

Didn't think it through well enough, with the above we might end up with a
invalid tnum because the unknown bits gets negated as well, need to mask the
unknown bits out.

 	struct tnum tnum_neg(struct tnum a)
 	{
 		return TNUM(~a.value & ~a.mask, a.mask);
 	}

> So instead of getting a value out of tnum then putting the value back
> into tnum again
> 
>     u64 val;
>     val = reg_const_value(reg2, is_jmp32);
>     tnum_ops(..., tnum_const(val or ~val);
> 
> Keep the value in tnum and process it as-is if possible
> 
>     tnum_ops(..., reg2->var_off or tnum_neg(reg2->var_off));
> 
> And with that hopefully make this fragment short enough that we don't
> mind duplicate a bit of code to seperate the BPF_JSET case from the
> BPF_JSET | BPF_X case. IMO a conditional is_power_of_2 check followed by
> two level of branching is a bit too much to follow, it is better to have
> them seperated just like how you're doing it for the others already.
> 
> I.e. something like the follow
> 
> 	case BPF_JSET: {
> 		if (!is_reg_const(reg2, is_jmp32))
> 			swap(reg1, reg2);
> 		if (!is_reg_const(reg2, is_jmp32))
> 			break;
> 		/* comment */
> 		if (!is_power_of_2(reg_const_value(reg2, is_jmp32))
> 			break;
> 
> 		if (is_jmp32) {
> 			t = tnum_or(tnum_subreg(reg1->var_off), tnum_subreg(reg2->var_off));
> 			reg1->var_off = tnum_with_subreg(reg1->var_off, t);
> 		} else {
> 			reg1->var_off = tnum_or(reg1->var_off, reg2->var_off);
> 		}
> 		break;
> 	}
> 	case BPF_JSET | BPF_X: {
> 		if (!is_reg_const(reg2, is_jmp32))
> 			swap(reg1, reg2);
> 		if (!is_reg_const(reg2, is_jmp32))
> 			break;
> 
> 		if (is_jmp32) {
> 			/* a slightly long line ... */
> 			t = tnum_and(tnum_subreg(reg1->var_off), tnum_neg(tnum_subreg(reg2->var_off)));
> 			reg1->var_off = tnum_with_subreg(reg1->var_off, t);
> 		} else {
> 			reg1->var_off = tnum_and(reg1->var_off, tnum_neg(reg2->var_off));
> 		}
> 		break;
> 	}
> 
> > ...

