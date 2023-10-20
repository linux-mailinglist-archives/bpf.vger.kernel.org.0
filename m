Return-Path: <bpf+bounces-12815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659427D0FA4
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 14:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A0F1C20E73
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 12:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660EF19BD4;
	Fri, 20 Oct 2023 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LccNg23t"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0C71A27A
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 12:27:45 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2048.outbound.protection.outlook.com [40.107.6.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260B8D49
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 05:27:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fI/+2GJgkTWKEfLGjeTMO52LnAjGVkg4ve6dUYnyfV8VO30lu5yPs8otU2ADbBwC8X18LSNVUtmc4za4nzckyD827+c9TXqreUu0W9GNkXXJQvBqVyFXtSDrqbB7xEuOxMqhup9P1k0FwdjtMjdEAc955AF36geFJwZmEaGsJX4z0kDtjEZUrcqw+RgSkQxzVea6rRb/CisBhf1wsTBc1oeB3J5HGyVUnnYzv4mG+0/ib7z2xSBcipf0+dymQ6qiANw/J3XzYhtMVArag7wy/ppDiRE5idQuv4LnGcCzCVTwMpO7K5HGI10xxY5Bee8sKXimXBiJz8/sZytDVsUK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQfqEJahVjM4uE7OOUHQN+J8jcnJNPaoRnxvO5JQR0Y=;
 b=f4+E+3M2fYogN7vmzBb4+ZFj7YM3kheI4hUEMMdhDdFPB8A1c0anSejQYQoAUU+BjpLP5QCQZ9OA4ksj7B9gIzSaXSS866yglbGL+0Z+soCdq+rOm/gfYYKOlypP5QV2z2x/AGtgZkx2MYd+9oUj7yymzhzuDR4FVuNQvDRxGL8vzkqcTpwhxe/Af8vo4QceCdIkr7VJCWhcOmF/2YCiPkiKl+ttvY2J9DLtEFW8t1k8aQjyCDP84wGweoIPIKvLzsyjNYLwmmLi4sjSDs+vZhDvg9hLlzcMFk9Xaj8EprOtA3eIRouOIw/REq6xOXLO//PFi7mvSTwGcyt6pVm+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQfqEJahVjM4uE7OOUHQN+J8jcnJNPaoRnxvO5JQR0Y=;
 b=LccNg23tNUV7ZD9xjIeR5REMGYXjdFAAdH3yDYIdumQeky0eJ7iVEX7kB+dO2DNdO1d6vuAvxCLNjawHYwWQZcFB3S+hD2SRqfHeJS623i65aG2JcHyGqj7gl+Cl9B4MbrjBtW8PWaJ/2UcOfJHDMj2+ZhKLS79RIu0I1otqlNJ6GKgXE+MHRAnZeuXIoo5E8jcbBxBNh1RSM4YFSfrOJOqXPWY8TZmlh7DATWZ1bMc2KF3Sk+SFC3Xsp9jNSH269gaK+TkW+bkc5WGGgRyyd7vvCCoreb4kmrMCjEuxxlYfkdhJNfcEd1fpLMPbAKBolYkulr31AnTujxs0tyyhCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DB8PR04MB7049.eurprd04.prod.outlook.com (2603:10a6:10:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7; Fri, 20 Oct
 2023 12:27:39 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a%3]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 12:27:39 +0000
Date: Fri, 20 Oct 2023 20:27:32 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Langston Barrett <langston.barrett@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@cs.rutgers.edu>,
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: BPF register range bounds
 tester
Message-ID: <ZTJyNJ44ekEdazfS@u94a>
References: <20231019042405.2971130-1-andrii@kernel.org>
 <20231019042405.2971130-8-andrii@kernel.org>
 <ZTDbGWHu4CnJYWAs@u94a>
 <CAEf4Bzad+jgPWQ37VM5JOw4GPHbjZpJrxmRsFs8N0MqeMHyLSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzad+jgPWQ37VM5JOw4GPHbjZpJrxmRsFs8N0MqeMHyLSA@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::18) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DB8PR04MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9a7a31-4891-4c59-f9e8-08dbd167f324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ye/6c0B4eRN6yy1dDhJcKd4f7ctplta4TnKpuPAcT+doJvh0R/qt2xotvoTdukJFnyuxNVpfEEAsMDU5yWcff6qBtLJFrdSyD7ov+yad7TW36CtA/BC/CnbLlD3pkwFGVG2ayP/x36nza5LyH90w/uZku+0Tq89I1F+ylzyS+RWcmDRjjW4MWOUzQwD5Rw8q5d02KFokuNHr1WEVSoEhA9b8FiB6qdaSzOPijydvkk8cudNr8KX5uVMHXnv4uSiAZrBUc0X1N/4KseiAAdtVgGmCIvFR6dIoDJmECYUmyIcpyXPAw32ed2/Ko95hEu9qZF+7vZ5JtqzhhPH/L9kO2jfqs3VZPCyyJEIlKdT14nKszSEICJzMPhrTeePoSPCR00YUsXYWHDTpnBaiKsNXlmc2WqOwc5OMxhC/lJfnrLLaRu67NoDmS7D9XyLTWBkR9dWc9qxSE46maEBZvEzZjfCRTD+5jT8LauN8Rat9G7TF4PJiqVRoPVqWz3IRvUCyK6hkmT6xmdpC2gKCE+WTUbFJzEO2sNpBuXekjalzV60=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(66946007)(66476007)(316002)(66556008)(86362001)(38100700002)(53546011)(83380400001)(6512007)(9686003)(26005)(6666004)(6506007)(6916009)(478600001)(8936002)(2906002)(6486002)(54906003)(7416002)(33716001)(4326008)(41300700001)(8676002)(966005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjZLYnBRZmMwNExVODRRQXFGV1F2bytDdERSQkVDRGloL3dkOXFFVGtTWThB?=
 =?utf-8?B?MGd2UWNmZVdJOU0xRXJXNk5qcHVYYndxeExsMFJCRmppWEVvdWt3eFV3dWV3?=
 =?utf-8?B?WkxxM3YvR0k4dElHSjcxcmtDZ3l0akJmWm05d1J2ME4zYmxodk92cHIxaVJt?=
 =?utf-8?B?WER4MUprb0x1elZ1SmtMS1hxZ0laZjRxeEpsWm1UTll5ODJlVTVGWkg5MmJ3?=
 =?utf-8?B?T01jdnhqRG56U1J3OWNKYk53Mit3YXZmZmttZXBHbkJqb25aQVZJRFVsSHBL?=
 =?utf-8?B?RGFON3paZmEvZjJZNGtCdGFDanp1S2VNQm8rZmQweWRSNDhCd0tuTzFTRFpa?=
 =?utf-8?B?QTNWdHdZSlZseGgrTVJCZTFPOU1HRjlTbXhKTTM5Si9wNWRodTRSb0tDS1JY?=
 =?utf-8?B?dytUV05td1JWUlE1bForNDZkZ1VjeHl6dmU4WHBvTW1OcVdqVzZHc1pKb3dI?=
 =?utf-8?B?TThVNU1wMnJJRzB3am40N0FmSit5WUtwVjljbTIya2RDOWU1ZFh1R1Vldkwz?=
 =?utf-8?B?blErVmI2ZU5aYjA4K2FqZUY3RjJQV2tZKy82emRIalBOT1J4NDlSQ3VLd1JM?=
 =?utf-8?B?OWZXd05MeTFxYmZEd21Oc3ZCellFdjU1WS9MK01tb2toODMyNkxZVDJzU0Za?=
 =?utf-8?B?bTJpTXRlWUhNbXFhUk0xRjY1SWVlejhyWFNWcVBoSGRMWWhpTHRBMkw3dHpB?=
 =?utf-8?B?bE1TbnVvV0tldXBienNBTVlNZDZXYlJ3YzU0bGxnbktOdDVUM1RwUEhjVkgv?=
 =?utf-8?B?TXllb0VRM01UUGRvbXlOdkhQUDNxa3RZdDN5U0R6WDNzdlVYeHAvZW1FSFFw?=
 =?utf-8?B?Vjl0VkhvV2MxVHhobW5NR1ZtWm5qYjZKb2FnVFA4TWh1amMxb2xQRzNPcHdw?=
 =?utf-8?B?cFp6clVtUkZ4T3drMm1EbmF0bU13T2w2UUMrNFJLejIyM2k3THo1OWJ6dkhy?=
 =?utf-8?B?aWlvTnp3bnJYWG5neXprZlY2Uk1GenZsdi90aHNud1RjZ3V4M0VscDJQZDRR?=
 =?utf-8?B?RzVxUWtlemJnSHVFL1ZFT1pXTklCbGxuSmZZZjlnT3NLY2dBdW5aMkJrbjdD?=
 =?utf-8?B?ZHRvS3ZYRHVxVXQ0V2tMSmRydHZpclhDaEFxeFJaL2hQdWkyVEoxR0tYYkZh?=
 =?utf-8?B?VHQ4YUo2QThGNHBGNENsVnU0Q0p4N3VpaGlxMTBQRVEvaExSQ0pXQll3TXhq?=
 =?utf-8?B?Uk5hbG1SdjhrT3dGMC83aUJhNGViVlJmWGh0ZGtURlBuem1nOE43TkNZWnQ4?=
 =?utf-8?B?OVdsNmIwc296WXJKNE1iVUs1VmNHdjNneWpkRGZBNFpnMGlZYmlvRkZtTVB2?=
 =?utf-8?B?T2ZTZWgrQ3VBQ2g0NDdxYVhNbUUvZkVaZVpzYmVoK3hmaENxSjgvbTEzd21x?=
 =?utf-8?B?WkFpODk0b3o2ZlBsUysrTTEvQjVOOHVhM2tLRjF2RG9VaURIUjg3ZW9mM1RR?=
 =?utf-8?B?U3lLNmdwc09CN1lpZzREaGNiblVYSkVRRmxWelFxdHNrLzFGVFNySXZTYjlj?=
 =?utf-8?B?MGhETk9nbi9KWno3VHhQcGNFcWRhOXV5MnJYY2tybFV6NUhvandiOXVNaVow?=
 =?utf-8?B?SGpMM3J5QlVURkVTV2UyQ1dzQ09qUjJDbEhjZUJ1UmRqK25FMGZYRGE1ekUw?=
 =?utf-8?B?OTZPYzQyU1Y0T3kzcUx1M2NvN1c3MVZVZS9VWGVBdVZLdzBjVzNZNkduRWFZ?=
 =?utf-8?B?bGpKa1Y1Mng2WGFVL3l1YmtCNldGczZhNU1tVjYzLzB5bDhDUW0rY1hCNzd4?=
 =?utf-8?B?a09VL3E0bkVua29hY1dDbFRmN1hnYlBsSWx5YjFrMkUwY2FYUTUyTVFBc2FF?=
 =?utf-8?B?YVhHVmtuS000N0libTFXeXU0SFhkWllLVTdSZXJtbWE5MDNrVzF2NzdCTGph?=
 =?utf-8?B?NjAyRitaejlVQVBhZHdVaytsb25YU29raWJtY0ZYVlMrK09ZVzIvcnZOQWlz?=
 =?utf-8?B?dGVrRVI2dFdRQlNpQXRGOTBiV0Q0VURmUnJlNWladGtrMmY2cnVvSnZFRGVI?=
 =?utf-8?B?QUIrRXlvVnNjalJGd1pTOEMybjZuRXMzclNreDBHdVQ1ZjdZWFNrVHFwS1NH?=
 =?utf-8?B?dXFyd1dhbklJc2U3OUNZWDlkVFFHcTBNZ2xzTHZpNEZjTGhTRVU0RDZCdWFC?=
 =?utf-8?Q?XDGwZDGm1hyQNaC1vWAENHFeq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9a7a31-4891-4c59-f9e8-08dbd167f324
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 12:27:39.5183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZjm26QZvMXlRDQZZGxyVKENrvSjKO7nRm8lDfl24eWOIG5FbPGSi5zNASF3EoVI4DCx10et/5R/6miY58DvRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7049

On Thu, Oct 19, 2023 at 11:31:55AM -0700, Andrii Nakryiko wrote:
> On Thu, Oct 19, 2023 at 12:30 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > On Wed, Oct 18, 2023 at 09:24:05PM -0700, Andrii Nakryiko wrote:
> > > Add tests that validate correctness and completeness of BPF verifier's
> > > register range bounds.
> >
> > Nitpick: in abstract-interpretation-speak, completeness seems to mean
> > something different. I believe what we're trying to check here is
> > soundness[1], again, in abstraction-interpretation-speak), so using
> > completeness here may be misleading to some. (I'll leave explanation to
> > other that understand this concept better than I do, rather than making an
> > ill attempt that would probably just make things worst)
> 
> I'll just say "Add test to validate BPF verifier's register range
> bounds tracking logic." to avoid terminology hazards :)

