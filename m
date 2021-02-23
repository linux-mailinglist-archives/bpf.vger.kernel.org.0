Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B67323126
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 20:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhBWTJI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 14:09:08 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60000 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230114AbhBWTJH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Feb 2021 14:09:07 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11NJ2UJp007897;
        Tue, 23 Feb 2021 11:08:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vlV+CvFZJSori1b78mgodffAXasK8/GnGMndZCzJExk=;
 b=jxJRPkENSTRro3Rerfz+CYc0Hv2omAmD4EnL8IQDk52oOgWvBBZOqaGsA1xnzpdEkZdu
 Z4m4vBMa4p2mcK9dvqSv8RdLf0CRLiAcv5n+Pd15G3NaGv46AHRY0V5xEUal9uViKYSe
 /S3KuOxewVtyURxfWB1U0QYeMVMfEL5qcKg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 36u03406gp-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Feb 2021 11:08:14 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 11:08:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsUwpcT9pAt6wfmJU7VnfO2IupDzOJyc5jyfSUE0DypPlvsslVUuruiai8BCMpO/85fO0f98rZrmHFc4ENUImBBm8WB7QKSqhnwUFUskCbfhLzpKREaYPr6kUdkSlY4xFUODIuZQ4FoZftm+gApdn3U6UXW0C+XcwQ41uRmymirgQWqmF2FCEAvG+E6zsDSaI9t3MDb0THgPJy5Fk3aJsYC8Hnnzzpuv/lsbOU/sayixrYrHpTV4YyfaAAATn7zrH5tjE1rUZMdqV4EcO4wR6kBIyPgOB8GSs98Rj7TEoJGfQqeuPGY1s0DIn9z46sAHHGr5Bzby1/P2tTPb5TCzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlV+CvFZJSori1b78mgodffAXasK8/GnGMndZCzJExk=;
 b=dEuiKUfg/27cE1IORdud6tg1D0FNBFOOM29o00lXJVxcBNS+OrqgN683LNWN7el8kUi+F2K4HquXVtOVXAM4lD5/06A8zBikwsSvSWiaXznEkyt4dCVwS4hNaSzQOshhS8o4jQ+jjwHVTybziZZmxAY67ZbZOw6NkU6x5EGuKSIUK2z3kkwEvPLk3mFM8Xt7PcYTfuzYU80I64fByXCX0oA1XYt13YoJFHiSCEXztDOJF5TYvgkHlIQygUSUmvUW20mMvCqEUgeBE3lUvhcrsIonbBhQJnVRnrB+oKvqMx6ESR5/g9C+x9NTS8Z3NtRGRItbYRz1nuHwTo4UZKvWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN6PR15MB1236.namprd15.prod.outlook.com (2603:10b6:404:e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 23 Feb
 2021 19:07:58 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::81bf:9924:c4f1:75cd]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::81bf:9924:c4f1:75cd%6]) with mapi id 15.20.3763.019; Tue, 23 Feb 2021
 19:07:58 +0000
Subject: Re: [PATCH bpf-next v2 08/11] libbpf: support local function pointer
 relocation
To:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210217181803.3189437-1-yhs@fb.com>
 <20210217181812.3191397-1-yhs@fb.com>
 <CAEf4BzZwEDQwMiXthy2Q32F3Qt1X4sTg92w8HZL7PbMB_FtYtg@mail.gmail.com>
 <b20cf48f-fa7c-1397-fc47-361a9e8edecf@fb.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <a97068b4-2428-bc0b-0978-95d5c1f50752@fb.com>
