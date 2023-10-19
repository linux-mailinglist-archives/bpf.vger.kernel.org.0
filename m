Return-Path: <bpf+bounces-12679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01F57CF1B2
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 09:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A08281C09
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 07:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3D2DF66;
	Thu, 19 Oct 2023 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="x9k2FEHC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E95DDBB
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 07:52:16 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECA4115
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 00:52:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrZrFBnruYvGbJL3LJbx3K79uypWLEuTSymXHZgA7tvZwMz3SnGvJWYvZ6R5TiW5wklpuAjJeJw7lsSEorcv8LSPFX0d5J8QRdp6sKiem5WCDpVIIL0SSaF76vMrnvdsjwYGrNlMzFhgEGjvUhr3GVS8LDPqCQLRq+Q+EUkhyg4hGuEFhV3P3Q+EPnUSlOFY2iPhSOzDJdDYSTehgPMsEo2SO6D7lpF+aLlIRlD5pBYx4fmDKmNyqy+Q2abxTgRt9HBeysLuu/Psl/IdB3dfG2WtQBrl0u6GRTxliSHyUG1CJ+MX4vtOS3auvdwmbDuXgJdSpy4g9TkY/cjp7QvIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vo4YGJhTIe8A/KGvrE+Y4FhiMqLn49goC0Rns9PfRbI=;
 b=mJ/zDboWZVH9/x2LnxTxSiMJmGQ/UPdDu5roR36vh1mmaTONobV2na3IkzoywFxLm8V7gsoQUSZPt8w6Dkfu0s/LYmzzAb5L9ayVDfBHc0dnZc2V0/Rs9vNYgJKuoOaySm/49PBZmQ5Wk7V94Cbc2c5xBopp4mIEiLM8/jMjdd1V1KtSrmjPUwWgt3OisFp6nYa8MIvOKVRfz1tyeIl4CM5KQkAmScLuXtuxDTaJ+zxzuscVw9+fxxW7PMBIgRN5xAMUs/rdcnQZ+9ILTP23dVjbseSxwszbWwR6yEVI4kVmNwqaWFp8QXUIPHdSLcJHiIsH8qWDz0cNnqTCHElT1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vo4YGJhTIe8A/KGvrE+Y4FhiMqLn49goC0Rns9PfRbI=;
 b=x9k2FEHCA8Cfp4jgRCbVm0mTR03T3+D+EZUyQP+c7Irg1E/Gn2a7EnxebCLyt4Qu/PuIjjyNr7qTsBnb2EsYBmP4bEyCjZF1y0XHnPggMtT96VUMY0q8KBRNuI6/cT/i10laQzlnbThIfgHXVpwQC85y4beGXjQJpuFaCUT82vEqbzpeAUxekCFBzJyEtNAxiNeWPCiReHDW+p/0zq18aMGPO1Y0HI9dgLUFS4oHXU4nfNErk2t+8zdpKfGM9Pr5f7SjdYDZGAbv+MVeNB7A208OAquclkR2aQeb6LtPduiohLtmBf4jktfWMkG7qPyQX0G3cDpL3wCPtZ6W6VNN2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by VI1PR04MB7037.eurprd04.prod.outlook.com (2603:10a6:800:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Thu, 19 Oct
 2023 07:52:10 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a%3]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 07:52:10 +0000
Date: Thu, 19 Oct 2023 15:52:03 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: Langston Barrett <langston.barrett@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@cs.rutgers.edu>,
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: BPF register range bounds
 tester
Message-ID: <ZTDgIyzBX9oZNeFw@u94a>
References: <20231019042405.2971130-1-andrii@kernel.org>
 <20231019042405.2971130-8-andrii@kernel.org>
 <ZTDbGWHu4CnJYWAs@u94a>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTDbGWHu4CnJYWAs@u94a>
