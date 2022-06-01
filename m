Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E8653ACD5
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 20:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiFAScM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 14:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiFAScL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 14:32:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8C12CE30
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 11:32:10 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251BtQw9028674;
        Wed, 1 Jun 2022 11:31:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=kLHrdiPulm5VQFdp1joxzRyh2X17pbNI2l4qyKzWC7s=;
 b=meqTexoANKTEMvumWMStc62z4XOzZ91Khv2CRgnMby75ctfSznHt+elI1KtxUYV+RAx9
 xfM9/nZ6DaG6Sr5qQuuGbrDnnHA5aezoX05fbXQUorMqo5xbQx47q2JgncLruz1GWoFZ
 wxCVA6Cuva80uiAHmtmPxDxGYOsJ0OO8Vnc= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gdt5jpfgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 11:31:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Upn+Bl62a6kNP5fdq+fk7m4fiWGAphk6y8x55QTAnmGzMljQlIPE/JLq2YP6JZJxwFbTo1coTBlaJU4IsBEiGCEPjfD0U8HBCWOSkqP5Nu6c5iJwtbFAHkWjbCDe1eH/TjlggEni/8R2WVv6T1UKKcD0AtnY/DfoEl1Ol2CufhHwKg8dde0s14pEpqzaTjGYHP19XscML0F0n5hsoS2LF3cciuZYQa2XFLYtYfRn9uSpIhnSsEhSM5COZKWwkvnSipcUEbMm2oSJfiKcyPyjVeWHG2AwsgcmKxK6LIvemwG3km7eV40yx0+tyXtEGpAYjDfaCM44n1rxToid7fDBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLHrdiPulm5VQFdp1joxzRyh2X17pbNI2l4qyKzWC7s=;
 b=Mm1OX0wonlcoxbZAKWKQrdlesFdmtDHFrX51BgSQs8LMnS2mQ/5bgZ5gZKJ3Ixl9A/XeOWKAKdXWkzl8s3Fxd8pWwyiSEbQizsMT4cSYl7nN5DCY9KXUHZUbHX7EyzRnkTglvw0g4Xc2ycg1ikoKvO/CTiJRuN7y46Jqh6n+6onEFaDnqKttZpshUA3RYVRRDyAwg6SqmWUnzGxAzHtYowoAQbc2qM6KjVV/H3YoZyJrdyvvLHuJio1XGhyNI683Zoiv5IC6L3uZzutXpmA/18jhafSjyQayg4IHzvgrA1qBzMQkLOemaBjWZv/pmAHG0GfeTJwsaHy7PT+ODD5lMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BLAPR15MB3908.namprd15.prod.outlook.com (2603:10b6:208:279::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 18:31:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2%7]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 18:31:54 +0000
Message-ID: <4ddd80f8-24e1-2f6e-52e2-ed03af7760ed@fb.com>
Date:   Wed, 1 Jun 2022 11:31:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH bpf-next v3 06/18] libbpf: Add enum64 deduplication
 support
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220526185432.2545879-1-yhs@fb.com>
 <20220526185503.2548083-1-yhs@fb.com>
 <CAEf4BzaCiYvsfBLAqFKnciiL5QKKVqZp8enRbZTUUUekygCHUQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzaCiYvsfBLAqFKnciiL5QKKVqZp8enRbZTUUUekygCHUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3c1aae4-528a-4043-c897-08da43fd00d9
