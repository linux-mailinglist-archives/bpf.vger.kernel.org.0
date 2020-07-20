Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F124A227274
	for <lists+bpf@lfdr.de>; Tue, 21 Jul 2020 00:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgGTWoR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jul 2020 18:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgGTWoP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jul 2020 18:44:15 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94295C0619D4
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 15:44:15 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id h28so13958197edz.0
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 15:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vYYj1xkqdAsQ1FACIja4W5B8GUjTG6OnchmcXRlXDAM=;
        b=LhvbkMttHCYSIkbtKIEJKfKLYcHeua/U3mDmokc6dBBiJsdTOS9eQQVY9fXHQEpNSg
         bsBZjEcH/UvUgiyXF/bGXcjZfuUC/BGaS5rd6vGmLmfV0UaHgRLXjT0EXKUmsIqGPCBy
         Sb8dlD85mrzgrlGYZs+ZHYMQF4zJNXtsCPBXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vYYj1xkqdAsQ1FACIja4W5B8GUjTG6OnchmcXRlXDAM=;
        b=sDUL7x2evJO9ZtDMyI07+gXA64Bkx30Fdgev3irUENZmzwNpfWWUxUgofrbnbs4afH
         CzvlsBpjLDwp/tqEJ43qte5uTowULuOoceKOjEWkUr2lY76dbhy8IyFlERTa8Eyllm9B
         6Q7kkpVx4yZBvVedhfGjlEskqOKLTXcpBeP5fO3H2lztAdXxzmILgn5NQTsru+YEQC5o
         nN3WPPIhxNnkMpvPJBHWMTpprHVwyWnImgjKSb6DRxGUnzMnokzE8/v+0IMXu8qGcxQh
         R/aD0PnpcvG/BIe2nhnJ5CLbH7i1cdy0yjIOd8Tcijyoi0uyq7GLryx3jMbPvGnQs2YN
         9QuQ==
X-Gm-Message-State: AOAM530dvA6uRSekkvCRf5Y245m3D9PBQMwjkbVtbrnPoOLSnH38dYFg
        TjCjkvmibBzLlffYtRCa+6Nkpg==
X-Google-Smtp-Source: ABdhPJwOkJhYIctISfI3yYileJE3UyfLzhW9ibOBRJkJLPhkuKeNd9eypzHHnF3uimZ4IxjR5U9Q/Q==
X-Received: by 2002:a05:6402:3d0:: with SMTP id t16mr22865489edw.287.1595285053947;
        Mon, 20 Jul 2020 15:44:13 -0700 (PDT)
Received: from google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id cc9sm16719027edb.14.2020.07.20.15.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 15:44:13 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 21 Jul 2020 00:44:11 +0200
To:     KP Singh <kpsingh@chromium.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Implement bpf_local_storage for
 inodes
Message-ID: <20200720224411.GA1873800@google.com>
References: <20200709101239.3829793-1-kpsingh@chromium.org>
 <20200709101239.3829793-3-kpsingh@chromium.org>
 <20200715215751.6llgungzff66iwxh@kafai-mbp>
 <20200715225911.GA1194150@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715225911.GA1194150@google.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 16-Jul 00:59, KP Singh wrote:
