Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEC6478167
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 01:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhLQAhM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 19:37:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6350 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230354AbhLQAhM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Dec 2021 19:37:12 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BGHMle6021667;
        Thu, 16 Dec 2021 16:36:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9R7i7592LYWTMDC2ykR7Lq5NNw6TG+CCJSWTqk0FkT4=;
 b=G2d0XAhP1iTYW4hkyXSmntxaRkEBu7eaWv57dzz1VHrFBu9MBjxYdCzwraXNEkxeapuL
 7E+D45VgxZ5hsIFzxm3OIsNeyTaKdfQydWjdpyJK4pKoLEXIZY6b38RyqaKd63PAkKXR
 0s9ZaJvbXSpQYUQgfJY5SBdPxm+vEAGThpk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d09t2jv3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Dec 2021 16:36:59 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 16:36:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyjxKJ8kXjKYnL2G50XMk05ERtnS9bzmMkuQgPyd8C3ycV6BcRAhLCbomKTbKCquFR05VK+wPnnnxL/40h0LuXErIzzL73nb8Im5gpkdf4ZQZoI3S/7+xNjLFJ2BQll/kkNlYWy39t9IXGRS+p7FQ3Hc7YH7m80nvxjY0kq1p/oau5fLYdG4AqiAuUCNYwj2D9D5cMaONvKhCMk8I+KNgqo/zyTPZcQk9TevMD5w4OYDmLN2/vBlDTck2VTgUTbDhVoDib2pbMLB2hZGt7e5/9Q5xTyMKFhi6DFhR78CfJij53OYBmtMpudpr1ke1nIXq4uUGM+RTh8kwZLcJIWjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9R7i7592LYWTMDC2ykR7Lq5NNw6TG+CCJSWTqk0FkT4=;
 b=kacL5caph9W6CluVjweTBVmjYs9powHZszYaRJ6R0ehn0K6h4paZRVbBS49NYLdqLcREgLIDpHX7sx7wHZ8CMAeXoptAXwjEh642fuHt3oC7n41SsFmx+hgnoZe8nUeKjv+1JDfLaxX9G//N1xoAwcI9Az7Ol5s3LEIw2x18Dd73Yli6mZ9QNXEajnA7K0jQRx2RF3hvQ3MR23ljeuy4fIwkSkXYmncqaHP3G59bEu3TuWralnU/29NYsdc86J1U4v74nfC4ftpPld5Yd/MxPOB/0ZqjPeB/ukcAo2UKkp7+UMILNAbdi+rD7fBTMi+9gD6lcz2AsvskW357kDlJ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB3991.namprd15.prod.outlook.com (2603:10b6:5:2bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 00:36:53 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953%7]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 00:36:52 +0000
Message-ID: <caf73f95-2a0b-8785-5147-4be81edf6103@fb.com>
Date:   Thu, 16 Dec 2021 19:36:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH bpf-next 3/3] bpftool: reimplement large insn size limit
 feature probing
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20211216070442.1492204-1-andrii@kernel.org>
 <20211216070442.1492204-4-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20211216070442.1492204-4-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0061.namprd16.prod.outlook.com
 (2603:10b6:208:234::30) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1faf7d0e-411a-4cc4-5dd7-08d9c0f5521a
