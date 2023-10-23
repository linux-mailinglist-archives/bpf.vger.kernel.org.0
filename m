Return-Path: <bpf+bounces-13007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B3C7D38E0
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 16:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450D71C20A7C
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 14:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1591B277;
	Mon, 23 Oct 2023 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="5EaVcp8I"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A41CF4F8
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 14:05:57 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80D5D68
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 07:05:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivWd7t2z91GcEzwaNexG0FtH9GevPde2mxqfElf3wRK/0hYp8KF+NJ+N4+hvgknTfay90vrVhM0WIjMuQu2ZMT7KY8uwdQPgbf+AA55r54XvH2o3Ix5kbP+npu8GgYqtdXPaK/0EMj+sOrJ92BFln0NKgj4ouoZLgedBeWBTt9aANA3K0y6Px9cPb3tr94b/YB2KRWdCVPjggYZS/+L03aZz6gxzcrcAkpzRnT1CKMkxUYMqAii3tXi46ylYfXOgmGVROniNfEQXPSesu1Q4nff+3E9t/zz06D2CI3eP8RWdQIPygAjIxIxEt6WPNxAzwsewkxIITTzgl+5YEZLoPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+aK8MG7f9p2qwOX+LrEFM85/2God0bC+ZWJdi2+vSU=;
 b=oc2wS+9h9V/NVyNOmq84u+Rd7ZqzD04WbIVbfa2E80niQO0SsbZ7Ls2I4lAZCbiZgak7//Ns8k0Jk2zNxGUfdG3R2//gIoj+F4La4e4fA5WIcD5zSHk2dIRPB9wX/AOmHKOnlr9v+HsIHV9JojhdzAn5n6ZdGKw33l7vpWSpDOohNNP8kUgrnRmSs4FmoKgOSBBdpU4uNIb18Ot5jZPG6DWI+I1z/xuJMJ22D7oXD7p62Z96+yJUa6qq7FFzBkLeqBbWfCg/P3hHDF9PMKXHT4LivqEKvfB5I1fM8IUYmVFUeTAe2rE30shIWirUUruyRa0dlNt18TlJJtQm3oWwow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+aK8MG7f9p2qwOX+LrEFM85/2God0bC+ZWJdi2+vSU=;
 b=5EaVcp8IFAo+4zxkIBpL1SMV7Z6zeIkRs2LKHxTdlXw/+/KVPPJDCdp6RyEnfxY8Z5oDBHC+tlP+pQUHX+DBRZ/5RTeH4jqbv8nwcDvHbGuG/3QtyhadF5GbSh53Ahl+oSKEuPL6fvhbhvBsQcASf86L2lW2Hp5b4yBN0PkT0Txw3tHhyEdO3vG10IeTBmZc0Tfy8gVDMViqkiF0cKX03B+ht9Seub5IYxqUVByMf+M0mA5zaRF1lDWGJUGyeVGFzyehLQgitKHodGSfriDF/zG+I/U+2alOHqRk4SFj7zPTWFs91MrYc83BzofVKtMA/Jk7EWC27kVSuW5WoDqGDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Mon, 23 Oct
 2023 14:05:52 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 14:05:52 +0000
Date: Mon, 23 Oct 2023 22:05:41 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Paul Chaignon <paul@isovalent.com>
Cc: Srinivas Narayana Ganapathy <sn624@cs.rutgers.edu>,
	Andrii Nakryiko <andrii@kernel.org>,
	Langston Barrett <langston.barrett@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <sn349@cs.rutgers.edu>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"martin.lau@kernel.org" <martin.lau@kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	Matan Shachnai <m.shachnai@rutgers.edu>,
	Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: BPF register range bounds
 tester
