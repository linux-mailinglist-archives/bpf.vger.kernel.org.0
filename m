Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD97406FDB
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 18:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhIJQmU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 12:42:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57582 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhIJQmT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 12:42:19 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18AGekZX004586;
        Fri, 10 Sep 2021 09:40:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Evh2dd1ob1frK+kb0/wsNUry/9ZNJ/u3sTSxDa3s0MQ=;
 b=CG18k2ySSJ1ajdkYwZzd4YJ2hs54jkQQArmwGrPo2fEKKOl5bbwUjU9NBrpA9W95mLuk
 nudSN7PblbNrATcIII82F3/IrrI5jEilNSxwsgLbxJ2Ke8B+QDKirNSUm9+nt9I/kj2l
 h1wvkcv6tEab/neaEr1yxJMirst+WEMb0CM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aytgk5yn0-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 09:40:54 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 10 Sep 2021 09:40:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxarJUfGPJK98WC8u6JVg46VxDxow6UYyNG92/2dlj3E5qHL/U2vlcFZ7F5CFwARKsHKE0ANtX+QbTx7MfqWvDAkLhyDK4WXFCQJGhVOF1wdSswb1MS73uXRbMGDMTCvOmdLvovGuOgTQ+CCutMw1EJSI5RfdymqkIWKNwDKgrW++A9st1d6zhI7wJr8UPvWI/Wplvrrn4k8ZtbRG3EJC57HVgqlgUu7+r/vhKrC8JtXtDAoziZocdWB1gZk54bTHWoZdfyKhIy1gHgd/fZGE+Gbh8RxJebdSLGlnJ45BeZUgh9nGtnkrFjio37XDAYy5uC5Sp+kKoasaeOUK764rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Evh2dd1ob1frK+kb0/wsNUry/9ZNJ/u3sTSxDa3s0MQ=;
 b=NXNm9L6R2gtEc3aym0oKS3FhpNir4truEMu3zksNhWRWSLDE+SS+ZwX0d2jBBe1lT7L0dQhSteFrJOvvpN39v7N0+FjhcemAiPvpXFyvRl3aHxjQWjKaLE2EWCYBPpep1kFl91b3o+H0Fof3NXGkiWc7CtCINka7NKnm1v4doBv5aKnQ8AZ3sEwDgDcgqMjS5Hqn8SAUgZstPXqpBC5ZIWPYqtYOKD/GrUorxeYTWdVprdA2m7gwgoMhMeNPRggmkq6vDVfKiT3SzsOi8Hjee60cMSUw5dLMHiuH51GTm+8V8Iv760Mj+JcnJatIOudGUSO4tqraP4EE+Rn4i84GjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4223.namprd15.prod.outlook.com (2603:10b6:806:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 16:40:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 16:40:42 +0000
Subject: Re: [PATCH bpf-next 9/9] docs/bpf: add documentation for BTF_KIND_TAG
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210907230050.1957493-1-yhs@fb.com>
 <20210907230138.1960995-1-yhs@fb.com>
 <CAEf4BzYy7_1jUHiNy6VWJ7nw4sUa5gABW1Mosc-1zcd+unvSZw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3ea879c6-3a83-8e09-c2b4-ae84161502d7@fb.com>
Date:   Fri, 10 Sep 2021 09:40:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <CAEf4BzYy7_1jUHiNy6VWJ7nw4sUa5gABW1Mosc-1zcd+unvSZw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:a03:338::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21e1::1064] (2620:10d:c090:400::5:7b93) by SJ0PR03CA0160.namprd03.prod.outlook.com (2603:10b6:a03:338::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 16:40:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06fe9810-0dad-4ca1-b537-08d97479baea
X-MS-TrafficTypeDiagnostic: SN7PR15MB4223:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN7PR15MB42230D4AD287C043E53B0C57D3D69@SN7PR15MB4223.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FaXTbftCfQBPX3bdbT6M2WlIHXyFBDVqQwBCKiR5R9jzoVt0vBkcm6kYBx/Dna0dBnWyZwMkW+A+nxtkorlL4fhkRpSyQ2VkD+pqkBrpgYOP4M/Rj0qzEGHKIvQRlqIfScql4Pm30li+xdtmAKoV2yA9b36Vadlq1szB3sb9ApTEMSx5Tmlj5tKvKbV7Gy/XCxAGtvagO9tiON2Yban6Y+4NEffRbv87owpczsu2ABFN1FzfryILU+IgfA0frSeu/4z70nhNmKacTo4i9XJi6vUxSiHlzy3snVn6Vl+xQNoPRhumWw2Sma5CZU0EM1VCs6YE6TzTg0rz7T+/JhkcXsbkVng83EaMS87Pd18Lipux2Tm1w00opGB01DijIns9VcIBpFWz9okPvf4RHLn2doYaAkjwhvNqLEjQVeGTj9kn925WsBa720gEWrRpLg6nmBUd45CihWfi9poQv91ZqU9IvIeAdZWWspN9rset6+NisuV5Heb+4OHvhIN7vghGgzcXGHBMILNr7Ob3cUYYe3eI+djzhC4p6IIvzG3gfQIl7N/isTk+PD3XwP/fPEtM5eCfUZjeUKq9woY8+PiViQQn1YWf6DYPgFVdm4Y5eDIZXVaMMRhLXk97n+1cjK+Sl/1/hnmKLI1Uxop4okZ3AjMkLgzHN8gJN8ofRq3NXZPP4EZj4S2QI5a6f0s6oQrNksfpAt1Ee4v2Cf4ZQimjDsW0CkshKDGTnXbN+ueuG7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(8676002)(66946007)(66476007)(83380400001)(66556008)(186003)(2616005)(53546011)(31686004)(8936002)(316002)(31696002)(38100700002)(4326008)(2906002)(54906003)(6916009)(36756003)(86362001)(478600001)(52116002)(5660300002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmZwVkQyV1V2L0JwMSs3RWJleFJVc2RSZjhZbW9hRnBXcGFJR2ZsWUxpcm92?=
 =?utf-8?B?alZGTi9tdm9aM3ZnRHErVG9IdnVkNEUwTXo4U2EvSTBQek5NSFBaN29ZN0xB?=
 =?utf-8?B?WlF1OGhDTmJZSENNQXpqdXlOSWMrcitlUitQUnhMOTF6TkIxek9BUFc4YzdU?=
 =?utf-8?B?djlBRTcrRVdRRFhZSW9sMG5FaHI0YnlpVEdZY1NML052MnMrZEwxT1ZkK213?=
 =?utf-8?B?Zys1OVBzWGdrY0phTEdQQStHdFFDVFRxcitlblg5ck54YkRIWDJleFJkZC8w?=
 =?utf-8?B?U295R2hGbVJTU1NvN3ZMK28xMmFjN1ZaeG5qVXhHcEdkemlBc3NlUmwzN3BZ?=
 =?utf-8?B?S3N2ZWl6Nm9wWU52WGJCb1BVUXRFMll6YUJ5bk9Eakc3ZjFSczRTeUg2TWdZ?=
 =?utf-8?B?cG5qWHdFQVJveGNEeVBTbmFmeVZrN2xHYi9mblZPektycC9OSUU1bjRSTnhu?=
 =?utf-8?B?QncyZTRyclRadTZ6a3B0S0Vqclg1bTZXWDltaCt0UUtpRjhyNXd4REkxQm5w?=
 =?utf-8?B?V1djUUJGNWhBVTUvN2hoc2RGMXAvSXBEUGF0clhFbWF5a0E1aU1JWnhlSXFt?=
 =?utf-8?B?aXR4SEx3WjRlbW9nOXVPMCtXVFZMQ2oxbFZ1U1hPNEJzQjlHQWNJTzVORmI0?=
 =?utf-8?B?ekhiZlpFM3ZMaU5UWmFUWFRTR1BJUEpnbithQjFpQTlJQ2dubkhqMlNlWXd2?=
 =?utf-8?B?dUZrcWlvSE1xck1MN3lPdlhUalV4SlViRUdFaUYvZnFLNy9KY3NRb2hsZG5F?=
 =?utf-8?B?N0ZLVnQxSkxuUk91R3hNcEN3Z3pySWcyUU50aGRmNFpYMnRTb2pjK29KdUtR?=
 =?utf-8?B?eFEzdDl3WEg3TUdVYWpnQjkrVndQZENuNEEyc1YyclhSOVphdVQwSFNUQnR0?=
 =?utf-8?B?OENlN0R0eFd1V3VlUXlnRUQyNXUxWFZOZnRhdE5BVzloZXd3TmoyaWZEaXVj?=
 =?utf-8?B?TXF2c0swYy9jaW9Pa2EvZ1I4NVZVdkljUmNNSFluSk4yaTUzZUtUOGpzd2U3?=
 =?utf-8?B?UG9iSXJhYnlMT2JiUkppTExCV2lDdzdMZzdqTjVPb3hYVGJYSjNtdmlxcEY5?=
 =?utf-8?B?YTVvelVxYXJRc2dyck16S0ltTHNlbXB2T1NWbjJrNHNiYXYzRjFEVlVnZVlT?=
 =?utf-8?B?cHkwUDNIODIvbXFGOEY0VzVEVEtBRm5uREFjVlZjTU5JT1FqVHN4aHIvWDgr?=
 =?utf-8?B?eXhiSGRQNzZ3bWhLbXlJRnh2bCtRdXR5b0t5T2szUXFJZHJDS3FOVHNML1Rx?=
 =?utf-8?B?VWdBNXBSR3FMTTlvWmFWOVRKdklsbWhFUlVreDVyV0NZV2RyVlNuMmJ0dFMy?=
 =?utf-8?B?SVVpelhTQVZWcDY0elhsTGZtbmdWZVNGeENXM0ZsdHY2c3JnYisvTjJSZ1Fj?=
 =?utf-8?B?TklBd3I5UE1uL2NpNHlEdk5ZTzVxVTZ1U3NtZkc5blUxUllCVlRWVXRjUmtF?=
 =?utf-8?B?bnlDRTR1M3FCaTNvZE5IZitFbEpPb0VXYUZWN0tUS3hXV1dlQjFuQlYrNWtE?=
 =?utf-8?B?VWhIbDN0Z01sVERqeHhEa0FIbmJGaFNHeUhvVkp5bFBxNWhOZkRXYzNTUHRF?=
 =?utf-8?B?VmE0Q1hadlB6S1NJWEYySkhUWCtaTXFrQVU5bG1KS3VFazVLcS81UHdEcGVH?=
 =?utf-8?B?cit2NEJRQ1JJL3gvS095RGZDMllqTjNhbkpNdEQ0Q1ViUXVBbXFnbUw2eTRF?=
 =?utf-8?B?RVZsUG1qMXpCYUw0SDJOSGcrTzBGbHNzOEpjejRKK1dDZTAreHNoWC9QN3J3?=
 =?utf-8?B?SXZ6OUFRYURnUEh4V1p3a2xRUS9YQXdEeWM1bUp0b0xwYWl5cXBTVUQyclow?=
 =?utf-8?B?elRrMlA3aHpBQ2hyeTlQUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fe9810-0dad-4ca1-b537-08d97479baea
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 16:40:42.6623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytuL7BUfCWP19xcdHDT29A63hpJ9mK3rLNEn/gDbdWdnXoR09H4pQPCmeKXBHT2e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4223
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: qFQtE51KaA00_ov_IOkUme33WD1DP1so
X-Proofpoint-GUID: qFQtE51KaA00_ov_IOkUme33WD1DP1so
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_07:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/8/21 10:42 PM, Andrii Nakryiko wrote:
> On Tue, Sep 7, 2021 at 4:01 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add BTF_KIND_TAG documentation in btf.rst.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   Documentation/bpf/btf.rst | 30 ++++++++++++++++++++++++++++--
>>   1 file changed, 28 insertions(+), 2 deletions(-)
>>
> 
> [...]
> 
>> +2.2.17 BTF_KIND_TAG
>> +~~~~~~~~~~~~~~~~~~~
>> +
>> +``struct btf_type`` encoding requirement:
>> + * ``name_off``: offset to a non-empty string
>> + * ``info.kind_flag``: 0 for tagging ``type``, 1 for tagging member/argument of the ``type``
>> + * ``info.kind``: BTF_KIND_TAG
>> + * ``info.vlen``: 0
>> + * ``type``: ``struct``, ``union``, ``func`` or ``var``
>> +
>> +``btf_type`` is followed by ``struct btf_tag``.::
>> +
>> +    struct btf_tag {
>> +        __u32   comp_id;
>> +    };
>> +
>> +The ``name_off`` encodes btf_tag attribute string.
>> +If ``info.kind_flag`` is 1, the attribute is attached to the ``type``.
> 
> This contradicts "info.kind_flag" description above

will remove info.kind_flag stuff in the next revision.

> 
>> +If ``info.kind_flag`` is 0, the attribute is attached to either a
>> +``struct``/``union`` member or a ``func`` argument.
>> +Hence the ``type`` should be ``struct``, ``union`` or
>> +``func``, and ``btf_tag.comp_id``, starting from 0,
>> +indicates which member or argument is attached with
>> +the attribute.
> 
> Does the kernel validate this restriction for the VAR target type?
> I.e., if we have kind_flag == 0 (member of type), we should disallow
> VAR, right?

Yes, I even has a selftest for that.

> 
>> +
>>   3. BTF Kernel API
>>   *****************
>>
>> --
>> 2.30.2
>>
