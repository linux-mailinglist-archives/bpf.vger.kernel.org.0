Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF0043F268
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 00:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhJ1WNF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 18:13:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34404 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231341AbhJ1WNE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Oct 2021 18:13:04 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19SJ4pLV001702;
        Thu, 28 Oct 2021 15:10:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Kr1uPEIS8JFNc7dYoOjp5LJTvsKZXU+WIJh57oIAsDE=;
 b=GCsnCH+1YdKJPv8IvFnnz2iu1ZzWimx0fmzVGCvsYCH+OJ9wh4WeS6ai7sEZFxA0DBOO
 POBgvW5eUr9eIWd3KbuZYVk66IwVsa0vXsE+6xauWR/VKOvRgYvb5E7ZQqA5rn36aD19
 W5M9ZQGBFaF+od4zzM20cE3I5MXIltnrODo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3bysx3mwc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Oct 2021 15:10:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 28 Oct 2021 15:10:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jc4WJeVlSUQ8R9jscaq96AXWqxNrh1KEua0B3vXG6sabJl6l6PB+9yg/tm0V8e7sovJmlOPRo+85AGAPeQBQm5+YLn5J2ADU18FPjxwx132nM97oHShZyup7unEn0c/HX+MBL/MdQqGK5BIg2V56TIv2cdWHGukSw4rqYNLUrsQfiBX9wUa5h1PNyvmlNkG4lcSFutrALZWjeDH7ZItsMihh5dGZuBDnnCBPekXQhsuJGJfN0UdPlgwfgW2UP2xF5i/+6NOjlZF4R6F9TBoA4mrdN4zgw9rWTbR5qL+ce5z3hbmC84SScEe56RkCiuVSJpR7+Ufzsa4mZUctsDxDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kr1uPEIS8JFNc7dYoOjp5LJTvsKZXU+WIJh57oIAsDE=;
 b=Yy5S/ZDn016cvbvyZN8bNhBKwtpSPEEasFmT+HlenlYK0NAqM/jx374Ggmu9n1LM+eZjmF0+tpCXU/Dfx18hXqMGZnAs/ak8/H9o39n5zNeX5WpZn9auvoeelv9oGjqJJAvlQ08IlSDTYGrcsnxCePvaA5StvaINsuhNzVFLQZeYins6FzJhgkziE7VYkC+6QprnMIaZgLBi3TOaolm5Bz/XfXFPq/cIjzX7Bquhuu96EddHhCWQMQJ39JN0tRNgj80I3g1Jh8kemYIcUNQUWkDosyBXXNR+v4gFOJywjzhM4km9EM+pS6+r31w6pRYJiGkoBIU6A2PcE3lPLceLIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4595.namprd15.prod.outlook.com (2603:10b6:806:19e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 22:10:22 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%7]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 22:10:22 +0000
