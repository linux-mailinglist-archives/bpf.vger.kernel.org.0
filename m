Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C545C42AFCE
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 00:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbhJLWtB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 18:49:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34766 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229588AbhJLWtA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Oct 2021 18:49:00 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CMfmiL017127;
        Tue, 12 Oct 2021 15:46:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ICcA+sYChV9K6DCuczObudaNx7L9qjd1HNi5ks3cyh0=;
 b=bGwiE63/WXczB+1ckfS68E1PJa3EmmSv7UKr6aZUjgP9/kgl2vfi05k+VWApbzG6Bjad
 btZd5gH/7C5NC1tv+Wu1jCenSrbvxbDr0YwqO/yif+55Z73FEdm0rWkhuPE6YqaGM3nU
 lExghFDlkHRahficqWkYtgPu2vyv35mDuKw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bnkcjg11m-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Oct 2021 15:46:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 12 Oct 2021 15:46:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibGmhGXbmNEuiHcbOvk+ILDfCfo9FXfD1fjFZ/0dRdC94AltDduqJC50mOigDkF15gXtvLVjuGabQXcOaP5QQ0MCrTTp7AAEb5v9S617SnZx9Rd6ylwYQAJUXJueNaU4cpfaBOTnEXx2FnAbWDfvfaQH8IcxWj6eM4eMoM1p66VX5xW/uupSSvPOD6Jr0/IswmqhedTCZ52m85EI0lr7tacOQXmZhlinCmvytIORoFCRZxBRix/4woZRhQcVMdCELM9cq3HcVHKFPT0e1m9O5ARIeEtErQUxBTo1sA8iUieF6q0r/8KmxZYqOvi+9Ng9pay5pUHC+9iFzE2+8Jaj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICcA+sYChV9K6DCuczObudaNx7L9qjd1HNi5ks3cyh0=;
 b=Y144H3v6o/li13uzwnecQvjv1qJALeBBwYd1fntRtoL7tkIgNKcv/TDqDYfprDHNnoK9jCuj12Yk8Ypzv1p18iH3wBtYwzMHiSwIMZdwY8V0BIqrLsn56A2f6P/h+vZRpEHtemvJqwlViwaX1yN1oFUh8tgj6GEl1D1SBwKgSZOLC1lmhC1xhoFfHEgoSVTHxfO/aFA1GHqfEbIphCUQJqn3/yvoXObEQzRogBg7Xxgd1fYAhmr89jiR1d2LRCnA0O6qbIalgtZr3TMYHI7iy4nPitZIz3bUDWQGcvX2s1OK6+9hnfu8GABMw1RjvOYIYRe/ZEh6r8jUAYIK1xCYaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SN6PR1501MB2191.namprd15.prod.outlook.com (2603:10b6:805:10::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Tue, 12 Oct
 2021 22:46:50 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::2413:3993:2f20:c304]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::2413:3993:2f20:c304%6]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 22:46:50 +0000
