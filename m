Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9017D406FD6
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 18:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhIJQk3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 12:40:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53828 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229503AbhIJQk1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 12:40:27 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 18AGY398018510;
        Fri, 10 Sep 2021 09:39:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Nn0+HjHWlF39Y8S7yZ5rh6qtlMmyPPD76kJPU+N7Q5w=;
 b=bUAkZFEknMRfPkjKdFw0sMR5045c3hpbjDymTVBZjrNFes2lfzv2H7Fd++ZIi2+yzd3P
 wx8tyMGC0bdg0L9aE4L/pYEtDwgLL3hEDORSSm8ced8VqDvnQaP7u3vcIMZH6yvMVTqy
 p6i/4paomjvX0Mfr7U+7bjiIb7jWBdkOcao= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3b0agg0b4g-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 09:39:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 10 Sep 2021 09:39:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwKg0mzGYsOw1nB7ePqODHkN9QHR+3fIh2k2jH4uf39J4kE29ATRIP2sx9x9qXCmhJJg2+p+GFTMHcir6Gjy56EVi0Vv9jA6gE561U4wfdUpu5QSs34ChCQbMhyW9ScvfKBmehh0AVjaYDcWOZb9iLPcL0WTUlb05XmUO4nwJTP5UntCjgOxy+pQQAWrU34gd0fIo0Po+qYDkgIlOAM0eexwLzak8AWLms51FqhD7FGetlsvM4EXc8Od8akIidL47qnDFrMznUFQcZS9nvO6f4Ca112KLi7Bm/7LxAN05ggKix//h1xq6Btb+FkdrmNJrTOv19+3IytbgsEVHzKhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Nn0+HjHWlF39Y8S7yZ5rh6qtlMmyPPD76kJPU+N7Q5w=;
 b=DC15fOGMJ0cqzaeFl+ySTJSnzUW/ZEUXwczruiCR/HsegSoxiD1FLPvAodfOhTqEqpV850xR75lUT9ZTiL5HpNv5mQHmubQ0AICO94D3Fs0JeruMdQUkClC/WIjuT3WZ+IxSQ7eI17cGf92tvjAe2NzmN0uaznyL9j8ERoPxFJNVCpsRWz5htVHFH2K5GofHpq/uUfVrBjUfto9V6hf1RCd3Wcd/GFkX62GkmtceNKCumPutatocdUANS+WzQoHuZ7yKjApZMx0q0sTehebHD+u6R33nv5Xk0XzFHq+5pIb9IrYTtSTf/OYMq3raXS4GFOo/EvtzEu4gDFNzNTkvVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4452.namprd15.prod.outlook.com (2603:10b6:806:197::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 16:38:56 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 16:38:56 +0000
Subject: Re: [PATCH bpf-next 4/9] bpftool: add support for BTF_KIND_TAG
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210907230050.1957493-1-yhs@fb.com>
 <20210907230111.1959279-1-yhs@fb.com>
 <CAEf4BzZ6eX5GbV4o+4vz2whXyOQd+5_AaVEYn+uvR5=sV=aWZw@mail.gmail.com>
 <CAEf4Bza5SodxX+tU1jtjoAJW-4nZ7WvDA-7wVbTca7s8AkexFg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <5fef8e8c-4881-7973-4a4d-676fc22fdae3@fb.com>
Date:   Fri, 10 Sep 2021 09:38:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <CAEf4Bza5SodxX+tU1jtjoAJW-4nZ7WvDA-7wVbTca7s8AkexFg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:a03:338::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21e1::1064] (2620:10d:c090:400::5:7b93) by SJ0PR03CA0170.namprd03.prod.outlook.com (2603:10b6:a03:338::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 16:38:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0d2b985-2615-4d85-c31a-08d974797b9f
X-MS-TrafficTypeDiagnostic: SA1PR15MB4452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB44520453971699E6FB170B15D3D69@SA1PR15MB4452.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCfd5hceYyDltWlYuZVkDwi8jS2Y0c3bKgn6ra3ejd6nIb+KmWV+BRCYSagvu0WMTaGy1wHJjSAeRS2iloquX1zD+m2bd3JQHCkoHT0P8ISSP++HR6tKqaqIfH5wsYeooFz8Kyon0M3K+Ufdqepskc4r7tm4ru6JbqYcvtxGu8W2YMvgI8ET/AWercpznnFeDjxQSSr/qSKgZdY1m9iuP8HsATWFDbFadrA+TVlFECqOPQdK8h72ejtcc+Dy+fd28lnBRpBoeGOT6bJ8erGhBIwtnJVnIvYlSDvBxX4uAMH1znZxQEUc9CB/3YkFoxcp3VP6zClYIHgbYnDGV9A+HbgJQLEIPgLRmLp+3y/2I5/rOsNcPSYEW3KuwxdSMTK23A1yByij6QVD+1x39VJU/W9VymcsdQ24Jt3tbCcJSXibbKBD4+LQeyAa5oG6GvHjuivFYMFKGjBXv2RQb7M+WJ9M+ZQrJx40Y0gYc9JnrjYS5lTHjcF3u96hlT3A/1HSD52pGOpp+QyYJ5uz/TuxhlAhZfiDqdLrlI+eQFR3Xd4JA9PwIbytP6A+OSW3Ef9Nqi7GOAtMImaUMr4XeZmh/r7DTT67auUZVe7yJcKRKTpJoOMVY9OP8koyXEfxIMnkw17zbYCUnbYtrzk3J8y2TV78QNYURjNIBA2b9IkDDgFlap2KMXd8jNmb2Ew8QKXnzQfsATRdX4BKKEXRgvkq3weia25ZB99clnJk8YJKgTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66476007)(8936002)(52116002)(6916009)(316002)(508600001)(53546011)(186003)(83380400001)(31686004)(6486002)(86362001)(36756003)(2906002)(31696002)(8676002)(5660300002)(4326008)(66946007)(54906003)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1Z2ZEtqMXRQeEViYXdGTzVoWU5iQ1AyY01IUGRhdHBkYitTdGxGV09HM1hG?=
 =?utf-8?B?azhnMTloeEgrUWZWYklFUldTMGpCbHlWM2U4QlJqSjE5Z25IaHRvWEpCalBn?=
 =?utf-8?B?S0VRTElsSHBnckE0QjBjMjB2YmNwYmpyZENQSjlwQ3hWNGI3UTloYTJFdk5L?=
 =?utf-8?B?akhLRTQrQzJwVy9wWGJEeDBDSy9GOHVQWnJMTjFWRkVsU0pMOXkrenYzMmdi?=
 =?utf-8?B?NXhxUGN4U3RMZzY1NlVlQUExOHZKOVF6bG9VTDVrVDB3amtBNndBZnBoYnh5?=
 =?utf-8?B?S25RR015cTJuZEZVams0T2RWRjNYZW1rUzkvSjdmd3djSXZVaHV6YStldnVs?=
 =?utf-8?B?Ujg4bVI2WGZYM2dnWUN2RTJ6TXppZ2hDWWwxaEVvVEMxTHdad2VCcHZmSFpH?=
 =?utf-8?B?UWdIYndpc2c4dHB2aStLTEgzY1pGL2lBQllOM0t5ZS9sNTJpM3B5WU1xM0JC?=
 =?utf-8?B?SlBERkNoaTA0bHkzL2RqZGZIYldFZTlCbjNMbHVxNk9MN28zLzhySU82SnJU?=
 =?utf-8?B?Z3lkT0owRlJTTTFhOTd1ZmJmZlRyYjBvZkFNaUxFNFRocndYZU51SXB4S1JM?=
 =?utf-8?B?eVdyb0dJOGdGSjBLeENCVG5jL05VOEJxY0FXdm16WUdwYS95TERadHFlbHFD?=
 =?utf-8?B?bWcxT0lpNk53RVpjUVpSa1I0QitnbkZnZk1GalFLZjcyQUNCYlVLc00rY1dM?=
 =?utf-8?B?WXBLdEVBUkE3bWE5cmRhNjdTM3dnSktmVDJveTk1Y1R2TmZQcVdSR2YyVmpY?=
 =?utf-8?B?Y2d1MU5RUjZkV0lNYjBOZ2FaUHY1RWlPUE5RV2twbU1MeVdzMHAraWFBeTNQ?=
 =?utf-8?B?MlpnWmFVRE51Nk9ZcXlGcHVkQXFZT3dCUm5iQUZ3VytFL1plZ1ovcGNMQkZq?=
 =?utf-8?B?ZGEvVHdXTndkd09KNCtRMFg1L3llMWdMaitRMDZYMmwra2E1ZUhCRjRUT2tl?=
 =?utf-8?B?dHhkQTVkanVrTGozeVZnTTRwZUtoRlNOZExDd2pVTzBRRHliS3g5SW9PWGVP?=
 =?utf-8?B?SzJZblhQWHlLZWZDSStmc2hFcVRrZkVEZHBJemdjbExKU1Exa0tGOHd4c0Fj?=
 =?utf-8?B?SlFyUFBUemxXaTYxbTJiKzY4ZG9jMkxUaUZ1c2k1ZlFKd0NFbkNXQjU1N3FT?=
 =?utf-8?B?Z3pkMFRkcXlUc3hJY0YvK2hrQVN6ZDk4eGxDOGM1L1NrVjZONGVuN3BPVG1S?=
 =?utf-8?B?ZjBkUE5OQ3IvbnIvbWR5cjRXekNUTS9jemxKTlEyc3JCYmVDVnd4YU1pZWZ2?=
 =?utf-8?B?ckViRGFDSElVcGFIbnZkZkFjaGtlSVFFaXA3SXdLWHJkb0JhTkwwQ3J2NjhX?=
 =?utf-8?B?OURrQS83T3RsdzRjZlFsUktpdDVwTE01OWhvOEFrdDBINGViajN0VVlvUVpq?=
 =?utf-8?B?c2FWbUtWQitUY2RtdUhlSmp6QnBRajMyS0hUMU1qWXZnVG8zQWN5UDB5R1hJ?=
 =?utf-8?B?M0FkVkNHRmJZU3dkbnI4b2RhT3UxSThKc0lqbnZPQ0U2cjVEVXdQcXk3RWhL?=
 =?utf-8?B?OGU5anBIK2ZuMXpaRnFXanVXK213ZFRVR05hZWw0Yk5VQzh1bmdIM0VaQndp?=
 =?utf-8?B?WGxyUk9uaDE3N0hndGFQME1hTnVaS1ZpeGRGcGE4dW9vaVNKRW9yKzJUUGdo?=
 =?utf-8?B?K01QdGtMUFpFMDd0SEdMQkNWNHVPdWt0QlEzVW95ZjRlTEdoNlNaWS94aHNH?=
 =?utf-8?B?akVUZThFaXJQcXZxU1ZRRmdubE8xSENjbUl0dERpZElHcVZSbnI0U29SZTVu?=
 =?utf-8?B?OGsyaVNVN2dFUWpGUEg3UUp5c1hhU1RsR1d2R3MwWmpGOUFmb2FleTdBT3dJ?=
 =?utf-8?B?S0s0U3JESWo5bDU2Lzc5UT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d2b985-2615-4d85-c31a-08d974797b9f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 16:38:56.4797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1w7qgEg1aSluBLfa1sFYxTiBpLEtoBuj1KUzmLjFLojqTtqyP0j0MvOIk2jO/ti
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4452
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: NF4pic3ga45qgTJZrFZ35DIjHYOn0aMT
X-Proofpoint-GUID: NF4pic3ga45qgTJZrFZ35DIjHYOn0aMT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_07:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100096
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/8/21 10:33 PM, Andrii Nakryiko wrote:
> On Wed, Sep 8, 2021 at 10:28 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Tue, Sep 7, 2021 at 4:01 PM Yonghong Song <yhs@fb.com> wrote:
>>>
>>> added bpftool support to dump BTF_KIND_TAG information.
>>> The new bpftool will be used in later patches to dump
>>> btf in the test bpf program object file.
>>>
> 
> What should be done for `bpftool btf dump file <path> format c` if BTF
> contains btf_tag? Should it ignore it silently? Should it error out?
> Or should we corrupt output (as will be the case right now, I think)?

