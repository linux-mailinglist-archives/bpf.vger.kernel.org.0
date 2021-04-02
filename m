Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DE5352FDF
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 21:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhDBTmP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 15:42:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15862 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229553AbhDBTmO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 2 Apr 2021 15:42:14 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 132JeAOP031297;
        Fri, 2 Apr 2021 12:42:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=upmoQDcva7wKD2GzdpKWxxRikV4SN/hQXShavX4LDq4=;
 b=EN6/el6zj0brUzOqCEpXZCfPhXwULAoIyVlBmfyYlycwvOaBkI3FbZDj1VIWglKJ/chc
 a8xuxFt1bwizZVYpYJTa+XYyO5A1pJ67ZC8/tLZw+lokDbN4YlpYWoVnq3A+3gKJz1Ze
 b+263l0/A4O3N0KPHhO09HPqZJcj66o869E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 37p026bnda-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 02 Apr 2021 12:42:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Apr 2021 12:41:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjabzNNpSW53uNkfQ7D3UbcrUk0WI78eFVNqyZmN1/4c3rNjqDtz8GoDsFTE1uSSKVZjUO1LkmXGnlUZdiJUtKeRuFL7AvLpksNJbav88cFkgu4Qsrw7TuSYFLTFoiyEuuNrOAZoLrKD3h/Y/6qNpJaLT9/pyLHiW+9BxN4luH3RTpw4nDTilIlV6VqkZPce54UpozvGYeyZR3sqEgxq/44N/PqoA31iCV+oNghvQmwe8v8Bf4Nkz5BuWbJYL60WTwvGGsABi8cq2hNHZgAlGjOuLOWuVmdgMFPaDMMNQhtMPLAQUbIWRezKIg7YfHlgKXaLNN9XxtMZLSUyObDzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upmoQDcva7wKD2GzdpKWxxRikV4SN/hQXShavX4LDq4=;
 b=CHP6j5uuS1sGUTb1ZvgID6JX+S3O1PuT4ywx1hskoI5vtKaLsiVGiMNGHRIgL/MvSHClqPtc4EJvw1lonlM46GfNRhdcYdFpLgKFnzzMwByX3mzInCbMNAHnG5MKIrlmzB6ohZ7nG/oEhtOt6XbBG/UFZuPRXQ35xt3BfHQTE0Unrj/bb9Q81/hvmHVnl7cxKeBC2fra55BCKpJVF4kiXvXjPDvtkrbJjWSY3H+pYTBD90E/Ak3gaLDJBZPYPSwM2TlT+EQtQEX9+K//Kju9Tw1zFTW0MNROq0b0IxQ0TqxLmHDJOqMQPdif03CcMefpD60Bwm9tYwvaqwFZ+xyNCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3966.namprd15.prod.outlook.com (2603:10b6:806:8e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 19:41:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.027; Fri, 2 Apr 2021
 19:41:52 +0000
Subject: Re: [PATCH dwarves] dwarf_loader: handle subprogram ret type with
 abstract_origin properly
To:     Arnaldo <arnaldo.melo@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     David Blaikie <dblaikie@gmail.com>, <dwarves@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <jolsa@kernel.org>
References: <20210401213620.3056084-1-yhs@fb.com>
 <e6f77eb7-b1ce-5dc3-3db7-bf67e7edfc0b@fb.com>
 <CAENS6EsZ5OX9o=Cn5L1jmx8ucR9siEWbGYiYHCUWuZjLyP3E7Q@mail.gmail.com>
 <1ef31dd8-2385-1da1-2c95-54429c895d8a@fb.com>
 <CAENS6EsiRsY1JptWJqu2wH=m4fkSiR+zD8JDD5DYke=ZnJOMrg@mail.gmail.com>
 <YGckYjyfxfNLzc34@kernel.org> <YGcw4iq9QNkFFfyt@kernel.org>
 <2d55d22b-d136-82b9-6a0f-8b09eeef7047@fb.com>
 <82dfd420-96f9-aedc-6cdc-bf20042455db@fb.com>
 <E9072F07-B689-402C-89F6-545B589EF7E4@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <d4899252-af75-f284-a684-b33a7a12c840@fb.com>
