Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3036DD3FD
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 09:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjDKHXH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 03:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjDKHXG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 03:23:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD69170B;
        Tue, 11 Apr 2023 00:22:59 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33B67ChT018270;
        Tue, 11 Apr 2023 07:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WPz6VWAuso0TUls6NwifSXDqXiXIq7ClHmv1ryg+u74=;
 b=m0fkeBVN34WmGzfqZ/cUYRqe5b9/YpiHfsmkTwU2prDzuF0Fj+CTJWmkgyy/mgGlOZWr
 mJitR9rlTOObaD/X0YdYvbI0bOUp/o3lryNd3zssJPqJD9LHecDyPR2ucLelRwJosso+
 ZPsDEfTs6ALdM0303yXuKVgguZ6+sZDbiKJxiAEKJ98aoJlRgCzXBjS8y1qKhCUg1eWC
 pKaLXENWcykEYCJCu+p74gGgX2GWfiirnOjDrOBQ5wgTdWaICkt1A5kqERf6CuVpQOzM
 D+b/TmA+Quer1dwFR6vnwxX4dofTjt5hH6v4BknhQXABvx9DapDHRQvEp+T5iRIxwFTj SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3puhut8muk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 07:22:14 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33B7IcKa004461;
        Tue, 11 Apr 2023 07:22:13 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3puhut8mu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 07:22:13 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33B4qSG2002007;
        Tue, 11 Apr 2023 07:22:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3pu0ktjx2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 07:22:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33B7MAAc12845678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Apr 2023 07:22:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA1EA58061;
        Tue, 11 Apr 2023 07:22:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5B3958056;
        Tue, 11 Apr 2023 07:22:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.109.203])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 11 Apr 2023 07:22:06 +0000 (GMT)
Message-ID: <e65b6ea91d66b78c382acdec14003d3665fcfd3e.camel@linux.ibm.com>
Subject: Re: [PATCH v10 2/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
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
Date:   Tue, 11 Apr 2023 03:22:05 -0400
In-Reply-To: <20230331123221.3273328-3-roberto.sassu@huaweicloud.com>
References: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com>
         <20230331123221.3273328-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E8yNCj9MPzgxgSZEgocdya7SYFNPX_wi
X-Proofpoint-ORIG-GUID: DqGj2APG48jSuJ7iodhUc6fHZ86fEZix
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_03,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110065
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Roberto,

Sorry for the delay in responding...

The patch description reads as though support for per LSM multiple
xattrs is being added in this patch, though lsm_get_xattr_slot() only
ever is incremented once for each LSM.  To simplify review, it would be
nice to mention that lsm_get_xattr_slot() would be called multiple
times per LSM xattr.

On Fri, 2023-03-31 at 14:32 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Currently, security_inode_init_security() supports only one LSM providing
> an xattr and EVM calculating the HMAC on that xattr, plus other inode
> metadata.
> 
> Allow all LSMs to provide one or multiple xattrs, by extending the security
> blob reservation mechanism. Introduce the new lbs_xattr_count field of the
> lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
> needs, and the LSM infrastructure knows how many xattr slots it should
> allocate.
> 
> Dynamically allocate the new_xattrs array to be populated by LSMs with the
> inode_init_security hook, and pass it to the latter instead of the
> name/value/len triple. Unify the !initxattrs and initxattrs case, simply
> don't allocate the new_xattrs array in the former.
> 
> Also, pass to the hook the number of xattrs filled by each LSM, so that
> there are no gaps when the next LSM fills the array. Gaps might occur
> because an LSM can legitimately request xattrs to the LSM infrastructure,
> but not fill the reserved slots, if it was not initialized.

The number of security xattrs permitted per LSM was discussed in the
second paragraph.  The first line of this paragraph needs to be updated
to reflect the current number of security xattrs used, though that is
more related to the new lsm_get_xattr_slot().  Or perhaps the entire
paragraph is unnecessary, a remnant from
security_check_compact_filled_xattrs(), and should be removed.  

> 
> Update the documentation of security_inode_init_security() to reflect the
> changes, and fix the description of the xattr name, as it is not allocated
> anymore.
> 
> Finally, adapt both SELinux and Smack to use the new definition of the
> inode_init_security hook, and to fill the reserved slots in the xattr
> array. Introduce the lsm_get_xattr_slot() helper to retrieve an available
> slot to fill, and to increment the number of filled slots.
> 
> Move the xattr->name assignment after the xattr->value one, so that it is
> done only in case of successful memory allocation. For Smack, also reserve
> space for the other defined xattrs although they are not set yet in
> smack_inode_init_security().

This Smack comment should be moved to the previous paragraph and even
expanded explaining that lsm_get_xattr_slot() will be called for each
additional security xattr.

> 
> Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org> (EVM crash)
> Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlinux/
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index c2be66c669a..9eb9b686493 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -28,6 +28,7 @@
>  #include <linux/security.h>
>  #include <linux/init.h>
>  #include <linux/rculist.h>
> +#include <linux/xattr.h>
>  
>  union security_list_options {
>  	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
> @@ -63,8 +64,27 @@ struct lsm_blob_sizes {
>  	int	lbs_ipc;
>  	int	lbs_msg_msg;
>  	int	lbs_task;
> +	int	lbs_xattr_count; /* number of xattr slots in new_xattrs array */
>  };
>  
> +/**
> + * lsm_get_xattr_slot - Return the next available slot and increment the index
> + * @xattrs: array storing LSM-provided xattrs
> + * @xattr_count: number of already stored xattrs (updated)
> + *
> + * Retrieve the first available slot in the @xattrs array to fill with an xattr,
> + * and increment @xattr_count.
> + *
> + * Return: The slot to fill in @xattrs if non-NULL, NULL otherwise.
> + */
> +static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
> +					       int *xattr_count)
> +{
> +	if (unlikely(!xattrs))
> +		return NULL;
> +	return xattrs + (*xattr_count)++;

At some point, since lsm_get_xattr_slot() could be called multiple
times from the same LSM, shouldn't there be some sort of bounds
checking?

-- 
thanks,

Mimi

