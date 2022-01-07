Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03001486EDB
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 01:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344304AbiAGAaq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 19:30:46 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3256 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344231AbiAGAan (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 19:30:43 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2070DUfX023675;
        Thu, 6 Jan 2022 16:30:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=LWmN0wf1nTvfjVAxhkc0B2S5LEdeK0qIH8Oyh5JhOD0=;
 b=Q7+XH70RqtDqajp9SDxYgihIf9rEcovaK3pRFMJ7hSSgFEKJb9g14CD5FN9M5wJ3Ydwp
 KP4EE5TAevbzBuo2cXGyulJVxEY52WyPG3OOLr8XSV4g12bHdFgJLFhkFUluzdF1hFQ2
 FlqoFGXlStlv/PHrUryj3z95HsyCCB8dG3o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3de4vjte6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 06 Jan 2022 16:30:27 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 16:30:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2sCAheBoFaTvTUFqdXfWMRZBNX3bkFfM5lq0U/XFTsvf2w79WNmg/enFWeRvyzibmYn7XTQCJVLoBwFyqDsX6vdtJvANgRVkEwS6Rh0Cp2rH1x5DQ2c3Lf9lhsKIDE6YNd9ZKEGuSVGEVYPr8pPNvnyaW5P0PgAUgNc9yoDXWHsW0tTFbPCF3H9a+dF4vq9Bvb4orIvqJvUKva9Qi+ggJtNySn1UZaFPLfiNoaqnJ5ALzv2zCTE3o6q/ngeTY70Slf2FQNYB9Qw6hRH8UDon7LqfTpooASK9tqAIufVXJYSBQg36EdJky3zuKY3WyP+QrMm+IfJh8lgKO5ionmZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWmN0wf1nTvfjVAxhkc0B2S5LEdeK0qIH8Oyh5JhOD0=;
 b=T2dmV8sNIonmOSbX3KAWuxZ/1cN395wM4igsFDdOG99vZZ1K79B56jUvUUM4/BSZKwna4sc7w59xLhM2ylbiQrst41YlQvtm+cvLngzi7DlZP6oZlWDSl3Eko7wpgFZKJ5EhYoK+kiszkJCxrRp3/HaxG5rJ190eW88hklq2bTw80YRE6HO87vlFFMNzgDQSXH3lNKCeq+y1sSmke3c8Ru+NcweW/s6hqqH+ytwq1DVlN8EXquQZQWtMtrQ4+GwP1mnoMXQjtlyAup8EiyCq24FR5mUWOwX3y9lc+LpXViGB2eqHL9E4YgrFBXUh99M/W3NjNQsmiqlNno186kv5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM6PR15MB2298.namprd15.prod.outlook.com (2603:10b6:5:88::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 00:30:25 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::8988:8ab3:bd6f:514f]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::8988:8ab3:bd6f:514f%3]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 00:30:24 +0000
