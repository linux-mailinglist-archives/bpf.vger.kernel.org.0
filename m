Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4AE42B230
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 03:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbhJMBUY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 21:20:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56602 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236986AbhJMBUL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Oct 2021 21:20:11 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D0fvYq022266;
        Tue, 12 Oct 2021 18:18:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=v9r+FAW61n8S6xpOhYYrK4rGasxfIGmRrOVb0qpvoLs=;
 b=ooKrsabU1Yttha6zlzBhfM+ZI9GknyTz4fEmrNeVn6eI7DECE3jzngDdW/StWMJHtszQ
 5+y6GDG7eosYc/C5eAHkO+b3auNzLPjjK9Ekz0cam/1EU3W6XIrlG5YLuXqKC+QXePDw
 iWssBHrywLqSyqUXb4FIyQ9EFeLOb0ux3XU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bnktmrkdu-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Oct 2021 18:18:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 12 Oct 2021 18:18:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKD+oMCtvmNraAjoykd5MktSUV+SmaaT32DgEVu4plAWF3jh+ep9I/D3zVTMoAWuOEjS5OkYtGSvyRFID1Cgjl+o/QOuTYRdc08NrCy/712hYI8uOeFe2DcflffBXPmuzL9DsajgC2oeEXX3Yj5XHAFKqhGalJFp+AZD50w/FdgwBbsU1dqN5sBYxOLtR2KfXyhMP7uvFbmxRNS++EA+anhwVUyJ06SI7di/2ras9yeJBUn5mLIG0s1F0r2tAeFrMQxe4YRHr4Y+MC56yPaLwcufxAK+8w7yw5w2g03PyjiD94B3VFiPcjgN1tlS8CjMtZEho0ONBW7c8ktT+dJG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9r+FAW61n8S6xpOhYYrK4rGasxfIGmRrOVb0qpvoLs=;
 b=j5LJQjJU1NgkIn+Gsvf5YHk04lFVuPco3AsV+HhJAkv3wpQr38duOZf2n6XNOe3P1P8wy3Ye6yu35ivppDiMPcQioN6NWO5ZeOxNSdsf1wglemTunDC8Doeu9xsbAgioayIa+zL67CsbQ2/JXyDBqTpP8QSFQTRPRVinbm7VmpgWIUFbNBdAxCi0t/ZJOcdqJa9YfO+ma5Xwqi8V2e3L3vSMY2Ewjj5BR+HZJFCQefqAmyAItr0PMmFkMdbQJHTX4IT3dPUmod9Q32mWpjn5aiwFZSZf4CU9i2QfcDfwI4DHB5nQZvrJ4olLsyayPElokpfTRnudaOKKpnaL/zbVFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: riotgames.com; dkim=none (message not signed)
 header.d=none;riotgames.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SN6PR15MB2463.namprd15.prod.outlook.com (2603:10b6:805:18::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Wed, 13 Oct
 2021 01:17:59 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::2413:3993:2f20:c304]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::2413:3993:2f20:c304%6]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 01:17:59 +0000
Message-ID: <4f09d330-b694-e2c6-8ec9-388c088d1c34@fb.com>
Date:   Tue, 12 Oct 2021 18:17:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bitset map with bloom filter
 capabilities
