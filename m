Return-Path: <bpf+bounces-12641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A4E7CEE0B
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 04:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF1D3B211D9
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 02:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16CAA49;
	Thu, 19 Oct 2023 02:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="i9Tg0BJQ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068797F0;
	Thu, 19 Oct 2023 02:25:02 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2112.outbound.protection.outlook.com [40.107.215.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53631AB;
	Wed, 18 Oct 2023 19:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNtWnBpkHmcyNRdl+5+sJs76pld3U+Abm9CoR0HhIjACWnZ1p+A04YA+uuBCuR74x1CHhXeCDeiJZvgZqtxY8xBGA3GKVAOkHU1ZG6glV+NTNC/uHQCaPcnymCe4Vzyw3/GwfgvrN2aCjXS0sYzhP7RKX/ApNfzJTlxzNvUl5fh4Iz5h3tCi8NdMYCq5rpdWQxIMLRJ3Im+/PA5jdFO0cxqfUv9PtiFvfEa/pj6kUfMWQwfH7ccH6FTqT0NkvXqy/c03LnXgtk0FC78n/80YbLk1sNaoq/hpy3WbbLve3KsaTgIGSTh4zeW2o5XaCvLjpYSyCFlZzE1Q1L+z0HY8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mLFYJlv0YNZWwUv4fy8BkGnXbWSGLMgaTq3j3WYEjI=;
 b=ELVR05U0JlxAOHTsZlk8b7A4ktqFEjXmHLVpe9UuiyT9vMFlAuJcSAY7aFAYVWGY2O6U1O/cjk8hFdcS4WpQwbyYSKshgqJAGLgE6k/5sSpdbJeVbItCCRxd6RQvUlAMoFdFIAlYFGPj0gi/NRxDb1PSy/yCL3D3CEV6bbnS24TKcBhxMFqZLkxBcFMKM1WJQglf96CbCeE0eTvVBI71wn5cyRj+suATMmPFkbVdw59PBZE9ysuJ8tKZCzOALzXN0E9QIQZujGgJ8+LF1yRXQgl35pr5n4VnIZHiIMjSKOc21YmV70JIbSvNVEd2L+qVIEIYN8/SQMaCeo+ter97GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mLFYJlv0YNZWwUv4fy8BkGnXbWSGLMgaTq3j3WYEjI=;
 b=i9Tg0BJQ4OJBIVLjkgg50AXljLr+/u3MFWP0hMxQQIYZiDdZyq6/NXbOLTiY7hhFcN6DbNWw/AGtiVGbMkHucX0MpGSWFhipVfKbCd4iWXEUsLCU+0yKflgMmO/olJU7hRDF4F9RKk73+06MY13e/is5APmDimJQKV7N/wQNbcND1VQhKCkfxGkeewLV7Fn2jUQ8rCsRaBjDg920mZpl8vBmyniA1gfcbc+PUoAYFv2MVsC8AQCZbECWkVgU1s7UqkCm0uk5qWY+TQQuQH7d6WnurV5aXs8F+UjeIhIDvQpPVfgCmGJTGJ/6moiyuwFraYTkopBIWviRxCwLKCuFZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEYPR06MB6878.apcprd06.prod.outlook.com (2603:1096:101:1b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 02:24:50 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503%4]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 02:24:50 +0000
Message-ID: <b8dd0150-dcd4-4936-aa50-958fe8867911@vivo.com>
Date: Thu, 19 Oct 2023 10:24:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tracing: mm: multigen-lru: fix mglru trace
To: Yu Zhao <yuzhao@google.com>, Jaewon Kim <jaewon31.kim@samsung.com>,
 Kalesh Singh <kaleshsingh@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, bpf@vger.kernel.org, opensource.kernel@vivo.com
References: <20231018082104.3918770-1-link@vivo.com>
 <20231018082104.3918770-2-link@vivo.com>
 <CAOUHufbc9j-6yfcm_4h_qD5L1oq6KRVXxA1u+mx0dXBqtghjYQ@mail.gmail.com>
From: Huan Yang <link@vivo.com>
In-Reply-To: <CAOUHufbc9j-6yfcm_4h_qD5L1oq6KRVXxA1u+mx0dXBqtghjYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEYPR06MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a053b88-5890-48bf-7caf-08dbd04a9240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8wAcBiznQQs07PChR0EBc2oa0Mqys3tGO8Jr6Zfl1CajnCeJOHru1t6b/ZFJFay/NBrwPrYvsDoviaUnR/jLwR+qyxyCWIFxgBGBZ4ON0c+xc8hYMvhRB/hDHPXnT++OKlPm7N7/+oAsWzx8sQyNeTIcf2i8gsN8dNwfCVo31F4FFtSVZdqTJznEvwPJfs+jKRaslUk/D6qsP9ubQP2RdCTRkQWfGki/RZMxG6Syg0SAVdZ4kmI5fwTNihf7QaQ+5tYbmnpEgUm/xj8AE79d3DLDTskla1TqjGvZ7xyrL/C0D1J6ldwI+chcNtGdtLUHs8Qi4ZYrBSh/0UEpEWC1b2gb/sKZQ+nao3nOBnCepKw2gOc1oVUsNuGU92iL9lHgOQGzmG0Vmi3XoXgYhx1EUx1YXk7hBLwEIBBumNSQyROJzbPKNEhmWlkbjLMgUlh2BEZWokV14xPUh1Pld26tE8dmzOhMuzwUP6OvCu7+i21bKq5LbGrp3NzA7qhYFyvgtuUBHS3Wbe1KhTqmSo2X0aZ4QvLSB9sAWLyrAnJKjfEuV8M03NXXALxiZK1ml9qbPIvz/HdKfpT+ga1jqiz/WZvWOtH61nkLP+6ojolWu7rXfLEdHNVFKai6hPmGWPR6m/tdsr1tPGArEwDZJD55BcILHnZDhTs5mn+JsqHxk/fz9ZOcYyK5cC/9w3dFLicQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(107886003)(2616005)(26005)(6512007)(6666004)(6506007)(52116002)(53546011)(83380400001)(2906002)(7416002)(4326008)(41300700001)(8676002)(5660300002)(6486002)(8936002)(478600001)(66476007)(316002)(54906003)(110136005)(66556008)(66946007)(31696002)(86362001)(38100700002)(36756003)(38350700005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDAxV1NIeG9MOXdqMmZWOU1YTXFGQW5OY29CMTRqWGJIT2xtUmJLck9kMVBs?=
 =?utf-8?B?QnQxcXRCcnE4TzJWZUhiNmdTKy9WRjdvd1lQa21hcGRZVFJRWkR5d0xlU2JI?=
 =?utf-8?B?eFBHMU92OEdoMmZuYkplZlBtRzhlcE5YMUdYeHMza3lvYVhiMUpwUkRRTWE3?=
 =?utf-8?B?K1Rpa2dxTFRmelNHRmVyMitTaUd4cWNWcmxqaHhTaWR4Yk1rRXJacUhTMUx4?=
 =?utf-8?B?YzVsS2xFeFEvZ0l1dVVOUVMyVktzcXVPNWRaV3hDS25lcTY3akNBYkd5M1JU?=
 =?utf-8?B?b1dnaVdzWGdaWXNrVHlON3VDRkx3SE5JdVFEM3NvWUU3ZGIzRUFERGlIdThU?=
 =?utf-8?B?MFVxUGhTeEcvS0dVdHhzQmhDZ09YSG9qdXpGb0NrRDd5alE5UlhyeDlnMnZS?=
 =?utf-8?B?bTg3eDVYenZpSms4cytRUmwwVFNod1d2UkxsNm40c09SRkhKdkUyc0Q4d2ov?=
 =?utf-8?B?VlRYUFRHM00rUjJKODVlQ25WaDJZRXZYU2tHUFhMejNvWHpTdEpzZCtnckx6?=
 =?utf-8?B?UFFHS1lLTkdCc0lBOXYxajRkd3hyZGkvL3FyRXpReTNLU29PVnZCSGU4OGQ1?=
 =?utf-8?B?QndjRFFaYkpoSXprQWQ2UmdwdFo3bmNDa1VJeUYyM2xQOXFjZkFoQnRxUDNm?=
 =?utf-8?B?R29FVTQrL0pRUzhLTTNIV0dxYXNsVHovT0JjVHV4VFZ3MzN4Znc4bVZJZGcw?=
 =?utf-8?B?UmNVKzdJWlZ6c0RIY2dreUtLbXcwUlhKSlErTmMzL0R1V1Q5TVZYNE0zTEMz?=
 =?utf-8?B?SnR3N1hDTVB4Y0J3dndWVk1kZWR6ZzlQcW8vWkptRXJLQjlqaXU4V200dkJV?=
 =?utf-8?B?M2hBblMvNVZNY0x0NWNXb245VDdnaWp2a1NJNm5hejBpTituOFJXU3kvYW5K?=
 =?utf-8?B?V1M1QkgyNWRtY1dGRXZsVW15TXk3S2tWM2M3R1RpRU50L3BFeTJuaVByMUF6?=
 =?utf-8?B?ZXkrYUUzQUptNC9ENzdhcDVIS3JlYkw5OEwxRkZxWjhMMlpBT1pqZVVOaWdk?=
 =?utf-8?B?bkh1dUtHc2JzN1A5Z3U0YW5kZW1VMkx6S2h4SWV4L3hCdXN4UVFYWkhYNmR2?=
 =?utf-8?B?UEJJWjNYZjEwNG1iVnZhRUJ3TlNvV1ZZM0Z5QXNsVDBwQjZJQjBSbkljeElI?=
 =?utf-8?B?dy84bUxuYXZ1b0NjUzRxYVdHeTBpNEx0Q1RCdWk0bUpxVzJlcTYzbDUxVWRZ?=
 =?utf-8?B?TE1VZERucVB6QTV3V1VrZFlBUkVuSFJya2NPMGxwdzA3UGxxczlqRzdGRitO?=
 =?utf-8?B?eUdyTXlSRjRVemJ6YjNEeEhEWTM0emlUdkkvWm5WQStleW5TNWFtTDhNdFJF?=
 =?utf-8?B?MS9qZWxKdFAvcWppK25BMllsR0psWUtxUmo0S3JIVWwwcmpEcU9yRzV4Y2dZ?=
 =?utf-8?B?ZnJQem5WY3h2S1FQbmhRTnhqWFdLd0tKUFpRTlZFTXFNelN5ZjZ6NXhsU3h3?=
 =?utf-8?B?QTFxM1RYZXIzOFJyMDd4K3dWUWZXVGRNRzMvTXl2UVBwdGJWV0VVTHJtWUZH?=
 =?utf-8?B?RjBMZVB0NXU2QmtXTExtdHlhTjArRUgyS3c3VDV2dEJVUkhZcmhOWFBkVWhO?=
 =?utf-8?B?SEtrMnoxNHh5d2F1V2NPeWhBOFJ0cThBdGpUR0pMckhGbXZjcDJ3cGgyZFRM?=
 =?utf-8?B?MXBYUk0vWmtsMFpKQmpLNGlCNzhqS04wNFBEV2RQNmRMVVdiNGlueWgwWW9a?=
 =?utf-8?B?T2RXUG9BUVUzNXZINU9EN2xuSVJMekszMDFVMWVnTkU5U0tneTJkeEt5emJD?=
 =?utf-8?B?a3graFBkUmFSeFpDSXN1bG5WeStRUGZXMHloZWRqeDZSeTBZeTlld1hsbjFL?=
 =?utf-8?B?UTQrN2tJUEZaWWx1dkloVEtDWXBYcktzVStxY1J0Slk0dElhRFF1eUw5SG8r?=
 =?utf-8?B?ODN2NXFrQlMrYjJabnlGbHpLS0crVktyNm5adEoybVI3dFhML1gwUjE4blZp?=
 =?utf-8?B?WVVNaTJtUnh6dXUwM3k5M3AyL3ozVy9TUy8rM1dXUDdNSFg2RUZ6blVNMFFS?=
 =?utf-8?B?cmJVclV1MlM1RFJGUGp2MGZ2VDRtVmUxNTFXU2dFbjB1UWZMdE1uNU9IZm1q?=
 =?utf-8?B?Y2dUOHRGc3lkNWU3dVgvU0dpT0pwVnFBZlJkdlJ0eWx2Nm0yd2dQeGdhbGNi?=
 =?utf-8?Q?usReNiaCOly1Zrpi6ij8yA83R?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a053b88-5890-48bf-7caf-08dbd04a9240
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:24:50.5695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzfHSZCXvRP55cEBe/rppNYzwHifA5COpkd10Z8xG7qAAWjMYouEl1t6KQwtKxeKdgokP8tN4WyTuy2yT+7lEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6878


在 2023/10/19 0:28, Yu Zhao 写道:
> On Wed, Oct 18, 2023 at 2:22 AM Huan Yang <link@vivo.com> wrote:
>> This patch add two reclaim stat:
>> nr_promote: nr_pages shrink before promote by folio_update_gen.
>> nr_demote: nr_pages NUMA demotion passed.
> The above isn't specific to MLGRU, so they should be in a separate patchset.

OK, nr_demote isn't MGLRU, separate is good, but, if this, nr_demote 
isn't need by
myself, I just add this when I see this code. :)
Please see nr_promote and nr_scanned fix  is MGLRU need?

>
>> And then, use correct nr_scanned which evict_folios passed into
>> trace_mm_vmscan_lru_shrink_inactive.
>>
>> Mistake info like this:
>> ```
>> kswapd0-89    [000]    64.887613: mm_vmscan_lru_shrink_inactive:
>> nid=0 nr_scanned=64 nr_reclaimed=0 nr_dirty=0 nr_writeback=0
>> nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0
>> nr_ref_keep=0 nr_unmap_fail=0 priority=4
>> flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>> ```
>> Correct info like this:
>> ```
>>   <...>-9041  [006]    43.738481: mm_vmscan_lru_shrink_inactive:
>>   nid=0 nr_scanned=13 nr_reclaimed=0 nr_dirty=0 nr_writeback=0
>>   nr_congested=0 nr_immediate=0 nr_activate_anon=9 nr_activate_file=0
>>   nr_ref_keep=0 nr_unmap_fail=0 nr_promote=4 nr_demote=0 priority=12
>>   flags=RECLAIM_WB_ANON|RECLAIM_WB_ASYNC
>> ```
> Adding Jaewon & Kalesh to take a look.
Thanks, Huan

