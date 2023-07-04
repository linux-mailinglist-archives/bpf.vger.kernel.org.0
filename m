Return-Path: <bpf+bounces-3987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCB67474E8
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 17:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9C91C20A26
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 15:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5407663CF;
	Tue,  4 Jul 2023 15:05:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0D263B9
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 15:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96112C433C7;
	Tue,  4 Jul 2023 15:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688483128;
	bh=Qkcd9m+SV34/ZmoHIL3vzsBtk3lpli7AUFnp09k5ECU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNzRM70NlVz3IA8TUYe1rlXFMEeZMYsqqQ8lmHRk5mRY0vDsYO5lb0Tlcvv7/q5u1
	 CRQDRaIW6DihFX0UqgJvnT/5CPcdYF2hPrdqpukdf0sH4XiczO4NRmvsXUYyQ3m+VW
	 Mc0QlzKtTBXwP89SEQuzuajRLwKfXui3Qh/q/MUyRZK3xrEG/k+CK55P2QdMlUE+mM
	 YnAZDWxeTOmi0U/MxfNwMtqDqHytCF7+/hJ3nqa660wrQH9Q3mGCfwo4Z4n/NCfkAk
	 kquHZhc2hzBsPVJ5r1DiYC3P0+yANrFFuSCld4AuOKmAF12nhT0nMJqN/Ueqf385wK
	 iY2ZZTJ5Ymt4w==
Date: Tue, 4 Jul 2023 17:05:22 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v1] fs: Add kfuncs to handle idmapped mounts
Message-ID: <ZKQ1Mkf5G9CA1/9J@example.org>
References: <c35fbb4cb0a3a9b4653f9a032698469d94ca6e9c.1688123230.git.legion@kernel.org>
 <babdf7a8-9663-6d71-821a-34da2aff80e2@huaweicloud.com>
 <20230704-anrollen-beenden-9187c7b1b570@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704-anrollen-beenden-9187c7b1b570@brauner>

