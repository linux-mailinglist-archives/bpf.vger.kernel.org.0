Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010D26F1D75
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 19:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjD1Rbm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 13:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjD1Rbl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 13:31:41 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041345253
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 10:31:13 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SA6MfW003906;
        Fri, 28 Apr 2023 10:30:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=R7Ozih4l0n5imSBQ/FnMw4GQD/zA25ZTCMcvp+sxTCw=;
 b=huzZusT8mWKom/8iTzAsgljOLM4LOfMk4HqehB+NIweKhI1QV58n0KUWOwBPhE+6/Ek4
 fL01xv0+tBvAohD+754PRn9k1+e/cg0iDqmopOgTd9oaaNGHjC14mQkk7rcZhQeI4sZk
 uah5Jepx2wOYlM7melCThCQTQosNF14vy2RUjlsrRZUxGM7Zk39rpj7IsQfBiE+V8k7Q
 rA/KnaP/c0DKzio3EbJH/dVP/Z/Gd6fZBvvTHAAbpvfnjZwYXBrOWNjfPoANIAWMM/Mj
 Lz+WIfLsPXDcMTnj4s3/VK3s3iLEkyVOBqEVDRvCxjZW3Jj+63Nzmd/7yhs+FRHwwGiU dA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q84y3naew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 10:30:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddsMecFU8qQZ1sW5d0DlKdMbN22UJSxWIJHOMWshW8YA3Co48Fs4Jd3/HRzk6h16ZwdVtHEFM8Vwb/ynRDuqU36rTM2KnC1eya6KP7/I2AS21Nadukskf7mMpQWgkJhp0YRKpaJfYNoiLXXaAbXYSsujs1EaqARbGR3eZr2CH4wzh6xwxPmmuRA44JmpyqKtPFPRMoINnCqoGBrjNGynXyWpwHxWr1udFhqxnJygEC/nBVL6rT4hETHgZwSKBVf8xf1q3i07ho+TiMY2nXFNh9RPVfjrznVBH0jFv9CRxFDLnAYgHMVO/MrkMN9pq6NrzBQLjAgx76B0LxGyLscXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7Ozih4l0n5imSBQ/FnMw4GQD/zA25ZTCMcvp+sxTCw=;
 b=U1feXit+VZ3aZQAY+EBSqMp/GlovBakX7mav4FyagUwRTmQclO3TxzOUuf78FzpRycxrnxyJy0NrE3WCCRT+7DAnQRu8x2ihWvu21hDOj8atT4caYTYfisSpl4aqUYgkHcltevNXm08cCb9ymhATZd9H7q0+jXP23qdMeu4LE6bZlRiMzKKVu4In6CjLM0VBBJDkw9oEQxXqVZV9oFcknT3CwgC30sjyNoZg1LnrNmNAMfMydCTG153Zp/tefiw0dtunROwh/cBlyg7jrnMd2SZ8uxcTVVFZ1FIBo56JOnDm5KhiYzPDmQNX3YRX9JpSdVBV6Bb6qp+uG+9HXsZtaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 28 Apr
 2023 17:30:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 17:30:54 +0000
Message-ID: <006349b9-7cec-bf02-2732-90aaf614f342@meta.com>
Date:   Fri, 28 Apr 2023 10:30:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next] libbpf: Fix overflow detection when dumping
 bitfields
