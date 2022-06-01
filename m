Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B56253ADF5
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 22:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiFAUr4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 16:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiFAUrG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 16:47:06 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A3A1E7BE5
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 13:41:43 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251E1eNM011656;
        Wed, 1 Jun 2022 12:15:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5fc3QW0knGq6mnHD8LSDxJNFWsj10rtIOmwnt8ZIkyQ=;
 b=SQY+S6fv0cdfyGlso5kCTkugm7ndNuP78SgF6bHARA1FkG7z2uqiju16dxbBByes9q99
 U7vsUyQi+8MP8q2zoK17MLouYeQl+t+6xWCt+kktBGLJ1JZPKS5E5qX99cSLENjryttm
 I4ulT6u55FYYfTO96uWpbyDqn+2R5s0UuQ0= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gdv91wyjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 12:15:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+IBmO29QWQJ+9SpJZD+sRCbYUR0FhEHxYCZTQ1YJbPp8Rg6LbCuzHhnvKVYA1sCaBy0WJt5IPC8jApumQTtjLrOks5TYR8SNQJ1r3bb/V2rjXyAv++FSRWh3o525yc1zBMS4UoljwbKBVlsdDlYCMO7Kb+AQvR4YFElZrI+ubm1H0fJiQIu+oZ6bqXaPIzAWo8Ae1Znb/0yzwwN3O8SImn+WwhFOLZJ5c7I+lIWdQ+npTeYEBlr6xcsOHBFdCpH8sHScFyMQxodY+MqoO0ckTUAK5sX42FPbNz4FH8ax/qsInwVV/t+THPMk7gMZKQZV47HuD1ERQ2aVZgB45x6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fc3QW0knGq6mnHD8LSDxJNFWsj10rtIOmwnt8ZIkyQ=;
 b=NETqGJfThvU6fsSgE/4wiuTgatqZ69d09CfPHUm5BHuZmtGM+ymotA+cEl1U2dVzbReHOLK6a/0wpUn+nhsFcZYtt5ZjQRx4pCIx9Kfmb2nZBAkcap0iy7UGIWJb9qSTi3EenqXJ+Vt3CRQ0gp2aaT1Ej73yjJ9+uiMtLxRlI7cL5LxBc/AQqN2vQwcKTdn3T5eEWW9d8C5YAd7DmzqtqWbrh1NBkkFAxexIfVaRoDucaUFLrPjakGA27ifIAL6ec6H919ZypB9AGY1LJRYY74iKW3bbyE7eeyDic1hsjmLaSL0YZGYCv/WyN2atrP+YHGl05AG+gHomjpxRYOlvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4185.namprd15.prod.outlook.com (2603:10b6:a03:2ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 19:15:16 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2%7]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 19:15:16 +0000
