Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58ACB46E0A2
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 03:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhLICDb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Dec 2021 21:03:31 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19612 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229583AbhLICDb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Dec 2021 21:03:31 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8H2cLO031320;
        Wed, 8 Dec 2021 17:59:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=xRJqtOCA36EHspePppSOpAnwHw2Xgsvg0Gy6s2xhh7o=;
 b=PcxLWt4QJzHD0xIBbdWRmxB9YVZeSFQjJ5j8uvipduNn0+z0KjzJA64OO2RGrud4KPVi
 btKBvZjpzaq6cgSNSD8SdT+PR28I7coKS0DGVJjavIJ+sXolaOlWRs551y3BOrJMSHDX
 uwAJCu5Lw0CtHRxOmy5b/UfeKTiNZmdl0qg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ctn5rya51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Dec 2021 17:59:44 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 17:59:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lfh71L+kaUIk8CZcsqvE/M+jHSj6lOkkd2F+2da76wyRQ9SzrXyHXuASM9QIq5x7/i0zjYIrpbTyRK6AwXHiAjX9wb2om6j4fm8LqepTLjWyBtmvb95luoTK3EgsR0+ZmSVp6zH+i8L7KTOxr8zB0S4m4Ry/Snjdem6mwOpdbrFY/FbqGen4XH1mdJE+KkpfdDFJZY0i7zRyHbkYaRz1saCgXNrwN6lhNKWT2epSLcRFZSRMN/u5dG+IDbRrLmGj3wbAJkiBuj8BwJsotBak8/22srhPXv4+vrANhOrNOrGthzbaz3VcSWawMQ1iolMHQVD7JahRA6eQNASn7ydsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRJqtOCA36EHspePppSOpAnwHw2Xgsvg0Gy6s2xhh7o=;
 b=NLI41eyO5JgZzdvBLhG7D683GZIYXBnKv+1DUal1XBxa4Hw9K1tcOibgRycNv03pTuO1ZYuW7OZjESjQMEpUVqrOirrVH26jLBYGWguD50PaJHRva3Ml25EsvM+6Y41kUGbYqSHY+AZI3rUgbKIQ72QLlH//LGcuADbk8FzLbbLHlnYA85UU6CTDQ2K3RDas9obo8wwh29ZiKpuB1MsVIBZ/Iuv3W2vADRToRzhcDMH6eFByi8DBeq+rEn0FC0FPgljiQgzMqLIpl2348dSwuT+8fUxNqRCMXEKSWpP7YfsAUX8h62vH9f33isxBV5aSykImqX/SvWFMiKE+fBKYlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN6PR15MB2463.namprd15.prod.outlook.com (2603:10b6:805:18::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 01:59:42 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::e589:cc2c:1c9c:8010]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::e589:cc2c:1c9c:8010%7]) with mapi id 15.20.4755.022; Thu, 9 Dec 2021
 01:59:42 +0000
Date:   Wed, 8 Dec 2021 17:59:38 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Allow bpf_local_storage to be used
 by sleepable programs
Message-ID: <20211209015938.s2f4wmjtiqagjwqy@kafai-mbp.dhcp.thefacebook.com>
References: <20211206151909.951258-1-kpsingh@kernel.org>
 <20211206151909.951258-2-kpsingh@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211206151909.951258-2-kpsingh@kernel.org>
X-ClientProxiedBy: CO2PR04CA0186.namprd04.prod.outlook.com
 (2603:10b6:104:5::16) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:9be9) by CO2PR04CA0186.namprd04.prod.outlook.com (2603:10b6:104:5::16) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 9 Dec 2021 01:59:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbd3f3b3-a3a3-49e8-8d01-08d9bab790ca
