Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635D22F28E8
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 08:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391968AbhALH1b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 02:27:31 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62010 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391943AbhALH1b (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Jan 2021 02:27:31 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 10C7DAFV030699;
        Mon, 11 Jan 2021 23:26:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=J7RfQ5mQOdiBZgHmWumO6ULPqPpph9WTm71KAyiOhsA=;
 b=b6XnFomNYbRxmpgzgHGw+XeB01JqdurtukA7Uv/m2fZIC1ZqKRu3ZCNUzaHTiKYDnwZv
 YW4FSKNQZlnk5SB1Cn8CB16EQA+MAW+EpsQTFt1aB1wzyYr9Wsnicgt2LBgr7a1c3Jbl
 Y0jlMYF/YM43bAduvakKH4ljPzSelZhaPF0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 35y91rv69p-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 Jan 2021 23:26:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 11 Jan 2021 23:26:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IY7f0rAxljmYMQYLWh6pvVuK33HSPOfmNX+SWftm+MXyrbdzhMvcRmBAaHbXyBl5YAIsW+YOLufg+Hsd8a4MNkVqWQVl6BMY8bIAakuplhdzOLbsBqRs4VQ6FmQJZFNJlFyXyihkQ0YLIe5J/qzfDPTOD0MomOFpE0wgMIiEpB6B5cvONhVhLdSQXcPQc4Wu8KYZKlaUB4xSCLh7E1s3ob/X13da0FCmS+9EEjn1E8k6M549GlmD0rjQFwyMu6yz6FF1AcI17ruDik573T1OeHeLCDiUIIx1VYk1WXgG7NQowsfldqM4UDGcJ/RWReNsdQiA5HiH6o5GAC3s7Jn41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7RfQ5mQOdiBZgHmWumO6ULPqPpph9WTm71KAyiOhsA=;
 b=L3lid6w/LYvPKrmB1IZeWn/gX+GZ8JMUJ8axI2WNXxowvohNoC2kLvCccz2WL0lUPG9c8yCuN42WtLW/Z4qElkaM0+I9FG4V9ocgda20YECFMQ40m79LaSh+lXroAgN+0a9ABkzPGm7/x0+rDTVBrCwXjgQQux4/98O5IUJWVDqUagvC0ah0plq496xfeD+sX8uvLWNbo3kx5yeABovYYdiUwlPipA3EyH5d7m3/GtJH3nbRKPHBlv2Xal2mIl7FsYJw2zYsYW11r2BsJEJy2DUb+omFzBlzSf1ZSrNvfzloXUfyUj3KZJ0QaUabdO+UStp3LEulKpzuZ+azWc2slQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7RfQ5mQOdiBZgHmWumO6ULPqPpph9WTm71KAyiOhsA=;
 b=cXSG3TnWswAGUfiLPqoYY2JF72v4BkF5JUGr89zGKYitdSgbPvlBMzvmuG5QyXMsxq7DJZW5XujLnnZnhGmy9dDayi+tgQTyz0zKXQXPguvPXnzKlW0d/WfwGxWca1zxgNE0m3s04L+BCdpgFNWFh7VsSE0rLCEaN+VmdDMnAM4=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3191.namprd15.prod.outlook.com (2603:10b6:a03:107::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 07:26:32 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 07:26:32 +0000
Subject: Re: [PATCH bpf v2 3/3] bpf: Fix typo in bpf_inode_storage.c
To:     KP Singh <kpsingh@kernel.org>, <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
References: <20210111212340.86393-1-kpsingh@kernel.org>
 <20210111212340.86393-4-kpsingh@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <03b9679a-d210-81a7-4aab-4beae626bac2@fb.com>
Date:   Mon, 11 Jan 2021 23:26:26 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
In-Reply-To: <20210111212340.86393-4-kpsingh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:4443]
X-ClientProxiedBy: MW4PR03CA0378.namprd03.prod.outlook.com
 (2603:10b6:303:114::23) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::190b] (2620:10d:c090:400::5:4443) by MW4PR03CA0378.namprd03.prod.outlook.com (2603:10b6:303:114::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Tue, 12 Jan 2021 07:26:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bde5795-9fa9-42e6-1cdb-08d8b6cb6286
X-MS-TrafficTypeDiagnostic: BYAPR15MB3191:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3191BAFBBF092EE79BA873F0D3AA0@BYAPR15MB3191.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MB6xzuT9hVrictvxTOwNwTNCqNUgCg3yCvCBx3aRUHVTspNngV44mr4xpjiBdAi06WkiQ8/guoam7MzOHUiKP9KqSKIQy5O+nrw1UET3jL9OmdI6JqhaUNn1h8cgIx17/c3UgKOPSpxog25O72vccK1vx08ANIPgDnCyNkn11YgI65NcUz2djyeQeVoxiWiw9gSxXQEzkBqjwlIbbZEsR3R+H1hsJbsoPXwPAO5PMh6WvXpmZSER80xA9bo8wuyf/g5coCQYpbB+K49nNJngipgP7bNh2OD4vcdIzA3zlD2wjxXRaAHiYwH3HZjiceC9s/pZUVoiOrDVcQ4Ks6GAud/ijiuLfAlaAjmVWnksBdyBo7ekGAwgUQOw23/Zu18N3S3fbSpz9ghGWDcseaNxtZvTCvtr09U9uI/rxzfp6v+FsfDcNYp9MlARBzTqEdMS71jq1uSsMI58+ZVn9Vh2E+blnAj+PQDpiwvqn0YZSDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(346002)(366004)(396003)(2906002)(316002)(36756003)(8676002)(66946007)(66476007)(6486002)(53546011)(16526019)(6666004)(186003)(2616005)(66556008)(31696002)(31686004)(54906003)(478600001)(86362001)(8936002)(52116002)(5660300002)(4326008)(558084003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q1Vva2lTZUFDUGVralNMc3M4RlBiZlhmcFdnWUlCRndYc2tVVkdLVG10YnBQ?=
 =?utf-8?B?WW1IYzNzdXVMQjVaN3FOblBWc20zQTdwT1JZakpZQy9HU2hsbkJZNk83MSt6?=
 =?utf-8?B?SXYveFJnS0M4MmVJOXFuS2dIdG4wdEpvVE93b0hrSUtEWWkvWjg1ZHFlaWo5?=
 =?utf-8?B?NkRSRTgwRW5HMUc4Y0VzbTB1U1pjME91cGwwVmRvaExMMGt5UFMxVU9pOGMw?=
 =?utf-8?B?em1RSk9jOXE5TnJHMk9ieGM2R0ZZcHdRUXE2ZnVVeVJleGY2cHJnOVVhdkFV?=
 =?utf-8?B?bE52OXV4TlBZRFhvamZNV3c0MG16d04yWW51OWpwaTFmSnE0YUxDM2hyV2N1?=
 =?utf-8?B?RHpJR0FYajd1RmRTSkNlZFBkZ0NTNUN6c2hUM0JFY0JxRFdjUFMxVjB6YTJJ?=
 =?utf-8?B?S2lvWGxPRnZRUnpIUzNST3JGYjRZd3pqSVdjR21ETnh4cnZmZk1GMjRsbjZ5?=
 =?utf-8?B?c3NXQkN2SXhBNEVHYWF3RmZrZFhqWmIvWDRDVFh0d25ZaElmOGFQY0VhVDNL?=
 =?utf-8?B?S0lqaDZVVGxVVXoyNGc5a0tsZGd3bVB4THp3dzhFTlkrNUdsTCtJc3R6VExP?=
 =?utf-8?B?OWxSQU00VHhiRmhQcUVXY1ZmVzZsLytMc3JFM2pEM2tIMllkclhJNFF4NHhS?=
 =?utf-8?B?YkJGUitWaGdTOUczZis1WFE1c1h5aGZBanFoMjZCaG5aanFsajB3WEVZWmJq?=
 =?utf-8?B?SlJGWU5FN2VwSGpYM2tmV3lZa0JrVllBTnNCSlIrVnErdWtmK0c3TndmSmhB?=
 =?utf-8?B?aml5VnpkZVZueUlwNmYvTEozNkVGbUtwdUhSdHB4ZEt3UDJXZEg1R081QUpn?=
 =?utf-8?B?dDZaSVBYY20xK3hyK1M3MlJyV1NyQ2toK28yZUtQeml4T0NRSDM5a3hkOE1T?=
 =?utf-8?B?SUs1MWRMc3hPRlJjbXJvVE1sTFNJdzM4S2ZCYXoya1dHWXBHU2FRcnhNOFlM?=
 =?utf-8?B?N0prT3V5Sjh5Vy9FbWkrSExBMWNrNEJOYWdxb25IOTA5VFNpN1poKzlWZ1Iz?=
 =?utf-8?B?bnVZTHQvMHc0NDZBN1lZTzlGdjFPNXpBZXVSczZVNXUrdUYxNExGOUhnZUhU?=
 =?utf-8?B?NUwxOE9acEFuM1NTbW9BcnAvTGpJS3VuVktBdXlyNmV6UFlJTnJyM0wxMHRH?=
 =?utf-8?B?ZlgyQmMxTFR1UTBxb2x2dzB5TkJ2bzA1QzVLL0Z6eU85QzhHb3NXOUxBWGhj?=
 =?utf-8?B?ZkFVUlpiemMreUh3V09nUlRyeXFxa3dVMmQ0MkNRZVlVbmhVYmJKMTVqQ0R0?=
 =?utf-8?B?NEt3RVNRdWFWQVdHT3RnRURFQ2NQMHMzUGlwR29GTGxISXdwTStjbEcrVUk4?=
 =?utf-8?B?Z3QxUExBS3drcjF4L1JTd2E3SGJ4d3dIZmU0K3lxMjBaVWhHcklDUmpUZkQ3?=
 =?utf-8?B?eFdyb2grb0JrWEE9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 07:26:31.9288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bde5795-9fa9-42e6-1cdb-08d8b6cb6286
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlfcvbpcAI7no8HE+w2MbB3hQ5wg+vwjWxUcQOKlqwFhnAK+Zp9uWwbJXsBdRs4t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3191
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_03:2021-01-11,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=913 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120038
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/11/21 1:23 PM, KP Singh wrote:
> Fix "gurranteed" -> "guaranteed" in bpf_inode_storage.c
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
