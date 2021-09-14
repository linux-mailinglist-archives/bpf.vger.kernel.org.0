Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAF540B586
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 19:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhINRBx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 13:01:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12063 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229719AbhINRBt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 13:01:49 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18EG1i3l016179;
        Tue, 14 Sep 2021 10:00:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cdSU9TccDd2coWeXF3VmFUbP9Yzqjp1QE7//TbAnZ8k=;
 b=aCKq2I1gc/EYNlSj1msC3pqGGgk5i76j1ZVrlv97/yaJyzCk+CSLr2117cTFCIp7Xcbh
 uBSStsBrtiaG8RXzd8QDt8rLtN5E4TcBTwUw/xMKxIPCojwj3sknRZvphsOaAHFtyQEt
 y0wSBqT86f6gjYc0fE9y0EB5QDXZjDviPFU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b2s332n0s-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Sep 2021 10:00:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 10:00:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTPgZvEN27eiD0sYJYQSDT8XbPSslSa/F6jZ42WJPknYPYK8F7kZ2m4tDuCnFm3IkZC9ec6mWOfW18Jow0/P1tg/WUDGG7IG7trTisnYWxRkXr32LPpBonW8lAXzLSAwiRDZenADWu9GS51ExW022f+Jq7R8pg2NJ1X7OCmD21rmFWHmKHkhA4foVxlqfP4GWyHSHlEsLmX2vtPNf0IjW3Av1Jp7CQOzglBuRLNbqTlvcucAsEi7qIuqIEjWXxBuiBkKqP95auHg1AI9bG3QLUt1SxhFvz8A6cXWn3Bk5mhqXF8i1vrO3Fwl7i09C4PoxNVSiEzd/mj+Oh93h2wt2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cdSU9TccDd2coWeXF3VmFUbP9Yzqjp1QE7//TbAnZ8k=;
 b=LNz6WiV5HpUpNf2Gr4giZFNYR2o756AHzo5bkZb+jcDa5gcbbNgQ9MRc9GxYW/B0HnN9ei1yxjQ2cCpRij+icgxgA6WInWWkUGsbGX5iUig4JuAeRU+IDcHxcuDEpVdun9ghlBy3B6TZfgH+9oIx3WQGG7nFvDTuWH2/KuGPWfZDM5IrplFzXGr4PtyhvtVsYQHqky6Wt6oP1pQYestZtI+DFyqpi46WacH+DSd2C6bLtXkkMxOI5j3wwcI1rLfTFi1kX6k0epkBynMTqDeYqW09pW1PJju6vNfu8f/NXnon23wEF9Ryedxk3pQtatKZtANoKPPNuDYUtnVnCfZUDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4917.namprd15.prod.outlook.com (2603:10b6:806:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 14 Sep
 2021 17:00:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 17:00:14 +0000
Subject: Re: [PATCH bpf-next v2 08/11] selftests/bpf: add BTF_KIND_TAG unit
 tests
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210913155122.3722704-1-yhs@fb.com>
 <20210913155206.3728212-1-yhs@fb.com>
 <CAEf4BzZ7_fmqro9HwaQFELbu=YJHtu-phYy=DBOhuXygrLfV7A@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <2c74952b-72f1-0f4e-2565-b835d59c5d41@fb.com>
Date:   Tue, 14 Sep 2021 10:00:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <CAEf4BzZ7_fmqro9HwaQFELbu=YJHtu-phYy=DBOhuXygrLfV7A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21cf::1169] (2620:10d:c090:400::5:6de5) by BYAPR03CA0003.namprd03.prod.outlook.com (2603:10b6:a02:a8::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 17:00:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7a38eb8-24fe-415f-d2bf-08d977a11f22
X-MS-TrafficTypeDiagnostic: SA1PR15MB4917:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB49172362DD44B4879521C1D2D3DA9@SA1PR15MB4917.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uAsYrfviCmFOpOa36mcD2UmDBCaoS0sketpEvfYMzsSIB3Zt7JZfbkPSQYwgYJ61DWwo6/Y9mSRfxD+7QopO6nLcLTDWvoJr15kXfK8SR/LHEWCwd8y4xDdueDyyS6EkEAFqYjQ3deCNNbA41NMCrfHQofpON+kxVStKoQ/4Wck+s2VybBvDzfe+cyYJy/oejPIZdllqPgfgvuNJkn8cz2RoBdu/o2cqoY5w2oBffHjDWvX7VzIedtz6aCowHejVexE7ztBWz3tsz1DxQ2pmb+DOioVxH0UzYAkAceZuC2vRDgEBTd0P76QxTZ6WsGbhE3c9L40XF8BoCl77KEapu4IRQ9yNZHn7OUbM6iNXz28wu5RuJNGKxF1X/+OTiiqsjeI9l0QdZEIMslPn76z1Oiei9ySx+1on7bqY0dDZpZcnKaRyUE3PLFzmUQTjeO8tgNvtufBVBa93tBxw+FnVd8l1s+pSfY2WpdrArFG7Nzi/TESweIZWVt0xCsTi2ixkre/RQnJ8d5gFCU+NOiacnb8mEglS0h8MgRau5iq0m7fdxwpcB9tQMxnTiHq7ywtGPrPv2qreJlLfqmxpNCNt3ykChkzQz9yymrt20ZJfALp2klYcYFxWqMdvqHgiQI0QSshpqGe3rLN5uOF7A7izGt93s9OUpwGB2Xfpy0YIkM9X95ICzm5Om3QU03NbS71/BnZ59Yo5f0iX8Ekh+yUUos/eGsxnSSY3xPwwkSiR1Ak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(4326008)(186003)(54906003)(36756003)(53546011)(2616005)(52116002)(5660300002)(6916009)(66946007)(38100700002)(2906002)(31696002)(31686004)(86362001)(316002)(83380400001)(66556008)(66476007)(478600001)(8676002)(6486002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlBpeUVYSFJ5N0ptYmU2dGY0ZW9WaXpQSHNSRTFlNjVJemZQV3pJTE1lREd1?=
 =?utf-8?B?SjlRQ2FMVzNPbUIzZHU4dXU0c2x0NUlxL0NaZUNENG5GK2pLQytoa05UdzJP?=
 =?utf-8?B?YUkreDBFdEdXQ3dxWFJSUEpqbHhKNHNUTlNkcVhUVEF1ZzFzWTArZjZOSXdl?=
 =?utf-8?B?R1NDZkFzUnRzWWVteHdZZ0FHMUVJeXVSbVJrd21UM0IrSTZQWVVBRUJuU0RL?=
 =?utf-8?B?SkVUTzJsWFlaQjl3UU5nNElxK3hmeGdPQm4zaHhYT3NCQXFqVUNkekViN2Qy?=
 =?utf-8?B?WERMQ1VQUUp0c1JKZzR2am5NelkvZDhYYllTZ2k5Wi9MOG5tTU5Id0NtMksz?=
 =?utf-8?B?Qk91K24zOFZzS0NhbkJMWndLakh1dTFJYTBUOFFmZDNGbEo2R01ydUdBcWYr?=
 =?utf-8?B?eU5IUUN5dzhjdmMwWUxJeU0yMWpQWUZkQkVXMUd2NGVqNTcwM2hka3RCSjVN?=
 =?utf-8?B?Sm9aQS9CSmwzQ01SMVBVTkU5WTNuNXVaMmdSYlhIZzFCRVRmK0V2RlA0Qmln?=
 =?utf-8?B?Y0FhWVZucWFPZW5UekxjVFk0VTdaMVpvMi9xU2RrejdCdmhXTDBOOU1haG04?=
 =?utf-8?B?UVA4RzBWSHluVE1UandUR3M1SUM5Z1lvRE1zNnRPOUV0ZVN4Q1gxQ0l2bjhj?=
 =?utf-8?B?MEw5SHVrQWtJSTV4T3oxbSsrUlA4TEd5QUdYVW1VTExlRjhzc0FKZjBscUhp?=
 =?utf-8?B?SEhNTGdQUWlBRW10QUtSRWlqVGRPeUhUOWJva20rTC8yNURnYm11S09zN2dH?=
 =?utf-8?B?Y05DVEh6akVHUWo3MFp3bnpHUnNxanZCMkdvVDFGVG0yR3NQdUVvc1h3U3FB?=
 =?utf-8?B?YlptRGI3MFJyQXdheTA5VUJ3ejIreXlUOVFZQ1NQZDNuY2h0TEFmRytIQ0FK?=
 =?utf-8?B?VEhmSmRCalJ5MDVzVkcybmJPY0lqa0ZBd2I3TWlzR0xHc0FFNXhyZTVtUkRH?=
 =?utf-8?B?S2FrOEl0Qi8wUU53b1dhVDNJUUVITytnNE1penBlQVpTVFlzTVRGalNvMUJV?=
 =?utf-8?B?TUx4Z3VKVGNncEgxdUJBcDVoM1EzWVQ0eWxYUXlsendiS2RaKzJRY3JLanFG?=
 =?utf-8?B?bHp1MjlTUUEyQWVhSWpNSGJ3UnhqK3lPVU82OFZ2NXhQS0VaekpNbi82c3Vl?=
 =?utf-8?B?V3FSRmIvUWVLeU5xblNKTnNzSHpQbXlwcWhpUVc2RWh1VTlzUmVqUDJaMXJK?=
 =?utf-8?B?QzJrYVpDR2hnVjhrSmNxSEM4Wmh0SXZTRXZPSUxFYWdoYlpyQWd5QzlHN3lL?=
 =?utf-8?B?ZUpNYThha0RidlhUeFBIYkRxTUxTcjZEWXVtUXVTaVArZkRJdzJpcWtBL0do?=
 =?utf-8?B?MFBVenpRbys1WmVsVHJoYUpibVhBT29pRHpIWjYyYXVkSUM1SXB1Tmk4SGQv?=
 =?utf-8?B?dHExTHRSYmZnd0JDV3IxL2ZzYk5DK2xEc045VU1kcmplOHdiM253emlSWTJO?=
 =?utf-8?B?ZTI5RjJ0NE1XWWRXR0M0RnZJQ2VlazZIZHVtM0I4RHBGVFg5RDh5MFc0eFRi?=
 =?utf-8?B?UEpHWWl6bkNKcFh0dktmcW9OdExWUUMrbTdpU0F5QW9tUitpcG5SbmE1U3dh?=
 =?utf-8?B?WHpka2FLR0VYdGVleG1ubC9lcmFxNFhzenJVNWFyNHNOeWNoSG1xaXlhSVFr?=
 =?utf-8?B?YTRiWDZKTkFNczh5OW40bXl1Q0kzTDJSZU82eWU1WVVzVm11SG9sYTRVdVRy?=
 =?utf-8?B?bEJSRjhBemZXR0d3OGN1Slo2TGc3Rk9FcmNGWnVsMGhtbytOVFNnU0FoRnlP?=
 =?utf-8?B?Wkt2V2NyTERKdlJGZGZNNVg1dUtvay9RUlhPdjRUQXNHZ09ITFZMd0JmeExs?=
 =?utf-8?B?NWVqQ2tEY2RyTU9kdUtHUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a38eb8-24fe-415f-d2bf-08d977a11f22
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 17:00:14.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCeuEinFsqynO4G1mPVrrawF1gd3XSxxSF3UdaTAdTmjPbEKW6tm05vMzTyhvyZx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4917
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: SlaP2AJp1t1ZAs72g5p7MGDwJPm6xIIn
X-Proofpoint-ORIG-GUID: SlaP2AJp1t1ZAs72g5p7MGDwJPm6xIIn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_07,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/13/21 10:31 PM, Andrii Nakryiko wrote:
> On Mon, Sep 13, 2021 at 8:52 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Test good and bad variants of BTF_KIND_TAG encoding.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/btf.c | 223 +++++++++++++++++++
>>   tools/testing/selftests/bpf/test_btf.h       |   3 +
>>   2 files changed, 226 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
>> index ad39f4d588d0..21b122f72a55 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
>> @@ -3661,6 +3661,227 @@ static struct btf_raw_test raw_tests[] = {
>>          .err_str = "Invalid type_size",
>>   },
>>
>> +{
>> +       .descr = "tag test #1, struct/member, well-formed",
>> +       .raw_types = {
>> +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
>> +               BTF_STRUCT_ENC(0, 2, 8),                        /* [2] */
>> +               BTF_MEMBER_ENC(NAME_TBD, 1, 0),
>> +               BTF_MEMBER_ENC(NAME_TBD, 1, 32),
>> +               BTF_TAG_ENC(NAME_TBD, 2, -1),
>> +               BTF_TAG_ENC(NAME_TBD, 2, 0),
>> +               BTF_TAG_ENC(NAME_TBD, 2, 1),
>> +               BTF_END_RAW,
>> +       },
>> +       BTF_STR_SEC("\0m1\0m2\0tag1\0tag2\0tag3"),
>> +       .map_type = BPF_MAP_TYPE_ARRAY,
>> +       .map_name = "tag_type_check_btf",
>> +       .key_size = sizeof(int),
>> +       .value_size = 8,
>> +       .key_type_id = 1,
>> +       .value_type_id = 2,
>> +       .max_entries = 1,
>> +},
>> +{
>> +       .descr = "tag test #2, union/member, well-formed",
>> +       .raw_types = {
>> +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
>> +               BTF_STRUCT_ENC(NAME_TBD, 2, 4),                 /* [2] */
> 
> this is not a union. Other tests open-code union, but it's probably a
> good idea to add BTF_UNION_ENC

This intended to be a union. So will fix.

> 
>> +               BTF_MEMBER_ENC(NAME_TBD, 1, 0),
>> +               BTF_MEMBER_ENC(NAME_TBD, 1, 0),
>> +               BTF_TAG_ENC(NAME_TBD, 2, -1),
>> +               BTF_TAG_ENC(NAME_TBD, 2, 0),
>> +               BTF_TAG_ENC(NAME_TBD, 2, 1),
>> +               BTF_END_RAW,
>> +       },
>> +       BTF_STR_SEC("\0t\0m1\0m2\0tag1\0tag2\0tag3"),
>> +       .map_type = BPF_MAP_TYPE_ARRAY,
>> +       .map_name = "tag_type_check_btf",
>> +       .key_size = sizeof(int),
>> +       .value_size = 4,
>> +       .key_type_id = 1,
>> +       .value_type_id = 2,
>> +       .max_entries = 1,
>> +},
> 
> [...]
> 
>> +{
>> +       .descr = "tag test #7, invalid vlen",
>> +       .raw_types = {
>> +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
>> +               BTF_VAR_ENC(NAME_TBD, 1, 0),                    /* [2] */
>> +               BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_TAG, 1, 1), 2), (0),
> 
> here you have both kflag and vlen specified, so it's not clear which
> one is rejected. Please keep kflag at 0 for this one.

Ack.

> 
>> +               BTF_END_RAW,
>> +       },
>> +       BTF_STR_SEC("\0local\0tag1"),
>> +       .map_type = BPF_MAP_TYPE_ARRAY,
>> +       .map_name = "tag_type_check_btf",
>> +       .key_size = sizeof(int),
>> +       .value_size = 4,
>> +       .key_type_id = 1,
>> +       .value_type_id = 1,
>> +       .max_entries = 1,
>> +       .btf_load_err = true,
>> +       .err_str = "vlen != 0",
>> +},
>> +{
>> +       .descr = "tag test #8, invalid kflag",
>> +       .raw_types = {
>> +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
>> +               BTF_VAR_ENC(NAME_TBD, 1, 0),                    /* [2] */
>> +               BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_TAG, 1, 0), 2), (-1),
>> +               BTF_END_RAW,
>> +       },
>> +       BTF_STR_SEC("\0local\0tag1"),
>> +       .map_type = BPF_MAP_TYPE_ARRAY,
>> +       .map_name = "tag_type_check_btf",
>> +       .key_size = sizeof(int),
>> +       .value_size = 4,
>> +       .key_type_id = 1,
>> +       .value_type_id = 1,
>> +       .max_entries = 1,
>> +       .btf_load_err = true,
>> +       .err_str = "Invalid btf_info kind_flag",
>> +},
>> +{
>> +       .descr = "tag test #9, var, invalid component_idx",
>> +       .raw_types = {
>> +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
>> +               BTF_VAR_ENC(NAME_TBD, 1, 0),                    /* [2] */
>> +               BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_TAG, 0, 0), 2), (0),
> 
> nit: could have used BTF_TAG_ENC?