Currently it is silently ignored. The attribute information is mostly
used in the kernel by verification purpose and the kernel uses its own
btf to check.

Adding such attributes to vmlinux.h, bpf program BTF will contain these
attributes but they may not be used by the kernel verifier at least
for now.

So I think we can delay this as a followup if there is a real need.

> 
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>   tools/bpf/bpftool/btf.c | 18 ++++++++++++++++++
>>>   1 file changed, 18 insertions(+)
>>>
>>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>>> index f7e5ff3586c9..89c17ea62d8e 100644
>>> --- a/tools/bpf/bpftool/btf.c
>>> +++ b/tools/bpf/bpftool/btf.c
>>> @@ -37,6 +37,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>>>          [BTF_KIND_VAR]          = "VAR",
>>>          [BTF_KIND_DATASEC]      = "DATASEC",
>>>          [BTF_KIND_FLOAT]        = "FLOAT",
>>> +       [BTF_KIND_TAG]          = "TAG",
>>>   };
>>>
>>>   struct btf_attach_table {
>>> @@ -347,6 +348,23 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>>>                          printf(" size=%u", t->size);
>>>                  break;
>>>          }
>>> +       case BTF_KIND_TAG: {
>>> +               const struct btf_tag *tag = (const void *)(t + 1);
>>> +
>>> +
>>
>> extra empty line?
>>
>>> +               if (json_output) {
>>> +                       jsonw_uint_field(w, "type_id", t->type);
>>> +                       if (btf_kflag(t))
>>> +                               jsonw_int_field(w, "comp_id", -1);
>>> +                       else
>>> +                               jsonw_uint_field(w, "comp_id", tag->comp_id);
>>> +               } else if (btf_kflag(t)) {
>>> +                       printf(" type_id=%u, comp_id=-1", t->type);
>>> +               } else {
>>> +                       printf(" type_id=%u, comp_id=%u", t->type, tag->comp_id);
>>> +               }
>>
>> here not using kflag would be more natural as well ;)
>>
>>> +               break;
>>> +       }
>>>          default:
>>>                  break;
>>>          }
>>> --
>>> 2.30.2
>>>
