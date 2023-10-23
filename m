Return-Path: <bpf+bounces-13004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFA47D3782
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 15:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A916FB20DE0
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC3318E36;
	Mon, 23 Oct 2023 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hTtffTyJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3718AE7
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 13:14:25 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2082.outbound.protection.outlook.com [40.107.13.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88563E5
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 06:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enhBpD9VhKMrQFINzX9TaZ41aHKolgFVB8IEozX2Tue2jHSLbiTHE7uaNzdgTX48coit6DQUKUrXb3KBhvHudRq6KlJ7zhYqOZqbEPxaVlqjVTpvcjkO5q5ALzuOp7GoFYGOMPnWcInwc4r1Tt9Lh/KEzTWXLlxB4I/JMpFj+nuPXAwv0NSKwa4A9BfEc6EJWwVtcJr8HK35E7WDD/qzoUodXl1OmbqAx09zdxcIAGw6upynVFN2apMWwVPsTL6G3aN1X3jggaUpV2Pu2FsQnNfIs+OUEQpVGg9B+W4AI9xudTZbr1191XxGuqMV+7k0blPeDVKh/55Ozp4drMV4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnHs2QDl4QEVVWANufKNPhRBuzudefHDA8bFkXNybt4=;
 b=fS1fqH1RYp7o4enshYHHOWhl6vG+4T5TwAjdFBZt0eLufv/wUmq3ofJRtMDM3EoS2fXmw1oSNSj79x5QjvvuaRRbxtjTpGBRsmlyUFeKLE1W0zBx8/z8iary9QlZ8kxGK53Z/KVmyaUWcHqjUEpaoUHIep09P3Obtdkpsd53tbksbTCIJzvy2ccKKPi0vL5b+eEPiF0diSv7QC7l4cLqKLbLhNOagHrW9k4MVfiEDM39tzplR0z1Wszwdmik1gxjBIlDHTCpOjW/oFwgxFbevBbhZBpBRGF7NOg8k8T9QmTzRdAFWxryfVz/4EbBa76YhoX4cY7ivsx9KpVHa+GNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnHs2QDl4QEVVWANufKNPhRBuzudefHDA8bFkXNybt4=;
 b=hTtffTyJ2VLF/8J4TtUXUr9gWyz3jBuzOFJq7MpKed0t4a3+RciZVtXEbXuPrd9ZDis09hmyvUcKIhBUxrW+KNYFplmlUc17G/FVksFUPx6dMjE3K9XBUvwvmkc6+kJGrOf3STC8jjd0Dchoenu+AUL05dpMekvVUtwfxH4NMfmfeIsh/m4b+HHTEFXN2sORBDMyHEifwSj305Gv8lUKoi2hbPPKp0dq7JKFadwYeRBbAhJO+8OB6HvIo8EnJrIqH7SaTuScNdXApUpoqxkvjylh7uRqP1hoNiAxpX976KDB+prwBmxrHkYQtpZYZmgNycz8O2jjdM3noK/lVWCw1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DU2PR04MB8661.eurprd04.prod.outlook.com (2603:10a6:10:2dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Mon, 23 Oct
 2023 13:14:19 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 13:14:19 +0000
Date: Mon, 23 Oct 2023 21:14:08 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Dave Thaler <dthaler@microsoft.com>,
	Paul Chaignon <paul@isovalent.com>
Subject: Unifying signed and unsigned min/max tracking
Message-ID: <ZTZxoDJJbX9mrQ9w@u94a>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: TYAPR01CA0230.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::26) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DU2PR04MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 8daa5118-3721-4fe6-9f75-08dbd3c9f6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lHbncy22HPsymI0HgTPANVSbnEqGWXHtToVIQV1BwlCTdhXx4DI15aZekArrAPIvDUyuOL9CU44qGAB4rGGkD/fZXTfq0oBHUkPf5MsWMC4pu9INANJM5sbxTdpfmoPzwA3zlGA9DzHdQOLRMixzhacIvHH7Iumsg48jK0tFXOPlu74zrYM2bo56rUtFwA1mu65oyzZIgt0631A+kJIZWyjZqba9slCI7vaBeSvgsOTE7+susxmRuMfJsuMIlnzipwnoLqzlC5/SoDncxvfPWaE+zIOxjh2+ewGeXkNuIoFuExtIEailySbmf0qtyCyeQkK3+NdMpfKiebXLEKshl7Up3Sp8ZRyGPKDyp+5XVxM/hJZx6eeRPK6prnhtvfASQDTieprcT52d3UyJbmYpUaSTx1o4gNrpDCyOcG+AliGH247A87LD+1UJLXGjVdLK2HYeWr/KxUBxs7TTCo4IpqFVBNuBWEJStQSuh12a5USu4Dox6mW1zCGrYaDdJ6O+nsFMgl+kvcXqCa9S6YmIh2l/9pcjcaq5/gYHE/vrLwJ9t9/Pq436Da81wteTGWtsEfU3syjhzQ+55SSIVuPrnw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(39850400004)(366004)(346002)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(9686003)(26005)(6666004)(6506007)(6512007)(8936002)(83380400001)(8676002)(5660300002)(4326008)(41300700001)(2906002)(6486002)(33716001)(966005)(478600001)(66476007)(66556008)(6916009)(54906003)(316002)(66946007)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1Y4OWg4UWtJR2dac3p4YWxxWWJUTzdQdCsrTjI5a0JpbmlzZVQrVFZQd1ow?=
 =?utf-8?B?QWJxYjRKdkYxZzBma1BVZ2xiY0lYcWZiM1Y1SnFveTRZdENIYUVmUmxQVXQ3?=
 =?utf-8?B?ZE9mMDdVTDVrYVhHUFhXUjVOOEtyWEx3SWVSTjJwMVJmcWEvMXNIUmJ1N0d4?=
 =?utf-8?B?azJpZUJ6U04yeHk5em5lUkhPMzhLM2o2UUtQUVY0bG8wL08wUGNXcTBkNTUz?=
 =?utf-8?B?VE1zS01EL0xSaE9XanhvU056ODV6QmhBS0hycEVENmlBSWJ4QzM4VjRKY1J3?=
 =?utf-8?B?ZFFJOGF6d1dGSmNiY3p4d1RqUmRnU3pITFBaWXNIMTZsaU40aXRJMVY5cGJz?=
 =?utf-8?B?NEtzbzEvUkViOTZScTZFUm9JSzJzdGx0Y0lXaUJoOVU5WHRjNzh1TUEwL3VD?=
 =?utf-8?B?U3JIQkNjSDNoNXB1bnd6TVFEWGlCZXhBTkZJVGJvWlJTRjFRR3pmRmtIcU01?=
 =?utf-8?B?T2ZHd3JDVTlHbFZtQ0V0OE9VR2c4dHBEVWl0czFNa1ViT2hpc2ttNzlDbTUx?=
 =?utf-8?B?Y2Jac05OSHFmcktZc2NxWTlJRnlNK0tSRy9IZjR0eHRnMlQ1Qk5JR3prVU1K?=
 =?utf-8?B?TEF5bituYmM3ZC9oUnRwR0o1azlDQlVaY1FaNG5JbXBZazZENGNLRXdka0k1?=
 =?utf-8?B?TXBRa3gvdnlmYml1TFZuRjFRVTFJdFZOM0ZCQ1Rsd0l3b2twYkhJUDJBWTRu?=
 =?utf-8?B?NzRtdTZxbEhYZFBFUU1OUHpSQk9lWjlpaWxvdW15eExJL0xmQi9QRDhTdm0v?=
 =?utf-8?B?dU55azUvZ1ZmR3BHUy94aWtva0Z1bDRhSmkzSTJEbnZSTENGZ1VRVTFoTzBw?=
 =?utf-8?B?d0JicEx1U2Vod1hjQ1U4dlgyOS9vdXd6MnBiMEVhaGthWFhZWnlDcE1ONWJ1?=
 =?utf-8?B?NFZSUlBPY3J3MzRrY2NlSVZXdXpKK29WZUVnZUhGRzhOcGMxVGtlbTA3clJo?=
 =?utf-8?B?NGlDTnZETzVleDAzWkNDR09XbitSMCtiM3ZvZ0dwZUNpMFVSbHZ0TUN1NXIy?=
 =?utf-8?B?K0pkckgxYjNwSE1TNS9aeDNvSWQ2ZVdKd3NoN0xXdVh3UHBBV3RmT0RHMGpV?=
 =?utf-8?B?VWlNejRicHhLUHVVL1FQY0h6MDlQdmMwRTV2YUpVU2tHNVoxUnQwaEpuY1NV?=
 =?utf-8?B?OFVBTW5tQUdkdXFDR3pJRmpSYngvZjREeEZraityUlpwM2JjZmtzVWJTc3pO?=
 =?utf-8?B?ZW1GODdidTRQdkJLTXkzWjQycHg5VDJCNXppZEwwSzdLOGs1RlBaNHFzTEFI?=
 =?utf-8?B?OUtKcXN6WHhCNVJrMzlzdEZpREpQTDJXemFjSWh0MnlEMDlyNTZCNVR1YUNR?=
 =?utf-8?B?YXh0WWl5T3dUY25VUEhJVkRGRFhueGxSMFpzRU1zdCtSNXpSTUdkZldhV0Zp?=
 =?utf-8?B?cFViZW0wQWV2Z1Fnd2hZTUM4SUJJaXFKTGR6R3FUUmt4ZTNrWERiME1Qd0Qw?=
 =?utf-8?B?UGtsc2xkSU9LbjFZK2pXaHh1UDJMVm55eG1uK0tVc0hPYmtDL25IeTRkaUla?=
 =?utf-8?B?UW05ai95THJkVk9MT0hSZFZaWGZaYTdvZzJpK2ZybngwYUhyU1BtQTgrTlVq?=
 =?utf-8?B?RWhPNHJ4YUtlOTZsa2ZEMkRVbG9QTWNkV3kvOTRIZ3htM2NNTktneVJoakY3?=
 =?utf-8?B?ckRUV09OMXh3VzNBa1k5a1haTzVWT3F3NTNvOFF5WVQ1bnp3NUl1M3ZTTXo5?=
 =?utf-8?B?VFZ0Tjg0YURkR0ZlWlc0clNZcTNheTZOOGNxazFxWG5aTG5PMlQvZEUzUE04?=
 =?utf-8?B?MkJSb2FaTGVwWExsOGt0RUdHem9QSDNZQUI0RGprT3NLWm9WZllkdWVHR1My?=
 =?utf-8?B?a3ZaaGZKOFFOOSs4UGNyUEtTanArS1d6b1FZbDFkVXh5Zm5UVXJSWmY1UGVG?=
 =?utf-8?B?ZnVCYnRrUHBLNzQwUTRwM3hiaGdiSEJkRzAxQjI5bnVkVUNVSjB3c2U0VG5h?=
 =?utf-8?B?U3hMOXhjTDJPKzRVSkpJN3ZrSkhkckN5MjdFZHZtbk9zZkRTUllFdUdaNDdz?=
 =?utf-8?B?NGh6bFY5NXAxTUhZN2JkbTR6Nm5GNURDWUFsR3NGdWtZOE9pZjkrSlBwV3JC?=
 =?utf-8?B?UlE2aFk3d2FIWEtXZXNsRFFCRVdXMnFreGZXNk1xNnhRSDhoQWdaRWZhRkwx?=
 =?utf-8?Q?1uT7q4fnhRp6lAvnsKglaqmX/?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8daa5118-3721-4fe6-9f75-08dbd3c9f6ea
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 13:14:19.0771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rY/Fsb7pYWn/gHWvm5q/cqocjBflb6gw1UuJrq6E9donPbCTUUiHzn7AHbfe87c16OpABkRsnfu23t9GTpyfTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8661

Hi,

CC those who had worked on bound tracking before for feedbacks, as well as
Dave who works on PREVAIL (verifier used on Windows) and Paul who've written
about PREVAIL[1], for whether there's existing knowledge on this topic.

Here goes a long one...

---

While looking at Andrii's patches that improves bounds logic (specifically
patches [2][3]). I realize we may be able to unify umin/umax/smin/smax into
just two u64. Not sure if this has already been discussed off-list or is
being worked upon, but I can't find anything regarding this by searching
within the BPF mailing list.

