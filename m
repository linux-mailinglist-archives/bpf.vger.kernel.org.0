Return-Path: <bpf+bounces-12437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4135E7CC79C
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 17:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6548D1C20BED
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14396450DE;
	Tue, 17 Oct 2023 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="yNyFDr2f"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A783FB24
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 15:40:06 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2064.outbound.protection.outlook.com [40.107.6.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD069F
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 08:40:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnkSBGU1YUkHA2LVKKdrfpvqP4EuZCRZDfEjkT1NrwDjztQqBvT5vj702EyvPJLIYfQFBE1PrN+imS8DbW9kDme37SOwv7f0V5g8IETYSAf2+GkZjlJnqMCCHGyJlXL0jyRUXzUsb7agC9CiO+7D+guniLtI7y71LySu6dcX2jKa5SoFB1DiVb1N5oMk0Qz6LNZUQIekHUReSgCW4Ocgl/n9Pq+WFy9WAYky1nkRymEBt5zIc8gXmPX6FbVuVzcym5xBqG4wxZAyN0sZh1HTU/k7xvz6gkGDJt4Fw8ynk64I9CioNCQLUsc0MXOKx9J2ODT2pGPoaAuST4dcYVZ2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bZzkJa7QdpXp4qKb8AVDi1J43FnwrsiK/lLgjru98E=;
 b=dVUzGEEvj0trSFlMI5N38gk/05p8vPgrdoRhyTDL7OqsHqIS9fWvIF3Qu9Ce9F69Vv6EI2cHKUB7ax8BqnS8dLvdVQG7AhS+4EsPGtcFRWoeIn3ai12d2jvIv6zPTLhWZyH6BVCwNEgX0MK6kk6D/8DlidbZntQcKqPHdFWdAw/aFTH+Pe8Us2TIg/utvJ/y5KWSsmHPtQvxu5bgH1rm35M07K7It12/s5orhZmRKKPlrl921LpeR4ZkoVQfXZAp/8cH5ZAAARwBC0VKqytLdBFVkG5b+vPe8Su8P0e2PFZSF0N8IVXUB9QNt7Jee6ytTciO9x1DnabELaKEL2eIHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bZzkJa7QdpXp4qKb8AVDi1J43FnwrsiK/lLgjru98E=;
 b=yNyFDr2fHe2bRHbDWPBwraUA1+1R9whR2r5m833GGJMlzP+o1Wbm6f+hPSJDMpIS3I46Ku30CjkvUW7ZOLFKQhAL13wsbv5W87UHmVTBtkl+zCi90FcK2YXchPowX0UF81UjIUKBuDwv0wG4c6JEG7als7Qugs5INs6nrK8vy0PnGHn8ikFBYoCydRgb01fnA3OyOLrI3X/BzTHhiRJnDjIyjn7riQqgkX1B7XzgXuReKWxYZQt6g92mv0q1lX8nj0YJffSYZxMfiEuGQje991jvluYX8o02yELwCsppIvE/M+1qsZnzBTr3Wmz8BmUKvziSkP4Bg4yE2y/UuRkgIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 15:39:59 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 15:39:59 +0000
Date: Tue, 17 Oct 2023 23:39:53 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Mohamed Mahmoud <mmahmoud@redhat.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Subject: Re: Hitting verifier backtracking bug on 6.5.5 kernel
Message-ID: <ZS6qyQ2R0vcyWUHt@u94a>
References: <87jzrrwptf.fsf@toke.dk>
 <CAEf4BzaC3ZohtcRhKQRCjdiou3=KcfDvRnF6RN55BTZx+jNqhg@mail.gmail.com>
 <87sf6auzok.fsf@toke.dk>
 <CAEf4BzaAjisHpVikUNb5sQDdQwNheNJRojoauQvAPppMQJhK9g@mail.gmail.com>
 <87il75v74m.fsf@toke.dk>
 <CAP6g7JL-tPZgtKy-+io0L03D4201saqKT5FUBMC5Ph+uYnfu5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP6g7JL-tPZgtKy-+io0L03D4201saqKT5FUBMC5Ph+uYnfu5Q@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::9) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|GV1PR04MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: d58c2174-d9be-4bd2-35ff-08dbcf275224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u6VD2cwTtXEQ6HLWKC11Nzng8+Z+DU29gG4rp81V7d/2htytGQFrSfdCQCc3MWGEJKU53r4MaIGkQBAV8xRwBesd4B+T5qx8dqyBsxda48TukHvs7VaIzBjDHHn+rVupQtKrq5mptGdM5mHSfIEXi+DbTKL7B9fhMsOYA3GhH0M/iHrRKSvxyihDZLleoCMbxUjG5bVn7aUA6QAs/Mb0ZeKJZS8qsLLndyplKxZGy9MhKWnQua+5aPdkiljkCHSfq7kKaO8qi6RpYariL0Cc9M3RLNd8nePuh92fC0uBIaARfF9QyuUZouYtBp+G3FrjQU4Spf6KSV1/oWwlJxJ1uAQBjazrMjcgQD1KbCO4qwVPJkX8t5e2HObpiRhX9BsWLWJKvluzzsxC7I1e8Iv+UOybPB34prl6rZSYcK85dwmZeG7LGA9ib67vHjt7c5PfNQy8ygM9vIYmPjJdCO5qlwLUpgv62OuTHHF3Zl9F10nTbTQ67+CVQ9tpulDJenQUH+hU5ZeqTuDZEdQILbQDZJJgIfjjS4wG91UaVi9Tvk8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(346002)(396003)(366004)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(26005)(66574015)(6506007)(6666004)(966005)(8936002)(53546011)(83380400001)(41300700001)(4326008)(5660300002)(8676002)(2906002)(33716001)(6486002)(478600001)(66556008)(66946007)(316002)(6916009)(54906003)(66476007)(38100700002)(86362001)(9686003)(6512007)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEJOQ2F0MkJJNUZOUVcwS2RsaTFoQjI0bjlZQnhJaWwvaWIyUHRjS1liYlgx?=
 =?utf-8?B?QjV3S3hRRTBSc3prdnlxMGVLdjZocFhFTllwNGZveDVndnJOU05oRHBNNWtN?=
 =?utf-8?B?a0wvUFM3TEkwK21zVFVQTW1iaHNwcTdTVUZSV21ERWJRM1o1algzM1BUVXpB?=
 =?utf-8?B?R3JPQVlVVDZSNWJLUzVSdlEvenBJTjRJWVdyYmlOYTR6Ykc0bjhmelJCbExO?=
 =?utf-8?B?YlJKWWtzck9sYndCSmNrbzNoVFN0OTFWOU9GSFdnWE5aems0K0RrWUxUWWMx?=
 =?utf-8?B?N2k4eU5YY0gzMHBmOElLcndTdzc2Zy9rK3J3S3JucTQyTU1QdWdrdis3L0dM?=
 =?utf-8?B?ZjFJb1A1dG10WDdkdk1DT3Zuc3Mxd1JmRll1ZnduNjJyd2hwbHVjMmRuN2g0?=
 =?utf-8?B?QnFRTjFtWGxkVElyajBnUnZRM1FZWDMrVk9MU0lHNHZ6ODltUHNPb2pIbEV1?=
 =?utf-8?B?bis1amNWWnArNHlTQlVnakZpNllPcGhXNit0dkE4RkUvVjY3ZDlKV1RiaWhi?=
 =?utf-8?B?L3IwSDcwZmdPbkZvRGNJaVpxOVFCWEpiRm5ndFFxa2pFWEpvT3JwcGNTVjVq?=
 =?utf-8?B?T0Jib0N6T1VPejcvaVlpSlRBRTFOSHR1UUZPSEpncDNBYVp2Wk1XM2xWUHNa?=
 =?utf-8?B?WnFDK2RkdEUvL2xtMlNPZldNbWFiczRKeFE5WnlsWFg5NVB5SUswOHFlZmU5?=
 =?utf-8?B?dm96cFZoek0xM1RlWld4RGo3QzJFQy9JRnUvVUMvbDl3YXBFRkF6MHRXaG4r?=
 =?utf-8?B?d1Y3dDdmSVdiU1M1SUYxemFDMGhTN0lLOERQbHR5STV4MGk2NFZjWU1nSlNW?=
 =?utf-8?B?TmQzWE5BUTkyU3p1U25NTlBjZkswa2pVOVQxVEJKMG5MVkx1TGUyQzVoRkpu?=
 =?utf-8?B?M2dwdnFDVDRjZVN3aTJJaVVHZUt3SXl6d2VHM3dpd3BpeUFVV2thQTN3TFc3?=
 =?utf-8?B?TndLL0N1L0tDaGJrT3VMWExzd1ZUeGZXNS9vMWNLQTRKUm5TUU1zV0pqSkFS?=
 =?utf-8?B?UVZTRi96bUJBNXlzTkFRd1B4QXFNQnNUWjh1ajJrOHhMT1VCOEgyYmpJL00y?=
 =?utf-8?B?ZVdlYnJqc1FsM2daS3p4aERlSVJ3RFROTjNJeUM0NTVza0RJQlBRNGF3bThH?=
 =?utf-8?B?NlIyaTMwWWxIaTBDcjFmSnFOTEhSenNFUnpDdlEwUVI3ZlFiei81SEMyUlo4?=
 =?utf-8?B?bG9ZZU90ZUY0OTVhWFgwaTJMSC8vRG9PdlR0UTRBcEdGL1BkYnIzc2gwcDJL?=
 =?utf-8?B?TnZVOHJwT2xnaUdpQTRnazNPOFBubCthMzRHc05UVW9jMHVzS0xJMTg0NjlC?=
 =?utf-8?B?S2s1THpzaFhoSzBzSWc0d2lMc2NuVU5KN1hlT2ZKWm41dXVSSlFrUUY2b051?=
 =?utf-8?B?MmppdTR5ek92Y3lCWEhsSCs4bkxzMEpMbHJuR2E2TjZBMEVpQU5Nc01RdGtK?=
 =?utf-8?B?Y1BBUlJ6ckJoQ3BnUEFKQVpwZkRaZHpGTFZFM3Nsem42bU9XRW1ZRHZrK2FK?=
 =?utf-8?B?ZzloSU9PUnM3OXhCb1FUOGV2UXY2S2Z6U2lMRlJpemtReEtqYnBnWHRZYVJQ?=
 =?utf-8?B?MFlvVGJ5dWEzSU1xODB0UTgwckFWZmw4d3hva3RpaFVvSHhEZnVFbEZSaFlx?=
 =?utf-8?B?Ris4R2F5Q1JmTmo1TmJZSTVtZVl0OW1JdEVJdVY2dWZTSVNaRTZoZjRUNno1?=
 =?utf-8?B?eDkvMERaQmVSQ0FtVmF3c1FMTWhEME9uU0hiR1BYQ1huMGd1RHpiSGh5TE9Y?=
 =?utf-8?B?UzJXSUlZWXM1a290c1BQVElMcHBrcnN5L3ZRcVVWZG5lcGhhbFpkNDBqZ3JM?=
 =?utf-8?B?Q21jdzA0OTViTmtNYXkvWTI3K0tEM0FKQnViU3lGdlFveWZzdytMVFI4Y0ZH?=
 =?utf-8?B?WGZkbFFPL0FEYmFUSEVwVEY4S0tYeTNLbUZEWjRCRVZ1L2FKV29qV2ZtTXJx?=
 =?utf-8?B?cmJiUVVjVkxUUEVJOGJPcUkzNjFRd1QyZ1lOeTJGSldRSzJ6SHlXbDdNYkJa?=
 =?utf-8?B?NEcrSXMyMmVGNVpXTmFWR1ZwcUtxbmtnNjlkRWNGTDhBc2RERys5OUhpaGt5?=
 =?utf-8?B?L0FIUWFiVWpENlF6L0s4aFNFRkltWHM0bGJhTzVvOTVESGFQTzJDZkxVbFY5?=
 =?utf-8?Q?2i8uNi/FgVIukBIh9BL0BhGpm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58c2174-d9be-4bd2-35ff-08dbcf275224
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 15:39:59.4692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRMvgWHBiDopsEnSNtzd1RMjo8u46mDLC1Sg6uavkavmQpiBC1P/cUIeOOU57lkVzXQY3tCtMl2W9UwZUCtpqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 08:16:55AM -0400, Mohamed Mahmoud wrote:
> Any idea why the same verification errors are not seen when the
> program is attached with bpftool ?

