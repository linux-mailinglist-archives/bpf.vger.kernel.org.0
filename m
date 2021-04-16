Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C1A3616BC
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 02:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbhDPAWe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 20:22:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23224 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235139AbhDPAWe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Apr 2021 20:22:34 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13G0Af9v004415;
        Thu, 15 Apr 2021 17:22:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0d2nT0MxxHW4qD/Q3bnx7T9tBKoIGVMVrf+WN5JcnzI=;
 b=P3f5nA3ix1r0Od6/Q4fmQnhp0+NB3RqnuAo0EThCbBqiBX4GypPfjqjDv4+1OidNwjko
 yFgY9aa65GWyz69NCgwm4i/ktEti86yf22AwwvfsRA1SOiHgmb53h71HseXmuk/9cg91
 TNSE5nzpLB/ldT9fcVJgh3ktL+pc1RU85Gw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 37wvgkb2n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 15 Apr 2021 17:22:06 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 17:22:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyHNIGOhkO5tCqghN3ypssPtLnNxtLxvnRHyEzCMzBu7Ueohhc2TXCbqqZQKSzZZcdvC9Q5d+NPSENCHLlLsbQ37SqPlhiy04Pw9stjJ6JAA9iTs+ZGhmqvEmjC9gorf87/BwnQiWVgjm6tQ3Y6YGGJDDx1hbKH1vdPqgO4dXG8+1/R5pEMYKfATTPGZQ9/bYCkMbqEPw8H1am/zqiLYStMLWUWeJ4opbc2S76ADfeI9A4ipEM+ndgj8G3QSdQYBOaq45lsMWEd/C3tKWN5xY+eYdrXVGpLEV7S37I1v4NLbHibQgrgWcHUTyD+0uF8O5YnNqhyks9jnTc5hJ5ViMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0d2nT0MxxHW4qD/Q3bnx7T9tBKoIGVMVrf+WN5JcnzI=;
 b=BFxTn6b27zPyYOKhWzRSyqGr8wvQOygqNepH/7rceZgzdI7/3b1ejeTHTe27Ib8CVqzCd6aVM4N6+BUmIc4oT3e/KT8l5RFaYe9ymyc44vx/SWj2eZvZILQ8tBba4NbMxLgUlj+++JvSGBxGu0xSGQRKpVvICWd/wZ0eKxYAzB9wD/BSZj3ng/pyoLdYUGZZEsVx6bsJIYYOUIsykVl/tsUZqgouPicmyqXP4VpUFQBrSf9pgdepwKZ24IWVB6iKxtjy5waUeVbhvY65WsseqJGDik0FAz0HG8czpO0cbP9qpF5QT9E2p+tYFFIvBjzg3+UmA4KHhYJBscxj/Fg69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN6PR15MB1411.namprd15.prod.outlook.com (2603:10b6:404:c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 00:22:03 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::315e:e061:c785:e40]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::315e:e061:c785:e40%3]) with mapi id 15.20.3933.040; Fri, 16 Apr 2021
 00:22:03 +0000
Subject: Re: [PATCH bpf-next v3 0/5] bpf: tools: support build selftests/bpf
 with clang
