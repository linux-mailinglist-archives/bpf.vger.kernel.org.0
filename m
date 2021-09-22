Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875F0413F89
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 04:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhIVCjm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 22:39:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8798 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229644AbhIVCjm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 22:39:42 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLHEtA009727;
        Tue, 21 Sep 2021 19:38:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=gyzgQeyQJtnETnlpWUkl1Xw+d0fQLkDxW7i2FRTyHBo=;
 b=fi/lqpW4Bz+9RCfxXlXCPDhat7ZiPQ+JPWjM+nFKvwEoGGaD1DcEJP36fiQW2Lw8XAT7
 W4kjxsplRGGMPaESpZhvL3mNqeG43VYgIIe/Xu0XUENnl69jAcj1sy0x6s1+AGsIbn+v
 JZypLVNv0WTwe9sqPSpXsmboYcYIR4UOguo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q62hmmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Sep 2021 19:38:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 19:37:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QU9ZCfL1QiKDliWOSv6Mo9MsYvc/z8e3wfiqz1j6RPXue6vXPs/q3TkODwrYxRUNGvV12fmuA2l7lzimGOOBkQkXQ3nHRQ84ReeOsxik0ddgZOrxaMTkQwTNlYfXPUsdq5UVDhCinWgZk+pYbiR3PY2/tevNcjpFkQ4F5Tfcqf4PN9e+5O3Im2N0Gh5K/BwmjfkMfbdzMGjnjjndvXCaxt2OZ+j+z+fEX3DciRsm+jnyudein5jJSkQe5j8hulhsOPkWBZpVhUnyAczB8jw3w0NElxexuA4RiKlN/57BRvgrrL1877ByExEB0wblGiGdmLPKIf728eZB98NHDCQxcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gyzgQeyQJtnETnlpWUkl1Xw+d0fQLkDxW7i2FRTyHBo=;
 b=MubLzHtrrXRnRJqPUFoEghK3jPLbo8DT+/R1j7nGRawkVhXKvXSv3Y/5hpwwOUHBykTPcr2wpI1pry8hlwqzcKOdjzuJbGWMXhwSEREEEiGh4/CpQTtYyScchAVd8HQ9/q9B01ZToAkt9LpcAcGuXavU0kPMPZ9LhaWw6rJFy5W9R3qJS8La6hRcAvxNfwLXVO5JScBQ470dC/rS/9LgPvnV+ygdFmC1JLiieQirxMXyNIo3HEKkKAE01IoRD9e8QRZrPj78R+LlJQZJ2Qz2anwi56LJH8CGymi5+BXwApsVtjur/AtrEo+rJ+pWNsWgM2p27pc9njc+2xuX/k7XWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB2684.namprd15.prod.outlook.com (2603:10b6:5:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Wed, 22 Sep
 2021 02:37:57 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6%9]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 02:37:57 +0000