Message-ID: <38d80c55-97e1-4cbb-cb23-d6331d8f539b@fb.com>
Date:   Tue, 12 Oct 2021 15:46:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bitset map with bloom filter
 capabilities
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
References: <20211006222103.3631981-1-joannekoong@fb.com>
 <20211006222103.3631981-2-joannekoong@fb.com> <87k0ioncgz.fsf@toke.dk>
 <4536decc-5366-dc07-4923-32f2db948d85@fb.com> <87o87zji2a.fsf@toke.dk>
 <CAEf4BzbqQRzTgPmK3EM0wWw5XrgnenqhhBJdudFjwxLrfPJF8g@mail.gmail.com>
 <87czoejqcv.fsf@toke.dk>
 <CAEf4BzbWVCz6RNKHVgqLYx8UqGUdDqL5EPKyuQ5YTXZMxt2r_Q@mail.gmail.com>
 <877deiif3q.fsf@toke.dk>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <877deiif3q.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO1PR15CA0082.namprd15.prod.outlook.com
 (2603:10b6:101:20::26) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e1::1a1e] (2620:10d:c090:400::5:7eb) by CO1PR15CA0082.namprd15.prod.outlook.com (2603:10b6:101:20::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Tue, 12 Oct 2021 22:46:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baf93cdc-8cff-4875-8885-08d98dd22dfe
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2191:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB21917E399F5F67AEB050750FD2B69@SN6PR1501MB2191.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AH+vxOXW9ShCEUiYu/ZudBfESDwKJGaecCR+tykmc1i3FlMsQDtEkJusc12hNqcS7cEtAdIFR7dtW1PiDSbR5rCkkoss49ZcrKsdhWKSDPQLKA20SsP6uVcL3eXyjA+0NeXGg0HU+pKz/K4/mNfea8l6VOCtpd6R50rvrGpFWVNtJJMNZUhBOYI+OkfWgoLKn3BAjw/fni7yLjnb+vRH2017Rxk0d8EBzbo/LC4WycJc0HAH2Ont+pYsFBUauULp3iMZjdaZM9jxcK7VQFrq9psAEyXcSm/345x3mr+cMBVNiJ+oJYKV9UuFnzD1rrIVFWzPtzQQ3zQjwKAXN5AhQczebclhx8zDP/Td8bfRVBoOdsJxvB2v7DyqjkoA2fen4zJ2tTjCireyeRPTs9OzzqbT92dw3qZcQNGxi2gDCZCTt6hPKz9+j6Ghg8LNjhguq6y9lER7A7gq0lTCiKPFfU6WhxIXQht27Oyqt9+/htyP45zOv0ob9Ye4EjRQWjUsw4L2Raw8VNJwcWdAVZVljfnxFh9q0QL89S7fYYIbjSWuM4U5xeFxJfQWNZiY+213KD00dSrv02fHw59AMqRwCGsk/AAegCMP2Vkhhm0GtSCQHMjpe+w4C4XKXotd+4CGvI1VVyxSsndbyP2S8SUMbvIqawIdOwT19qLeNuZE09zpZbjhqitOjUKKclHpqpwuiT7i871rfrcQIvhDbMahYG316Sc7h8ceEGpuUrsM2aE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(4326008)(8676002)(66556008)(8936002)(6486002)(186003)(66476007)(31696002)(86362001)(316002)(66946007)(31686004)(54906003)(36756003)(38100700002)(5660300002)(110136005)(53546011)(508600001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUNMR2huN3FOUFVZV3RqWmo3VmxqR3c2ZlpKaFBKcEJtZjFKcWdBMnFWOHFY?=
 =?utf-8?B?d0dCV3JSMGw3UzdrdjZIdENCRlB2UXdLak8yTGJUR0tGdWpnOFJRQzRFcy9r?=
 =?utf-8?B?Qlhockxub0tFRjdHaW1vMm5NNHZnczYzc0pXdVJWZno1VXF5V2FMZVZmTmN6?=
 =?utf-8?B?WGZKVDNJZVNvL3BkQk5RajBEMkh3d011UWhVa21QMWZQU0NOZVUrbEFtMkpE?=
 =?utf-8?B?TG1xYVVzMDZ4Z2Z2NFlUeEQ4d0ZMcnlsOGFEUFp5OEw0Yi8rNXZKOGdwdStk?=
 =?utf-8?B?N2FHZUFaRUxzNkV2cmozVy9oVjdRWDMyd21aRlpJVEJjdlBqWjYvSkdEZUN2?=
 =?utf-8?B?VUdOL0wzWUJ3WWNSTEszL3VIV29VZS9zZGh6c1JpWnBpdU0yNFZtbUZKSWph?=
 =?utf-8?B?Zm9Cc2NXUDZIWnVCZG5HM1hKcUg5a0pUbktudDkxUXFPOU9LVXNlY2RuWUhu?=
 =?utf-8?B?cUdTZldCTjY5TFpWYUx1cTdDNGszY1R2dHZGU0YydmRlSEV5U0NFNGhhU21G?=
 =?utf-8?B?eWgzZ09Ocklpb3gwUmM3UXdpRFd0TkZOWWZWWFhjakdraUhtMlh1VU1CWUFI?=
 =?utf-8?B?R2lRQWFVREtFbzhqaE5QWGhMZVBxcFlSZ1JMYnNMWTBDQlQwT0VVamxXZ1dJ?=
 =?utf-8?B?bUUwTGZ3dTBlMmM5ZnRqeGhsZmR1WmdIQnErR2d0emtTemV3bjJha0grRytn?=
 =?utf-8?B?ZnF1bDhpcUpwQmdMdTVRdmV6YzI2RHFKRkFtU0FUS3lwMWxJOWgxN1JabGJh?=
 =?utf-8?B?dE51dyt6UjlFZTkyWnBOOHBZQzdZaFdwd1JaNTVsaHJPOXRkV0VxekJ1dElj?=
 =?utf-8?B?MFlhbkIxU3dwL0I2WitudldjWW44ZTVGZEpLL3BDVU41K2UwRUEyNjU2R0dP?=
 =?utf-8?B?YXI2dXlYM25oVGJvVW5tWUlBVkZ5RzBPK1VQTmZqVDlHMmtFemZxUmdhcVN2?=
 =?utf-8?B?QTQwTkdLaU4zVHAzRytQVXRJcGRYQUYydUJiMFNHQnovUDVYcWw2MWdpN1Zh?=
 =?utf-8?B?SmlvME5YNnRmVVV3VUJRa09JMy9XWjJTakZxYlFISWtIazBLaG9rWjFRbVQr?=
 =?utf-8?B?Y0pGeG9BWjZIMjRDWURlN2NuYW5oS2JLZ3FNTk9abDR3Rm5iRmxGb2V3M2tM?=
 =?utf-8?B?RWlPK1hBVlg3S2JTMSt4c1BvTnRkdVdBcUxnUTFuUThja05yTjFOMlppWE51?=
 =?utf-8?B?QWU1WE1hVzFkdXc4SUFxc0tKbDFhY0pEb2FzbHhHVnNYMVB1NWpxdzJJSGNL?=
 =?utf-8?B?M1h3MGJXWHR0NkN5Y0Fib01Lb3JrZmRlRGJIVERtbWdWOU01UnhERUVGenVS?=
 =?utf-8?B?cDdBNjRsUHYrSmZxN09SYUtLaGFYQ29JK2xORUFVR2xhdVJ6TytWZFYvTXpN?=
 =?utf-8?B?MDhleXJMOUVrWGZsOVpRQkJFRVR5UEU4UW04Uzk0NmhiWVRVeS8xeXduaHJX?=
 =?utf-8?B?Y0YweUR1SW5jZ3ZqcjRFekFrSWM3N1NTdHdkeURLb3hzU0dnRjNJbnZUYjVV?=
 =?utf-8?B?U1BCY0hqamNrbzdTcnRhVHJCK1Mwb0tXOFFRc2NScWJNcldQbm1EdGUySWdO?=
 =?utf-8?B?QnpScDYxS21Sd3hUWVFLUzFFd3k2T0d2RGNvNVQ2eHFxcFpNeUx2UGNLN0NB?=
 =?utf-8?B?eE9ycThaTW1Ud2J5TTAzY3N2TlkzenhiMUpJeWlKdEk2eUh4dS9yRU1LMm5O?=
 =?utf-8?B?VHJDNmNFZXdHcVhmNERvcThCejJmT3JRYlFzOFkyazNGOUFKRXZvWkpEcmx6?=
 =?utf-8?B?cEZxY0x2SkFKZnRrNEVIL0szTXYzbUJ0WDNzcDBTdnNxdUtrYVA2S21yM25Q?=
 =?utf-8?B?S3czeTVzRGRnSUhCUmJrdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: baf93cdc-8cff-4875-8885-08d98dd22dfe
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 22:46:50.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZTDyEtGCsCidh+UwqF21WToONMcaXV3blPvnxCgysqiQDdfhIIWRMee6luFFn0FQTALDDVUfXI5wzrzGWDLJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2191
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: VQn7HOHNDdwWgpqK5CV_XbVw2_dNv_oE
X-Proofpoint-ORIG-GUID: VQn7HOHNDdwWgpqK5CV_XbVw2_dNv_oE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_06,2021-10-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 mlxscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=873 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/12/21 5:48 AM, Toke Høiland-Jørgensen wrote:

> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
>>> The 'find first set' operation is a single instruction on common
>>> architectures, so it's an efficient way of finding the first non-empty
>>> bucket if you index them in a bitmap; sch_qfq uses this, for instance.
>> There is also extremely useful popcnt() instruction, would be great to
>> have that as well. There is also fls() (find largest set bit), it is
>> used extensively throughout the kernel. If we'd like to take this ad
>> absurdum, there are a lot of useful operations defined in
>> include/linux/bitops.h and include/linux/bitmap.h, I'm pretty sure one
>> can come up with a use case for every one of those.
>>
>> The question is whether we should bloat the kernel with such
>> helpers/operations?
> I agree, all of those are interesting bitwise operations that would be
> useful to expose to BPF. But if we're not going to "bloat the kernel"
> with them, what should we do? Introduce new BPF instructions?
>
>> I'd love to hear specific arguments in favor of dedicated BITSET,
>> though.
> Mainly the above; given the right instructions, I totally buy your
> assertion that one can build a bitmap using regular BPF arrays...
>
> -Toke
I have the same opinion as Toke here - the most compelling reason I
see for the bitset map to be supported by the kernel is so we can
support a wider set of bit operations that wouldn't be available
strictly through bpf.

I'm also open to adding the bloom filter map and then in the
future, if/when there is a need for the bitset map, adding that as a
separate map. In that case, we could have the bitset map take in
both key and value where key = the bitset index and value = 0 or 1.
