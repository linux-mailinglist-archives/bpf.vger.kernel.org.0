Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456ED22BABA
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 02:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgGXADU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 20:03:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61312 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727901AbgGXADT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jul 2020 20:03:19 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 06O030N5030585;
        Thu, 23 Jul 2020 17:03:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ryndwn7OjECKjoQhrWRSNfCDf38h2LStz1co8gpNfJY=;
 b=YC4nJ2ao5qgz29NbpHwi/vpLi5bMYT3uv2ntTxvuRZjz1Cy2Ue0vyYRntXJs7gefEAVq
 AfloRTxuKfiNxY66R+bHvcVOFbsyQnIAlu1mH6v1Y1UOrceWqfLU1VERd3PMVB2LIMeE
 BfJhJFZ9lclnlqAD5aqMMmDOkZypySpbfvk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 32er2ffsg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jul 2020 17:03:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 17:03:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6TQaKMXH/r2/bkX889pTlJm9IbZfcBsd4X1JTdB3FphPn6cH9V1lC99qQ7Fxv4/r04NZU6ct2/7LSVOgGfy5ajOpbRjUrguOlc11Wk8Cmqsor7ra0rl2uoo/ov/urBhB0kvXigqN6/+Cbno/DqZS8fi9hUK7FCWMCPw0TpJbaUMNEb9KgXkto2KoodGldTszGMhtNVad5ihj+GCuRbXYHWPlxWom8wkzHkYnhBWHtTUH9BxoX90+n3at+ILK1nxNw3/X9LUnLwdd+O0fSwkNYVtwU9svVPJsDxPfYTjLB+8668ObIY9cF4IeQw1HUkFb2E32d2aOJD45DFvklCVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryndwn7OjECKjoQhrWRSNfCDf38h2LStz1co8gpNfJY=;
 b=PKw2OtFG3rgdLtbG3k8gEXisfHFydSCVS195ebZQiPzrwXPdebJshixWpQezATBfZYUXB722WNdD/JuYymm79pNmzQNmqkdzbk0qgFXeIkJ3gcKdg8UU1zn4qeVHevt1hkev1wI++nzCjg3ubIsS302/40N7bc5eGUulsZJYSdX+L4Z7qLdj72p50PvKDlTdtnko8eAJkrHRIWmUjxxzkEQTFjQlT4IHVStKeqzVTyFz+RkK8pdqNwi4/n2hrZGHbw/t/AHTyAPtU90tmfnw7lk6SEsqYMX0gN2cetpDqViO6fXhEa3JgHDVZdF8el06byNXlxMebyAsB9ViHsYxaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryndwn7OjECKjoQhrWRSNfCDf38h2LStz1co8gpNfJY=;
 b=V+jAIrGdRN/0gO0X7VlUq2brEE4kntus69+5TahdytcsetzOq1LJZNrW0Fg35subu+FoVs5KST6/zjTzG8cMxCXOgvwup46FWRXmGflG9La01FLlACBT4Y/z9YrHitD1Y/3hGHQCjC+0r+7gIs2pTkvyYFVzifnUyzK0FcuhFXs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2822.namprd15.prod.outlook.com (2603:10b6:a03:15b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Fri, 24 Jul
 2020 00:02:59 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 00:02:59 +0000
Date:   Thu, 23 Jul 2020 17:02:57 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v5 bpf-next 5/5] Documentation/bpf: Document
 CGROUP_STORAGE map type
