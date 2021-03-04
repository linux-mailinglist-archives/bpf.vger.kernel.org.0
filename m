Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF1832D7F9
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 17:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhCDQnA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 11:43:00 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14614 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231426AbhCDQmi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Mar 2021 11:42:38 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124GYhZ1013036;
        Thu, 4 Mar 2021 08:41:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=LmASFcepxsT35uTpednwDXV1st8kssbIcXQUrCLiT2g=;
 b=G9+3nJvzVCrxzLpw2jVP+EWF2LLrFvZTw28teyTGILAwVgimt83MmMfVD14z7K6lFNOj
 1gvJ2c6aOeD5RefSry2wPSn1HDnwt+hLsJFK+P2ztDHTMs5nVT4BBYi2xhEWfEt0lBGG
 4EwmZEb2QW4Gf7hWOxI7plAdL0nBXlHmAvU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 372187a2md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Mar 2021 08:41:57 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Mar 2021 08:41:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETxK315HW0K3cVkVWBK4Jea8aB2wTStjbCXi6zFEtSHEI0Not51ZUjZxWEwHgdNf8eszv+9RATL+Yvi6Lyf3CVxxPDSX3E2YXE4ti4HEblUFrIktTJjtjJj1Exo1TNHt0cXntyShljnS2e8xngs3PdHCTd9/Lhzlm2DCgWwLDckvULekfuvIg15iap52A02bMGlfWpwWZWcG5wfu2PPomNqxBUezgEGgPoBPMjORNj2/RAFmlVOu+fS6dsGKZBtYqOyU9i3g4DqzK5sB+6w4bdnY8sOZoOOHb8osBfca/CxlXGVVXQ1Edr0yH1Ut1Lh/t0uz00ETkT1GwNpmJllErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jV+Wcs3Fm5uy7R9G4Ma4jo4gfdFOd6QqRKqIuDAHG1k=;
 b=mQUmCZeSRNwt6w7Az1DFTAKg9HDiqeOCTXS/0dYhpqWtS9asEAYBFWiGqgPcXzjIAwI8JSZEQdYjrWC8+ioOK+YQyYm1OYWh3RbGczSmuK0iHqYV2yDbKJ9dV5BVoPlYqMbqwrXjQEZ6tpnG7O+ayD6VlJc0Ie6S0s43zC8bbfJcFKl0DwfB8AtaMptA44EzDeiD/59o0qp9DmCLg4/EZvy3pIl+QCVNoZi/6ZML9tA4tUzuXfXyb6dpRCbSuDUS20otIVRwFvmmUGM6iyu4CN5c3+J4LuAMP2jgpwBHYEuU3WMHLKbrPRjMsH4qHarPbtCrSZDCR5G9H9JFENWvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4643.namprd15.prod.outlook.com (2603:10b6:806:19e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Thu, 4 Mar
 2021 16:41:55 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.030; Thu, 4 Mar 2021
 16:41:55 +0000
Subject: Re: bpf_core_type_id_kernel with qualifier aborts clang compilation
To:     Lorenz Bauer <lmb@cloudflare.com>,
        Andrii Nakryiko <andrii@kernel.org>
CC:     bpf <bpf@vger.kernel.org>
References: <CACAyw9_P-Zk+hrOwgenLz4hCc7Cae9=qV86Td2CkGVUPAzWQ8A@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <a3782f71-3f6b-1e75-17a9-1827822c2030@fb.com>
Date:   Thu, 4 Mar 2021 08:41:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <CACAyw9_P-Zk+hrOwgenLz4hCc7Cae9=qV86Td2CkGVUPAzWQ8A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:1edb]
X-ClientProxiedBy: MWHPR17CA0096.namprd17.prod.outlook.com
 (2603:10b6:300:c2::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1a32] (2620:10d:c090:400::5:1edb) by MWHPR17CA0096.namprd17.prod.outlook.com (2603:10b6:300:c2::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 16:41:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12fa7294-1fed-4ff5-697d-08d8df2c6b9e
X-MS-TrafficTypeDiagnostic: SA1PR15MB4643:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4643E7B772F8C92C5E876612D3979@SA1PR15MB4643.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KBFqhQX9rtMA6FytDsECbUXIf6HANRPgciDLKGlHJwQuYnHagvaDf5+mkXtX3MrOCt6lxw71vPbbi6Jk7PY0n7wE9gR+eSQQVTdjJQgAE4VJZKcf57QrNJcB0X8/dl3DJo6en6eCC23lVIzhU/FgIMwDxXVbn6Cv9ttctpjeMKFq2v0fAK7Wp3WFXpd/c3bAHwrfLrCMIT7Xd/cDFMxkRoN/mJeqcX4PvIDA/boJQcufWMGQh7v2NNW18QWi85cxyAkw6hDGG2Bt+hTbw/yhazqDBFgMIeh7CKF+1XIWQP/jcS3mWJAA1yVLdNkcGAyTGqRSO39gZ/+iPJu3Tei/ZXiFMvcQv3gwb17X3geP3bGhV+GHZSDjvGBB4GjL5yX4mODrVEGUShb0R8ohQBvTw0lylyb3avFEtdPGWAqZSgdujDgQjWoR/Bc/eJqfbY4e0P2SVLQVpO0ZxuGb29RWGNNHtjIO2WFwOS6raYzliykMz/+cXlJ8ri7+tJvvPDTQPCizIdL91hn+huM9uC9fuFGutNm6tWTSxVrMhJalCqio1BTqkyE2TLuxwaW1cNCMDCo2Qm9YOkauqkVZtuWeGQXxc6KtTNUzS8QkvrINyEJfjg6ZTMgZKAJLB3jIjNN8g3WLTBm7cfKK9u9b8NcmTbBpV61FlqIxo/qvxkXv3RIhaxxCPU0NrxQv4LsjONt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(396003)(136003)(376002)(52116002)(53546011)(16526019)(6486002)(316002)(186003)(31686004)(478600001)(4326008)(36756003)(66556008)(5660300002)(66476007)(110136005)(86362001)(2616005)(2906002)(966005)(31696002)(66946007)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OXFla1NVYmVUR3B4enNmTjc1TmRaVEJndzFZMnZNY0xBeEFYMUpWTnJ6SUVj?=
 =?utf-8?B?WW5XRGVOb0IvZHE1Zno0N2ppNVg5TzFhWkU1RStQcFpsZThyL0FxMWZxSnl0?=
 =?utf-8?B?S2xNelZocytuVldSY1hDZ3pzdFNhQ3VkR1VYa1liRUZXdllZNUZUQXhMZVYr?=
 =?utf-8?B?aTVPUGFrS0VobHVPclBuTzNmRFVVaktmVGtaeW9KVXRvLzNDWkkxTlJsNE1M?=
 =?utf-8?B?TGdXSlB4b1h4L3NRMG5yT0I2b3dSbCtDYlRVM2w4WnhvSlBHM3Z2cWJTUkdW?=
 =?utf-8?B?bWtSSjNveHhzU1hoaklIQzZoS0o2bjFoN2hFUTFSTkg2Z3BsUjUyR3ZNYWUw?=
 =?utf-8?B?OWVjd0tYNTFKRGIzWTNsb1JMeCtpaEY0YlF0UEU4dVQrUTBRZlBEVTFLc2Q0?=
 =?utf-8?B?SlRVWUJ4ZW15YVM2UjVXc2gyZDRwTTMzT3FSczUzYzdQeVh3WWVyTDhuejR0?=
 =?utf-8?B?NCtJcnhrT1h3VFR3MzU0MXRMeEppdmlNL3lBR09QbFdWM1VlUGJJQUtNL0d3?=
 =?utf-8?B?eldiUVRiNDJhTmU2bko3MHlMOHBlcjRtUFR0MmhSaTk0Qk8wMEliMUlHeXFz?=
 =?utf-8?B?SDkvWCtFOUFZWVEreTJnRk1xWi9kRWJJTWV3d1hmc3BwcFpRcWVLRXNENTNS?=
 =?utf-8?B?eXhSS0wyazYvTlp4QkkvYW5xeFpzRmxaK0lKOHR2QkhFTFprZXRRK2U2R0Y4?=
 =?utf-8?B?RTNxNnQzbzhIeFpNb25NVk5HbkhiTmtXV3ZacFBmc0xzSHBwVS9zWStUVUll?=
 =?utf-8?B?dFJlYjNEMHZ3aDJVSjYra01LZmJ1dTN5eWdFd0xKYStrMVhUV2xHY3NUMmVT?=
 =?utf-8?B?RElpalhjeGdyKzBEUUpXeXFhR3BTdWRaSWlSSlkrWlBxbkRKYjR0dHFCbmRJ?=
 =?utf-8?B?MGhoY1NYZWxTdnhxK1RtWGQ0Y0ljMVpSVGFTbW9DdHorS2tmSkRKc1k5NmpJ?=
 =?utf-8?B?aDZ5SUk1YnJpK2E0d2JCZnRWRU84TWpnS3dCWm9RbVhSdTRsQkl0dTJoVU92?=
 =?utf-8?B?TDZCem9YRDBDUXMxSDd1YWNXMTNmaFV3ZCtKSUJiYkNra2tRVWs3V3pmSEJW?=
 =?utf-8?B?bHV2ZlZ3SWJRYU9LdVVWS29hbm95dkRsOG5vZS9VVDlJbEhTb3pCT2dJblJw?=
 =?utf-8?B?NGFEbjdsbGp4SUZWSXkxcHJoekd1aUFLcStCMUZ0M3hueGJZS1JEWmw5NnQz?=
 =?utf-8?B?ZHRaNFVjOTczdHM0ZmIwMXpFUFhVaVVuUHBhWnBTYzNlczdna3FXUU43UE9V?=
 =?utf-8?B?T1k3cHhOTlZIUzhBR0xZcE9ZUVRwZjhwTXhPOGRvZnYraVJxb2d0RXlXdWls?=
 =?utf-8?B?bTMyUjFOSnNnZmo5bko5SEJ2d0k2bTdWekZsaGpWN3lKZGtnVXFoYTgwSHRR?=
 =?utf-8?B?YlFuOE1ld2VscURNTThzdzZEZjcvMnh5MXRBaEJaR3Q5UGhHWWsvYkhpd2p6?=
 =?utf-8?B?ZXpoY2tHTURqTm05alUvbWZjSWtRTlpQMU9Mc211VDdwMkV4UUVXT3R6NENr?=
 =?utf-8?B?Q1ZlTXdYV3VDcklVbGhPMXZsWkpVc0pLSkEraFJaamV6eHZVSUZJN2Nsb0Qy?=
 =?utf-8?B?U0FIYkprcC9EZ0xyUGpaaG1zZTgwczN5L1owZjFwamp6Z3poUnIxejVkbW40?=
 =?utf-8?B?OWI5NUFONzFjRXpCRXpQQzNyUWRnV1JJckdTSjJENmtOdHNVT21yQk9QSDB5?=
 =?utf-8?B?ZlBLTm1kSXR1NFd0RXFJU3VXT2RsNlU5dG56MzBXQTRDdEEyOW9hMUwwSVo4?=
 =?utf-8?B?eVA1R0Yzc1V4dHVMYmdYejJQQU1SMXhlczdJNklTSEt4UzhmNDZ5UGdqaStu?=
 =?utf-8?Q?jAdp09qXqrw8vLyrdGnoOK8G2avve91kL50vA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fa7294-1fed-4ff5-697d-08d8df2c6b9e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 16:41:55.0963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/cU1lMY1DuanFOWf8yAkFkvKZPh/2gF/G4DKO/+F7nd2vhzBHbPmjMt9b6sx7+j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4643
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_05:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103040078
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/4/21 3:25 AM, Lorenz Bauer wrote:
> Hi Yonghong, Andrii,
> 
> Some more poking at CO-RE. The code below leads to a compiler error:
> 
> struct s {
>      int _1;
>      char _2;
> };
> 
> __section("socket_filter/type_ids") int type_ids() {
>      return bpf_core_type_id_kernel(const struct s);
> }
> 
> Truncated output:
> fatal error: error in backend: Empty type name for BTF_TYPE_ID_REMOTE reloc
> PLEASE submit a bug report to https://bugs.llvm.org/  and include the
> crash backtrace, preprocessed source, and associated run script.
> Stack dump:
> 0.    Program arguments: clang-12 -target bpf -O2 -g -Wall -Werror
> -mlittle-endian -c internal/btf/testdata/relocs.c -o
> internal/btf/testdata/relocs-el.elf
> 1.    <eof> parser at end of file
> 2.    Per-function optimization
> 3.    Running pass 'BPF Preserve Debuginfo Type' on function '@type_ids'
> ...
> clang: error: clang frontend command failed with exit code 70 (use -v
> to see invocation)
> Ubuntu clang version
> 12.0.0-++20210126113614+510b3d4b3e02-1~exp1~20210126104320.178
> Target: bpf
> 
> "volatile" has the same problem. Interestingly, the same code works
> for bpf_core_type_id_local. Is this expected?

First, bpf_core_type_id_local() works as compiler did not check type 
name. for bpf_core_type_id_local(), there is no relocation, libbpf
may need to adjust type id if it tries to do btf dedup, merging, etc.

Second, the above bpf_core_type_id_kernel() failed due to
"const" (or "volatile") modifier. bpf_core_type_id_kernel()
requires a type name as relocation will be performed.
In the current implementation, the btf type is
    const -> struct s
and there is no name for "const", that is why compiler issues
an explicit fatal error:
     fatal error: error in backend: Empty type name for 
BTF_TYPE_ID_REMOTE reloc

To fix the issue, just do not use any modifier,
   bpf_core_type_id_kernel(struct s)
should work fine.

I think in the case, it would be good if the compiler tries
to peel off modifiers and find the ultimate type name
instead of fatal error. I will put a patch on this.

Thanks for reporting!

> 
> Best
> Lorenz
> 
