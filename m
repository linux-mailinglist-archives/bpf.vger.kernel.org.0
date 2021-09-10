Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3CF406FD7
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 18:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhIJQko (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 12:40:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53148 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230142AbhIJQkn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 12:40:43 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18AGaNuF018185;
        Fri, 10 Sep 2021 09:39:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4/JDVenhxUGSEaCHiI4962EaiJBbEU48Gt/uyncjbkY=;
 b=pw1CXd0RJWzbu49XsMOmpoyzpDb1Pcg9DnCn8S+kDrlF3gcuvWvEEo5Ii3w3GLFGHk2W
 N+s1xM44c+v2g6FRqxc1JVW5BsUcgmog08SsixmV9LU10QRRHo9cmZa2u5WWN9DAh7IV
 HH5248WHbzWSvEEJ5UcGTkUHinyAX/1pFVc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aytfff7x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 09:39:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 10 Sep 2021 09:39:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTcU7CC3sLsq9uNXdx29Dhv4/EnCAP+doyoTtUB8wxFH3AjdhgPlD1Iy3pXWdX2WVNQnBjkL3Wjv2qhhNxzSu2LKOxqXGOy3JW8ECShFsOenLBDuwj4ojE+Mlz2rEEWBpPDhQ0A5CPQgsFju506pzHqm5RfStEw6LSfi8Ym6bBueJb/gEYkNv/cqI/yuzJAHHzPQC1+BY3dfJeObgxeNmSiFZL8uE6KbbKNYWLFNNXX85Q83A5uSQ8xIJW8mPqmGKodGnKFXkjX/gSPGD1WriVx2LZpUN0g1YblBPPBobnP+IyRcKBMY8cM9Ue4dELBWo/sMz/Iw+72W/XWj5EvcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4/JDVenhxUGSEaCHiI4962EaiJBbEU48Gt/uyncjbkY=;
 b=bvTVpN/CysfSI5sQrqKFB9211rWfuyNUxsf2tr2HIbLofQQP3FtZEaFG9QNitN5Ref2TAVGrpRJECT70HRVagZEQXFVT8KGW9pTQ4ekjtVgeMpVAeoUj/HfCR5FYEQgKWpchmAOzzWjtHdouJMbFoY5zLGxvETUlDftGeBPt7etvuq7n+krTjYO6dfwb1tLcEEjl56GOIRkYbhWdzR73ZC4NWc9PJfAHFIuVrnyNwhZok4l4EFmWqKV3OaTaHbyrdWu8lwPfdo9J9c6pl8QR5xeWoOrypJWHV9agbAYT+U6x8L9EjC/p/K/4fWB135BGmD3AnmgXpuAU17tSJ/VfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4452.namprd15.prod.outlook.com (2603:10b6:806:197::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 16:39:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 16:39:18 +0000
Subject: Re: [PATCH bpf-next 5/9] selftests/bpf: test libbpf API function
 btf__add_tag()
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210907230050.1957493-1-yhs@fb.com>
 <20210907230116.1959597-1-yhs@fb.com>
 <CAEf4Bzbyf3qnsypUF0CQNO16advVtZ=seVAthwoeN6PfQx8tWQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3488ce1d-a7f4-8959-1bc9-d520e66a630a@fb.com>
Date:   Fri, 10 Sep 2021 09:39:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <CAEf4Bzbyf3qnsypUF0CQNO16advVtZ=seVAthwoeN6PfQx8tWQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:a03:338::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21e1::1064] (2620:10d:c090:400::5:7b93) by SJ0PR03CA0159.namprd03.prod.outlook.com (2603:10b6:a03:338::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 16:39:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6328b28-38a5-4c3e-fe1d-08d974798877
X-MS-TrafficTypeDiagnostic: SA1PR15MB4452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4452CF3F875FB7F75F5D1837D3D69@SA1PR15MB4452.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d8if9ETjz1O/TORfv/S8rhbnPDCBDST5QJcOMXBFJ7CBB0gJT7bsX/VLnfiwqVmV7UxYnLmyLLzlIE2NuaV5/d4s7E6Sk0ShPQxAwI/EOD/QACEC6IcDhNsayJ7rAmt4SssPsy3nvhNIOHIpq6FzuOgm0Cec31HgjSybqMlh4/HHjg5UpLWJ7JYcn/wYEwaL3U7UmWLx+UmeTsE6ZGUmXQ6cxwCremsY+7w8rrQEqZ0tR3u7/Q/0sVU0BzpRTMurX/+f8CcqYGUlhcQiFb0WyolFWbQVrbxBPU3aE+XBqJEDTnuP2fJ5L0YhJFolyP94wI4yqH7fxw4Nwyrnh4DCVEVTXD1LXfiqsDx3cYeBKehBAmdSu6mxOnuff7uXjO+1hapDGxzVLc4zr3rK+c6z5MUXcaNqSCd2Ya7HXgcUCIKraoaO5MfP4Hl6/+IgCw9zKDkXyJ7elSQ2u6BCn7GlzbOYxTUnRbk4LQjYa2UvYQ5jSj/OnBzfTil+Owe15ojquKRvF25/d60WxuqSHa0HN6rgaK8kkemTKuJJgULVg0neqycdSFj+iuAP2o+YiyI/UKW0rEAXmlxnJ7qJx/5EZ0fJTCOE2oTL9rYV6J+Giiu6cpSMCNFBA01OxAnHS+b8mzhf5oUWj3Sp0BTe3ZTsX1zXJG9hmsbyQbpuP4l0dJ7k9259nvb3ALYXIM/Zcb24vSCv2plIqADIkWodPwDgN0Y0+l4/cGkPFqgOXBfNTy5GEw4mZFnssk4psmik1a71lymHRb69DK2xoYILL3TCxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66476007)(8936002)(52116002)(6916009)(316002)(508600001)(53546011)(186003)(83380400001)(31686004)(6486002)(86362001)(36756003)(2906002)(31696002)(8676002)(5660300002)(4326008)(66946007)(54906003)(2616005)(38100700002)(101420200003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akFyQkVLT3o1aEZxQVpCb3pwVnR2a3AxT2ZPU2RYcTZOSmpFNmc3bkE1NFlC?=
 =?utf-8?B?RGQzdnZPZjRkL21pTGhPcHRPcHc1cXBCbVRQVzg5c1YzRjQ4Nzdnb0JFUG5Y?=
 =?utf-8?B?bkNGWnFDZmc2NkJUenNUaFdkYk85bXZXdkhId042WTdkckZjK1hHTmc5a01O?=
 =?utf-8?B?Nzd0emMzMDd0V1pYdGJZK242WUtsWXRkOUhXTDE0TklpaWsrQzd1aTVENkxh?=
 =?utf-8?B?cy9OUHlYN0xPa08zQ1l3MnRXMENtU3VoZ3FjU3ZiZ3V0emttS1QxQU1GQ1dV?=
 =?utf-8?B?KzVBZUVmc2tPMjVFR3JnUVJJODRMVE1kdDlQcGRSOUxQenVVcW1QbjNENTds?=
 =?utf-8?B?NXlPRVh2bVZFTy9NNTZnQ1kyVzRQSDRKYlhpTmpzaFhqYWFrMnNEUi9xMlRv?=
 =?utf-8?B?V2FKdjIvRVlNUTFEbjJqa0dSWFd2MGdsNEg3V3hYVXFFVDFWQWhTUDM4ejVk?=
 =?utf-8?B?d0k2cUZBOEFtdXhMMG9ybUFhbFdlZHdHWW9PNWFSTGd5NmhqUktVMGVFd3VO?=
 =?utf-8?B?NHRPQm5qZFFJZlB6a0JwRzhGNmY1MTVnWUhmWllzeE5wbjVoVEprLzJ2bUh4?=
 =?utf-8?B?QXhmMjZ2ZmJYQnJ6WkVuRXVzQ1J5RmUzWkJWYjRjRm54cWVLcDA3NmF0TWtt?=
 =?utf-8?B?bUlFZUdjdG1NdXpMKzBrd0hpaGRXN2plOFFQTGlyaGdyQXJzT3NNN2xsYTFJ?=
 =?utf-8?B?VENaK09kcVBKTGphc2tRZTVGeEduMWJNMjRaZCtudjc1MGxuWFFJS3RpbXU3?=
 =?utf-8?B?UkIyMEtxRThzRU1FVnNpY3VYMTlOUnZ0ZnRTUWtVNm5jTW02TlZLbHhncWUv?=
 =?utf-8?B?RUkxQTZFUTVlMXBXdnV6MGpINHk4K1JsZzREdG9lQ0x5cDM0U3ZYQXlUQVVh?=
 =?utf-8?B?ZTdMbGVhaTlBdzYyTWpmZzZIZURIQlNIWkEwU1B5VFVSQXhLWGZobG0xU1Vk?=
 =?utf-8?B?MUlQNFcyVU5NR0lPd0lrUFUxaE5iWW5jWVR3MEdRa3ZuUlFaRDg5clB6WTY2?=
 =?utf-8?B?ZmZoWkZtTFl6c1JNamdJRVZoN0ZZMDlBOWYvLzJUK3ZWUlNyYWgrSUQ1T1VM?=
 =?utf-8?B?Ykx5RnZ2MmZKRjY3dFJVVkU2RHcvQmkxZDVCajcybnA3YllkUVFsWVFyQmky?=
 =?utf-8?B?b0Jnak54Tk1xd1BseGgzZ2crMS9kWGtrRjg5VnRnL2x1VzFpakFKdjdmVHZH?=
 =?utf-8?B?SFByUnhZZFU3OU5GQzk4Umcvand0Y3hNREp1dXhMKzg3WGRZZjRBK29VNE5s?=
 =?utf-8?B?d0dFZFZYRFdxRjEyNWlBREEyS0l0RFg3SHpMNG1HMGFJUWFzbWp1R2Y4a2RV?=
 =?utf-8?B?dXZxQitLMjhTRjUwNHVkdUFwTlZhQVl6YXhRZEVzZ0piWWhqZDZRQU0vZW9L?=
 =?utf-8?B?RnhvMFhjUEswb1ZWelFzOTZPN05nYkdNbTZ0dVh1c0c4WXYxR3c5cnl1NEMv?=
 =?utf-8?B?dTVJZmFpV0xTTFN2Z0dsRXVYWk5GSFExOVZXTjBrT0FZN2RpOHhsZ2lxRHNT?=
 =?utf-8?B?V1BXaGpyRmp6QVNCV0dqMEJ3eElhUE1rakZ1N0hTa3AyV0p6TmNIYml6TDUw?=
 =?utf-8?B?M3RWL0tIbmN6MldaNUNxTzZ4ZmRTN25JVDR5NzA4VVIydHB0SkJEYUtEZW9C?=
 =?utf-8?B?Z25MTVEyRHFTejNkM3M3UGwyQ3MwekNjQThPNU4xT2crdFNzSG1YeWhmbUhT?=
 =?utf-8?B?OXFIeFFqaldrU2Rvdzd3eG4yekZ2amcyLzFFYk5yVVZtQTNwZkV0ZGtFOEJ6?=
 =?utf-8?B?ZnV1RkZSMUNHODNCUEFEMVJvdzFMKzhFRTluKzlvSU01NG8zOHV5b01ZY001?=
 =?utf-8?B?dkU0U2M0UGZCOXM2MkFqZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6328b28-38a5-4c3e-fe1d-08d974798877
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 16:39:18.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQyebims3tZW6LFBXcCVYTSaCyCUZeV4yqXPWdyFitWNJ/BLH4f95WL9e/P9T5VO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4452
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: KSTvWOs8Uoxi-ivF_Zwla68Ghrl833-V
X-Proofpoint-GUID: KSTvWOs8Uoxi-ivF_Zwla68Ghrl833-V
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_07:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100096
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/8/21 10:35 PM, Andrii Nakryiko wrote:
> On Tue, Sep 7, 2021 at 4:01 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add btf_write tests with btf__add_tag() function.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/bpf/btf_helpers.c     |  7 +++++-
>>   .../selftests/bpf/prog_tests/btf_write.c      | 23 +++++++++++++++++++
>>   2 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
>> index b692e6ead9b5..20dc8f4cb884 100644
>> --- a/tools/testing/selftests/bpf/btf_helpers.c
>> +++ b/tools/testing/selftests/bpf/btf_helpers.c
>> @@ -24,11 +24,12 @@ static const char * const btf_kind_str_mapping[] = {
>>          [BTF_KIND_VAR]          = "VAR",
>>          [BTF_KIND_DATASEC]      = "DATASEC",
>>          [BTF_KIND_FLOAT]        = "FLOAT",
>> +       [BTF_KIND_TAG]          = "TAG",
>>   };
>>
>>   static const char *btf_kind_str(__u16 kind)
>>   {
>> -       if (kind > BTF_KIND_DATASEC)
>> +       if (kind > BTF_KIND_TAG)
>>                  return "UNKNOWN";
>>          return btf_kind_str_mapping[kind];
>>   }
>> @@ -177,6 +178,10 @@ int fprintf_btf_type_raw(FILE *out, const struct btf *btf, __u32 id)
>>          case BTF_KIND_FLOAT:
>>                  fprintf(out, " size=%u", t->size);
>>                  break;
>> +       case BTF_KIND_TAG:
>> +               fprintf(out, " type_id=%u, comp_id=%d",
> 
> seems like we use space as a separator, please remove comma for consistency

ack

> 
>> +                       t->type, btf_kflag(t) ? -1 : (int)btf_tag(t)->comp_id);
>> +               break;
>>          default:
>>                  break;
>>          }
> 
> [...]
> 
