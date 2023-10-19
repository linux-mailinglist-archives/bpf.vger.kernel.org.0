Return-Path: <bpf+bounces-12667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CD37CF017
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 08:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA201F223C1
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 06:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CB08C18;
	Thu, 19 Oct 2023 06:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WoS9WVZF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF408F54;
	Thu, 19 Oct 2023 06:30:06 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAF7BE;
	Wed, 18 Oct 2023 23:30:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COUmDmDWBXhsFWoJZEut54JIA3xAKINWG3se6Uyn6ex2Hb6rEOJfM9i9z3UVVl20YcQy0sbfonE1DJbfceZzXQU81+1BWwhvZOZ6AcuvnXf6EbMA/AaSoxz0V42gLLV7UAAXGm4GVyQNuSd1u9JvzyMFKoSv1pOZctkx0kI/8dHdlneGANyb2FChmSpmQqAZtrCrpFNVU4AFBcYU3moq4KZNkecvOsOz/DwO0iC/Gsv/ss2RtMmCaAebcf0eHuSCWpc6Pu/HEpJNNVaugOXeSGjxccx19ZEuuto6wNCdeXfyZjnXTQOGnFncx/L1gHv/HZ/G5C5T0gUP35H57ghEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZxj8oQmPox297DV5VycbP1JaphezX81E1qPpoYP1N8=;
 b=KEAYK85J8pCwrsxSevcGJmqsbAhzO4F0Ueh8BRPk43JOdsRrdbEuRT+uM8cUReZWQ67H4t4ihAbKkRKAUC9wNtBOKpC//DV8Ga0Ph0q7fhmif9qgBZgUx8Abh26oQbmKlgi07Wsk8uiQUz2khw/fBi2yOEQVTG025koT9pPew16oDCrZHW6/6bs0Htlpo5GBKjmVi2LhHfIXvhTp+sc+i5EoykhIPVjiN7xPTNA/lW58H/xA97+DDEZmv7vVbyMp3k/eIRF/XoMdx9nUSLTvcCsqHO3/+lIXxQa3eRw9hUXAcY1lILIw8FGnH9ZF8tY2YcvDzcqtphYN7mPfhi1jJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZxj8oQmPox297DV5VycbP1JaphezX81E1qPpoYP1N8=;
 b=WoS9WVZF9hxLeFSnCzQEQa7oV/YJYo6gbBU19RYC7Li/vPV1fWXTCpLSIeDB/tMQWwCvSck8hVKXovW4l67ZyRnhCh79hLG4PlubGlWSJuMtXyFZgQ/34fwGBW9yJrpvP1tvEpOwYIaSDMPcvJkBHdu1Asai64FEc6odRgcmLR1D6MMHXZGj9B9LoAw2Xn3KJaQAUscD0qXPMquuAfErM8DVBYG2Yiarlhd4TKnySR3xLFixJmr/19Z29f7fJohKZxsk7zvNxU22plK9S7+DO48VbBfCcCPN1oTlf7o5+KAksYAZs9ZnmrsQ57t5Lzbr+Bmud6uKp/ZOuBJA62mczA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by KL1PR06MB6985.apcprd06.prod.outlook.com (2603:1096:820:11a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 06:29:57 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503%4]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 06:29:57 +0000
Message-ID: <233c1c9b-963b-4129-b26d-f1f74c8595ad@vivo.com>
Date: Thu, 19 Oct 2023 14:29:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: multi-gen lru: fix stat count
To: Yu Zhao <yuzhao@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, bpf@vger.kernel.org, opensource.kernel@vivo.com
References: <20231018082104.3918770-1-link@vivo.com>
 <20231018082104.3918770-3-link@vivo.com>
 <CAOUHufbPiAhpvHuo=oH7Zhyoc0hR-6kpVrCEe-b0OuWYWne2=A@mail.gmail.com>
 <a2373558-920a-49b1-91ac-9b0a6a1468b2@vivo.com>
 <CAOUHufYiu-5wEkNnrt+HdnwHTZ+5FytqBB-j3nuHS5kgY+c3ew@mail.gmail.com>
