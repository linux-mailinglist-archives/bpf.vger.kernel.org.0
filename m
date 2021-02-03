Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528EE30E086
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 18:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhBCRIW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 12:08:22 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24580 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229902AbhBCRIU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Feb 2021 12:08:20 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113H3np9017235;
        Wed, 3 Feb 2021 09:07:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GfZRhXYCfpRDO9V58bFHGBwfsQwIv0U8zCVh1k5h1zc=;
 b=pB6wo5UF+u7l5+0HohvHAyCq7WZVSA+xaSSxFc5NuF+NPEkBgqBacFHsBQVG+Al0z/Rg
 eqsiBJ1rtlLd98OE5/vmrooFOnQDfMW37u6IpyqQK0LYTHP371FEUt7Mpd2Nz9ITuBPO
 cSuV7fVE46WKx8g7RSPoT8MBnMGIkiwemZ4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36fcrb5nm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Feb 2021 09:07:22 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 3 Feb 2021 09:07:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsSRP3RSQSFf+X3MniZUXbedzB1QCaCzeuI240pt/7PqD07CrxR5PmHmk0nHSFwXnZiOopzSK8exoL1bfmljV0WTGa/0dve6UCBld0IQKvqLUQsQ+yL5DbBZ2l8MA1l6qPlDIEayi6pXsouUiwpjUfmLj09IG72c90k2hWnaavVp5QvfTfDDBgmkosRyod7x7kQDwkfj6lPmglYLHQQVm09UR17JhZIVP7khHPVS55201lw2Pc1RpAqO4XKk9dFfI9mlazoy8x806lHnUj3GmSQIXPeoO4cXiH6WG9d4+We4iw3E+Yd39d7kNkT0R1IPY0apxkvQlFMyXkY0cC7Pmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfZRhXYCfpRDO9V58bFHGBwfsQwIv0U8zCVh1k5h1zc=;
 b=XWTDrlNeS03x098fYjBaIrs3TvEQNdvPHNKBbr8UG7d6y64nGRONvSlOrrTOC0b3/GbNCiKT/iIuUn46L8fpFoBkqi3wtCdC2kUq2iYZnLjEHZbSA3Lbc7JMeAXukU7x7jTEJTqC3U7GmEzle09LCuj316NKBsG6sZAalXQ3zJyM/oG4K2XLFB/zBwfsMYQGmTVqS7h0p8Q/Y79s2ZDG56qCg9KCV6Ajn8ieYexq2PfCkqYGCEjvGzyu+Xk0aPKB6EHfL9vbjRRRxE64prPYZeEoVRG+9sWmUZDjKWf93AHH8Epi3+T2rePGR5YnouxlRqYtiVHWw22JjKSzsbm07g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfZRhXYCfpRDO9V58bFHGBwfsQwIv0U8zCVh1k5h1zc=;
 b=BFy664jrFw26qjY+trIhf/KlYtt9OCdOFc9jI2uume3Jgh29LLm/7pfStn/siZUn4c/CcOgw6WekpnwFqVcl7p0DV8ynxPMc/4KIzCS3Mn+ey4sy5cDptWILXz4FM7eVj+LoH5LdHZHL7SW55Pczf8fjsXYiArZH4gPOsgXPNLc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB4117.namprd15.prod.outlook.com (2603:10b6:a02:c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Wed, 3 Feb
 2021 17:07:19 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 17:07:19 +0000
Subject: Re: [PATCH bpf-next v3] bpf: Propagate stack bounds to registers in
 atomics w/ BPF_FETCH
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        John Fastabend <john.fastabend@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <20210202135002.4024825-1-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3160ff36-3f5b-e278-0ce8-b5a4aa61417f@fb.com>
Date:   Wed, 3 Feb 2021 09:07:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <20210202135002.4024825-1-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:dca2]
X-ClientProxiedBy: MWHPR11CA0032.namprd11.prod.outlook.com
 (2603:10b6:300:115::18) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::11fb] (2620:10d:c090:400::5:dca2) by MWHPR11CA0032.namprd11.prod.outlook.com (2603:10b6:300:115::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 17:07:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e5f5152-b605-4fed-6916-08d8c8662a30
X-MS-TrafficTypeDiagnostic: BYAPR15MB4117:
X-Microsoft-Antispam-PRVS: <BYAPR15MB4117C38F0D017E6ADD36DC5CD3B49@BYAPR15MB4117.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXobholqd+sOkvnzXJeT4yoj5IJga2yDxCgUafDv0b0jwHQa11Glimvre1Y1/pid4OIYVVQKOzlRMBE5Irgq1Pmj6Q/50NEW3GW0a2/a0QVqj7wVuR8mEMfJS7H4KrpQdq0b67HG5TCbyS25qyyIFtMCWORs6C+ARGt2ezImAWEumHqJpaJhZrcNPtFL6cwkmcNbQvnFYBCnXK8UUgCWNkQ2OVS6KdP05PBMLzLGiDGVkqnSGrXy1wRvIRPJoiyXsj58guftQvmJjasXop08pu/KjyZr0Ux6Ox+XDmrJUOEckn6w+aUXRi9TPgw4OmR/FPg2OQ3lWbBLwEZbeUi+GViNFCSry3Hym/pE6iAU/IRrdxNzqnLPSdwV9+Yt/dzf4ruqE2peD7R7tH3ZA4hG0Dh3IaOlPz1kahSLbENJPgvc3AZ9w0aIWb7iOsW4vHcZKRfHuB2qSgogYNIz70NdfMqCL5GqkUGXosBjHrSuUGvjEXXYccGee0ifeBBg9AeUo1nd7KpaavmDovmVq2IqhyVGe4d+mtxbEw7OC4lAXQFUGonRkTVcQRimtkmbehVgIlMHA5cXXUcWglJc2aeHcGNkRE5KMLNFhE/E3KqWXnLslly/HNI5kRjFFOXPkGvgU/YvK+zkx11yVUVGn8NxOz9XcZWn52pC0EYw0Tfu2Jw8zFONsWROMIw8oSjmuj1I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(376002)(346002)(396003)(31696002)(478600001)(186003)(86362001)(53546011)(16526019)(36756003)(966005)(66946007)(4326008)(316002)(31686004)(66476007)(66556008)(54906003)(2616005)(83380400001)(5660300002)(2906002)(8676002)(6486002)(8936002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZnhlSk0zNWV0TVErbkd4UFJNYnEwcG5jT0JvZVpIL0NhUnJFUDNMSjk1ZWdr?=
 =?utf-8?B?MmVYWXdsWE9MQjZ5TzhGRTYreU0xYmp0V1VKeXZYVUR3ZldQYitNTlg2T2NC?=
 =?utf-8?B?cVVBRmswN09ycVdmZVkzWXV4Y0ZFL3psV3dnSWYrS1RCOW1FdkxJd2p6OSs3?=
 =?utf-8?B?UFJwMThGVDhtQUdic1JON2tnMTF4bVEyN2pjaTRDVVBKRWl4U1pMeWs1Qkti?=
 =?utf-8?B?N3V5WVpLM2ZIa1IxM2xxN3Z1ZW03NGRYaFNjUnRuUkp0cmVhWHRnYmVPcUx4?=
 =?utf-8?B?bjFnSWRRbUpSNGpKMWFIY0Vmb2d1VGZaNGJWZi9Qa0gvOGNTTWQySXNUVjFt?=
 =?utf-8?B?V2VKVy91aHdSWHRFMGFxdHBtRGRWZFNWWC8rNHFZckVVT2U3bE5RKzRwd3pS?=
 =?utf-8?B?K2JzQzRkS0drdnlUeWhhT3hSeWJDSVoweVpONXkvUkpXbnhCcFd2OXVCQjNs?=
 =?utf-8?B?WkliM00zQnlrWUVqNzFwdVVXbVFFVkduaWUxWDRKZWtaSEdDUWZHVHNzZmRV?=
 =?utf-8?B?TjRPb0RUODhkMVB3V29kL1EwRHpYcjIwZzA2NkpLQnFIdFNyZFNiRVR1WEFa?=
 =?utf-8?B?TlUyOThLNTJ6amNHcSs1dTU2THRLcndhd01sekN3SGZmWWtwVmIwcG9XNE8v?=
 =?utf-8?B?eWI0UkUyOEdXQ3pIMVZBQit0bG5obXpURlRtK3ZTWWNOdFU3K2pZcFlUODBH?=
 =?utf-8?B?WG9BdERsVDYrVlNaMTJaa3IxSGxCS09oOHdNa1BIM2VIWkM3TmtiNDlkUmJY?=
 =?utf-8?B?MjVlZ3lUMHlwWWJjZEp5alYzWVZKdkJwRFNMQmVIZGhLS2JURmo4c2p3VHh3?=
 =?utf-8?B?cjlNVktHUWYraFpSNU1oUlN3K1NOZjhLdEF0NERubjg1ZmM3N0NDbWJMb08r?=
 =?utf-8?B?ZU5sNnM3c0tTekI5bzFvTFRkaHdZRjBDWm9XYS9zVitGVUZ6aEF6aUd6WmdQ?=
 =?utf-8?B?dU9CUjFWMnVUcS9LT09JVEp5NmRweGZMS2Z3czNVZWhOV09aM2dLRXE2Yyth?=
 =?utf-8?B?b0JTU29leTYrUGZUYis2b1FVQUhkYTdwemh3WjlrclNtWmRLY1lwSHNmVEJp?=
 =?utf-8?B?WDVqNVp5d3Rlem5QZlVuQ3RUSGV6WWxBYXc4bFM0V2FJVll0THF0RFUyQmpH?=
 =?utf-8?B?VnpHeXBPY0I1djB1L3hRaUZvS1N5Qjg3K2gvUlhrYkFLN0pxSk1YcHZPV24y?=
 =?utf-8?B?ZFpyWXYybk5jaGxqUmxvdERkMUx1SERkYWxaMFk2RTIzWEgyb2kwNWhBL21j?=
 =?utf-8?B?ZndHQ3NuWHB4SE1sUnErM21FWVdpWXZnVnJnblpWRU9jMGc5WFpSRU03eGla?=
 =?utf-8?B?V29OVUpSeFhUZkk1ckpRU2NRbkFJSnAxcnhZc3RDc2J0U3diaG10K05STDlp?=
 =?utf-8?B?WnFKczhpVU85VWsyVHhHbDlpM3k2U3NWR01mL2JlbG92ZkFvS2NXYkd1SWZ6?=
 =?utf-8?B?cnhHdDZJWXVnM3Y3NCtOT1BKMGt4UWtmelFnZzI0cHFNTjJJWUlpc2YramxV?=
 =?utf-8?B?eWNweDh0WGRwQmpXdUtIU0JqWDFmNWlFYjdHaFJNN1FHRGp2eHh3cHdid2gv?=
 =?utf-8?B?OU5GeFZXb1pSQndjclZJY3pDMldoN2lPK3NuUGErZDlVVU9nTHJiQkJ6djU0?=
 =?utf-8?B?UDNzU1ZyU0JCS0w4eXgvbHV2VEhCajAxZWNGdHJiZ05TS1JpaU1TUmZwVkty?=
 =?utf-8?B?empiVitUb2NhYTN0a3dneTUvTm1Ga1NaOW1tY2VQV1BlZjFEWlM0eFhjUTV1?=
 =?utf-8?B?cEVJRG1iQzRzcmgySk8vMmFzMVNLS013cDVPQlhkNElBMjdoMXJKaFdGdGpY?=
 =?utf-8?B?Rk50dTJGZ1pZYlc1cytrUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5f5152-b605-4fed-6916-08d8c8662a30
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 17:07:19.5618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FQJyYMfmcxB20cDuKpq68vtpSL4dagaN9/i2spt9U/VRFkoHAKYCBJ3lF8r5W2h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4117
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-03_06:2021-02-03,2021-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/2/21 5:50 AM, Brendan Jackman wrote:
> When BPF_FETCH is set, atomic instructions load a value from memory
> into a register. The current verifier code first checks via
> check_mem_access whether we can access the memory, and then checks
> via check_reg_arg whether we can write into the register.
> 
> For loads, check_reg_arg has the side-effect of marking the
> register's value as unkonwn, and check_mem_access has the side effect
> of propagating bounds from memory to the register. This currently only
> takes effect for stack memory.
> 
> Therefore with the current order, bounds information is thrown away,
> but by simply reversing the order of check_reg_arg
> vs. check_mem_access, we can instead propagate bounds smartly.
> 
> A simple test is added with an infinite loop that can only be proved
> unreachable if this propagation is present. This is implemented both
> with C and directly in test_verifier using assembly.
> 
> Suggested-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Ack with a nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
> 
> Difference from v2->v3 [1]:
> 
>   * Fixed missing ENABLE_ATOMICS_TESTS check.
> 
> Difference from v1->v2:
> 
>   * Reworked commit message to clarify this only affects stack memory
>   * Added the Suggested-by
>   * Added a C-based test.
> 
> [1]: https://lore.kernel.org/bpf/CA+i-1C2ZWUbGxWJ8kAxbri9rBboyuMaVj_BBhg+2Zf_Su9BOJA@mail.gmail.com/T/#t
> 
>   kernel/bpf/verifier.c                         | 32 +++++++++++--------
>   .../selftests/bpf/prog_tests/atomic_bounds.c  | 15 +++++++++
>   .../selftests/bpf/progs/atomic_bounds.c       | 24 ++++++++++++++
>   .../selftests/bpf/verifier/atomic_bounds.c    | 27 ++++++++++++++++
>   4 files changed, 84 insertions(+), 14 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
>   create mode 100644 tools/testing/selftests/bpf/progs/atomic_bounds.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_bounds.c
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 972fc38eb62d..5e09632efddb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3665,9 +3665,26 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>   		return -EACCES;
>   	}
> 
> +	if (insn->imm & BPF_FETCH) {
> +		if (insn->imm == BPF_CMPXCHG)
> +			load_reg = BPF_REG_0;
> +		else
> +			load_reg = insn->src_reg;
> +
> +		/* check and record load of old value */
> +		err = check_reg_arg(env, load_reg, DST_OP);
> +		if (err)
> +			return err;
> +	} else {
> +		/* This instruction accesses a memory location but doesn't
> +		 * actually load it into a register.
> +		 */
> +		load_reg = -1;
> +	}
> +
>   	/* check whether we can read the memory */
>   	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> -			       BPF_SIZE(insn->code), BPF_READ, -1, true);
> +			       BPF_SIZE(insn->code), BPF_READ, load_reg, true);
>   	if (err)
>   		return err;
> 
> @@ -3677,19 +3694,6 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>   	if (err)
>   		return err;
> 
> -	if (!(insn->imm & BPF_FETCH))
> -		return 0;
> -
> -	if (insn->imm == BPF_CMPXCHG)
> -		load_reg = BPF_REG_0;
> -	else
> -		load_reg = insn->src_reg;
> -
> -	/* check and record load of old value */
> -	err = check_reg_arg(env, load_reg, DST_OP);
> -	if (err)
> -		return err;
> -
>   	return 0;
>   }
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c b/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
> new file mode 100644
> index 000000000000..addf127068e4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +
> +#include "atomic_bounds.skel.h"
> +
> +void test_atomic_bounds(void)
> +{
> +	struct atomic_bounds *skel;
> +	__u32 duration = 0;
> +
> +	skel = atomic_bounds__open_and_load();
> +	if (CHECK(!skel, "skel_load", "couldn't load program\n"))
> +		return;

You are missing
	atomic_bounds__destroy(skel);
here.

> +}
> diff --git a/tools/testing/selftests/bpf/progs/atomic_bounds.c b/tools/testing/selftests/bpf/progs/atomic_bounds.c
> new file mode 100644
> index 000000000000..e5fff7fc7f8f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/atomic_bounds.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <stdbool.h>
> +
> +#ifdef ENABLE_ATOMICS_TESTS
> +bool skip_tests __attribute((__section__(".data"))) = false;
> +#else
> +bool skip_tests = true;
> +#endif
> +
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(sub, int x)
> +{
> +#ifdef ENABLE_ATOMICS_TESTS
> +	int a = 0;
> +	int b = __sync_fetch_and_add(&a, 1);
> +	/* b is certainly 0 here. Can the verifier tell? */
> +	while (b)
> +		continue;
> +#endif
> +	return 0;
> +}
[...]
