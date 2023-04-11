Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEA16DD405
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 09:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjDKHXf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 03:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjDKHXd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 03:23:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A66170B;
        Tue, 11 Apr 2023 00:23:31 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33B6IbUV015908;
        Tue, 11 Apr 2023 07:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=F5oaR7mQS9YSO9cMB8O+css1vtlsYjRNMU5UQxqGHHU=;
 b=f/a2vBUGI0uqJSxc8Gujiw6NHg7uuX4idlXVQcqO8jQYbu4EMQIV+w4AP4mhdQg4H8T2
 EGGT6WIA5iuYXMLq+eYeJ5LXcb/twzbuc5dENjyvt0X16yWXkMx7ZPrKvfrX7uQOpkMw
 CT5aNsXF9k8tebQnEp687qLG5CddIWA2Xp2iY/5S1mzNtiybPGvxvRfvOw4cjVoTHE8a
 cfgSo72sz5ZVvrzkpyqSpX5B233PPYA1Dk/Tzs2wvBzq0pKn4A9VSKkc9ULkjPeYWzf5
 TkPUrdmH2YleC2Gncwk0AclqPVjWO0e1m/mb07+sshPZc3qSQYvvGqkXTE533cXQyMAw pA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pw25xsgus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 07:22:51 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33B6LxSD027758;
        Tue, 11 Apr 2023 07:22:51 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pw25xsgud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 07:22:51 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33B4liSr009441;
        Tue, 11 Apr 2023 07:22:50 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3pu0gyjvsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 07:22:50 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33B7MmV312059150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Apr 2023 07:22:49 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B016A58056;
        Tue, 11 Apr 2023 07:22:48 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6090358050;
        Tue, 11 Apr 2023 07:22:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.109.203])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 11 Apr 2023 07:22:44 +0000 (GMT)
Message-ID: <404a022216d33063ff8f8b4f0d31d9d38a2da4d4.camel@linux.ibm.com>
Subject: Re: [PATCH v10 3/4] evm: Align evm_inode_init_security() definition
 with LSM infrastructure
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 11 Apr 2023 03:22:43 -0400
In-Reply-To: <20230331123221.3273328-4-roberto.sassu@huaweicloud.com>
References: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com>
         <20230331123221.3273328-4-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n-DzhUIt9-SkjmIukES8pgEhcU7tJHYy
X-Proofpoint-ORIG-GUID: ADzN2D2o5WELpKyuDR-X5qaZOXeg6OHj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_04,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 mlxscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304110065
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-03-31 at 14:32 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Change the evm_inode_init_security() definition to align with the LSM
> infrastructure. Keep the existing behavior of including in the HMAC
> calculation only the first xattr provided by LSMs.
> 
> Changing the evm_inode_init_security() definition requires passing the
> xattr array allocated by security_inode_init_security(), and the number of
> xattrs filled by previously invoked LSMs.
> 
> Use the newly introduced lsm_get_xattr_slot() to position EVM correctly in
> the xattrs array, like a regular LSM, and to increment the number of filled
> slots. For now, the LSM infrastructure allocates enough xattrs slots to
> store the EVM xattr, without using the reservation mechanism.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/evm.h               | 13 +++++++------
>  security/integrity/evm/evm_main.c | 16 ++++++++++------
>  security/security.c               |  6 +++---
>  3 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/evm.h b/include/linux/evm.h
> index 7dc1ee74169..597632c71c7 100644
> --- a/include/linux/evm.h
> +++ b/include/linux/evm.h
> @@ -56,9 +56,9 @@ static inline void evm_inode_post_set_acl(struct dentry *dentry,
>  {
>  	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0);
>  }
> -extern int evm_inode_init_security(struct inode *inode,
> -				   const struct xattr *xattr_array,
> -				   struct xattr *evm);
> +extern int evm_inode_init_security(struct inode *inode, struct inode *dir,
> +				   const struct qstr *qstr,
> +				   struct xattr *xattrs, int *xattr_count);
>  extern bool evm_revalidate_status(const char *xattr_name);
>  extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
>  extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
> @@ -157,9 +157,10 @@ static inline void evm_inode_post_set_acl(struct dentry *dentry,
>  	return;
>  }
>  
> -static inline int evm_inode_init_security(struct inode *inode,
> -					  const struct xattr *xattr_array,
> -					  struct xattr *evm)
> +static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
> +					  const struct qstr *qstr,
> +					  struct xattr *xattrs,
> +					  int *xattr_count)
>  {
>  	return 0;
>  }
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index cf24c525558..475196ce712 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -21,6 +21,7 @@
>  #include <linux/evm.h>
>  #include <linux/magic.h>
>  #include <linux/posix_acl_xattr.h>
> +#include <linux/lsm_hooks.h>
>  
>  #include <crypto/hash.h>
>  #include <crypto/hash_info.h>
> @@ -864,23 +865,26 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
>  /*
>   * evm_inode_init_security - initializes security.evm HMAC value
>   */
> -int evm_inode_init_security(struct inode *inode,
> -				 const struct xattr *lsm_xattr,
> -				 struct xattr *evm_xattr)
> +int evm_inode_init_security(struct inode *inode, struct inode *dir,
> +			    const struct qstr *qstr, struct xattr *xattrs,
> +			    int *xattr_count)
>  {
>  	struct evm_xattr *xattr_data;
> +	struct xattr *evm_xattr;
>  	int rc;
>  
> -	if (!(evm_initialized & EVM_INIT_HMAC) ||
> -	    !evm_protected_xattr(lsm_xattr->name))
> +	if (!(evm_initialized & EVM_INIT_HMAC) || !xattrs ||
> +	    !evm_protected_xattr(xattrs->name))
>  		return 0;
>  
> +	evm_xattr = lsm_get_xattr_slot(xattrs, xattr_count);
> +
>  	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
>  	if (!xattr_data)
>  		return -ENOMEM;
>  
>  	xattr_data->data.type = EVM_XATTR_HMAC;
> -	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
> +	rc = evm_init_hmac(inode, xattrs, xattr_data->digest);
>  	if (rc < 0)
>  		goto out;
>  
> diff --git a/security/security.c b/security/security.c
> index 1aeaa8ce449..ef7779ec8b2 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1645,9 +1645,9 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  	if (!xattr_count)
>  		goto out;
>  
> -	ret = evm_inode_init_security(inode, new_xattrs,
> -				      new_xattrs + xattr_count);
> -	if (ret)
> +	ret = evm_inode_init_security(inode, dir, qstr, new_xattrs,
> +				      &xattr_count);
> +	if (ret && ret != -EOPNOTSUPP)

As previously discussed, -EOPNOTSUPP originally meant that the
filesystem itself did not support writing xattrs.  So there was no
point in trying to write the EVM security xattr.   With the change in
-EOPNOTSUPP meaning, it will now try to write the EVM security xattr. 
Instead of glossing over the change in behavior, it needs to at least
be mentioned in the patch description.

>  		goto out;
>  	ret = initxattrs(inode, new_xattrs, fs_data);
>  out:

-- 
thanks,

Mimi