For simplicity sake I'll focus on unsigned bounds for now. What we have
right in the Linux Kernel now is essentially

    struct bounds {
    	u64 umin;
    	u64 umax;
    }

We can visualize the above as a number line, using asterisk to denote the
values between umin and umax.

                 u64
    |----------********************--|

Say if we have umin = A, and umax = B (where B > 2^63). Representing the
magnitude of umin and umax visually would look like this

    <----------> A
    |----------********************--|
    <-----------------------------> B (larger than 2^63)

Now if we go through a BPF_ADD operation and adds 2^(64 - 1) = 2^63,
currently the verifier will detect that this addition overflows, and thus
reset umin and umax to 0 and U64_MAX, respectively; blowing away existing
knowledge.
 
    |********************************|

Had we used u65 (1-bit more than u64) and tracks the bound with u65_min and
u65_max, the verifier would have captured the bound just fine. (This idea
comes from the special case mentioned in Andrii's patch[3])

                                    u65
    <---------------> 2^63
                    <----------> A
    <--------------------------> u65_min = A + 2^63
    |--------------------------********************------------------|
    <---------------------------------------------> u65_max = B + 2^63

Continue on this thought further, let's attempting to map this back to u64
number lines (using two of them to fit everything in u65 range), it would
look like

                                    u65
    |--------------------------********************------------------|
                               vvvvvvvvvvvvvvvvvvvv
    |--------------------------******|*************------------------|
                   u64                              u64

And would seems that we'd need two sets of u64 bounds to preserve our
knowledge.

    |--------------------------******| u64 bound #1
    |**************------------------| u64 bound #2

Or just _one_ set of u64 bound if we somehow are able to track the union of
bound #1 and bound #2 at the same time

    |--------------------------******| u64 bound #1
  U |**************------------------| u64 bound #2
     vvvvvvvvvvvvvv            vvvvvv  union on the above bounds
    |**************------------******|

However, this bound crosses the point between U64_MAX and 0, which is not
semantically possible to represent with the umin/umax approach. It just
makes no sense.

    |**************------------******| union of bound #1 and bound #2

The way around this is that we can slightly change how we track the bounds,
and instead use

    struct bounds {
    	u64 base; /* base = umin */
        /* Maybe there's a better name other than "size" */
    	u64 size; /* size = umax - umin */
    }

Using this base + size approach, previous old bound would have looked like

    <----------> base = A
    |----------********************--|
               <------------------> size = B - A

Looking at the bounds this way means we can now capture the union of bound
#1 and bound #2 above. Here it is again for reference

    |**************------------******| union of bound #1 and bound #2

Because registers are u64-sized, they wraps, and if we extend the u64 number
line, it would look like this due to wrapping

                   u64                         same u64 wrapped
    |**************------------******|*************------------******|

Which can be capture with the base + size semantic

    <--------------------------> base = (u64) A + 2^63
    |**************------------******|*************------------******|
                               <------------------> size = B - A,
                                                    doesn't change after add

Or looking it with just a single u64 number line again

    <--------------------------> base = (u64) A + 2^63
    |**************------------******|
    <-------------> base + size = (u64) (B + 2^32)

This would mean that umin and umax is no longer readily available, we now
have to detect whether base + size wraps to determin whether umin = 0 or
base (and similar for umax). But the verifier already have the code to do
that in the existing scalar_min_max_add(), so it can be done by reusing
existing code.

---

Side tracking slightly, a benefit of this base + size approach is that
scalar_min_max_add() can be made even simpler:

    scalar_min_max_add(struct bpf_reg_state *dst_reg,
			       struct bpf_reg_state *src_reg)
    {
    	/* This looks too simplistic to have worked */
    	dst_reg.base = dst_reg.base + src_reg.base;
    	dst_reg.size = dst_reg.size + src_reg.size;
    }
    
Say we now have another unsigned bound where umin = C and umax = D

    <--------------------> C
    |--------------------*********---|
    <----------------------------> D

If we want to track the bounds after adding two registers on with umin = A &
umax = B, the other with umin = C and umin = D

    <----------> A
    |----------********************--|
    <-----------------------------> B
                     +
    <--------------------> C
    |--------------------*********---|
    <----------------------------> D

The results falls into the following u65 range

    |--------------------*********---|-------------------------------|
  + |----------********************--|-------------------------------|

    |------------------------------**|**************************-----|

This result can be tracked with base + size approach just fine. Where the
base and size are as follow

    <------------------------------> base = A + C
    |------------------------------**|**************************-----|
                                   <--------------------------->
                                      size = (B - A) + (D - C)

---

Now back to the topic of unification of signed and unsigned range. Using the
union of bound #1 and bound #2 again as an example (size = B - A, and
base = (u64) A + 2^63)

    |**************------------******| union of bound #1 and bound #2

