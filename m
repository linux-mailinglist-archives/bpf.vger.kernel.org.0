Return-Path: <bpf+bounces-75007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 907CFC6BE37
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 23:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D34C4E4D19
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 22:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A024A2EAB64;
	Tue, 18 Nov 2025 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLTGDx4j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139542BEC42;
	Tue, 18 Nov 2025 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505896; cv=none; b=S4OeXW2DtrCGfdX76Mxrpk9sFgCri0rgYumcRWN5hnsPqtY35a5Bbct0oJ5+cLuiWX/pckBKj9qJogTLrpiZZnrRHeen71fW74Z6zNUtQ893yosRFMutk1rqiKeLGbqiYFhpTYpN+ePVnMT1Ajhl3Ib9Z2kvEjc9rvJtlBkg80U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505896; c=relaxed/simple;
	bh=KvM4sw5d11P00xzno+X5e9UaJIpcGEJfE9v6laupK1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kr4gs+Nwbga7KMjl5kSEtuf6J5iIJiK5SW6sIAXawBmrhdGuTU00N8dvlJnsbfOGsxa/M5EWa7iFpMhfAsv4ks3BsNz6IhOhw4GmjR3V01EEuJia8HsE4pUlzZUqmaMtHMtSnPDKycbTEBAS0JxGAHm+etN5eRdfS/1vb24FOmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLTGDx4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3A7C2BCAF;
	Tue, 18 Nov 2025 22:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763505894;
	bh=KvM4sw5d11P00xzno+X5e9UaJIpcGEJfE9v6laupK1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JLTGDx4jkYO6rCsLPTkfwcGiYcDeLR7/nVDsghDGniU+c6haoY7REaiN1wy3sBlq9
	 S1Nx/SQUNHYJzFYW4DRllsixtoyyp/z5EwPSAfaxytqjmLjM5Dyz9qZOt9GuNlhP9S
	 CEDQmNM5EHH2448doM3f0Cx8X+uz/iUSnP+Ojva/p3O6299cR8zioP7BcoYWpmAUo2
	 8TrFbVfbFfqiy5367kLCW+wwOTigWd0zQxJceJ5lXZ+N1IwOPma7GgW0fQskrRVRo2
	 PPso+aj/XoqEE0emE98JGMwkcULoKFxl0uhcw0ahNwqCoY4uoeT7hW5MCZUSasVRxk
	 Uc9tZlxit/BCg==
Date: Tue, 18 Nov 2025 15:44:48 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, kvmarm@lists.linux.dev
Subject: Re: [PATCH v3 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
Message-ID: <20251118224448.GA998046@ax162>
References: <20251117173530.43293-1-vishal.moola@gmail.com>
 <20251117173530.43293-2-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117173530.43293-2-vishal.moola@gmail.com>

Hi Vishal,

On Mon, Nov 17, 2025 at 09:35:27AM -0800, Vishal Moola (Oracle) wrote:
> Vmalloc explicitly supports a list of flags, but we never enforce them.
> vmalloc has been trying to handle unsupported flags by clearing and
> setting flags wherever necessary. This is messy and makes the code
> harder to understand, when we could simply check for a supported input
> immediately instead.
> 
> Define a helper mask and function telling callers they have passed in
> invalid flags, and clear those unsupported vmalloc flags.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/vmalloc.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 0832f944544c..5dc467c6cab4 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3911,6 +3911,28 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	return NULL;
>  }
>  
> +/*
> + * See __vmalloc_node_range() for a clear list of supported vmalloc flags.
> + * This gfp lists all flags currently passed through vmalloc. Currently,
> + * __GFP_ZERO is used by BPF and __GFP_NORETRY is used by percpu. Both drm
> + * and BPF also use GFP_USER. Additionally, various users pass
> + * GFP_KERNEL_ACCOUNT.
> + */
> +#define GFP_VMALLOC_SUPPORTED (GFP_KERNEL | GFP_ATOMIC | GFP_NOWAIT |\
> +				__GFP_NOFAIL |  __GFP_ZERO | __GFP_NORETRY |\
> +				GFP_NOFS | GFP_NOIO | GFP_KERNEL_ACCOUNT |\
> +				GFP_USER)
> +
> +static gfp_t vmalloc_fix_flags(gfp_t flags)
> +{
> +	gfp_t invalid_mask = flags & ~GFP_VMALLOC_SUPPORTED;
> +
> +	flags &= GFP_VMALLOC_SUPPORTED;
> +	WARN(1, "Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
> +			invalid_mask, &invalid_mask, flags, &flags);
> +	return flags;
> +}