Message-ID: <ZTZ9tYlVgt9DVcgi@u94a>
References: <20231019042405.2971130-1-andrii@kernel.org>
 <20231019042405.2971130-8-andrii@kernel.org>
 <ZTDbGWHu4CnJYWAs@u94a>
 <ZTDgIyzBX9oZNeFw@u94a>
 <CAEf4BzYgJR6SAjbvd0uZ6w8D37Sy=Wjd2TROOGEAZDiEq7xb2g@mail.gmail.com>
 <1DA1AC52-6E2D-4CDA-8216-D1DD4648AD55@cs.rutgers.edu>
 <CAEf4BzbFhA585gSN1YfaDaeEmmUvWSdpMY605fmV_RvSQ7+xeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbFhA585gSN1YfaDaeEmmUvWSdpMY605fmV_RvSQ7+xeQ@mail.gmail.com>
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DU2PR04MB8822:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd38de6-7cfb-4329-9a4c-08dbd3d12a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xD7etOsqna/8Cjd/Hhmd0K0cmXfiw3t/l7PChiJQdpHEv9rFFSUfG9CN63rdChTRC86xMlMgH+sA2ov68rmIZ4gJctSFFLPLhiq+JRN6OGbIpgqYHIKKhGIwzg6dtb5iOo+EBmnrxqZK3NnUnWMoELyRVF3r/VmKyJ4ua8y/1pSlnbnatITm/CP+fzff9iIwpGIYTWKoT/zZG+WYT0qP1n6xFFOU/R0K5DNOeZdkVgprTThggPjYQvuQ0vc7vttcoKxFV8CCbBGMlkcstJy2DX5cVL/kH/vyrKcQ39f1GgvyIlShAsF9KWOllZhHEd7F0tq6GREr5rTAzUZyRcZj7+yL0vteZd0bMyQv1EiKfuBklL0JJTJ9px2MCkxplZvW2UxdWapg8tbeb1qV9Te0BccNeEsG8jVDe6Hb3rL+LlB8u4ljgyLqgoAjJq64FXO57+fwf6S3w0srGip6+tJeB88bHaHscRRerMqxS8NJjVVXzXw8aqn3r+V0nSMEAKlFcaW1WZdCI7b71zjYb2zOlneAlrhB0G08f8wAZgmcrk0s0YNPkJv8b0c4/EdcZrVNIO5KCTCRa6oijEoxpD8xmA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39850400004)(136003)(366004)(396003)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(4326008)(8936002)(8676002)(41300700001)(2906002)(7416002)(5660300002)(33716001)(53546011)(6666004)(6512007)(9686003)(6506007)(83380400001)(38100700002)(110136005)(86362001)(66946007)(26005)(966005)(66556008)(6486002)(45080400002)(66476007)(54906003)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjJZUU4xUStIUmlDQnpFQW5tRXN1bnRKWHRQeE5mYXBRWWRkSkliYjFGRHN2?=
 =?utf-8?B?QkdENkRvbUxPdjZTTFJ6MXVCSVdMclRMdTBXOHhPd2s4Q3RJQmZrSWtWSEp1?=
 =?utf-8?B?dkQwQ3E4YnZUTHFRUVVHSU95emI3Y2d1RDcvUlkraWhYL3ZlU0R5azVzWGFX?=
 =?utf-8?B?aXZSL1JEUmhOenpZN0N2ZzNFQ1VwS3AvUk5UZUpTN2Z3N0syQVpLN0grdnpH?=
 =?utf-8?B?Y1pqR1hsTDhVeWhQWXNLQXJXTkFDTG5yVW9QTGRZRUpHWGZhbWYzOG1ETFhD?=
 =?utf-8?B?M2lCMklQQmRzaWVMMHdubXJrOVUzTmZuRC9Yc3AyWUs3Q09FV25VZUdLaVlJ?=
 =?utf-8?B?c2JocVZkS0hMZ0VuL1FTRnNld0tXNGRYQ3JZSEhOQWV1bFhUU0h1aElSQUw0?=
 =?utf-8?B?NTE4Kzl6dytTTEpEc0dXWmlOQ21XUWpYZCt4Mk1vamNvSFhUR2NQT2ZSUEVP?=
 =?utf-8?B?L2tNR0FiZTZzaUttdExBcmRueXl6Ukdvc2hPeTFGd05kRmJXeDNPUFZ4OVdB?=
 =?utf-8?B?czFZK1RqdlZmUDlBR0tKckRQQ1h5ZGk4d3R4SEJTdEZRL3Q0Z29sTG9KcEYy?=
 =?utf-8?B?WXVHMC94QnE1eU54QnhSOW9yUGk5aGR3bCszd2ZLUVBhMVN3MGpzWW5nazVr?=
 =?utf-8?B?OTlvL3NNUkdMVGVZSzgwbHpJTXFyMFJMV1lYVTloRWlSMW9Db3RiOEJmR0py?=
 =?utf-8?B?eUxWNUJOQ2tzbUpHRkQvbGR0a1RQWE1mYnJZRVVrU3BLODhIUjROMXZnZDlj?=
 =?utf-8?B?d1M5MlZBMVphcnRUamQ3SnBucDd4S1RKRVZOTGg2dUx2ZUplWUFzZjhrc0Ir?=
 =?utf-8?B?SDMxeFZiR1BYRmptM3VhbHhRSk1zZW5EYUhsVnBwNE02ZWttUFZucjZDd1pj?=
 =?utf-8?B?YVFUWERSQ3d6d3lIVnI4bjd1am1BREF3QTN3aXo2d0pVMGtnTDU5NkV1SUsz?=
 =?utf-8?B?UXRRTmZrbmpzbHZCbDRoWmNrZ1QwYU9ITC9JeU5PcE9vdUhhdTc3QUI3cXZ2?=
 =?utf-8?B?K3lPU2thUnozL0V4Q1B6ODV0VVlla21VTWZkSE9KQ1R0KzJoc0Y3Z01yclNs?=
 =?utf-8?B?aEhaSmN5ZlZmRGxTUHdGTnRFREw3bTkyOXRlZHF0a0JXODNBc0puVEVkbzlu?=
 =?utf-8?B?Y0FaY0JGZW54czhIb3ViNytkMlowOU4wUjFYTGFGL0czQUJURzMxdlNFeHMx?=
 =?utf-8?B?UDZFSXBDcEllOVd4aFNWMW5LN0ExeHlJNmYrS1ZuaW83TG5CWlQ1ZVE5TDF2?=
 =?utf-8?B?OEJUcEdPZmZGMXNHMmJXQlJMWUJSMnlMMjU3MnNlT2V4OExNSEdVK3hZSTRj?=
 =?utf-8?B?T2p5Rk42a1kyeDZXWUw3dTcybk5NVDBzeWFJYjhjTmtMVW1jZnV1UmtzVTlF?=
 =?utf-8?B?VXF0OEdhZEdqZ2k0bGY3eldMNjM3Tm1LTmMxNGc2UnlGVVRNeFhFR0VNcURu?=
 =?utf-8?B?WmxlWWtnelF1QTN5YjdvbS9oc2QyM1BRZWpub2xBWGdwTW5PQWUrWGRwZVA2?=
 =?utf-8?B?TFVTNnZIaTRnQ3U3a1ByZHlqQWt5cmozeXZDM1RvSkFnanl2eHFBU2U1cTMz?=
 =?utf-8?B?SDFuWXVkWjZFTFAwMzRMa0hBdzdTcHFWUnN5cGRJQmF0c2Q1OXFad0IrSFk1?=
 =?utf-8?B?MTgyaFhDREs5aU8xNnE4dkJ4aUxBTXc5cmNWdmZaRWNvN2M1R3R5M1dCTGFS?=
 =?utf-8?B?a2tUWGF1NVBCbnZzekJzcmNuM2dCTGlsNkpYYVB3a3R2MnlkaU9xV1hCbEdR?=
 =?utf-8?B?UnRFY00ydWtIOE13MW1qeTJTSmluWi9vSENlTm5acjVNSmdadjgyZnZ1Y0RB?=
 =?utf-8?B?YklTY1M1d0dPZEx5WmFEUnpOWDU0Ylp2MnpsNXhyQWVyOTN1S1h2bnhIRDBz?=
 =?utf-8?B?bHdpcWUvQU5JMzlOVWwza1E0TXY2Yk9sczkvQ1EzdUw4TjZVSFdQSFNKU25u?=
 =?utf-8?B?Zm1Eb0UvM2VMOE0yM25LUDM0WDhhOVVwRHBHeEhHYzhDN2lvdklwZlhWQktZ?=
 =?utf-8?B?UmZSSU5nZkdWdVduaWVKWitzWXQxL0VCblgyenRicUdpQWxseUdxaGQ5NHYr?=
 =?utf-8?B?TmU5VEIzTXJWYmVSaE5pa3VvazBQN1VXVmdGbWpCcFdxODFpSWc5cnJFN2FF?=
 =?utf-8?Q?+NbiKdPvTTWtaygJcHRlTFOe9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd38de6-7cfb-4329-9a4c-08dbd3d12a7e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 14:05:51.9824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmLQryCKbK3p9YmwwdiUB0JV3PbnJ/uAoKcJJwKodpYsjOENSBqUqUTrGagjmXg6KToLZVyVyVk4WZu0K94gkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8822

