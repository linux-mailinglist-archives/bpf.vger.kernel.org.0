Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24392406E9C
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 18:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhIJQGN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 12:06:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48870 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229466AbhIJQGM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 12:06:12 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18AFxJ3Z001177;
        Fri, 10 Sep 2021 09:04:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Y5z/Qmk10nSFfyVcjr60ul6IEKJ95W4Idle7zVcVjbo=;
 b=TU8SwuNK8c8SdWaBC26T0+uptshpLEdNYjyjCIEixWTLBThB5JFm4k2lNlDSi5UwrU+i
 I7jS9vp2ztT+cgxhyq379LWGncyaK3pxVs+K+IxLyhQI4ZNkLj3xOkWI5zmUK809+V8C
 Ijh246YDXTQyC10Q6F5eudvAMngawuqc+TY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aytf2wrpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 09:04:48 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 10 Sep 2021 09:04:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhPqGV6uNCJy1BrRX49CPj+wOa6cHXuauHecB+XV+fvoZrB1zYnurEKquG4Kb4uttNiNKize9kHXuJyOOM73LdvLno6fTT+a4AJh1WOG53GActrVz9rxN0y3j2HvwdTTOoXJu7eVSJ689ylGl/N54wXIz9pUWbOtLjidx0SL1tDS47cdoRPXFnnOVTVlbEEJiauMqaQKH/6r+xAx7liPHLuwJo2KxeCWLc5lVdatqGehj0UZzskSF4IMPgBy64YbpCdPRvo0KP7Q8JNnlBIY1WqgV7khz4CVQe9lNBxumcGGWFjp/XKx4hccozyG3fjkNFRQJ+qJT0C1AyuF9znKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Y5z/Qmk10nSFfyVcjr60ul6IEKJ95W4Idle7zVcVjbo=;
 b=HSQcrNAE/XKJqJa0qm+UdzOLjKEJhHvA4zLYZziL4d2ggUOuBFG6FUNE8XM+TkV9t1WicwkYUPxRsnD8btzrCo+L7tNCOPtXuuWqW/S6FRZINTQ6fo4+WjqUnqvhhV+0b5CRTuNzkIOfT0oRoYCTj8kgkyDxRMusQzgEHrDgWXwMw45UFCzHuOwaSV0QgOsXJW+RQ1KK1yZRD59yi0lp1+4iv4EqVj0Bhxe6guOZDoOu9Rkz9h8GIfkSYnPFyEAYXmADVBwZ0NNXSvuch0C0GDEtH6vA2gkKujhZ1/132FjfZhnfexIf0xCw/7/tE4fr5c2TeZSxPssa9jjrTtIGdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2414.namprd15.prod.outlook.com (2603:10b6:805:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 16:04:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 16:04:18 +0000
Subject: Re: [PATCH bpf-next 3/9] libbpf: add support for BTF_KIND_TAG
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210907230050.1957493-1-yhs@fb.com>
 <20210907230105.1958546-1-yhs@fb.com>
 <CAEf4Bza5azi3mamL8geoCPJm-jxtKYsJ6+-Yv8uEg_pBkachNg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <d310362c-08b7-7c7b-c8e3-788ec56615b6@fb.com>
Date:   Fri, 10 Sep 2021 09:04:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <CAEf4Bza5azi3mamL8geoCPJm-jxtKYsJ6+-Yv8uEg_pBkachNg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0072.namprd17.prod.outlook.com
 (2603:10b6:a03:167::49) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21e1::1064] (2620:10d:c090:400::5:7b93) by BY5PR17CA0072.namprd17.prod.outlook.com (2603:10b6:a03:167::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 16:04:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e6e37a5-5c81-4a91-1381-08d97474a4b9
X-MS-TrafficTypeDiagnostic: SN6PR15MB2414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2414D1E23956770240FA1394D3D69@SN6PR15MB2414.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7l3NM/gsvE4Ao+qqGF+AFyp6GT2nkxC7L0VddtM02jzrcriuU48k13LXDE+w8Rr9Qvl7UQvjypeMeZESN/BpEWnQi5j0/nZ9AtNlO/MwcJPn8LKJF5Ms8ZUkpetybAZa5nokeA40Pud9Yhn/cMkEid2PvPpCxC+EqCZcODxPB9FMJYPIm49gI00cYsYOma3tsUPa3KPbhPTw7tg72LNK0vWXV5mrJEV9HR4Ts49WqtqIfTa/PxZv1mZtWau7H6H3YMF4pu6mpml3epUtK8qDfjyd7HnEe8y3ltBjlZ1Ur60dLCfWSsPhiDeZJZxO1IcmLCEzrG6JDneA3efuhmIlimgEcvFlYvO2TIqB/f+LEIV7eY1SxUW1p3mM11+HOzv7cxQuXxl251gumB8NO9p/8dGgSLWHnfiUlrxrhYVaLg+C2rJ5AZTY1JBI4cxIyL5KZggbQp2dmI1S5/n1aVMJjdfs+SS5EZwjWxqI8fu/jJr1ZhlifP4ee10WBJJ21MtgT3hJMtSw2nNy1uq8ioesxDXxzs9WET4nsVPSLDHCBnxmUbRsX1l92eUu6wT5OPc6Dh0KaGMRxVDO+9Q3fOYq36dIcfQpeNMOfU7q6VU0qrK3iO7t5ZaZFow4UDsWiWoDT9zueBC1xrh8A5wrN9jrrEtw8TcUGS89/T0Wkt8LQRn3Jdc7/P7YAc3qLku/RcOiukAWahTgcJuiAGhCtpULzZ34rnnoMCd4NXV7ZDxrlPi1vkUGCIwqWorO512x0T2v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(38100700002)(8676002)(66476007)(2616005)(6486002)(2906002)(5660300002)(4326008)(66946007)(31696002)(31686004)(52116002)(36756003)(186003)(54906003)(316002)(8936002)(6916009)(86362001)(478600001)(83380400001)(66556008)(53546011)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WS9DejhFRlN4bEpSRnQyV1hCSEZremxtZmNUT3RRQzZsLzM0Nm54QUswWURx?=
 =?utf-8?B?K2FhNzY3ckZKQTJKUDJLMEw0RVY0Tm9CZlJ0NjNjNlZFREhIZkFQTkhSMmJa?=
 =?utf-8?B?RlVZTkdFbE1ZT1h3NnhDTVpOMHpSSXdCcXhRZW5yaTZaOGlTZkZ2YzZYUHFz?=
 =?utf-8?B?TlNGcElDbmoxVHA5UXNQQjVCazZ3K2tvS3JsZTR0bGxCTzNmZ21DWlphaUxL?=
 =?utf-8?B?dWt0NzMyaVM0aUZBV2ZWcHpkd0lFamlFaTVoWDZRaHc4SUIvSk95YlRqRGV0?=
 =?utf-8?B?cngxRnp3OHN6SDVya3pEeHp2Q3FjUG1MZE1XTTFHaDhvcU90aGoxSEFVcnAr?=
 =?utf-8?B?QzBOa2tCM2ZvbWEyRDdGUmpVODg0cDJ0a1ordE03UjNtZXQra2JLeFdtbjYv?=
 =?utf-8?B?ZDJJdU1WajcxOVJCeHIzSmovTW9KeEExTTR4N3FPdUxEdkJzOVdPamkyNFc4?=
 =?utf-8?B?ZzFnTVpxK3phekVpVy9jV1dRZXBjbEFqRGo0cGxhampidVZ5eE1Ka05VU2pP?=
 =?utf-8?B?eHB5Z2U1L2hBL1htWVA1S0M5cDFkVFo1cm0ySHVkeWovZmRxcnExWnVadFpL?=
 =?utf-8?B?N2xDUWpPVHlETkYxTVdvNVN5NVgxblZkSi96YWEvRkcwdVBaaWw0UzZtSGJE?=
 =?utf-8?B?VzE5UGR6aklDdzlId1NISUwweEVVZkFvYTJ6L1RManNCUHdSWmRyMjhzS0dX?=
 =?utf-8?B?STdiVnVmd0Zqcld4bldHT1RWaE1pdnQ3UzB3Q1RuVU9GZFhrNzZCSnRDclVl?=
 =?utf-8?B?VWplT2I2WXdtMlJrRGFUUXQxMzZVdWhpajVrZkxqdlVsdzdselkvR3ZWa3pR?=
 =?utf-8?B?MENTdHByN2tsQ2NBZklDSjBQdXh3SytldElCdk9jQzF4RVhIRTBOVTlNdjcx?=
 =?utf-8?B?QVpjeWUxTkxDMzlSZFdFV1ZZcjNGYmRZemZDdDRGd2dsNkx5UXNnRHhmZ1FP?=
 =?utf-8?B?VC9nRDUrQnpyUFRTbExZU2FsUmdOUU93dG1zL0c0c2JwaGdzR2tIcTJ3Qk9P?=
 =?utf-8?B?WkM0Wlp1dGxPWmx3VmtEdWExbERBcVVUbStXc0ZWWStlbFJYTTkyNGlnNTZM?=
 =?utf-8?B?LzNKQS9taTRkTTUxQmg1QnRWSmh3WXFDWVZHUFVybm1xOVVxcWVJVFR3NktI?=
 =?utf-8?B?ZENGVDkxbjhNczhJeExJTGI4U2hPT2N5bFZVT2p1WUJmSEhzTWcrK3B6dHdz?=
 =?utf-8?B?cG14RStsM2FZcDhoaTNGTmVaRTZKcUsxZnpUMldwQkJkQU5rQ1FXTHRoS1d0?=
 =?utf-8?B?LzE2L0VOSWRsamplbU5Ubk9vdlFVeDZjaWxNV0FYNFc0Zk9oS29LdkcyVXVn?=
 =?utf-8?B?SkQwRDVTN1NFV1h0L0g2M0xtamJtQWU2L0cyOXN0aUlyRWQ1NzIzSHR4YWov?=
 =?utf-8?B?V3R5bkd1Q1NNcEJNUTVjclFqRk9YcjZ6blRheXpQM1pGVzJSdEc0dGYrNDdI?=
 =?utf-8?B?L0I4S3AxR285UE9jT3ZhOWNUMGx6RkE3WnpBcWxubTZ6c2hzL0FPeHBNS0pJ?=
 =?utf-8?B?ZS9BL2twVTdHdzJDL0UrVGNoYkJKcFlDODRBQWloUjFLOS8xT3FhU290dlEz?=
 =?utf-8?B?QzlHcy9GVlNFT3hCUVBtM09adEpyNk9ueXowM0JmbVZPSXdmOFh6c2U0K0ls?=
 =?utf-8?B?Nk5YaE9Mc0VRZEkrcjZuTkh6WHBSTG9TQ1FSeExWcXhuemkrV1hRRnp6Z2lQ?=
 =?utf-8?B?UzgwQldmWUhRdlQrNXJIRmlma25acnBTZkVyN2VvYzFucjViWjRPNkNOSFgy?=
 =?utf-8?B?RWh0dXRhNUd0SDZONGZJbUI1dTN5dmkyNytkODlNdEZMUEpCYnZaZVljL2ln?=
 =?utf-8?B?MXkzRXFzTFZoK3plbEZZZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6e37a5-5c81-4a91-1381-08d97474a4b9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 16:04:17.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeLqMQa7fWphnVxnlayjIibBB8x0jsy/MTYclyZQKmxm3HvOeRrXPpJQmR8MgrK9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2414
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Q_ZNwyFgSuPv8iGq_CHw9PRyCc4B559G
X-Proofpoint-GUID: Q_ZNwyFgSuPv8iGq_CHw9PRyCc4B559G
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_06:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100093
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/8/21 10:26 PM, Andrii Nakryiko wrote:
> On Tue, Sep 7, 2021 at 4:01 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add BTF_KIND_TAG support for parsing and dedup.
>> Also added sanitization for BTF_KIND_TAG. If BTF_KIND_TAG is not
>> supported in the kernel, sanitize it to INTs.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/btf.c             | 61 +++++++++++++++++++++++++++++++++
>>   tools/lib/bpf/btf.h             | 13 +++++++
>>   tools/lib/bpf/btf_dump.c        |  3 ++
>>   tools/lib/bpf/libbpf.c          | 31 +++++++++++++++--
>>   tools/lib/bpf/libbpf.map        |  1 +
>>   tools/lib/bpf/libbpf_internal.h |  2 ++
>>   6 files changed, 108 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 7cb6ebf1be37..ed02b17aad17 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -304,6 +304,8 @@ static int btf_type_size(const struct btf_type *t)
>>                  return base_size + sizeof(struct btf_var);
>>          case BTF_KIND_DATASEC:
>>                  return base_size + vlen * sizeof(struct btf_var_secinfo);
>> +       case BTF_KIND_TAG:
>> +               return base_size + sizeof(struct btf_tag);
>>          default:
>>                  pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
>>                  return -EINVAL;
>> @@ -376,6 +378,9 @@ static int btf_bswap_type_rest(struct btf_type *t)
>>                          v->size = bswap_32(v->size);
>>                  }
>>                  return 0;
>> +       case BTF_KIND_TAG:
>> +               btf_tag(t)->comp_id = bswap_32(btf_tag(t)->comp_id);
>> +               return 0;
>>          default:
>>                  pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
>>                  return -EINVAL;
>> @@ -586,6 +591,7 @@ __s64 btf__resolve_size(const struct btf *btf, __u32 type_id)
>>                  case BTF_KIND_CONST:
>>                  case BTF_KIND_RESTRICT:
>>                  case BTF_KIND_VAR:
>> +               case BTF_KIND_TAG:
>>                          type_id = t->type;
>>                          break;
>>                  case BTF_KIND_ARRAY:
>> @@ -2440,6 +2446,41 @@ int btf__add_datasec_var_info(struct btf *btf, int var_type_id, __u32 offset, __
>>          return 0;
>>   }
>>
>> +int btf__add_tag(struct btf *btf, const char *name, int comp_id, int ref_type_id)
> 
> Curious about the terminology here. The string recorded in bpf_tag, is
> that a "name" of the tag, or rather a "value" of the tag? We should
> reflect that in argument names for btf__add_tag.

