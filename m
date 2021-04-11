Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC52A35B62E
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 18:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhDKQrG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Apr 2021 12:47:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24946 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235779AbhDKQrG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 11 Apr 2021 12:47:06 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13BGkAef020255;
        Sun, 11 Apr 2021 09:46:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=bOaZC49cvfRKFe0AldpTYoKwP+T78F06x8DqP1cc7Z0=;
 b=kbvATDl6O9fNIneylJR+sy9MUP4z4g3Ejj+V7298o5vg9atiX9hD7W/hePydqyoH4R0z
 NLWW8ZsNCFTUgLsNVm/kJt67FC0dn4T1GhBYJMfYzmVeHya8lFDAmTSpQKNZJADz+exb
 19UDQ5vdEhRIKTu4w0rLcZ+9MU+UDyv0+k0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37uv3p9hdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 11 Apr 2021 09:46:45 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 11 Apr 2021 09:46:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwAb607xg8BaCKuNlBct5ndvXb5k95zlydLTtu4jY8Td32z49Rhfb3TchG0uA83gDFsaZOg4ppwUw2QFspvaYis1FQQewRJom1Q1ufuGDRMY43ePVIE/o2Tk0XPhPifcWdpORfUufgTnGo/ykgpnYUuFTNwfOKgAveUOtBne8dyItfWLynn+YUkAbijKxC9pScEtcWkTfgoct9l33eujV+oSdavzgq7pUZfHXotev9fQ4xT85q0GIt/Ht+qBGyCU6TsDJTQga8e3IGi84zOabNV+ljyUddC/RL5DKKUGSrurO1yAm7P7q4hC86f7cBa5nahu6Z9UYR81yk+E8XU+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOaZC49cvfRKFe0AldpTYoKwP+T78F06x8DqP1cc7Z0=;
 b=Qh70+ClfUTQtJyMvWEzwnd3F0dqHBFAL671HQN4sWMwCOkHPBWX45vDP8EwIOxb0r98BV1ri5S4R0NNAeOeVf7l6bCNX6RZeSM5MlaaPrIDsWXr67D6/lGPJ8wXQOqwt6HyL3e2sLd/PJpaVf3jrA83pxklCGLEKu//JUJXgI4OdyWchAInp562gcQvrFsV26j+cFuVMqBWBzZoMS8FA4ia3Pw86dgdmq5gcL9Euu5QICjw0H1qV681sdeuH3Z4qT9O+lEfhlBH7VqxjU6HFF5/fH6YxAq59IVGPtzYgKfc8+d15Jnzk1t120g5WjVKdiui5iIakgRNonl92eZHCGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2334.namprd15.prod.outlook.com (2603:10b6:805:23::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Sun, 11 Apr
 2021 16:46:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Sun, 11 Apr 2021
 16:46:42 +0000
Subject: Re: [PATCH bpf-next 0/5] support build selftests/bpf with clang
To:     <sedat.dilek@gmail.com>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>
References: <20210410164925.768741-1-yhs@fb.com>
 <CA+icZUVz0US1y7LSkk_cvq5bOrTok0LqVSCLkUukmyde5aChpA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <c7c1b4d2-b3dd-a537-7ea4-fb8280416710@fb.com>