Message-ID: <38d251bb-35c2-618a-1470-e7115f543f49@fb.com>
Date:   Tue, 21 Sep 2021 22:37:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v2 bpf-next 9/9] selftests/bpf: switch sk_lookup selftests
 to strict SEC("sk_lookup") use
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210920234320.3312820-1-andrii@kernel.org>
 <20210920234320.3312820-10-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20210920234320.3312820-10-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:208:d4::15) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c1::12b6] (2620:10d:c091:480::1:d228) by MN2PR04CA0002.namprd04.prod.outlook.com (2603:10b6:208:d4::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 02:37:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aed9a31f-5822-4505-5b26-08d97d71fcc5
X-MS-TrafficTypeDiagnostic: DM6PR15MB2684:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB26841E8752EA84CE2C8A3E38A0A29@DM6PR15MB2684.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHxsHfa7Dpqg7SWJZbVOyaL9FJTy4Qxl54z/hZu2Y/w++x94dXjJf4sGtHAUcvF7g1lAqncaGUWKrNXDncyE+M/UDNiWQkqg66RtGLtGgzhcT8xt1iVFY6149NhST8wvY8KNtAWylr4IpDRZzF0YTmX8A/yR2rU27We8vBJ0vVE3ZjtZUWMUzRbq5fAvBE7dJFed4hEOSZplZRq1obmiaDNjVSxWSfgYdxZU/0APKScaAfkDVRkSooAiqduBGN7+Ms0rjTE6M+MWI3/7UdLgaWw7fgQUCgOuTxmcvFBc2jnzeOCgzI84B0PcBeFA7aqyYzyRSM2LO/8hoxEeMGuYHQ8FNJnXWx4lnhqozI2WTp/AmQOCS5kblHY0snfJtiimYyHLCh2yoqmcRa39/7kE+q09i2qUSLJykIfl+0OI80hXFw8RYXWQyUfBr+bTizrD1yRW3QIJ/9dLL5IqhthPoi87W6HIJ5asu10mCcVCTipbyLIxStN0uT3aXGckuSYyzlP8c2g+v8wurjgeZTYMMc/cprrE6kYeUK70uB3jdF+TOwvBj7ilKhWMalwrGAWmdZ+IxlnfXrvIit3BmBVQrZveD21v35rBCYvrY4tfMHCxH9rcHz+uq8mbDZOI/m8mXzV86n+S+SlGiHol7e2p4Th+TfbnGXzQMcx5kYR8rYMRxTwxnSk0SNF2Z1YXezAz5yGuPMBZKpubTZlIEp23upUZ6kBCL5KfVbqEGBfWDJ2TjG0Z1k8xhQcDQPcef1O3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(8676002)(31696002)(2616005)(31686004)(86362001)(508600001)(316002)(4326008)(8936002)(66476007)(4744005)(6486002)(66556008)(38100700002)(53546011)(83380400001)(186003)(2906002)(66946007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0pBSGRWRnR3N0N4SjlyQzQyMUJJU0ExbnNFamRYT0NMNlRvRlovZ1FZSmVR?=
 =?utf-8?B?WFZLWVhDQ1VBTVBtSHhDb2VIcDNHTy9iQXMrS2luR01Td2FwbURPeDlHN2l3?=
 =?utf-8?B?NUZaOFh1RVVlYzRsc0Z5SVNrdTV2cmFSaEoyVEtHaUhlZmUzdkFmaWZHRjJY?=
 =?utf-8?B?SVhqT01Fa09hV09mT254WEZKNUd4U3FKS205TDhyYmI3dHE4Mlk5eDhTcGJO?=
 =?utf-8?B?Q3kxQ0tSUTcvN2VPc09GcnRnL0M3UGx1cUh0bkR1TUhxa2xMUGJhTzhWSEF2?=
 =?utf-8?B?ZDJMUzdEY1kzeHd1TDdCK0xUYmFkWEpMR0NnTjVPdU1zTGxIU1ZhZ3hyVlV1?=
 =?utf-8?B?RytZMmhOU1FteG5KTGVURkRsVDVwaFcxYjBRdTJVeUQ4bjRHUFltWGhJbDZs?=
 =?utf-8?B?aFl2d2VKQ1NBMWVDTHdzR2V6V2lWRFMrZ2V3R3ZrRVdHeU1CUVRoOS8zTXVa?=
 =?utf-8?B?VkZraDdHb0FBWm14ZG9UQ3pCcHVvT0FNSzF4dkNldFlQRXMxM3d3eWdJNStO?=
 =?utf-8?B?WnQ2czlENnhSTjR3TGhVY1hRYk5uMlJRcmRFZ0xMeTFyK3gxYTZCTnBxZjhJ?=
 =?utf-8?B?Y1IwZ0xvZGhyRTZaRlpHRzljYnpEMmFpQkNDaHB2SkdENVp0ZG5xSUxuSmRR?=
 =?utf-8?B?K2xiMzh1MjFSU053UnpHbE02czYwem9pMmREcHYxMkFqSlMxZ01XTXhvcGp3?=
 =?utf-8?B?MmZwSXUwTjNPSndpbnI0SHU3QjZtRndZQVRocFZNb3dvVS9ocndjSkw3YllW?=
 =?utf-8?B?OHlDeEppYXpMVkRnN1hUajdtOGhiZVFkSUtDc2Vua3ZDejNzajNlanBqTmM0?=
 =?utf-8?B?VjRuSkIrdGlZMHl1dndvR0swQkJybGJuNkF4bDA3TXdPN3ZoajBoakxsSU5Q?=
 =?utf-8?B?Y1dJQmc5L0xwb1lKU0kwWUs4d0tKb08yaUtkY0F4Y294eDNPS1VSZkgxK2NT?=
 =?utf-8?B?bW1Ubml0OFJPdVF6bzh2VXJmYVlBdVhNWkR4ejBRclUvYS85ak9oQnFYM1Ur?=
 =?utf-8?B?NURkaUxjdlBzY05rNVYyOW55TnQ3Wm9zZHNSL2xGbjBsTTVmYXRYekQwRUwy?=
 =?utf-8?B?S3ZaaDlBOXA3ZG9zZG9kVkxzMEZXUFN5U3V4VXNmb2JyNlgySk56S1pIeUx1?=
 =?utf-8?B?R1dPcnZ6cUlmRGNaUWNaRi9yYkxabE1hZGRhczUrZThhdFplQmNHbklXMDVX?=
 =?utf-8?B?VTA4V2RSVGpZeGdnSzBHS3pOK0UyQUx1MVhvRDRUd2lVakJJQWZEaUl5a1dN?=
 =?utf-8?B?d2NaQzZoZC9NcXVoaUhibkxEY0g1c0dzM0RNYVRaSHRQaks5U2JVcE5RSmhi?=
 =?utf-8?B?ZjRETzFIbFpVRm9TN0Y4U2VrOXFEdnZJN0RNU2labEpBS0M1R2hzMkVzMDMy?=
 =?utf-8?B?YTRoclo3V2dHKzFxdHFwOHE0WVprZWdQREdWSE9XVEVmdEpkNHlqcXdaaCtQ?=
 =?utf-8?B?Zy84SXNnUmovNGNGVEJocHdxRGFqSDgzRWpPdXphckdURFQwSWorQlJYMEsx?=
 =?utf-8?B?eUF0U3VMeERzWmlGbW1DZWNQczI3NVZ0V2hJd2pKN0dod2JDWnVodjh5Q09B?=
 =?utf-8?B?U2hKUG5KeCtmbktJWlNzU3p4bVJoY0dsSDJrSndvY1ozRUlHSzlYbkc0T3Vs?=
 =?utf-8?B?RTdhY2x2eWxKZjVrdWd1aWVnZldGU3BuemhGMEZvVFpsdXpOUGwyYm5LdU40?=
 =?utf-8?B?amNnck9tbFBGcFJ6RzlsUHphckx5UHBGZ011OEpuMkt2VjFoVVNCM1JtZVNr?=
 =?utf-8?B?bitxNTlueUNYR0EzSXNxdU9Wakdpem9CZVE4cVdMV0hoS0phTmdoOXFXZGZu?=
 =?utf-8?Q?K6gWMwdzXHFef20HfxN/SlgFjfiPsQ5dl4dfU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aed9a31f-5822-4505-5b26-08d97d71fcc5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 02:37:57.6658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnd/dF4mL4iV9HpgHXUhaDOuUBf+hMEv1TVS68qGoPm/JCm4mke7TvEviV4QDcxhaRHmO+SLCDEUIWRy7cQ3xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2684
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 9c4-ZANeJ9yzJdt-S2_VSABqwybZT-X6
X-Proofpoint-GUID: 9c4-ZANeJ9yzJdt-S2_VSABqwybZT-X6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 mlxlogscore=924 phishscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220015
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/20/21 7:43 PM, Andrii Nakryiko wrote:   
> Update "sk_lookup/" definition to be a stand-alone type specifier,
> with backwards-compatible prefix match logic in non-libbpf-1.0 mode.
> 
> Currently in selftests all the "sk_lookup/<whatever>" uses just use
> <whatever> for duplicated unique name encoding, which is redundant as
> BPF program's name (C function name) uniquely and descriptively
> identifies the intended use for such BPF programs.
> 
> With libbpf's SEC_DEF("sk_lookup") definition updated, switch existing
> sk_lookup programs to use "unqualified" SEC("sk_lookup") section names,
> with no random text after it.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