Message-ID: <86203252-0c97-8085-f56f-ea8fe7f0b9dd@fb.com>
Date:   Thu, 6 Jan 2022 16:30:20 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH RFC bpf-next v1 0/8] Pinning bpf objects outside bpffs
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, <bpf@vger.kernel.org>
References: <20220106215059.2308931-1-haoluo@google.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220106215059.2308931-1-haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::10) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dea1fe8-16fa-48ba-87ad-08d9d174e596
X-MS-TrafficTypeDiagnostic: DM6PR15MB2298:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB2298F015B73D4C4FB2D8358DD34D9@DM6PR15MB2298.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1d3bmGJQxujUc0rQg/gS9oix1Fr3PbblkoodtyrDQ4ma6ULhzbNAElaEzEZVexqGf1p5bjH3Uxc58/mlUUh8o24qsX15H7YytQ6YWPplGCrRdcoMhodCpaopTIKhtzA6pLgUjVOb0eGZngKJcNwpGFafws56b5v0EBVjPupZs3d/ddCX3pH7n9M/jHiVJr7FzpsuM94Lf2doitnhCkHZqv/z1rqUangg8dykKQ97NTW8QABrwueFDDMsXkZoSADZjGg6PSiQyN2atFIazmfTgOBx53FGA2P8jQ0JiYAbkKSKE8h+xJKkw7YwhvjzvLTdZXhieWPgRneQONvPtRDi9IS9XNsXhJG2J1qlNMWnmchctONeo4GpsGJhSzkEYILd/r5DEyvrxjLuLDMC0150wqCZCCqbeJwefx6BurMdy5x1QVaFbpGrEB7if/0BjFH+RV5487TBI21ArI9YJ/nyUwROjuJhe75cawf5ijjO5xLt7PhQT1aQjNNxtqW53etuC6JB+0im+BPX1e5mq1XjKT738AYGFKa9tio9BlgSf4uXtACW+DIfe8kmc9kGWiY9oTDJ24SHq+lBpYZ3s1W0zP5D2T2J/GCDg4qcgRPIduI8tylX87WnqsUGoU39QuHBQUYpnIopqGFLlm+T7oZz5B9BZYOjAYelxNA/iBZoBK3BEbz4BtTiCVJdUiGHNu9uZS95SgZ8Ok7fL86Yt+dbInO51i/6h/31HwakOe1CCTs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(38100700002)(8676002)(6666004)(6506007)(86362001)(53546011)(36756003)(8936002)(6486002)(4326008)(2616005)(31696002)(186003)(54906003)(508600001)(316002)(2906002)(83380400001)(5660300002)(52116002)(6512007)(31686004)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXFFS2ZtazVpTG1UdkNMVXg1cVVBblp4KzVYR0ZGVGlaYjZtdS95UGRVTVVQ?=
 =?utf-8?B?TTh4a0RRT0pIVDlsS3VnOXF6U1J1SGpxVW1HUGVIVWh4aFphaE5xWEgrZGJN?=
 =?utf-8?B?bGNwc29NL0swc0I3eHpmMWRmSFZMcVBjbnROTVdPTTE2aXRMTDJJamk2b2c3?=
 =?utf-8?B?WE1yOEp3d0dBLzFsY1R1eUxmZkljRGZVanRwRVVwSXJXZExObVJPd29DYUN2?=
 =?utf-8?B?dnZKR1NLSFJwcldlR2ZiS3ViRHdGVWFtQWIyRTB5ZGN4N2M3QlRhVWpldEJz?=
 =?utf-8?B?eWFkRmRvTDczUHhiRlZBQnozbGZkOHNCd1F3aVBDbVhUUHdrNnMzbnlXcUpt?=
 =?utf-8?B?eUNuQUlnMzFZOFAvQ3Q1YTh0c0ZTdTZSc1hvNm1OcFhmTTZ1QjhtZ1RTSUxW?=
 =?utf-8?B?N2tTQTFDOXpOM0JYbUpwSWYzdnBwNWpjZG41UDZnWWtmSGg1Q2NGQzRJN2Jx?=
 =?utf-8?B?dGZKakFzb0lMczl6VHNQaDBiMVVDNkFJTjdjUlRzRTN0VE9Xc3BTb3NrVitO?=
 =?utf-8?B?cDB4YUZOQlgvSWdIRFRiNDRmKzYwOXpvYmpMWkFLVjE4emIreDFDemE2UnZ1?=
 =?utf-8?B?TThEenMxMzJGTzVhbFVVbVlzcWRJNzAwdHI1aEdiRU56Zmgxc1RZS1p0cEpr?=
 =?utf-8?B?K0FSMGY0ZlhaZk9qMzdHeG5xN0lTaWc3SDE1eW9ZeWo5NHVhZHMraWhPL1dB?=
 =?utf-8?B?emVyQ1RPWUFXTEFTSXloK2dYL2pBUC9uWjZKemJWMTJvcDFueHpMcVh2TnVE?=
 =?utf-8?B?d05EMXF1a2FTcDZrTFNEZEdkdmxVZ0FXSkhucWc3RkdSNEhaMEpvVHROT1Ju?=
 =?utf-8?B?cUovRkVTT3U3V0xHNSszS0NFMEF1THVHdHhSdDB4QVUwdTNtRlhRRVFhL0pn?=
 =?utf-8?B?eDMvdkJPNUNNTXdSb1ovYllpK20weE1od1k2RS9Dc3ZzNzl1ekxwbnF2ZUxN?=
 =?utf-8?B?Y01TNzl5S0N6dW45OWFGYXhSaFd2ZHJUYVRoWkNxOHoxWC9xMk1peG8vS3BY?=
 =?utf-8?B?TmovZmM3WXlsQmJLV1I4azB0REZZeVpQaDFORGN0V2ozcEwzWklYbFpub3Vh?=
 =?utf-8?B?YmRuYTNsNlhMbFRVcnZPTHI5ejZhU2ozSTFieTBKSEloV2Q5WFk2OTVwTkFY?=
 =?utf-8?B?R01wMktXdHZYS0dxcklhVHBib2hkWVU3a1F5MjhRYWZOVWtDK0x1SmZ0THJt?=
 =?utf-8?B?dGxtLzJvcEVFQUI5d0MxK0hyNk9ja2ZvTWJmbkVpcmZxOUNGNG50RlAzVWNO?=
 =?utf-8?B?eHZIZ2Zva3hldnVnQlpoZFlLcG5USVFRbnpTd1E4ZkVCdENBUHlGNEFrQ1VL?=
 =?utf-8?B?OU9uSSswZ09mNmlsSWpBT0NzeEEyd2NaOVZlUFFzNTIwWWxhWjRhUFc0bThY?=
 =?utf-8?B?OHB3djhUWGZYQUtibXFkREROdlNCVWRxcG8xUEdkczlWb3hTSVFKNlZBUSt5?=
 =?utf-8?B?MkVydkUvb0dDbnF3MjJ3RDhaeXJGRklBUUlzRU9GUk44aDRGQXUrMW5YdFpM?=
 =?utf-8?B?VDFDa29aa3l1bTJJYTB3bzZOYm04aUdUYUhIcS9keldZS0lZR3RSbWVrVFNH?=
 =?utf-8?B?SFFHU2FCL1NMV3Qzc2xXRzBob3VwaVBWZTFERzE4V2dkVFdINzRrR0l6cGRl?=
 =?utf-8?B?c2RNQVIwQnJ3bGpoSmFSd1V4aCt3Q1lhM3QrS2o3aFRTWHVxeHJTR01acnZh?=
 =?utf-8?B?NzRsUm9NVmF4dWw4WEtJWU9iYzNnYk9NTFFVcTNMRXVKR1RkMzZrUFdFandX?=
 =?utf-8?B?Nm0vbzdtYVlJZUdKQWQ3NlJWb3Y3cnhiK2pOMGo4Y2w2bjNrTHcvYkJyQlJG?=
 =?utf-8?B?a1A0UzlnMjUzbGRTMkx3SnYzMDVhMThZbDhYMnkyR2UvZlYxU1RrSXZmQ21D?=
 =?utf-8?B?VFVsWW5qeWxTUUZuSWR6d1o4UDU5R3YyUWVnRFRobDdTQ2laeHJKdzBSdXpo?=
 =?utf-8?B?OWpPUUVZWFlMUWI2d05LMTk4QXhvWVdZbVYwQUJ6QjVIOFBpd3Z3NlFoUjBv?=
 =?utf-8?B?ZGVyTHVhbG56aXMwcStTc3hZRFI0aFllZzJ5cTlRblJia3ozU1oyOFhRLzhn?=
 =?utf-8?B?R0JWR2poblBGUE9sMGRXd3UvN0Y0V2crc3NyZ1ZEMzVkcDJaYTliZmsxRDdO?=
 =?utf-8?Q?34OUZ3nY8PHo+juhJLWwgUaoE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dea1fe8-16fa-48ba-87ad-08d9d174e596
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 00:30:24.8988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtWhNp17xCisjf2mBwDlCmTUO+kJ/zGz4JEYHTVYaEIzBSGBxz0hiprewWKaK9zp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2298
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: GGhv2ZkAGebl1sIsAr5U31WhT4JZMjXM
X-Proofpoint-ORIG-GUID: GGhv2ZkAGebl1sIsAr5U31WhT4JZMjXM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_10,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1011 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201070001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/6/22 1:50 PM, Hao Luo wrote:
> Bpffs is a pseudo file system that persists bpf objects. Previously
> bpf objects can only be pinned in bpffs, this patchset extends pinning
> to allow bpf objects to be pinned (or exposed) to other file systems.
> 
> In particular, this patchset allows pinning bpf objects in kernfs. This
> creates a new file entry in the kernfs file system and the created file
> is able to reference the bpf object. By doing so, bpf can be used to
> customize the file's operations, such as seq_show.
> 
> As a concrete usecase of this feature, this patchset introduces a
> simple new program type called 'bpf_view', which can be used to format
> a seq file by a kernel object's state. By pinning a bpf_view program
> into a cgroup directory, userspace is able to read the cgroup's state
> from file in a format defined by the bpf program.
> 
> Different from bpffs, kernfs doesn't have a callback when a kernfs node
> is freed, which is problem if we allow the kernfs node to hold an extra
> reference of the bpf object, because there is no chance to dec the
> object's refcnt. Therefore the kernfs node created by pinning doesn't
> hold reference of the bpf object. The lifetime of the kernfs node
> depends on the lifetime of the bpf object. Rather than "pinning in
> kernfs", it is "exposing to kernfs". We require the bpf object to be
> pinned in bpffs first before it can be pinned in kernfs. When the
> object is unpinned from bpffs, their kernfs nodes will be removed
> automatically. This somehow treats a pinned bpf object as a persistent
> "device".

