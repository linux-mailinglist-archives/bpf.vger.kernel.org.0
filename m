Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079C21EA698
	for <lists+bpf@lfdr.de>; Mon,  1 Jun 2020 17:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgFAPNr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jun 2020 11:13:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34240 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbgFAPNr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Jun 2020 11:13:47 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 051F7bK2013408;
        Mon, 1 Jun 2020 08:13:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GEl4Q+k5Yb4CA6FNH8nOuh4pNTllajYNeUb1nSAgEKU=;
 b=IvIyRq7Iytj/0SBtYfEqIgA1i7zWnXZCg/7Musrp4f5EZWRiuvTuv5NuDGrUpGS/hDu6
 c5jCsAPv+OC6aRgjoSbnHFv76UvOHM2jec5OEQTUSai9ipbMwSy/eYiKAHhxd394rhQ1
 2Fq9mHeVfxYnCj6RHTf26Y/rEeJlZjNYlVw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 31bk5n4wk3-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 01 Jun 2020 08:13:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 1 Jun 2020 08:13:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mdw7VmNLq9CUaOl0AcAOl/lHhi7O2ENuZG3ihRc1qQunA+xpIALvdckBIr1dXrAAdbOBIPFCIBjjDG9AVjBsmKqZ26Y/PENhKmVI8lpiqJnc+THl8YWcNhU/ltyL3z28SGe98yaYVQ9nXWf1Tj0c5bsZA9iRRrrsd2KI32a5hTdEKxWe2F6bk4q4FdyvNoema9+Rn4fU4l2X9kb1rmmDObp7hlRtdFaEA3hVGH/NTL0fC4PColXPZPYsm3V2NhNzXNxcIeyCONzCKXjDFc9N+3qQqcvu6mVtQSvSDfpTKQ2fjCf/FRppYBe78Drf49cN+PYDM8wjuLANyQGukjgSng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEl4Q+k5Yb4CA6FNH8nOuh4pNTllajYNeUb1nSAgEKU=;
 b=SSPUAdADRbVUGmfbuSCihjVqQpl2KLEmoUhD/4CiLZCmkdCjNydHvGY77DkZ9sJDhHXHzZ27pdhGUuqo+ZjE52bLUK5S//wL4O7LBKsISraUd7G1PbSLyXX5z0SSM34Cfq8f5jxC+MC3zACHZ5K2D3+pFeLk6CUig44wVZQnmsFuheL+jRQESSLB9tbM3J1epXMZfFHCY5ttCiCDrBhxMbDlzCQOFVUHMwcMsZYRQhnozUByp55mvRkW0mVUIwHmacwS8VBLMSE0shF3ZFOOwTxvuHGwgUKX+jjdrxT/CsuLuG3gLClDLLeMItaA3XNQAFCGlMiIlz/PXLViXQOoLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEl4Q+k5Yb4CA6FNH8nOuh4pNTllajYNeUb1nSAgEKU=;
 b=kC/03vjjgdYbPwQvXopaxAJEY7v9SyRpUXlKEznWFdzaB5Oyp7k1WiFbwKfp8l6S0FofFMbm6S2UVX7KFAAan/tiZB/oYqZWlEZ8YUkIYYIq/E4O2tSQ3MG07V2dxd7UkNowbia4FkJkHgU37sQryVIw3ErCXDALGQNrcNO7qMo=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2952.namprd15.prod.outlook.com (2603:10b6:a03:f9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Mon, 1 Jun
 2020 15:13:43 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 15:13:43 +0000
Subject: Re: Trouble running bpf_iter tests
To:     Lorenz Bauer <lmb@cloudflare.com>, bpf <bpf@vger.kernel.org>
CC:     kernel-team <kernel-team@cloudflare.com>
References: <CACAyw99G8vWfZAxy5ohapnTgwndzDrBeTARvxyrO6xopoW98yQ@mail.gmail.com>
 <CACAyw98Stt_Ch3nFZ26UO9qDoCL46w-bt73G==NH=bMieCwBPw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <cf3ee3cc-9095-3bac-0210-51b866b115db@fb.com>
Date:   Mon, 1 Jun 2020 08:13:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
In-Reply-To: <CACAyw98Stt_Ch3nFZ26UO9qDoCL46w-bt73G==NH=bMieCwBPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR02CA0062.namprd02.prod.outlook.com
 (2603:10b6:a03:54::39) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::110b] (2620:10d:c090:400::5:bd91) by BYAPR02CA0062.namprd02.prod.outlook.com (2603:10b6:a03:54::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Mon, 1 Jun 2020 15:13:43 +0000
X-Originating-IP: [2620:10d:c090:400::5:bd91]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9aa575f-33a0-4eba-0dca-08d8063e5fb9
X-MS-TrafficTypeDiagnostic: BYAPR15MB2952:
X-Microsoft-Antispam-PRVS: <BYAPR15MB295216839B701CFBD65B670DD38A0@BYAPR15MB2952.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gZNIw4kv7ntmqw2dO7/AunX+1cJZWZTmIt/uDBIg8bRxAvgDdEsj2iYWizY+q/r6PFlrEZH9y7D6AYb6Pm7C26tEMnBsyIQarSLaMs8ZeXuBx7CRDWqDmYr2Vs6z3yp7U3Bl42FyFq7X8koHBSWmo1cM7ASeMmC4v0OkpujEMhkSoMMTmsqpKALR07r7wrDs321FuYAyZZF5IgkP6bYH44bPRC3ZRDeXDP+ShOgPuDiFxd0T2uWCdyqqY98gjz572kF9uzO6iImID2UdMwceMRtT7cowPjfUiP5BjOBwMHJolYlCxotlo0p3grMtquxezIY6CHoSKUtY5ZQC8xui0WdhV6GUvhsGPwiCiGceoPXI0tUlhPrTBYmgcrSRmAoi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(39860400002)(396003)(376002)(366004)(110136005)(316002)(2906002)(83380400001)(8936002)(2616005)(186003)(478600001)(66476007)(52116002)(66556008)(66946007)(5660300002)(31686004)(16526019)(6486002)(53546011)(8676002)(86362001)(31696002)(36756003)(4326008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: r8pPEd0IzTigZVB+0FupRT6am+og91H4CQFQ4Q2e9/oZ+rxR8DZn7YytslUe34/ptajFpHAauhQGTH+lGEt63dDd9KUn+HZkHOJmSrLeQfNc1lldzWGcPcuHZNofkb7f+a+wfCc0YaYyQlc89GyVFrzZPdDfcM0YRJSlEYj9ZSRbm49FhqK+VIbYtA0DodOCKqOrf1O6en4CTmNFHC4eedEYvI5T4A1X9LlG5Rlod0BdSc3q+UQjMBJ5g8MKicMhrYd9riNAexS5s+ovMwxQX7r61/lC9g3UfYpmTnr8+4hqlZsbBGEjO+feTK+A29+Q2zC72CrlAXans9qkf8/pqcXF26cDnohfJleOeCFEXSEq7sda+Baqlii4ny8VI7UfDCa/QRANsQ6nBReE4YfQLt55OotWV9yoafvMYLzNEVWRc3ThzoKfSoXrCG8MS0KpkxV9kWE/x63W5Du19jXdtW0pT0NeVkSOHMm0upeQqjeQrwAFwQ8wzMB2HOjH0xD9DkLqE401Iu1yVi6FhbAvWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e9aa575f-33a0-4eba-0dca-08d8063e5fb9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 15:13:43.7866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGN3RDB/mxrQqEqBFi/ZOym4JSNkdELPLJcLTyaLgqGISLUx6iRH98tyPj56lkfT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2952
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-01_11:2020-06-01,2020-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxlogscore=999 cotscore=-2147483648 phishscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006010112
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 6/1/20 7:42 AM, Lorenz Bauer wrote:
> For some reason the initial e-mail wasn't plain text, apologies.
>
> ---------- Forwarded message ---------
> From: Lorenz Bauer <lmb@cloudflare.com>
> Date: Mon, 1 Jun 2020 at 15:32
> Subject: Trouble running bpf_iter tests
> To: Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
> Cc: kernel-team <kernel-team@cloudflare.com>
>
>
> Hi Yonghong,
>
> I'm having trouble running the bpf_iter tests on bpf-next at 551f08b1d8eadbc.
> On a freshly built kernel running in a VM I get the following:
>
>      root@vm:/home/lorenz/dev/bpf-next/tools/testing/selftests/bpf#
> ./test_progs -t bpf_iter
> 510 bits_offset=640
>      #3/1 btf_id_or_null:OK
>      libbpf: failed to open system Kconfig
>      libbpf: failed to load object 'bpf_iter_ipv6_route'
>      libbpf: failed to load BPF skeleton 'bpf_iter_ipv6_route': -22
>      test_ipv6_route:FAIL:bpf_iter_ipv6_route__open_and_load skeleton
> open_and_load failed1510 bits_offset=1024
>      #3/2 ipv6_route:FAIL
>      libbpf: netlink is not found in vmlinux BTF
>      libbpf: failed to load object 'bpf_iter_netlink'
>      libbpf: failed to load BPF skeleton 'bpf_iter_netlink': -2
>      test_netlink:FAIL:bpf_iter_netlink__open_and_load skeleton
> open_and_load failed1510 bits_offset=1408
>      #3/3 netlink:FAIL
>      libbpf: bpf_map is not found in vmlinux BTF
>      libbpf: failed to load object 'bpf_iter_bpf_map'
>      libbpf: failed to load BPF skeleton 'bpf_iter_bpf_map': -2
>      test_bpf_map:FAIL:bpf_iter_bpf_map__open_and_load skeleton
> open_and_load failed
>      #3/4 bpf_map:FAIL
>      ....
>      #3 bpf_iter:FAIL
>      Summary: 0/1 PASSED, 0 SKIPPED, 12 FAILED
>
> If I understand correctly, this is because there is no function
> information for bpf_iter_bpf_map
> present in my /sys/kernel/btf/vmlinux:
>
>      # ./bpftool btf dump file /sys/kernel/btf/vmlinux format raw |
> grep bpf_iter_bpf_map
>      #

Yes, this is the reason.

>
> There is an entry in /proc/kallsyms however:
>
>      # grep bpf_iter_bpf_map /proc/kallsyms
>      ffffffff826b2f13 T bpf_iter_bpf_map
That means the kernel actually haves the right information.
>
> And other bpf_iter related symbols are available in BTF:
>
>      # ./bpftool btf dump file /sys/kernel/btf/vmlinux format raw |
> grep bpf_iter_
>      [12602] TYPEDEF 'bpf_iter_init_seq_priv_t' type_id=9310
>      [12603] TYPEDEF 'bpf_iter_fini_seq_priv_t' type_id=352
>      [12604] STRUCT 'bpf_iter_reg' size=56 vlen=7
>      [12608] STRUCT 'bpf_iter_meta' size=24 vlen=3
>      [12609] STRUCT 'bpf_iter_target_info' size=32 vlen=3
>      [12611] STRUCT 'bpf_iter_link' size=72 vlen=2
>      [12613] STRUCT 'bpf_iter_priv_data' size=40 vlen=6
>      [12617] STRUCT 'bpf_iter_seq_map_info' size=4 vlen=1
>      [12620] STRUCT 'bpf_iter__bpf_map' size=16 vlen=2
>      [12622] STRUCT 'bpf_iter_seq_task_common' size=8 vlen=1
>      [12623] STRUCT 'bpf_iter_seq_task_info' size=16 vlen=2
>      [12625] STRUCT 'bpf_iter__task' size=16 vlen=2
>      [12626] STRUCT 'bpf_iter_seq_task_file_info' size=32 vlen=5
>      [12628] STRUCT 'bpf_iter__task_file' size=32 vlen=4
>      [25591] STRUCT 'bpf_iter__netlink' size=16 vlen=2
>      [27509] STRUCT 'bpf_iter__ipv6_route' size=16 vlen=2
>
> Can you help me make this work?

Looks like you have old pahole in your system. You need pahole 1.16 or later

to enable global functions emitted to vmlinux BTF. Could you give a try?

>
> Thanks
> Lorenz
>