Not sure why, but I've captured the verifier log during the successful tc
load here (using a slightly modified tc) on v6.5.4:
https://gist.github.com/shunghsiyu/b3bd6e4f4e1510e98a80491d50f3908b

    1890: (dc) r2 = be64 r2               ; frame2: R2_w=scalar()
    ; id->src_port = bpf_ntohs(udp->source);
    1891: (77) r2 >>= 56                  ; frame2: R2_w=scalar(umax=255,var_off=(0x0; 0xff))
    1892: (73) *(u8 *)(r1 +48) = r2
    mark_precise: frame2: last_idx 1892 first_idx 1883 subseq_idx -1 
    mark_precise: frame2: regs=r2 stack= before 1891: (77) r2 >>= 56
    mark_precise: frame2: regs=r2 stack= before 1890: (dc) r2 = be64 r2
    mark_precise: frame2: regs=r0,r2 stack= before 1889: (73) *(u8 *)(r1 +47) = r3
    mark_precise: frame2: regs=r0,r2 stack= before 1888: (dc) r3 = be16 r3
    mark_precise: frame2: regs=r0,r2 stack= before 1887: (bf) r3 = r2
    mark_precise: frame2: regs=r0,r2 stack= before 1886: (69) r2 = *(u16 *)(r7 +0)
    mark_precise: frame2: regs=r0 stack= before 1885: (2d) if r3 > r2 goto pc+23
    mark_precise: frame2: regs=r0 stack= before 1884: (07) r3 += 8
    mark_precise: frame2: regs=r0 stack= before 1883: (bf) r3 = r7
    mark_precise: frame2: parent state regs= stack=:  frame2: R1_r=fp-160 R2_r=pkt_end(off=0,imm=0) R3=17 R4=fp-96 R6=fp-96 R7_r=pkt(off=54,r=54,imm=0) R10=fp0
    mark_precise: frame1: parent state regs= stack=:  frame1: R6=ctx(off=0,imm=0) R7=1 R8=pkt_end(off=0,imm=0) R10=fp0 fp-56= fp-64=00000000 fp-72=00000000 fp-80=00000000 fp-88=mmmmmmmm fp-96=fp fp-104=??????00 fp-112=0000m000 fp-120= fp-128=mmmmmmmm fp-136=mmmmmmmm fp-144= fp-152=mmmmmmmm fp-160=mmmmm0mm
    mark_precise: frame0: parent state regs= stack=:  R10=fp0
    ; id->dst_port = bpf_ntohs(udp->dest);
    1893: (69) r2 = *(u16 *)(r7 +2)       ; frame2: R2_w=scalar(umax=65535,var_off=(0x0; 0xffff)) R7=pkt(off=54,r=62,imm=0)

