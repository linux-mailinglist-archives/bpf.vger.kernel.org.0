Return-Path: <bpf+bounces-27913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9BD8B339B
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 11:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7EB6B212CA
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 09:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B6F13E88A;
	Fri, 26 Apr 2024 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiQPcfz+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D264413D265
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122542; cv=none; b=CzdDnBXbxkTlrmlNKxMjpfPdIMS4s6hffHT0Ia8xdAdziHgZ7d0N8bg2x7kPVl+xsnA9aWpBOJXUMMY84eJRkojGuGeF8YtzyAuYsiexKWZL2C7aH48XIlEiRPIQsCXmhctlLglTOIIkF6LvXUUp57A0atiK/+25qX6yMJmFNOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122542; c=relaxed/simple;
	bh=ZuNIvP3BZuKd0givgrg6I4r7lQnvfA6Dnm9cdownQS8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMxnqdUJ/sTTHu593LwXYXY5TE1799c9XArnqyBTWM8aFqMYIgXwc5G+OPdRviL0VaGRb201HaSunrBUerZgpqqrEdBe0fOWhtIIi+uvY5XKvR3szADtjRDtMPoyxHgZ7Y5aeiPkNigYvTqmweuih7KGgnod4F2kr2iZ0NDKhds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiQPcfz+; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a58be618a17so174027466b.0
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 02:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714122539; x=1714727339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BuiSOj4bHHzviHQUPwur5pXB5xXhGyrrm7QhsdXLbac=;
        b=PiQPcfz+AJ1/IKpWuGyuVukGF8ww7UA2487v3hncz5kYBWkMnL2iv92NNAL5hJc3EX
         XzLH6T8QUGQ142mYLjBEUw6/Xap0VlH4eRs7WvRZcyXyps/N1WooGlwre9cczNMPaZ4y
         gIAwks9ufJcPexDwZUD1mbKd+6jIDjpIAruZuJslup1azJSdcjEo/0Hyr7mNASNCQDHy
         7CtnyexL87gjXkKbOEaU8TtSFSYEJa/1u+27GwI6odLVt4TjAY073k+y75+DCMOiipXZ
         JSNhh6fmVO7c9O/aJq5zXUDVUFEAw3Xd35kCEbO7Ggr4jJpnHrS4NGK7g64AeG7BvDAL
         JI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714122539; x=1714727339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuiSOj4bHHzviHQUPwur5pXB5xXhGyrrm7QhsdXLbac=;
        b=EDxV13fBVHmjnMZhWrIgtHXcCIxBaYFht6JYfT40rhs/8E8hgCsXiMXTwuYhDKporz
         W5GxaekQBexNocLFDNrdGLugu2xgMHffbo0P8ADh6vFaPOlVd88x0ZbLoEAj85EHs3qw
         XqrVxZFETNp/sEpY48LsFHZ6Mq0kjX5mKiXwUfqqzrX3bZlqYaRCQVqSSG6fyKiPSefR
         JbulgziJADaO10XkzDLlMwv9+PKxnMwWXv+zl4HBHBqrA+LP2zNCs78qIiJHL+FFRXsd
         bDlHpD8A86mTICdCc62/6kO2nOCDektmSAy3F+BsVvNKIbJo5d9dKDU/dXgv7VSlUtL4
         VIxg==
X-Forwarded-Encrypted: i=1; AJvYcCVhxXsNHUZFsE3IDW/OwMr37eyjXZJDBcMKpP3rPPBIpRzzoffyWwqU/s97No0kaSJcgLEJVBpc0gk8N9zR83WK9gws
X-Gm-Message-State: AOJu0YwYQw8MLVKpLEWdm2NtH0tppg9z/SSF/7k17tJFByWJBcLkQfeW
	fLC/kYiFcYifs5SvqdbZhdRql8uglj2/NfLwZpRidtbX3DqDxAKV
X-Google-Smtp-Source: AGHT+IEH/DKSxgwvXTIlA6TSeGRxhgzVOwtK2QuBmZVNXP9WXoLYdeG0lGaaqFyiH9+clns3oX7OTQ==
X-Received: by 2002:a17:906:3a85:b0:a55:b272:ea02 with SMTP id y5-20020a1709063a8500b00a55b272ea02mr1356307ejd.75.1714122538791;
        Fri, 26 Apr 2024 02:08:58 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p13-20020a170906604d00b00a587bc4ef2esm4272148ejj.122.2024.04.26.02.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 02:08:58 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 26 Apr 2024 11:08:56 +0200
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: acme@kernel.org, quentin@isovalent.com, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v8 0/3] pahole: Inject kfunc decl tags into BTF
Message-ID: <ZitvKNGPvmE7fV1N@krava>
References: <cover.1714091281.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1714091281.git.dxu@dxuuu.xyz>

On Thu, Apr 25, 2024 at 06:28:38PM -0600, Daniel Xu wrote:
> This patchset teaches pahole to parse symbols in .BTF_ids section in
> vmlinux and discover exported kfuncs. Pahole then takes the list of
> kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> 
> Example of encoding:
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
>         121
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
>         [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
>         [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1
> 
> This enables downstream users and tools to dynamically discover which
> kfuncs are available on a system by parsing vmlinux or module BTF, both
> available in /sys/kernel/btf.
> 
> This feature is enabled with --btf_features=decl_tag,decl_tag_kfuncs.
> 
> === Changelog ===
> 
> Changes from v7:
> * Fix/support detached BTF encoding
> 
> Changes from v6:
> * Rebase and add decl_tag_kfuncs as default feature
> 
> Changes from v5:
> * Add gobuffer__sort() helper
> * Use strstarts() instead of strncmp()
> * Use uint64_t instead of size_t
> * Add clarifying comments for get_func_name()
> 
> Changes from v4:
> * Update man page with decl_tag_kfuncs feature
> * Fix release mode build warnings
> * Add elf_getshrstrndx() error checking
> * Disable tagging if decl_tag feature is off
> * Fix malformed func name handling
> 
> Changes from v3:
> * Guard kfunc tagging behind feature flag
> * Use struct btf_id_set8 definition
> * Remove unnecessary member from btf_encoder
> * Fix code styling
> 
> Changes from v2:
> * More reliably detect kfunc membership in set8 by tracking set addr ranges
> * Rename some variables/functions to be more clear about kfunc vs func
> 
> Changes from v1:
> * Fix resource leaks
> * Fix callee -> caller typo
> * Rename btf_decl_tag from kfunc -> bpf_kfunc
> * Only grab btf_id_set funcs tagged kfunc
> * Presort btf func list
> 
> Daniel Xu (3):
>   pahole: Save input filename separate from output
>   pahole: Add --btf_feature=decl_tag_kfuncs feature
>   pahole: Inject kfunc decl tags into BTF

hi,
I tested the latest version and it still works fine for me, fwiw

Tested-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
>  btf_encoder.c      | 377 +++++++++++++++++++++++++++++++++++++++++++++
>  dwarves.h          |   1 +
>  man-pages/pahole.1 |   1 +
>  pahole.c           |   1 +
>  4 files changed, 380 insertions(+)
> 
> -- 
> 2.44.0
> 

