Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0375C34B275
	for <lists+bpf@lfdr.de>; Sat, 27 Mar 2021 00:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhCZXGD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 19:06:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40102 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230026AbhCZXF5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Mar 2021 19:05:57 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12QN4xTg018965;
        Fri, 26 Mar 2021 16:05:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ATRXbefEUN2ToMpc/HYQLYhuqaE1sE+Ak5mHp9QrjFI=;
 b=Hrw/KtqPfeKwfuoVVbB+OMmgqIwYcoN6GNct5I15JQkEwlqaGcnNFZDZHK2qAw7I6EQP
 GKgOUsQIM5UvlT/1hLThl824nJ/VHUtBGuoeqhi+emvsPw9Fe6/r7odQMJ1mWfEG/mzp
 0TWSACLdb0q3W3p973v8u25XzoBEiFvtX0w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37hqhugem2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Mar 2021 16:05:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 26 Mar 2021 16:05:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mt/twtqrdSdd2sBrnfLkzljbn+tC5QW0AanJA3ryzdL80gkYf+D/eRcP4cEfeMvyxo60M+yer0GJkCX58IZuxdgI0/M0Du4nqYckRs+SaLcU9NELnhpAfSnQx2mDvA5eiWrC0OR1a0PyUq+IglwaCqxRXcckpjBBEjYZfhLltCEBG38AikMvcOgcTXPDha0SR7apzt6p1fomCaHavLNrjElm1ErF7Zn7ZVWehoNIfCvrs4g2TzPahfsiseuf6EiEiktz5FErIeRrZq2mUWE+v/caI9gDSc5KlxZhLZBJjLmTIWWGdUWGPRq/BHTEjxkNRGUJEdQVPlH/kbpD1C0z4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATRXbefEUN2ToMpc/HYQLYhuqaE1sE+Ak5mHp9QrjFI=;
 b=iDLQ+2vvUMPQs8vs0ktdjWcY0wS17JyLf95mP3mo04734odgIcYU7bFQXr8+uhe61GyeeIHF+2frL/jEF3q3H6arZJS7q8WfUFowhPXUGOZIJB8P5TbW2iJ7tb85/dIoTuEMuc+mFbP6uAlhkexnhCH/NRp+FKFyHeOv04ydzokFRLBsir68eUwun4apN5nFwnkv2n+ZK7ITr47iVmKQUVpkvStMwHlqx6ptxaK7wMpFv2LFQ5saYRukyw4ryQJcwvj8EotV2Ukiwlvzf9vl2AQanB0pEGBQ8KVVbF2iy1QyAWdXiT2xekGMi3kpykm1E0epy2LsfzScpAHotDbbZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3936.namprd15.prod.outlook.com (2603:10b6:806:80::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 26 Mar
 2021 23:05:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.025; Fri, 26 Mar 2021
 23:05:49 +0000
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: add option to merge more dwarf
 cu's into one pahole cu
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20210325065316.3121287-1-yhs@fb.com>
 <20210325065332.3122473-1-yhs@fb.com> <YF3ynAKXDCE0kDpp@kernel.org>
 <d618edb6-e4c0-a260-905f-e07720746594@fb.com> <YF4ltLywXsM3YkSs@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <74e25d53-1e36-03a0-2de5-bd2d349a4a7f@fb.com>
Date:   Fri, 26 Mar 2021 16:05:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <YF4ltLywXsM3YkSs@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:2920]
X-ClientProxiedBy: MWHPR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:301:1::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1777] (2620:10d:c090:400::5:2920) by MWHPR11CA0013.namprd11.prod.outlook.com (2603:10b6:301:1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Fri, 26 Mar 2021 23:05:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15aa7304-9087-4ede-8e1b-08d8f0abb20a
X-MS-TrafficTypeDiagnostic: SA0PR15MB3936:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3936D4ED2498629BCA7FC25BD3619@SA0PR15MB3936.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AMsC7bdj8AXEB8Y4LG1/6vZted6+a+PPWl5lugmkSQkoSJPSCCgZqOWQAjD2dmgeKrrw2Yg5Y+jbz4N5aZMLTfOsgVTc1B6l+/2L0v56jp1RecXsHmr1USm68iwfsT4GMdGGLbWkGa30vrlNPwEZsIe7TOale1NAmrhGXuTnGt/dzY+KXnliI66jquogmmLHW6u+jMcNwjB/EM4Gae1OAZ419Umx+99+raaSnqUDIjF4fvDbMG8ASg6ChxpAcPvgFB6sEuJvQ85X4YeCpSplL99WVhOHwSGARu4J7Ha5EFgHyQuIhEhoditB91zVSFCASgSFKVcZFOaSsuWq5pav16h+8zIpoanJc2Dt1y2xojScGFb5pipWagPGpM3H0CySRSoOSMpMr8VOgUhoBFMfjUdTnYNl/FvFVXYt+W+1iImcQw56c6EDYF58F1V3PjhjLSceoUhHiMBwFKEkqDldJkyMBp8ljwRCZDg5Wu2l48kTblt37b1c5hLW2dPypJQ/avYbvklPlfOPqeBKSRSKVTZaPn8mWJJl5VXwS1AbxwSwoBrHQ/B+EVswz89KRqGWVTczG+L8AHKZ36qOqCvv77dKGka5STTksxjJHNBO2xpGSW1TKkGOWNf21h0zN+jX4r1zjXKSsW8yGJeCSvdFWjo1S72ZA5re/6lDdiw+BA8zK7lOAjhsnzMwrtTVWtXw7B2QKD9a2BxeSmgptT5pCVaaAWPG+4N/hExoOlMbIxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(346002)(366004)(396003)(316002)(186003)(8676002)(31696002)(86362001)(8936002)(2616005)(36756003)(6916009)(6486002)(66476007)(66556008)(66946007)(53546011)(38100700001)(16526019)(31686004)(5660300002)(54906003)(52116002)(4326008)(83380400001)(478600001)(2906002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QVNDS2Voa00ycUkweDd4cHhDd1hIdVlQYlVwOTlPdDJDcEdmYVdLdUNlbjM5?=
 =?utf-8?B?cjBlRmsvaWloakFsaDVUTU1iWG0zdWtibEo3SnlSQ1NBUEdBZW5BampnUG0v?=
 =?utf-8?B?NmdQS1E1KzBGWnoxZEY1UlhtR0RCSUJEU0VUUXBkOE53M2FKUnN0eC94ZlRO?=
 =?utf-8?B?Vzdha0hmcEJUT0VMU1dHbFVDRkFhWUxLUm1JK1NLdDFFeS9Wek83bzcyV3JB?=
 =?utf-8?B?V2RYR1ZJYW8zbFBkaGxPTnpoSjkvN1pKVXdzRWhuUjg3cXljZUxESXN3Skk0?=
 =?utf-8?B?bGNWOGIyVEpDVjVJdU1UYUEvemZtMENyZXRid2FpK0ZTOWJRODJxaC8rc3Fa?=
 =?utf-8?B?bDE0Yy93UmlnM0VWQnpLejVKVFFuY1VpSGFaOW4rc1VPb3pZdUF1aXlVOFlw?=
 =?utf-8?B?RkpqQVJoYkV6V0xwV3V4MDlVREtmUHgyR2QrYkYwdWg0eEFzN1JORUkrc1dh?=
 =?utf-8?B?YUptTHhoWktMN1FsUFhYV2xGRzVidGFHQlpKS1B3VldzRUhNWTA4dWQxMUo5?=
 =?utf-8?B?N2NLclUzd0NnSTdhK3JLWG1VcUxwOGNtQ28yaGFpTWRqRi94Y3Npa1JiZ05R?=
 =?utf-8?B?UW5FR1dZUVlyVTQwTnV2eHZ4eTBKTEdwL1pRVklCcUtvVG9SZzZMd1JoTWxx?=
 =?utf-8?B?TkpQemd0YU9jV2p1eXY2eVdxbmRmeURRa3FFRkdld1JNM2c2ek9OWGJOcjcr?=
 =?utf-8?B?elR2OXhZZHJXaUpZVFBMUHhlMGhNUjZRZHJ5WDc3eEhjMTVLd2VXK3BPNGVH?=
 =?utf-8?B?M1NVRGZxQlZSTWF0NTdBM0tRZDZJd2ZEUWZYZDl1QURZOHptYTVjZ0U4Rm5F?=
 =?utf-8?B?UXBIQnZqdTE0akdyYjF1TjlrajZPTk1IN3Z6RnZsOWJHNFJYRGxFcXJhME1Z?=
 =?utf-8?B?SkFscGpqdmZQOEVjSW9tV3haODFiTlYyQjcwdjV2NUlQOUFQZFh0SEJON0U4?=
 =?utf-8?B?cmpRRnVaWmxWVVpMamJtd1Byd0M3TXN5TUNDaVBYVERGOTBlQmJFZmFTbkdU?=
 =?utf-8?B?VWhTZlpQK0REN1NiT0pRWUxWTGVJMFBqMlZHeXJMcksrL3F2V1A4WnQyN3ZN?=
 =?utf-8?B?YzNhWFpndG5QVUI2eEZtVG9MdEFZSytxbGNjWnB2WCtuUmszVVhFOTN1VS94?=
 =?utf-8?B?YmU2ZktXZ3pON0lhVEhWZTQyM3Y1M3BnT3lzYzdQYVFEc3FMb09TYTI2WWlT?=
 =?utf-8?B?R05WcUlvYm9LdnlEdlRWME1hbE5LQ01WZzdaUWVBL2gvZTZDalJVOHA3U0pn?=
 =?utf-8?B?bWhxTU5QWWk3S2JyeGNKak1jOXhnN2Fpa2N1RTdEc0hGa1IxaHgyL2dUaEZ3?=
 =?utf-8?B?NnFXOEJ2NVVGMGxQUXh4YTlRT081TEZCQTlhdHRueW1jQTBMeVFreTZUVTVX?=
 =?utf-8?B?SmU5YU9PQ1ZtODVDcnpENFUvVzNOYmdQcmlzUER3YUl3TjlZUDZEYUM3dkI1?=
 =?utf-8?B?ZTR6TFZ1VUhMelVNcHBCODY2c0NZYk9xQ1I1QzQzVXZDbjMrL0RlOVJCWHZ5?=
 =?utf-8?B?YlZ5ZXMxTDQrSk9DRXVIT2QrM2ZLYWpoUTR2SlZFd1U1YURUc1pkOS9xdFdk?=
 =?utf-8?B?eldqOWdqRmlRc0hSUGU1V2FPM0E0SVErb0VhY0dCRGxjN2xjTStYRC83VStV?=
 =?utf-8?B?VVRBTTB6VXZiL0ZrRmhzY3cvWE8rWHQ3dldTUi9ONEZjaHpxTmVmZ2RJdGh3?=
 =?utf-8?B?b3JkTnA5OXc0ZUJsbFNVSitJZUFZUFNnby9xVWV5b1lLS3QrcW1RaW9JVjFF?=
 =?utf-8?B?ajhDaEhVbFM0bzc3Uk5VWU95V2QxK3BBcGJ4YUJkL2FiVTFUZ2JRTDFHekoz?=
 =?utf-8?Q?gZnWCFXqJx8lIhyXcP7Yufo7DvX7UVBnyuDrQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15aa7304-9087-4ede-8e1b-08d8f0abb20a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 23:05:49.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kbPBIFJkWbzoSGtrY/B2i6R8jULm3THix779gZJ/T3FzmuBzPNukWQrXuJMVV1f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3936
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: XKvT4C1e4YdxvssrS3pjWMY-Lz7vpoaz
X-Proofpoint-GUID: XKvT4C1e4YdxvssrS3pjWMY-Lz7vpoaz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-26_14:2021-03-26,2021-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103260172
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/26/21 11:19 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 26, 2021 at 08:18:07AM -0700, Yonghong Song escreveu:
>>
>>
>> On 3/26/21 7:41 AM, Arnaldo Carvalho de Melo wrote:
>>> Em Wed, Mar 24, 2021 at 11:53:32PM -0700, Yonghong Song escreveu:
>>> I'm also adding the man page patch below, now to build the kernel with
>>> your bpf-next patch to test it.
>   
>> Thanks for adding man page and testing, let me know if you
>> need any help!
> 
> So, this is also needed if the vmlinux was buit with LTO:
> 
> [acme@seventh pahole]$ git diff btfdiff
> diff --git a/btfdiff b/btfdiff
> index 4db703245e7d..440241de7c2e 100755
> --- a/btfdiff
> +++ b/btfdiff
> @@ -18,6 +18,7 @@ dwarf_output=$(mktemp /tmp/btfdiff.dwarf.XXXXXX)
>   pahole_bin=${PAHOLE-"pahole"}
> 
>   ${pahole_bin} -F dwarf \
> +             --merge_cus \
>                --flat_arrays \
>                --suppress_aligned_attribute \
>                --suppress_force_paddings \
> [acme@seventh pahole]$
> 
> After that we're down tho this diff, which probably isn't related to the
> patches being tested, but some difference in how clang encodes this in
> DWARF and then how the BTF encoder does it, or perhaps some problem in
> the dwarves_fprintf.c routine, I'll check:
> 
> [acme@seventh pahole]$ ./btfdiff vmlinux
> --- /tmp/btfdiff.dwarf.ik3LN3	2021-03-26 15:08:05.833806712 -0300
> +++ /tmp/btfdiff.btf.69SSZs	2021-03-26 15:08:06.124802727 -0300
> @@ -67233,7 +67233,7 @@ struct cpu_rmap {
>   	struct {
>   		u16                index;                /*    16     2 */
>   		u16                dist;                 /*    18     2 */
> -	} near[0]; /*    16     0 */
> +	} near[]; /*    16     0 */
> 
>   	/* size: 16, cachelines: 1, members: 5 */
>   	/* last cacheline: 16 bytes */
> @@ -101159,7 +101159,7 @@ struct linux_efi_memreserve {
>   	struct {
>   		phys_addr_t        base;                 /*    16     8 */
>   		phys_addr_t        size;                 /*    24     8 */
> -	} entry[0]; /*    16     0 */
> +	} entry[]; /*    16     0 */
> 
>   	/* size: 16, cachelines: 1, members: 4 */
>   	/* last cacheline: 16 bytes */
> @@ -113494,7 +113494,7 @@ struct netlink_policy_dump_state {
>   	struct {
>   		const struct nla_policy  * policy;       /*    16     8 */
>   		unsigned int       maxtype;              /*    24     4 */
> -	} policies[0]; /*    16     0 */
> +	} policies[]; /*    16     0 */
> 
>   	/* size: 16, cachelines: 1, members: 4 */
>   	/* sum members: 12, holes: 1, sum holes: 4 */
> [acme@seventh pahole]$
> 
> But we need to find a way to discover if the costly --merge_cus need to
> be used...
> 
> For the kernel its just a matter of looking if that CONFIG_ asking for
> one of the CLANG LTO variants is present, but for pahole users wanting
> to work with a LTO vmlinux this gets confusing as it crashes, perhaps I
> need to count how many lookups fail, fix the segfaults and at the end
> emit a warning...
> 
> OR we can look at...
> 
> [acme@five bpf]$ eu-readelf -winfo ../build/bpf_clang_thin_lto/vmlinux | grep -i producer -m1
>             producer             (strp) "clang version 11.0.0 (Fedora 11.0.0-2.fc33)"
> [acme@five bpf]$
> 
> oops, it seems a kernel built with clang doesn't come with the compiler
> options used like when using gcc:
> 
> [acme@five bpf]$ eu-readelf -winfo ../build/v5.12.0-rc4+/vmlinux | grep -i producer -m2
>             producer             (strp) "GNU AS 2.35"
>             producer             (strp) "GNU C89 10.2.1 20201125 (Red Hat 10.2.1-9) -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -mindirect-branch=thunk-extern -mindirect-branch-register -mrecord-mcount -mfentry -march=x86-64 -g -gdwarf-4 -O2 -std=gnu90 -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -fcf-protection=none -falign-jumps=1 -falign-loops=1 -fno-asynchronous-unwind-tables -fno-jump-tables -fno-delete-null-pointer-checks -fno-allow-store-data-races -fstack-protector-strong -fno-strict-overflow -fstack-check=no -fconserve-stack -fno-stack-protector"
> [acme@five bpf]$
> 
> Humm, can't we automagically detect that we need to merge the CUs and do
> it if needed?

This is a good question. In the beginning, I wanted to automatically
detect lto mode as well so we don't have to invent this options.
Since we cannot get hints from the dwarf, the only thing we can do is
to actually scan through each cu and if somehow we cannot resolve
the tag, then we try to the merging-cu mechanism. This is a little
bit heavy weight. That is why I invented this option.

Now since you found gcc actually has flags in dwarf tag producer which
will provides whether lto is used, I went on clang side found that
the following flag is needed in clang in order to embed flags in
the producer tag:
    -grecord-gcc-switches

So I am going to make the following changes:
   In pahole:
      - check one DW_AT_producer, if lto flag is in flags,
        phaole will merge cus,
      - otherwise, old way, one cu at a time.
   In Linux:
      - add flag -grecord-gcc-switches if clang lto is enabled.

Then just for vmlinux-lto, we won't need merge_cus option.
But for other lto built binaries without -grecord-gcc-switches,
pahole will not work. Maybe we still need --merge_cus option
eventually, but we can delay this until a later point.

Another further suggestions? I will start to do a v2 based on
my above outline.

> 
> Have to go AFK now, will try to think about it while driving Pedro from
> school...
> 
> Did a last test, may be unrelated:
> 
> [acme@five pahole]$ fullcircle ./tcp_ipv4.o
> /home/acme/bin/fullcircle: line 40: 984531 Segmentation fault      (core dumped) ${codiff_bin} -q -s $file $o_output

The .o file in lto build is not really an elf .o, it is llvm internal
ir bitcode.

> [acme@five pahole]$ pahole --help | grep merge
>        --merge_cus            Merge all cus (except possible types_cu)
> [acme@five pahole]$
> 
> 
> - Arnaldo
> 