Ack.

> 
>> +               BTF_END_RAW,
>> +       },
>> +       BTF_STR_SEC("\0local\0tag"),
>> +       .map_type = BPF_MAP_TYPE_ARRAY,
>> +       .map_name = "tag_type_check_btf",
>> +       .key_size = sizeof(int),
>> +       .value_size = 4,
>> +       .key_type_id = 1,
>> +       .value_type_id = 1,
>> +       .max_entries = 1,
>> +       .btf_load_err = true,
>> +       .err_str = "Invalid component_idx",
>> +},
>> +{
>> +       .descr = "tag test #10, struct member, invalid component_idx",
>> +       .raw_types = {
>> +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
>> +               BTF_STRUCT_ENC(0, 2, 8),                        /* [2] */
>> +               BTF_MEMBER_ENC(NAME_TBD, 1, 0),
>> +               BTF_MEMBER_ENC(NAME_TBD, 1, 32),
>> +               BTF_TAG_ENC(NAME_TBD, 2, 2),
>> +               BTF_END_RAW,
>> +       },
>> +       BTF_STR_SEC("\0m1\0m2\0tag"),
>> +       .map_type = BPF_MAP_TYPE_ARRAY,
>> +       .map_name = "tag_type_check_btf",
>> +       .key_size = sizeof(int),
>> +       .value_size = 8,
>> +       .key_type_id = 1,
>> +       .value_type_id = 2,
>> +       .max_entries = 1,
>> +       .btf_load_err = true,
>> +       .err_str = "Invalid component_idx",
>> +},
>> +{
>> +       .descr = "tag test #11, func parameter, invalid component_idx",
>> +       .raw_types = {
>> +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
>> +               BTF_FUNC_PROTO_ENC(0, 2),                       /* [2] */
>> +                       BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
>> +                       BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
>> +               BTF_FUNC_ENC(NAME_TBD, 2),                      /* [3] */
>> +               BTF_TAG_ENC(NAME_TBD, 3, 2),
>> +               BTF_END_RAW,
>> +       },
>> +       BTF_STR_SEC("\0arg1\0arg2\0f\0tag"),
>> +       .map_type = BPF_MAP_TYPE_ARRAY,
>> +       .map_name = "tag_type_check_btf",
>> +       .key_size = sizeof(int),
>> +       .value_size = 4,
>> +       .key_type_id = 1,
>> +       .value_type_id = 1,
>> +       .max_entries = 1,
>> +       .btf_load_err = true,
>> +       .err_str = "Invalid component_idx",
>> +},
>> +
> 
> please also add invalid negative component_idx test (e.g., -2)