Date:   Thu, 28 Oct 2021 15:10:19 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannekoong@fb.com>
CC:     <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <Kernel-team@fb.com>
Subject: Re: [PATCH v6 bpf-next 0/5] Implement bloom filter map
Message-ID: <20211028221019.oinkfqhb3keuuzau@kafai-mbp.dhcp.thefacebook.com>
References: <20211027234504.30744-1-joannekoong@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211027234504.30744-1-joannekoong@fb.com>
X-ClientProxiedBy: MW4P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::10) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:e99c) by MW4P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Thu, 28 Oct 2021 22:10:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96b4d51b-37a8-430c-3bc8-08d99a5fbc30
X-MS-TrafficTypeDiagnostic: SA1PR15MB4595:
X-Microsoft-Antispam-PRVS: <SA1PR15MB459579F3571D13EDA8407A38D5869@SA1PR15MB4595.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ABeuEzmywa6ZY7sQOpHXLoyc2NvgBCiiQnISYO5Vpivv5IYgJ/TR5zE66X8xbHVDVfsvCW1zKM0s/KBplY7AVRsRWdz7I/X4iomWusR96B5pMA2ex8QJRuXFc118MH2i5R8bysJ8qz9A/1ueGjsh9vah0sRXGp4afJlI6R/28zJPf/9bzlRDf6K8oQL/v9eCtq7MozxgJL6TZ1mfnzBfgSnEnSJRd59YI4rSFqpbYDNvZvQoBLVMP4degO4WwcQet9sNeSkH72rPaQCYoUZEDfFdr56sniWMR4U+RTuU1mSyXLP9pFP3Z0/hcabwkoLXrj9Zs52XpKz6CcXabNwIkyFHrl6xZALoTpnEkYKhxo2YIDm8T1fvI8UdIL31uHof0xLeLZikKWt46vlaYa4bzQaCF60g1u5dXr1H4aP1yDcJQfy6rNvFVjrhXZIuN1GuJ/Dppp+xpgOogcJEmKtYGuC0Z64QxeVljPUbXmWoYoyrcEU0OIvNxy3R+TQchM26k2s0vTXsXw5lx/j0PJOKZQAXnUTDU0ksar2tdAcFYsNABXUhhQ7dTH67/mayBf/UPAt3rV5H87IPuBNyADORWuckMUk+jrmpnEeZLLO1XhzCWFeW24fG5mRXUy+jVOoLMjfcBfCSles+dJqdYdOzsBoYpBlbg7kezczzKRm9gXNsZQ3OVw5kmQn3AJ/lS8rViS1pXmtGNoAQbbUfce7yp+WleCUWax4xe+ryrWOmkDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(6636002)(8676002)(9686003)(2906002)(6506007)(52116002)(83380400001)(8936002)(86362001)(66946007)(7696005)(5660300002)(66556008)(316002)(38100700002)(66476007)(1076003)(186003)(6862004)(966005)(508600001)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pPubCyskOjbgbDyKunyWES2UlxSGYal12aVki4gL/MvaCdB+9faprYPCtSjX?=
 =?us-ascii?Q?Jmd3vmmmAq5cAmHFRWZWEZ+xPRPUPzRCGJz9UdKeAial8fotmJha5vzazMqv?=
 =?us-ascii?Q?O3iFyPa/fjzGL7paFYNlFp9mnOoIqHtfgXFG/LqIbpfp0IoOrZG1hf051BPb?=
 =?us-ascii?Q?A4rru9vyok07t8tUMzsrTx7zTBM+UJPRbmWkdllc9O0FA5337sR+NKlipj38?=
 =?us-ascii?Q?e2MMUvWa4BOqYTV9G9M4K8VrQiu7Z0DTO0ACJum7V1zMZXKl/+RmvaTJrJCf?=
 =?us-ascii?Q?sxA/YLYZ83EAVXvmxzayqxXBTgoP+PA/t0YdNVU9mvBJq5WGtXbLUM1lzmz8?=
 =?us-ascii?Q?9rkKkObSWHcH0ppOCL2QHyUEp8JS9h9+fFiJPagPvFuvueIVMB/qmhAdR285?=
 =?us-ascii?Q?YCIZNOg2bN4OHp/eKT14zTYAkhp6sJUQQ1uTIXJjC9gcwhzOd6B70TccIhME?=
 =?us-ascii?Q?dXz/R4rSVKv7W266F4MJOlzmYQhyPTv2kMXL0YLtk/Y4I0urWj2oMwnZJXxq?=
 =?us-ascii?Q?zJW0e2QOGw44dAo9ihiK0Ox8HdOjlYSDzBa8lCjI6eThO8peOdCvXrTfjqZa?=
 =?us-ascii?Q?6jFn2IKTRJ4fC+8Q73wqtzF5tFyOHQFYvs9NTtL4cJBdXUl/75GhgRgo9wTj?=
 =?us-ascii?Q?QpZDq1hYrF6hhRI4xgjdq/ZE9fdx07MYR6n0/zYWs+m646ShNv7MYTtTrkIo?=
 =?us-ascii?Q?/UVfiYKjl/+YOiGyB/OsgU05xI7HURIiuZJHLefN0CY1AhQR/EkbrOQHzvTO?=
 =?us-ascii?Q?dQOkqKNcw2Mwg6e2kBidzUKzbObdshVPM6Y4rFNSb4cn6z0ZWNaSyWbmycdo?=
 =?us-ascii?Q?dfHODxfOHbHKkpiUzT3oXNMhW3RW82xLwrbqwAvqHN5L/c8TCqbia1FV6wUd?=
 =?us-ascii?Q?P08ElYksxklp0zBmSsbo/uJi168O0Ack8QmU9cD968qEnNWngQgHGFf/rxkD?=
 =?us-ascii?Q?cYxeC5VBRIzCIdT2S/EllG7TCcIfLKAEwF9+RP5qKmr7tLSzCzWdB4UIRY4B?=
 =?us-ascii?Q?vMyegmqdPD7bOxNwpFbcItRn18HC6FKcqze7LXPDYW2QQmbWI3Xx5trP+Zqb?=
 =?us-ascii?Q?9IHOiZZuzQJ4F9mH3ZYtPLT2WZ0LuLm9P/a4fzxUZfr0d/EFziL/QTYDwjTg?=
 =?us-ascii?Q?PoKGDIB+ub+iF6t10YzbpWvvNQT5ueJtcC4StX0xvVLhtuyRzO3h1HF+j0h/?=
 =?us-ascii?Q?8wBhCKNWhoB6BA1chl232MRyS5E+L44PkCYJhLvo9ghvFAjiMdDHWY7McZtc?=
 =?us-ascii?Q?GG5ketPvYnYOKLO3GKIW4mR3RXZ+vnFDHi2GPln6hsLUKm1uUFpKq7Tw6AKC?=
 =?us-ascii?Q?CMVGgmJzFXVsr31I2GvPZT2geUBfiT4yMlu3xNfKxvE0+LVeGrJpnLG8HIR9?=
 =?us-ascii?Q?/1lnsElc0TT0EndDj6ZkyZiIU1Gvfea3PGZiqHUX7dLRvGB64E58IpZkw1Pg?=
 =?us-ascii?Q?fKboAaT3alSDx5lo2udsyEjU0ApS33l0TqEUsqsAuNW96QgTXRQaIoRPq+m1?=
 =?us-ascii?Q?Soei7W22xg4vh8k8S3dWpaM2yuzeXKQQxa6lVL1rUqPa9lXrbRj9u+E2LP8C?=
 =?us-ascii?Q?WuOAGBe4zc2u5RUMMcNhCWnOKsbUZVktwl7IJg2L7fbKCxBaeU94ONB6W7MM?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b4d51b-37a8-430c-3bc8-08d99a5fbc30
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 22:10:22.0599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPPFIgk/buGF4EZrtEgIGVFhH6zFzMIHTGcdPnqmLGEhj4shx+g607WPDF5rrnKg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4595
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: kvN_n0aW62bPzew6us2izBhQJhQqWRpp
X-Proofpoint-GUID: kvN_n0aW62bPzew6us2izBhQJhQqWRpp
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_05,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110280116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 27, 2021 at 04:44:59PM -0700, Joanne Koong wrote:
> This patchset adds a new kind of bpf map: the bloom filter map.
> Bloom filters are a space-efficient probabilistic data structure
> used to quickly test whether an element exists in a set.
> For a brief overview about how bloom filters work,
> https://en.wikipedia.org/wiki/Bloom_filter
> may be helpful.
> 
> One example use-case is an application leveraging a bloom filter
> map to determine whether a computationally expensive hashmap
> lookup can be avoided. If the element was not found in the bloom
> filter map, the hashmap lookup can be skipped.
> 
> This patchset includes benchmarks for testing the performance of
> the bloom filter for different entry sizes and different number of
> hash functions used, as well as comparisons for hashmap lookups
> with vs. without the bloom filter.
> 
> A high level overview of this patchset is as follows:
> 1/5 - kernel changes for adding bloom filter map
> 2/5 - libbpf changes for adding map_extra flags
> 3/5 - tests for the bloom filter map
> 4/5 - benchmarks for bloom filter lookup/update throughput and false positive
> rate
> 5/5 - benchmarks for how hashmap lookups perform with vs. without the bloom
> filter
> 
> v5 -> v6:
> * in 1/5: remove "inline" from the hash function, add check in syscall to
> fail out in cases where map_extra is not 0 for non-bloom-filter maps,
> fix alignment matching issues, move "map_extra flags" comments to inside
> the bpf_attr struct, add bpf_map_info map_extra changes here, add map_extra
> assignment in bpf_map_get_info_by_fd, change hash value_size to u32 instead of
> a u64
> * in 2/5: remove bpf_map_info map_extra changes, remove TODO comment about
> extending BTF arrays to cover u64s, cast to unsigned long long for %llx when
> printing out map_extra flags
> * in 3/5: use __type(value, ...) instead of __uint(value_size, ...) for values
> and keys
> * in 4/5: fix wrong bounds for the index when iterating through random values,
> update commit message to include update+lookup benchmark results for 8 byte
> and 64-byte value sizes, remove explicit global bool initializaton to false
> for hashmap_use_bloom and count_false_hits variables
Thanks!  Only have minor comments in patch 1.  belated
Acked-by: Martin KaFai Lau <kafai@fb.com>