And look at it's wrapped number line form again

                   u64                         same u64 wrapped
    <--------------------------> base
    |**************------------******|*************------------******|
                               <------------------> size

Now add in the s64 range and align both u64 range and s64 at 0, we can see
what previously was a bound that umin/umax cannot track is simply a valid
smin/smax bound (idea drawn from patch [2]).

                                     0
    |**************------------******|*************------------******|
                    |----------********************--|
                                    s64

The question now is be what is the "signed" base so we proceed to calculate
the smin/smax. Note that base starts at 0, so for s64 the line that
represents base doesn't start from the left-most location.
(OTOH size stays the same, so we know it already)

                                    s64
                                     0
                               <-----> signed base = ?
                    |----------********************--|
                               <------------------> size is the same 

If we put u64 range back into the picture again, we can see that the "signed
base" was, in fact, just base casted into s64, so there's really no need for
a "signed" base at all

    <--------------------------> base
    |**************------------******|
                                     0
                               <-----> signed base = (s64) base
                    |----------********************--|

Which shows base + size approach capture signed and unsigned bounds at the
same time. Or at least its the best attempt I can make to show it.

One way to look at this is that base + size is just a generalization of
umin/umax, taking advantage of the fact that the similar underlying hardware
is used both for the execution of BPF program and bound tracking.

