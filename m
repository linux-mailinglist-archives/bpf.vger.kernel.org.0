Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617B222176C
	for <lists+bpf@lfdr.de>; Wed, 15 Jul 2020 23:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgGOV6M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 17:58:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54914 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726370AbgGOV6L (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Jul 2020 17:58:11 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FLsNKE025832;
        Wed, 15 Jul 2020 14:57:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=WXxjhYYHs2uvaqOOltD7ZeIAJl7XQaF4tF7W6uO/ASk=;
 b=rp3vO2RMA6G9cOIe8wtRHrp9H4Vv6766tKtfAhcRSa1cDejBRxlxrlGa8tYiutG/Etkc
 T9mQwDjuyoUMsn1lijwaDFm+0wfQmofTlmkOAB+CRrnvRpBwHoQ8AFSiOn785kxxAk9q
 H9lu9vs3NwCjrakfh/6Qwn9n5ypI26CvTwQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 327wdrt0mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Jul 2020 14:57:55 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 14:57:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iefDx+E7ABWk5aUr4pOVoJ+LKmkLELITi/g6SJbyNLIhLZdVtJ22WfFp0O9KIJ0cA4Ri6w/Pd8m6J8/1eTATF78AnSZ/6DZBTjXJh7YKVQDTQ3gHhepUw3o/B4s/zT+6oiQI/ZPcUAI/yw4Gw3o3K7KDg7+ldq87aAC9EQS2CGd2wIHOR+udJ+MktKaB9aR0wGNxoXsoV8LNq0cgXuGwdSV9SfknR4os6Xppk8mu1rSK0HXSQ2sruGf7oIMD41Gwnez8jgEdOXVrnmUSicNM63UGIzknHKqcqO95ZozXicD6KfVBDUamobJcCluiCKoprotp0AGctjL1ooSESfywaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXxjhYYHs2uvaqOOltD7ZeIAJl7XQaF4tF7W6uO/ASk=;
 b=cpwT7StQe6+KmFo7D2nOHunPsoMJkNeMDMLUi1FnAraHr3JGUwuGZKhjL2k3YIXQ9+M6ObAY8vXcbx2I/IOFfafGhFtLAYsSpQsOOhC4wEI/XwahTFKnTbv9GRjoj9s0bMmpzqyHIuYEZ8qPdJL0HymaqR/n1k7KdA3Qfqp8xqpCoURGfsqqmlYn+Wk8AV98LTvfIELLlG+pFQ8jtcABxTenz4YwkAjljokzDgcpJpC0CMXry5cNzV/JyiDqs+SfnkaJbGrfmcEPYKKYF06HiCOolkNVnbiBNMNEf5zCOCvnVHGYYiLt10VF2hd0edGUqO//C1SwqggmWDKJT8FG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXxjhYYHs2uvaqOOltD7ZeIAJl7XQaF4tF7W6uO/ASk=;
 b=La8OBjjXmgSaaZsFrY1eVKvst56qTLlyEifibR2RMpTdcgMcbZ7BrIyaCbmTeElLFE68/R2PvVxzY2/NaXINoYirAyfaQCGYgyZfI5ROr11tyB+EKWeENx5SQh/X6KKzoUFx3ybP4Rv48/1F4BofnGjwW3NYnbbCE3lA3DTihh8=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3302.namprd15.prod.outlook.com (2603:10b6:a03:10f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Wed, 15 Jul
 2020 21:57:53 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3174.026; Wed, 15 Jul 2020
 21:57:53 +0000
Date:   Wed, 15 Jul 2020 14:57:51 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Implement bpf_local_storage for
 inodes
Message-ID: <20200715215751.6llgungzff66iwxh@kafai-mbp>
References: <20200709101239.3829793-1-kpsingh@chromium.org>
 <20200709101239.3829793-3-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709101239.3829793-3-kpsingh@chromium.org>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::24) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:5ec) by BYAPR03CA0011.namprd03.prod.outlook.com (2603:10b6:a02:a8::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Wed, 15 Jul 2020 21:57:52 +0000
X-Originating-IP: [2620:10d:c090:400::5:5ec]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53228ed2-a151-4178-818d-08d8290a1f7f
X-MS-TrafficTypeDiagnostic: BYAPR15MB3302:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3302173FDFDFF84C8FE9E37BD57E0@BYAPR15MB3302.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rkwoy2j2Dqh7bDo/7zPxIsfEZn8/jZq6Ok/7L+5BG7kmNIgzZu4OlOIaltLxt6VbX3GKgggMYPsuIysmaPkn++0GaeB0Mdg0A7ICounkH5vP0Gct9NNCzevZ8Dm0X2YvgJGO11IJ8Ne0swsAB0qaV22z0VCw/9wGXhPncqtAGGscKbzIqB9HV3tlZfwaUHbr8slR5Uo27jSX6bPquz7JdEscPSdQ23FG0gz9SD04HqV2OcQDlphTw8E/CIJK5rk8YCfI0dvc0x7+xgR9IHZCnd242DJuWwieZNzrcqWRJyf0wTJqmrRxFxNkxcvqAIaj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(376002)(366004)(136003)(39860400002)(33716001)(16526019)(6496006)(66476007)(52116002)(66556008)(8676002)(66946007)(6916009)(55016002)(186003)(2906002)(5660300002)(478600001)(86362001)(1076003)(4326008)(83380400001)(9686003)(8936002)(54906003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: RSftEDidlj8JSHfFPGhw1971hlgUmR8XFPJ8VZT5VkY1fkoDiIJ9yOVGTgoNkg6WpONa05YIwe0tbRTXlJAN9M59TeJNixbaw2vwM5NLXGOzdN6NwkXke3naayNCkE+HODdlwENhu1HxLkOHGloE9IP/XAfzLXFFLL+5VHI6kgs8q5LboTF9fvh23PURhF1TOLWaHTUbg10/YoH3zonl1GCHYDk1+QgWcYfvQEeW6XJG+yMy0LyI5ibOha7GDnTdlCyi5eIWA7wjgUQD3sqXh3hahM9gqVAC/yE3qTO93iUFEyHTW4tziP+yKEBHhv+KCHW1HMEP2fCS9MSLCt9JVZ97LqNplyqoVC7wD015Ve+V2alte0c9or/WK7TppwJ6fseWiA9YIZFHtkbKiMYVWPIBazPaIyZIuRJPLJ4GGv99PEE2CdcbYexB1OyMBgOEnl6joaqFsklHrn6mi9tPALsGvQUbYVHrV7sSCmEQGWxIlQt7HGTE+In8riTb4BzqBa9PQkuweO01p7GFyANRxw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 53228ed2-a151-4178-818d-08d8290a1f7f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 21:57:52.9166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6YOUTlZi2+0gtntqdl59DWWr8NpT8HgM90FACht9Q899jJxO7XR4opesewUxwuS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3302
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=2
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=485 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150163
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 09, 2020 at 12:12:37PM +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Similar to bpf_local_storage for sockets, add local storage for inodes.
> The life-cycle of storage is managed with the life-cycle of the inode.
> i.e. the storage is destroyed along with the owning inode.
> 
> The BPF LSM allocates an __rcu pointer to the bpf_local_storage in the
> security blob which are now stackable and can co-exist with other LSMs.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>

[ ... ]


> +static void *bpf_inode_storage_lookup_elem(struct bpf_map *map, void *key)
> +{
> +	struct bpf_local_storage_data *sdata;
> +	struct inode *inode;
> +	int err = -EINVAL;
> +
> +	if (key) {
> +		inode = *(struct inode **)(key);
The bpf_inode_storage_lookup_elem() here and the (update|delete)_elem() below
are called from the userspace syscall.  How the userspace may provide this key?

> +		sdata = inode_storage_lookup(inode, map, true);
> +		return sdata ? sdata->data : NULL;
> +	}
> +
> +	return ERR_PTR(err);
> +}
> +
> +static int bpf_inode_storage_update_elem(struct bpf_map *map, void *key,
> +					 void *value, u64 map_flags)
> +{
> +	struct bpf_local_storage_data *sdata;
> +	struct inode *inode;
> +	int err = -EINVAL;
> +
> +	if (key) {
> +		inode = *(struct inode **)(key);
> +		sdata = map->ops->map_local_storage_update(inode, map, value,
> +							   map_flags);
> +		return PTR_ERR_OR_ZERO(sdata);
> +	}
> +	return err;
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
> +	bpf_selem_unlink_map_elem(SELEM(sdata));
> +
> +	return 0;
> +}
> +
> +static int bpf_inode_storage_delete_elem(struct bpf_map *map, void *key)
> +{
> +	struct inode *inode;
> +	int err = -EINVAL;
> +
> +	if (key) {
> +		inode = *(struct inode **)(key);
> +		err = inode_storage_delete(inode, map);
> +	}
> +
> +	return err;
> +}
> +

[ ... ]

> +static int inode_storage_map_btf_id;
> +const struct bpf_map_ops inode_storage_map_ops = {
> +	.map_alloc_check = bpf_local_storage_map_alloc_check,
> +	.map_alloc = inode_storage_map_alloc,
> +	.map_free = inode_storage_map_free,
> +	.map_get_next_key = notsupp_get_next_key,
> +	.map_lookup_elem = bpf_inode_storage_lookup_elem,
> +	.map_update_elem = bpf_inode_storage_update_elem,
> +	.map_delete_elem = bpf_inode_storage_delete_elem,
> +	.map_check_btf = bpf_local_storage_map_check_btf,
> +	.map_btf_name = "bpf_local_storage_map",
> +	.map_btf_id = &inode_storage_map_btf_id,
> +	.map_local_storage_alloc = inode_storage_alloc,
> +	.map_selem_alloc = inode_selem_alloc,
> +	.map_local_storage_update = inode_storage_update,
> +	.map_local_storage_unlink = unlink_inode_storage,
> +};
> +