Message-ID: <20200724000257.qgbttkwwutuakdsi@kafai-mbp>
References: <cover.1595489786.git.zhuyifei@google.com>
 <2ac90af2504384ff33ab8184c288f236378173fb.1595489786.git.zhuyifei@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ac90af2504384ff33ab8184c288f236378173fb.1595489786.git.zhuyifei@google.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:a03:40::47) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:ea06) by BYAPR04CA0034.namprd04.prod.outlook.com (2603:10b6:a03:40::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 00:02:58 +0000
X-Originating-IP: [2620:10d:c090:400::5:ea06]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7810022d-8e3f-47dc-8c00-08d82f64ecd9
X-MS-TrafficTypeDiagnostic: BYAPR15MB2822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB28224EC4ADD3FF9621B6BE2AD5770@BYAPR15MB2822.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHtiiT+TraE6TcMmTDhogcq6410TNqE2TKy9U0w7718zk0qEyO4W9dNbtjC3zUdKr10SF396SQn37kNUXZO+tuM8v4Pi0BC4dlgdxq55XkkAVh3dKxzgGFaj+YiirZ1ZnLyWfQHQPSMiCRnNgRuBVedxWyWastHr7pFERlZR2KzKmoKlOv03r2PzmjJiFKGO9pBvd8haN6wHRYRnbf+QGxnQspMzfDrI/+fIHHrADMSz09vs7UDspC+Oo7+C7S7JzJ6+waxBj6HZsILCeU48vXmKtNQNdSIa3ReYZBxx6vTFcr7QApkU6QCFPnhl0aHx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(136003)(396003)(366004)(376002)(83380400001)(478600001)(4326008)(8676002)(33716001)(316002)(5660300002)(9686003)(86362001)(66556008)(66476007)(66946007)(8936002)(2906002)(54906003)(55016002)(186003)(1076003)(16526019)(6496006)(3716004)(52116002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: nBhtGZhqow2tqkuEgqiDPSkMUhn35sjK/+IZsT2L5ZjHlSPX4tajC+vP2I0V8RhO6RJaXj8fmmXPCV/CPFyUrUAIfUQvXWjzNPSBzFbddbO4DIpWn4OiIB7gSl6wXQm3JqXtk1x72XKIWiMPOypRi9mzPLoz60WfX1YIruXgHBONM4ZyynKkFVpy3OO+Tf+9uy9VMVsIlX3yFFohuzs3fnhGqzh2prrEPCDH08U1dXtcOiEPZg+9Setxt2mF8Qwdg881zIakqSK2MOHHXwfJ705XbcJyt44LYBidnkI/wD3zxXElXdksMLeye4CR+Xza47tJZ1ee/INf8O3+Xb1wHTQNsYNm8Ms2Nw5i1oWcF7lajgMpSxaS4ip0zY8Mu+ggdCRwxDSjejTa9cEG03Bo9b9+8XszwEfKrZZu+M14Hj71aT3gzR7NYp3drCiAT2xdwYiyQYr2NPMaUL7zzsXSZlJWlkTUZubFOwSrfditTXEnZgCaSB66dzyjP/jpjBRqyb8/LWttV4leAfLO1eM/rQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7810022d-8e3f-47dc-8c00-08d82f64ecd9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 00:02:59.2488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ueb/lFhPUWi6jZMq0bVJsqoSCg8ZBnpbDiCMRP6t5l4KDXulpCxKiOhoGtfZIKVY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2822
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_09:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230169
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 23, 2020 at 02:40:58AM -0500, YiFei Zhu wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> The machanics and usage are not very straightforward. Given the
> changes it's better to document how it works and how to use it,
> rather than having to rely on the examples and implementation to
> infer what is going on.
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
>  Documentation/bpf/index.rst              |  9 +++
>  Documentation/bpf/map_cgroup_storage.rst | 97 ++++++++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/bpf/map_cgroup_storage.rst
> 
> diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
> index 38b4db8be7a2..26f4bb3107fc 100644
> --- a/Documentation/bpf/index.rst
> +++ b/Documentation/bpf/index.rst
> @@ -48,6 +48,15 @@ Program types
>     bpf_lsm
>  
>  
> +Map types
> +=========
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   map_cgroup_storage
> +
> +
>  Testing and debugging BPF
>  =========================
>  
> diff --git a/Documentation/bpf/map_cgroup_storage.rst b/Documentation/bpf/map_cgroup_storage.rst
> new file mode 100644
> index 000000000000..ed6256974508
> --- /dev/null
> +++ b/Documentation/bpf/map_cgroup_storage.rst
> @@ -0,0 +1,97 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2020 Google LLC.
> +
> +===========================
> +BPF_MAP_TYPE_CGROUP_STORAGE
> +===========================
> +
> +The ``BPF_MAP_TYPE_CGROUP_STORAGE`` map type represents a local fix-sized
> +storage. It is only available with ``CONFIG_CGROUP_BPF``, and to programs that
> +attach to cgroups; the programs are made available by the same config. The
s/config/Kconfig/ could be more obvious.

It should describe what problem this map is solving and why/when it should be used
instead of other general purpose map.

Something like,
provide a local storage at the cgroup that the bpf prog is attached to.
It provides a faster access than the general purpose htab which requires a
hashtable lookup.

> +storage is identified by the cgroup the program is attached to.
> +
> +This document describes the usage and semantics of the
> +``BPF_MAP_TYPE_CGROUP_STORAGE`` map type. Some of its behaviors was changed in
> +Linux 5.9 and this document will describe the differences.
> +
> +Usage
> +=====
> +
> +The map uses key of type of either ``__u64`` or
``__u64 cgroup_inode_id``

> +``struct bpf_cgroup_storage_key``, declared in ``linux/bpf.h``::
> +
> +    struct bpf_cgroup_storage_key {
> +            __u64 cgroup_inode_id;
> +            __u32 attach_type;
> +    };
> +
> +``cgroup_inode_id`` is the inode id of the cgroup directory.
> +``attach_type`` is the the program's attach type.
> +
> +Since Linux 5.9, if the type is ``__u64``, then all attach types of the
I think it needs to be more specific that ``__u64 cgroup_inode_id``
is supported since 5.9.

> +particular cgroup and map will share the same storage. If the type is
> +``struct bpf_cgroup_storage_key``, then programs of different attach types
> +be isolated and see different storages.
> +
> +To access the storage in a program, use ``bpf_get_local_storage``::
> +
> +    void *bpf_get_local_storage(void *map, u64 flags)
> +
> +``flags`` is reserved for future use and must be 0.
> +
> +There is no implicit synchronization. Storages of ``BPF_MAP_TYPE_CGROUP_STORAGE``
> +can be accessed by multiple programs across different CPUs, and user should
> +take care of synchronization by themselves.
It sounds like the bpf prog author is on its own.
The bpf infra provides "struct bpf_spin_lock" to synchronize the storage.
e.g. tools/testing/selftests/bpf/progs/test_spin_lock.c

> +
> +Example usage::
> +
> +    #include <linux/bpf.h>
> +
> +    struct {
> +            __uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
> +            __type(key, struct bpf_cgroup_storage_key);
> +            __type(value, __u32);
> +    } cgroup_storage SEC(".maps");
> +
> +    int program(struct __sk_buff *skb)
> +    {
> +            __u32 *ptr = bpf_get_local_storage(&cgroup_storage, 0);
> +            __sync_fetch_and_add(ptr, 1);
> +
> +            return 0;
> +    }
> +
> +Semantics
> +=========
> +
> +``BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE`` is a variant of this map type. This
> +per-CPU variant will have different memory regions for each CPU for each
> +storage. The non-per-CPU will have the same memory region for each storage.
> +
> +Prior to Linux 5.9, the lifetime of a storage is precisely per-attachment, and
> +for a single ``CGROUP_STORAGE`` map, there can be at most one program loaded
> +that uses the map. A program may be attached to multiple cgroups or have
> +multiple attach types, and each attach creates a fresh zeroed storage. The
> +storage is freed upon detach.
> +
> +Since Linux 5.9, storage can be shared by multiple programs. When a program is
> +attached to a cgroup, the kernel would create a new storage only if the map
> +does not already contain an entry for the cgroup and attach type pair, or else
> +the old storage is reused for the new attachment. If the map is attach type
> +shared, then attach type is simply ignored during comparison. Storage is freed
> +only when either the map or the cgroup attached to is being freed. Detaching
> +will not directly free the storage, but it may cause the reference to the map
> +to reach zero and indirectly freeing all storage in the map.
A few more things should be mentioned

<5.9:
- There is a one-to-one association between the map and bpf-prog during
  load/verification time.
  Thus, each map can only be used by one bpf-prog and
  each bpf-prog can only use one storage map.
- Because of a map can only be used by one bpf-prog,
  sharing of this cgroup's storage with different bpf-progs
  were impossible.

>= 5.9:
- The map is not associated with any bpf-prog, that makes sharing
  possible.
- However, the bpf-prog can still only associate with one
  map.  Thus, a bpf-prog cannot use more than one
  BPF_MAP_TYPE_CGROUP_STORAGE (i.e. each
  bpf-prog can only use one cgroup's storage).

> +
> +In all versions, userspace may use the the attach parameters of cgroup and
> +attach type pair in ``struct bpf_cgroup_storage_key`` as the key to the BPF map
> +APIs to read or update the storage for a given attachment. For Linux 5.9
> +attach type shared storages, only the first value in the struct, cgroup inode
> +id, is used during comparison, so userspace may just specify a ``__u64``
> +directly.
A sample map definition will be useful in the "Usage" section above.

> +
> +The storage is bound at attach time. Even if the program is attached to parent
> +and triggers in child, the storage still belongs to the parent.
> +
> +Userspace cannot create a new entry in the map or delete an existing entry.
> +Program test runs always use a temporary storage.
> -- 
> 2.27.0
> 