X-MS-TrafficTypeDiagnostic: DM6PR15MB3991:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB399181A21BA0CBEFABEAE780A0789@DM6PR15MB3991.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Dd7MYkGkgZJdRAeV0DQ/tICYH/9FuPH7JPYDVe+DyJHyi0ZG/IWvrbZMRih0zDMnUiG65PyNxOOQeTkvvE69YNb060FZtT38GXWLiN4gxZ3zmD97+X6Vv8ykADSONdtBDMT9kOcn56A04YxX0eymGf39KEMzC1cosU/FCt9tSQolw+0V853b8K0DrpImyE76UhxADeZNeFVPTzDV5y74fQHJZzKZ7TVArNo6/CnDbPYFgHRb2uDsE8tmKoyngyyWN8cNAadRWyviC/45jEhVYG+ukjsHYRubZ15QarAl0Zc1RMhD9eqsiq33+kWn3DwBwO97/9WdlGfrDerAwb2vq+nMdl7j75UtG7C8GfEy9OyQe8pWiplHQWxbQETQ3ii+eQCUZIYLPTqzpgFKowkIh2NCYUXwDEkxtq04ASTrhHv6oCxmzh3euzqjcCLLkdLWSMZWiPsUydinRaAMMVLXW3iU8j2VPJNypRV/SpLTV04O+x2cU4Vk6lYqhBj07oa/lzOg+U1XOofcctvWgjOIEWOe41lAAVDcDSopdzj9E9Xrz63NDXfczqySTMMgY+wCYf12s7f0POIiKqQr6Pwe5KedR5XMwU2ihWWEUxI9QVyVcx01N20wxlOdqAYVJCin3/e4xFmXwiYBW1Ey0EVmUoFoqyyqf4JPkcW9v0GCiMpYMIJjjAr3HhiRrf7rBdmsIrVLcSckYt/84ms6bHhXpeR3Swy0AN6MA8ZUisRR3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(316002)(53546011)(6506007)(8676002)(4744005)(508600001)(36756003)(5660300002)(2616005)(6666004)(6486002)(66556008)(66476007)(6512007)(8936002)(86362001)(186003)(66946007)(83380400001)(38100700002)(2906002)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGtBbi80VVBMNXFLVmxjbEFDNFRXejlWUjlsN2xBc1I1TnNhYmJ4S0NuOXBY?=
 =?utf-8?B?UWdPMmFwQ1FUZTFUYm1zZkxRNDdvdzF4UXEyZWhsdWxacEtuZktjdnhaRURD?=
 =?utf-8?B?Tkc1K0U3emJ0RnlQL0hmTzBoaWwzcHFTUGdOdUIwd1R1T2M0cXlSTzNBM1Bo?=
 =?utf-8?B?NS9DR1F6TW9ZVjZybmZlZ3Y3RUx1N3hjY2lUUld3UU1tMTZsMkgzYTE0Q0ph?=
 =?utf-8?B?UXNaMUdJM1FFWTNvV3FBRGUyb0dacHZYM3h4RXZqQUpaSFVoZCtSdm54SkFQ?=
 =?utf-8?B?elN2ZlNJclZFYjMyTm9LdVZqcXhTWlRrRk41R2ZVMnFidU0rekFqM2VRR1R4?=
 =?utf-8?B?cTUwMG1jditBUkZCNUdOSHgxVFFNV05ZR3o2SldXbzhzLzFMVWFob3lJNTF3?=
 =?utf-8?B?NnBGUnk2UktuWG9VUG9TRWdaV1ZtWkJzMjhXc0VrRXdtcHFpRm1nMHg5bDJU?=
 =?utf-8?B?T1crWEVjNndSM2FCa01iUGU3cDBSN2dHVUN0Nmh4WU82YWlDajROUkhqQUhL?=
 =?utf-8?B?cmpTQitjUm9zSCtydGl5ZzQ5dXUraXF2ajZLekdOakhSaGlWejVXOHZnS1JI?=
 =?utf-8?B?dE5WK0NmL3ZJYUVsQlR1USsrb3NTZG5Cd0xndG54RnJaUUE5TXhia2VpUHRk?=
 =?utf-8?B?QkNZcEgyOGlRUis4NW9OWGlpRzJ0OWIxbnhUcDhXTlpGcHgvWkxETy9WWjhy?=
 =?utf-8?B?WUFHU0pWMURKcDdTMDVlZFFDY2hOMEUybkMyS29RK09jT0Q3TEFiMTV5Nzk0?=
 =?utf-8?B?MHJDb0NKMTNGcnFBRWpubEpSc1RsM3hGVzM0VjJlbkpuWmZZWS9DUlNPb1J1?=
 =?utf-8?B?NWpqY0FKZkEwZTc3MkpVRCtCY2lqc0NtVk1SR21YclRyb2JKRGwydG5udFl1?=
 =?utf-8?B?SVpHYXU0ZGZFbWlGamY4YWJTV20vWGUvOGhzdldEKzlucUw2c0ZjTDhFVW5R?=
 =?utf-8?B?SnhhY0NNR2FCajV0bFA1em5NMUhYRkQzNnhOYWZBb2czVmwvMmRVNU45MjJH?=
 =?utf-8?B?VnhiUG56RDMyenFCbXY2RmZKeEVWeWRUaWZ4RVZoWkd4VkdXM01VK1BOSXo4?=
 =?utf-8?B?TkhTYnhaazZLVk9nMnhqSWp5TXpBSHFFdWxYRisyYzhIdTZKcEh4NGVzd2tI?=
 =?utf-8?B?bmN6aDAwRFRhREhVQ09xV3o2bGdXeDhQdFZxa0ZQMEFkYXNXVVRlZ3E0QXlo?=
 =?utf-8?B?QjU1MkV3c0lyLy9xTlR2clFNV1AyWG9YRVRSSzJiUTlSZlhIMW56WGJTVkRu?=
 =?utf-8?B?Vk5ydnZONlVDd3VpV3F6R2ZjTXdGa1FUNEhJMEE5SUFpQ2VUVkpKSzdEczJV?=
 =?utf-8?B?M1lUMiszSWhZeElHR21Sdm1WM3lFMjFVeTRsOU9oR0hXdWhLS29IUE85RWVF?=
 =?utf-8?B?OFFHQnZRREFuTk9FWnFlQlA3MCtyRzFFRktwYkhicnlHelNOUkEzZERlQy9v?=
 =?utf-8?B?eTVjWW1scXk4WjhndGwxSFhsRURHM2VWSnhMMkYvQWZ0cWs3U2puSkFEUWM2?=
 =?utf-8?B?QU1DQWd3Q3ArRjAzRDQ0dzg0V2ZZMEFqVmNtRzNQbzQxUTZ5WlVxVE9va1Bu?=
 =?utf-8?B?Kzdid3I2OWtMVnNzZlpTZExmb2cxMERWaUVuZ3k3b09tT1dYb1ZYYzQydjhy?=
 =?utf-8?B?NllRdzBQZnAwMTJQUnF2bmFDL2NJT1dMUFhVeWE0UDdmNGJBM240blBtbzJi?=
 =?utf-8?B?NmRWR0pUWUlub1oxSVBPckV6RnEzVWxZRERsb3BiUkZOdFRSS3c5TzlJY01o?=
 =?utf-8?B?dU5LTVNtTzcxMnNWb0dSVjZTc0JXUTROYVk0bk5tS2JXU3YyY2RONi93MU1I?=
 =?utf-8?B?T1ZJdEhseEkxQ2NkeWZ0VjNEUGpZbFl6NnI1ZzVRZWp0Mzk3ZkF2VTV6MTVh?=
 =?utf-8?B?UE0rQ3NqMWloVUxqV253S2J6VXdSb1NMcStnTTJjL08rc3RvdlZWRFVtM0lQ?=
 =?utf-8?B?N2NQbFk4aHNGdkJYRVJmeGpYY216U3ZCeUQ3SzNOWGxMb3R5dEtNU24wSlRy?=
 =?utf-8?B?TWxlSTd5Kzg3STlhZWxtYkpGRU82ZVBZWjNUUlRUa2JCYmRKMVhGSzE1dk1t?=
 =?utf-8?B?RW1GMVliUFFOVWNjQWtQS3RFS21qNVZlSXhVVDNGaTc0ZndVakVHVTlVM1Bh?=
 =?utf-8?B?VFVNRFFvTHJvZEpvK0RWZzdzaytXVmdoWHA3aFFOclcvSFlHaHFNNTRJRW5S?=
 =?utf-8?Q?+oPnFrjsbAOdyMv+DZO0oMohca8ZdrhglpD/4li2S56m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1faf7d0e-411a-4cc4-5dd7-08d9c0f5521a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 00:36:52.8408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZyicHxohXSTy8bL7knoWJEbmqEuINyz+YUKQDlaBiTZTNkFCon6ZqrJ37A8omdkn26rBHcSWG5QiRII62GN1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3991
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: PlVc-gZ2Ezh9OMncYcTsMK79xqgSHaFp
X-Proofpoint-GUID: PlVc-gZ2Ezh9OMncYcTsMK79xqgSHaFp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_09,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=997 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112170001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/16/21 2:04 AM, Andrii Nakryiko wrote:   
> Reimplement bpf_probe_large_insn_limit() in bpftool, as that libbpf API
> is scheduled for deprecation in v0.8.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/bpf/bpftool/feature.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
