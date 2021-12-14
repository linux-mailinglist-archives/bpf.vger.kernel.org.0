Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D19474A2B
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 18:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbhLNR6g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 12:58:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37250 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236701AbhLNR6e (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Dec 2021 12:58:34 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BE8QgM4006368;
        Tue, 14 Dec 2021 09:58:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=VhHV9DDq2wC0Q4wpX1ZirU8wkfHqdhnnPwO/667h1Yo=;
 b=GYe6urKzkAv8ORXMp9LNOBGOMDMdBCz/rAtrCqTr1WKvM+LwB9MwjeE0qQkh4BXLAdYM
 r+7GOTDeH5w42zoxaSnntmQaLFEcNtSsmYRoiMMXCDoVjnebIuz7+Tdzr9C2nGaOZgWH
 QSVw50lWfK+kcqfJttBzvqIr133xe//YuY8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cxqrbc20t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Dec 2021 09:58:20 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 09:58:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyjVIvqJ/L5Qy2hv3E6tFiqFupTmX1QjjjIlE8fzUa857OmBYisVq5hkAdq3DVhOACcprJj7uIE2IfwwzvIhYv9SWbQhft251bpR3id2T0Qq4zNhuxGvg93fUF/qR45IdACkbVy9AA8cJNelPPZhtRTkmkaLOiIHOjdOsTLZK0R0mlwlN5Wo6wbMeGNg0lCnoLdWHnjfpVOjvYEbIF72UnxfxXt4Rqun2HrrqpYX5v/a8HndmPl4AsTybqpzQN5MWpcKTOuxmnkNpXBu0Qzua8qnjLOoZnexOLnmX5XgbI+S+kcDVo+21+sRx69izmMNZHXbQCKpr+qI2Df+0faqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhHV9DDq2wC0Q4wpX1ZirU8wkfHqdhnnPwO/667h1Yo=;
 b=mMedKjX8tiJF45dxPw+WRCII8NWHQa1J4gXptXW8eznvZ7mgLJqnCK5zh37kqq70YiWHod+B4HTOoNiqkJT/q+CrqsJ6aGZWySLaqvE7rV40Sc6BItEFVORpiMhN09POO32nqQAE7GuMtiUMtHoFPcjd3WjAzsOKFPbUwhdTpLvoD9j9yGHNEVk+aRuCT4wZB/gNB6glTDI07d53UnmusWKhbmZJyps+ZpINdZqB2NJ+UXejpUO7BP1QgvOOz5GXbbOZUh6K6w2uD2Wee2bSeqPAmwdn3CWuRvbN3K6iZ75MKMTwvdIKh8IpabDiuRi3viRWIxWPPRWK3/tZYqaf1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by MWHPR15MB1280.namprd15.prod.outlook.com (2603:10b6:320:24::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 17:58:17 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::3d3a:2235:5b97:dd42]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::3d3a:2235:5b97:dd42%4]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 17:58:17 +0000
Message-ID: <9656836e-f9ea-f1ff-80c2-f4aba51f0d8d@fb.com>
Date:   Tue, 14 Dec 2021 09:58:15 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v3 bpf-next 1/2] libbpf: auto-bump RLIMIT_MEMLOCK if
 kernel needs it for BPF
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <20211214004856.3785613-1-andrii@kernel.org>
 <20211214004856.3785613-2-andrii@kernel.org>
 <177504f5-c89a-a05e-8542-9c326d9a10c1@iogearbox.net>
 <CAEf4BzYRQcpd5meQ21oOBWdKdUnSM2VLF9oTV9kQrX8cmnk==Q@mail.gmail.com>
From:   Alexei Starovoitov <ast@fb.com>
In-Reply-To: <CAEf4BzYRQcpd5meQ21oOBWdKdUnSM2VLF9oTV9kQrX8cmnk==Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR14CA0001.namprd14.prod.outlook.com
 (2603:10b6:300:ae::11) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 299c9928-0a2c-4c2e-a551-08d9bf2b4ec6