Message-ID: <45531c7a-96af-d1c9-f1b7-b3e7a27fe078@fb.com>
Date:   Wed, 1 Jun 2022 12:15:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH bpf-next v3 13/18] selftests/bpf: Test new enum kflag and
 enum64 API functions
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220526185432.2545879-1-yhs@fb.com>
 <20220526185540.2551209-1-yhs@fb.com>
 <CAEf4BzZBNfee7zpg2bN-XqQQjQrn4ufq_53pmYqbaWb+jiwcjg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzZBNfee7zpg2bN-XqQQjQrn4ufq_53pmYqbaWb+jiwcjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8adb690-598b-4dd0-0654-08da44030f4a
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4185:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4185A2607CCD941EE048B140D3DF9@SJ0PR15MB4185.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9psTFVZzs55BqU8OMp1ogYA+SpcbPYUgqRLtmEF0fuZvuvll6R/2hFdGrqJa7wddiiKABLHxSvwv2Qxgbd5HWSPhm+iFqDAAD59KhRGvUou8na+L22iDYSW6QoGCYYQtnhPj1QTAGsng5n4iSb+IFRqcjxT9UgEK4bWUG2KFq6q/E9JxtR6pYwUiPfz2HGWaulxV3WPWTpvrMsaoWl1U1jQkpoKxLDg1z4As1TlIXziCfeu6kHmche7xF0Kq4d3wijR+JiIIElHn6nu2khGxB0LyJt7alqu+76dgrBJgB1c2IEE+w9Pxa2cAhprx00HFR3oCkGGoXSGL4RHG/q+nNToFYIoy0mWMRppjeNKZNL74QwWUd6BuvA6RChKJaX9q9fcvxLJ61NAOA8ln1JWIsXQKoWKPTdI2lMTcXSR6GmbK36BzHpZs/nmGF3V+46qby+Wupb2r5zBSB/aAkmsSZb9RY28cs1Do408Ij6ixhAiZ4ZO3llY0j5ULh3iY7Z12cxlATlibyRQRKWhvnyLoCIHdG6zf/zhHIKycWRR5ZHkj7F/IIEX2b4smLLce9VvZN/MWWxB4mXZH5xVrzaDC//Tojd/EL1PBhTJVWlPRGYFPhAe6dptByPlvwgDVnaA64smgjMY3gi0us/OdDBoBFZoEZFaa8Ki1PDByw6ezaeIQEDTz11j9MPuzPWF8pIgndue2+1hTou9FZA6fGUO2RnBJ+H317QbOlt/NgKzTBwXZtq6h33VQqpweg7AInxeN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(508600001)(4326008)(54906003)(8676002)(86362001)(6486002)(316002)(6506007)(2616005)(186003)(83380400001)(2906002)(53546011)(31696002)(66946007)(66476007)(66556008)(6666004)(36756003)(5660300002)(52116002)(6916009)(8936002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkVTcEJLZVNTYi9YeUl1QUVHUnkwVGEwZGlzcS8zQzA2ZXlNaEw2V3Rwa1hy?=
 =?utf-8?B?dUR2WEg3ODFWV0RFN0hJRmRRMENKT0I2Ynl6RlRPWEVoYVNYbThERThXQjFj?=
 =?utf-8?B?TUphVnMxcmlmKzQwSnFhYk1LZzJEaVpxTVhyTHBxUlpaSEFqUTRDMHNPQTc3?=
 =?utf-8?B?NDBXbi9sUzdoYW16SFN4TUtiemRtYkJQKzV1ZlA2amRxRDFSKy9BN3JnUVhI?=
 =?utf-8?B?TnJBa2EybkZWL3RuamlYRmZEK1gwOXI1MnJqMnZCcXdpeGdERnVlVU5jSzJm?=
 =?utf-8?B?Ym5VbXVpYXYvWVJDQXptbGs2Z0FLZjhkZ3VNa1g4dkVldnlhc2RjaDJzMjdS?=
 =?utf-8?B?SUpEL0VhZnZ2RnZnTUcrcUJPVGQzQWRuVU1JU2ZvRGFXTkZPUVJSZjZjQk1o?=
 =?utf-8?B?V1RoVXVlQTRzUVlFSm1WbHNhL0RRU3JudVlMa25Hc3dWTkdXL3o3L2MwVjE1?=
 =?utf-8?B?OHpnMm15Z0UycXV3ZmRCOXJVM2l2NmZ1dGNEdjJQSGZLZGQ1dzlHYVZtL3dz?=
 =?utf-8?B?MFN1Y0pINUswdjdnYnRGU3ZHbkl1NWNRckFQb1oxcDVxRWRCN241cGpTUmhO?=
 =?utf-8?B?V0xtSk85c2YybURGa2IzWWY5V1d4bDVBamp0QVRCRHhQTExHbkdTUmptekRr?=
 =?utf-8?B?NVdrVjhmQTkzREd0L2lCam9GTlRrNGVaMHJ5RkdZbnZJZ1RWZUVVc2ZoU1c1?=
 =?utf-8?B?YkY2dHl0Ym9oc1ZaTEFZMUtQTnVycHl1QXFPZmdJVmtKY2tNNjNuV1RLQ1lX?=
 =?utf-8?B?ZWNGY2d3MUl5dzJpQ2tIdkJ5VkpjUlZ5eFRjbkNrUklyOGN0dUp0ai9qd0c3?=
 =?utf-8?B?QVhuY0lTRm51TnR1ZnY1WC92Mnp6d2hmeGgyWUNxYmxCcEh5NXg1K0VpV0cr?=
 =?utf-8?B?eXB6Qm80azJzZEpZaFBWZlZ4dHpMUjY0NUFmdXhmUzB5KzdTZ0ZCRXhpZmdV?=
 =?utf-8?B?b0dvT09KZ0NpN1R0U093M1BYZTRVcEs4cE9pRk42WUE5SVdzWHl6UVQ5QnUv?=
 =?utf-8?B?bVR3TWJyVHZUY2JMdDBuZFl3WUQyWkk2VHp4WnZRNWtsa3hJQVFZYUE0czlO?=
 =?utf-8?B?clZRT1J3V3FLY1pXT0RLU0NNb0Z0SDZ2OFpuWWpjQ0U2b0hMKzNWTVpIaFBq?=
 =?utf-8?B?SWZjdGd6REN5OXBaN2hGQ0hFdEYzalBFZ2x4MVNhOWhkdU1ZOVM1TUtTUHNi?=
 =?utf-8?B?dHB2LzczUUJLVG5XUTVDQWtLaWcxYkZrOUIvMjR5bHRxUTNDMGhwS0t4VG9Y?=
 =?utf-8?B?cDNzd1I4MVU5U2lxOE50dmlJT0N1VWxBSTl6RS9lS0h2Rk1iQnErQTJkN2xY?=
 =?utf-8?B?d3VJSnhlTWYxNTFVMUtkUGk5UHFRZlFiaXFkaG1MZnlCdDJONmRCQzhzb3BW?=
 =?utf-8?B?QVVCRE9LeDBlN044alhSQWlIaUtPU1QxY3oxWjlBWDFuQ1lVam1iR3VtenFq?=
 =?utf-8?B?cVNQdVZUd1ZZR3dhWCttVG81cmlKT3JhZTBjc0JUMGRwVk94YU9la0tqN3FT?=
 =?utf-8?B?Mm15RkIraGlLSTV3TFF6ZDJKa1JlUlZsWG9HdDFhNDR2a21GcGV4S0RYeity?=
 =?utf-8?B?cFdub0Foby9hZjg3c0VKRkFxTnI5eC9UNm1TWU9aVU1VL0l2eDIzMitnRkVz?=
 =?utf-8?B?bkgxKzJ5czJiQWMvalk0TThhT3phSFVtdGxvU000MXV4ajVIRC9yak5IeHg0?=
 =?utf-8?B?T2hsZ0VKSkFvOUpLaDFvdk13b3dRWms2TlJXcmNJaEJTUDhqTU5UV1YvNHdG?=
 =?utf-8?B?Si9mNWlzZmRvcUxDRXFObml3L1hKV1dPeXpmY3E4SjNCTmQ1TDFNZmFMTXRw?=
 =?utf-8?B?aGdJYVQ4WFpSeTBuY2tKYlBGQTQxUHdQeU5jcjZjSzI3d1NON2pmVWs5UWJz?=
 =?utf-8?B?Tm1Db3FSN3lWSE5qYjNNbElrNStBWnZWbkFQRHgvUUEzUWg4d3BXWmtpWEpJ?=
 =?utf-8?B?Y0JPeDZtMmg5OXNEUy91Y1ZWQ1c0VzRuUS9ybjlqRWJMc1d4SkU5RzRlN1Bp?=
 =?utf-8?B?VUY5bEh4dHQwaldsNEFGUmluM3pkS3ZkYzViM0JMYm82eEhQbU5CaVRUbTJV?=
 =?utf-8?B?c0c0YjNCWjZFY1BwV2dWUUE4UjRSQndxNkRqc3lQb1prdjEyYXl6YjBYVEc2?=
 =?utf-8?B?cEoxb0NBSDNKNDUvQXBWT1J4c2FKNzNnbTBrejFHZ01ZOGJuSVp6b3FPVlBW?=
 =?utf-8?B?Qi9JZnBqZUMybG8vRHZvejZEeU1XVFdVdlYwZitaaWpydWx3L3pTemtxMklh?=
 =?utf-8?B?eTl2NW9yS3QyUFY5SkUzYlRkSTNzY2JYdk5qN05UM0ZzNHFqdXRnRXRDUnJy?=
 =?utf-8?B?VzQ2L2ZVSURLTXFKejlFL3B2RVpRandoaXF2cFhpMk9vWmk5bytEL20wU3Nn?=
 =?utf-8?Q?GP0MpRpCPwuV42Yo=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8adb690-598b-4dd0-0654-08da44030f4a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 19:15:15.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3aaG9QRSASEDBuso22xSuruKRWqJAYXuah82T8Ksrk+N4055woF/ivFiHTdNjqx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4185
