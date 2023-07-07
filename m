Return-Path: <bpf+bounces-4405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220A074AB5E
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 08:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75322816CE
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 06:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B308538F;
	Fri,  7 Jul 2023 06:50:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCDD1FB7
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 06:50:33 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8531FDA;
	Thu,  6 Jul 2023 23:49:59 -0700 (PDT)
Received: from frapeml500007.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qy3pB2SwYz67L0F;
	Fri,  7 Jul 2023 14:46:26 +0800 (CST)
Received: from frapeml500005.china.huawei.com (7.182.85.13) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 08:49:26 +0200
Received: from frapeml500005.china.huawei.com ([7.182.85.13]) by
 frapeml500005.china.huawei.com ([7.182.85.13]) with mapi id 15.01.2507.027;
 Fri, 7 Jul 2023 08:49:26 +0200
From: Roberto Sassu <roberto.sassu@huawei.com>
To: Paul Moore <paul@paul-moore.com>, Roberto Sassu
	<roberto.sassu@huaweicloud.com>, "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
	"dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>, "jmorris@namei.org"
	<jmorris@namei.org>, "serge@hallyn.com" <serge@hallyn.com>,
	"stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
	"eparis@parisplace.org" <eparis@parisplace.org>, "casey@schaufler-ca.com"
	<casey@schaufler-ca.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "selinux@vger.kernel.org"
	<selinux@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "keescook@chromium.org"
	<keescook@chromium.org>, "nicolas.bouchinet@clip-os.org"
	<nicolas.bouchinet@clip-os.org>
Subject: RE: [PATCH v12 1/4] security: Allow all LSMs to provide xattrs for
  inode_init_security hook
Thread-Topic: [PATCH v12 1/4] security: Allow all LSMs to provide xattrs for
  inode_init_security hook
Thread-Index: AQHZsHSGuRovFN0LUUi8HyIwTywt+q+t3OnA
Date: Fri, 7 Jul 2023 06:49:26 +0000
Message-ID: <8fd08063bc6b4325b9785052d02da9f2@huawei.com>
References: <20230610075738.3273764-2-roberto.sassu@huaweicloud.com>
 <1c8c612d99e202a61e6a6ecf50d4cace.paul@paul-moore.com>
In-Reply-To: <1c8c612d99e202a61e6a6ecf50d4cace.paul@paul-moore.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> From: Paul Moore [mailto:paul@paul-moore.com]
> Sent: Friday, July 7, 2023 3:44 AM
> On Jun 10, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> >
> > Currently, the LSM infrastructure supports only one LSM providing an xa=
ttr
> > and EVM calculating the HMAC on that xattr, plus other inode metadata.
> >
> > Allow all LSMs to provide one or multiple xattrs, by extending the secu=
rity
> > blob reservation mechanism. Introduce the new lbs_xattr_count field of =
the
> > lsm_blob_sizes structure, so that each LSM can specify how many xattrs =
it
> > needs, and the LSM infrastructure knows how many xattr slots it should
> > allocate.
> >
> > Modify the inode_init_security hook definition, by passing the full
> > xattr array allocated in security_inode_init_security(), and the curren=
t
> > number of xattr slots in that array filled by LSMs. The first parameter
> > would allow EVM to access and calculate the HMAC on xattrs supplied by
> > other LSMs, the second to not leave gaps in the xattr array, when an LS=
M
> > requested but did not provide xattrs (e.g. if it is not initialized).
> >
> > Introduce lsm_get_xattr_slot(), which LSMs can call as many times as th=
e
> > number specified in the lbs_xattr_count field of the lsm_blob_sizes
> > structure. During each call, lsm_get_xattr_slot() increments the number=
 of