X-ClientProxiedBy: FR3P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::14) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|VI1PR04MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9800ed-6e3d-40cc-25a6-08dbd0784c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8jPnhfVpBjNwSp0UpUpma525xJArQC7+U1pVdSL+nvFGhU6K/WXt3Xbps8NxHwwQUR4VWAQOuiFaREGxqD93E9sH3ZmQuoHCiymwNh4YPGQm+Y654OktcByG32q2ACi7XwkDakEDUnoD+H7uCQ+VqkKHCb/XBHgT1PFczO+qicTkDYC273XOf6wy14JEG6eyaxpBTJZ3QCsVGcvcCYb07bag7aIll+VG3EeyijS/98z4jfwOshNd5FhK/2ep4cakXhP1kL5CCY7Ibcu25pKdznsyRFNOkeAiVjHqjyAyk9w/XmyqsCw82ZnejBC8sfSGjmPLwdYXIO4WXqkJZz40L8qpc/7tAvxGsLEehyzZmAPf43D2Ka/UzrQwgSbd0J8ZCrSFn+byThvhAbXCQnbW5TNiFsUOg56FEOBqt7/iu+ueK9C6WGmO9aGMKzcNmFS1lSKpSr9FsZAGEFR4rdFaYGIl9a45ed2vyWII5JZzJ5bjVwyHSOo75gbuaUQiZGAZRf9oKHQOyDx9ivGeOwgRK/pyEPRQEEJWyGamIo3u5cuNWBBrAKxu1mLTloVCYj1hB6dJV6e7ppJh+sDMFwrDPw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(396003)(346002)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(478600001)(54906003)(66946007)(6916009)(316002)(66556008)(6486002)(966005)(83380400001)(26005)(66476007)(9686003)(6506007)(6512007)(6666004)(2906002)(5660300002)(33716001)(8676002)(4326008)(8936002)(41300700001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnE1WFF2TVZBOTZlWlVzY01sd29DeHB1anFzYmtnemtLT1pPUUNxcjFZcllG?=
 =?utf-8?B?b1YxOTB1dHF6ZmJjbmZNWWdSNUE5MHJhMFVqbGU0U1ZxOXJyVlRycENrd2Fz?=
 =?utf-8?B?engxYlBHcVluTmFDenkwdU1FL1kyQzQ4dHZMZFVYYytWNm13TGY2YTlGODQy?=
 =?utf-8?B?aWFlRHJSTnNoMGNlOFphenE5UWs0RFp4Ti93bFBSbzF6SnR3QXV1T2g1c3ZF?=
 =?utf-8?B?RnllU3ZRNDg5V285U3p5Sm9EM2ZDaDNHRlhoanduTHNJODVVZmRiRC9UYmkw?=
 =?utf-8?B?STJxNXhsaytQNmdWZGt2eFluTUJkTEptdkM1OXF5MDA0TWtUVjBXNnh5TDgw?=
 =?utf-8?B?U3JTUnY3dkRLQTBUb21FR1J2amdWTXUwODJadFpEdFZaN2ladXkwMERKRDRa?=
 =?utf-8?B?SjliSllYT3BTeGV4UUplS1FPd0pPZGs0aGFRMXJhZUJWRUdqUnJTZXhKbm9j?=
 =?utf-8?B?UXFaN1hSYUM3Zk55c0x3SWNDRlJmRHZ6Yy9GOGtlOStQMFEyT0lJS3ZubkM1?=
 =?utf-8?B?N0VWdUFzZzdmNjZkZkgxbWtzTGsvY1Nqb2JDZlFGaXZQUENsc2l4eXk4eGhn?=
 =?utf-8?B?ME9XSlp3ZUhlKytlaEdRTjI5dytPWDh2b0dPS2V6bVlrTlI3NFMrcDZVaFdt?=
 =?utf-8?B?c3JaTnNudUNHSHMybU5EbllaU2FzbC94dG9ZUnMzQnB4RTRUQnd1dmtkVTR4?=
 =?utf-8?B?dDl1ekVyanI5TDNkSGp1aldneXNRemx4RzdLNHhyc2hoSUw0R09uN2FWbVV4?=
 =?utf-8?B?aysxa3o2cW1sQXQzUHRnM0pHaktXLzNqWis1bDhPMDVLS3YwV3dXcGw4Z0Zp?=
 =?utf-8?B?dkhqZFNIOWt6WE91c09sd01PWWhIOUVkdmIvTXphK0tCRUdkS0pGVlZXbERE?=
 =?utf-8?B?ZG1YcnFlTWQrY25MVmVyMVN6ckFlcjJnQ2oya3VreU8vYjlMblhQSEVSbFVB?=
 =?utf-8?B?QU5MQWRPRXJ6Y1lOWFhLNC9jcWNQblQ1T1JtV2U3cDZVV1NGcjROMDNJWW9l?=
 =?utf-8?B?b0ptblQ5OUtjZ3JwUDBtdlYwRXlwQVhRNHVPM0J0am0xMEM4VnBZUEkwVjBP?=
 =?utf-8?B?YUc3SXMwT3YyZEVpVTJiZGRHditsWnZEOHNkZi9UNUxyYW1HbFdQaUNaV3pV?=
 =?utf-8?B?UVVWdzNHN1JKTWpsR0xsbkorZ1V4ZXlyZlZIMXhBR3VDdkRUMVJxeWhPUWRH?=
 =?utf-8?B?eFZhWW1jOXFRdXlWQWgrTFVXVFU0QXVKSUNNWkRKbFhYakdVN0p1aTBYNXVN?=
 =?utf-8?B?ODdaQmN0RlZPdmJWalBCWlJyOWhVQ212dnNWdExZWVY2NFBwbWJnY1B5SnNM?=
 =?utf-8?B?em5nNnRucE1KUlFqcjcyczdLRGk2UlRqQ0NMVmIvSjExNVJBd01FRThnQnJp?=
 =?utf-8?B?YVZsdDExcXdQREZFVU1KRHZSYUVmSWNmVmgzWXVKa3hweGhtdHNHQVNPSjRY?=
 =?utf-8?B?QWFXNnE0QmNiQzRUTmJFeWE5MEZTZEMvaUFPMHJwelZ2azhuTEJDcTVoc3o5?=
 =?utf-8?B?K2RhSDhnN0VKRnQ4cjhEZ3doS1I3WUpRcVE5MUJTcU9PMkpneGRCWG1rVFBD?=
 =?utf-8?B?TzJpZUlSRWs2Z0ZnSFdCbC9BSHNDUkV1MGw3NWZvN3ppTUkyajVCamtVczRa?=
 =?utf-8?B?OTBBd0VuVVE0MlFTMlV1cjVIVlZHd2lSa0V4RFpRek42TThrTkpvS0ZpRWw3?=
 =?utf-8?B?TkhmWFk1MGszMWs3eHFPdURQczhuZDNickpieTBoNVE3QmxocTVxOTRXdE8v?=
 =?utf-8?B?NCtmWWprdnBFanZNdXVQZUJVRWR0SGhRTXc0NXNRM1ZIR09jUUxadmFYanpq?=
 =?utf-8?B?YmozdTFoUGpoaGgxa0VIaGx1eUEvWUt5TXVLUUxQcGx3WmR5R1J3ck9hWnNF?=
 =?utf-8?B?eTd1QzlRbi90Sm1kdGNBU3lUNzZsU08yaUE0WDlMQlp6bGNJZmkreFU1ZCsy?=
 =?utf-8?B?SjVTSDdzb29OR2RTTXo1K2hqYjFKekZGZ25rbmVBTGFoZGlKQzBNZUR4TUJv?=
 =?utf-8?B?YmVWWmpqTmhNLzk0UWY3YTN5QTNtcHJ1NjU0ZEZGaTlmLzBzQlJsQ1VKTXlH?=
 =?utf-8?B?TUJIOVJleDZzaTBxOU1iTVdaOTRjbWh0YXRweDF2YUs4Um50TjRWWkdCVllo?=
 =?utf-8?Q?e4igzHOmpNvw13qhpxUxbBl8P?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9800ed-6e3d-40cc-25a6-08dbd0784c9a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 07:52:10.5791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fiZkSWsc2dGHz8fBTa6NLNsG+L4lanWs0jyTSH7Aub75Q+kIqAuJWFjd1CuqyYeUKt5wYCd5/hetgHeEAYjWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7037

On Thu, Oct 19, 2023 at 03:30:33PM +0800, Shung-Hsi Yu wrote:
> On Wed, Oct 18, 2023 at 09:24:05PM -0700, Andrii Nakryiko wrote:
> > Add tests that validate correctness and completeness of BPF verifier's
> > register range bounds.
> 
> Nitpick: in abstract-interpretation-speak, completeness seems to mean
> something different. I believe what we're trying to check here is
> soundness[1], again, in abstraction-interpretation-speak), so using
> completeness here may be misleading to some. (I'll leave explanation to
> other that understand this concept better than I do, rather than making an
> ill attempt that would probably just make things worst)
> 
> > The main bulk is a lot of auto-generated tests based on a small set of
> > seed values for lower and upper 32 bits of full 64-bit values.
> > Currently we validate only range vs const comparisons, but the idea is
> > to start validating range over range comparisons in subsequent patch set.
> 
> CC Langston Barrett who had previously send kunit-based tnum checks[2] a
> while back. If this patch is merged, perhaps we can consider adding
> validation for tnum as well in the future using similar framework.
> 
> More comments below
> 
> > When setting up initial register ranges we treat registers as one of
> > u64/s64/u32/s32 numeric types, and then independently perform conditional
> > comparisons based on a potentially different u64/s64/u32/s32 types. This
> > tests lots of tricky cases of deriving bounds information across
> > different numeric domains.
> > 
> > Given there are lots of auto-generated cases, we guard them behind
> > SLOW_TESTS=1 envvar requirement, and skip them altogether otherwise.
> > With current full set of upper/lower seed value, all supported
> > comparison operators and all the combinations of u64/s64/u32/s32 number
> > domains, we get about 7.7 million tests, which run in about 35 minutes
> > on my local qemu instance. So it's something that can be run manually
> > for exhaustive check in a reasonable time, and perhaps as a nightly CI
> > test, but certainly is too slow to run as part of a default test_progs run.
> 
> FWIW an alternative approach that speeds things up is to use model checkers
> like Z3 or CBMC. On my laptop, using Z3 to validate tnum_add() against *all*
> possible inputs takes less than 1.3 seconds[3] (based on code from [1]
> paper, but I somehow lost the link to their GitHub repository).

