Return-Path: <bpf+bounces-14859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CE77E88FB
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 04:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0111F20F7A
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABE863AD;
	Sat, 11 Nov 2023 03:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G/GqUCma"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A888C29A8
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 03:45:42 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17E52591
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 19:45:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2hkCpb5NscS5f6ysESrLOrohziqK3MPswBAwDVvWmPdY3dqdMDaKRHwy4nhRs+VuYDsR3cjkkmDeZpS4osdZs47iklnvusiubp48LU7wsRNhkF2TGj7/MioxoAO0lsQZcvll/5itUZltcfxhv2yQgxwOYTOMUM/Z0TRTmgS7QdKxYeiRaQrAUdzf0mbbjVPisLqOI5XfvNK608SwMnme0qUfm2/emflDul4s83tt0KxKXv2+DVvA26q023IZ8lxrEZVohT6JL2IVL8k/ZkPjURtt35Srxsa9T+TiqoY1hq3YqBDPb/a9r0k0myQB57o8/bsLBV2LzfauBmnWHexqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdpooYwh6LsHEG0OHgPjFwHxyDElBSbYOyeZGMqMp4A=;
 b=Knh5emtGqBBpTgWKcn+uELwUr1hcULd/ywxMYgaiE+fo/9e25al64OrdcUelInsPf79WcwDpbHtos6cz/JeyCvsFEBz8cKJMQIZoWdVvYgM7tNHggpEkzzEpuL84MEpXlxGTlskYePRsU4CiCPjCAwOp6Wk8TZDxOvCfHlPd2Qlw4vzNCM2K9S2Yos6+JK10m8mUqwFSLoez4abFMHbIOX67/GvowCWCYAqqbp8Oy1AZBttC7HdcxlAYmIxGf5mOrVujRXBaRFvJyi/llC2Rculx1Fjv5YIBP4jAhiaYet6mlELNfSrbUb1xTBGTUQMqVNC8COB+docq0w+lwN4cfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdpooYwh6LsHEG0OHgPjFwHxyDElBSbYOyeZGMqMp4A=;
 b=G/GqUCmaGMNM4Vf31pRZRhzk+tq9VTCjkFBKu1QnQkc6FtkGEOtNg40HEnaG2AQNvi1HZnS9D9TD2oL4iBbA10BPIsnPnHmBGgj3qC6425e5PUM4PkLxZVgLIRjmyY/S2suEDoRsUydEZ0OuCS2d1mwEruZV5RNRsfK71gJWe4EssYGzC/PMYWrVDfMJNuSC8NYUY6JFpeUPFWis8g8dgzskfTjuDmnG2xKVSyUv4eHy4DDATG6NENwXz+HFu8iJ7gQ2rpIe2G4LZ6UDLTPiUcEO86bRQbLGdEjs6aplhkwUwHQK6hXxww1o/jJMfsq4iDjsfYFbcAWh7sMejWIbCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by AS8PR04MB8804.eurprd04.prod.outlook.com (2603:10a6:20b:42f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.12; Sat, 11 Nov
 2023 03:45:35 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%6]) with mapi id 15.20.7002.010; Sat, 11 Nov 2023
 03:45:35 +0000
Date: Sat, 11 Nov 2023 11:45:22 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Paul Chaignon <paul@isovalent.com>
Subject: Re: [RFC bpf-next v0 0/7] Unifying signed and unsigned min/max
 tracking
Message-ID: <ZU74vP8US-QnwHrK@u94a>
References: <20231108054611.19531-1-shung-hsi.yu@suse.com>
 <CAADnVQLRjj7nQg02BAzToDOZvtk6P9f5UN010Nyb2negcPzoWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLRjj7nQg02BAzToDOZvtk6P9f5UN010Nyb2negcPzoWQ@mail.gmail.com>