> > filled xattrs, so that at the next invocation it returns the next xattr
> > slot to fill.
> >
> > Cleanup security_inode_init_security(). Unify the !initxattrs and
> > initxattrs case by simply not allocating the new_xattrs array in the
> > former. Update the documentation to reflect the changes, and fix the
> > description of the xattr name, as it is not allocated anymore.
> >
> > Adapt both SELinux and Smack to use the new definition of the
> > inode_init_security hook, and to call lsm_get_xattr_slot() to obtain an=
d
> > fill the reserved slots in the xattr array.
> >
> > Move the xattr->name assignment after the xattr->value one, so that it =
is
> > done only in case of successful memory allocation.
> >
> > Finally, change the default return value of the inode_init_security hoo=
k
> > from zero to -EOPNOTSUPP, so that BPF LSM correctly follows the hook
> > conventions.
> >
> > Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
> > Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlinu=
x/
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  include/linux/lsm_hook_defs.h |  6 +--
> >  include/linux/lsm_hooks.h     | 20 ++++++++++
> >  security/security.c           | 71 +++++++++++++++++++++++------------
> >  security/selinux/hooks.c      | 17 +++++----
> >  security/smack/smack_lsm.c    | 25 ++++++------
> >  5 files changed, 92 insertions(+), 47 deletions(-)
>=20
> Two *very* small suggestions below, but I can make those during the
> merge if you are okay with that Roberto?

Hi Paul

yes, sure, I'm ok with them. Please make them during the merge.

Thanks

Roberto

> I'm also going to assume that Casey is okay with the Smack portion of
> this patchset?  It looks fine to me, and considering his ACK on the
> other Smack patch in this patchset I'm assuming he is okay with this
> one as well ... ?
>=20
> > diff --git a/security/security.c b/security/security.c
> > index ee4f1cc4902..d5ef7df1ce4 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1591,11 +1592,15 @@ EXPORT_SYMBOL(security_dentry_create_files_as);
> >   * created inode and set up the incore security field for the new inod=
e.  This
> >   * hook is called by the fs code as part of the inode creation transac=
tion and
> >   * provides for atomic labeling of the inode, unlike the post_create/m=
kdir/...
> > - * hooks called by the VFS.  The hook function is expected to allocate=
 the name
> > - * and value via kmalloc, with the caller being responsible for callin=
g kfree
> > - * after using them.  If the security module does not use security att=
ributes
> > - * or does not wish to put a security attribute on this particular ino=
de, then
> > - * it should return -EOPNOTSUPP to skip this processing.
> > + * hooks called by the VFS.  The hook function is expected to populate=
 the
> > + * @xattrs array, by calling lsm_get_xattr_slot() to retrieve the slot=
s
>=20
> I think we want to change "@xattrs array" to just "xattrs array" as
> there is no function parameter named "xattrs" in the LSM/security_XXX
> hook itself, just in the 'inode_init_security' hook implementation.
>=20
> I might also break the new text describing the hook implementation
> into a new paragraph.
>=20
> > + * reserved by the security module with the lbs_xattr_count field of t=
he
> > + * lsm_blob_sizes structure.  For each slot, the hook function should =
set ->name
> > + * to the attribute name suffix (e.g. selinux), to allocate ->value (w=
ill be
> > + * freed by the caller) and set it to the attribute value, to set ->va=
lue_len to
> > + * the length of the value.  If the security module does not use secur=
ity
> > + * attributes or does not wish to put a security attribute on this par=
ticular
> > + * inode, then it should return -EOPNOTSUPP to skip this processing.
> >   *
> >   * Return: Returns 0 on success, -EOPNOTSUPP if no security attribute =
is
> >   * needed, or -ENOMEM on memory allocation failure.
> > @@ -1604,33 +1609,51 @@ int security_inode_init_security(struct inode *=
inode, struct inode *dir,
> >  				 const struct qstr *qstr,
> >  				 const initxattrs initxattrs, void *fs_data)
> >  {
> > -	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
> > -	struct xattr *lsm_xattr, *evm_xattr, *xattr;
> > -	int ret;
> > +	struct security_hook_list *P;
>=20
> The above comments were nitpicky, this one is even more so ...
> convention within security/security.c is to call the
> security_hook_list pointer "hp", not "P" (although I recognize P is
> used in the macro).
>=20
> > +	struct xattr *new_xattrs =3D NULL;
> > +	int ret =3D -EOPNOTSUPP, xattr_count =3D 0;
>=20
> --
> paul-moore.com

