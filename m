Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760D96E7C15
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 16:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjDSOPs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 10:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjDSOPa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 10:15:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DF117918;
        Wed, 19 Apr 2023 07:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUNxl3JpiJs8oziT9sHTBPraDLbw6hyMJYZRJx2HaTBW/z/2QUNdiMpQ96nR3lXoRjAC5BgKNvzfoeim2z6BnzIFewX7QjMU3/B55mt5qAEaKDybN9njrNNVStrjvAUoJn4C8dK5bAgUW403pqBXMPBqkbwOi7NplC5quJ8RFIzRFIz5EbHfp+g24MO6mV7Li82YG/Ip/6I8UhBk9kVuOHRpJ5ZTxqzlLx1AA6n8S9/vJXHol6ZjbjFoPQRJxN2LGKfWWPF1ecrigakmMPBqzIJyl3ZJ7nsv2iD5OAsZVSkiek22aZY2aFjer/qEhXq5FYa/CQIvJMpnrnmCrqjHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmYGcJi/ivHXMWjXa6gcuKF3+bHWHhyH4ebYmtpgXtY=;
 b=hzVKsSXcK3Ys0SorXlKwyZt7Ma0N6bNXF4BYSYeI9cCX6h7352RcyhceoHQlvBf+c8VF+Sbb6NqA2BW9nKl8uqunmFhPuMQEGxniRHnW3bElU+GyMOJhmLaO29UXpak1O8Q7/99IMlnLjiVUQenqKFS7RyJkFByRF8p7KDWLRuBDn14tnWUdC+b2fc/D5HlX8zXKbkWALUtEs8NEP41rW6Lfr43cjuVkSgatC2WAxvqDfXHCF86Wo7TzzmWLRj80YfDk7knRUC5SibQ6TIKMDuWW9vwVkXUVXvu+dJSlssF+4AWW2MbZnW50ZfvF1fZnW7pEPPpwu5UqYZ858M4LtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmYGcJi/ivHXMWjXa6gcuKF3+bHWHhyH4ebYmtpgXtY=;
 b=xIyzIqUHzDC8/AQ3qohz/9VSCfoF2FyIRkfkxkehKcfkGZKV65lwIkI/xg3tqz7V6qTxICbbGBoFXJ/M0xgfhEvlKJyPe75XqoCvzWgTMW4Q6XkbWnOXxB8/velAIXyA6ncC6aH49Hb3vJzcdTWOm194kHehFpa3ZLTSZxCoBjSDBuIGWfAf8vPqVbaiRlKG2vpIC4AJGqDbwDzJJQHmhQzkqNnurJb4dRe39/yqX9cH9OtmH6+A5h49pGSV9YBnzcvnJp7JXBikRMA91+suRfF3u5ucTXpjIqVCK8FV+LgyoWiymSFo2Vqb6A0tEai9MjmRTINkTz9LhA0yJKZtlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AS4PR04MB9690.eurprd04.prod.outlook.com (2603:10a6:20b:4fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 14:14:21 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::e4c4:247e:4a08:7ed2]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::e4c4:247e:4a08:7ed2%2]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 14:14:21 +0000
Date:   Wed, 19 Apr 2023 22:14:06 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>,
        Mahe Tardy <mahe.tardy@gmail.com>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
Message-ID: <ZD/3Ll7UPucyOYkk@syu-laptop.lan>
References: <ZDfKBPXDQxH8HeX9@syu-laptop>
 <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
 <20230414095007.GF63923@kunlun.suse.cz>
 <b933fad3-7759-00d4-94cb-f20dd363b794@isovalent.com>
 <20230414161520.GJ63923@kunlun.suse.cz>
 <CAEf4Bzaw6DBHn=S9zKCXTSh7jW8xL9K6bzi1Q-e8j93thi2hmg@mail.gmail.com>
 <20230418112454.GA15906@kitsune.suse.cz>
 <CAEf4BzZf50fX7T9k47u+9YQrMbSLxLeA1qWwrdWToCZkMhynjg@mail.gmail.com>
 <20230418174132.GE15906@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418174132.GE15906@kitsune.suse.cz>
