Return-Path: <bpf+bounces-12962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD367D2844
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 04:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0D31F216E3
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 02:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED817137F;
	Mon, 23 Oct 2023 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GjZB15Hd"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9269CED0
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 02:08:41 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5D08E
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 19:08:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6IAkbZhTfzmTvB7RzvIIK5wu5Zh8MvbqSFdK6dLX+cO7R9+AZIvCp4B4Xhs+hwVSaZz5MQUncHzCcbAFnoX4mjX3AmKslLCFu2yobf82Vx6gyfLJuwhjsXObuc1EsD6g17izuvcPChAKhaEkaJ0ciF87AENWCyyRmc1vk+Kcw2HEKO+PPISbqVzDl/v3+6GNr/BJpNjZhZbfDeW9P7qk7JZGTTYbYcWCTJUYj90EkS6I582XNdmFwWi0yFZKf4svPyiTh4Zmhw6YzcxCeexkOCbniF7DUtzn2tkgDWcc2mIxyb0AGI2kNk0eJU5PMuF0FyBbqh0qtNkMXlmTJabtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrEYkvUv8GJM/VPo4ppqvvFraofUNGYaboPjTSA7dzc=;
 b=MJwTMXjQDUHMjW42QCeS22B7LHdF8thM+r7bMc5Q8XxNhaQPKPuRB2WUjClRgB28XTsYhLtrVWx2lLB7nGJLGGfberhRGC7Ibf5zrPbsXZUPTjQTympAIfJQgp81LvO+j/Bd7VN6mvsyz1ywMF8nD+Ks7lcZnQ7oTXs1ZzrOoYm2pZ+m66kh70VBOHWoZ533+9zhuLf6yTg3tfx+g2adaTliU4HsJDip90yO2cTDH06fZ7as6djKI8OPtp6L6Orc2AchMs7cwB7VcPEjM6NiuWSQ3Tru6KwzD3x/NKPgnmyH2qR+G8Fe3FJiQC+aII4n84DTC9ioJwxSTs5Gsejh6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrEYkvUv8GJM/VPo4ppqvvFraofUNGYaboPjTSA7dzc=;
 b=GjZB15Hd4Y5CfxzyTTwW/UbZQYCj16pFAe/oozagAjL6x6On/sSnyDrE53W9WLuIxtuAsIt4iD1EIw+yRRTtP2bOM9TDjcU4cvX85hZzI92VarHN1bBWhQv83nIlcIRFmbF9GIp+tfm+vO9rtRa1nd1Hw+zv7dFhXnsCZeejkDgNtHgjtXSeHEFysdeMeOANoNDsVqpbC+9TMP8bP02QY74LFhUuDbCGi8aUhNNcP78n4qNGXL7l2dTRRIgOg0bZqYUdUrIqt/GWsr/Olqh71xUGyt5NO4LbYifKnfUCFGXd+C61GoTqqg31Or7Ir9ZfdcITdTs5edNm5EP5Ms7WpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DBBPR04MB7785.eurprd04.prod.outlook.com (2603:10a6:10:1e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Mon, 23 Oct
 2023 02:08:37 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 02:08:37 +0000
Date: Mon, 23 Oct 2023 10:08:31 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Mohamed Mahmoud <mmahmoud@redhat.com>
Subject: Re: Hitting verifier backtracking bug on 6.5.5 kernel
Message-ID: <ZTXVn3EMBELuV-yH@u94a>
References: <87jzrrwptf.fsf@toke.dk>
 <CAEf4BzaC3ZohtcRhKQRCjdiou3=KcfDvRnF6RN55BTZx+jNqhg@mail.gmail.com>
 <87sf6auzok.fsf@toke.dk>
 <CAEf4BzaAjisHpVikUNb5sQDdQwNheNJRojoauQvAPppMQJhK9g@mail.gmail.com>
 <87il75v74m.fsf@toke.dk>
 <ZS6nnJRuI22tgI4D@u94a>
 <87fs29uppj.fsf@toke.dk>
 <87mswds1c7.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mswds1c7.fsf@toke.dk>
X-ClientProxiedBy: FR4P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::17) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DBBPR04MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: b61d030a-9066-4b9a-f6e4-08dbd36cf7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vWhw5xyo+rIqS06Q34e4wtsFPgixC5TZFoUq+78aa3CZoi/m6xT4u1jN/iGzTVSwIIbj8zipvSqSLP9pCX9YH/SAwMUuKY3r7PXMlFIkJi+Oi7HrUy5pAmwZPzqtQc20ZnbVNXlM0L+kRSaOMZGXbC+pmvHOrczUD1bqAlIsHPzi1l59W3NYESwNUGwVG7y2Phmpj7foaeZR2tlHZTFeySGqT9B85wdD8qIya/53PV5sr6OnS0UBhA2EtAz0bTFau9IthmoPD9bAvvry7iKIq8RBUwkhUW2oEJOhne+kB2FNv+D2h0+i2Rk0t0jCvBZ2XPkOdogSxpw7AyyInLwNwBDFB/LgIeodD+2BRTOn1mvYWSr6Bn8kg9tU92iW+sJCB9YKNjaeXzkawzPfbjCeIMB19RmbeS3vmZq5M7WQx8wE+9l84ak73hzU9ATcHZ3quFqu+8Qgbql60QSl1INE1VXxrj6eXaZUUr0/Yz110Js86ZLnJOSe7yyt4H0JeOYkq1a3FQFP0wCgBJ686SAMNf6u8erXQ52BYSz2euNQLDR982HaVZl6SNpZPti7REG2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(396003)(376002)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(41300700001)(4744005)(2906002)(6486002)(478600001)(5660300002)(8676002)(8936002)(4326008)(6916009)(66946007)(54906003)(66556008)(66476007)(316002)(33716001)(86362001)(38100700002)(26005)(9686003)(6666004)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmQwNnVKNDN5dFc5K3pjRVFrUVdqeERBMmxpOUtjbVVHOW0xMVRjaC9OOTZJ?=
 =?utf-8?B?eTB0NzVOcGFHNGs0bzVHeXVQeHhjU1pMeHZIL0Fyek1xUGZSeGp3b1FzdllU?=
 =?utf-8?B?R3AycmZLQXB1Tkc3OU14bWdPaU9lS1BQOWpNWU1QendlemVTV1VpNlpsaGZH?=
 =?utf-8?B?RUYzdjJUWFVacHQvTXJFSGVEYmErMWtzeXBJTVcwc21hVFRqdE5iZHVmZXRG?=
 =?utf-8?B?NWJxRFhrcVJNTUE2Y0s0Tll5WnBVaityUVRGeUVEYTM4ZlQ1MzdqRFVXRTY0?=
 =?utf-8?B?VTNVZlFycEtnVThUYXBuaDh0TnVkaWNFWUNBUktlNkN6QmNlcEd3MFpWbFJN?=
 =?utf-8?B?VWVGMGFRNDdkUFkyS2pKQ0IyQjh1U05PS1IwZUc5WFJNayszbXhlN1Frbnds?=
 =?utf-8?B?a2VicmtHMi9uR1QrSGR5WkdxT080WHAxcVBNeUFELzFHR1d0SUJmL2Q5NmV0?=
 =?utf-8?B?eU5jMFVpVHE5WmxjMFR5Yk9kRVBBTVhUWU5YbVRjY256dkwvSUpKRlZtVjY5?=
 =?utf-8?B?MlhQaTlDaEwwam1YL3N3TEpyTVBQdVhSQkowMkUrc3lGMmtYQmVxZFEzM2tk?=
 =?utf-8?B?cnUrSUJ0dUhqd0d2azJ5amlVSTNQdXp4VnBKejl3dFNzQ1hJUzAweDJxTG1J?=
 =?utf-8?B?aFE1cndJamNOUlZ0U2tNSkVoN01xSkhGZ0xsOEJyZUJLOXQxNlNSTFI5QkR1?=
 =?utf-8?B?bXIxYlJFRVJZMnNBVkZudUFMT01PQUV1N3YwWkJlTU83THRiK3R6OElNb2lt?=
 =?utf-8?B?b3h4aUN0NklZL3Q1OUhZWUNFY01RR09wYTg2MjNuQlIzWlJPUGlvdEVIV1Fq?=
 =?utf-8?B?SHNCYXJNOGNlMkZQTkhzU1pDakJCZjRKNTNCVXcvaEpPSVR3UWR3VW1veWta?=
 =?utf-8?B?NHVkb3Z1ZDF1K0MwTE1jeFVRZGtDTzF0RUk5aURQZGRXRmR6WDBlTUJlR1J5?=
 =?utf-8?B?NHFkWFJFZ3I3Vks2RGxycFJzeXN2eVlYRnd0a0wycngrU0JHbGtNQlZTTjg3?=
 =?utf-8?B?SVdrVEYxSHR6b2d3ODRuNGlQUU1ZWHdKUlRGVmZEbnczMzlaeHc2RnFmQWd1?=
 =?utf-8?B?ci9sczVtbnZxeG0rM3dFMTloZnRXNmFKUmZERS9YTFBSbzlZRVR5WjFSeWxT?=
 =?utf-8?B?c3M0cUNMdVhkN0lwTkNWMGVZT3pDeXFXWEE4MjJWUWp5Rm9KNDdsdTNOaHVm?=
 =?utf-8?B?dk85L1o2REtKZ2JTL0c4ZHZraWl4eFFxbWJsSmM1YXNINENYSW5WR1RSVUVN?=
 =?utf-8?B?WFRFZllFUnU3Y3FTNWJZdTQxeGhiSkQvM2gvTGw4bTBzdExWcDI0UnhpUmpZ?=
 =?utf-8?B?RzRmUlNSd1J2YlR1aERkSndKK0ZjYnM2NlNvcmRKZHlhaklRQ2Z3Wng5UmNK?=
 =?utf-8?B?azgxZHlFWXhsbXRKTExjNklWQWNxNmswRTVOMnlhbGt5aXp3R0xaUDN3ZUhn?=
 =?utf-8?B?MURWM0E2Ny9rdE1PUkcvQWlrOHUvMldCM3NLa3dtMmpvYkNuUGlnMFI3NHBY?=
 =?utf-8?B?eTRhZ0tEVWFHVGY1MHhtMCtTODhNTlM4SjBaNFlOa1BBRmFIcjFIcjV1bGJ2?=
 =?utf-8?B?NFljTHprMlZVZWJoV0dCakJSRjlzK04wY1RIL3h4Y0FSUGxObkNwSTg5blVw?=
 =?utf-8?B?MVBOME9SckRGcHpKaU4wa21uRG1zc1BpUFZrbTFJbTU2L1dheXYvMFB1V0pI?=
 =?utf-8?B?QmhWNGNrYS8xaXFCcklJU1lQczAySWd1Q2pBY1hON3FXNXlHY09BRFNiNXpK?=
 =?utf-8?B?OEMzdkg4M2dpY0xBanpCZ3VtWXhEV1BuaWEwK2JwWHB4MWRMQUdSQVl6a044?=
 =?utf-8?B?dzFjbmpMNDRQQkU3V0FMVEVEenNVcE5UNmxIR3YyQ1Q5c2M4R3ZkclBBbkJW?=
 =?utf-8?B?MVFMVE5YQkkrT1Uyak1MVlVnYVphV3pGSDlBclVNZUlkVFhWeE40SEFhMy80?=
 =?utf-8?B?WlNtSG9kNXRROE1sUVFJWWkxdld1UTJ0VEVIdVdUQ2NIUXpQbHRRQVM0K2pu?=
 =?utf-8?B?NDhzTHlqQUhoMGZIYlppREczaVVHUFN3a3lHNXFaYUZpZTU4RkdsaGRnYlBm?=
 =?utf-8?B?Vk5YcXZrRUw5SThMZFZwSkxvc0VTbjdlL2NFTk9ybmJqd0ZzeWlpRmREUFNY?=
 =?utf-8?Q?wqcic7Y2hRrpYl+unjHGgRzZH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61d030a-9066-4b9a-f6e4-08dbd36cf7c1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 02:08:37.0632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eo6/Azsrc2URUc2r4wZ9oxklerHT+aIVIOgyLzGXroYardfKMbI3+kYgt4mnMzLoONQiLwbK2bDpCLRGC9r7mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7785

On Fri, Oct 20, 2023 at 06:30:48PM +0200, Toke Høiland-Jørgensen wrote:
> Toke Høiland-Jørgensen <toke@redhat.com> writes:
> > Shung-Hsi Yu <shung-hsi.yu@suse.com> writes:
> >
> >> Patch based on Andrii's analysis.
> >>
> >> Given that both BPF_END and BPF_NEG always operates on dst_reg itself
> >> and that bt_is_reg_set(bt, dreg) was already checked I believe we can
> >> just return with no futher action.
> >
> > Alright, manually applied this to bpf-next and indeed this enables the
> > netobserv-bpf-agent to load successfully. Care to submit a formal patch?
> > In that case please add my:
> >
> > Tested-by: Toke Høiland-Jørgensen <toke@redhat.com>
> >
> > Thanks!
> 
> Friendly ping - are you planning to submit an official patch for this? :)

Yes, I do plan to send an offical one along with selftest as Alexei has
suggested. Once I've got my irrational fear of writing selftests overcame ;)

Should have it out before the end of this week.

Shung-Hsi

> -Toke