Found it. For reference, code used in "Sound, Precise, and Fast Abstract
Interpretation with Tristate Numbers"[1] can be found at
https://github.com/bpfverif/tnums-cgo22/blob/main/verification/tnum.py

Below is a truncated form of the above that only check tnum_add(), requires
a package called python3-z3 on most distros:

  #!/usr/bin/python3
  from uuid import uuid4
  from z3 import And, BitVec, BitVecRef, BitVecVal, Implies, prove
  
  SIZE = 64 # Working with 64-bit integers
  
  class Tnum:
      """A model of tristate number use in Linux kernel's BPF verifier.
      https://github.com/torvalds/linux/blob/v5.18/kernel/bpf/tnum.c
      """
      val: BitVecRef
      mask: BitVecRef
  
      def __init__(self, val=None, mask=None):
          uid = uuid4() # Ensure that the BitVec are uniq, required by the Z3 solver
          self.val = BitVec(f'Tnum-val-{uid}', bv=SIZE) if val is None else val
          self.mask = BitVec(f'Tnum-mask-{uid}', bv=SIZE) if mask is None else mask
      
      def contains(self, bitvec: BitVecRef):
          # Simplified version of tnum_in()
          # https://github.com/torvalds/linux/blob/v5.18/kernel/bpf/tnum.c#L167-L173
          return (~self.mask & bitvec) == self.val
      
      def wellformed(self):
          # Bit cannot be set in both val and mask, such tnum is not valid
          return self.val & self.mask == BitVecVal(0, bv=SIZE)
  
  # The function that we want to check
  def tnum_add(a: Tnum, b: Tnum):
      # Unmodified tnum_add()
      # https://github.com/torvalds/linux/blob/v5.18/kernel/bpf/tnum.c#L62-L72
      sm = a.mask + b.mask
      sv = a.val + b.val
      sigma = sm + sv
      chi = sigma ^ sv
      mu = chi | a.mask | b.mask
      return Tnum(sv & ~mu, mu)
  
  t1 = Tnum()
  t2 = Tnum()
  
  x = BitVec('x', bv=SIZE) # Any possible 64-bit value
  y = BitVec('y', bv=SIZE) # same as above
  
  # Condition that needs to hold before we move forward to check tnum_add()
  premises = And(
      t1.wellformed(), # t1 and t2 is wellformed
      t2.wellformed(),
      t1.contains(x), # x is within t1, and y is within t2
      t2.contains(y),
  )
  
  # This ask Z3 solver to prove that tnum_add() work as intended
  prove(
      Implies(
          # Assuming that t1 and t2 is wellformed, x is within t1, and y is
          # within t2
          premises,
          # Below is what we'd like to check. Namely, for any random x whos
          # value is within t1, and any random y whos value is within t2,
          # (x+y) is always within the tnum produced by tnum_add(t1, t2)
          tnum_add(t1, t2).contains(x+y),
      )
  )

> One of the potential issue with [3] is that Z3Py is written in Python. So
> there's the large over head of translating the C-implementation into Python
> using Z3Py APIs each time we changed relevant code. This overhead could
> potentially be removed with CBMC, which understand C, and we had a
> precedence of using CBMC[4] within the kernel source code, though it was
> later removed[5] due because SRCU changes are still happening too fast for
> the format tests to keep up, so it looks like CBMC is not a silver-bullet.
> 
> I really meant to look into the CMBC approach for verification of ranges and
> tnum, but fails to allocate time for it, so far.
> 
> Shung-Hsi
> 
> > ...
> 
> 1: https://people.cs.rutgers.edu/~sn349/papers/cgo-2022.pdf
> 2: https://lore.kernel.org/bpf/20220430215727.113472-1-langston.barrett@gmail.com/
> 3: https://gist.github.com/shunghsiyu/a63e08e6231553d1abdece4aef29f70e
> 4: https://lore.kernel.org/all/1485295229-14081-3-git-send-email-paulmck@linux.vnet.ibm.com/

Also forgot to add the link to the removal of SRCU formal-verification tests

5: https://lore.kernel.org/all/20230717182337.1098991-2-paulmck@kernel.org/