X-Proofpoint-GUID: _GcdTCcG9YFICo5Alu4ynZQfA-qBghOQ
X-Proofpoint-ORIG-GUID: _GcdTCcG9YFICo5Alu4ynZQfA-qBghOQ
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



On 5/31/22 5:08 PM, Andrii Nakryiko wrote:
> On Thu, May 26, 2022 at 11:55 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add tests to use the new enum kflag and enum64 API functions
>> in selftest btf_write.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
> 
> LGTM.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>>   tools/testing/selftests/bpf/btf_helpers.c     |  25 +++-
>>   .../selftests/bpf/prog_tests/btf_write.c      | 126 +++++++++++++-----
>>   2 files changed, 114 insertions(+), 37 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
>> index b5941d514e17..1c1c2c26690a 100644
>> --- a/tools/testing/selftests/bpf/btf_helpers.c
>> +++ b/tools/testing/selftests/bpf/btf_helpers.c
>> @@ -26,11 +26,12 @@ static const char * const btf_kind_str_mapping[] = {
>>          [BTF_KIND_FLOAT]        = "FLOAT",
>>          [BTF_KIND_DECL_TAG]     = "DECL_TAG",
>>          [BTF_KIND_TYPE_TAG]     = "TYPE_TAG",
>> +       [BTF_KIND_ENUM64]       = "ENUM64",
>>   };
>>
>>   static const char *btf_kind_str(__u16 kind)
>>   {
>> -       if (kind > BTF_KIND_TYPE_TAG)
>> +       if (kind > BTF_KIND_ENUM64)
>>                  return "UNKNOWN";
>>          return btf_kind_str_mapping[kind];
>>   }
>> @@ -139,14 +140,32 @@ int fprintf_btf_type_raw(FILE *out, const struct btf *btf, __u32 id)
>>          }
>>          case BTF_KIND_ENUM: {
>>                  const struct btf_enum *v = btf_enum(t);
>> +               const char *fmt_str;
>>
>> -               fprintf(out, " size=%u vlen=%u", t->size, vlen);
>> +               fmt_str = btf_kflag(t) ? "\n\t'%s' val=%d" : "\n\t'%s' val=%u";
>> +               fprintf(out, " encoding=%s size=%u vlen=%u",
>> +                       btf_kflag(t) ? "SIGNED" : "UNSIGNED", t->size, vlen);
>>                  for (i = 0; i < vlen; i++, v++) {
>> -                       fprintf(out, "\n\t'%s' val=%u",
>> +                       fprintf(out, fmt_str,
>>                                  btf_str(btf, v->name_off), v->val);
>>                  }
>>                  break;
>>          }
>> +       case BTF_KIND_ENUM64: {
>> +               const struct btf_enum64 *v = btf_enum64(t);
>> +               const char *fmt_str;
>> +
>> +               fmt_str = btf_kflag(t) ? "\n\t'%s' val=%lld" : "\n\t'%s' val=%llu";
>> +
>> +               fprintf(out, " encoding=%s size=%u vlen=%u",
>> +                       btf_kflag(t) ? "SIGNED" : "UNSIGNED", t->size, vlen);
>> +               for (i = 0; i < vlen; i++, v++) {
>> +                       fprintf(out, fmt_str,
>> +                               btf_str(btf, v->name_off),
>> +                               ((__u64)v->val_hi32 << 32) | v->val_lo32);
> 
> nit: btf_enum64_value()?

Right. missed this one. Will fix.

> 
>> +               }
>> +               break;
>> +       }
>>          case BTF_KIND_FWD:
>>                  fprintf(out, " fwd_kind=%s", btf_kflag(t) ? "union" : "struct");
>>                  break;
> 
> [...]
