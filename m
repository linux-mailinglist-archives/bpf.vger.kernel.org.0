Return-Path: <bpf+bounces-4727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E3374E778
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 08:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F549281052
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 06:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAA41643E;
	Tue, 11 Jul 2023 06:40:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AF0211F
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 06:40:47 +0000 (UTC)
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA64793;
	Mon, 10 Jul 2023 23:40:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4R0WF02hWlz9v7Yk;
	Tue, 11 Jul 2023 14:29:40 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwB3IjlH+axkNk5bBA--.35225S2;
	Tue, 11 Jul 2023 07:40:19 +0100 (CET)
Message-ID: <badbc85145959e90cb9cbf9d21e0a43ea112776e.camel@huaweicloud.com>
Subject: Re: [PATCH v12 1/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, eparis@parisplace.org, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org, 
	nicolas.bouchinet@clip-os.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Tue, 11 Jul 2023 08:40:03 +0200
In-Reply-To: <CAHC9VhSFy6wf+7DXrG=6CXZC4RrpTeP2sQezX0BPc95fxGAWxQ@mail.gmail.com>
References: <20230610075738.3273764-2-roberto.sassu@huaweicloud.com>
	 <1c8c612d99e202a61e6a6ecf50d4cace.paul@paul-moore.com>
	 <a28c8fce-741b-e088-af5e-8a83daa7e25d@schaufler-ca.com>
	 <CAHC9VhSNqzVpHcDw59a2CznaME1078SJWuEcqJx=R5PQgSjTDg@mail.gmail.com>
	 <CAHC9VhSFy6wf+7DXrG=6CXZC4RrpTeP2sQezX0BPc95fxGAWxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwB3IjlH+axkNk5bBA--.35225S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF48uF48Aw1fuFW7GFy8Krg_yoWrGry7pF
	Wft3Wjkrs5JF1fAr9ayw48W3Wak3yrGr4UWr9xtr1UZas09r1xJr1jkr4ruFyUZrWkGFn0
	qF1UXr9xurn8A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj4wlKwADs5
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-07-10 at 14:04 -0400, Paul Moore wrote:
> On Fri, Jul 7, 2023 at 5:44=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Fri, Jul 7, 2023 at 12:54=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> > > On 7/6/2023 6:43 PM, Paul Moore wrote:
> > > > On Jun 10, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote=
:
> > > > > Currently, the LSM infrastructure supports only one LSM providing=
 an xattr
> > > > > and EVM calculating the HMAC on that xattr, plus other inode meta=
data.
> > > > >=20
> > > > > Allow all LSMs to provide one or multiple xattrs, by extending th=
e security
> > > > > blob reservation mechanism. Introduce the new lbs_xattr_count fie=
ld of the
> > > > > lsm_blob_sizes structure, so that each LSM can specify how many x=
attrs it
> > > > > needs, and the LSM infrastructure knows how many xattr slots it s=
hould
> > > > > allocate.
> > > > >=20
> > > > > Modify the inode_init_security hook definition, by passing the fu=
ll
> > > > > xattr array allocated in security_inode_init_security(), and the =
current
> > > > > number of xattr slots in that array filled by LSMs. The first par=
ameter
> > > > > would allow EVM to access and calculate the HMAC on xattrs suppli=
ed by
> > > > > other LSMs, the second to not leave gaps in the xattr array, when=
 an LSM
> > > > > requested but did not provide xattrs (e.g. if it is not initializ=
ed).
> > > > >=20
> > > > > Introduce lsm_get_xattr_slot(), which LSMs can call as many times=
 as the
> > > > > number specified in the lbs_xattr_count field of the lsm_blob_siz=
es
> > > > > structure. During each call, lsm_get_xattr_slot() increments the =
number of
> > > > > filled xattrs, so that at the next invocation it returns the next=
 xattr
> > > > > slot to fill.
> > > > >=20
> > > > > Cleanup security_inode_init_security(). Unify the !initxattrs and
> > > > > initxattrs case by simply not allocating the new_xattrs array in =
the
> > > > > former. Update the documentation to reflect the changes, and fix =
the
> > > > > description of the xattr name, as it is not allocated anymore.
> > > > >=20
> > > > > Adapt both SELinux and Smack to use the new definition of the
> > > > > inode_init_security hook, and to call lsm_get_xattr_slot() to obt=
ain and
> > > > > fill the reserved slots in the xattr array.
> > > > >=20
> > > > > Move the xattr->name assignment after the xattr->value one, so th=
at it is
> > > > > done only in case of successful memory allocation.
> > > > >=20
> > > > > Finally, change the default return value of the inode_init_securi=
ty hook
> > > > > from zero to -EOPNOTSUPP, so that BPF LSM correctly follows the h=
ook
> > > > > conventions.
> > > > >=20
> > > > > Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
> > > > > Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@ar=
chlinux/
> > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > ---
> > > > >  include/linux/lsm_hook_defs.h |  6 +--
> > > > >  include/linux/lsm_hooks.h     | 20 ++++++++++
> > > > >  security/security.c           | 71 +++++++++++++++++++++++------=
------
> > > > >  security/selinux/hooks.c      | 17 +++++----
> > > > >  security/smack/smack_lsm.c    | 25 ++++++------
> > > > >  5 files changed, 92 insertions(+), 47 deletions(-)
> > > > Two *very* small suggestions below, but I can make those during the
> > > > merge if you are okay with that Roberto?
> > > >=20
> > > > I'm also going to assume that Casey is okay with the Smack portion =
of
> > > > this patchset?  It looks fine to me, and considering his ACK on the
> > > > other Smack patch in this patchset I'm assuming he is okay with thi=
s
> > > > one as well ... ?
> > >=20
> > > Yes, please feel free to add my Acked-by as needed.
> >=20
> > Done.  Thanks Casey.
>=20
> I'm merging the full patchset into lsm/next right now.  Thanks for all
> your work on this Roberto, and a thank you for everyone else who
> helped with reviews, testing, etc.

Thanks Paul, also for making the patch set better!

Roberto


