Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB104314909
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 07:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBIGnX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 01:43:23 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6952 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229521AbhBIGnT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 01:43:19 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1196N9ir030712;
        Mon, 8 Feb 2021 22:42:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=EhZdTBVbTdLKWG2BvgZNcLZEboPSL/jid6ThWM51PaY=;
 b=lBeWD8B6SlBQvbuIpm9fMfuHm2zuEyPFi7kdy/4aOKVChLbqgEauCi4edaCfX4tKJlPZ
 JaQAMH3WwbEwZvOAc2A6l5Njk/ZY4RhVUR+ZRGsNx83DHsDDUqa5vpBKNuWab/xLEj7/
 TWX+hwonKaJhGUXJaoXj0HbP2GpwIel/YTk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36hstpc1gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Feb 2021 22:42:25 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Feb 2021 22:42:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LS3lFI6apLLeUp8Y3S0L8C8O+bEu+h8+xyfQPPHwqJgusGoDpsRpYjodVj3tUJbGq1PS0KXr7ssi/n6pBLETItIKbqDt4xUGZ7TOeeD+7UMxXZloPElgjjrogD0Cg6fhXrHBkUVeSA+KD2dki+HejCnYUJeSG2zTeIJnHabO7ZklPu65J9rJU66RK33uitwasGybF2QArwv998AKLrd++h+6VW8Vmid+OSNbphsuBxH6hlPpblaxaF4xZeZLPfUtFxwB0ZoGaKHkIBLDQ8AWlcUlDgMgDm9jcYanIq5yfMogvV9nHfICc3FP0z4/JhYvXpYnkN6b4z5qSZO45Y856A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhZdTBVbTdLKWG2BvgZNcLZEboPSL/jid6ThWM51PaY=;
 b=kolveWvAXG3P/r98V0uDTCmEtgWfJRfzy7T+my5lf0WtVEUUlPbOSKC2PBJW53ACUF8wKy3bUeDDXMnMcGh3dBnVeJKoBuf9da+HQPdgU40d6f+lQRyE/oNt2vm1Z5uaT4zShmGXlP2xO/pG4rd4KJI/f8B2o3rNO1/aqt4OUzhFudTH+Z/RiHkpQVBIlg++2F58VGZFzHz/XcWhSHiSlgyRrnFPilAzm/yv+61Pw7JClS6Uab49wTfOE+eJ7qLnpDMXUsAQPUVDhFEFrz592l8rf5or/WyGHXjNFijdyFxhegagtvmUI6eDEcMVwvR0PVZOYQOPiVGaCt9IapJiUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhZdTBVbTdLKWG2BvgZNcLZEboPSL/jid6ThWM51PaY=;
 b=gwtJfYStzigRS5FPhy8IxWIGtWd5s7VSv1DdyBxG2cxezkoGucb3+EO0Nnhu4WPW2+Or2fkZUvdTvtFWuTRugmSo/yn79HZALYHriZThlG1AOxwwP4t5ESRLVj++on+Z3e3QkMZbhxbJSxyXaINb892e0jmZc6s9VecOsEPXQp4=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2694.namprd15.prod.outlook.com (2603:10b6:a03:158::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 06:42:22 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 06:42:22 +0000
Subject: Re: [PATCH bpf-next 6/8] bpftool: print local function pointer
 properly
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210204234827.1628857-1-yhs@fb.com>
 <20210204234834.1629568-1-yhs@fb.com>
 <CAEf4BzYC27CGJKuWWRmbKGUBoGhkFiftT+omyD9bkbT3wub1vQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f88e66a3-6456-180b-b5f2-1655fbb998ae@fb.com>
Date:   Mon, 8 Feb 2021 22:42:19 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAEf4BzYC27CGJKuWWRmbKGUBoGhkFiftT+omyD9bkbT3wub1vQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:e222]
X-ClientProxiedBy: MWHPR22CA0015.namprd22.prod.outlook.com
 (2603:10b6:300:ef::25) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1610] (2620:10d:c090:400::5:e222) by MWHPR22CA0015.namprd22.prod.outlook.com (2603:10b6:300:ef::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Tue, 9 Feb 2021 06:42:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14b0b1a2-6cbb-44c4-f5f2-08d8ccc5dab4
X-MS-TrafficTypeDiagnostic: BYAPR15MB2694:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB269489CBE62224ACDE7BA6F1D38E9@BYAPR15MB2694.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mdAm4IXML2+lZjB3gsm5wqYiXZnpYge1SdRKN4iyGOqdV5d5QJGRP9ZT7N1CZJAQ+ecEsLvxjev19P+/P6/sDNd5QlwyFrHimIzNC/sjw3FllWEUgtX7Yg4hQBTCM1SFAia1IWjSHlQ5YcEbhCZO+mPEn4878lIPPDixSSVFdxWTw4WFGwh6P2IfFiP+j4W/tMZqsN43qM5wA4LicTLi2PHqk7WyT4wps2n+Mhw1QXQj7Rh1olDoYSoOHs90bWfHvCiIhBGvS92JyYYMEczNwSUNsTu3nwESuV9sbuDPYyotznduQPVZsYqYfj8LDaEMzdj85O3K0gpd3RJAFbvE9Yx7P2KssZdzpOmZ7xqRcOCCrhfZ4RcevgtcL+PSGt1RewjKrbUJduLa2afo64RdhLcrRd3vuJdwDfj6yMXTeq6+ET11oBRJQf3CiFBZQToIdcvHpU0pwKcxXqa3HHabgiyoVRBfETobU0Bg6nzjrjRaATBYDuC+EBWtl0GcGtIG2dNtHHlAnxujvljr169flEK05E1WElbbdMsMTlBRvpibUl7qPywXBLRTpTmtDA4Qcntr0TC+rEm+8cve8YD+1VGSYgHDShQQv/J5jkWoIo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(396003)(366004)(346002)(5660300002)(54906003)(478600001)(36756003)(31696002)(52116002)(316002)(8676002)(66556008)(86362001)(66946007)(2906002)(2616005)(8936002)(6486002)(66476007)(31686004)(186003)(16526019)(6916009)(4326008)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MUptM2pWelRVMnhteDVDeUtQV09pRHVuUDZIME10QVFYLzhzZGE0Y1k2amdx?=
 =?utf-8?B?UTV1U3lheUI1SUpZN04vV2dOZ1F4T3UvQUNYeU5CL3M5Qm5scy9VYXlGNHFY?=
 =?utf-8?B?YVFKTW5aNzRGMTFWRkYzblNvVVZ6MW8zdkFIQWw1dXdjYUJ2SUdMVHRpVTJh?=
 =?utf-8?B?YzcrSDdnK2FxSUNOcXE0RVNRT2lXUW50Q2VGbU9JYlg0YW5kWmQxRU5OdE1s?=
 =?utf-8?B?VlVVWjA2MmQwRVliSDhEUCtST1pqTnZaWUczbVVEUmhIMkREdzc4NkxkYjNp?=
 =?utf-8?B?N3BWVzR4SklkOUVET0lHaEFLa2prNDE3Zy9iODhvVFN0UEJUWVM2VVZjaExX?=
 =?utf-8?B?cjFhVGJMamo2OCtEeUZtVWpValA5ZXdzVStEejhjSEUzZ25vTVFBUGxZZ0Rr?=
 =?utf-8?B?dTluVnpoNXZSZHdwSjRUMnJwMVFNSWZhZHBzcVp5bmxVT082M1Z0V1RmKzRx?=
 =?utf-8?B?ZFlZS2syR1dYaTlaNXBRQ1Q4NUpGYXVIck1oVS9QYnVBMUtMWTF0ZHBUdjE1?=
 =?utf-8?B?MCt3K3puSGZyWnhpYjF1d3dNL2phZ2xDKzZwczU1OFJCbDV5UDRhTnNyc3BJ?=
 =?utf-8?B?dHBYcGZVblVISVdLUng0MTRRZS94Q2FXSnUxQ0gxdzdoK3pOYis4Ni9GWEFK?=
 =?utf-8?B?OUxxVVFVU3REQS9oWE9YV3VCTnIxQlVsQk5waUNkM3B4M0tqakZ3WXlqYjNS?=
 =?utf-8?B?ZVRibHBNUUI3Wk1DcFhEN3RObzVBUzJiUUR2K2RBcFg1UVdqMW9PNGZzbkEr?=
 =?utf-8?B?YmVuRGNOMEpHUXRnVlhxVUQxZEhaQnRiWmVseTh2SVBRL0p6d1d2UEtZWi8y?=
 =?utf-8?B?aUQrd1dKUEVOeDh2ZDJ1eEs2Y3FTWVRRVkhFZmsxcFV0Uy9oQkVNRzBCTmpX?=
 =?utf-8?B?ZkdqOXY2Wlo0SmRmeHZhdGxhSk5GVXkvNjZibmxaUTlTTHNNNXluazhZT050?=
 =?utf-8?B?T0pUSHU5S3MvUkUySkorWlpVbHVKUmhHSnNJL0hxRHpPM1dRVWVpd0ZINnd1?=
 =?utf-8?B?Q1BZRENvdDdjM1dNV1c5aTFteSt2TEJmTS9vVXpBUVdvOU12Z2xMSVJxd2d0?=
 =?utf-8?B?VFhBc1Bjc2JBNW9MTWJzOHh5dkdSOWZURE1XMVRPclcrejR4b0RMaFpKSTZq?=
 =?utf-8?B?TzBZbFE4UGdpTDl2a2pEeUk3SHNpZFNQaVI5SGUrd3ZvcWI2MVVjM1E4UzNY?=
 =?utf-8?B?dGtZeHp4akQ4TTFIVHdvWk1iNXVHcDQ4d29LUlB4Ymh3aUx4VlBkWWFjYWps?=
 =?utf-8?B?R2dlbUxqVTdNVy9yeEV4ZVJkWjlOTVNMdDYwaFM5TS9LRForZ2twZllDTkh5?=
 =?utf-8?B?UUZyQUlQSk5nbDhOYjBUVzhOQXlWTkFOVjVub3JxTStsYTBFSENsT1NVek1Y?=
 =?utf-8?B?YnlUdXBGYW96STFZY2FQQlI3TlZNYldGN2FnVjVrNVhMenpaTUdScGE0aTBL?=
 =?utf-8?B?WHdlYnAzR0pkbzduMzdycThRbmlEeWtsTndWdnUvaE4xRkoxZ0lrWUlVQWla?=
 =?utf-8?B?TU5ZWkpwNWJjakx4MTRQcFlMMFcwc0NwWnVlTU1pQ3k4ZEk4eWpQUWxGeWlO?=
 =?utf-8?B?aXJlZzZlcVVsSHNXU1lNb3p1MmRTRFRCTVZkS2FhZDZzbm5ncXcrK3ZzL3Yz?=
 =?utf-8?B?OUFQSTF6UW85MjFRYWlNK0NXYkFOQll4VVQxYzdOVjZrYjJKTmUzbXhlQzR5?=
 =?utf-8?B?dGxhTGZNbEdhcVgzQ1J5UFRET2RxU0dTbmJ2aXdycFV5dm53bll2Vk1TbmZm?=
 =?utf-8?B?aElwTDhKTmN0NHB3c3F5dlExM25Pdk85aExiWWFyN050dW9xWlpYVlhnb3Vx?=
 =?utf-8?Q?ijeZaK/jvjHD1vXPa7bOTRGumILSA4UjKpx1A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b0b1a2-6cbb-44c4-f5f2-08d8ccc5dab4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 06:42:22.5659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2Mzvnn0pqIVhWD1HVl2bk5tvCmVaYzULSOkN/51WmsM/wgB5AYp4/eJkEmfl+yH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2694
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_02:2021-02-08,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102090034
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/8/21 10:22 AM, Andrii Nakryiko wrote:
> On Thu, Feb 4, 2021 at 5:53 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> With later hashmap example, using bpftool xlated output may
>> look like:
>>    int dump_task(struct bpf_iter__task * ctx):
>>    ; struct task_struct *task = ctx->task;
>>       0: (79) r2 = *(u64 *)(r1 +8)
>>    ; if (task == (void *)0 || called > 0)
>>    ...
>>      19: (18) r2 = subprog[+18]
>>      30: (18) r2 = subprog[+26]
>>    ...
>>    36: (95) exit
>>    __u64 check_hash_elem(struct bpf_map * map, __u32 * key, __u64 * val,
>>                          struct callback_ctx * data):
>>    ; struct bpf_iter__task *ctx = data->ctx;
>>      37: (79) r5 = *(u64 *)(r4 +0)
>>    ...
>>      55: (95) exit
>>    __u64 check_percpu_elem(struct bpf_map * map, __u32 * key,
>>                            __u64 * val, void * unused):
>>    ; check_percpu_elem(struct bpf_map *map, __u32 *key, __u64 *val, void *unused)
>>      56: (bf) r6 = r3
>>    ...
>>      83: (18) r2 = subprog[+-46]
> 
> this +-46 looks very confusing...

Make sense, will use %+d to have either +46 or -46.

> 
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/bpf/bpftool/xlated_dumper.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
>> index 8608cd68cdd0..7bdd90503727 100644
>> --- a/tools/bpf/bpftool/xlated_dumper.c
>> +++ b/tools/bpf/bpftool/xlated_dumper.c
>> @@ -196,6 +196,9 @@ static const char *print_imm(void *private_data,
>>          else if (insn->src_reg == BPF_PSEUDO_MAP_VALUE)
>>                  snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>>                           "map[id:%u][0]+%u", insn->imm, (insn + 1)->imm);
>> +       else if (insn->src_reg == BPF_PSEUDO_FUNC)
>> +               snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>> +                        "subprog[+%d]", insn->imm + 1);
> 
> why not `subprog[%+d]` instead (see above about confusing output)
> 
>>          else
>>                  snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>>                           "0x%llx", (unsigned long long)full_imm);
>> --
>> 2.24.1
>>
