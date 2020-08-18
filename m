Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373352489A3
	for <lists+bpf@lfdr.de>; Tue, 18 Aug 2020 17:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHRPXt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Aug 2020 11:23:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16006 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726630AbgHRPXs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 18 Aug 2020 11:23:48 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07IFNQxp003419;
        Tue, 18 Aug 2020 08:23:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=D5Z7zLm7NkaTJlcMUU3f5yQ8zpBAEi/N0okMA6tPaU0=;
 b=qjOmON/Vw+U+KSDoVNodQH5njdkrKJmId/+e08DYxw/orEYjHP8LyWQAS6RRp9fcPDNl
 i9O5HwS3iiYyFI1UkBoo3l1bpY5g+r/LdbJUkuwpjKSUSs/p+vEKdcYoZIZc2zW34YGu
 3DlaXulnIgRYD9NCqRyevDJx02wBSZNTY08= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3304p7uat3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 18 Aug 2020 08:23:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 18 Aug 2020 08:23:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElzbxiI6fWrxr3iUfeVLeyK6YcSyraxN4D6Uiwxi5aDpggNTd9FH84ML9vrhfr5Nm7BmBhFjZ7xvCjWG63xr7h8AcDuElhF8HBNz0ME2MMuE2KjZ7jOCmg3OvkJSePTqVSi5LqKyjY8seimin1oEUxFjDW4iLKb7AQru7VK+QBmfZ7flRNmVrmIDR4uTEmFr2bDpSHWOfDSmGmxnaNoF8zEFblXN/RbeSIRZ0ldz4Q9dKWV5dEjP9W3q53LjmwwkM1SUkz76d/yF4gA8jUBDnZwBm987Tiuwk9Au10virJRFrjuZ0AmGwRaLqWUkYSq0yt2easOtrcEUEtVe39t5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5Z7zLm7NkaTJlcMUU3f5yQ8zpBAEi/N0okMA6tPaU0=;
 b=UqXD5j+ryxV/SlNvQsnSznbQ2L5EBSW6Q+YYcT78VxHjOKrxar1CvdzCUnBcJkyhD08CzfgRBBW2MGEPVDc0vtrQ0BqjbYywbsa4p/Q0IdXYd6o8GxmV8qAXy9mUuYDHHLeVLFmvi5r4YRJQXLWvBxYmgyNYxwQUD87aFMuzpHyQCkGEiGO47WPoHVEFpLdimfAXPoOQsUnUWWH6Ojq6ucJFpFrhE49yNOD0tWI3xu3TpJLJ3Dy4fiKmcFQEyx/k7BVKalc1yQPboSdm6wS8Z9kVfE/OC6rWGdBR2A08eSJXUY7pzaADj+FPf6o9ztuE91p0VDfAcHCNYQDRRLdYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5Z7zLm7NkaTJlcMUU3f5yQ8zpBAEi/N0okMA6tPaU0=;
 b=VFjmisJLn78/uNKrGCUe8lNC9nV2Wd09iOflXIORAyWXHFJZrboVPKJzqc9ohSZ60affVoAV2fWpHeMrvtQpZkcqzYivTYyEb1uyC6I2z3vj2GdPO7vM77XKpN9Zsm3r7aU/zJQt540OJSjEM6Vua5Rh57n4t2K29PyjK1B76E4=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2327.namprd15.prod.outlook.com (2603:10b6:a02:8e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Tue, 18 Aug
 2020 15:23:28 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3283.018; Tue, 18 Aug 2020
 15:23:28 +0000
Date:   Tue, 18 Aug 2020 08:23:23 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v8 5/7] bpf: Implement bpf_local_storage for
 inodes
Message-ID: <20200818152316.pkyko6gcpzeqp5sn@kafai-mbp.dhcp.thefacebook.com>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
 <20200803164655.1924498-6-kpsingh@chromium.org>
 <20200818012758.4666zlknkr4x6cbl@kafai-mbp.dhcp.thefacebook.com>
 <60344fad-f761-0fee-a6ef-4880c45c3e52@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60344fad-f761-0fee-a6ef-4880c45c3e52@chromium.org>
