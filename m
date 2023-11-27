Return-Path: <bpf+bounces-15896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6FF7F9DF8
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 11:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32141C20D23
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 10:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3673518C15;
	Mon, 27 Nov 2023 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="wQWuJIDL"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665E1AA
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 02:55:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBWmrz0ScwHKYgDUGvm2NzBgIi8tIqwzYStOPoRdfPi8ipO+M3FBJEw2jPdOalpXquQnViuXSMC8IvSR+LFpuPKGcVmHKmEp99RaNlbvBa8sF3/gCRVPsDwrOg+wrv8FzHvhd/ycZApKArOa8dt8TlVSqaxtpgjaMR/NB2fThs/+Lx42z8Ym1kZOCARdAR+9PrqCcvNwydVwn9Bszw4BoakNpcENtOVvOY6W1Zc199CExWnk3AZyXv6XKxp13DeGgLKInZAvQ2CsmwuXkANbU8hvEWPe0UZw8JTdLjwNRX4WiH/ZGcNBGlCMR0CO81DZ7Ll2PkSO6YX8KD4yLZHeXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpuE5FAx98t4XwyZmUGZ2CTVq2Ux4zcXr2U5N+m2o5g=;
 b=Icb4DV8u9lOzr6ZF9x9UTDw4biivceOYdRToRxlaxRilM6Yy4gpy8Gk44S7Di1dqvSpsrgw4LsBDnp8kGV/cDFOlbU4Fsg1NmnmD5Qy2YtbcHD2b6DUoASu+ecTzQDLS72XMVB1J7zgbza+fBaj+drEShIFlTIwJ3IkCvtcalpugOHDAYIKaR8dFbuQOFgbFf/c+9LaMhaAs8dsanZK59YcFENhZdGkWyh/YuEU3sKXQ/8um1Ia+H3x/irFWkeYTJxpK20Y7P9r/qRPupivaNgDqdE4d0qAAePph+kdh219LXWZWfEhmu7CKLTnjHvbMrsDf8mJERrFXRVOAajAK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpuE5FAx98t4XwyZmUGZ2CTVq2Ux4zcXr2U5N+m2o5g=;
 b=wQWuJIDLA11HxDUR8HuDkXYoo47+hrJYNnczSdDS1x62+h6A0elKusxEZAJ3pzj41JD8pA1gILw4mGuonGIEwbi3kQHEkyZiTbOaERwCG9nh9pJyCjiJjVBIC0/KRI4Uw+ekWe9g/wr3g4bm01bnDZKMYymlMetrlimHmGjrTbJAYS8icr3cLY1wfvblebNDcuSg08/Zn1d9LGlOS7NY/xcTAYtS6BqMtNezfi/jeztW1Up5RiVM+ajk+ebQ5f8nVmKN1ayZRke4Ab6swMXTFwZIkpDo4iv89U7hDrFfFttZdkEi+tNVQjCh4QHFrkvaZh9NcqAwkaDqVsdOBFuHwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by DB8PR04MB7099.eurprd04.prod.outlook.com (2603:10a6:10:12b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Mon, 27 Nov
 2023 10:55:53 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%7]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 10:55:52 +0000
Date: Mon, 27 Nov 2023 18:55:38 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 04/10] bpf: enforce exact retval range on
 subprog/callback exit
Message-ID: <4x5xpjxbcd4srv66flcaopgegpwfpir45qompzsuiubtyk265k@ycg57nu6o5cw>
References: <20231122011656.1105943-1-andrii@kernel.org>
 <20231122011656.1105943-5-andrii@kernel.org>
 <a6edebc8d7063836c7d031d86a3c43f2dd0f49bd.camel@gmail.com>
 <CAEf4BzaXazY88jiLgwdrnOw2OgSREfuTp5sAfs_-0FyumQB4BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaXazY88jiLgwdrnOw2OgSREfuTp5sAfs_-0FyumQB4BQ@mail.gmail.com>
