Return-Path: <bpf+bounces-45934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B7C9E041B
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 14:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57E4282A21
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CE6202F89;
	Mon,  2 Dec 2024 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYDhRaBU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3076201265;
	Mon,  2 Dec 2024 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147750; cv=none; b=R+QRHovArk/7BdT8oxLJaxhHBVJkV+3NZ7bp2N3ucay3Vqf9Zq5PcqiYtsuHPZT7tZXqeDi8tSdZUqg2uAeC1/TAb03YJh7tLUhPsvd6pijcyGdpfjQ6+U06wOz4AvDlD4izL52LZpn/QGcmbH0VL1rNvBYg+BWgKh8ILHnHa8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147750; c=relaxed/simple;
	bh=Ydj8DV5t6ezBarawKFIkqn56lPCfEsiVscFuKj8QUaY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBs/d72VRThkS4sJUR0QQsqizCSVqvT3auAHBHyHWsvfeo90P0KQ50HgPkFZP27KWVNewv6OqGuVAYsFnEDmDy5lRg6QPv4A7jfnQx2qBzmXB2rH9Ap1IpE0KubkTzF/AgIx2CULRrdVy2QZpwDT60nM28wrr9S54aQepdpMET0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYDhRaBU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa51d32fa69so674993466b.2;
        Mon, 02 Dec 2024 05:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733147747; x=1733752547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PA539ENGyPb/F01SAT3XpfaroeO9b4eH8ud/s0JxHkw=;
        b=PYDhRaBUw0G4TGqcvkvl5Ir3GNSxR5RX4G8DibmSHi5MBdmzI0lCYKeuGGA09XJKF9
         hYRXw6QCKLG4MBPmJ7SCKHQdjd96LxeZpaeQMzEubUH+GQEowxjq3nu6ZAor8pVPpqTB
         1z1q8zC4AjIpS3qTQKutEZVsyA2YeWbepmuWgF5shePMMe5ktMCc+JfURu9t4tIlk7cA
         /OaTT8E5yG4m/Aqj05SKolzgdZn7ba8zytIQ1uRB1i9Th259EMlwVEUrFLho+vunwLNL
         TJRWGqTp3UaLfrwEit5k0+1jYSdM0RdwSS9TygdqhAMhCcKkYVAGwiOXdv6KGBZtuFSF
         +x+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733147747; x=1733752547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PA539ENGyPb/F01SAT3XpfaroeO9b4eH8ud/s0JxHkw=;
        b=jX3O6R/D5EpLhZHsGxO7wJU/YE894kfE5KBnpn7ets6uThVzzT4BR6sMQcd7saW2Rv
         Zm0IeLNmsoQthgAgOGFeWimBZrmF1coSTh9ch41l5mqBpGhOEcGPYWTUCARkDgmS8hYa
         +k6a8hyIHzPaaSas+Z/uAHeM7DZP0R3L+5wmPcaF+OtulPdGPkuALJxO+gaJOva7YqMi
         GCQeGMvU/T8nOTQWTpptejSUmbfOIw9wxNK52jtZPmLzLquEzXuI/RNzI3BoGyLJUp1h
         pJcM9VDtirD7UtTj5201WJJXjBCWGhj+HjVJetTDDk/FG6uosOpRUIl5GSWN8TDS4O3j
         gaAw==
X-Forwarded-Encrypted: i=1; AJvYcCXUmx11IyHrZx7BqUlgx6jBGucD1U0nx5zUg9SRGOJZ5y+f7xtiOxzsLkYCO8YgXN8hiHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQQLg+j54wAzjB93D0pAIy8TNfBIZib+TGpHkcxlt/KkcBqRQZ
	PhAq+1FDgdGaMpU0gHRFScO9eA/HMtG2GBQ9c/mzdORfgGK1eYk/
X-Gm-Gg: ASbGncsPEUmW6uia8TeqjvruxEOjGmriN33wqL8oVS/LC2r1rqSiLOCdY9SA2jKCgCF
	UVmfOUWLB50BEJrRmab/YxgihToTQ4OOHt2j32cGHMWgNi8FiOTRTFNEwJoPSmkYs6DtJ+jEfzX
	idmnze/Y2ctTC/1dOzIUVGdO25MpPnT1aPWdLqikFJJUWHSo+w3OoA01oFh37/UJf1N39pZPyyF
	Erg5FVeKZD8sjfPt8oB7D4/mgNToWPjnD6DSxXUPWdhY7iEQmTEYodJ0prLumL9bksA1KdhdSan
	OzHqcsv7SwHUkLjnFSvn/QM=
