Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AB5200235
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 08:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgFSGxG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 02:53:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63044 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729080AbgFSGxF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Jun 2020 02:53:05 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05J6nxiZ005477;
        Thu, 18 Jun 2020 23:52:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=bie15nvi9rsI89oMh1sEXLatClZXGjvhJQyETXL+ml4=;
 b=U6MtzxlEAzAg37J/ak3hf7rbuCvioaZ6/N31b8BW3+VHd4xdY1Gq8R47UkGM+tHJPZNA
 V5fUTGPkDWC9ogZHPE8b4thZ/jToectjwSBjObMvVIMOIVHWo6dGUy9i4eopxveRZwOy
 gbaizlbDMzoUDL/j8kQM336QDknoPKDdyds= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q653rfex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 23:52:49 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 23:52:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kM18sheFNH8B3tNNVJ4vIqZIB0HtKNIFhoaFfp1bn10y+pVnHtF7vm0g2eSjsPP4xtBmldIuLVTLBlZr2qtU8MijW11fy5kQihTnn7KtlULw09fmBrWFhOSxskTCNF2pMHnONSamqV1zxALudsO498n3i8N9LZciQQQ5/Vuj955I9M/gp56c5ViyBEaoKNAMhu+fv4afUei4j7l62TPuQ2l9IEP3Wu/EMylbZZYgaHnamk1HbL0sBPNk40VJN4yVSy1g5eZ/zrYXyLVujIvWb8Bvh300pglhjqZwyUsk5S9ULxybpCIG6Q70CD7Ccl5Zt8U4hoLnrCbGpsVp7mvoQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bie15nvi9rsI89oMh1sEXLatClZXGjvhJQyETXL+ml4=;
 b=VoeZCj3c6bWX0oWwZ46cfKMKOL/LRZ0lGlvu5ANDpSqbOZ3H9RGpLedPSwk3uq5k36IZL1MGHmENOnFm78GXq8axDwENm4rfXynJGEnsLBrYBebTz/PSNzvWvr5S7R2dVYLEpmxvasbcSjxbc4nrv329zFvJGVMOYgWETtcO5KWIi7PvfkPyubntbaZbIlY6uQEGl7HYMOVK882mKD74Ol6WkD5ml4PdTxiszvQfzXbrQZsexieV6YNeDwz1XQZ0AwNO/iMTz1e0HFLyUEqGZovv11m2CrhDYpClWpteFaBgXdSAcRgzLJXu8RjyFaPL8p7gb/nPO6J0GdIvC7MsVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bie15nvi9rsI89oMh1sEXLatClZXGjvhJQyETXL+ml4=;
 b=JBINiprteyl17cBlJMiySAWFqJjzt6k8EefXq6JqWPJgzIY/GTIWrIQPvOzk9MGoBg3ayhMm9bPqQkwdZfcvJR4DAIYUhzbCkcc53YGzeZGNYG0extzW4CHQi+A8rnWGY9e7Rd+M8oAixTSz4ZofOtsVOKVsC7esfI+KCjVmV4g=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2376.namprd15.prod.outlook.com (2603:10b6:a02:8c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.20; Fri, 19 Jun
 2020 06:52:47 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::b00c:d8f:2544:f92f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::b00c:d8f:2544:f92f%7]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 06:52:46 +0000
Date:   Thu, 18 Jun 2020 23:52:45 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Implement bpf_local_storage for
 inodes
