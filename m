Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599CC233CC6
	for <lists+bpf@lfdr.de>; Fri, 31 Jul 2020 03:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgGaBIu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jul 2020 21:08:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39934 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730987AbgGaBIu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 Jul 2020 21:08:50 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06V15oeX009850;
        Thu, 30 Jul 2020 18:08:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zbmMTHUb7VCsqbfZsbWlNepNwmQ83FAySCCrm+KaP9w=;
 b=HGczmnrBkuscBO2v5//mBlX0zgHnIm5aRQMDdYYs4idk45zQ5Y9RINihVpblfEZock05
 dhfqdbPVanWEFvwwDzr7LWUFpVMebabwkbQ/lSyGNN8JfYEY/njFrngs9EfAfsSWAkvg
 mnFTM2u3th9ixobtZA8HXKhauOxEXCPoNmg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32kcbuyvcy-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 Jul 2020 18:08:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 30 Jul 2020 18:08:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbyyO2o9pxMpo54YhQYh/z+hsutFw83SDNc5Cxb06iAoW/3xPlhSmTxZhYF6o5Z4nvDtRvQQmTU6PSlPBhAcxTW2GWXeqRQmpbqdMjXvO/pLBnCGkNqrahiwyARzAhMNh8G2sXIWTzbLHhU3fmMGm5jbdu/Pfr6miErOZcEVTuO3EzKGUJq9mExCQ0SKX1VMWzqcv5Ai7PNHwJopxF+3d5SWHlMJd+CMnDFvQfCyPGEAZP6GWpgL+7mmVS5mVh3RcKkixY7OxEnDMPvjUh2dhDO4wlwccK6x8cNdA5kUGx0pSEfFZdm+Zm/Ff3//jWew4xkR/c5Oe/XCbOFf/pRLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbmMTHUb7VCsqbfZsbWlNepNwmQ83FAySCCrm+KaP9w=;
 b=KxJipJu6FnKOG2RIZCMv8e9lWcYtEVL+L2Z2nmmK1fdBviS5Rxz7Dl3D5PD9XIjnsJJC6f591H1bXOEG2ig1ghUTpLFT7P7NK1q22cYmByTjjHSUOEnU5whJPpaFtDygolObsVPz2U1UTqlDVvpV8Zim1A80pTSLI7cPk3XXIgSiz088dHCohcYrsRiIcCk9C3/Xj1iqYdT6gxJHvl9tM33/yML2Spp2BWmWcVTWCZl/JtWlqHFkxLMybuwZb/BTPrvRoRsxvhSNaBxE/qT8mJImSCwOjS3XWchp97vgsEyKMnmrHAKmhpMwbI1rY1spNzM5PSgIbybpaAApSXhRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbmMTHUb7VCsqbfZsbWlNepNwmQ83FAySCCrm+KaP9w=;
 b=Ss7L9bS9v1bFwiJZezKLr8niVlOuJ9FCJ0C+ii2zqIqLtMF1cPpu7SWHtN5ZBWWHnyvOtICQPl5YtbUX4SHmN69/K1gJY/0wKuqhHa1+9ZNMVubIQQQxj41HTuJgQRk0ppx4UVHq7N6iR26DHr0v5kUVXZPpCPB5G73i7c1n6nc=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2950.namprd15.prod.outlook.com (2603:10b6:a03:f6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 31 Jul
 2020 01:08:28 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3239.017; Fri, 31 Jul 2020
 01:08:28 +0000
Date:   Thu, 30 Jul 2020 18:08:22 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v7 5/7] bpf: Implement bpf_local_storage for
 inodes
Message-ID: <20200731010822.fctk5lawnr3p7blf@kafai-mbp.dhcp.thefacebook.com>
References: <20200730140716.404558-1-kpsingh@chromium.org>
 <20200730140716.404558-6-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730140716.404558-6-kpsingh@chromium.org>
