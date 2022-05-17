Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B56A52A905
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 19:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiEQRLz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 13:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351417AbiEQRLd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 13:11:33 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7007186C9
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 10:11:29 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24HH8dBT016356;
        Tue, 17 May 2022 10:11:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Tc0LoAM10pGGE9IogXKE2wQd8xDCfWU5x0aZYryb810=;
 b=aDHOFc2pigKDdLmlTRVY74EAXdv5NFIEWqeP/9/JHCyQPAGJG58OFvn8BuLIO+W8kEhZ
 kythjbe/m4T1KIty50Z1iFWQb+UV+flJiUw9MvqqJvD5LCf/1AkIiYgrtUfOsLR+2JZV
 m7BNU5Bd2Hbux2fwtrbkAqF3mubLxjNk2mQ= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by m0001303.ppops.net (PPS) with ESMTPS id 3g283wk3ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 10:11:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8CvEirFLDEhk8XpbVVhT4uaPxBXodAmdrf3QQPBGaizBFkrFv190EI7sIiI+iixiWTF3BJZ5trWqQX7tINRu7FYmvjXCJjzEmk/h25HN73wMum5WZzozZrHhMQQfgg4/QXs1jMfS9Xuqk3ktBeCXMZA5o/Yny0d+dbxeGmPWbqb/p6Sy8AMwSkyCGBL2WoY+75pR8eKCdydv30kW2ig2aOqBS848k28uh/y2l2pHvtVx4qtlihfmvSBUtdzefOg5foHnzkdyPzivgDupYQkrNu9Qsf75sPRDqzLZmsXFAYKQR4VRa8sP1wqa4CWluY8CPCXF0yFpZdBmhgdjEnJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tc0LoAM10pGGE9IogXKE2wQd8xDCfWU5x0aZYryb810=;
 b=kJTQEXVI7YojnuVHHrGRnx0x1o0ks1tlJV1hVJInvSa3Cwye8lQAltIEJhho+03Z4/OkVb+4bC7ZPyfHrcBMMkk6eKIOxtIoIc5EIWvlD8HI5HtoogipkUz6XurT/k6gAV5BZbtIIP3W7WvQ4kzLStL9rOKZqxyUDEHKdiPP+S218rVZ8DP/iKvoWb2/5WVr88PWCb8EM0F+H7A97vp7vy/CAZ09Huo2mp2b8FaO/1qD8XJltcxjuWKgQPmRAEnRv5lXiiTF4qFaxw4RXzZXUEPnSLENncN4tNpRHzouBTti2zPL0GvJtW5j9i4pqlCSWhMwS8Lj1P/oYzB5R7vxSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MWHPR15MB1760.namprd15.prod.outlook.com (2603:10b6:301:53::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 17:11:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5273.013; Tue, 17 May 2022
 17:11:13 +0000
Message-ID: <804bf498-a272-86ac-7a24-e4662e8288a1@fb.com>
Date:   Tue, 17 May 2022 10:11:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v2 06/18] libbpf: Add enum64 deduplication
 support
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220514031221.3240268-1-yhs@fb.com>
 <20220514031253.3242578-1-yhs@fb.com>
 <CAEf4BzYqC8BhUHk=SW-=dLyF=4ZPqYXoo2eBTLcqd1VXjK0xUg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzYqC8BhUHk=SW-=dLyF=4ZPqYXoo2eBTLcqd1VXjK0xUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05fb61a0-41c8-467c-8496-08da38283ebb