Message-ID: <20200619065245.t755bkffk6zleoi2@kafai-mbp.dhcp.thefacebook.com>
References: <20200617202941.3034-1-kpsingh@chromium.org>
 <20200617202941.3034-3-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617202941.3034-3-kpsingh@chromium.org>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BY5PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:180::14) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:7c9) by BY5PR13CA0001.namprd13.prod.outlook.com (2603:10b6:a03:180::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.10 via Frontend Transport; Fri, 19 Jun 2020 06:52:46 +0000
X-Originating-IP: [2620:10d:c090:400::5:7c9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3faec788-27a4-407d-3ea5-08d8141d5faa
X-MS-TrafficTypeDiagnostic: BYAPR15MB2376:
X-Microsoft-Antispam-PRVS: <BYAPR15MB237654181EF9EE109B27F79DD5980@BYAPR15MB2376.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UfF41qVzrAgo4tnlU4YyBgUDpiAj/4z6V7Y8bNvsf9323kx2f439EN4h3LNpByR9xL2ZaIXIaWpO9rcm7byTlQhnkqGd5FF1EAgZGV2/vypUraeGos/CagZPfF73A/LaqaZWqde0J7JawBNObiG4prwfC5RJsff2ZlPjTTp6u9GqKNMh/OzrBlNsb8gOskli8mJbxbxLRcVsYV0QZ/p/NIAxvh6KCPioY/yXWxngMVr+xK4t+vLuiC3cMfV70SY7wfYv2tb4sRBnxDfQ/mUjvzJ/hS1Y7nPkk6gNmg8peFQZPBUyF98rbQay9DQtUT7YaF/xlucTEn+dX05jNxp5Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(136003)(39860400002)(376002)(396003)(16526019)(186003)(66556008)(8936002)(6506007)(2906002)(316002)(8676002)(54906003)(7696005)(52116002)(66476007)(66946007)(6916009)(1076003)(4326008)(86362001)(5660300002)(55016002)(478600001)(9686003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2x/+Z+R8+uJEdzWAPLyEWrmarY3pj9/ZalViWekQhh/bVzD+HnJOBf/xfZ+39OjbNLagyDuElfEJp3ryzceRG/Ejyg4OdXTACq9CfgoYXEcBTEU6hICaDurrldqB5lAL2yGQUDgWeE86m74sqWKZqnHIau0pwb6+RbhCNiuHJzncPheAi0h4VH54QDjwRidGgsIQmF6wJRX/ONCT1xyFd2aNBWO0+PUE4Gw4uubY3fpKBOPdDK+2pIMk6As8lpAj4wl2aXBVdGtu1pJtd3wAvgTGGqDIp3iJVgloRNg0OOOvCvXPNcZCqXu8HmOqV3fFbE9mJpxzooyssYlEfrF6sLZBojAfjXBuM5UARPF0luZOSF04hU/zyHNwOb6D9IPfJeNSw+vkGLysxpPyM802z5W6K27MVk+4FM4FWVSpLpOZlKSbKJ/lEOA9X4QgLoqpEbeV/vCFDLE/RPRNx3wHbV7UW6VlNC0ECagMUhyGKjQlATMfM94Ey9gev8buFGckFL+SpAJjMM75hvDKQIDEDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3faec788-27a4-407d-3ea5-08d8141d5faa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 06:52:46.8272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QY64uEHT35yr37jTaLF14UI9yjSi3xyMIKY/hCiTdr5jRq50RuR03zBJuPwmmYX4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2376
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_04:2020-06-18,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190048
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 17, 2020 at 10:29:39PM +0200, KP Singh wrote:
[ ... ]

> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index af74712af585..8efd7562e3de 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -17,9 +17,24 @@
>  #include <linux/lsm_hook_defs.h>
>  #undef LSM_HOOK
>  
> +struct bpf_storage_blob {
> +	struct bpf_local_storage __rcu *storage;
> +};
> +
> +extern struct lsm_blob_sizes bpf_lsm_blob_sizes;
> +
>  int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>  			const struct bpf_prog *prog);
>  
> +static inline struct bpf_storage_blob *bpf_inode(
> +	const struct inode *inode)
> +{
> +	if (unlikely(!inode->i_security))
> +		return NULL;
> +
> +	return inode->i_security + bpf_lsm_blob_sizes.lbs_inode;
> +}
> +
>  #else /* !CONFIG_BPF_LSM */
>  
>  static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> @@ -28,6 +43,12 @@ static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline struct bpf_storage_blob *bpf_inode_storage(
This does not seem to match the newly added "bpf_inode()"
above for the "CONFIG_BPF_LSM" case.

A typo?  May be a good idea to test compiling with !CONFIG_BPF_LSM.

> +	const struct inode *inode)
> +{
> +	return NULL;
> +}
> +
>  #endif /* CONFIG_BPF_LSM */
>  
>  #endif /* _LINUX_BPF_LSM_H */
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index a18ae82a298a..881e7954c956 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -101,6 +101,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_HASH_OF_MAPS, htab_of_maps_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_DEVMAP, dev_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_DEVMAP_HASH, dev_map_hash_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_SK_STORAGE, sk_storage_map_ops)
> +BPF_MAP_TYPE(BPF_MAP_TYPE_INODE_STORAGE, inode_storage_map_ops)
sk_storage is under CONFIG_NET.

inode_storage should be CONFIG_BPF_LSM?

>  #if defined(CONFIG_BPF_STREAM_PARSER)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKMAP, sock_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKHASH, sock_hash_ops)