X-ClientProxiedBy: TY2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:404:a6::21) To AS8PR04MB8660.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|AS8PR04MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 42bd4548-68f1-472d-4550-08dbe268a98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P3i0RhayWgJCE5EJBhmZXtnqMSA0rKCCMx4Z5hTPcYwayqwzHnkShCZyV9pi21HoRNqmvh6ioTj646fGQJq5GlcHm5RSkSsRnL3NGz0e+AqrkPTbr4yUBGC4H/G2XpuYKe+TH2yV0L4cnqoL+xZc/gDVpybsu655nei4v3Pmie6ELgFLLxAKhW49D4ZhWVlFGiA8VPiIGIniZNSxjpsJW1E2J7+OxHhVtSJgOMlMsr4DDz/AnKXbieg9Jtv3hOPrpqjwGNt9QKjQwfYSJRVYAVwdOLHeLPUgUXHdhCriU8mvMUvrpPO9kF6phr0UobgymZkfU00cKG5ovOK11OPXXUVAACFCTSXBG05CwYaoaexxeyrtg0WIJ0s8iGHAvvPi2YtT3+3+usjjitm2KMPs/QLGu/hWnwxoikzo80XbSxFQDI1ix1uUJYL95Dr0QoQXmr9NHlYXo+g30LNCsBunl8pMvzdrD/WC0m3nefmO48eVZkXV8X+i0Ox7Po7rihvDiiYD+ns+cABusy3p38vuYDrkwQAteELXFIDdY1BH6kFIQsWaX0NjMdUnbOdhPZGoK4hACRqXckKwOvNBogAC6Hs/WU+/WwPLCD5eWWBFO4Er/SCYrlvhjhKzUkDJBQ93
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(38100700002)(316002)(6916009)(66946007)(26005)(54906003)(66476007)(66556008)(33716001)(6506007)(86362001)(6666004)(6512007)(9686003)(5660300002)(8676002)(4326008)(53546011)(8936002)(6486002)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG1FZGZCdFo3SjcyNFVpZHhDMUdoT0hPN0kxM0NYRGYwVzJKaEVEb01obURI?=
 =?utf-8?B?T0F1dGQ5bXRhdFdXL1B0dWtvZXlWaFc2YVNsSVh0UnNGUEprTFMxaXdtOUdD?=
 =?utf-8?B?NmZZU0lOWmtBTjU3enhpOVEzbmtRUXljTWlvOEhCZjlLK1FQMnlIYWowVXMw?=
 =?utf-8?B?cnV5SGNMZDUvWkJVYmFyOTJMNW9rM3FVeHYvQW5mZHRjYnVXRS9SazdrUUp0?=
 =?utf-8?B?M2hWWUdMbkxLOUlDK2FudWJySUllZGxhc3JQSFJwWklWd3VEaDc4UFRJZys5?=
 =?utf-8?B?dmN5UWRIRW5GQ0E3bmFMQVliTjlTTkJ1VGY0QVRJUTJ3d0QwNWlZRFBkbnJH?=
 =?utf-8?B?NC9JWWxFdTBzYlVwcXozMTkwVzlpOUQ3MlhpVXVIMENVY2tWYkp0SUd5SWJS?=
 =?utf-8?B?OHUrNTRpeXZyZVl5cXZWZTJSU2JqL3pEcGlDTlpUVkMzWWVSREZoK29FcGta?=
 =?utf-8?B?Q2huamtsQlJ5Z0FTRUNjZi9OWmk3eVUreGQzZ2Jmem15LzU5enI0UW5USnVk?=
 =?utf-8?B?OVBWcUtxTjdPekZOR2FiZUhvRGlXcE9iNzluRXpCcVkwRnJHa1RxMmJDYzF2?=
 =?utf-8?B?Y0tOakEzK3FZWEs5NWc3UHdtZkF0K0dmOFMwQlJneEpGdENjeFYrSmRmZ1Ax?=
 =?utf-8?B?dnhwenpSUUh2ajM0elEzMG94NVVLdmFKY2dGbFNDb0l6L0M5NFdMUnlWbDQ5?=
 =?utf-8?B?Ym53akRHREYvb253TE1TMFRKbUxJeVpJUTZRNWdGNU5kTGsxSWRrZHhQbHBS?=
 =?utf-8?B?SFE4eURHWWEycTZMdEFEaVZqcTYyeXhBZEI4VkZWRzhLdTI1OXhZTXVDMUZ6?=
 =?utf-8?B?dWtocEFHdzBZR3pLOXVmYkc2MG9qNndNdERIRWlrY0d3VDV4Rm54QnI2VUMr?=
 =?utf-8?B?TGdRL0V5b3ZSRERiWmFTRk4rSHdZclBISE9USXVqYmpsTGhITk0vWmlhNFhO?=
 =?utf-8?B?QUNaaHlobUI1L3lJMGtJN21pcS9RNUVzN3I1dHhPMGZlL1NqWGdJTFV0ZUFD?=
 =?utf-8?B?MmtqNGsyM1BqVFNtN2VoOUVOcThBR3JsNzFsZXo0M1pVRWNNK1NvMEMzK3hF?=
 =?utf-8?B?ek52ajdRVktRZ2NpRnJRd20yYjZ1T3Q5aW5peklNMkZ1RFR6a3k3MmFVeWUw?=
 =?utf-8?B?L2VtWDg1amI4R1lTanFMQVUwUmVvbTdKdm8xYkN6cWgzSlhzYmlSZmVJWGFM?=
 =?utf-8?B?ODlmS05YNncyL1ZJQVlwUGc5S0ZhNXVUVnduNFpXZSt3MTI0VXhwbStSNDhJ?=
 =?utf-8?B?L0p2WUhFVU1uZjZMdHh0dm16a3Q5VGFRUmRQWWZuNlViMmNMS0puVU1uZ1Zq?=
 =?utf-8?B?NnJaNjYxVGg4cGFsM0ZEZmlPMnN2WnJRdUNRa0pNaXFscGRXdHZDNmpSNlVG?=
 =?utf-8?B?S05teGpYenE5R2tIbTZxUzcrczltQzJYblZLQWRwMjZrZzJQck1QWVBpWFBx?=
 =?utf-8?B?K2RybHk5dFRlcGpHQzc3ZW53WkluWm85bGlQK0ZOUXFkSGZiRGR4bEhsUzR4?=
 =?utf-8?B?N1pGcGU2eG5KNkdZVzVCOG1PZzFrWUhLdGtkOHZZc0ZmaW9Dd1Mydi9lR2RD?=
 =?utf-8?B?WnlCL01oZ091NVVQVW1BcW5qWlFIVmo1Tzg1WHZCTWFBdDBOd2djU3pjL2dM?=
 =?utf-8?B?WE9CazQwMWxTVUwxVXR2cWUzbm4waC9ic1ZkUzhFeUpTdEpPOXNxK1EvN3dK?=
 =?utf-8?B?ay81cnAyTXlDZ2FWczR4bUpLajJ6eGdQeHQvNmRYckI4Tkx4Q2RlUE96T293?=
 =?utf-8?B?ZEpVdW1kVzErNU5TNVAramc1bU1iUGgzRkk2azlrb3FUSER6TXJOb21sSjh5?=
 =?utf-8?B?cC8vRktwbWpCWDNYWXdRR2gzK1gvTVVESkUzSFJITTBwWFIxakxjRklkcXhv?=
 =?utf-8?B?eWFocjRiNDFLMHcwUmhrY3Y1c1dpbzBGUWFOSTY0YmNRWFNacndqWVNqUEg0?=
 =?utf-8?B?VjlhSmlBYlpCT0M1RVNnVlRPc2I2clBsdittUDZ0bVdaeU1JTDFvcGJmbkZX?=
 =?utf-8?B?cTU4ck5PRlRMQ2Z6Q1B2Z2dDL3lNWTRQNTJpZ01rdDRDdnJkYzdjd0dIaTJ0?=
 =?utf-8?B?NGYxYUFTa1dLNU5taFYrVjQrakhoT0ZrR1lTTm9RaUt4YXZHcWZpTnR6R1ZI?=
 =?utf-8?Q?VGlgjHPtmdxnVZCBJnYS1qJEG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bd4548-68f1-472d-4550-08dbe268a98f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2023 03:45:35.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dc9ppwmAZaGENR0k2ZZO7m9TzGlehaRlxAD4TAFlGA3foju3s50zeUyD6yvodO2Bhvbp9uFiBDXq+XvztlXQUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8804

