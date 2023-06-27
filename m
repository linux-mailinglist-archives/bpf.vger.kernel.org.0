Return-Path: <bpf+bounces-3538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C79A73F3D4
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 07:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1231B280F6F
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 05:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FA2139A;
	Tue, 27 Jun 2023 05:06:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFB610F9
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 05:06:47 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F3D8F
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 22:06:45 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R3cCYj023037;
	Mon, 26 Jun 2023 22:06:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=PehiNjYVHYXCcjBH/SaXCzy6YdFpikJap+hVPUdoUUM=;
 b=hisosqwEwsM6zbaLjYoUqenmk4KpC32s63IiILQmSQJI85LttHUPaS09BbFftfRwSb6j
 +uWYH8wbEHnDMuELTQwSSSXXcFVssXMts4aFe/nHffPFVAFZ9noCx39KtKSxfCtrqgq9
 v4/ct47H2gkhj76WL6EUSo/2HAq36PtY8bm8GMhK8tFH0Mgn/9+9xoLCiZ22dVXdYuz1
 kaqymP755jUVfCz0tlKaSE4KYgLGtuMhHZibq8OTIic9nGl1y2S1cGTRBFcG6Oxm9uMu
 kGR/6iWZ3Lv+n0NwkdGds+gw1ZrZIZeBXyu/4jAg2kpfVVCGnPpQtPlweRerFrWGB79q VQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rfpags84e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jun 2023 22:06:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXe28l9r3So2ZkVxzpgxcvVyrcATpEaYNFuByfbr1DqpTrGVV/yqaiA4e8iVM45UCsVVXBmUXZINcD0KQdpYfwgwR/1b6+rNcSfqwkU91qBgFPtsmFCfHy9SPBmPS6bVAJZVdzJyO5cnDfkdcD5vwP/0+eFLyzTBR1Tipss27OKPmvNP0t72aT5/1Xoc7WBPPDyGV36D3tsMtYjIjFnAtzh+jjrvBRZu7x4YwtV5jWSWwn0HCd7yZ6s51o/OgukVbURwwlDaSjT3xI82eZTfscc5w7T580aHo1UXdz4Q9W1tKdWyqJBiui/3SDhQMynmfK2rfNYZ+iQBDuDflouGow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PehiNjYVHYXCcjBH/SaXCzy6YdFpikJap+hVPUdoUUM=;
 b=MpJIxWxGy5NXyYJryAtjmOedp+T+rm1ubbuWqrVDigKHTN1rEtrPChohAYlC6RVRxdLswRIituCwUMiCIlwvzS646oQ5rMlVtlONgwCS6daegMJXwX0wmZDp6+v3p4gaqfBJIiSLBBl6XAUJvUcWN27Xa8DcHj786GDV8MuDjpHoZOB9Bp+zTFzQDgfmJtd1mpXTNKoIDHBp9z0FEDFWeeyZv/Hd5ns7FLtBmW3uaQvU/DK9qOUhLQlYWkmxdHYC1MWnbgO4DP0EthhRE0u60SjTxA3Hnqrd6joCeCeBz6WUHpcE1PrOyivW6f7uxiwzGGGqqjmdLS3LK3H/+yX0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA3PR15MB5678.namprd15.prod.outlook.com (2603:10b6:806:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 05:06:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 05:06:25 +0000
Message-ID: <aedcc985-d49b-3eb3-765b-e248082cff4c@meta.com>
Date: Mon, 26 Jun 2023 22:06:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test to exercise typedef
 walking
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org
References: <20230626212522.2414485-1-sdf@google.com>
 <20230626212522.2414485-2-sdf@google.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230626212522.2414485-2-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA3PR15MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 34fac374-f336-40f6-ac3f-08db76cc41dc
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tNr+uIZbOcMUVvoFrMmjpyzgu/r7+wf8TOdgZuaV2NBNXdXNESp86WzajsBfb8qpS6irpxrittptkcS+QVB2DrdGnXQW7h5I/UsRU3DkJ9Norg6IW2ButQR9P+g6+98yTkJsuV7ubW79bybZpsI0QJk4pgTGCH5ZEEunQCSaQvCbZJwPb7Gj+p+jlgTCp+UK61qYR8aOoS5UwbCppDn9MI/NngTPgNttXj9bIZ+rv4HfLh/Z7PEeshXZ4GIXv9UmioPn4r1tFbQ8hSqAVSRCNjtKQNalyEqeb2KLb48Q1dRjCzf2X6FNi1GBgNhmrHTD2t74Wk41yeUpzPcURRRcYE9HI3qjUHgGJsNPpha0DMrXDwMoheDCptAgBip9vtLWUyF29Dej9CsuJgszg4nRaFN1WXzLgUOgUj/ysE09fpVDpLA1d1kax5c0/bR2XjSxYhP9pWHTmYj7XFeezuJ/6J3yMwNddeggifGgmQbdhHH2oJFHEDPZxLG9SASZdAo/gVPiZ4VfjPPpNF9xim8p2Vy1l6H6aLx/pGLXUF9wU8flXsNvrwjURipS+IP7x/VIM1KzIwsz/CcnA/SLfusikICikDMYgDJoOV6oETmFcmk/zcqnGqHeHcpHmOGmc0qV5/7EWEGM/7FxjMkhv/NfrQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(38100700002)(31696002)(86362001)(6506007)(53546011)(5660300002)(7416002)(66556008)(66476007)(6512007)(66946007)(2616005)(186003)(2906002)(478600001)(8676002)(4326008)(316002)(6666004)(8936002)(6486002)(41300700001)(83380400001)(558084003)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aEdXL3diVWhPSmFDQ1hSaEYybEpCVld6RHcwTHk0TE90V0NSZ1JLNHArYmdD?=
 =?utf-8?B?em9pamJwMjE2K1JGVk9ET3JKOC9qRjNuWDI0TFU2bEJUTmRXWGdlTE5Uam83?=
 =?utf-8?B?U3QxZ0tIbWE4TC9JekpYTjFROFZGMjF0TDlQc3pxcEZveHlyY21zTDBLVy9E?=
 =?utf-8?B?MFFOZXBEMjV2OGdYM3kzZUxDUFVrcDdkODYrb1VYV0RiekRLL25WYnZQWXIv?=
 =?utf-8?B?ZHc0K1pPRFBUck1wWE4rUkxubkRzQmxPNWRMcUpjaE9PbkcrSmlqcDY1aVJM?=
 =?utf-8?B?Nzg2amEyckJhaE5sbXhHZEowYXc5K25JY2EySnIyMHRqTGtFdlJSNjhNT0gx?=
 =?utf-8?B?M01QaWJiTGZ1djVIQmNvMmhHaFNkSEZqdUFPaDhTdFdCdTg1ZkRkVEgrYlpx?=
 =?utf-8?B?UXl1QXJBRzNvNElRTm1KdEd1bnlrNkhOMmdWRXpxQ2JyYmhGWVdRZWViNlR0?=
 =?utf-8?B?SXVXUVl3RXFtRUdQRHpOT0E0NWJHQUlRbHdVYkxMcjQ3THFXT0xvRWxMVWNu?=
 =?utf-8?B?RWcyUk1BUGdML1BEajR5eHRiSzhGanNPZDl6a2NUVUJkTStpckRoTm9TMXp4?=
 =?utf-8?B?dFZTRTlpZG11OWJSbTIyUko5a2syaWQrK0xJS0Q0bHIxZE5vLytkME5VOHNC?=
 =?utf-8?B?Y0RVSUlJTFlXN0pTbG9tYjRIUTRRd284NFVQNG1vNXI3WStnN3VMbUdwMkln?=
 =?utf-8?B?c0Q3Z0wyNThkVWU1V3M1c0ZHQXJqTWRuNCtZOE1tbFNlZkFGNER2czExUzhQ?=
 =?utf-8?B?T0lBazJIcThYTzMwUk5YK29jY2RhaTBBNDZZTEpVdHIxNCtrVHlwNGNpV2VC?=
 =?utf-8?B?T1BXMktGaElNbzVEYTByUmhWMW5uVHZRZVVnK1M5ZDJBQXRWeXhNYm1hTEt5?=
 =?utf-8?B?L1dlYVlpRkxQQVl2enpabkwvaEJ4bCt3anZ6WlVrajhmNkthQ3NvU1o2VWwy?=
 =?utf-8?B?YTVuVDh1STh1TjkxUVZ0YWxxRDlZeVF5ejNVakJTN3laT2V0N1NNd1VEYmZR?=
 =?utf-8?B?ZUpZOFRSalBkRG1tOUNoeXh3YUtaeGlPTEZZNndqZURXWFNVL0JqYXpKV25O?=
 =?utf-8?B?Q2dPZnhXRmdjcXMxQUZUZnlSS3FibWNuQ1g1ZlJQNTZZUmRiR1NHcXIwSDlD?=
 =?utf-8?B?WE40Y3R6U05adThsSlNjWkpMbmtNeThIQnFXZjdMdzlCZG84NnJ2RjR0RFAw?=
 =?utf-8?B?TW9uek13d1lxNFkzUytjUytnaU1ORnYyNWFPU1NXbUdBcVRLa3ZHbXp0TzVW?=
 =?utf-8?B?elJRR1piZ1dYTGFqRVlVTVFuRGJReXliWVN4SjFsSDVmV0hkS3NkRHFwSHZE?=
 =?utf-8?B?bFV5WW0yQUtxSlppNTNKOHByUDQvTXBjZzcxazl0NkR0NjZMa09PTjhIamxm?=
 =?utf-8?B?RE1ia2l0NkM3NVBmbjdvYWFZaDZmdEczQlNLZXlodXBkdHVndjNVOVhKTnB4?=
 =?utf-8?B?KzBtSG41QWdXSEdhbnpHSi84bzR4dElBMENLM0VGYUplMWg5NjF3anJKZkF3?=
 =?utf-8?B?eWNYbW0zOGI0STFaMGV1VUZlUkw3alRsL3FGRFR0dnpOY2JzYWhDenVaRE9H?=
 =?utf-8?B?WW52YldDdGJRdHdwV1hUK1h2ZnpDeFB6UXBkandFczdPTUM0SkgvU0k0SEEz?=
 =?utf-8?B?eEtlZ3VvWitTb1hZQ2tGNUhmOGlkVmVlbG9IalZ0c3l4THBNRVBENTBlbWdW?=
 =?utf-8?B?dm5lY0pSYlpiQzF0bHpsRTJ1ZThGaXRBeG5tNVFQR3hZcEdJZXVlZGZaaGVu?=
 =?utf-8?B?OVp2blQ3L3dwTUt3cU5pNFJCdTZwUVJzaGtweUxEUGhKaUI4ZVVpRllOc0hi?=
 =?utf-8?B?NHJGaEptOG5ySE05MnR0VG1DSGNpbVJLYzQ1L3JSRkc5RHJUckNTZ1hXelRI?=
 =?utf-8?B?NlBBOC9mWUx0MVd1NHp1MUZYT2dhVFBYSnFya0pacGVkUkdTZUdlWDJ0aVN5?=
 =?utf-8?B?czh0UGJIWHNsL3J6SXZhd3pBM3JoL04vS0xLWjZ2WGEwU1F1UmRMc2d5Mi82?=
 =?utf-8?B?TU0ydlNyRkwxeDJDSXl1cG0yUzA5VVY1aWhDUFRrN2luZHFPYzBBc1VjaXRa?=
 =?utf-8?B?eUFvblpUZHFQU0VqSmw1QmlFL2RaTks4YzF6aC9oc0VOQUN0WldEOWErcEhI?=
 =?utf-8?B?V2VGLzVWN3lZUmljd2JwY0lFZGpzS3RmWXpiczcxQ2V6dmZIaTB6Z3lqSjUx?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fac374-f336-40f6-ac3f-08db76cc41dc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 05:06:25.5314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AG8+THKj5Jbdi91gnsZpGrywe9mhlmKjkEpjgXae8/LUt+FvFzIB47h1y6LJDSc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5678
X-Proofpoint-GUID: 2ir3dXSZBFBbVwqr8bspqoMiVFWYpK_1
X-Proofpoint-ORIG-GUID: 2ir3dXSZBFBbVwqr8bspqoMiVFWYpK_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_02,2023-06-26_03,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/26/23 2:25 PM, Stanislav Fomichev wrote:
> Add new bpf_fentry_test_sinfo with skb_shared_info argument
> and try to access frags.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Yonghong Song <yhs@fb.com>