Date:   Sun, 11 Apr 2021 09:46:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CA+icZUVz0US1y7LSkk_cvq5bOrTok0LqVSCLkUukmyde5aChpA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ec9]
X-ClientProxiedBy: MW4PR04CA0138.namprd04.prod.outlook.com
 (2603:10b6:303:84::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::110f] (2620:10d:c090:400::5:ec9) by MW4PR04CA0138.namprd04.prod.outlook.com (2603:10b6:303:84::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Sun, 11 Apr 2021 16:46:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed73297c-0935-4add-d0ab-08d8fd096247
X-MS-TrafficTypeDiagnostic: SN6PR15MB2334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB23341A25573192989FED3965D3719@SN6PR15MB2334.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VomZlbLHvr7IqJTRgdwnbT/Gc+/4Tsfj/IPp/xPpMnoP4LxPRvWbPMLjtLX1T0Rnh9W/KmhUW3vWPqOVhSRMeyhu4+/P5ofpm0KcAsswoB9fkw5AzwFSQd2mmWxLGG09aaD9WJ7oCnyOiPeImaFmZ0ICzdy7wLTu72Kn6nT+xbYFCrCtSvC8Jlldz/Qli+2Qp1KXQVB3qbIJaunbxTBj4RSCjBhbsgaBzofRiWVl8TzdHjmv7wkiYOoQQUhnEVmbn51UF+I776SiSBSBhycg/FDWGqBeBPenZOaGLFg3y9AceYCN5EVouRU5m984myT0chJwo27XUfPbRSOuwTCgvp0UwwEr+1Y137kFkpnOWC4WaLKf3SIrQFm0rirdpNrrbIKdtqSSpf4aHsgNuSYkSDzKSaYTxDlaQmGqBJGHV1wolqyM1IaanfJHfa7aRcLOETz3Q4K70o2WL6B3AbHcBbiW+ZmXlZupNeIjna3xgpYmaD8Cw/SI/riEErPVvaHnHx0kBSW/ppg+idzFJ6VN5WzCO2+1rNrvjU/48GdvzLlsetPjnV2uKOjtuTKQivOlHmeOSfh5kdwU8l4ahePkd0Wq9MfpD5OlcUHkp80erald9YWTwtghtWVERSgL/6AcPpprzwXFhQ/EbLgFQ3iB/62r8a7pFh9TzJ4zgI8MtLeYfZNAcFoUFoytxFovEFoN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(39860400002)(346002)(83380400001)(31686004)(5660300002)(54906003)(52116002)(186003)(53546011)(6916009)(38100700002)(16526019)(66946007)(8936002)(2616005)(478600001)(86362001)(2906002)(31696002)(316002)(66556008)(4326008)(8676002)(6666004)(6486002)(36756003)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TjNSMXp3YkdXNFBsQlViQTlhTnNYc2VmR01RL1NpZTJGbFVwM0c1M0U2OXYv?=
 =?utf-8?B?MnBONW1PalRNcW1IbXpsWUNIU01SNVB6dEt1VXhjSHh1c0cvcWxNd2JUYjVD?=
 =?utf-8?B?NHZ6TUdBOHp6TDI3Z2hSWGpTbE5sSlRJZ055NllCTUJCUzRyUFlLYlc5MnFo?=
 =?utf-8?B?eGRrTmdhcHlQUkVIeTBOSlFhZDZldEpFZUtNbXBDbU1yVXBmdjFjZGx5RVBD?=
 =?utf-8?B?MTFMdk5zNHpoMk54cXM3WHUrVkVmb3Q3cTJLQW9BTDZKUVBZTEFicExYQUhD?=
 =?utf-8?B?Z0hOSFEvRzlLUkx6dVp2ditCWGtmU29Qa3hyK1ZBRUlLSGpzbW00QmJHRU5j?=
 =?utf-8?B?TzE5OHNhMlVudVp1QnVURm9XYmtXQkhpeUFOSW9ZOGovaHNtc2RQaTlDTFIz?=
 =?utf-8?B?bzQ5SkQ1SzZZcnhORW5aRUQ5Tnc5anh2dUNOTlN3MnZNZ0pWcDNDN1RtOGJT?=
 =?utf-8?B?bUtPZkVkRjhSYmFLcWllSUNFVlUwSW85WEJoVnlST28zeVl2UENnVStVWHM4?=
 =?utf-8?B?b0ZkZTFmL0dpbDlnZUg1aEprMXU5dnBCSHM2U0ZoWGpHdDdTeVpqZE1jekZP?=
 =?utf-8?B?NURTekxaU3ZBNkJRRFFDam9abnNjalo3dkNWb0V2WjVVb3dOUTFTWDQrczR3?=
 =?utf-8?B?Z21KeU1GRzh4d2F0bEhsK25oRGJJL29nOC9vVUtyL2tKZXVMQXUvNmRETmNL?=
 =?utf-8?B?a2xCN0VrTkZVc2VGWXQ5a3dUZjFCY0x2dGkwQVEwamdYbUhUMG1pVStkZGRT?=
 =?utf-8?B?OGlIWnhpdmRUSVB4S1hWVXVOQm9XVE9rRjA1TWIrYmdtMnBqWDAyTEhjR3FM?=
 =?utf-8?B?RnoyN3hFOWx0dVJLV25aZzloblhzZWVGTkNYdTFYazhhVzUzR0dFTTJlVDh1?=
 =?utf-8?B?UWxQVjkzT2grWGNJNTUwRS8zaDZUMlVVVWtPT0RkY3dDbi8wVnJGRU1qcWlO?=
 =?utf-8?B?b1Z0aXJua0l6VmlQRjFMRlVsd2h5SnJ4cnVnZUhna0h6RmJHVUkwU2VxS0Qx?=
 =?utf-8?B?bURBaW9zZExySHJ5c2VJN2Z0aW9IYVU4cGtPSXYreXF5Ny9sQkFVelBxNUU3?=
 =?utf-8?B?cVRVUzd2SVRIdzQwM2ptcXI5RGlYd0l1NjVtV1NlcGxhMUlMRDU2ZDB5L3pK?=
 =?utf-8?B?YlNDVDhYT0RSdncxK1FhdGsvU3FjK3J3K25yRFp1R3ZXdnlLS1o2YUxMUlU0?=
 =?utf-8?B?Zm5ZeEJuYkUya0IxYys5clc0aGZMd3RYdlBYU0ljMXE1VjMvVHlnWjRYZGVK?=
 =?utf-8?B?WkxWM3NscTB5WU5ueHdlSzVKaGt1MGs4Q1I0RjAyTWFrUXlUc0hIQURSUS9O?=
 =?utf-8?B?QXpSbm04UXEycUI2cWhTb21Vc2RYNXJIMDVFdUVXRkd1amxwYUZjSkd5WWlL?=
 =?utf-8?B?QnhrOGQ1aHZhOXVFZjhBWFM3S0Vtd3QxQXg5TVVkR0xOTlZwUFp6dml3cjZr?=
 =?utf-8?B?NWZEVldtSkgzVzRwVGJLdmtySjBzdWpORTdtWTBmSUlKRnZPWEVhNzhrTk1J?=
 =?utf-8?B?bGtLNkoxRnRvejM0ZjBZSmtqcWdnWC8welh2VXVQeVN6bzhSZlJidWpqQ0c2?=
 =?utf-8?B?TXlHVEx6RzJKdkU4YnlVNDRnY2MxZmpHczBqaDMwM3FaZi9pWXJsd29zR0NE?=
 =?utf-8?B?SmZxS0t3a2NnTlBKbmFGcXh0THRobVcxVDhGaC9ydGFrZlNmNGF0LzBjM2hX?=
 =?utf-8?B?blVrNkxRbTZGaHBReXBmemJSWGJwVHVEYWsxVHRGWjVVU0hUY3gyc2ZQb0ts?=
 =?utf-8?B?Y0ZkdURLajUxeDdLcTNFN05qTU9BUTBNTjVDMitxM0JXMWQrZTRwckJ6d1h5?=
 =?utf-8?Q?x7Lz3drAV95NHLt2c1sUtXBBvDC2+GGpX3AwU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed73297c-0935-4add-d0ab-08d8fd096247
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2021 16:46:42.0020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNwEGUSmt8Z3SGIxGpM75Ox0KRFI5VG5wKTvPqG3Yxe/Bt7FxMhnc8ZuitIXvivI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2334
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 1tXdhGY1Ht02dprVzn9busWZH8LNEkQM
X-Proofpoint-GUID: 1tXdhGY1Ht02dprVzn9busWZH8LNEkQM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-11_09:2021-04-09,2021-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104110131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/10/21 12:19 PM, Sedat Dilek wrote:
> On Sat, Apr 10, 2021 at 6:49 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> To build kernel with clang, people typically use
>>    make -j60 LLVM=1 LLVM_IAS=1
>> LLVM_IAS=1 is not required for non-LTO build but
>> is required for LTO build. In my environment,
>> I am always having LLVM_IAS=1 regardless of
>> whether LTO is enabled or not.
>>
>> After kernel is build with clang, the following command
>> can be used to build selftests with clang:
>>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
>>
>> But currently, some compilations still use gcc
>> and there are also compilation errors and warnings.
>> This patch set intends to fix these issues.
>> Patch #1 and #2 fixed the issue so clang/clang++ is
>> used instead of gcc/g++. Patch #3 fixed a compilation
>> failure. Patch #4 and #5 fixed various compiler warnings.
>>
>> Yonghong Song (5):
>>    selftests: set CC to clang in lib.mk if LLVM is set
>>    tools: allow proper CC/CXX/... override with LLVM=1 in
>>      Makefile.include
>>    selftests/bpf: fix test_cpp compilation failure with clang
>>    selftests/bpf: silence clang compilation warnings
>>    bpftool: fix a clang compilation warning
>>
>>   tools/bpf/bpftool/net.c              |  2 +-
>>   tools/scripts/Makefile.include       | 12 ++++++++++--
>>   tools/testing/selftests/bpf/Makefile |  4 +++-
>>   tools/testing/selftests/lib.mk       |  4 ++++
>>   4 files changed, 18 insertions(+), 4 deletions(-)
>>
>> --
>> 2.30.2
>>
> 
> Thanks for CCing me and taking care to clean BPF selftests with clang.
> 
> I applied (adapted 4/5) the 5 patches to fit latest Linus Git.
> 
> As I had a fresh compiled Clang-CFI kernel without enabling BTF
> debug-info KConfig this fails at some point.
> I am not sure what the situation is with Clang-CFI + BTF thus I will
> do another Clang-LTO build with BTF enabled.
> So, I was not able to build test_cpp.
> 
> I am missing some comments that LLVM=1 misses to set CXX=clang++ if
> people want that explicitly as CXX.
> Did you try with this?

Yes, this patch set should fix this issue.

> 
> AFAICS LC_ALL=C was not the culprit.
> Did you try with and without LC_ALL=C - I have this in all my build-scripts.
> Here I have German localisation as default.

Just tried. Yes, LC_ALL=C does not impact compilation any more
with this patch set.

> 
> Wil report later... (might be Monday when Linux v5.12-rc7 is released).
> 
> - Sedat -
> 
