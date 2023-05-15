Return-Path: <bpf+bounces-551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34087032F4
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 18:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A87F28142E
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 16:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501A6FBEB;
	Mon, 15 May 2023 16:31:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B17156C8
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 16:31:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2103.outbound.protection.outlook.com [40.107.237.103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2411810E7;
	Mon, 15 May 2023 09:31:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5kZis4l/ps3egJp7Bo7vGn8NAaxuwlgDEmPiEqKo8RR+x8EO1i7e3aYWeTsiU1kr5R/MiKt9Ni10NNuxuNsmC0eyKgE5z66DuV+zdZ5HfrV+5Y0J0/dpwMWW6aNlC8xHkUa3hmpalDgdjI/mlvFj0HA42LISY6LSjVMHVYXJpJNabTeSyfEYnNlVQexHIzKDAl+Cl4QcUm3w7RNp6HemyOOxPZbfk8KF3FNVmmy0n22YcqXhOna4MO7oJPVhqhIFqdVBLCfvhtJOArMMcVdyUKtsdHTVtu6vEfF0hd6PUS518rYQyBjQKpjcM8WRSy0LjROxMOnzDFGilNMAYhQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlJTcFBgXigsKPDNmDtdnbWmmH/BbHpWAD6Y99cAoKs=;
 b=Ec9L+LVAE5tmzC28JdLQ+oPa8KmvS+yPc/j4elmU+cRiGKZZQnvkwNez3zlreIrwCG8bcaDVfXklzAdQbu+D6qnKQ0z+pWOSDqWraBpaMr1DFk+ZjLJgfV4zeko3FhRE//39dLNfelK6nuDPLCE8SxqUqM3J93nm3VqtCRvgERg1v8lNGI758lYr7RIg0CsoGuZy/W4N7txVwJmVKov5LayRrgnRhibc40hufo1G0CSlYYiePyiLORcFAhh898JPNdQZKplMo+X1iUtD+PVuCR/kkPu/uHZquVATWynTWWTHBJ7LZVkFng9XAbWhxcGwGRO4z5xAQXK5s/Q/u1DmMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlJTcFBgXigsKPDNmDtdnbWmmH/BbHpWAD6Y99cAoKs=;
 b=T3s8EOusUf7zLGkLcZjDK9XcSvwqwAUam4GPIdyGum5Yw2kAzjzRV12mKzGSaP0zFnGX05rzhBkBCIBj+vVazye43t85eE5XyjU4Z58HIytP+42UOUhDdemoKphn/7rPLo2eAviETk/ec9VkX/s89Rdu7YrHBR/KCT20RnY24VE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BY3PR13MB4804.namprd13.prod.outlook.com (2603:10b6:a03:355::13)
 by BLAPR13MB4755.namprd13.prod.outlook.com (2603:10b6:208:330::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 16:31:06 +0000
Received: from BY3PR13MB4804.namprd13.prod.outlook.com
 ([fe80::8bfb:3fbb:241f:e41]) by BY3PR13MB4804.namprd13.prod.outlook.com
 ([fe80::8bfb:3fbb:241f:e41%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 16:31:05 +0000
Date: Mon, 15 May 2023 18:30:52 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@corigine.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Quentin Monnet <quentin@isovalent.com>,
	Stanislav Fomichev <sdf@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpftool: specify XDP Hints ifname when loading
 program
Message-ID: <ZGJePGCkfuCITRxn@oden.dyn.berto.se>
References: <20230511151345.7529-1-larysa.zaremba@intel.com>
 <dd7a4bec-c0d0-4ffe-3bb8-e4d7ab4a01b8@isovalent.com>
 <ZF5A752Z4eu8FAw9@lincoln>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZF5A752Z4eu8FAw9@lincoln>
X-ClientProxiedBy: GVYP280CA0048.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::17) To BY3PR13MB4804.namprd13.prod.outlook.com
 (2603:10b6:a03:355::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY3PR13MB4804:EE_|BLAPR13MB4755:EE_
X-MS-Office365-Filtering-Correlation-Id: a5dd2a06-b261-4df5-30a2-08db5561c7a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XdK76mwwFrmu3XPgX2wn9RiLh/VpLxhDVUSBgq3+tTwPuykNcrnoTQkdNmnP+5/jS0N1FHh2I4Ph5lBvcBl9pEamNpf1DR9syWrua35Hs+zBrQ4Li+vBn0qWgiCFDdiKKoNMqMicuOWPj7d2W+sk4Vbk8wQMrp/+Y1yN/0a626TxVi1+cjL8yY8LsTHU8Fl72LTvtrNns8e/k7+odNtAZGVrN5tte0iUg4eOpcuL81jLYqblPRn/wn8pT1LlJXkW+LrTo7M7g6z/KutA07pJcVOfPuWh2o5wCRyMiCT6UdoHfuSQU9BNmJatbKQaAShBDKMRUB/Z5kiSG18RYk95rxUJUUp5UMSfBId0HOpCaVx9sAzoELfBRmbLCYFrpSfppCXAiBSpAtzl/1LGuolwgTxJYBzoPwp3YIzteDVXLgBwjj+UCWLnTqrKhIJe51YNKrNDvxrVEVMzmXSe6j5vtgMkmb7eVbi2u6ga1Y0vw481fi6gyswr6kftq2g4OCBHiaFUZLVnnZ0ivaOKiXG3znVtfdNQ03lqPsxsNEevJtg4MdgzrD4xL0jfHqvWf6kjQVnW9Q44ncfbJu1NXRvXq3qaCjV0JglGPY5SUD2vMlAcpPddruOx+soZNrH7QEKK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR13MB4804.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(376002)(39840400004)(451199021)(38350700002)(38100700002)(66574015)(186003)(26005)(83380400001)(9686003)(53546011)(6512007)(2906002)(41300700001)(6506007)(5660300002)(8936002)(8676002)(7416002)(6486002)(478600001)(52116002)(966005)(6666004)(66556008)(66946007)(66476007)(4326008)(86362001)(6916009)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjZpY3FWVlA3NUdVUDVHNDFFdlFpT3daNk9FenVQVzlzMlBrN0Z1SzlNNmN4?=
 =?utf-8?B?WFd6RCs2ZTAxNHFwaUx0WE43VkNEa2pQOXZ3czR1WFE2eGhZNHVDQW1JOTZx?=
 =?utf-8?B?U0F5RlJZbnFrbGg0QTdJYnhEWXRzMEpnTnZGSFpid25CZlB6dndSZ1lrbFlx?=
 =?utf-8?B?STk2RFVBRTdqdW9QbUxjYWtDdFpXbnJBZ3prZGhFbkVXV1JRNDJGb2M4SjEz?=
 =?utf-8?B?MnRIYXBueHpZRUpYM29ZUHZCdGRmajdBekNnREhMM3BIU01aWG5uWWs0aGVp?=
 =?utf-8?B?NXI1Z0xCdGpGTjcvZVFWWmxxWHV0T0RkeFY4OGl2dkdpVW5UdVkzY3ZvQTN4?=
 =?utf-8?B?NWJRZmljckN1T0J4Z0REWlNyaExEaFF2K3BIazNTRXB1VWFQZk94c0haUFVo?=
 =?utf-8?B?TksxbWViOHZwOFdvWU4zNTJkQ04weVpwaVUxWFVwOFU0eFk1ZjR1eFRkSWo5?=
 =?utf-8?B?ZUZlUnIzVk8zQmh5Nlp4REtWL1dCeDR2emRlN0UyK3BybFBRbnZkTzlHYk5j?=
 =?utf-8?B?cjRhaUJ2WUtqUlhqZ3VDVEYvVzlWazZTUzc3MWJ0TTJQTFk3djQwM21rSXp3?=
 =?utf-8?B?MWN5emJjbFZYNGRoQkxQclFuWWZWUENCendPTURZeHg3aVI2WlJiUmo0VG0w?=
 =?utf-8?B?bzZ6VFE1Z3RsamdOeGJNZ1NsdXI5NHN0Yk42d3M1ODV6aTN3eGhrcXdOZHFr?=
 =?utf-8?B?VXU4eUxXdnBvNVlTVDJiNGhFbjVkTXRtZG8zSjRoWGJRZmZ1T1Ayalh6eXJV?=
 =?utf-8?B?Y2ZmNmdMbmRyNXVNZjk4U0VGNkhVSjBVMCtReE9OdFJhNDhtbUhBb0FUZ0l0?=
 =?utf-8?B?NVBtVkkzWjUvSWRSVHBUVFF4Y3NFdGJsQmhLWFcxbit4bVNXbW56Sk1TMHVh?=
 =?utf-8?B?eCtpNktkZTgzZ2M0MWJncGdiS1J0SFdzSFgxQnFuZU4weThiNENLeTUwZ1lW?=
 =?utf-8?B?SEJZSW04UVJ0RlRtK0VIdHZSUHQvOVYzVWpEQzBPQzZMYVppTVhsa2ZpaVU1?=
 =?utf-8?B?bmpMWUt0NzNzTnZ3elRaWDExMDd5QzVnbXpDNWJReFhjK1JPeXVPd2tydTBM?=
 =?utf-8?B?NHRVZmFhdEtZRTZVUDdwQmhCV0lFOWRTcmtkS3FUWk5tNmQxRlJxRkJTbVRD?=
 =?utf-8?B?MmU4bHMvTy85RTZDY3BYa2xNYURiSnJzUkd5M25SUnZmM1lCTkZuU1RnV1RY?=
 =?utf-8?B?TVNqbWJsbkJmZlRPNWIwWCs4Kzl6ZjlJYWtDKzFZV2kxbkNsMlVpTXROMlJY?=
 =?utf-8?B?Vi9tb1FFcFFxLytKNWJMQ3ZQbVBVWmlxS1Q1cXN5SXNyckEzbzErcXFuamd0?=
 =?utf-8?B?TUM5RkxreG5vYkV6NGVRZXZWTWVOM3JTcHJRTS9TL3BLand5akliMnB0SnlJ?=
 =?utf-8?B?ODBnVUpMdk8yV3h5c3pTQTZMM0srK0d3TlJnZGF6Zy9zY1BaL1EyTHhKRVNN?=
 =?utf-8?B?aGptVWQ2OHl4azhxN244RjM5eDV1ejhwbk53QVpHS2VOMytVMFhhWnZObXBG?=
 =?utf-8?B?aCsydmZ2Zm1MTkF0ZmVBZXZFa3h4VGhoa3hiK0NVVzF2ZWlJamxad1BYTDV1?=
 =?utf-8?B?cWh0TGUxVW9MZTIvVnBNTlF3d0NORi9pd0hhckRaQ3F5T0l4K20xUnMxVEhS?=
 =?utf-8?B?VTVQcjRUYmlWRVFBM0IwQUtSM1p2OGNtYkVuejlmVWdoMThpdlV5b1lPRTFo?=
 =?utf-8?B?NTBYVExxNlp1UWV6VG5VcHovRE41dUdiTzROVVQwd1kyd2xoQmVmeUlReEE5?=
 =?utf-8?B?dis3WHZSZ3RBdFJsVmV5M3A5NE9RSVFpNEJxeS9aZ0lOczRaZ0FnMmM3c0NJ?=
 =?utf-8?B?V2NtdXgzYlVqTjdOeEdBR0xYVmx4QzJPODRiekV2M2NJRjh1bWtoNUllWXlt?=
 =?utf-8?B?RldrcXJFcmdhTE1WTmF3KzU5ZXl6aFNWd1Nka0srZU1Cd2RBYjdPckpNQUtF?=
 =?utf-8?B?QWhNeUExajZVM1YyWXlBMUJiSUlFNVN2QURzTmVlK1dzeHJESy9OZ0NCbmtz?=
 =?utf-8?B?TndTRkY1V3hQY3NoMHhWNlZtRlRNS3E5c3pEWkNVQzhjcGRwK1c1YWFaSmY3?=
 =?utf-8?B?SCt2d0lNZ1NJMWxaMEVjWmdyem9UVDZLWDdMeUFnVVNqUjBZK2p4NkJNM0E5?=
 =?utf-8?B?d3RFNlFobXJ5clhDZ2hQY2dSZ1haQ1FDeXVFK2VOTlNNb1dMQTI1RlYyUlJP?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dd2a06-b261-4df5-30a2-08db5561c7a4
X-MS-Exchange-CrossTenant-AuthSource: BY3PR13MB4804.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 16:31:05.5872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4RkiGrXG+elY4C8DRK74RWwrbmgwlgq8ElykadaHBHzrlwxBjUL1UF6OOQq8oTK15Y6TGDsTRKiR+1idv1+mcGsCfOqaUeDwiFrcIQ2AGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4755
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-05-12 15:36:47 +0200, Larysa Zaremba wrote:
> [You don't often get email from larysa.zaremba@intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Fri, May 12, 2023 at 11:23:00AM +0100, Quentin Monnet wrote:
> > 2023-05-11 17:13 UTC+0200 ~ Larysa Zaremba <larysa.zaremba@intel.com>
> > > Add ability to specify a network interface used to resolve
> > > XDP Hints kfuncs when loading program through bpftool.
> > >
> > > Usage:
> > > bpftool prog load <bpf_obj_path> <pin_path> dev xdpmeta <ifname>
> >
> > Thanks for this patch!
> >
> > Regarding the command-line syntax, I'm not a big fan of the optional
> > sub-keyword for the device for XDP hints. I must admit I had not
> > anticipated other another use for the "dev" keyword. Instead, have you
> > considered one of the following:
> >
> > 1) Adding a different keyword ("xdpmeta_dev"?) and making it
> > incompatible with "dev"
> >
> > 2) Another alternative would be adding a sub-keyword for offload too:
> >
> >     bpftool p l [...] dev <[offload <ifname> | xdpmeta <ifname>]>
> >
> > If the ifname is provided with no sub-keyword, we would consider it for
> > offload for legacy support, possibly warn that the syntax is deprecated.
> >
> > What do you think?
> >
> 
> I think first option would look a little bit nicer, but I like the idea to
> deprecate "dev <ifname>". In my current version, forgetting to add "xdpmeta"
> resulted in not very descriptive errors, this may confuse new users. So what
> about:

I agree the first option looks a little bit nicer, but I think both 
options would work.

> 
> bpftool prog load [...] xdpmeta_dev/offload_dev <ifname>
> 
> "dev <ifname>" syntax would still work, but with a big warning, like this:
> 
>   'bpftool prog [...] dev <ifname>' syntax is deprecated. Going further, please
>   use 'offload_dev <ifname>' to offload program to device. For XDP hints
>   applications, use 'xdpmeta_dev <ifname>'.
> 
> > >
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > >  tools/bpf/bpftool/prog.c | 28 +++++++++++++++++++++-------
> > >  1 file changed, 21 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > > index 91b6075b2db3..a9cb96d99277 100644
> > > --- a/tools/bpf/bpftool/prog.c
> > > +++ b/tools/bpf/bpftool/prog.c
> > > @@ -1517,12 +1517,13 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
> > >     struct bpf_program *prog = NULL, *pos;
> > >     unsigned int old_map_fds = 0;
> > >     const char *pinmaps = NULL;
> > > +   __u32 offload_ifindex = 0;
> > >     bool auto_attach = false;
> > > +   __u32 meta_ifindex = 0;
> > >     struct bpf_object *obj;
> > >     struct bpf_map *map;
> > >     const char *pinfile;
> > >     unsigned int i, j;
> > > -   __u32 ifindex = 0;
> > >     const char *file;
> > >     int idx, err;
> > >
> > > @@ -1614,17 +1615,25 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
> > >                     map_replace[old_map_fds].fd = fd;
> > >                     old_map_fds++;
> > >             } else if (is_prefix(*argv, "dev")) {
> > > +                   __u32 *cur_ifindex;
> > > +
> > >                     NEXT_ARG();
> > >
> > > -                   if (ifindex) {
> > > -                           p_err("offload device already specified");
> > > +                   if (offload_ifindex || meta_ifindex) {
> > > +                           p_err("device already specified");
> >
> > I'd add a note to tell somehow that offload and XDP hints are mutually
> > exclusive. I suspect not all users understand these well.
> 
> Ok, will do.
> 
> >
> > >                             goto err_free_reuse_maps;
> > >                     }
> > > +                   if (is_prefix(*argv, "xdpmeta")) {
> > > +                           cur_ifindex = &meta_ifindex;
> > > +                           NEXT_ARG();
> > > +                   } else {
> > > +                           cur_ifindex = &offload_ifindex;
> > > +                   }
> > >                     if (!REQ_ARGS(1))
> > >                             goto err_free_reuse_maps;
> > >
> > > -                   ifindex = if_nametoindex(*argv);
> > > -                   if (!ifindex) {
> > > +                   *cur_ifindex = if_nametoindex(*argv);
> > > +                   if (!(*cur_ifindex)) {
> > >                             p_err("unrecognized netdevice '%s': %s",
> > >                                   *argv, strerror(errno));
> > >                             goto err_free_reuse_maps;
> > > @@ -1671,7 +1680,12 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
> > >                             goto err_close_obj;
> > >             }
> > >
> > > -           bpf_program__set_ifindex(pos, ifindex);
> > > +           if (prog_type == BPF_PROG_TYPE_XDP && meta_ifindex) {
> > > +                   bpf_program__set_flags(pos, BPF_F_XDP_DEV_BOUND_ONLY);
> > > +                   bpf_program__set_ifindex(pos, meta_ifindex);
> > > +           } else {
> > > +                   bpf_program__set_ifindex(pos, offload_ifindex);
> > > +           }
> > >             if (bpf_program__type(pos) != prog_type)
> > >                     bpf_program__set_type(pos, prog_type);
> > >             bpf_program__set_expected_attach_type(pos, expected_attach_type);
> > > @@ -1709,7 +1723,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
> > >     idx = 0;
> > >     bpf_object__for_each_map(map, obj) {
> > >             if (bpf_map__type(map) != BPF_MAP_TYPE_PERF_EVENT_ARRAY)
> > > -                   bpf_map__set_ifindex(map, ifindex);
> > > +                   bpf_map__set_ifindex(map, offload_ifindex);
> > >
> > >             if (j < old_map_fds && idx == map_replace[j].idx) {
> > >                     err = bpf_map__reuse_fd(map, map_replace[j++].fd);
> >
> > Could you please also update the following items:
> >
> > - The usage message for "bpftool prog load" near the end of prog.c
> >
> > - The related doc in Documentation/bpftool-prog.rst (command summary
> > near the top, and detailed description later in the doc)
> >
> > - Bash completion (for keyword "dev", look for "_sysfs_get_netdevs" in
> > bash-completion/bpftool). I'm happy to help with this one if necessary.
> 
> Will do all the above in v2.
> 
> >
> > Thanks,
> > Quentin

-- 
Kind Regards,
Niklas Söderlund

