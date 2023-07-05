Return-Path: <bpf+bounces-4067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7253D74880F
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 17:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33521C20AD2
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 15:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A1C11CAB;
	Wed,  5 Jul 2023 15:29:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A855111AF
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 15:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31E3C433C8;
	Wed,  5 Jul 2023 15:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688570942;
	bh=Mat839npoeJh/Tz7RCFIFfIGntbsPDu65YAK0n8NdEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udSh8k4i0iGOR3kNvzIghRWDHrv75FsNWw0blv+6GrlcTSjPskFlTS0E9wxnrd03M
	 Q8jOiPefK9fkWWQtgkXk6YkoCG6KjzqyFtAFXl8P/lwHUTyDak2W69xwSkEy8ToXat
	 yFC1mYnYpR4xvGoJDVg4Pa9utkmXbFW0kN0/FXdZH6d21kgJ8CPEdsoiv02+8tVuLa
	 z7RJXB3CXpzEi0wlaMiCYbiFvI5/nJZEYiDnCHdPM+nie2A6XuKy67cyItmx093vck
	 y4zFEBVXVXj4ETNQqYLQ62+lSSHexDZSSxMzDprlcIw2iFp4fP2m4R+ikNeqwiESAo
	 dotaRMlCYQZ+A==
Date: Wed, 5 Jul 2023 17:28:57 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v1] fs: Add kfuncs to handle idmapped mounts
Message-ID: <ZKWMOaAr7sgabAiW@example.org>
References: <c35fbb4cb0a3a9b4653f9a032698469d94ca6e9c.1688123230.git.legion@kernel.org>
 <babdf7a8-9663-6d71-821a-34da2aff80e2@huaweicloud.com>
 <ZKQ2kBiRDsQREw6f@example.org>
 <20230704-peitschen-inzwischen-7ad743c764e8@brauner>
 <ZKVzbQESW00w67qS@example.org>
 <20230705-blankziehen-halbwahrheiten-b52fae1fd86a@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705-blankziehen-halbwahrheiten-b52fae1fd86a@brauner>

On Wed, Jul 05, 2023 at 04:18:07PM +0200, Christian Brauner wrote:
> On Wed, Jul 05, 2023 at 03:43:09PM +0200, Alexey Gladkov wrote:
> > On Tue, Jul 04, 2023 at 05:28:13PM +0200, Christian Brauner wrote:
> > > On Tue, Jul 04, 2023 at 05:11:12PM +0200, Alexey Gladkov wrote:
> > > > On Tue, Jul 04, 2023 at 07:42:53PM +0800, Hou Tao wrote:
> > > > > Hi,
> > > > > 
> > > > > On 6/30/2023 7:08 PM, Alexey Gladkov wrote:
> > > > > > Since the introduction of idmapped mounts, file handling has become
> > > > > > somewhat more complicated. If the inode has been found through an
> > > > > > idmapped mount the idmap of the vfsmount must be used to get proper
> > > > > > i_uid / i_gid. This is important, for example, to correctly take into
> > > > > > account idmapped files when caching, LSM or for an audit.
> > > > > 
> > > > > Could you please add a bpf selftest for these newly added kfuncs ?
> > > > > >
> > > > > > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > > > > > ---
> > > > > >  fs/mnt_idmapping.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 69 insertions(+)
> > > > > >
> > > > > > diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> > > > > > index 4905665c47d0..ba98ce26b883 100644
> > > > > > --- a/fs/mnt_idmapping.c
> > > > > > +++ b/fs/mnt_idmapping.c
> > > > > > @@ -6,6 +6,7 @@
> > > > > >  #include <linux/mnt_idmapping.h>
> > > > > >  #include <linux/slab.h>
> > > > > >  #include <linux/user_namespace.h>
> > > > > > +#include <linux/bpf.h>
> > > > > >  
> > > > > >  #include "internal.h"
> > > > > >  
> > > > > > @@ -271,3 +272,71 @@ void mnt_idmap_put(struct mnt_idmap *idmap)
> > > > > >  		kfree(idmap);
> > > > > >  	}
> > > > > >  }
> > > > > > +
> > > > > > +__diag_push();
> > > > > > +__diag_ignore_all("-Wmissing-prototypes",
> > > > > > +		  "Global functions as their definitions will be in vmlinux BTF");
> > > > > > +
> > > > > > +/**
> > > > > > + * bpf_is_idmapped_mnt - check whether a mount is idmapped
> > > > > > + * @mnt: the mount to check
> > > > > > + *
> > > > > > + * Return: true if mount is mapped, false if not.
> > > > > > + */
> > > > > > +__bpf_kfunc bool bpf_is_idmapped_mnt(struct vfsmount *mnt)
> > > > > > +{
> > > > > > +	return is_idmapped_mnt(mnt);
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * bpf_file_mnt_idmap - get file idmapping
> > > > > > + * @file: the file from which to get mapping
> > > > > > + *
> > > > > > + * Return: The idmap for the @file.
> > > > > > + */
> > > > > > +__bpf_kfunc struct mnt_idmap *bpf_file_mnt_idmap(struct file *file)
> > > > > > +{
> > > > > > +	return file_mnt_idmap(file);
> > > > > > +}
> > > > > 
> > > > > A dummy question here: the implementation of file_mnt_idmap() is
> > > > > file->f_path.mnt->mnt_idmap, so if the passed file is a BTF pointer, is
> > > > > there any reason why we could not do such dereference directly in bpf
> > > > > program ?
> > > > 
> > > > I wanted to provide a minimal API for bpf programs. I thought that this
> > > > interface is stable enough, but after reading Christian's answer, it looks
> > > > like I was wrong.
> > > 
> > > It isn't even about stability per se. It's unlikely that if we change
> > > internal details that types or arguments to these helpers change. That's
> > > why we did the work of abstracting this all away in the first place and
> > > making this an opaque type.
> > > 
> > > The wider point is that according to the docs, kfuncs claim to have
> > > equivalent status to EXPORT_SYMBOL_*() with the added complexity of
> > > maybe having to take out of tree bpf programs into account.
> > > 
> > > Right now, we can look at the in-kernel users of is_idmapped_mnt(),
> > > convert them and then kill this thing off if we wanted to. As soon as
> > > this is a kfunc such an endeavour becomes a measure of "f**** around and
> > > find out". That's an entirely avoidable conflict if we don't even expose
> > > it in the first place.
> > > 
> > 
> > I was hoping to make it possible to use is_idmapped_mnt or its equivalent
> > to at least be able to distinguish a file with an idmapped mount from a
> > regular one.
> 
> Afaict, you can do this today pretty easily. For example,
> 
> #!/usr/bin/env bpftrace
> 
> #include <linux/mount.h>
> #include <linux/path.h>
> #include <linux/dcache.h>
> 
> kfunc:do_move_mount
> {
>         printf("Target path           %s\n", str(args->new_path->dentry->d_name.name));
>         printf("Target mount idmapped %d\n", args->new_path->mnt->mnt_idmap != kaddr("nop_mnt_idmap"));
> }
> 
> sample output:
> 
> Target path           console
> Target mount idmapped 0
> Target path           rootfs
> Target mount idmapped 1
> 

Well, it's a possible solution, but in this case we don't limit the bpf
programs in hacking. But on the other hand it will be only their problem.

Since this is the current strategy, this is suitable for me.

-- 
Rgrds, legion


