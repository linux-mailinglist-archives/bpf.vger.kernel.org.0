Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632EB474CCA
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 21:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhLNUv6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 15:51:58 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39104 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230396AbhLNUv5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Dec 2021 15:51:57 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BEIcnCq026854;
        Tue, 14 Dec 2021 12:51:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ERhhCvcwObJKRt0VYeLgHjvgnhhS1ePVPW8YGzBKd8o=;
 b=l7MfzVY8QQHm7Xiw4qnVnd8nU1u/ppDhLR9GHLchzCqkZaPFkojdJXPPxn52r4lx5klW
 8wyjIbwnmhB1RYqgWUrMytAlt+VOL14TBv8ewb/rYomJhz/8W+sDTWfMLAWTjfqCeyOQ
 uGBKQIRMZvyz5G5gozHIDMrMBWvVO273vKY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cxxn9t7hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Dec 2021 12:51:40 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 12:51:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0Gwv3qiRTAbtUPheE0nqGsoqjhJ7Ji6oqX3PabLCnkyUXajrMKafh7RTsz0Jmg6xdm6TtquVqeA9SucaQRfx4TTjsfTze0kwUuDxGrE5mMXhvAfjuNINFPAYndIRQ0t5Ea/+5VR9WWdYUQRE6lZDbwapTa8o1YdTSOt/SOhL2bJm4HXen30gARUgwiAFC8f5JgnhgMeqsMQSh7eOYKordlEBtQnyJNWWIwx2fdtcFXYcQ//dUde3hikfXl9BZKeyswVsU8GFaz2CJEWcmalo2IE9QWH8rUdsVy8m1D0VdJDpM1LGAqgEwlJt7/1qIX/VOw7J2isdWWldmNBhGXYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERhhCvcwObJKRt0VYeLgHjvgnhhS1ePVPW8YGzBKd8o=;
 b=LXQAuZylF+D+d8BwnXZw4oWvnHE16q+6aLFUMChAcn1F1tUSDhvZyG3wK3KLQe3IMfh3SnJprlmYeyzmxN5cS3yLdCMjntnv1VT/KtYMuNDFZztj5rZBhWor54cv7QMPjttQsadDhHWlIHkkpc7n2ooeDWPguHx+GKlw+ZfgO6jSPs4RYV8/WJa0mjjt1crhe2PoTuMbNEXT1nRFB9qar7u53lYOEsYIKlaQ2H3JznT5lpi+OtmXepKntFpk7rFSjZrYgjTGOkDBUBv3AE5RuLUwIyOEzHk7IZ04jh+vdhIFxfOiEuMSL0kjnIpHdlB65q1vrptQXdQAyEi27sD5aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by MW4PR15MB4443.namprd15.prod.outlook.com (2603:10b6:303:104::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Tue, 14 Dec
 2021 20:51:38 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::3d3a:2235:5b97:dd42]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::3d3a:2235:5b97:dd42%4]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 20:51:38 +0000
Message-ID: <35b54575-ede0-e9b3-ad3c-4b18ffe0089e@fb.com>
Date:   Tue, 14 Dec 2021 12:51:33 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v3 bpf-next 1/2] libbpf: auto-bump RLIMIT_MEMLOCK if
 kernel needs it for BPF
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <20211214004856.3785613-1-andrii@kernel.org>
 <20211214004856.3785613-2-andrii@kernel.org>
 <177504f5-c89a-a05e-8542-9c326d9a10c1@iogearbox.net>
 <CAEf4BzYRQcpd5meQ21oOBWdKdUnSM2VLF9oTV9kQrX8cmnk==Q@mail.gmail.com>
 <9656836e-f9ea-f1ff-80c2-f4aba51f0d8d@fb.com>
 <CAEf4BzbmBNRB0sWAxHpSaW6fYMbgrCDm9K=8XScYGa2PEpdsPA@mail.gmail.com>
From:   Alexei Starovoitov <ast@fb.com>
In-Reply-To: <CAEf4BzbmBNRB0sWAxHpSaW6fYMbgrCDm9K=8XScYGa2PEpdsPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: CO2PR04CA0136.namprd04.prod.outlook.com (2603:10b6:104::14)
 To MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c5c08fd-9964-4386-cfa6-08d9bf438579
