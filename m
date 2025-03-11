Return-Path: <bpf+bounces-53819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99544A5C2B4
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 14:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13DBD7A9675
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 13:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F36B1CAA9A;
	Tue, 11 Mar 2025 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZ5e98Jp"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E5C1C245C
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699833; cv=none; b=GowFkGo/Ssj9uQU95IjZ/jQuPivYRmOZjx1RovcHFX4b0USCQkQN/v8aN9vbsbjKHNniODTFYCTT9/iAL7FVpFL2jK2Qevx8j5mi8Qy6jQmc2n3i5e9wp8pTuWnH4dgGcHhCc0j2Ur5wLrSo6NnzFqeN62219qFY3Jy0C2lOD5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699833; c=relaxed/simple;
	bh=l6zR6XGtKJ5X0OhwmHL3+OfRxrFGdi1TkJcer1hdk8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eeTW5zT96Jq4jJuYQZFFTTckxMgowdGYXmsdOEVDoIlPZoDIa0tlVHoWZI2ThEI0u2lRVWsVY2iGCIKxrNMkPKMXs6hZc5o4Qa9Ye82qR+L2fi8DGJbaPep5eIMcPvOEBm511mmBOollOy3SC6M283+pJGtchexnivjKeu2alBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZ5e98Jp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741699831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pEztC+tYEqmw4n/BkTKddXXttPyUOtkMeTZTPuQrQU=;
	b=gZ5e98Jp8JUR25heY/Yb3bboAm9IXb+WybL1RCjcXcTXOhJjxZ4/0FQKqG/PIQMrtXZ+DD
	N4xYypa1ffmUEnNbEpA7AnFZrUPUOys5RIpEKdX0QUED09ogOyO8CAcKE0dq5WFOo6P2s6
	i18m3vvN+PbyqPD3Dfd9AtK8wOJiHSY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-kqLrgj9lMQ6k8PpG0HaASg-1; Tue,
 11 Mar 2025 09:30:21 -0400
X-MC-Unique: kqLrgj9lMQ6k8PpG0HaASg-1
X-Mimecast-MFC-AGG-ID: kqLrgj9lMQ6k8PpG0HaASg_1741699818
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D90E91808869;
	Tue, 11 Mar 2025 13:30:16 +0000 (UTC)
Received: from fedora (unknown [10.22.88.194])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B40EF1955BCB;
	Tue, 11 Mar 2025 13:30:13 +0000 (UTC)
Date: Tue, 11 Mar 2025 09:30:11 -0400
From: Luiz Capitulino <luizcap@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the mm tree
Message-ID: <20250311093011.48fa9d08@fedora>
In-Reply-To: <20250311120422.1d9a8f80@canb.auug.org.au>
References: <20250311120422.1d9a8f80@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, 11 Mar 2025 12:04:22 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next merge of the bpf-next tree got a conflict in:
> 
>   mm/page_owner.c
> 
> between commit:
> 
>   a5bc091881fd ("mm: page_owner: use new iteration API")
> 
> from the mm-unstable branch of the mm tree and commit:
> 
>   8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
> 
> from the bpf-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

This looks good to me:

Reviewed-by: Luiz Capitulino <luizcap@redhat.com>

> -- 
> Cheers,
> Stephen Rothwell
>
> diff --cc mm/page_owner.c
> index 849d4a471b6c,90e31d0e3ed7..000000000000
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@@ -297,11 -293,17 +297,17 @@@ void __reset_page_owner(struct page *pa
>  
>  	page_owner = get_page_owner(page_ext);
>  	alloc_handle = page_owner->handle;
> +	page_ext_put(page_ext);
>  
> - 	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
> + 	/*
> + 	 * Do not specify GFP_NOWAIT to make gfpflags_allow_spinning() == false
> + 	 * to prevent issues in stack_depot_save().
> + 	 * This is similar to try_alloc_pages() gfp flags, but only used
> + 	 * to signal stack_depot to avoid spin_locks.
> + 	 */
> + 	handle = save_stack(__GFP_NOWARN);
>  -	__update_page_owner_free_handle(page_ext, handle, order, current->pid,
>  +	__update_page_owner_free_handle(page, handle, order, current->pid,
>   					current->tgid, free_ts_nsec);
>  -	page_ext_put(page_ext);
>   
>   	if (alloc_handle != early_handle)
>   		/*


