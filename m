Return-Path: <bpf+bounces-3988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91B8747500
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 17:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DABD51C20A7B
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 15:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D31663D0;
	Tue,  4 Jul 2023 15:11:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C906DA2C
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 15:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294E9C433C7;
	Tue,  4 Jul 2023 15:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688483478;
	bh=wUuv2k6yustQUKSmYCZmh7t4L/YAMvaj2AqZ/Hb5lOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBhTevwfWaqSqdhx0njmTYyw5MwzcyeJWbHAQ1w1FMw+p1zfm2LEVnA/hYUEJCeLm
	 5eyrigJg9WW+XJAotEWqCKds4O9UNxPhcEUnLbD+n1D7FuGS9O+rNMeZEzmTx5M5gt
	 7Ehsmw/WTVajSnU03YevXok4oTSlEy4E9ExdyTpeEVONQk2J8lVzdjqtPkxYf5oiz8
	 FXG/GppAS67xAqXLWde27IneOKGizDnHlCB82kuYlV3re/UOSt4NswL+OoZigAjHmx
	 qyx8Fh9rY2Ygj1rwL6XvCJcGhQZYPgrZ+y1TmTzeoF0w82qO6fGE/3Onc4Dy0D8zIH
	 Xl2XOveZeOnTw==
Date: Tue, 4 Jul 2023 17:11:12 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v1] fs: Add kfuncs to handle idmapped mounts
Message-ID: <ZKQ2kBiRDsQREw6f@example.org>
References: <c35fbb4cb0a3a9b4653f9a032698469d94ca6e9c.1688123230.git.legion@kernel.org>
 <babdf7a8-9663-6d71-821a-34da2aff80e2@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <babdf7a8-9663-6d71-821a-34da2aff80e2@huaweicloud.com>

On Tue, Jul 04, 2023 at 07:42:53PM +0800, Hou Tao wrote:
> Hi,
> 
> On 6/30/2023 7:08 PM, Alexey Gladkov wrote:
> > Since the introduction of idmapped mounts, file handling has become
> > somewhat more complicated. If the inode has been found through an
> > idmapped mount the idmap of the vfsmount must be used to get proper
> > i_uid / i_gid. This is important, for example, to correctly take into
> > account idmapped files when caching, LSM or for an audit.
> 
> Could you please add a bpf selftest for these newly added kfuncs ?
> >
> > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > ---
> >  fs/mnt_idmapping.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >
> > diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> > index 4905665c47d0..ba98ce26b883 100644
> > --- a/fs/mnt_idmapping.c
> > +++ b/fs/mnt_idmapping.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/mnt_idmapping.h>
> >  #include <linux/slab.h>
> >  #include <linux/user_namespace.h>
> > +#include <linux/bpf.h>
> >  
> >  #include "internal.h"
> >  
> > @@ -271,3 +272,71 @@ void mnt_idmap_put(struct mnt_idmap *idmap)
> >  		kfree(idmap);
> >  	}
> >  }
> > +
> > +__diag_push();
> > +__diag_ignore_all("-Wmissing-prototypes",
> > +		  "Global functions as their definitions will be in vmlinux BTF");
> > +
> > +/**
> > + * bpf_is_idmapped_mnt - check whether a mount is idmapped
> > + * @mnt: the mount to check
> > + *
> > + * Return: true if mount is mapped, false if not.
> > + */
> > +__bpf_kfunc bool bpf_is_idmapped_mnt(struct vfsmount *mnt)
> > +{
> > +	return is_idmapped_mnt(mnt);
> > +}
> > +
> > +/**
> > + * bpf_file_mnt_idmap - get file idmapping
> > + * @file: the file from which to get mapping
> > + *
> > + * Return: The idmap for the @file.
> > + */
> > +__bpf_kfunc struct mnt_idmap *bpf_file_mnt_idmap(struct file *file)
> > +{
> > +	return file_mnt_idmap(file);
> > +}
> 
> A dummy question here: the implementation of file_mnt_idmap() is
> file->f_path.mnt->mnt_idmap, so if the passed file is a BTF pointer, is
> there any reason why we could not do such dereference directly in bpf
> program ?

I wanted to provide a minimal API for bpf programs. I thought that this
interface is stable enough, but after reading Christian's answer, it looks
like I was wrong.

> > +
> > +/**
> > + * bpf_inode_into_vfs_ids - map an inode's i_uid and i_gid down according to an idmapping
> > + * @idmap: idmap of the mount the inode was found from
> > + * @inode: inode to map
> > + *
> > + * The inode's i_uid and i_gid mapped down according to @idmap. If the inode's
> > + * i_uid or i_gid has no mapping INVALID_VFSUID or INVALID_VFSGID is returned in
> > + * the corresponding position.
> > + *
> > + * Return: A 64-bit integer containing the current GID and UID, and created as
> > + * such: *gid* **<< 32 \|** *uid*.
> > + */
> > +__bpf_kfunc uint64_t bpf_inode_into_vfs_ids(struct mnt_idmap *idmap,
> > +		const struct inode *inode)
> > +{
> > +	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
> > +	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
> > +
> > +	return (u64) __vfsgid_val(vfsgid) << 32 |
> > +		     __vfsuid_val(vfsuid);
> > +}
> > +
> > +__diag_pop();
> > +
> > +BTF_SET8_START(idmap_btf_ids)
> > +BTF_ID_FLAGS(func, bpf_is_idmapped_mnt)
> > +BTF_ID_FLAGS(func, bpf_file_mnt_idmap)
> > +BTF_ID_FLAGS(func, bpf_inode_into_vfs_ids)
> > +BTF_SET8_END(idmap_btf_ids)
> > +
> > +static const struct btf_kfunc_id_set idmap_kfunc_set = {
> > +	.owner = THIS_MODULE,
> > +	.set   = &idmap_btf_ids,
> > +};
> > +
> > +static int __init bpf_idmap_kfunc_init(void)
> > +{
> > +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &idmap_kfunc_set);
> > +}
> > +
> Is BPF_PROG_TYPE_TRACING sufficient for your use case ? It seems
> BPF_PROG_TYPE_UNSPEC will make these kfuncs be available for all bpf
> program types.

This can be used not only in BPF_PROG_TYPE_TRACING but also at least for
BPF_PROG_TYPE_LSM.

> > +late_initcall(bpf_idmap_kfunc_init);
> 
> 

-- 
Rgrds, legion