Sounds good to me :)

> > > The main bulk is a lot of auto-generated tests based on a small set of
> > > seed values for lower and upper 32 bits of full 64-bit values.
> > > Currently we validate only range vs const comparisons, but the idea is
> > > to start validating range over range comparisons in subsequent patch set.
> >
> > CC Langston Barrett who had previously send kunit-based tnum checks[2] a
> > while back. If this patch is merged, perhaps we can consider adding
> > validation for tnum as well in the future using similar framework.
> >
> > More comments below
> >
> > > When setting up initial register ranges we treat registers as one of
> > > u64/s64/u32/s32 numeric types, and then independently perform conditional
> > > comparisons based on a potentially different u64/s64/u32/s32 types. This
> > > tests lots of tricky cases of deriving bounds information across
> > > different numeric domains.
> > >
> > > Given there are lots of auto-generated cases, we guard them behind
> > > SLOW_TESTS=1 envvar requirement, and skip them altogether otherwise.
> > > With current full set of upper/lower seed value, all supported
> > > comparison operators and all the combinations of u64/s64/u32/s32 number
> > > domains, we get about 7.7 million tests, which run in about 35 minutes
> > > on my local qemu instance. So it's something that can be run manually
> > > for exhaustive check in a reasonable time, and perhaps as a nightly CI
> > > test, but certainly is too slow to run as part of a default test_progs run.
> >
> > FWIW an alternative approach that speeds things up is to use model checkers
> > like Z3 or CBMC. On my laptop, using Z3 to validate tnum_add() against *all*
> > possible inputs takes less than 1.3 seconds[3] (based on code from [1]
> > paper, but I somehow lost the link to their GitHub repository).
> >
> > One of the potential issue with [3] is that Z3Py is written in Python. So
> > there's the large over head of translating the C-implementation into Python
> > using Z3Py APIs each time we changed relevant code. This overhead could
> > potentially be removed with CBMC, which understand C, and we had a
> > precedence of using CBMC[4] within the kernel source code, though it was
> > later removed[5] due because SRCU changes are still happening too fast for
> > the format tests to keep up, so it looks like CBMC is not a silver-bullet.
> >
> > I really meant to look into the CMBC approach for verification of ranges and
> > tnum, but fails to allocate time for it, so far.
> 
> It would be great if someone did a proper model checker-based
> verification of range tracking logic of overall BPF verifier logic,
> agreed. Until we have that (and depending on how easy it is to
> integrate that approach into BPF CI), I think having something as part
> of test_progs is a good practical step forward.

Agree, by no mean was I trying to suggest we shouldn't have this test.
Mainly want to bring up checker-based verification, and was glad to hear
that it is considered worth investigating.

> > Shung-Hsi
> >
> > > ...
> >
> > 1: https://people.cs.rutgers.edu/~sn349/papers/cgo-2022.pdf
> > 2: https://lore.kernel.org/bpf/20220430215727.113472-1-langston.barrett@gmail.com/
> > 3: https://gist.github.com/shunghsiyu/a63e08e6231553d1abdece4aef29f70e
> > 4: https://lore.kernel.org/all/1485295229-14081-3-git-send-email-paulmck@linux.vnet.ibm.com/

