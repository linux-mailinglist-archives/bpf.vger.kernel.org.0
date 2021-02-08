Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D183143A0
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 00:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhBHXVj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 18:21:39 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49090 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhBHXVg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Feb 2021 18:21:36 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 118N3V8A019455;
        Mon, 8 Feb 2021 15:20:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=IquYrixdxQHhfCWHZ3/Kg6TExe07QIqBtYwsJAj3F28=;
 b=XhUDnXP8Zlwq/NCb5+Igt5hrmQQm88Dw7fzNCb1xS7t20Pi204iDf9Y/xed0h/tdXwsO
 2ugk10OxeLltVT3SsDLkwgSrQ/S0C2aEPadIeD/SOnmlq6ILqt4NVQy5l4AoeN5QXrvf
 xnEo/sn8mCSZ686qAJm6lOBBDwgcrLA0/5c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36jc1c7rn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Feb 2021 15:20:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Feb 2021 15:20:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ1dysIWo87DsJ/i3b6LS9KlD5ilSBNupoL/KlCgp8azY9axdRij1zcJmXk0bF34bNH6QnneyFwDQzpXcb02X3eeMo6+8PYnhNkYN1mpEgJs4sXNUVlBOxF0vUPPMGowJZjwEJmwiQn0KGJPei6Qpg8TENYzoqwRxohY2axrNGL/m1LEFrkcGkM9F7XzezpBL3SiOxx4x4AViTL+Tlsx0XTutV3wlEUywdgkAnT+N8xLpoCMNW/hHJHhNgU3YXDKrItKaVgskFEqF1/pgLXnEyCPI7CbQFlly2IAMNUZgjJaVAszjNMs1Y9BIPmjj5D7PhHJdyG3OcsS3rY0AF6+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IquYrixdxQHhfCWHZ3/Kg6TExe07QIqBtYwsJAj3F28=;
 b=QX8+aZOdwz8/x5DWg7AK1/VCNjpXSQhdy1OK6O+H4V1jvzPCfUn2FFB1Hwk9jtG58nQrfwbUCFgiIOx90R4vmgobH4uNGWsjFPvJgKwX5k9ghw0RSKaCGFoQFNBMZE0oBwuGVPN6QkGkNnYkqGfUSoRduBDJZPXq3DI9FmvmNsm17vj+gJPeKiaZbIssrKq+IxuR92vyyVUjOGfbmSKrfEIvHWgNAlX9ay+2XiRgVlMs9eAq4gxMiQ7zac+G0nPetmve9FZPOLqMe8ZPm1mpjYlZN0nVnxqpOyhMZ0C58HFH9LoTB8iNlggArzdpUJDrqs1z/EDFbLkqqwa6jmRHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IquYrixdxQHhfCWHZ3/Kg6TExe07QIqBtYwsJAj3F28=;
 b=V1Wdx4nUY20blrOHaj9zCpuBF9J8Tpokim5lHU5dWo2DveF5rpcvuJrMa15ypXO1h6k/KzhYYUtzndu2ovenv5eiPcwrOGmb3vmYM1oE50W4PFBH0nLaR07WDdATi8l2wsNjHxc2KOERTvPhiDbUGjDwSYMcLsFtSm/e+nYcrrY=
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN8PR15MB2674.namprd15.prod.outlook.com (2603:10b6:408:ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.27; Mon, 8 Feb
 2021 23:20:37 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::81bf:9924:c4f1:75cd]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::81bf:9924:c4f1:75cd%6]) with mapi id 15.20.3763.019; Mon, 8 Feb 2021
 23:20:37 +0000
Subject: Re: [PATCH v2 bpf-next 6/7] bpf: Allows per-cpu maps and map-in-map
 in sleepable programs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
 <20210206170344.78399-7-alexei.starovoitov@gmail.com>
 <CAEf4BzaAvDYU4jD8N=CziaRAXnEsvU1QYSa=-x8Q-Sv7iOTdtw@mail.gmail.com>
 <CAEf4Bzb-bMCu9HVbxvnHCaiwFvu+mZDv4yS8H2aS-g4VxF2S0Q@mail.gmail.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <6f5f93c5-c59d-76bd-830c-7951ffa821cb@fb.com>