X-MS-TrafficTypeDiagnostic: MW4PR15MB4443:EE_
X-Microsoft-Antispam-PRVS: <MW4PR15MB4443B6122C76828A19B75E23D7759@MW4PR15MB4443.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 125LdQkeH96TGZz80OVGdrfOC1EqZ57ZnlwQPyRA0uvYf1DV46uWr5tIFd1b+urIKdloClkFn8EbeGJZPITMgRacvM2w8mKEdI0WCy+OuUomQsqtZGNPY12KPZ2ufSMT1NLYJuOjiXMFfqjKiBiNQgH330fHsQ/otognBmmgfqvcCz5PK9CDapj2A9dTHFYQwKFKXkDbKErNDvQe9tvNya02ynAdQDlEd1xpH0LpcAvE0f/QN+0JZLt8LDDFsBQdDCKgAebfVL6g4edTzp897MisATy7s+cV0dKCxvl9aktL+OLGBaqjEFoD/d9d31uZ7CrEu6I5RXpvWnV6P6sh5/Hu4yqnLodQXmeVMZGhPqxWJwctWKpugJ3pt+CIl3u0/zFJ2BIxzmu7ujDnKD5NzfU9ust6My2WbVNkWDEiKZ5qgnLVKm3m19ooUP2W3y//IH7WiO5cUeNUu3mehZhFjX75t2MMGVOsATUsRkjoK1jtbae1mICJipw0uz+TYs1eJzw0kEaiXC+SN0mvwLxW4MHzN5AKJ+ZV3tvEzq1dJPsKcqwYMRTXlMU7XiJR59HsDZM2sUaMEcGpODA4zufDuCTb9PNi2WUKWQVvPGlKlKXneyztHvX6QKnZW12HHpxd/hYq3OsL/KKPwKu+4hNNT/C6Rby/GQAxmJjnrPv+gf6ky9bSNHGk3xLlafWnEsrqFMRz9lzL2aq3X4flpFR4EvxRdJzqrBpCGcTHgZKtQNGswA2GNQ3M2r2MU+O6WgiKRVosZX4YIDb+ODm1sxt/7pqbfNbUe9Y5RlF0ueaP6s3aXLYe46znPS+Tkh+/YPLkrPXnauy+5rsKb8zcEWXfOoh8aBjcotyMpb8QdiHWLhp8gLR21Urgv3xX2gtBxh/m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(966005)(54906003)(66946007)(316002)(66556008)(508600001)(86362001)(83380400001)(66476007)(6916009)(31696002)(5660300002)(6666004)(6486002)(8936002)(31686004)(8676002)(2616005)(52116002)(6512007)(38100700002)(36756003)(186003)(6506007)(53546011)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkt1MU1EbDhMSGdsWHlrckUxUGg0SXY5L3huY1JlOFBoZ0RTb0lzMGhDbGFi?=
 =?utf-8?B?bys4empZTHZkOElHME5UZDhDZ25DYy9LZG1iZVloTVJLeXBVWFdSblEvZnhy?=
 =?utf-8?B?eXpuei9Pby9qR3JQcFpmeHA5aHptc2hVbVJQYWVPMkRwcmtacGN4QVJnYmNp?=
 =?utf-8?B?TGNmZUUyelY1YXo4OVVMQm42RWRzdzRyazlyWktyY2xVTFk2NUdyTFNjYWZK?=
 =?utf-8?B?NFVjY3ZFVGFScFI5N1NLUER1Wmp3VkE2NzgvOGpud1FtT0tqQ1EydXM1RjQ0?=
 =?utf-8?B?dW9KQ2I1bkU0M3p0a1cxQzVnSkI5U1AzdE55QWdTR3FNWHExZTkwZE1nZkxX?=
 =?utf-8?B?ajVWai9EQzZuTVNXSnpaN0FzczI4VWhlVHZTY2ZLQ0gyZjAwb3VKVmhUVlFj?=
 =?utf-8?B?aTE1dEdZZ2tpblA1RC9XTVJZWFJ4QUhJWXB6UEtCenlVV3lFL0pjLzFJakJs?=
 =?utf-8?B?cmJMVlVSblRvd3NlSHI1YTJqcDYwSUc5dHVHVm1JTytTWHpNZkNOQlNsdkt1?=
 =?utf-8?B?R3RBdWx0eG9FdzVidFo2YUF5QjMyeWdJQ1gvK3NJak4ycDBOQVhyRkJvdmJr?=
 =?utf-8?B?TVpYNDZaVXFmbTVUMGNUb2ZGY2pESjJ0WlR3V2NZZzEvMmw2Q1lhcDk1dklj?=
 =?utf-8?B?UUNTOUhKOXVnRnZBZnlmTHF2a0FqUGxTUXpiM0h1MHI5Y0xnNklhMGRocFR4?=
 =?utf-8?B?VUUydFBPN0JrTFRPbUk5eFV6U2lmbkdtOTcybXZYZ2NxbXBIYVl4cFZUekFr?=
 =?utf-8?B?NGVkNHoreTZEZEhlaEFRNGd1eE5tL2oxQWp5TGNKbU1wQk5IV1QrZXIxMXhZ?=
 =?utf-8?B?bW15aGFKV0txNFFYbUU1RS9vdVBYd0t6NGoveGpqUDFnb3BzbEJXQndmVVFn?=
 =?utf-8?B?YzVZbE5rbktTL1I3VjdURm50WTBnb2MrT21tQnFDbnZvZDJGZXFTRGhiOVZi?=
 =?utf-8?B?eWZLR1B6UHVLTTA4NDBkUytlcUcyYnRjNGpDTnE1MjlETlN1bWl5OHV6eitl?=
 =?utf-8?B?RVJNbHhRY05MYVJWQ3FMdFZTdVpOMkF3blNkZm5yVHpqQWNTRStYZkswa1Za?=
 =?utf-8?B?QzNidlNLemtQNmZPMEw2c0tqYVNWNmE5a2NPS3dNMlI5ajBwRzNDZ0ZJL1c0?=
 =?utf-8?B?R1Z1dTVXVzlzZ3JQa1UzSTl0cWN3S2NLdTFmOEdlQzRpOWczZUI0L3ZURFVN?=
 =?utf-8?B?cGVtTG0wR0QvbjNzblpoWklQRmFQOENLaWZQMlJWdHBRK1BIQ0QrZDQwQiti?=
 =?utf-8?B?VTFCYUxqUXJZZnpJaHhjd1l5QzdBbGhUUG1hWGJKMTdLaGdLRU1wdk1aNjV6?=
 =?utf-8?B?aDAxaXBIVDE3VkRJV1ZBZE80MldJdFkvN2ZVeUFsWGVuMUJTYVo5bDZoU2Fy?=
 =?utf-8?B?TVJReis1SWVQZlQ0eHNpdTJ6dmlEemVnbnNIN0tGRmpxbGdSMWpMdDBMMjZ2?=
 =?utf-8?B?NElHQVpSY3VHcXJxL09oRkl4MTdFVU1SQk9sM0pCZktpTTY4SVcya1N6WlNy?=
 =?utf-8?B?aUk4dGJMbkVrT3BRUW11cHFRZEhLblBWMTdSQ0tFMTFnQTQyKzJURjY3a2VC?=
 =?utf-8?B?aVpRbk5xR1JqT1VpbHBuWGxWRFNsODVQb1Fia0NoMGIxZzQ3NmlJVDRneHZt?=
 =?utf-8?B?c3NzS1haUXc4YnhjTnFSbDRCMzMyQnJMZ3FGTU1pbVJOOW5WQVZsa2xpZ2pw?=
 =?utf-8?B?SVE1YmpqV1dMUkUrSlpselR5YThoZzg2a1plbTFZcEczenluamhRNEZPMHd0?=
 =?utf-8?B?Ujhuc2lNYXlkSCsxYk1zMDdxMCt5M2xkTS9HejFyWW1ydy93ZitjN1JybEpP?=
 =?utf-8?B?U3o5d1NpR2lFT1E3MFhPUkh1S0VtaVZwZGhkemFHK3dzeVpvL0FVSTJzVWZk?=
 =?utf-8?B?ZWIyZUlQK1ZXZVBpbWIzbFdPNGZsYm1CZ2pqT21GWHV6ZGhKZmFkVHEwM0ZC?=
 =?utf-8?B?L2Rqcy9QWUdVNm5tNG9RYnFGK0t1QVBtOHlIRS9zOEZHY0hFQThCYVNlWDBV?=
 =?utf-8?B?cDRlOVhpTmNaZUczTytGMkwyVjhXWlA0N1h5eGFKMFhsZUhZSVVyZG1NMXB1?=
 =?utf-8?B?OWxqbi8vamhPMnlFZTNvcTVnZjdvRzUyWmlySU10Ym1WcTZ6UHJXdTdqTHEy?=
 =?utf-8?Q?VNKducM+21nnRTdzzGwbL++JP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5c08fd-9964-4386-cfa6-08d9bf438579
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 20:51:38.1307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtviJmBqiRCHwcu8KZgQhJg1/fzhkZtBqEqPt0lac6yWmlEcp1SdflAgIsD+kLWd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4443
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: vkAEVdibapeqeerTBsOkt022lj3ayL7w
X-Proofpoint-GUID: vkAEVdibapeqeerTBsOkt022lj3ayL7w
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_07,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/14/21 10:31 AM, Andrii Nakryiko wrote:
> On Tue, Dec 14, 2021 at 9:58 AM Alexei Starovoitov <ast@fb.com> wrote:
>>
>> On 12/14/21 9:51 AM, Andrii Nakryiko wrote:
>>> On Tue, Dec 14, 2021 at 7:09 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>
>>>> On 12/14/21 1:48 AM, Andrii Nakryiko wrote:
>>>>> The need to increase RLIMIT_MEMLOCK to do anything useful with BPF is
>>>>> one of the first extremely frustrating gotchas that all new BPF users go
>>>>> through and in some cases have to learn it a very hard way.
>>>>>
>>>>> Luckily, starting with upstream Linux kernel version 5.11, BPF subsystem
>>>>> dropped the dependency on memlock and uses memcg-based memory accounting
>>>>> instead. Unfortunately, detecting memcg-based BPF memory accounting is
>>>>> far from trivial (as can be evidenced by this patch), so in practice
>>>>> most BPF applications still do unconditional RLIMIT_MEMLOCK increase.
>>>>>
>>>>> As we move towards libbpf 1.0, it would be good to allow users to forget
>>>>> about RLIMIT_MEMLOCK vs memcg and let libbpf do the sensible adjustment
>>>>> automatically. This patch paves the way forward in this matter. Libbpf
>>>>> will do feature detection of memcg-based accounting, and if detected,
>>>>> will do nothing. But if the kernel is too old, just like BCC, libbpf
>>>>> will automatically increase RLIMIT_MEMLOCK on behalf of user
>>>>> application ([0]).
>>>>>
>>>>> As this is technically a breaking change, during the transition period
>>>>> applications have to opt into libbpf 1.0 mode by setting
>>>>> LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK bit when calling
>>>>> libbpf_set_strict_mode().
>>>>>
>>>>> Libbpf allows to control the exact amount of set RLIMIT_MEMLOCK limit
>>>>> with libbpf_set_memlock_rlim_max() API. Passing 0 will make libbpf do
>>>>> nothing with RLIMIT_MEMLOCK. libbpf_set_memlock_rlim_max() has to be
>>>>> called before the first bpf_prog_load(), bpf_btf_load(), or
>>>>> bpf_object__load() call, otherwise it has no effect and will return
>>>>> -EBUSY.
>>>>>
>>>>>      [0] Closes: https://github.com/libbpf/libbpf/issues/369
>>>>>
>>>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>>> [...]
>>>>>
>>>>> +/* Probe whether kernel switched from memlock-based (RLIMIT_MEMLOCK) to
>>>>> + * memcg-based memory accounting for BPF maps and progs. This was done in [0].
>>>>> + * We use the difference in reporting memlock value in BPF map's fdinfo before
>>>>> + * and after [0] to detect whether memcg accounting is done for BPF subsystem
>>>>> + * or not.
>>>>> + *
>>>>> + * Before the change, memlock value for ARRAY map would be calculated as:
>>>>> + *
>>>>> + *   memlock = sizeof(struct bpf_array) + round_up(value_size, 8) * max_entries;
>>>>> + *   memlock = round_up(memlock, PAGE_SIZE);
>>>>> + *
>>>>> + *
>>>>> + * After, memlock is approximated as:
>>>>> + *
>>>>> + *   memlock = round_up(key_size + value_size, 8) * max_entries;
>>>>> + *   memlock = round_up(memlock, PAGE_SIZE);
>>>>> + *
>>>>> + * In this check we use the fact that sizeof(struct bpf_array) is about 300
>>>>> + * bytes, so if we use value_size = (PAGE_SIZE - 100), before memcg
>>>>> + * approximation memlock would be rounded up to 2 * PAGE_SIZE, while with
>>>>> + * memcg approximation it will stay at single PAGE_SIZE (key_size is 4 for
>>>>> + * array and doesn't make much difference given 100 byte decrement we use for
>>>>> + * value_size).
>>>>> + *
>>>>> + *   [0] https://lore.kernel.org/bpf/20201201215900.3569844-1-guro@fb.com/
>>>>> + */
>>>>> +int probe_memcg_account(void)
>>>>> +{
>>>>> +     const size_t map_create_attr_sz = offsetofend(union bpf_attr, map_extra);
>>>>> +     long page_sz = sysconf(_SC_PAGESIZE), memlock_sz;
>>>>> +     char buf[128];
>>>>> +     union bpf_attr attr;
>>>>> +     int map_fd;
>>>>> +     FILE *f;
>>>>> +
>>>>> +     memset(&attr, 0, map_create_attr_sz);
>>>>> +     attr.map_type = BPF_MAP_TYPE_ARRAY;
>>>>> +     attr.key_size = 4;
>>>>> +     attr.value_size = page_sz - 100;
>>>>> +     attr.max_entries = 1;
>>>>> +     map_fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, map_create_attr_sz);
>>>>> +     if (map_fd < 0)
>>>>> +             return -errno;
>>>>> +
>>>>> +     sprintf(buf, "/proc/self/fdinfo/%d", map_fd);
>>>>> +     f = fopen(buf, "r");
>>>>> +     while (f && !feof(f) && fgets(buf, sizeof(buf), f)) {
>>>>> +             if (fscanf(f, "memlock: %ld\n", &memlock_sz) == 1) {
>>>>> +                     fclose(f);
>>>>> +                     close(map_fd);
>>>>> +                     return memlock_sz == page_sz ? 1 : 0;
>>>>> +             }
>>>>> +     }
>>>>> +
>>>>> +     /* proc FS is disabled or we failed to parse fdinfo properly, assume
>>>>> +      * we need setrlimit
>>>>> +      */
>>>>> +     if (f)
>>>>> +             fclose(f);
>>>>> +     close(map_fd);
>>>>> +     return 0;
>>>>> +}
>>>>
>>>> One other option which might be slightly more robust perhaps could be to probe
>>>> for a BPF helper that has been added along with 5.11 kernel. As Toke noted earlier
>>>> it might not work with ooo backports, but if its good with RHEL in this specific
>>>> case, we should be covered for 99% of cases. Potentially, we could then still try
>>>> to fallback to the above probing logic?
>>>
>>> Ok, I was originally thinking of probe bpf_sock_from_file() (which was
>>> added after memcg change), but it's PITA. But I see that slightly
>>> before that (but in the same 5.11 release) bpf_ktime_get_coarse_ns()
>>
>> Note that it had fixes after that, so in the kernel version where
> 
> You mean 5e0bc3082e2e ("bpf: Forbid bpf_ktime_get_coarse_ns and
> bpf_timer_* in tracing progs"), right? This shouldn't matter if I use
> BPF_PROG_TYPE_SOCKET_FILTER for probing.

hmm. I guess we allow it in unpriv too.

> fdinfo parsing approach has unnecessary dependency on PROCFS and is
> more code (and very detailed knowledge of approximation and memlock
> calculation formula). I like ktime_get_coarse_ns approach due to
> minimal amount of code and no reliance on any other kernel config
> besides CONFIG_BPF_SYSCALL.
> 
> But in the end I care about the overall feature, not a particular
> implementation of the detection. Should I send
> ktime_get_coarse_ns-based approach or we go with this one? I've
> implemented and tested all three variants already, so no time savings
> are expected either way.

Either v3 or v4 are fine by me. Let Daniel pick.
