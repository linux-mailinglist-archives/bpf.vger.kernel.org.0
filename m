Return-Path: <bpf+bounces-14370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F007E3494
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 05:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7350FB20BC6
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 04:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B48410E2;
	Tue,  7 Nov 2023 04:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U3fAdlmy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC038B
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 04:43:25 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AADCFD
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 20:43:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEeES9mln0KMAOa1VgGEGx5ACLkCgcM2DLkXAxAcRUR+JCDrRdVeyp5cQd0dq6zAmlFfIAvLOkPzvcX49x+zCz/qqivpLcdKlkIbaEAQQjjsq8CH1ihSpX7ZQE+TvguLMn2ChybwE4zBA70ToIZf1X/lRlzQuA9p0GDhZrHEE5O194u6Y4geg6yECO9G8eWbcO6uDjFRamEHq+DGv0bUrV9/6zZpKqHArOFWFK+qRPTCkr4m5ptZvDN78Df9coEqTc+vQAicS0cljb+TaGbP/FcPv3yr1H2M2wWhaKCi/tRWlTrs3ECyJF30aHZj5k94s5e+JGzX9T/5zzNHxd7OKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nawEo1OBnBo4eBKMenPiFrYnygC0V3+oQf4mpXyN4Hw=;
 b=Xpi/4lGbwnZu1naDa3LfVBvX/QfwJVikBVKWRH6lH2oEwZ6gT52IEOPt3QTEONjmTOXirmGhQcxBvdXH8f1HOY8BLwV0AG3zIdyBIyKmjABjaS9It1Q3EOMpMLW/ySbAXr9BFFL07lz1Y9FUxxOZpBhfWly0uoQdlbMtZ5sjl5n1lmzQjLdg2wxfRHTrIxghgLhW1IsuUU3xwuWn3Secbbvk+vzsSUCqFkvFzVNwDtgCnCJfV+LT+SeBd6tw5IMlRcKPpFBIbClS2m54oTbiVd3Z8KCSeGEbxi4TzoyxABWzO/zRAtf+38Xy/w1xwWe73EIUEGDx2iRQ7xUH5JyEsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nawEo1OBnBo4eBKMenPiFrYnygC0V3+oQf4mpXyN4Hw=;
 b=U3fAdlmyvvNxYXXC7b29Hn1N5wGIkRNryCivrGtVXDHNLUYpd7ynLpIFOwB6o0OjFrfALUbn3f/aLI72kLf74avVMgHbaUS995/Pyv0gRSWGo2CNSy9LTecsP0719pvaTlKKAokKPO/+CNj08pXqyhZPQa/Dgd3ErUnJCOf9DI0oPvG5Dp3Puu0YMizUxXuSICXFKAYx6v1dPp9nBFuUsm6LSLksTmxw/JlN/cjAJJ+MazGGL5g4B0HL3m+DKrwkKBlUtIqQe4vbh8INLVV7OtNVMIWuqcd2yDC+o+GALTUJIV3hg5VnhJv/mzlydx+v7B6CPDJsn4+QS2jfIfpyKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AM9PR04MB8146.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 04:43:22 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1%6]) with mapi id 15.20.6977.017; Tue, 7 Nov 2023
 04:43:21 +0000
Date: Tue, 7 Nov 2023 12:43:05 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH bpf-next] bpf, tnums: add bitwise-not helper
Message-ID: <ZUnAWUhks4UQwz_D@u94a>
References: <20231106021119.10455-1-shung-hsi.yu@suse.com>
 <CAEf4BzZABSe-kbFzrO=9umVriJO=PSwCtw3nxt0PdS3Ltq4gmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZABSe-kbFzrO=9umVriJO=PSwCtw3nxt0PdS3Ltq4gmw@mail.gmail.com>
