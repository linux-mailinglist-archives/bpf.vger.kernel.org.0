Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1FA2F6AA5
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 20:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbhANTOR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 14:14:17 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56070 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbhANTOR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 Jan 2021 14:14:17 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10EJ8Sku021399;
        Thu, 14 Jan 2021 11:13:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=3ss0qb+We8mmU+g4wsn+cbX3vxiAghiQFMuJbupimF4=;
 b=CrERExtQ0B78fRHStj2fixuA3I8x0hcwvIryC89keyTFhgStJf0nSaputM3G+22qlA61
 d3ORf138mI7ozPv4sOB9PDUQpEuqsTwoA0znygQdjBjc3i6Zn5uUtKGr3/iBQEuLDxst
 rktT4uOq6ZEwkCWTGfreOLcD4yeqVdLalUY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 361fppmmvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Jan 2021 11:13:23 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 14 Jan 2021 11:13:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKX5Nrg0kgDMgSP6ZQbyJ+G/ZYqMqPwAb5VMjAutHJZ0TXkj8cz0N7gy3ZjH+DKqhxhhpy50mVDsQ5BYmLk5u5Aoy8uErFRwF5qw8ykkcSsFA+phutIEGjSM1toDFtsHwkvpSsVaggfbYgloH9ZaBBQEDQsnRDyIaR1mGXrgFR5RKOmV96PCWkIhz9sCJjenDZrLyBRfx78E7DHKhL9Zq8DWv32pY0waEPpqAIKdqcvGnn8LG6QQ7Yw/p3dWHswTqDL5RIu3zFkX+HXhxPRvODSM3SrYFyESwEJIqtHb48rSmxJ0U2sdlLZPfVyGV86IomwrH4cPQ5t+9u34YdLukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ss0qb+We8mmU+g4wsn+cbX3vxiAghiQFMuJbupimF4=;
 b=kB8rJyYgCW5AXafjYsaedM+kAqTyr/4ud0VLxLGZ6vPnsfgA54/D8vENyzra2KLP6s5oZ8VVAj+Ftq9CWs4GcuxAO43rQg8tmPD8eiygOk+ly2AHovrheqRoAB350PSIbzwjn4teA3xnQd1hq47X7DqPaJmEjUNCk1FxdxBJVCcbmLb/bb8qktNYRK2HbNFrmeauAO4fOGOvTsCbIoP510PIWfXPUDBiVPFExOLlpFB3vZKcvrzPL+wHjNaB607L+RauefaFqRllsLOzywsYqiUemLX+NNoC4AAXPxpJrCjxKW+0tpKi/iwBQAfUAA3GxfEGnvXeaEx5Nwspqrt46A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ss0qb+We8mmU+g4wsn+cbX3vxiAghiQFMuJbupimF4=;
 b=BcW5KHUgIcMH3MFeldTdFGrRW2o1p7W8e2IPQNQBsKFd1DS4rgrGPWjxA2YHvVddu4gCkcLM/gJ9PBc9+TGk0kXBTZy1p5a0c8RYmLry7t2q39SrRgK+fb7BwEPDmsr3cEjL4OKImLslrUt0T2lGE+v1OYZgfhLS5PGbYz3+7vc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3668.namprd15.prod.outlook.com (2603:10b6:a03:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Thu, 14 Jan
 2021 19:13:21 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3763.011; Thu, 14 Jan 2021
 19:13:21 +0000
Subject: Re: [PATCH v3 0/2] Kbuild: DWARF v5 support
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Caroline Tice <cmtice@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Nick Clifton <nickc@redhat.com>, bpf <bpf@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20201204011129.2493105-1-ndesaulniers@google.com>
 <20201204011129.2493105-3-ndesaulniers@google.com>
 <CA+icZUVa5rNpXxS7pRsmj-Ys4YpwCxiPKfjc0Cqtg=1GDYR8-w@mail.gmail.com>
 <CA+icZUW6h4EkOYtEtYy=kUGnyA4RxKKMuX-20p96r9RsFV4LdQ@mail.gmail.com>
 <CABtf2+RdH0dh3NyARWSOzig8euHK33h+0jL1zsey9V1HjjzB9w@mail.gmail.com>
 <CA+icZUUtAVBvpU8M0PONnNSiOATgeL9Ym24nYUcRPoWhsQj8Ug@mail.gmail.com>
 <CAKwvOd=+g88AEDO9JRrV-gwggsqx5p-Ckiqon3=XLcx8L-XaKg@mail.gmail.com>
 <CAKwvOdnSx+8snm+q=eNMT4A-VFFnwPYxM=uunRkXdzX-AG4s0A@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <5707cd3c-03f2-a806-c087-075d4f207bee@fb.com>
Date:   Thu, 14 Jan 2021 11:13:18 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <CAKwvOdnSx+8snm+q=eNMT4A-VFFnwPYxM=uunRkXdzX-AG4s0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ab59]
X-ClientProxiedBy: MWHPR1401CA0019.namprd14.prod.outlook.com
 (2603:10b6:301:4b::29) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::13f6] (2620:10d:c090:400::5:ab59) by MWHPR1401CA0019.namprd14.prod.outlook.com (2603:10b6:301:4b::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Thu, 14 Jan 2021 19:13:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72afb3c7-5667-43d8-0408-08d8b8c07593
X-MS-TrafficTypeDiagnostic: BY5PR15MB3668:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3668463CB106C65E0F253BD2D3A80@BY5PR15MB3668.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfkWcBugolfxPnYzCE4+hoF2zdi2Ei1RWAimEbQ0MhXvT+CQP4rIdcMmNjzcmIkp8SnUxQGnoWXyDoxK4s4FN7zgDkGgXBEgNU3RkfDVPVIzx+30u5Rf2GMwr4lmrSjyFT32WiIPOi84YnD0kjAsEUscCEPr5G0p23pzrheG/lLErYNxPa6DIVBFi69SXlFBjjhYw7HvaAVI5bUUVoVHfMcMKrV3mOm8kDM9SMVKtE8JpIZaxo7eeKygfSShkCapBDPcVYjYYebSE5ums7m/6Zpvlk2G9sXYojPGIN5t6aJ5DockSaIHxijchFZsDfvyST0V30Qj9LQfiGt6JaSRLOxUZVEfDUHK+2QHEKlTBKLszA6vgGYCV2QT2iMjDkM7G5TGWt1EpwMlo1fWrn/o/4CoT3I/6pcOF3+nLR1o1K2zUSMpgBPKyyaYhodRuGEO4ozuaFD/EhJsQ7Z4Yr9nzimYPjwB1ysskpoPnSHPGUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(346002)(396003)(136003)(186003)(7416002)(83380400001)(8676002)(5660300002)(66946007)(8936002)(16526019)(4326008)(31686004)(316002)(53546011)(6486002)(2616005)(52116002)(86362001)(31696002)(66556008)(66476007)(36756003)(478600001)(110136005)(2906002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cVdpekNncmJOREhsdG1VTDJ2eGZONVlqSUZZQUthdld3OVlkUU5lWHlxZkpW?=
 =?utf-8?B?VWNFekNjR3hOeUdSRTh2RytmTnRiNERjQTBDWi9DZUJVczNVVHovWnZZdkpl?=
 =?utf-8?B?Nm0rUGRKNEhxNGtsNm9GOGhFclFndzVra28zSHdtdU90eWpPVm5OdjF5Y29m?=
 =?utf-8?B?NW9ZalhoVmtJaWhFS0JCMDF2L1V5enlZSk5OREpReFlFNVhmS3VjKzJ3Q2Fn?=
 =?utf-8?B?azg5dGtqMkpKeVZhRWpQQnhwNlJSdTBDSE1CeUt1V3V2eWlXYTBGZndqdzRp?=
 =?utf-8?B?R1c5YnBuOWdCbHBBay90dGxEL2pWUnRRZ2pleEN3ckJmQ29sc0pEZm1VcGo2?=
 =?utf-8?B?SFZXeC95elFpV2pRZEt0U2RFUWpVOG5YR0lvSnJ3NGE0S2tnK2V5SU9mbHhZ?=
 =?utf-8?B?YWI5emlsMXlweVY3NW02Q0NsSWJKR1R0T1FOMHl5bmdrdnFrU01PSythb1Bk?=
 =?utf-8?B?d1o0SWkweUVTNEhFbENxSmY0YWJUWThJSjBlQ205MExucGFZblRHYUpJUEh3?=
 =?utf-8?B?RERGdWUrTXVQb3hPT3V1bFBFWDZVaWgxdWtrN281M0I3ZzV2WEJ3M3VMZGFP?=
 =?utf-8?B?dnpMWXVOVEJHOG43dGVqWjZyNGtpcWNYRDE5QVR1S3lXVkpwSGFnV2M2WURo?=
 =?utf-8?B?YkVubE5UYWVuczl1L2ozaTk4ZkJKZUFMdElGUVdUMmt3RVh3bmpzelJ5TlR0?=
 =?utf-8?B?UkxLNW9QYU9PVXl1R0VFNTVIMFdQdDRlVk83NzliMzVucjRzSm04SXd0N1hu?=
 =?utf-8?B?L3RKaC8rVm5tb1BuMk0wT3RhME9QTlAyMmFQTkNyU1pBYUNvQm1BZWtza0N6?=
 =?utf-8?B?aEV5NWhDQnRZRE5UeGdxdGVtT2lZbUVqaVhlZGptSHQ1eFdzN0J1YTJhRDR0?=
 =?utf-8?B?L1BvOUNTZUptQW42TittdmU5UFltcGRVS09hbmUrZloxMXVRUUFvZW5wQXEr?=
 =?utf-8?B?V0YxUTQ3TWQ3TkRUYmhuakp0TnNZbWtSZnVxSFJRM3BENmpDQzd5MVFMc1Va?=
 =?utf-8?B?SVFVcGRQcUxpTmVCbVdkSmppWU05RDhQTWxyd0Q0UGYzMVIrV3RBN0VhdEVK?=
 =?utf-8?B?cnJ0L1BRVnhtNU0zdWNBQnpUUXlreS9OemUvRUo4TWJMSHBrOUQrRWVkRE1E?=
 =?utf-8?B?U0dOdUtVaE1rWm53SytPKzBDcExHU1NTUDU5ZmlVUHZRZlZYZ0Z5S1YyQy85?=
 =?utf-8?B?Y2NtaU5GdWxPM1ZadkNwcVhGREF2TUxQN1ErZlUybzlxZUt4VWtJYS9EbWwy?=
 =?utf-8?B?cGlGdWNZZkNXdng5ZUd3UTBTbm1zVkd2aFVJNkQxb09mMXhBcWVvUUFRdFM2?=
 =?utf-8?B?cHRuQXV2aHNmbEpRVTdJVnlPTTZlUC9zZVdIdXNkYXFNbksxaUU5RlIxYnBB?=
 =?utf-8?B?Z1Z0Mld6RDcwdEE9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2021 19:13:21.7846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 72afb3c7-5667-43d8-0408-08d8b8c07593
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4y642P36e/4o6/SsFtbemszqGrx9OC2tZf6l7InMnzEldD5KVei9BgFrsJA2vH3T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3668
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_07:2021-01-14,2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=598
 mlxscore=0 phishscore=0 spamscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101140109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/14/21 11:01 AM, Nick Desaulniers wrote:
> On Thu, Jan 14, 2021 at 10:53 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> On Wed, Jan 13, 2021 at 10:18 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>
>>> On Wed, Jan 13, 2021 at 11:25 PM Caroline Tice <cmtice@google.com> wrote:
>>>>
>>>> On Tue, Jan 12, 2021 at 3:17 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>>>
>>>>> Unfortunately, I see with CONFIG_DEBUG_INFO_DWARF5=y and
>>>>> CONFIG_DEBUG_INFO_BTF=y:
>>>>>
>>>>> die__process_inline_expansion: DW_TAG_INVALID (0x48) @ <0x3f0dd5a> not handled!
>>>>> die__process_function: DW_TAG_INVALID (0x48) @ <0x3f0dd69> not handled!
>>
>> I can confirm that I see a stream of these warnings when building with
>> this patch series applied, and those two configs enabled.
>>
>> rebuilding with `make ... V=1`, it looks like the call to:
>>
>> + pahole -J .tmp_vmlinux.btf
>>
>> is triggering these.
>>
>> Shall I send a v4 that adds a Kconfig dependency on !DEBUG_INFO_BTF?
>> Does pahole have a bug tracker?

pahole could have issues for dwarf5 since as far as I know, people just 
use dwarf2/dwarf4 with config functions in the kernel.

Where is the link of the patch to add CONFIG_DEBUG_INFO_DWARF5 to linux?
I think you can add CONFIG_DEBUG_INFO_DWARF5 to kernel with dependency
of !CONFIG_DEBUG_INFO_BTF. At the same time, people can debug pahole 
issues. Once it is resolved, !CONFIG_DEBUG_INFO_BTF dependency can be
removed with proper pahole version change in kernel.

> 
> FWIW, my distro packages pahole v1.17; rebuilt with ToT v1.19 from
> source and also observe the issue.
> 
