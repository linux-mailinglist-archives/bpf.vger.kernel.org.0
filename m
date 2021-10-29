Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5A84404EB
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 23:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhJ2Va6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 17:30:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27162 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231293AbhJ2Va5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Oct 2021 17:30:57 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19TJnWbJ018652;
        Fri, 29 Oct 2021 14:28:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=AznyUoppprKWRJcwY2YBNkMYxYAHTQARPuopaVVOxs0=;
 b=kpLmIKWfPhR2YE7mkCkHRI4DIkFmA4zSh/zPLI7deUvxxHPjT8xsCBfujSxem681zc2l
 sef+kZoiAYZCyAL3aQbveidyrFhtw90SGrII+yzXG12HJ/+qj2/F6bol7Q37peZTP/eg
 q1YK1N5XvG/Cn0Mryab15t0IANzAQRnP8Fg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c0jnmkmqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Oct 2021 14:28:15 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 14:28:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUbMG29R+s1N/GPvcuhQuC2kma1mW3M9Lea9gt0KCGQuksNwPj6PrIhC3wUUxEa4aTrzPMjkOL+hggG1+rrTSkQHgbLtOswOxkr8dafWinKIJ4Iy50fGhYiWh1ei1NfXYC3JeiYY+GOym5sTbmHi772nNHE6u7yqGAeM6YeSnyMCe2KrLUQUhLMfZCLWiiDIRAQDT8kPnd0/LPdOepsju9/kJGuwJt+d+DO6g3/bA8yuFtJ8ezQTgAgLPqg2q6rm7nluL6zJGgGQUxGAfxhdWH1mv2AAHgN/qE6LG6CdmLQc/27bhUO6wFLomM8HnvPo00IOqdNKR3nkRrPkYuJuiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AznyUoppprKWRJcwY2YBNkMYxYAHTQARPuopaVVOxs0=;
 b=NETRxSP9Hksmu8TC4h8u1Z4MlqBia+EJFr/FfebvDBdGxkcHdxqfExQTeeNC4k9nfm3e4FswTIkGajmRDaJKQudfmsJ51r2nOMGwHgsNMZk/bI+8v3NXcL+kuYjm+wSeS+gpNi9T0iOOqDh47wn0XXUXxY+HeSxGy5GJnnkFyurSGicK1A2oit+t7fgvzIaWAPzKAGDbYN64VJxoVLKEHvpmPRF5zQeORCd3R3+zdcbuNnKob7Imvjb1fWB+z4gRsU04DtKgiZ7BXt0MWlt6P2MEmEyq34VmuW56aWFzsrsNqcsjYdoPPTcrG0cyipssIUqQEemiaxO3ZL/oJkxWWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2159.namprd15.prod.outlook.com (2603:10b6:805:d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 21:28:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4628.023; Fri, 29 Oct 2021
 21:28:13 +0000
Message-ID: <b2e66cf7-7039-1d12-112d-5baddbbf7b4c@fb.com>
Date:   Fri, 29 Oct 2021 14:28:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next 1/3] bpf: Bloom filter map naming fixups
Content-Language: en-US
To:     Joanne Koong <joannekoong@fb.com>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>
References: <20211029170126.4189338-1-joannekoong@fb.com>
 <20211029170126.4189338-2-joannekoong@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211029170126.4189338-2-joannekoong@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:300:117::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c1::17cb] (2620:10d:c090:400::5:47d6) by MWHPR03CA0004.namprd03.prod.outlook.com (2603:10b6:300:117::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 21:28:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfc6410d-e8ad-46c8-4dd7-08d99b230310
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2159:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2159B77998184BEAD3117695D3879@SN6PR1501MB2159.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tSnI/rZvblbRFb8W90T+v7dZqf9ibiUjQZtDLHuc3GvhXdpr05HlV9MckPjFXJjPxM8MFrz4HEAF2EbQZE00Zjx2O8FwdOtYxXFL7911o76w38o565LIO8TU7WQC5R/AwbgmGpO43bCBYTaQk3mR3yYhD3shXF/RHRk4+XwdYXAiSpFY1vchck/dhmm4DDiPFB0H7DGvMMOpq++RWG3LDXT9t7oa4QVjLiknxX2cLy5gXU1GlxRkGI7zvpgM0VygkahK5l9am37s5MweOoi4OY1Hy0KWlPazUY2u4zrab7b+M8CgtPXmg7mHyI62sbPwoSfw1uZgWZ2H48ypucDT/5oxv6RYdHo63peOChjwXaazIU4S/aer62pe+K90MyEdPr3m1CMLUcXzOvS8bV7+5QDoEi0oad/EYYQXJxU73DFIgE5rOGqHb4gby/dlcHPWAUPWwXucD1sHiWPSyCF4b2/aZrZxSEsVd+Ar/coyQIvv0b3Dt+ren/Ga4Bw8qitofKFQdClBkMktyzBFk3xThqAADrE7osLK5CKe2u5Jd2WSy//SOSChUPxLrfHMhE2Je+FimtpHEnHJLJdTuSjFQhcf3xtp0s5ZT/S7pC52oSiHoCnqXMbta4mUNKqjvvyOlusp88ggASioiGu++z5a2JwACXJovaoJPWqCplhmHub+cVVg+mQaNTeAIBn4/IdDQsb/gubUWO0yrM2arkyxHm/mMbieLY3VmCLaqmkh6Wk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(4744005)(2616005)(53546011)(86362001)(6486002)(52116002)(8676002)(66946007)(2906002)(508600001)(8936002)(186003)(4326008)(66556008)(316002)(66476007)(38100700002)(31686004)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnpFaFJibEZqSmhIcjhqekN3USt2TzA4cUR6Q1dpWE50WG1NQS90bG5rVGF2?=
 =?utf-8?B?VUs0QnVndVRnRzNsdTJ6aEp6YlptZWFVaENCKzRvUUdXWDFUUHlpdnJwMGdE?=
 =?utf-8?B?TStFSENxTjlCZysvTm1tMS9kOHZGZzBPYTcvc1hwa1EvN3BhQWMrRThIZHgr?=
 =?utf-8?B?c3FjWVlHVEpVblBUUUVUb1B2T056QlMvaXNYY2xYVHhRZkFiSFdQSUI2SUJy?=
 =?utf-8?B?VEE2RVBLZVdFdCtPM3ROcDdUbGdjdEtrRUp1SmNIczZCbzI4NTluTUNYdThY?=
 =?utf-8?B?bDlNUWtRU1loV1VaYUlocWdNeDJkUDVUeElGbU55eDRMVU4vdFAwZ1pCQmlJ?=
 =?utf-8?B?ZFZ1R1RZdW9zalNSNUFxdnRQRlFIYm52RXRMb2twQk1QL3pWVk9JMW1OOUtp?=
 =?utf-8?B?d29IemNoK0xTUVpXbUxNV0hQenRaL2F0ZG5JMVBRMkEyR0JhVkoyNTg1MVQy?=
 =?utf-8?B?M2ZtMndGSXMxa1NiUThZRjNaZTkvZlR4NWFpb1dTelladnZLbW0wWDE3VzRM?=
 =?utf-8?B?aTlRaFlqRHZNZVl4UmhxUjgvZmVaTlZtREwvcG5ZZEJvZjNHS2FuU3JWV0RE?=
 =?utf-8?B?eGNkRDVrV2RoL0tRUjAxeGNlMlpJUTlUeHp2TCtkNFI2Ukk4bFg2c0UvdG14?=
 =?utf-8?B?Y0JCZi9BaWZPU2JHSUtwQmpJYkxoOWxRZWZjU1oyUHpwN05xMTdtbzRYeGox?=
 =?utf-8?B?TnFqR2dKOHBYV3M5R1UxNndxeXUxSnNrVmhlVGF6WVBjdDBwWkJUSzgrUzlp?=
 =?utf-8?B?eWtoMGNkSkg2aXc0Qksydm83QnpuTEwzWEhJamVNQkFlT08xZ0NuZTZ5a2J3?=
 =?utf-8?B?b29UL1FDeFE4T1ZlcDREdEdNZlk1MlR0cjNpdC9Mc1QzWDFSM0IzSUFPOFlu?=
 =?utf-8?B?QmRTUlVxZUxEaWRlbzJjOENwYkxxamhwaFNRSDg1Q0x5d2NYTTFhRVpIOWxP?=
 =?utf-8?B?SEIvdkZVZWhpY2JQanNEbG1RT3huQksrUHBZUk9LOFU5ZTJMaGtuaFRjN284?=
 =?utf-8?B?YmcyMHJDSUc2ZHc3aEtmNUU5N1V4RzZPYy9zd0pqcStnNGtxOEsyN1F3a3dW?=
 =?utf-8?B?NEZhU21EOWdoNXJpS3B1QjQwb1pqQ1RwS0x6UzZjODlFZDVXUW1tN2QwcGZa?=
 =?utf-8?B?MkR4bUlpZ3VLbk1kWW11YVhOai94WmszS3pIS0hoR3NhQlRxaHE5VWc0Vkx0?=
 =?utf-8?B?MnNaZmhFb2tReEV6TzJGUy9pZTNMMVlxZUI1eVE1dG8xaTBkdHJxMDRhUnBh?=
 =?utf-8?B?VmpTa0tCdUlKamdrOFh0K2YyYjl2SmVnNit3M0k0YTNlQTNwUFJMMmgzeFRi?=
 =?utf-8?B?SUxyRlNpeFV6ZnpmTEpqSlc5WGNRWFFRYzRvSkpUYWhMdFR3dTBuVlZRUU5T?=
 =?utf-8?B?U292akZ0SnV1akFIbWwrTDBPd2RleWJjOUNBb1VsaWU4VE5yK1ljZ3VDbFV2?=
 =?utf-8?B?M3haTUJwcFMxeE4wUEVBclJ1RC96RjBVTHg0VTlNYmU4YmxmMFdtalVXUkR0?=
 =?utf-8?B?bFZqc3pNWitZdmtyeFNjeGd0OURSZW44aGcwalQ1TzJ2dkpXdThzdGt0WWpZ?=
 =?utf-8?B?WS9EdnJJUWxGQSs5S1F6cWFvRGhZQkZNNDQwYVRMQjJyRllKdHJ1M2pUQ0JE?=
 =?utf-8?B?R0xNNGJNQ2V6TEFJeDZvenpGNnYwbkZTaVAvVHU2bHRkR0VCdWtkVVVTb2V2?=
 =?utf-8?B?MHI4RmdqMW43b1pIamFJQzZHN1ZtMkhOcVNjWGk2N2NhQkpNaEJUWUhRMWhK?=
 =?utf-8?B?dGFJS2ZyTW5KMnhIUisyaitHeGdmdVB2TDlaMUgrcGtRUnJQWERLY09CS0tD?=
 =?utf-8?B?aFltbUlYSGtKQjZPc2RYcDFueERLNWV5RnNDWkJBTTRKZ1JxK2RncDV6MUdN?=
 =?utf-8?B?Z2E5eXdwRnAwSFlSeGZ1STBhN3JtYll0dTQwY2NqZXNJUndrZEFnd09zUHRn?=
 =?utf-8?B?cXExK09OOHB3SDdRWjVPMEtWZVVyQ0J2UmdKbzdiZU50Uks4cHlMZlZLVTdB?=
 =?utf-8?B?TWZBQjY5VjVLV1FQV1pQK1NCMFVRRWhaSi9KY3haQ2R3OGNZMDl5RlBOalZz?=
 =?utf-8?B?YTI3RmlPN2NwQkdaTXBKTjlWTzBUZnc5TzRGYXFObE5tSFhidG96Y3RXTUVj?=
 =?utf-8?Q?ailVg0w6Ys0Dja4uIM0Aq/5sM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc6410d-e8ad-46c8-4dd7-08d99b230310
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 21:28:12.9805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmM84qUDr5hgkwGA5aD+OHgUrTWMLQkNiKCx7sT9ga7DtxcEPrYmzqKLG/55o+m2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2159
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: BJXtIgqeIOm1VTo8pjV7PlbBU0IRaeGl
X-Proofpoint-ORIG-GUID: BJXtIgqeIOm1VTo8pjV7PlbBU0IRaeGl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_06,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=652 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/29/21 10:01 AM, Joanne Koong wrote:
> This patch has two changes in the kernel bloom filter map
> implementation:
> 
> 1) Change the names of map-ops functions to include the
> "bloom_map" prefix.
> 
> As Martin pointed out on a previous patchset, having generic
> map-ops names may be confusing in tracing and in perf-report.
> 
> 2) Drop the "& 0xF" when getting nr_hash_funcs, since we
> already ascertain that no other bits in map_extra beyond the
> first 4 bits can be set.
> 
> Signed-off-by: Joanne Koong <joannekoong@fb.com>

Acked-by: Yonghong Song <yhs@fb.com>
