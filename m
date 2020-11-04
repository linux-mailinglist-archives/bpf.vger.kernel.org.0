Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449472A703C
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 23:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbgKDWIx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 17:08:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38898 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726777AbgKDWIx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 17:08:53 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A4M5uX3021165;
        Wed, 4 Nov 2020 14:08:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=s1V9aK72SvMpTwF3X1U6fueB2so/oMNNGSmUokS6Rsc=;
 b=XjNMtU3qWyBDP/K8NsdQeGknsTCMiNuogOhwWOPhfF/Ysio7SE7ox7ZKNDYt/8hffMQp
 SpoQxs8i+/HyG7uypzROeU4Lpe1+9oRNWSlc9vsxdCff+StIvItXBzS2e1tNAP265U6n
 s7moZa9cglPiPdzS0FASwqmGbxNH3NfTkfo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34kf5c6bsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 Nov 2020 14:08:36 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 4 Nov 2020 14:08:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bE7pPJavD77Ao8cLiM+si2OgVYXEf8hDvvwOTlJYaCS2HAi3r8wFhAAelqODiKEvKoBV+eYpZua28UZ8xiJTmrrdGk1FT4DPMGz8ByPjy4XFpEuJczLptl67hMwFCF62DSKLFt5gDCw6KEkcqJYRTHnOrXMMgBBOYtUIdIolcU5dOaC4Pe4n46bpnGBpYzt6VnuPEWJculFs7OqdKVAsWHEqNjHz1iF+olFC6nOt/KM3mAOypvwO5Z7PecUzhmL41O0BxwJGqcOFdwNhFX6URWcbQ29+bw888RX4zG+QS9fF8owJI7fXPZEbGwmS8a2PV//3v9wwIIQ0waORgNghJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1V9aK72SvMpTwF3X1U6fueB2so/oMNNGSmUokS6Rsc=;
 b=LbK2iSn6J50XGs1SrKituetyXZ+ofg4ri2CmS9/bje3zPW7UUnBEt0LJW+PyccuqmLqe83wA9T11XrsZuOZCEqzOhSAjKVErBgeAMH8ikvs/smzG/C44hheAfshoTAdr/szOCp09qkm07A7JazXR0KFWZp2xYQK9mVbe5Lqn6QAOj3Vnzrzvi32wIBnEtFu/3uNCk2nfjwy7w/cYPzpKmGmRtctWhyl2PcR/goFy732HwT1v7FYz+J0hmIutUH3AvxeP3lMX2d+XwttFCdeUZbMFfTSALLQiupDB1W7Q7pyhAhUpRbbuvGpyBXVtWtNAFz6UqzBw+xRObZ//Y6kUpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1V9aK72SvMpTwF3X1U6fueB2so/oMNNGSmUokS6Rsc=;
 b=GtjMCLJYGSMdK2tdTMLgRIxvmDSDoskXbwrTje2kbQld/C9ylhQprWOG9t4OrtFD97mZ1xIzyecPUrPiw6PxNyiGKIgHgrvmolGl/UOvh2nFbTuznsAtJGW0cxQd5p2sUNKXUFmOovSiiQYDcBIcC23iI5TAq4yx4fS6/BH8VkA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3190.namprd15.prod.outlook.com (2603:10b6:a03:111::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 4 Nov
 2020 22:08:21 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee%4]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 22:08:21 +0000
Date:   Wed, 4 Nov 2020 14:08:14 -0800
From:   Martin KaFai Lau <kafai@fb.com>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Implement task local storage
Message-ID: <20201104220814.quq7jzpeb4wcyffv@kafai-mbp.dhcp.thefacebook.com>
0;95;0cTo: KP Singh <kpsingh@chromium.org>
References: <20201104164453.74390-1-kpsingh@chromium.org>
 <20201104164453.74390-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104164453.74390-2-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:3041]
X-ClientProxiedBy: MW3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:303:2b::33) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:3041) by MW3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:303:2b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend Transport; Wed, 4 Nov 2020 22:08:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2467d800-9460-43b7-88ce-08d8810e23f9
X-MS-TrafficTypeDiagnostic: BYAPR15MB3190:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB319063D7A8169F2DCA6B6DCCD5EF0@BYAPR15MB3190.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMtT8GmJAAIOznuvGhrdseqN5659FTrWPbu+fTwB/rKTNvgineHyc8xBerf5n9MB4RWiXzAtsUnPxUtNEglhBecxApfPFEMsNMxynx7T6NWWtxwMAGuzMJNtOvuPL3PQZ+cgKQSd2GhHlRFULXVwFbEpamSHwCpjcp9Z622Rwpy02nVDBiweLRzm7dODnDSqy4KI+tUr6BWQfUgdfWFNhc7bQJck16m6X3I8Wg/FxONxm6cvB9+hg+rE+sd7GYilKRqUUdg9mRQtaZEGaD434OJ65nXfP/nogRmqpIHEv5vAMHJdYJDAfkoiDxH1apO1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(366004)(136003)(396003)(8676002)(6666004)(7696005)(186003)(55016002)(8936002)(83380400001)(9686003)(16526019)(54906003)(4326008)(52116002)(6506007)(109986005)(1076003)(478600001)(66476007)(5660300002)(86362001)(66556008)(2906002)(316002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: S5OhrRiTQWnq3291itR4arN473vUzfORTaG4SnljWefIqBxhcJBQ6Ww6+u9aGN9dwbt0EGsZWEGhNE5aTFZCfY4IyYLb5hiyPjNELHDTnyjqxPyVmXlzeNsUWnGao7dMe7o9LqKB/6vtFv7Pqk4IJAafOI3+UUyvtW4AZHnXETsBQY6mjsybZT3yBRNhayJEk4T5AiW9tTh3KRQMLd+sB0e2CqfYKmpPp6fdLo/xziakKneInU8AkOEdu4EWFZWQJUfa4S3lHSwHaie5QfaSercsVAb28RUnNqwj8TiSocYWfDl3/Q+A2H98/H75acfenI2f2NtNg8hp0Nf2pW/jw/BB9KfSZ9jWhpmcSLOXKOK6v5EJ5pg0bqL144Nsgx8MGaqhOTKRsDlJ5Bm+3W55Pc7be/+dqIrPGJ3khZ2649BjgIuW+14DlIJFzQZicX5mOBmN/6i3iWvJ+TnqRvpUa/DENz9Msft/6EU4tAyWtOVPSgBbgfXzenYRsipBIv/Y20UXgFHJIDmEcAcuDcC2LxVMFMt1MH6oWKscHXHBb0UN0/muQKpglP26U+GkiRT2pWA/1p6+R2K5I0Q38fzEK+z1Q5GOqsS1L1Ds1kET5/H46ELElxoScCFyLDcw50VRnWsuDmnIs1NW9tai+JqYWGf9J7hJPLrpco8rYJiK+M0dIXRI3Z/6hZYwc+mibkGc
X-MS-Exchange-CrossTenant-Network-Message-Id: 2467d800-9460-43b7-88ce-08d8810e23f9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 22:08:20.9374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuuU5v6pWS6+qQPujK9JhRfrOY5Z/iUpcSGlT9N21JHIkuFIP832N7cThAT54DZV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3190
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_15:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=549
 suspectscore=1 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040157
X-FB-Internal: deliver
To:     unlisted-recipients:; (no To-header on input)
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
> +

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
