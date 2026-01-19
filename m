Return-Path: <bpf+bounces-79484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A8ED3B620
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 19:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C6BD30DFC34
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 18:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D492A32ED2E;
	Mon, 19 Jan 2026 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpF8sx9y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F6832B9AA;
	Mon, 19 Jan 2026 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848346; cv=none; b=rTKs/3QObtSjyMFLBdHuNwZjyDMdb7uAW/tVBPYPDm59J0qJnj6yz0i4fcxSmnktjVLEDcobh+xSJjEV5REhO0NzYA57tEyHkH3PhjR2w7lK7nWFqyZGjDVAsgQ6HgwgC5DBSSDIwQZ2aE/G3ABFtoxQR0wSwk1s9jG6Kwi5YM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848346; c=relaxed/simple;
	bh=yTzhnxNPfBjOv4A7Jf5ZH8irOVDGh2doSfoTA1eXI+Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AES7VcHx8RpO8UccEKLXio8Zn9W1NQ3M3V8hiYWilvlcTPuWynVPdHRO/Ye5ZkP7u5gsSIM0+0CAXIaQvfLOcxY5AeO0TjtZOqQO7ZVCu7gsVxF494p9hqyf6XRlN4ntu0cgDQbiQvsY5z2Cj9z2DgUX6OvshZ0p03+gTvhq0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpF8sx9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFECC2BC9E;
	Mon, 19 Jan 2026 18:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848346;
	bh=yTzhnxNPfBjOv4A7Jf5ZH8irOVDGh2doSfoTA1eXI+Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=jpF8sx9yoPBK+75kbwEK/XDb70QQw06hL19NghwrNXIbWlVRW+qpdggcZmPJqCnIZ
	 xf7Xoa3xS4tsjCL+FN1anhTSqb3VlI3SLcIIDyrFqetIi65PHdgI+YtkFT8tUA6kXc
	 GyX/wUtM1+grvip66TDHhOMCmDVRxniustnSTJ+mPAmelDj/1NiLniFysOT30vucZQ
	 IRf5NlOtGqotpRWMhGqKP72SohWKAP3pfyV/bbUpKs+j7dLRE3kKAkQOloY0OyciPi
	 9f1gU/xqpmuMP82pIK3eKiVnig2KyYPM5+IXEtpQnDpRgEO7Ge+5r4BQIWtaX1TV3o
	 No1BBljt/DynQ==
Content-Type: multipart/mixed; boundary="===============3750611079457372937=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b66d576d542b902d53ae283373b076be72b6c39b2a2a9d0ed5fd401664c6ba11@mail.kernel.org>
In-Reply-To: <20260119032424.10781-3-piliu@redhat.com>
References: <20260119032424.10781-3-piliu@redhat.com>
Subject: Re: [PATCHv6 02/13] kexec_file: Move signature validation ahead
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 19 Jan 2026 18:45:45 +0000 (UTC)

--===============3750611079457372937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index eb62a9794242..0222d17072d4 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -231,18 +231,19 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  	kexec_dprintk("kernel: %p kernel_size: %#lx\n",
>  		      image->kernel_buf, image->kernel_buf_len);
>
> -	/* Call arch image probe handlers */
> -	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
> -					    image->kernel_buf_len);
> -	if (ret)
> -		goto out;
> -
>  #ifdef CONFIG_KEXEC_SIG
>  	ret = kimage_validate_signature(image);
>
>  	if (ret)
>  		goto out;
>  #endif

Does this reordering break signature verification? The kimage_validate_signature()
function calls kexec_image_verify_sig(), which accesses image->fops->verify_sig:

  static int kexec_image_verify_sig(struct kimage *image, void *buf,
                                    unsigned long buf_len)
  {
      if (!image->fops || !image->fops->verify_sig) {
          pr_debug("kernel loader does not support signature verification.\n");
          return -EKEYREJECTED;
      }
      return image->fops->verify_sig(buf, buf_len);
  }

However, image->fops is set by arch_kexec_kernel_image_probe() via
kexec_image_probe_default(), which now runs after kimage_validate_signature().
Since the kimage struct is zero-initialized by do_kimage_alloc_init(),
image->fops will be NULL when kexec_image_verify_sig() is called.

With this ordering, kexec_image_verify_sig() will always return -EKEYREJECTED.
When CONFIG_KEXEC_SIG_FORCE is enabled (sig_enforce = true), this causes
kimage_validate_signature() to return the error and kexec_file_load() fails.

Is this intentional, or should arch_kexec_kernel_image_probe() remain before
the signature validation call?

> +
> +	/* Call arch image probe handlers */
> +	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
> +					    image->kernel_buf_len);
> +	if (ret)
> +		goto out;
> +

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147860407

--===============3750611079457372937==--

