Return-Path: <bpf+bounces-2255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411FA72A330
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 21:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBB7281A22
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 19:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ADB20683;
	Fri,  9 Jun 2023 19:35:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7AD1800E
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 19:35:59 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93372D44;
	Fri,  9 Jun 2023 12:35:57 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359JGqJQ012298;
	Fri, 9 Jun 2023 19:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Y0ujg9aOXTZyHj+DvN6KuOtO3okoMAH+tLdcdj97GkA=;
 b=tfp4COfNj/vOt+kJRYllS+GzyaQg3IGzSQ0OX8XVEm5mzuQJjyEYK8qKDjCqSzzg9qHM
 KSE/u13U4cFj5rWVNi6LoFgyv2kIX32ZqkYlzS9gZbXEVzRGuvCM17T5MhV0i+y5eYER
 n3eU1G6lRjglbkRjhqxOXk6RwSoS/tEdevywbzL5I8Frs6HqIjwftPFc4AhIYBn+T6Me
 E31E80A3Lp0e43cJYVcTnINR1DBrbnwOR7fjNjuxZEaJtREWS0rTu+WUnTRb4VDWM2Yu
 f/c4h4k6IsXkCEeLpihSVEoij2lMBeXWhD2ZKIygwLQnAJB1PsAhGe1db4aU8aFwiOCB YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r4a3rgc9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jun 2023 19:35:25 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 359JN2fK005410;
	Fri, 9 Jun 2023 19:35:25 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r4a3rgc8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jun 2023 19:35:25 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
	by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 359I0J1L022047;
	Fri, 9 Jun 2023 19:35:23 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
	by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3r2a7877ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jun 2023 19:35:23 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 359JZMNX63832338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Jun 2023 19:35:22 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 962415805D;
	Fri,  9 Jun 2023 19:35:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B6AD5805F;
	Fri,  9 Jun 2023 19:35:20 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.47.53])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Jun 2023 19:35:20 +0000 (GMT)
Message-ID: <5f8d8e67a7803ede8847d30ffe3204723b4ac7a7.camel@linux.ibm.com>
Subject: Re: [PATCH v11 2/4] smack: Set the SMACK64TRANSMUTE xattr in
 smack_inode_init_security()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 09 Jun 2023 15:35:20 -0400
In-Reply-To: <20230603191518.1397490-3-roberto.sassu@huaweicloud.com>
References: <20230603191518.1397490-1-roberto.sassu@huaweicloud.com>
	 <20230603191518.1397490-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FCgk3rjaKMOBhScgfSMfj6JgJR_VTDAy
X-Proofpoint-ORIG-GUID: dyexbh4t4OtmTEw-ws6fhxaBcksaz967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_14,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=723 mlxscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090164
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Roberto,

On Sat, 2023-06-03 at 21:15 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> With the newly added ability of LSMs to supply multiple xattrs, set
> SMACK64TRASMUTE in smack_inode_init_security(), instead of d_instantiate().
> Do it by incrementing SMACK_INODE_INIT_XATTRS to 2 and by calling
> lsm_get_xattr_slot() a second time, if the transmuting conditions are met.
> 
> The LSM infrastructure passes all xattrs provided by LSMs to the
> filesystems through the initxattrs() callback, so that filesystems can
> store xattrs in the disk.
> 
> After the change, the SMK_INODE_TRANSMUTE inode flag is always set by
> d_instantiate() after fetching SMACK64TRANSMUTE from the disk. Before it
> was done by smack_inode_post_setxattr() as result of the __vfs_setxattr()
> call.
> 
> Removing __vfs_setxattr() also prevents invalidating the EVM HMAC, by
> adding a new xattr without checking and updating the existing HMAC.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Just a few comments/nits inline.