On Thu, Nov 09, 2023 at 11:38:09AM -0800, Alexei Starovoitov wrote:
> On Tue, Nov 7, 2023 at 9:46 PM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > This patchset is a proof of concept for previously discussed concept[1]
> > of unifying smin/smax with umin/uax for both the 32-bit and 64-bit
> > range[2] within bpf_reg_state. This will allow the verifier to track
> > both signed and unsiged ranges using just two u32 (for 32-bit range) or
> > u64 (for 64-bit range), instead four as we currently do.
> >
> > The size reduction we gain from this probably isn't very significant.
> > The main benefit is in lowering of code _complexity_. The verifier
> > currently employs 5 value tracking mechanisms, two for 64-bit range, two
> > for 32-bit range, and one tnum that tracks individual bits. Exchanging
> > knowledge between all the bound tracking mechanisms requires a
> > (theoretical) 20-way synchronization[3]; with signed and unsigned
> > unification the verifier will only need 3 value tracking mechanism,
> > cutting this down to a 6-way synchronization.
> >
> > The unification is possible from a theoretical standpoint[4] and there
> > exists implementation[5]. The challenge lies in implementing it inside
> > the verifier and making sure it fits well with all the logic we have in
> > place.
> >
> > To lower the difficulty, the unified min/max tracking is implemented in
> > isolation, and have it correctness checked using model checking. The
> > model checking code can be found in this patchset as well, but is not
> > meant to be merged since a better method already exists[6].
> >
> > So far I've managed to implement add/sub/mul operations for unified
> > min/max tracking, the next steps are:
> > - implement operation that can be used gain knowledge from conditional
> >   jump, e.g wrange32_intersect, wrange32_diff
> > - implement wrange32_from_min_max and wrange32_to_min_max so we can
> >   check whether this PoC works using current selftests
> > - implement operations for wrange64, the 64-bit counterpart of wrange32
> > - come up with how to exchange knowledge between wrange64 and wrange32
> >   (this is likely the most difficult part)
> > - think about how to integrate this work in a manageable manner
> 
> Thanks for taking a stab at it.
> The biggest question is how to integrate it without breaking anything.
> I suspect you might need to implement all alu and branch logic
> just to be able to run the tests.