X-MS-TrafficTypeDiagnostic: MWHPR15MB1760:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB1760509C2F08AB9CE61D8DF2D3CE9@MWHPR15MB1760.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZBy6UmVXyaI9U6isKhDPwzgKIlaiUNfiiteG0Ogd+7Ma/KZjV9/vjo3r9MDKYyjZIXk5yH0DW35ydKUs8JcNSaaITQH45y7TwOBqVoSv0+rmiDUtjyXEwTIP0w0e3zV1jJIlodXK/tKkkVmh8SUHVJ5O4xlXide8nF7FIH07XF8RJOnxyzYt5URFAHyh8t4f7k620dA2ZY7xwJMbjnsSC5YT8L0/OP20iEQc+WIh18vEhUBqpFKgk19qpoV3W3wymmJB3Y1XH5RKtdGnATaXqmWjFMIcQnon8dq77vm7LMRMJx1Azdga674VGyNASNpYbHR1aGCe9T054QDgu5tJibxsoRlP975h1ysBXJxaAssw8FOHGM7EJYyfRS76QguNHixiYKSY8YqYjLZbPWuJiL479/ETMQ6XZab1xlME+oihcH2AFCPEHvLK0TMSlx1WJa6oDI/gzoDe8iRsQvK2AUItFgr+Tv02gQJAxgPtAXMMriYVRWTMUccojIdLGwAs0H7BRJQ8TdY1p6RJF5YBfSkbMZKuVt3B5IfVtnY8i/NnJkWfQW2fstO99L2b0rY1CuGtgoT0cPAo3qfEkrVmzpRtLibKmzyFsZ1oNlVPbzC2rbFIBLvPUJquEnoBlv6duemHndO1IZQxvLqkvzWybzaVwYGWJAZba22UG6yphTcZUKyp5i305BLI3v3nVGhi6nZyEmSOYlAkYsXgZRit1C+B3b0eYpxZb0QK+w+jog=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(36756003)(6486002)(83380400001)(316002)(2616005)(6512007)(52116002)(6506007)(2906002)(8676002)(508600001)(8936002)(53546011)(31696002)(86362001)(66476007)(66556008)(66946007)(4326008)(186003)(6916009)(54906003)(38100700002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG9WcGI1eGkxZ3pKTWpGUnc1c09YSDN6Z25GSzBxTXdOV2UzT1I4R0tuZU42?=
 =?utf-8?B?amFCd2pkME5CNHFMQ0lKR240ZEtKVnlKdHdDT3NISUJDYUNxcEJ6OHZ2NlBp?=
 =?utf-8?B?RG9JVVEvM3RHZmFLWlZVZGtlc0V2VktHdThPU3EyZWcvbmRDekQ2MU5ZTmFC?=
 =?utf-8?B?ZzBZbWlJMTE1SmltK1NrUzJremhkZzJINzB2cklVcFpFSmd6dGluMHp5eTF5?=
 =?utf-8?B?TFhobWhCRkl0RlBSSDdqcXgxeE9kNHY3SUVHRjdWWVlRc29LSzAvZXNzbW9w?=
 =?utf-8?B?TThSdFhwS3lpcE9QVUNHcDE1U3VseWZNSjM1c251U0UwMFNkOHZ0RUQ1bDRF?=
 =?utf-8?B?ZVVxVUZzM1dQK1N2TzVWZmRKSUJ5T0dnZDBNSzhBTVdwS0ZLcTdHbXAyQk1M?=
 =?utf-8?B?YmNqMFlFS0ZkWXg4OWVYSC80Snc2NVNzYzlMZXlmZ0Fua2oxY2o5Sk1MdUxF?=
 =?utf-8?B?UEJPYklETDdIYUY0SE1VWlkvQ3Q2bzVsTUlOcVFhSWlRREVDdk1ObG1kWlJP?=
 =?utf-8?B?QldzR1QxbjVjRlJydm01dXp1SElkc29OV1gyUEFaeEN6NzlrTjJvNUhBQUZl?=
 =?utf-8?B?UjJKRHE3NE1Pb01IMXBLdjVpODdpYjZweUdHaGVDN0c4SEQ4VDBZZjkyaGNI?=
 =?utf-8?B?dHpieVhXOFlaeXVTUHJ4YnhvWUNNcHFjdWM2Z1lUbVdVdXJ0UDJ3Z1RvSmxK?=
 =?utf-8?B?cXhkYlQ2dG1PQXdqTDFua0hmYUppdHZsOXVxWi9XYmV5TGhZMUVOdmI1QTVC?=
 =?utf-8?B?RElnWWx4UjA5OTVnRzNQTmEyQzY2Z241anEzQVZKUnZ5ZS83REViQ2djZXRa?=
 =?utf-8?B?Zm4wS1oxMUxtRVJERGdNVitqSlpxUkhJUkFrSGZyZzMzYm1IL1M2cHFLZ00z?=
 =?utf-8?B?alo4NVYvbU51bm9kNmNaRk5WeU4vMjFJNmdZcnhRYU9ZeERERGJRZitJOEFr?=
 =?utf-8?B?R2lqNVBZaFh0S3JhQUFrMnNGYms1VlpnMWRWYWpCNVkrQWxrYkhrOUVTbFB2?=
 =?utf-8?B?Yk1FUUJCZlpDMUhQVC9MOStaR1gzUlhHR29Gd0QxREVHc0dvN0E1RGt3SmN3?=
 =?utf-8?B?LzhaaGZWSkF4TmZDYUdkT2NZRnArNFlWR05qOEFFSmRDalN3elBYZ2MxT1Bo?=
 =?utf-8?B?djF4MjZsMUhkR09RRGQ3dHBzaVNKUDN0S0lQUEpubkd5aHdkbUN4cmpBOW85?=
 =?utf-8?B?Qi95SytQUmJ4N25KNkR3T2xKamR5S1hZbm8rNGVnMDB5ZUNYTzN0alh0a01P?=
 =?utf-8?B?Zk5XNnRGb3ZyVVlyZVhNQWhralpaSW9xc1VyNGlpRTFLTFR1dU9LMlliVDJZ?=
 =?utf-8?B?bmJLTTJPNUFDTFhRaENzMFNMZ2hhUzhvbjFtYlpTblhJWTAxM2UzTWNOTmdr?=
 =?utf-8?B?eHhXb3l2NkNrcENnanRyNUU5ZVNhOWVOOWVaT1BFWjdQVjZKTUFxeEpHQWR4?=
 =?utf-8?B?aDYybGhmL3J4dWc5a09saFJCcjVUMUlwZ2VadzFPZ1F6ZjRraHk4RGVQY2Nn?=
 =?utf-8?B?MG14ZG1rZ3ZZUGJYS1dDSHJVcVpsOGVVS3h5MGxPL0NRVDU0dmpwd0xPc3VH?=
 =?utf-8?B?NGg1cmRqQmJnVk1OdXc5Qmc5anZWemQvUmNEUiswcHdMSHd1ZTB6bWN0bDVs?=
 =?utf-8?B?UUc5YW1kMGRTZ2ZqQ1NGbkFlYVJyRkI5aHZ0aHNpYk16UUJXNmQrWk15Yldp?=
 =?utf-8?B?RHkvSzZsZG5ZWGtWYnk1MTV1dDZ4ajRiUDFNZWtkckxhWW1HbjVaeUY2aXNR?=
 =?utf-8?B?NGZHL1plL3NoeHZlc2RoQTV4cmhSbzBla29nTTE1Zk5xUGFZeUhiSkRjSUV3?=
 =?utf-8?B?S3p5V3MzbXV3VFZoWVlDbUJONHNqcVNlVyszMmhjaUxCZURTKzdUREFHRHpQ?=
 =?utf-8?B?d01oZjVtNWRqb2lnb1JSQ1VFMmJPOXhYSlR2anNvVURyLzdSYi96ZlhLcnVF?=
 =?utf-8?B?ZEJyQndGN2doZkROZTdmNTJoNnFZUm1OQjRPd0RZb3lmVmw4K0pNT2tEYmNw?=
 =?utf-8?B?NC9XOWJLRFJhMjY0dUpOUGtpZ0crLzFlbkhxMk1KaTU0ZWRmT0RjS3dzTzBG?=
 =?utf-8?B?YWlOaFFQdXZaa0k5aWpBNlhOVkJFVXluN3pIUmJoZ1FFUU45MDU5bU9iQmhn?=
 =?utf-8?B?Z1ZPMEtZRCtsOWdhYXNnRUhBNHc2ZExIVmRvZmVRSUdFRklMYmlmRjc0ajNo?=
 =?utf-8?B?SFBJOUxiUVp3T1dqc0pmSmFrUThuZU1QQy9UUmk5a3VWMlR4TXRPeTVKaDEz?=
 =?utf-8?B?TlNuRFhKcFB4VlR3cWNxYWRkMDk2REtiaXV4aTF6RE1QOGppd2VuWWR0VXpN?=
 =?utf-8?B?QXBkVGd5VHpQS1dNSExCV0g2UWl6UGpVTzVIczBBUDNuZEVJM25aVUxwd3Y4?=
 =?utf-8?Q?Y4gEITRIp+aQCipc=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fb61a0-41c8-467c-8496-08da38283ebb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 17:11:13.0545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bHwhtgLHdBtH6nG33voHgR61PLPf1ClV0Yomn3UXaHCjPWbfy22y1JIIAzdkO4A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1760
X-Proofpoint-GUID: oGNzHWTDGlp8samG4TuWThRKDupxCC0T
X-Proofpoint-ORIG-GUID: oGNzHWTDGlp8samG4TuWThRKDupxCC0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/16/22 5:28 PM, Andrii Nakryiko wrote:
> On Fri, May 13, 2022 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add enum64 deduplication support. BTF_KIND_ENUM64 handling
>> is very similar to BTF_KIND_ENUM.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/btf.c | 55 +++++++++++++++++++++++++++++++++------------
>>   tools/lib/bpf/btf.h |  5 +++++
>>   2 files changed, 46 insertions(+), 14 deletions(-)
>>
> 
> [...]
> 
>> +static bool btf_equal_enum64_val(struct btf_type *t1, struct btf_type *t2)
>> +{
>> +       const struct btf_enum64 *m1, *m2;
>> +       __u16 vlen = btf_vlen(t1);
>> +       int i;
>> +
>> +       m1 = btf_enum64(t1);
>> +       m2 = btf_enum64(t2);
>> +       for (i = 0; i < vlen; i++) {
>> +               if (m1->name_off != m2->name_off || m1->val_lo32 != m2->val_lo32 ||
>> +                   m1->val_hi32 != m2->val_hi32)
>> +                       return false;
>> +               m1++;
>> +               m2++;
>> +       }
>> +       return true;
>> +}
>> +
>> +/* Check structural equality of two ENUMs. */
>> +static bool btf_equal_enum_or_enum64(struct btf_type *t1, struct btf_type *t2)
> 
> I find this helper quite confusing. It implies it can compare any enum
> or enum64 with each other, but it really allows only enum vs enum and
> enum64 vs enum64 (as it should!). Let's keep
> btf_equal_enum()/btf_compat_enum() completely intact and add
> btf_equal_enum64()/btf_compat_enum64() separately (few lines of
> copy-pasted code is totally fine to keep them separate, IMO). See
> below.

I debate with myself about whether I should use separate functions or
use one function for both enum/enum64. My current approach will have
less code changes. But I can do what you suggested to have separate
functions for enum and enum64. This will apply to btf_compat_enum
as well.

> 
>> +{
>> +       if (!btf_equal_common(t1, t2))
>> +               return false;
>> +
>> +       if (btf_is_enum(t1))
>> +               return btf_equal_enum32_val(t1, t2);
>> +       return btf_equal_enum64_val(t1, t2);
>> +}
>> +
>>   static inline bool btf_is_enum_fwd(struct btf_type *t)
>>   {
>> -       return btf_is_enum(t) && btf_vlen(t) == 0;
>> +       return btf_type_is_any_enum(t) && btf_vlen(t) == 0;
>>   }
>>
[...]
