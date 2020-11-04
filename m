Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A266E2A704A
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 23:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbgKDWRf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 17:17:35 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58366 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730724AbgKDWQS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 17:16:18 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A4MFwm1005890;
        Wed, 4 Nov 2020 14:16:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=CjRuBlU2QowrJA1+D9q9Bybb6iRBfVNSHW+OtLmxMyY=;
 b=AUI0+tgbPbIc1u9IWztwp6byQtQMsmu/x2sT241lQ77ODPoJvqRbMrWpF1gWCv57aO97
 OxbMVFFhw3ZcdvH9JT3JMgSwbuQZHjhKv1ijXdInr4a4pn6GdLdd4rYYYQqQDO/my5Go
 dIp7RU2DB9GsNHktxIUSoAel2YP+0cRwW+c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34kf5c6ctt-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 Nov 2020 14:16:00 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 4 Nov 2020 14:15:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B60/kzKukYLNTT3O84Y2fQ7jljUmigz+Zg6OTSITDCj1hwjS0dMdYS2GPjx20jS7Y9beE45mfIo4FcJZIaNupQRxKtc0++rZR8K4+O8HxFSrRAyKZ2U6zICpDHEtmVTDxHr5NI1p7+i0bvvUT5ZoNMsBNNTg1EYDVqjZTMGriuqW7jEB6uxH7jClHadgCRSU3ZC8VUiVQBTnvBHGz7qasjH34R/5rSw9aXHH1ZTYA0pt7oSUW1ScmlH+l5wqb0sFXtiYaFPrze+Duihg1zfuPOkaFZ7vx5m+Bc4wSVlod91VFqePyjtyhSf71jdPdkEOjLiWwVHhXfalVohr6MG01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjRuBlU2QowrJA1+D9q9Bybb6iRBfVNSHW+OtLmxMyY=;
 b=BYZQv142+63QkPjCnfbxXKDiKWZR6SvjcLsM+xizG61wWt8XOU79bFj6PfDB8ssTQWnxTTp+t1aMvbxKrYsL0Hbnp1pM1oMIu3LzKJdQAqLB6Dhg3IiGtYWIY0aQGrLC7iAgwfUNeK3RMQlqNiNxc8/6JYnqCYr0QFaKqtuztAEcmebzMx5+ji3X5sU+zFRnWr+CWcuZNBeLX9MTAoPRoe9XZEuhbxEApgj7v0zW4KC6rNfr4s0mmP7tXVekElMriWxAytPvdgQET9Xhc5M0CZwg82M6RhpDDSmMCR4N381btilMvUF5sg6eCwwZvsq7Rdhi3mgKWqRA6nCG5isvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjRuBlU2QowrJA1+D9q9Bybb6iRBfVNSHW+OtLmxMyY=;
 b=BH1bZFPs7EvliHlx6+VrOvcqH0k64TndxB/o3dPwGQ65IHdihWy+fmVR8mH4uEqoijkfv0wVpd7EhGYRIRVFcBuoRUsNGU6/bN6d2Sg07tS2xCMNlIXdcmwRkQlMqduwNcF8UtuxlEeE8yKYJJilu8K4YkNPsZ39UUFFZKo7K/c=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by SJ0PR15MB4235.namprd15.prod.outlook.com (2603:10b6:a03:2e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 4 Nov
 2020 22:15:41 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee%4]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 22:15:41 +0000
Date:   Wed, 4 Nov 2020 14:15:35 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Implement task local storage
Message-ID: <20201104221526.dv6qfpfp5lk2t7zw@kafai-mbp.dhcp.thefacebook.com>
References: <20201104164453.74390-1-kpsingh@chromium.org>
 <20201104164453.74390-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104164453.74390-2-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:3041]
