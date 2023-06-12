Return-Path: <bpf+bounces-2417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DE172C9C2
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034BA280E90
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1130B1D2D9;
	Mon, 12 Jun 2023 15:21:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5071C757
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:21:16 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4DFE51;
	Mon, 12 Jun 2023 08:21:08 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35C6e5je021424;
	Mon, 12 Jun 2023 08:20:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=413DwEO82w6Xh251u+hclxFzASOaGWd6nDFI30aVBu0=;
 b=R+3fCKjEEyIwswRRTFFvPv1w096m+jqhiGBvLkfVThEua/Wrn8SXLuXyl5wuKvLrpix6
 HMSBtuQIKbxPXXb5u6nNgRHTk+RkewQlKlksPutkMOCDi/IcUZ8PSjatDEHXwvdSuq/a
 8OkXG8mlAGXtxLK1sAD4kRMa4OgsMkigRQaZTjtAWgOcP9NUCKQkrsYS0e3Xqql4ZD6E
 7WglWMlo6fyw/dDLZFqKuZb+B6GpbnGy9jMsJtzdA4R8IjAmjLfcT2Uo7HrwvS4wDE3f
 RmSRvwHkdIOfeEWcc1c5yEsSt72D733pJs5Rw8ugT1ykALXETT5Jlwj5qhy/eE4ZkHuh gw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r5x9ujurj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jun 2023 08:20:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TF4vhG3RdHDBBcPOtpjxJogkJ5y1aDP9CiU1JhgDVNDttwj7JH6BpffBFBEGXaikoBePOwAfDMXETP5rHIJBcj8OKzKwA4R8hFYBlV0Uyp0h9edu++0r+F+0u9B0mj2y5jN6izaXTNGJTVD+/G+dzHszHkms7SmLcguB4g83eiI7gRpaHmVuEOWCdNBKxIGtV3VSaNNjJaxC4Fbj9df3u5FpgvnuzPwCTrISKAxTD6Pkt7YX+j2qWyw/mlBhYRHeMJpFadaDCHZsNLSnXiT75hLzYTTEt5+qk3a1zG5XTDKByHuvvd0UuAbveatsui/ZRhsRIkPSq57MIPmiyTMQCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=413DwEO82w6Xh251u+hclxFzASOaGWd6nDFI30aVBu0=;
 b=YijyJn7v5vgcv2TBy9CdyR7f8MAsIxl1+UhNTACbpczlUIGk5YyNv/fyYnC12LWRZdhlN2vQqNBqmkIYXLU8pbpfeZiiLRxv42zFX5wLCeFTgYg4A+PMUWgJmuvi80ECzd5Pq+oOdcT4/+OQW5zzZPW6j0+bmkCZ9I/Yx4HmuOhlanH1DhBB9p/TsOQEj9AOpwSU7qeUAJ9rC8l9q5MJXHGTmm0pFaOu3TV7Ho23LLmvBazuFH88KO2Sp/i36e0yd5HE+Vh7HfFCTtu3m4xoCULE1fWA2ev0nWZy2T9o1shqgr52UdMLtp4LFOVW8OX/o4LxEY2kt4TDMRU9gIncCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS0PR15MB6067.namprd15.prod.outlook.com (2603:10b6:8:125::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 15:20:48 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 15:20:48 +0000
Message-ID: <c59e8c1c-a37b-d2a5-76b6-ace0807dd7a0@meta.com>
Date: Mon, 12 Jun 2023 08:20:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next 2/5] selftests/bpf: Add test for new
 bpf_cpumask_first_and() kfunc
