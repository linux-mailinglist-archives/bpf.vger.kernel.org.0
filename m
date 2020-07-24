Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE17422BAB8
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 02:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgGXABX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 20:01:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34818 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726626AbgGXABW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jul 2020 20:01:22 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NNsXoR016556;
        Thu, 23 Jul 2020 17:01:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=v0xw69flsfaPKNyedOSS071aUtq8a9qe5DyQPldRpZE=;
 b=fbyrYDXMiea6Jfqqma8Ne8OoDKqKaoNlT3duqZNdBVnFeijk6GUzautbdmWTRuVx+LPC
 9ZAI/XEdj12VwloSltTOH2g+D6A4Bxb6pEHeFXkN0vMWBX0Yh9IzDwmLUkBXkW7I08EF
 pi1w8VTSYJONEeDKg31lFJKAOKq92e1IjaQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32fh7kgx2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jul 2020 17:01:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 17:01:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACIvBY3xu1dpUxrZC607mQtNti1H2L1TUTxwkaFPr1zh3exi93b/jBoVUul/X8UlCzGzXCezEjVTmbjdobchff+YrtEhkAWK5P3gQEj3Ut+3roY5sMpL4xQ+JvhKg0LdBwsn6IIFrFnO1RHVsdz6frOiT/YuyCbBSr6kMD0rh8PkN5PInJ+HVW/pU699ecjSNj+6eQb+RiQvKWp5++oLh7QTHjQ4yowLAz736RPJTSzPhZAK66DDZO4hiRzrY3nwe1TulEww+aKmNTIxd2KCHuPckiZig1qdvGPT1FazjxlDquCX0jF3pX5Ej9z3PZZsRd5AT3kgw0bIMCRRkcfN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0xw69flsfaPKNyedOSS071aUtq8a9qe5DyQPldRpZE=;
 b=BLH61tn9jU6L3O6aVewPYgyuCl81O8IMgo4GHgVdgxxu/sIHMrZYrk4b61YXaecz2G8zwO8jDTOH8ZJoWJG6L/AWZaL9+LQWC/mthki+CzQCx1oadl6LW6TciHR4vBvhmOBwyeOpXk+2p7ZgKFjFHh6vEJWbgwlu7QITWMTVAfLf/nJSoTG9cwklMQWs5sYoD+t1c5LKnUvB/D7S9NwzWY1z1Rht8NAuJUTLv5t0VYFU+0ldsKZUUTvx96Ybkf58NMaOjhju0CVHqk/rhEUDNuLNUiNqTn962nmxcXhYCcenhuWeUccuJVlwjev5LHxpy5eYE21l7Mq4yOpO+neJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0xw69flsfaPKNyedOSS071aUtq8a9qe5DyQPldRpZE=;
 b=Prr1KmcgaVh3GOLkSpKY3ZoOokM/x47FIxwt2xM9SuJeCt2eKaCeg66Qqe9B/pHeoOs3hwZz7M8vCade5DmvBQkgV05uDSV1igFpMgbY9fPDWxTQ0g8ziCLlMJvrL+p4rN90SK4tbZ/doDHj72DaRFoTcUDAZa0CaesPLKFvI5M=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2822.namprd15.prod.outlook.com (2603:10b6:a03:15b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Fri, 24 Jul
 2020 00:00:27 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 00:00:27 +0000
Date:   Thu, 23 Jul 2020 17:00:19 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v5 bpf-next 3/5] bpf: Make cgroup storages shared between
 programs on the same cgroup