X-ClientProxiedBy: CO1PR15CA0059.namprd15.prod.outlook.com
 (2603:10b6:101:1f::27) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:3041) by CO1PR15CA0059.namprd15.prod.outlook.com (2603:10b6:101:1f::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 22:15:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c720cff-464c-4b54-634f-08d8810f2a7d
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR15MB42358DB17499D7707A2CFADDD5EF0@SJ0PR15MB4235.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RspPk5v+L4+ISWS79A55JWnF4ylhrlL45hoPN9am/c/L3CLlhS5u6hYFYBC7jSZy32TBJeSFYut3xG4KCHcj47dSOxjthq1Zpvv5U5xbvRhLthzS5Fle0/7HpUnD3ue5mw9POB2cQ0Uyxq+Dp2Gx5FWbGeqzlDmvMBO0dDydK0bWLCJdCtFCUarx5TdJQ+UvN8uMa5DQgANoE2H3Wt0GHzKX+2tiWYyZsWx405B8543edatOPNM6unAjXHEfNCDXeJQacbr294BGwiq6qSnKQF9n++FXEkjyFF1d2LttpCD9qnjeQdIVP6DMkVOb6VNt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(376002)(136003)(366004)(9686003)(6666004)(8936002)(8676002)(6916009)(6506007)(4326008)(186003)(55016002)(86362001)(16526019)(66946007)(478600001)(5660300002)(2906002)(7696005)(66476007)(83380400001)(66556008)(1076003)(54906003)(316002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: uc23kOzYIYedgYkITDHbyFw52CYJocgPdyNQA4oOjuKqF9UaV3+S0/ebHwE1+LpVYv33OGup/eb8S4pfmOSnEx4c/2fOOKcUaWzV5mX1t5C47teR0RqmIn+k/RAod0PFORmfURVx9qC11sM16QOsXKAbX0QlymYsTOfGLHLiWcBX8INjKFFS/dWLoGgxyLgZ9LYrLxt/fJW94LCS59agEUMd4hh+tOL9nRGtSnQQ7VFj2ncCO4DOuljxPmQiTEJEhrTdfgIgGJQPBd94O2T/Ytgk8lN0UmFENL/iRloGUOP5i0Ddu6xvslEY3ewe47JXaQPlWmZQikoDbDQPFzPJ+jFJcCpEdYhwQ509gt8Haa+VLWNcDt/2uaPa30uaz7TP5+qxjgn6rfolY+UVciwClGV4nG6hnvnVkG32whJH4mFRupZ3IcWWSXbXj9pxIdpTSAZem5VSOwJuY+VaKnqtB3p/bJssxjjRxGTlm0wee/zC51JLwIubYmTd5I88z5VcH7IlZcfgGgbR5sGfU2eUUDB/40bnldX2c1gmG1AfNtsevi0uctlZaTaQLFoHPdVYrvfs6oEB+2C/95c3hhxsa3a6BT8K8eRuUqfv8RIjKEwzxu7nhw4C/f36ZaZAZvf4xrNiumjec7b5Caaw/rHRvx//xIFFeNWoqpHM0/aVYZiaK3SgAde8Zkj9MJ48m+yR
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c720cff-464c-4b54-634f-08d8810f2a7d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 22:15:41.2826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pp5V/rFICkyzpn1iSUEfnAGIuZTEYF6XE2KY/yDENFqh68cZO3qkN8+G6aq4TKrA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4235
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_15:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=634
 suspectscore=1 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040158
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 04, 2020 at 05:44:45PM +0100, KP Singh wrote:
[ ... ]

> +static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
> +{
> +	struct bpf_local_storage_data *sdata;
> +	struct task_struct *task;
> +	unsigned int f_flags;
> +	struct pid *pid;
> +	int fd, err;
> +
> +	fd = *(int *)key;
> +	pid = pidfd_get_pid(fd, &f_flags);
> +	if (IS_ERR(pid))
> +		return ERR_CAST(pid);
> +
> +	/* We should be in an RCU read side critical section, it should be safe
> +	 * to call pid_task.
> +	 */
> +	WARN_ON_ONCE(!rcu_read_lock_held());
> +	task = pid_task(pid, PIDTYPE_PID);
> +	if (!task) {
> +		err = -ENOENT;
> +		goto out;
> +	}
> +
> +	sdata = task_storage_lookup(task, map, true);
> +	put_pid(pid);
> +	return sdata ? sdata->data : NULL;
> +out:
> +	put_pid(pid);
> +	return ERR_PTR(err);
> +}
> +
> +static int bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
> +					    void *value, u64 map_flags)
> +{
> +	struct bpf_local_storage_data *sdata;
> +	struct task_struct *task;
> +	unsigned int f_flags;
> +	struct pid *pid;
> +	int fd, err;
> +
> +	fd = *(int *)key;
> +	pid = pidfd_get_pid(fd, &f_flags);
> +	if (IS_ERR(pid))
> +		return PTR_ERR(pid);
> +
> +	/* We should be in an RCU read side critical section, it should be safe
> +	 * to call pid_task.
> +	 */
> +	WARN_ON_ONCE(!rcu_read_lock_held());
> +	task = pid_task(pid, PIDTYPE_PID);
> +	if (!task) {
> +		err = -ENOENT;
> +		goto out;
> +	}
> +
> +	sdata = bpf_local_storage_update(
> +		task, (struct bpf_local_storage_map *)map, value, map_flags);
It seems the task is protected by rcu here and the task may be going away.
Is it ok?

or the following comment in the later "BPF_CALL_4(bpf_task_storage_get, ...)"
is no longer valid?
	/* This helper must only called from where the task is guaranteed
	 * to have a refcount and cannot be freed.
	 */
	 
> +
> +	err = PTR_ERR_OR_ZERO(sdata);
> +out:
> +	put_pid(pid);
> +	return err;
> +}
> +

[ ... ]

> +BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
> +	   task, void *, value, u64, flags)
> +{
> +	struct bpf_local_storage_data *sdata;
> +
> +	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
> +		return (unsigned long)NULL;
> +
> +	/* explicitly check that the task_storage_ptr is not
> +	 * NULL as task_storage_lookup returns NULL in this case and
> +	 * bpf_local_storage_update expects the owner to have a
> +	 * valid storage pointer.
> +	 */
> +	if (!task_storage_ptr(task))
> +		return (unsigned long)NULL;
> +
> +	sdata = task_storage_lookup(task, map, true);
> +	if (sdata)
> +		return (unsigned long)sdata->data;
> +
> +	/* This helper must only called from where the task is guaranteed
> +	 * to have a refcount and cannot be freed.
> +	 */
> +	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
> +		sdata = bpf_local_storage_update(
> +			task, (struct bpf_local_storage_map *)map, value,
> +			BPF_NOEXIST);
> +		return IS_ERR(sdata) ? (unsigned long)NULL :
> +					     (unsigned long)sdata->data;
> +	}
> +
> +	return (unsigned long)NULL;
> +}

[ ... ]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 8f50c9c19f1b..f3fe9f53f93c 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -773,7 +773,8 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>  		    map->map_type != BPF_MAP_TYPE_ARRAY &&
>  		    map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
>  		    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
> -		    map->map_type != BPF_MAP_TYPE_INODE_STORAGE)
> +		    map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
> +		    map->map_type != BPF_MAP_TYPE_TASK_STORAGE)
This is to enable spin lock support in a map's value.  Without peeking
patch 5, I was confused a bit here.  It seems patch 5 was missed when
inode storage was added.

>  			return -ENOTSUPP;
>  		if (map->spin_lock_off + sizeof(struct bpf_spin_lock) >
>  		    map->value_size) {
