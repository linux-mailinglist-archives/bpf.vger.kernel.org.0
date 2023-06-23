Return-Path: <bpf+bounces-3307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC5173BEE9
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 21:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE5C281B0F
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 19:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE3E10965;
	Fri, 23 Jun 2023 19:32:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6CF101E7
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 19:32:47 +0000 (UTC)
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51192711;
	Fri, 23 Jun 2023 12:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687548766; x=1719084766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MXGjsQVBbUEfugTyhqtLOg34xJrVsEnXiFXbx+PaHRY=;
  b=UeBmqFaRBZo0LDtqdhDP+Lx7Igt3lPCiaclNEshFzFYa8pq9OAvmbg5x
   BNrQDx/bcCJCOm36lZsIE7QQCmf9uNwu01CVUwrsnGDUxIMzt3bcNxYsy
   DJhuAbGuZbBKHzzhqg0Y+zHXN6qCFCy82o2PrKhTb32avjKZPVAr5tGzh
   A=;
X-IronPort-AV: E=Sophos;i="6.01,152,1684800000"; 
   d="scan'208";a="222788639"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 19:32:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com (Postfix) with ESMTPS id E6DAB66811;
	Fri, 23 Jun 2023 19:32:35 +0000 (UTC)
Received: from EX19D028UWA002.ant.amazon.com (10.13.138.248) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 23 Jun 2023 19:32:35 +0000
Received: from uda95858fd22f53.ant.amazon.com (10.88.166.238) by
 EX19D028UWA002.ant.amazon.com (10.13.138.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 23 Jun 2023 19:32:34 +0000
From: Mengchi Cheng <mengcc@amazon.com>
To: <roberto.sassu@huaweicloud.com>
CC: <bpf@vger.kernel.org>, <casey@schaufler-ca.com>,
	<dmitry.kasatkin@gmail.com>, <eparis@parisplace.org>, <jmorris@namei.org>,
	<kamatam@amazon.com>, <keescook@chromium.org>, <kpsingh@kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <linux-unionfs@vger.kernel.org>,
	<mengcc@amazon.com>, <miklos@szeredi.hu>, <nicolas.bouchinet@clip-os.org>,
	<paul@paul-moore.com>, <roberto.sassu@huawei.com>, <selinux@vger.kernel.org>,
	<serge@hallyn.com>, <stephen.smalley.work@gmail.com>, <yoonjaeh@amazon.com>,
	<zohar@linux.ibm.com>
Subject: Re: [PATCH v11 2/4] smack: Set the SMACK64TRANSMUTE xattr in smack_inode_init_security()
Date: Fri, 23 Jun 2023 12:32:22 -0700
Message-ID: <20230623193222.2326429-1-mengcc@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9f4b7bef5d090da9de50ed1aa1e103abc19b125f.camel@huaweicloud.com>
References: <9f4b7bef5d090da9de50ed1aa1e103abc19b125f.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.88.166.238]
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D028UWA002.ant.amazon.com (10.13.138.248)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-06-05 08:38:29 +0000, Roberto Sassu wrote:
>
> On Sat, 2023-06-03 at 21:15 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > With the newly added ability of LSMs to supply multiple xattrs, set
> > SMACK64TRASMUTE in smack_inode_init_security(), instead of d_instantiate().
> > Do it by incrementing SMACK_INODE_INIT_XATTRS to 2 and by calling
> > lsm_get_xattr_slot() a second time, if the transmuting conditions are met.
> > 
> > The LSM infrastructure passes all xattrs provided by LSMs to the
> > filesystems through the initxattrs() callback, so that filesystems can
> > store xattrs in the disk.
> > 
> > After the change, the SMK_INODE_TRANSMUTE inode flag is always set by
> > d_instantiate() after fetching SMACK64TRANSMUTE from the disk. Before it
> > was done by smack_inode_post_setxattr() as result of the __vfs_setxattr()
> > call.
> > 
> > Removing __vfs_setxattr() also prevents invalidating the EVM HMAC, by
> > adding a new xattr without checking and updating the existing HMAC.
> 
> Hi Mengchi
> 
> could you please redo your tests with this patch set applied?
> 
> https://lore.kernel.org/linux-integrity/20230603191518.1397490-1-roberto.sassu@huaweicloud.com/
> 
> You need:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/log/?h=next
> 
> https://github.com/cschaufler/smack-next/commits/next
> 
> Thanks
> 
> Roberto

Sorry for the later reply. It turned out lsm.git repo needs your previous
two overlay fs fixes before applying these four patches.
With v12 I did not see the issue I reported anymore.

Best,
Mengchi