From: Huan Yang <link@vivo.com>
In-Reply-To: <CAOUHufYiu-5wEkNnrt+HdnwHTZ+5FytqBB-j3nuHS5kgY+c3ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0192.apcprd04.prod.outlook.com
 (2603:1096:4:14::30) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|KL1PR06MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e6445b-13a0-45bb-ed53-08dbd06cd004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P3gFNUFN8Fb8L3xj6mW/hM5cqYX8vqycIW16A5wCFBVgdBqx7mBYsVU5lV9a86r7/i0lb8ZiWGJFuDSLkFzlwbroHkKhP+3x7d3w9W5JUTfGFzBloncCeL9eJbqUTrFioGRU5FsM90qgs/lpgozF3NHg5gluftZa8ECGKZAF9kbzHJZ6m6dFU6taoxOMIj6jbU6MpvG7dQl0BIeIUF9GE/tGfDFmhMcxceIhOeeJ09d3YE/SzB4l/HTvp4Oom69CzRVgL/AZ0qsIDASxNGCorTy7IFEE3eT52p0eWb0s/BWmCeXfs84UjyIqgFmTILhRL4vMCTOZnV+9ZgziEvih7y0DiAMzn72y8pJchEcNLXY0VdFYvwXt9ZzT9oM5uIuk3ZrsMnuwA86G/qmi4on3ZXFjGNTNrHNYPQPbrICWYI09axaPd7x1H1Nx1I91ZzHMyh1njO94RfACiedEp50dlaa881jUZjONHd3HMzED4XLfnPDyyDNyDaHBqmp+Loa/9GI1+F1wOKdaL6wD0fm69PfEWRK3CrA59Le1JzyMnbSXTfirR0/p04Zo5UnDrdu1IdXb/6f1r5BwZbBuouJ6mxE6htBovC3pT4hXu8ZMBEbIEc7YeiM4GX1R2gBiD+7Rh02hqORaHN/ZrUHxk02zOLmOb9kFld+8oyn+5n+5c8ysBorQTeXnZ7Y4RDBT0CRp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66899024)(5660300002)(4326008)(66946007)(54906003)(66476007)(8936002)(66556008)(316002)(6916009)(6666004)(8676002)(6486002)(478600001)(41300700001)(36756003)(31696002)(7416002)(2906002)(86362001)(38100700002)(52116002)(107886003)(2616005)(53546011)(6506007)(6512007)(83380400001)(26005)(38350700005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Lzk2dXZ0NStEcUlHNy9wUUtFUDc0SFVRdVZTNmFBbkh3SDRJMmlIM0tWZE1T?=
 =?utf-8?B?akxBbXl6QXk2TEJBWXdaVWNtMkpreExxM2RBVlBsS1I5SGVVOXNUek1mbkZj?=
 =?utf-8?B?MHdkTVBzdkRrUFlPYXVjeHp3bTlpckc0dmFTNTVTa0w1SWhZRWlWZUkvaWln?=
 =?utf-8?B?R0pBN2FOUTFlaGs1OG8zVEhmZzVqSld1aHZxeVNyVTk4WmsvdTlKa0F3ZEFP?=
 =?utf-8?B?MTRnbjBucit3QU1JeGVHYllQWjduNkxwNTRJZFVTcHlBSGl6UmVVNG1mVXk3?=
 =?utf-8?B?QXVqTnVFTU4yRVZaVk1zQXFsNm5YWTF0Y0lZbTlmYzg5VTFOZnZCeEt5ZzNv?=
 =?utf-8?B?d2Q0Y3NiRE9zWmw2R3V1eDVtNXljQ1lrN0o2dVBQSTBGWXBwekNFaWRNYndC?=
 =?utf-8?B?OVdkemxER3ZVcms5RHhFZ0x4d0VzSWp0d21tS0FxSi9WT2dLY2Izb1FFWHVI?=
 =?utf-8?B?Wk9YVEpZTVJKVHdCVldMZXJNdlVtNmNVd2R6cnR2VW9hQW5aUlRiOXArSVIz?=
 =?utf-8?B?MHh2dm13YjJ1Y1NaaDVYRnQ2aE9yekRWajl2VndmZmU2SkE1eXlyb3ZpcVlU?=
 =?utf-8?B?SDcvRDRZNTJRaFJaNzQ2OFNRcmhsMXQ5ZGg0MVN2RFRlRmRFMTdxSUVkSzVD?=
 =?utf-8?B?Q2JNM1k2VVQ4UHBzUFVwYUwwcjhuZThUV2lMTEV4SFpqU2hRS3ZZTzNHNlpY?=
 =?utf-8?B?eE4xMTJUaUo0M3M0aXYyQjJ4OStSdFl1bmZDemlJUHl5a1l4WS84WkRIMjlO?=
 =?utf-8?B?THQxMnFXOVhvRG85UUNhMGhUcGxPQlVvSXcyS2M3TEhKODNDV3lkcThxTFpn?=
 =?utf-8?B?ZTUyWG9rY1VMeGJ3RE5tZFdRNDk3aVZrdlNJSkFlMHBqN2V2MUtONHZxbWtn?=
 =?utf-8?B?ZUtyR1FpS1FqRzYzY3ZrOXliQmNTaDFOWmhQQ2Z3ckpLOGZSa0JXZ0FST1ds?=
 =?utf-8?B?Wi9SM1Nld2xIdGVPNzFRdVRWSHljMGtZNDEzZyt0M1YwSG5wRW1RNVhPb0ov?=
 =?utf-8?B?NzNkK0tDRnlFYWFNRUVyc3B1WFg3QWx2eDNMdExWVjVvNkxiYzMwWWtRZ0Iw?=
 =?utf-8?B?dEg2SmtXMW5QZjRjbzBZaWZYS2VsVlFINnZwaXFHeGI4YnJhRFMyVzRaSFh1?=
 =?utf-8?B?WFBUYVAvSGFlT2l0OXRudXU3N25NRjRkaGpDTTBHZ01zQzhiU091NmRNeExk?=
 =?utf-8?B?YzAzTnAwcUpXTWlBOUg4clpneFBDL1BKVXdkeUtmV29BQk5UbmtsOWlNeisx?=
 =?utf-8?B?LzhSTHE5b3RtWTlESk5kbHl1S2hNdFhnUkR5akNyRmNwY3FYNmlKRTQ0Wm1Q?=
 =?utf-8?B?endCV05PNTlabWxqTTJ0RUxZZS8vckxpSlRqZ3JUcUZvNWZZLzZxUjFqZitn?=
 =?utf-8?B?cEZBRDZrYSswTUpJRWtCREN5dWtTU3lDc1R6eHdib2k0N2lNQm1yRWdhdGFN?=
 =?utf-8?B?VnZVZTM2SFJPczhPc2xsejVJbDdzV25heGsvUHVHU0Z5M2J0bEUydi9OWC91?=
 =?utf-8?B?Vkd3ZnJXdTUwS1dUSm01UTZLNXVnZG9kOEJVMnJVUXBZQVc5V3g1MGVqNU4r?=
 =?utf-8?B?U01lVjdkamN3NDE2NVJZS1AwNWkrUVFUc1RzbEVPQWlMNDJ5MEhNR0RSeDNr?=
 =?utf-8?B?NWcrT255YlZoR1hIcWtyT0EvM3FUb1VvOXBNa0Z5ZHM1cUZiRGE3aXlTWjA4?=
 =?utf-8?B?blB0VG5ya2dCSWNmRVYxNWM1dXY0MGtOdWljdStBSTJacW9oa0hwKyt5T0ox?=
 =?utf-8?B?ZktCWkdXcWV1Yk1XTXVxUy9uMDFndnBPZ1lBemovZXM1SkdFdlVZbS9CSGli?=
 =?utf-8?B?cFdTZDF1ckkzRjlmeGVOYzlEV2NoQ1AxMEk5ZEVpOW9VejBocDNCeEw3dHA0?=
 =?utf-8?B?MHRkYmZwY3NWU2FMOU9EY2YzcUZRcGJLTlgwQkppVEdqRUg4cFVpTDFqRzA3?=
 =?utf-8?B?VnkzUU1VNHhtanh6SVBZVDBVWVZteG1MSUpDcnppbGUwcWRMbzJvL1Uzdkla?=
 =?utf-8?B?NGZxVllDNnkxd3pLditneU9DbTZDb1VaRzljR0l0NmRwY2dlV3FZcWxDbmNt?=
 =?utf-8?B?NmVINkFQZzI3U2htZWNNR3U3S1hGczlRNnBjTFlSQngwWXhqQnl3VlpoSERE?=
 =?utf-8?Q?TT7Fg3iya1ZiARL/gJBp1fkN5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e6445b-13a0-45bb-ed53-08dbd06cd004
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 06:29:57.0558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N88OmP0g95w0zPqvJz2Hr8ZaficMXvT/qnsC41D7Fk2uowGbMcxIm+64nLBQpwR/C7Y3oq5EZeCHQEePyuIfxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6985


在 2023/10/19 10:39, Yu Zhao 写道:
> On Wed, Oct 18, 2023 at 8:17 PM Huan Yang <link@vivo.com> wrote:
>> Hi Yu Zhao,
>>
>> Thanks for your reply.
>>
>> 在 2023/10/19 0:21, Yu Zhao 写道:
>>> On Wed, Oct 18, 2023 at 2:22 AM Huan Yang <link@vivo.com> wrote:
>>>> For multi-gen lru reclaim in evict_folios, like shrink_inactive_list,
>>>> gather folios which isolate to reclaim, and invoke shirnk_folio_list.
>>>>
>>>> But, when complete shrink, it not gather shrink reclaim stat into sc,
>>>> we can't get info like nr_dirty\congested in reclaim, and then
>>>> control writeback, dirty number and mark as LRUVEC_CONGESTED, or
>>>> just bpf trace shrink and get correct sc stat.
>>>>
>>>> This patch fix this by simple copy code from shrink_inactive_list when
>>>> end of shrink list.
>>> MGLRU doesn't try to write back dirt file pages in the reclaim path --
>>> it filters them out in sort_folio() and leaves them to the page
>> Nice to know this,  sort_folio() filters some folio indeed.
>> But, I want to know, if we touch some folio in shrink_folio_list(), may some
>> folio become dirty or writeback even if sort_folio() filter then?
> Good question: in that case MGLRU still doesn't try to write those
> folios back because isolate_folio() cleared PG_reclaim and
> shrink_folio_list() checks PG_reclaim:

Thank you too much. So, MGLRU have many diff between typic LRU reclaim.
So, why don't offer MGLRU a own shrink path to avoid so many check of folio?
And more think, it's nice to assign a anon/file reclaim hook into 
anon_vma/address_space?
(Each folio, have their own shrink path, don't try check path if it no 
need.)

>
> if (folio_test_dirty(folio)) {
> /*
> * Only kswapd can writeback filesystem folios
> * to avoid risk of stack overflow. But avoid
> * injecting inefficient single-folio I/O into
> * flusher writeback as much as possible: only
> * write folios when we've encountered many
> * dirty folios, and when we've already scanned
> * the rest of the LRU for clean folios and see
> * the same dirty folios again (with the reclaim
> * flag set).
> */
> if (folio_is_file_lru(folio) &&
>      (!current_is_kswapd() ||
>       !folio_test_reclaim(folio) ||
>       !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
Thanks