X-MS-TrafficTypeDiagnostic: SN6PR15MB2463:EE_
X-Microsoft-Antispam-PRVS: <SN6PR15MB2463CCC0D9C299ACDB5CE1B3D5709@SN6PR15MB2463.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JO41V4sO6IeguijOvA5ojSCJB6hC36rFN2sqcZLHHjiYF6ENEwiMusxL1UavcSbMZVzFZIxEF5kfTRcn9IW7XlWkXx6INdcye9MsAD4i7W4G1JQk0FiK46FqwPpuEU7O6T95/jB6POjvyHG64rAZ9AZgxysdkQKUJtM2UkCThvpCbsZaNPfAe68prWUMbscNBXhZ4V3oJNO1m25Id/UsJ5nhYJt0vshj0jsA+ed/6C4edQtrXGnHvs0B4XGLp+eLzNmgUvWzJ0g0efaCzyFfrrOm1yJvXT6nVtTG52NENiYhqEnXzVJGMuctDsKgNDCPepjAU3LKwNdsMgUhuFW6PhrzpQe2XH3n7DYTqmLS+vMsGUOMR92LcmYEsFjLnTix2lPRV9p3lcxDihKDZiy2Esv+m+rDnujpOzHsvhwrydVcPIPaXPcdSJ/S3fLLYCjZ48zcrPScHszpg8HnuoRD+2Gfy2L91AsaQJHYCT+NjWkgJxbAfeUvH1s975wa/w3riOmAVnN64OK5PmU6j7prOhgyydSCksY7r9dKFS0PGpUh4JibjThK4ojcDNDLAnUcBIaGY4KBnbJrWm8/8Ftopv5oKn4ddOCcAlaEP+HuVAwprHMtP29mdoaSnlVzAdy7curTjtwIkksQ891j0nDx3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(86362001)(6506007)(5660300002)(7696005)(55016003)(83380400001)(186003)(38100700002)(508600001)(8936002)(52116002)(6916009)(54906003)(1076003)(4326008)(2906002)(316002)(66476007)(9686003)(66556008)(8676002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0acuH5tv250W1hnFV7Eaptu1A9RqdtnKAo8qaAPZ0yJFM4o7ZTzVc1Q2ENrR?=
 =?us-ascii?Q?0V8cBrwmCYfJyyRQskVgig79nWOOGy6RNvRv3b2H2awI5LWsTHdP2CYVimL8?=
 =?us-ascii?Q?QVwWbXzgE2n8uH0UyEvgykDTl62J2Jcez07+29aW66f2Ud50wFUe6i4fYIAG?=
 =?us-ascii?Q?Ep2WyIEnSlW6zLTQTrJlAfD/kqg2G9P2NpiPbUrVAD5JdQ+VjxyjEJO+5a5V?=
 =?us-ascii?Q?2uYtphtMPcpQaPK8W0vWaLKVzXw5AXrUofVLY3PJHnhQlBqMfcKQ0A1hLpP7?=
 =?us-ascii?Q?+O+Vv2w9LtErUlklCBVORuMN6QYUMJ5LjRzLqkVaXMo8oSOH6sB4yWAndouy?=
 =?us-ascii?Q?K2zbaKsSG/ufz1i2RsLfJ3FUQHPL15Ach4BlqZkqkqRMrfF4qJYIpkl49oE+?=
 =?us-ascii?Q?xOxj7XfCeOI5/ssPOj/+hUUAXZtAHzBiF23EiG/yx0TROQIB3IQQRlzvjH4E?=
 =?us-ascii?Q?UnUWlETMg3dqxy+45rXv8K00iXraQb8V7DEPNrKPn+YmAr1Rj+XUh8Wtt/Z1?=
 =?us-ascii?Q?l59nAZtizR+1VLyHk1scNIkFG0MCR7KPabNMynwlMXOf9MxFLBO/x8oZTEZG?=
 =?us-ascii?Q?m2mXkcX+ei3CrZznb//Nneblq9McQErdPT95diMmNQxaTrd7BG1Q1JBNCJOH?=
 =?us-ascii?Q?eY5qqaflIOlOmZmyAqe/O7hnN7HqbdIoPBa0l8wpO2SaOgIvxZNZh4kEJQpE?=
 =?us-ascii?Q?6hPT+WhpIFvTbezGlh68idO1ke4s85Ji2w4+NpH2SlPrGrzf+rJsiAu0IKAA?=
 =?us-ascii?Q?drB8DDjD4nqwjr+RAewfwxWo/npwS775mHEdTGxTEpTNCCwoeaFGO0SWjIeB?=
 =?us-ascii?Q?yoPfne/RY+YGX124HaGJekfZW0nGU51DE7KC4nPB+fXbUl4wsdIgy2m+Hi0t?=
 =?us-ascii?Q?IYsAvEf9oWATmGFUXe5iS9rWUZdq0aXt9bwGAmmykZcDsQpSKYmjfhiqgi9A?=
 =?us-ascii?Q?/ywaz698wJa4/Q/ry8h6wsmRmg5PkgirtO82VQEskXQx67u0EDTjMM6TqqRf?=
 =?us-ascii?Q?RvvF0ITSYtiea72ozVDJkSprKQm2SSTa9yukxjgDCn6YClMwc+Y2NTidW6JF?=
 =?us-ascii?Q?ZZYAw7UmJa7qXQEAnCQcJP8gQOaIohPrladoQCg1y2hgrY9mv9PLELYbXm5O?=
 =?us-ascii?Q?RHziphCq7hvEmVKQdGLFHTi7cpRB2ArumGkwDBq9h9sIRh5pu9AlO5WGDMa/?=
 =?us-ascii?Q?lbfyZSB1SqlcKH/6YpG/L/76vzTGoNOCJ+Og174XQuJo+6FGKppvN5+hLuNf?=
 =?us-ascii?Q?Q1FroUxXzeEkWmP6mmZe6F8c5HvxMACqFhSid7dzx65FD9COZzWLoPdnyo45?=
 =?us-ascii?Q?FABYXdqLNcNBUDEvvgo7egiqmq/ZYNCgAdXp1Lmpa4f5xjNqNXvXIfGIoL00?=
 =?us-ascii?Q?TPSgRBvruLw4/HiAWYE03WN37fayjXQ7x84zmhX6Q8rdg9FHBfqPF7qx3eNv?=
 =?us-ascii?Q?91jKcPPuhqeg/JI+Js1do63NqmO8y9/s0Y5slGmd017hAjBxy7k0NAiQip7W?=
 =?us-ascii?Q?ZoYZFVVFNSme6y4+MoDnF0bxbT3IJy5oTZ/wyl5oRcJ0nqyhMfrj0DQjbxmi?=
 =?us-ascii?Q?JdmMHrmw5zriI8AR79R1Ahjsrw4vggkvCvTUTN+t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd3f3b3-a3a3-49e8-8d01-08d9bab790ca
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 01:59:42.3119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmtbymQjL8Uzl/iO0w6enkqo00K7xjFIMZl5YQPIA0Sd+rqEtLsNVS5dqnsXAy7H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2463
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: SqEzQr-b_h7Z8_2V2vMZC3J3kPsWN-gV
X-Proofpoint-GUID: SqEzQr-b_h7Z8_2V2vMZC3J3kPsWN-gV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_01,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=716 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112090009
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 06, 2021 at 03:19:08PM +0000, KP Singh wrote:
[ ... ]

> diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> index 96ceed0e0fb5..20604d904d14 100644
> --- a/kernel/bpf/bpf_inode_storage.c
> +++ b/kernel/bpf/bpf_inode_storage.c
> @@ -17,6 +17,7 @@
>  #include <linux/bpf_lsm.h>
>  #include <linux/btf_ids.h>
>  #include <linux/fdtable.h>
> +#include <linux/rcupdate_trace.h>
>  
>  DEFINE_BPF_STORAGE_CACHE(inode_cache);
>  
> @@ -44,7 +45,8 @@ static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
>  	if (!bsb)
>  		return NULL;
>  
> -	inode_storage = rcu_dereference(bsb->storage);
> +	inode_storage =
> +		rcu_dereference_check(bsb->storage, bpf_rcu_lock_held());
>  	if (!inode_storage)
>  		return NULL;
>  
> @@ -97,7 +99,8 @@ void bpf_inode_storage_free(struct inode *inode)
>  	 * local_storage->list was non-empty.
>  	 */
>  	if (free_inode_storage)
> -		kfree_rcu(local_storage, rcu);
> +		call_rcu_tasks_trace(&local_storage->rcu,
> +				     bpf_local_storage_free_rcu);
It is not clear to me why bpf_inode_storage_free() needs this change
but not in bpf_task_storage_free() and bpf_sk_storage_free().
Could you explain the reason here?

> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> index bb69aea1a777..1def13ad5c72 100644
> --- a/kernel/bpf/bpf_task_storage.c
> +++ b/kernel/bpf/bpf_task_storage.c
> @@ -17,6 +17,7 @@
>  #include <uapi/linux/btf.h>
>  #include <linux/btf_ids.h>
>  #include <linux/fdtable.h>
> +#include <linux/rcupdate_trace.h>
>  
>  DEFINE_BPF_STORAGE_CACHE(task_cache);
>  
> @@ -59,7 +60,8 @@ task_storage_lookup(struct task_struct *task, struct bpf_map *map,
>  	struct bpf_local_storage *task_storage;
>  	struct bpf_local_storage_map *smap;
>  
> -	task_storage = rcu_dereference(task->bpf_storage);
> +	task_storage =
> +		rcu_dereference_check(task->bpf_storage, bpf_rcu_lock_held());
>  	if (!task_storage)
>  		return NULL;
>  
> @@ -77,7 +79,8 @@ void bpf_task_storage_free(struct task_struct *task)
>  
>  	rcu_read_lock();
>  
> -	local_storage = rcu_dereference(task->bpf_storage);
> +	local_storage =
> +		rcu_dereference_check(task->bpf_storage, bpf_rcu_lock_held());
This change is unnecessary.  There is a rcu_read_lock() above.

>  	if (!local_storage) {
>  		rcu_read_unlock();
>  		return;