X-ClientProxiedBy: BY3PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:a03:255::33) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:5d73) by BY3PR10CA0028.namprd10.prod.outlook.com (2603:10b6:a03:255::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 15:23:28 +0000
X-Originating-IP: [2620:10d:c090:400::5:5d73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9942df4-854c-493c-f4d4-08d8438aa874
X-MS-TrafficTypeDiagnostic: BYAPR15MB2327:
X-Microsoft-Antispam-PRVS: <BYAPR15MB232761274C0511D5243DD3F9D55C0@BYAPR15MB2327.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+iXP2gEoafhVnZE07RI3uP0Tq2SoM2u0b3mUlCsdGAk8axKsmgDK/MgLDidd1uEL7pBCHIUzeKRl4PfslYwGj5Nj5KpucJ/pIr+utpHe8T5I898i8YfUluLZs3aBd8QPheeKELxUSPj0qqzVJ9eVoYZfWyshJr3wADCNyas4ldN5CAVkV8/mU2RL7p8f03wu9peLkdL4hd1y+ma8MMpZ9ln+/ALLztq/27qnvvK0Tn+akQFL+N9EmaMGErs0mKrU2YQ1PKqKVrhR9c2elvYtn44cL/RR2V63NTACPJ0sj5of0L5NvkrH/zIS5Tzkeivg0//uDkkLRBeHQBJgzB5vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(366004)(136003)(346002)(9686003)(2906002)(53546011)(6506007)(1076003)(8936002)(86362001)(55016002)(66946007)(66476007)(7696005)(66556008)(52116002)(186003)(16526019)(4326008)(8676002)(54906003)(316002)(478600001)(5660300002)(6666004)(83380400001)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: UqslNODVcVneOV3QD0vRPdPFfWsIQRUISeZLO/g/9msNn9A3G9M2CLylQ0ZWmJ2PvWimZCg66xtyDd4T1YnHkg3RyC6v5BBuljX0aArSaLEPndwtD05ruNQbwuXv8I2FfSmu0K2Qou2s3qYjVJ9FBKMjsJy4rbxGuObfGhfr1sPOIWk0eC8VLjuxmTVvsKup0DxRDnAuVGnLjxB7WcBSxlAzTqLLR2xJEvfyoPyZVTMMcc1J8AnP3naNlBDshdK3bE8D5qqbXkVS4mYdE2b6f1aDRzoCPDvdU45lQvqr1epXxt3cNd/D9AvKd0xEeTmv6jr43YhnZKtLvhtKJPtd+5kmbGEZmnBVDjIXZdwx/HXVCNq/iej06YI+ZeptUtAIKq1iQ5oKMWT+fOKFQXt6vpvUHmypsg/OQHi25MRh75f6Uk8UPhXR9Bg0uN/rzhGfGaBYeL4bo3gERWVa7teMDGosUkcCo1c4t+b33vdK6lUy1i8+Q6Zryi4MWaNhnAxlF3PS2gLNblv75/09WqGqaHY8DSqyQuAhUkuHDWyI9DTqnDAlM8fG4LGiWvuWctAQPlnCeges0zsNnwPgG3Fmmvk9J+l2L5pUbx0cwBblW9GMquoC27sd/4kit//dPxYZ8TxckwkVEnSOGV/+YuA5vt8zBicOj8X2DN735DjBmys=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9942df4-854c-493c-f4d4-08d8438aa874
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 15:23:28.6388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flPq27Jkj/OVsjXmtwERMDUlB5LpPTWXuSpNVsZ+hfNzqgw8oFvzDu/iaLgl4cqb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2327
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_10:2020-08-18,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=841
 clxscore=1015 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008180112
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 18, 2020 at 05:10:34PM +0200, KP Singh wrote:
> 
> 
> On 8/18/20 3:27 AM, Martin KaFai Lau wrote:
> > On Mon, Aug 03, 2020 at 06:46:53PM +0200, KP Singh wrote:
> >> From: KP Singh <kpsingh@google.com>
> >>
> >> Similar to bpf_local_storage for sockets, add local storage for inodes.
> >> The life-cycle of storage is managed with the life-cycle of the inode.
> >> i.e. the storage is destroyed along with the owning inode.
> >>
> >> The BPF LSM allocates an __rcu pointer to the bpf_local_storage in the
> >> security blob which are now stackable and can co-exist with other LSMs.
> >>
> >> Signed-off-by: KP Singh <kpsingh@google.com>
> >> ---
> >>  include/linux/bpf_local_storage.h             |  10 +
> >>  include/linux/bpf_lsm.h                       |  21 ++
> >>  include/linux/bpf_types.h                     |   3 +
> >>  include/uapi/linux/bpf.h                      |  38 +++
> >>  kernel/bpf/Makefile                           |   1 +
> 
> [...]
> 
> ata *inode_storage_lookup(struct inode *inode,
> >> +							   struct bpf_map *map,
> >> +							   bool cacheit_lockit)
> >> +{
> >> +	struct bpf_local_storage *inode_storage;
> >> +	struct bpf_local_storage_map *smap;
> >> +	struct bpf_storage_blob *bsb;
> >> +
> >> +	bsb = bpf_inode(inode);
> >> +	if (!bsb)
> >> +		return ERR_PTR(-ENOENT);
> > ERR_PTR is returned here...
> > 
> >> +
> >> +	inode_storage = rcu_dereference(bsb->storage);
> >> +	if (!inode_storage)
> >> +		return NULL;
> >> +
> 
> [...]
> 
> >> +		kfree_rcu(local_storage, rcu);
> >> +}
> >> +
> >> +
> >> +static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
> >> +{
> >> +	struct bpf_local_storage_data *sdata;
> >> +	struct file *f;
> >> +	int fd;
> >> +
> >> +	fd = *(int *)key;
> >> +	f = fcheck(fd);
> >> +	if (!f)
> >> +		return ERR_PTR(-EINVAL);
> >> +
> >> +	get_file(f);
> >> +	sdata = inode_storage_lookup(f->f_inode, map, true);
> >> +	fput(f);
> >> +	return sdata ? sdata->data : NULL;
> > sdata can be ERR_PTR here and a few other cases below.
> > 
> > May be inode_storage_lookup() should just return NULL.
> 
> I think returning NULL is a better option. Thanks!
> 
> > 
> >> +}
> >> +
> >> +static int bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
> >> +					 void *value, u64 map_flags)
> >> +{
> >> +	struct bpf_local_storage_data *sdata;
> >> +	struct file *f;
> >> +	int fd;
> >> +
> >> +	fd = *(int *)key;
> >> +	f = fcheck(fd);
> >> +	if (!f)
> >> +		return -EINVAL;
> >> +
> >> +	get_file(f);> get_file() does atomic_long_inc() instead of atomic_long_inc_not_zero().
> > I don't see how that helps here.  Am I missing something?
> 
> You are right, this should not not be an fcheck followed by a get_file
> rather fcheck followed by get_file_rcu:
> 
> #define get_file_rcu_many(x, cnt)	\
> 	atomic_long_add_unless(&(x)->f_count, (cnt), 0)
> #define get_file_rcu(x) get_file_rcu_many((x), 1)
> #define file_count(x)	atomic_long_read(&(x)->f_count)
> 
> But there is an easier way than all of this and this is to use 
> fget_raw which also calls get_file_rcu_many 
> and ensures a non-zero count before getting a reference.
ic. Make sense.

There are fdget() and fdput() also which are used in bpf/syscall.c.