On Tue, Jul 04, 2023 at 03:01:21PM +0200, Christian Brauner wrote:
> On Tue, Jul 04, 2023 at 07:42:53PM +0800, Hou Tao wrote:
> > Hi,
> > 
> > On 6/30/2023 7:08 PM, Alexey Gladkov wrote:
> > > Since the introduction of idmapped mounts, file handling has become
> > > somewhat more complicated. If the inode has been found through an
> > > idmapped mount the idmap of the vfsmount must be used to get proper
> > > i_uid / i_gid. This is important, for example, to correctly take into
> > > account idmapped files when caching, LSM or for an audit.
> > 
> > Could you please add a bpf selftest for these newly added kfuncs ?
> > >
> > > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > > ---
> > >  fs/mnt_idmapping.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 69 insertions(+)
> > >
> > > diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> > > index 4905665c47d0..ba98ce26b883 100644
> > > --- a/fs/mnt_idmapping.c
> > > +++ b/fs/mnt_idmapping.c
> > > @@ -6,6 +6,7 @@
> > >  #include <linux/mnt_idmapping.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/user_namespace.h>
> > > +#include <linux/bpf.h>
> > >  
> > >  #include "internal.h"
> > >  
> > > @@ -271,3 +272,71 @@ void mnt_idmap_put(struct mnt_idmap *idmap)
> > >  		kfree(idmap);
> > >  	}
> > >  }
> > > +
> > > +__diag_push();
> > > +__diag_ignore_all("-Wmissing-prototypes",
> > > +		  "Global functions as their definitions will be in vmlinux BTF");
> > > +
> > > +/**
> > > + * bpf_is_idmapped_mnt - check whether a mount is idmapped
> > > + * @mnt: the mount to check
> > > + *
> > > + * Return: true if mount is mapped, false if not.
> > > + */
> > > +__bpf_kfunc bool bpf_is_idmapped_mnt(struct vfsmount *mnt)
> > > +{
> > > +	return is_idmapped_mnt(mnt);
> > > +}
> > > +
> > > +/**
> > > + * bpf_file_mnt_idmap - get file idmapping
> > > + * @file: the file from which to get mapping
> > > + *
> > > + * Return: The idmap for the @file.
> > > + */
> > > +__bpf_kfunc struct mnt_idmap *bpf_file_mnt_idmap(struct file *file)
> > > +{
> > > +	return file_mnt_idmap(file);
> > > +}
> > 
> > A dummy question here: the implementation of file_mnt_idmap() is
> > file->f_path.mnt->mnt_idmap, so if the passed file is a BTF pointer, is
> > there any reason why we could not do such dereference directly in bpf
> > program ?
> > > +
> > > +/**
> > > + * bpf_inode_into_vfs_ids - map an inode's i_uid and i_gid down according to an idmapping
> > > + * @idmap: idmap of the mount the inode was found from
> > > + * @inode: inode to map
> > > + *
> > > + * The inode's i_uid and i_gid mapped down according to @idmap. If the inode's
> > > + * i_uid or i_gid has no mapping INVALID_VFSUID or INVALID_VFSGID is returned in
> > > + * the corresponding position.
> > > + *
> > > + * Return: A 64-bit integer containing the current GID and UID, and created as
> > > + * such: *gid* **<< 32 \|** *uid*.
> > > + */
> > > +__bpf_kfunc uint64_t bpf_inode_into_vfs_ids(struct mnt_idmap *idmap,
> > > +		const struct inode *inode)
> > > +{
> > > +	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
> > > +	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
> > > +
> > > +	return (u64) __vfsgid_val(vfsgid) << 32 |
> > > +		     __vfsuid_val(vfsuid);
> > > +}
> > > +
> > > +__diag_pop();
> > > +
> > > +BTF_SET8_START(idmap_btf_ids)
> > > +BTF_ID_FLAGS(func, bpf_is_idmapped_mnt)
> > > +BTF_ID_FLAGS(func, bpf_file_mnt_idmap)
> > > +BTF_ID_FLAGS(func, bpf_inode_into_vfs_ids)
> > > +BTF_SET8_END(idmap_btf_ids)
> > > +
> > > +static const struct btf_kfunc_id_set idmap_kfunc_set = {
> > > +	.owner = THIS_MODULE,
> > > +	.set   = &idmap_btf_ids,
> > > +};
> > > +
> > > +static int __init bpf_idmap_kfunc_init(void)
> > > +{
> > > +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &idmap_kfunc_set);
> > > +}
> > > +
> > Is BPF_PROG_TYPE_TRACING sufficient for your use case ? It seems
> > BPF_PROG_TYPE_UNSPEC will make these kfuncs be available for all bpf
> > program types.
> > > +late_initcall(bpf_idmap_kfunc_init);
> > 
> 
> I don't want any of these helpers as kfuncs as they are peeking deeply
> into implementation details that we reserve to change. Specifically in
> the light of:
> 
>     3. kfunc lifecycle expectations part b):
> 
>     "Unlike with regular kernel symbols, this is expected behavior for BPF
>      symbols, and out-of-tree BPF programs that use kfuncs should be considered
>      relevant to discussions and decisions around modifying and removing those
>      kfuncs. The BPF community will take an active role in participating in
>      upstream discussions when necessary to ensure that the perspectives of such
>      users are taken into account."
> 
> That's too much stability for my taste for these helpers. The helpers
> here exposed have been modified multiple times and once we wean off
> idmapped mounts from user namespaces completely they will change again.
> So I'm fine if they're traceable but not as kfuncs with any - even
> minimal - stability guarantees.

I thought that the mnt_idmap interface is already quite stable. I wanted
to give a minimal interface to bpf programs.

Would it be better if I hide the mnt_idmap inside the helper or are you
against using kfuncs at the moment ?

Like that:

__bpf_kfunc uint64_t bpf_get_file_vfs_ids(struct file *file)
{
	struct mnt_idmap *idmap = file_mnt_idmap(file);
	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, file->f_inode);
	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, file->f_inode);

	return (u64) __vfsgid_val(vfsgid) << 32 |
		     __vfsuid_val(vfsuid);
}

-- 
Rgrds, legion


