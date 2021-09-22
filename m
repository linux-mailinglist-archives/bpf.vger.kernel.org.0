Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF77741508F
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 21:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhIVTkH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 15:40:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1222 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230030AbhIVTkH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Sep 2021 15:40:07 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MIlQ4o003489;
        Wed, 22 Sep 2021 12:38:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=XKTGGjFh5F+14Ey+YPUq5ob2G3I8g5LjqqQ81uttNJo=;
 b=X3GPZWpO/fqAZlHrtqFVKCrtZziBqvIzjaAgViURQmwZ5mhtpRpX3QxdLL9iT5xZriR5
 c7NutM4KELkyFazpzAK6uJGnzK5Lug6Sb61UhzVHa2bnXL7J9tTz5pC/IM7DE9YDaIL+
 PyOES1lhJjPFZ+FKffAPH3nXQKM4RSoMMLo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q5bqnxu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Sep 2021 12:38:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 22 Sep 2021 12:38:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvFZteViLquXhG/cD8gREXWriEriRwK8Z080XgtTpfh1hNYcXtYF8MJpey3/Wle7lVHGD61NRobbjfTlvSjcJddGtD5tax1fGiFmc4xb+77/DALfzMpEkMp2kQfwqA2wMteccrQfmwhWvcB8i6s3cwvo/xn46IYMLLcUtEK/5l2F/RVtxknrbiDp+UE4Z8sgPkGXYC71+1Rz5QRpfdwTBFRE/iBYuDKDdPzjR2IrDQYrXsrMXuC1isUWJm8wI1rt1knRCL8A/ksYlvDFGjkRQsm8k4MY4544nacWcypQpMrICRM9wOtqiCnXSRB3j1k5xR4ACxoyEy96ZyMp3tI/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XKTGGjFh5F+14Ey+YPUq5ob2G3I8g5LjqqQ81uttNJo=;
 b=F12CMv/6SGtoYnrYM5a6mt0av0qi+KYSWZQvtcpa0uZPI4peDek3KD0h3YJ6ogT1KsnGMBM/IIjKIWU8DvmluPRlpnl35cOOFX9Idf6Ba/nhhzyDuEuxDhCmfwO38x8xWgqm8PktZ2BjP0Mmp/eo4CagZLosVeLD9dTDLTIqIyMjzGPxsWP9fSiGN9dQGOYeohBjTKmhYU1D4zCOk+qrybzdFCUkF9XoLH4yBKA26kgqkTeUGcXOmi04ZWbNb7Qf8ypGANXa6fBZhHB1RjraRHSt38M6+5/ePeb1mL7eAJFNlC/Q126mKcEqDpUy4AVz8oSPcK5o01Xs/ao0+WVmOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA0PR15MB3869.namprd15.prod.outlook.com (2603:10b6:806:8c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 19:38:33 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 19:38:33 +0000
Date:   Wed, 22 Sep 2021 12:38:27 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannekoong@fb.com>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
Message-ID: <20210922193827.ypqlt3ube4cbbp5a@kafai-mbp.dhcp.thefacebook.com>
References: <20210921210225.4095056-1-joannekoong@fb.com>
 <20210921210225.4095056-2-joannekoong@fb.com>
 <CAEf4BzZfeGGv+gBbfBJq5W8eQESgdqeNaByk-agOgMaB8BjQhA@mail.gmail.com>
 <517a137d-66aa-8aa8-a064-fad8ae0c7fa8@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <517a137d-66aa-8aa8-a064-fad8ae0c7fa8@fb.com>
X-ClientProxiedBy: MN2PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:208:23d::21) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c091:480::1:1a34) by MN2PR06CA0016.namprd06.prod.outlook.com (2603:10b6:208:23d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Wed, 22 Sep 2021 19:38:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0526747a-e3ce-4fea-4db8-08d97e008fb3
X-MS-TrafficTypeDiagnostic: SA0PR15MB3869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB38695803040601DEE5D3D079D5A29@SA0PR15MB3869.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6um1OPgHDV8hHv/4QAdqWdSs8k/EV4lmG2Re+b+fGlUjqiop8QsjDkn8YKWvPcMZixOocurDTcR5ePKveQlACyRBu+nqGZF6T+zjOne/g4Sc7jAZ/ylez1+JJ6Xk7NXJOa4wuhbEOocJtBnqXnx4mXSnBS4FvLnBn1OgGIz1LzwYm1yfdvTVsBnsO+MEhg6X4NP5lPPWovuGTppC09Lh5sZvlnN4HDeJGbwF9eTgtQccBDkrDB44JVi3ryy+Msq6GkzL/r5s2TEybCSROW8sP80OGnBC9cOIpjpbd0rmHxQO+vuNVxxyQSEK2yC5ahkaK3tbmbIr16mTlQ95UmVzIUeH1RWB8FF5eQ++A/19gf7PTUpayOPTICKAvaRoN/Pt9E1lt5FgVHe96W4CQu1k/D3vvLD/K8F1ov0uQZc5ZEq0hOk5bXMAIZytygTJJu7dHuku74uCgQIv8rMj7AL81LbN6oaL1EmaQB02U7vn68elmOnAhAiOxaFyK72I2kQuYTnarAHHj1arilIsVgt0FSdMc6qwMJ3eRRcNVjePHNAxISIJSsK3iMCF0psW0qlJkZCn9DIOcsS1Va70GL0xbfRprOs0bacFJ3lVxpqYZs9oYqUABmEK+JeglNOzALgqkcgFkD+f6YdxD9kb7kIuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(6636002)(66556008)(86362001)(83380400001)(66946007)(54906003)(66476007)(508600001)(8936002)(1076003)(38100700002)(2906002)(5660300002)(6506007)(53546011)(6666004)(8676002)(186003)(9686003)(55016002)(6862004)(4326008)(7696005)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wUnGFWHi9ZgsRyQ04BJtlvcmbFV+pqz9wKm8hQ/TBme3W3MgtVVuijrFkVC/?=
 =?us-ascii?Q?fXG1FpeiBm6gLLJ3bOg2vCjq0ZTzniwO6XscbN9jiB4UfQB9TZQSiCpEUqfF?=
 =?us-ascii?Q?jbdw/cA35TSERESMU9UrEDv/OKlxnga8aXrWVpXqxxn8hjgbDN6YRvrG0f4d?=
 =?us-ascii?Q?zkvm+ARSextIVNCL/+wE/9Ep2q8OGzOGi8UsEkr8kekQjMJTVL/6I8L2hgEU?=
 =?us-ascii?Q?9LhkVaOvZ3vpL/J4Ah74bB79NbzA3oGWiEc6OloFk8R1I0schqt+0DFc/0A+?=
 =?us-ascii?Q?kPNYe/XRHWXfkk/w7ZbdVtBB9ZP7JUzGNd+1YoQ12wKQSHwymuvAzm5npE1x?=
 =?us-ascii?Q?W1nyx+o6J9lZfLyemc6btZCNSkPe2D9B3TPhGIFjRELJo/iYqPBeLepnRct7?=
 =?us-ascii?Q?I7hLCkVCv3s4DM6JqV2ay21HxQ2DB65aMlRwnSpadJMV13lEwoWfxVwYOVCu?=
 =?us-ascii?Q?WgZ5SA6Rvyxvo1zstFkMZ9ghf8FBnDug9T3V3E3ZTTYfwfn6lFsB+eMInEDB?=
 =?us-ascii?Q?uJyRfBbgzWpg+5MQfDru74ydTMTsgRlmY/k/Nc5othDYAiuqWsr766cO+QVc?=
 =?us-ascii?Q?Ls5nBlhY0GrksrPwqxeSiXSelLnezZ57D711VwlRZVyhD98CbiEILl8vmVO/?=
 =?us-ascii?Q?ksqktil4hjbjKSSbBKG4n591yxS+4q8Xyu/Ep599/5lwGR61nAx5r/lGeeLu?=
 =?us-ascii?Q?6BQETGrUbIu6umqSz/IiP+QzklxLHpPxIVlIUA7LjNeMFfcO3Tw1sONZSm2P?=
 =?us-ascii?Q?7AFMXUH/ZeNCB8BVyAzpgeg/gk97ZaO1fyzvd72G/4SrsVPbi12RRlETEFO3?=
 =?us-ascii?Q?DGnmPzl72kv9Ve5l/Jkljjgjw4u6Ppib7mTgzYQkoJc+reEzhc6j+itDuOEc?=
 =?us-ascii?Q?uRfnBzc93k1y3jvADiSDuAio/4NOpXqtrEBkY3wqaV2mO4A/oYdtQIoYE5Cm?=
 =?us-ascii?Q?3xkjNKP3HC6Jy8M+FukTWQoevRRvzXKYJhuntTYYNakLW61Fb3yONOR2M74+?=
 =?us-ascii?Q?Mmh8DkoY6uRoLV9SfJ9EzDEC0tqMod9M4Hqs+hKHSduZHmQP2wazVO3k7fb1?=
 =?us-ascii?Q?W/qYpolJSUfQxiXHV8yrq0/JwGqxUH4k/uR55k4PwIMu03/RAflsv/fjMt+u?=
 =?us-ascii?Q?0zWV81KHjj1y8vwgBA7qUl1qhzAopkg9ULotCFfh9nCOt1PsEqoFKA9MBNsh?=
 =?us-ascii?Q?Gf1xNjrpIuXQ/oS4rnyjZbZtwhpXM5MnmX4UovJWjJZz+382dSNy2SBpW+Vu?=
 =?us-ascii?Q?XoYb0BbsUjzJKhEdk/ivTYhWfoMtKQtIMRJ0P1iogQgw0stgdV2eIOrPHwaw?=
 =?us-ascii?Q?m77fSMRuviNQm8FdHbPD8cMUuAAnHFMjPxzaHMGAtByqUw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0526747a-e3ce-4fea-4db8-08d97e008fb3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 19:38:32.9152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hodL537JPhvYhyvGSOd2KvNGGwCoRvj7q19WB6Uex2suZAJBUH7DLiX/LrXQfcLT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3869
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Z4B2EO4VpEr2AplPnCvoTxcLPEnzl5Zw
X-Proofpoint-GUID: Z4B2EO4VpEr2AplPnCvoTxcLPEnzl5Zw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_07,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 22, 2021 at 12:06:02PM -0700, Joanne Koong wrote:
> 
> On 9/21/21 4:44 PM, Andrii Nakryiko wrote:
> > On Tue, Sep 21, 2021 at 2:30 PM Joanne Koong <joannekoong@fb.com> wrote:
> > > Bloom filters are a space-efficient probabilistic data structure
> > > used to quickly test whether an element exists in a set.
> > > In a bloom filter, false positives are possible whereas false
> > > negatives should never be.
> > > 
> > > This patch adds a bloom filter map for bpf programs.
> > > The bloom filter map supports peek (determining whether an element
> > > is present in the map) and push (adding an element to the map)
> > > operations.These operations are exposed to userspace applications
> > > through the already existing syscalls in the following way:
> > > 
> > > BPF_MAP_LOOKUP_ELEM -> peek
> > > BPF_MAP_UPDATE_ELEM -> push
> > > 
> > > The bloom filter map does not have keys, only values. In light of
> > > this, the bloom filter map's API matches that of queue stack maps:
> > > user applications use BPF_MAP_LOOKUP_ELEM/BPF_MAP_UPDATE_ELEM
> > > which correspond internally to bpf_map_peek_elem/bpf_map_push_elem,
> > > and bpf programs must use the bpf_map_peek_elem and bpf_map_push_elem
> > > APIs to query or add an element to the bloom filter map. When the
> > > bloom filter map is created, it must be created with a key_size of 0.
> > > 
> > > For updates, the user will pass in the element to add to the map
> > > as the value, with a NULL key. For lookups, the user will pass in the
> > > element to query in the map as the value. In the verifier layer, this
> > > requires us to modify the argument type of a bloom filter's
> > > BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE; as well, in
> > > the syscall layer, we need to copy over the user value so that in
> > > bpf_map_peek_elem, we know which specific value to query.
> > > 
> > > A few things to please take note of:
> > >   * If there are any concurrent lookups + updates, the user is
> > > responsible for synchronizing this to ensure no false negative lookups
> > > occur.
> > >   * The number of hashes to use for the bloom filter is configurable from
> > > userspace. If no number is specified, the default used will be 5 hash
> > > functions. The benchmarks later in this patchset can help compare the
> > > performance of using different number of hashes on different entry
> > > sizes. In general, using more hashes decreases the speed of a lookup,
> > > but increases the false positive rate of an element being detected in the
> > > bloom filter.
> > >   * Deleting an element in the bloom filter map is not supported.
> > >   * The bloom filter map may be used as an inner map.
> > >   * The "max_entries" size that is specified at map creation time is used to
> > > approximate a reasonable bitmap size for the bloom filter, and is not
> > > otherwise strictly enforced. If the user wishes to insert more entries into
> > > the bloom filter than "max_entries", they may do so but they should be
> > > aware that this may lead to a higher false positive rate.
> > > 
> > > Signed-off-by: Joanne Koong <joannekoong@fb.com>
> > > ---
> > >   include/linux/bpf_types.h      |   1 +
> > >   include/uapi/linux/bpf.h       |   1 +
> > >   kernel/bpf/Makefile            |   2 +-
> > >   kernel/bpf/bloom_filter.c      | 185 +++++++++++++++++++++++++++++++++
> > >   kernel/bpf/syscall.c           |  14 ++-
> > >   kernel/bpf/verifier.c          |  19 +++-
> > >   tools/include/uapi/linux/bpf.h |   1 +
> > >   7 files changed, 217 insertions(+), 6 deletions(-)
> > >   create mode 100644 kernel/bpf/bloom_filter.c
> > > 
> > See some stylistic nitpicking below (and not a nitpicking about BTF).
> > 
> > But I just wanted to say that I'm a bit amazed by how much special
> > casing this BLOOM_FILTER map requires in syscall.c and verifier.c. I
> > still believe that starting with a BPF helper for hashing would be a
> > better approach, but oh well.
> > 
> > [...]
> I liked your comment on v1 regarding using a BPF helper and I agree with the
> benefits you outlined. I'm curious to see what the performance differences between
> that approach and this one end up being, if any. I plan to test out the BPF helper
> approach in a few weeks, and if the performance is comparable or better, I am definitely open to
> reverting this code and just going with the BPF helper approach :)
Reverting won't be an option and I don't think it is necessary.

Agree that a generic hash helper is in general useful.  It may be
useful in hashing the skb also.  The bpf prog only implementation could
have more flexibility in configuring roundup to pow2 or not, how to hash,
how many hashes, nr of bits ...etc.  In the mean time, the bpf prog and
user space need to co-ordinate more and worry about more things,
e.g. how to reuse a bloom filter with different nr_hashes,
nr_bits, handle synchronization...etc.

It is useful to have a default implementation in the kernel
for some useful maps like this one that works for most
common cases and the bpf user can just use it as get-and-go
like all other common bpf maps do.

imo, the verifier/syscall change here is quite minimal also and it
is mostly riding on top of the existing BPF_MAP_TYPE_STACK.