Content-Language: en-US
To: David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
References: <20230610035053.117605-1-void@manifault.com>
 <20230610035053.117605-2-void@manifault.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230610035053.117605-2-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS0PR15MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1e1c04-7ea1-47aa-8cc3-08db6b589988
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HkYrycO1iSkp516UXiaKM7nwko9pRVL3OkbQMvt/lOV5ZAryjdHF6rK6jLQQzvi7dUkC/m4wZszcoa0EEwHA7D5XbwGUZsm7H2Y1j4HwuzlrG/+P2cX4zugBlJKuKcdf2FSzDRawlRRJMbaCBr5tkD7L7z+H91/69QYhsAIzStcdkV/e/YQ95MwTG/JWdJiJgJS/Z5bwOoX//PZyfq+BeiDUuI1lu+S5EToPzN1v70Dzzmy+/ML0amIg5bawgkzRmaOW9cBNUYnymfOSP+hprPuANarEFgtFeVlI1sSjeN440m4ddBJy8dAj+24xYeQMgCNebChY6pwk4L/d3WDjyG72u3yY4etd0Q1enyN7rLHg2Rh+XifY8TztTJQscDsBZgGHpbFfk4Ux7zeWUsVPzM8nHPdrmJwux8EGgWRwKVFb0SeDlzoVCZoH9B2PGNB0zwJwRgFmA7OjleM4+9zN0YNM9rNtpD6bCTthIXjz13ee9yU1oYqahe+RNWYNY0Hvt2867GjC3n9qNfYD1+hCdIzWL3S4SIujm6kUxgO31WOu8CIJcw3PGu/Pa/RCwPEffHP8IJJ2ylNmmGVpOQkfkhmJQSCgEN4Ek+SPp60AEZHiAwYYDCni9wuSb/CxDuoVMoiDOxockCu3nCmK8wJrNA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(8676002)(8936002)(186003)(83380400001)(2906002)(316002)(31696002)(7416002)(86362001)(5660300002)(53546011)(4326008)(558084003)(6512007)(6506007)(36756003)(66476007)(66556008)(38100700002)(66946007)(41300700001)(6486002)(478600001)(6666004)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eE4wSUtwRmptZmRiZ2RVeWJKbENlU1UrMkFTdENDK0Rja3lkMmIyWDVWK1F1?=
 =?utf-8?B?akZLMWFtQkdIMjVkMWFobldBUFVlWG03a25DOThtZmtmNGUvamxreFhjamZi?=
 =?utf-8?B?ZWcrVm5PSDFSWTcxV2gvTU5JMzJIa0RTMjdWTU4renh2RTNxSGw5OThSdXgx?=
 =?utf-8?B?RklUVHdrOHI5MDBrRXBNQkRMNlZBVkR2RlZ5eFFTNE0vc2hqSXErdk43WVdW?=
 =?utf-8?B?VWxPK054RkhXMkFmMUhNejBNMmVZV0ZTOE5zblZIejJZaWJPWi81OGdKeEFw?=
 =?utf-8?B?bEpCdyt3SDJ0REpkT2hTNXZHOVJlWU5GUmtqcXVXbmFKWFRrOHVtOG9QU2dD?=
 =?utf-8?B?eFdQUUlZbzFGQURhMUFSVUQvcEVuUEhHNzdhOUUzNU5oanBZVG90cXNIUS9q?=
 =?utf-8?B?aUZCeVRzNE01RE5pMmNFTUJ6VnpHRllsaXc2YnhGbjVyU3pCa2tHWTgyWkNp?=
 =?utf-8?B?OUZ1SHlnczlwb2Fxbk9Oc296cEhNWjdjT3pUcHdaUkowTGxRYWI1LzhDZm43?=
 =?utf-8?B?TmxVNjhaVm1DWThyWWFoL2k0YkZNZkVlUDlhYzYrUDM3dXlPWWJ6a1c2WnUv?=
 =?utf-8?B?a3RlWlhFa1FQekR2RmZLNmpqcytIQlVUMnJadGljY0RmNE9BaUFZRmFOejY1?=
 =?utf-8?B?QTBwZVh0OTFzbFU1TkxCdjl4bGZkMkpsNVdtTGFhVFRVTVJtQzhlVnE4b0xx?=
 =?utf-8?B?eWY4aHdYU2M4N2tKZlZLTnl3TlNGbzNUSDJvSzZZcG9HYmNjSEYxMCs0N2p6?=
 =?utf-8?B?aVIxUFlvZVJhNEVHeHROdkZlUGl6Rm04cnE1VDJPckNaYXJpYzREdzdxbFpF?=
 =?utf-8?B?OFZseW4yWWIrVmVQeHZERGJpYXFOUXEwL2Z4cFpMQUl4RFlwckUyaGRraEdo?=
 =?utf-8?B?U2I0enVYWnUzdFE0S0ZKdFExUjkrR2I4aEk4VjYrSVdrbVZXVlpPbWUxWkk4?=
 =?utf-8?B?Y2N1VmRFNEhjNWZJU2wzQ2lWVDlzSCtFa1lCZXpmNHZzeFh0R0xoYXNHdHNp?=
 =?utf-8?B?Y2pwM29Vd0NydkJhOG5uQXJldWJvK0plTERnV1JiQ0ZWNVZKUU9TVjVDYVJ5?=
 =?utf-8?B?b3VwRzRHZWlsWlloSUJuMUhwbjRkZWZmTzFhbjRQMmo1TTJHa0R6UEpZTmNY?=
 =?utf-8?B?d3BYV2h5K0hEcHBtcTRBU1BjYnVUYWdBRTJTbmRaN2VOL29jeklNZTEzUDZ0?=
 =?utf-8?B?SkFRWVFSbStoQWROSUQvTG9CVjd4OW1lMjRxRzRTSHJpRzJZNEtTQ0RoNEdE?=
 =?utf-8?B?WXhzVGRtK1lCYmo5U3BRRnk4Wi8rRHZjRGhEV3RIdktCNlZ4Qm00RkU4NEsr?=
 =?utf-8?B?Qmdqc3B4RFhPbzNmVmNia3VPSlpQdkw4Vjl5cVBheFRTTUp5dnVxRU1lMDZC?=
 =?utf-8?B?K25pUGswNnlMQVZzemtJdjlHQWNhWjdydWptTlpMNEZXVkRDOXNWY0tvTlRx?=
 =?utf-8?B?NXNpYUtHYjltMWNyeFJvc010bFpmei84bUprUDR4QUtiRng4UHY3OUp4eDVn?=
 =?utf-8?B?dHdIWjR5aXNSZXJJbGRueU5hV0hTaFd6ZEpsTlAzamZ4MFIzNWV3eDVDcXMv?=
 =?utf-8?B?emRBS2RyWTk4MnJONWpSclN6Z2lwb2FhMHJOd2FiZGh6ZVU4VlhVbnlGK1k5?=
 =?utf-8?B?SGo2WFVRZVVyNVBJbWI4S3N6ZmREMjFQZ0VPMVpnTGJMeC85RU9Pb1BIdFhS?=
 =?utf-8?B?dnJ4bTRKejM2U0J2WmZsOVNYVGJkcWJNMjdDeTVpdXZ3WkczOXViZzJ5UmtS?=
 =?utf-8?B?RzJYSTRpVjFUbU95SFlJVzVaWURnWjNwVW1pNCtTallKZkIrRzNWQUQvSzFL?=
 =?utf-8?B?RkI3TG13czJkOTQvZjhxODBRNktrblVHTUZCQjI5ZTVoQ2I0dWJISG1LcTNl?=
 =?utf-8?B?RitEVzBhM3J1QmNnYlJOZlRNSkRsTlA2bWpUR2RIZGR1M0pVK1JmL0IraFd5?=
 =?utf-8?B?eGllN2c2K3BsQ3ZlTDB4dlFRUldqUmZrdHRWSWlmRDJRQXpMakhiNmFtRFRS?=
 =?utf-8?B?cWdUM2VidGxGR2lCN2xNb21TRjd2aHZGcjRQUjhGQmI1aFBzbjVlZDdlL1I5?=
 =?utf-8?B?WlNBZ05VRTJWU0JuR0IvRVhqSCsxZjNZTFZoM0tLMnArVlZjWVdldFU5U0Ux?=
 =?utf-8?B?eGpjUHozOXJCSEhYMXg4WGV0eEJ6WmpxMS9IcTJER2ViOS9EbHpYanE5ZGNI?=
 =?utf-8?B?Tnc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1e1c04-7ea1-47aa-8cc3-08db6b589988
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 15:20:48.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T286B/YslbhQLgPIRGhmIMYsLZ0vKbqoFdgTxakOPnf2lLB3eGtLa/MXnkB5pP6m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6067
X-Proofpoint-GUID: T8-Vj3ks4LVH0ZSWhKVsF_bOVSQ2V8U6
X-Proofpoint-ORIG-GUID: T8-Vj3ks4LVH0ZSWhKVsF_bOVSQ2V8U6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/9/23 8:50 PM, David Vernet wrote:
> A prior patch added a new kfunc called bpf_cpumask_first_and() which
> wraps cpumask_first_and(). This patch adds a selftest to validate its
> behavior.
> 
> Signed-off-by: David Vernet <void@manifault.com>

Acked-by: Yonghong Song <yhs@fb.com>

