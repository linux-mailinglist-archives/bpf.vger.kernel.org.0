Return-Path: <bpf+bounces-44501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AA79C3956
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 09:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD0E1C216E8
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 08:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8B21552E4;
	Mon, 11 Nov 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOAnpuvh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B79E20B22;
	Mon, 11 Nov 2024 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731312081; cv=none; b=sHu7UFeT7tc1aCvDCure/U+ifG7l4NWotPK/xON3SJv5Y09o7lSdDX2uCeHTEEnPbztnJlTaMUPh6+uu8TPz9RSImWdL0maueEkwVsz8vSFgWs6Jpkdo1o3eOMyvWp13FbA65glmj68ENNs3I1dFSbBtpe9xLy1MGaJZUu0ROEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731312081; c=relaxed/simple;
	bh=jZ7ENZPy7ezvm1ueMoO95rXI3rEIOWyfBlzRfA0Zgqc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QG0bH4fBWBTg+tBUuv+7HIZjbXq/2u1xbGwz//uvBbN+S/WE4HiqYXiJN8cvtdr46iZeGRGK8/aCsY6uKzc6fYsv1k3JmUSpNGcagUmziLvbFuwSTO2V/A2HNmWS3m9shkT8vp6D0VbjM/BdRMspbV5pw1S3NWiR7ZD6vEbSNYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOAnpuvh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e681bc315so2994724b3a.0;
        Mon, 11 Nov 2024 00:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731312079; x=1731916879; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8M31YD7FQ0nkvWKqMn3TSMLbR9sftbadyBeWh92HzY8=;
        b=VOAnpuvhXHm/hWtmKdw8y1PXhvJO3VHSjSwK9/dCsazMSDu96EmE8m+QmfYsdPlXLW
         5IpBUgLPu1kZ5gVnbj0g4HBQ4iE05BVtk4NqIOLB55uq0Kx1fenIoeTSCXzGFgQKqXUH
         4Ul6LhndQ97GaVEA7YJz4DuhToVUjHKLHehiTxgBQ89VuePckcgxFCVmmKkoU1TYUYn1
         LPhVdS2ML1sayJ+XmK1FyxdhDmQo7jsvBt8T4cLV3jLSTZZcqWJYacHpdPtihysI1L0P
         Ax60PXpS1CLawrWGUIExCXQDJW+Eb64HXj9Sptijn8iJmhLSjEusbfcyTHmzO3j/FQ1E
         a6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731312079; x=1731916879;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8M31YD7FQ0nkvWKqMn3TSMLbR9sftbadyBeWh92HzY8=;
        b=tGYGJ4zE38yGA9xOF1Vlh/IwemHG/u0P2a3uS7xtYjetlkR/CMEWa8bKudNjuhFCKa
         BjzkuFqk2y2XZ1/ssCh2ho/2+eCrNWy+Rc8rT/CUILJNsMDnCGbbbT19g7KG2Z+9Gebu
         gvnceT0CkdeMIwBh5ySDn+UFHq4BeQNu6PR4FxzK4WZb9CX3jhAPo8VYNkW6R0Pk4wYm
         qhksw17VYmpkVRvifRaPBVfvJrTCITClBhNl1P8AVbsyN2CsS06R5klQ/bAo2F2k4Oeu
         sRy0LveVepIYLhhU96AT33QG6pjqbSriqVx7fGB+4aW3+m/D1FHaFxXRO8o3pjM+nXm/
         MOVg==
X-Forwarded-Encrypted: i=1; AJvYcCUimXw4q+XpQ+EXWsHIKXY31v+2He5UW2+esGcQENNgAM9c8rS+k3bpSV63enAb4NKnwk4=@vger.kernel.org, AJvYcCX/wtI9YdvBBLdz9SK8uWyZku8fFk146Rzr/tnszaobiM17P7JpC66QU2kKf2jH15j9vgsKJmeSZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZYqedVxXSNkDj5ysoNWvrg3kG5aU2XWOmGL/eOXe3NR7fhTN6
	rVItc6tQl52SQqJ529IXJz8V1nhjIrEJfQf+Fhj9KtFq3AYf77hi
X-Google-Smtp-Source: AGHT+IFl3LD1BqQwGKrszPIvnvBG5PgoCfMlwB91WtdPsYx40tiL8vzpjqgQbcDyYkQYR4CVIc7cDw==
X-Received: by 2002:a05:6a00:21c4:b0:71e:7f08:492c with SMTP id d2e1a72fcca58-72413f4c526mr17682664b3a.1.1731312079244;
        Mon, 11 Nov 2024 00:01:19 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407864f78sm8447011b3a.33.2024.11.11.00.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 00:01:18 -0800 (PST)
Message-ID: <080794545d8eb3df3d6eba90ac621111ab7171f5.camel@gmail.com>
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: Check DW_OP_[GNU_]entry_value
 for possible parameter matching
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Alan Maguire
 <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo
 <arnaldo.melo@gmail.com>,  dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  bpf@vger.kernel.org, Daniel Borkmann
 <daniel@iogearbox.net>, kernel-team@fb.com,  Song Liu <song@kernel.org>
