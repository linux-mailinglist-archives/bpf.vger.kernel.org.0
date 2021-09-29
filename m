Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1054841BC7E
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 03:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242042AbhI2B4j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 21:56:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27360 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229505AbhI2B4j (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Sep 2021 21:56:39 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18SM2C97003629;
        Tue, 28 Sep 2021 18:54:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4tWhSHeDZheVHEsOrnIug08NGpsPobMki1CiwLpw7Ds=;
 b=OlIKbaRDb7U7P9MGeDHB3O7Iqw4ZXiuYxFCSVW3iajh49/NVJV7CZ/1Y6kn5Jlz5+uUZ
 csCSN6rRrGBRh/7czg0MHUoW/rwt8TFhTqEsUxDfqk7faAx6+mcMpCBCZVCOj7dzeOPf
 FpWD2dn0IbrNCl8DfjjretE6RqmgYpeECYA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3bcbfjh5xe-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 28 Sep 2021 18:54:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 28 Sep 2021 18:54:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNf6/2EtcvPqqopvwsDv717uI2Z8hBeg2+K1LrDBGbHwtgQakQvQqw4tsyVNIqh3zH5uBfCscWVo0YQap8QX2SvDexrSFeGDxz8mAvuz2lNX8iJYVFjTtr2jXaT+w/fuU05YwaZ+H94dn29gi5VRkQoRG374RnNGogapIqQU5/vxGirQlaF/a+tOo1qjpJT6mch7ka33caiZC1itQU6hQvZuiPWOvAnGXHvUCapl2hGj8b71HjJbajjRt5xjfYtjG31elUdt8sr/syJZ0DvX94yzWtgoJlBUhSq4XKbdXzu4qjo4vjjCAmbHPP2+O3bhG19kQhnVLXovFFneyccD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4tWhSHeDZheVHEsOrnIug08NGpsPobMki1CiwLpw7Ds=;
 b=hmvS5AW6/w0HRocNa/7rowtxaOaWD4LiG6hg77N3LaMgQEyE4uG6fk2SgvrrLXqFKTydnPJohsEH66VV4f04ttMX7BheOXilou+y4Tpz0+eXtORw2BbobYqeM0AglUJcPLP37CX4fftBauLhDvCq+Do2enX3KelYM3H02PZgUnQNTrwsQ/4USQYCaVcxvGVfdGTlDaRODxeNrFJ1KSPVKMHXBccicxEcdEfKGSz+mcWm3j3ag1q+RJz1alRz5NS1q8Dcy5samPjn6lwUFg2rDa3h7FbF+bXKZm6FoGnRHFRm5uTGXdaHJlVLGvJxybmhsIdngrP0gx3d+5VxtXHJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SN6PR1501MB1997.namprd15.prod.outlook.com (2603:10b6:805:8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 01:54:55 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::1d1a:f4fb:840e:c6fe]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::1d1a:f4fb:840e:c6fe%8]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 01:54:55 +0000
