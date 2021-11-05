Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562B9446041
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 08:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhKEHyJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 03:54:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63378 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229884AbhKEHyI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Nov 2021 03:54:08 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A51GHrX006695;
        Fri, 5 Nov 2021 00:51:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=49hWKACM2QN8oyCXubZ5WlCUaA5sXhOv8K28HryyAGA=;
 b=VC/Yxqh9yYgi65tPCR9+ulQ/pNkOeoYbxH53mMz6Il60cKXUh/ExHyUElSVNiuO7Lhbk
 l/NybkqigaSh5vfMeJrBjehYyCzXU4iQ68+d7Fgb0p0t1KItPvLQ70SDqfmw0SNy9nyF
 vWc9Y+jpghdqhnUczd37g+3hehIcYfp+Kdc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3c4t6nj0sd-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Nov 2021 00:51:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 5 Nov 2021 00:51:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9A5XKX2Bgf8YSADlY9ddJWm01rmUoTzmP/fhMajSS1Vz1nqUtG41d8rrJiRcRVXaIXkWrQm5BQb//r8YZmd0ijadb0UEpelkJonEDAZhwoaejwKOLXyudSnbAcA2kNGecBHKkQIzk/YjV9Sfb1soCx8XnNgBmouM/3e0S8gsT5C0ITTnsm+Ggt038OEV3i4OEEdhn57a905XQKtn+W98Vg+bNPPr7MwfHmwvfVDFSA8mVL5rlGkt9gS33PbfGiNnlcyBrCSX/3a/ZRGbOJQqxlQdEDaXvfvgKBgE6I4Upnjwyn/VWVvlqtX2A8eqw+FYQL99HtNGNd1A3L8g7hlOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49hWKACM2QN8oyCXubZ5WlCUaA5sXhOv8K28HryyAGA=;
 b=CMOQszGeXAojH74hKgGAmwHR318Va5zxQdbSpm2iu9SQKPCk5Yjh+CJBTISHeCb8rLU533qp6lFwC9ay+XbctiXyQKiZ9FhSXgU2B0n050TnXIoA8UqiENe9wQQju7U/wDajMd7C/TsNfdqT6Ir4MsxoKriIO13iuETvE2K5evl7Hk57nRmnQplmB/NeE+gJckI5/kAzxjnSDda1hV9oVu1go+N9qm8XkkCQLHfR9RkGRNZ3OVA50wavCJ8quedrW26trrYNKF4bG+8N8sys05iRB7YxMvUf/HBvj0C1+q/CW0stuptGAbFzmUirXPasf/2ITWnNX1i8R+54DPeJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB4006.namprd15.prod.outlook.com (2603:10b6:5:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 5 Nov
 2021 07:51:14 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953%5]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 07:51:13 +0000