X-MS-TrafficTypeDiagnostic: MWHPR15MB1280:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB128061C962401B7E1C5BC63BD7759@MWHPR15MB1280.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMIc5tw/OnvxPnftRVM4k64cES1PmMmDALHWH1vJJXslzLEuyx8jVb+XQabPYi84A2s6N1pLrJhWLlsW246Jx8cudn+kiQHnliw6zo0rZ9jcpzRI7wSxGvFGPQ82353UytiM3ysxTWZUedvJUDn7+ti5LpcPlofEKM+MbH7+mkltOWdBtPcsfKB+op/UBJtQDzAdMqSFDWB2MlAk2fnKO0NIAE/ydvOGdKZ6koGwb8Ln9MTl8RifQ6l10pfRl5P7WVp/XeMevwpCm13JFBNCe4vDIAWjTeK87/gFCcbrYyDN8feTdHZeBAlco1ziaiwP3Ylwt+U9sPhPveWEIYvGWjnalQhmBxUqtMzbDiGH6dvFGgGJ1Lm+6urxhYe6fhwAG7rSTkc+m9nePFUw/jdOVK6p9T7eKfLnFDV0WSQpmeM9YxVFzK5UQrMjNXk4XrP/t0Tf8bItnpDmt9yvXvRWz3Lt7nEBN8Uf9grmyoi7JFUqTnmAfP87ZmzT3Wh8lpaRkRGSrpFXUDN4pIq0orZbBMOR/eXFRbD2dnUJDgMLBK4GeARnw8ksxl3Ng/gg+/lVjulZ2bTMag4FTMvJQshMETLb5flF6zKFmZAEKRZdEDp8JdGG6L3UiN4BQr+5N25vNWQ4Vvij1I6mgwy+V6OagiqlnU8uZs3csmZw77ohHimQV61k1lqNOm9Ekga3CMgBQL3IuhH8PZeD9PdXvkf/btfCG0j/cwNBlO8xndq2Kz8BCYbXSrtwCBOPCbWhIICJRACzYEUDqXh9jBbT9abZ6+Hma99HWgAvf/t+R8s0DaXsvJJuk0WlHps+7DU6gRTAO+B21JKEXlbP00kmSRknJboQs4yTktlSvFQEAdyore4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(110136005)(966005)(6486002)(186003)(86362001)(31686004)(5660300002)(6506007)(8676002)(2616005)(52116002)(8936002)(6512007)(31696002)(4326008)(54906003)(36756003)(316002)(66476007)(38100700002)(66556008)(83380400001)(66946007)(508600001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmhPcm1OYWNLWFp6YzlvNFJyYTdTd1FVbVBuOUlTT3ZtWnpjTnBMdnVrcEpX?=
 =?utf-8?B?ekdOQ05UVWxLVkdFOHJrSnhSdWdDWnlaUjBNYW9XR2hITjFnZi9PdHpBMG1P?=
 =?utf-8?B?K1R6ME9JeEpIdjlzenFFYmVaNUFOT01ZdVZrME4rVzJjMTFjVHBHV2tUbEwx?=
 =?utf-8?B?NFgrb1JPSmpwUC8vUmhJVWhFa2cwUVk0Zzcrb1hmQVJFZThxc2FYVUJDdzZi?=
 =?utf-8?B?eG1hT3U5ZWtScFMrQ1NzbnA2eXMxdUxvc0JtRkt3amZYbGNXUjZEczQ5SHVP?=
 =?utf-8?B?SEJwQXNPQ1RFZDI3bGdmOXp1U2FUSjJuc3J4dHN5ZDJDVVJXMHdXNmY1RjdY?=
 =?utf-8?B?c3FCSG1BdGtvdFNoemM1V2x6ODRrUmFBL1NKVllZS1RySDJiYVN4TDllbDV1?=
 =?utf-8?B?Wm5DeFBsT3FXODRuNnlLazJjUmtTYkdVQ0tYS2k1WjRiVHZVK1AzcVdJYzZT?=
 =?utf-8?B?Ukc5cCtRekxqKzBnRFFnMy9mbFVxYlZUb1RqNDloN3M5WFhyb3p0WXVZMG5v?=
 =?utf-8?B?NzRubjhUa3FMajhYL2JCaTErbmVDMHBRS2E2RVMrNm52NW1Kc2ZrY3pycFph?=
 =?utf-8?B?VVBKL2F4QUV1SmErVjAzWDZOMFRpY3JPcHVXQ0ZmYmVUaXBxVjI2TUJJV3BI?=
 =?utf-8?B?enpFMld1eklKd1NLQXJSaG83NmlaNk40dC8xbVFwdENMYzduUFZYOFJHVFFQ?=
 =?utf-8?B?ZjlSREl5TFBLWmhQWGM3aWdmODJaVDBaNjA3YjNtVDRzRVBEa2hwaXRZN2RX?=
 =?utf-8?B?NlRGQWNGc2ZQd0ZBUG9LZDlnT3FxTWVFZFBPSEtFVWFwV0ZuVFJ5OW5NeHpi?=
 =?utf-8?B?b0lRWDdxOEk1SEJ2ZE5ISVF5VlEraWJCaFZtRTAxejF6L3hOOENrcG9ObEVw?=
 =?utf-8?B?am8wVmZ5eExCSUVuZTh0aFNaS05BcC9mMHlmdUpCV1lSb3A0ZzkzMTMwOVVx?=
 =?utf-8?B?UzhMRERVdEpkN1lmR0xDWkpnNWhvb0lsdk83OWo0S0RKVFJJbDdDSW90QklT?=
 =?utf-8?B?SWhLM2lKOFQza1B1VFNrdUc5c0dSbmdVVUxQRVc4TGN0aVdmU2piSWxRQnhs?=
 =?utf-8?B?eEFreGZ1YjJyZ0V5R2x6SlNQdVpYRms4dkYxRGFJZ1crZXZxYThPalB0QUM0?=
 =?utf-8?B?bHpPWVMvbW44RnBndFIzNmdCb09tZHp0TlUrWVR6WHp5cTJ1NHZVRkRzb1Nv?=
 =?utf-8?B?RERnYkhEVFVpS3JhV0FjbTgwT0szWE1ObVpwVlgrc2U5aE0xVVYwY3JQQ2pZ?=
 =?utf-8?B?bWFjLysrK2VqeUU3VC84MlNFNUF1TktzS2RaVjIxSlRsU2xLbkxmaUJqZ0Zt?=
 =?utf-8?B?bEZ2S3hSQTEzWm40ZllyaHdGUk5rTmQ4MUlqNHIwTHZScHJ3OTBSTS9Pa2ZD?=
 =?utf-8?B?NWhOK0RpRnlOSVpIek9ZWDVQMWN2NWI2VWd5TzhrQXAwZzNoMnJsaFVxRm01?=
 =?utf-8?B?MmJaNXJIcGFuT1dCZWN3cjFuU0hoZEJGcTY1SFVLWmRWaWxRVzFxQmhRLzBK?=
 =?utf-8?B?OTNGY3FhaGRSRDlrMWl6WDVIcUd5aUpVM2oxTmJ1bEI0MU8vYXRId0ZHakY0?=
 =?utf-8?B?WXFqZmJQZmoraGpLNnEvdnAwcnp3Uzk5dVBIeElTTkdjWE9ldlRqUTYwZjQr?=
 =?utf-8?B?cGdwaVVqZ3AvTStWbE02L2dpSExWbHQyZlhBZlRRY3dWaWpXNDZTQmUya204?=
 =?utf-8?B?eTR6dCs5SmE3SVNVaFZBdkRwdVgrNk9xSUFNVnNlVzNFOFJXeTRtWnZ0VmNl?=
 =?utf-8?B?d3VPR1NZOEJhT1hNay9UOEZFelFoTXpRd3VydTV3TjB4NnhwNlR6NkdTQU5N?=
 =?utf-8?B?YlFNc3ZLeHhXUFJQZ3pDL0JXb0RpeVQ2dmlXU09DWjF4a0xvVkVmeXU1VjVR?=
 =?utf-8?B?LzJ3QnZuSjJIZEpNZ05mR1NWM1hrUnZob1U1dmYxcFdjdVZJdkVEUUo4TDcr?=
 =?utf-8?B?SDNHdnJpL0pHYTJUTG9WOXlSKzR5MkZUMVg3Z0dBa0pxa1dtdkZtN2JwYSs4?=
 =?utf-8?B?Yjg2VUxtc0FzSzhBblM5MlFFTW1JOVVuR1RJS0FKY3VTM3c3M2JhWWpZK0Mr?=
 =?utf-8?B?bUN1WXA3TVlJYzBoaGhVSUNZMTIwWUcranRwT1JSeVpGUisrT1FGVUxtK0dj?=
 =?utf-8?Q?OEXSp7uQeujHBupvLp3RGeM6E?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 299c9928-0a2c-4c2e-a551-08d9bf2b4ec6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 17:58:17.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFzT0nvKkMeEapcB7vVcCvVZSZ4/qsRCutZxuEQoyTHmOXigrM0qE8WDHoDUxVRa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1280
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: BjkiYUB0ptrTMwI7xlehZUZ36JMCUOvb
X-Proofpoint-ORIG-GUID: BjkiYUB0ptrTMwI7xlehZUZ36JMCUOvb
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_07,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1011 spamscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/14/21 9:51 AM, Andrii Nakryiko wrote:
> On Tue, Dec 14, 2021 at 7:09 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 12/14/21 1:48 AM, Andrii Nakryiko wrote:
>>> The need to increase RLIMIT_MEMLOCK to do anything useful with BPF is
>>> one of the first extremely frustrating gotchas that all new BPF users go
>>> through and in some cases have to learn it a very hard way.
>>>
>>> Luckily, starting with upstream Linux kernel version 5.11, BPF subsystem
>>> dropped the dependency on memlock and uses memcg-based memory accounting
>>> instead. Unfortunately, detecting memcg-based BPF memory accounting is
>>> far from trivial (as can be evidenced by this patch), so in practice
>>> most BPF applications still do unconditional RLIMIT_MEMLOCK increase.
>>>
>>> As we move towards libbpf 1.0, it would be good to allow users to forget
>>> about RLIMIT_MEMLOCK vs memcg and let libbpf do the sensible adjustment
>>> automatically. This patch paves the way forward in this matter. Libbpf
>>> will do feature detection of memcg-based accounting, and if detected,
>>> will do nothing. But if the kernel is too old, just like BCC, libbpf
>>> will automatically increase RLIMIT_MEMLOCK on behalf of user
>>> application ([0]).
>>>
>>> As this is technically a breaking change, during the transition period
>>> applications have to opt into libbpf 1.0 mode by setting
>>> LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK bit when calling
>>> libbpf_set_strict_mode().
>>>
>>> Libbpf allows to control the exact amount of set RLIMIT_MEMLOCK limit
>>> with libbpf_set_memlock_rlim_max() API. Passing 0 will make libbpf do
>>> nothing with RLIMIT_MEMLOCK. libbpf_set_memlock_rlim_max() has to be
>>> called before the first bpf_prog_load(), bpf_btf_load(), or
>>> bpf_object__load() call, otherwise it has no effect and will return
>>> -EBUSY.
>>>
>>>     [0] Closes: https://github.com/libbpf/libbpf/issues/369
>>>
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>> [...]
>>>
>>> +/* Probe whether kernel switched from memlock-based (RLIMIT_MEMLOCK) to
>>> + * memcg-based memory accounting for BPF maps and progs. This was done in [0].
>>> + * We use the difference in reporting memlock value in BPF map's fdinfo before
>>> + * and after [0] to detect whether memcg accounting is done for BPF subsystem
>>> + * or not.
>>> + *
>>> + * Before the change, memlock value for ARRAY map would be calculated as:
>>> + *
>>> + *   memlock = sizeof(struct bpf_array) + round_up(value_size, 8) * max_entries;
>>> + *   memlock = round_up(memlock, PAGE_SIZE);
>>> + *
>>> + *
>>> + * After, memlock is approximated as:
>>> + *
>>> + *   memlock = round_up(key_size + value_size, 8) * max_entries;
>>> + *   memlock = round_up(memlock, PAGE_SIZE);
>>> + *
>>> + * In this check we use the fact that sizeof(struct bpf_array) is about 300
>>> + * bytes, so if we use value_size = (PAGE_SIZE - 100), before memcg
>>> + * approximation memlock would be rounded up to 2 * PAGE_SIZE, while with
>>> + * memcg approximation it will stay at single PAGE_SIZE (key_size is 4 for
>>> + * array and doesn't make much difference given 100 byte decrement we use for
>>> + * value_size).
>>> + *
>>> + *   [0] https://lore.kernel.org/bpf/20201201215900.3569844-1-guro@fb.com/
>>> + */
>>> +int probe_memcg_account(void)
>>> +{
>>> +     const size_t map_create_attr_sz = offsetofend(union bpf_attr, map_extra);
>>> +     long page_sz = sysconf(_SC_PAGESIZE), memlock_sz;
>>> +     char buf[128];
>>> +     union bpf_attr attr;
>>> +     int map_fd;
>>> +     FILE *f;
>>> +
>>> +     memset(&attr, 0, map_create_attr_sz);
>>> +     attr.map_type = BPF_MAP_TYPE_ARRAY;
>>> +     attr.key_size = 4;
>>> +     attr.value_size = page_sz - 100;
>>> +     attr.max_entries = 1;
>>> +     map_fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, map_create_attr_sz);
>>> +     if (map_fd < 0)
>>> +             return -errno;
>>> +
>>> +     sprintf(buf, "/proc/self/fdinfo/%d", map_fd);
>>> +     f = fopen(buf, "r");
>>> +     while (f && !feof(f) && fgets(buf, sizeof(buf), f)) {
>>> +             if (fscanf(f, "memlock: %ld\n", &memlock_sz) == 1) {
>>> +                     fclose(f);
>>> +                     close(map_fd);
>>> +                     return memlock_sz == page_sz ? 1 : 0;
>>> +             }
>>> +     }
>>> +
>>> +     /* proc FS is disabled or we failed to parse fdinfo properly, assume
>>> +      * we need setrlimit
>>> +      */
>>> +     if (f)
>>> +             fclose(f);
>>> +     close(map_fd);
>>> +     return 0;
>>> +}
>>
>> One other option which might be slightly more robust perhaps could be to probe
>> for a BPF helper that has been added along with 5.11 kernel. As Toke noted earlier
>> it might not work with ooo backports, but if its good with RHEL in this specific
>> case, we should be covered for 99% of cases. Potentially, we could then still try
>> to fallback to the above probing logic?
> 
> Ok, I was originally thinking of probe bpf_sock_from_file() (which was
> added after memcg change), but it's PITA. But I see that slightly
> before that (but in the same 5.11 release) bpf_ktime_get_coarse_ns()

Note that it had fixes after that, so in the kernel version where
it appeared it may be detected slightly differently than in
the newer kernels (depending on how far fixes were backported).
imo I would stick with this array+fdinfo approach.