X-ClientProxiedBy: BYAPR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::45) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:f049) by BYAPR11CA0104.namprd11.prod.outlook.com (2603:10b6:a03:f4::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Fri, 31 Jul 2020 01:08:27 +0000
X-Originating-IP: [2620:10d:c090:400::5:f049]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a7120be-27ed-4486-fc99-08d834ee3b59
X-MS-TrafficTypeDiagnostic: BYAPR15MB2950:
X-Microsoft-Antispam-PRVS: <BYAPR15MB29508ECF28B16318220FFF00D54E0@BYAPR15MB2950.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U1RvTPOLXwxqOBJjfKfWnV+sM0ah2k8dtXkyIWp6gAk/bLO8WeHAnuAeCwUK9TthRL9rgi80NCWRANmWWxMGevjLnflkCPg62Wv6Kps/7X8YyBmwQes+5vPoDoIBLheW0MC5SvXA1hZvGVOTICPfSfaLc7t7KVoQhLOFKx4ANVS0eAooDpCP0TymLiBbBdysHsM4fHcbpX1bnJD4aTL00ZB8pbp3O3GoFFXjLabO9PBUDe5jZnLVD7nJh5mm8aBCxaDRJzbfCZQ/Tz2PNpihkiNKkGWbv0qWuH3q1VWXhP/FKvlu5OJgvJEbkPxbYIMNLfipyof2Bb8JBYMnpUrKSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(376002)(39860400002)(136003)(396003)(4326008)(478600001)(186003)(83380400001)(6506007)(7696005)(52116002)(66476007)(8676002)(16526019)(86362001)(6916009)(66556008)(66946007)(6666004)(55016002)(54906003)(2906002)(1076003)(9686003)(5660300002)(8936002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Xt7VfWOzCpzakFaXyJ11DRZ742bTzDIC0L6OlH3+YWKCYYiBL5MGB1PLaPOijt7Wj+y6SWVSPGwW8yP1Y4RK3zYA7aFhe8F9xABywy3tNf7HBZkR/xDIYL05OZxegpb5E3BKu8I5pvV/S6fOpVnmhl4DLcqOuc++zk7CEEcQJSkpoRauRk+yhxeuFTFJUzBPEMf0fSm6+ARlWwr/whHqaewoRdACuakCe0HK4I0BzhdhSwODuu8VKzsW0sbzicRPPPX3uCHfkdktBFbOHXwuJ0dzi9mlTWwTJxPGvyn/fNj9vxm6fJSESOGAV90RrW3Gz8IjHgl2bGnXYM+N7gO9gkMmNZscEkFgezQaewW3GMdxLzpR1iK4jgBTYk22CBFSg5BLVI/XZ6qk5EDX4WXxBMun7u4Ntu2xyfZepD+V4Pg6sUEtSAZCYq7mhZTyqcpmGjgZNal2LPMds0Ny2NZdEOlAeYFvzlGinh1pNq3I0+C4H8C2gLgqM5+nA+GaNRgT+j7k1m9jEOm5r+zllfoFvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7120be-27ed-4486-fc99-08d834ee3b59
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 01:08:27.8697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIoX0kasqaF+s6L0SAHSLuAB9zCLY0W/+nUqmB2K7W4VYcID85bIjTD1QqHxCPlU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2950
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-30_19:2020-07-30,2020-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=877
 bulkscore=0 clxscore=1015 suspectscore=5 phishscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310005
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 30, 2020 at 04:07:14PM +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Similar to bpf_local_storage for sockets, add local storage for inodes.
> The life-cycle of storage is managed with the life-cycle of the inode.
> i.e. the storage is destroyed along with the owning inode.
> 
> The BPF LSM allocates an __rcu pointer to the bpf_local_storage in the
> security blob which are now stackable and can co-exist with other LSMs.
> 

[ ... ]

> +static int bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
> +					 void *value, u64 map_flags)
> +{
> +	struct bpf_local_storage_data *sdata;
> +	struct file *f;
> +	int fd;
> +
> +	fd = *(int *)key;
> +	f = fcheck(fd);
> +	if (!f)
> +		return -EINVAL;
> +
> +	sdata = bpf_local_storage_update(f->f_inode, map, value, map_flags);
n00b question.  inode will not be going away here (like another
task calls close(fd))?  and there is no chance that bpf_local_storage_update()
will be adding new storage after bpf_inode_storage_free() was called?

A few comments will be useful here.

> +	return PTR_ERR_OR_ZERO(sdata);
> +}
> +
> +static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
> +{
> +	struct bpf_local_storage_data *sdata;
> +
> +	sdata = inode_storage_lookup(inode, map, false);
> +	if (!sdata)
> +		return -ENOENT;
> +
> +	bpf_selem_unlink(SELEM(sdata));
> +
> +	return 0;
> +}
> +
> +static int bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
> +{
> +	struct file *f;
> +	int fd;
> +
> +	fd = *(int *)key;
> +	f = fcheck(fd);
> +	if (!f)
> +		return -EINVAL;
> +
> +	return inode_storage_delete(f->f_inode, map);
> +}
> +
> +BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
> +	   void *, value, u64, flags)
> +{
> +	struct bpf_local_storage_data *sdata;
> +
> +	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
> +		return (unsigned long)NULL;
> +
> +	sdata = inode_storage_lookup(inode, map, true);
> +	if (sdata)
> +		return (unsigned long)sdata->data;
> +
> +	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
> +		sdata = bpf_local_storage_update(inode, map, value,
> +						 BPF_NOEXIST);
The same question here

> +		return IS_ERR(sdata) ? (unsigned long)NULL :
> +					     (unsigned long)sdata->data;
> +	}
> +
> +	return (unsigned long)NULL;
> +}
> +
> +BPF_CALL_2(bpf_inode_storage_delete,
> +	   struct bpf_map *, map, struct inode *, inode)
> +{
> +	return inode_storage_delete(inode, map);
> +}
> +
> +static int notsupp_get_next_key(struct bpf_map *map, void *key,
> +				void *next_key)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
> +{
> +	struct bpf_local_storage_map *smap;
> +
> +	smap = bpf_local_storage_map_alloc(attr);
> +	if (IS_ERR(smap))
> +		return ERR_CAST(smap);
> +
> +	smap->cache_idx = bpf_local_storage_cache_idx_get(&inode_cache);
> +	return &smap->map;
> +}
> +
> +static void inode_storage_map_free(struct bpf_map *map)
> +{
> +	struct bpf_local_storage_map *smap;
> +
> +	smap = (struct bpf_local_storage_map *)map;
> +	bpf_local_storage_cache_idx_free(&inode_cache, smap->cache_idx);
> +	bpf_local_storage_map_free(smap);
> +}
> +
> +static int sk_storage_map_btf_id;
> +const struct bpf_map_ops inode_storage_map_ops = {
> +	.map_alloc_check = bpf_local_storage_map_alloc_check,
> +	.map_alloc = inode_storage_map_alloc,
> +	.map_free = inode_storage_map_free,
> +	.map_get_next_key = notsupp_get_next_key,
> +	.map_lookup_elem = bpf_fd_inode_storage_lookup_elem,
> +	.map_update_elem = bpf_fd_inode_storage_update_elem,
> +	.map_delete_elem = bpf_fd_inode_storage_delete_elem,
> +	.map_check_btf = bpf_local_storage_map_check_btf,
> +	.map_btf_name = "bpf_local_storage_map",
> +	.map_btf_id = &sk_storage_map_btf_id,
> +	.map_owner_storage_ptr = inode_storage_ptr,
> +};
> +
> +BTF_ID_LIST(bpf_inode_storage_get_btf_ids)
> +BTF_ID(struct, inode)
The ARG_PTR_TO_BTF_ID is the second arg instead of the first
arg in bpf_inode_storage_get_proto.
Does it just happen to work here without needing BTF_ID_UNUSED?

> +
> +const struct bpf_func_proto bpf_inode_storage_get_proto = {
> +	.func		= bpf_inode_storage_get,
> +	.gpl_only	= false,
> +	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
> +	.arg1_type	= ARG_CONST_MAP_PTR,
> +	.arg2_type	= ARG_PTR_TO_BTF_ID,
> +	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
> +	.arg4_type	= ARG_ANYTHING,
> +	.btf_id		= bpf_inode_storage_get_btf_ids,
> +};
> +
> +BTF_ID_LIST(bpf_inode_storage_delete_btf_ids)
> +BTF_ID(struct, inode)
> +
> +const struct bpf_func_proto bpf_inode_storage_delete_proto = {
> +	.func		= bpf_inode_storage_delete,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_CONST_MAP_PTR,
> +	.arg2_type	= ARG_PTR_TO_BTF_ID,
> +	.btf_id		= bpf_inode_storage_delete_btf_ids,
> +};
