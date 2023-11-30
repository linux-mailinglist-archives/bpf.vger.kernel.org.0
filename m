Return-Path: <bpf+bounces-16227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAADE7FE8AE
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 06:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846EA2822F5
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 05:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14C016422;
	Thu, 30 Nov 2023 05:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="1YGx/MAC"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79187BC
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 21:29:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hpk2FU/BpUPI83WEmybCVR27vEq0TA1usOEzg1M1UMrQAlZtozOboeGRRnp0bKm3dxpE/PPMjiykiUsSfMQF3l25Ng6e99M4JsePrWVR3na6BL5hEjraEz1fUPgnz0OblhvZHR8iJMkWepoeVhoMo62tEW2wXmwH3n2KVRYemYZ3Klm1VaQkozuh24nOEim47P9J2aTsmdsq5DAP/aGe+Kooz0F7EDAR571/mdCFtRxBRgXMqy1yvR7ZD46RZAclSeE3/PAgG3COAkEAv3A+7+O3lu0IE+vn2/NiEKZDsXgcp8FwIWdKajGz8dvmBWM1Ao7GmlTfNnfakwcExSB3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLE70Tqk8NB2XVtu+78O98Roeouyzfud4Qsquc34gJM=;
 b=ExgBGPJVrx8xMa6raeBLdyM6EhhbYLBtWwdnMa1Lkr4yPxP+IFqs7Fkgx5JLvFRzqTBlIbl8tbhSCbnFLKzoayCbzcMbmbxUdVH6qjuFyRUcO6r5JYCS96DHeIg9RjQc7fnI2++0RW6LrD2+fZylAMubFWzvrIJo9gdZcBx5h4i2NLUh/+5+vVb9qUMVNENycy44Vca1CCBvh5CSlZea2tVSQEePqzkLnxoZWWkFvna/fjkl7k5SZoB7SFqkF/fL1hq3XwUoSHRmdy7w/OBc5RWBfzOZSNah76oevqAcGTDRAWbdq/P3q8bt7VAv1jGnm1rf+2hO9B3j2r/UxN2xQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLE70Tqk8NB2XVtu+78O98Roeouyzfud4Qsquc34gJM=;
 b=1YGx/MAC3XeX70NTXzw+Kkle9JNyW0F7Y6aHQGwganN1VtKvOX811aPKLmlQK/oPc93zqChL3MF0s1pfpHC076OVy4tUD88i/O3i7wj1ByMLS/7zhYVwzLb8psv0xGfE/lwhywHA/aPRUTEuJXL5jxBSElwZuNyYpArADK3jatQkLq+VU343mDTWLv7AZt5TA6HSQKoaDdM+Jnk3E1TTqnqeMN5/9mMZ5DU6YPBQVGLYi3DteDjNpN3hGLzJiBA+kKPCwirPvTl7VwjcIqvdLtXxkXVbh0hWgL2eJA2XBFfxDHotzGqL6MMk2vR4bs9fysy9P3QEv5UjDS50bSYw0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by PA4PR04MB7678.eurprd04.prod.outlook.com (2603:10a6:102:ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 05:29:44 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%7]) with mapi id 15.20.7068.012; Thu, 30 Nov 2023
 05:29:44 +0000
Date: Thu, 30 Nov 2023 13:29:33 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	kernel-team@meta.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/10] bpf: enforce precise retval range on
 program exit
Message-ID: <ZWgdvcz4ZIc3KNVG@u94a>
References: <20231129003620.1049610-1-andrii@kernel.org>
 <20231129003620.1049610-6-andrii@kernel.org>
 <f4zdgu5gyjo5ldq5pvrdzyrhvyx7ec2xus6ngcfdok5ibma3op@jzf4cofcyab6>
 <CAEf4BzZyHd80b3WEJLrBfim4oZ6t7pVMYhk_oznPg63a-r-P_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZyHd80b3WEJLrBfim4oZ6t7pVMYhk_oznPg63a-r-P_Q@mail.gmail.com>