X-ClientProxiedBy: TYCP286CA0099.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::17) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AS4PR04MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cdbf60e-a89c-4e06-3f89-08db40e05ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ohvOX1QlO6d4LPatiO+z2j1GTkt4L5+jsvw9mqtg632M3aiXiShUulnztIETGtWFKYIS7+M41wlvjeVPgY2iI8SeLUy68qMcRBWE9haLDz/NJ7FpVRX9s19Dt+5zIJbiXv+ju/+BTVqW1UyXY+uc34Oe05CaiBwQ9a5mpPdzB3vpokUCJEZ1XGJSOE3xGbCpW7NR2wq1IbDUI35232sPETYqv3p7GlOMNs1YOljDnagKQDEtb7ohsh94LjW/ziGOpe7ul31LXpCMsS6oA3P+Dea83dVLrZV9hryB87QYJkMLonbLAyMvzFUGpS/pPG0BHE1Dt3HDml+wJqvNspxMdnvnI8ACzU2AEw/aFm/SMhyp+ufDiRBOc4dZF5ANx3whXuHYH38cXTtK+bLq1iWCDjVUxxSjdCsTeVqzNnyOC8MfSMZVsiN8gifV81kHDgfhuxAAlE4sWYKhK0mb+vizB15l49MIjLlkgTekms/FynUsgkeDZeK1M34bLKswLPkJ8gJyryT/1VYGBqS/IZgcnEfSU3yQ3z1PLrdCEBEiKqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(66899021)(2906002)(478600001)(6666004)(86362001)(966005)(26005)(53546011)(6512007)(6506007)(9686003)(6486002)(36756003)(186003)(41300700001)(54906003)(38100700002)(8676002)(8936002)(4326008)(66556008)(66476007)(66574015)(83380400001)(66946007)(316002)(6916009)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3l3di9TbjBiNTg5eFYzeUJMR2gyY1BLSFhzMW5KOFBXSVJpNmsxUGFzb1U1?=
 =?utf-8?B?dFBLUDd1ZTlIdFk4bHZucWNvUm9NZ0hXLy9oM1J0cGRnRGVKTEhSSEZjSXFl?=
 =?utf-8?B?UFJ4WHgxRnZvSWloeTBIUXR0N1NCaDdnNzA4TlNJa0x1ZEN5eG1sVG5waTRD?=
 =?utf-8?B?dUt2NTFlUUN5STcwMmhQVkNhV1ZqOG1vdld1SjVuMGQyRVI1dGdXT01LYmho?=
 =?utf-8?B?RmNsZTR4Q2lEcmthelRRNU90VTN1TW9uRUJ5b2hxUEdNUytDUGlJKy8wNlNl?=
 =?utf-8?B?d0wxS202WjFPbk5QbHVEU0YvaFh2WEhpa1JxOFlIK2g5UXRSQ1VmZGhlQUV0?=
 =?utf-8?B?cmxqeUJtTnR5bEhRek1Yc2VvY1pacUk4dGpQQm5ubk45L0JXNzh6OVRJZnJ2?=
 =?utf-8?B?YVUyNzc5UmFLcmpLZmZ2dWo2NmNQYWJlTmJqaHgzd0JrRVJCUVZWSnM1STVZ?=
 =?utf-8?B?eXVyY0gyWjJZOHFURE8yOWlEZktNVFJ4enFyeVc1NzZvcm5Ra0c4dFBqN1Vn?=
 =?utf-8?B?ajVSaFBzN2l2dC80WVR0SFYvWVdVRnJtZEtZQ0VLa0ZlNWdmT2YzUHlkcVNm?=
 =?utf-8?B?eWVER2ZrdFVwZ3g5YjJXT3pnZWU5OUNBVDk3SjVUU2xkMlRvVjNqMUpmNnNT?=
 =?utf-8?B?K3FHdVZQQ1BCcVpKb0JVMkxzZUhZREJ5V1JGUzIxbHp5QUxHNDNCZ0NoRys2?=
 =?utf-8?B?ano5UXFpM3VENkhhcG5OamttVFpNcHVmWnUwVWFUL3lYT3BjRzErU2JoNmk0?=
 =?utf-8?B?SDFyZlB3WEcyWEk2bmlsdkRjNkppdDRNMlNEc1pmSjBkRmkvSlZJblFCN3R6?=
 =?utf-8?B?V3U1eGZLSExsR0ZUOGRrQklYcGVaV3JTRjdHZ2RjVzFXMjFVNDV2TzVjejZB?=
 =?utf-8?B?bVFtbC9CUTVvdVlPcEd3Z2pVVU9MV05SaHhaQjM0UThnWWlWekI5M05KN3BL?=
 =?utf-8?B?Wjkyc1NEVjM0eXlTelFRNkc3UDZSYjBuYm5RVFZrRUFTZmZuQndrYTJ1RllN?=
 =?utf-8?B?cHR1cUI4bE9hTkZzUDNIUVM3aVZaeTRxd2VIYzVRVjNsc2ttUVFFSFREUGdj?=
 =?utf-8?B?OXpRTVY0S2tqbzlnc2RobXpveFlmcjl5ZUxVcVV1MlJObjB0U1ZPeGtyTC8x?=
 =?utf-8?B?dU15UW1uMStQMUNZRFRXSHZJMGlYU0lYWi8rSzBTb3NsNmFWS0dKcWd2aGFE?=
 =?utf-8?B?OWhzM3p6VFJGRk8rdW1UZkhvUnhSSTE3bGtudzdGc3RJOHRUS1JQVUgydUM0?=
 =?utf-8?B?QmFkeTdEZ0hwN294R2VTRVJvaHl0N3RzaVpWZU12MExhcnFvSFV3aW84aElH?=
 =?utf-8?B?c1NqWFZUWU45UEhISXNZamFoNU50TUtrUWhmdEZwOXpaTEpUaUZNYWg4NlpM?=
 =?utf-8?B?TFJ6aThneENFK0hVK093SlRZRDZyeU9EdUw0VXB3ZUtkUjI3NXV6b1Z4UG8y?=
 =?utf-8?B?ODlzVVlWbmdVcytndVE4TXRsbXNYVDVNRTE5WXdjZVZray9pVFVMdGFYdEhX?=
 =?utf-8?B?ODdWbUltZCtSYVBpR3FLRTFIUjMrak9DZERtMDgzOUlqS2R4TVIzZzFzS05t?=
 =?utf-8?B?SVQyei9vSDVxeGNrdnIzbHRjbjYrbzRHNlNvbEtkTmNvQ1plelRpR3J4aFRh?=
 =?utf-8?B?SU5YUVl0Wkk5YURUWEZkOTBMcVU1K1J1TlV2VnU3MVFsY2FaTHZGYmJXdEla?=
 =?utf-8?B?SktaTkZDSlVmbFJDOUg0RjZCQnFXTW03WXYwWWtDaHc2aDBNanJHeU9mKzUv?=
 =?utf-8?B?TGNoNGNuYm0zMWd0ZG15Tlp6Wk9UL0VQdWIxTE1MTVhZZjFoV3pVRGdFendH?=
 =?utf-8?B?S3NOQy9xOUIvWkdNcTVZY2Y0RVNuUmpPdHUweEFibXhTSEU1NkVDaGpKbWkz?=
 =?utf-8?B?SmRMd1pvZlBGU2dhcnZQcTdaVW9BZk1Rbk1WNEVKWEJxQkFsWjQ0d3RlQlNu?=
 =?utf-8?B?a09QUndCcDJsNWtIZERJK1JjUCtiR1JPd0ZOTEFuMWtxenpiVnErT0dLcUZN?=
 =?utf-8?B?dlJoUVJYUnJ2RXprd0JsWWRFZ3loRXlPdmc3Nm9SaW5ocE1qV2wwNVhuUzFj?=
 =?utf-8?B?NGRtYzRld21PRzhrRkQxMUJiTmRZRCtpcVVpRFk5Q1U0QVkxeUJoSnR6c3Bv?=
 =?utf-8?Q?kgjvAOKSq/AgNQpk8mKbQ6DrS?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdbf60e-a89c-4e06-3f89-08db40e05ecd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 14:14:21.4590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7Og6cQKpvB1OZ1ZNK5wXFfr/U7e24+koy5kzT3G5NlDCdjLpWvuEDMsfG7CtuA/GTWoNGb4jcV+8zTQbDvDGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9690
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 18, 2023 at 07:41:32PM +0200, Michal Suchánek wrote:
> On Tue, Apr 18, 2023 at 09:38:20AM -0700, Andrii Nakryiko wrote:
> > On Tue, Apr 18, 2023 at 4:24 AM Michal Suchánek <msuchanek@suse.de> wrote:
> > >
> > > On Mon, Apr 17, 2023 at 05:20:03PM -0700, Andrii Nakryiko wrote:
> > > > On Fri, Apr 14, 2023 at 9:15 AM Michal Suchánek <msuchanek@suse.de> wrote:
> > > > > On Fri, Apr 14, 2023 at 01:30:02PM +0100, Quentin Monnet wrote:
> > > > > > 2023-04-14 11:50 UTC+0200 ~ Michal Suchánek <msuchanek@suse.de>
> > > > > > > Hello,
> > > > > > >
> > > > > > > On Fri, Apr 14, 2023 at 01:35:20AM +0100, Quentin Monnet wrote:
> > > > > > >> Hi Shung-Hsi,
> > > > > > >>
> > > > > > >> On Thu, 13 Apr 2023 at 10:23, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > > > > > >>>
> > > > > > >>> Hi,
> > > > > > >>>
> > > > > > >>> I'm considering switch to bpftool's mirror on GitHub for packaging (instead
> > > > > > >>> of using the source found in kernel), but realize that it should goes
> > > > > > >>> hand-in-hand with how libbpf is packaged, which eventually leads these
> > > > > > >>> questions:
> > > > > > >>>
> > > > > > >>>   What is the suggested approach for packaging bpftool and libbpf?
> > > > > > >>>   Which source is preferred, GitHub or kernel?
> > > > > > >>
> > > > > > >> As you can see from the previous discussions, the suggested approach
> > > > > > >> would be to package from the GitHub mirror, with libbpf and bpftool in
> > > > > > >> sync.
> > > > > > >>
> > > > > > >> My main argument for the mirror is that it keeps things simpler, and
> > > > > > >> there's no need to deal with the rest of the kernel sources for these
> > > > > > >> packages. Download from the mirrors, build, ship. But then I have
> > > > > > >> limited experience at packaging for distros, and I can understand
> > > > > > >> Toke's point of view, too. So ultimately, the call is yours.
> > > > > > >
> > > > > > > Things get only ever more complex when submodules are involved.
> > > > > >
> > > > > > I understand the generic pain points from your other email. But could
> > > > > > you be more specific for the case of bpftool? It's not like we're
> > > > > > shipping all lib dependencies as submodules. Sync-ups are specifically
> > > > > > aligned to the same commit used to sync the libbpf mirror, so that it's
> > > > > > pretty much as if we had the right version of the library shipped in the
> > > > > > repository - only, it's one --recurse-submodules away.
> > > > >
> > > > > It's so in every project that uses submodules. Except git does not
> > > > > recurse into submodules by default, you have to fix it up by hand.
> > > > > Forges don't support submodules so you will not get the submodule when
> > > > > downloading the project archive, and won't see it the the project tree.
> > > >
> > > > git submodule update --init --recursive didn't work?
> > >
> > > That's one part of the manual fixup.
> > >
> > > The other part is after each git operation that could possibly cause the
> > > submodules to go out of sync, basically any operation that changes the
> > > checked-out commit.
> > >
> > > Of course, you can make some shell aliases that append whatever submodule
> > > chicanery to whatever git command you might issue, and tell everyone
> > > else to do that, and then it will work in that one shell, and not in any
> > > other shell nor any tool that invokes git directly.
> > 
> > Are we discussing a *standard* Git submodule feature and argue that
> > because it might be cumbersome or unfamiliar to some engineers that
> > projects should avoid using Git submodules?
> 
> As far as I am aware they are unfamiliar to *most* engineers, and for
> good reasons.
> 
> > For one, I don't have any special aliases for dealing with Git
> > submodules and it works fine. If I jump between branches or tags which
> > update Git submodule reference, I do above `git submodule update
> > --init --recursive` explicitly if I see that Git status shows
> > out-of-sync Git submodule state. If I want to update a Git submodule,
> > I update the submodule's Git repo, and then git add it in the repo
> > that uses this submodule. I haven't run into any other issues with
> > this.
> 
> You know, git could just handle submodules automagically. As you say,
> it's not rocket science. For historical reasons it does not.
> 
> With that working with submodules is cumbersome, and it's additional
> thing that can break down that the engineer needs to be constantly aware
> of increasing the mental overhead of working with such projects.
> 
> It may not be much of a problem for people who work with such projects
> daily but not everyone does. Those who don't need to do the mental
> switch whenever submodules are encountered, and are prone to getting
> issues when they forget that they have to go that extra mile for this
> specific project.