X-ClientProxiedBy: TYWPR01CA0011.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::16) To AS8PR04MB8660.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|DB8PR04MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: de6bb324-d166-45a6-d67b-08dbef376c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eIOHkGAqT/nCOwk0WjtcCsr2EMLuOGfBLgXS+cghLqpCSZi04xUJgCIw/a1rOQVQAZARs8vs4S3ToaKx3w8xTVF9Qlf+PUtmrLcOQdSedTeO3BvMkzO+HWDdYc/E/N8iR7UJVDNrbLQ8uMTUCYTlTfIZVAsA9CHI5ezEAQEr1AFCEcEOAwnNjJrhE083PKcdafsPIoO0GSF4Rfs1kWm4qYfm3yT3Q2cVmvDKPQVQLhHZ3IcOJkw8/6WQctDrzstNN64dgyVkeptUH9l+rnPEd8OLsGEUCNzblUUZ1Bn0rIqH/D4GT+q3BiY2B7KWTQurkF/X62OxwFl5X/sfwtfBpKB3p89cn2v0/8Kyi2IxyAMsmDWR8utS69eW0mK+fYJJe9Alz3pqPkK/UPLC3iftT4FuNbcBAkU0wMGQl7Vaj+OAQGeitPWOdR4RihGJeZhIuC5ZhoPytIkZnP6BLBeWEJtc+yP0HDNl8I8lrACF+iQ37JzaR0NFfEay8h9ikX4nXJUHrIS4wIO2wFuxBXD5pd/6QrzhVgDHtIDoLMIPTBc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(366004)(136003)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6506007)(6666004)(6512007)(9686003)(8936002)(4326008)(8676002)(53546011)(5660300002)(86362001)(478600001)(6486002)(66946007)(66556008)(316002)(966005)(6916009)(54906003)(66476007)(38100700002)(83380400001)(41300700001)(2906002)(4001150100001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkdKVVd2Mkp2ek5qL004UkUrZDVSbGI0OWJMcnRoYUh2N3p2RExHZ2dHWm1B?=
 =?utf-8?B?djBMaHFCdlZTeFA4a2JBaEJQV3hqbWkra1AwamtRemRBS1hLWUxzWGNVdXlS?=
 =?utf-8?B?c2JVS2JhVDlrU2oxVDRTc2FDSUF4cWpCaHlycnUxdlJJa0t3a3gvK3N2eFJz?=
 =?utf-8?B?TjVadkU1QjR6WFczbkc4dncwTUFDbmxrUFlJZjJWbThFL0dQcnJmamMyOVoy?=
 =?utf-8?B?MFZhMHhKTXRGLzV4TFE0ZWdJL1dNNjZPVktBcDB3OEZIUXcvSklsTGpVYmYy?=
 =?utf-8?B?Z29qK0dUeVpPTVA0YjhLYjY1dHpmc0hDSngxUHVEcDd0TUdKS3FnSFN6dWQx?=
 =?utf-8?B?cDNpWWwvV3hsR1hqSExVUU9UbklUOGlpNStTbHQ5cnZhSnZkaTdsZ092MElV?=
 =?utf-8?B?SDFnRFhZek5zaElwVGJUcTh6WkJyd2xpM3lWOWNnOWNZQnFKTFFhNy81czBh?=
 =?utf-8?B?cVJZMmJmUGpLQi9sV3VEd2pETDM3Tm9sVm91VCtjZFRtbDZCOHJXMDhkZy9L?=
 =?utf-8?B?YWNGeVk2Q09rcUk2aXl5QUtiV2w2N1Nnd0tpcjNXci9VOThlbURObGFsZHkx?=
 =?utf-8?B?UE1CN1RhaVlLY2lacGtrRERMSmw2Y3NzZGNhZ1BpanRYaUVIYVY1KzMxejZQ?=
 =?utf-8?B?Q3F5KzhQTU9LdFlqUnJXcHRRR1NRL0ttTG9UZG8yWmdRZ1ZnVDdCUEJUVFpT?=
 =?utf-8?B?N1RvK3MyME16Y3hRdFV5dEZ1U0pVUFllNW5jZTJSRGE5Yk5rSEptZ2R4VW5P?=
 =?utf-8?B?ZHJhL2k1RUNvbllTZ01pcmN0QlZLY1g3Y3ZXMjJwWWhYcDhTOXk1RllpeHhS?=
 =?utf-8?B?OXlHSFVWcGs5T1JjVWhiV00xZUZId0YzQzh5ZnJoMHd4K2gvZWRQenVHOVhq?=
 =?utf-8?B?SnBYNWFFRUFnRDJpYm5UUFNmZm1WMjZleUFQdzBQNDhDMXFWcjBENjJMbEpW?=
 =?utf-8?B?VVJuUndqNkJUNGlQekZLcFd0UDR2azllVHJScERjTUZiTHhaN0tNSmdsbytz?=
 =?utf-8?B?MnBCR3VwNUt1UU5BM01ScFhoZ21KakpZc2hZU29RU1FSR2E4Y0VLa2NSbCtN?=
 =?utf-8?B?UXloV1JkWENYS0tuUlVQVHdrRmhnbUFlWjd4QnZKQi82dEtKMDY4Tk5GZ0RX?=
 =?utf-8?B?UnFsdzBsVXIrcjkxR3ZOQkpYdUNsWFRoSUdQN0ZRVGc1N3FyRk9kZ1h3TGxa?=
 =?utf-8?B?ZTlUTlY1cks0VGlDQ1pTTXF2SmJuQWpxZ0YzTHIzd2NrdlozOWFGY1dWNFlW?=
 =?utf-8?B?VUJxa29LOWdKZ3Y3YU5ZYTRZQ2RhdDlxYnhISVpJdUJBdlEzVEpNbERiV3BJ?=
 =?utf-8?B?d3ZkT3JiM2o1UkNJeUlxdmRaSjJLVEdZZS9Hb2h5aGVEeDBKcVBkcUVRZDhu?=
 =?utf-8?B?czA1ZDM0Q0ZKMC9iSXYxK1o3NnJxd1pBU0RpTEZud3RLZ0ZuSlBCN2dLSEdx?=
 =?utf-8?B?RS9Cb1d6enR6R1JNdS9ITDd4UTBiUGFzYWd1M1ZpMml2c2VxL0FleDBhdEFX?=
 =?utf-8?B?S3phODB6TFRaQ3UyNG9zVWF3Tm9PVHk1WHp3SUV1Yjh2S1lYTldPb25wZjN0?=
 =?utf-8?B?Y3hWalJ2bTMyL1BocTlwaEUwSStsRFdDUkRJc1BGTzdXVkpvWXFkQlhRMXFT?=
 =?utf-8?B?VVpoSGh4Q25hSDNkVTJIVHFlWWI4dFZmSm1nZUZjZlpsQ3FqZlZWejFqc3JT?=
 =?utf-8?B?a0hjYlhibTRJS1luM0tlWUNOS0VjbmZUV0JkdEZYdU1YRnNLalFYSGQ0NnJY?=
 =?utf-8?B?RFdWMW81cC9LZFBIYTdYTVFnbnJNM3pveElNSTZqK1FEQVI0NWV6YjdGd09R?=
 =?utf-8?B?OG1xNjkzTlgyV0ppbDliWVBHTyt5L05BUnFBSnA3NHBBYjB5K2lJSWdZWjR0?=
 =?utf-8?B?dVNKSmpNMk5CY3Noc20yQVdVQkphckMrTjZtNXNSOE1wSlhzUEpkOVZSSkth?=
 =?utf-8?B?cWJlQTcyRlFvbXdRNjh1T1hyU3ZVbG10VHQ1Z2UxeUVvR1ZlZ0ZGcEpxajA1?=
 =?utf-8?B?T0ZtelBLUmVrWWVLVkVQLzJPVDh5MW03dUgvcVZ6MDdjK0JmSmthbzgvalRM?=
 =?utf-8?B?RmtNN3lLTkFvbG12Q3pqK0FiWGl3Yzk2S2dNbU5CNlIrbUhSUHNEejJzN04z?=
 =?utf-8?B?RStOU2lzV3JOV25VSFIxQnZ3U1BEZkc3eVEwSEFFTVFsYzlpM0pMOU5ydmZk?=
 =?utf-8?B?a21USEdxWXJsYjlnaGx4RjFzYUppNG9vRmE2djh4T1pJTnM3VVF4S3ZCcWYr?=
 =?utf-8?B?U3RBZVA5ei9WTDNoMjRrVjdwUzZ3PT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6bb324-d166-45a6-d67b-08dbef376c91
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 10:55:52.8856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZ2/QHjiYED49Ey376+Tm8DDnOPkGToSoC3u8e1o39gPSZGrJ6jQFSvim/ysi67CZ2iyjMxvHnd8r+744AtqnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7099

On Wed, Nov 22, 2023 at 09:45:27AM -0800, Andrii Nakryiko wrote:
> On Wed, Nov 22, 2023 at 7:13 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > On Tue, 2023-11-21 at 17:16 -0800, Andrii Nakryiko wrote:
> > > Instead of relying on potentially imprecise tnum representation of
> > > expected return value range for callbacks and subprogs, validate that
> > > both tnum and umin/umax range satisfy exact expected range of return
> > > values.
> > >
> > > E.g., if callback would need to return [0, 2] range, tnum can't
> > > represent this precisely and instead will allow [0, 3] range. By
> > > additionally checking umin/umax range, we can make sure that
> > > subprog/callback indeed returns only valid [0, 2] range.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > (but please see a question below)
> >
> > [...]
> >
> > > +static bool retval_range_within(struct bpf_retval_range range, const struct bpf_reg_state *reg)
> > > +{
> > > +     struct tnum trange = retval_range_as_tnum(range);
> > > +
> > > +     if (!tnum_in(trange, reg->var_off))
> > > +             return false;
> >
> > Q: When is it necessary to do this check?
> >    I tried commenting it and test_{verifier,progs} still pass.
> >    Are there situations when umin/umax change is not sufficient?
> 
> I believe not. But we still check tnum in check_cond_jmp_op, for
> example, so I decided to keep it to not have to argue and prove why
> it's ok to ditch tnum.

Semi-related proof[1] from awhile back :)

> Generally speaking, I think tnum is useful in only one use case:
> checking (un)aligned memory accesses. This is the only representation
> that can make sure we have lower 2-3 bits as zero to prove that memory
> access is 4- or 8-byte aligned.
> 
> Other than this, I think ranges are more precise and easier to work with.

Agree with the above.

I'd vote for ditching tnum for the retval check here. With umin/umax
check in place there really isn't a need for an additional tnum check at
all. Keeping it probably does more harm (in the form of confusion) than
good.

1: https://lore.kernel.org/bpf/20220831031907.16133-3-shung-hsi.yu@suse.com/

> But I'm not ready to go on the quest to eliminate tnum usage everywhere :)
> 
> > > +
> > > +     return range.minval <= reg->umin_value && reg->umax_value <= range.maxval;
> > > +}
> > > +
> >
> > [...]

