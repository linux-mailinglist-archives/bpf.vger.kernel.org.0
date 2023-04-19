Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C366E81D6
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 21:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjDSTZr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 15:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjDSTZr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 15:25:47 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387535BBA;
        Wed, 19 Apr 2023 12:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1681932340; x=1713468340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SsYQyINsS1Fk4lVA4C/fRqc9lh6pGxoW0r4tOSla9cU=;
  b=XrnsG0+RtLL63yP7qQ4MRLL2cN2IvQusmgEI+sKdrqt0x5S/6v0aMuKf
   CPS7fLS74VXiLf2TCePdYTIy/bOpSzncmDV3EmsEQdlYRRzrn62ZZV1Kb
   PJABhafS0BHzigVlvfTDeyWTnY6+nnqtKw9i+uy3Ws6NmG4aIJL07TJs2
   I=;
X-IronPort-AV: E=Sophos;i="5.99,210,1677542400"; 
   d="scan'208";a="1124137496"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 19:25:36 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com (Postfix) with ESMTPS id 5FDA8818D0;
        Wed, 19 Apr 2023 19:25:30 +0000 (UTC)
Received: from EX19D028UWA002.ant.amazon.com (10.13.138.248) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 19 Apr 2023 19:25:29 +0000
Received: from uda95858fd22f53.ant.amazon.com (10.106.101.53) by
 EX19D028UWA002.ant.amazon.com (10.13.138.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.26;
 Wed, 19 Apr 2023 19:25:27 +0000
From:   Mengchi Cheng <mengcc@amazon.com>
To:     <roberto.sassu@huaweicloud.com>
CC:     <bpf@vger.kernel.org>, <casey@schaufler-ca.com>,
        <dmitry.kasatkin@gmail.com>, <eparis@parisplace.org>,
        <jmorris@namei.org>, <kamatam@amazon.com>, <keescook@chromium.org>,
        <kpsingh@kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-unionfs@vger.kernel.org>, <mengcc@amazon.com>,
        <miklos@szeredi.hu>, <nicolas.bouchinet@clip-os.org>,
        <paul@paul-moore.com>, <reiserfs-devel@vger.kernel.org>,
        <roberto.sassu@huawei.com>, <selinux@vger.kernel.org>,
        <serge@hallyn.com>, <stephen.smalley.work@gmail.com>,
        <yoonjaeh@amazon.com>, <zohar@linux.ibm.com>
Subject: Re: [PATCH] Smack modifications for: security: Allow all LSMs to provide xattrs for inode_init_security hook
Date:   Wed, 19 Apr 2023 12:25:16 -0700
Message-ID: <20230419192516.757220-1-mengcc@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0fccab67e496f10f4ee7bf2220e70a655013935f.camel@huaweicloud.com>
References: <0fccab67e496f10f4ee7bf2220e70a655013935f.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.53]
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D028UWA002.ant.amazon.com (10.13.138.248)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> 
> I got some errors during xattr removal, so not sure if my patch was
> working properly or not (it happened also without it, didn't
> investigate more).
> 
> However, I saw another discussion related to transmute:
> 
> https://lore.kernel.org/linux-security-module/20230419002338.566487-1-mengcc@amazon.com/
> 
> I add the people in CC.
> 
> The steps described were so easy to understand and executed, I tried
> without and with overlayfs.
> 
> Without:
> 
> # echo "_ system rwxatl" > /sys/fs/smackfs/load2
> # mkdir /data
> # chsmack -a "system" /data
> # chsmack -t /data
> # mkdir -p /data/dir1/dir2
> # chsmack /data/dir1
> /data/dir1 access="system" transmute="TRUE"
> # chsmack /data/dir1/dir2
> /data/dir1/dir2 access="system" transmute="TRUE"
> 
> It seems to work, right?
> 
> With overlay fs it didn't work, same result as the one Mengchi
> reported. Since Mengchi's solution was to set SMK_INODE_CHANGED, and I
> want to get rid of it, I thought to investigate more.
> 
> Looking at smack_dentry_create_files_as(), I see that the label of the
> process is overwritten with the label of the transmuting directory.
> 
> That causes smack_inode_init_security() to lookup the transmuting rule
> on the overridden credential, and not on the original one.
> 
> In the example above, it means that, when overlayfs is creating the new
> inode, the label of the process is system, not _. So no transmute
> permission, and also the xattr will not be added, as observed by
> Mengchi.
> 
> Hopefully I undertood the code, so in this particular case we would not
> need to override the label of the process in smack_dentry_create_files_
> as().
> 
> If you see smack_inode_init_security():
> 
> 	struct smack_known *skp = smk_of_current();
> 	struct smack_known *isp = smk_of_inode(inode);
> 	struct smack_known *dsp = smk_of_inode(dir);
> 
> [...]
> 
> 		if (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
> 		    smk_inode_transmutable(dir)) {
> 			isp = dsp;
> [...]
> 
> 		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
> 
> This code is telling, if there is a transmute rule, and the directory
> is transmuting, set the label of the new inode to the label of the
> directory. That should be already the result that we wanted to obtain.
> 
> The current code should have been doing it by overriding the label of
> the process in smack_dentry_create_files_as() with the label of the
> parent directory, and letting the inode being created with the
> overridden label of the process. The transmute xattr is not set due to
> the problem described above.
> 
> So, as a quick test, I kept this patch with the change to xattr2->name, 
> and skipped the label override in smack_dentry_create_files_as(). It
> worked, I get the same result as without overlayfs. Wondering if the
> process label override is necessary in other cases.

If I understand correctly, removing the if block below is what you suggested.

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index cfcbb748da25..a867288e9de9 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4769,8 +4769,8 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
                 * providing access is transmuting use the containing
                 * directory label instead of the process label.
                 */
-               if (may > 0 && (may & MAY_TRANSMUTE))
-                       ntsp->smk_task = isp->smk_inode;
+//             if (may > 0 && (may & MAY_TRANSMUTE))
+//                     ntsp->smk_task = isp->smk_inode;
        }
        return 0;
 }

This way will have issue in the following situation on the vanila kernel.
data in the lowerdir has "_" label before overlay and dir1 is already
created in the lowerdir.
# chsmack /data
/data access="_"
# chsmack /data/dir1
/data/dir1 access="system" transmute="TRUE"
Apply overlay on data directory and set the smack rule in the same way.
data has the same smack label.
# chsmack /data
/data access="system" transmute="TRUE"
After that, remove dir1 and mkdir dir1 again. dir1 did not get the correct
label.
# rm -r /data/dir1
# mkdir -p /data/dir1
# chsmack /data/dir1
/data/dir1 access="_"

Since I am not very familiar your change. Could you help check with your
patch will this issue also happen? 


Best,
Mengchi

>  
> Roberto
