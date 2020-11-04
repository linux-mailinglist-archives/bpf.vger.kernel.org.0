Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232A72A7051
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 23:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbgKDWTX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 17:19:23 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36514 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730691AbgKDWSi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 17:18:38 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0A4MFaFG027060;
        Wed, 4 Nov 2020 14:18:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=NfD2VGhVkvqz8FHLkA3EFYasvL//2MZ3W5a9s5qW1MM=;
 b=SaD1YRcCF+/za0f85EROPpu4Icr/PYgXrj5IfkLGH0qXXzrhL92Aim8TyKFYjUYfpQrx
 J1OgczXivuer8HcOwPtEcmKah1FlOVAmlpvz+Mt6WqBScjEZrsKbmsPfdLpmHBYwnJeQ
 ARUlyLfZN/YWCLCW9xep29W/Vd+ik7/XgWE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 34k9k3h076-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 Nov 2020 14:18:21 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 4 Nov 2020 14:18:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amxWyteQwBoPiVOQsDtELjX+EBrKAj+Vjj1M0seWW39ohNa8ZYFC62bVWd8BTGS+VqehEVHFO6mEbcb7jgcbWyNx/Pqc1qq26/dfaDdk9V4lDCCnomPjIkOV4LM1FiOuPZ8yL9e72kiTWRZJGvHuGDx7YbCJMahBq4OcjQRq4IDNWXT+rwrOp/rYr1yXdcVsZeMW8EdtSZms+a1lANHHjJHf0N5NNEBsNdWUZYqOjmU8YzHvBc7sC1KVf9k+htiFgltmusTrhdLtazl2StViQ90GInmgRgaHzYMZsUVJgfiaWwy3/DgWOyG8xyJTnmQ4nncyCU9Lip4BtO10SKGh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfD2VGhVkvqz8FHLkA3EFYasvL//2MZ3W5a9s5qW1MM=;
 b=mVxgG1O714nbzwdNf+OCLn1Gb9wtQExWbYI/HnRatKr+CykJsmeGvleZ4JQ4qKx7Sdwt6zKDyqYDtFOvVHf5DwxrQ7E40H5PkDDcIqp9Kdb30o30kPPy7k8+mx6q+7gkcvz7iMxzo+Mv8owdroG1Lf0GXS7woCxaEAQR/fYFWVbhTM3X7bzozKutBpq4qYLidPiTXTN+WAOBphZkIKvCKKETJaZOpZa8k2M1zbmTYZQWd0taKLPBkOdhxRNU1NMrhbem+FhB+dZa9tF9RggptqYc+A+x/VGOR8VhuBuvYOdJOwTt7T6vnoJylN4LkSYsLBBdsvsomFOcTkCuFuKVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfD2VGhVkvqz8FHLkA3EFYasvL//2MZ3W5a9s5qW1MM=;
 b=c6PX0LBPkOYelL/AOwVmvNu9hZB1KhLQugHuVXjQww9UDnVHbpLSkLqf2OPh0XwulQv5nIUqZfecxUivq4a3qqXvMUzhGpEo031fLpY0Wb9C/LvlZ4eFtsMt114EJlmp2StSu6eAAfnzA0whTr56IBJFsoq1SKk0KjSvCBdTzFU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by SJ0PR15MB4235.namprd15.prod.outlook.com (2603:10b6:a03:2e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 4 Nov
 2020 22:18:05 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee%4]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 22:18:04 +0000
Date:   Wed, 4 Nov 2020 14:17:58 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Implement task local storage
Message-ID: <20201104221758.jr537hm7psfyvqlv@kafai-mbp.dhcp.thefacebook.com>
References: <20201104164453.74390-1-kpsingh@chromium.org>
 <20201104164453.74390-2-kpsingh@chromium.org>
 <20201104220814.quq7jzpeb4wcyffv@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104220814.quq7jzpeb4wcyffv@kafai-mbp.dhcp.thefacebook.com>