I am seeing this warning trigger when starting a VM on one of my arm64
boxes.

  [ 6345.145795] ------------[ cut here ]------------
  [ 6345.145803] Unexpected gfp: 0x2 (__GFP_HIGHMEM). Fixing up to gfp: 0x400dc0 (GFP_KERNEL_ACCOUNT|__GFP_ZERO). Fix your code!
  [ 6345.145819] WARNING: mm/vmalloc.c:3940 at vmalloc_fix_flags+0x60/0x90, CPU#32: qemu-system-aar/4325
  [ 6345.176990] Modules linked in: ...
  [ 6345.254421] CPU: 32 UID: 1000 PID: 4325 Comm: qemu-system-aar Not tainted 6.18.0-rc6-next-20251118-00002-g2331e73a4769 #1 PREEMPT(voluntary)
  [ 6345.267101] Hardware name: To be filled by O.E.M Ampere Altra Developer Platform/Ampere Altra Developer Platform, BIOS TianoCore 2.10.100.02 (SYS: 2.10.20
  [ 6345.280907] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  [ 6345.287856] pc : vmalloc_fix_flags+0x60/0x90
  [ 6345.292115] lr : vmalloc_fix_flags+0x58/0x90
  [ 6345.296374] sp : ffff80008d5b3a10
  [ 6345.299676] x29: ffff80008d5b3a20 x28: ffff07ff8a148000 x27: 0000000000000000
  [ 6345.306800] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
  [ 6345.313923] x23: 000000000000000b x22: 000000000000ae01 x21: 0000000000000028
  [ 6345.321047] x20: ffffc682ea643fbc x19: 0000000000001040 x18: ffff800083465050
  [ 6345.328170] x17: 00000000d949c370 x16: 00000000d949c370 x15: 0000000000000004
  [ 6345.335294] x14: 0000000000000002 x13: 0000000000000002 x12: 0000000000000000
  [ 6345.342417] x11: 0000000000000001 x10: ffffc682ec577744 x9 : bf6a46a6bf3b7900
  [ 6345.349541] x8 : bf6a46a6bf3b7900 x7 : 65646f632072756f x6 : 7920786946202e29
  [ 6345.356664] x5 : ffff081f6fcdc678 x4 : 0000000000000000 x3 : ffff80008d5b3688
  [ 6345.363788] x2 : 0000000000000021 x1 : 0000000000000000 x0 : 000000000000006f
  [ 6345.370911] Call trace:
  [ 6345.373346]  vmalloc_fix_flags+0x60/0x90 (P)
  [ 6345.377606]  __vmalloc_noprof+0xa0/0xb0
  [ 6345.381431]  kvm_arch_alloc_vm+0x64/0x70
  [ 6345.385344]  kvm_dev_ioctl+0x9c/0x58c
  [ 6345.388997]  __arm64_sys_ioctl+0xb0/0x100
  [ 6345.392995]  invoke_syscall+0x84/0xf4
  [ 6345.396648]  el0_svc_common.llvm.4390888008543260363+0x90/0xf4
  [ 6345.402469]  do_el0_svc+0x2c/0x3c
  [ 6345.405773]  el0_svc+0x54/0x2a8
  [ 6345.408905]  el0t_64_sync_handler+0x88/0x134
  [ 6345.413164]  el0t_64_sync+0x1b8/0x1bc
  [ 6345.416815] ---[ end trace 0000000000000000 ]---

where kvm_arch_alloc_vm() from arch/arm64/kvm/arm.c is

  struct kvm *kvm_arch_alloc_vm(void)
  {
      size_t sz = sizeof(struct kvm);

      if (!has_vhe())
          return kzalloc(sz, GFP_KERNEL_ACCOUNT);

      return __vmalloc(sz, GFP_KERNEL_ACCOUNT | __GFP_HIGHMEM | __GFP_ZERO);
  }

Should __GFP_HIGHMEM be dropped from the call to __vmalloc? It looks
like it was added by commit 115bae923ac8 ("KVM: arm64: Add memcg
accounting to KVM allocations") back in 5.16.

Cheers,
Nathan

