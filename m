Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A68406E9D
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 18:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbhIJQGY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 12:06:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18576 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229481AbhIJQGX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 12:06:23 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 18AG11wF007985;
        Fri, 10 Sep 2021 09:04:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=zFMcD1ZWHAr+Ri2QPmCcK1/I0mB/jIaoCVggj6ljLnc=;
 b=JGLl5krSSqXkP74Nff0gMLMf0UXuSUqzua4dPrfElfW73rvE4zwj57+E4uxcVcnMTzUH
 VKjy3y4n1Kv99FLDLxEH6w0FRW/dGTbNGATjOVxMqGjbB3nrGwDOlAed/y+62MOOmzF2
 152ncemEm8TXE8AxLlp+qHs0duXLuqSTmxw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3b0agg01ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 09:04:56 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 10 Sep 2021 09:04:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4g4wYa/ld/4uAm6y7f5yZE3/Y6M/K/uaiaGp39hD0qZ+aI55nI7++mAVoai8HI3n8DjJgWSCaTEB04cw97A+ghwebJk30pozCqw0Ay4WFQ6uCeg/NpLiTnHOFmSP+CDxHlKo4HVPpQhxtqdThuH/LiHtcwCqy4wbnJ2Dw0ZW1CnSXDJTuRddul7xMH1okOBBQS1mc/K1XP2cK6y246V7IjGqxhJYCqwwH6gzOLxqAweYAAC48ecK3yAlswt2kk4vnNQuGluRxHIki89XWLGEVWsVk3YMFWDfvx8sNCBMvHhqH0TPZwP/J49Ws3ei0QN6Md1Snqq4zOZRnGSSzTIsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zFMcD1ZWHAr+Ri2QPmCcK1/I0mB/jIaoCVggj6ljLnc=;
 b=UGYrfuMj/47YAR3q0j3u3GOkvOmawGhrfSgheDjU5r22XLtRsNUo3VqTeB8TnVVRHWvm0sjTgHR907pd9ddBO3/mLpM+0lljzQYMT049thxW4JPUf34Z7GGv4tw/j7MJfYQwZudrkbuVbjbTMPh2uldo48YbmNsz4MZkFE9dOXbqq4JISZGsm0t/SYFyzaJMyjkJ7IH0mB1Y84yEUgX8fZ4rFSu4VDYrO6hez+r4bPeeNR3+Ra/org1ACfcyYX10t5TQYm5xSt5PtgykgbYnJlidnkIGRyu7ywyxIsUWiZdPJt0i3uMa2nrYUvk2wypphIXYbFmAvH9KcOgrP/EEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2414.namprd15.prod.outlook.com (2603:10b6:805:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 16:04:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 16:04:49 +0000
Subject: Re: [PATCH bpf-next 4/9] bpftool: add support for BTF_KIND_TAG
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210907230050.1957493-1-yhs@fb.com>
 <20210907230111.1959279-1-yhs@fb.com>
 <CAEf4BzZ6eX5GbV4o+4vz2whXyOQd+5_AaVEYn+uvR5=sV=aWZw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <665f0ad9-78ca-23cf-daf9-b2a8099f2ed8@fb.com>
Date:   Fri, 10 Sep 2021 09:04:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <CAEf4BzZ6eX5GbV4o+4vz2whXyOQd+5_AaVEYn+uvR5=sV=aWZw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0063.namprd17.prod.outlook.com
 (2603:10b6:a03:167::40) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21e1::1064] (2620:10d:c090:400::5:7b93) by BY5PR17CA0063.namprd17.prod.outlook.com (2603:10b6:a03:167::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 16:04:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c40497d9-ec67-4d6e-e417-08d97474b756
X-MS-TrafficTypeDiagnostic: SN6PR15MB2414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB24140D6BBC598F2C95EEB44CD3D69@SN6PR15MB2414.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YvOH6Ng2/GSwnFMV3DuevmenbEW9xONTGZPKakJkj76hB0AwL0f0w7BadNyu4TdbSBtUHuAPnFdVWch0RGWatw5+qPVaTPox21dHXIPHIrkLtcAo6002fW5QpmzL3R7UigDVtjd6SCSZmr3a88Bsb+1tcO+wsiNCNXufk/G8Qo/d+zCvy1bMfY3ofYBX8L3eY5NIGFJrvD4bDtHgeR4+DMwf/jmJuYoCOZqsrrTKrcfl5bMGekRsYZmCTwuaToDUPZYbfl9HcDf6pHlrmzST1OmVaSzi137R73MGfN/F5FEZK5cc8HRROlDFjzXgvKeue5eukGoMgJaUwijSG5QG32CiApJiv++QQHQhbsggpbHWwdT/MVdS9fcJo8Q3tCulk7VutUQsQS+Q7Za9GMPqh1Q2laKRhY0x4hr5O6xzBqrMmtjfYlce+V0Wxwbi8/gV1Ommf/KQDxKHUe/+zTOHhnHQGxBzkcnVkf/sjt/hG5IPYRv249V8kntE5IQs3DlI5Zw67minxwU/M1eh7DSOcSaS1MT6N5K+JfxxaSROmJ8CLJmnxmWWdWGvEKdHfNm9ajdRy8D95ESyU0oHx9S/xvSUqbAggL8HKzIGA2ZPdukVYVEI3LKc1ke0RfR3WjCt7CiYC4GpMh5LCFxCykFX2o13CMMTH+yQSUioZi6TXGmldFhPoZFWeR+u3TygF3fYQlFgEp+/zs4UINqQhdKX/nxV2lML+Ny76BWPKMgcL/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(38100700002)(8676002)(66476007)(2616005)(6486002)(2906002)(5660300002)(4326008)(66946007)(31696002)(31686004)(52116002)(36756003)(186003)(54906003)(316002)(8936002)(6916009)(86362001)(478600001)(66556008)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZURWUFplTnhJQTNjLzlCbldhK0hHTm5kT2JYUWpjYjc5ZEFlemIxNjdLc1Rw?=
 =?utf-8?B?STFZYk82SW00d3RRZEZGRnVqVDdNVEJ4bnpYNCtEamxla3Z3NGtXa3lDd2FV?=
 =?utf-8?B?Rm4rQ2RtRkpSVnEzOThkOE5zK1orUllQdHVNczIycGpvVURiU21tZEdQQzhC?=
 =?utf-8?B?NjNFY3lsUWY3enBkR1RtanFmZmYrOVR5YUg0Y21lRkpPb2hBdy8zcVhDcDdv?=
 =?utf-8?B?eHJlVkorbGszWWk1djI1VFZ2K0p1RW8yZFFGRWxJL0RzZHVYbHFLa1dRczVl?=
 =?utf-8?B?aVhzNDE5Y1JOSldJb29yWDg5dWxnaFdMd1hmOGN6V05ZQU5vd3ByZ0RjWit0?=
 =?utf-8?B?aXYvTHdyOEl6cFVOamtVTk5EaXppQjFSb2Y5NjVyL002a2dydWRwTkdCbHJt?=
 =?utf-8?B?a1lzK3pTdkdoTDRQc1RTLzdjWStPZThpdlZwM3ZRd0p1Vi9qNWN3eUFUMExl?=
 =?utf-8?B?dTYycGZ1VWhaUVNyRXlUZFJ6VFZueFBpY1NXeGk4VDFQaVF6Rm1FODloZHhH?=
 =?utf-8?B?M2dxVTJHMnNOemorZ0lWVEdGUEFnWVBMaEJOZ0lBYXozR25iM1ptYUs2aWVs?=
 =?utf-8?B?SHZsVEpYaHN6N0xUUWZVb1laR0UxU1R6dXJoN1NMNWhhUS8wT1V3WUlSbXZz?=
 =?utf-8?B?dHJQcUF6bjQ5UllGT3dLMm9DRXpsU2NlUEZCWElEaVZwOXJpN1JFN0x2dEhB?=
 =?utf-8?B?ejFYK2dDSWpnRjQxQ0E2SHJRZmI1UHlaT0VmNCtIcjU1cndWdzl0eTBhc2FG?=
 =?utf-8?B?SEtxQUVIb0xsL0F3UHZWZkdWU0pOUUh3enJnT290K2h0Wi9oZy9WRVZSSy9a?=
 =?utf-8?B?cDljdHlZYzVNMXRZMzBJWTdwUnExcnpmOHp4SGpNMTRoblNjbFBNdzIyUVFR?=
 =?utf-8?B?QkpDRWNiYmZ0NU9RUjF6blhTVTRSU043QzVKWEh2dXRzM2tRb1lFNW9VV2RE?=
 =?utf-8?B?d291OTJoYmNhbkN5S0gvTjZhS3VWdDNUNXR5MG9CS0oveUxvTHViN3RVczJS?=
 =?utf-8?B?V25zVFEwQlJhMmN0ekp1cU5pNkNoaWc0eHNqR04wSWhlOHBHT2NwMXpqY3I2?=
 =?utf-8?B?b3VQd3NiT3dFZDJBekJZSHVOQjF1ajd6SEUxQkZkYVlQVGZOSEw4UVFBZFVS?=
 =?utf-8?B?ay9RSU5kMXZ6M1RQRUZ5cDZWMTlITTdMYmt6azBsR1piNnJBUlpIeW9UK08x?=
 =?utf-8?B?aCt0WFJCbktvdERKV1RIb0JPRHdpK2c0cjlBSkNHaWRPekdFY1pjRmhEWUR6?=
 =?utf-8?B?Qk9GeVdhSlloMlBTcTlhK29DM3lqb3VQN3dKVHdTNU8wMlZBMXI4R3hYUWNn?=
 =?utf-8?B?a3JpVDN1eU8rdDB1YnphRUZPSE1kNzdGdCsvd085dDlSa1R6dFk1SUw5NTEz?=
 =?utf-8?B?dUJNVXhJVWhMYzl6blJSVkVZVHh6SWtyTXphMHc5OERrQ3V6TnNjTmJiV3VQ?=
 =?utf-8?B?Z3o0V3dsdHpJWDlzZTR1aFFYSWRBV2hidCtEemFieUtLMm4rdjFJUDNCd2pZ?=
 =?utf-8?B?ZkFIRkVHWUdQZ2wySjhqb3F4bUZSVHZ6ZlFIUisxa1N3UFJsL3Q4Q1ZDaXBk?=
 =?utf-8?B?Q1JEOUdOTHlsLzBCSURiUU52Sm9SaHpkUkZxb2ZrZ1ZhQklMMUYxQTVZRHNx?=
 =?utf-8?B?YTUvQkUrKzVZV2EyWVp3ejJ6aDlhWC9rN0ZQSVJIWXAyaXNSUkdjTVhqOXlO?=
 =?utf-8?B?aWVOT0NFOTcvM2gxUWM3ekpFWDlhaXMxdXNpZFRjUHByaVA5akozVVQ0Wngy?=
 =?utf-8?B?K2tUSDZpWi92T3JTNHFSOENIWmltN1pUaThLTnVwVGlpSnlOWmhJbTYrTksv?=
 =?utf-8?B?RmhCNTV3SlNnZ2RPVzMwQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c40497d9-ec67-4d6e-e417-08d97474b756
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 16:04:49.1788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYT4rgGWzjGrIHa/boRS0vfvNnEv3nqAZOubwgt5Qtyd8hzb+tbI19rsf4bTwYS2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2414
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: qpfCywRMzzWLx-yVsi2GiXnedo0rjI6G
X-Proofpoint-GUID: qpfCywRMzzWLx-yVsi2GiXnedo0rjI6G
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_06:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100093
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/8/21 10:28 PM, Andrii Nakryiko wrote:
> On Tue, Sep 7, 2021 at 4:01 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> added bpftool support to dump BTF_KIND_TAG information.
>> The new bpftool will be used in later patches to dump
>> btf in the test bpf program object file.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/bpf/bpftool/btf.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> index f7e5ff3586c9..89c17ea62d8e 100644
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
>> @@ -37,6 +37,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>>          [BTF_KIND_VAR]          = "VAR",
>>          [BTF_KIND_DATASEC]      = "DATASEC",
>>          [BTF_KIND_FLOAT]        = "FLOAT",
>> +       [BTF_KIND_TAG]          = "TAG",
>>   };
>>
>>   struct btf_attach_table {
>> @@ -347,6 +348,23 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>>                          printf(" size=%u", t->size);
>>                  break;
>>          }
>> +       case BTF_KIND_TAG: {
>> +               const struct btf_tag *tag = (const void *)(t + 1);
>> +
>> +
> 
> extra empty line?

ack.

> 
>> +               if (json_output) {
>> +                       jsonw_uint_field(w, "type_id", t->type);
>> +                       if (btf_kflag(t))
>> +                               jsonw_int_field(w, "comp_id", -1);
>> +                       else
>> +                               jsonw_uint_field(w, "comp_id", tag->comp_id);
>> +               } else if (btf_kflag(t)) {
>> +                       printf(" type_id=%u, comp_id=-1", t->type);
>> +               } else {
>> +                       printf(" type_id=%u, comp_id=%u", t->type, tag->comp_id);
>> +               }
> 
> here not using kflag would be more natural as well ;)

definitely.

> 
>> +               break;
>> +       }
>>          default:
>>                  break;
>>          }
>> --
>> 2.30.2
>>
