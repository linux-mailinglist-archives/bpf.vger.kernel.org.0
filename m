Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E796C3110DA
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 20:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbhBERbg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 12:31:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7752 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233582AbhBER2z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Feb 2021 12:28:55 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115J8Qxq029387;
        Fri, 5 Feb 2021 11:10:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GvYgDxxvs+wF8044TDfIKS2InXma7VbVquIenIYHs2c=;
 b=LGfe1JlKxvNc4ExVHMExx64Dxdo3B6eWBFOtP1CQ8HGMHFKBJptVN9spjYClT7xXkJ1U
 P16YRnJc/1SNk3cco/MkQGdjWWH+8jQzYpcMvoGlLv0yjL2os1TdG8gvja8czi2Inhng
 KVy7cf2XPQjfF+7XFN1ztx9IblQiBQExJuQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36fvyd6ahj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Feb 2021 11:10:15 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 11:10:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtuuCPF/6J8XJj6E0upZe5zlynWHpq/vT0vX6ROQplGl5nHFFxE6gus1cN9o4CLyqYAD62ubcRFQAVZ3wPgT7eAgkS4r2BE+QhAtDXB79RDmbaPyePjFhZ5EnVhhe6AR3OVIWmrClORf+NWjOzEQGPuQzOhAPN7s6gZ0xKFQC5Y0CTCS2lptHCB3Ac0l+59RjLz9jlB1QuGWaO9sQBtCS9b4QMCMA4+dM13xxL9h536LVLpxCkBct7LScUjkgtULvIzjzHrCvhZHysGWyYZWQ6xhXv0n/xKgk+s63symU66h4VwTgvs0STPbvlEppIQSceeNhjWTPf/js+9Sdw3CqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvYgDxxvs+wF8044TDfIKS2InXma7VbVquIenIYHs2c=;
 b=YMsFv1GS15X7I7K2LJ256z0dE3IYWs/P8jTxCdJRQkvdx9Gvi7KIlbScLy5LPD1088aXZB/1VfOQf/gwUOnkzQC9uOVYGXAEkxD3VYEXjF1XMLnQAde+YHyDFH/UruyipBX4F2NA8ncz/scsBaJvelogLX4foK4jbv+2C2Idyfw0mtirc8ozKweOlKJGLg3M2yNOT78ON1et4QKrH3mzhRhK/YKF22fD3WjQeRHfQsAmG1keNPQh6Q2guYI871J5YMy/OEcTBgPwhMWnCmxn+Nw10jLaQ8YJTOino8ABdPTkMXkFAA91/KICjDz0byqsdPXu+kJOSo10r2aLx/X0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvYgDxxvs+wF8044TDfIKS2InXma7VbVquIenIYHs2c=;
 b=XIhWh5DQMlwcBXgWFeinjNVJaLvXfYnFm5kdns/vhOMdboMzuuACg+ZAQPigFbuxDPF13JCwelRtUmGr+DodrABGqYYijH1e1liE2ZTw1m6R0g2QpzZ6vAT6rW8tBlyfJkbEzChAG1gZHpAfzRDPG8X36ZmNyEr11sEXQ7vgbk0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2568.namprd15.prod.outlook.com (2603:10b6:a03:14c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Fri, 5 Feb
 2021 19:10:11 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3805.028; Fri, 5 Feb 2021
 19:10:11 +0000
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     <sedat.dilek@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     <dwarves@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
References: <20210204220741.GA920417@kernel.org>
 <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <CA+icZUU2xmZ=mhVYLRk7nZBRW0+v+YqBzq18ysnd7xN+S7JHyg@mail.gmail.com>
 <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com>
 <20210205152823.GD920417@kernel.org>
 <CA+icZUWzMdhuHDkcKMHAd39iMEijk65v2ADcz0=FdODr38sJ4w@mail.gmail.com>
 <CA+icZUXb1j-DrjvFEeeOGuR_pKmD_7_RusxpGQy+Pyhaoa==gA@mail.gmail.com>
 <CA+icZUVZA97V5C3kORqeSiaxRbfGbmzEaxgYf9RUMko4F76=7w@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <baa7c017-b2cf-b2cd-fbe8-2e021642f2e3@fb.com>
Date:   Fri, 5 Feb 2021 11:10:08 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <CA+icZUVZA97V5C3kORqeSiaxRbfGbmzEaxgYf9RUMko4F76=7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:b8ac]
X-ClientProxiedBy: MW4PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:303:dc::27) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::11b4] (2620:10d:c090:400::5:b8ac) by MW4PR03CA0352.namprd03.prod.outlook.com (2603:10b6:303:dc::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.21 via Frontend Transport; Fri, 5 Feb 2021 19:10:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bd5bee3-5329-41f7-6391-08d8ca09a941
X-MS-TrafficTypeDiagnostic: BYAPR15MB2568:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB25689878AE129D368612EDFAD3B29@BYAPR15MB2568.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:60;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /nKZMq0Kf+DMSk3JpZPdCN1MAzGtwlVmg/r/HNsVyFIsQqvZT+DldS5xj12NlVQK9l9RMKvDfybBzQx9PJghl5hBLJHA2NmEhDADGwZGRFI+HteuTJB4bxsQgzxHjQREPcu7mxZQJ0J5WpuCrUJgnuLnbLv65XsveGEKDbW9608+GLk82rdSZRUPIiCgVauyFNKrQXmn/OmfAUg8HCJWwdnf6/WCmCrQnXijo08GmAYqbAqfHETWI8G12vSBP5pCZO3S4VX3ep0TYblsJ6vpr6i79ap2LenB4lojgSNzBp/wufjtMNG6uWTIT0oTIb2q0LhPPxYiyQgA/LfBEI/auYTtD1AohCZKsyNNpD3zjhdijDtdm/Bgc09VhmDtESHprse7790sbe3VULNU5+dhpRAdTGGZf/qVoAhvyDIVDUOrEWe1bFW3AbEeFK8HM+gTT4OeaGCiO4i4ShXQHCDFfuSjPey7JUF7wx0IW2GgyKr50K2rmZRXBuDDFy2M7kbUETAtMcfMy0qu9qprVbHG13GNrwyArb+wuG31yIk0B8o30jMAs+2Lt0mAtti/l+legAkWqCZrOjPdWgfDsYL0CUQfjpJchf5kpJbjnSx5oqU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(376002)(136003)(39860400002)(2906002)(36756003)(186003)(16526019)(2616005)(54906003)(7416002)(8676002)(31686004)(66556008)(66476007)(86362001)(8936002)(66946007)(6916009)(6486002)(4326008)(316002)(52116002)(53546011)(478600001)(5660300002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aytEekVWeE95N0paekhucEVJbjdyL1hHWVkvOXU5aVFiQ1dKeHlURm5BOU9o?=
 =?utf-8?B?T0NCN2tTcEFLUSsxZmpQUk1xQlV0S3I4ajAxUmJoQVcrYzJwTTJ3aWc5OUFy?=
 =?utf-8?B?K1pOY1REYmpXejRtMzJxWlVsdXF0Z05yMCtCQ0lyeHg5amdEQnFkSnY0QTdN?=
 =?utf-8?B?S0RvN3Zic3VxcWYvYUJacFNDREVUTG5ra1o2dEJmY2VrRkUxaUpyZU5aSTlX?=
 =?utf-8?B?Y3BmcXk3d2VDeUdONis2bWY4ay9YeXBoTXBwajU3YlBEb0k4a3ljZytFeENW?=
 =?utf-8?B?QlJwVzBRWlBkREVhdmlsaUdlMjlkRHg0elZSUFQyd2NUN3RMajZSbjIvN0pW?=
 =?utf-8?B?QWNwdlN4d0hkcGdLcm1FQjZYRThVa1pvQlllOVdLcVpFRVNsWG5JbkpkMlhY?=
 =?utf-8?B?eUZOeVc1SkZxQ1JtcGdmVFVENndjb2xXQ0o3a3ZzNUJrV3pxS0FNbTI3UVB5?=
 =?utf-8?B?VlBaSkJWUkl4WTBXYktHZTNkUmI5V3REWC9DWFozWnlWL3JRamkwYk1RZmZS?=
 =?utf-8?B?bWZyRDUwTStSNDhpbXZBZk1DZ2l3ZHV3Zjc0UjVzY21rN2FSbzZxYm9VdXRJ?=
 =?utf-8?B?RWVrT3JpcGhOaTR5SDVpOVhhcXdMUDc1NmY1T29qQTVpcmhiZk83SjA3RXU2?=
 =?utf-8?B?ZUxiL1FtUlZXT0JYOXNUUGpQOUpzYVZVV3FXLzZTVWNsUkxrMkFiT2FUSzRO?=
 =?utf-8?B?Y1VPNHBLaW85emtXcFBwRWxxS1J6NkZCZTY4OTB5SEVLc1hWa1BJTU5icENN?=
 =?utf-8?B?OW5UcEh5WEk3S1IxVy9tWWRTb2ZOWUMxZnRDWFJhQi85V1JRTGFpZkVxdElq?=
 =?utf-8?B?dFdLTUFEZGZvVHlNNVVDdXVZZWd5L2IwK2tzMlNzamphdDRvbmk5RGRLVzZp?=
 =?utf-8?B?NVBsQlQvZnNLcytPRzFISEtvR1FzQ3RDU1RsS2VpMGF2SlRxSHZLYU1KdzU5?=
 =?utf-8?B?NUg0dlNPclY1dDZWN1RuaHBmZFlnNmFXYWk1aXo4aStBZ3NaWHJVdUt3R3ZP?=
 =?utf-8?B?S1J5SjlERDdaVWQzOTJZUXZEZGl1T3cxUHhuT3ZPZGtkajJVQXQxL08zMEtt?=
 =?utf-8?B?Zk9CQWw5QVhKRDlzQ0NUc1NmSEs5bFFxQTBzM3FhbjBnL2NSNFdxTE5reWtO?=
 =?utf-8?B?L0ZlNHFjUEQ5dkI2SjVCbTB3ZFN4NFY0Q0t6N3N6YUUyZWo4aURNMEE5M0E4?=
 =?utf-8?B?T0FlN2k3OTlEWk9FYVJFbk91QXdjRHVlMVljTTdYbU1EODJxZ0pTUm5TUlZj?=
 =?utf-8?B?c0FTSlEvaDFHaHFZdFgra0R3MVc2WWZDK3hwZ1VqRDNHM3VncWxtbGJOd1Nx?=
 =?utf-8?B?NzFFWWR2NjQwa0tXU1BQVXE0dUZZMHNUbmQ3K2pKVmtYSWxwaUkxMTRDU21K?=
 =?utf-8?B?M29qRzNMT3lIaU1mbUExdzhKN1FSMmdILzY2aG1MdWJOdTNxc2NHejNSZ3lO?=
 =?utf-8?B?K2JMWGI0KzlpMXlRL0JicXYwbTd1SjhEV0dUdXF0eXlleHdkRG0vRkFITjd4?=
 =?utf-8?B?Z1R2VHpYQjVPTzFQWDFEUHZoejNjQ3RHU0w4Q3dRVURVY3paL3VoZDRyczEx?=
 =?utf-8?B?amplUDZqNS9KZHkzTUZvQmdaMmxrOUZETHF5YnZGQVJpcVIxQ3hOcm1DZnpl?=
 =?utf-8?B?T2xzalZxdUhtQUhrZ3FPWVppcU1vZXNJS0J0OGk4YUhpcXc3MktVZkpMUTZj?=
 =?utf-8?B?cHJ0aklCTmhUbytCQzE0SFB6ZkNVNHI3alFrdnV6VFFzVGNiUFlYRjRqLzFv?=
 =?utf-8?B?QUpXUHg2ZnhQV2dmV0RJVmZBTVZrNzRwQ09xY2hjRVlHOXhVSDNody9GRnNN?=
 =?utf-8?Q?0aUcF5RESl+JD1WfIohMmgp1+trkr+lUKEmX8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd5bee3-5329-41f7-6391-08d8ca09a941
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 19:10:11.7645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dz9Rnw4GLOPTVAF5ZvKPJgS0JozY9KBeXnEqdD2hmjQ5OAcdjHW9Ul/y/FtWLGdE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2568
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_10:2021-02-05,2021-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/5/21 11:06 AM, Sedat Dilek wrote:
> On Fri, Feb 5, 2021 at 7:53 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>
>> On Fri, Feb 5, 2021 at 6:48 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>
>>> On Fri, Feb 5, 2021 at 4:28 PM Arnaldo Carvalho de Melo
>>> <arnaldo.melo@gmail.com> wrote:
>>>>
>>>> Em Fri, Feb 05, 2021 at 04:23:59PM +0100, Sedat Dilek escreveu:
>>>>> On Fri, Feb 5, 2021 at 3:41 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>>>>
>>>>>> On Fri, Feb 5, 2021 at 3:37 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> when building with pahole v1.20 and binutils v2.35.2 plus Clang
>>>>>>> v12.0.0-rc1 and DWARF-v5 I see:
>>>>>>> ...
>>>>>>> + info BTF .btf.vmlinux.bin.o
>>>>>>> + [  != silent_ ]
>>>>>>> + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
>>>>>>>   BTF     .btf.vmlinux.bin.o
>>>>>>> + LLVM_OBJCOPY=/opt/binutils/bin/objcopy /opt/pahole/bin/pahole -J
>>>>>>> .tmp_vmlinux.btf
>>>>>>> [115] INT DW_ATE_unsigned_1 Error emitting BTF type
>>>>>>> Encountered error while encoding BTF.
>>>>>>
>>>>>> Grepping the pahole sources:
>>>>>>
>>>>>> $ git grep DW_ATE
>>>>>> dwarf_loader.c:         bt->is_bool = encoding == DW_ATE_boolean;
>>>>>> dwarf_loader.c:         bt->is_signed = encoding == DW_ATE_signed;
>>>>>>
>>>>>> Missing DW_ATE_unsigned encoding?
>>>>>>
>>>>>
>>>>> Checked the LLVM sources:
>>>>>
>>>>> clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding =
>>>>> llvm::dwarf::DW_ATE_unsigned_char;
>>>>> clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding = llvm::dwarf::DW_ATE_unsigned;
>>>>> clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding =
>>>>> llvm::dwarf::DW_ATE_unsigned_fixed;
>>>>> clang/lib/CodeGen/CGDebugInfo.cpp:
>>>>>    ? llvm::dwarf::DW_ATE_unsigned
>>>>> ...
>>>>> lld/test/wasm/debuginfo.test:CHECK-NEXT:                DW_AT_encoding
>>>>>   (DW_ATE_unsigned)
>>>>>
>>>>> So, I will switch from GNU ld.bfd v2.35.2 to LLD-12.
>>>>
>>>> Thanks for the research, probably your conclusion is correct, can you go
>>>> the next step and add that part and check if the end result is the
>>>> expected one?
>>>>
>>>
>>> Still building...
>>>
>>> Can you give me a hand on what has to be changed in dwarves/pahole?
>>>
>>> I guess switching from ld.bfd to ld.lld will show the same ERROR.
>>>
>>
>> This builds successfully - untested:
>>
>> $ git diff
>> diff --git a/btf_loader.c b/btf_loader.c
>> index ec286f413f36..a39edd3362db 100644
>> --- a/btf_loader.c
>> +++ b/btf_loader.c
>> @@ -107,6 +107,7 @@ static struct base_type *base_type__new(strings_t
>> name, uint32_t attrs,
>>                 bt->bit_size = size;
>>                 bt->is_signed = attrs & BTF_INT_SIGNED;
>>                 bt->is_bool = attrs & BTF_INT_BOOL;
>> +               bt->is_unsigned = attrs & BTF_INT_UNSIGNED;
>>                 bt->name_has_encoding = false;
>>                 bt->float_type = float_type;
>>         }
>> diff --git a/ctf.h b/ctf.h
>> index 25b79892bde3..9e47c3c74677 100644
>> --- a/ctf.h
>> +++ b/ctf.h
>> @@ -100,6 +100,7 @@ struct ctf_full_type {
>> #define CTF_TYPE_INT_CHAR      0x2
>> #define CTF_TYPE_INT_BOOL      0x4
>> #define CTF_TYPE_INT_VARARGS   0x8
>> +#define CTF_TYPE_INT_UNSIGNED  0x16
>>
>> #define CTF_TYPE_FP_ATTRS(VAL)         ((VAL) >> 24)
>> #define CTF_TYPE_FP_OFFSET(VAL)                (((VAL) >> 16) & 0xff)
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index b73d7867e1e6..79d40f183c24 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -473,6 +473,7 @@ static struct base_type *base_type__new(Dwarf_Die
>> *die, struct cu *cu)
>>                 bt->is_bool = encoding == DW_ATE_boolean;
>>                 bt->is_signed = encoding == DW_ATE_signed;
>>                 bt->is_varargs = false;
>> +               bt->is_unsigned = encoding == DW_ATE_unsigned;
>>                 bt->name_has_encoding = true;
>>         }
>>
>> diff --git a/dwarves.h b/dwarves.h
>> index 98caf1abc54d..edf32d2e6f80 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -1261,6 +1261,7 @@ struct base_type {
>>         uint8_t         is_signed:1;
>>         uint8_t         is_bool:1;
>>         uint8_t         is_varargs:1;
>> +       uint8_t         is_unsigned:1;
>>         uint8_t         float_type:4;
>> };
>>
>> diff --git a/lib/bpf b/lib/bpf
>> --- a/lib/bpf
>> +++ b/lib/bpf
>> @@ -1 +1 @@
>> -Subproject commit 5af3d86b5a2c5fecdc3ab83822d083edd32b4396
>> +Subproject commit 5af3d86b5a2c5fecdc3ab83822d083edd32b4396-dirty
>> diff --git a/libbtf.c b/libbtf.c
>> index 9f7628304495..a0661a7bbed9 100644
>> --- a/libbtf.c
>> +++ b/libbtf.c
>> @@ -247,6 +247,8 @@ static const char *
>> btf_elf__int_encoding_str(uint8_t encoding)
>>                 return "CHAR";
>>         else if (encoding == BTF_INT_BOOL)
>>                 return "BOOL";
>> +       else if (encoding == BTF_INT_UNSIGNED)
>> +               return "UNSIGNED";
>>         else
>>                 return "UNKN";
>> }
>> @@ -379,6 +381,8 @@ int32_t btf_elf__add_base_type(struct btf_elf
>> *btfe, const struct base_type *bt,
>>                 encoding = BTF_INT_SIGNED;
>>         } else if (bt->is_bool) {
>>                 encoding = BTF_INT_BOOL;
>> +       } else if (bt->is_unsigned) {
>> +               encoding = BTF_INT_UNSIGNED;
>>         } else if (bt->float_type) {
>>                 fprintf(stderr, "float_type is not supported\n");
>>                 return -1;
>>
>> Additionally - I cannot see it with `git diff`:
>>
>> [ lib/bpf/include/uapi/linux/btf.h ]
>>
>> /* Attributes stored in the BTF_INT_ENCODING */
>> #define BTF_INT_SIGNED (1 << 0)
>> #define BTF_INT_CHAR (1 << 1)
>> #define BTF_INT_BOOL (1 << 2)
>> #define BTF_INT_UNSIGNED (1 << 3)
>>
>> Comments?
>>
> 
> Hmmm...
> 
> + info BTF .btf.vmlinux.bin.o
> + [  != silent_ ]
> + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
>   BTF     .btf.vmlinux.bin.o
> + LLVM_OBJCOPY=llvm-objcopy /opt/pahole/bin/pahole -J .tmp_vmlinux.btf
> [2] INT long unsigned int Error emitting BTF type
> Encountered error while encoding BTF.
> + llvm-objcopy --only-section=.BTF --set-section-flags
> .BTF=alloc,readonly --strip-all .tmp_vmlinux.btf .btf.vmlinux.bin.o
> ...
> + info BTFIDS vmlinux
> + [  != silent_ ]
> + printf   %-7s %s\n BTFIDS vmlinux
>   BTFIDS  vmlinux
> + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> FAILED: load BTF from vmlinux: Invalid argument
> + on_exit
> + [ 255 -ne 0 ]
> + cleanup
> + rm -f .btf.vmlinux.bin.o
> + rm -f .tmp_System.map
> + rm -f .tmp_vmlinux.btf .tmp_vmlinux.kallsyms1
> .tmp_vmlinux.kallsyms1.S .tmp_vmlinux.kallsyms1.o
> .tmp_vmlinux.kallsyms2 .tmp_vmlinux.kallsyms2.S .tmp_vmlinux.kallsyms
> 2.o
> + rm -f System.map
> + rm -f vmlinux
> + rm -f vmlinux.o
> make[3]: *** [Makefile:1166: vmlinux] Error 255
> 
> Grepping through linux.git/tools I guess some BTF tools/libs need to
> know what BTF_INT_UNSIGNED is?

BTF_INT_UNSIGNED needs kernel support. Maybe to teach pahole to
ignore this for now until kernel infrastructure is ready.
Not sure whether this information will be useful or not
for BTF. This needs to be discussed separately.

> 
> - Sedat -
> 