Date:   Tue, 23 Feb 2021 11:07:54 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <b20cf48f-fa7c-1397-fc47-361a9e8edecf@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:5e03]
X-ClientProxiedBy: CO2PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:102:1::18) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103:c99:e09d:8a8f:94f0] (2620:10d:c090:400::5:5e03) by CO2PR04CA0008.namprd04.prod.outlook.com (2603:10b6:102:1::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 23 Feb 2021 19:07:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d00e4e0d-1665-445e-5e65-08d8d82e5554
X-MS-TrafficTypeDiagnostic: BN6PR15MB1236:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR15MB12365EFE4B6E6F2E723C838CD7809@BN6PR15MB1236.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfVYfCvaFcBc+CMevqTkEUmokWCCTGU45H+nASiXQQGiyTZl2pFCSCmSUOfU3S0j3PFc/MVnAuW3vZ88wYvSoMViwg8fuJF29L9ORgDJbeUXAvQbfMDiKRvHhOsW06sUdcjkOYNjdLEIssD+3G7iCeG8pfW7wRLTLefz8blOp6HzVzt1QsdlKRdapFXbeVAUVA+NIrjnjVZ5azwcivZtKA1c9jnjH7CssjwT2u+7f7jwCzsmttmfeoNkpzrMfhZ681C0KpfPF0TWoaAsMQWVAkp5/MKeFgg2h5Oqq+qZ4+BFDVOyiwhfInclqkFL4x0OSoBvSaVcl2nRpR3/i7Ofa2lhV/F3L3VuNErOlOQfuAjIXHM+QUCiwKfpovdepBibSAu4QEApv/3CSXKKhWFc0knyIx7bd3NA8x5x81y/AQDGsdjbc45oU7iDdmQZWm04XZHWDkBn72/v8i/TSz8+U1DQjAbcbLMCm1h7AmMcfhG2YniZ2j3VnegZ2ZiAXMjOOkY5W5zlnhxA8xt+7O1roBLgb+JiY5TZrcNR/XfIv928+JmbMezDcwx3QhArB8VKrO8r4u4xylAG5+TwhLF5InU7HkChZ41HbKwb0JCg9gE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(376002)(39860400002)(396003)(36756003)(52116002)(2906002)(16526019)(66556008)(66476007)(2616005)(31686004)(66946007)(4744005)(186003)(8676002)(31696002)(8936002)(86362001)(4326008)(53546011)(5660300002)(6486002)(6666004)(110136005)(316002)(54906003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b3hld1pCMXNuWW5NZHZFNFdtcmtZYkxaQ3NiRkpEendXZFpXMW5GSTd5cDZy?=
 =?utf-8?B?SXRnTGxPZitPbTBlWjQ3aFhoMkVuWjhqUkVFUVpxM1Zjd2Q1MXNQM1lFZ3c4?=
 =?utf-8?B?TTRYcjFnT2FiMmNWRHYwM21vNEdZSjlxNUtLK3VTSEVRVTJUWW8xRFRDaEhX?=
 =?utf-8?B?SFpjMzI1VmhMSFl0VnBRa1g3cXl6bFMwZlh0bS9raDN6aDJCZ3puZ295REhX?=
 =?utf-8?B?VWk5N01QTEtkZmdhRFpkNUxCeUtCZERuWlQ5N2k2aXJmS09weFhYQ3VWR2U0?=
 =?utf-8?B?NjRBRVgzRUcwbk96NmRGR1l5bndaY3NPaEE0Mjcrb2RFYUI0bUIxbG9hcDA5?=
 =?utf-8?B?bDNqVy9aSEdFOVZCY3dmUG1MMnUvK3VRWFVPREx1NnNtcUNWWW9Zc2V2YklW?=
 =?utf-8?B?VWVZMXJOWTNMVENCMG0vSk9vcFJvUFlZSWl6dGtONW9SeFQwRUQvWS9VQVdP?=
 =?utf-8?B?MmlVTURWRnBYVVpsQ0o3di9na24wRWtpbFdITmU1TnhLZmM5NHpyMG9jaEtH?=
 =?utf-8?B?RFRDdmU2R1NsUzBwdERoMElSaFg4SkRZOXZjQy9ETUlFVXU4S1dmQ25EN2Vm?=
 =?utf-8?B?QU9taHVBT3N0TUdmN2dWazE5QTF1b2pxL1BXOElBbFRlQjNwZTYvSmxML1Bi?=
 =?utf-8?B?UmlsNG5NMEhoNlpzMFJXOVB0N3M4WnRtSmtacVJOWC94dzQ1NTZhZnJ5SUc2?=
 =?utf-8?B?b1JFRUtqNE5Nb21VNTYrV3NBTkFnc1E5d3Q1QjhlMHZSRGU2MGtBRUlJK245?=
 =?utf-8?B?WlNLSEU2QkpIQmhFaklvK0lKa2xISUlzdy9SRjJOQ1JPcnFNaWVFM0Yva3kx?=
 =?utf-8?B?c25keUJqQ1VmdTdjMHVwTERocU8xU1dRYzJWbjNqRWhqUnoxdlZSWTNBQith?=
 =?utf-8?B?QTBFUFZOaHhDaENmQkFIRzA5eFJsVVQvSnFTb2xGa25RcmdoWmtHTFdPemVv?=
 =?utf-8?B?RWxhUVMraUJjMGdoL2hwQ0VBTFZ3dHBUM1dvc1dBSllZRERJd2tlWGRLaEUx?=
 =?utf-8?B?MkVhekVENjRnNDJCN014THFKYitZdmZUREc1ZzRHNThRWEpsOThWWXpxN3JD?=
 =?utf-8?B?c2pqM2lDRUZweTBRK0U1SmV6Y0tQd1pYdVZnSWsvS0dxN2ZiQUhha1dyalZL?=
 =?utf-8?B?d0JVNTFMNkVaelp1Q0R6K1BCY2lzQkNRUTExMGdIaVJUTENQZm9Tdk83TlZ4?=
 =?utf-8?B?R2hDRHVLZjA2UENCZnlnT3lQSmVqVkpSdWVLMnJ6ZVNaaUVwendybkxxQ0ZD?=
 =?utf-8?B?WFArWjJzd2VxM2RRMzMyRjI1andub2l1VHZnNlQxOFRmMkp3YWZZMjh0enE1?=
 =?utf-8?B?cDRFS2dLV3V0L2s2aExsQTV0Z2QrK1M1bXE0eWkrZ2ZMaWM0RGFhU09wdTVX?=
 =?utf-8?B?ZWR4U0dtdEhhOXBuSGlpdzAxMEZYRlJzVlJ6SmVwa0NtakJzNitZaGxUaU40?=
 =?utf-8?B?TlFMQldkZGJzSUI4Nk44WGZXTDBFWWVDR3lHNmV3RnVkbWZVYmg2ZkFvTGEy?=
 =?utf-8?B?TytvejVGSzNhM0IvVjQzSXk0VVI0T3JMWWJHTVdRcW9JTHNsTHNoTlNoS3lm?=
 =?utf-8?B?NnVSeDFHR1NzQTBxRjE4ZktsVTdEVTNiamU3REt5NnB1ZnNScVFlTlltMUVk?=
 =?utf-8?B?dUE0c1ZoUmgzdTBqbVloNC9FQVAzRzlQT1dmV3FiVS9IRXJ0bkcydVJ5eml3?=
 =?utf-8?B?Wkk4K29kY2F2T1dMYXo5SlY0YXBXd21rbDlHTGVvSndnL0t5eDZ6MUY1M2FZ?=
 =?utf-8?B?enpBN0pyWnVoektNK3VYODdWZmhvUzZ1VlJvNDJaeE9hOEpHSk1lTzIvL0xn?=
 =?utf-8?B?TytET3QwZEt1MmxQUmRVUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d00e4e0d-1665-445e-5e65-08d8d82e5554
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 19:07:58.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQQqUU9eCTE+iQTrOptL2/xpE5Q/nQQjZHGDZ4YjUN3UDnVTFm5UZSUy6la1S+gw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1236
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_08:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=934 clxscore=1015 lowpriorityscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102230158
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/23/21 10:55 AM, Yonghong Song wrote:
>> BTW, doesn't Clang emit instruction with BPF_PSEUDO_FUNC set properly
>> already? If not, why not?
> 
> This is really a contract between libbpf and kernel, similar to
> BPF_PSEUDO_MAP_FD/BPF_PSEUDO_MAP_VALUE/BPF_PSEUDO_BTF_ID.
> Adding encoding in clang is not needed as this is simply a load
> of function address as far as clang concerned.

Andrii, I had the same thought when I first looked at it.
The llvm can be taught to do this, but it would be a change in behavior.
Older llvms will generate relo while new one will not.
To ease adoption libbpf would probably need to support both.
Hence no real need to tweak llvm.
If we go with llvm only approach my ongoing work on naked functions
would require to tweak llvm and libbpf again.
While the llvm does the same relo for naked funcs already.
So I will reuse this libbpf support as-is.
Only for &&label and jmptables the extra llvm work will be needed.
