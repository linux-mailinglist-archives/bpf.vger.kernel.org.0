Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD55A52C56D
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 23:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243139AbiERVVc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 17:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243133AbiERVVb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 17:21:31 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837502B26E
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 14:21:30 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IKi6G3031485;
        Wed, 18 May 2022 14:21:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xeZQTuzMJyCTpCzDMtItTPQv6EsVOr1kTAMwIR7VTic=;
 b=ZRAcNSpBfd1XsFgCzOKzuAlM+7AZUrEonX/OYEQaINwYWD3tqANZkCPY/npNP8jwsA+I
 tqM7hSVvd+M0WXZ46MhC+C/C5HoAaW4COJS4g8tmblqWucD1F6nHKWiuZdqcd296c/Sr
 Xg2XwMCs3Khgb06OFpLs1qeN5hO0z4pgnSk= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g3yq0feuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 14:21:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akkmEmVKJmxLG3u55T2nbH9RL2X6O7/82/qdQA/JxToveBQ8tf63igwS9Aq2ye4F0f878lVR4qKspNqgSSVJ+aa2F4+XMquqfxC9vl8v/u5n67s7mezcTl7ghZYrfpVQN13GQazIABNTGj2+yCduKntzaJJOSAJPahwKJJBMblGQdANkUQ2ZvDs8EI2MVwanRfqcA81rfu9ZgwQRZZBHYqJXw2LPyb/Y+0LlJDMjD9qIbr+jwiuEqB24OHko3kOVajwwED8xGWBECh6+o1X9NEd9VPuW0w1A889PuNOi0lsKI2/LYU3utcrtwGNCjni/fssCjSJXNgTUDO2rq2FxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeZQTuzMJyCTpCzDMtItTPQv6EsVOr1kTAMwIR7VTic=;
 b=Bk7hDzr1HteY2rh0i9k2ybwdTd1tLIQP6S3h/Zlva2sZhTfu7kGCGxolykmTDeNb/wGUbxkCZ36hsee4DgODwpVPlHjnyTeJA+jlUti7jOI8R9XDN8DGaO1tpfPdoaKmvH2d4ETwh2TPsn7doDzaGV5OkBD9MhoQaMcZ09oz+53EqQUqOqxBY5/toXDOARpxrZARPk+W8w8fd9wtF6Qo9JX25czfr8dnqb+0o4U7cv5hZOTF4uyfD1dFzckg0VX+9FTNver2CRz26R/BRBpXSISonRnz7fbBzOFOZ9Y+ZouEXvlDrpoHQ1e6ecJtrRCakIgiQSCYD/rNleUwbRg5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB4096.namprd15.prod.outlook.com (2603:10b6:805:53::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 18 May
 2022 21:21:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5273.015; Wed, 18 May 2022
 21:21:13 +0000
Message-ID: <e87b0882-f3e5-90a2-77c2-b00fad483f9f@fb.com>
Date:   Wed, 18 May 2022 14:21:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v2 18/18] docs/bpf: Update documentation for
 BTF_KIND_ENUM64 support
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220514031221.3240268-1-yhs@fb.com>
 <20220514031356.3247576-1-yhs@fb.com>
 <CAEf4BzZJ-UoVK75tgzh+sFRVw3X+OsGEQHU6iDgpnb=Y3gLrcw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzZJ-UoVK75tgzh+sFRVw3X+OsGEQHU6iDgpnb=Y3gLrcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0191.namprd05.prod.outlook.com
 (2603:10b6:a03:330::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af2707e7-0f37-4e98-aaca-08da39145647
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4096:EE_
X-Microsoft-Antispam-PRVS: <SN6PR1501MB40968FC3BFC75BCB367D4F01D3D19@SN6PR1501MB4096.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: myVL1k3h1i9WAnL1M8dAq3wI0Ir+QnnbrbDQHfjDxE+jjWHSZ2MVUAuSspVxHqCaASRI64CokF+riOGEWXACDgHO+QkxCsXDH3l0vV7Imhs5I5HKd96j9ooTXz/mGjiM3ukx2bp8vpy8gxah5KqHeqcvzPdH4b9H5bYvojsj0KiJxjGuhAu0gjHthpYbmRyYxUlVqH3x6G9TAPDbfscSSSZi7IBZoGCieaUmc9GqQu73e1SfFH9sJmFpkW4z7pAC/6oCtyN9kVyDiNayO2Nu6zUFCOZ7sRI8NPWRpi29ECSPdw5amMrHyIqNR0rloxwyZz5EWPa73KmepxLr4wIJMtnFKEx1pOz3FSoTSIvGfC1Vw6SdLgVI8K+5NDLtcorqKGBg9GhMaiB8+6DZwKlDbZ82jjaPPDnPQNqKIuk4qdL8pqTh/3hqBq9B6nqlYRFK68oFcWfSoTwCo8w5jaNOtjptY4BvTeQVVJO60sPp9ORWD3dd8BabbA5XOfivlkzdrXhlMYLH6Npd0RkQWtOwGZZ0oVd+yLGmK0sLwtt//uZnud2OlS0GWMinJX8q2qi5c9Pqp8V0veBBUUkqJI7JJ6jxgTo9Bg2YdykI97Ruf+WmsqzkCQL6+94fIB3lI3fn67kML8IxgJa2/5mDza8ddAbmrEHl4SDgonmMBueVqK5noEWfgVypwlzkLZt9rxc4xzdCHd1wC548Ef3T6HFu+DHAdXMur7DjOwuolXeDajucKV3JRj3j84OZAnbjtIDW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(36756003)(6486002)(31686004)(508600001)(6512007)(6916009)(54906003)(316002)(8676002)(66556008)(66476007)(52116002)(38100700002)(6506007)(53546011)(66946007)(4326008)(8936002)(186003)(2906002)(5660300002)(31696002)(2616005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUxnWHd2aDByVjRGMEVid0JORmUyQ0h2RDhaSG9WcmlsWFFwc0xTSFFWME9C?=
 =?utf-8?B?cHdvcG02RTd1NVdUUWhtMFQ0REVScDlqdVkxQUZ6QTBjVkgrRFJoR1FPR1hY?=
 =?utf-8?B?cTlqRkVJK0VPMkd1SGM2Qlhqb2lSb25vcC96UDV1aW83U1JJOFM1bzhqRVk1?=
 =?utf-8?B?aC9tOWpsU2hNL09aalgxeXZZYlloaGRLd2pLSFdRcEJJaW1BNDB0Um0vMUJB?=
 =?utf-8?B?WitDQWpkaTlzRkszeTF3bXQ0bmFEeVNnTjV1OG1qNXNYNk5KcE1KQkIyTE9M?=
 =?utf-8?B?OFpZRFJPYlZsbzF6K0RpMmYxWnlpWHp5cE12cDJrdmg1Wno1YVFHZXRVNWxi?=
 =?utf-8?B?MmtkTklUMjdIN3RhcEF5ZTRJaXZ4ZEV4R3g3V2d6YnNPWWszTEdsVUt5UUNz?=
 =?utf-8?B?OGQxRXY5NUF6RWd2QzBxSi9yVXZDNWtOUElrNlh0bVFaR05oN0tuaWRJeVhW?=
 =?utf-8?B?bzdxMXd1cmhIR1Z3RG9WeXVFSHk5TEg3czZjVlRiZDNyM0d1WU1nQjdxK0JQ?=
 =?utf-8?B?cUpnQ1dPOFRKTmdOdllxL2FZVW9mOHB5bVExV21aU1diT1U0T1FaQzY5TDcy?=
 =?utf-8?B?NzhqTldxY3paczA1YlRPZ056WnBYTkV3Nkp2c0xjRjZ2SXRIU29sMFdzbGpn?=
 =?utf-8?B?cWt3Nkk4N1F4andTNVJ0SXgrRFJqaUdnM0dpam01T3g5YTU1WFNMenJTbGdB?=
 =?utf-8?B?dzg3SzVVN1MvSVhoMFJ5OXFSbTlEZlJvME93WVY3SkJnU1FLNU1oYUFGN0lB?=
 =?utf-8?B?R1JVRzNoRkJUQ3JLeGt2Z1M0NDl0eGh3SnJDNGh6Yk5KaVc3RlZQcGFzdzVl?=
 =?utf-8?B?SjJCUkRhbUF5RDdjbTRkbXgwYk5iaXBYQnd0bFlvRjBIbWhIWWsyV0FvbWhn?=
 =?utf-8?B?T3lpZDVPeERsMTlnM2Z2d2MxVlFHR2QzcWpXZmdmcUNncUJpY0lNTjJ0N2kw?=
 =?utf-8?B?UlBpdE5NMVM4aHNDeS9tc3FOaStCaTh5RVlaVVd5K004b1ZJaS9raXE5Zkti?=
 =?utf-8?B?R29vT3BPYkR6UnJyQXpOb0Qwa3VBVm1KS2RGYTJNZWxNa0tjRGdkOVVHVnRq?=
 =?utf-8?B?U1FWOFhycEhUOCszbEorUU0remkrb1ZPTE1QcWRuSUlDaGJicmxNdzlqZDBW?=
 =?utf-8?B?VmdlRytKVVpiOHIvSm42bTVFWnJ0Yjk1UmdTN1pUUXFRdXh0M2RxQ2xzQ29M?=
 =?utf-8?B?WVRicm1jM1dqUzJtWWpqVzY2M3c5bGdtNmF0UXFtNnN5VXdPWGhQa1J6WWVX?=
 =?utf-8?B?U0lJVk1FVk84U2E2SFRNRE40ckhZZjZQQ0ZlaVlqaDBvWFZaWEJOaGZqNk5q?=
 =?utf-8?B?UkhoN0plR0FVTEFwQ2Y3SVUxZS9BTTE0Tk9aK2wySVZqd01aSW00ckVvSWFh?=
 =?utf-8?B?U3dIQU5tZ0F1ZmltaHV5Y3J1SnVEMU52aGsyaTlXbHppK0xYOXdRMEhlUmJG?=
 =?utf-8?B?endQVWpNV20rdkdZSDJOZktpaUdIeWRrM2IybUNEQVpLekFvVjF1eXh4TWIr?=
 =?utf-8?B?ZERFZW15SUF1ZGdVRU4wU292bDhpYmxaRzlLRVBSUUNteWxnSzNQc210U2xH?=
 =?utf-8?B?YjlZSWxnL21SWmQrVTNwbmxxTUhNc2pqNmUzcldXTDdHd2pTUFFjSG83ZUpj?=
 =?utf-8?B?UStMRTF3UHdKNFZqZ0NmRk5HYVJkbWlOMjZKbWdRVHJDcDF5TXY4dm1IMm9t?=
 =?utf-8?B?Qk5nQU1ha1U3VHNhU0VJb20xQUVKNGx3MGxMeTNXV1FDQUpScG4rcmpXOTAx?=
 =?utf-8?B?NDZoS3ByQ0RFcGg5ZmYvMXhSZ3dQWHVxTzVYekRxZ09jV3dLc3gzT0Roang5?=
 =?utf-8?B?bCtKRmdiUk1iT01WTzNWMW5hZndGNnpKaFRsVWNlUVZrY1ZVMjlDNnhZTXJo?=
 =?utf-8?B?RTV4WVZnbHhvTmZ6dGZuOEplMlFpd09TdS9JR2t6eDFCRURxaVlkalFkZUdy?=
 =?utf-8?B?TkF2eFkrT1ZyQkV3d1RaS3Zva1ZCekdWQkdYVzF0ZTlrbjVwZFovRlMrRXlF?=
 =?utf-8?B?aWJkQ3dhejMvTzM5K0JwcmxGb2lVcGFpOFhQUzYrTG5ZMTFjWXRwUkJmNk5u?=
 =?utf-8?B?Y2w1aFFqVUpIaWhNOVRXbFVaWHZTbE5Wbjh1YjkxR0ljRHFLMktCZkdoYUxy?=
 =?utf-8?B?aW02M3BqeTNSMGN1YTd4Q3FwRkNodVNOOTNMM1Q4SFcwNVQwUUo1cXJjV0xl?=
 =?utf-8?B?WTlrQ2thQUtzWGE3VkFZUlRWQzMvSjZyQlUyMUppSTR4czJxZU95OVRMZmd1?=
 =?utf-8?B?dVVkb3d1L0xYV2lMWXE4WTMydnpIWnpKMGZzN3Q3SkFkMnByelVucHBBSXVP?=
 =?utf-8?B?T081azZjM09zR3M0M0RTVnR6VzFrWC9ERG8zMmo2SlZtWlZPWWIxS0FVKzRN?=
 =?utf-8?Q?3vKzBIR6teySWCvU=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2707e7-0f37-4e98-aaca-08da39145647
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 21:21:13.7575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUGVsp1c8D/mguhAofbDDPqZIbaJ71gLc+MNzGMI4Ndl9tP9tDdDj/yUeMq25K/N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4096
X-Proofpoint-GUID: _a-hRXBIMQDy2iQ6q0_oTjkwMaI4BmKd
X-Proofpoint-ORIG-GUID: _a-hRXBIMQDy2iQ6q0_oTjkwMaI4BmKd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/17/22 4:47 PM, Andrii Nakryiko wrote:
> On Fri, May 13, 2022 at 8:14 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add BTF_KIND_ENUM64 documentation in btf.rst.
>> Also fixed a typo for section number for BTF_KIND_TYPE_TAG
>> from 2.2.17 to 2.2.18.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
> 
> LGTM, but see pedantic note below
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>>   Documentation/bpf/btf.rst | 34 +++++++++++++++++++++++++++++-----
>>   1 file changed, 29 insertions(+), 5 deletions(-)
>>
> 
> [...]
> 
>> +2.2.19 BTF_KIND_ENUM64
>> +~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +``struct btf_type`` encoding requirement:
>> +  * ``name_off``: 0 or offset to a valid C identifier
>> +  * ``info.kind_flag``: 0 for unsigned, 1 for signed
>> +  * ``info.kind``: BTF_KIND_ENUM64
>> +  * ``info.vlen``: number of enum values
>> +  * ``size``: 1/2/4/8
>> +
>> +``btf_type`` is followed by ``info.vlen`` number of ``struct btf_enum64``.::
>> +
>> +    struct btf_enum64 {
>> +        __u32   name_off;
>> +        __u32   val_lo32;
>> +        __u32   val_hi32;
>> +    };
>> +
>> +The ``btf_enum64`` encoding:
>> +  * ``name_off``: offset to a valid C identifier
>> +  * ``val_lo32``: lower 32-bit value for a 64-bit value
>> +  * ``val_hi32``: high 32-bit value for a 64-bit value
>> +
> 
> I presume if size is < 8 then val_hi32 will be sign-extended (i.e.,
> 0xffffffff for signed enum and negative enumerator values, 0
> otherwise), right? Should it be specified here?

Right. This is similar to btf_enum, e.g., btf_enum can have size 1,
e.g.
   enum T { A = -1, B, C, D } __attribute__((packed));
But for enumerator A, its value will be 0xffffffff.

Here, val_lo32 and val_hi32 are just low and high 32bits
of unsigned long long value of the enumerator. I will add
a few sentences to clarify here.

> 
>>   3. BTF Kernel API
>>   =================
>>
>> --
>> 2.30.2
>>