Once the wrange32_{to,from}_min_max() helpers in patch 7 is implemented, I
should be able to swap out individual alu operation while keeping
bpf_reg_state untouched. E.g. for addition in 32-bit

  static void scalar32_min_max_add(struct bpf_reg_state *dst_reg,
                                   struct bpf_reg_state *src_reg)
  {
      struct wrange32 a = wrange32_from_min_max(dst_reg->smin, dst_reg->smax,
                                                dst_reg->umin, dst_reg->umax);
      struct wrange32 b = wrange32_from_min_max(src_reg->smin, src_reg->smax,
                                                src_reg->umin, src_reg->umax);
      
      wrange32_to_min_max(wrange32_add(a, b), &dst_reg->smin, &dst_reg->smax,
                          &dst_reg->umin, &dst_reg->umax);
  }

and get current tests to run on top of the new algorithm. This won't cover
every aspect, but should be enough as a first taste on how well (or unwell)
the integration will be.

These helpers also can help to create finer intermediate steps for smoother
integration; something that's added in the beginning to aid the transition,
but removed after the transition is done.

> It's difficult to see a path for partial/incremental addition.
> The concern is that at the end this approach might hit an issue
> which will make it infeasible.

Agree. While the helpers above can aid with integration, I do not see a safe
path for partial addition. At least not before everything until
reg_bound_sync() proofs to work should it be considered.
Still a long way to go.

> So it's a big bet. Might be nice correctness and memory saving or nothing.
> Certainly exciting, but proceed with caution.

Having enough optimism and attachment to tackle this but not too much to the
point of overlooking its flaws is certainly a challenging task.
Will try my best :)

Thanks for the feedbacks!