Date:   Mon, 8 Feb 2021 15:20:33 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <CAEf4Bzb-bMCu9HVbxvnHCaiwFvu+mZDv4yS8H2aS-g4VxF2S0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:d90d]
X-ClientProxiedBy: MWHPR17CA0076.namprd17.prod.outlook.com
 (2603:10b6:300:c2::14) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103:c99:e09d:8a8f:94f0] (2620:10d:c090:400::5:d90d) by MWHPR17CA0076.namprd17.prod.outlook.com (2603:10b6:300:c2::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Mon, 8 Feb 2021 23:20:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96e5fafd-f622-451f-e543-08d8cc8824a2
X-MS-TrafficTypeDiagnostic: BN8PR15MB2674:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR15MB2674290A69658B37EA50A289D78F9@BN8PR15MB2674.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtRMdCbL5IVUkfibFWrtqZn0p4Mk0FEvQdcrgwm2JZB0yHfw3h2M1u1vdNTesjnZQ0kqLzUQBA4/EAB9vBkk8Qy1n616L4kyZLXl+oP9EnjC1Mf2RIqiq7AMIdPSWBz62VyzcuIoAUmIGx1f8Nv80QnVnNaqj7PbdK4VMFIFbIHoDwFJicofmGjf88s6l6DuylFp+JmqeHGSIg57RcY9Uc8WXMfBkRTxcUbvWDPrzKOdth6ZjhBvmgtnniCgq9VVP7gv1RL9SIp+Za7gFJAnvzy8/GROrCezNt6Chy9ojmPurOmGQIFjaVFwVqhUUhuezqrugyJGFpytMnyH9ZpBUJPLStMw3OM0PdJlUpcS4cFBQIgVr3IGv45vxumXWkFHV95wgTiuswWhENNUvQUVsMjFbtk3g/DelvrOfnSVtIkJu38Lxo5MpR9zCPGCRIkOolwR9MmFCnYweYyQ7zPG8y1Giqus4hJcVgAWGFp7iee041oRcqKnQmRubr6BariKCduYnYMkDcog7drIbXcHA4J3SmaZQx20aaGyyxnPlKr6SqzxwSm9VkFQnlfODztMbemzt1p7N7y+PdAThiSE5AKtvzqP2tL4QdmWuStC1aE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(376002)(396003)(366004)(4326008)(53546011)(66476007)(186003)(31686004)(6486002)(4744005)(86362001)(8936002)(31696002)(8676002)(36756003)(5660300002)(52116002)(2906002)(54906003)(110136005)(6666004)(66556008)(16526019)(2616005)(478600001)(316002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?enJrTTVNN2xBbXRUSnVMWUFPL3RtME4wczZ4ZGZEelJLMmR0MXhZUTZnWnhw?=
 =?utf-8?B?RlFrTTZ2THFXOHBuZktCR1g1WkcyUm9OZGpEQWNvMFovb0pMdy9KR3RZRjda?=
 =?utf-8?B?NWo0Rkl1T3E2QzBQWFhIRlZlRG1KUTVqL004RS9IV1J0NEZIZUdSMjZoMGRr?=
 =?utf-8?B?MG1VS0xvejdxWitKVUVYUVRJQWduSThjMGFDUWxFbWREU1RhR0ErbWtIektm?=
 =?utf-8?B?akNIdkpWa2xmWklyQTE1d3FYYldORU92ME4xNTVFazE5b2NCQUhnR0V1VFJX?=
 =?utf-8?B?Sld4YU1JaUJRS2hsUkhjL3Zjd3kxemtzNUMwUTZ6aGVXem85MHZXRWNZM204?=
 =?utf-8?B?L25yMWhwcGxkbjFmK0dndVI3SEFWYjZOSW9jWFZvWVo5R1JqU3J0eWE5MWpH?=
 =?utf-8?B?Y2JJREtsQUU2cStiTUVrei9pRFVoOWpwc0dUSGNGYjM3TEJSVWh4TW10Ni9Z?=
 =?utf-8?B?Vk9pZlI5WnFuU0JjeDNXSkFscEo2ZWZzcVdESWtZcmRmODN5OTBrWHdFTmZW?=
 =?utf-8?B?WHYzcDMrT3BzYXYvRzFnakVYbndHU3hBZzN2K3NQbXhMNFg4eFZOWm5RUXhJ?=
 =?utf-8?B?bUtXa2pkTmErT2RDZHNPbS9tSWZDVldWZ1R4ZEtvb0h3OVJlTXpWVmNoaDZ3?=
 =?utf-8?B?bmIzZGQ1YTNDMk5GN0Z2R2NCRE5pbjBvK3EyRFVueTdMOGYvbnhvaEZMOFhL?=
 =?utf-8?B?aG5wTVlZL251Y3BURzZ3MGJSZWhxT010dEtMNGdEbFVtNUZhcWoxbGM1dmM0?=
 =?utf-8?B?OEdsR3RpL1Zvc1JZSWhmZkY3VUFkWmxUUmcwVDlZRFlqcDJ0ZFRTTFMxUU15?=
 =?utf-8?B?Y0pyUFB5NUk3KzBwMlNLS0tNT1FYaHZXUEY2VVp5OGFIMEUrdGJEaUtNTUFi?=
 =?utf-8?B?UDlZZjlHUnJTUk5CL0FLZ3M0Zk5tbUlqV3lJSnRyYmovVWRRVUR4Y0xMa1JM?=
 =?utf-8?B?ZkgzSjdiWCtOL1N5VHFNZzFmK2pGMWNlbVNYdUQ1SW9aM0xuelBIak45Um5R?=
 =?utf-8?B?ZnV6Y2svRERSWEtBQys5ck53bm9ib0Z4Qm8vSEhNWjVPdUNnMmI2bkNmWVBx?=
 =?utf-8?B?aTZTemxWbS9JdnBqUFlhOVNoZzJWMVZKMlhWbGg1RFJVdERYd3NpMTk2RVJS?=
 =?utf-8?B?bTI3L3U0MzRjRjNxbHUrV1ZIVElISDh1NnNoR1dpK2tKa21UTHJGTjl1d25q?=
 =?utf-8?B?emZibjFyTW51dDYrM2JUS1BEM3pWK1FXMUVhY0pmRmVGSmF1VlAzeDRCTmZn?=
 =?utf-8?B?aEtTcW41WTNpNGJORWM3R0JyL0x6M0FEVlc3RnJEa2pDbkpQdzFsL2R1d0tj?=
 =?utf-8?B?NlluVVBOMnZ0NGJvdXFWS2lVanBoVFV3bnhzWkZRbFdic0hJdGk4dFg1SjBl?=
 =?utf-8?B?eDFOODZSdHNjcjM2Z0I5bUx0cVJlZ1R3SXBTYTlLaytwakRJWUxxVlpoSFo2?=
 =?utf-8?B?cDRoVzZCRDhiaVBvTWdldXF0em5xcGtjUTFJcU5ZZm5NR2xIK0ZHSmFhenZw?=
 =?utf-8?B?bDFqMTRUekkySmZvMWdHMnpBeFJ5cSszRzRjcDFLMy9BQmtsWVVoZmpCdklh?=
 =?utf-8?B?MjJGQ3ZSV2pwNVVDdWoyemU2WXdZRW5PWC92QVVKMGJYT0p6N20raTQ0aUpL?=
 =?utf-8?B?TTJRdUVLeEhkN2hWWE1yN09BVnQ2ekltOGVYeG9Hekc4RmpVTlQ5UzdhQVFM?=
 =?utf-8?B?b0h3VGxqaUhMcnFwdW1wM3ZaZ3ZFVXB0RWJqaXdRQnRvYmIzQ2NHbDRlemtL?=
 =?utf-8?B?ZFA5b3BKaklCU0F6TmxTRHNkRFFhSjRBUGpaNGRib0FtWlFwN0VJbFB0cTNS?=
 =?utf-8?Q?OwqwZn5e2i3tYePKeV4pJwB0nYfl52VaIc9JQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e5fafd-f622-451f-e543-08d8cc8824a2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 23:20:37.6398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBD2m9Jwn69GJV1bfvnKW/4wiECVqRlMgvOhJNjqbarb/lokWyYs/e7X+aRshkSV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2674
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-08_16:2021-02-08,2021-02-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=975 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/8/21 1:01 PM, Andrii Nakryiko wrote:
> On Mon, Feb 8, 2021 at 1:00 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Sat, Feb 6, 2021 at 9:06 AM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> From: Alexei Starovoitov <ast@kernel.org>
>>>
>>> Since sleepable programs are now executing under migrate_disable
>>> the per-cpu maps are safe to use.
> 
> Also made me wonder if PERF_EVENT_ARRAY map is usable in sleepable now?

maybe. Probably would need to add explicit preempt_disable to 
__bpf_perf_event_output around perf_event_output.
It needs more analysis.
