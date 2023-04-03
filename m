Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070CB6D424A
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 12:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjDCKkB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 06:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCKjv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 06:39:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5378212BE6;
        Mon,  3 Apr 2023 03:39:21 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333AE6dw024727;
        Mon, 3 Apr 2023 10:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=CFuKEPFFQM7kQzgTrYjPL4AY7Pi37UZRMecFHRosweE=;
 b=U+Osj3dttd61Gqkleo8NodD0T4dqNYPSeEQx1MUa1nPU+/OtvwYkQz6LRHalAtrN0vBb
 ESZKWdyxWgGyUifAqZIGH74kJid1NxqYHjbNoxJJiJGybzaPyLqUjxxVd6o1vnvz+TR4
 QGJ44mq3lvCpI/qxWhpzmw69mKIw1HcGeVSaXU0Z1LYpnOo/d+RAMgzueyf0QWpzORN7
 hdtusqCqf/tmafHx4x3qsmDpsG1eM13aHhzMYfINO856vZLFQ9G5EM/IIIQnuANtdLO+
 pSS7+Jo6rzdTRnOQe0csEiLkPJXZMSbp+LmOkj0OxxhUDQp6SNfnDG/Gnns8eRYry2Cq fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pqvv1rmy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 10:37:58 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 333Abvcj030774;
        Mon, 3 Apr 2023 10:37:57 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pqvv1rmxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 10:37:57 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3339YsoI024983;
        Mon, 3 Apr 2023 10:37:57 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3ppc87ju0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 10:37:57 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 333Abtd316712304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Apr 2023 10:37:56 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9BAF58163;
        Mon,  3 Apr 2023 10:37:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55CE758158;
        Mon,  3 Apr 2023 10:37:50 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.66.117])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  3 Apr 2023 10:37:49 +0000 (GMT)
Message-ID: <ef1ff552e16eadf5bc8d6219d463b35511103c38.camel@linux.ibm.com>
Subject: Re: [PATCH v9 3/4] evm: Align evm_inode_init_security() definition
 with LSM infrastructure
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 03 Apr 2023 06:37:48 -0400
In-Reply-To: <ca6d4080b0f234b5321d965fb1350bfcd291646e.camel@huaweicloud.com>
References: <20230329130415.2312521-1-roberto.sassu@huaweicloud.com>
         <20230329130415.2312521-4-roberto.sassu@huaweicloud.com>
         <CAHC9VhSDVv30ce2652kridRU7iaQQ19tiGubWpyP0mi7pf+JJw@mail.gmail.com>
         <bfe74fff24a5a7a8059acc00c29ac957bf0b7880.camel@huaweicloud.com>
         <ca6d4080b0f234b5321d965fb1350bfcd291646e.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4HnafZ_8XDHqvoCwkEGm4_Y9zfImSkbC
X-Proofpoint-ORIG-GUID: dDlv3V5Bnc7q_d3CLfPITjeLxvL5-_yX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_06,2023-04-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030080
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-03-31 at 14:18 +0200, Roberto Sassu wrote:
> On Fri, 2023-03-31 at 09:32 +0200, Roberto Sassu wrote:
> > On Thu, 2023-03-30 at 18:55 -0400, Paul Moore wrote:
> > > On Wed, Mar 29, 2023 at 9:05 AM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > 
> > > > Change the evm_inode_init_security() definition to align with the LSM
> > > > infrastructure. Keep the existing behavior of including in the HMAC
> > > > calculation only the first xattr provided by LSMs.
> > > > 
> > > > Changing the evm_inode_init_security() definition requires passing the
> > > > xattr array allocated by security_inode_init_security(), and the number of
> > > > xattrs filled by previously invoked LSMs.
> > > > 
> > > > Use the newly introduced lsm_find_xattr_slot() to position EVM correctly in
> > > > the xattrs array, like a regular LSM, and to increment the number of filled
> > > > slots. For now, the LSM infrastructure allocates enough xattrs slots to
> > > > store the EVM xattr, without using the reservation mechanism.
> > > > 
> > > > Finally, make evm_inode_init_security() return value compatible with the
> > > > inode_init_security hook conventions, i.e. return -EOPNOTSUPP if it is not
> > > > setting an xattr.
> > > > 
> > > > EVM is a bit tricky, because xattrs is both an input and an output. If it
> > > > was just output, EVM should have returned zero if xattrs is NULL. But,
> > > > since xattrs is also input, EVM is unable to do its calculations, so return
> > > > -EOPNOTSUPP and handle this error in security_inode_init_security().
> > > 
> > > I don't quite understand why EVM would return EOPNOTSUPP if it is
> > > enabled but there are not xattrs to measure.  It seems like EVM should
> > > return success/0 in the no-xattr case; there were no xattrs to
> > > measure, so it succeeded in measuring nothing.  Am I missing
> > > something?
> > 
> > From a very quick look at what other LSMs do, it seems that they return
> > zero even if they are not initialized.
> > 
> > So, it makes sense to return zero also here.
> 
> Oh, actually there was a reason to do that. If an LSM does not wish to
> provide an xattr, it should return -EOPNOTSUPP.

In general, the original purpose of -EOPNOTSUPP was to indicate that
the filesystem itself did not support security xattrs.  This can be
seen in evm_verify_hmac(), which returns different values (e.g.
INTEGRITY_NOLABEL, INTEGRITY_NOXATTRS, INTEGRITY_UNKNOWN) based on
whether security.evm or any protected security xattrs exist.