For me it's less about having to go through the extra loop. It's that
submodules would require git to be installed, network access, which all adds
extra moving parts compared to a tarball...

> > > > > After previous experience with submodules I did not even try, I just
> > > > > patched the makefile to use system libbpf before attempting anything
> > > > > else.
> > > >
> > > > Quentin mentioned that he's packaging (or will package) libbpf sources
> > > > as part of bpftool release on Github. I've been this for other
> > > > libbpf-using tools as well, and it works pretty well (at least for
> > > > Fedora and ArchLinux). E.g., srcs-full-* archives for veristat ([0])

and having libbpf included in bpftool release means the complain above no
longer holds. Though I have yet test build the mirror version of libbpf and
bpftool like Michal has done.

> > > > By switching up actual libbpf used to compile with bpftool, you are
> > > > potentially introducing subtle problems that your users will be quite
> > > > unhappy about, if they run into them. Let's work together to make it
> > > > easier for you to package bpftool properly. We can't switch bpftool to
> > > > reliably use system-wide libbpf (either static or shared, doesn't
> > > > matter) because of dependency on internal functionality.
> > > >
> > > >
> > > >   [0] https://github.com/libbpf/veristat/releases/tag/v0.1
> > >
> > > So how many copies of libbpf do I need for having a CO-RE toolchain?
> > 
> > What do you mean by "CO-RE toolchain"? bpftool, veristat, retsnoop,
> > etc are tools. The fact they are using statically linked libbpf
> > through Git submodule is irrelevant to end users. You need one libbpf
> > in the system (for those who link dynamically against libbpf), the
> > rest are just tools.
> > 
> > >
> > > Will different tools have different view of the kernel because they each
> > > use different private copy of libbpf with different features?
> > 
> > That's up to tools, not libbpf. You are over pivoting on libbpf here.
> > There is one view of the kernel, it depends on what features the
> > kernel supports. If the tool requires some specific functionality of
> > libbpf, it will update its Git submodule reference to get a version of
> > libbpf that provides that feature. That's the point, an
> > application/tool is in control of what kind of features it gets from
> > libbpf.

