Return-Path: <bpf+bounces-13609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7242F7DBB93
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 15:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A10B20C58
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 14:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9545917999;
	Mon, 30 Oct 2023 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gYav30Aq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864A17982
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 14:16:43 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2049.outbound.protection.outlook.com [40.107.13.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3027FDE
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 07:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZ+YLQwgDfh6L2trwlNHTpkyzc8796HXDR9BRfi33+HFsCk3KywjgE8jAyFH+05f61rfXf6OEk5xMH18gY74rQnuBv+Gs9u2ech3UXLuTnA7oC+n/uf2lBcVlZFOexXA4xEpl6iG77E7+rb1WI04evswNQ8uGulxDepe59HuCEDGMk8UbOl5pG4l/xSPNMvXAEtw2nR9obK8W8oh9tufdqlfVFII1VEYqEKm3d0cY93vRE19Yf4uAABxu19T3mAtGf/TJpe+SWe+lL/cOHN2+BMqeJ6POFy3Fww5Rp9pCH7uCkQpCkQu0UF1x8TO8mg4cAK8waWH216lsVH3bkZAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCGAfL0DIsCuDpsyXaJzF/xYmBLV26PZfdZ83Mn6/l0=;
 b=OV0/3SYfZSzZaTIdJSF3d0kgjC07MxBKeMJxLrniATN04q0jXExfpfytjToUclPIlpjx/bHWTFDiJrs9Lr2fJTRZfrXfxHt4oG2jk0+1Y7AgRg9Bs5oJP8oYKIvh5pp8NGdYiTeqZ3E+rxihXoj6/jho7RsVHwR/BdngodxLXPK+1F8OT2Q/MflpYWjrbxjZR3d4jXt06KZ7XxJbLlzEXtZnH5ReatWa1wfWhBxE/eNk0oemyCvBBzGiA94URBKsXZHkf2N2fuZqbs5s7sgyj3JnW3p2ZXonxpjH3eiz3VxXNNGdncYrLHf5B8Bmf4oGic56AyPmGG2LrVJRbMP+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCGAfL0DIsCuDpsyXaJzF/xYmBLV26PZfdZ83Mn6/l0=;
 b=gYav30Aq3LaUWUEo381ppVukdDG7KVltEl8j7MI5JFunpQXgLK7yYS8Od+mSFR2VA3ANL+CBUjks2hmpGclWDW6UtJroxHMOTUJuiJ511zT6/AM5VV4W4xkx8V0bSAOnWIeH6R1wDmpEVj4jtQVg3QzGKULqTRekQ45nKvs5ZbLOSYyndS7TmHqYOdTEBKO4e5tN1hHHYHXGcRJ/zaDnD5k/iiU+w1znQvBTWedVB/7xr99goEqNsI4B7uDxvE4SMfkb0ZXXgNLcXLO7EYQmHZkrB2T7iDDXg9TLjr5ukPcAYkj6/AGO6gqN5BZe9gFx0PJNYvwzMwhPAPG/BZXmwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AS8PR04MB8006.eurprd04.prod.outlook.com (2603:10a6:20b:288::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Mon, 30 Oct
 2023 14:16:35 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.016; Mon, 30 Oct 2023
 14:16:35 +0000
Date: Mon, 30 Oct 2023 22:16:26 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mohamed Mahmoud <mmahmoud@redhat.com>
Subject: Re: Hitting verifier backtracking bug on 6.5.5 kernel
Message-ID: <ZT-6upsxRUWVnTvV@u94a>
References: <87jzrrwptf.fsf@toke.dk>
 <CAEf4BzaC3ZohtcRhKQRCjdiou3=KcfDvRnF6RN55BTZx+jNqhg@mail.gmail.com>
 <87sf6auzok.fsf@toke.dk>
 <CAEf4BzaAjisHpVikUNb5sQDdQwNheNJRojoauQvAPppMQJhK9g@mail.gmail.com>
 <87il75v74m.fsf@toke.dk>
 <ZS6nnJRuI22tgI4D@u94a>
 <87fs29uppj.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fs29uppj.fsf@toke.dk>
X-ClientProxiedBy: TYCP286CA0374.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::9) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AS8PR04MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 41727fe8-f392-4992-28a5-08dbd952d2c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q5PuFicIs6tScSc1fFS1zMo14P0QWqe7bhrZBLrrPvQ6J3TPBHgbIeOHMovohZ62bN+uMCZvo79Tt5vUu4iDpb5Kc1l1j0Udn9oM+dU9zXsSRhSFMfRISVti4a2K1QepL1wt8ooOp64oHsJMUhsZhVKJdtvxZ4mSP6gCItbXzsoW4Uef0PEqqtVM3kXai0xidN/juk5Pigjpdj6D0YEic/O8XKpGSFE6m4SHjFXpjlAym2OFB3MGBSFyVRnq4ICSa7XfEWQJfQhtEZwzzVa7UHWXZjH2qg6wQavFyxhTymVVMTnwi+KFTYaob7MupROvZn5ual3z8Mc1tbsZBclD3GXxp+/VSKSOiuKIp8a+0CdvG/xGlUEZCPR4wQGXXet4hviETmvKyrGeDbGndOG2rzrYGQB600UN0ob51Jq4sANtKWjZuVqLk1tKr+cBs4cTMePeQ8M8pmwpkdDZ8BZ3A4BCbphqTp861HvaM2SkB8blt2HaDnrHrT5lybqJh+U0gb9bus7c77xclgmDxiRztWb7MB403+50S2RKu5h7rzBkzBsEiERLxAkS9wQ4pLwBoEoVyYJ/Q33ja2nPqXv545fy/JXdssjPV7mwLXhE/jIv2Ec7bqKO7sC4n0By7A31
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799009)(186009)(64100799003)(86362001)(66574015)(316002)(6916009)(9686003)(6666004)(33716001)(8676002)(38100700002)(6512007)(2906002)(41300700001)(6506007)(53546011)(26005)(83380400001)(5660300002)(4326008)(66899024)(54906003)(66946007)(66476007)(478600001)(8936002)(966005)(66556008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDJjbXhFb2s4cDdTcEU1VVVSWnkvUnZtU3ZvcXZQM2FsaTZtenY5YStQZFRu?=
 =?utf-8?B?cUxyVGhrbVdOYW43cElJQkhoRGk4M2RWUjg3NUFjY1hFZzhUOWpsd2RuQkFD?=
 =?utf-8?B?Mm1QZjRUZnJTSVYxb2xSTUs2bHdPTHVWMWxpUUlpZDRCVDFpbGlDaHE1b0ta?=
 =?utf-8?B?djE5MzBmM21EbnJObUxoYllPUS9oTFEyUmNFa0dsTStVUFpNdjQ0OUtncnli?=
 =?utf-8?B?NEFMeXFTN0hMVnM4UDFtd3hSN2NRTzdsL1E4WDYrK1BVTVJaSk0rUUZRSllB?=
 =?utf-8?B?aFN0MW1FaFVzNzAvUDZpMVQrWlVmcDgyNjlZOEpxeUFDNmE2bkdrbFIwYXV6?=
 =?utf-8?B?OFpZR2xwUElLK0pUek5iUWovQU5McllYclpjS2JDSmM0YmkwMHlUdFJVSXJx?=
 =?utf-8?B?c01GbmZMQU9Ob25zeHJWV0RpaXdQdGRQQkxEamM4RVJ0ZUtRUllWcnMxY2Y4?=
 =?utf-8?B?dElKa2ZCRm50d3BvbW5jTitPYjF6SjhEdzZnbkhZRERvNW5PdHg2VHA3N0xY?=
 =?utf-8?B?c0hpUmdnZFRrQU9ScTNuWDZMNmU4QXU2Z0V5bHNvbWFUbk1XblRwT240eDJp?=
 =?utf-8?B?MFJjRFBnYUc2TXJZY212RVhqMW9EbDloUWd3c0pBU2VPSko5a1dIeWdxbFJt?=
 =?utf-8?B?VHQ3bW1KaFdkZFdGbW1RdUh3SUZMb3k2L2xITkJ0dHliRHBYeWV3WWJydnJL?=
 =?utf-8?B?QlZwSEFMSlhkTmg4cjRjT085VkRVUmZmTTFtc2twSGhJTTVUZ1BYOWtLMXNP?=
 =?utf-8?B?bnZVejJBMkJtME85dmF3QW5IY1NsV2NCWHVNaUd4b0hacnlUZ0c1QkhlbnhY?=
 =?utf-8?B?WnZ2aDdWTVVNTUtmVGM3eGZsRDhZVG1tZEZsSHgzYVN6R1lTTEJBUXNXT3Y3?=
 =?utf-8?B?WjdHSUVIVDR3SzBkaE8xWVdpRmpIWHVBdEo1b3hleCs4cmEzdk9LZVc1SDEz?=
 =?utf-8?B?dHp2SUhIeldpRzFmTXJSS1pkWjhKSlF2eXFvUFo4eTllbGNkSm1nU2JNN0Jm?=
 =?utf-8?B?R1ZUL1FMVDBxRkUxNWxWaHRpU3ZzNU1acERtelhVUmdwOEpEK0E5R2I4bHNu?=
 =?utf-8?B?RHN5TDB2elZtUjg4K3RmWWRjSjlMWEtyQTRaZ1pqNk14UG9VVE9qWkNuLzB5?=
 =?utf-8?B?Q2JrcjRNZGxIMmFrTngzMTdnYkFWUkdtUEprSDRNd1FXQ0NESlJtcGxXTlo1?=
 =?utf-8?B?ZS9wbkkzOExBODJLbVovaXdwcEgwU1pDOU1pTEkxcytYVHVzeURVcDNIM3BW?=
 =?utf-8?B?YnpOVUZWQU1peHFLYS84Zmh0OUFDS0MvRU9NQW0vNFRYRVhSb1o1Uk84RHBz?=
 =?utf-8?B?MFJRYndJVjh6VzU2VTJpVTgrL2ZmOFlPMGtyTUc5aXNEU0UyODVWTDkrT2RK?=
 =?utf-8?B?THd3UTFEeFFCUnJ5d05TQ2FvWWNYbHFPNVBMSjc2R0J6NUxTTWZkVmlCU0ZC?=
 =?utf-8?B?STVkTVBzTDlmYlVIM1VnOG1TV0w5UlExTW54dXFneG5ZK2MzSTRvcWoxZnFy?=
 =?utf-8?B?N09VU3VBRTFCZm05VzdIbkk2OUdLWkVSZWtvOGR6a3YwKzlmOWNEaGlRSmw2?=
 =?utf-8?B?QWxMMlVIV3pCSko0MGQ1Nmx3cDFRTERlZVRGbzltK3JpTHFuWDR2R0g5aXlE?=
 =?utf-8?B?VGxHdnpqYW5OQjFwaHF2SWkvOGMxVDNiamJPU2lqSDlPcy9OQ3EzVGJhQ1h1?=
 =?utf-8?B?REw5Y0tXWmI0dUVXc2w4SG1PUEErZEljMGtIQlZwNVBrRGtFNmk5UzB6L1RT?=
 =?utf-8?B?cDA2MlhUL3gvYUxXcm1JSlp6YkNsczRkV1V1Y21yWGk5NDFvSlFMSDdsWGVE?=
 =?utf-8?B?WFlyY1RvTTRmWXpOMVpUcWZLWUZQVEJwTjA5MnNKcXo4eGlyaXh5UGl5UXk4?=
 =?utf-8?B?b2sySWhjd2E0UlAzcjlWbndGYUlDVmpBaXlFa3N5elFCeGpUaktwajVLTStI?=
 =?utf-8?B?WFdoeFcwN1hjbEw5N2Rhb0lPeUx4c0l0Q0gvUnJFUDgxY2gvRjlmSnh2cDB3?=
 =?utf-8?B?QWpJZzhyUXpBS2tXeUlrSU5ZbkVvdFhyWnB2RUN1Q0ZMYlRSWmxlZXFhZDVq?=
 =?utf-8?B?NHRUWGk4SUNwT3pyckZJTnJ5OGZHdHI2c0s4bUJiRGlHQitiTXJIZXZnSjlZ?=
 =?utf-8?Q?OqCJpueCS25KPwa2HfqQW9HMD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41727fe8-f392-4992-28a5-08dbd952d2c4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 14:16:35.1500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MB6AKf9DcugfDx8ucswa2ISLA84az5pvMzqgo8KAkSWCb/Qh0fPUaqP7x11dSyyaTscy+9Y+UsqkT8/G86hDww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8006

On Tue, Oct 17, 2023 at 07:24:40PM +0200, Toke Høiland-Jørgensen wrote:
> Shung-Hsi Yu <shung-hsi.yu@suse.com> writes:
> > On Tue, Oct 17, 2023 at 01:08:25PM +0200, Toke Høiland-Jørgensen wrote:
> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >> > On Mon, Oct 16, 2023 at 12:37 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> >> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >> >> > On Thu, Oct 12, 2023 at 1:25 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> >> >> >>
> >> >> >> Hi Andrii
> >> >> >>
> >> >> >> Mohamed ran into what appears to be a verifier bug related to your
> >> >> >> commit:
> >> >> >>
> >> >> >> fde2a3882bd0 ("bpf: support precision propagation in the presence of subprogs")
> >> >> >>
> >> >> >> So I figured you'd be the person to ask about this :)
> >> >> >>
> >> >> >> The issue appears on a vanilla 6.5 kernel (on both 6.5.6 on Fedora 38,
> >> >> >> and 6.5.5 on my Arch machine):
> >> >> >>
> >> >> >> INFO[0000] Verifier error: load program: bad address:
> >> >> >>         1861: frame2: R1_w=fp-160 R2_w=pkt_end(off=0,imm=0) R3=scalar(umin=17,umax=255,var_off=(0x0; 0xff)) R4_w=fp-96 R6_w=fp-96 R7_w=pkt(off=34,r=34,imm=0) R10=fp0
> >> >> >>         ; switch (protocol) {
> >> >> >>         1861: (15) if r3 == 0x11 goto pc+22 1884: frame2: R1_w=fp-160 R2_w=pkt_end(off=0,imm=0) R3=17 R4_w=fp-96 R6_w=fp-96 R7_w=pkt(off=34,r=34,imm=0) R10=fp0
> >> >> >>         ; if ((void *)udp + sizeof(*udp) <= data_end) {
> >> >> >>         1884: (bf) r3 = r7                    ; frame2: R3_w=pkt(off=34,r=34,imm=0) R7_w=pkt(off=34,r=34,imm=0)
> >> >> >>         1885: (07) r3 += 8                    ; frame2: R3_w=pkt(off=42,r=34,imm=0)
> >> >> >>         ; if ((void *)udp + sizeof(*udp) <= data_end) {
> >> >> >>         1886: (2d) if r3 > r2 goto pc+23      ; frame2: R2_w=pkt_end(off=0,imm=0) R3_w=pkt(off=42,r=42,imm=0)
> >> >> >>         ; id->src_port = bpf_ntohs(udp->source);
> >> >> >>         1887: (69) r2 = *(u16 *)(r7 +0)       ; frame2: R2_w=scalar(umax=65535,var_off=(0x0; 0xffff)) R7_w=pkt(off=34,r=42,imm=0)
> >> >> >>         1888: (bf) r3 = r2                    ; frame2: R2_w=scalar(id=103,umax=65535,var_off=(0x0; 0xffff)) R3_w=scalar(id=103,umax=65535,var_off=(0x0; 0xffff))
> >> >> >>         1889: (dc) r3 = be16 r3               ; frame2: R3_w=scalar()
> >> >> >>         ; id->src_port = bpf_ntohs(udp->source);
> >> >> >>         1890: (73) *(u8 *)(r1 +47) = r3       ; frame2: R1_w=fp-160 R3_w=scalar()
> >> >> >>         ; id->src_port = bpf_ntohs(udp->source);
> >> >> >>         1891: (dc) r2 = be64 r2               ; frame2: R2_w=scalar()
> >> >> >>         ; id->src_port = bpf_ntohs(udp->source);
> >> >> >>         1892: (77) r2 >>= 56                  ; frame2: R2_w=scalar(umax=255,var_off=(0x0; 0xff))
> >> >> >>         1893: (73) *(u8 *)(r1 +48) = r2
> >> >> >>         BUG regs 1
> >> >> >>         processed 5121 insns (limit 1000000) max_states_per_insn 4 total_states 92 peak_states 90 mark_read 20
> >> >> >>         (truncated)  component=ebpf.FlowFetcher
> >> >> >>
> >> >> >> Dmesg says:
> >> >> >>
> >> >> >> [252431.093126] verifier backtracking bug
> >> >> >> [252431.093129] WARNING: CPU: 3 PID: 302245 at kernel/bpf/verifier.c:3533 __mark_chain_precision+0xe83/0x1090
> >> >> >>
> >> >> >> ...
> >> >> >
> >> >> > Is there some way to get a full verifier log for the failure above?
> >> >> > with log_level 2, if possible? If you can share it through Github Gist
> >> >> > or something like that, I'd really appreciate it. Thanks!
> >> >>
> >> >> Sure, here you go:
> >> >> https://gist.github.com/tohojo/31173d2bb07262a21393f76d9a45132d
> >> >
> >> > Thanks, this is very useful. And it's pretty clear what happens from
> >> > last few lines:
> >> >
> >> >     mark_precise: frame2: regs=r2 stack= before 1890: (dc) r2 = be64 r2
> >> >     mark_precise: frame2: regs=r0,r2 stack= before 1889: (73) *(u8
> >> > *)(r1 +47) = r3
> >> >
> >> > See how we add r0 to the regs set, while there is no r0 involved in
> >> > `r2 = be64 r2`? I think it's just a missing case of handling BPF_END
> >> > (and perhaps BPF_NEG as well) instructions in backtrack_insn(). Should
> >> > be a trivial fix, though ideally we should also add some test for this
> >> > as well.

Turns out the only case r0 is wrongly added to the regs set is with
BPF_ALU | BPF_TO_BE | BPF_END like the one seen here (only realize this
while working on selftests). All other cases are already handled correctly
because they happens to fall into the BPF_SRC(insn->code) == BPF_K == 0 case.

        } else {
                if (BPF_SRC(insn->code) == BPF_X) {
                        bt_set_reg(bt, sreg);
                }
                /* BPF_NEG, BPF_ALU | BPF_TO_LE | BPF_END, and
                 * BPF_ALU64 | BPF_END goes here in backtrack_insn()
                 */
        }

That said, having a "if (opcode == BPF_END || opcode == BPF_NEG)" check
still makes more sense, so I'm sticking with that.

RFC can be found at
 https://lore.kernel.org/bpf/20231030132145.20867-1-shung-hsi.yu@suse.com/

> >> Sounds good, thank you for looking into it! Let me know if you need me
> >> to test a patch :)
> >
> > Patch based on Andrii's analysis.
> >
> > Given that both BPF_END and BPF_NEG always operates on dst_reg itself
> > and that bt_is_reg_set(bt, dreg) was already checked I believe we can
> > just return with no futher action.
> 
> Alright, manually applied this to bpf-next and indeed this enables the
> netobserv-bpf-agent to load successfully. Care to submit a formal patch?
> In that case please add my:
> 
> Tested-by: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> Thanks!
> 
> -Toke