X-Google-Smtp-Source: AGHT+IFbiAnceJQ6wHqsqmWoLH3bctwuYtX0/ueCNrTBmE9o5CxHZXly4Jy60FzEtPBhFASWIEDJYA==
X-Received: by 2002:a17:906:3d29:b0:aa5:152c:1995 with SMTP id a640c23a62f3a-aa581028f89mr1666316266b.45.1733147746976;
        Mon, 02 Dec 2024 05:55:46 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d574fsm513054366b.58.2024.12.02.05.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 05:55:46 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 2 Dec 2024 14:55:44 +0100
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, bpf@vger.kernel.org,
	alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org,
	mykolal@fb.com
Subject: Re: [RFC PATCH 0/9] pahole: shared ELF and faster reproducible BTF
 encoding
Message-ID: <Z028YOBN_EnUA9Qm@krava>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128012341.4081072-1-ihor.solodrai@pm.me>

On Thu, Nov 28, 2024 at 01:23:44AM +0000, Ihor Solodrai wrote:

SNIP

> Test results for this patch series:
> 
>   1: Validation of BTF encoding of functions; this may take some time: Ok
>   2: Default BTF on a system without BTF: Ok
>   3: Flexible arrays accounting: WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_cast_to_kern_ctx already with attribute (bpf_kfunc), ignoring
> WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_rdonly_cast already with attribute (bpf_kfunc), ignoring
> pahole: type 'nft_pipapo_elem' not found
> pahole: type 'ip6t_standard' not found
> pahole: type 'ip6t_error' not found
> pahole: type 'nft_rbtree_elem' not found
> pahole: type 'nft_rule_dp_last' not found
> pahole: type 'nft_bitmap_elem' not found
> pahole: type 'fuse_direntplus' not found
> pahole: type 'ipt_standard' not found
> pahole: type 'ipt_error' not found
> pahole: type 'tls_rec' not found
> pahole: type 'nft_rhash_elem' not found
> pahole: type 'nft_hash_elem' not found
> Ok
>   4: Pretty printing of files using DWARF type information: Ok
>   5: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok

hi,
when trying selftests with this change, I'm getting wrong .BTF
on bpf selftest bpf_testmod.ko module

$ bpftool btf dump file ./bpf_testmod.ko
Error: failed to load BTF from ./bpf_testmod.ko: Invalid argument

jirka

> 
> 
> [1]: https://lore.kernel.org/dwarves/20241016001025.857970-1-ihor.solodrai@pm.me/
> [2]: https://github.com/theihor/dwarves/pull/3
> [3]: https://lore.kernel.org/dwarves/8678ce40-3ce2-4ece-985b-a40427386d57@oracle.com/
> [4]: https://github.com/acmel/dwarves/compare/master...alan-maguire:dwarves:elf-prep
> [5]: https://github.com/theihor/dwarves/pull/8
> [6]: https://gist.github.com/theihor/f000ce89427828e61fdaa567b332649b
> [7]: https://github.com/theihor/dwarves/pull/8/commits/a7bc67d79d90f98776c6dc5fdaf9f088eb09909d
> 
> 
> Alan Maguire (3):
>   btf_encoder: simplify function encoding
>   btf_encoder: store,use section-relative addresses in ELF function
>     representation
>   btf_encoder: separate elf function, saved function representations
> 
> Ihor Solodrai (6):
>   dwarf_loader: introduce pre_load_module hook to conf_load
>   btf_encoder: introduce elf_functions struct type
>   btf_encoder: collect elf_functions in btf_encoder__pre_load_module
>   btf_encoder: switch to shared elf_functions table
>   btf_encoder: introduce btf_encoding_context
>   pahole: faster reproducible BTF encoding
> 
>  btf_encoder.c  | 661 ++++++++++++++++++++++++++++++-------------------
>  btf_encoder.h  |   6 +
>  dwarf_loader.c |  18 +-
>  dwarves.c      |  47 ++--
>  dwarves.h      |  16 +-
>  pahole.c       | 265 +++++++++-----------
>  6 files changed, 567 insertions(+), 446 deletions(-)
> 
> -- 
> 2.47.0
> 
> 

