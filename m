Return-Path: <bpf+bounces-79487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBFED3B627
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 19:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFBD8310BFF5
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 18:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672252EAD0D;
	Mon, 19 Jan 2026 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kble2M3t"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE9E2F360A;
	Mon, 19 Jan 2026 18:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848354; cv=none; b=qrqtzUL3YW0drObjyWRqiYaSbbDkhCeKLxCWbAMjTVtIjCnWzN6mecvJKngdYHkmX66CW6wcm3/VQcMSU746VrUaOgsTA4WhArU4q7aBukHMGUxpa4p8qpRGXP7YAqOFBi079qpml2qiSzpaL8BbogwNSR2ch3ayeeWdMXX2aqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848354; c=relaxed/simple;
	bh=h9M3VYBtxAEa2EwrH2dHTAkKbQKY8m0mIdf4uUg6zyQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MQNGKX4Bv8fDwa1S4R/K5z3pm4iPMIm3juq4G007D9A+XW0fxnYjBn0L2b1RyBZgQJ0aeax9kbyfO8PrCRE+GebKEg+2M0VyWkf+HjeMYoKBO0MqGNVuhmiz4QbcywzQsiIfvkvMooHmyb6rGnvTtDHqR8p+/DS7RgRmKNFvB5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kble2M3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007C2C116C6;
	Mon, 19 Jan 2026 18:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848348;
	bh=h9M3VYBtxAEa2EwrH2dHTAkKbQKY8m0mIdf4uUg6zyQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=kble2M3tdeCBi+Rhj7syEirvqAi5NWfPqufd0haTd1xVG3FTj4DD8XevNRGHMS+C/
	 sV4cytjEi7fhbZ2yclLbDeF4UvE6j6UNpmApoFEGX9RjTIN9srnHvggjY3KawObHrc
	 +H+HiWBBsvnc2On8phPYg5rNxG96TgReeBORM/jPgWp12icFgbtIBVXfbLGFLmyVcb
	 IC26AS2eYzFV5Jccleq0ejFHQ51tOsmIxkdpUP5jgr5AG+nsMQ4wIbCpKw6Aa3AEoX
	 mlZkYbQ+1sy5UVyBOCrUnk8vSXMkDgbU+QOKddlsLA6jHmQfDCwXc+tiAtQoiLHLBr
	 odXeAD/Lbtsjw==
Content-Type: multipart/mixed; boundary="===============0962507557268174505=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e0424b46ffd815f666093af468a0961c6f9a4966a5d67d5cbc3b232422426328@mail.kernel.org>
In-Reply-To: <20260119032424.10781-7-piliu@redhat.com>
References: <20260119032424.10781-7-piliu@redhat.com>
Subject: Re: [PATCHv6 06/13] kexec_file: Implement decompress method for parser
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 19 Jan 2026 18:45:47 +0000 (UTC)

--===============0962507557268174505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
> index dc59e1389da9..bd6a47fc53ed 100644
> --- a/kernel/kexec_bpf_loader.c
> +++ b/kernel/kexec_bpf_loader.c

[ ... ]

> +static void decompress_mem_allocator_fini(struct decompress_mem_allocator *a)
> +{
> +	vfree(a->chunk_base_addr);
> +}

Should decompress_mem_allocator_fini() also free the individual chunks stored
in chunk_base_addr[0..next_idx-1]? On the success path, merge_decompressed_data()
frees them, but on error paths (decompressor failure or merge failure), the
chunks appear to be leaked since only the array pointer is freed here.

[ ... ]

> +static int parser_cmd_decompress(char *compressed_data, int image_gz_sz,
> +		char **out_buf, int *out_sz, struct kexec_context *ctx)
> +{
> +	struct decompress_mem_allocator *a = &dcmpr_allocator;
> +	decompress_fn decompressor;
> +	const char *name;
> +	int ret;
> +
> +	decompress_mem_allocator_init(a, CHUNK_SIZE);

Is the return value from decompress_mem_allocator_init() intentionally
ignored? If vmalloc fails inside that function, chunk_base_addr and the
other fields remain uninitialized, and subsequent code will use garbage
values when accessing the allocator.

> +	decompressor = decompress_method(compressed_data, image_gz_sz, &name);
> +	if (!decompressor) {
> +		pr_err("Can not find decompress method\n");
> +		return -1;
> +	}

When decompress_method() returns NULL, should decompress_mem_allocator_fini()
be called before returning? The allocator was initialized above and allocated
both chunk_base_addr and the first chunk, which appear to leak on this path.

> +	pr_debug("Find decompressing method: %s, compressed sz:0x%x\n",
> +			name, image_gz_sz);
> +	ret = decompressor(compressed_data, image_gz_sz, NULL, flush,
> +				NULL, NULL, NULL);
> +	if (!!ret)
> +		goto err;
> +	ret = merge_decompressed_data(a, out_buf, out_sz);
> +
> +err:
> +	decompress_mem_allocator_fini(a);
> +
> +	return ret;
> +}

[ ... ]

> +	switch (cmd->cmd) {
> +	case KEXEC_BPF_CMD_DECOMPRESS:
> +		ret = parser_cmd_decompress(buf, cmd->payload_len, &decompressed_buf,
> +					&decompressed_sz, ctx);
> +		if (!ret) {
> +			switch (cmd->subcmd) {
> +			case KEXEC_BPF_SUBCMD_KERNEL:
> +				vfree(ctx->kernel);
> +				ctx->kernel = decompressed_buf;
> +				ctx->kernel_sz = decompressed_sz;
> +				break;
> +			default:
> +				break;

When decompression succeeds but subcmd is not KEXEC_BPF_SUBCMD_KERNEL (for
example INITRD or CMDLINE), decompressed_buf is allocated by
merge_decompressed_data() but not stored or freed. Is this intentional, or
should decompressed_buf be freed in the default case?

> +			}
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147860407

--===============0962507557268174505==--

