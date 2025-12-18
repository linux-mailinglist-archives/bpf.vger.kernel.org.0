Return-Path: <bpf+bounces-77025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE757CCD258
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87F19308AB8A
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 18:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518BE253958;
	Thu, 18 Dec 2025 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJZmdQFy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C556E1F4606;
	Thu, 18 Dec 2025 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766081942; cv=none; b=Gq6vDL6PeNPnXmkyl9LJ0IZP/wqCyxIGhWjKPqWno3bwOBPhxYwptwQUwDXLIQeRS/41bdzeDEHwfERaZ1QVcBwW0SlSkMxV5h0F3V1PmtXlK3oAWN83zrlHYgKrZQ4huILMBdeiYA0bmImOxhfnE+9/gzMie4CfWG6Q7CAEdiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766081942; c=relaxed/simple;
	bh=Byq0gQeVr8r94BMBgQHWvwmuI2Z+ZBlYY+sb7UmgvVs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=r7Tb5Kl6TuIwo4F2cyDY7qx2yN2IIa4Oo41gZNc1DEOiAFcWUeJDoldqJepnuF75yOHBjYWudY4tocxI4fYNrhePGSou+6C8KkhGJvk0t7OoxOm72/WwXxyUc0lyKSyUE1Rhd2LNjBMrtkS0FDr766IvMsJNL5D6nNdM869OmZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJZmdQFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098D0C4CEFB;
	Thu, 18 Dec 2025 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766081942;
	bh=Byq0gQeVr8r94BMBgQHWvwmuI2Z+ZBlYY+sb7UmgvVs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=NJZmdQFycXuwwVljU/LDzVxlSbmc+dOcyWBC7V04fcAKp6FxPi89OPL4FGkndV+V9
	 WSqXu7tKJuWI+sszJz4PORHM3U9z2SJAh4rSC9eqcmYA3uehnrNROv4GqMMHzBORX9
	 YGkvflAealueQkvyTTF3neRV6zUsrWzcXYv+HNpnXSMzhI2AKSutHypgkH0EPuGClQ
	 gAax+bekWwbycWIUXthlZ94TyQE61quckvNQ3SIInFGf2KpmBJ6KUvvcxwW6pf/CMV
	 bBgurp0T57O66dZx6mqfhKzQEfR763yIvKfX+nEMYlcYkZd5DklWiNbojy7RLPeFfs
	 1+6/f/tYiR1hA==
Content-Type: multipart/mixed; boundary="===============3648498011065644442=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1b0222eec86de05407965545ea7e224155a42050c27be3f36cfd067a2dd165e8@mail.kernel.org>
In-Reply-To: <20251218175628.1460321-3-ameryhung@gmail.com>
References: <20251218175628.1460321-3-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v3 02/16] bpf: Convert bpf_selem_link_map to failable
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,song@kernel.org,haoluo@google.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 18 Dec 2025 18:19:02 +0000 (UTC)

--===============3648498011065644442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 850dd736ccd1..4f8e917f49d9 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -191,7 +191,9 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
>  		}
>
>  		if (new_sk_storage) {
> -			bpf_selem_link_map(smap, copy_selem);
> +			ret = bpf_selem_link_map(smap, copy_selem);
> +			if (ret)
> +				goto out;
>  			bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
>  		} else {
>  			ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);

When bpf_selem_link_map() fails, is there missing cleanup here? Looking
at the else branch below (bpf_local_storage_alloc failure), the error
handling includes:

  - bpf_selem_free(copy_selem, true)
  - atomic_sub(smap->elem_size, &newsk->sk_omem_alloc)
  - bpf_map_put(map)

The new error path for bpf_selem_link_map() failure goes directly to the
out label without any of this cleanup. At this point in the code:

  - copy_selem was allocated by bpf_sk_storage_clone_elem() and charged
    via bpf_selem_alloc()->mem_charge()
  - map reference was taken via bpf_map_inc_not_zero()
  - copy_selem has not yet been linked to new_sk_storage (that happens
    in bpf_selem_link_storage_nolock() after the failing call)

The comment at the out label says the caller is responsible for cleanup
via bpf_sk_storage_free(), but since copy_selem was never linked to the
storage list, bpf_local_storage_destroy() will not find it.

Currently this is not triggerable since bpf_selem_link_map() always
returns 0, but commit 615477732ee8 ("bpf: Change local_storage->lock and
b->lock to rqspinlock") later in this series makes the function actually
return errors.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20346662777

--===============3648498011065644442==--

