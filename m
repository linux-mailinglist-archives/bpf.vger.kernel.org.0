Return-Path: <bpf+bounces-40013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D92197AA86
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 06:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DB94B2A789
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 04:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A8A364BE;
	Tue, 17 Sep 2024 04:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8feKbRA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D822126281
	for <bpf@vger.kernel.org>; Tue, 17 Sep 2024 04:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726545659; cv=none; b=TYuhFN+MrM4IGpxDvKJKcoo450mEaLCWemFVZdFJJPGWrAj7TTywsB5j/wgD/Sj9x65THKkzXA513+7hLWm/s6ykYx4nY13zV7ZfIBZgsfUfTC0+8dWM2vMHJjQl+uuv7qyqzE0wTwYHJvXWYTWGAu8LDxrVa04qgQK39aJtlk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726545659; c=relaxed/simple;
	bh=2mT8KGFebWG+AULllknbMLjU0lTdyLFDptjcHqYQn7U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hJSqUxuYQvItxLBiY1/k0fs/MPLoc9EjeaKUwonUqOEN/RG6eoUg+OG08p7k1q75AX+RgsavV1V1Z6CSRIx6zSlAHI+UGVrpBfpBE+ieOVUI2b2OTWT0LTaN0+tNgD4G9nQsSzF/W5OFAx/b0oW5O4a3sCH3/fuVieDaAvmpl2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8feKbRA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7191f58054aso4234214b3a.0
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 21:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726545657; x=1727150457; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uRXfbSdFSZ2HXbXPn/8w1OsVGkZ0RIFT5CDEX8AaCuY=;
        b=V8feKbRAVwdE4CguwFHVBNMEjr45+D5kG141X1fLNIwsBV+rYh4JXzRWlqi7oL04i+
         n6xJQfmb9gKjbm9KReiOgL3to91SXNJAzSoPNrp/jcduFDqDeOVaqOL3Vtk5mZEDgTqD
         aUNYw58w2rTdUncPVXm5246ZZivUa8h0z1STDjJhkSzSkbEVFb9NSFX0kqJ8BD3Klagt
         WbFoSE+aWlyC9V2ERoAP6y9fBa/lZCd/fMtmE6gbl8vBDSkgL8yQeobRCdybHYR/ZN3U
         Z568W+RNHn6eZGiUrk2oy20y8tAh4zkjTJ6ph/2G0tkIIQzSYWKxInInJTfX5Km60FQF
         1wVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726545657; x=1727150457;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uRXfbSdFSZ2HXbXPn/8w1OsVGkZ0RIFT5CDEX8AaCuY=;
        b=CqjcFtpJ1CQjiEQ4GQR3BS/gERp52mJmkaMlOZiBPzgYYTqdY05urgpKhRIvRvfDP6
         3JWljPzUkhOr7iGH8TGvpwyyRA7xjGNQc1CPrmV+svu9lwsptmex3I2l65Plz0gnLyyc
         gse2RgMi/vhc/DLPq/PF+uBTK6FIUd9oWKpflFqqjnv2+TKEAk6sdgu7dAajM0BoCM27
         WQOkvWVcgpQlikJQGF1d0XjAf+NTO9yrGKogF3cIzn8he1gySXtXXRkq9r2w9Rau1LGt
         Ty3tvg8wT0JN5zYBll8tTlRl555Z9bmmmKSjdL7RXV2wO8uVx+0RYvQdz0n+FjKA8ciF
         xjsg==
X-Forwarded-Encrypted: i=1; AJvYcCWzQeqK2HVau9rvDJAbNnJeIMrBweVNAa0epmZQjlV084O82EwIB+40Zet763qNlGsOF4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJcAeKOMUeTh0ljqogBAehbyETT4ACPi4YlMNMMljg5LwG1SNS
	mNGgEvE7F67G375mXXrdsSCuKtId6RFqlR0uT3cd4CQ9jrjBAER2XWJujQ==
X-Google-Smtp-Source: AGHT+IFGxdGQvNsO18cELOL8L8tKXvmpDtiCPpf630la7ZsLWyIkjRVzMzN3eWCH0a3BPHCUUq4dPw==
X-Received: by 2002:a05:6a21:6e41:b0:1c3:fc87:374e with SMTP id adf61e73a8af0-1cf764c255bmr25570800637.41.1726545656820;
        Mon, 16 Sep 2024 21:00:56 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bc4270sm4392501b3a.201.2024.09.16.21.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 21:00:56 -0700 (PDT)
Message-ID: <dbf5eb3056eabbd44775d526a64b53e1a43b9f59.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: set vpath in Makefile to
 search for skels
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com,
  bjorn@kernel.org
Date: Mon, 16 Sep 2024 21:00:51 -0700
In-Reply-To: <20240916195919.1872371-2-ihor.solodrai@pm.me>
References: <20240916195919.1872371-1-ihor.solodrai@pm.me>
	 <20240916195919.1872371-2-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-16 at 19:59 +0000, Ihor Solodrai wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index df75f1beb731..365740f24d2e 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -622,10 +622,11 @@ $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $=
$$$(%-deps) $(BPFTOOL) | $(TR
> =20
>  # When the compiler generates a %.d file, only skel basenames (not
>  # full paths) are specified as prerequisites for corresponding %.o
> -# file. This target makes %.skel.h basename dependent on full paths,
> -# linking generated %.d dependency with actual %.skel.h files.
> -$(notdir %.skel.h): $(TRUNNER_OUTPUT)/%.skel.h
> -	@true
> +# file. vpath directives below instruct make to search for skel files
> +# in TRUNNER_OUTPUT, if they are not present in the working directory.
> +vpath %.skel.h $(TRUNNER_OUTPUT)
> +vpath %.lskel.h $(TRUNNER_OUTPUT)
> +vpath %.subskel.h $(TRUNNER_OUTPUT)
> =20
>  endif

When I try this patch, the following happens after first full tests build:

$ touch progs/verifier_and.c; make -j test_progs

  CLNG-BPF [test_progs] verifier_and.bpf.o
  CLNG-BPF [test_progs-no_alu32] verifier_and.bpf.o
  CLNG-BPF [test_progs-cpuv4] verifier_and.bpf.o
  GEN-SKEL [test_progs] verifier_and.skel.h
  GEN-SKEL [test_progs-no_alu32] verifier_and.skel.h
  GEN-SKEL [test_progs-cpuv4] verifier_and.skel.h
  TEST-OBJ [test_progs] verifier.test.o
  BINARY   test_progs

Note that multiple binaries are built.


