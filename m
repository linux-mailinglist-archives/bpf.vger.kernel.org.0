Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6E04166D7
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 22:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhIWUm4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 16:42:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61816 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229609AbhIWUmz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Sep 2021 16:42:55 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18NKDO2e025954;
        Thu, 23 Sep 2021 13:41:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lp9LEjYv+PONu7bFhXt0gVOd7Vh7yyU4UJuc9zbgdO8=;
 b=CdQL4J56XOt7MtSkjkQJdtfdLqRl4vkIadhAaqs4m3pLjRiE1JoX4a0yKX71An+ah3YO
 FlTLrIXYQdWGCKbnqJLVygWJzG9y3YlVCisxWl4sz4iMYF+/I56Z5X3dWv9Q4k280fOZ
 zEexYOFc+e7Bv/nrsOTS0P7NJYzlVKlLHmE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3b8ds5y8u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Sep 2021 13:41:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 23 Sep 2021 13:41:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djGLzDzRsW2P+7jK+j4eaY6+wFDYYyEZKrhqSEzAmaTUjNMTFGPzYp52cQSobzGi5YefX3dxU1TOGOPMliCUEyXyQaN6Su/1WjrNaNxL6+uG/fHmnIpIlB1bcFb4FyQw8QDqkcP/SLQ64Sx2uW72Nq2tJsQwf6rB1dl8fcGlt3zdrN8TpFC2bPUb1CKZKOFWpDNcMw1OamjmdX61D5eWY9aXwHkUXbm6tCw0wtNhg80GHnaAMVhLUkbUhMPDRl0ERCkDo6fIbcVX8qc9JUTqVo/oqbdVVe1a7P2/0fJourkf1mB2SBu+PK7xrNJ9Zoq4UvQkqAUuzrYMVA2tI5aE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=lp9LEjYv+PONu7bFhXt0gVOd7Vh7yyU4UJuc9zbgdO8=;
 b=b4EKZG4teL4nPjYVfqHEmVkXQLwZm6YmgV1EBaXLmrCPB7ddLLZMprPRacDmlwBHwIrdQn7yTHYWy+Mt+YeeLNFAzH9feRhzNXcy7K808zuxgOi2qd1tXbxz5KNZVW9XqELL6fIQbu5kKzIK6P5O2wxonB9XTBT1cvgUJruanYMDynEnajQxp+TeK9udexr1qyCHoaGaKNbiUSj5ihD+su7d/h/Zyy0wwzWLjCqimdkIXVeid62/B2H7GFyhOg5+vDWcBF8ue3PIi/YHrrfKvGhDFqoLGXX6l2QaLJdUWo4olcKcqt+629ApgKlZAr/tgiRm8swtgGyyv+KDJ+0hFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB3212.namprd15.prod.outlook.com (2603:10b6:5:163::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Thu, 23 Sep
 2021 20:41:07 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 20:41:07 +0000
Message-ID: <32d5b675-7f54-f03c-8844-d0eb313ec1a5@fb.com>
Date:   Thu, 23 Sep 2021 16:41:05 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v3 bpf-next 7/9] libbpf: complete SEC() table unification
 for BPF_APROG_SEC/BPF_EAPROG_SEC
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210922234113.1965663-1-andrii@kernel.org>
 <20210922234113.1965663-8-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20210922234113.1965663-8-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::26) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c9::100f] (2620:10d:c091:480::1:3f18) by BLAP220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Thu, 23 Sep 2021 20:41:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fcccad7-6e59-4dc1-105e-08d97ed277fc
