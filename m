Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901D9244198
	for <lists+bpf@lfdr.de>; Fri, 14 Aug 2020 01:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHMXBF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Aug 2020 19:01:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50828 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbgHMXBD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Aug 2020 19:01:03 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DMcn5k024586;
        Thu, 13 Aug 2020 16:00:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=adD/+NGa5uzD2ku4lR7ScCOmskKTZpNWN2CAKZUBo9A=;
 b=LQ9stzdnT+5XL0cBycTGbMbRoeYb34qwE3/3JdQsJ83371BkN+rJzI540OJ5NxgTlrHy
 x5MI5HtzBbCpinflkJ3pdN8/QPCdGXZkoM7tJJXxJ4clme0N2rOIN4hs2i3IN1qcV0rn
 0U4CgAYkyHN5oCjwqI3uWz3nIiDZRAHIVCs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32v0kg4kmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 13 Aug 2020 16:00:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 13 Aug 2020 16:00:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/ckvnAPJ+xByOGOJgezcoNP1DGDyrEMOlGsjaqm3LNzCl7AONGauY3CGW/yhSsVfi+pLmSW68pYjb31117BeEobXmooFaQ+a1/sqG/Rewuq/Ti4SZZBu8wyJcKrdIRCuSDEUPUu3K/ntADs2YZcxbZpTzU3/8hprmeeQxgXrp3s1NaIT5n4+1pRzq38wuJXJ/qzaKyheSeGzlX5hza91oZ8W0/Nk73KHUUzxENTqnaoSsa+vZoMfHDwgep4fej4VxUMjXIM6JKc9F28CvF9tBi6/QxDEm3XH5ULFmelKqDPhj4wLOs4s9u7Vkkgf6OQ52RyoMeEg+Li7FEpYeyVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adD/+NGa5uzD2ku4lR7ScCOmskKTZpNWN2CAKZUBo9A=;
 b=gRJ8Bb2MFtBGjqBjjDskvH+MEWca3QrS+tj2791nDRm98wi5xF5sYW33mONEz1zp4oh4Ysf5GNb4fSiUbO32DD+yRKd1rhGsxUuYA2O5YI9tgoH3KIDRDvPoXkuxUTrI58UbWZo+YNMSrn0OP5DJjcaDCP+fix2QAh/La7dbEzTMho54RqEk/+Csc6yROPrD0vgmrHoow/MdUiVsgaqb3or4PzHqp8LMAz4Wo8Rsf01g+OjmISL3Jve5VS+5NBwDXrkT8tVqILIdJyVi84cNZj9fBIKBf0z1rD7317NHBFuWH+NRaDqGVSS4PDvsDwXe4zj5abvRK6aSuDC39Dhlpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adD/+NGa5uzD2ku4lR7ScCOmskKTZpNWN2CAKZUBo9A=;
 b=H5fWxG6kKNGKSTXZ2erXZJMxDjVW0aco0pEvPbVqi6YEg2/veMFpbCUaCzGJe3MN9Hwgqu3vlXBnefTECV5tLiXZwCtcxpaFhwdDnvabqoKR5GM/OzUI+FyDM5tmG+OQJoAf/1ynARfquffi2iERVFS9TQddSn3+3oD3vC/dRm4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2263.namprd15.prod.outlook.com (2603:10b6:a02:87::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Thu, 13 Aug
 2020 23:00:57 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3283.018; Thu, 13 Aug 2020
 23:00:57 +0000
Date:   Thu, 13 Aug 2020 16:00:51 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Leah Rumancik <leah.rumancik@gmail.com>
CC:     <bpf@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <orbekk@google.com>, <harshads@google.com>, <jasiu@google.com>,
        <saranyamohan@google.com>, <tytso@google.com>,
        <bvanassche@google.com>
Subject: Re: [RFC PATCH 1/4] bpf: add new prog_type BPF_PROG_TYPE_IO_FILTER
Message-ID: <20200813230021.llbkj5ihyadcbuia@kafai-mbp.dhcp.thefacebook.com>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
 <20200812163305.545447-2-leah.rumancik@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812163305.545447-2-leah.rumancik@gmail.com>
X-ClientProxiedBy: BYAPR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::25) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:fd4e) by BYAPR07CA0012.namprd07.prod.outlook.com (2603:10b6:a02:bc::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 23:00:56 +0000
X-Originating-IP: [2620:10d:c090:400::5:fd4e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 893a1e80-6362-4019-5d27-08d83fdcbcda
X-MS-TrafficTypeDiagnostic: BYAPR15MB2263:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2263F25B8926E127D0AAE9A1D5430@BYAPR15MB2263.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Se4K2vNjZyDvVjaoD9ccwpjDzx6mfpwfMoO9CD7F9HffdHkccEz5XZyvKycRB8hFX2VRusQttJPyDCUFZZDWq//LHc0jE3eb4oKj1jYO2WbQIzRYAEoWxkMRk1VRetqa14KGgs/VGHWcNCOQQqSyUCXSWCWNrlogcNzjEQ3orMoKw9I+0sA8VS18mqTnYBZ2UB3MlQfCHPwsmIAfB4OcAyzctFik1G8hMfVKA47YipF46XIWo7eSaEHrJa4dptb9J9xaH5jjIjEbvueUD5jTgsouCNu7JcEt5BpHTekwlAP7dUsXp2slCDLs+WmmqUO6zqzBev7/pC3CFsKMsSOOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(39860400002)(346002)(136003)(396003)(8936002)(8676002)(2906002)(9686003)(55016002)(478600001)(316002)(4326008)(86362001)(66556008)(66946007)(6666004)(6916009)(66476007)(83380400001)(5660300002)(52116002)(7696005)(6506007)(1076003)(16526019)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 0eo6zD1BpmOn4c1tTxJYH3f69wTTW/akLrN49sv5WmWUpDSgyV5j60Akm1lHCuwBnWNTGX220onKg77N6IZ2lZRGg1gzVuqYVWkHYDy+VnTMwos5JbbuHjaMWKgt1ntpOzM/jIsr26l0krNqT1bk7uzGaopW7G+vlGARX71ZXtLmc/5Tk73pY4oON49y2NRcz1xItm1vfZ6PLXBn50AcBSx4klBcUUQYzkLZgcqRvPDwg+C2/OmWIH3EZB83SZU7Fd22rET4nNQLcqXiZB6ebegFSWV+WGy2+lSMbjK54pdbPYtGQRYuLdL7n+6dVrM7s6/mo2fbGIv1v9fLRqzvOLbug2dqkjcAIDzY4fwG0oeZniU9Y0d+tLLpE6y4ev1EJHKgerTGjOk9+g1PvJfgrvQYzgbSkwJ9kqUacnanvADf5KNzNntjwBI4OYfbhl7m1BxFnX1aRIy5pLuNK0FKY7Zy7pgj2DUxcaftJwvoZZJ8myqGK7UBdbo/WFCyaKJ+GtnzkzHt/fusGrKG5Tzk4kwO45KLFo/OFIR6H2AKTE5KII1fcwWHEgsd8tLh/11SbpEEJkzVohy4KvuEsTo+3ls4wL+FEIJkzhuy4h4dEgBoxKUGw/s4dIXd4ruI4KNiqn9V+D/g6xk6n5SXt4IAo99QNSDndVhzY9SEi11PuId7ZbMKDP5VnXCn/nJyIGDU
X-MS-Exchange-CrossTenant-Network-Message-Id: 893a1e80-6362-4019-5d27-08d83fdcbcda
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 23:00:56.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrjFQ5TBew07blI0YrqyQa6Bni29TVw7pFODcTde+GEJRO+xI+57A+x7eVHI6H5Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2263
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_17:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 phishscore=0 suspectscore=5 adultscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130160
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 12, 2020 at 04:33:02PM +0000, Leah Rumancik wrote:
> Introducing a new program type BPF_PROG_TYPE_IO_FILTER and a new
> attach type BPF_BIO_SUBMIT.
> 
> This program type is intended to help filter and monitor IO requests.

[ ... ]

> +#define BPF_MAX_PROGS 64
> +
> +int io_filter_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +	struct gendisk *disk;
> +	struct fd f;
> +	struct bpf_prog_array *old_array;
> +	struct bpf_prog_array *new_array;
> +	int ret;
> +
> +	if (attr->attach_flags)
> +		return -EINVAL;
> +
> +	f = fdget(attr->target_fd);
> +	if (!f.file)
> +		return -EBADF;
> +
> +	disk = I_BDEV(f.file->f_mapping->host)->bd_disk;
> +	if (disk == NULL)
> +		return -ENXIO;
> +
> +	ret = mutex_lock_interruptible(&disk->io_filter_lock);
> +	if (ret)
> +		return ret;
> +
> +	old_array = io_filter_rcu_dereference_progs(disk);
> +	if (old_array && bpf_prog_array_length(old_array) >= BPF_MAX_PROGS) {
> +		ret = -E2BIG;
> +		goto unlock;
> +	}
> +
> +	ret = bpf_prog_array_copy(old_array, NULL, prog, &new_array);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	rcu_assign_pointer(disk->progs, new_array);
> +	bpf_prog_array_free(old_array);
> +
> +unlock:
> +	mutex_unlock(&disk->io_filter_lock);
> +	return ret;
> +}
bpf link should be used.
netns_bpf_link_create() can be used as an example.

[ ... ]

> +int io_filter_bpf_run(struct bio *bio)
> +{
> +	struct bpf_io_request io_req = {
> +		.sector_start = bio->bi_iter.bi_sector,
> +		.sector_cnt = bio_sectors(bio),
> +		.opf = bio->bi_opf,
> +	};
> +
> +	return BPF_PROG_RUN_ARRAY_CHECK(bio->bi_disk->progs, &io_req, BPF_PROG_RUN);
> +}

[ ... ]

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 8bd33050b7bb..4f84ab93d82c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -189,6 +189,7 @@ enum bpf_prog_type {
>  	BPF_PROG_TYPE_STRUCT_OPS,
>  	BPF_PROG_TYPE_EXT,
>  	BPF_PROG_TYPE_LSM,
> +	BPF_PROG_TYPE_IO_FILTER,
>  };
>  
>  enum bpf_attach_type {
> @@ -226,6 +227,7 @@ enum bpf_attach_type {
>  	BPF_CGROUP_INET4_GETSOCKNAME,
>  	BPF_CGROUP_INET6_GETSOCKNAME,
>  	BPF_XDP_DEVMAP,
> +	BPF_BIO_SUBMIT,
>  	__MAX_BPF_ATTACH_TYPE
>  };
>  
> @@ -4261,4 +4263,13 @@ struct bpf_pidns_info {
>  	__u32 pid;
>  	__u32 tgid;
>  };
> +
> +#define IO_ALLOW 1
> +#define IO_BLOCK 0
> +
> +struct bpf_io_request {
> +	__u64 sector_start;	/* first sector */
> +	__u32 sector_cnt;	/* number of sectors */
> +	__u32 opf;		/* bio->bi_opf */
> +};
Is it all that are needed from "struct bio" to do the filtering and monitoring?
Please elaborate a few more specific filtering usecases in the comment
or even better is to add those usecases to the tests.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 94cead5a43e5..71372e99a722 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2613,6 +2613,7 @@ static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
>  	case BPF_PROG_TYPE_LWT_SEG6LOCAL:
>  	case BPF_PROG_TYPE_SK_REUSEPORT:
>  	case BPF_PROG_TYPE_FLOW_DISSECTOR:
> +	case BPF_PROG_TYPE_IO_FILTER:
Why it is needed?

>  	case BPF_PROG_TYPE_CGROUP_SKB:
>  		if (t == BPF_WRITE)
>  			return false;