> 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/smack/smack.h     |  2 +-
> >  security/smack/smack_lsm.c | 43 +++++++++++++++++++++++---------------
> >  2 files changed, 27 insertions(+), 18 deletions(-)
> > 
> > diff --git a/security/smack/smack.h b/security/smack/smack.h
> > index aa15ff56ed6..041688e5a77 100644
> > --- a/security/smack/smack.h
> > +++ b/security/smack/smack.h
> > @@ -128,7 +128,7 @@ struct task_smack {
> >  
> >  #define	SMK_INODE_INSTANT	0x01	/* inode is instantiated */
> >  #define	SMK_INODE_TRANSMUTE	0x02	/* directory is transmuting */
> > -#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted */
> > +#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted (unused) */
> >  #define	SMK_INODE_IMPURE	0x08	/* involved in an impure transaction */
> >  
> >  /*
> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index a1c30275692..b67d901ee74 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -52,7 +52,14 @@
> >  #define SMK_RECEIVING	1
> >  #define SMK_SENDING	2
> >  
> > -#define SMACK_INODE_INIT_XATTRS 1
> > +/*
> > + * Smack uses multiple xattrs.
> > + * SMACK64 - for access control,
> > + * SMACK64TRANSMUTE - label initialization,
> > + * Not saved on files - SMACK64IPIN and SMACK64IPOUT,
> > + * Must be set explicitly - SMACK64EXEC and SMACK64MMAP
> > + */
> > +#define SMACK_INODE_INIT_XATTRS 2
> >  
> >  #ifdef SMACK_IPV6_PORT_LABELING
> >  static DEFINE_MUTEX(smack_ipv6_lock);
> > @@ -935,7 +942,6 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
> >  				     struct xattr *xattrs, int *xattr_count)
> >  {
> >  	struct task_smack *tsp = smack_cred(current_cred());
> > -	struct inode_smack *issp = smack_inode(inode);
> >  	struct smack_known *skp = smk_of_task(tsp);
> >  	struct smack_known *isp = smk_of_inode(inode);
> >  	struct smack_known *dsp = smk_of_inode(dir);
> > @@ -963,6 +969,8 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
> >  		if ((tsp->smk_task == tsp->smk_transmuted) ||
> >  		    (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
> >  		     smk_inode_transmutable(dir))) {
> > +			struct xattr *xattr_transmute;
> > +
> >  			/*
> >  			 * The caller of smack_dentry_create_files_as()
> >  			 * should have overridden the current cred, so the
> > @@ -971,7 +979,16 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
> >  			 */
> >  			if (tsp->smk_task != tsp->smk_transmuted)
> >  				isp = dsp;
> > -			issp->smk_flags |= SMK_INODE_CHANGED;
> > +			xattr_transmute = lsm_get_xattr_slot(xattrs, xattr_count);
> > +			if (xattr_transmute) {
> > +				xattr_transmute->value = kmemdup(TRANS_TRUE,
> > +						TRANS_TRUE_SIZE, GFP_NOFS);
> > +				if (xattr_transmute->value == NULL)
> > +					return -ENOMEM;
> > +
> > +				xattr_transmute->value_len = TRANS_TRUE_SIZE;
> > +				xattr_transmute->name = XATTR_SMACK_TRANSMUTE;
> > +			}
> >  		}
> >  
> >  		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
> > @@ -3518,20 +3535,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
> >  			 * If there is a transmute attribute on the
> >  			 * directory mark the inode.
> >  			 */
> > -			if (isp->smk_flags & SMK_INODE_CHANGED) {
> > -				isp->smk_flags &= ~SMK_INODE_CHANGED;
> > -				rc = __vfs_setxattr(&nop_mnt_idmap, dp, inode,
> > -					XATTR_NAME_SMACKTRANSMUTE,
> > -					TRANS_TRUE, TRANS_TRUE_SIZE,
> > -					0);
> > -			} else {
> > -				rc = __vfs_getxattr(dp, inode,
> > -					XATTR_NAME_SMACKTRANSMUTE, trattr,
> > -					TRANS_TRUE_SIZE);
> > -				if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
> > -						       TRANS_TRUE_SIZE) != 0)
> > -					rc = -EINVAL;
> > -			}
> > +			rc = __vfs_getxattr(dp, inode,
> > +					    XATTR_NAME_SMACKTRANSMUTE, trattr,
> > +					    TRANS_TRUE_SIZE);
> > +			if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
> > +					       TRANS_TRUE_SIZE) != 0)
> > +				rc = -EINVAL;
> >  			if (rc >= 0)
> >  				transflag = SMK_INODE_TRANSMUTE;
> >  		}
> 
> 