Looks like r0 is also being incorrectly added the to the precise regs set
here; but I'm not sure why backtracking didn't go all the way back to "call
pc+1617" (which trigger the warning).

> On Tue, Oct 17, 2023 at 7:08 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> >
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >
> > > On Mon, Oct 16, 2023 at 12:37 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> > >>
> > >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> > >>
> > >> > On Thu, Oct 12, 2023 at 1:25 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> > >> >>
> > >> >> Hi Andrii
> > >> >>
> > >> >> Mohamed ran into what appears to be a verifier bug related to your
> > >> >> commit:
> > >> >>
> > >> >> fde2a3882bd0 ("bpf: support precision propagation in the presence of subprogs")
> > >> >>
> > >> >> So I figured you'd be the person to ask about this :)
> > >> >>
> > >> >> The issue appears on a vanilla 6.5 kernel (on both 6.5.6 on Fedora 38,
> > >> >> and 6.5.5 on my Arch machine):
> > >> >>
> > >> >> INFO[0000] Verifier error: load program: bad address:
> > >> >>         1861: frame2: R1_w=fp-160 R2_w=pkt_end(off=0,imm=0) R3=scalar(umin=17,umax=255,var_off=(0x0; 0xff)) R4_w=fp-96 R6_w=fp-96 R7_w=pkt(off=34,r=34,imm=0) R10=fp0
> > >> >>         ; switch (protocol) {
> > >> >>         1861: (15) if r3 == 0x11 goto pc+22 1884: frame2: R1_w=fp-160 R2_w=pkt_end(off=0,imm=0) R3=17 R4_w=fp-96 R6_w=fp-96 R7_w=pkt(off=34,r=34,imm=0) R10=fp0
> > >> >>         ; if ((void *)udp + sizeof(*udp) <= data_end) {
> > >> >>         1884: (bf) r3 = r7                    ; frame2: R3_w=pkt(off=34,r=34,imm=0) R7_w=pkt(off=34,r=34,imm=0)
> > >> >>         1885: (07) r3 += 8                    ; frame2: R3_w=pkt(off=42,r=34,imm=0)
> > >> >>         ; if ((void *)udp + sizeof(*udp) <= data_end) {
> > >> >>         1886: (2d) if r3 > r2 goto pc+23      ; frame2: R2_w=pkt_end(off=0,imm=0) R3_w=pkt(off=42,r=42,imm=0)
> > >> >>         ; id->src_port = bpf_ntohs(udp->source);
> > >> >>         1887: (69) r2 = *(u16 *)(r7 +0)       ; frame2: R2_w=scalar(umax=65535,var_off=(0x0; 0xffff)) R7_w=pkt(off=34,r=42,imm=0)
> > >> >>         1888: (bf) r3 = r2                    ; frame2: R2_w=scalar(id=103,umax=65535,var_off=(0x0; 0xffff)) R3_w=scalar(id=103,umax=65535,var_off=(0x0; 0xffff))
> > >> >>         1889: (dc) r3 = be16 r3               ; frame2: R3_w=scalar()
> > >> >>         ; id->src_port = bpf_ntohs(udp->source);
> > >> >>         1890: (73) *(u8 *)(r1 +47) = r3       ; frame2: R1_w=fp-160 R3_w=scalar()
> > >> >>         ; id->src_port = bpf_ntohs(udp->source);
> > >> >>         1891: (dc) r2 = be64 r2               ; frame2: R2_w=scalar()
> > >> >>         ; id->src_port = bpf_ntohs(udp->source);
> > >> >>         1892: (77) r2 >>= 56                  ; frame2: R2_w=scalar(umax=255,var_off=(0x0; 0xff))
> > >> >>         1893: (73) *(u8 *)(r1 +48) = r2
> > >> >>         BUG regs 1
> > >> >>         processed 5121 insns (limit 1000000) max_states_per_insn 4 total_states 92 peak_states 90 mark_read 20
> > >> >>         (truncated)  component=ebpf.FlowFetcher
> > >> >>
> > >> >> Dmesg says:
> > >> >>
> > >> >> [252431.093126] verifier backtracking bug
> > >> >> [252431.093129] WARNING: CPU: 3 PID: 302245 at kernel/bpf/verifier.c:3533 __mark_chain_precision+0xe83/0x1090
> > >> >>
> > >> >>
> > >> >> The splat appears when trying to run the netobserv-ebpf-agent. Steps to
> > >> >> reproduce:
> > >> >>
> > >> >> git clone https://github.com/netobserv/netobserv-ebpf-agent
> > >> >> cd netobserv-ebpf-agent && make compile
> > >> >> sudo FLOWS_TARGET_HOST=127.0.0.1 FLOWS_TARGET_PORT=9999 ./bin/netobserv-ebpf-agent
> > >> >>
> > >> >> (It needs a 'make generate' before the compile to recompile the BPF
> > >> >> program itself, but that requires the Cilium bpf2go program to be
> > >> >> installed and there's a binary version checked into the tree so that is
> > >> >> not strictly necessary to reproduce the splat).
> > >> >>
> > >> >> That project uses the Cilium Go eBPF loader. Interestingly, loading the
> > >> >> same program using tc (with libbpf 1.2.2) works just fine:
> > >> >>
> > >> >> ip link add type veth
> > >> >> tc qdisc add dev veth0 clsact
> > >> >> tc filter add dev veth0 egress bpf direct-action obj pkg/ebpf/bpf_bpfel.o sec tc_egress
> > >> >>
> > >> >> So maybe there is some massaging of the object file that libbpf is doing
> > >> >> but the Go library isn't, that prevents this bug from triggering? I'm
> > >> >> only guessing here, I don't really know exactly what the Go library is
> > >> >> doing under the hood.
> > >> >>
> > >> >> Anyway, I guess this is a kernel bug in any case since that WARN() is
> > >> >> there; could you please take a look?
> > >> >>
> > >> >
> > >> > Yes, I tried. Unfortunately I can't build netobserv-ebpf-agent on my
> > >> > dev machine and can't run it. I tried to load bpf_bpfel.o through
> > >> > veristat, but unfortunately it is not libbpf-compatible.
> > >> >
> > >> > Is there some way to get a full verifier log for the failure above?
> > >> > with log_level 2, if possible? If you can share it through Github Gist
> > >> > or something like that, I'd really appreciate it. Thanks!
> > >>
> > >> Sure, here you go:
> > >> https://gist.github.com/tohojo/31173d2bb07262a21393f76d9a45132d
> > >
> > > Thanks, this is very useful. And it's pretty clear what happens from
> > > last few lines:
> > >
> > >     mark_precise: frame2: regs=r2 stack= before 1890: (dc) r2 = be64 r2
> > >     mark_precise: frame2: regs=r0,r2 stack= before 1889: (73) *(u8
> > > *)(r1 +47) = r3
> > >
> > > See how we add r0 to the regs set, while there is no r0 involved in
> > > `r2 = be64 r2`? I think it's just a missing case of handling BPF_END
> > > (and perhaps BPF_NEG as well) instructions in backtrack_insn(). Should
> > > be a trivial fix, though ideally we should also add some test for this
> > > as well.
> >
> > Sounds good, thank you for looking into it! Let me know if you need me
> > to test a patch :)
> >
> > -Toke
> >
> 

