Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73C76E96B4
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 16:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjDTOLa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 10:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjDTOLa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 10:11:30 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F83A212D;
        Thu, 20 Apr 2023 07:11:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q2K8c0mhtz9v7fx;
        Thu, 20 Apr 2023 22:01:52 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwB3JDvmR0Fk1Yo8Ag--.1954S2;
        Thu, 20 Apr 2023 15:10:59 +0100 (CET)
Message-ID: <5a9ba6618b37a592cda13ce36ea35cf78c98122b.camel@huaweicloud.com>
Subject: Re: [PATCH] Smack modifications for: security: Allow all LSMs to
 provide xattrs for inode_init_security hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Mengchi Cheng <mengcc@amazon.com>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org, kamatam@amazon.com,
        yoonjaeh@amazon.com
Date:   Thu, 20 Apr 2023 16:10:42 +0200
In-Reply-To: <97849695ef53ab3186e59d8a2c6b74812f13ee19.camel@linux.ibm.com>
References: <c7f38789-fe47-8289-e73a-4d07fbaf791d@schaufler-ca.com>
         <20230411172337.340518-1-roberto.sassu@huaweicloud.com>
         <2dc6486f-ce9b-f171-14fe-48a90386e1b7@schaufler-ca.com>
         <8e7705972a0f306922d8bc4893cf940e319abb19.camel@huaweicloud.com>
         <72b46d0f-75c7-ac18-4984-2bf1d6dad352@schaufler-ca.com>
         <82ee6ddf66bb34470aa7b591df4d70783fdb2422.camel@huaweicloud.com>
         <91f05dc4-a4b7-b40a-ba1a-0ccc489c84b2@schaufler-ca.com>
         <5c50d98f1e5745c88270ae4ad3de6d9a803db4c6.camel@huaweicloud.com>
         <48c6073f-59b0-f5d1-532e-fe4b912b939d@schaufler-ca.com>
         <0fccab67e496f10f4ee7bf2220e70a655013935f.camel@huaweicloud.com>
         <c16dd895-f488-241d-0be8-e56e5f0c1adb@schaufler-ca.com>
         <a98ddf946c474a3500bdcd72766c6cb0043278ff.camel@huaweicloud.com>
         <97849695ef53ab3186e59d8a2c6b74812f13ee19.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwB3JDvmR0Fk1Yo8Ag--.1954S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy5WrW3Zr1kur17GFW3ZFb_yoW8ZFW5pF
        WIgayUKrs5tFWxGrZ2yr47Xa1I9rWrCF43JryYk34kAFn8Cr1ftFyFqw4Uuay8GrsYvr1Y
        vFWUZ398Zr1DXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBF1jj4xFswAAsD
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-04-20 at 06:44 -0400, Mimi Zohar wrote:
> On Thu, 2023-04-20 at 10:50 +0200, Roberto Sassu wrote:
> > > It's possible. It's been a long time since I've looked at this.
> > > I'm tempted to take a change to make overlayfs work upstream and
> > > then worry about the ima changes. There seems to be a lot more
> > > going on with the ima changes than is obvious from what's in the
> > > Smack code.
> 
> It doesn't sound like the patch set introduces the overlayfs bug.

Correct.

The first problem of overlayfs is that smack_dentry_create_files_as()
override the credentials in a way that transmuting is not detected
correctly anymore in smack_inode_init_security(). The process label is
already overwritten with the directory label, at the time smack_inode_i
nit_security() calls smk_access_entry(), so the latter will not find
the transmuting rule that refers to the original process label.

The second problem is that overlayfs temporarily creates the new
directory in the working directory, that does not necessarily have the
same label of the parent directory the new file/directory will be added
to, causing the transmuting to be computed incorrectly.

> The security_inode_init_security() change to initialize multiple LSMs
> and IMA xattrs and include them in the EVM hmac calculation is straight
> forward.
> 
> In addition, the patch set creates the infrastructure for allowing
> multiple per LSM xattrs, as requested, to be initialized in
> security_inode_init_security() and included in the EVM hmac.
> 
> Mimi
> 
> > We could also set only SMACK64 in smack_inode_init_security(), and move
> > SMACKTRANSMUTE64 later, when we figure out how to fix the case of
> > overlayfs.
> > 
> > IMA and EVM would work in both cases.

Thanks to Mimi, I realized that adding SMACKTRANSMUTE64 in
smack_inode_init_security() is actually necessary.
Calling __vfs_getxattr() in smack_d_instantiate() causes the xattr to
be added without EVM updating the HMAC (thus, making the HMAC invalid).

Thanks

Roberto

