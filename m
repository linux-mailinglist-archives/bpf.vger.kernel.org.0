Return-Path: <bpf+bounces-56713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3DBA9D04D
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 20:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016564A705C
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7850A215F72;
	Fri, 25 Apr 2025 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iwba7NGI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A537E134CF;
	Fri, 25 Apr 2025 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604874; cv=none; b=XajiqJrmRxewliirkQagnKj6jEKt++LdsWdV6SvGlWNPXH/lunN7Ft+NWicOIAdrgjXmJ6vo8K8/nLhKHLe/j6k+yM99a1hsNypTp08GguncZHRkkNzKQndklTRa22kzCv2rkqWPJ1zpwVmgd8PGUDZ35ZQJQfmbFBpjLl64164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604874; c=relaxed/simple;
	bh=obQ4zrMojK9A8/mwLqOzAzy3ZMJTd0ILpydGCM6gRPU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ViFWbj1tYM6OxUx6jUyPVLIJ/qV+QH1JZmu5BP3B2tcCgCnwHc39b54581Bx8Im8afnvms+oOw5TuI4fQHQY4VeOzRKwhhuKApEOWvuNzfMlXbXUzBzW3Sz+3YxYM9fVfeqkKZIdtkuhZS7p3vmH/9x8xQ/qXijdqwkrNQDdfL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iwba7NGI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-227cf12df27so25912255ad.0;
        Fri, 25 Apr 2025 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745604872; x=1746209672; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gTyXdnfQIjwq0XvLr0/yR01zcCxm7a5vo+7iUmpuOIY=;
        b=Iwba7NGI+gytLzLDztXVgObwTTMzVxMrCPrcH2qQGCXJ/xVjWBl0aOri0LJA6h4bDs
         2RcY/oarQqfAqM2DDWuPlo1HRx4FQxteJf5D5/8tB6+ZsBzxUqM+JItisSi/A7Q8rsjX
         +56a6TJNPPEQADH3XrNA8n22od0TyuIw3i8+plPdGm5WR7+j5kBWhDEiEnfHhy33+e/x
         NeLQ/Kd2B0AsGV4706Fu/EHWdBlJwQRZjaweQfojFoNwRlCxqPt+F1Zpj30BlHL6NwmK
         AxYPAIgCwwfFO4lWw5b5vbkT48y0hiuQ1okGJ20iy2XyCZEQvzvW/DVUCIiA3GEL+rYy
         jQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745604872; x=1746209672;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTyXdnfQIjwq0XvLr0/yR01zcCxm7a5vo+7iUmpuOIY=;
        b=eCyEHt2n7LL+4R2pXNNrJPo3lskCxVpss3YfhvkjCemDQ/gzZxnmsaP2EFNPEP0DJK
         JrAtOO940WUyGVVmk5PiExsd9Dw4kuFPz3m38hPbk9Jb20HGq3FVW+icd4XeFavsnk1z
         +bCJ4zx4xzy8lLqX8Q5H28b7+PTku4mHU7l1n11k+mBlXonLvu6fXBgzsZQT8rb1tI39
         26NxXPbh+hgjIiBvOXg0tQeQNgk//T4lGHEZGBCkrBLqMEEl+kuUyRa91CdYRMRgH976
         U+cEL04xZA3qpVSIe43Dv1OroGR4kl3al6qGS3XRbKSar2RB+ABX36rZW/ysa+FtLaav
         ltEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVayKHuaajXeFrxECXMxFoRDITiWPKmDL6ZNSVagqFTM4VPb9/O5nRzZsipOwVWDeIKfq0qyTTuag==@vger.kernel.org, AJvYcCXXHR9k2XE2B5e50V7U/pwyaJyDyReInqBR7brNfb+fiDX/5ihgnHgLj22xvp017BmM0pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPwZ1b03ix/QW/CcDBZrJLCnvWVhhy84I/q9F46vG9w1KTvFcj
	MKE/N3G1ia7Mwvk/1Mr/AeCKTrMZQ/swXaVYw1HvzHF8JTWsqa8qMVmrB4UC
X-Gm-Gg: ASbGncu+aNAchaGSS2s352KnAHYTDm3g4cpsrLKaXPxsyN5ojT8cpB1LH8tEaBkCZUh
	u0/GCTtmNx6KQIiamXZZ8i/sHMLdce0XsmbvxTxHNzalJ8uzqfqJNzyjWieLYeUY2wybH0RL4gx
	RV/erQr6HLQJXSByq+I1QZGwesg4xc9jmi/SULHuabUbIpt6LpWh7UkbvN/mZsN/JGMRG1fMru+
	ax4Ndre/day0EDwqkcIftZzD+vMdZg7T0/H1h8MYPxuqQlNkdzcyBEJVAsoTgt8Sbv9AvlH4tab
	kdJg06Wl4bfnR+AsnI5J7aX4P5P9gALulGL0uIDmeMh2wSQmZg==
X-Google-Smtp-Source: AGHT+IGBFBGOgWX+dO86lQqILDBGp4QZNBtMNP+VgD6xemjnIbj75PISVgclOWZ5N0uOMo4Tu4Kc4A==
X-Received: by 2002:a17:902:f68a:b0:223:fbbe:599c with SMTP id d9443c01a7336-22db4981ef9mr101216295ad.19.1745604869984;
        Fri, 25 Apr 2025 11:14:29 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::5:5728])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbdf7bsm35866465ad.87.2025.04.25.11.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 11:14:28 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,  Arnaldo Carvalho de Melo
 <acme@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,  Ihor Solodrai
 <ihor.solodrai@linux.dev>,  bpf <bpf@vger.kernel.org>,
  dwarves@vger.kernel.org,  Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: pahole and gcc-14 issues
In-Reply-To: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
	(Alexei Starovoitov's message of "Fri, 25 Apr 2025 07:50:10 -0700")
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
Date: Fri, 25 Apr 2025 11:14:26 -0700
Message-ID: <m2v7qsglbx.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> Hi All,
>
> Looks like pahole fails to deduplicate BTF when kernel and
> kernel module are built with gcc-14.
> I see this issue with various kernel .config-s on bpf and
> bpf-next trees.
> I tried pahole 1.28 and the latest master. Same issues.
>
> BTF in bpf_testmod.ko built with gcc-14 has 2849 types.
> When built with gcc-13 it has 454 types.
> So something is confusing dedup logic.
> Would be great if dedup experts can take a look,
> since this dedup issue is breaking a lot of selftests/bpf.

It does not look like the problem is with dedup.
Quick glance at structure definitions does not show any duplications,
just much more structs compared to clang:

  $ bpftool btf dump file objs-gcc/bpf_testmod.ko format raw | grep STRUCT | wc -l
  351
  $ bpftool btf dump file objs-clang/bpf_testmod.ko format raw | grep STRUCT | wc -l
  38

Comparing raw C dumps for btf_testmod.ko it looks like much more
structures are injected to distilled base, e.g. the following type is
present in gcc generated .ko and is absent in clang generated:

  struct taskstats {
          long: 64;
          long: 64;
          long: 64;
          long: 64;
          ... lots of long: 64; ...
  }

  $ bpftool btf dump file objs-gcc/bpf_testmod.ko format c \
    | awk '/^struct .* \{/ {s=1;c=0;o=0} \
      {l=match($0, "long: 64;")} \
      s && l {c++} \
      s && !l {o++} \
      s {print $0} \
      s && /^\}/ { if (o==2 && c) print "distilled?\n"}' \
      | grep 'distilled\?' | wc -l
  408
  $ bpftool btf dump file objs-clang/bpf_testmod.ko format c | awk ... | wc -l
  33

