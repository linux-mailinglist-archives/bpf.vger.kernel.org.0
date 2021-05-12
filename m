Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EC437B4C9
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 06:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhELEGp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 00:06:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23056 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229447AbhELEGp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 12 May 2021 00:06:45 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14C44D37012462;
        Tue, 11 May 2021 21:05:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ryCCSgSQ1OIKT5Vsaj3fw09wdeiO++6YlZpVGRcENh8=;
 b=Dc6PH4Lle7L4Ke601nODWmKswhGaWJfsk2DWa+s2FARzWxWfLVzmhOR0iolc9yZbGhmE
 rEJno7UC5iPAIUi8vbWvfKqVhKBwEm4u5pR5N9DaeaTB8wt0zT9iaposp1GcXt1XQa1u
 XpwiJcnhpYuv+EjqSFvnaWw0mRSsKmgbCLs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38g5r5red8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 May 2021 21:05:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 21:04:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aijuwkrcCmsboJOG4tTDBa80wJ/zz6vMwcZVar/nMBFyliAEjKEQPT5yh5m8BcZm7Oqrh1c1sq8v4lupp3QXbgJ5p7BzT9PqHqyTa4oI3yhN0OGDhDk48Z7MSSl5uYLSxdMJKPHTkIaDVtSOZrNzqiYW15C1utV3S/cODxWr6kRh6H2buLPzAvh/1BDJ3wMlFI0IED3VFyFrBIJTFVkpFzpA8vwdE50pVvGFWC0CPlWNUYjQw05Lx1CVSYGLPE648/NC5N+mNM3owl0yKSEox30aFc7GbMmDb/cR5vZ9WpoMBU2P8qlTM3r7M2qJJj3J1HDd3lDgAU6HXf+I2xOLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryCCSgSQ1OIKT5Vsaj3fw09wdeiO++6YlZpVGRcENh8=;
 b=ScMSw7IjAUZ2otD1NpiZChNMC5rhl6o4KxvD49Nt36j54i40ewY03Shan57hdKP5U2dmX2lbycWTVRkg/Os+4xzcwVPg59PaR9VbF8lYec6jx0/yuAaY3bWLvAgVObGyy/LVK7VOwD/JZ1VfXC6ylHFirx8Vq2D+UNspdkKCKX10Q6HM7vdnwBLyqLni8GgqSSQDbu9eXsaqxTTQQzfLb8+a0oi1x8BWCTtV3LkzrpHkctHBSy7i4C0XxVcioNvJTYKgX5QgEwp5OYKHN8HPGlD8mzAFJF9VLkbPqYkasGoPJ/kGXAfY3WETQB18Jzg+VUg2OcdMS5G+eztDkB0cSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN8PR15MB3441.namprd15.prod.outlook.com (2603:10b6:408:a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Wed, 12 May
 2021 04:04:51 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::d427:8d86:1023:b6b5]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::d427:8d86:1023:b6b5%6]) with mapi id 15.20.4108.032; Wed, 12 May 2021
 04:04:51 +0000
Subject: Re: [PATCH v4 bpf-next 07/22] selftests/bpf: Test for btf_load
 command.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
 <20210508034837.64585-8-alexei.starovoitov@gmail.com>
 <CAEf4BzbJDRAVmjPSk6XWcfxuLUvymouN4G+-UYM1G9f=2pX-yA@mail.gmail.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <bec3232d-b59d-9d89-fae5-795e2bd32556@fb.com>