Date:   Fri, 2 Apr 2021 12:41:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <E9072F07-B689-402C-89F6-545B589EF7E4@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:59a5]
X-ClientProxiedBy: MW3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:303:2b::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1466] (2620:10d:c090:400::5:59a5) by MW3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:303:2b::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Fri, 2 Apr 2021 19:41:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3fba720-02a6-483c-227d-08d8f60f5d61
X-MS-TrafficTypeDiagnostic: SA0PR15MB3966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3966B70709442A4B6A05381DD37A9@SA0PR15MB3966.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JYa2Wy4Y1MaQllmoEXihu2plcX20/4r4crC3OaY15wvfEOZcECn1jFT9pH1XaMCzSGVE9qJbzcdIUG1NTQoQO+nV/ddT7U1HuY2V2bpZoQ77EN2j2Yzh/Tjc6BlQhmx9+lbKhYUB8QviKYi+X/+KYyXvY/bRhqX3CK6rkN09OoiRPb4yFgCKvYdoFRm8Y4meE0g6pdZ+jLgsQLxFa5aoN9kqKqioK1562bN4e39SdN/I/wbHiMoLmoBHwCUa0iUskAY31W+N+1WfVPmqRZD9yPUL5B/pDUpp9Zbwqa/+WL9TTPmNTrjUgCdIJNRjWBvClHZi0al9LZ8tuXLO4HDrzxg5AJFP3AcAUMeXqeWbNXDdS9Dx652nL/fKGvmiwcARRICNF4OXiBbTn1gccFsBZSe9P8RL6/ZGFuHFEtVxadJxA/GytkxI9xkPZ8ce+A3vbQvPE4kc4x6SxyuBqaNJVN3sFwAxkfuLHrRoBR9zIw7cBE9RnBmlX/TH/cgF9yfN5faQwKfZkz5neDU75n8XX16Wn8NvEkvt/JvJHQ/DsXKV4cEmAynqg5p4MFzWddIA4WpyXjca1FNMIWxd7sEhYMLg/8qHcuHLVHgzPbmGCwc7Ej1LYBcGsjS5hkNjMHPz6h7h9CkM4FC98c7zt9BGmCIXuuhgaVCHUsHBIWj7hWHAKo2lyBK7nVfsZXxvon4Yeieet9wTLriPepTMMSglNord/axPLoOmHgvS+RYJuSU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(346002)(39860400002)(396003)(52116002)(36756003)(316002)(110136005)(4326008)(478600001)(53546011)(6666004)(83380400001)(2616005)(54906003)(2906002)(66476007)(38100700001)(66946007)(5660300002)(31696002)(86362001)(8676002)(8936002)(6486002)(186003)(66556008)(16526019)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?KytXTUlDSkZaTVN5ZmRPaWxxV1hJRlNxNm9ETURoZjViN1cvQ1ZaWXdVWU1B?=
 =?utf-8?B?VnRHNDlVVFI0d3Z1ZkEyMDBLQXJUVlN5dXJsT0lxT1o0cWtIc0gxL2ZCcUw1?=
 =?utf-8?B?VlhYODZERVFqMG0zbkpNZk9zUVJPRjVnUThYWXFZTFlnaVJMcUhnVkIxTWpB?=
 =?utf-8?B?T1MvSjhrRzNqNEhqR1g1b0JYQmY3MDdIQWVWczc3dHg5SksvOHlkWXUwaEto?=
 =?utf-8?B?bVdjajJFUjBEK0daSS9PVlovNExlTll0ek9vWGtzMzJ3ZVZTU0FiUGg1MDZv?=
 =?utf-8?B?b1JtZmtpTEl1MXlJaWNoVUlwb1Y0ZHJpa3NPcmYwS003UDFQKzZQRWRNVnZD?=
 =?utf-8?B?T3MwR3MxaGduc1MwOHZXRXQ1RkphYkZtellscmlrZXFsclZ0dlI1QjVvNzZJ?=
 =?utf-8?B?Z21yK2haY20zTm5NL01HUFkxZzB5bnNWTExvc05JSzFSRWlXcHRLZGhjRnpz?=
 =?utf-8?B?Y1ZteTR2OWRYemx4MGZwYkwxcTVmVmk1MFI4WVBrNTJ3bk51d0hqM1hrNEUv?=
 =?utf-8?B?Z2p3dUFWU1M3MVZ6NWZOOFpxTUQxME5NMUxmcVZGOERqakJxWUJ6RTd1bEt0?=
 =?utf-8?B?T0Mza01nZHZvQVVjRTJUTHFhbWl6eVU5bDdQcnFFWkNEUVhDRkc5SHI1OEpY?=
 =?utf-8?B?TDZralNqRGpYTlZJTk5EcnYyR3lreEJXQlJ0R29KakIyOEkvSko4S1dJQU1V?=
 =?utf-8?B?N1IzRXJKc0dMNjg2SDNaYzBKeHoxSDB1Nytyd1FEUlRJandOK01JR2tIWVlv?=
 =?utf-8?B?YzdYaTVtNnlka2NkSUkyUU5uN3NzWEYwaUxTYlpYN2tnZzQ5NXg2dzNNakhu?=
 =?utf-8?B?MVhZSVlwa1FEd0dhMmYzSTZUYyt1WWZpT0RqQkdSVDJ0QXZjN2ZaWHRtSXAr?=
 =?utf-8?B?YUEzWWdYSVhuVC9PMlpvZGo3a2hWM2FSenFINkxodmlhcmsyTUk2SDdPbVpZ?=
 =?utf-8?B?Mm5NU1Bvd3F2MUQ3bDdGU0VvZHN2b2VHZWx1LzBodmVCVTRHYnp1cDU2V1l1?=
 =?utf-8?B?VkkwUVJUOUpoVDVuZkRtaWFIMlpXRWt3VitRNFdObFo0L0xqV1hpOUsxbEFT?=
 =?utf-8?B?OHZSQ2hDcllRUDcxMERkaFRTZVV3a0RLc25vMWV1OEU1MVZBZDdua0ZVR1FB?=
 =?utf-8?B?cnUxc2pGNTBJN3Y5QlgvQVpPcTJYTTBncG43emlPVkFoZUl6bHJrdGhlZHR2?=
 =?utf-8?B?akw1c1BGeDcrMHR0Zjd1QUYvbldlVlJPQk9vdHZQNTR2VUZBcm5Ca0tPVkwx?=
 =?utf-8?B?b3RUb0oyRUloMFVxU0huNytHM3lCTEpWRTViYXZNaDBVNEJaSGdxaDdJVFRF?=
 =?utf-8?B?ZjlnTTZhTTQ5U21WdHJPcDNXTWp3VU9MR294Qlp5U3loUVBFdEluYjRTQjBQ?=
 =?utf-8?B?aGp0Rmpxc1Z0Yk0vOUpVdkovbXZMR0FEc081Y0hCZ1FLb3FtMGp1S2l2TEVm?=
 =?utf-8?B?a2htVWRlWUdTQ1JZVm03dlgrS1FCazZiWFZudHN5Q3N1VDR6LzRnMkc5c3dQ?=
 =?utf-8?B?NW1PWEI1WXlvcE9OUTFVVXRyQm1YWEsyWGphb2V6QjYyTXdSR2hsMWx6eWds?=
 =?utf-8?B?RE9OdmthSGZDWWNoUjVpeS9PWFFGWVpsYUpDczg1dlBCRzdxM1duTU9MVmdT?=
 =?utf-8?B?bWV4Qmh3RmhHd2tDa3Q5SmpoRlZRVTV4N3QrVTRLQ2xzaFNINEpKTWRxQnlr?=
 =?utf-8?B?dGZwVVpLZFJjWWdXTTEvQzYrWFlpRStsL0JjNDN4U214WS9rQ3NJRUx0N1Er?=
 =?utf-8?B?c2xVdnd2MDlCWEk0cjZnMWRIY2IwTitJdXVhWVQ3Vlh0bHZYR2tjVVQwV3JP?=
 =?utf-8?Q?813gWgQGWiMlW2RW5TNQ82ppp0jH9SoxGBRs8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fba720-02a6-483c-227d-08d8f60f5d61
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 19:41:52.5234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8Tj7x0of4Z68MF1JFd1wT6/7hVpyoosBuRPzrOKQQEzhDzNLleT6Te4SHYPKRB7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3966
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 646F9_YlrH39oS0yRwnNckNtlMoE3VAv
X-Proofpoint-ORIG-GUID: 646F9_YlrH39oS0yRwnNckNtlMoE3VAv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-02_14:2021-04-01,2021-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104020133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/2/21 11:08 AM, Arnaldo wrote:
> 
> 
> On April 2, 2021 2:42:21 PM GMT-03:00, Yonghong Song <yhs@fb.com> wrote:
>> On 4/2/21 10:23 AM, Yonghong Song wrote:
> :> Thanks. I checked out the branch and did some testing with latest
>> clang
>>> trunk (just pulled in).
>>>
>>> With kernel LTO note support, I tested gcc non-lto, and llvm-lto
>> mode,
>>> it works fine.
>>>
>>> Without kernel LTO note support, I tested
>>>     gcc non-lto  <=== ok
>>>     llvm non-lto  <=== not ok
>>>     llvm lto     <=== ok
>>>
>>> Surprisingly llvm non-lto vmlinux had the same "tcp_slow_start"
>> issue.
>>> Some previous version of clang does not have this issue.
>>> I double checked the dwarfdump and it is indeed has the same reason
>>> for lto vmlinux. I checked abbrev section and there is no cross-cu
>>> references.
>>>
>>> That means we need to adapt this patch
>>>     dwarf_loader: Handle subprogram ret type with abstract_origin
>> properly
>>> for non merging case as well.
>>> The previous patch fixed lto subprogram abstract_origin issue,
>>> I will submit a followup patch for this.
>>
>> Actually, the change is pretty simple,
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index 5dea837..82d7131 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -2323,7 +2323,11 @@ static int die__process_and_recode(Dwarf_Die
>> *die, struct cu *cu)
>>          int ret = die__process(die, cu);
>>          if (ret != 0)
>>                  return ret;
>> -       return cu__recode_dwarf_types(cu);
>> +       ret = cu__recode_dwarf_types(cu);
>> +       if (ret != 0)
>> +               return ret;
>> +
>> +       return cu__resolve_func_ret_types(cu);
>>   }
>>
>> Arnaldo, do you just want to fold into previous patches, or
>> you want me to submit a new one?
> 
> I can take care of that.
> 
> And I think it's time for to look at Jiri's test suite... :-)
> 
> It's a holiday here, so I'll take some time to get to this, hopefully I'll tag 1.21 tomorrow tho.

Thanks for taking care of this! Right, 1.21 looks very close.

> 
> Cheers,
> 
> - Arnaldo
> 
