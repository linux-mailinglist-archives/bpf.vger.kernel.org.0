Return-Path: <bpf+bounces-79483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDE5D3B61E
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 19:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E7CC30D2B2F
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 18:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5947B32ED2E;
	Mon, 19 Jan 2026 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQCXYOQP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D01DF759;
	Mon, 19 Jan 2026 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848344; cv=none; b=uZ6Zgnsht3V9PfzV+irk439RoAE6NzD1kufhn4LaXXIAa50SfZk9sQ0/t2Vrb24QDwFkOn6pSsNFDKDZpvdySVcxdLwI3p0yOKX9hDpy03He1eIE2spMLpkuiKlYURVz2FaWjvNUJKfRXeA12Mn1O3cl2VepNYjKZX3BL6ag1q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848344; c=relaxed/simple;
	bh=Ikfg5KIMUlTIopIK07Reje08ixZv+AmRD+SrzZ7gCdk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=S9t8N0iRDEzi+jROiv7b3Zra9Pa8Jt2IxcCSiVVAqWvFO4wR/4mmrhiRZI15aa8ORpjuwf0hL6wDtRoqpnDcGY2HkeKshsSCurGVSmzL3RrQVQ2TMVLyRrpdAk8u5kxBJQfrPtsz+IuT9aKHmH1sslrGMYGbJc98AGI7RX6/TaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQCXYOQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D19C116C6;
	Mon, 19 Jan 2026 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848340;
	bh=Ikfg5KIMUlTIopIK07Reje08ixZv+AmRD+SrzZ7gCdk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=CQCXYOQP/u2K0fH7yCGd+dJFJcgI6wYCxxAHMylFusY3Rovv9qnmMv4V3BVoslePE
	 7B2uK6HqUcLhYMtvy+AZZ2zXsgEW5UT+sKH0H9mdpXDN17lEqDxVynqjGMJb7jSHU8
	 WR9OVAOgyBgGIZLvOxXpng1ZB66evVmKfhBufNspeAVRMWQZJAfy33/xaGIMLAP75c
	 O13v00SnSF0Wa5JEBCKaNUGHfKkLHLMsuRdlFonOR+SYVfkXYe+wdS1cg0OA4hY3yZ
	 hEG+tN9Azf9W9kMdbgnuypOCVa9AaFAJgC0mQhJ73h3woocL5SAoXEqSuyF6n71cLM
	 kDb+UMFtfr+Mw==
Content-Type: multipart/mixed; boundary="===============8972815748039503686=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f7a838c389c0356a7a52dc2fa09b5db8f24a6eed1d7dbc346250e4f3db233855@mail.kernel.org>
In-Reply-To: <20260119032424.10781-13-piliu@redhat.com>
References: <20260119032424.10781-13-piliu@redhat.com>
Subject: Re: [PATCHv6 12/13] tools/kexec: Introduce a bpf-prog to parse zboot image format
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 19 Jan 2026 18:45:40 +0000 (UTC)

--===============8972815748039503686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/kexec/zboot_parser_bpf.c b/tools/kexec/zboot_parser_bpf.c
> new file mode 100644
> index 000000000000..54c4b762b332
> --- /dev/null
> +++ b/tools/kexec/zboot_parser_bpf.c

[ ... ]

> +/* see drivers/firmware/efi/libstub/zboot-header.S */
> +struct linux_pe_zboot_header {
> +	unsigned int mz_magic;
> +	char image_type[4];
> +	unsigned int payload_offset;
> +	unsigned int payload_size;
> +	unsigned int reserved[2];
> +	char comp_type[4];
> +	unsigned int linux_pe_magic;
> +	unsigned int pe_header_offset;
> +} __attribute__((packed));

[ ... ]

> +	unsigned int payload_offset = zboot_header->payload_offset;
> +	unsigned int payload_size = zboot_header->payload_size;
> +	bpf_printk("zboot image payload offset=0x%x, size=0x%x\n", payload_offset, payload_size);
> +	/* sane check */
> +	if (payload_size > image_sz) {
> +		bpf_ringbuf_discard(buf, BPF_RB_NO_WAKEUP);
> +		bpf_printk("Invalid zboot image payload offset and size\n");
> +		return 0;
> +	}

Should this bounds check also verify that payload_offset + payload_size
does not exceed image_sz? The current check only validates that payload_size
fits, but if payload_offset is large (e.g., near image_sz), the read below
could extend past the end of the kernel buffer.

For example, with payload_offset = image_sz - 10 and payload_size = 100,
the check "payload_size > image_sz" passes, but the bpf_probe_read below
would read 90 bytes past the valid buffer boundary.

> +	unsigned int max_payload = MAX_RECORD_SIZE - sizeof(struct cmd_hdr);
> +	if (payload_size >= max_payload) {
> +		bpf_ringbuf_discard(buf, BPF_RB_NO_WAKEUP);
> +		bpf_printk("Err: payload_size > MAX_RECORD_SIZE\n");
> +		return 0;
> +	}
> +	void *dst = (void *)buf + sizeof(struct cmd_hdr);
> +	/* Overwrite buf */
> +	struct cmd_hdr *cmd = (struct cmd_hdr *)buf;
> +	cmd->cmd = KEXEC_BPF_CMD_DECOMPRESS;
> +	cmd->subcmd = KEXEC_BPF_SUBCMD_KERNEL;
> +	/* 4 bytes original size is appended after vmlinuz.bin */
> +	cmd->payload_len = payload_size - 4;
> +	bpf_probe_read(dst, payload_size, context->kernel + payload_offset);
                                                           ^^^^^^^^^^^^^^^

This is where the out-of-bounds read could occur if payload_offset +
payload_size > image_sz. While bpf_probe_read is safe and will not crash
(it uses copy_from_kernel_nofault internally), it could read from adjacent
kernel memory if the zboot header contains invalid offset/size values.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147860407

--===============8972815748039503686==--