I wonder whether this is already being done elsewhere, e.g. by PREVAIL or
some of static code analyzer, and I can just borrow the code from there
(where license permits).

The glaring questions left to address are:
1. Lots of talk with no code at all:
     Will try to work on this early November and send some result as RFC. In
     the meantime if someone is willing to give it a try I'll do my best to
     help.

2. Whether the same trick applied to scalar_min_max_add() can be applied to
   other arithmetic operations such as BPF_MUL or BPF_DIV:
     Maybe not, but we should be able to keep on using most of the existing
     bound inferring logic we have scalar_min_max_{mul,div}() since base +
     size can be viewed as a generalization of umin/umax/smin/smax.

3. (Assuming this base + size approach works) how to integrate it into our
   existing codebase:
     I think we may need to refactor out code that touches
     umin/umax/smin/smax and provide set-operation API where possible. (i.e.
     like tnum's APIs)

4. Whether the verifier loss to ability to track certain range that comes
   out of mixed u64 and s64 BPF operations, and this loss cause some BPF
   program that passes the verfier to now be rejected.

5. Probably more that I haven't think of, feel free to add or comments :)


Shung-Hsi

1: https://pchaigno.github.io/ebpf/2023/09/06/prevail-understanding-the-windows-ebpf-verifier.html
2: https://lore.kernel.org/bpf/20231022205743.72352-2-andrii@kernel.org/
3: https://lore.kernel.org/bpf/20231022205743.72352-4-andrii@kernel.org/