We can use "value" as the argument.

> 
> I'll also nitpick on order of arguments. ref_type_id is always
> specified, and it points to the entire type (struct/union/func), while
> comp_id might, optionally, point inside that type. So I think the
> order should be ref_type_id followed by comp_id.

Will switch and then the argument order follows ELF file format order.

> 
> Please also add a comment describing inputs (especially the -1 comp_id
> case) and outputs, like all that other btf__add_xxx() APIs.

Will do.

> 
>> +{
>> +       bool for_ref_type = false;
>> +       struct btf_type *t;
>> +       int sz, name_off;
>> +
>> +       if (!name || !name[0] || comp_id < -1)
>> +               return libbpf_err(-EINVAL);
>> +
>> +       if (validate_type_id(ref_type_id))
>> +               return libbpf_err(-EINVAL);
>> +
>> +       if (btf_ensure_modifiable(btf))
>> +               return libbpf_err(-ENOMEM);
>> +
>> +       sz = sizeof(struct btf_type) + sizeof(struct btf_tag);
>> +       t = btf_add_type_mem(btf, sz);
>> +       if (!t)
>> +               return libbpf_err(-ENOMEM);
>> +
>> +       name_off = btf__add_str(btf, name);
>> +       if (name_off < 0)
>> +               return name_off;
>> +
>> +       t->name_off = name_off;
>> +       t->type = ref_type_id;
>> +
>> +       if (comp_id == -1)
>> +               for_ref_type = true;
>> +       t->info = btf_type_info(BTF_KIND_TAG, 0, for_ref_type);
>> +       ((struct btf_tag *)(t + 1))->comp_id = for_ref_type ? 0 : comp_id;
> 
> As I mentioned in the previous patch, it feels cleaner to just have
> this -1 special value and not utilize kflag at all. It will match
> libbpf API as you defined it naturally.

will do.

> 
>> +
>> +       return btf_commit_type(btf, sz);
>> +}
>> +
> 
> [...]
> 
>>          case BTF_KIND_ARRAY: {
>> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
>> index 4a711f990904..a78cf8331d49 100644
>> --- a/tools/lib/bpf/btf.h
>> +++ b/tools/lib/bpf/btf.h
>> @@ -141,6 +141,9 @@ LIBBPF_API int btf__add_datasec(struct btf *btf, const char *name, __u32 byte_sz
>>   LIBBPF_API int btf__add_datasec_var_info(struct btf *btf, int var_type_id,
>>                                           __u32 offset, __u32 byte_sz);
>>
>> +/* tag contruction API */
> 
> typo: construction, but I'd put it after btf__add_restrict with no comment

ack.

> 
>> +LIBBPF_API int btf__add_tag(struct btf *btf, const char *name, int comp_id, int ref_type_id);
>> +
>>   struct btf_dedup_opts {
>>          unsigned int dedup_table_size;
>>          bool dont_resolve_fwds;
>> @@ -328,6 +331,11 @@ static inline bool btf_is_float(const struct btf_type *t)
>>          return btf_kind(t) == BTF_KIND_FLOAT;
>>   }
>>
>> +static inline bool btf_is_tag(const struct btf_type *t)
>> +{
>> +       return btf_kind(t) == BTF_KIND_TAG;
>> +}
>> +
>>   static inline __u8 btf_int_encoding(const struct btf_type *t)
>>   {
>>          return BTF_INT_ENCODING(*(__u32 *)(t + 1));
>> @@ -396,6 +404,11 @@ btf_var_secinfos(const struct btf_type *t)
>>          return (struct btf_var_secinfo *)(t + 1);
>>   }
>>
> 
> please add `struct btf_tag;` forward reference for those users who are
> compiling with old UAPI headers.

okay.

> 
>> +static inline struct btf_tag *btf_tag(const struct btf_type *t)
>> +{
>> +       return (struct btf_tag *)(t + 1);
>> +}
>> +
>>   #ifdef __cplusplus
>>   } /* extern "C" */
>>   #endif
> 
> [...]
> 
>>   LIBBPF_0.5.0 {
>>          global:
>> +               btf__add_tag;
>>                  bpf_map__initial_value;
>>                  bpf_map__pin_path;
>>                  bpf_map_lookup_and_delete_elem_flags;
>> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
>> index 533b0211f40a..7deb86d9af51 100644
>> --- a/tools/lib/bpf/libbpf_internal.h
>> +++ b/tools/lib/bpf/libbpf_internal.h
>> @@ -69,6 +69,8 @@
>>   #define BTF_VAR_SECINFO_ENC(type, offset, size) (type), (offset), (size)
>>   #define BTF_TYPE_FLOAT_ENC(name, sz) \
>>          BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
>> +#define BTF_TYPE_TAG_KIND_ENC(name, type) \
> 
> following other macro names, it should be BTF_TYPE_TAG_ENC, no?

This is to differentiate the case from attr to member/func_argument
which is implemented in selftest test_btf.h.

But with the new scheme, we just need BTF_TYPE_TAG_ENC. Will change.

> 
>> +       BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_TAG, 1, 0), type), (0)
>>
>>   #ifndef likely
>>   #define likely(x) __builtin_expect(!!(x), 1)
>> --
>> 2.30.2
>>