X-ClientProxiedBy: TYAPR01CA0077.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::17) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AM9PR04MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed5c39d-451e-4b66-4999-08dbdf4c11ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1M+n4Neob4WOgzxGFozmPAASlUL7eJkKafG2NMbnMEpahBJae0E3H9boOjgJYU9eoAnT3DDZiv7Seg4qFNxOrsaNkzU6afQufdMIGQ9HQ6yet2YQb07gzwpyeQZtpWv85ECyBiqwV2oVaZb6eDBWhRt8VOhDXpxJj82tOVXVZ2bHj0X7mmfBJcpeKdYvJYwHfcwHO0/2u3sY/gkAV94wH13dVciGEsKiv8UZCtOYvOEvBeAc+z+fy8mami+oEVA8gNKXrZi81S4sMbJBofjESnsjbsgta2xPu2tDSoqIqCejL9fGSYS9I6shz1l46GrH9RuTkgS1ZzVUgjuDazcAHXvsPdtzAXisHhq5+INm4uKPY1AZQ6Z5UegQTQKzNNTHOUUWfdmKAXeubhClJbUknNpQcNltvqbLstq1mcgNMq4RnzeowoujfGUZnq60xzY/Oh6YzFsOrxhlLs1zzN0qh/n8v/DcyIZgO2KFMz6sloi+LfQxKEWIFsu6iDG8nM/fvrUowN8ba9RHHAKyGRRaAM2D8CTx5TMs9ZqssUhvHts=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(39860400002)(366004)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(53546011)(966005)(6512007)(38100700002)(6486002)(478600001)(9686003)(6666004)(54906003)(6916009)(316002)(83380400001)(66556008)(66946007)(26005)(66476007)(4326008)(8676002)(8936002)(7416002)(86362001)(41300700001)(2906002)(33716001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MExRV25nYVpoSzl6ZVNyTEd0c1N0Q2prMHJCM00rUkJKQnhSMzJxVy9ydCtB?=
 =?utf-8?B?MXZtbVNaQ3pEZGZPOEtZKzJqek56MUYzUndOQ3NwcmtEUVcvaXNzQ1Nsd3JR?=
 =?utf-8?B?STlJclplc2Rqamw5dmdwMi90eUxhc1d4WC9sc3VVVUFhdkJ2TW5Mdmo5V1Na?=
 =?utf-8?B?Ukc5dXBwZmVLM3cyVzR6akxFZGNuTEtERVZ5cFQySUNOL0hoZjVPNnZIcGxL?=
 =?utf-8?B?ZWEweUxPZERNWWNkM2lOc2U5V1hKamduOTRHN09mY0JFSFErcjRUdGF0RWtB?=
 =?utf-8?B?ZnV4cFg5UUVWeTdRUXNMSnVjdlliSWFWWWl0OUthQUtPZHFsMkNHV2x1YUFo?=
 =?utf-8?B?N1FUNnVUc0pmWEZXTEtjSmRHNWZoNzRjNm5mQ1A2Uk1pOXhMbmxpQm9Ic1pF?=
 =?utf-8?B?aU9IQlJyaFNYWlcvS1UwTW9jMDFFV3ZaSjAxMjFGRnpQWUNVS1NTdFlaTmJj?=
 =?utf-8?B?bmNnTXEwSHFRS0ladnpVdXBDUjc1WmxVT1JLRmppOUhKMkRIR01wVGtvYzVr?=
 =?utf-8?B?c2UrLzQ3T3VSSzFaR09DdnZVcXdPdG1jMUNjb0h0bXQ0cnY1bk0zd1VSd1BH?=
 =?utf-8?B?ZktYaTdDQXc2bDRNU205VXp2OXRYNnhOZ0M0ZGpkVWNMZ2tabWI1RWM0SEJB?=
 =?utf-8?B?V011MUdtMWw5TEhjZVhDdVphQ2RyM3ZtMHdLaXJaZTkza3NnNEhvR2djcjc0?=
 =?utf-8?B?TGdjNXJLWXlBbVJuSkF1NW1zTVJITVBKUi9jVkcyZnFoZlExanAzOWp0enBQ?=
 =?utf-8?B?U3poNytBUUhTNURacEhSbXVQblB5a09yR0w3SFhCLzREMHlzU3BvcE80bUp3?=
 =?utf-8?B?bE9zZiszTUxUa1h4NmlhWkJZV1NBK01QaGpNaVNrTDlVUnZzcGE2eFFZTDh2?=
 =?utf-8?B?K0poMStiajNmMnoxQ3VPaXgzUWN2UjNwL05iNWhvaVlDd1JoYU4zcnB1VjMr?=
 =?utf-8?B?dGthUm1UK1A5QVVCSzUrUi9GdFZKYXNieUkyYVgvODhBS2h2cXlWck10cHZ6?=
 =?utf-8?B?d0s2MWtTM2lGeGtMZ2MyTUNFTERjenBVUlpod3BrNnJNQUtQaWl3OTBZV3Js?=
 =?utf-8?B?WUoybjNrOHh0Y2lKQVg0Sm5xamNBbFBFTVEyMXgyMms4UlFueGc3R3JnVE14?=
 =?utf-8?B?ZXpWNTlnZTZVcy9iUDJ6N0FqOE9SendSV3lidUJWUTVjcnRwUXJ4Qk9SeTky?=
 =?utf-8?B?cHpRSnNVMGRKT2VOd3ZUcjhSdUV2b2ZncFFTMUVJeGwxa1BMVlFRK0N1c2Mx?=
 =?utf-8?B?V2wxbldudFJxc1ZaSEQ1NmtOZ0ZDSTBZa1lYVHRkWXZ4WHRzNHJrTHFNYkJq?=
 =?utf-8?B?eFRaSEtPVlZFWjI1b3lENCtQUWxkbkFFZDB3MmpyZ3M1MWpFS1ROYy91czZ3?=
 =?utf-8?B?L1pxRk52U29jb1VFR0l5VjdjZ3FyZGtUMTVTeFBIV05WWk9SS21FaFg3V1VB?=
 =?utf-8?B?UnhUM1NxZ3U4YjNSUTRHekozUEtUZFdpeEhReURDOW5CMmlQVlp1TEp1OG8w?=
 =?utf-8?B?WHNNZ2x1TnJkMjBvSkhXSHdRQ2RDTVdtbW5lNGdHTXRmTHVRRDJ2NzlZV3Ax?=
 =?utf-8?B?TGQrYmh2ZDdVR0lQdE40WFdueWxpYVR1SFpCTU95cldEZWxnaHlwalQ4Um5i?=
 =?utf-8?B?SStjdm1QdUVWTzUzU0lDb2JUaFlxR2xmbUZVdFRRQys5VEtLWlFkdFBlcnpT?=
 =?utf-8?B?Q3dMNWMyYkg5SmVheWVtVFRjQVp2MUFWVG1FZFk3dXhuY0VPciszcFdudFFa?=
 =?utf-8?B?RVRNSTFBZlRhazkxVHBvVkkvZGpGcEdtOEdoU0h0NkZUYUJwZUpTM1lpdEo5?=
 =?utf-8?B?bVlFclYzV01qd1R5aHZjdE9UcEJYZ3p6QWM4NGE1c01FZENMSDZ5L0F3bXB6?=
 =?utf-8?B?WW9uUlpMeXNrVy9aTDVaUDZtK3Jwb2xROTZIM2RpY3J1NEpSRTlLV25NZEpw?=
 =?utf-8?B?YXN2Zm8rL3hVbGdUL1JWVnB0K0YwT1dBcUgzRFNoUElQSytVMDRiSXhBb2hk?=
 =?utf-8?B?OWhVaVRyTmVGcUFqdm1XT2RtdmN1Y1NLWUdGYWJSV29wOGhNVmIxYVdqeXE2?=
 =?utf-8?B?T2lDRTJzampRSTg3TGtwUHNJRGI3dHBaNzEvcW5Jd3VFbHZINHpWNGlVMDJ2?=
 =?utf-8?Q?hhnd2cut+jRaGwLG33zXZT0mo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed5c39d-451e-4b66-4999-08dbdf4c11ca
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 04:43:21.4249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FKdVJl+WOcjZo2ZXqAlpE0Y9xcZDbTdJAwnKy4zayv8F93EZXZzz5K2Pa6E4MUD/vQ3fX/s3mdZ4VpPXgPO9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8146

On Mon, Nov 06, 2023 at 11:56:22AM -0800, Andrii Nakryiko wrote:
> On Sun, Nov 5, 2023 at 6:11 PM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > Note: Andrii' patch mentioned in the Link tag isn't merge yet, I'll
> >       resend this along with the proposed refactoring once it is merged.
> >       For now, sending the patch as RFC for feedback and review.
> >
> > While the BPF instruction set does not contain a bitwise-NOT
> > instruction, the verifier may still need to compute the bitwise-NOT
> > result for the value tracked in the register. One such case reference in
> > the link below is
> >
> >         u64 val;
> >         val = reg_const_value(reg2, is_jmp32);
> >         tnum_ops(..., tnum_const(~val);
> >
> > Where the value is extract of out tnum, operated with bitwise-NOT, then
> > simply turned back into tnum again; plus it has the limitation of only
> > working on constant. This commit adds the tnum_not() helper that compute
> > the bitwise-NOT result for all the values tracked within the tnum, that
> > allow us to simplify the above code to
> >
> >         tnum_ops(..., tnum_not(reg2->var_off));
> >
> > without being limited to constant, and is general enough to be reused
> > and composed with other tnum operations.
> >
> > Link: https://lore.kernel.org/bpf/ZUSwQtfjCsKpbWcL@u94a/
> > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > ---

[...]

> > diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> > index 3d7127f439a1..b4f4a4beb0c9 100644
> > --- a/kernel/bpf/tnum.c
> > +++ b/kernel/bpf/tnum.c
> > @@ -111,6 +111,11 @@ struct tnum tnum_xor(struct tnum a, struct tnum b)
> >         return TNUM(v & ~mu, mu);
> >  }
> >
> > +struct tnum tnum_not(struct tnum a)
> > +{
> > +       return TNUM(~a.value & ~a.mask, a.mask);
> > +}
> > +
> 
> In isolation this does look like it's implementing the tnum version of
> ~x, so I have no objections to this. But I'm not sure it actually
> simplifies anything in my patches. But let's see, once it lands,
> please send a follow up applying this tnum_not().

Okay, will send once it lands.

[...]