Ack.

> 
>>   }; /* struct btf_raw_test raw_tests[] */
>>
>>   static const char *get_next_str(const char *start, const char *end)
>> @@ -6801,6 +7022,8 @@ static int btf_type_size(const struct btf_type *t)
>>                  return base_size + sizeof(struct btf_var);
>>          case BTF_KIND_DATASEC:
>>                  return base_size + vlen * sizeof(struct btf_var_secinfo);
>> +       case BTF_KIND_TAG:
>> +               return base_size + sizeof(struct btf_tag);
>>          default:
>>                  fprintf(stderr, "Unsupported BTF_KIND:%u\n", kind);
>>                  return -EINVAL;
>> diff --git a/tools/testing/selftests/bpf/test_btf.h b/tools/testing/selftests/bpf/test_btf.h
>> index e2394eea4b7f..0619e06d745e 100644
>> --- a/tools/testing/selftests/bpf/test_btf.h
>> +++ b/tools/testing/selftests/bpf/test_btf.h
>> @@ -69,4 +69,7 @@
>>   #define BTF_TYPE_FLOAT_ENC(name, sz) \
>>          BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
>>
>> +#define BTF_TAG_ENC(value, type, component_idx)        \
>> +       BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TAG, 0, 0), type), (component_idx)
>> +
>>   #endif /* _TEST_BTF_H */
>> --
>> 2.30.2
>>