Content-Language: en-US
To:     Zvi Effron <zeffron@riotgames.com>
CC:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
References: <20211006222103.3631981-1-joannekoong@fb.com>
 <20211006222103.3631981-2-joannekoong@fb.com> <87k0ioncgz.fsf@toke.dk>
 <4536decc-5366-dc07-4923-32f2db948d85@fb.com> <87o87zji2a.fsf@toke.dk>
 <CAEf4BzbqQRzTgPmK3EM0wWw5XrgnenqhhBJdudFjwxLrfPJF8g@mail.gmail.com>
 <87czoejqcv.fsf@toke.dk>
 <CAEf4BzbWVCz6RNKHVgqLYx8UqGUdDqL5EPKyuQ5YTXZMxt2r_Q@mail.gmail.com>
 <877deiif3q.fsf@toke.dk> <38d80c55-97e1-4cbb-cb23-d6331d8f539b@fb.com>
 <CAC1LvL3DxGWtk1vx3o=1XOj=M0m+KF3yT9z=gONWFXgnc_voiA@mail.gmail.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <CAC1LvL3DxGWtk1vx3o=1XOj=M0m+KF3yT9z=gONWFXgnc_voiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0303.namprd04.prod.outlook.com
 (2603:10b6:303:82::8) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e1::1a1e] (2620:10d:c090:400::5:7eb) by MW4PR04CA0303.namprd04.prod.outlook.com (2603:10b6:303:82::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend Transport; Wed, 13 Oct 2021 01:17:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33a883a0-ade6-4b00-7d6d-08d98de74baa
X-MS-TrafficTypeDiagnostic: SN6PR15MB2463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2463EB376CD23D683167AF4BD2B79@SN6PR15MB2463.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nv8Xkr+5ofXFkYpM4SSg1FHch/939FLqx1F4KshIS25IzYfCBM7PqZ8X38QKVkTgn+wgcBqWXI9zqyLmpu6F9OUYOdsEIgmLjemBRiWaUzSc30eW7pOII0v6sB7nOOSqaXUsfxbHqmC3ZsE1DhxZNUKQowJaHsXuCdrY6asta2hY7GSXXcUy/xjG0xwhQhgp4DiKesPp5s7U0RaBYbHX0YUNBMCZmIP0dVnTp7ygRat3yEOKXf1zgpzEnaCQ9aXM7c6nVXxIyZkJFoi/aQsi0WDB6gQesB+9BrdnMfLYaA9fsZX8sHMoldZNGJ/r+irk4HpzaBfQaXxM6/unGUMhokP24tUbfPY5CVXWhnR50dm2TuJP+k3JxdNHdh7o6CiXRss/zZdmmzkO7Vb+BpYDoarh2G+MksTGAM1HZiLoq9GrZiYBuMj97GBRdOBsX+0ULlRQQBOQyXUY+4id8awGqPiU4iozHi5eOfjZHzGVJl86yXQRdhiRFYzkZSqtHo3vm6CMaIqflrlm2KQzvgo17+o9hvZ+Kc2edafau7svfWfBm/Bg4l94jCW453RVnL4Z83vVZ3t8coNswO2LIqwGhRBDDPBTJauKR1Y5Gp1YcwZm5XSIrMI8CsyLtQBgKM4ZERg1dAWGZM5YjQ2uX/gx/YTo3lM6A3uTFVXBVKYPgVmoxLqjP/9Qj3FqkMQ6Zq1brVOv2bEyzIUslmYBY00nAUDMO4hCrz5s24N2tN1ShAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(8676002)(66946007)(5660300002)(6486002)(508600001)(54906003)(66574015)(316002)(38100700002)(4326008)(6916009)(2906002)(186003)(31696002)(8936002)(53546011)(66556008)(36756003)(66476007)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXdJZGpiQ3FLTHpwNUNVMms5RGZDWUVYMHoyV0dHN2VIcVZUa0daWEY5Zk5I?=
 =?utf-8?B?OWk1Q2FxY2huOXZBUmVrRnJNYmM4Q0VBZkxnKzZ6elQ0c2VodEdRZ2k4MXFx?=
 =?utf-8?B?VGk3enBxeE00U2ZoR0lRQTRFTE44SUVSWCsrN1k4bGQxVDJIWWtGVXgvdlky?=
 =?utf-8?B?UWJZTDN3TE1YeW9JTXFNa0pLaytrTVRWZWNmNkVoUlRGSDlXSDBnbzBjdzZJ?=
 =?utf-8?B?N01LMkk3VEpJRndrSkwwY1AxZVIrV25pV25ZZXUxMHgzdldhUnFzN1dTUXpw?=
 =?utf-8?B?VmVlcVNwZ2Z0ejMzYWVxdi96UlQ1cVB1VURYWFh1R3dYOVh3eFhNMGRXNTZv?=
 =?utf-8?B?d1cwU25mSm13ak1LNUtGeGhxYTd3K1V5cDN0U3pvYUVoL2JkZ2podDNxM20r?=
 =?utf-8?B?WjNEbEp2NFp5NXNQQTVmZnY1M1NZUFRDVFBsYnAvSC9WRHFicWdxRjJmZHRm?=
 =?utf-8?B?aWNqSVF6NStzaitpUU1nZjcxWG9tajI0QUtYMktvSG9MeWlIeHZUTFpZRVJS?=
 =?utf-8?B?SlNpODZaQm9saEZ0TG1oVjRlMXMwWklFKzFnUStXS2VXN0FHVSswbEVvUFJH?=
 =?utf-8?B?OUNURGF4TDNuMUpVZFBTc3RnMFhkRlR0MFZ4UTc1bzNZaEZ5dUxVWUt1cWFu?=
 =?utf-8?B?RjJZWXZqWTBKR2ZGc2Zrc3hHdU9qaFBES2djeS9ORjU2R0NxTCtLUVhEOFQ0?=
 =?utf-8?B?OHJrUXZIaktrbGhxMytFcElzci9YZUxaSjhDazBsS1JrWi9wQllpNTdnd2RQ?=
 =?utf-8?B?WkZ4QnhUYWl6SkJyRnk4WUFOL3JJdGJxeUdEUDQ2cExxcUNDc2YreXFtN29l?=
 =?utf-8?B?My9QUVZGWnc2SFlEaWM3Z3RYZThKQjBIMG9vQnY5VjJMcHFFbHVRT1oxZWFD?=
 =?utf-8?B?TUR5VXdTMmwrWEkrMzF6YTlvVEdMZUNrbDIxNnpIUEl0cXlva09nbWIzK1hn?=
 =?utf-8?B?R0gzakhiNDVEblZqcmhuQUNBb3Riamd3c2xSU1VFZ2lGM0V6UUI3cFp5VCtQ?=
 =?utf-8?B?dEpxRmxtMDJzTFpBVnpwRnVCUmtCR0NjaFBOdGNpTGViK1Q5TWxHamRIc0VL?=
 =?utf-8?B?SlUwTGJwVmk5bEZwakVvL09ucjRYSVlUSlJmRG1NWEZYUmxza1lvS1k1bDd1?=
 =?utf-8?B?Mld5TXRKM3cyclIzODhYUmxRVjBpUytpc1RjQWdzWGQ3dnpEUlRxVUQ4ZjI0?=
 =?utf-8?B?cDdpc2lIZHdUdzVVVmNHZlhRRUpnWlVzNG8xRVArTGg3NGNrT1NqMkdpYm1s?=
 =?utf-8?B?dHNvRnBKa1ozbDg3dDFmb3hOcXVsQzZqazJlcTQvVkV1dFB5V0ZOQ0ZySUlu?=
 =?utf-8?B?bE5acCthdXlNQTZpa3dhUGJ1Z2x2eUJWY3BYSkJtTllVK0p3N3ZUNk9IWG1O?=
 =?utf-8?B?MFRiNHdGM1A5ZEh4Tk40RlV6aXpZejAxaGk1RmxsUVA2d1pwNjdwQTViOFFi?=
 =?utf-8?B?dHBGVVZISTI1cHVnSlNPK2F2TUpKYUl5WTJGRlRqL2Z4YkNwY1V6cllvZ2Vx?=
 =?utf-8?B?T3dxZjlja2ZIT25nMmt4d0FGN29obWRlNVBDYXNsV1JQQUtwTlU1NEFsWWtt?=
 =?utf-8?B?N3lxY1paWTZkMjhMT2hWVjBqTFRyampnTWQzVGgySFlCdWgwWVFmazNmVGcw?=
 =?utf-8?B?R2pNWnN2UFZJamM0R2Q4ZXZyUnByTThjdnVyN1pTOXVnUXJLbXlkMTJhRCtr?=
 =?utf-8?B?S2Z0NUtLNkNnZXNFeDN4R1F1RjV3ckNGS1pGWDJSSTB3b2Y3M1NVdmczcDhz?=
 =?utf-8?B?SFd6S3ovUlZsR2cxZ2hYTmg1dmRRSXo1bzRlK1BBYXIxanBKalNVYTM0a2tH?=
 =?utf-8?B?dlZIaG9YTTRYRkNLd3Z5Zz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a883a0-ade6-4b00-7d6d-08d98de74baa
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 01:17:59.7236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y62oVLSdzpE4Q0R5xV4fJb4dGDuWEbO1sAo3dMhTonrv0+ac98T4J8xudBdTSNIsC2nftlpXnF2aBXsDNM28XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2463
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: w5wXdz7OIpmd2g-E6_DcPQfPlT-MC6ns
X-Proofpoint-GUID: w5wXdz7OIpmd2g-E6_DcPQfPlT-MC6ns
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_07,2021-10-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=767 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/12/21 4:25 PM, Zvi Effron wrote:

> On Tue, Oct 12, 2021 at 3:47 PM Joanne Koong <joannekoong@fb.com> wrote:
>> On 10/12/21 5:48 AM, Toke Høiland-Jørgensen wrote:
>>
>>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>>
>>>>> The 'find first set' operation is a single instruction on common
>>>>> architectures, so it's an efficient way of finding the first non-empty
>>>>> bucket if you index them in a bitmap; sch_qfq uses this, for instance.
>>>> There is also extremely useful popcnt() instruction, would be great to
>>>> have that as well. There is also fls() (find largest set bit), it is
>>>> used extensively throughout the kernel. If we'd like to take this ad
>>>> absurdum, there are a lot of useful operations defined in
>>>> include/linux/bitops.h and include/linux/bitmap.h, I'm pretty sure one
>>>> can come up with a use case for every one of those.
>>>>
>>>> The question is whether we should bloat the kernel with such
>>>> helpers/operations?
>>> I agree, all of those are interesting bitwise operations that would be
>>> useful to expose to BPF. But if we're not going to "bloat the kernel"
>>> with them, what should we do? Introduce new BPF instructions?
>>>
>>>> I'd love to hear specific arguments in favor of dedicated BITSET,
>>>> though.
>>> Mainly the above; given the right instructions, I totally buy your
>>> assertion that one can build a bitmap using regular BPF arrays...
>>>
>>> -Toke
>> I have the same opinion as Toke here - the most compelling reason I
>> see for the bitset map to be supported by the kernel is so we can
>> support a wider set of bit operations that wouldn't be available
>> strictly through bpf.
>>
> Do we need a new map type to support those extra bit operations?
> If we're not implementing them as helpers (or instructions), then I don't see
> how the new map type helps bring those operations to eBPF.
>
> If we are implementing them as helpers, do we need a new map type to do that?
> Can't we make helpers that operate on data instead of a map?
I'm presuming the bitset data would reside in the ARRAY map (to cover
map-in-map use cases, and to bypass verifier out-of-bounds issues
that would (or might, not 100% sure) arise from indexing into a global 
array).
I think the cleanest way then to support a large amount of special case
bit operations would be to have one bpf helper function which takes in a
map and a "flags" where "flags" indicates which type of special-case bit
operation to do. We could, if we wanted to, use the ARRAY map for this,
but to me it seems cleaner and safer to have the map be a separate BITSET
map where we can make guarantees about the map (eg bitset size can be
enforced to reject out of bounds indices)

If the bitset data could reside in a global array in the bpf program, then I
agree - it seems like we could just make a helper function that takes in
an ARG_PTR_TO_MEM where we pass the data in as a ptr, instead of needing
a map.
> A map feels like a pretty heavy-weight way to expose these operations to me. It
> requires user-space to create the map just so eBPF programs can use the
> operations. This feels, to me, like it mixes the "persistent storage"
> capability of maps with the bit operations goal being discussed. Making helpers
> that operate on data would allow persistent storage in a map if that's where
> the data lives, but also using the operations on non-persistent data if
> desired.
>
> --Zvi
>
>> I'm also open to adding the bloom filter map and then in the
>> future, if/when there is a need for the bitset map, adding that as a
>> separate map. In that case, we could have the bitset map take in
>> both key and value where key = the bitset index and value = 0 or 1.
