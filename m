Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F3250D9C5
	for <lists+bpf@lfdr.de>; Mon, 25 Apr 2022 08:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiDYGwD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 02:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiDYGwC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 02:52:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513B36C966;
        Sun, 24 Apr 2022 23:48:57 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23OMWL5L001304;
        Sun, 24 Apr 2022 23:48:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=oGPK6lyn5gzsGGdaKQsWqWrHwXmsgdnlgYqgnvtHR8o=;
 b=BTqKcFibz2p2hUCgPnRdCSjJuAtPDxQFE1w5XDIzGjov/s7QMix1h/RfqZk5AFwT+pGr
 Xh7Nhnuz6uuhissBwSdSxFhOzJEkdqkPn962RUUV5Jd6miYkwyJPWnyjBVkpoHbQ4YqV
 TkUVgkaV14a02CVtSZF4yEfr8eaQ2avt5Tc= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmcsgrgnv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Apr 2022 23:48:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWR5aJOfiF3leRLlIwage3v0R5D62DlAKvPg39KbRhSF4DWH2oN60Dp+4J/gHl8rQqcsDoBgk+NzWRe7K6BDMmrlC3FBh/cxBRhpecdIXreLHFBoJ+A07SVUh7hoP8jG7jzQ3OGJOzqWNCi5Pwqi9T2VmbCVhs/5WFV81OuKJQoQVTrjZ1xIquj+C05hmnGa3BSCIyPyOCjrriG1LEFx4bHDx1LPnPr/GQEKVFF4KV7eaFpdjvaLcAxEgmV3r28O8V2B5ujP0uTEiS0zQGKy2VJLLpGEgP0TVMtg4gLj+nv/+Sb3byKnZwIF9Gn0I2EsCkOO4dLMccGRLhv6TYC+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGPK6lyn5gzsGGdaKQsWqWrHwXmsgdnlgYqgnvtHR8o=;
 b=XQ9xbv7T8dwz55r0+jtHUzgDuwU14scGjdnYFM481EaMTG1HlQdlw3kBZdyvZx1wj9XBGFudrO0my3jhUDamuZj8O18nlXE+M5qYoozHNaydEXEr8tTOazHPvhvnGx4oMpmUaEOspK0jVnhBefbWcAccNS616c0f36ZO3nQSH86VEAZb78ocQmN1QJeJey7UevRINYfsDQXvG1LQehH6ZSh1MAnQ2chO8TOnIeIsCXw9zsLw3t7MSe9UCKo1qppjo94SjnYBOGkvLZpspupSxtM19LMHC/t7kwB1hzD+HCyIEU1mGAw4ct6PS+Hm/ofIOdA9K5TTXgVx5Lq7rt2msg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MWHPR15MB1294.namprd15.prod.outlook.com (2603:10b6:320:25::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 06:48:52 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::20d2:26a2:6cb1:3c4b]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::20d2:26a2:6cb1:3c4b%7]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 06:48:52 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Thread-Topic: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Thread-Index: AQHYUOjRr/eYt5HVI0ucQZg4JV/u/6zxVckAgACoe4CAAPedAIAMbewAgADbbQA=
Date:   Mon, 25 Apr 2022 06:48:52 +0000
Message-ID: <B92A031D-EC21-43EC-A236-1A5B09A23F4E@fb.com>
References: <20220415164413.2727220-1-song@kernel.org>
 <YlnCBqNWxSm3M3xB@bombadil.infradead.org> <YlpPW9SdCbZnLVog@infradead.org>
 <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=whadDF2MGN_THUo-n9S-m9isA-+vwhMeVvwGvmuZaYb6Q@mail.gmail.com>
