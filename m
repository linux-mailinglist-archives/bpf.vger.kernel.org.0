Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0D644BBA7
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 07:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhKJG3S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 01:29:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56802 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229731AbhKJG3S (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Nov 2021 01:29:18 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA62BOw028130;
        Tue, 9 Nov 2021 22:26:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=n9HVkUU0HMhjABJ+/BzUq0LowIW6NUVJucXWDP49r+g=;
 b=kf27Va5ZLD6i+CD91Y4KLTavaBJ+ccSyaDZ1ZstjcQkS5T41//7dpRRsGgO2UOiF5TDZ
 6cw8dVKJftToW+iixpn24Y7C7M1Qo65eLmV7S7BdODe+Pfvv1/YU6v4XaGP/f3L89MoE
 7c1qePutN1x1ImciPbMpYYiUMy1TNB6qWsE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c838f9v27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Nov 2021 22:26:14 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 9 Nov 2021 22:26:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxGhsE6RcNYo+TCkyjSrz5jP0J11Peu3hHTttuAd3HAWGF6QtRc7CC4cJ5FxbQJ19IL+ZAXpaZTnKIPtY/cRXswyiXjDgX1lhfDwlxpyKVX4rlmBwVxYjCK7N0XUOh6NDbhhTyOpnvXWGe+/W32IZRQ6tul6IKvVD8Pct5cvoB3EUKCHCI0XxBULEBgOcC30jVH8iw5BHf/PSUoMdpCL+3BjMjdNFsgzxZFDvP2uEvHfUHBqTsonu6MIEXScXemu/rkwe7n5s44sCxVl/6S7vGskNCCIm5K0fDues++ftfEyHs3oKlOa8HTV1ygOcf1jNtp4/iziFJVG2A/YjT7Xfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9HVkUU0HMhjABJ+/BzUq0LowIW6NUVJucXWDP49r+g=;
 b=kokdyfyiX74h37yZaz1n5hT9lNjIjteM6DBrxYOwl957QN2xhco3sjGAlR59izG5CUBojd31Y1H/Q5lyPmoQ2cIiOCutcY6EZsWhW6Zu5KgiGhrX7KKaOXpk+yZuIevW17xTYNwcdNqRXsyslwNBpJ9CzgsTVR+DS1h/Hekx3NrD/v+jUR04fx1bnbDGug6YRLA/LD6Ip6t3MSEmZmfYdV2TqjjVG4IQ+Y7qjH38Idse5vvxhtrOxrzGNcL1E9GLyVua7HNlcdZPjay8MgR+W9JvDkYlrb23tDGHgFukj14qcsa9X63zWqXl1FrQLHbOMdoBjRVEGxgUccpRk+Xkew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2335.namprd15.prod.outlook.com (2603:10b6:805:24::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 06:26:12 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 06:26:12 +0000
Message-ID: <d2546d58-67ee-0aee-5741-113f0583365b@fb.com>
Date:   Tue, 9 Nov 2021 22:26:07 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH bpf-next 00/10] Support BTF_KIND_TYPE_TAG for btf_type_tag
 attributes
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
References: <20211110051940.367472-1-yhs@fb.com>
 <20211110052805.qds3qzhabhdr3ah4@ast-mbp.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211110052805.qds3qzhabhdr3ah4@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:303:83::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21cf::1709] (2620:10d:c090:400::5:dba5) by MW4PR04CA0111.namprd04.prod.outlook.com (2603:10b6:303:83::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Wed, 10 Nov 2021 06:26:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38457137-289a-4d0f-634d-08d9a412fdb8
X-MS-TrafficTypeDiagnostic: SN6PR15MB2335:
X-Microsoft-Antispam-PRVS: <SN6PR15MB2335FD19B4075A8E239D6F47D3939@SN6PR15MB2335.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+Cqw0P6XczBCLu6pyDLPGDa9Xy6c/muCsEKaj0GC8RoaQLw16Spl05sza67pdMXErbyX6i/FQYXtXkBBQcbYv0Of3JJzZgAi/SbHMAInVQFtxQQgTFhtqI9ipjprgSVdfvrw2Yf2nfOiZQCgmqh2hZcav48gOBB69up5swwD8JI458OYiWxc2TbNZoNpzJWCVsgueTAksVWkNKmvAlwDLaZ4oPUC8I2Sef9/bWjOQPIzhT2Im4ShorT3uAQEmxBUpX7JFwZ3WiOgX0bwppWwkpMmxlmgP3xgLgrxktn9gHa6EmbLl4HNGwdut9txDdSxpJuIVmfsCdgylZyfTQ09qV9g6FK6a5H13kcopwPrAGmXG5B/SyHni6v+pVFalTmKw9H0EaB7PvH+yKnTtzOdmTIVWXXhljinFhMGIFz58cg4QI2qsKLUXtkJ6l+nc1Ki/im2t4tcq31+5dTnn/hSELlHhY7Sx2Z32tVos12ToHwSg4zWfMh7ilb4vaHEBcGKp4U4aJS5XDlL2pHxLc+WYYO7krSXGNRNVCtx3AMtrf3FKT/x4lLg0rCQt3/s8Xpd8IJIw7EdU02qsNr6Z0kWbA3+73lNDv6tXKkVNgxyKaImToZPPBliWhmP+c4p6PjKkxhopvznvVsA3LCKNoJD8kt2vl5L3hoZLfaDrbHKoDNd4zFPRhb8f5NMic/V+05ZXD38OZjNTIDjnVNgYAP5ateLQMnd7tKR/Lfk1La6x3+xtaNYltLgIDIcDXHc224
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(83380400001)(508600001)(36756003)(8676002)(66476007)(66946007)(6486002)(38100700002)(86362001)(31696002)(4326008)(52116002)(2906002)(5660300002)(66556008)(54906003)(53546011)(2616005)(31686004)(8936002)(6666004)(316002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVBhZitGeWtoV3NXSVA4R1Y5SG16TUlvM2pFV2h4YURwUkowWHNXMStiVWdx?=
 =?utf-8?B?QmF2YTVIWGFqcEVqOUlGSUJzeFRFZFFxTXQ0dWt3NldFWkFmc3VONG9zak1R?=
 =?utf-8?B?SGhwVWY0N2VFaE1HR09iNGxPSFBHKzVGNGw0M241VUp0cHdLYnBZeWw5emtz?=
 =?utf-8?B?ejZBTzB2WlFtTXRGQkkxa1Zhc3BxaHc3THZzMnprVFZ2SlNYcjFWeVdGS0E1?=
 =?utf-8?B?TWNvOGlwd3craStqTWg2WHNxSmNtZkczZVJqZHRTenhjVC9TNGdTeUNCVm5l?=
 =?utf-8?B?ekF2NmlCNko1S3hmZnBnME02aXU1NlgyQ2tIL0JlVEdsNEJUcjROdUltbXJ2?=
 =?utf-8?B?dEtFN0RQU2RvQ1JYdGtCY1ZWK1pUcG9WSCtWc29YTk55MkR6QWNOUGs3eDZY?=
 =?utf-8?B?aDFNK1ViMHdtbVhDWFRYTlByaUZnMitjOVYyV3dVMENLR1VPa2d4N1pJV3Jn?=
 =?utf-8?B?V00wSVdFN2pkMXpJd3dUVVRvb1BkTjRqR1owRVRzUHNScTZpVUVVc1B5am93?=
 =?utf-8?B?czBncnoySTF2STNmeUVqOWcyTnhvSTEvMEk2R0VZRjFxcEVMNUJvaHZPVWVu?=
 =?utf-8?B?bTVDYk4rNGU0UmM1UzlOQXpxSThSeS83eFpGbkxnYm9sOENvZWpkOVdrM0FS?=
 =?utf-8?B?Mldmb3RBNVVSWGdyYW1IOEdUR1lWZkw3bnVtTkthYVhQZTdhbytydEhLUlEy?=
 =?utf-8?B?NVlNVzlVTTZDaiswdFJacVF2VG05bFY2RitSN0U0Vk9hbjBvd0ZGbGZDWEw2?=
 =?utf-8?B?ejVSWlVZQWI3R1NUMWJsU2NENE9xd0lLQ1NpVUo5Tk5kSDNJN3VEN09PNTlZ?=
 =?utf-8?B?dk5xYU9acFVmVzVhT1FNVkZpUGwySXBRcmRadUpmQ2xWSHRlVHNCL0VPRTlW?=
 =?utf-8?B?dHIrVnhDajR3VzR6bkovR1U2K3pkekxCb3pzUkRLUnhHYWNyZVZxeXczcjNX?=
 =?utf-8?B?L09uL2tZd3JMRExMcWNpaURQUEVpZCttTS93MitvMElLZllLU0ZOSFh2Rk9h?=
 =?utf-8?B?dEN5V05ZRWw4NEZTTFZ5ZXNRU1pEdlgzRzZOWWg4b1h1Y3NpTXN2WExWV2NJ?=
 =?utf-8?B?cmpiN3RFNGRmNXBjQy9IR2cyUGRNQ2h2TG8ydmtuTnh2aHhaSUR2Qk14V1Z1?=
 =?utf-8?B?cm52dytiVG1NT25rZFZpLzNLeTZDeU5qOS9GVldGR2NYbFR6N3docmVlajBU?=
 =?utf-8?B?d25BS21zZytPa3haZzU3bGRGRldZRzhUUmNKbmxIYUQ0Q0g1YVQ1UjNGZGFl?=
 =?utf-8?B?a0VLRUtvSFkxWS84cE9qdGNPY0UwNFpmekovbTlUMlRGMzF2OUlyaWlhNkVP?=
 =?utf-8?B?T284ZWhvZGlWYytQckxmR1h2MEpsam5oU2dJZXdjTUpYejFiWEdVd2habUVK?=
 =?utf-8?B?VlIvUEpqbCtLRXV3OFVyK3VZQmFudzA3LzNJVStESHNaN0hmL0JoZERkMkd1?=
 =?utf-8?B?eVdaT2d4T3JMSUxubXF4ZnMyckEzc3hUYlE0b2ZvNXNyaUVvTDBZU2FTVFR5?=
 =?utf-8?B?blN5Z2hpZDNtaFBwOHBKbExjQzIrcjhKY3lJcUloOHZwVDhoams4V1pOVHh5?=
 =?utf-8?B?V3NwVHJzK0wyQlBJK0FPQkoycENsTk1jNTh0Y1Q1eDNncDlrdDRzaWVLUFR1?=
 =?utf-8?B?bkpMNUt4SUYzK1ZHS0VYU1pnaU9EcnVlZVJSbWRRTExGQnhDYlpEVXJpNlVh?=
 =?utf-8?B?R3ZtMnMrdUlrdjkzNDZNZlpwK3RiZERNOWloU3RlcDFvSFY1NFVJbU55RFhU?=
 =?utf-8?B?dkZNc1NMcmF5WE9iR3k4RGRxVEthK1ZSRUQxMklsMC9aNEYyRXFnVGl1Tndh?=
 =?utf-8?B?WnFsTmZXYVR4cmpyQ3ZzdXBtMjZGSDFXTG1WbGNJUjVKUHZZSkJlSFpkcXBU?=
 =?utf-8?B?YWYvVUw4L0NMR2Era0NOMkhxZVZlamdUNkRqNThTUGVIWnlBUTVSRFdRTS82?=
 =?utf-8?B?TVRTS2R6Kzh6SVZZZStaWmdUNERYNEpyRXBUL3g2OFZoOWhZNGJMNkU3TnlX?=
 =?utf-8?B?WFppM0RUL3N1OE5FM3NXR0Z3c3FwTTlVN1ZXdU9hcXpaTHN0ZDl0OUQxcTVT?=
 =?utf-8?B?ZHV4UG5OQUJPbnhYbWNna0d4YWpqbVNsUkNaODgxQWRyMHN4RUd4cm9ROE9y?=
 =?utf-8?B?S293bmVXUmx1dEZmVUR4R1VSenJhNlkxV3AvTnBqTHZlNGF4UVVCUDJMamtr?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38457137-289a-4d0f-634d-08d9a412fdb8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 06:26:12.4061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKfwOsSViTfD/gmRRRz9rknLpJZpgrQcbZFI4Z3XuHlfcDC7li5ZY5xOHsjfh8Jh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2335
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: OSy62Q2BceQuZE7foHZyvRwA4ZQr5MVS
X-Proofpoint-GUID: OSy62Q2BceQuZE7foHZyvRwA4ZQr5MVS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_02,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=997 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111100032
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/9/21 9:28 PM, Alexei Starovoitov wrote:
> On Tue, Nov 09, 2021 at 09:19:40PM -0800, Yonghong Song wrote:
>> LLVM patches ([1] for clang, [2] and [3] for BPF backend)
>> added support for btf_type_tag attributes. This patch
>> added support for the kernel.
>>
>> The main motivation for btf_type_tag is to bring kernel
>> annotations __user, __rcu etc. to btf. With such information
>> available in btf, bpf verifier can detect mis-usages
>> and reject the program. For example, for __user tagged pointer,
>> developers can then use proper helper like bpf_probe_read_kernel()
>> etc. to read the data.
> 
> +#define __tag1 __attribute__((btf_type_tag("tag1")))
> +#define __tag2 __attribute__((btf_type_tag("tag2")))
> +
> +struct btf_type_tag_test {
> +       int __tag1 * __tag1 __tag2 *p;
> +} g;
> 
> Can we build the kernel with the latest clang and get __user in BTF ?

Not yet. The following are the steps:
   1. land this patch set in the kernel
   2. sync to libbpf repo.
   3. pahole sync with libbpf repo, and pahole convert btf_type_tag
      in llvm to BTF
   4. another kernel patch to define __user as
      __attribute__((btf_type_tag("user")))
and then we will get __user in vmlinux BTF.