On Sat, Oct 21, 2023 at 09:42:46PM -0700, Andrii Nakryiko wrote:
> On Fri, Oct 20, 2023 at 10:37 AM Srinivas Narayana Ganapathy
> <sn624@cs.rutgers.edu> wrote:
> >
> > Hi all,
> >
> > Thanks, @Shung-Hsi, for bringing up this conversation about
> > integrating formal verification approaches into the BPF CI and testing.
> >
> > > On 19-Oct-2023, at 1:34 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > On Thu, Oct 19, 2023 at 12:52 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > >> On Thu, Oct 19, 2023 at 03:30:33PM +0800, Shung-Hsi Yu wrote:
> > >>> On Wed, Oct 18, 2023 at 09:24:05PM -0700, Andrii Nakryiko wrote:
> > >>>> Add tests that validate correctness and completeness of BPF verifier's
> > >>>> register range bounds.
> > >>>
> > >>> Nitpick: in abstract-interpretation-speak, completeness seems to mean
> > >>> something different. I believe what we're trying to check here is
> > >>> soundness[1], again, in abstraction-interpretation-speak), so using
> > >>> completeness here may be misleading to some. (I'll leave explanation to
> > >>> other that understand this concept better than I do, rather than making an
> > >>> ill attempt that would probably just make things worst)
> > >>>
> > >>>> The main bulk is a lot of auto-generated tests based on a small set of
> > >>>> seed values for lower and upper 32 bits of full 64-bit values.
> > >>>> Currently we validate only range vs const comparisons, but the idea is
> > >>>> to start validating range over range comparisons in subsequent patch set.
> > >>>
> > >>> CC Langston Barrett who had previously send kunit-based tnum checks[2] a
> > >>> while back. If this patch is merged, perhaps we can consider adding
> > >>> validation for tnum as well in the future using similar framework.
> > >>>
> > >>> More comments below
> > >>>
> > >>>> When setting up initial register ranges we treat registers as one of
> > >>>> u64/s64/u32/s32 numeric types, and then independently perform conditional
> > >>>> comparisons based on a potentially different u64/s64/u32/s32 types. This
> > >>>> tests lots of tricky cases of deriving bounds information across
> > >>>> different numeric domains.
> > >>>>
> > >>>> Given there are lots of auto-generated cases, we guard them behind
> > >>>> SLOW_TESTS=1 envvar requirement, and skip them altogether otherwise.
> > >>>> With current full set of upper/lower seed value, all supported
> > >>>> comparison operators and all the combinations of u64/s64/u32/s32 number
> > >>>> domains, we get about 7.7 million tests, which run in about 35 minutes
> > >>>> on my local qemu instance. So it's something that can be run manually
> > >>>> for exhaustive check in a reasonable time, and perhaps as a nightly CI
> > >>>> test, but certainly is too slow to run as part of a default test_progs run.
> > >>>
> > >>> FWIW an alternative approach that speeds things up is to use model checkers
> > >>> like Z3 or CBMC. On my laptop, using Z3 to validate tnum_add() against *all*
> > >>> possible inputs takes less than 1.3 seconds[3] (based on code from [1]
> > >>> paper, but I somehow lost the link to their GitHub repository).
> > >>
> > >> Found it. For reference, code used in "Sound, Precise, and Fast Abstract
> > >> Interpretation with Tristate Numbers"[1] can be found at
> > >> https://github.com/bpfverif/tnums-cgo22/blob/main/verification/tnum.py
> > >>
> > >> Below is a truncated form of the above that only check tnum_add(), requires
> > >> a package called python3-z3 on most distros:
> > >
> > > Great! I'd be curious to see how range tracking logic can be encoded
> > > using this approach, please give it a go!
> >
> > We have some recent work that applies formal verification approaches
> > to the entirety of range tracking in the eBPF verifier. We posted a
> > note to the eBPF mailing list about it sometime ago:
> >
> > [1] https://lore.kernel.org/bpf/SJ2PR14MB6501E906064EE19F5D1666BFF93BA@SJ2PR14MB6501.namprd14.prod.outlook.com/T/#u
> 
> Oh, I totally missed this, as I just went on a long vacation a few
> days before that and declared email bankruptcy afterwards. I'll try to
> give it a read, though I see lots of math symbols there and make no
> promises ;)