During our initial discussion for bpf_iter, we even proposed to
put cat-able files under /proc/ system. But there are some concerns
that /proc/ system holds stable APIs so people can rely on its format 
etc. Not sure kernfs here has such requirement or not.

I understand directly put files in respective target directories
(e.g., cgroup) helps. But you can also create directory hierarchy
in bpffs. This can make a bunch of cgroup-stat-dumping bpf programs
better organized.

Also regarding new program type bpf_view, I think we can reuse
bpf_iter infrastructure. E.g., we already can customize bpf_iter
for a particular map. We can certainly customize bpf_iter targeting
a particular cgroup.

> 
> We rely on fsnotify to monitor the inode events in bpffs. A new function
> bpf_watch_inode() is introduced. It allows registering a callback
> function at inode destruction. For the kernfs case, a callback that
> removes kernfs node is registered at the destruction of bpffs inodes.
> For other file systems such as sockfs, bpf_watch_inode() can monitor the
> destruction of sockfs inodes and the created file entry can hold the bpf
> object's reference. In this case, it is truly "pinning".
> 
> File operations other than seq_show can also be implemented using bpf.
> For example, bpf may be of help for .poll and .mmap in kernfs.
> 
> Patch organization:
>   - patch 1/8 and 2/8 are preparations. 1/8 implements bpf_watch_inode();
>     2/8 records bpffs inode in bpf object.
>   - patch 3/8 and 4/8 implement generic logic for creating bpf backed
>     kernfs file.
>   - patch 5/8 and 6/8 add a new program type for formatting output.
>   - patch 7/8 implements cgroup seq_show operation using bpf.
>   - patch 8/8 adds selftest.
> 
> Hao Luo (8):
>    bpf: Support pinning in non-bpf file system.
>    bpf: Record back pointer to the inode in bpffs
>    bpf: Expose bpf object in kernfs
>    bpf: Support removing kernfs entries
>    bpf: Introduce a new program type bpf_view.
>    libbpf: Support of bpf_view prog type.
>    bpf: Add seq_show operation for bpf in cgroupfs
>    selftests/bpf: Test exposing bpf objects in kernfs
> 
>   include/linux/bpf.h                           |   9 +-
>   include/uapi/linux/bpf.h                      |   2 +
>   kernel/bpf/Makefile                           |   2 +-
>   kernel/bpf/bpf_view.c                         | 190 ++++++++++++++
>   kernel/bpf/bpf_view.h                         |  25 ++
>   kernel/bpf/inode.c                            | 219 ++++++++++++++--
>   kernel/bpf/inode.h                            |  54 ++++
>   kernel/bpf/kernfs_node.c                      | 165 ++++++++++++
>   kernel/bpf/syscall.c                          |   3 +
>   kernel/bpf/verifier.c                         |   6 +
>   kernel/trace/bpf_trace.c                      |  12 +-
>   tools/include/uapi/linux/bpf.h                |   2 +
>   tools/lib/bpf/libbpf.c                        |  21 ++
>   .../selftests/bpf/prog_tests/pinning_kernfs.c | 245 ++++++++++++++++++
>   .../selftests/bpf/progs/pinning_kernfs.c      |  72 +++++
>   15 files changed, 995 insertions(+), 32 deletions(-)
>   create mode 100644 kernel/bpf/bpf_view.c
>   create mode 100644 kernel/bpf/bpf_view.h
>   create mode 100644 kernel/bpf/inode.h
>   create mode 100644 kernel/bpf/kernfs_node.c
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_kernfs.c
>   create mode 100644 tools/testing/selftests/bpf/progs/pinning_kernfs.c
> 