To:     Yonghong Song <yhs@fb.com>, <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20210413153408.3027270-1-yhs@fb.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <26309b44-e719-2fed-6feb-397389985d2b@fb.com>
Date:   Thu, 15 Apr 2021 17:21:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <20210413153408.3027270-1-yhs@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:62e6]
X-ClientProxiedBy: MWHPR12CA0032.namprd12.prod.outlook.com
 (2603:10b6:301:2::18) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103:c99:e09d:8a8f:94f0] (2620:10d:c090:400::5:62e6) by MWHPR12CA0032.namprd12.prod.outlook.com (2603:10b6:301:2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 00:22:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95fcacb2-9467-468a-92f9-08d9006da868
X-MS-TrafficTypeDiagnostic: BN6PR15MB1411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR15MB1411E32A9C8B1B8A62F23C7CD74C9@BN6PR15MB1411.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAU1LJJ8CdosyX9Lmqe4OvTxLoMx1ShF2ZbDHF30QH2swLpVZerqi71EbB5ahzajwlisXqAn0SzURYIzEznpqxxso6LIqjskAoOA/CDYSL55gorsUUspu5FOy8qxgv6bKDvOWTrsKhVt+ngrv+ssFauaNveXlyIDLqd1WUz5SvYQq39gCmxzdFyWQxdjblIC+sXsgRLC2v0+7z0QkE0rD1/SBG5zIJ+l13CfoAPGqRTs+tLXs+L/SqSpESeEGCuR4WizLw6y/J8QLs5tFbhMpfats7dpzmuOgvnMuLcjtHvU8c3oNU5BhOQXs0IdI5aFDvK47oLV65eWD+7pXy/w9aBrWzHWCgQSjiZaZu8o+aTlUmckgtmwrd4hzuz+jdlqmm6JfNc1Udlcippboih+/SB8UOeM9hbie0TI/F87yvlRZgr/s8DfCgJ1doiG/pZrbZIBEI/DcPX+ngiyO2wKHmvhkenzgbY/UzlxqdrY3MX+UnhGT5tAOuQSWhpXr+3j0CRe8eJdkUKPF++QbJKzobU2rk4z2tyIkb6JFGS5T1kvxYxSc+CQc/BAKZlISQzbZzQy3BbcCn1jFJRrpcHOWpeOWO4bSIehocj1E4vQpEw0D12Y/CBl26WM9BYW4UXw3gkETv5TMkhlW4PlHomkAK9s/kmoghcU4Wn/FpHLr4dzN3vwTn+nSUaiQTEvFI3//6Eaa8CrATGZVJdyKsfzgHOII962dsFdAChcLLq2jrDpfSZaf9qR3E9y39oFWyobj74etEhgp6Oqx7ynWYst2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(396003)(136003)(366004)(31696002)(54906003)(6666004)(316002)(6486002)(38100700002)(83380400001)(2906002)(36756003)(86362001)(2616005)(478600001)(52116002)(4326008)(186003)(966005)(53546011)(8676002)(66476007)(8936002)(66946007)(16526019)(66556008)(31686004)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bWcxeEV1L0kxbnhNM2dPeVBiL0Z2UXpWZHNlZXBZYmxaazNicU9NNXp5blNl?=
 =?utf-8?B?RVd4OHh2NmJqRTBDZ0hmOVFRSENkNWc1eHY0dUhEd1o4dkdmM0dZR3dSOEFH?=
 =?utf-8?B?L2ZTYmZvNW5MS2R3L1dBWTlMMmJ0dFVpNkphdnp3Qk1DM2d0aG5FMTRoVnFo?=
 =?utf-8?B?WFl2QXhwMTl2bldQb0JlR3pRN0Rhbmo4RDJ3REh3MklwaWV1bEl0QWp6TFRn?=
 =?utf-8?B?Tm1hRUVQUDZxMVVCTnN0bnBaME1SZzhsV0l3SDdhZDU3M05tbW9aTWIrRXVa?=
 =?utf-8?B?RW5OY3RnZE1BUjdMN05SVGlEM0x5ZFpGK1ZJekpKYWd2eW1EUGpGcEVGb252?=
 =?utf-8?B?UHE0MlNXdUVBK1BjdzArcEtKalhrTE8vOFRzZldOWnJMbUdtM1JCREtjcU9F?=
 =?utf-8?B?amQ1RVZOU1Z2bzZ4a2M4SHN1aFJPN1JVejJGWUlFL2FXZ0N2emw0MmduditF?=
 =?utf-8?B?YnNmdytYOHh6MmZjd1gxNTVFMmN5QlBCYU14aGhxa003eWNNQ092Z0o1TlBY?=
 =?utf-8?B?Q3FKQXU3d3F5Nko1VXpjdHBEKytkL3FUbzA2RTU2OTRmbUxTbElYNkIxcEE0?=
 =?utf-8?B?RjQ3eDY2TVB3TkRCMTVoTHZMSWVTK1BrVnhJVFhPOVNXTHI1a2lLdFhaRCt0?=
 =?utf-8?B?M1RwQjY1dFpseHFYU3h5c2Y5Mmc0dW55VTZmdG5tSVphTWkzY2FPcU9vekc0?=
 =?utf-8?B?M1BzZkI0MHBYQWthdGJUNCtEZStnQjFMalpYb2MzbERka25Fd1h5ZHNKYU55?=
 =?utf-8?B?eUF2N0RGNTF6c0pmcVhUdmFmcHJWM08vV08xeXVTTytOTTRpSjdCYjZOUmJJ?=
 =?utf-8?B?eXgwS3BvLzFmNEtWV0MrUWlsajJyQmlYWVdrZmtRUEY4Vlg2T1JaVVBGYVFQ?=
 =?utf-8?B?SEc3SDBJRzM5Wi8xcDdoZmlrVU10QlBuM2RtMlFjQVZ3VlUvVytTTFJQTXFj?=
 =?utf-8?B?cmtMZmJWNnFyTm56UlBEMU4ybVlMcjhQN1JJZzdCUWVrdldBZjBuSHZNTUtW?=
 =?utf-8?B?UWRLemd4dElJQ0VpMTdYTW9CelMybmVITWRwbmFWQVNEL3pHVDAyRlkrbXg0?=
 =?utf-8?B?TGs2SlhGeGNVSUg5ZzVKL2lBMXV4WlNJdHkrVkh6NFA2L0E2Z2RadDBkWXQ4?=
 =?utf-8?B?ZHBHY3ZzMnNab2w2Z25SNUd6OFdUdDRqK0Z4aHpTaHlOelJVYWZQV1A2RzNt?=
 =?utf-8?B?c3NhbldGYUIwOE1ldzJSMkMreHZyTlNkOXNzMXgwWnFtLytuTjBLMDY3WnN3?=
 =?utf-8?B?N3FwUkd5UWx5cGJweWVvNXpBUVNEa3k2NHRzdnZyT09IZldtUkM1V3NMcm1m?=
 =?utf-8?B?U2RMRDczVjZrTUxROGdrVjZHSWhkcXJ2RXdoZFZFdGYzbFBhSzNyOWxaWHZV?=
 =?utf-8?B?U3BaWnNmTU9SeE5laUcxd2RIS3hlK09KZXRjQXRRODJyY2U5WjE1Y0prT0l1?=
 =?utf-8?B?N1M3TTlGT0gyaDMyb0VMUFh2dVlVeklNQ0JJM1FOc1hWSXBQTkgxRERaSHlQ?=
 =?utf-8?B?c3RyR0VtN2lKYXVUcjhJc3pSWEkwMGZtdEZodG5IT2hrMUhKSnlKd0xVOHl6?=
 =?utf-8?B?Uy9paEE4eVc0YW5MSk5ZZXFXdjI1UXc4UDR6ZlVvenZhNXY2eENYVHk3bkZY?=
 =?utf-8?B?VmxlYk1UMFpJa1MxNkplbTZ2c1ZQUHBWejkyNmRsN0hEeUpIVTJVR1NCUGhG?=
 =?utf-8?B?b043SlZXVTAzMXpkdEpIRlo1eWU5YWxhYTIwV29PdVkrVU9kdGZIZ2hyUU9X?=
 =?utf-8?B?UXplVEFoZjhaS2x4NENyUWZWY3B1OEdOWmczZjhEbEF0QWM2U080VmJNWXNo?=
 =?utf-8?Q?CIGGvac699cWfA9SFs6AOFqk3uH/zJZNAzv9Q=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fcacb2-9467-468a-92f9-08d9006da868
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 00:22:02.9654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fazvnydOcXnyYfEm2KstWLEGFq+OSutKPpgn4zm9ZUi058ECyw+qtmTb61ue3kNN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1411
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: HDxSlXb3mKM9QLtHyDHhb8fjThSJT8ez
X-Proofpoint-GUID: HDxSlXb3mKM9QLtHyDHhb8fjThSJT8ez
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_11:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104160000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/13/21 8:34 AM, Yonghong Song wrote:
> To build kernel with clang, people typically use
>    make -j60 LLVM=1 LLVM_IAS=1
> LLVM_IAS=1 is not required for non-LTO build but
> is required for LTO build. In my environment,
> I am always having LLVM_IAS=1 regardless of
> whether LTO is enabled or not.
> 
> After kernel is build with clang, the following command
> can be used to build selftests with clang:
>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
> 
> I am using latest bpf-next kernel code base and
> latest clang built from source from
>    https://github.com/llvm/llvm-project.git
> Using earlier version of llvm may have compilation errors, see
>    tools/testing/selftests/bpf
> due to continuous development in llvm bpf features and selftests
> to use these features.
> 
> To run bpf selftest properly, you need have certain necessary
> kernel configs like at:
>    bpf-next:tools/testing/selftests/bpf/config
> (not that this is not a complete .config file and some other configs
>   might still be needed.)
> 
> Currently, using the above command, some compilations
> still use gcc and there are also compilation errors and warnings.
> This patch set intends to fix these issues.
> Patch #1 and #2 fixed the issue so clang/clang++ is
> used instead of gcc/g++. Patch #3 fixed a compilation
> failure. Patch #4 and #5 fixed various compiler warnings.
> 
> Changelog:
>    v2 -> v3:
>      . more test environment description in cover letter. (Sedat)
>      . use a different fix, but similar to other use in selftests/bpf
>        Makefile, to exclude header files from CXX compilation command
>        line. (Andrii)
>      . fix codes instead of adding -Wno-format-security. (Andrii)

I struggled to tweak my llvm setup, but at the end it compiled and
selftests/bpf/test_progs passed compiled by clang,
so I've applied to bpf-next.

The things I've seen:
1.
include <iostream> not found due to my setup quirks.
2.
diff selftests/bpf/tools/build/libbpf/libbpf_global_syms.tmp	
diff selftests/bpf/tools/build/libbpf/libbpf_versioned_syms.tmp	
  btf__set_pointer_size
  btf__str_by_offset
  btf__type_by_id
+LIBBPF_0.0.1
+LIBBPF_0.0.2
and this was happening with packaged llvm builds,
but my own llvm build was fine, so I didn't debug further.

3.
clang-12: error: unsupported option '-mrecord-mcount' for target 
'x86_64-unknown-linux-gnu'
due to kernel not built with clang.

I suspect followups will be needed to make it bulletproof.