Since libbpf has a stable API & ABI, is it theoretically possible for
bpftool, veristat, retsnoop, etc. all share the same version of libbpf?

What I'd like to do it build libbpf and bpftool out of bpftool GitHub
mirror's release tarball (w/ submodule included, which exists now for
snapshot). For the rest of the tool that does not depends on libbpf private
function, have them dynamically link to the libbpf built from bpftool's
source, just like how libelf is dynamically linked.

I'm not saying that those tools should not have libbpf as submodule; as
submodule do look useful. But for packaging I really would like to have the
option of choosing the exact version of libbpf being used.

> > > When there is a bug in libbpf how many places need to be patched to fix
> > > it?
> > 
> > That's up to tools, again. If the bug is affecting them, they should
> > cut a new version of their *tool*, using a patched version of libbpf
> > from Github. If it doesn't affect them, then it doesn't matter *to
> > them*.
> 
> I don't share your optimism about this happening in the real world.
> 
> For one the issue that the github tarballs do not contain the submodule
> and thus cannot be built was raised nearly two months ago, and while a
> test snapshot that does include the submodule is released, a release
> does not exist yet.
> 
> For people to make use of the repository without a release cut they need
> to replicate that submodule support - that is add support for submodules
> in their development tooling. Otherwise you personally cutting a release
> becomes a single point of failure.
> 
> Because there is no API it's not really advisable to just apply patches
> on top of the last release either. Applying patches may cause the main
> project and the submodule to go out of sync, the submodule would not get
> updated by applying a patch to the main project, and the other way
> around.
> 
> Suppose a severe security bug that requires patching libbpf is found.
> Now there is a number of tools that are each tied to one specific
> version of libbpf, and cannot be upgraded to up-to-date fixed version
> because that would break them. I would hope that never happens.
> Nonetheless, libbpf is used to generate code, and if the code is
> generated wrong worst case it can have severe security implications.
> 
> Thanks
> 
> Michal
