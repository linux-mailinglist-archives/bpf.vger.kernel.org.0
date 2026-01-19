Return-Path: <bpf+bounces-79482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6379DD3B61C
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 19:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 382A730B823F
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 18:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59B638F224;
	Mon, 19 Jan 2026 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hD784xQC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4916024BD03;
	Mon, 19 Jan 2026 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848339; cv=none; b=de22c7hLmWbn89+aEbtkM/Wwv3DUhJKeG9IkwUAWvbB7LsD2PcUpmj6iZ00f5CKKimzd7eeQEXkQG9C/yxLsiP1OEzPKcSFox8tSlzZcQeg6S8Zu+J6L5eHnzow/8+brCbdBSYTBYWvLLeFkf8Kc5obm/3waIw+bPr/NW/tblS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848339; c=relaxed/simple;
	bh=o3QfWn2TBZyOjwZ2AAj5dfWiv7vY+2pGNcMgrRpuNl4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AmaFg3roveuDzhpyclLvPSKAkdrN3FKfnhporgmQALQ47LKu9j+wwOXLg4VVeb2FRa0mmcJmPBN7VhViQqyAhIgMY8tHJPut7Ir6doBd3jlkGC0JPc9r+iY8zTxNhM0DHEDYEO4yNpRPU5OJYV0xnElHn43XNDJQqrNbW93cuy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hD784xQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F720C19422;
	Mon, 19 Jan 2026 18:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848338;
	bh=o3QfWn2TBZyOjwZ2AAj5dfWiv7vY+2pGNcMgrRpuNl4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=hD784xQCsR/qhdpbVTmQgAf30ZQkcmLw47T9N0BNpCSxTpJYp7eNdjghRexSoL97P
	 d/P4jRqmy9nFjJL0JykXe2wvWWwDXsux77lhoGGmRcVwuZaYz14qHzgQhsZZgRDMYh
	 lhFiXugvQ3T2fPyaoAgllTPezHioPSakrKt93bOHt48Tc9M48onBCziv5G+r+/cmFO
	 CeM9OfmG2iS5K6HZ/fhZgL4FMuxeso9TVo7MtzOwWZPWLnyU5bvhHDMdv5kfgvP08Z
	 k1+j6B10899/McdKvxs0BDIKwgPW7BYGMUdnvQT+ts3J5T4sjbYFxyDecF6hfN65NS
	 KHUSWSGvGKp1A==
Content-Type: multipart/mixed; boundary="===============8096099273637422097=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2742c5333700b577bda375a3bf80f55ca5aa92bdd66ecc85e85a8f762d94c277@mail.kernel.org>
In-Reply-To: <20260119032424.10781-14-piliu@redhat.com>
References: <20260119032424.10781-14-piliu@redhat.com>
Subject: Re: [PATCHv6 13/13] tools/kexec: Add a zboot image building tool
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 19 Jan 2026 18:45:38 +0000 (UTC)

--===============8096099273637422097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/kexec/pe.h b/tools/kexec/pe.h
> new file mode 100644
> index 000000000000..c2273d3fc3bb
> --- /dev/null
> +++ b/tools/kexec/pe.h

[ ... ]

> +/*
> + * Return -1 if not PE, else offset of the PE header
> + */
> +static int get_pehdr_offset(const char *buf)
> +{
> +	int pe_hdr_offset;
> +
> +	pe_hdr_offset = *((int *)(buf + 0x3c));
> +	buf += pe_hdr_offset;
> +	if (!!memcmp(buf, "PE\0\0", 4)) {
> +		printf("Not a PE file\n");
> +		return -1;
> +	}
> +
> +	return pe_hdr_offset;
> +}

This function returns int and can return -1 on error, but the caller stores
the result in a uint32_t without checking for errors (see below).

> diff --git a/tools/kexec/zboot_image_builder.c b/tools/kexec/zboot_image_builder.c
> new file mode 100644
> index 000000000000..c0a785074970
> --- /dev/null
> +++ b/tools/kexec/zboot_image_builder.c

[ ... ]

> +int main(int argc, char **argv)
> +{
> +	uint32_t payload_new_offset, payload_sect_off;
> +	uint32_t payload_size;
> +	uint32_t payload_sect_idx;
                 ^^^^^^^^^^^^^^^^

Are payload_sect_idx and payload_sect_off intentionally left uninitialized
here?  If the loop below never finds a matching section, these variables
will contain garbage values.

[ ... ]

> +	uint32_t pe_hdr_offset = get_pehdr_offset((const char *)base_start_addr);
> +	base_cur = base_start_addr + pe_hdr_offset;

Is there a missing check for the return value of get_pehdr_offset()?  The
function returns -1 on error (printing "Not a PE file"), but this code
stores it in a uint32_t and uses it directly.  If get_pehdr_offset()
returns -1, pe_hdr_offset becomes 0xFFFFFFFF, and base_cur will point far
past the mapped region.

[ ... ]

> +	/* Decide the section idx and the payload offset within the section */
> +	for (i = 0; i < num_sections; i++) {
> +	    sect = &base_sections[i];
> +	    if (zheader->payload_offset >= sect->data_addr &&
> +		zheader->payload_offset < (sect->data_addr + sect->raw_data_size)) {
> +		    payload_sect_idx = i;
> +		    payload_sect_off = zheader->payload_offset - sect->data_addr;
> +	    }
> +	}

If the condition is never true (payload_offset not within any section),
payload_sect_idx and payload_sect_off remain uninitialized.  They are used
later in:

    payload_new_offset = new_sections[payload_sect_idx].data_addr + payload_sect_off;

Could this cause undefined behavior with a malformed input file?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147860407

--===============8096099273637422097==--

