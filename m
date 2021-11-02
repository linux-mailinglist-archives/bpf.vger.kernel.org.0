Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D4044322D
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 16:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhKBQCb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 12:02:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7040 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231314AbhKBQC2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 12:02:28 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A2FRV8V015942;
        Tue, 2 Nov 2021 08:59:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=yAbi++O6FLpBK8SonExf3bSpJ9uf90LasdF52PFgpP0=;
 b=ZyV8BcZxdbj9+DI0GqDERwrJ3pcJyEubDUNrBqQOUj+mJD09zbNjgZVl4QORD6fZTfnT
 +Kl3MFkoUxPOH8egLBxnm0OhTvQpazVK3K5vV3doCY4AWtH+zV1qX7IgV2bB8FreuqJZ
 ecV1ZX9kmHsEPA1I9yZ8krMrD4VrI+c13bg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3c2xy6umy8-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Nov 2021 08:59:40 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 08:59:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYJO7HLy+gl28RTE8cPUcZVoq2dEGtyPnAFaMuTM/+FFB+cilzLRUR3JuwDJroMvlJig5vUGZmfBSi889jmWfHHQArc4YK7V6wsUvnN1e+ncInPSH/Z9Pn0Lvw5rT+STG641Y6Sewql1u0q2mMXt9IiFPs1hyJdj2+p4/J5EW/LxtFYS9lcd0RMZF/MRg4WItL6MqS+ok15T+D84hbSWyYvUmKf/nkkYvTOEGpfa5eHz4IJceBZChhFrp322+FiaYkAVPnwkbPClGS+hyJsVjL3IcZyi79eTvluxsnwyNvc+m7/SekgJJWVuUosq4npqfLglrdgQTLnndGDvXE++Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAbi++O6FLpBK8SonExf3bSpJ9uf90LasdF52PFgpP0=;
 b=nYSEBo5BVemjUh24TtuTebpwYCLtlr0vqofRCz8wcc8sq661jhZhwM4c09cF2ibBk4EBmIdFSdF1yPLu3NaYX+zTtIXSk1UHoU5+l+kYI7XszDmBJ7knE+JS/lRsVk0gT38lz0B6k6jTlQmR45cx7vd/g5T6vdwMGup+FNGDvFzXfrueMJgYxFMLm+r8IpWufVI/ltH3wKTxV4Zqued+u67Bm+erDStUFv2lqmSCtk9Vt76Jh0aFytNiAsoW75PjUKLDgyBJ3xgN1NJq2sJ4EJ+h9GyAN2DnSDDVI4/JbKzvQsxKfztSBwICHuViMRzYUeMpHgc0wQ36yW6vBe5gFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB4096.namprd15.prod.outlook.com (2603:10b6:805:53::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Tue, 2 Nov
 2021 15:59:37 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 15:59:37 +0000
Message-ID: <00ffc27e-b559-7970-ffbb-a3606f974e80@fb.com>
Date:   Tue, 2 Nov 2021 08:59:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next 2/2] bpf: selftest: verifier test on refill from
 a smaller spill
