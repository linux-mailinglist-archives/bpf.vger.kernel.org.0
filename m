Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD6E2F1A6D
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 17:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbhAKQGG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 11:06:06 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10060 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730512AbhAKQGF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Jan 2021 11:06:05 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10BFm5KL002941;
        Mon, 11 Jan 2021 08:05:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=gPV9C7qPS138obK/mTbzc9ZheDOq9PbC5Cf03vjpqFw=;
 b=rJFAw3P1b/jEFA+5Q0PTbLXnlTkwUaWWO2BK0bmEwjDnSNkCAaEAYjYSnMU3yMa1IQ1+
 nMQIW9UyTum9142lINsdfC0u6YthrZJB6uF44r0Kw1k5peH0ATfz09Qx1dDXkVZXtkmy
 YScFX+XCag2mUUAybPEaBq3Mhgl9feD0Zjg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35yweb5aqn-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 Jan 2021 08:05:10 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 11 Jan 2021 08:05:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sw9qY50x2MxS48A9cfI6hlKWmNAVjUECjaqXVZIxC4IggJxfLx3L6qC1CTBk0/MhjWey/moUkatKeb0usVB9clM/SAq7dyhECTSv6DMitZ8fxtuctDs7HzLE+kKBx1paJcpLTLjK/mRtzxyUF/aTwA6lFCPOHxGzHipDcW5YSvmWgJTzbX3YwllZvP1E+fWhU2jw4rRIg2ZDU+b/26PcWmxY+Ovw88bovySxrnbUHovJUJK28Irs0Y5uqMiPMkAhejVDeAVtGhc5CJoSEozeD3LMVxRedwgc0IhmSiTqj6IF0QzlO+5pgho9954IKGojBHzNFWCBuLnWUF/Haz22jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig/Hh0HczGNPqwxraaLX5xi1KSMGSMnRSnKxL3se6Hg=;
 b=jhb/fllBpaZs2++vSJK5n5yURk7K9TKbgAEfZzdGrSbaxZnl6OjUJrV9aJFoforLvUkhjpY8BzYIkpEEvoMuD9W6S7VNw03yonN29m/SyxES6Mc3+RdX2Q72REoK6Ap3XSYqKmh+xOZSrdN5DiaebJkiBSpRh40CjDVOdesQvGUla0Uj9N+NmbAGHjRTWu74BmSpdx9mfaXVsN7T4bZ9SNrGCbCe5LpIQGxYQk5AYGS2UlXaZFRDqZMxg9a43Z8T+s2ZDKSx9WWmCUCSYY2RvSRpLLrf2jKuLXJ8KhFjesXMWl+7CDmvUjJ5ukSDsVl89+72Gki4B6UdF8kIJJrgjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig/Hh0HczGNPqwxraaLX5xi1KSMGSMnRSnKxL3se6Hg=;
 b=NYUXMgc/p9d7Emjniz7bRnDrLLv2cXmHr9kpaBCGfFYRwC/7IJtZpxXb3BT8pNDgJVAbQFD/Kl/gF+BhvdtwjWwdCnMjpNuxEYMUGzSvTplbDcSFsV3kcaXoNi2Wf6OW9D6c75W3dj9idcbIQkgZaWpHZtD8vh5JLriextK59C4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3208.namprd15.prod.outlook.com (2603:10b6:a03:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 16:05:06 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 16:05:06 +0000
Subject: Re: Check pahole availibity and BPF support of toolchain before
 starting a Linux kernel build
To:     <sedat.dilek@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-kbuild@vger.kernel.org>
References: <CA+icZUVuk5PVY4_HoCoY2ymd27UjuDi6kcAmFb_3=dqkvOA_Qw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <fa019010-9d7c-206c-d2c6-0893381f5913@fb.com>
Date:   Mon, 11 Jan 2021 08:05:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
In-Reply-To: <CA+icZUVuk5PVY4_HoCoY2ymd27UjuDi6kcAmFb_3=dqkvOA_Qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:6450]
X-ClientProxiedBy: MWHPR1601CA0022.namprd16.prod.outlook.com
 (2603:10b6:300:da::32) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1158] (2620:10d:c090:400::5:6450) by MWHPR1601CA0022.namprd16.prod.outlook.com (2603:10b6:300:da::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 16:05:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30678518-06a1-44e7-7e91-08d8b64aa992
X-MS-TrafficTypeDiagnostic: BYAPR15MB3208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3208149A68E6D2881C97FB55D3AB0@BYAPR15MB3208.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6zTEwDc3zHYai0XOyyH/h67KHADA2p+PhcmLiPf1kR6dViLKbvZf90KesNoj7SQHj/vsCrs8flCxdo1fCXKsRgartOEENh+Q7Aif8lnT2Bk5q6IVo9WNwGi4bevJ4AE2I/zAamw+FuSbcCzhvPVj6zdbgA/hYptcQYhRQEg4aU7RHiA4314fh5odqlpNjcJW/G7MpSTMeC5/nFXzWiOmm0ZUojQiDqDebRMTT+0z3IGg8IXi6N0I0LFAJzJcT5jjrAcP2xtm+OD5eYLYVYanBMvrv6K4p7nea43M6zYP1Ru11bhI1YRNymXeJMFoU07OWlBr5WOxd1nwASF9Ky4bwyXQBWGy2r/pUj8lIcwAF/IIaDYL6z+QK6epZsKNuoJFBCy29llJwx1tEdY/2aYkhUJ3UugkmSFnucuOWrt3tXFZFGgX2FqlZmc01/hCUv2c0ZzvUW2PMdjFoGPbou9WL1kLCLY44Ufh4q0rHpd3h7oNGUxHXxf6IrGMqmmcV94RBuuqzdaRMx9+SP58bGkjtuh9zG9d6Sd7tw2fbgdmfOX9o04A4Pt2ecmYiZJxbOw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(366004)(136003)(39860400002)(2906002)(316002)(36756003)(8936002)(83380400001)(53546011)(6486002)(110136005)(8676002)(66946007)(52116002)(478600001)(66476007)(31696002)(86362001)(66556008)(5660300002)(31686004)(2616005)(186003)(966005)(4326008)(16526019)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UGs1WDdqcTBtOGhBKzAzR2tOVWduZUZMQlUvT2NURkJtamg0QktZRm9ZMEo5?=
 =?utf-8?B?eDNPMnRxSFp2Zi9YZUhzN1Y5RXVXKzlsejRWc3M0Z0owaktoczhjNmo0enR3?=
 =?utf-8?B?NURucThwSHRoWkt1S1lmUXpweEdVTE5haElhQWZuUk04bk9tYW9odW5WL0Za?=
 =?utf-8?B?dlRIZ2V2cExNUTQxS3RWQnAvRThzWEFaMUtSVnIvRDlCVnFrS0RGQWhXaFll?=
 =?utf-8?B?cnpVRGVSNWJaano3ckpzK0NmQzljNWxCekNwOUw1TUc1TjdTano4Ymt2MlJH?=
 =?utf-8?B?RzQwbWsxeXRBMWI5NisyQ0tqNGhwekNQdi9DaFRZVURINGsxWTFid2lZZkhk?=
 =?utf-8?B?YmZDTlRHcFZQMFJWa2k3Qk1henFrd1MyZDNwWFBkZGE2cG9wcWFFSG9UcWcx?=
 =?utf-8?B?UHRVYmkzQU1aaWF4a2pFVnFuSHR2VkdlVHlDbE5wOW91R3JES2lnN3JmU3lh?=
 =?utf-8?B?QWhnbFZYOUFzUnBLcmtucnhZdkJrVFFNZkFLM3VRMU1JU1dMalhMVTJvakwr?=
 =?utf-8?B?eStaam5QNStRbVdHSGpReXZFMEp2aHpaSTNuZS9MajlFRTdsYzFUa2FRWWt4?=
 =?utf-8?B?Z3o1TjNHekFka2Nwb0JyaHFPTlk0bm5NaHEvQjdiMGhKendybllFTDM2RjhU?=
 =?utf-8?B?QmE1YXByV2pzWTJCa3RKd2JOL1p4WjlOOTAwdll1VVdDZEF1YU5sVnJwR2E2?=
 =?utf-8?B?SVF6bzliT2pMSm1na3h2Z2Foc3FjM0N4akJWWWVJY2hqeDA4elc3NGR1N01R?=
 =?utf-8?B?TUN0WTBVaktxWDBEdVdXTzVLRWxxTlJkRlU0ZkZFUjBUK1FiSUVWeDJ1RWJl?=
 =?utf-8?B?U0s0TlFPZlVVWGxaL3BNUXRHYkl4bk5QOXZST2RKdWh6TDQwcDI2Q0YySFVz?=
 =?utf-8?B?R2ZUaXFVQnp0OEdZOWd5bm9ycUVrKzRhanVkNDBBTVY5ZlJxd2JiUzJhSGpE?=
 =?utf-8?B?MnhRRUhZcFVETUlYOVRqd29jcEJhaWxBcU9IV0dQUW40VEJhT24xVWtsNzcy?=
 =?utf-8?B?NCtqL1R1aHdNR2k4NUJDdGJhM0ZjZDg3SzlFMkExVjBIbmRrcDRhSVhvYmwy?=
 =?utf-8?B?QWJmNHpzdTAycmVYclhyQllzS0J5UFZvZUNYZ2hUVWYwSngxZ2xwb2ZzTHJJ?=
 =?utf-8?B?NlhFZzE2MXN1YW4vUXpiVllBT2Y0RlJJWTVyUzlubDNjbU9INk5BQms1Zlor?=
 =?utf-8?B?ZnRYandEeEpzdmFPNHU1cDJkYW1NSW50aE1BZVE2MHk5U0U2dnBnT1phcGEw?=
 =?utf-8?B?M2hMSkMwUjVodS9GYjNMTG5hRlpnQTJYcG9qZ3JQVWV6T1kzTEJTcUZoSitV?=
 =?utf-8?B?bU9COVFuVDEwdmNYK25vRDFFT1dDclJBM2ZUbmhDVmUwYWxIbVJEQnB6SjVK?=
 =?utf-8?B?U0FEQlRkNHFpTXc9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 16:05:06.0111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 30678518-06a1-44e7-7e91-08d8b64aa992
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSdp2zVo3c4cpfaDhi0p0INR47eXCEurhMd/V33g68Sk1Vt2hnzJatflmtVkwSCO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3208
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-11_26:2021-01-11,2021-01-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101110096
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/11/21 4:48 AM, Sedat Dilek wrote:
> Hi BPF maintainers and Mashiro,
> 
> Debian started to use CONFIG_DEBUG_INFO_BTF=y.
> 
> My kernel-build fails like this:
> 
> + info BTFIDS vmlinux
> + [  != silent_ ]
> + printf   %-7s %s\n BTFIDS vmlinux
>   BTFIDS  vmlinux
> + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> FAILED: load BTF from vmlinux: Invalid argument
> 
> The root cause is my selfmade LLVM toolchain has no BPF support.

linux build should depend on LLVM toolchain unless you use LLVM to build 
kernel.

> 
> $ which llc
> /home/dileks/src/llvm-toolchain/install/bin/llc
> 
> $ llc --version
> LLVM (http://llvm.org/ ):
>   LLVM version 11.0.1
>   Optimized build.
>   Default target: x86_64-unknown-linux-gnu
>   Host CPU: sandybridge
> 
>   Registered Targets:
>     x86    - 32-bit X86: Pentium-Pro and above
>     x86-64 - 64-bit X86: EM64T and AMD64
> 
> Debian's llc-11 shows me BPF support is built-in.
> 
> I see the breakag approx. 3 hours after the start of my kernel-build -
> in the stage "vmlinux".
> After 2 faulures in my build (2x 3 hours of build-time) I have still
> no finished Linux v5.11-rc3 kernel.
> This is a bit frustrating.

You mean "BTFIDS  vmlinux" takes more than 3 hours here?
Maybe a bug in resolve_btfids due to somehow different ELF format
resolve_btfids need to handle?

> 
> What about doing pre-checks - means before doing a single line of
> compilation - to check for:
> 1. Required binaries
> 2. Required support of whatever feature in compiler, linker, toolchain etc.
> 
> Recently, I fell over depmod binary not found in my PATH - in one of
> the last steps (modfinal) of the kernel build.
> 
> Any ideas to improve the situation?
> ( ...and please no RTFM, see links below. )
> 
> Thanks.
> 
> Regards,
> - Sedat -
> 
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/link-vmlinux.sh#n144
> [1] https://salsa.debian.org/kernel-team/linux/-/commit/929891281c61ce4403ddd869664c949692644a2f
> [2] https://www.kernel.org/doc/html/latest/bpf/bpf_devel_QA.html?highlight=pahole#llvm
> [3] https://www.kernel.org/doc/html/latest/bpf/btf.html?highlight=pahole#btf-generation
> 
