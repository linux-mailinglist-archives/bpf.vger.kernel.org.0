Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C104CC712
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 21:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiCCUcP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 15:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiCCUcP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 15:32:15 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073C9187B8F
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 12:31:28 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 223KGxSp005109;
        Thu, 3 Mar 2022 12:31:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ScITC4qEZlqSs/ImFRlaZa0Dlkrb5gkqFHofE7BiWCk=;
 b=izSC+JkJYGU5kD4ejrgHPaZJ0atdjNb1jCPGWMjgmA8K/ARTyDSQoV3Zx4PCB8OGmcFq
 TBF2Y0RR7k9W8wvrkF8BEYYDa/jvcRrP+NJnS5IMBgWL/fuTO/6yO3jOshbtPaCiaZjn
 SVdvx4T4GtO6CtfDPuG3Su4o4GtpyqHd+DA= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ek4jur39f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 12:31:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8+TJqQ0QOU3hHlBqk7SLbQn1b6vrizIYuoUaO8zCKMrTcbLkGPKGQSManK9EXSPytYWSN7V+gVl1PJxC7Sig9dRKaORmc62L1rpiz6OKG1B160UIwbXEIpD48zREdzVrh2jot6nMUw1sUfRV6F7H38KDEOOd6QiBaXbfYacLYRwLuo1drYT+my4fnhLUN5gT9pEC4Ttv/Mm6As+SL/QUSZRNGFjP5FpSZC83OLtzWCCVg1Zx4QOCuNuLb+/IfByi+Qqer0tRuY+0vRUOmJhRkFtKgSHRPL85sgU+EWFFU3KAcdsfLftRCR/QXkNYfyvSx+f72wU3k1VEYuq9wuj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScITC4qEZlqSs/ImFRlaZa0Dlkrb5gkqFHofE7BiWCk=;
 b=k32RUMOen215NJkhfbVZNU8Q6wVvmdmn5eKhZbQsp1xyZnH8sfZhqmvYld0JWFxmRbl5yl55LERSBTkTch4+OhIHnGN7BteboZTEMlJh+2juIoJAVLoL+GG+WC26d63O8Y2BAjxmxM8l+5ZAj6aFt0/qkQ7upI3GmCR9d0SmuG2Fr9ZgRVmH4K9Uo6X5HPAomaNb5dkELUaCiOUBcJsrcdz+NtqnQAUuCE1bKYgPE2ThrFGwL5U1kx4TzxdJHy7BEdDumj9sW/p3O5+/cRwAfavL+CSTe7Rc5o1JjbZ2jZCor0HrDhnBZN/J7O1nEQR+rkIOdw5sLjblAyNdE7v4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3758.namprd15.prod.outlook.com (2603:10b6:806:81::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Thu, 3 Mar
 2022 20:31:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.029; Thu, 3 Mar 2022
 20:31:13 +0000
Message-ID: <e0f14903-9212-606c-bff2-29232b51ee1c@fb.com>
Date:   Thu, 3 Mar 2022 12:31:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v3 bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
Content-Language: en-US
To:     Mykola Lysenko <mykolal@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        Kernel Team <Kernel-team@fb.com>
References: <20220302212735.3412041-1-mykolal@fb.com>
 <8bb551bc-c687-04fe-d588-6beb1495f01d@iogearbox.net>
 <2DDD6C41-0584-44F5-8D85-4460EDFB2C40@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <2DDD6C41-0584-44F5-8D85-4460EDFB2C40@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:300:117::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31cddace-8995-4d7a-dccd-08d9fd54c278
X-MS-TrafficTypeDiagnostic: SA0PR15MB3758:EE_
X-Microsoft-Antispam-PRVS: <SA0PR15MB3758BA9E5F10F9DA3E2F72E8D3049@SA0PR15MB3758.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7uxOA2TPEYqlvsO+jHgH9HmCeLNefrg6iITapmFYJMdwVrAQmbFaXG+mSlM5sghKWAUoC3+MPq/bTYox2eRrWooZ0m1va5M82P0YedyPe6l1EH46e5VSCV3h8FmFRqfk6cCn9I++FQoal/PnMsuItcJMUWfzWwLGhuDWjKNUFCTRIDv0hnEtOvIPxi0GtCpvY96P1lenb1IWbgkaRKRvjW/kXhYUps93rr+tg0AhS9o99j4enhA+sLZCIVUMJgus/05vw9s790HIEwQb3RCidAcp7LbGUSHJoA53aF/g6h+eVDPWjCPvmBhq8UkxmnbPeYIhYByIbDkGP1xtDBh9xGca47sCzo/I7RkevkwbvjoOXa734Gm8NyTKgrZjZPKImdBQxzRGQu4ZDpYELlrDRdmUOAir309oNXn15zYnoJJz6sTs241sqMcmikY0mZCSwR4xbq5Pep7IG9cW+lAza/tTN7i5uwOo8vRsdFQYG1hWxOHf+9n+vLDtT4EfYAKDKoSRRGnm5o4MX+wUysFPdWzgQcqr/Xy0iWZq1Yz4XZOc3YHXW5omjAyEzW7WAnDa+YaZYIj2YAQJdcm7TRVFg13lTZdYq/o8rFPuIR+OWFlnaar88VDsL8UxD68wncXnCuSSUUJEp+mLKSjhsO/tpOt1WFEfCJ3eurrGyY8gK3bBPTfDPxx/GWOGXqPWGioF6wxWSbSlDmI7m5lSlOZFXWufLJ0Ll1QnjbKuy2DKErgwB37ei5VzMvM0aE7/jn+b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(31696002)(4326008)(8676002)(66556008)(66476007)(86362001)(2616005)(110136005)(36756003)(316002)(54906003)(66946007)(6666004)(6486002)(2906002)(38100700002)(508600001)(31686004)(53546011)(52116002)(8936002)(186003)(6506007)(5660300002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnhTREtpbzVDeHNVK3R3ckFpZkJ1aXBCQmRMM2xsWDhUK0dYaWZ3RlA4cU8x?=
 =?utf-8?B?ZzJDZlUyQXJmWHRxZ2p1Y3IvZzd4cG1mOHNJV1hVWXdwRit0S2ViRXFHMHFT?=
 =?utf-8?B?UG9PT2pRZUptT3dXNDFBZ05hOU0vTUVNYm9KWVF5SEIrVnJkVUg0YTh1UW9p?=
 =?utf-8?B?TnpWNjlVNkY4VXJKSE5CeTVud2YrUUUzejlRZGtsNTRGcjlIb1ZpWnlkTkI5?=
 =?utf-8?B?cy9Rc3M4UXZpRjFTVnZpdUJIZzlrUkhaZThZUktFL2hseUozQThBenM3blNh?=
 =?utf-8?B?ZUY2VnFEcml6TmtzdTBsMzlXVzZrTWI4eEM5Z09HQ1NsTGJzR280OXNRRHlz?=
 =?utf-8?B?TlJBbnV4cmNxZWl0M3VkemJGSmtBVk9wRDA3K1hJL1JFcks4MFhMQWhlZ0lI?=
 =?utf-8?B?cTlqT2QxbnRkdDRVU3ZJR0JkalUyUEtua1R5a3YwUFdLNzlaWHczTDNqOThD?=
 =?utf-8?B?K2JncHIxeUVUU2lpU0RzU0NSZVVtRDVVSnZJREZ5NmRoWkFMLzdEMWF4SVdX?=
 =?utf-8?B?Ym1kWlBxWXJQaVBFcHhqeVE5NVo2aENONlcvSmVqN2Rva3ZCQm9wTzRSa1dR?=
 =?utf-8?B?ejhHdmxaRlByN1paL2lpSlBGWWVlNHo5dDN0aU9IOGFrVWJtaVF6SElVUFBN?=
 =?utf-8?B?dXYzRytUSGI1R1lYZjlSaFZkL09nbzFxeS9IN3lwWDFSZmVLaWZBUWtrRFpO?=
 =?utf-8?B?Q0IvLzJYZk05Q1hNdC91VFFDSUV3MjZTbkZxdC9JWDN2QkN0RUM3YlR0Qy81?=
 =?utf-8?B?K3ZHM0dObU0xRUFlQkxJL002bWh0cXRyNTNGRE8xMjBpakdpNmtqOHdsZW8w?=
 =?utf-8?B?Nnh5bVh6ZG80OStSbzRDTWUwVUYxYlNoUXpRTzFhd2lIVWFHeitncVBPVnI0?=
 =?utf-8?B?R1BqZU9VdURaWVJMTXdPY3l0a3R1K1RDSHpaeFVWQnFlVU5SVmFtZ2JOYXdu?=
 =?utf-8?B?c1p5Q1FXbGJ6TExkVkFOd1gyNDl2aHY4Z2psREtESHRTNHFZUUNhM1FjM2Qz?=
 =?utf-8?B?MkhxZ3hJRVc2STcrLzVMUVFwUXo0a0UwT1pDdHpEakpUYythdE5na0gyV0l2?=
 =?utf-8?B?d1NQNDhST1d0VXpHWmt1aG11N1BUZWNrZHhvaXBqQ1BYZCs3UXhaMUh6UG5r?=
 =?utf-8?B?b0x5MkNhUWhjYjdCSVVTVU94YXZVOE51V1VhMmV0a3Q4YWxkUit3VTI5b2Q0?=
 =?utf-8?B?MUVSaDBUZldLLytPLzRhbjAxRzhrS0hGTDlxajBRYWJpaW9vcm1QRmZMTjU0?=
 =?utf-8?B?bnprZFRsT3FkVjhWRXNGRWZqc29yY054ckZMM3pmUGFjUEsyR1YvSXFSTlhS?=
 =?utf-8?B?bHRCSTBhcnlmQ0pnbVFwcm9YMS9iTWp5WXZnZFU1cTh1REhZd29rWmZRL3py?=
 =?utf-8?B?MWpwZHBLaVNURDhUdGhMMmh5ZWxocVlKL2c2aXo0TVNRM3BiV01EdjYwSVlS?=
 =?utf-8?B?YVFIMkEyQlpqK252dmRjNW1BVU16THZLTVVHZWI3TjZlWWRSVXVZRnR5dUtD?=
 =?utf-8?B?d04yQmtCcTdVNFcwMGtZVVE1MkNhV3VQcmcwTDkydDN0ejRuTnBrTXpvOGhI?=
 =?utf-8?B?cDlQOVFTS2I1RnR6Z1hOTE9CMmkwYXBGSXJvQWhFRFY4dUlJbmhKbWU1WEFS?=
 =?utf-8?B?Z1lNb0V4WldaL2hJVWlLZ2hoRXJMUFdnTzZnOXZqeFh6bEF5c0lUaEZyaUMw?=
 =?utf-8?B?cGxlY2h5WXorQzBBdThyaFRWNjdaS0gyRlNNNks5VngvRzZ4VWk0YUU5YUJL?=
 =?utf-8?B?NW5RR0NGYytLK2F0M2lBWTVmMGdDUDNRRUQ3a3NFbWFIWXgyVGRxb1dZdnVs?=
 =?utf-8?B?Q0p3dmxpa3RPSyt6bHY2czlNdVRoZ1JNRWVLNERvby9BcHZzVC9qNWZPemdt?=
 =?utf-8?B?ZnI4YlZpYVcvTUpYbUhNQ3pPa0FDaFpiREVFMmQvR2hIYUZoanVuT1gzSUVz?=
 =?utf-8?B?TnlFSlorcXQ0WVhuV0xBV3pCbTc3NWNwZVlVTkZmNmZ3N2xjM0VCLzJ4UGFy?=
 =?utf-8?B?cXprbXNNQmwwdkVDdWpkOTZvc3MrdXVXSDNRQU5DeERKUWJ4Q21FTDI3NDNj?=
 =?utf-8?B?eEF5ZnpDVHpDZkpnM2RCNmhoTnlNb3hUN3RMb29FRXBDTlFkTmJHdCs3Wm9u?=
 =?utf-8?B?Tm93VlFBMVpyRmFMalFPTGNrbUNLekhIbCtwcjhMb1FKeUpIdWdoM0xGY2J0?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cddace-8995-4d7a-dccd-08d9fd54c278
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 20:31:13.2510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEzK0DQcRYBzKtt27QZAwDiU5FEiLFdA/u35UVqrHAJTD5wAfDdk4W37DRYRoWKm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3758
X-Proofpoint-ORIG-GUID: oQGcMkSD0WA0DUW7WV8bRBwB_Y_KXdGv
X-Proofpoint-GUID: oQGcMkSD0WA0DUW7WV8bRBwB_Y_KXdGv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_09,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203030091
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/3/22 9:29 AM, Mykola Lysenko wrote:
> 
> 
>> On Mar 3, 2022, at 7:36 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 3/2/22 10:27 PM, Mykola Lysenko wrote:
>>> In send_signal, replace sleep with dummy cpu intensive computation
>>> to increase probability of child process being scheduled. Add few
>>> more asserts.
>>> In find_vma, reduce sample_freq as higher values may be rejected in
>>> some qemu setups, remove usleep and increase length of cpu intensive
>>> computation.
>>> In bpf_cookie, perf_link and perf_branches, reduce sample_freq as
>>> higher values may be rejected in some qemu setups
>>> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
>>> Acked-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>   .../selftests/bpf/prog_tests/bpf_cookie.c       |  2 +-
>>>   .../testing/selftests/bpf/prog_tests/find_vma.c | 13 ++++++++++---
>>>   .../selftests/bpf/prog_tests/perf_branches.c    |  4 ++--
>>>   .../selftests/bpf/prog_tests/perf_link.c        |  2 +-
>>>   .../selftests/bpf/prog_tests/send_signal.c      | 17 ++++++++++-------
>>>   .../selftests/bpf/progs/test_send_signal_kern.c |  2 +-
>>>   6 files changed, 25 insertions(+), 15 deletions(-)
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>>> index cd10df6cd0fc..0612e79a9281 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>>> @@ -199,7 +199,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>>>   	attr.type = PERF_TYPE_SOFTWARE;
>>>   	attr.config = PERF_COUNT_SW_CPU_CLOCK;
>>>   	attr.freq = 1;
>>> -	attr.sample_freq = 4000;
>>> +	attr.sample_freq = 1000;
>>>   	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>>>   	if (!ASSERT_GE(pfd, 0, "perf_fd"))
>>>   		goto cleanup;
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools/testing/selftests/bpf/prog_tests/find_vma.c
>>> index b74b3c0c555a..7cf4feb6464c 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
>>> @@ -30,12 +30,20 @@ static int open_pe(void)
>>>   	attr.type = PERF_TYPE_HARDWARE;
>>>   	attr.config = PERF_COUNT_HW_CPU_CYCLES;
>>>   	attr.freq = 1;
>>> -	attr.sample_freq = 4000;
>>> +	attr.sample_freq = 1000;
>>>   	pfd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
>>>     	return pfd >= 0 ? pfd : -errno;
>>>   }
>>>   +static bool find_vma_pe_condition(struct find_vma *skel)
>>> +{
>>> +	return skel->bss->found_vm_exec == 0 ||
>>> +		skel->data->find_addr_ret != 0 ||
>>
>> Should this not test for `skel->data->find_addr_ret == -1` ?
> 
> It seems that find_addr_ret changes value few times until it gets to 0. I added print statements when value is changed:
> 
> find_addr_ret -1 => initial value
> find_addr_ret -16 => -EBUSY
> find_addr_ret 0 => final value
> 
> Hence, in this case I think it is better to wait for the final value. We do have time out in the loop anyways (when “i" reaches 1bn), so test would not get stuck.

Thanks for the above information. I read the code again. I think it is 
more complicated than above. Let us look at the bpf program:

SEC("perf_event")
int handle_pe(void)
{
         struct task_struct *task = bpf_get_current_task_btf();
         struct callback_ctx data = {};

         if (task->pid != target_pid)
                 return 0;

         find_addr_ret = bpf_find_vma(task, addr, check_vma, &data, 0);

         /* In NMI, this should return -EBUSY, as the previous call is using
          * the irq_work.
          */
         find_zero_ret = bpf_find_vma(task, 0, check_vma, &data, 0);
         return 0;
}

Assuming task->pid == target_pid,
the first bpf program call should have
     find_addr_ret = 0     /* lock irq_work */
     find_zero_ret = -EBUSY

For the second bpf program call, there are two possibilities:
    . irq_work is unlocked, so the result will find_addr_ret = 0, 
find_zero_ret = -EBUSY
    . or irq_work is still locked, the result will be find_addr_ret = 
-EBUSY, find_zero_ret = -EBUSY

the third bpf program call will be similar to the second bpf program run.

So final validation check probably should check both 0 and -EBUSY
for find_addr_ret.

Leaving some time to potentially unlock the irq_work as in the original
code is still needed to prevent potential problem for the subsequent tests.

I think this patch can be broke into three separate commits:
   - find_vma fix
   - send_signal fix
   - other
to make changes a little bit focused.

> 
> TL:DR change in the test that prints these values
> 
> -       for (i = 0; i < 1000000000 && find_vma_pe_condition(skel); ++i)
> +       int find_addr_ret = -1;
> +       printf("find_addr_ret %d\n", skel->data->find_addr_ret);
> +
> +       for (i = 0; i < 1000000000 && find_vma_pe_condition(skel); ++i) {
> +               if (find_addr_ret != skel->data->find_addr_ret) {
> +                       find_addr_ret = skel->data->find_addr_ret;
> +                       printf("find_addr_ret %d\n", skel->data->find_addr_ret);
> +               }
>                  ++j;
> +       }
> +
> +       printf("find_addr_ret %d\n", skel->data->find_addr_ret);
> 
>>
>>> +		skel->data->find_zero_ret == -1 ||
>>> +		strcmp(skel->bss->d_iname, "test_progs") != 0;
>>> +}
>>> +
>> Thanks,
>> Daniel
> 