> On 15-Jul 14:57, Martin KaFai Lau wrote:
> > On Thu, Jul 09, 2020 at 12:12:37PM +0200, KP Singh wrote:
> > > From: KP Singh <kpsingh@google.com>
> > > 
> > > Similar to bpf_local_storage for sockets, add local storage for inodes.
> > > The life-cycle of storage is managed with the life-cycle of the inode.
> > > i.e. the storage is destroyed along with the owning inode.
> > > 
> > > The BPF LSM allocates an __rcu pointer to the bpf_local_storage in the
> > > security blob which are now stackable and can co-exist with other LSMs.
> > > 
> > > Signed-off-by: KP Singh <kpsingh@google.com>
> > 
> > [ ... ]
> > 
> > 
> > > +static void *bpf_inode_storage_lookup_elem(struct bpf_map *map, void *key)
> > > +{
> > > +	struct bpf_local_storage_data *sdata;
> > > +	struct inode *inode;
> > > +	int err = -EINVAL;
> > > +
> > > +	if (key) {
> > > +		inode = *(struct inode **)(key);
> > The bpf_inode_storage_lookup_elem() here and the (update|delete)_elem() below
> > are called from the userspace syscall.  How the userspace may provide this key?
> 
> I realized this when I replied about the _fd_ name in the sk helpers.
> I am going to mark them as unsupported for now for inodes.
> 
> We could, probably and separately, use a combination of the device
> and inode number as a key from userspace.

I actually implemented these as:

static int bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
{
	struct file *f;
	int fd;

	fd = *(int *)key;
	f = fcheck(fd);
	if (!f)
		return -EINVAL;

	return inode_storage_delete(f->f_inode, map);
}

This keeps it similar to sk_storage and the userspace can just pass an
fd.

- KP

> 
> - KP
> 
> > 
> > > +		sdata = inode_storage_lookup(inode, map, true);
> > > +		return sdata ? sdata->data : NULL;
> > > +	}
> > > +
> > > +	return ERR_PTR(err);
> > > +}
> > > +
> > > +static int bpf_inode_storage_update_elem(struct bpf_map *map, void *key,
> > > +					 void *value, u64 map_flags)
> > > +{
> > > +	struct bpf_local_storage_data *sdata;
> > > +	struct inode *inode;
> > > +	int err = -EINVAL;
> > > +
> > > +	if (key) {
> > > +		inode = *(struct inode **)(key);
> > > +		sdata = map->ops->map_local_storage_update(inode, map, value,
> > > +							   map_flags);
> > > +		return PTR_ERR_OR_ZERO(sdata);
> > > +	}
> > > +	return err;
> > > +}
> > > +
> > > +static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
> > > +{
> > > +	struct bpf_local_storage_data *sdata;
> > > +
> > > +	sdata = inode_storage_lookup(inode, map, false);
> > > +	if (!sdata)
> > > +		return -ENOENT;
> > > +
> > > +	bpf_selem_unlink_map_elem(SELEM(sdata));
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int bpf_inode_storage_delete_elem(struct bpf_map *map, void *key)
> > > +{
> > > +	struct inode *inode;
> > > +	int err = -EINVAL;
> > > +
> > > +	if (key) {
> > > +		inode = *(struct inode **)(key);
> > > +		err = inode_storage_delete(inode, map);
> > > +	}
> > > +
> > > +	return err;
> > > +}
> > > +
> > 
> > [ ... ]
> > 
> > > +static int inode_storage_map_btf_id;
> > > +const struct bpf_map_ops inode_storage_map_ops = {
> > > +	.map_alloc_check = bpf_local_storage_map_alloc_check,
> > > +	.map_alloc = inode_storage_map_alloc,
> > > +	.map_free = inode_storage_map_free,
> > > +	.map_get_next_key = notsupp_get_next_key,
> > > +	.map_lookup_elem = bpf_inode_storage_lookup_elem,
> > > +	.map_update_elem = bpf_inode_storage_update_elem,
> > > +	.map_delete_elem = bpf_inode_storage_delete_elem,
> > > +	.map_check_btf = bpf_local_storage_map_check_btf,
> > > +	.map_btf_name = "bpf_local_storage_map",
> > > +	.map_btf_id = &inode_storage_map_btf_id,
> > > +	.map_local_storage_alloc = inode_storage_alloc,
> > > +	.map_selem_alloc = inode_selem_alloc,
> > > +	.map_local_storage_update = inode_storage_update,
> > > +	.map_local_storage_unlink = unlink_inode_storage,
> > > +};
> > > +
