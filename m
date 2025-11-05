Return-Path: <bpf+bounces-73606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64B9C34D58
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 10:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71BE4678C3
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 09:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3F62FBE00;
	Wed,  5 Nov 2025 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcZplfUV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C442FB0BD
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334486; cv=none; b=bYA6L4ZC5NwcMJBFNmrHZnTxU95WMbnw/l51p8kvToqFWzeKCvWml+V0bV2ujB5W5aFSO78WEXUnDLjUvAYOhej2AZeuVLjU4rsq0gKAaStr3d2645NwoopdZTcHxuoeLyGohlxZTPEFNyChrptalzC8McaOdEH5vwBeSYZJjvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334486; c=relaxed/simple;
	bh=MPTFWNKuWXAI+YzKbL4xxi0niV0w471gj2sf8GaDXKw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=etCDjyPYHlmFIutfNqcCVIHUSBt87X3X13aq8/ew7OGcDoqa4YcURtRci3zI1L1H8wgPd+H+S0RaH/EvBp13u0b1T+m182+mSdodm9xws9gNQ8oRiN3KOCBHAIKn0T/fwAEOJ2soVNSgC43jy+eANoTHy6XO59SbZFroDMy3bEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcZplfUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104A0C116B1;
	Wed,  5 Nov 2025 09:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762334486;
	bh=MPTFWNKuWXAI+YzKbL4xxi0niV0w471gj2sf8GaDXKw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=rcZplfUViHpAM9JHSHwoyxM31hRpDeFnCq/LnaEQvtQ3f9WFn9pZMcCbkzjuTgRnl
	 quBPvUpBMZFZxLgYemAMt1oy+xthbu5Pz0brAWz7iTOTf6c+Oz6bTFfbuf2PWzfTjd
	 XsJfdR51Nn3t7dhKNoCXO6USNTcBoCyVug3YaAljEMBpHTRmFjQ5K5EcyjRJ9m9K03
	 QVNkjqS9+pXcrqEsfzfHMTR94LdfggdZ33qqSh5vQ3tGjT43zbEKE5IzQK6x5K/zwl
	 RYcZENE9lzfsCjb1jGlFFptqRgD2nuFHf/N/8949q34SWUv19TBBPYVgL2UgioJuFv
	 rpxIfidEhUFhg==
Content-Type: multipart/mixed; boundary="===============5027449913165862589=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b1df429383fefe439fb19c0ebf0f9f665e37ffbc164c837a307fe2911a520a18@mail.kernel.org>
In-Reply-To: <20251105090410.1250500-3-a.s.protopopov@gmail.com>
References: <20251105090410.1250500-3-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v11 bpf-next 02/12] bpftool: Recognize insn_array map type
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,aspsk@isovalent.com,daniel@iogearbox.net,eddyz87@gmail.com,qmo@kernel.org,yonghong.song@linux.dev
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  5 Nov 2025 09:21:26 +0000 (UTC)

--===============5027449913165862589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> index 252e4c538..1af3305ea 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> @@ -55,7 +55,8 @@ MAP COMMANDS
>  |     | **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
>  |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
>  |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
> -|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** }
> +|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena**
> +|     | **insn_array** }
>
>  DESCRIPTION
>  ===========
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index c9de44a45..7ebf7dbcf 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1477,7 +1477,8 @@ static int do_help(int argc, char **argv)
>  		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
>  		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
>  		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
> -		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena }\n"
> +		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena |\n"
> +		"                 insn_array }\n"
>  		"       " HELP_SPEC_OPTIONS " |\n"
>  		"                    {-f|--bpffs} | {-n|--nomount} }\n"
>  		"",

The commit message says "Teach bpftool to recognize instruction array
map type" but this change only updates documentation strings. Shouldn't
libbpf's map_type_name[] array in tools/lib/bpf/libbpf.c also be
updated? Without that, when bpftool displays an insn_array map through
show_map_header_json() or the plain output function, it will call
libbpf_bpf_map_type_str() which returns NULL for BPF_MAP_TYPE_INSN_ARRAY,
causing bpftool to fall back to printing "type 39" instead of "insn_array".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19096860051

--===============5027449913165862589==--