Message-ID: <2e495e88-5410-9d33-b1f5-beeb1bc2f875@fb.com>
Date:   Fri, 5 Nov 2021 03:51:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v2 bpf-next 10/12] selftests/bpf: merge test_stub.c into
 testing_helpers.c
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Hengqi Chen <hengqi.chen@gmail.com>
References: <20211103220845.2676888-1-andrii@kernel.org>
 <20211103220845.2676888-11-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20211103220845.2676888-11-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0024.namprd15.prod.outlook.com
 (2603:10b6:207:17::37) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c1::102f] (2620:10d:c091:480::1:7c65) by BL0PR1501CA0024.namprd15.prod.outlook.com (2603:10b6:207:17::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 07:51:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 745c3d5c-de3e-412e-6cce-08d9a0310a4d
X-MS-TrafficTypeDiagnostic: DM6PR15MB4006:
X-Microsoft-Antispam-PRVS: <DM6PR15MB4006C205AE1CFE1202567B01A08E9@DM6PR15MB4006.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bOpPKYAY1N+gl4RRy/5Pg3Rj27EIzeZzEPadBupWqfytF09QpAd3HfstRh/Yy8UGDQXnH/vQQrS3E5l8SntSNJnLgixUiyyBJLKlexhbHouwipfEWL9SSm6QbjGTr2lcNKh7vN7IWo6Agb8DD8v7ZlGvNCH36swL+xoHLBFHuNKuHc+7j2LMUoAKsWPjgdCSSmXEJ98dBvhCJB6T+f9AyR0meIoNNi7QH0zKkN8p5IdcWU1tCslv+hJ6UVjRzj0nLdYIIitK4zdKXDUhzq5zd9mRZTdZrYn/68qOewwuniN3YM8PA8pLaG8xXrffK4HaMRIo9qv/b/qhYSRDUDIwWubF3RiGrvTn92ep5DrDqRXTYwLXDSKuxVyhKLJRMItw28mhyq2sIm2iejEFtV5TFaco05GeWNctRgXYCh/7Iu52ls/0yEdyWEqcSdYKUijF/AxTunhjOjo+cpoVuj7QBQ0rENhq5x5ZKydj94hkd7hLyuTq9VIcGmMj+joT6p8zkceGKuW7O4tSTDQAkyi09bzd/U7FAPIZc0LYtVFn/A/PVmUGnqMHn1LaRdYq8Biu0MPSs5wNUfcHf3g23lHYz/Hq+gHPVteet6C33vv5gA8IFA2QOtHmLRpPjfPtgs1udSjw5TCeftKiVItOaB+Xxcd7zbpQ8/7v4g4SdWCEkf4/4xp/VM4B5e3VO9W6D0pFfyqwqPgdVakt11oBcIJd1eY4KMhSA+65wtfZClK2n6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(66556008)(66476007)(66946007)(316002)(38100700002)(4744005)(86362001)(8936002)(8676002)(6486002)(4326008)(83380400001)(2616005)(31696002)(31686004)(36756003)(508600001)(5660300002)(186003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Kzc5V2ZDLytBenNrR3NBSUJsTmE1cEZzdlI4S2Z6NmQzaEZhdVBnMmtpVjBm?=
 =?utf-8?B?NkRQRFRhR1UvTmxadFpXZjgrR3dybjN1cUYvOG9yUGFKY2U0YWl5eUUvcFJL?=
 =?utf-8?B?U0JmMXFEMnh6R3hMK2RpdzIrenJ6L21idTRnQXlORks5ajNiaHoxMW5kOHpC?=
 =?utf-8?B?SEx6RHEveTdiSDBBWXJsRDN4RXFDMUpkQ1ZzRGxNWnZGWkwyVzBFdEtwKzhH?=
 =?utf-8?B?SXlZTGRhdmNzZzBEU21zaDMxNFprT3AwejJ6cnppSS9UTkhZcDdDa21RSC9S?=
 =?utf-8?B?emhyNTZBMDF2UW9YSWkvMG51S29VWHcwVUpLaUtuNDdqOEVUMlp6MnFDUTZy?=
 =?utf-8?B?dWtTTzE4YmRzTFExRHV6d0EwcjE4WnJqRXIzL3pWVHdGR05sRUF0bnJnclVI?=
 =?utf-8?B?UDVUKzFRV1N4RHdYOHp2cEI4eFRpcnpndXo4ejNURHBKWjJQb3FsVVZyODRS?=
 =?utf-8?B?eVJHL3hkKzIxRjlLQlpCdUZFWHNHUkw1Y0VtLzZ6OU9ja0JUSUIrV1hQOS96?=
 =?utf-8?B?V1BxQ0VwakMyc0wva1hWaGJDVUZrQkZxb3JyaXFBRnYreS8zR0FxcS81U3pj?=
 =?utf-8?B?QmRlV3lFU09HbnJkQWNVTXpaRDhHaklzSm1QakErRFllMERaTnhHazJCQ0M2?=
 =?utf-8?B?WFAwaDdROEcyTW0rKzFsZTFQMGJ3cDlkMndKMU9WeEI3eURoeG1lS254Qnh2?=
 =?utf-8?B?ZHdZdFNMYU1xZzVZV2FiaThmZlFadE1aRmRpaHd3USt0Y1p0SWtZMDFMZHdQ?=
 =?utf-8?B?NXdBeGpDNTl0Vzl4dlFqNXZ5MGpEM2F2ZkE2NkpoZG5JcDdyL2creC9Gckhv?=
 =?utf-8?B?M3kwS3hlemp6dEJhS1lqcWhiVjgvUWVtSkZTTHFrYnp6YXhRcWhVbi8zQW1j?=
 =?utf-8?B?T2hnbmJ6NW5Fd2M1NTRkOC9LUGwvSlcwZGNYMkp3bEEyRjZqUTdVZlQrQWI3?=
 =?utf-8?B?OHlybXIzc3FiaVB0WElBQ0o1eFFkWURncXZLb2pMMWFBUUUwcFE4T1grZzgr?=
 =?utf-8?B?cXROSzlTWWEwZlZJRWpNU1NQbU13NG5jRnlaaEg2ZlhEMDE5dWVXY2tnZGVK?=
 =?utf-8?B?SFZ3VUluTFFjOGpjdVpiUFNSelB2MzhsSEQ5ZUtEMm92OUF0cEhrU3VqaEdj?=
 =?utf-8?B?WGFMb3VTQVVvaDJlaXhPU2ZxU1AxcWRQZ2dISTM4NHQ2TDJrR0RrQ1VFU2RZ?=
 =?utf-8?B?Z2k2YkU3NjIzcllDd0plWUN1SVJMSnB2aW5wRkYvWkJ3SVExUUR2cVFZOVA1?=
 =?utf-8?B?Njc1VFVqeHZ1OTQxOXVDangvM3B2YW1LYWYwaU9EbFpERTdsV1Y5REROUFF5?=
 =?utf-8?B?SnpPNjRtLzVXTEZ6MXhBMTRPbGFZQzJEZXVxZSt2SkU0aHNsbDgzMDlKYzNx?=
 =?utf-8?B?RVRvT0NlTFVRWTRrU1JVQmI1ME13TXMzbCtlUC9SVjNXeStuZ0lOSjZmcnhS?=
 =?utf-8?B?eFN3MHM0b1k0VlcrQmdNOEdhK0poTVd5S0hQdjZhVTZ4Q2pHczZmOW5GS1lq?=
 =?utf-8?B?Q2FPd2p3M0xGSzlqbDBOUG1hNU95cTBGamU5YmxoWDNROGFDSWxaVlJYMGpw?=
 =?utf-8?B?dkFzU2t1R1JYLzJyQmNvYXlKLzdEUDRBeDhubnRZQ0N6Qmx1SWpaSlQ2aTNZ?=
 =?utf-8?B?azRJSG50YStyd1grczVKMjRRcjhSSW9aUk0xcjEwOHE5Ylpqc1g1eFNIT0pV?=
 =?utf-8?B?YlR0dU9RdmZFMDlKRlFXNVFsZmNrNFo3SzNFTWQ4M21aQkdyWlB5QlpSM0FM?=
 =?utf-8?B?RmdvYkE1S1NwaWU4bEIvTGIzOWlEMnpiS000ajFkT2dQNWRPcnFZV0RNckl2?=
 =?utf-8?B?RlgvWmpIYm93YUpEakllVTM4WUZ6cmUzYnowaDhKdDhRT1RPeER2VzBKdzdC?=
 =?utf-8?B?bUoyclROU3NsVUsxNm9rR3YyQWtPMWdrWWdUbmZZN0lHRkpFOXNwbUlwN0RW?=
 =?utf-8?B?ckdXUG5SRUdKdkdhNTk0dElKMUZDNERFcFNrc2VSb2lvbzhxMTRYV3NYUU5Z?=
 =?utf-8?B?N08veUZwUW5XOW9XSWFyL3p2S0JkckViNGtTdkVzWjFMcXdycmFtb3pkU21n?=
 =?utf-8?B?T3RtMUVISTBYSlFmTEVGSUw2ODJOYy9Uc1NWcVNyZXM0U0pZdnhFRE9scEx0?=
 =?utf-8?B?czFNdXdWWlh4eGFGbkQvUXZVeXdpaGdjRkxrWjhrK0NlVGJERTJIWHQrK3RX?=
 =?utf-8?Q?uYb5e0izcRj9HGzX0uLmBDx329vYX2SKMJJoely85AHW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 745c3d5c-de3e-412e-6cce-08d9a0310a4d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 07:51:13.8175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbRQk73oFzjzeShdOYBiCDhsAXFse4IOrgum/Y8o5fEjwf4fLvVfrLcB+fKJsHC7w1Cx7oR/Jhx1QXbL+3uC3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4006
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: SaeTcaD2s_-OQQiZJBrwNjYeNNLMoOc5
X-Proofpoint-GUID: SaeTcaD2s_-OQQiZJBrwNjYeNNLMoOc5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050043
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/3/21 6:08 PM, Andrii Nakryiko wrote:   
> Move testing prog and object load wrappers (bpf_prog_test_load and
> bpf_test_load_program) into testing_helpers.{c,h} and get rid of
> otherwise useless test_stub.c. Make testing_helpers.c available to
> non-test_progs binaries as well.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>

>  tools/testing/selftests/bpf/Makefile          | 33 +++++------
>  tools/testing/selftests/bpf/test_stub.c       | 44 ---------------
>  tools/testing/selftests/bpf/testing_helpers.c | 55 +++++++++++++++++++
>  tools/testing/selftests/bpf/testing_helpers.h |  6 ++
>  4 files changed, 78 insertions(+), 60 deletions(-)
>  delete mode 100644 tools/testing/selftests/bpf/test_stub.c

[...]
