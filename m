Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A319F325D2E
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 06:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBZF1Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 00:27:24 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18288 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229449AbhBZF1X (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 00:27:23 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11Q5No6r020483;
        Thu, 25 Feb 2021 21:26:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=STo6ON1lNiEhTZXmtNz9O/cdqnFmlXP9Q2mB0sQsXHs=;
 b=oNpMPg3Ez7ib7uSG4jQGIa4O/98pXf+URun37z8jWJvBCvvhYyBEKZ7/L4gl62thv380
 rQWOgCroLhNnq4Qme1HLtH7GwKUnLlYnTBeUIg4jSvfTMu8RXEBFvUx3OViuZbiU3rdp
 RxSXzeeMRGzjd6vliCG7ZP2gC9mwCWawuzY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 36wncfv6re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 25 Feb 2021 21:26:26 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 21:26:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RChlXLKSY8HlaLglo8VxxQzUoBbJuclj10etJS+hJysbU5jnkeFQ5qD7xGnRc9FgSQy5bDsVILDzqxkY5aaKcWEyf8kFVgH3XCstVCC3F82NyHnpx3YJjKkpfuAERlpqHA+Rb98TJzJaf0o3Yb3o81/laENsJV1ibR7LB5h1SYqXGJyZB9T5spR6p6knN64K3HJHXVO75Sb4j6yaphzw/08DUhjvRD6CJdqRPXPtFME1Dkf0Nc6RE0jFiogDkMUKRiVDu7g8E6iMgzPLvPm0OBn4BGQ7WQnkPeCwj/hfVdXU/5GZV9AIBy3HT1Y45i6atnESbaHLu/5tNvnlr7zpfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STo6ON1lNiEhTZXmtNz9O/cdqnFmlXP9Q2mB0sQsXHs=;
 b=F6xSPy92JJ1ZBDdEFMPHDniRtqPa0QNdPrZDz+TCZHLRhwvrJtdpLEVt3FBJMPfQg8py0gYKt2SLW4o7MmtBQCeJOp+9DYFCgWtOI1VbnWjliP2iwkXcjkIj0DkfKRFtVGT4v+zxwSvlYFP0ZMYqYKrq/uEVke18pYvAodyERFT+fOUenwypJXtlzQW8tmVpZWGUDY64MktASaGWMuW2cUoBEHVVtg6F+JRmJTSCJZZ6NzG4vos0q0zFUXFAgEXh5GbIkD7EcpVv6yonbR5pbw5dXY9IZi9o9YPqpz3zD37OT5NG2jUIlO+2XyrxP6dK6KRE7qKiG6sV07WC7q1+AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4387.namprd15.prod.outlook.com (2603:10b6:806:192::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 05:26:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 05:26:24 +0000
Subject: Re: [PATCH v6 bpf-next 3/9] libbpf: Add BTF_KIND_FLOAT support
To:     John Fastabend <john.fastabend@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210224234535.106970-1-iii@linux.ibm.com>
 <20210224234535.106970-4-iii@linux.ibm.com>
 <60384f3e68e80_5c31208ed@john-XPS-13-9370.notmuch>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <43a94f4f-d00c-52ba-8060-86f0c2774ca6@fb.com>
Date:   Thu, 25 Feb 2021 21:26:20 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <60384f3e68e80_5c31208ed@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c091:480::1:1f06]
X-ClientProxiedBy: BL1PR13CA0480.namprd13.prod.outlook.com
 (2603:10b6:208:2c4::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11d1::15dd] (2620:10d:c091:480::1:1f06) by BL1PR13CA0480.namprd13.prod.outlook.com (2603:10b6:208:2c4::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.11 via Frontend Transport; Fri, 26 Feb 2021 05:26:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 808ceae4-bda8-4d75-8831-08d8da170ee1
X-MS-TrafficTypeDiagnostic: SA1PR15MB4387:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4387504A773426A52AF44904D39D9@SA1PR15MB4387.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utqex3ws25+obBUBBaCP7hiD4K9FV7x80ImuYOQ3+rbmSg5it/M6yNoa+qFAau2NVLfmLv2BRWUlZ+lk2sDFCngqIiq0+EbSBYLTKATfXUwOh/bnIzsYiOzF+70+uXgBASWWBocmvLLeOOy3a2OMeHul7cje/7y+TJ8uABHoHlpAxBZleZ9D6OFMEW7LPTxk2aML3uciahxvRR81rSaoljXLmytSlrSuUhJEE2mpxkHnCuaFiSeevC/ZtJwicjX69U7RjQZODZIFv1tXSNagiAzO2/lewYSwWPHKDVzVJ/I38K+DQKduoe3FHnVpHqtYHDKXa4WDlrdDRvct23pulLcj4Lj0FLiu6vZQ02C99da3PZwdL2iQxCH7M/aAqryeLQqWuwBr681gMf4oUM9QR/JxdzlOuFNRX8KEJCvzdOdCWJQiWF7kaiIhBdtZQtBXvb+TzBobnGFi1TB3LTmUMI7t/zCFMjL49GpU/zyjIFd0Ujdycn7y0ZG1NmHHjYrCer6EtAxSZ92uXXtnW7/lPvDzB7T6VgFtBAq0U1c5vDo3s/PZAPx1yu72YKByfzgQ5w0XZwlW+BVNiP12gwMRURlx7jZw9XaVePN/joaDtIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(366004)(39860400002)(31686004)(36756003)(110136005)(16526019)(186003)(478600001)(8676002)(31696002)(86362001)(66946007)(5660300002)(2616005)(66556008)(6486002)(4326008)(54906003)(53546011)(2906002)(52116002)(8936002)(66476007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M21XUUpWRGdDUjNWZkRLcDBMRkNiUFFyYU5mZFhkYWdGRGd3WnlQdkJlMzAy?=
 =?utf-8?B?d1lLZGptYnQyNXpJTUs0d3Z1L0JrWElDc2d4VW5SVG5qeFA3Q2libnhiN0Vv?=
 =?utf-8?B?bGx2ZHFZSUVORjJlNEtDNTZYWVd4cEM0ZE0wRTNZYi9CUytIUjdCY01VRDhp?=
 =?utf-8?B?aGJLZ0VmRU5wTFFwLytMbnZoYnZRT3pyWUtCZVZsbENPSzEyQ3VKU2ZDK2tk?=
 =?utf-8?B?ZVVLdTFtRXNCMEF6UHBvSXZKdUZFc2EyaFJKVHdtcHl5S0ZYVGttZysyT0wy?=
 =?utf-8?B?ZmpoQ2ZGWXhKUkRIeldKYlpJNm1ZMzNqaGRZa0FNS29ZUWxxT2ZINGU3Y0to?=
 =?utf-8?B?bFVjZU0zSHRZVmdpaDgzMXl0SE5hSk9jZjJNOFdZSTdITEl1R0c1VnpMK09H?=
 =?utf-8?B?Nm5lNnFWZ3hwSE5raDhaaE03TjJmVlZSZjhJRkRQQ29MK1FNc0tIWlJ3clEx?=
 =?utf-8?B?LzFEZVdjdHNWZmUvU3FwQW9GeUhoRmU0MGlTT0pUMmlHbnQwaXVNS3h0UVpv?=
 =?utf-8?B?OTlpQkJSMHgwWUJvdUZRRDBTdGMvcUZsQ0RwRi91MUZPbTlVQTBOSFlESnFC?=
 =?utf-8?B?cDdCeGhmN2ZoY2owM2U5TjRLRVNsdVVpdER3UWI5NDM2cVJyTW5weGY3dUJR?=
 =?utf-8?B?K0RHaWtzMFljc2JqVzQ2TDhoY0UrRGtpbm51NG0vTHNxa0VQUzNra3hiRWM3?=
 =?utf-8?B?K1Z1WjBzV2haTkFhTlk1bWhvYjY3bWVxQUU2WWZ1YXpOeTJJK0lQMmV6MUFK?=
 =?utf-8?B?SkJHL1VnRkVQZlRkL0VVdTREY0xxZHFHRzJDQmZ3MUloV21hQThEcWVOLzQ1?=
 =?utf-8?B?ZXVmYU02b1V6ZTVqYUdPMDhEekhYTHpJYURVL25zcmt6THNuRDVnc3dHb200?=
 =?utf-8?B?MHQyVm5nUURYOFZXMnIxY3g0elpJTnhpSVNzR2syTjJNRzUzMG52MllKQkc4?=
 =?utf-8?B?Y2lvWThMdk5iRk1WQ3Q1amY2ZEIyQ2xoV25WZHZLVDQ2ZkRJY1hCRGFSaXY0?=
 =?utf-8?B?UThxZzU2UlQ5Q3M5SUtzZVZpcGE3THFsQTc2T2plRFcxd2lHVGV6eWlTSm9r?=
 =?utf-8?B?Y1FzZDdvNVk0Qnc1S0ppWXlKckwxc0lZTmxHSTkrbFMxWHMxamZXU1NiTldz?=
 =?utf-8?B?K3hUZElKWTJneHFkdFQzSHdydXdUSlBnK2ZqRW80WkpqU3BQeVdwUlBSVUJ1?=
 =?utf-8?B?bDR5eDdtV2l5MGFWOTFKeitTMXA0NkRNd1RkQm40RGNxazdhNzhZNUMrSmpl?=
 =?utf-8?B?MndkYzA5NGI3dmthNnBDdGVtdERNMjNMMGJsRlpIcTJBMjVaaGxOb3NTcEFB?=
 =?utf-8?B?Nmtyd2pwRUtSVXkyTDJoUThhNkQvOXdrWEx5RFlGUFNCV1AwZFVoSmNOTE1K?=
 =?utf-8?B?MFFGNWx3aENaRC9Tb050NkJ4bmJQeUF4UDBMWWJKQXBUWDg0Zk5pRmVjbkpa?=
 =?utf-8?B?VzFOZytyVTRWSldSbldKOTlaYlVaUEY2Y01TbWVoQnNSdnJLUER6aHJpdDI5?=
 =?utf-8?B?eXNWdFJvaDhuWThEVzE0Qk1GdmoxT2x4L3B6aWwxcVlMK3VYSkRWZGo1N2xO?=
 =?utf-8?B?WUhCRzNCdVNUdFp3ZTMrejkxWW8xL1REWkNCMURjdVZ1czNNVnVpQTIxV2hP?=
 =?utf-8?B?VGp5anhOTmxIYjFEMUxzYmM0SHl5d0o4N0tsM2dyTDhrZW9zYjVDWFE0QWlk?=
 =?utf-8?B?dzB6Mi90WlJ5MmtONVg0QjMxMXJJRGt5dHNpM21vc25yeGcrYzRieTBpSjVN?=
 =?utf-8?B?eHh2VzU4aVZzQW5SZGMxMmM2Rm4xb05wbTE0REZ5Tmx2RlFpWnJBQ0hEYmpo?=
 =?utf-8?Q?VE+kbF/pgqUwDUnkPz3RMVs6frHvMa/rLCzf8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 808ceae4-bda8-4d75-8831-08d8da170ee1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 05:26:24.3248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlOj+bs6iBQy1v5KAoMmrZLJVoYjGcuIhW6hA/uXa//0Lmt2fCuRl0YemnDgcCqQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4387
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_01:2021-02-24,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260041
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/25/21 5:30 PM, John Fastabend wrote:
> Ilya Leoshkevich wrote:
>> The logic follows that of BTF_KIND_INT most of the time. Sanitization
>> replaces BTF_KIND_FLOATs with equally-sized empty BTF_KIND_STRUCTs on
>> older kernels, for example, the following:
>>
>>      [4] FLOAT 'float' size=4
>>
>> becomes the following:
>>
>>      [4] STRUCT '(anon)' size=4 vlen=0
>>
>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>> ---
> 
> [...]
> 
>> @@ -2445,6 +2450,10 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>>   		} else if (!has_func_global && btf_is_func(t)) {
>>   			/* replace BTF_FUNC_GLOBAL with BTF_FUNC_STATIC */
>>   			t->info = BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0);
>> +		} else if (!has_float && btf_is_float(t)) {
>> +			/* replace FLOAT with an equally-sized empty STRUCT */
>> +			t->name_off = 0;
> 
> Can we keep the name_off from btf__add_float()? Or just explain why
> we zero it here, its not obvious to me at least.

This is mostly to avoid type name collision, e.g., after sanitation, we 
may end up with "struct float {}" or "typedef char float[8]". All these 
will be rejected with strict enforcement although we didn't do it today.
Consider a rare case, users get btf from kernel, dump it into a C file
and then it may not compile...
In my opinion, if user needs any information, libbpf should emit them 
during the time of sanitation. Maybe some comments will be good here.

> 
>> +			t->info = BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 0);
>>   		}
>>   	}
>>   }
>> @@ -3882,6 +3891,18 @@ static int probe_kern_btf_datasec(void)