Message-ID: <fc94d56e-8d49-40ca-2614-c91a6181296e@fb.com>
Date:   Tue, 28 Sep 2021 18:54:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
References: <20210923203046.a3fsogdl37mw56kp@ast-mbp>
 <CAEf4BzZJLFxD=v-NvX+MUjrtJHnO9H1C66ymgWFO-ZM39UBonA@mail.gmail.com>
 <7957a053-8b98-1e09-26c8-882df6920e6e@fb.com>
 <CAEf4BzYx22q5HFEqQ6q5Y0LcambUBDb+-YggbwiLDU86QBYvWA@mail.gmail.com>
 <118c7f22-f710-581f-b87e-ee07aced429a@fb.com>
 <CAEf4BzZ1BXyTWmLpfqoGOms02_bwQDgBgEd9LkUM_+uDZJo1Og@mail.gmail.com>
 <20210927164110.gg33uypguty45huk@ast-mbp.dhcp.thefacebook.com>
 <CAEf4Bzb7bASQ3jXJ3JiKBinnb4ct9Y5pAhn-eVsdCY7rRus8Fg@mail.gmail.com>
 <20210927235144.7xp3ngebl67egc6a@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzY=yrSZFJ_dgeS5MSn+pTR+Y9d4am2v+Uby-TBGn4i+Cg@mail.gmail.com>
 <20210928162125.qsidw3zkzsfy4ms2@ast-mbp.dhcp.thefacebook.com>
 <aa967ed2-a958-f995-3a09-bbd6b6e775d4@fb.com>
 <CAEf4BzY08boSQdzC8RKkhoTyMXrSmz=Ugcb3EJwGyfj05stO1A@mail.gmail.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <CAEf4BzY08boSQdzC8RKkhoTyMXrSmz=Ugcb3EJwGyfj05stO1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::34) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21d6::1597] (2620:10d:c090:400::5:9dfb) by BYAPR06CA0021.namprd06.prod.outlook.com (2603:10b6:a03:d4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 01:54:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcc30fd8-be69-4210-d904-08d982ec225f
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1997:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB199724828DE8969A02625CB9D2A99@SN6PR1501MB1997.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DfyVVN3A8tIg0mwyC/s1vSi6YuQLSYotHSqpAoACWyQToncP5Cb5jGR4yG645iHNh5rcjuGJemaf+Lu5zsNd8dDDqHEjl/xgQI8LBysPcyPyK5jGMq+iU+VmPf2XzhIpeo4fpX+Iy0QFAu5x2eOI3az9ZeZPg+6MLRa8XUux1Y3CgkiTapLvEqK8LRCIceSgQ3PDuRA3dAtxm2ewh/NFTH5Y48d2uv9hpneQhCZ/2VAk91yO1qWp/2RKFgizbXlPNF6mU05KSfk3A82p9jvSAMiW6rwiKPRWWgdrMV2U97qy/upfrWI0KWm0evCiPExghmSF8Cjs6gzqmpWAXbv+mYuT7wN39LMH21dePkQt20uoL4/mLSqIydyf1zj1xgir4DUT3YyHVEARr331ICOCN9IK7uCGCTspmVKelsxoy7UZiFBtWTh/1djxNDVR7k3qScKkxIUHz/R2BkSx7ubyir51ZP1/0HqAy3/y/CdazfVbz/UZMRqGzpuw+TR3eqT9mFVvB9OMDY+IEUduBT0yGFkOSjvkJHeOXqWL+KvpT844DDM2aC56fVCVlpxqctaaHGxIEsbN/k3GYDOZf6vA/x1auJYnfoUR13ceJEq5Q4Jy5/y1S8ya3YR+3f2XAA2lUWm6zwSPMEj48YkwMRRyFFDkj5Q3qQ9hCYZnWk9UbaT7fMQZqRjsJm6u4U4BBo/4yQQCRVcyHGe64E6FdjH8t0DUmYH8tnJuA9SW7Rc/npo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(66946007)(4326008)(6486002)(8936002)(6666004)(38100700002)(53546011)(508600001)(186003)(5660300002)(31696002)(66476007)(316002)(66556008)(54906003)(2616005)(83380400001)(6916009)(36756003)(8676002)(86362001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzZSN1ZKYnZoSHhaTlk5QjFHNXhYZ1lia0xqWWJ6RG9JUno4UkNvVm1iakZE?=
 =?utf-8?B?bTFwV0Z4ajU1cmRqSzBCb3A3c0RxMk1iK29ORGl1SVY5MVpFcGJHTG56eUNL?=
 =?utf-8?B?QVZONHFQdmVncUwyTnVYRVhWcW8wSlVuYnZQMVEzeUlnU2hqekM3MXY2cEUy?=
 =?utf-8?B?YnB1U1pQUkIwVFlIUVZBR1I3d0h3R1phYVVxUTdONVh0bStkQUtMTExBbWFa?=
 =?utf-8?B?cXNvREUvamw1T1BKWGdMN0NlbGFWLyt5K2p6TCswNEJtQXhZaS8wdmltZHdU?=
 =?utf-8?B?MExTRlBqbnJUdHo3SEZkeWd4U3V2ajl1SUpxMjkyRW5acU9WTHZsQW00S1Y2?=
 =?utf-8?B?aHI0V2dBenA0TDJ6RXJTc1AwenpYcGFQS1ZENmVxM240K2RrUERZZmxsT0lh?=
 =?utf-8?B?dFkwUHZjSGVvM0s1VFB2S1dCbnpDcVAydjR1Vy8yTXRlTUNoVE5JeWU0UlZy?=
 =?utf-8?B?YjFZcWwwcVUvUGFhYW9PcjJrcG4wUk8xRDA1dDBMejk5TGNrTDdzcHg2dzRI?=
 =?utf-8?B?MVhyVmY1MG9rZ3lpRkJqdmt0L1dnMDhHWWcwOE00NHdhcDhoai80dm5uZ1VO?=
 =?utf-8?B?Lzl0NkhQd1hLTE5RNUo2NVN0YlpweCtRVGtpcDBBM2ZQN0JFQXg4V2dyVldo?=
 =?utf-8?B?M0JqQXFTNFNHM0piUnhab3E3RU5KNlJPTHJvOFJyQldKN3JDWnpOYXFXRmRh?=
 =?utf-8?B?SkNlLzNqNm5yRUNwakpXUHROSWp1QnlZQXdXdVFqSVNHN3RCT1N6aXVsenhi?=
 =?utf-8?B?RFFNRE1TV056OVE5cG5ueVQ5dTVwc3p0Q2pSblJTRGcvQS9QZlI1TWJ0NjFi?=
 =?utf-8?B?TTJpV3BER0xidjNpdWFvLzhOWUF6am8rL3lzVDFwSzdvK2kxSkdDNjcvOGZk?=
 =?utf-8?B?VGcvZGR1b2dUajYzLytNTlZuL1ZZeVJMK1JYYmpzdTJzSWJSaFF0eUtidjJh?=
 =?utf-8?B?OVhZbnM2QzB6MWFpdnJpWWNpMzRVKzNJNUhIZTMvMXp5Y3pReDVnODlGeDhV?=
 =?utf-8?B?RFpHeDRadHR2VmE4UkNLN2xjY0VxU2VqYlF6OGdhNzZ4NFdnRVBPNm4wb3Av?=
 =?utf-8?B?cGlFbkg5VTRxWHZLWkFxNGlWNDdwZ0lvNTFpYjMrQnZOZ3R5ajVNdHRob04w?=
 =?utf-8?B?NlBUa01IUjdWdnlXY2VvMUQzdTlFcm9Bc20xbVI1MWtxaUdzTis0cm5yNjgx?=
 =?utf-8?B?RHVSRWRhRW53WGJjMWRGanF2Q1RIRG1zSFl1R3piOVFFSkdnVnIzSTJTT202?=
 =?utf-8?B?VWoxV1UyNldSUjZtMWNkZmQzc0pnUWovVER0aUxIdzIvUTQwbld4WlhxTjh0?=
 =?utf-8?B?ODVBdERXL1hKTlp1dlc2RjZGRitML0tEZ2pQYkdRY2U2SW5wTktGTDFyMVVL?=
 =?utf-8?B?NTllN1dOSjJSc0F0RENvZWNrZFdnNGxJS29TeE5tVVJWTU9QdVlHZzFaQ1Z2?=
 =?utf-8?B?NVF3aVEyQWIySW55bmg2RTByY0xwUVJ3ZisxaTZzRU1wQXd6NnpqQU1LMWVY?=
 =?utf-8?B?U0UzWkRsU05xWWZncm93U1huQ2I3WElWQjlhZ3RVOTAxajZkOFpSUDU3VHhI?=
 =?utf-8?B?RzY1WVhBTjBWZzBNOTNiTm9lOXBqUGRCd0p5R2FrUTJzaFpZemlqZU90SnRl?=
 =?utf-8?B?MFUrMkRZMEo5RjVwK0pkelRqdXkrdmpsazRzUzkrQjZLbncvcUQ1VlhLZ1hN?=
 =?utf-8?B?dEdTME0xUWJ6R1dreEpKYTY5SVNCb3VieXkyTXltMCs4a0RmRlEva1J0Q3pL?=
 =?utf-8?B?cm5JdWRWMHJObGdLVG1VTmtYZmVCeWdvVms1RVZKcEsvcnA2cGUvSWNsMStn?=
 =?utf-8?B?YVZYdzlmK3d2bHdLT0o2Zz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc30fd8-be69-4210-d904-08d982ec225f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 01:54:55.1440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LtrF+Su9VY22eiANnNwazrjjglwjqEEwb3VzjnMwIiCpqXi6EdX0ACeVqrP2fqa6b88rnqU3RGV969gmyqbdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1997
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 6FdfhVp-1oHKCnBIHv0x0tDAAx4Sk9mH
X-Proofpoint-GUID: 6FdfhVp-1oHKCnBIHv0x0tDAAx4Sk9mH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_11,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290009
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/28/21 4:54 PM, Andrii Nakryiko wrote:

> On Tue, Sep 28, 2021 at 1:56 PM Joanne Koong <joannekoong@fb.com> wrote:
>> On 9/28/21 9:21 AM, Alexei Starovoitov wrote:
>>
>>> On Mon, Sep 27, 2021 at 05:36:00PM -0700, Andrii Nakryiko wrote:
>>>> On Mon, Sep 27, 2021 at 4:51 PM Alexei Starovoitov
>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>> On Mon, Sep 27, 2021 at 02:14:09PM -0700, Andrii Nakryiko wrote:
>>>>>> On Mon, Sep 27, 2021 at 9:41 AM Alexei Starovoitov
>>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>> On Fri, Sep 24, 2021 at 04:12:11PM -0700, Andrii Nakryiko wrote:
>>>>>>>> That's not what I proposed. So let's say somewhere in the kernel we
>>>>>>>> have this variable:
>>>>>>>>
>>>>>>>> static int bpf_bloom_exists = 1;
>>>>>>>>
>>>>>>>> Now, for bpf_map_lookup_elem() helper we pass data as key pointer. If
>>>>>>>> all its hashed bits are set in Bloom filter (it "exists"), we return
>>>>>>>> &bpf_bloom_exists. So it's not a NULL pointer.
>>>>>>> imo that's too much of a hack.
>>>>>> too bad, because this feels pretty natural in BPF code:
>>>>>>
>>>>>> int my_key = 1234;
>>>>>>
>>>>>> if (bpf_map_lookup_elem(&my_bloom_filter, &my_key)) {
>>>>>>       /* handle "maybe exists" */
>>>>>> } else {
>>>>>>       /* handle "definitely doesn't exist" */
>>>>>> }
>> To summarize this, Andrii it seems like you are proposing two possibilities
>> for passing the ptr to the data as the key:
>>
>> 1. Have the value be NULL (value_size = 0)
> Yeah, this was my biggest hope (except value is non-NULL, it's just
> zero-sized so not readable/writable), but that's academic at this
> point, see below.
>
>> 2. Have the value be value_size = 1 byte or value_size = 4 bytes in a
>> worst-case scenario
>>
>>
>> For #1 where the value_size is 0 and we return something like
>> &bpf_bloom_exists
>> for bpf_map_lookup_elem() where the key is found, this would still
>> require us to do
>> the following in the syscall layer elsewhere:
>>
>> a) In the syscall layer in map_lookup_elem, add code that will allow
>> value_sizes of
>> 0. This would require another change in bpf_map_copy_value where we have to
>> also check that if the value_size is 0, then we shouldn't copy the
>> resulting ptr
>> of the bpf_map_lookup_elem call to the value ptr (the value ptr isn't
>> allocated since
>> value_size is 0).
>>
>> b) In map_update_elem, add code that allows the user to pass in a NULL /
>> zero-size
>> value. Currently, there exists only support for passing in a
>> NULL/zero-size key
>> (which was added for stack/queue maps that pass in NULL keys); we'd have
>> to add
>> in the equivalent for NULL/zero-size values. We'd also have to modify
>> the verifier
>> to allow bpf_map_update_elem for NULL values (ARG_PTR_TO_UNINIT_MAP_KEY).
> This "UNINIT_MAP_KEY" part is confusing me because we are talking
> about *NULL value* (so neither uninitialized nor a key), so I must be
> missing something important here. I thought it would be
> ARG_PTR_TO_MAP_VALUE_OR_NULL, but it does suck that other map types
> would then be allowed NULL where they don't expect to get NULL, I
> agree.
You're right, this would just be changed to ARG_PTR_TO_MAP_VALUE_OR_NULL;
I mis-pasted ARG_PTR_TO_UNINIT_MAP_KEY from a previous draft. Sorry if
that caused confusion.
>> For #2, from the user-side for bpf_map_update_elem, this now means
>> the user would have to always pass in some dummy 1-byte or 4-byte value
>> since the value_size is no longer 0. This seems like a hacky API
>>
>> Repurposing peek/push/pop (in the scenario where value_size = 0) would
>> avoid the
>> bpf_map_copy_value change in #1a altogether, which was the primary
>> reason for
>> suggesting it.
>>
>> The approach taken in this patchset (where we have the key as NULL, and
>> the value
>> as the ptr to the data) avoids the need to add that infrastructure
>> outlined above
>> for allowing NULL values, since it just rides on top of the changes that
>> were added to the
>> stack/queue map that allows NULL keys.
> So overall, I agree that all the above will be an unnecessary
> complication for relatively little gain. Just go with peek/pop/push.
>
>>>>> I don't think it fits bitset map.
>>>>> In the bitset the value is zero or one. It always exist.
>>>>> If bloomfilter is not a special map and instead implemented on top of
>>>>> generic bitset with a plain loop in a bpf program then
>>>>> push -> bit_set
>>>>> pop -> bit_clear
>>>>> peek -> bit_test
>>>>> would be a better fit for bitset map.
>>>>>
>>>>> bpf_map_pop_elem() and peek_elem() don't have 'flags' argument.
>>>>> In most cases that would be a blocker,
>>>>> but in this case we can add:
>>>>> .arg3_type      = ARG_ANYTHING
>>>>> and ignore it in case of stack/queue.
>>>>> While bitset could use the flags as an additional seed into the hash.
>>>>> So to do a bloomfilter the bpf prog would do:
>>>>> for (i = 0; i < 5; i++)
>>>>>      if (bpf_map_peek_elem(map, &value, conver_i_to_seed(i)))
>>>> I think I'm getting lost in the whole unified bitset + bloom filter
>>>> design, tbh. In this case, why would you pass the seed to peek()? And
>>>> what is value here? Is that the value (N bytes) or the bit index (4
>>>> bytes?)?
>> In that example where seed is passed to peek(), the context is the
>> hypothetical scenario where  the bloom filter is implemented on top
>> of a generic bitset.
> But then why does *bitset* do the hashing on behalf of the user,
> that's the confusing bit. But I'll reply to Alexei's email in just a
> sec.
>
>>> The full N byte value, of course.
>>> The pure index has the same downsides as hashing helper:
>>> - hard to make kernel and user space produce the same hash in all cases
>>> - inability to dynamically change max_entries in a clean way
>>>
>>>> I assumed that once we have a hashing helper and a bitset
>>>> map, you'd use that and seed to calculate bit index. But now I'm
>>>> confused about what this peek operation is doing. I'm sorry if I'm
>>>> just slow.
>>>>
>>>> Overall, I think I agree with Joanne that a separate dedicated Bloom
>>>> filter map will have simpler and better usability. This bitset + bloom
>>>> filter generalization seems to just create unnecessary confusion. I
>>>> don't feel the need for bitset map even more than I didn't feel the
>>>> need for Bloom filter, given it's even simpler data structure and is
>>>> totally implementable on either global var array or
>>>> BPF_MAP_TYPE_ARRAY, if map-in-map and dynamic sizing in mandatory.
>>> Not really. For two reasons:
>>> - inner array with N 8-byte elements is a slow workaround.
>>> map_lookup is not inlined for inner arrays because max_entries will
>>> be different.
>>> - doing the same hash in user space and the kernel is hard.
>>> For example, iproute2 is using socket(AF_ALG) to compute the same hash
>>> (program tag) as the kernel.
>>> Copy-paste of kernel jhash.h is not possible due to GPL,
>>> but, as you pointed out, it's public domain, so user space would
>>> need to search a public domain, reimplement jhash and then
>>> make sure that it produces the same hash as the kernel.
>>> All these trade offs point out the need for dedicated map type
>>> (either generalized bitset or true bloomfilter) that does the hashing
>>> and can change its size.
>>
>> To ensure we are all aligned on this conversation, here is in more
>> detail what I am intending for the v4 map changes:
>> * A bitset map that also internally functions as a bloom filter if
>> nr_hashes > 0 (where nr_hashes is denoted through the map_extra flags).
>> max_entries will be the requested size of the bitset. Key_size should always
>> be 0.
> ok, makes sense. max_entries is the number of bytes or bits? Not sure
> which is better (bytes is more consistent with other uses and allows
> for bigger bitset/filter, but bits might be more natural for bitset),
> just bringing this up as it's unclear.
>
I think number of bits would be more ergonomic for the user
in the context of the bitset map. Especially since they will be operating
at the granularity of the bit anyways for setting/clearing/checking
a specified bit.
>> * Add the convenience helpers
>> bool bpf_bitset_clear(map, value);
>> bool bpf_bitset_set(map, value);
>> bool bpf_bitset_test(map, value);
>>
> It maps one to one to bpf_map_pop_elem(), bpf_map_push_elem(), and
> bpf_map_peek_elem(), right? The signatures for pop and peek are
> *identical* (map + value), while push has also extra flags (not a big
> deal, we have 0 flags in a lot of helpers). So I don't see much value
> for this (and it actually will be more confusing when bitset is really
> a bloom filter :) ).
Makes sense! I will not add these convenience helpers in v4
>> In the case where nr_hashes == 0 (straight bitset):
>> * For simplicity, value_size for the bitmap should always be a u32. This
>> denotes which index of the bitmap to set/check/clear
> SGTM.
>
>> In the case where nr_hashes > 0 (bloom filter):
>> * The value size can be whatever
>> * Clear/delete is not supported
>>
> Sounds good as well.