Content-Language: en-US
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20230428155035.530862-1-iii@linux.ibm.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230428155035.530862-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: b882be1e-5705-4422-fded-08db480e51cd
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Py3vGfI1rKKuLSedd9Pf2SwzHDjs9k2Y7LnoTVNUTW4u5rnx8Wsk/dxPuVYYWAwc+PpCbAg1QzcmsRtSIyBYd+iREcopDYLY2YVQmy2owpmtZ8yFmxLFOog8Fwi3t7Jx670EcBfNKSvdMxpY1NEZUNxzhTl2zFyIRaZWQXsl/Ppi6yidfhAZLz5pAJCRKsm0RHW455OugvoHLEH6af3dYGHQAbKl0Hqqo3O8URb5osWpbyCioGFbJvrhqvYMe3xhlQEG9gSpjXLHvXRznzF9fzfsyqyJNTS8wk4y3UTdAZRbPR+YhS88HNAgPurLQw+xJXmUM9XVQc/5eofttCUQGH93uPCeEGHbaDV6Uom9/tkwmXxJqz8+GETuWOBQCnu7Z8BUxmwdl1XzKPr45o8Tjf3pP6hwCP4GHesUwOmM+My/8izcRMHgNeBGEcEHACAo/kQVlwua04kBbzJKkl94a0NIOhkqQxwThqcnpyOCuhzkat72B66+udUZ9PXSyoZrHE8JhfaQQkKMkYEMoqoYhiTSxR7BDH0OsmRG704GC48D2O/wFUCY+Rv93oiVhuLyRSAM1UPpt2jWx9S7iTSgi4eClhrtXVH1J54ffpU547reDJMS+z7i30yazqH7pYR+hpdtthO7UYs9tp81ioya2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(54906003)(110136005)(478600001)(5660300002)(8676002)(8936002)(36756003)(2906002)(31696002)(86362001)(38100700002)(66556008)(66946007)(66476007)(4326008)(316002)(41300700001)(186003)(53546011)(6506007)(6512007)(31686004)(83380400001)(966005)(2616005)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXdvUERENTd2Kzd4b2gxNUswcVRUZGFVd2h4alNBOVlydHNYa2JYTG0vVHFx?=
 =?utf-8?B?ZGhBT05OZmdiOVliZHVOM292MXBIc1YzL1RodThmMlQ4aTZRWjREUHliczk4?=
 =?utf-8?B?dXZSZUxlOVNIWnJtblF6NmtQMnNDNnFyYlN1d0NaOXVhQ0lXNG5mZDRsSXVC?=
 =?utf-8?B?cStaaWlWWkxhTDRCb1ZHNUNDM1hNeVlKeEdLKzh5ZnBJN2IxZ00venJDbU5R?=
 =?utf-8?B?RlU5RUxhZThKRE1CSUhhYzBNVWdqOUNJM3JWbGRGdzF3K0hPWHlSZzFhenBD?=
 =?utf-8?B?OHdSbldwU0pleVNjMXBXZnRaVFQvQ3hRTHV6UmNzbGxMRkRmWDRFK04yQkRv?=
 =?utf-8?B?ZXd2SG52VjVEQU10K3p1OVNhY3RIYUdpVENsd2RwM1J2d3ZxTnRCVjVNMFlr?=
 =?utf-8?B?c1hTaWZ3b2IzMk4xV3ZmZ09QNlpQL0VMRXlReG9xVG5xcE43ZEZ6cUFobW5N?=
 =?utf-8?B?UjlRSVp3ZFVqRks4T09KbFJqaVNDZFhNc3d1aDdGOFIrSCtUQXNyU1VydFNm?=
 =?utf-8?B?RTdpVkdrdDFFdG4vOU0rOGJ1amM5WUZmV0kwaGlxRDl0MHA1S3RzeGRzaU5o?=
 =?utf-8?B?dUkycC9vckcrZGFHbllQM2VmMktWTTAzTXIwL0ZweDFQVi9pSnNVUmlHTmRG?=
 =?utf-8?B?T1pzN2wrL1hoSTVIaWlMWTkyZ2ZBVWZGSHQxVzBWNkloUS9kUjh3M2hzdmN6?=
 =?utf-8?B?S2dDNkJwYnQxMXBlT2w0UnlLSVRicDhSWXVxNVFnWDd1NVBlcmJZUnZ4WFhl?=
 =?utf-8?B?SU1rNVlVZXdhdlJ5UEtwd3l4UjhGaklrY2FmUi9TZXlPdXZ2aEpjNHFuZ2Iy?=
 =?utf-8?B?ZmhGWllBQkRVOURHUDQxdFFKNnJSZ2VUQVQwb3orU0NPcjNJWnBBc1pLTzY1?=
 =?utf-8?B?OTA1TFQwY1pPdTlUejlML091S3VLNEdWQ3JLU25NdXd3R0lVdFNpZTlNcEh0?=
 =?utf-8?B?anNNZGJIOGowWUcwNnB1UVFkaFlOM0dlMDU1QlZUVTB5Wkh6T0hnRVJFTkg2?=
 =?utf-8?B?UC8xMnQzTmwrcUk0WS9ZTGlhWEs2N2hVWHBuV1BsT0xLRUdValZjVHN0Mi9S?=
 =?utf-8?B?Rkt5RlBha08wVGw1NDd4RDJOMmRoeGxPRXVQUmZmbDQ0YTJxOHFNVzZ4NmVB?=
 =?utf-8?B?eUxqeWRHZ0swSytqWkltNEljTy9vODJBQmNPV1R0cEdEUWpoanV2VUQ2VFdB?=
 =?utf-8?B?aTRLVFJRNXlLa3hLemEwcjRaQW5ISUE3SXh5YnNzVGYxR1lLbkdGQ0Q3ZmF2?=
 =?utf-8?B?MzcrbE5WWlcydTl1Y2dXZ3plWk0yc0VuQitjMDAramM4WDFWMG1LMXNsWTNm?=
 =?utf-8?B?eHBjTVVmTTJ2WUxSVkJMTUNIWS9LdkFEMDUxN3JFbjJmbkZObEdjYWxZcFIw?=
 =?utf-8?B?VG4vYWhydnZIeWU3N2t3SldMWHJjalhwcDRxdkpBaXZhdzl6bVgreFRZUEtG?=
 =?utf-8?B?TUNpd0cwTEU2T01GVURzOE5lQXFwSXFZZ25aS1FwY3pIQ3c5Q1pzeDNQRS9o?=
 =?utf-8?B?RkpmakR1WUlNL216c2JJRVpBWVpTN2FDWmRJb2RjWWYwdUJYN3RVbTA4ZXJZ?=
 =?utf-8?B?cXczV1J2Y3U5SzhDZmJvQThRRzhmUmVINEVjTWJQMnVjQXVmRHFCdEZ6Nkda?=
 =?utf-8?B?MmpDWjQ3a1NkZGFERFRLOGJhNXhEVkcyYWVxQmkxc0swL0lhYWhadE5sY1Nj?=
 =?utf-8?B?dnpwZXF4M3hXeXVjbUx6LzhEVlgzRk55RWx4ZWNRRkNZT0llVDZHb1U0VUlT?=
 =?utf-8?B?KzFrSXRUbzY5eWhkLy9Oa3dhai93OU9sQVU2SlBLMEFpM0lpeGl3RWVnTVI2?=
 =?utf-8?B?SndvYzlqLzE2SzZDckpXYnI1QjRXMmcyQ240cElQdlc4QUVTMCt4cnY2aXFO?=
 =?utf-8?B?R2Z6Y0syL0tZNFY4ZmFxWTE2N2lOOS9SNWQrN2RBUUxBZFF4dDllcHdsOTNE?=
 =?utf-8?B?MnlYVkltV2VQQ0VEYTAyRGN1QlVFN011QmFIT3pHUCtURGJPTXpSWVl5SEVC?=
 =?utf-8?B?alA3WC9aNDFHR2xFZURDb1NEZTRTT3ZsRGUzRllZQWQ1SUhXMEE2cExpNDlm?=
 =?utf-8?B?RW9ieHFteGlzK0ZFUnJ1dEpCNnFSUHUwSURLd1JJakhvcFUwMFBnRWRpQUIz?=
 =?utf-8?B?TTNuSE5UVXhnWUQyMkl2eXRZcE5wcVF6WVJlelp3eWhFajdieGt6dHFaMjh3?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b882be1e-5705-4422-fded-08db480e51cd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 17:30:54.4383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzLHIe4NpoC+ZGTXSWLWUUsvOun8E2snonkpBbVi+Qkr4su0aD57zI9UAYFebQ3e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4552
