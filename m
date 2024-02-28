Return-Path: <bpf+bounces-22854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DEE86AB12
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 10:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589231F23712
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 09:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5174736103;
	Wed, 28 Feb 2024 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOYOpJgq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBCC33CC2;
	Wed, 28 Feb 2024 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112019; cv=none; b=JA6ajDYLnumDVkDbGheCiWkUS+CKBsCl+uCRqn1GkqVh+QAGJWZcoV1zOeJkox0xyEqNioyiCidyXPKvQA6ReoBNIj8djMnK1BiLd27cucVqgj8xhe4cqZc2kJVgissqdhA2Mjdprhfhr5AmRhty9Jt//gQzYcVfm/gOSKWG26Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112019; c=relaxed/simple;
	bh=v2eiHuL62WCXQs7hcAtCym9lIkCchgxpESbrCei0pbA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvRbD2U8k/GbVaNY6ODrYqkFbhDm1ydBwZtZCzDDCe5ak8OoQBB9WWGqbUZJkLfoVclh5n8AjI4T37f7unWfzCJk0cZUPXd9upPZFoTRBWlSZzEe8mpYkaVsnpVQP2VUADxbtNu+yskDuhH8Tp36NctZbZpOw7aA5uSRtv6lbNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOYOpJgq; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so3860635a12.3;
        Wed, 28 Feb 2024 01:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709112016; x=1709716816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MMWQD7UAFsp9KchPLx3P8oI21qYIe7rr+n1htkt7OGE=;
        b=NOYOpJgqlfXsp1NviA5b58FjGtoZFiLLPZ83p12jcAolpm5eNLtyoPZyNWWPa+cxsh
         3fnXVmy0KFs2ESN/8bF4WZSYNh1mJ/uziHXHG2T57U4Bu8dXOBMoNNiJHybSLngH7zCF
         kYRDGXuItJ0Ien2s5OBUMJwnF8T3SpRhBjLx795PYWl16C5HKWqvACAUNn+H9D7Ap+PW
         iN0I23QryATIATDgXIFOkDNg6xOg8nP2PoGuh8v77CQTdat61pI2/YrOd6d5Tk5ucNdP
         6RyazRzjo2E/cg58OfM6gfB40PeStnHytSFyeVFcHpcRUzabV1+7otTV9ZKKxbladzxg
         TufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709112016; x=1709716816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMWQD7UAFsp9KchPLx3P8oI21qYIe7rr+n1htkt7OGE=;
        b=HouydlVj6Db825ZJJW4zKsTdmH44snCiOqCeggP89KkSSEuf4o0dgsFZM7xZDo9Vpr
         c38zYGR4nO4guy+TOutBipnTB/lHa1hGJ8epzjdsnQjwR5rXz68jHfCj4hpObpepGPb5
         uqlXHnUZBqiw5ExujcNtOLECHyI5rjXHgN3aOIWPGKQ5CnXWe+xDxjYIGiGbqlrMPDbM
         GRj9qNAdSKlAfx/JiPxyDhBE0ZjUVS/WTM7TPSU/oqQ44BTQb28koZ3GYayTVjJn1UVD
         DkTE4ouAUk3KL19rwyGCpRMUqeayEQxgCbsZGWHNeDH5Yq8Yr4wvok1fVGcLWv+9BI4Z
         VYeA==
X-Forwarded-Encrypted: i=1; AJvYcCWvfqlYaVlwsQTIctJvEQ/7+EGz7sy8qCUkzjlE3md7FOaYJmwGiCoik6B5pa2QkT6KrXdSzlhVHOeC85rU4BuVXj3ycZiCsa8JOdSKeNucquNDBrJQnfMZ+dKbF5HwbMffcJkHMJf5lDxIobNNaL4tvRHyA+HIxehTkA==
X-Gm-Message-State: AOJu0YyrcVIxrHkvLDvzrRuYOoHyjj5zPTSqn2SOcAnKatAjrcLTi1c7
	x3mAJrLD1S2tR91ERUBQ3L0a7p3xWSSJn/w4gYKTAoSuYPH9LILI
X-Google-Smtp-Source: AGHT+IFMqeyTM1Fz8XS/CKmvJQyp3KmW3GKHKd3rNDuQ3QkpR1QTAbKMMsbOlG73ALffL7AbF66auQ==
X-Received: by 2002:a17:906:13db:b0:a42:f40e:3ac0 with SMTP id g27-20020a17090613db00b00a42f40e3ac0mr8087879ejc.6.1709112016441;
        Wed, 28 Feb 2024 01:20:16 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id fj15-20020a1709069c8f00b00a42ea946917sm1626181ejc.130.2024.02.28.01.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:20:16 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 28 Feb 2024 10:20:14 +0100
To: John Hubbard <jhubbard@nvidia.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, dwarves@vger.kernel.org
Subject: Re: [PATCH] fix linux kernel BTF builds: increase max percpu
 variables by 10x
Message-ID: <Zd76zrhA4LAwA_WF@krava>
References: <20240228032142.396719-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228032142.396719-1-jhubbard@nvidia.com>

On Tue, Feb 27, 2024 at 07:21:42PM -0800, John Hubbard wrote:
> When building the Linux kernel with a distro .config, most or even all
> possible kernel modules are built. This adds up to 4500+ modules, and
> based on my testing, this causes the pahole utility to run out of space,
> which shows up like this (CONFIG_DEBUG_INFO_BTF=y is required in order
> to reproduce this):
> 
>   LD      .tmp_vmlinux.btf
>   BTF     .btf.vmlinux.bin.o
> Reached the limit of per-CPU variables: 4096
> ...repeated many times...
> Reached the limit of per-CPU variables: 4096
>   LD      .tmp_vmlinux.kallsyms1
>   NM      .tmp_vmlinux.kallsyms1.syms
>   KSYMS   .tmp_vmlinux.kallsyms1.S
>   AS      .tmp_vmlinux.kallsyms1.S
>   LD      .tmp_vmlinux.kallsyms2
>   NM      .tmp_vmlinux.kallsyms2.syms
>   KSYMS   .tmp_vmlinux.kallsyms2.S
>   AS      .tmp_vmlinux.kallsyms2.S
>   LD      vmlinux
>   BTFIDS  vmlinux
> libbpf: failed to find '.BTF' ELF section in vmlinux
> FAILED: load BTF from vmlinux: No data available
> make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 255
> make[2]: *** Deleting file 'vmlinux'
> make[1]: *** [/kernel_work/linux-people/Makefile:1162: vmlinux] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
> 
> Increasing MAX_PERCPU_VAR_CNT by 10x avoids running out of space, and
> allows the build to succeed.

do you have an actual count of percpu variables for your config?
10x seems a lot to me

this might be a workaround, but we should make encoder->percpu.vars
dynamically allocated like we do for functions

jirka

> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  btf_encoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index fd04008..d9f4e80 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -50,7 +50,7 @@ struct elf_function {
>  	struct btf_encoder_state state;
>  };
>  
> -#define MAX_PERCPU_VAR_CNT 4096
> +#define MAX_PERCPU_VAR_CNT 40960
>  
>  struct var_info {
>  	uint64_t    addr;
> -- 
> 2.44.0
> 
> 