X-MS-TrafficTypeDiagnostic: BLAPR15MB3908:EE_
X-Microsoft-Antispam-PRVS: <BLAPR15MB3908F768FC75F7A2FE55CF68D3DF9@BLAPR15MB3908.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LaAKoIv3kJsXb/tbWueVgD2vu99T7V1dJd06oyxdtlA9VscYhNh7aE/GE2vzUUAARWYyfDiDVfLuTaMbANjmY/tDGqPRrp7EzDkuPT68QzWwKBgYlv2hPWDltFk3OCRdVwZiswCRUFuIJUK4VTCw18OEiDOLmJJX1H9gv0vOlg2JlCi3nzHLhhR5JRir/ynsnfY8pPJk88MLUBR3U9Kt1xdULB9Mi5DzGetF5Q8zrJ8eXBrmtuIxWDMVymE50GCoUH/usmYUGL5JX4LouuCekrn7I2aV/eyXyWjCsIRjkg5hBkGY1MpkQmIL1z1br/JD2DTIUILRiHsCYCzWbw3XMNWe0xvHetzkmflVYPEhL8QlX6lU1vJB1t7w2r6XNeCpi0kgNzlO0N8a7BLf2RX3Xw2tltYTdZFK+/QHQLFM0MK4ULvSKu8wTpuYtJEWxB9BlvGtYMQ7ACTJoTlrd1YNBd/1CzmsyXG6m+2Udz/pbiY9c6B/vOEtBvUPk1zO9pbd9gUyzq7eCmccHxMPw67pLWhqgMsSF883mUc4w1nL2KQFBC33pXNTVGN/wpmLir805kq3LM9ddO5EcoRy0if7mJN5UnMo/Ljx7Mv4x4enfloJ+xBjIPpnsDWkuqhf9eaWHvqYc5PEivZlltWZuYs9wwVnjZMlW7lTJgr3zzT/YjUBGPYp3LqE3Ps9tZGpqnlSPvw0tGrsAunFF2cbtcBJ/NMKlUdgTiW7NE5RvSvDAFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(186003)(2906002)(6512007)(8936002)(6486002)(2616005)(52116002)(5660300002)(53546011)(6506007)(316002)(36756003)(31686004)(6916009)(54906003)(4326008)(8676002)(66946007)(66476007)(66556008)(86362001)(83380400001)(38100700002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFpEZHVBeXhGOFU5cThMUGpvckZIclpWME9qcUJpUEwvRmhTbzhQQkVBdVUx?=
 =?utf-8?B?dUhOQmZ3dFpIQkRsTHlFWWtHZm1OSkVWcklHaWh5Y2x2bGVqZ2cyNHRvWU82?=
 =?utf-8?B?N1EvRWFQMEhweTAxZmJuQW9qN1JXdzVYNFEvY0RmMDg5bmlCOUVYRFpPSm9X?=
 =?utf-8?B?VE82dkZSdkVtVlBFaFN6Um5zMzBSTU5RdkZqQlJzUFpBNFNnaXg1ZUlHcVRn?=
 =?utf-8?B?NUtjR2NrVXVCVUlHR2dnL0g2ZjIxeWt2L1k5TWdmUWJpOGltRk11QlVwMEwv?=
 =?utf-8?B?aHlxMitDQTVzdzdncWlVd1k0M3kwd25OWlk4N0JYaWg3NnJZb05wV2QrdlNx?=
 =?utf-8?B?eUJZMmEyRTV6WUlhYys1cmY4cEg4aDdlSkhaeWY3RG5qYlBiYTFFckJYKy8y?=
 =?utf-8?B?c2d1UEZMa0hRVVpVc1phYlV1Q3V4U0t4c2xtRXFlUHgxTGFXL1p1QjQ5THJn?=
 =?utf-8?B?c3Z5SHVkTFdMNEFudXI1a2FYYlZ5U0k1NHNsQVVWb0cxaWhqeFlRZENaa2hx?=
 =?utf-8?B?amFqeGMyUUJIRytCNHV1R0VzTks5cldWbTNmbEUyd2tiZUIwczkxTldoQTdn?=
 =?utf-8?B?cHBRY2svVE16L245c3ZybFJHeUxYVXNyc3RQaXIrcW5Zb3djU3R2Zmpra2R0?=
 =?utf-8?B?Sk5OM2hWbkpZSFN6NzhhZEVyNS9NZVc5SGMzV3M2NFBHTjlVT1hUVkpueUdl?=
 =?utf-8?B?RHlDSEd2MkRVdTltUmgveWpoWFl4ZjNGS3U5MGN4TnM4RGpoUDZCZ2xaTENG?=
 =?utf-8?B?WFlFcUIrQ0JpUjlHZGtPOFMvUzVTUmZJOUZXdXUraENPOVNEUWFybHVNLzZl?=
 =?utf-8?B?MVRmZmRBSWEwWHVMYmltWXBoWFZ1RS9BaXI5MWppVjBCNzBNY0dpaTArdDZR?=
 =?utf-8?B?UjhkeXY4WVcvZFE5eEw4LzZsNUV0SEdic2w1QkFjZGtkKzY2QUNuYlNXNWUw?=
 =?utf-8?B?b0NnbmE0SzA4MS9nQ3g0ZjhnNHV4akY2N1gvREQxd3ZsNHZEekM2b0I4QTJR?=
 =?utf-8?B?cW0ya1lOcHhXOWhaZGxvZUxTSkNmcEcwWXNOd2tySFAvdjFCZnZMb2hER1Rm?=
 =?utf-8?B?bVcya0lGV0NkUzFmL1dHL3JTZUl0OG05SHJKdGNmeEVMM3l6TGNlQk5EdnYr?=
 =?utf-8?B?cEYrOEt2MHBUWkVtTHdTZUNydmpyT1FlRlpIeVgvZ0pQVStRbUthRVZrN1NK?=
 =?utf-8?B?YVVmdFJWQ25CeEg1Z3VXdWZYQW9pUGNnYVpYM25OMkNSeEJOV0VpcGpNMFRy?=
 =?utf-8?B?M1NGUDhWSm9pQXFSbjRIOFNxcDhSZmwxVmFTZmttTWZMQi9BQkVqdGV3MURi?=
 =?utf-8?B?NVZUV2c3Yk92ZlkwRjlZVzlEZlQyR2Rvbm16Skk3eENRN2s0MzNtcFVMUm84?=
 =?utf-8?B?U2Z4OEFmdTJvM2hXVlJnbHBLZUlyQ3NhS05QcE1ndXRKRWc1bzdlSHBQa1FF?=
 =?utf-8?B?Ym43YkFTRGhDaTlvQytHYUR0K2lWNnZTV0dYMFZFQ1g3UVY5Wm5iTzBvTUJX?=
 =?utf-8?B?NDZTNGZTdTB4MEh3L2hFeXIxZ2lQbzR4andHVnIybk1UQ1ByV3pRbk1hdmdT?=
 =?utf-8?B?aHNZMTlLQnZMRnRnQVZKbEpKVG1aVWluaEFsNXNCTmU1U0FWS3k0SFAydUxS?=
 =?utf-8?B?VUpPcmVKQlEzdHMzOWYvOGhNcU5ac2NvZk5CYzA1eEZWMUpsSy8ySVNXdkph?=
 =?utf-8?B?WndEbDAraU1UbkMwWmFSNmw5VnJZbmUvRitwRTBSYnJsZUpTdnVLMVJ5c3U5?=
 =?utf-8?B?c1NGdkNTWXMyOUhIMDhPYTRsZWNIUXludDVjeXBBNCtlSWQ4K1U1QWtuY3k2?=
 =?utf-8?B?RUtVd1VjcmJGVm9tNE5wMzZFbHIzcGpNc3pxMUpqMjZPODRESkNHSWVYcStI?=
 =?utf-8?B?dW5tNlZoVXhtL2RQdG9sQTdsYnQ2RjdFZlFabmpvT1ZSOFdKWGxUYkN5WmZh?=
 =?utf-8?B?RVptaUtsMzFuWXQ2cG4wNDlVRFlDYWNhT2V3dnhRbUR5TXNXcjR4bDV2VE1q?=
 =?utf-8?B?ZVlsT2JpRWVEeFZoRUpWbjNrenYydCtGT1o2V3pxM01nVkxUbTJvQnNEVzNC?=
 =?utf-8?B?K3VaWWpRMk8yUnRuTUF6ZVM4RHM4YXVvTU0yREpMNExNSCtlcVNlbUJJTWJK?=
 =?utf-8?B?dndRd3Rmb0g4OE5yZll1Z1VjcjJjM3ozZEtsNC9HZHA5T2Fia2IwZWNaWTBk?=
 =?utf-8?B?aDRuTlFTRWJ4eDMzbDMvcTB2T1pUSVVGQjNHdWxGVEFYdWM1aXRiTFpCS2ZL?=
 =?utf-8?B?cmxVRHYxR2FMZk84UVE5VXVLQ0E4b285MnhqWWhqOTMzT25pd0ZEdXgybGc1?=
 =?utf-8?B?bTNzY1VmOGp2U1VQS0FmclRHaytEQTJFQ0RWNW96blpNQ0NFbUtqUFFDWEZG?=
 =?utf-8?Q?23V+AZyEldO0hVOM=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c1aae4-528a-4043-c897-08da43fd00d9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 18:31:54.8124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DNZ9jRbV+Q4yZuxpLaYMXRi+ABQ44dsGP/a6bSV6kmR3GuLIncFGKCHlOj98IRc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3908
X-Proofpoint-GUID: _uvmAvT1RNpAwIHxLDoReMS14IJq41Jw
X-Proofpoint-ORIG-GUID: _uvmAvT1RNpAwIHxLDoReMS14IJq41Jw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_07,2022-06-01_01,2022-02-23_01
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/31/22 4:50 PM, Andrii Nakryiko wrote:
> On Thu, May 26, 2022 at 11:55 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add enum64 deduplication support. BTF_KIND_ENUM64 handling
>> is very similar to BTF_KIND_ENUM.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/btf.c | 62 +++++++++++++++++++++++++++++++++++++++++++--
>>   tools/lib/bpf/btf.h |  5 ++++
>>   2 files changed, 65 insertions(+), 2 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
>> index a41463bf9060..b22c648c69ff 100644
>> --- a/tools/lib/bpf/btf.h
>> +++ b/tools/lib/bpf/btf.h
>> @@ -531,6 +531,11 @@ static inline bool btf_is_type_tag(const struct btf_type *t)
>>          return btf_kind(t) == BTF_KIND_TYPE_TAG;
>>   }
>>
>> +static inline bool btf_type_is_any_enum(const struct btf_type *t)
> 
> btf_is_any_enum() for consistency with all other helpers?

I am using btf_type_is_any_enum() since btf_type_is_* is the kernel
code convention and btf_type_is_any_enum() is used in relo_core.c
which is used by both kernel and libbpf.

But I can change to btf_is_any_enum(). It should be okay.

> 
> The rest looks great!
> 
>> +{
>> +       return btf_is_enum(t) || btf_is_enum64(t);
>> +}
>> +
>>   static inline __u8 btf_int_encoding(const struct btf_type *t)
>>   {
>>          return BTF_INT_ENCODING(*(__u32 *)(t + 1));
>> --
>> 2.30.2
>>