In-Reply-To: <CAHk-=whadDF2MGN_THUo-n9S-m9isA-+vwhMeVvwGvmuZaYb6Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0300a9cc-f902-45aa-9136-08da2687a933
x-ms-traffictypediagnostic: MWHPR15MB1294:EE_
x-microsoft-antispam-prvs: <MWHPR15MB1294BFC3932404B40638FE78B3F89@MWHPR15MB1294.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r/7zBEyvmY5GPot4IJeeAdFps8DFalvWXUXWe0O/ranbEDzLRzgTydMr2c7Jmih8LFuHRyjiUkXs3gOg1BLrpwXErX65e57KdzcxvKGmPBZsTbTxoGH5uhB/jGSOQ93N9JXNG7tapeWneoqgisVDnPANTtHyoWGYZQiXBqMxWDhGtmCHCK45h9Z6q7IzJrDl7+IKNF82d1Gz3YsTdewBY/q4OLDedyWgkWvSr+0IPQHMoLcCJfjNE1BmAI79u/9HOxRuUOIvapjdWZAxkKQp+ePEc3AufJhOYkk25i7pVN6PE4LRt55eFviqmlJzrPJvZwDRJscwu7vcr80XXH1HJ5178VduLTWBG+Oymvcj59SeaVj7cYXqfiiofJKVaRFScWGHRZz5VKJVR2EOhQi26ngXgqXbWZwO2OAbosNiHT0crQ0PoSqrocCyX/1C6Z/7a09GaIk+2Gbsyp7ltQzHZcYmE6JPWQFiRs5fgaTuc0a7zcQQevUwygk4IGbTOeVejGSOKRFIGV2AoMX52YMGhll4jo4PoqOJS1iBgh/csagO1omZcRTEW/orpUE+3pO4ERG/3XNzev7ljHj+8PIDZeSO0oCeIZe3Z4Az9JdVu0nGQYGD0K0OBw9o395IYXJHLOuReYio5Sq3WYqToIoQng5SeY2SVUGMivtrai32ENKzfJt/UbfJc9H0UMeKEagpRm8zWtjNvqPlLi6A1ch/nSaHrHc3ODZA8ZPLSf1wCD9prR4BcaG/NMUe4VT72+yNHTP5vy3m65pIyFJOe5VjEqq0GbMbg8xqKGCjXgj9bfhcVb5N1U8s/mkfOnkZbZab8pfyoQ/rd8BLyg3lmNdUZJEC5KUuJjmThSNCRAerxYX+B9ew0RKZWXrbwOJ5/tKbyuy1z5hnX0kPVDihHISi5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(508600001)(8936002)(6506007)(36756003)(33656002)(7416002)(316002)(6916009)(53546011)(2616005)(186003)(8676002)(2906002)(66556008)(66476007)(66446008)(64756008)(122000001)(6512007)(4326008)(6486002)(966005)(5660300002)(38070700005)(38100700002)(86362001)(66946007)(76116006)(91956017)(71200400001)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZU1wZVZZVnBDYTdJTVVjRUUxNVhSV3gxN0dxZXM2ejlnMmo3M2l2Ty9nZmFx?=
 =?utf-8?B?M1NldkFROTRPelUyYTNRNkhQYXVLcmZzdDVsQVR0Tnk4SjBGanNYNDZIWHgz?=
 =?utf-8?B?eFdEL2Y1RmE1MnhxUGpGVUR2QnFmeXlNckxJMEh1VWhVZmc3MXc1NDliRDVP?=
 =?utf-8?B?cWVTa3ZGS2Q4NkFuN1Q5MFEvdE81QjdPaGNZa1hEam9pTTIybDltY3hnVWtQ?=
 =?utf-8?B?dDhQdk1IQ0hKTGR1bnZBR3RQS284RS80YkpZYUIwbXJVWnYrQjdxbnZQTGww?=
 =?utf-8?B?dEt4cmJqWFFLZlE0Rzh1aHZ6L29IMEtna0JDTkNpL0NpSnd6d0dPTjFJdEUv?=
 =?utf-8?B?UUR1c0pxRjZobkx4MXk0bTZBckdTT1YrMmNUL3FUaDcyYWZrM1dNeHMyM1RR?=
 =?utf-8?B?RDgrUWtOWEtacU5zTngxOUZpQ3Mzc2t5Zy9kZnlUZ1FrY0pJYjlsNThhVlRI?=
 =?utf-8?B?NVRUQlFNRWFvQnhGRkVtUTRhNkpjR2VQV21BSGtZdno0Y1BYcnZTa05SM0JP?=
 =?utf-8?B?Y2o5SjYxdkJDT2VLVFVvd014Tk5IcDIxNDFVWWZybElrY09jcXhjZE4zNE5E?=
 =?utf-8?B?VXp1L0UvZnU0WkNlb0djTkRsSGRhRitpUEdxNFZyWTBPVFE5bWcvcUxXc2hn?=
 =?utf-8?B?OXpBOWJod1d1WXNHSlphUVN0ckpQMGYxZ2REK3NxNHhnSmZvOEluMFJhM3dP?=
 =?utf-8?B?TzhZQkVQaE5nZUtOMU9ZMG1YRVRBVUlPb2RScFI2c2VteFlmL1BzQmpDKzVx?=
 =?utf-8?B?YVIyQ1VPSlJTYWZFK3RkaElsV3JEeDA1Rkd4ZE9CL1MwWjZta3B1ZlFwNHZG?=
 =?utf-8?B?RHBKOTRHcGUxMjcyK3pFVldsQ3FsUVl2dWljenJTQzlVWFgxbXVKTi91U0tL?=
 =?utf-8?B?SUlRUytsSkZraTQveWxJU0RvSkd0SWh5b0RYNmE2QXRoakZrVXZNajMvVTBS?=
 =?utf-8?B?dUpiQjVpbmtBQWZ1TkQ1M2J5VHpxaEJtZitUQ0MrQUJlOGcyMjRqdGJkMlFM?=
 =?utf-8?B?ZFJpQmNMNUdDK1Q5c28va3U4TDFwekhPQTYvVjJjeFp4UU1mMjY2SHFiN3B4?=
 =?utf-8?B?RlhNNFYrV3VacU1pdy82RjFEMHhlUng4dndKZllPREdGdUFzUHY3UHR5MkRj?=
 =?utf-8?B?eTc0Q3J1andZQ1hyeG1OaFJFNXh5Y01wUS9ud1FzS21MVzFyMEZ4UVdOYXVE?=
 =?utf-8?B?YnFOK094dWU5NG5kVDdGak9qS05vNkszMEo0cEo4SW5rd0kxQjk0R2FRZlRK?=
 =?utf-8?B?aHByUjVKei9KU040S0VZWW9UbE9udFJhMTBLWjZyKy92bk93NG82dVllUS9I?=
 =?utf-8?B?UlhvVzdnSmJpL2lFSklFODFBbGNKNXFhSHo1eDZkcitFRWlyOXlWcjJIenUz?=
 =?utf-8?B?Q3E3eGhkcUpmL1ZsUGdZaXFxM21Jem1QQUZ6TnRwTjdTVlBWdHJOcUxWMmRj?=
 =?utf-8?B?RXU5M3JWVEFxa2kxYWNWK3dDRmR3VmxGNFY4VFJlbnd2UktFTVNhMGJzSTN3?=
 =?utf-8?B?S0NkaW5Xbk56NDJLVVh1OWZELzRlakpITDhwMk40N3FBTW9yWE4zMGw1OGg1?=
 =?utf-8?B?bWQ1dVcyOXVLenFnSEorVVlORFJicUtobG90cFpRRVhNYUZiM0xFaGJ2dWZp?=
 =?utf-8?B?eHBNNXp5VS8rd0U5Wk4wSjVnWjY1eFRmMGFQdExCZ2lhRStRZTFRY25XMHVw?=
 =?utf-8?B?cUdodFo0dTNMY1Q5eWxmSnp3dEpNeUNIaDY1d1NOMU5MbEp1K1VzSlFmcTFP?=
 =?utf-8?B?dVRDdHErVEdMZDNoZjAyREdRK0NUZmUzVnU0K2FCUEMvT0ViZnpyTWpRUVlu?=
 =?utf-8?B?MDNmTjMxUU1sWXMxa0s5VGtwaUlYSnVrN1NDWHhDUXFSWUF4eTVjbmdZaVl2?=
 =?utf-8?B?WjFrQU5UaDE2SnpNc0x6OVI2T0xtV2ozeEhlYUlrRENxYXBHQjJ0NWRmbTBB?=
 =?utf-8?B?TlE0ZkViQWlHaHFYSVpHVVZwRlRQNldYTlNPY2hPM1VDdDJ0MDV5UDg3Umhy?=
 =?utf-8?B?ZG1tS0d4UTR4TmZZL0RJcy9MQ1ZSZnZBYkZHUFJWTFcrTnRpenVtWGVvbmxi?=
 =?utf-8?B?NHdqOUtnSUErZ3RCQlVnSWhuS0h6N0p3N0o3eHZyc0xmZSs4YnpHNW5UQmRs?=
 =?utf-8?B?YXRqVm9NODBwOXBaQTMxSkc3bnc1eENHTUxHZ3llSmFUZFhULzFTbjV2YUtZ?=
 =?utf-8?B?R0NLMlBkeCsxaTRBUTh0K256Rk10VGFSb2MxYjZ0TXFpbzl5ZmtMajJGbmlh?=
 =?utf-8?B?cUFRa1g5TG1QMGZ3enRoQjhBa0Jxck10NVoxOGJQdFZnYUFhQ0svWFptZDZL?=
 =?utf-8?B?UDJmNXBYS3F0UnhDRjBPQ29NeUJXakJmUDZaekU5Qy9QWE5ldGkvUHdIK3Iz?=
 =?utf-8?Q?V7XomOtibC6ZbKHbDJSNFQK9PXsIF6CfNlHvc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F93101FA58A5046B803283E3C55E01B@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0300a9cc-f902-45aa-9136-08da2687a933
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 06:48:52.7203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /oAQFe8g2MMJgD1eJ4g89O6IvtQI3K7F19jDpjGVBPaEJdNEHdUWgqS7cDuHwEcwvlfSUq3oP8pzAkgaSFRHOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1294
X-Proofpoint-GUID: EjF7jYjq9ocMBHr-ctE3hbdJrFzrfH2R
X-Proofpoint-ORIG-GUID: EjF7jYjq9ocMBHr-ctE3hbdJrFzrfH2R
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_02,2022-04-22_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGkgTGludXMsDQoNCj4gT24gQXByIDI0LCAyMDIyLCBhdCAxMDo0MyBBTSwgTGludXMgVG9ydmFs
ZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IFsgSSBzZWUg
dGhhdCB5b3UgcG9zdGVkIGEgbmV3IHZlcnNpb24gb2YgdGhlIHNlcmllcywgYnV0IEkgd2Fzbid0
IGNjJ2QNCj4gb24gdGhhdCBvbmUsIHNvIEknbSByZXBseWluZyB0byB0aGUgb2xkIHRocmVhZCBp
bnN0ZWFkIF0NCg0KVGhhbmtzIGZvciBmaXhpbmcgdXAgdGhlc2UsIGFuZCBzb3JyeSBmb3IgdGhl
IG1lc3NpbmcgdXAgQ0MgbGlzdC4gDQoNCj4gDQo+IE9uIFNhdCwgQXByIDE2LCAyMDIyIGF0IDEy
OjU1IFBNIFNvbmcgTGl1IDxzb25nbGl1YnJhdmluZ0BmYi5jb20+IHdyb3RlOg0KPj4gDQo+PiBQ
YXRjaCAyLzQgZW5hYmxlcyBodWdlIHBhZ2VzIGZvciBsYXJnZSBoYXNoLg0KPiANCj4gSSBkZWNp
ZGVkIHRoYXQgZm9yIDUuMTgsIHdlIHdhbnQgdG8gYXQgbGVhc3QgZml4IHRoZSBwZXJmb3JtYW5j
ZQ0KPiByZWdyZXNzaW9uIG9uIHBvd2VycGMsIHNvIEkndmUgYXBwbGllZCB0aGUgMi80IHBhdGNo
IHRvIGVuYWJsZSBodWdlDQo+IHBhZ2VzIGZvciB0aGUgbGFyZ2UgaGFzaGVzLg0KPiANCj4gSSBh
bHNvIGVuYWJsZWQgdGhlbSBmb3Iga3ZtYWxsb2MoKSwgc2luY2UgdGhhdCBzZWVtZWQgbGlrZSB0
aGUgb25lDQo+IE9idmlvdXNseVNhZmUodG0pIGNhc2Ugb2Ygdm1hbGxvYyB1c2UgKGZhbW91cyBs
YXN0IHdvcmRzLCBtYXliZSBJJ2xsDQo+IGJlIGluZm9ybWVkIG9mIHNvbWVib2R5IHdobyBzdGls
bCBkaWQgb2RkIHByb3RlY3Rpb24gZ2FtZXMgb24gdGhlDQo+IHJlc3VsdCwgYnV0IHRoYXQgcmVh
bGx5IHNvdW5kcyBpbnZhbGlkIHdpdGggdGhlIHdob2xlIFNMVUIgY29tcG9uZW50KS4NCj4gDQo+
IEknbSBub3QgdG91Y2hpbmcgdGhlIGJwZiBwYXJ0cy4gSSB0aGluayB0aGF0J3MgYSA1LjE5IGlz
c3VlIGJ5IG5vdywNCj4gYW5kIHNpbmNlIGl0J3MgbmV3LCB0aGVyZSdzIG5vIGVxdWl2YWxlbnQg
cGVyZm9ybWFuY2UgcmVncmVzc2lvbg0KPiBpc3N1ZS4NCg0KV2l0aCA1LjE4LXJjNCwgYnBmIHBy
b2dyYW1zIG9uIHg4Nl82NCBhcmUgdXNpbmcgNGtCIGJwZl9wcm9nX3BhY2suIA0KU28gbXVsdGlw
bGUgc21hbGwgQlBGIHByb2dyYW1zIHdpbGwgc2hhcmUgYSA0a0IgcGFnZS4gV2Ugc3RpbGwgbmVl
ZCANCnRvIGluaXRpYWxpemUgZWFjaCA0a0IgYnBmX3Byb2dfcGFjayB3aXRoIGlsbGVnYWwgaW5z
dHJ1Y3Rpb25zLCB3aXRoIA0Kc29tZXRoaW5nIHNpbWlsYXIgdG8gWzFdLiBJIHdpbGwgcmV2aXNl
IGl0IGJhc2VkIG9uIFBldGVy4oCZcyANCnN1Z2dlc3Rpb24gWzJdLiANCg0KVGhhbmtzLA0KU29u
Zw0KDQoNCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDQyMjA1MTgxMy4x
OTg5MjU3LTItc29uZ0BrZXJuZWwub3JnLw0KWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LW1tLzIwMjIwNDIyMDczMTE4LkdSMjczMUB3b3JrdG9wLnByb2dyYW1taW5nLmtpY2tzLWFz
cy5uZXQv