Date:   Tue, 11 May 2021 21:04:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <CAEf4BzbJDRAVmjPSk6XWcfxuLUvymouN4G+-UYM1G9f=2pX-yA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:aafc]
X-ClientProxiedBy: MW4PR04CA0226.namprd04.prod.outlook.com
 (2603:10b6:303:87::21) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1acd] (2620:10d:c090:400::5:aafc) by MW4PR04CA0226.namprd04.prod.outlook.com (2603:10b6:303:87::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 12 May 2021 04:04:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01aa80d2-5e2e-4c55-9b7b-08d914fb1705
X-MS-TrafficTypeDiagnostic: BN8PR15MB3441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR15MB3441AF9EAA856F97EA97ECEED7529@BN8PR15MB3441.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0nDCKOn4OyWsLwgBIYfIEo1Hc9dtSSbgI4PsHKQKUC6Nq4ir0N/OSsjxlHUJyNl3CTgMo4OIjSyfbQit9xYH1CDwgfChIW0m358hQ+lgh+L+2hSmucyuXMd3P3H3+nIkaRqGE11vhQ3m96zzmBUEiwKyiouozVMRm9ffz4gftGUwBDw9J5M7zkJT1ynTTl0mhNcL0tmaHb2fAj/L0jIxtP62i6zMLFvxniaqVLtRAa+YCSXXvHwgUdEit1IT0GlC+faDvLAM/ZVN2OLsRusVTMJ+rrSJC20EFJo4H0G8nPasTxoGogvi64kLZlKbZZEkaicvjXyOLh2ys1i0jWf1x0R0Irpxb+yInInnO6/puNPeHb1/cZhfgkMXTW70igaF+2Vsx6nl56NvE7fvi6OGDf9300rc8uaHC/RnrJAFlKJ/vhs2ay328UZqHAUQ0GcltlDbV0l22/6oT7h0xgFy1PSfc1VA/5Ae2vVH+8uWQ/3JvPYHsN8vKERtPWbP1NK7w3uA6L4aLMD7nKUkP2QBA8/zA7N+Ixn+Zu6krG77Azn48Fmi0xXw0xkxFF1fhAGfbNcyn/7lHuvnITkNVd31F3fwDaP/OrgRFLfoKfZvaPVWI5Wp5dL2b3Fsc8adoe7GJ4pTCCxKz4bmbTFAR1B3N40CZ087k/mkT6tbb13gCkbZtkNsaZk/KoIsVQyZY5t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(16526019)(478600001)(53546011)(31696002)(186003)(52116002)(5660300002)(316002)(6486002)(86362001)(31686004)(38100700002)(110136005)(36756003)(54906003)(66476007)(66946007)(66556008)(2616005)(2906002)(83380400001)(4326008)(8936002)(8676002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NmxmK0FoZTVPZVM1L3c4bHRRZ01FVVgwNDI2Q3hpMStYRFVFNGlpV0dLOU02?=
 =?utf-8?B?K0o0R3ZUVWVwNEdmZzR2YmVIdVNkSDVQaC9yMHRSMkZ4K3VpRUhFOUhwZzhI?=
 =?utf-8?B?Y1NWTHZGSkFCY1d1QnA0YVZhblBrc2J1Y0VidWpITWVMTW9mYzB0SEZtNmJl?=
 =?utf-8?B?MVRVdWthVkJmcVpmeWxrS3g0UXNmZXlaTjZnazJLcllyM2dpZFpWcFlydUNi?=
 =?utf-8?B?VHhTWXc3Uyt5WXl6Q20vNWozemYyMmEyejQzcGxlK1kwM1h2a09CRFQ2cjdz?=
 =?utf-8?B?RWR1MjNEV2FMQU02SFBxNzNyMFpyWU14bTNrd0llbVV3Tjg4eWVmR1lhOGRS?=
 =?utf-8?B?MWRLK1c5MzBnbUVUeUV0dSt3cVdtMC9YWTh5RlJ1SC96dElwbGg1cndhVkJs?=
 =?utf-8?B?T2Rzb1N2MWZSNTJBbjl6eW5mNzBSUWhnc3hvUEswYWhtd3UzVG0yVlRWcjhw?=
 =?utf-8?B?WHZOdXJ4SHBSTy8zSjNkNUxpaHM2VUVVMzNyNHZFQmVubGdyMWtBM2Z6ei91?=
 =?utf-8?B?UUZhc2d6VWFETUV0ZUlWSFhYVUM3OUtocGFFeDFpaUYvbk8vMUxiaVdicWow?=
 =?utf-8?B?bVBjendVeU5qNk9XTzg4V2JKVEYzOWtyaWFYaHMxNlVOdkQrUUd1QWpYUHI1?=
 =?utf-8?B?UmpCV2xwVWFYMWtMSXROazQ5VkVNeXJLSHQrL2pYTnFLTnlFdVFDN20zblRv?=
 =?utf-8?B?czl2ZWxPZVgyOUVvYTBiMlE0R004akZ6WWVpc2YybCtweDNOVDY4TEJUWUtG?=
 =?utf-8?B?aDJVRk85a1NFckZ2SFFUbnE4M1pYWWN6OXFQM3BidDZXeW15UXFrMlNEWDRo?=
 =?utf-8?B?T2hIM3QrUitVNklxNlNmNFkxWGVkT1FVNERTTDc2bGsvN2t3ZDRieVZuZ1pT?=
 =?utf-8?B?S1F0M0FpY2oyYWRlU1Arc3RDbVptSXpUYkdsd0tvK0djRlJpVXR6VDdPZFFx?=
 =?utf-8?B?a0Eyd3dZRzFJWkVYQlA3czdMMW9PUXZDRVRUNGhuRXRRM3BpckttdTdNVFJ0?=
 =?utf-8?B?WVBmUnhid2NwaTBjMVMrQ1dHZVpTalZReW1BelM1M3VxMlozZEhFb1BJR1pW?=
 =?utf-8?B?dkw5QlJWbUZaSEVLZHRON29VaXlRanM0NUsxSEc4MXR5aUk5VnJLSzVLeXpv?=
 =?utf-8?B?K2cwZStkY3BNUU1sMDltcmM4WjJiUGZ6aStIbzhrTzRGQ1hiTWVnVU5HVnFN?=
 =?utf-8?B?MU1GNE5rUmFYUC9qalJnK1F3eHlxd1pMaDloSDNZRnU1NTVuRk02SWszQmFF?=
 =?utf-8?B?eEEyQkQ4SzlFeE1FV2xqOGNEcm5rUHI0OUtwSUhLYW9va2lJVHBzVFdJOVh2?=
 =?utf-8?B?UW51aU0zM1J5ZkVOTEZUdXRYYUF6ZGtZZkJyckErVUdGV3ppQklycXYzRUZG?=
 =?utf-8?B?b0pWWGo5OHVYelJUazdMWWp6eTVUZnJvZEZQTUJ0NlpGb05XSEZWRm1oOGZw?=
 =?utf-8?B?U1F1RU1EMFh6dkRaT0FFamRZdnZRSURMR1hhWTFvUWVERERBM21aUVV2RlEv?=
 =?utf-8?B?RHRiWTRkNlhackhyQTJtUG5TdW5QbG15UjlNYUFKZUc4cnpTaGYvL1Nyc1c0?=
 =?utf-8?B?YTlWeWw2N0NQY2R5dk5UTkY5N3h5UmlWZFlIQ2VLUXVVQWR5ZXdvYnlVeWVq?=
 =?utf-8?B?TExMeGE3TklPNWFhd2RJTWxSN0U5SGp1czZXQmhGekRvVmxtdVV4TWJjczRi?=
 =?utf-8?B?Z05GMnJnZnFsUG1IM1ZSdU5hUWxEWUdVclRGTVlTL2NQeVF1Ynl3YlRhdFRF?=
 =?utf-8?B?WDlJZnZkRFQ4b2dIYTd3OElxOHRnOG45MXRaUktnVzY5amhYUU1NaFc1NzA3?=
 =?utf-8?B?bXVqTWYrTSsxT2ZuVVFCQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01aa80d2-5e2e-4c55-9b7b-08d914fb1705
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 04:04:50.9123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGRrG4AXA+5no+Yr4MwiEi5yfBdBrBQdS8tcJXuWvvAviK2V7z4fWf4OFrLR/DDc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3441
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: dkYSR47ytnMJoUrvRrFHZbYBba9tiHCs
X-Proofpoint-GUID: dkYSR47ytnMJoUrvRrFHZbYBba9tiHCs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-12_01:2021-05-11,2021-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105120028
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/11/21 3:45 PM, Andrii Nakryiko wrote:
> On Fri, May 7, 2021 at 8:48 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> From: Alexei Starovoitov <ast@kernel.org>
>>
>> Improve selftest to check that btf_load is working from bpf program.
>>
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> ---
>>   tools/testing/selftests/bpf/progs/syscall.c | 48 +++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
> 
> [...]
> 
>>   SEC("syscall")
>>   int bpf_prog(struct args *ctx)
>>   {
>> @@ -33,6 +73,8 @@ int bpf_prog(struct args *ctx)
>>                  .map_type = BPF_MAP_TYPE_HASH,
>>                  .key_size = 8,
>>                  .value_size = 8,
>> +               .btf_key_type_id = 1,
>> +               .btf_value_type_id = 2,
>>          };
>>          static union bpf_attr map_update_attr = { .map_fd = 1, };
>>          static __u64 key = 12;
>> @@ -43,7 +85,13 @@ int bpf_prog(struct args *ctx)
>>          };
>>          int ret;
>>
>> +       ret = btf_load();
> 
> Maybe let's move patch #11 (bpf_sys_close() helper) in front of these
> selftests and call bpf_sys_close() appropriately on error and (if
> success) after map is created?

Interesting idea. I took a stab at it, but it's not unit-test like.
That bpf_sys_close is going to be used assuming it's working.
I'd rather add explicit test for bpf_sys_close eventually
instead of mixing the two.
Since your concern is fd leak I've added btf_fd to context instead
and added explicit close() in user space.
