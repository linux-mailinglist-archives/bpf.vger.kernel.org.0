Return-Path: <bpf+bounces-32919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2690914FD1
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 16:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76234283F96
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 14:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152D7144D37;
	Mon, 24 Jun 2024 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QAD7H7q7"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050317C7C8;
	Mon, 24 Jun 2024 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239018; cv=fail; b=geH7tbJHNA5VEZDu0MGoMUzRgDt1SvxNl6BX0VRRSFXYoglvN7jIFC8NZVyrN9dQuXdsz2CiKsUZ+Z2P/ziolobr8ZCnI5P9zWW1vmejOWf2G2kinH2jXyBnVOieUUDSreamdmFSRGZ1KOxpzlVHkzAN8Y1MT18DmKV7JzlZUj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239018; c=relaxed/simple;
	bh=FDZhOh3g8JM42gWHupn2r8I6VymV7EXBWgaNZc8NZm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OdbabHXfWK4aSf37JDIrwVu6AorSH0ahsL31738hfE2+bUynHNu1IWRRtbEI6We4yNiHaf2Uychpf5InTtsKJ8kkf/Hav5OPERsmk+L91ynUN6T+bXakeShMvdnLKDKGvWCPqOdtX9ZJNJIeMlk2q/YV5gSnAp+wyDpoGVQfWcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QAD7H7q7; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bI4MTtn7BBIoFNJxqdVaBiDv2WHv2yZCXRbkOo9KMXXL8g9E6bNKynXZniNbxB6XRQ4isIxRqLlkMRerkvMbsHm8YWzxko1xfxWcuTrb4hZJzIrYbaDtj/N0fgwLGD3qhQ/TQjplUXP+Sna6ZIyMgY4l99q91xPvdxvRpi+Qez6vANDMKPI+L7YDnnPn46OsSc+IVXxFhIS41p4elHfvOZ2XfBWDvFAI9OCDhUCESKXfeEyo1LcESES5IEWxC32cAOecHKs45dEZuuCSifEtNubAAAm1AJbYxZZ/3bDD+eWIVAYP/m4xjSBuG5YHc6VP1Z20NT7EDpOgytQP4nsHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ih/aWMDmViLIjsOOn0FaEN+I9a8c8YV+2ju6Kp8oxQ=;
 b=El5O4ueBRfUdX0w2rOGXX1EkGfYZv6KfK1EsSzyMRxwskkqO+FtJe3UNVArEBck+4k2LaIuiNmaZ375o8xs4RnVo/q0g3Urxrgd1eQiYlyo9wOP6PpCWbVbLiG7my1zK8xmKQFhSi508DFzbBSxPp1VdvbKjcShzLop0yRtBDaLJ9P98qXeJjtCVTmkvRe9XCNGflOIZfDV6J7Gq3OEb6F6ZfSgMqr9VBhtBbNhMd6Jc8t/9xSPTHwgc2V/W1/mk4jNTjGBDEgMc4Lrd2mAFsq75uGHIwgKZo8c2FnVWNO8/Hqh5FOVVqtZ4j+9VU8LhpJQRjO+evaAWCosoYhiUtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ih/aWMDmViLIjsOOn0FaEN+I9a8c8YV+2ju6Kp8oxQ=;
 b=QAD7H7q7cIpQgk85MJyAMcAmvZ1kdmlxSelMq6XdcXr+ICHZVBGBNtydQxwhZuimjjlQY8xJmwuaP9kttdtB420GSZtfAHU9gej0nuVyfmZghMJ4mbB/0EjlMaCNKRM2a0ebUmPK/rFOgXjx/AKJCB1iznhdCQ4xsm0S6/oeIQ+hVL2rqrGZSlHoNnBWJYAXs4ynbSCj5slINqyo8vOCweunD/FJsPBOOigpKF8hwJS1FUJ32Ci4ERr9kpefjjAfUmRX5MKMc1KmMbpEgrYbQa8vmyyc9UzptbXu9gqQA1G2wljbkYRgnLD2XeBSvFQgPVix2FrpTWNEIbKIZ/OmgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3843.namprd12.prod.outlook.com (2603:10b6:a03:1a4::17)
 by SJ2PR12MB7919.namprd12.prod.outlook.com (2603:10b6:a03:4cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Mon, 24 Jun
 2024 14:23:29 +0000
Received: from BY5PR12MB3843.namprd12.prod.outlook.com
 ([fe80::efc8:672:884:fafe]) by BY5PR12MB3843.namprd12.prod.outlook.com
 ([fe80::efc8:672:884:fafe%3]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 14:23:29 +0000
Date: Mon, 24 Jun 2024 11:23:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, andrea.righi@canonical.com,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
Message-ID: <20240624142327.GA1405783@nvidia.com>
References: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <871q4rpi2s.ffs@tglx>
 <CAHk-=wgN6DRks55fsqiJYE3uV=_QTgzdxOvh1ZZNgm_YooKdYA@mail.gmail.com>
 <87v822ocy2.ffs@tglx>
 <CAHk-=wiRgsFsrnTR8XShrS_-aYS--4DSrRPmaWtYJ55-fmjznA@mail.gmail.com>
 <87zfrcx81u.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfrcx81u.ffs@tglx>
X-ClientProxiedBy: BL1P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::26) To BY5PR12MB3843.namprd12.prod.outlook.com
 (2603:10b6:a03:1a4::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3843:EE_|SJ2PR12MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d68f83e-1637-417d-a4ad-08dc945937ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|7416011|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jPbM9FhGdgcXaMUxb5nbxRumy6yrAUNUFKxU3ifWHVP/EgxJrU6D43eR19FZ?=
 =?us-ascii?Q?4SwHfOA3cSk/lYihqJazw9lbU3y9h04kFnCoNrBmGM9Fv1XelADJHXfjpQ2Z?=
 =?us-ascii?Q?RJm5HmfRf/5PFUxnzK0hWL+GJIF2n0MsbTXI7+vU7QEuQDtOzEAazVMKO8/X?=
 =?us-ascii?Q?+5nOnoid0v77+7p+QoU0uo3t8cX3T/wHFFEvHqUbaAJyWGzNMAdWS5IFxYvV?=
 =?us-ascii?Q?dMLd3NdOBGtLEdFmh5XeXR08czdca6FIDVXQaRMv9nvUTT6yarGmpbDnewgA?=
 =?us-ascii?Q?aNWGigSb1SgwGfHfnzsc4o3VnKOzhmFffmwBLT2Q0uyrohwsVjEWxKgezufw?=
 =?us-ascii?Q?l/dar6Xo3ViwIbSq1fJrFk/pkQ+H4EWjKaH3ZGEB4WkuewWQ423tUQUlvf3s?=
 =?us-ascii?Q?nzLWCv6u85gYWKhzR56NoxnUqyMe0N6gc2SW4DeYteKEKU1DfPtqxGoHrzIb?=
 =?us-ascii?Q?K5+EgzIBF2VzP3/kCnnshIYd19SJGzas7HfSr0x3q+TsuP0qbyJh9Sviu42e?=
 =?us-ascii?Q?bWokThzoypfOZTFQ1OqOQ/L3HC6cMtUva+zphnLgkCdLovOJQxSkIxe5t2kC?=
 =?us-ascii?Q?kHR6D9T0evw+Phcl57q9/LKaqHdEOhY9Kn185Jl57CSP5X+EwiCXjAb6aM0X?=
 =?us-ascii?Q?1NMv5pogv4vX4kHRkl8Via/NpZIlusjulPQ8nzDbcNsRCkNyTRucQjfmKO40?=
 =?us-ascii?Q?MnF9Wg1ddeOtOtcGfPS+NmV+SOgW/pYW8zmLNPZNn2y+hodHiMhki4j01aCX?=
 =?us-ascii?Q?zr+CmeqAdpzY+SgZsA1SaPEJcvKT3K3YokMOIAm7X8I/SJotp79T3MQt377f?=
 =?us-ascii?Q?WQL/sDuV3szui+XEGFrmqkY10Lj9tkDGXoT8OHb6BRcrXPeDWfnQW5xvdRIU?=
 =?us-ascii?Q?tVT8SOfBtyzFwzztb/mYFWj4WhgCdYSVHvnyc+6iM4119tSSbaNtxpZzj/Xc?=
 =?us-ascii?Q?jyI/GzQKCqls07e+h0zRMkxalVqqiADB/YLHUzJitxk9JgkuCdJDIKIH91Jp?=
 =?us-ascii?Q?kklTbxy+ywq3e8WjKGI9vrAQCvrR8lH+HaYRXjfQaHGD0S8OS6s93rSem+wi?=
 =?us-ascii?Q?cxvZt10Fk7pnM1jhwM1Qb0q88SCcFTUJkBCwEJTxIPNTpS4BpwIZLzsQGYkh?=
 =?us-ascii?Q?sAbnvN2TaXsDZIXPtZiU2R4JSSxzvrsn+vj3sX7+ph1zZWPed9QdBPwtPoGY?=
 =?us-ascii?Q?faW/MfibEDr7GoNlTj3hkop9yecUGZv+2nRRpopZLFUL8ZrkypPVqjj2toua?=
 =?us-ascii?Q?3A7D9OXTYQqhwMxCM5gsICv+fuKR/61JnfjTERlGedzzGcI4mHzSctX0Ru/4?=
 =?us-ascii?Q?Ao6U2D2R0Vr9vVzQmg32DFPT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LnjWSUalx3t1uBE9ZeCGgJvPz6YdPnfL8xMS6Z9E6tcYGoERQtU4jFQ27bLq?=
 =?us-ascii?Q?6XTsMkSOHIbmNZ1FKZtj8TV9bRaI+rbjrS6gv9B/7AwFjgPtWaJXdDpf38UC?=
 =?us-ascii?Q?XV2v530GfrdMaFjzIsYpb4qDrjDjIR4leYAVvrVBH1hdPzfAwVXwsjd/9ink?=
 =?us-ascii?Q?Cc/nT5tQWoaj56a6zaVI2ByOXNHV1k5CQ6xD3i+B4/veR/3KGm9Zb5ON2jaE?=
 =?us-ascii?Q?NctiIA5S8mAOLv7itlqJOmpCNwumuaAUpV0qOyV1HpWGF72hU/eWFLyTO/ZM?=
 =?us-ascii?Q?NBUXga27AH0tAM2ElXyzYLRHpOdjG8r8V1X8ZCCuxIFePHecmUCsqw/CD6IC?=
 =?us-ascii?Q?uOAb/9YLgQBQalL2kCW+sHB3BixspL115LC2Pe/OirlSIKn4p9EtywAW5a+g?=
 =?us-ascii?Q?3UwfFK7m0/NR3UdPcIZJKAfYEeuIfoUNNnDLrDettx3fqrnjBbNBdQZqApbM?=
 =?us-ascii?Q?16iNtOM/kW1nt9Rdv8v+LICvz/DUcRVUTBuaq5qYGBHjVn/1SUTMvA5FMqKd?=
 =?us-ascii?Q?EORP1MO+jAPisDWd/GfS5W2ZEWTNNxaB1iXeQT0yL+KAvwQ3FhdvMTW7mSee?=
 =?us-ascii?Q?iGQlkPLd06aG06Kf8W9+xlj3yW41S5AHATOvxMMorMp04yeWKVQFTaegbTfQ?=
 =?us-ascii?Q?s0X+SByCAjv0T9HGsNXUzDMmdJLLVGJpzeITHLA9M8Toftt8x0HYRGhoNMwE?=
 =?us-ascii?Q?Xm7E9WDdFmbe5WFWg/N/4HaNuzQV6pp/UbhUZvEuaM2gqH0ghaZkOVaFKRL3?=
 =?us-ascii?Q?VNpWGkYz7pjiCtOfLGCOmE9wj0xqchi2sW3MJikNAUBurV1jzSvklm9yEzxo?=
 =?us-ascii?Q?8me3Ni17/Q9/+kiY9CFsGD1LAtwomJBual74x8K86CCO6S/tcPM4j9rPb2XK?=
 =?us-ascii?Q?nmHD4QmMOBCx0kI70WNLbSSQRpocD0U/VV9NMe5P3NK5k/6++hsqWK/l6Zny?=
 =?us-ascii?Q?DGj4iqziUr6wyRLyawAGgEBMqKkC0CWUmEPFI/ae86ffLNABmxY9Nr6imCXR?=
 =?us-ascii?Q?EUBtwV8ifJMUfG7o+7jM8wP9PkXsqIeObzBn6jRZkgtBaHRuJj2uA8K72wkR?=
 =?us-ascii?Q?1lQSTWpOooDXhUPCLNCQ4N2MOMHO3l7HAHK5oyjEGbgH7f2pk0WrJTdbHmNi?=
 =?us-ascii?Q?R7KM8KvLLrvTY6NRDiWmXLUZVH0szsDOMHdHsmFtlo3JuHAyJpLjXFzonbyd?=
 =?us-ascii?Q?J0gxigdfl4HdpgPxXoAa4LWn9JQzxoKOOMYHij08ptHSULN+BlF3HvHK4MYD?=
 =?us-ascii?Q?nYD0FsALvyO0M7XL0KYjLNK3oxCD1APtTTOfpwMWtEh2KrrxB7reYQnO1skO?=
 =?us-ascii?Q?1d67aMUhe4BAzcIJ9JP23ZTIJZYteBZwdkjzn/EmBBIQ3SpRbrfshSegWnSV?=
 =?us-ascii?Q?ojfkTPJcSFKEhJsqCGuv+qOdQEXdSVgv2vCRoOZCYMqpCiuXD2q47XocZob+?=
 =?us-ascii?Q?fe3wJNRdS9CaQXmcoqd3eoQ4CeYYsnacX6huvF2DBFY4+ek57sdPOk4lsLqW?=
 =?us-ascii?Q?1SevhMsLQV7efR0EnXUORAcEY1fd5WbN7ChYxekQPD4BBrJslxQwjG8l/vVB?=
 =?us-ascii?Q?9EtI9I+VrERQEpNgqAM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d68f83e-1637-417d-a4ad-08dc945937ea
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:23:29.3454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUCAM/mqzI02aKGkUk6fJR5reBAgtvufakI+m5Nvc3duZmgjpBEBrKfn+KGybiqT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7919

On Sun, Jun 23, 2024 at 12:33:33PM +0200, Thomas Gleixner wrote:
> If I want to compare another out of tree project with sched ext, then I
> surely do not pick RT but DPDK. The network people rejected the DPDK
> approach as they wanted to have things fixed and done in tree instead of
> letting everyone create their own sand pit. It worked out as it made
> people think and come up with XDP and other things which gives the
> dataplane people a proper tool while having the general stuff work
> nicely in the same context.

Not to derail this discussion, but this is not quite the case.

It never "worked out", DPDK has continued to grow in importance since
XDP was invented because XDP/etc are not a replacement for DPDK. It is
still the case that places using DPDK really don't have any
performant alternative.

DPDK growth has been significant, in fact, it is quite likely this
message traversed some DPDK in the internals of the internet on its
way to you. It is an important and necessary project for certain
applications.

DPDK is very good at what it does, best in class in fact, and fully
supported by in-tree Linux. Just not via netdev.

> In other words, that forced people to really collaborate and sort it out
> for the benefit of everyone. 

The discussion on these topics created animosity from netdev toward
DPDK and that has created some community/collaboration problems in its
wake.

IMHO forced collaboration doesn't work unless both sides can gain some
benifit - in this case it was not clear what the advantage really was
for DPDK. For instance DPDK-XDP exists, but it is not widely used
because it is slower.

I don't think there was a benefit for everyone here. People remain
split based on their use case and there is little actual
collaboration. DPDK people know not to talk to netdev :)

Part of collaboration is to be able to also know when collaboration is
not going to be valuable or feasible.

Not sure there is a learning here for sched_ext..

Regards,
Jason