Feels the same when I start reading their previous work, but I can vouch
their work their work are definitely worth the read. (Though I had to admit
I secretly chant "math is easier than code, math is easier than code" to
convincing my mind to not go into flight mode when seeing math symbols ;D)

> > Our paper, also posted on [1], appeared at Computer Aided Verification (CAV)’23.
> >
> > [2] https://people.cs.rutgers.edu/~sn624/papers/agni-cav23.pdf
> >
> > Together with @Paul Chaignon and @Harishankar Vishwanathan (CC'ed), we
> > are working to get our tooling into a form that is integrable into BPF
> > CI. We will look forward to your feedback when we post patches.
> 
> If this could be integrated in a way that we can regularly run this
> and validate latest version of verifier, that would be great. I have a
> second part of verifier changes coming up that extends range tracking
> logic further to support range vs range (as opposed to range vs const
> that we do currently) comparisons and is_branch_taken, so having
> independent and formal verification of these changes would be great!

+1 (from a quick skim) this work is already great as-is, and it'd be even
better once it get's in the CI. From the paper there's this

  We conducted our experiments on ... a machine with two 10-core Intel
  Skylake CPUs running at 2.20 GHz with 192 GB of memory...

I suppose the memory requirement comes from the vast amount of state space
that the Z3 SMT solver have to go through, and perhaps that poses a
challenge for CI integration?

Just wondering is there are some low-hanging fruit the can make things
easier for the SMT solver.

> > Thanks,
> >
> > --
> > Srinivas
> > The fastest algorithm can frequently be replaced by one that is almost as fast and much easier to understand.
> >