X-MS-TrafficTypeDiagnostic: DM6PR15MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB32120461DEEA0ED39E1C100BA0A39@DM6PR15MB3212.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Ge8Oo01asLrWJvxSCq6KmVSYEIktdEy1Sm+F7TX6CI/ULckxBosgGefwSDtYp1/LE/UXpngRpRsJv/pPRBWX1H6hpFPbT+YNTuYoHL1KS9D/fstSRqAAwxqvoFenxISThcEl/ifPqzFEqyq25K7wzM76x1hoxBe4MZxM8WqM+a3BlCcEPQtvJ8trgdNyCQUwv0KF2M20Rrqw8aiRoWNZeTEF2aIUH2Cwyili2kMEIi1f9BEdzhy/WZ80YiG1tthlnbeUyAzJaAicRah/GPTHVQr9NjUhHG3OlYhX+oS/RjmpmbOAOOgKij8y2KJcdO5zn86+18utNetUas29jeH5j0VB0CAhG5WdjZRqYVAfiwUCGNWqqS5z6fuwgdLIzb+Wsb7hY/4Jjsz3TPmCL1jzGX+gD2/2MeCJszaqT9of53sCRJCxXpu7ORNcSMbe0xNWDbaCgZ22DNlywc449KSBmYeAgq4dd2SJMofVsvVH9CUA5s05R/X/KBIDaEPww/QZM/gTnUHKyjYNKtAaUqkM/zk2pss8aUdqDceqLZYjaX+XSjGUyiOheXZNxoAoopxQs0HQIsXPh1N9Q/ax8ggc4D3oEuSMbYXbavE5iRuYPIrkXVvu/4d7wmmqro+ixv1aPM6G3gwCpIuZdHd6FMTfLlB9JTz6P/nT0NOvJ2skJZVGlhyHPTb6h3cKkYPdSuvrYhiotwCH8tF1gyfm3+KNTMKE5lRBTOGC2Q2K3fBjyo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(2616005)(31686004)(86362001)(83380400001)(66946007)(36756003)(66556008)(8676002)(4744005)(8936002)(66476007)(186003)(508600001)(316002)(53546011)(31696002)(38100700002)(5660300002)(4326008)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUUyN3JxYTdWbThXRFhaeEF3YkgxelJ6NU1VK1d3ZjBLTlRPNXFPajRlYmll?=
 =?utf-8?B?L2RIakNNWVhQanEwMVBIV2RFZEZZYkhUYjhsYkZ1MUpCWnUwY2RIRVpOVmdS?=
 =?utf-8?B?TkdpVWR0bWkwVFBLVS8zNk1CVkFRU0x2bWI0YWxiRGNKbFREU0dySWRENmRQ?=
 =?utf-8?B?cEhOcG5jZU0vNk9IMyttNW5YQ2Q3VEducElaeU1SZkN3T2VZMVVtS01nUC9r?=
 =?utf-8?B?ME9LK0dHUUR2REZsTVdUZGR3ZkdUL3dwLzlqeUpvaHpManFORVgvU05kaEJL?=
 =?utf-8?B?R1AxQWliWXFhRTg4cVNka3dSRjZEaURxSFNSRG44eExSNEU1czZuZjNuQy8z?=
 =?utf-8?B?TnVIUFA0L3g4MC8rVnFOb0hncDludlczLzViVURwYk92MXhtcjFWdkQwMEVI?=
 =?utf-8?B?bUFwdEhENElHM3BQejZFQ0Jzc3FZRWMzUGNnSS9ocU50Rm14SGRuVFlTV0k4?=
 =?utf-8?B?U3prQ0R4V2hqMGhiQVNTazZXTXUzNXc2MFBCM1lMei83b3p0Y00vcVF0Zm5U?=
 =?utf-8?B?cGw5b05sSzc0UGROSWZQVXlTdlFxVE1jbkZJM241cTltOEZnaDVsTUZQQU9n?=
 =?utf-8?B?b1ZTVDdJNmREdVpJUkFCUEd1cEg3OUpFR0E0WkJsd1phQ0NrVzhkcGd5Tlkz?=
 =?utf-8?B?RVhHVE9nQkNvVTk0cVZFWFBNMDA1RHhuQlg2NEtNbVRpclJoZkpMUzlXNTMr?=
 =?utf-8?B?OWJ2d0F0NEFXL2RFTThxcDk3VmxHRCswRUtGVTQwcWUzVUxmZUlsZnFIWlkx?=
 =?utf-8?B?OFJlK2o5N084TUFIbFg0R1AxbFdtdW5HMmdEOCtUVVZPMDNMalozMTJUSTZ6?=
 =?utf-8?B?OVNJN2U0TzJnbnFXemJwSG05UXpHcWNoR3FreTFUWUIrRGdQaVM5L1RrUkxR?=
 =?utf-8?B?VWZlbU5tVnBNZzBIS2t0V0xOd1R1RWtkRmhFRFhpZUREeCs0VVo3Z2luS3pC?=
 =?utf-8?B?dnhFekU4Ujl2Rmd2bXBibnBpM2xURXFwcVBmYWhJekVHUUN0eU85N1p2K2Mx?=
 =?utf-8?B?b3FzVEx5M1hNQllQdnZ6OFdsOWxzN0I3V0xNbUkvMk9Ub3ZCcDBTbmJkTWYy?=
 =?utf-8?B?RFNFRzAxSWpmbEZSMHRPeURLUTJtWkx0Vks4K0JjZ2pwdkJKS05QbU5MYmpk?=
 =?utf-8?B?N0oxT2J6dkI2UldtcXkrbGJBK281ZzNreHVEODRqbFk3NVlpZlhRMVRWd2tL?=
 =?utf-8?B?emM2eGZDV3BOdERqaUtETi9XLzh3V3d3SUU3VnRlRkdkQWR3TmxWdVI1R2No?=
 =?utf-8?B?MnczNmxFM3k3VEZUQjR4ODM4MEx3RWllSGVyTkFaUlFuOC94elZuU3B4OVV2?=
 =?utf-8?B?RkNxd0k0bzIyVE5hc0pjOUpiMCsweVgxcDM2TzI0RDVvc2xnSFI1YlFJdmM3?=
 =?utf-8?B?djYxZTF0aVQ0b3VNc1dEbERjL0JVUmFtNE1ZYlNPMVY0aTRBcXQwN0Y2Zm1W?=
 =?utf-8?B?YTl3alV3V3g1VUt3cm1iTkR3WENObmx6UDJVb21UTFFiSUVXdldKRFZUMnR1?=
 =?utf-8?B?VllYeStyOVk4elhuVEVEZ25HK0dOZW9Gb0d0MU9iS1Y0UGNmRVBpUnk3dG4v?=
 =?utf-8?B?d1lBUlpaMFRnTDIyZkdpaE9KODdINmREaU1xeUlBaDFuVHBQaGhiRCs0SEdB?=
 =?utf-8?B?bDZKaU9zVmNUWEhNeWVNeEszRmllblNTdDhPOHpLY1J0VW5UeFozWXdUckI4?=
 =?utf-8?B?RGJQYmVyM1BCaVZ2ZVF6RDhtOEpGY3ErZHM1VW1hcS9RVTNoZURlYU9ITTd1?=
 =?utf-8?B?Sks4NEJnSTVMUCtvaE5zN0FGY2FOODJSN2xoN2poRmxGT050L1VEenlZckxC?=
 =?utf-8?B?RGQrZE1KenFYOFRGeWx2Zz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcccad7-6e59-4dc1-105e-08d97ed277fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 20:41:07.4161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cx/J+stIc3D9McvjXi4tnpwbQbEf+2af08lv+GrzH6Iy4iWXuCLnDPNmPDtzkODg+NWd0N3/V3bjV8gYcBzi1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3212
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 0113mGxZ-99APiMT504ivpKEDk6WzjkW
X-Proofpoint-ORIG-GUID: 0113mGxZ-99APiMT504ivpKEDk6WzjkW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-23_06,2021-09-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/22/21 7:41 PM, Andrii Nakryiko wrote:   
> Complete SEC() table refactoring towards unified form by rewriting
> BPF_APROG_SEC and BPF_EAPROG_SEC definitions with
> SEC_DEF(SEC_ATTACHABLE_OPT) (for optional expected_attach_type) and
> SEC_DEF(SEC_ATTACHABLE) (mandatory expected_attach_type), respectively.
> Drop BPF_APROG_SEC, BPF_EAPROG_SEC, and BPF_PROG_SEC_IMPL macros after
> that, leaving SEC_DEF() macro as the only one used.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>