> ---
>  security/smack/smack.h     |  2 +-
>  security/smack/smack_lsm.c | 43 +++++++++++++++++++++++---------------
>  2 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index aa15ff56ed6..041688e5a77 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -128,7 +128,7 @@ struct task_smack {
>  
>  #define	SMK_INODE_INSTANT	0x01	/* inode is instantiated */
>  #define	SMK_INODE_TRANSMUTE	0x02	/* directory is transmuting */
> -#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted */
> +#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted (unused) */
>  #define	SMK_INODE_IMPURE	0x08	/* involved in an impure transaction */
>  
>  /*
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index a1c30275692..b67d901ee74 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -52,7 +52,14 @@
>  #define SMK_RECEIVING	1
>  #define SMK_SENDING	2
>  
> -#define SMACK_INODE_INIT_XATTRS 1
> +/*
> + * Smack uses multiple xattrs.
> + * SMACK64 - for access control,
> + * SMACK64TRANSMUTE - label initialization,
> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT,
> + * Must be set explicitly - SMACK64EXEC and SMACK64MMAP
> + */
> +#define SMACK_INODE_INIT_XATTRS 2
>  
>  #ifdef SMACK_IPV6_PORT_LABELING
>  static DEFINE_MUTEX(smack_ipv6_lock);
> @@ -935,7 +942,6 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>  				     struct xattr *xattrs, int *xattr_count)
>  {
>  	struct task_smack *tsp = smack_cred(current_cred());
> -	struct inode_smack *issp = smack_inode(inode);
>  	struct smack_known *skp = smk_of_task(tsp);
>  	struct smack_known *isp = smk_of_inode(inode);
>  	struct smack_known *dsp = smk_of_inode(dir);
> @@ -963,6 +969,8 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>  		if ((tsp->smk_task == tsp->smk_transmuted) ||
>  		    (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
>  		     smk_inode_transmutable(dir))) {
> +			struct xattr *xattr_transmute;
> +

Variables should be defined at the beginning of the function.

Is there a reason for beginning the function with "if (xattr) {"
instead "if (!xattr) return 0;".  This causes unnecessary indenting.  

>  			/*
>  			 * The caller of smack_dentry_create_files_as()
>  			 * should have overridden the current cred, so the
> @@ -971,7 +979,16 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>  			 */
>  			if (tsp->smk_task != tsp->smk_transmuted)
>  				isp = dsp;
> -			issp->smk_flags |= SMK_INODE_CHANGED;
> +			xattr_transmute = lsm_get_xattr_slot(xattrs, xattr_count);
> +			if (xattr_transmute) {
> +				xattr_transmute->value = kmemdup(TRANS_TRUE,
> +						TRANS_TRUE_SIZE, GFP_NOFS);

script/checkpatch --strict complains here.

> +				if (xattr_transmute->value == NULL)
> +					return -ENOMEM;
> +
> +				xattr_transmute->value_len = TRANS_TRUE_SIZE;
> +				xattr_transmute->name = XATTR_SMACK_TRANSMUTE;
> +			}
>  		}
>  
>  		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
> @@ -3518,20 +3535,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>  			 * If there is a transmute attribute on the
>  			 * directory mark the inode.
>  			 */
> -			if (isp->smk_flags & SMK_INODE_CHANGED) {
> -				isp->smk_flags &= ~SMK_INODE_CHANGED;
> -				rc = __vfs_setxattr(&nop_mnt_idmap, dp, inode,
> -					XATTR_NAME_SMACKTRANSMUTE,
> -					TRANS_TRUE, TRANS_TRUE_SIZE,
> -					0);
> -			} else {
> -				rc = __vfs_getxattr(dp, inode,
> -					XATTR_NAME_SMACKTRANSMUTE, trattr,
> -					TRANS_TRUE_SIZE);
> -				if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
> -						       TRANS_TRUE_SIZE) != 0)
> -					rc = -EINVAL;
> -			}
> +			rc = __vfs_getxattr(dp, inode,
> +					    XATTR_NAME_SMACKTRANSMUTE, trattr,
> +					    TRANS_TRUE_SIZE);
> +			if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
> +					       TRANS_TRUE_SIZE) != 0)
> +				rc = -EINVAL;
>  			if (rc >= 0)
>  				transflag = SMK_INODE_TRANSMUTE;
>  		}