Date: Mon, 11 Nov 2024 00:01:13 -0800
In-Reply-To: <31dea31e6f75916fdc078d433263daa6bb0bffdc.camel@gmail.com>
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
	 <20241108180524.1198900-1-yonghong.song@linux.dev>
	 <31dea31e6f75916fdc078d433263daa6bb0bffdc.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-11-10 at 03:38 -0800, Eduard Zingerman wrote:

[...]

> Also, it appears there is some bug either in pahole or in libdw's
> implementation of dwarf_getlocation(). When I try both your patch-set
> and my variant there is a segfault once in a while:
>=20
>   $ for i in $(seq 1 100); \
>     do echo "---> $i"; \
>        pahole -j --skip_encoding_btf_inconsistent_proto -J --btf_encode_d=
etached=3D/dev/null vmlinux ; \
>     done
>   ---> 1
>   ...
>   ---> 71
>   Segmentation fault (core dumped)
>   ...
>=20
> The segfault happens only when -j (multiple threads) is passed.
> If pahole is built with sanitizers
> (passing -DCMAKE_C_FLAGS=3D"-fsanitize=3Dundefined,address")
> the stack trace looks as follows:

Did some additional research for these SEGFAULTs.
Looks like all we are in trouble.

# TLDR

libdw is not supposed to be used in a concurrent context.
libdw is a part of elfutils package, the configuration flag
making API thread-safe is documented as experimental:
  --enable-thread-safety  enable thread safety of libraries EXPERIMENTAL
At-least Fedora 40 does not ship elfutils built with this flag set.
This colours all current parallel DWARF decoding questionable.

# Why segfault happens

Any references to elfutils source code are for commit [1].
The dwarf_getlocation() is one of a few libdw APIs that uses memory
allocation internally. The function dwarf_getlocation.c:__libdw_intern_expr=
ession
iterates over expression encodings in DWARF and allocates
a set of objects of type `struct loclist` and `Dwarf_Op`.
Pointers to allocated objects are put to a binary tree for caching,
see dwarf_getlocation.c:660, the call to eu_tsearch() function.
The eu_tsearch() is a wrapper around libc tsearch() function.
This wrapper provides locking for the tree,
but only if --enable-thread-safety was set during elfutils configuration.
The SEGFAULT happens inside tsearch() call because binary tree is malformed=
, e.g.:

  Thread 8 "pahole" received signal SIGSEGV, Segmentation fault.
  [Switching to Thread 0x7fffd9c006c0 (LWP 2630074)]
  0x00007ffff7c5d200 in maybe_split_for_insert (...) at tsearch.c:228
  228	      if (parentp !=3D NULL && RED(DEREFNODEPTR(parentp)))
  (gdb) bt
  #0  0x00007ffff7c5d200 in maybe_split_for_insert (...) at tsearch.c:228
  #1  0x00007ffff7c5d466 in __GI___tsearch (...) at tsearch.c:358
  #2  __GI___tsearch (...) at tsearch.c:290
  #3  0x000000000048f096 in __interceptor_tsearch ()
  #4  0x00007ffff7f5c482 in __libdw_intern_expression (...) at dwarf_getloc=
ation.c:660
  #5  0x00007ffff7f5cf51 in getlocation (...) at dwarf_getlocation.c:678
  #6  getlocation (...) at dwarf_getlocation.c:667
  #7  dwarf_getlocation (..._ at dwarf_getlocation.c:708
  #8  0x00000000005a2ee5 in parameter.new ()
  #9  0x00000000005a0122 in die.process_function ()
  #10 0x0000000000597efd in __die__process_tag ()
  #11 0x0000000000595ad9 in die.process_unit ()
  #12 0x0000000000595436 in die.process ()
  #13 0x00000000005b0187 in dwarf_cus.process_cu ()
  #14 0x00000000005afa38 in dwarf_cus.process_cu_thread ()
  #15 0x00000000004c7b8d in asan_thread_start(void*) ()
  #16 0x00007ffff7bda6d7 in start_thread (arg=3D<optimized out>) at pthread=
_create.c:447
  #17 0x00007ffff7c5e60c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/=
clone3.S:78
  (gdb) p parentp
  $1 =3D (node *) 0x50300079d2a0
  (gdb) p *parentp
  $2 =3D (node) 0x0

glibc provides a way to validate binary tree structure.
For this misc/tsearch.c has to be changed to define DEBUGGING variable.
(I used glibc 2.39 as provided by source rpm for Fedora 40 for experiments)=
.
If this is done and custom glibc is used for pahole execution,
the following error is reported if '-j' flag is present:

  $ pahole -j --skip_encoding_btf_inconsistent_proto -J --btf_encode_detach=
ed=3D/home/eddy/work/tmp/my-new.btf vmlinux=20
  Fatal glibc error: tsearch.c:164 (check_tree_recurse): assertion failed: =
d_sofar =3D=3D d_total
  Fatal glibc error: tsearch.c:164 (check_tree_recurse): assertion failed: =
d_sofar =3D=3D d_total
  Aborted (core dumped)

Executing pahole using a custom-built libdw,
built with --enable-thread-safety resolves the issue.

[1] b2f225d6bff8 ("Consolidate and add files to clean target variables")
    git://sourceware.org/git/elfutils.git


