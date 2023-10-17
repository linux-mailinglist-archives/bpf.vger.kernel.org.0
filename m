Return-Path: <bpf+bounces-12436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CB97CC76E
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 17:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770DA1C20C5F
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 15:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0B94449C;
	Tue, 17 Oct 2023 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="0UboaThg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7C1EBE
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 15:26:38 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2044.outbound.protection.outlook.com [40.107.249.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C0E92
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 08:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4Fie2c3CtNecRTJ1tdntKn1rjxkMNiW9UqEOW8smGh1crfiAZwVujIusvfYeIrHzTRtt5RsG32M9NJ8gV3yfyak754nxPV62h58mCI+h4ZMmmJuS6uKUUJmiPwiV70g1HC5oV7DEkxW1Cb3j+qaBKItvndH72k1o7yFMihXyRp/BCp778c6mDUSKHiXguq0xkpIV3mSHRov+IQcpW60iMaQaTlmrKnTm8I8J4ubPxfivIKQKyKCHazYEJ2mr4JgKczbaK5XGKfSz1zkPIpey0Z+UqOz8hJH+KSAu5Avisz9fGig+8/VLHySlUJlT33PGfZM4Myh7FfHcwn9Ld5J7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3jPsYF3Z/VBE3ds9OjFNXwUjTyWMBca9hKSgNdyoOc=;
 b=QjfUpS9t7sdkEJsz8eLtaVb8ccl3lm522Rqyo3z4gd6PdPMgm6v8YHVvt6aDvDTzTWxTW6ZXLp1GDxcgi85Jaj138wyrV6Zv2KpqH9BHuuXEJgY8ZzlDsLT6tTzCQx5Xok+cfUQ0LD38En0kQIu+9rwKZlVZmPfIRr24rH8y3H5wxw4u9ooE4gK9eneiZ5DVxHOb1sOIlPVdrl4UNP/SKWvq6jEqjCyw2z7AUsHrzQYnoXXfaNMXwomDbyf31nFplooUgt/9M4TYDxtzWSQLtU2vdu2ODqScHJlYf7ol1hk6HQyi3yuZZp6OD8QMm1B55KBd4OX+VEHKjmjN0mrn1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3jPsYF3Z/VBE3ds9OjFNXwUjTyWMBca9hKSgNdyoOc=;
 b=0UboaThgKljbzqa8MNMgd3WgNMsOx9ejsCKoH2KosuoUV/MEON8PyDwKIBNyA2uab3yiTotozPHkeO7BDWnDxd373T9zI2vo4G0L3L4l2GZavDJRdN/HVvqLS56v5M0JmHqbTOEzV9vQhh4QXwPs0jD19UTA/YyggZqEw5bo8fEdKIEkF+jj0dQ2jle5umCWP21MhdkR8ESKqME0cFoCuQXi9ka7xRNYW5/6vsL3OVb+3AuKCX4DXOEMSwBdsMDrX5A8m+dsIBvpxdUUhO9XXlQ2Ehnq/e3SM5lEgkQgYUswhlNyWVW45I5a72SfjaRpfWLjn+27+q/j6zN4HJrQbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DU2PR04MB9146.eurprd04.prod.outlook.com (2603:10a6:10:2f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 15:26:31 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 15:26:31 +0000
Date: Tue, 17 Oct 2023 23:26:20 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Mohamed Mahmoud <mmahmoud@redhat.com>
Subject: Re: Hitting verifier backtracking bug on 6.5.5 kernel
Message-ID: <ZS6nnJRuI22tgI4D@u94a>
References: <87jzrrwptf.fsf@toke.dk>
 <CAEf4BzaC3ZohtcRhKQRCjdiou3=KcfDvRnF6RN55BTZx+jNqhg@mail.gmail.com>
 <87sf6auzok.fsf@toke.dk>
 <CAEf4BzaAjisHpVikUNb5sQDdQwNheNJRojoauQvAPppMQJhK9g@mail.gmail.com>
 <87il75v74m.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87il75v74m.fsf@toke.dk>
X-ClientProxiedBy: FR4P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::6) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DU2PR04MB9146:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c97d138-24de-48cc-e978-08dbcf25702c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VmSvbsN2u+ebswIS+Uhl9rJ7g+fzCRT69HO1FWehNMMjbTrMAE2F3tNfjAHfHtY0QkUmUN7i2Rba8ufTd0DbrVvM4QYELtRh25cV44+y61lthfnhBGVkFRgpw9rzZfceUoWz29YANzUcG/+4zuZMYoI/ZU21Fd1RwDBnR51EP9WswWub97W/9gfSHj/mXP+//SWpBH1UhGz6lAgaKaEUx3sz9ugctmPqbYirBoFWiRo/E2fU//S4dXZqa0hfMDmyjSxc3++R/t3EP/EzCBFhzky6/bj8STahmzR1P2RXA3oDHMd9rcq2b/61Np21RNQJAwAWFGrzRtTUiOhI5MGTn3ceJijMkZTvDl2AZ6XXWLjXfD2NRqLI9sWYle+vTUAjVnljYtG7eqC8BUt/c/VLKtmNLOXweVdoQpsikx6qmLvjcm/UfADtK5mJjNlhKjmIuYEl0wLs4levhTjb9JywHdr+8TvF7VJQUW93oMwEEzAbubA0uzfCGLi2+poQCUWz7w/ljjnavkdDg+nsesV5lj7A8iyOW6TdKKjVZus4GzY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39850400004)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(316002)(54906003)(66556008)(66476007)(66946007)(4326008)(8936002)(8676002)(6506007)(6666004)(38100700002)(9686003)(6512007)(53546011)(6486002)(966005)(83380400001)(478600001)(33716001)(66574015)(26005)(2906002)(5660300002)(86362001)(41300700001)(6916009)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmdiNDduUG5iU215TkdyTFlWaGIzSUJFMUV1TTU5aGo0VUpXbXZiYXpURHJM?=
 =?utf-8?B?ckJ2WDlOZ1YrKzgwMElMd2xVWEVRZlg4azJmQWgzN1BOWkdCdlBzd1BILzAr?=
 =?utf-8?B?Qy9qQmF3NUJGcS96THBwaHFzdXErbmxyVmU3d2o0anljNjF6M2ovbmxRNi9N?=
 =?utf-8?B?RThraG1paXNiTGJMSkY5akI2MDM2VW0vK3JPUmNRZ2pzLy9RYTB2RTkwRk1x?=
 =?utf-8?B?cDU2Z0hIVm1YWmZvaURaN3hPMzBHT2habDBacjNlMkJOM2JCb1lhUTdmVVQv?=
 =?utf-8?B?N2U2TDVtenRQZFc1cFN1ZURmc0tHY1V4YVBhblhOSnJ1UGxhT0FhZm1mVm9Z?=
 =?utf-8?B?NUk2NW4rdm1QTFVRRFRyT0t5aVcxTWpVbzllOWVSTXd5TkcxMzJkNXBIVkoy?=
 =?utf-8?B?U1U1L21DNU9aZEgrK0p3M1JlYnltNklNY2RReW5OSVhNajc1VVlNTFA1ekJN?=
 =?utf-8?B?OXRubCticklzOW1qWlVyeGN2OTM5b3FoaWF6NjZCRlQ1NnorV0lSTUtuY3Ni?=
 =?utf-8?B?QWg0UGhkcGdkaURLeHJXakpETTkrdDUrdWI2Zkc5M01nR0x5VE5kbkFyM0Vr?=
 =?utf-8?B?dDQ2SHFzTDlTaFV5TU9TZFcyYUwwSElLQ01DbkI2Ykx6SVIyMXRka3lhMldP?=
 =?utf-8?B?eGZXUzdMc3BEZ1NHeVI5OHFzdVMxeDdEVGdwbFJIOUdpWDN1V1B3eFV1SHhs?=
 =?utf-8?B?YnV4dzc3MlZta0hJS1phY2tBazB1LzFYR0lsWWR6UEUweUFIMVJ6KzNHakdW?=
 =?utf-8?B?dm5QMkJkSHRLaHZFeS85RHVWRlB0KzEzeTdQbHhlQUhRdGJ3VDlzQzIzRFg3?=
 =?utf-8?B?bytJRDlCTnhCSHhYVTlPcnhGYTRxRmhocG90QTlmenFvd1JCNTVJZmFuQmZJ?=
 =?utf-8?B?bXdoWExqeENsMnZodGtjVzRYV2FpcVFCQ2p6bjF5a0s4VHQyR1V3anhxL0xR?=
 =?utf-8?B?dWNCMFE5em43OHlmMDM0ak9HOGF1RTBad25rY2V0Tk9tN1Q1d1NzVHZ0VzR1?=
 =?utf-8?B?M1lGY1Z6TGt1NUpQenQvTytrcHJaaFNGQjRITDVIU3FjSTRXamE0bDk1MjZl?=
 =?utf-8?B?MFJOeGlrTXltbUJzRXNId2toQkJNcCt3Y3Byb2R1ZlRoMFJsTkpzL2NoUGNn?=
 =?utf-8?B?TWdoZ2VkdzB6SkRlemRTN3BzeHh2YlZsRU9RSU13NjVEOUJnU2lPdFJDQWJS?=
 =?utf-8?B?WEpUYkZGZmlnZ21zZlVuU3p6N2VnRUJHQThML0RQREtQUVFyb1VxVnd0ZHcr?=
 =?utf-8?B?SVBpRDNrbWQ5eGkyUE1QMkpWcUllNlVFeURNNkMzS200WDBseExPUkpmbzFm?=
 =?utf-8?B?MnpNT0syK2RVVG9xVG1FL2hmWHY4Q3hFM2s1cGhHd1NuRU10MFo2akVCWUdD?=
 =?utf-8?B?N0NpTEFJT2diOEd0dHloakFwUnloT0xJeDcraE9FRHFjcFZ2T042eEVtUkxz?=
 =?utf-8?B?MW5sYnFNUTdKbGRISDBEdjhKMTE3MnhXbFV1dG9uY0JUWHRvb3dUTlNLZndG?=
 =?utf-8?B?MDNLQW5yVnh2UlhuVDJkZXNFRHJ5SHVHZmVJTDd2czFYRVUxSVh2R2g4d3FQ?=
 =?utf-8?B?NmhMM05Rd0hzNGlMSmpQOVNwOG9hWERMRXMwVXlHaGNaMHhHM3plb2pIWUJx?=
 =?utf-8?B?RS9SNm9JVlVVbUExYkd5Z2NUdlRCa0RLUkZRenRJNE5hOUNCbENVV3NldWdG?=
 =?utf-8?B?amR6dERGdGx5eHZuQU9jM09iRWtwQm1iTkkySGVWV014WW1IOXRCY2J4UCsw?=
 =?utf-8?B?ZlZqSDZYcmppTHB0Mk9YS3h4eGdTQmkxcVRtb2RmTXdKNXByOTFKeXFzd1Fa?=
 =?utf-8?B?ekZHOVNRZE9MOVBqSjdBVUJMdUN2OUEvYVpVTUhMUGUwRWxXSU1IL2kvcXY4?=
 =?utf-8?B?R0dObTNCZkxaY29DZDFSQVFiTC8ybVg2MktwMHJHcFZsODRpUEhZYnYzMEcz?=
 =?utf-8?B?ajVFSTV4UXJ6ZUo0RTI1Q2pESVFaTGhYWWZtQzRHMTFhamR1OW1aN2ZFQlhw?=
 =?utf-8?B?ODRPSGYvdmJ4alNCTE9hMjh5Y3A5L1N6YlFMM1B3aUVkK3RPalZhNzl1enBX?=
 =?utf-8?B?SVU2UzFwVnlBTDRZWVpMZmdkd0JqQ3lwQjRYbm1xS2k5U2x2UThHQ2RwSXJK?=
 =?utf-8?Q?SjLErRgRPnNsg/T8fQdN0sTIL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c97d138-24de-48cc-e978-08dbcf25702c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 15:26:30.9948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2E6i9GRqazUiFyhPTBv7TFUo2W01mKevN9wB8idfBgsh3oluv6Z2q5H8LPT69Es0vteYtC6BxiC3zciloT6jVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 01:08:25PM +0200, Toke Høiland-Jørgensen wrote:
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> 
> > On Mon, Oct 16, 2023 at 12:37 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> >>
> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >>
> >> > On Thu, Oct 12, 2023 at 1:25 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> >> >>
> >> >> Hi Andrii
> >> >>
> >> >> Mohamed ran into what appears to be a verifier bug related to your
> >> >> commit:
> >> >>
> >> >> fde2a3882bd0 ("bpf: support precision propagation in the presence of subprogs")
> >> >>
> >> >> So I figured you'd be the person to ask about this :)
> >> >>
> >> >> The issue appears on a vanilla 6.5 kernel (on both 6.5.6 on Fedora 38,
> >> >> and 6.5.5 on my Arch machine):
> >> >>
> >> >> INFO[0000] Verifier error: load program: bad address:
> >> >>         1861: frame2: R1_w=fp-160 R2_w=pkt_end(off=0,imm=0) R3=scalar(umin=17,umax=255,var_off=(0x0; 0xff)) R4_w=fp-96 R6_w=fp-96 R7_w=pkt(off=34,r=34,imm=0) R10=fp0
> >> >>         ; switch (protocol) {
> >> >>         1861: (15) if r3 == 0x11 goto pc+22 1884: frame2: R1_w=fp-160 R2_w=pkt_end(off=0,imm=0) R3=17 R4_w=fp-96 R6_w=fp-96 R7_w=pkt(off=34,r=34,imm=0) R10=fp0
> >> >>         ; if ((void *)udp + sizeof(*udp) <= data_end) {
> >> >>         1884: (bf) r3 = r7                    ; frame2: R3_w=pkt(off=34,r=34,imm=0) R7_w=pkt(off=34,r=34,imm=0)
> >> >>         1885: (07) r3 += 8                    ; frame2: R3_w=pkt(off=42,r=34,imm=0)
> >> >>         ; if ((void *)udp + sizeof(*udp) <= data_end) {
> >> >>         1886: (2d) if r3 > r2 goto pc+23      ; frame2: R2_w=pkt_end(off=0,imm=0) R3_w=pkt(off=42,r=42,imm=0)
> >> >>         ; id->src_port = bpf_ntohs(udp->source);
> >> >>         1887: (69) r2 = *(u16 *)(r7 +0)       ; frame2: R2_w=scalar(umax=65535,var_off=(0x0; 0xffff)) R7_w=pkt(off=34,r=42,imm=0)
> >> >>         1888: (bf) r3 = r2                    ; frame2: R2_w=scalar(id=103,umax=65535,var_off=(0x0; 0xffff)) R3_w=scalar(id=103,umax=65535,var_off=(0x0; 0xffff))
> >> >>         1889: (dc) r3 = be16 r3               ; frame2: R3_w=scalar()
> >> >>         ; id->src_port = bpf_ntohs(udp->source);
> >> >>         1890: (73) *(u8 *)(r1 +47) = r3       ; frame2: R1_w=fp-160 R3_w=scalar()
> >> >>         ; id->src_port = bpf_ntohs(udp->source);
> >> >>         1891: (dc) r2 = be64 r2               ; frame2: R2_w=scalar()
> >> >>         ; id->src_port = bpf_ntohs(udp->source);
> >> >>         1892: (77) r2 >>= 56                  ; frame2: R2_w=scalar(umax=255,var_off=(0x0; 0xff))
> >> >>         1893: (73) *(u8 *)(r1 +48) = r2
> >> >>         BUG regs 1
> >> >>         processed 5121 insns (limit 1000000) max_states_per_insn 4 total_states 92 peak_states 90 mark_read 20
> >> >>         (truncated)  component=ebpf.FlowFetcher
> >> >>
> >> >> Dmesg says:
> >> >>
> >> >> [252431.093126] verifier backtracking bug
> >> >> [252431.093129] WARNING: CPU: 3 PID: 302245 at kernel/bpf/verifier.c:3533 __mark_chain_precision+0xe83/0x1090
> >> >>
> >> >>
> >> >> The splat appears when trying to run the netobserv-ebpf-agent. Steps to
> >> >> reproduce:
> >> >>
> >> >> git clone https://github.com/netobserv/netobserv-ebpf-agent
> >> >> cd netobserv-ebpf-agent && make compile
> >> >> sudo FLOWS_TARGET_HOST=127.0.0.1 FLOWS_TARGET_PORT=9999 ./bin/netobserv-ebpf-agent
> >> >>
> >> >> (It needs a 'make generate' before the compile to recompile the BPF
> >> >> program itself, but that requires the Cilium bpf2go program to be
> >> >> installed and there's a binary version checked into the tree so that is
> >> >> not strictly necessary to reproduce the splat).
> >> >>
> >> >> That project uses the Cilium Go eBPF loader. Interestingly, loading the
> >> >> same program using tc (with libbpf 1.2.2) works just fine:
> >> >>
> >> >> ip link add type veth
> >> >> tc qdisc add dev veth0 clsact
> >> >> tc filter add dev veth0 egress bpf direct-action obj pkg/ebpf/bpf_bpfel.o sec tc_egress
> >> >>
> >> >> So maybe there is some massaging of the object file that libbpf is doing
> >> >> but the Go library isn't, that prevents this bug from triggering? I'm
> >> >> only guessing here, I don't really know exactly what the Go library is
> >> >> doing under the hood.
> >> >>
> >> >> Anyway, I guess this is a kernel bug in any case since that WARN() is
> >> >> there; could you please take a look?
> >> >>
> >> >
> >> > Yes, I tried. Unfortunately I can't build netobserv-ebpf-agent on my
> >> > dev machine and can't run it. I tried to load bpf_bpfel.o through
> >> > veristat, but unfortunately it is not libbpf-compatible.
> >> >
> >> > Is there some way to get a full verifier log for the failure above?
> >> > with log_level 2, if possible? If you can share it through Github Gist
> >> > or something like that, I'd really appreciate it. Thanks!
> >>
> >> Sure, here you go:
> >> https://gist.github.com/tohojo/31173d2bb07262a21393f76d9a45132d
> >
> > Thanks, this is very useful. And it's pretty clear what happens from
> > last few lines:
> >
> >     mark_precise: frame2: regs=r2 stack= before 1890: (dc) r2 = be64 r2
> >     mark_precise: frame2: regs=r0,r2 stack= before 1889: (73) *(u8
> > *)(r1 +47) = r3
> >
> > See how we add r0 to the regs set, while there is no r0 involved in
> > `r2 = be64 r2`? I think it's just a missing case of handling BPF_END
> > (and perhaps BPF_NEG as well) instructions in backtrack_insn(). Should
> > be a trivial fix, though ideally we should also add some test for this
> > as well.
> 
> Sounds good, thank you for looking into it! Let me know if you need me
> to test a patch :)

Patch based on Andrii's analysis.

Given that both BPF_END and BPF_NEG always operates on dst_reg itself
and that bt_is_reg_set(bt, dreg) was already checked I believe we can
just return with no futher action.

---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9cdba4ce23d2..7e396288aaf0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3418,7 +3418,9 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 	if (class == BPF_ALU || class == BPF_ALU64) {
 		if (!bt_is_reg_set(bt, dreg))
 			return 0;
-		if (opcode == BPF_MOV) {
+		if (opcode == BPF_END || opcode == BPF_NEG) {
+			return 0;
+		} else if (opcode == BPF_MOV) {
 			if (BPF_SRC(insn->code) == BPF_X) {
 				/* dreg = sreg
 				 * dreg needs precision after this insn
-- 
2.42.0

