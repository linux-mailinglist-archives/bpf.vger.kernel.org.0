Return-Path: <bpf+bounces-244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F356FC815
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 15:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C49F1C20B56
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 13:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81994182D7;
	Tue,  9 May 2023 13:38:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A735DDD5
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 13:38:50 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251283A86;
	Tue,  9 May 2023 06:38:39 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349D9UrK018655;
	Tue, 9 May 2023 06:37:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=6+oqOv08S6xbMUjM9FQY53ALETOW628tqr16LHvYIaw=;
 b=bhaLMzOHmyjwPw/VRMHsvlnDWJ5OKL0i1YeRhSJ4qruUvDdm+HX1cGOBvCtknlESStOg
 c6RUeADvWKkbBlJXUxwpJ+tdxtNnXjsayruHazyg2/IdiaVVjEs+pZidrHzRL2ZkgKMl
 BCIvkrV9mDn4jAg/OaK8inw2dg5qpvu/Do7BWF+HB7zmI1d1GgC9dCb/2ePIJVJJdW7P
 hZAwzaEMicf8EHJZ6CgvU4dGTCU3ksC/QXnZ7N/6nDvr+4UT841u2TJErzHHkTmzk5Ir
 +F95CkNyNUGEfTK0TYkysHmLtlSmzjBU26jW5fuiWv1WHC4M1JnOM2wNsp55aINWK/Ta Aw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qf78d5h00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 May 2023 06:37:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8VlosjdxB/4usppy43WNQ9TRrS44IR04ClGiSVmXx+R/XmxRrXcrJXR8IFOrZHHEVGqF5pmjGvNyjs2MIITPu2laN6TR0tptdnS8kvM9yPMEfvn02OppUZMyReuzFYdTVvEA87Ce+pXokO3rqcmiX4+NHLLb8fyVfR0adxJ/clVT1zb9AiFZPcZx5GbCaRZHwtgN7W+V9dnAOI3HsOGfGz19C72oPH/YaGr3MPeIco/p2kbzwAWIxARfm3vqNHzy5Xy7DeZt76ub7G6eIJuqj2nBjfH96PhDjXk3sBmP/wsIVA45KbCGVt6d07XoRaaJAh2UFtqkkuyh8GdcQgzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+oqOv08S6xbMUjM9FQY53ALETOW628tqr16LHvYIaw=;
 b=Wmj3wbnr0JX/9KWrKP+ShvUnyFR3H+QjqqLiCSSKuqjqy5QwDFBPs/wLVYte9osZRsMCm2I1U+TeOERN2MWfyRrXTITswqbaA76lnKGw8qAoVhwhku5FWMDkBUb3Dw252WyC/3lYopPARQiXlEEU2EQ3CGoszRvsCDjIhcxJHFk+XBkNWLRwy96P4wZt4+WGsGdQ9dviD84+OtAadsb33Jo8zK8CsaSXih6J3lPa0PvjAgq5Pf98uIVsgwFb8HJYWspLxzymCoFUB1sorCiHiJo6cKcl3/v2iCFgusT1Q5LXlGyawn+SyUC4c08axqHpVbhCjluRiab3lviix2dWXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by IA0PR15MB5571.namprd15.prod.outlook.com (2603:10b6:208:43b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 13:37:50 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 13:37:48 +0000
Message-ID: <7cf68bd6-c103-6b0b-1929-86b53079db38@meta.com>
Date: Tue, 9 May 2023 06:37:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next] arm64,bpf: Support struct arguments in the BPF
 trampoline
Content-Language: en-US
To: Florent Revest <revest@chromium.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, mark.rutland@arm.com, xukuohai@huaweicloud.com,
        zlim.lnx@gmail.com
