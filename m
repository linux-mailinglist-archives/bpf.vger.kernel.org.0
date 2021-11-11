Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA3944DBFD
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 20:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhKKTRC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 14:17:02 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4412 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhKKTRC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 14:17:02 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ABJCjbC028785;
        Thu, 11 Nov 2021 11:14:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JlKVBm73whHBNvLJDUSOFV+pWUZ83HE6n2Nrq98tVkE=;
 b=SXCy9azv/6dWMOAqIpC74r4zWQX4nrTOSegPK/DNUF8XZENpcXFAkW9cPXFx+a21J05E
 Ot/dB5szUKObhbV7AKJBtyPC4elMHOxkB9LnlV5FYwiZExkPwNinYF5jPIMU/hwxwv4q
 rAd9uFv6+Aj/JfCe8zTsFTTl4G7iJ6+vjYE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c994qr0m2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 11 Nov 2021 11:14:00 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 11:13:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJh2HzgUIm6g8Ex2fYfYP1iER3vBKSyfRAmB2pfPfygV7+nSBV7fmYvV+9QvcaAdY5GhtlS61ZD//LmV19EWYtHAUFcMbtQN2NL4cocsSminsEzJ3SkobAql5bWZNyzSDtZ7uzpJlNS9iCd8s0y/FkYR2YX8KwN7WkI18VLsUFZWrhBBYbPMxZowWq5kv2CStQyilD4N0g1S7Icd11A+dCGKsCi1HWclqhVj74bZo3HtzDCUrkk1j6ZcsMeDgxP5gW/BVEVD/8drgRSh9KNu2iVYP2WkMwuV+1xcUZhmal9Uxirc6dEukFyJysfokC5zNVKuHXPZav8+9yjIWUe4eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlKVBm73whHBNvLJDUSOFV+pWUZ83HE6n2Nrq98tVkE=;
 b=kyj2EBL/zreTFEFMbU8r0SjJLA12XQhNYngxSZaVIHbQoSDhHcoL25bWm1RTHh7fm/w+45/AGKVFkG4+Lo6iupo+dXb1pIiXwUHNvThg49YM5z5Pb+wUMb3M5h3u9FX3+6G83in2UPgw9eNfAaOW6VI7uRvenZ9GqlnCIGLDixKx7x/4VQkTRTIp8bdrS/EmV0Setom2ZpTMH9bwKb2LO+JNQdBYiFxVSn0ov1r0RtwR6W+xJtp4QCKXlyXO3yWPUwi0dlrCjENlm9ZJUoSDE3Mbz4ILNdLiQgMZ88cdU0h8IhtIW9WnP0DzeCx3A53VWQ/ruQWLytnWJeHLHBtKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4869.namprd15.prod.outlook.com (2603:10b6:806:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 11 Nov
 2021 19:13:37 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 19:13:37 +0000
Message-ID: <de542781-a454-9de8-322a-348d66ce500d@fb.com>
Date:   Thu, 11 Nov 2021 11:13:33 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH bpf-next 06/10] selftests/bpf: Test BTF_KIND_DECL_TAG for
 deduplication
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>
References: <20211110051940.367472-1-yhs@fb.com>
 <20211110052012.371411-1-yhs@fb.com>
 <CAEf4BzYgzKtTqMYkvSYr-PRtdQzN6KMDbXJTM0TA8J5icic==A@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzYgzKtTqMYkvSYr-PRtdQzN6KMDbXJTM0TA8J5icic==A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0221.namprd04.prod.outlook.com
 (2603:10b6:303:87::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c8::18c7] (2620:10d:c090:400::5:918d) by MW4PR04CA0221.namprd04.prod.outlook.com (2603:10b6:303:87::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18 via Frontend Transport; Thu, 11 Nov 2021 19:13:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aadff9f-f018-43ef-7cc4-08d9a5475cd7
X-MS-TrafficTypeDiagnostic: SA1PR15MB4869:
X-Microsoft-Antispam-PRVS: <SA1PR15MB486985BFCE3ABB4660695E51D3949@SA1PR15MB4869.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPIPtxVkj92mUWzclwphlnVDc1agkTD1OZpIickUrmoVzAlR5Qw7BMtj4vjjW5ntZjGt7Dl8tEL8uLqCQ06XyYaR4wgbxinycFmwBSAk8Rh+vvziLoyYNA7cvTnCJGts5J0Dy+MnyZdu4qbqO93rwYiCtTqjXuTkD0ql/BmCrtsR71l+DwtEqHo4SMQhJvXWZUV9bNdhQ/JDgGz7ko0LpYmaHU6TS5hcPt894X9sWHbjbWxkA2B9GTOnS7Rq0hcGGduTZAoax7whAK9CdHsHYEFcNsgInQ/EdfevlyVs2Yw7eRyicUnGsSRPkGsV6EeB8UjOFIUQYUgvH/zOVr5mj3RsyTn+TnKdf2svhaxMbedgdQOEjEQQWX25TKWDIB2pOT++5ZoY48GSjrjkDBtNlbAQRHVHiwOcLdij0rPROcW7fyIZoiACFvH3xUuNwqmw6kMzqKCBSD4kNgnCHLQRN63EY0+fd/pq8ahGW+RMZJRlO31LoCvgyzETXtZKNzYaFJtgva31you+QiR2NVyYAGEoGyiEOdmZMYP+YpGDBvlagB8QrfYcXQG/aVseH3SM9EgtfQ1zyS7eGO0UicvzATq2ZXSBtAAxIGgbraEtkjUk5ALX+yU+2orM+hHvD69T9feL8/TTfYInovLo/TjgP/fW9NlncQ1yzr1fJ6ueoZPONtRmBNcnKX2F+QMKibs1J4P+TCRLF8v0pfpTFwYiMDqcEZdMVGB/nSGvoI+7xe0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66556008)(86362001)(5660300002)(2906002)(6916009)(186003)(8936002)(66476007)(2616005)(38100700002)(8676002)(83380400001)(36756003)(31696002)(4326008)(6486002)(54906003)(316002)(53546011)(52116002)(508600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUZMR0NaZlZySytEb3JmbFRWb0hrTDdTcFNmVUw0THZjN1BpNnh0aGlseEhr?=
 =?utf-8?B?UjRiSHAxVjBtRFVwVkRLVTFwRUIramQwUDZuNlVNcFlkblNrc01wK3BaVjBu?=
 =?utf-8?B?TmM3bEdaRmRhdVU5R2M1clYvUG5qVHNBYlhzVHNNZm5DYkNvam4wYzdERW0r?=
 =?utf-8?B?dlUzNmlZYXBEckZWUlVZS3RMQzdGaUcxMWtqNllqNTFNbG5ySVR4ZHVnTmpp?=
 =?utf-8?B?L2k1THVJVHlNcUdIeER4Kzd1SkdxK3hsbmFOZzdhSm5zNXBUQnR5dDNnU3Fs?=
 =?utf-8?B?OXNZT0FrbXN2KzZpSkNPWGFmUnRGQWJsQTdRMkRZVmNocTR1bTZVTUE4UlUy?=
 =?utf-8?B?VVFSbi9rV3V4SGhZY2xoK1B1Q1V2VlVPYmtSNkR1a1hNOUNRTzVrcjdqb3FP?=
 =?utf-8?B?SmpUVVdsdklDL2plNldFU1ZDeUhiOHRDY3dyOWdaM2U0NDBtR2dHdVIxbEh6?=
 =?utf-8?B?Vi9mSE8waUZMbStNQng3SUg0RFExM3NDazVueG9wUEdqM3N5aGZoNVI4Q3Aw?=
 =?utf-8?B?L1kreFZ6aWQ3V2JJczZCbnJnblNTSmJ1OTdjTDZQWG1aNGhnemR0YTJ5S3Rk?=
 =?utf-8?B?T01Nc0VXTHZMeFRrMW53K0JkeVpQbFozQS9YTHB4eHdUTWtyMzVJMmpLZm9p?=
 =?utf-8?B?SGovSlBnTEEwNkRhak51d3U1Y0ZoSlc1dUtrSHBCYmYyVXA0TkUrV21WOTVO?=
 =?utf-8?B?bU01dEVkZ01LdkJpTnI4bGN5Q00rUlJBcy9lYWY4dkR4YkN1dE9JMjhjOFdi?=
 =?utf-8?B?R1BJTi8vd0tXbUZCMmlSUEN6eFRzaGdFYkNZRlduVkJEd1JCdzBDM0RLL0Vn?=
 =?utf-8?B?WmYveHNGWEZGUXZHWHlTVmJ0QnpFaGxiU0s2ZzRjeS8ycTdmWmVuZ29EQlE2?=
 =?utf-8?B?T3hidC9QdVRwV3lBM3AyZXRkRkE1UkJKRFFjWkJHQ3FsaVdtN2R0WmpzUVhw?=
 =?utf-8?B?Q1YzUjk0eWMzTHdtZTcvMTNhTEUzdzFLM21renZTYUcxenBnaXA3ak5oUEo3?=
 =?utf-8?B?eWxubTB5VEhKZ3JHNWNRYWZ3Z24vV3RKOGF2SzdmV09wRWk4bXVnaW9uQ2sr?=
 =?utf-8?B?TVJsRjdMOEdHUTd2WHBjRVpTWXorZ2lldmE5VFArY1NHSGVrakRjMDhYQ2V2?=
 =?utf-8?B?NmgvZU9oWGhXQk5FaWRQTVJCWjFZaithV09NMUdDYTFESmJVSlIrVDNHRGdR?=
 =?utf-8?B?S1Z3YVU2SXFhSnZMSTMxOUNxNFhZQlpFVTU4Rm9TbE1KbkdzYS9jL1lLR3pJ?=
 =?utf-8?B?K2gxczV4bUZuT1JzektEVmhPVmVXUFVuQm1uQysvanlBVFNvbzN6WmJoeUd1?=
 =?utf-8?B?MjFudFprZU9nZXVJMFdHbWhqMWJDTzR2ZGJwOXhabWtRcTl6d29vYkdmNjZQ?=
 =?utf-8?B?ZWNrZnREKys0clV3VlBsczhCbXR5b0hoU2puaHlXT0NtSytKMW1DRFBRSDhV?=
 =?utf-8?B?bnFaQzFEbFdKd2xKNSsxejdrNkpSQkdrK2RsVHhFbWJhOW40YmZSc0h2M3Fq?=
 =?utf-8?B?eENtRzJlZVRvcm1KckZJa1VXZUd2T3hjQm0vYisyWm5hd0pDeEx0MnNvN1Vr?=
 =?utf-8?B?RXR3RGhNTm9vR1gvNytmK3VLdkRpMHFxL0c4S0o3aXpMUWVacWNmMFpzQjRr?=
 =?utf-8?B?UG1tSi9lY3k5REtFQkdOVWlwb3lBeHQzSzgwNWZWbm9wR0NqeHZ6UHJVSS9P?=
 =?utf-8?B?RUZsbVBqWklsODRtaEkrUjZmR1VsRmVRTnpSa2orT1JxKzFVaFgwK0JLUVhU?=
 =?utf-8?B?SGVtaUJMd3RWQnMyZ1Zpb3lBQnJWK3lTQVZlWGhNc2hSZWdlN2RoOVdmYlJq?=
 =?utf-8?B?Ri84dTdOcGpWWko1dVhyTGgxU012eCtLY0htYlorSGxjc29aQ2x4bVd3SnZm?=
 =?utf-8?B?dGtwNWJKTWlnV3daYml2ekpwQWROMkNhZWdyN044WlZsSG1yY09QWTk0V2Vz?=
 =?utf-8?B?Y0QvM25nNW4wWnVEbkUyQ3hRQm5BQU5FOGZ2K2ZxU2JWTmhpM1FxSjQ1Uzhy?=
 =?utf-8?B?cmJQbk9PbVlneGU1cFBzK1ZFL2xZQWlaZVltMmI5WFFScmdKWjIzNjBJS2xM?=
 =?utf-8?B?WjdDUk5pOG44ZXpncTgxYWh0WktWVloxdzRJTmdxNm9hZjBUcmF2SG9VRzAx?=
 =?utf-8?Q?wdgzcwTBfg3PXc/PugUJiexca?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aadff9f-f018-43ef-7cc4-08d9a5475cd7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 19:13:36.9452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+xWjRFDup/FT4tTDsvvJPn3mRGKzPq6nuUrV6WXf+JnvP5E2lSPv1qUvgBOu2WA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4869
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: GdaVy4m2nMRqGPlNhTyRDV4n48QFjE1g
X-Proofpoint-ORIG-GUID: GdaVy4m2nMRqGPlNhTyRDV4n48QFjE1g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_06,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/11/21 10:49 AM, Andrii Nakryiko wrote:
> On Tue, Nov 9, 2021 at 9:21 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/btf.c | 46 ++++++++++++++++++--
>>   1 file changed, 42 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
>> index ebd0ead5f4bc..91b19c41729f 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
>> @@ -6889,15 +6889,16 @@ const struct btf_dedup_test dedup_tests[] = {
>>                          BTF_RESTRICT_ENC(8),                                            /* [11] restrict */
>>                          BTF_FUNC_PROTO_ENC(1, 2),                                       /* [12] func_proto */
>>                                  BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
>> -                               BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 8),
>> +                               BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 18),
>>                          BTF_FUNC_ENC(NAME_TBD, 12),                                     /* [13] func */
>>                          BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),                                /* [14] float */
>>                          BTF_DECL_TAG_ENC(NAME_TBD, 13, -1),                             /* [15] decl_tag */
>>                          BTF_DECL_TAG_ENC(NAME_TBD, 13, 1),                              /* [16] decl_tag */
>>                          BTF_DECL_TAG_ENC(NAME_TBD, 7, -1),                              /* [17] decl_tag */
>> +                       BTF_TYPE_TAG_ENC(NAME_TBD, 8),                                  /* [18] type_tag */
>>                          BTF_END_RAW,
>>                  },
>> -               BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q"),
>> +               BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q\0R"),
>>          },
>>          .expect = {
>>                  .raw_types = {
>> @@ -6918,15 +6919,16 @@ const struct btf_dedup_test dedup_tests[] = {
>>                          BTF_RESTRICT_ENC(8),                                            /* [11] restrict */
>>                          BTF_FUNC_PROTO_ENC(1, 2),                                       /* [12] func_proto */
>>                                  BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
>> -                               BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 8),
>> +                               BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 18),
>>                          BTF_FUNC_ENC(NAME_TBD, 12),                                     /* [13] func */
>>                          BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),                                /* [14] float */
>>                          BTF_DECL_TAG_ENC(NAME_TBD, 13, -1),                             /* [15] decl_tag */
>>                          BTF_DECL_TAG_ENC(NAME_TBD, 13, 1),                              /* [16] decl_tag */
>>                          BTF_DECL_TAG_ENC(NAME_TBD, 7, -1),                              /* [17] decl_tag */
>> +                       BTF_TYPE_TAG_ENC(NAME_TBD, 8),                                  /* [18] type_tag */
>>                          BTF_END_RAW,
>>                  },
>> -               BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q"),
>> +               BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q\0R"),
>>          },
>>          .opts = {
>>                  .dont_resolve_fwds = false,
>> @@ -7254,6 +7256,42 @@ const struct btf_dedup_test dedup_tests[] = {
>>                  .dont_resolve_fwds = false,
>>          },
>>   },
>> +{
>> +       .descr = "dedup: btf_tag_type",
>> +       .input = {
>> +               .raw_types = {
>> +                       /* int */
>> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
>> +                       /* tag: tag1, tag2 */
>> +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),               /* [2] */
>> +                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),               /* [3] */
>> +                       BTF_PTR_ENC(3),                                 /* [4] */
>> +                       /* tag: tag1, tag2 */
>> +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),               /* [5] */
>> +                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 5),               /* [6] */
>> +                       BTF_PTR_ENC(6),                                 /* [7] */
>> +                       /* tag: tag1 */
>> +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),               /* [8] */
>> +                       BTF_PTR_ENC(8),                                 /* [9] */
>> +                       BTF_END_RAW,
>> +               },
>> +               BTF_STR_SEC("\0tag1\0tag2"),
>> +       },
> 
> Can you please add a test for two more situations:
> 
> First, like this:
> 
> tag1 -> tag2 -> int
> tag1 -> int
> 
> tag1's shouldn't be deduped
> 
> Second, like this
> 
> tag1 -> tag2 -> int
> tag2 -> tag1 -> int
> 
> Nothing gets deduped.
> 
> Actually, also third situation:
> 
> tag1 -> int
> tag1 -> long
> 
> Nothing gets deduped.
> 
> That will document expected behavior.

Will do.

> 
> Thanks.
> 
>> +       .expect = {
>> +               .raw_types = {
>> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
>> +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),               /* [2] */
>> +                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),               /* [3] */
>> +                       BTF_PTR_ENC(3),                                 /* [4] */
>> +                       BTF_PTR_ENC(2),                                 /* [5] */
>> +                       BTF_END_RAW,
>> +               },
>> +               BTF_STR_SEC("\0tag1\0tag2"),
>> +       },
>> +       .opts = {
>> +               .dont_resolve_fwds = false,
>> +       },
>> +},
>>
>>   };
>>
>> --
>> 2.30.2
>>