Message-ID: <20200724000019.34oaukw6ejw6hk33@kafai-mbp>
References: <cover.1595489786.git.zhuyifei@google.com>
 <38ec2f4f111d65a4a8b70ea0bc50a788c5a813ee.1595489786.git.zhuyifei@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38ec2f4f111d65a4a8b70ea0bc50a788c5a813ee.1595489786.git.zhuyifei@google.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR07CA0085.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::26) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:ea06) by BYAPR07CA0085.namprd07.prod.outlook.com (2603:10b6:a03:12b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 00:00:27 +0000
X-Originating-IP: [2620:10d:c090:400::5:ea06]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56599ee9-363c-4584-a114-08d82f649263
X-MS-TrafficTypeDiagnostic: BYAPR15MB2822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2822339164666F2DE4CA37F5D5770@BYAPR15MB2822.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: snlyjguvUewm7qSA713kM3J4cGJ2Eivwui7PKT/kYaEVkA2mCLHUUTYWI1g43LXovJYz1+5vjGSX/fmlIGnJHdcO1esi6x3O4mkgLoE2IWM6H/ollzmOFYw6XGI0se+CXSxQRtjR7JMV2TL/YdAOMRsSxfb9LBR1DTZ9YH12xA2XK2OrTCUegH24Y988GcOvlN17D1GRu3EnRheY4mSzO/5L67obDUeJwNf11ApvQnpzr2RJogOc5YK+siJBW8VG9OcoInhDueGxU/G3mQOeFIKe5uFWCEeiMnEgkDy4Xuub19E/Q3kKciGfUyirNP4FG6HA4WwYNt4DqVhgJyk4tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(136003)(396003)(366004)(376002)(83380400001)(478600001)(4326008)(8676002)(33716001)(316002)(5660300002)(9686003)(86362001)(66556008)(66476007)(66946007)(8936002)(2906002)(54906003)(6666004)(55016002)(186003)(1076003)(16526019)(6496006)(52116002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: nqi39f0nVXUQSxdo38Fe8d7THGC/mUcaQcCrfraxQn1UtCk1/ssK0+a6UoSfU+wfo4XpqjOn7zdPZBZtXmhxnj+OneCAQ5pHRtHLgVrs4hCLzSCc2ZeOUp6057m5sXeL/1c8k970f9T78k8xXpU/CDAeI/eIZVQwvCCyL3PTtHhsX/MlHvriQ9Px8Gdh1+dSj4jsQdPr6uTgjv3vT9TxyqovfByfaHNlJHc8Ism5EtMkURSmTkJEQIBL0TChvLfcYZgKpgYYfhRZZO+E6OeCB2Y51/2eRtlF6Ond+8nFN30McoPK4lm7lM58M9W43W6d6IcrWLbw1fK1IZY5n2Ckahm30Y++Dc1RkZY/EnTDV1IUzXcr250KbwC118Lcco+oPm5q0S7wVfnsp3Lq7kQFcE3eSbHioXjTujhkqzTA0iyamyLd7KSXKvVy4jmEtdLxtCwZ0CTVnXA0/oTLpSRXRf04bExUhEXdVKBv+tGqhCvTdms3QcCniEEHLE/UFak01TiKBiTS7ZfhjHPp4ZK+cg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 56599ee9-363c-4584-a114-08d82f649263
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 00:00:27.5061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08ygOdxDFZ1G9jsHzqcVJ5m3qeqA9ddz5sPhHLwB4oTK/Cxo5finlGXI+AvDxNTX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2822
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_09:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=2 malwarescore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007230168
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 23, 2020 at 02:40:56AM -0500, YiFei Zhu wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> This change comes in several parts:
> 
> One, the restriction that the CGROUP_STORAGE map can only be used
> by one program is removed. This results in the removal of the field
> 'aux' in struct bpf_cgroup_storage_map, and removal of relevant
> code associated with the field, and removal of now-noop functions
> bpf_free_cgroup_storage and bpf_cgroup_storage_release.
> 
> Second, we permit a key of type u64 as the key to the map.
> Providing such a key type indicates that the map should ignore
> attach type when comparing map keys. However, for simplicity newly
> linked storage will still have the attach type at link time in
> its key struct. cgroup_storage_check_btf is adapted to accept
> u64 as the type of the key.
> 
> Third, because the storages are now shared, the storages cannot
> be unconditionally freed on program detach. There could be two
> ways to solve this issue:
> * A. Reference count the usage of the storages, and free when the
>      last program is detached.
> * B. Free only when the storage is impossible to be referred to
>      again, i.e. when either the cgroup_bpf it is attached to, or
>      the map itself, is freed.
> Option A has the side effect that, when the user detach and
> reattach a program, whether the program gets a fresh storage
> depends on whether there is another program attached using that
> storage. This could trigger races if the user is multi-threaded,
> and since nondeterminism in data races is evil, go with option B.
> 
> The both the map and the cgroup_bpf now tracks their associated
> storages, and the storage unlink and free are removed from
> cgroup_bpf_detach and added to cgroup_bpf_release and
> cgroup_storage_map_free. The latter also new holds the cgroup_mutex
> to prevent any races with the former.
> 
> Fourth, on attach, we reuse the old storage if the key already
> exists in the map, via cgroup_storage_lookup. If the storage
> does not exist yet, we create a new one, and publish it at the
> last step in the attach process. This does not create a race
> condition because for the whole attach the cgroup_mutex is held.
> We keep track of an array of new storages that was allocated
> and if the process fails only the new storages would get freed.
> 
[ ... ]

> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 51bd5a8cb01b..b246ae07f87d 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -9,6 +9,8 @@
>  #include <linux/slab.h>
>  #include <uapi/linux/btf.h>
>  
> +#include "../cgroup/cgroup-internal.h"
> +
>  DEFINE_PER_CPU(struct bpf_cgroup_storage*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
>  
>  #ifdef CONFIG_CGROUP_BPF
> @@ -20,7 +22,6 @@ struct bpf_cgroup_storage_map {
>  	struct bpf_map map;
>  
>  	spinlock_t lock;
> -	struct bpf_prog_aux *aux;
>  	struct rb_root root;
>  	struct list_head list;
>  };
> @@ -30,24 +31,41 @@ static struct bpf_cgroup_storage_map *map_to_storage(struct bpf_map *map)
>  	return container_of(map, struct bpf_cgroup_storage_map, map);
>  }
>  
> -static int bpf_cgroup_storage_key_cmp(
> -	const struct bpf_cgroup_storage_key *key1,
> -	const struct bpf_cgroup_storage_key *key2)
> +static bool attach_type_isolated(const struct bpf_map *map)
>  {
> -	if (key1->cgroup_inode_id < key2->cgroup_inode_id)
> -		return -1;
> -	else if (key1->cgroup_inode_id > key2->cgroup_inode_id)
> -		return 1;
> -	else if (key1->attach_type < key2->attach_type)
> -		return -1;
> -	else if (key1->attach_type > key2->attach_type)
> -		return 1;
> +	return map->key_size == sizeof(struct bpf_cgroup_storage_key);
> +}
> +
> +static int bpf_cgroup_storage_key_cmp(const struct bpf_cgroup_storage_map *map,
> +				      const void *_key1, const void *_key2)
> +{
> +	if (attach_type_isolated(&map->map)) {
> +		const struct bpf_cgroup_storage_key *key1 = _key1;
> +		const struct bpf_cgroup_storage_key *key2 = _key2;
> +
> +		if (key1->cgroup_inode_id < key2->cgroup_inode_id)
> +			return -1;
> +		else if (key1->cgroup_inode_id > key2->cgroup_inode_id)
> +			return 1;
> +		else if (key1->attach_type < key2->attach_type)
> +			return -1;
> +		else if (key1->attach_type > key2->attach_type)
> +			return 1;
> +	} else {
> +		const __u64 *key1 = _key1;
> +		const __u64 *key2 = _key2;
Nit.
Instead of key1 and key2, a meaningful name will be easier
to read and tell what it is comparing about later, like the
key1->"cgroup_inode_id" in the "if" case above.  May be:

		__u64 cgroup_inode_id1 = *(__u64 *)_key1;
		__u64 cgroup_inode_id2 = *(__u64 *)_key2;

> +
> +		if (*key1 < *key2)
> +			return -1;
> +		else if (*key1 > *key2)
> +			return 1;
> +	}
>  	return 0;
>  }
>  
Others LGTM
