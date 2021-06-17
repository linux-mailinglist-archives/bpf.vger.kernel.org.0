Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464883AAD28
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 09:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhFQHOI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 03:14:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13952 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229599AbhFQHOH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 03:14:07 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15H74w7b032129;
        Thu, 17 Jun 2021 00:11:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=e6qg7GLkSAOxlCxOPp5OKSWVY1+Yiy6W2iYZt1Ej6LQ=;
 b=KQyOaZIDWb5UQQHYvXxx+I8bNSaKPIVCGITW1yx1x4HkW/kabaRSTCpnrF8rilNETYNy
 ubuw5QM4Amj+FmHl3bfexvU1QNtj7grz9Mjn3n8CQb0hLVfWWUL+kNRflfAgbieaQ0OF
 46YRl0YsNiya9XOiAQcoxh8tSxrLuYI375w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 396t1be5yd-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Jun 2021 00:11:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 00:11:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2B/TVjmVFerYYAOyudtvDZurpHErbARPdOy8kIdfaw5sQwHH5t+lyVkojHS1eHzNjB+0nSn8KjudA280vOQLVDELHzciXTEbTzYkK3Ik33XDrk8Dd4HhI/BeUjxu4ZWdL/SBhs2pEOdg/xMHYu41O3RqbsfCCNUBikoJWW+JFot2PsS50DZ1Ju5+xgaVfVEQWwmKSXJ1TeBXcT03JT/DjTSwGIMg/7VqQolLZXelT5qyPtzKI+8fgywuoQceYlUHgug+ovohktO28m5rZqjjpimkHeLPzDzighkizga6f0pdMUdITnGX+qmAb/v3lbSmk6tm/s5WNAZl1Jbq0dJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6qg7GLkSAOxlCxOPp5OKSWVY1+Yiy6W2iYZt1Ej6LQ=;
 b=dlJAOLm9luAvPdJXZGFxkGMKcQcDWfBiNRxJfTjXVryU7l71CmeV/w8/cwCCNdbjJKR6KE6YS+SxVZlDQYU5vRdBNw+fmvHPIyWOL/uFl9YcfmCU4ctvfjJCaf2k219zyks84zK6j9ofK0U1/fjHFgPskpHYCPrXWUjf2MRBgKQIA3UgK9o1cqFiizXIQdp1WpTLTA2ICA86fdQrwzv5xxKqVZxut5QG7oBRWKxoQ8jQKMJBhWonwravzHH7RR6F00J42jZajssFEZ0J6iO6PltfdFs2qXGuVnxJgGWY8+aDDdW2xkmHP6lCRTDnR7Dor1o+CCOXcRZ1vyGsGC/ZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: riotgames.com; dkim=none (message not signed)
 header.d=none;riotgames.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2256.namprd15.prod.outlook.com (2603:10b6:805:1b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 07:11:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 07:11:35 +0000
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: Add test for xdp_md
 context in BPF_PROG_TEST_RUN
To:     Zvi Effron <zeffron@riotgames.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
References: <20210616224712.3243-1-zeffron@riotgames.com>
 <20210616224712.3243-5-zeffron@riotgames.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <5ff53b96-775e-c0af-8b83-d1e366fb2d3c@fb.com>
Date:   Thu, 17 Jun 2021 00:11:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210616224712.3243-5-zeffron@riotgames.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:6d3c]
X-ClientProxiedBy: BYAPR05CA0098.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::39) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::12bc] (2620:10d:c090:400::5:6d3c) by BYAPR05CA0098.namprd05.prod.outlook.com (2603:10b6:a03:e0::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Thu, 17 Jun 2021 07:11:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58d064e6-8d05-46ce-f023-08d9315f2498
X-MS-TrafficTypeDiagnostic: SN6PR15MB2256:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2256E39B8874FAE4C4340315D30E9@SN6PR15MB2256.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DxvnophMBDHBxiUSUgL/HYOb0Rk7RVFKCYD1yOO5iI/vAh47alMCkXPT5W45qtjFysFATKumLy+XHQG9vmgz/CH5QFWmc0m8MeHL6+nCiL9lt5Bs84WA5cnbneFER4wKJJnNj7AkGjYctyJ4WoDqKARa7B6pHJI/SLzUt2SKIDfHHt1/TkMylBhcQ1pPH2sEV4peX5BfRcog+F8dR2yBUlDOSVfLrRAUpcj4kgODSa5uJgH9eVa2DNANYXLlpTJ6DiotlJg34p15T5/Tos4jKg7MdOgU8LBJPDj/wKY/nZSMTGEx0vZbpmtc8PgCarxMQ4nNats0uHkOMT39wpGHRGEiYc4tTqed/yR0jfDWUcGyVd5v4Xmty1xDgKFIyHrxmFvtPCelXewl3fieCdT61CkQ5B1IAU7wbYRhJHSgXsZdLcPrOFgWLFZg8E5Y8h28sUnprhyQPZvX/90ziK178iPu860Ye05Ys5a6W9IfOhak8hwTCNdFxiGYk9Uhd4Tx68Lug7Bymz/XDKD/OhAwu29xPYftxEnHQKGpLop+WfxMlcx9xbsWaU0+ZXeaEuRQ58CrxBSCyCjSVnXv19bMzlVEMGk3teUK1lgwl5o2+evnTUx+f9XaclgrzD4MTqjqUuWeomMB+ontRe5XcTP6U7MfgFTRQ9JF5PP8qpadCziM2RgNCThw+0clFRkD8lrm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(186003)(53546011)(478600001)(16526019)(54906003)(86362001)(8676002)(83380400001)(31686004)(8936002)(5660300002)(31696002)(2906002)(52116002)(2616005)(7416002)(6486002)(36756003)(38100700002)(4326008)(4744005)(66476007)(66556008)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1BHNGZLKzBDM0pjN3VDU08rSTU5MXQ5L0lsdjA5OEpiTk1lRzV3cmVKOE4r?=
 =?utf-8?B?L1RiZExnU01rRjNTUzJxdTArbFRlS2p4NDJub25jbUdwZ2ZEVGx5YnROVER1?=
 =?utf-8?B?SE5pb0trNHAya2NXeE05Q1NjOEdpNEIrSnNXRk50Z0N3dG9SK2JiV3NYUnd4?=
 =?utf-8?B?R3I5cmVERk1kcklxOXZHbk9LK05FYlJReHRISEZuZFBJeXVuMmIxQXRNbGlE?=
 =?utf-8?B?aHZjdS9sQlFlK1B5dTh1RnQrdHNIbjVWS2p5R2dhZ3RpRVU0UW9qemIxUi9E?=
 =?utf-8?B?SnhJUndaS0V4UUloT2tlTUlxcWRDblpJbkhWaDNRUE40bFVrYUhOazhzTHkz?=
 =?utf-8?B?bFcrcVk4NmZYN1J6cUM2cVRpN2FpcnplSjV0eDdZbzAycmJ1N2VvNG1lS055?=
 =?utf-8?B?Rm53emZJOVlRZlFUK05QWGVmbVpnclluaTZ0aHQvbTZWRzdxWEp0cjFRUndt?=
 =?utf-8?B?ZmFra2hPTWdtZ1B2Zk1mc0pVOGd3MVcrZUZJd3ZUNTh0TTgvUytIS29PaVE1?=
 =?utf-8?B?bUp6dXJOWDJyb1haQTk0eUtKWTNlVExoWVAyRGNYcHpIdkNzYmw5aFNpR0Qr?=
 =?utf-8?B?amFwcnhTcUlPajhLaWFaUzRYeEFCQjVSaDF6NElQVG5HSWUyK2ZyaHhXZVVi?=
 =?utf-8?B?NnlVM052RHVFZlRkT1B1eVZQcnpSaU1FUERlSXlBYVhCNGtEWkk3c0VYSGNS?=
 =?utf-8?B?aDFQcmJTeHZHMEFqbGhMSWhlaVNmUTViemg1SnU4SnRJQWFrKzdxcTRsMUNS?=
 =?utf-8?B?Q2dLQkxmRWRYYjlKb1N4NkIvdTF5UVpTOFlzYlYxVzFOYnoxUDdDUHBFWjE0?=
 =?utf-8?B?a0xGeDBPTzVUL05mMkJRc20raWtnVS9XL1FVNUNCSFIrNG10NDlVQXVJdGdM?=
 =?utf-8?B?TExSSXlzTWRJUGNNL3UvVUdPekR5cE1JZ0RjMGVYdmJGNUswVFRQWFpEYmhJ?=
 =?utf-8?B?aXJ0aHg3c3UrdmNXNjhVZ2VKZEdqY2FnamU4cXZCcGJqNVJwZnZiN1kza1hN?=
 =?utf-8?B?U01keHJyMkJOSjNRcWhkZG44Zys4cFJTVGlXRGUrZmlHK3R0QUN0bWViUzE3?=
 =?utf-8?B?Z3hYN1NRUTF6M3FwcUt3cEtUUEk1WEdVaEtrOXZ6eWJPZjJZSEh4a2xJRjRa?=
 =?utf-8?B?S3JFY0tXU09yTWE3b0FoM0J2c1Y1STl3VFJMc1FmSHYwZm1rdEZkQlhmdm5D?=
 =?utf-8?B?WCt5WndTd01qa1lTWlVtVkpVYzNKRng5R0VxZzJkUzBWVytSUkY4MzFYeUlK?=
 =?utf-8?B?VHFFdk5SRFBrbjlTY21MUmpBVjMrRVRLSzByUjM1VGZOZkcxYk9sRHBvOTNG?=
 =?utf-8?B?NXUxZ2d3OGpCUnFBbjFFVVpOREJoZCtjajRvNy9ZT0t2YXVzYXRvRkliOVRy?=
 =?utf-8?B?RWJKZTF2WHQwSVJPN1FVYmJyZEVYNGRQeDRMZUtwZFREYTlKOVUzM3VnZWE2?=
 =?utf-8?B?QzBXS2pTdFNEeGJNRFZJckN3NmJkZDZEeVo3OWZwMTlLYVVYVkZLVGVVa1Iz?=
 =?utf-8?B?ZExPRytxNjdUSzhJRjlxMUxSMmpnRXNFcmdFNnBjNHFDVE9URml5QmhwbGVs?=
 =?utf-8?B?ZmRkdzFkTi9WUzI4aWJFQTFpZDZuL1Y1UDg4bjhkdUFlOVRQWVl3emlYU3ht?=
 =?utf-8?B?K1VTV1NUcCs2OGJaRlNLK3E4VURQVVdEZllROW9CWjBGQU5MMU9uekJZK2kv?=
 =?utf-8?B?ZzhDMGVEV2t4dlZEejI3dUQ0OXVHV1daZFVhOVRsaVRRR2Fpend0OUI4NFVX?=
 =?utf-8?B?NnE3c3JWOGxkOGs0bjhPdTk1b1VWVFkvVGdOMW03NllHMTFYbzE1SUczYVVu?=
 =?utf-8?Q?Cz8QKZdfjZSNhBp9C8hJXAW4NQ70XRv+MaP7c=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d064e6-8d05-46ce-f023-08d9315f2498
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 07:11:35.6611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3HOeK0/sazipPH84eQRNDoGd1JR5PnCxFzrVqV8XxAfnSOIcmWyhADUndJN6gxc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2256
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: QUv2Z7G3XclriUPcA3mct65W-PYBGQKk
X-Proofpoint-GUID: QUv2Z7G3XclriUPcA3mct65W-PYBGQKk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_02:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170050
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/16/21 3:47 PM, Zvi Effron wrote:
> Add a test for using xdp_md as a context to BPF_PROG_TEST_RUN for XDP
> programs.
> 
> The test uses a BPF program that takes in a return value from XDP
> meta data, then reduces the size of the XDP meta data by 4 bytes.
> 
> Test cases validate the possible failure cases for passing in invalid
> xdp_md contexts, that the return value is successfully passed
> in, and that the adjusted meta data is successfully copied out.
> 
> Co-developed-by: Cody Haas <chaas@riotgames.com>
> Signed-off-by: Cody Haas <chaas@riotgames.com>
> Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Zvi Effron <zeffron@riotgames.com>

Acked-by: Yonghong Song <yhs@fb.com>