References: <20230508164650.3217164-1-revest@chromium.org>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230508164650.3217164-1-revest@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|IA0PR15MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: c41e0bc4-b3a2-4749-4003-08db509293dc
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	x7701RAauhDt8gGiDPppOyBE7Uwh5c3wSk8TNGKx5XLbhLrpdI8WARUC3Cz6/vI1KRSdMgu6Q9St7p2qChLGKhMaVXh7ivykqZsSICQutz3jb0ciYAZPOAdwApXJd9w0YmgiN/4DE1C7uFQJTSZxmEqjcBqBD92YO4Izdoo5wMnbP8CVAj2380MQg2vAKEj+PKz7V1b+80OMyBUO5Tn1PP4ndivZN2NBrA2gB8JrNFQm48D1Mz1aWx84uf6tgVLmHtrScPeSLpGte2yhpe68EKkJsWCYFRrmwMt/FnhBkcoA7k4lmCKtqdVXWULrYhtRJOhTvjaTbPBRHKUHE7tCN9IMdAktgeyzyi+qM8iIJAu9hDSMfSEXha9wRMHCikikeQ4UGyGckd1XGZ/EpUqePH+8VD+NJ4sv/e7tWs9gUHLLEVxVUjo5Rp/I5ztxbGMMIjq5gY8u1TCmTx9hjOvWY6c23kc6JuJAAsisYqac8LbQ7XEjMwDmfQ6+YwxmNSWLtzn4PP+W6VFurhuEhnTHooxvRkYpv7oDZ57gCjage04s9rMyXzm83jFiSednVmuuI0e/wNkwaCoHOgyXdW/E2kqEatyjrERFcnM+x8nBFxNh+Hktve6Fky/SSulRIASZB2Esaqd36+gL0DYvDaDogQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199021)(31686004)(6666004)(478600001)(66556008)(4326008)(6486002)(66946007)(66476007)(316002)(86362001)(36756003)(31696002)(53546011)(6506007)(6512007)(2616005)(4744005)(8936002)(8676002)(2906002)(41300700001)(7416002)(5660300002)(186003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SG1EUkRMZDBMa3kyZmk0WFllOUo5OTFmL0o5dVN2b21ZNHJsQTJlWUFHZW9L?=
 =?utf-8?B?NHRZQ0ZjRWdNM1JaR2t1ZGxyb0tvdVhSdWMwbXFxSU9TZEp4TzVUWU9XZ1lC?=
 =?utf-8?B?UGpxam1oUUV2TldDN2QwQWRkc0dqYnBEMlZCOGUwVjQxc3FLdmg3Q2MrZXhr?=
 =?utf-8?B?ekVSM1B1TFhKOTdwdXV2YXN0YUxoVm1rdldEeEVhWXlEVHp4RitKZGtCUGs0?=
 =?utf-8?B?L2R3L1VDY1o2UW9ZdXlHcWpROG1CcnJhVFl0emVvYWdjK0l5blBJVG95eGJy?=
 =?utf-8?B?QkwxSS9lY21GSlh0L1FsWXYrLzh1MmNFMkJhdXFrL2YwT1ZnY1dsWkhJQXg4?=
 =?utf-8?B?ZXFTSTRDeHpTN3BmWjNVSVloRWx1bXNOUVhlKy9wcW13N05laHhvRnZDREky?=
 =?utf-8?B?dlp6UFJoUjRSbTNlelgycnRrOFZaME1FeFdvZHRYOGtaemU0S2FFd0QwMTdy?=
 =?utf-8?B?cEUyV1lDU0VMa2NEaStXaTgzZEErSmRBYnhQeENXUkRMdjVVVVZPZitzWTc2?=
 =?utf-8?B?Q25LSlhPTVNHMlozODdQY0dNWjk3Q3dWMktoeGlQNjVFRzhuYzhsenNIczBn?=
 =?utf-8?B?b21VTklUZzRVcUFaV2d5M2VDWTAySm1lVEgwcGc5NGdXN3VySTcvQ1NuTHVW?=
 =?utf-8?B?Z2U2OW5HNStOcy81SHVZMStBTXdNV0tOWENNemFHOG9jTVBIcE9rMWErZ3Mr?=
 =?utf-8?B?YUJuMHVmRnFwMmlVbHEyL3lTMDl6QWJSUC96VTExcDJ5TzRrMVFsS3hRbEJx?=
 =?utf-8?B?N21TMWYzSStuUlN6Tm9BNzdXS3JYTjVUYkpVVzdQVlZpS0U2R0JpUmxPMnVk?=
 =?utf-8?B?T3YyaTJXSWtaYlJxS1ZWZGZ2RitUeWp4bU80STEweVlMM2hDVEpTOGZEUTMr?=
 =?utf-8?B?RG1Eb29zZUJWUWdOeTlwZGU0bW14R05yZFdOckgyQnJwcW5PRytEQUhoKy9E?=
 =?utf-8?B?RlZjTjVRVlpTL3RHZlZTVk96TkVJMXpIekZibGNNc0IrdmxDZ29SN0U0ck5w?=
 =?utf-8?B?RVBwaWRiT0J3cTBESytKQkxYb3d1ZEt0cHZkeFVLdklsdFJGUEkwMnhhWmlX?=
 =?utf-8?B?R1JLa3pmRU9Ua1VhdE1WMk1RY20xMGJWQWVtcGNaeU1sSHFTay93SWh3SnZF?=
 =?utf-8?B?VWxPWVZtbmtveDdhL0lNaGFLQnJtSUxjdHlkNWd1MzRjMVovQnY5V1pubitn?=
 =?utf-8?B?dU5JR0cxcjU2NUJJTDA4VHFhaTlQSTNwMWowenp4OWlaYUNseCswMmg4d1Ew?=
 =?utf-8?B?NEpKQzNjek5NRW1SOHYrRXMrc2YxYUYyMTdsVWtnalhtQjlJelFDYTVLZnpu?=
 =?utf-8?B?MjR3V094eWJqT200UzFZMEg3TE9zQlJaQ0w3TDlnNlJCVGxUK0R5ZXVwRnhm?=
 =?utf-8?B?UEp1dEFNZWo3K01TMXJpT01Oc2twLy8wNGxDODdXeUdCTXV3UllRVDVPQVAy?=
 =?utf-8?B?bEtQUUd2bGZjZjBraEJsbCtGQldkbEtUSXpZNG5EbnBRK2k0cCt0cUN4V2ZU?=
 =?utf-8?B?a2NuOXFOYUlTTHA2bWN0MGxSbVFva3dmNjZVTjJCS005ZmZmYmZIZWlFenZ3?=
 =?utf-8?B?OTNLSDZ2WEFnUHBVczBaODcvODhrREdlOHVWTDZvZC9MUXdnbk8zaGdFNzNk?=
 =?utf-8?B?RFl5M0d1aG9xNHZQTEJsUVQ1NlUvUlV1M00wc0dHai85aHYycGRCOWRqUFFD?=
 =?utf-8?B?R1hYQllvbDNSenAyTkx5eFFFZVR5WE9hNUZoNm00T2xyL0lCUjVUbDhlQzgy?=
 =?utf-8?B?Y2NzZ3JUZFBFQ29VckNPbHdTWUVEZ29TUmtLSVg5eVRwOERGK0dnUEppcnY3?=
 =?utf-8?B?NEt6NDg5NERzcEcranllUUR0aFlTUGVrKzRUWE9zUVl2N3JTRGtUQnNaaG5k?=
 =?utf-8?B?SDdLSXZPM0lKdTdVNE1uZ0ZXQ3FlelRNK3ZkUHY5VC9MSTI5VExYT2xPZ0ll?=
 =?utf-8?B?dkd1UFRVaTJEVVUwUHhGMnlidktSRUcwU3pRVzdQOWtHdk9FTzNCZ3dSamht?=
 =?utf-8?B?eS94MTBWSUVXaVIwUzhpSHp5VTBsRWVCb1JiREM4cjNjT3MwemkrVVJWcWJz?=
 =?utf-8?B?Z2drZm9wN1ZjTFpzdmRXSEd5aGVHdE0xZlpXUHVKaklnY080M1Z0cHo1ZHAw?=
 =?utf-8?B?TER6SkpPZFBoeFMrS3RwZ0lZUzgydG9NTUdrZHRRb3REMC9ZdUF3eDkwa0J1?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41e0bc4-b3a2-4749-4003-08db509293dc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 13:37:48.1013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHyhk1SfmYH4iz8Riw2+du9SVA0YDHKHDIRDkRzf8ERlawZwdaDjreXnpWt8ATNe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR15MB5571
X-Proofpoint-GUID: umGC6xq7ul4xd8WBdsFeIaldebLd1GU8
X-Proofpoint-ORIG-GUID: umGC6xq7ul4xd8WBdsFeIaldebLd1GU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_08,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/8/23 9:46 AM, Florent Revest wrote:
> This extends the BPF trampoline JIT to support attachment to functions
> that take small structures (up to 128bit) as argument. This is trivially
> achieved by saving/restoring a number of "argument registers" rather
> than a number of arguments.
> 
> The AAPCS64 section 6.8.2 describes the parameter passing ABI.
> "Composite types" (like C structs) below 16 bytes (as enforced by the
> BPF verifier) are provided as part of the 8 argument registers as
> explained in the section C.12.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
LGTM. Thanks for adding support for arm64!

Acked-by: Yonghong Song <yhs@fb.com>

