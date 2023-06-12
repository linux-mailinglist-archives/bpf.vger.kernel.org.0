Return-Path: <bpf+bounces-2416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2321F72C9BA
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616511C20B30
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D191D2D4;
	Mon, 12 Jun 2023 15:20:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56B519511
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:20:10 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88085E47;
	Mon, 12 Jun 2023 08:20:07 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35C6brUq028978;
	Mon, 12 Jun 2023 08:19:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=GihBGnxm7xsTFxTvYbNcCUOkQ8XwKK3+tYIspk2c0G0=;
 b=bBDlwliAgbI47P2mRrjAv1V4051BDYcULZrUSqzBrFunSSNHIugEzUYyHCjoAA7ZNv8U
 HDOLZHTzSNFgwQjjjo1U6fqJOm1JHkuH8O7aJa5cnrx3yv9gBIOyFZTlaa31raORsq/r
 yle8Pp/2Op/XWMLi5PvaAO2iRqQXsnFnGxI9+qkY0OKf09Z5zrtHJrIGG66fD6ImgJmG
 N/szvmiKU4xsEvToiarJMYRYGwMecxeKPss+lELurcIu2QLo0mxC1txZTd0s87lGU1XX
 pSOZKfsrEbHweLGBfNwFPAPyS6CCm+gPVwbaKsDIO9kpLzt5p4c3CFf6wZgH2pWN711u uA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r5x8yju5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jun 2023 08:19:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAFu9Thb+rJYpg2ACY1JBMul0xuYBqhBawcE6BBWpCpCF3DclH48pW6hLp0gW3IjqbLGK7R2Cm9UtyZAZPOvAP9EZsi/XvOCCEuu0zOvE/Zbgz4RY8z9e+Y4cXlufLxQoIXMcVwklhpCTOCEcCqW04immfcEB2RjZrqNdFsSGSwdSWnSNwmr4yjkP5VJJVAYWn5kRuWd00b2CBDmEUbFRQ2xjY5koj61vmaS3pqOZmxcMsPbc9Bd546/MV36vukIvDS3aHk1dlX9afFNlAF4Mp51C6M8/EPtaXTjD6VMUXZoEZM9av1BlNgOIo+hz0O6eT+L1HT6FqIubc02nIfw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GihBGnxm7xsTFxTvYbNcCUOkQ8XwKK3+tYIspk2c0G0=;
 b=Xqju1miX2gLTIboZjDFLSoZBLL9RSPDeSw8yu3UD9HfPYQV2NMrKSXcTl+EQ444IOj1WSDZi/ptQOwkR01retNQsGYK2cUEx4a3jrOIJj0vQsMOZoWYtjw0ZcXHzlNXpGYR0aB1yD6adsqjwExbOI8QX69ALAVUtHGj5ntHKKdrVNSahZNobhbGgJWMHvqyA+fWtxiQ+eV24xRND6zLiPN4OG6Xvz8h5uENQNsfO5STpHHJFoy8w/90DpcAduwXd3+62paNXq1vlbjcXXDzVsc85FLNPd8Kf/UeNkGxZaUeKf27P4L7aTvwmI2Zg9ijb87r9a9FpSO4ZYVs/zS/p+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY3PR15MB4898.namprd15.prod.outlook.com (2603:10b6:a03:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 15:19:43 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 15:19:43 +0000
Message-ID: <7575cded-9fc1-7ed7-da4d-bc4147ade742@meta.com>
Date: Mon, 12 Jun 2023 08:19:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next 1/5] bpf: Add bpf_cpumask_first_and() kfunc
Content-Language: en-US
To: David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
References: <20230610035053.117605-1-void@manifault.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230610035053.117605-1-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BY3PR15MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c5f26d-6dbb-49cf-245a-08db6b5872b3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zytvn6/vvHiXTQi9HJOcJy3umdym1WyKtzu1Jyy5sdkoxk8663ypQWYLOSsHhLsnknvmmjGmQoOA7yFKyqCTw2qkY/I6w/M6sO2U6EvQZgxEfbnqjk4YmpwZhufxtPEg+LCPfPfkSVVglsYP9aXnZXwH3ym0MRs0wXXgSfGrgN4z36JDfOJdP3ovYOPsL0KVgEjZBiccsbiS3tDDaBzFgC6rJD20qR74CVS1G3JyrTRkl9OLO6CXun6IwNuVWfBlpyJVnyUtEEG7NdXExqyLYQvbJS9SGJ2eWMW/7zbuQcuzuJJreBM3FgZKz+UnNOTZNnRIt8Fl+jGFh4eLB2s7T2rKGwjMGNJ0TOkQgVUu/hwXbmoOKbgaT2PucxyOrD9jq/Eq92Zq3xt+izX06lQVTdRkx3hn4v5LW4pdXB1XSewLttMuTYro7vXloYZHN7qMOcIxelR9CINeVxdl5Mu6rFYyTP0B8yCNyzJws7os2ZMHP3PrihFt4ebvowCx2DJGKp84Ku3Vx/+DRWVNQVvpraUZew9YKaZF+Q3w2W4b8q1g92/TAEvz7Z+I45DnK7TVN2Gt65/zTg8Xf1PrsmRi3/PQ7wT7/Qs97S/YConfoamBfn04ji9fQm0Efp0lzyxKBvvA3XBKHmF/atYLLrRnqw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199021)(66556008)(66476007)(66946007)(8676002)(8936002)(36756003)(5660300002)(31686004)(478600001)(4326008)(6666004)(316002)(6486002)(41300700001)(38100700002)(53546011)(186003)(6512007)(6506007)(7416002)(2616005)(86362001)(31696002)(83380400001)(4744005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SjZBSVhuWW4wTDJ5c0NEc3A5OWZaOWNTNi9Jc05Jd090b29nVGZOVXdabnpx?=
 =?utf-8?B?MGNmTDJzOFNCK3BHVU8vQVloTkk4NDBHbTJVZktmaU1CaXViYUt2TXI1N1l1?=
 =?utf-8?B?MlZkMy9SeFE1MVdObTNmcmJwMkVmNzVXVFpzV1gxZDFheHJRejJYSHIvSjdu?=
 =?utf-8?B?aVdqQm82U0IrRG10VHArd0w3L2Z2WlhCRVlJMUlOS05RUjBNQUhDaTdLZno3?=
 =?utf-8?B?NlFQQXVlVmFwWFBzZ1NicjFyWlpZajJjRkl2MjlsUnlkTE5Ia092Y2RmMlpp?=
 =?utf-8?B?YnFKdm1PVUg4Sy85MjZla1RSTHU0bnM0VmQzYnRxMmZwYlhZeFZqbzFHTlNw?=
 =?utf-8?B?OTVsanlvL0xoa3cwUEp3Q1FOeENBRWpRYU9WV2c1RGFsbUxVa3VSSG5kcXAy?=
 =?utf-8?B?OUJndnY0Z2hudjNNSzIzSkNscGhFLzUrMUV2TTFTYkl5MHltcm4veGVjeVdO?=
 =?utf-8?B?NEJJUFV4TFhET0gwaHFqMzVaM1pIRWtSKytzbWN5RGxGTHVYbThJSkFMRk1a?=
 =?utf-8?B?dnhMbGx6Q2EvQzhFK29ZT1RSUWh3NEFZWGxFMmJNa0pPc0ZiNG45RjRobUdS?=
 =?utf-8?B?cmRBMS9zUk5KSU9YRU5SOFdvOW5xWEs1MTJsNjUzWjNjU2NHaEhHQkhIVlNZ?=
 =?utf-8?B?cXAvUkF3dG52azVaaFB1aGd2aXM2ZFNVZXovOWdTdGxjWWVrc3IwaTZkZkxI?=
 =?utf-8?B?OXdoQ1B4MDBVVmF0elJqbm9CSi92a0tNei84SzJGdGxnRmlTQkNwZEVLUVgy?=
 =?utf-8?B?RDJJWk0wQ0krLzJEdGY4R3l3Z1l4dnB6ci9UN0lZa09vT0RBUVJ4SGxqd1Mx?=
 =?utf-8?B?YnBkb1lhWFJiQjEwSCtoN3lUU2JXRVNBdzVOWGNkS3VBeHVkcVc0clRsUXM5?=
 =?utf-8?B?NEhGUmNRaGc0a3d2MlZRZm1aQjU0ZUx5NlFwckFpVkhYaUEwWVZxY3FJWlJ4?=
 =?utf-8?B?VEdQY1VmMTJ3U0dZYnlFdjVZd0VTeEFlS2lYT1UvVzBrWEY1OVhOUnZlNzZE?=
 =?utf-8?B?dTJTaHZCS1JpOFdYQUUvWk9BejdFVzMrVmIyTDFyU1lLdktnMU0rTVN4YUUw?=
 =?utf-8?B?OFpFcFZCSHVhSFIrbGZBcUtaV1VaRnYwUGpKR3AyRnUzNW84WTFhT21tQ1ND?=
 =?utf-8?B?NFBUUi9rU3JMSkZ5ZkpWZWZSVTdCMWhjM1UvYTZ5cThlVmdjNitEVTV2WmFB?=
 =?utf-8?B?c3ZZQ0d2T1FtT1NpRzk5L3A4TTdQMjNBUngzRmJZUmhlbjhTRmRYR3lTczVS?=
 =?utf-8?B?VFRNTUF6WjUvQUIxQU11KzBXSVFuSkE0WGloeVdxZTBCTHpFaGVrS05aaklM?=
 =?utf-8?B?N0xjeUk2OGdsdkxNRnhMbFJLQjMvNVN5OVg3OTR2bFpIOHAvQ3d0THZob3Y2?=
 =?utf-8?B?b3R4T0RiK09QRElLVnNUK3BJdmUxbUdJWGJCVll5Mm5CdWRVTUJEN25mWXdh?=
 =?utf-8?B?TE5mVmM4bHNhTUppcjJWamduWjFFNjF4STM4eU10cms2aE1CZzJ6MWU1cHNE?=
 =?utf-8?B?OHhrZkpWSkxnZ3p0WTZEQ0RMUVA5YzlQTzdRU0tQUG0xeXUwMXc1Um9mYzhE?=
 =?utf-8?B?WUxjNTZNejFMd2NwWDl2eG9KaVF2VStiODQyamZ4VEpUMTBqU2I4UVl1bFdP?=
 =?utf-8?B?endaTUF3YVNQbHZrd2VVVWUyQnJOdjIxR1d3STgwOUxya2w1d2RJUE9iU1V0?=
 =?utf-8?B?MlYzQ0MvVndaYzFWdmdpWkZ1TklQS29KNUdpSWVoTk1EbVZpdzFxVzdoOVR2?=
 =?utf-8?B?WEloUnRoSGlwQ1drT1dneHAyeUNQb3ZVU1YvM3MwblkyUGFkM3B1NEw3VmZN?=
 =?utf-8?B?NXM4c0srMEFkZTFiNndJMmN5YzA5UVhNempGY0htTkNRZi9UZTdhdkdsVDdw?=
 =?utf-8?B?Q0RzWFc1N0JPckNZeVZCYzhFakN5Z1k3dmQ0MWpGUFhoeTBFWjIvU294akNo?=
 =?utf-8?B?SmszU0FHUjdFV1Rsa1cwUk0yaThHR0xzWk90ZjZPb0ZaTWM0NlhYWHdCNk80?=
 =?utf-8?B?MUVXcW4wVUN5KzlpRmY4TWxzSTR2ak55dlM2YjNKVlpVNHQ2UnFyTnUvai8r?=
 =?utf-8?B?eGlja2NPSUgyMk9Bb21wL0hDTkhBa0x1VXhraCs0QVZNamlnUnA2MnlheUNh?=
 =?utf-8?B?YjN3QzRVN3dZaEtuMWpyajV5V3VmMmcrcTlpWTBNdG9FWEJyU0FDYkM5L29Q?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c5f26d-6dbb-49cf-245a-08db6b5872b3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 15:19:42.9953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQes40Z3Kb0UPwN56+cUV9bfX2vOQBEwvSrP03+9kIyCLHZB1ftx9Dm0Ri1jrhde
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4898
X-Proofpoint-GUID: GMsr9C_nvO5pehwDLLIHZ1yaqKJiVi0z
X-Proofpoint-ORIG-GUID: GMsr9C_nvO5pehwDLLIHZ1yaqKJiVi0z
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
> We currently provide bpf_cpumask_first(), bpf_cpumask_any(), and
> bpf_cpumask_any_and() kfuncs. bpf_cpumask_any() and
> bpf_cpumask_any_and() are confusing misnomers in that they actually just
> call cpumask_first() and cpumask_first_and() respectively.
> 
> We'll replace them with bpf_cpumask_any_distribute() and
> bpf_cpumask_any_distribute_and() kfuncs in a subsequent patch, so let's
> ensure feature parity by adding a bpf_cpumask_first_and() kfunc to
> account for bpf_cpumask_any_and() being removed.
> 
> Signed-off-by: David Vernet <void@manifault.com>

Acked-by: Yonghong Song <yhs@fb.com>