X-ClientProxiedBy: TYCP301CA0013.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::16) To AS8PR04MB8660.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|PA4PR04MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ae9740-4a9f-48ca-3942-08dbf1655bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zSbW30zGy/sHE1g7exJOFpzrK22AxLCMSD2ait61tSnyPG/2gipYyawvjpW+82Q6DMvGGYvitB+AtuhH/3QuLl4o85bFwVoOQ38THBQX3txUeQB08XyHNte58Tb4vi3gNvtkHK7MyufQFDzKtDZaEeUo/iXqFuKGlsSq5LgUzOAbnLsqvU5tdsBPic7RLzRTEAL0K6ySjGEAGiatzCriWNgCeYrOBdWQh/W1QPbaaIO7oYmherv58VF7dH0X67cV2APeiGrD6pigOM81F1oVz/dPQCy84YwU1LnI44LQ3oZoLAejHt2byDPdK+maU+j/E4a02AuPaPOvHnOKHou/h2rObZDvEdty1Z1mbteW42FohzK6+tBU0cOyPK4CYJV4bNKfDx6MtBDoqTuRfNnDzXjnl5ymDs174iE2RwOwo2MoHmb1mN2/x+bmxc3Yhia2um9xY3ndQKF9V5NyJysz9TPgOFVnWb6mLstDyIcCKf+3WfyLoAGYpRMo0e4/wMhICWqa8X17djkSaGBC5lXBrXl8mwJf/rpvOR9ep42lIp3r/Zy5SgvpvZGDIzE/DNY2Eb16y9Zd0+aqzfoPxfTKASwI+bgdO/HwrAT7RaG3qNw7mplhTjgOzesdrTqbCbDe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(2906002)(33716001)(41300700001)(38100700002)(6666004)(6512007)(6486002)(86362001)(9686003)(26005)(53546011)(6506007)(478600001)(83380400001)(66556008)(316002)(54906003)(6916009)(66946007)(4326008)(8676002)(202311291699003)(8936002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Szh2dXhMZWRYZkVEdmN2V21mRmdRLzFoTlRmOFY1RXdhblBVUE9KWGdyeVhO?=
 =?utf-8?B?VkV2S2p5MzlubmgwWjNFOWZyRVh5TW94ZFlzK3pTUEF4VHFVc09MQzdaWEda?=
 =?utf-8?B?RGVUcDNyajRuWWVKV0ZkZGhodEg4K0czU0tGaVpHQ3ZmK0ZZRTBYbE0yTk9Q?=
 =?utf-8?B?MzB0RUJsbFV0MTFQZ0FUcWJjcWZhdytRQnVpSnpJYnBYTkxJbjQ5K2lqVWQv?=
 =?utf-8?B?d1NVak9taVpXMWowRUpaK3ZqQVk4bVFWRkt1OTl5VCt4Kzk0Um5ENGJQQnpa?=
 =?utf-8?B?RTBSM2NuOGpjVjlYQ1FoWDcxOXRWVGtHNld6U1BkclB1dmRlUlVLc3dNdHRT?=
 =?utf-8?B?UGxzOXdJVEJXd0pEUkxUNHlrVXg5ZWJGZWpJSFY1Y3ZHWWRVbkRsdGNhcVFl?=
 =?utf-8?B?ZWJyTWs1bXlMWC9tTlg1Yk5WMG9aamZWa1N5Z2NWUzFCRHZicVdjaGF2QTA3?=
 =?utf-8?B?aEUvUk9oRXJUZFNFN2w1eXltWWFLeWh1ZGdXYjk5dEMrVUk4T25yWDlWaVlo?=
 =?utf-8?B?VnlMU0lUbVVkWllZZkx0bG9uV0l4eEUyOXR2ZWhJdVNNVGVNeDhsUnNkNWlD?=
 =?utf-8?B?M2NyV3ovTnRVdVBTcXBkK25Yc3FTV0JmajJYOTFpYllVRXI2YUh1a1FDOUhh?=
 =?utf-8?B?TmwzSDNETFVkNkc5amxxVnF1c2ZPSzBXTDJ6TVlOdzcvNFUyUnF0WVREWmZ3?=
 =?utf-8?B?dmd1TEJjQldhQXpJN3VXc1luaUdvZkVrNWhWZ093eWkxV3dFbXcxbm1CTkRp?=
 =?utf-8?B?SVNsR0Z0OEJSemM4TVVuQmFhbjMvK012R3A3WmdiUFFibkIwU0xPK293ekVO?=
 =?utf-8?B?MEFoM2lJSUtiKzJiQ3lVSXd0VW00UGNVQ2V3Z01Kb28yNE45NUxySUdkMnY4?=
 =?utf-8?B?UmI4QjZXWURiWE0xTnE0eHNaQkVYVC9RZTk2WHVOMHFDdFROMVBybXJtRUd4?=
 =?utf-8?B?bk1BMC9Kb21DSzBycEl4cEVCTzVzakJmWkFCTEI1eUczKzVuS1VaV3lQQUF6?=
 =?utf-8?B?UFJ3TzJtYWpDRHJSYnh6NTVEam9pa2J3SFhRdmhsTGhXejZhZnBxV2FEU0lE?=
 =?utf-8?B?TGhRVEhrSlo0a3VtcEFTeVp5WVN4VkpTMXpIbXhVSWVIa1JwcUVBK2xDWmd4?=
 =?utf-8?B?RXVBb1paOEZmcDJvVjBBdFV1eXRaTkhoa2JYaFVRa3pWaHdZc2QxeWVZODNQ?=
 =?utf-8?B?bm5oWWtTQTJFK1RiQWxTUG0veUpqaTJ1SGh6bUV6cVRDanhoRzEzVXFNZmw5?=
 =?utf-8?B?eHNPTE1yaTZ6ZWNIMWFSVVhDTlNMV3RybnVNb0xCVG9pZzBENGk1SHpOaU0w?=
 =?utf-8?B?a014YzhiNGlrNnhSUElXeDE1TlFEM3VKTUpIZ1B4c2ZFcDVvOEF0Rkt3bWVY?=
 =?utf-8?B?bmcxOEIyU2xGOHJHQ2I1elBqVFFQeWhKamFBTkRpWHkxcWFSL29qaFJFbGhu?=
 =?utf-8?B?SlYxTTRqM0hUNUpIUnhNbUwyZDBLcFU3STlydHQ5UjdBdHhxVTVDRldIQ2RQ?=
 =?utf-8?B?aVFicE82ODdtb1B6Wnh1M0JnSk1oN3BoTHY0T2RmNGUrSy9QYjBvQitWNkha?=
 =?utf-8?B?N0pxOVFEc0NoK01LR0VtaDZZOUl5R3NnUHhQUGhsSWUrQ1VYV0k5cCt1MG9i?=
 =?utf-8?B?NmdIdnlyU1RhalRra0FMUmlCaXJBUmNrOXFEMUJOWTRyeFNTd3poUHFkdjBi?=
 =?utf-8?B?T2RzNjRpMHEvM1NlQXBpRXdRVGhyYU1CMnVDamZiSmpWTm1ISjd6Sm5JZXFq?=
 =?utf-8?B?QzdKR05LMGRPZXZhMi8rUnpZbGduOTF6N0VSRzhEUFdjR3RHUTF3cmwvZ2tv?=
 =?utf-8?B?alY4YTJtVkpRT1VFUTFTbkoybDVIdXpNQXhCbzVhUlNmbXhZMzZNVDREejk1?=
 =?utf-8?B?SUovQ1kwYjM3VlZueUY4bVFlM3d6Wk9WV1h0VXlsYVRTUjljRmcvWlIrZllo?=
 =?utf-8?B?MTRIVUZ5S0VKalVGRGJ4RnpZYmJkY1JuWWsyYnVqUjBUYnFrclBwUzIrcHNX?=
 =?utf-8?B?bzNNQktIVXRVMFhDblBQTnY3V250YTlpSkM0RlRMamt4QlV2WDQyY0lXTzlB?=
 =?utf-8?B?NHcyZzFDVDN3MDdxVzFQZzRDUFpQMktCaUdsWS81WC8zYStrWUtUOU9xRHBR?=
 =?utf-8?B?YVdUM3liUnZwYWFEaEo5Vk8zUkhRSVVLalV3NW9YMkkyeWhBaGJYWnhCTURI?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ae9740-4a9f-48ca-3942-08dbf1655bfc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 05:29:44.1301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOz15bpU44fzaq4BGRr1D6FsEB93kJv1xcaV/jG15HEFjnUEjzhKQTkNKX2jWKFOORTMt/pYU5EifnxBYIxnvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7678

On Wed, Nov 29, 2023 at 08:23:41AM -0800, Andrii Nakryiko wrote:
> On Wed, Nov 29, 2023 at 3:24 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >
> > On Tue, Nov 28, 2023 at 04:36:15PM -0800, Andrii Nakryiko wrote:
> > > Similarly to subprog/callback logic, enforce return value of BPF program
> > > using more precise umin/umax range.
> > >
> > > We need to adjust a bunch of tests due to a changed format of an error
> > > message.
> > >
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > ...
> >
> > Q: should the missing register name and values be added?
> 
> Probably not, it makes future refactoring a bit less painful. If the
> important part is to check that there *was* a message about invalid
> return result, rather *what exact format* of that message was, then
> matching for a substring is enough and makes the test a bit more
> robust to future slight refactorings.
> 
> > I know relatively little about selftest, but scrolling through it looks
> > as though the expect verifier message is incomplete. (Admittedly lots of
> > them are like this even before this patch, and this patch improves the
> > situation already)
> 
> Often times it's actually a mistake to expect exact format, it makes
> for painful refactoring and improvements. I feel it every time I touch
> verifier log formatting logic :( So I don't want to add to that pain.

Understood. Thanks for going through the reasoning!

> > e.g.
> >
> > > --- a/tools/testing/selftests/bpf/progs/test_global_func15.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_global_func15.c
> > > @@ -13,7 +13,7 @@ __noinline int foo(unsigned int *v)
> > >  }
> > >
> > >  SEC("cgroup_skb/ingress")
> > > -__failure __msg("At program exit the register R0 has value")
> > > +__failure __msg("At program exit the register R0 has ")
> > >  int global_func15(struct __sk_buff *skb)
> > >  {
> > >       unsigned int v = 1;
> >
> > looks like it is missing umin/umax=1
> >
> > ...
> >
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c b/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c
> > > index d6c4a7f3f790..4655f01b24aa 100644
> > > --- a/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c
> > > @@ -7,7 +7,7 @@
> > >
> > >  SEC("cgroup/sock")
> > >  __description("bpf_exit with invalid return code. test1")
> > > -__failure __msg("R0 has value (0x0; 0xffffffff)")
> > > +__failure __msg("umax=4294967295 should have been in [0, 1]")
> > >  __naked void with_invalid_return_code_test1(void)
> > >  {
> > >       asm volatile ("                                 \
> >
> > looks like it is missing mention of R0, etc.

