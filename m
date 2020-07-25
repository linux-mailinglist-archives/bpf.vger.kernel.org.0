Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B75D22D37B
	for <lists+bpf@lfdr.de>; Sat, 25 Jul 2020 03:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgGYBNy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jul 2020 21:13:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12650 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726701AbgGYBNx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Jul 2020 21:13:53 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06P18f78013161;
        Fri, 24 Jul 2020 18:13:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=+qXpq67P92LPLKbAfTA0RAqNISY+lsNANAuPRN2AB7Q=;
 b=aZIWFfxgJsVCSyZ3BB5zNdwEd9q9WfFDE230We9laK/TE6/PVLgshw3fCuOOPZ6DiBYg
 9YYLit2bBV+y1r1WuzUjE295EeDFTnNar8OIODFyRax4Un8L5MOTIJpVW5HD73Yh40/s
 aD5QC7Rw6DgFceLZJMDKTQOeq8qw7UpsfTo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32fh7kpkhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Jul 2020 18:13:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 24 Jul 2020 18:13:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dA5kK4cKgs5qLiHsHORoAcBBLtoweAa3FHk6GjQ5yh4SrmE4YAnaqfBpidmhYJW3Rz7oQRWrl7g5xEwhsa+NAT212GMUX7k1C7vFWxjfSX5ZVzN6tozGTHEgywIIN7enKqq2wa2AM8ExuGR73TiQrUCJnXXFS+VKFOGPh3ap5MyBk98bseI4esFUlJjf2+K1G0f5Jn7/x8wJOriD968lRoOqqL8L6HOz+973599lDJy+LiHihbSFxr7X9rNYnZZ6dUowNgbrqhc1sQZ73CURRBgL8gNR5EZRLYu7RHAciQChwbLiQQk6tJMTjOHLDeToMY5doXI6pR8NkIbqqPRNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qXpq67P92LPLKbAfTA0RAqNISY+lsNANAuPRN2AB7Q=;
 b=droelWVL2gpaUpv3ABOIxQqj0CLjRfekd9aSi3kUXhjkWBE5p+z+4Q9JgPDoehH+jjgefakFpAfVZTaa0RXVaMu6fvuRIT6UARBBYFEL1YwvbD36izZwvJqwHw3yudXd+RkJgQsPlmEDnlUF9WdWQl33pNMdtddCj+Uf9wgV63yNV35cJ0rQfnkuG3grQCjzi1UH747o19QcUFLQWNr9D+DGwEP34yoVFwFepBjfgtlC0HndKskAEd00s7+2Tup15z9lW9rKrbuQubJ3XjuH2++Y7S8anL3/RKpQEnZ1qnPfKszmaQsyDdoonfdIbNyBDH7h0GhnjD2PoEHwFIqQpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qXpq67P92LPLKbAfTA0RAqNISY+lsNANAuPRN2AB7Q=;
 b=H6knJWP6vf6K5hOTJEJHOuYglEc5Rl3sqfV/rvedtGOUnbG7sdFh/HFlh0xe+w7Yz5WZ8bzhWGaixgUBvhpW9cicp3Yoh3MWL7xiEfmz2Z7fceJBVxGI6GK6RjZTBqh9rEG0UcfAtIO420UfADYDU1FSbhWEjWE8tSyAn+CMlE0=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3461.namprd15.prod.outlook.com (2603:10b6:a03:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Sat, 25 Jul
 2020 01:13:31 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3216.024; Sat, 25 Jul 2020
 01:13:31 +0000
Date:   Fri, 24 Jul 2020 18:13:29 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v6 3/7] bpf: Generalize bpf_sk_storage
Message-ID: <20200725011329.ymvhmbb2y5yqzy3k@kafai-mbp>
References: <20200723115032.460770-1-kpsingh@chromium.org>
 <20200723115032.460770-4-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723115032.460770-4-kpsingh@chromium.org>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BY3PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:254::10) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:41b0) by BY3PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:254::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9 via Frontend Transport; Sat, 25 Jul 2020 01:13:30 +0000