Content-Language: en-US
To:     Martin KaFai Lau <kafai@fb.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <20211102064528.315637-1-kafai@fb.com>
 <20211102064541.316414-1-kafai@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211102064541.316414-1-kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR1401CA0005.namprd14.prod.outlook.com
 (2603:10b6:301:4b::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPV6:2620:10d:c085:21e8::198e] (2620:10d:c090:400::5:2e35) by MWHPR1401CA0005.namprd14.prod.outlook.com (2603:10b6:301:4b::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Tue, 2 Nov 2021 15:59:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fbca58b-7c1e-47ce-2095-08d99e19c54d
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4096:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB4096186C5E92AA6A2D7FB0FBD38B9@SN6PR1501MB4096.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UPEB0D+uVzJJ+xAFBy+IwO8wPi6J126Haf1pORpdktIyWOWVQaSFe3P0eVVgVIw0J8OE24T5K0lZKTjI+nQmQktd76XTDrz1LqOVGPj+sqFSc5e5WzFtZ20lGWMgNXlI+rMPwcv2V04nuXgGfs3R/UVfqIDinIiuHAtlvweKBF3PKP3eQOxZBLEm/XJIGYSbyUH67AyQ274zsImjmZVWrcuVGuAU53vcjP6+l4NXUBONMnJxngfWVIWAcGPSS7JxA3vo4BzFweXVLSSd4EB5DyWaEb7fsIGQ5Cg+u/TJ6YVvo/Z292pD+whBt7StG5ck5Nmxghqw2WwL9VJsR2NbMWeYsjTcDhdPlnwsxXBhI6hcgzFItNaVjdA/aqADxppJxkSEQiaES60w2o+f29e7uvitmtXG8hHxk9W+vblRWlH8B6NKhdPfEnT0+RZerA86DA+299lEL70eCHIhOCwAEr4lwdLmu0fMZnYSVCIKwGM0DHYjp7/srjqCJ9q9U9uWxs46ZUZ+S+PT6+3pS/y2kaFUOTVR1/li1v/NLmoDMHi8OemtD2+Xf+ID535G0kJkRszBrps/b2pWLsq5N6r+EvTfJTBxoayzcPJ37F9Zwg/CVWE40ROnxMLbVDoTpsFmY4CgfA9HFE+JkDZrLrqUF+xnfyA6ypEXnNj7R3udWEbcgPH0hG/EAFnVDgthfUcxUGnhxTE0oL7rShebdHkzTSpf8oi+C3zFE6nzH4ipPrV6mPPGdorrYM+ejBFQRfWmVAWvJRch1mpBslReHq3K3nC9HWj3/zyiQuusmBo/tbHc1pqIubtoSsCyuFCHyNAx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66556008)(66476007)(186003)(4744005)(36756003)(6486002)(31696002)(52116002)(4326008)(2616005)(316002)(31686004)(54906003)(8936002)(5660300002)(2906002)(86362001)(508600001)(966005)(53546011)(38100700002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXdkNVpYZ1BVclF3VHMydGF3cnhSREo4SThaVzYrNWF2SVJWYzM2RDFDVEpk?=
 =?utf-8?B?aDlzd1dtck4reTdqWlZPQ1lKM0Q4ZGdWazdWdDFOTWcvSmFCWGNIRWdmdXZq?=
 =?utf-8?B?bWkxSm53ZkN3TVg3RHJEWGcxQTk5UGFTcGFxeTFCMjRpMDl1S1ZRZ3RBTmZw?=
 =?utf-8?B?clpMTUd6Ty9pMVJlclEvcGJEQWFZb1g3ckNZdUV0R1ZLdFlGWWlObTZ6a0tU?=
 =?utf-8?B?SXZhbjJXMGVaSlh2VmJ2OGwydzVlMHp6Q1huWFI1YTFsL1pyVTRxWG9oSTdj?=
 =?utf-8?B?bnBpRkwvNmNoaytveEgrSzZvcXM4YVV4dTBnclFTc09kMjBMNXN2TGtydmM1?=
 =?utf-8?B?MlYzK2IyaHhIeFdPTkFLRnFXZWNPUXlOdXNTcmpHQWFjRkJJbC9LNERRQkNO?=
 =?utf-8?B?WWNncjF6V0xtR0RIZXl2MUM4N0VoTUlyRjFhSmliYVNBRlB5NytRQUh1TFJy?=
 =?utf-8?B?ZVZwQmsrak8yVEgydkZTbnVaNkdxdmFrTEh3L1ZZdklMT0VzYnROS2g0MVVl?=
 =?utf-8?B?bnArR0REZ0Fwc3dicWdaOWx3RDd5OThmQ3hPK2ZvaVpUS0ROYmZXb0p2ZFFr?=
 =?utf-8?B?OTBFb3FMa25SMVFmMzBPWjh4MXN5bEFwb2dYL3J2SUJaaDZYQSt5Z2ZUVmtX?=
 =?utf-8?B?R0ZJNnhJTnprRDRjdmVhcWR6Q2wzWEc1aE1FTkFYNU9Uc0J1K1hpQzVKcDEr?=
 =?utf-8?B?MTJGN0RUMmtBUmUyYkZoUkUwKzMxU3g5c0Joa3FzWDUrK2QxRVE2dFl5b1RU?=
 =?utf-8?B?eTRoaG45dGFxVTYwQmZRV21xTDJFdmU2d0lGODhWRTBNZmNuMnFsVzFHblho?=
 =?utf-8?B?NmFnUk5MNGtyelJCdGFDbVNKSHpLaWxYamZ6ejVnY3BlQmc2RE1sSWxYa3VI?=
 =?utf-8?B?TzN0MDBJbllpdjFiekxpd01kU1JPTVRwWHIwRmZxajIyTDdPbW9DcG1UTGxq?=
 =?utf-8?B?M1ZvRnJGd21BWGxQcEJFeHBHTktzQU14Z1RVdlhJaEFkWm9abEdid1dhckZl?=
 =?utf-8?B?YWZmVHRnZ0U4ZnBQMUJ1dk9LQTNaVHI3ZG8yYjg1Qk9kMDNtbnhaYWVnQ1Vk?=
 =?utf-8?B?OUhWQXV5QUdRL0NwQnBxMVZURzM5Mk1ZVUpsZHdyVDQyL1FuVmFPS0dRSjIr?=
 =?utf-8?B?dmVneVBySlNWaVJTVzY0OUFGQnhSeXE4elMvOXFZYjN3RHpYaFFMd2JoWU1p?=
 =?utf-8?B?VVBmeHExdlBYN2FUd0l2NTZnUzNCUGQwYU4rNE5STXpQQ3diRXJlWC9GRSts?=
 =?utf-8?B?MlV0UE1QSW90Myt6enl0c0R5SlpDd0ZCUmJjZW4waWtEUS9JZVVqWVZWRHhw?=
 =?utf-8?B?L2pxQkN4dml4azBtVEJvMEtROTFNRVRKQ29IZDdQZXlIaUhFMjBMbzYxeERz?=
 =?utf-8?B?SkxWYTJXZkhTZUNvNWpwR2Z0aGZkUXpRb2dOUlB3cThaS3dhbjJTdmZMZ1JZ?=
 =?utf-8?B?cnRtMy8wVzBJQkpFcTJKczlyOTlhbnVVdHVtVld3Sm81ODljaXE3Y05pdVlv?=
 =?utf-8?B?a0YxVGxqTmNFMkh6azdmcEhqR1BiWURBT3RtUWtPMzdtUXVIbG1xK0x2MDRN?=
 =?utf-8?B?SGNXY1dDVzhXRXMyV1MwbVNsN0owQzJjVDBZOFJ0eTQ5dDFiWnY0czJSNWZ4?=
 =?utf-8?B?eWU0WkdHdU9XSExYUnAzUFAvSkJLanN5UWdsY0VOTFVnaE9HWlA5T09MYWtl?=
 =?utf-8?B?UVZBOE4rQTlRaWdGWWJPVk9KaTBTMjNQRTM4bWVJQzVzZVRtZnE2d3kwQlBi?=
 =?utf-8?B?TVFCZ2pQbmVKWVdhdWhMMlgxa2thSjRPQ3p4UG1MWElxZDlHVVhhSzNYZGhx?=
 =?utf-8?B?ZVJXWS9qamdIb3VBckxoYW02RXBmQTR3VlJJMEZsQTJiWE02RmVzT3R2V1Zx?=
 =?utf-8?B?ZHlJbjBwMGl6Y085NnpLY0kyVTMzQm9ENkFSUmhWUEVzdkUrQitrdUFuU3pr?=
 =?utf-8?B?SitGQ09hc08zazAybHArOWFhSmJIbmwxaFNmTlZFYmh1U2VjVkxPRWZ2SlJm?=
 =?utf-8?B?RnppS3l0WHRnaUNJZExLcWRxU2ZxZWtmYWgxL2drZ1dsdHYxYmJ5byt4SlU5?=
 =?utf-8?B?ai9TeGRVMzRKWEpwTFZpU2E0TWtpNmdleUppdmZvRkIvd0M2L0p3Sy80TjdG?=
 =?utf-8?Q?AYe4OO2ThKVwdlbwN67yPEHvT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbca58b-7c1e-47ce-2095-08d99e19c54d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 15:59:37.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtraSuOLgBHCiFr7QAMbOhntdZ27ZoQczhgw5gCu6pr/QYlbedQjiApkBcCI6dJ9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4096
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: nnlkcX3d1Zfe6xAt8vbUjOZd-0G2EWEE
X-Proofpoint-ORIG-GUID: nnlkcX3d1Zfe6xAt8vbUjOZd-0G2EWEE
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=614 mlxscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111020092
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/1/21 11:45 PM, Martin KaFai Lau wrote:
> This patch adds a verifier test to ensure the verifier
> can read 8 bytes from the stack after two 32bit write at
> fp-4 and fp-8.  The test is similar to the reported case from bcc [0].
> 
> [0]: https://github.com/iovisor/bcc/pull/3683
> 
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Acked-by: Yonghong Song <yhs@fb.com>
