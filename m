Return-Path: <bpf+bounces-76742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0E9CC4E94
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 19:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 459BA307FC1A
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFE233D6EB;
	Tue, 16 Dec 2025 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKv/TPlw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134F133DEC0
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765908170; cv=none; b=uMc/e3++/xrvGDbrNNhWa/LgajPkz4fI4qeoQP/GLzARNSr8/Pj28ME5zR3wJSlC868OoDz+P0svBj7k3vSimFE6478h9cQHjUTmY8dsZ3KhZhyub+/gkqAMUX1iz4gy98k5ze0S3/uYtb4/MgfBkmG9wUc2MZzD96/RkpN53Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765908170; c=relaxed/simple;
	bh=8tjTRKdj8aZ0frE4cXeKHfkTsDb3ZKx9SrGlsNbk9SI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fuNuwpjtD70wmR9UjRFqca4DKexDd6UvoBoZWBD3SiREK/2VSqLJO+In6B9ClwbEV9+DuddNcgjptsauB9MbArPXZ3s5TbKlyCTXwm9RpNWnWVhLmVhqQjaDDnmZjRr8eifrF34YHwpxb1nwnEFhrxC7udjQXAzo0mZ3btKhCWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKv/TPlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B855BC4CEF1;
	Tue, 16 Dec 2025 18:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765908169;
	bh=8tjTRKdj8aZ0frE4cXeKHfkTsDb3ZKx9SrGlsNbk9SI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=TKv/TPlwPGh1YvasU1HhacksGFCCDzbjQDXdh8qIMXkgY7QzdyGklBHCBlYaZGnN7
	 xQqaad3IIBtPEHZypqPeU6WukGyKvsedqEFk3cJWX/RIQfoq7q/yD506zk9f2UERjm
	 VVgWUNqIFcdrOvAtD5dR6/CoQX2lMuf5xuTfDQmTXWIV2gRdai5xlLMXlS7znoK2NL
	 VCVjogdSqRCxE+1Z1t/5Zjj3ioSHmjX9jQJi48UgXmSjdDLh7WY5sfam6w3hOGTj6w
	 UTpfgp0DlATIRRsQiZjzGNJMQDSyboIWhcIrPjFsPCPJ6fOxnUda/qiddBWlrxWyWx
	 TblVYOQqBs7Pg==
Content-Type: multipart/mixed; boundary="===============3102835238690918957=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0447c47ac58306546a5dbdbad2601f3e77fa8eb24f3a4254dda3a39f6133e68f@mail.kernel.org>
In-Reply-To: <20251216173325.98465-3-emil@etsalapatis.com>
References: <20251216173325.98465-3-emil@etsalapatis.com>
Subject: Re: [PATCH v4 2/5] bpf/verifier: do not limit maximum direct offset into arena map
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 16 Dec 2025 18:02:49 +0000 (UTC)

--===============3102835238690918957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a31c032b2dd6..d6b8a77fbe3b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21132,11 +21132,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
>  		} else {
>  			u32 off = insn[1].imm;
>
> -			if (off >= BPF_MAX_VAR_OFF) {
> -				verbose(env, "direct value offset of %u is not allowed\n", off);
> -				return -EINVAL;
> -			}
> -
>  			if (!map->ops->map_direct_value_addr) {
>  				verbose(env, "no direct value access support for this map type\n");
>  				return -EINVAL;

The map_direct_value_addr() implementations for array and arena maps
return only the base address, and then resolve_pseudo_ldimm64() adds the
offset at line 21148:

    aux->map_off = off;
    addr += off;

However, insn_array_map_direct_value_addr() (kernel/bpf/bpf_insn_array.c)
has a different implementation pattern:

    static int insn_array_map_direct_value_addr(const struct bpf_map *map,
                                                 u64 *imm, u32 off)
    {
        struct bpf_insn_array *insn_array = cast_insn_array(map);

        if ((off % sizeof(long)) != 0 ||
            (off / sizeof(long)) >= map->max_entries)
            return -EINVAL;

        /* from BPF's point of view, this map is a jump table */
        *imm = (unsigned long)insn_array->ips + off;

        return 0;
    }

Notice that insn_array adds the offset to the base address inside the
function (line: *imm = (unsigned long)insn_array->ips + off). When
resolve_pseudo_ldimm64() then adds the offset again at line 21148, the
result is:

    addr = (insn_array->ips + off) + off = insn_array->ips + 2*off

Can this cause insn_array maps to access incorrect array elements? For
example, if a program requests offset 32 (which passes the bounds check
since 32/8 = 4 < max_entries), the actual offset becomes 64, potentially
accessing insn_array->ips[8] when max_entries is only 10.

Before this commit, the BPF_MAX_VAR_OFF limit (512MiB) prevented the
double-offset from becoming too large, but removing this limit allows
offsets up to UINT32_MAX, making the doubled offset up to 8GB.

> diff --git a/tools/testing/selftests/bpf/verifier/direct_value_access.c b/tools/testing/selftests/bpf/verifier/direct_value_access.c
> index c0648dc009b5..e569d119fb60 100644
> --- a/tools/testing/selftests/bpf/verifier/direct_value_access.c
> +++ b/tools/testing/selftests/bpf/verifier/direct_value_access.c

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20277371964

--===============3102835238690918957==--