> 
> As we are not checking this convention anymore, it is probably fine to
> return zero. I already made the change, will send the new version
> shortly.

For security xattr initialization, agreed.

Mimi

> 
> > 
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > ---
> > > >  include/linux/evm.h               | 14 ++++++++------
> > > >  security/integrity/evm/evm_main.c | 18 +++++++++++-------
> > > >  security/security.c               |  6 +++---
> > > >  3 files changed, 22 insertions(+), 16 deletions(-)
> > > > 
> > > > diff --git a/include/linux/evm.h b/include/linux/evm.h
> > > > index 7dc1ee74169..3c0e8591b69 100644
> > > > --- a/include/linux/evm.h
> > > > +++ b/include/linux/evm.h
> > > > @@ -56,9 +56,10 @@ static inline void evm_inode_post_set_acl(struct dentry *dentry,
> > > >  {
> > > >         return evm_inode_post_setxattr(dentry, acl_name, NULL, 0);
> > > >  }
> > > > -extern int evm_inode_init_security(struct inode *inode,
> > > > -                                  const struct xattr *xattr_array,
> > > > -                                  struct xattr *evm);
> > > > +extern int evm_inode_init_security(struct inode *inode, struct inode *dir,
> > > > +                                  const struct qstr *qstr,
> > > > +                                  struct xattr *xattrs,
> > > > +                                  int *num_filled_xattrs);
> > > >  extern bool evm_revalidate_status(const char *xattr_name);
> > > >  extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
> > > >  extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
> > > > @@ -157,9 +158,10 @@ static inline void evm_inode_post_set_acl(struct dentry *dentry,
> > > >         return;
> > > >  }
> > > > 
> > > > -static inline int evm_inode_init_security(struct inode *inode,
> > > > -                                         const struct xattr *xattr_array,
> > > > -                                         struct xattr *evm)
> > > > +static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
> > > > +                                         const struct qstr *qstr,
> > > > +                                         struct xattr *xattrs,
> > > > +                                         int *num_filled_xattrs)
> > > >  {
> > > >         return 0;
> > > >  }
> > > > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > > > index cf24c525558..9e75759150c 100644
> > > > --- a/security/integrity/evm/evm_main.c
> > > > +++ b/security/integrity/evm/evm_main.c
> > > > @@ -21,6 +21,7 @@
> > > >  #include <linux/evm.h>
> > > >  #include <linux/magic.h>
> > > >  #include <linux/posix_acl_xattr.h>
> > > > +#include <linux/lsm_hooks.h>
> > > > 
> > > >  #include <crypto/hash.h>
> > > >  #include <crypto/hash_info.h>
> > > > @@ -864,23 +865,26 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
> > > >  /*
> > > >   * evm_inode_init_security - initializes security.evm HMAC value
> > > >   */
> > > > -int evm_inode_init_security(struct inode *inode,
> > > > -                                const struct xattr *lsm_xattr,
> > > > -                                struct xattr *evm_xattr)
> > > > +int evm_inode_init_security(struct inode *inode, struct inode *dir,
> > > > +                           const struct qstr *qstr, struct xattr *xattrs,
> > > > +                           int *num_filled_xattrs)
> > > >  {
> > > >         struct evm_xattr *xattr_data;
> > > > +       struct xattr *evm_xattr;
> > > >         int rc;
> > > > 
> > > > -       if (!(evm_initialized & EVM_INIT_HMAC) ||
> > > > -           !evm_protected_xattr(lsm_xattr->name))
> > > > -               return 0;
> > > > +       if (!(evm_initialized & EVM_INIT_HMAC) || !xattrs ||
> > > > +           !evm_protected_xattr(xattrs->name))
> > > > +               return -EOPNOTSUPP;
> > > > +
> > > > +       evm_xattr = lsm_find_xattr_slot(xattrs, num_filled_xattrs);
> > > > 
> > > >         xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
> > > >         if (!xattr_data)
> > > >                 return -ENOMEM;
> > > > 
> > > >         xattr_data->data.type = EVM_XATTR_HMAC;
> > > > -       rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
> > > > +       rc = evm_init_hmac(inode, xattrs, xattr_data->digest);
> > > >         if (rc < 0)
> > > >                 goto out;
> > > > 
> > > > diff --git a/security/security.c b/security/security.c
> > > > index be33d643a81..22ab4fb7ebf 100644
> > > > --- a/security/security.c
> > > > +++ b/security/security.c
> > > > @@ -1674,9 +1674,9 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
> > > >         if (!num_filled_xattrs)
> > > >                 goto out;
> > > > 
> > > > -       ret = evm_inode_init_security(inode, new_xattrs,
> > > > -                                     new_xattrs + num_filled_xattrs);
> > > > -       if (ret)
> > > > +       ret = evm_inode_init_security(inode, dir, qstr, new_xattrs,
> > > > +                                     &num_filled_xattrs);
> > > > +       if (ret && ret != -EOPNOTSUPP)
> > > >                 goto out;
> > > >         ret = initxattrs(inode, new_xattrs, fs_data);
> > > >  out:
> > > > --
> > > > 2.25.1
> > > > 
> 