X-Originating-IP: [2620:10d:c090:400::5:41b0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ce191b6-a1d2-4d69-173a-08d83037f19c
X-MS-TrafficTypeDiagnostic: BYAPR15MB3461:
X-Microsoft-Antispam-PRVS: <BYAPR15MB346185DB4384AE479F912FD5D5740@BYAPR15MB3461.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYu8fWmDs4/ZdRLkWiJwvSHYYMuaCRnP7CcO2Q6omqeebm36M/IliN3PspWQyIWVIt51g658AckduFx3UnMMqE+D5Yq1HGVuB3ZZ/AhRk2o7pNraaGeqOT9aUuVI3LQ47RnshBLUy/lUEu8iX65E9xuokmeXIZwEdLqhGlhE80AJimlQlFopp3pyKNAJbRQWLuN2EBNAyn0WqBSQrf+LZwuz+bHF3BEkAkX3ECCQk2fFGBI+eFDteQ2Z2+HKy7ss6jJbyc55F4yR8qHEMRqKETCC0fX1KFv6p82Z1u4D1Yv9FS/srD7/vE7xxW5JEr+/2MHijvxeCukcCUbvZ3Rfxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(136003)(376002)(346002)(39860400002)(16526019)(33716001)(186003)(2906002)(5660300002)(54906003)(6496006)(52116002)(8676002)(316002)(83380400001)(1076003)(66946007)(66476007)(66556008)(55016002)(4326008)(8936002)(478600001)(9686003)(6916009)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Oo7nd8S1Wo+K6n6dq6gwKlN7eITuFoKk4Iq1kkb4rd6bw5RcfJMS4JcNWPKgOY7+eiJOGz7/Ka1lyid+ESQLiFlObiZFHzWJ2PUOkmqwBvoUxLujZpshwQtD4TthLg1IjjWEe+jJd3eEaAd2k88yT0n+KBuPufwGUi5jnH9bzFc5mYKU47IjXYfzEqXKTJM1cbltpXVQaiqZfGaFx3+zS+o/UiXjtIhwcC9e76l9HDHw1dL7gNICqw56yEwf6Q5EL/lZLdWqhviXlg5dfpPqOsvk7lWzAQS1MFO0HukJwHsu0scgvEKtEhnRF/q38KF7FFPvfBwDZ8Qfd7s4Ccqe5mIf5Iri9NHIvmmp/+DY/cTzd/oQqpMjs6hqK+huMsu6DsH5Ovn8u146DBL6j9oUpB54lDxZBsIegby4D2eDWNKYAFFk1v3TJAa+wMjpUOwOMhtcIhCOQH3Qr8+wivhngQmm2xOd1AjUmaOGw1WnR099FNT0m7+KlhXmnEa2nXjzIEqiKfFLjOjLYw1CyXoAXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce191b6-a1d2-4d69-173a-08d83037f19c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2020 01:13:30.9627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NH9XPIn6DtbTQo+gUnVWOdPcUlqdvQ2x31gKsN5Rv8G8EXEF8n4ENd1ImdUrx6n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3461
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_10:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=2 malwarescore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007250006
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 23, 2020 at 01:50:28PM +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Refactor the functionality in bpf_sk_storage.c so that concept of
> storage linked to kernel objects can be extended to other objects like
> inode, task_struct etc.
> 
> Each new local storage will still be a separate map and provide its own
> set of helpers. This allows for future object specific extensions and
> still share a lot of the underlying implementation.
> 

[ ... ]

> @@ -386,54 +407,28 @@ static int sk_storage_alloc(struct sock *sk,
>   * Otherwise, it will become a leak (and other memory issues
>   * during map destruction).
>   */
> -static struct bpf_local_storage_data *
> -bpf_local_storage_update(struct sock *sk, struct bpf_map *map, void *value,
> +struct bpf_local_storage_data *
> +bpf_local_storage_update(void *owner, struct bpf_map *map,
> +			 struct bpf_local_storage *local_storage, void *value,
>  			 u64 map_flags)
>  {
>  	struct bpf_local_storage_data *old_sdata = NULL;
>  	struct bpf_local_storage_elem *selem;
> -	struct bpf_local_storage *local_storage;
>  	struct bpf_local_storage_map *smap;
>  	int err;
>  
> -	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
> -	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
> -	    /* BPF_F_LOCK can only be used in a value with spin_lock */
> -	    unlikely((map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
> -		return ERR_PTR(-EINVAL);
> -
>  	smap = (struct bpf_local_storage_map *)map;
> -	local_storage = rcu_dereference(sk->sk_bpf_storage);
> -	if (!local_storage || hlist_empty(&local_storage->list)) {
> -		/* Very first elem for this object */
> -		err = check_flags(NULL, map_flags);
This check_flags here is missing in the later sk_storage_update().

> -		if (err)
> -			return ERR_PTR(err);
> -
> -		selem = bpf_selem_alloc(smap, sk, value, true);
> -		if (!selem)
> -			return ERR_PTR(-ENOMEM);
> -
> -		err = sk_storage_alloc(sk, smap, selem);
> -		if (err) {
> -			kfree(selem);
> -			atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
> -			return ERR_PTR(err);
> -		}
> -
> -		return SDATA(selem);
> -	}
>  
>  	if ((map_flags & BPF_F_LOCK) && !(map_flags & BPF_NOEXIST)) {
>  		/* Hoping to find an old_sdata to do inline update
>  		 * such that it can avoid taking the local_storage->lock
>  		 * and changing the lists.
>  		 */
> -		old_sdata =
> -			bpf_local_storage_lookup(local_storage, smap, false);
> +		old_sdata = bpf_local_storage_lookup(local_storage, smap, false);
>  		err = check_flags(old_sdata, map_flags);
>  		if (err)
>  			return ERR_PTR(err);
> +
>  		if (old_sdata && selem_linked_to_storage(SELEM(old_sdata))) {
>  			copy_map_value_locked(map, old_sdata->data,
>  					      value, false);

[ ... ]

> +static struct bpf_local_storage_data *
> +sk_storage_update(void *owner, struct bpf_map *map, void *value, u64 map_flags)
> +{
> +	struct bpf_local_storage_data *old_sdata = NULL;
> +	struct bpf_local_storage_elem *selem;
> +	struct bpf_local_storage *local_storage;
> +	struct bpf_local_storage_map *smap;
> +	struct sock *sk;
> +	int err;
> +
> +	err = bpf_local_storage_check_update_flags(map, map_flags);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	sk = owner;
> +	local_storage = rcu_dereference(sk->sk_bpf_storage);
> +	smap = (struct bpf_local_storage_map *)map;
> +
> +	if (!local_storage || hlist_empty(&local_storage->list)) {

"check_flags(NULL, map_flags);" is gone in this refactoring.

This part of code is copied into the inode_storage_update()
in the latter patch which then has the same issue.

> +		/* Very first elem */
> +		selem = map->ops->map_selem_alloc(smap, owner, value, !old_sdata);
> +		if (!selem)
> +			return ERR_PTR(-ENOMEM);

>  static int sk_storage_map_btf_id;
>  const struct bpf_map_ops sk_storage_map_ops = {
> -	.map_alloc_check = bpf_sk_storage_map_alloc_check,
> -	.map_alloc = bpf_local_storage_map_alloc,
> -	.map_free = bpf_local_storage_map_free,
> +	.map_alloc_check = bpf_local_storage_map_alloc_check,
> +	.map_alloc = sk_storage_map_alloc,
> +	.map_free = sk_storage_map_free,
>  	.map_get_next_key = notsupp_get_next_key,
>  	.map_lookup_elem = bpf_fd_sk_storage_lookup_elem,
>  	.map_update_elem = bpf_fd_sk_storage_update_elem,
>  	.map_delete_elem = bpf_fd_sk_storage_delete_elem,
> -	.map_check_btf = bpf_sk_storage_map_check_btf,
> +	.map_check_btf = bpf_local_storage_map_check_btf,
>  	.map_btf_name = "bpf_local_storage_map",
>  	.map_btf_id = &sk_storage_map_btf_id,
> +	.map_selem_alloc = sk_selem_alloc,
> +	.map_local_storage_update = sk_storage_update,
> +	.map_local_storage_unlink = unlink_sk_storage,
I think refactoring codes as map_selem_alloc, map_local_storage_update,
and map_local_storage_unlink is not the best option.  The sk and inode
version of the above map_ops are mostly the same.  Fixing the
issue like the one mentioned above need to fix both sk, inode, and
the future kernel-object code.

The only difference is sk charge omem and inode does not.
I have played around a little.  I think adding the following three ops (pasted at
the end) is better and should be enough for both sk and inode.  The inode
does not even have to implement the (un)charge ops at all.

That should remove the duplication for the followings:
- (sk|inode)_selem_alloc
- (sk|inode)_storage_update
- unlink_(sk|inode)_storage
- (sk|inode)_storage_alloc

Another bonus is the new bpf_local_storage_check_update_flags() and
bpf_local_storage_publish() will be no longer needed too.

I have hacked up this patch 3 change to compiler-test out this idea.
I will post in another email.  Let me know wdyt.

--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -33,6 +33,9 @@ struct btf;
 struct btf_type;
 struct exception_table_entry;
 struct seq_operations;
+struct bpf_local_storage;
+struct bpf_local_storage_map;
+struct bpf_local_storage_elem;
 
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
@@ -93,6 +96,13 @@ struct bpf_map_ops {
 	__poll_t (*map_poll)(struct bpf_map *map, struct file *filp,
 			     struct poll_table_struct *pts);
 
+	/* Functions called by bpf_local_storage maps */
+	int (*map_local_storage_charge)(struct bpf_local_storage_map *smap,
+					void *owner, u32 size);
+	void (*map_local_storage_uncharge)(struct bpf_local_storage_map *smap,
+					   void *owner, u32 size);
+	struct bpf_local_storage __rcu ** (*map_owner_storage_ptr)(struct bpf_local_storage_map *smap,
+								   void *owner);
 	/* BTF name and id of struct allocated by map_alloc */
 	const char * const map_btf_name;
 	int *map_btf_id;
