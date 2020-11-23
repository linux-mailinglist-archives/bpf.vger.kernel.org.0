Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15362C0095
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 08:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKWHWR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 02:22:17 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60294 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725320AbgKWHWR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Nov 2020 02:22:17 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AN7Frm2019138;
        Sun, 22 Nov 2020 23:22:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=T1LC81elCWSxW9ncYujHvaHj/NKGpKtk0yz6/X/0NXM=;
 b=qx0CXPygncfkVF49ritrq+wsseFda334QDhwsufCc5MyxNTSb2vq02Rp/Ys5u9N3A77R
 ok9lMfOvhFp0E6YQ2QTGKZzaWaPL+acFOijNRMoJw1f9zncs/jUZcoeAG4T3BSBd3Hwi
 invhYvHxin8qvOvO/mYQC8ayOmFMA9uxlyw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34yk8yu6my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 22 Nov 2020 23:22:15 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 22 Nov 2020 23:22:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf8QJv5tXoSZIdZgtIQNFqval4h9r1CShmlIhBnHNagUtMXMU5sJ8UzRL60a9vUNtnrlTPfjyGsDTn8WBiHr1eb1ZPzwqVkRZNAKhOEAslOONuEN6HpqJ5UQBsJSOtq3KhHgsKwaI6hZO9f5FHOzd6fkKwtJNhyhLEP3GCAiWT2PRElpuwV6DSBnGA+1tHcJT44V+HZOaoOh5bCv8FD7vyno7I49WzM1JFMTkK6MfVdhVX+rNQcmz2LwDG2oz6O/7A/kVtlf8HJqVlnJMsBW+ZaWkTILWFQneNsAkQldc0nGKrawhhxvQb3mGbCJl8WnvB3VrGJ+fg7eBEEjfF/53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbi3xMHza05aMj+MT0Ihx3BINxkrSw2CJkCd3G1vrXo=;
 b=YLzzDjXpKrv7VaKh970+7G6tlKZNTm8EwPVTxpcAPycX1dgOK48x8wr/19x0q2KemoJrBytm8RPnxq4oCOKpivlIwmrhtygPJg6YxNVoZxCoSImBMcqSpdXoFgZrndjgotD32tv5181ibDwSMJLOf0W+qnYZ7qihECR1cnBKXE6eCq0UyiVsliILSOhZUQ3CVbeDqDVROKq4pdlH0bEmqI+x74hJCiftnCHrZOqCNzFqrP3TpzbMHnMN3aHosV4/CRnj3y/vo1oyCIqAdWJkV6lfaibqwLMT6CDNmrtUErL+oVk/NUl+v145btae6Tfa3QmIiqc6CiS+G4EhgU6vLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbi3xMHza05aMj+MT0Ihx3BINxkrSw2CJkCd3G1vrXo=;
 b=HVcW5Ec78cifQX1GgNj2MXnahKFdy5Cbk4PIJCH2IloO4YKeqVOFR2nIrAL3BL4s/W3Fk9+Zkj2nXsZws/H8Z/Tf6a04URX1mIoqVHZMQ1JgWWmZtSRoYLQhwIXfNK0c6TjO+7wCUPDZXXLPE9SclF3uhymoy52IP1bKCZgA9SA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2839.namprd15.prod.outlook.com (2603:10b6:a03:fd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Mon, 23 Nov
 2020 07:22:13 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3589.029; Mon, 23 Nov 2020
 07:22:13 +0000
Subject: Re: [PATCH bpf-next 2/2] selftest/bpf: fix rst formatting in readme
To:     Andrei Matei <andreimatei1@gmail.com>, <bpf@vger.kernel.org>
References: <20201122022205.57229-1-andreimatei1@gmail.com>
 <20201122022205.57229-2-andreimatei1@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <dbb95d56-0700-c8b6-1f6b-d632144075bb@fb.com>
Date:   Sun, 22 Nov 2020 23:22:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <20201122022205.57229-2-andreimatei1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:162c]
X-ClientProxiedBy: MWHPR14CA0025.namprd14.prod.outlook.com
 (2603:10b6:300:12b::11) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::100e] (2620:10d:c090:400::5:162c) by MWHPR14CA0025.namprd14.prod.outlook.com (2603:10b6:300:12b::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 07:22:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6391e146-8589-4a25-c46a-08d88f807f03
X-MS-TrafficTypeDiagnostic: BYAPR15MB2839:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2839397A4AAB68C2DA5C6D11D3FC0@BYAPR15MB2839.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8Hgplf1YJwrNOYqJfaRur8E815miW6uv1F8XelpMc7utJQvBHWxCeVw/Pix+bvzAf6kb3mkzO+ihuyI1bLYpj9F/fmLnbFHdO2nB1GksKvag0ZilVT5gSudLnVGr30DtVu98zOsnGK7InGOtNNSBGM/TmasA/CbYLk9acu+o+LzUq1szcWNiScdLmU9Q5b0/dkoGU+LFOAXgSDZ/GhhePrzzJTAyd092MDe2b8slPG88gT6kbw3VLhYMWFo2K62550+WmT4+RZUx3dOLKOjvev3zVKmtVzK45zPpBi6O6/M1/VXfTMX8PvfYDy0B+Z4AnXonFdDR1111EqtfwDa+Y9YJdlsD+rc+yCBhQ0cACUVQUKc/9qHbgWamnaIHO4lF8VSjkPYyGbUE6VISe7Rllh2XRHikutfrDgLf+gs6byXIPw9gp6RK121qkwBMy6JqSQxK+lRj/4dmn1Jq4et3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39860400002)(376002)(136003)(52116002)(36756003)(2906002)(31686004)(83380400001)(6486002)(316002)(186003)(86362001)(16526019)(53546011)(8936002)(8676002)(31696002)(966005)(66476007)(5660300002)(66946007)(66556008)(2616005)(478600001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vAF5wp3T9xs7ry62R5aj0EXXhYvtNOtYYwgXKz+zMRdFyWWpDnVCMM1N1RoyhP12bmREyC3zSopWMvg5P3HacoPht5WwI+8l8yZy8s54o05YJ/lCV7Ci4zV5pXzYRPOZsgJ0dBH9hZqAnUWV1ZefODgOFi5dPRd7T7N+qvaEK2Mkpf0qH4F9Ht0Ji8z/Pbhc92/fHqOSdQVekv33vMsxFZLW/z+5JhO3VQ2J3sbZaNdVtIK0jIg4C2hjUG+UwUsAtGkJ5Ox+7Yg95tPQpco91CoX04EeUiOXF5XHLyeVNa87bttoCvMSRw67+ecMvNoT4+XGmf2rhbajH3eyT6ONeVlRBJvHRKHPDaiHbK40gijAwsH/tAs8B36UpCSYBPUXYJYCDKnsNF1UGm9j5qPzGGVxnSyj1koesraTJSNN7IaVrNM+9Z8O7WvnNKwOGDHTX7w3IxD6UjOQDVMmFznyO12ou5resh+IyauQxBh2Vrrex7zh1n+oidF//8hR2XYMgNtUcXWkjCg5W3liuTtqt+SLH6tH+UryupXg03ukGKkvChhwLXw3BTbNAbgduvdwn8Jj4UfheNzI1Deyv/avjBBhXgJVlySVysNmcgDLJ6Cz7BrxjV+OGBniZIuGYtx9dfDfqRM1O3fNRlJjNaAeJy6kNFMXluNpbf30ciXpOI+19Jl4rL+ePmv0IsDuQUfhGAdFK39OU9cvfGDeH68PHNBeB05SEpEh72itECSNaKqW6vu2RsDJ9xQGmq81sUiZIkdRdka7b6vernYgujJ75u5gSeHTpPoByev4WTHQvfiLtlZeFTWWTvtuZTNqFrFOgvyytlQ96/hfXYaIGqKeemmtPoOiGhz84h/tmvjI98T4+PRn/OwU4t9y2QbsopFUpi3Za2xIdbvH2WkG172CSabgmDLRaxHOThdRUljzuZQ=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6391e146-8589-4a25-c46a-08d88f807f03
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 07:22:13.2738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOLA/4yWSbuFYj/A3bVGZqYa+MTEAcC48qWnYNaevQ7t8v62DUgVlZBbYhFnBe2Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2839
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 19 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_02:2020-11-20,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230050
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/21/20 6:22 PM, Andrei Matei wrote:
> A couple of places in the readme had invalid rst formatting causing the
> rendering to be off. This patch fixes them with minimal edits.
> 
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
>   tools/testing/selftests/bpf/README.rst | 28 ++++++++++++++------------
>   1 file changed, 15 insertions(+), 13 deletions(-)

I cannot apply patch #2 with my current bpf-next branch.

-bash-4.4$ git apply ~/p1.txt
-bash-4.4$ git apply ~/p2.txt
/home/yhs/p2.txt:34: trailing whitespace.
__ 
https://reviews.llvm.org/D85570 

/home/yhs/p2.txt:52: trailing whitespace.
__ 
https://reviews.llvm.org/D78466 

/home/yhs/p2.txt:70: trailing whitespace.
.. _0: 
https://reviews.llvm.org/D74572 

/home/yhs/p2.txt:71: trailing whitespace.
.. _1: 
https://reviews.llvm.org/D74668 

/home/yhs/p2.txt:72: trailing whitespace.
.. _2: 
https://reviews.llvm.org/D85174 

error: patch failed: tools/testing/selftests/bpf/README.rst:33
error: tools/testing/selftests/bpf/README.rst: patch does not apply
-bash-4.4$ git --version
git version 2.24.1
-bash-4.4$

Could you help check what is the issue? Maybe the links are presented
differently in the patch vs. in the README.rst?

> 
> diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
> index 3b8d8885892d..ca064180d4d0 100644
> --- a/tools/testing/selftests/bpf/README.rst
> +++ b/tools/testing/selftests/bpf/README.rst
> @@ -33,11 +33,12 @@ The verifier will reject such code with above error.
>   At insn 18 the r7 is indeed unbounded. The later insn 19 checks the bounds and
>   the insn 20 undoes map_value addition. It is currently impossible for the
>   verifier to understand such speculative pointer arithmetic.
> -Hence
> -    https://reviews.llvm.org/D85570
> -addresses it on the compiler side. It was committed on llvm 12.
> +Hence `this patch`__ addresses it on the compiler side. It was committed on llvm 12.
> +
> +__ https://reviews.llvm.org/D85570
>   
>   The corresponding C code
> +
>   .. code-block:: c
>   
>     for (int i = 0; i < MAX_CGROUPS_PATH_DEPTH; i++) {
> @@ -80,10 +81,11 @@ The symptom for ``bpf_iter/netlink`` looks like
>     17: (7b) *(u64 *)(r7 +0) = r2
>     only read is supported
>   
> -This is due to a llvm BPF backend bug. The fix
> -  https://reviews.llvm.org/D78466
> +This is due to a llvm BPF backend bug. `The fix`__
>   has been pushed to llvm 10.x release branch and will be
> -available in 10.0.1. The fix is available in llvm 11.0.0 trunk.
> +available in 10.0.1. The patch is available in llvm 11.0.0 trunk.
> +
> +__  https://reviews.llvm.org/D78466
>   
>   BPF CO-RE-based tests and Clang version
>   =======================================
> @@ -97,11 +99,11 @@ them to Clang/LLVM. These sub-tests are going to be skipped if Clang is too
>   old to support them, they shouldn't cause build failures or runtime test
>   failures:
>   
> -  - __builtin_btf_type_id() ([0], [1], [2]);
> -  - __builtin_preserve_type_info(), __builtin_preserve_enum_value() ([3], [4]).
> +- __builtin_btf_type_id() [0_, 1_, 2_];
> +- __builtin_preserve_type_info(), __builtin_preserve_enum_value() [3_, 4_].
>   
> -  [0] https://reviews.llvm.org/D74572
> -  [1] https://reviews.llvm.org/D74668
> -  [2] https://reviews.llvm.org/D85174
> -  [3] https://reviews.llvm.org/D83878
> -  [4] https://reviews.llvm.org/D83242
> +.. _0: https://reviews.llvm.org/D74572
> +.. _1: https://reviews.llvm.org/D74668
> +.. _2: https://reviews.llvm.org/D85174
> +.. _3: https://reviews.llvm.org/D83878
> +.. _4: https://reviews.llvm.org/D83242
> 