X-Proofpoint-ORIG-GUID: ynBcctfk2EPQN52wbF2EsVoQ8GYRjQGH
X-Proofpoint-GUID: ynBcctfk2EPQN52wbF2EsVoQ8GYRjQGH
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/28/23 8:50 AM, Ilya Leoshkevich wrote:
> btf_dump test fails on s390x with the following error:
> 
>      unexpected return value dumping fs_context: actual -7 != expected 280
> 
> This happens when processing the fs_context.phase member: its type size
> is 4, but there are less bytes left until the end of the struct. The
> problem is that btf_dump_type_data_check_overflow() does not handle
> bitfields.
> 
> Add bitfield support; make sure that byte boundaries, which are
> computed from bit boundaries, are rounded up.

Ilya, Martin has submitted a patch yesterday to fix the issue:
 
https://lore.kernel.org/bpf/20230428013638.1581263-1-martin.lau@linux.dev/

> 
> Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tools/lib/bpf/btf_dump.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 580985ee5545..f8b538e8d753 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -2250,9 +2250,11 @@ static int btf_dump_type_data_check_overflow(struct btf_dump *d,
>   					     const struct btf_type *t,
>   					     __u32 id,
>   					     const void *data,
> -					     __u8 bits_offset)
> +					     __u8 bits_offset,
> +					     __u8 bit_sz)
>   {
>   	__s64 size = btf__resolve_size(d->btf, id);
> +	const void *end;
>   
>   	if (size < 0 || size >= INT_MAX) {
>   		pr_warn("unexpected size [%zu] for id [%u]\n",
> @@ -2280,7 +2282,11 @@ static int btf_dump_type_data_check_overflow(struct btf_dump *d,
>   	case BTF_KIND_PTR:
>   	case BTF_KIND_ENUM:
>   	case BTF_KIND_ENUM64:
> -		if (data + bits_offset / 8 + size > d->typed_dump->data_end)
> +		if (bit_sz)
> +			end = data + (bits_offset + bit_sz + 7) / 8;
> +		else
> +			end = data + (bits_offset + 7) / 8 + size;
> +		if (end > d->typed_dump->data_end)
>   			return -E2BIG;
>   		break;
>   	default:
> @@ -2407,7 +2413,7 @@ static int btf_dump_dump_type_data(struct btf_dump *d,
>   {
>   	int size, err = 0;
>   
> -	size = btf_dump_type_data_check_overflow(d, t, id, data, bits_offset);
> +	size = btf_dump_type_data_check_overflow(d, t, id, data, bits_offset, bit_sz);
>   	if (size < 0)
>   		return size;
>   	err = btf_dump_type_data_check_zero(d, t, id, data, bits_offset, bit_sz);