X-Originating-IP: [2620:10d:c090:400::5:3041]
X-ClientProxiedBy: MW3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:303:2b::6) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:3041) by MW3PR05CA0001.namprd05.prod.outlook.com (2603:10b6:303:2b::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend Transport; Wed, 4 Nov 2020 22:18:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ead1b237-0d6f-441e-b493-08d8810f7fe9
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR15MB42355C6631AD311EF29E2383D5EF0@SJ0PR15MB4235.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5ThSyI0KUpDUSYkbw06pyrecD8t4A7cu3V97ED+aTeebs9NkJlQwoKBcWnegQO92XtYKyk8DiDzWK4X5WIb/Sd724vta1PP9V1ObCRlzb39ExlchKQy3sZnFipKF8/m2TkEXqLjD523Z0mMfFTGm0raZ2AXwmDtjF1NP/4tSGKqHym73VBv8VNsYEKxurQTGsrUEFiELV9ybScVyrtUY9W2DySJCxqE0rVsJmI03IMGmIqxd10GrSi1Ct2gqcXSZmuGu1bmz8cq/1wT/iO3JbEISp25csnMA6ePpglKq2bcpn9abI9q+Bq8KQzIQlhE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(376002)(136003)(366004)(9686003)(6666004)(8936002)(8676002)(6916009)(6506007)(4326008)(186003)(55016002)(86362001)(16526019)(66946007)(478600001)(5660300002)(2906002)(7696005)(66476007)(83380400001)(66556008)(1076003)(54906003)(316002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vcp10orz1ZknApXkDDcPc02Y9MclfxXL/ekYGHonyDFGQZ3GKTiZRxykrIXMSGqQdwOUfN4WPNTShWoJFkSZSdiAR6NO5KoiZDSeBv0FRUID7YBy32TiMeQ/XiWge9bG+8DDjaOudOM9thvI1WxjeuwHxU7EJm1Q9sYDjrbIUDyt2vbisya04wbfeH1SpPQM+7MbixV9J8Sg8vU7dnA/CYwFNphdnSf6tYLLQtk/b21bejCUqM1B33hYMToRIJJGS9iHGre5XMppICMMdMb6ReBasTuVAf/r/JyELqlOUlgZh07TFrqf7bPQN6/YCESoBvo3YrpXeYEfy6wF5F2Y7XDgm1mDb0skRuBolVQzgrv5d4VJkm/7nvBR07wKdDvUBjRL8oL3k6t8am2wcIYymwE9azZhXwtkVkBBAj9eC/FphrdH6kLXEp6qeIVgH4RT1kpXO85egpKITVTokyFRxFDiLyo+46qA+Qb4tXuwGgto+OfO80ujPDuWr9784OWkj5W8X3nG4/sA8pASsllfWoS/59uVrnCcjG0jcFZpaigFawCd7R8WURORcwJN3YZ4BE81l8O1gND3sgvFoG6qxPuiAfTAUnjRPGFabMN27q8VVdPA71C81U1RSeQTF55kz+VWzk5HEhRjTPRrAWmyUw8H9dtC8tzRa5L2ij4clyA5uxU+jEQogeHG2up7qsRs
X-MS-Exchange-CrossTenant-Network-Message-Id: ead1b237-0d6f-441e-b493-08d8810f7fe9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 22:18:04.5239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmhOkOos6NcWkIyYMWldll0t3OSziKWQey7JFzBsPscvG5NSDWM78ycXw7EAn5bW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4235
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_15:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=599 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=34 spamscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040158
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Please ignore this reply which has missed some recipients.

On Wed, Nov 04, 2020 at 02:08:14PM -0800, Martin KaFai Lau wrote:
> On Wed, Nov 04, 2020 at 05:44:45PM +0100, KP Singh wrote:
> [ ... ]
> 
> > +static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
> > +{
> > +	struct bpf_local_storage_data *sdata;
> > +	struct task_struct *task;
> > +	unsigned int f_flags;
> > +	struct pid *pid;
> > +	int fd, err;
> > +
> > +	fd = *(int *)key;
> > +	pid = pidfd_get_pid(fd, &f_flags);
> > +	if (IS_ERR(pid))
> > +		return ERR_CAST(pid);
> > +
> > +	/* We should be in an RCU read side critical section, it should be safe
> > +	 * to call pid_task.
> > +	 */
> > +	WARN_ON_ONCE(!rcu_read_lock_held());
> > +	task = pid_task(pid, PIDTYPE_PID);
> > +	if (!task) {
> > +		err = -ENOENT;
> > +		goto out;
> > +	}
> > +
> > +	sdata = task_storage_lookup(task, map, true);
> > +	put_pid(pid);
> > +	return sdata ? sdata->data : NULL;
> > +out:
> > +	put_pid(pid);
> > +	return ERR_PTR(err);
> > +}
> > +
> > +static int bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
> > +					    void *value, u64 map_flags)
> > +{
> > +	struct bpf_local_storage_data *sdata;
> > +	struct task_struct *task;
> > +	unsigned int f_flags;
> > +	struct pid *pid;
> > +	int fd, err;
> > +
> > +	fd = *(int *)key;
> > +	pid = pidfd_get_pid(fd, &f_flags);
> > +	if (IS_ERR(pid))
> > +		return PTR_ERR(pid);
> > +
> > +	/* We should be in an RCU read side critical section, it should be safe
> > +	 * to call pid_task.
> > +	 */
> > +	WARN_ON_ONCE(!rcu_read_lock_held());
> > +	task = pid_task(pid, PIDTYPE_PID);
> > +	if (!task) {
> > +		err = -ENOENT;
> > +		goto out;
> > +	}
> > +
> > +	sdata = bpf_local_storage_update(
> > +		task, (struct bpf_local_storage_map *)map, value, map_flags);
> It seems the task is protected by rcu here and the task may be going away.
> Is it ok?
> 
> or the following comment in the later "BPF_CALL_4(bpf_task_storage_get, ...)"
> is no longer valid?
> 	/* This helper must only called from where the task is guaranteed
>  	 * to have a refcount and cannot be freed.
> 	 */
> 
> > +
> > +	err = PTR_ERR_OR_ZERO(sdata);
> > +out:
> > +	put_pid(pid);
> > +	return err;
> > +}
> > +
> 
> [ ... ]
> 
> > +BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
> > +	   task, void *, value, u64, flags)
> > +{
> > +	struct bpf_local_storage_data *sdata;
> > +
> > +	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
> > +		return (unsigned long)NULL;
> > +
> > +	/* explicitly check that the task_storage_ptr is not
> > +	 * NULL as task_storage_lookup returns NULL in this case and
> > +	 * bpf_local_storage_update expects the owner to have a
> > +	 * valid storage pointer.
> > +	 */
> > +	if (!task_storage_ptr(task))
> > +		return (unsigned long)NULL;
> > +
> > +	sdata = task_storage_lookup(task, map, true);
> > +	if (sdata)
> > +		return (unsigned long)sdata->data;
> > +
> > +	/* This helper must only called from where the task is guaranteed
> > +	 * to have a refcount and cannot be freed.
> > +	 */
> > +	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
> > +		sdata = bpf_local_storage_update(
> > +			task, (struct bpf_local_storage_map *)map, value,
> > +			BPF_NOEXIST);
> > +		return IS_ERR(sdata) ? (unsigned long)NULL :
> > +					     (unsigned long)sdata->data;
> > +	}
> > +
> > +	return (unsigned long)NULL;
> > +}
> > +
> 
> [ ... ]
> 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 8f50c9c19f1b..f3fe9f53f93c 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -773,7 +773,8 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
> >  		    map->map_type != BPF_MAP_TYPE_ARRAY &&
> >  		    map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
> >  		    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
> > -		    map->map_type != BPF_MAP_TYPE_INODE_STORAGE)
> > +		    map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
> > +		    map->map_type != BPF_MAP_TYPE_TASK_STORAGE)
> This is to enable spin lock support in a map's value.  Without peeking
> patch 5, I was confused a bit here.  It seems patch 5 was missed when
> inode storage was added.
> 
> >  			return -ENOTSUPP;
> >  		if (map->spin_lock_off + sizeof(struct bpf_spin_lock) >
> >  		    map->value_size) {
