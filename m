Return-Path: <bpf+bounces-37344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B60D9953E49
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 02:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438FE288AD4
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5037264D;
	Fri, 16 Aug 2024 00:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLH/fux/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A32510E4
	for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 00:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767807; cv=none; b=hzjEN+YgRUP2ZM6j5hCNun8wEEyR3So3ZOchxiwPioRcnn+6WBGt4Lh3qFsOucMjxP+5DV07vCPsp1QG2upRJrXBfJVURAt9nn6jADi7RRWK2OqWdJckgKiRZk4UFMX10sDePHT26SJIAhq4vGPNHoRHPMaD4foxTBS0newx/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767807; c=relaxed/simple;
	bh=ckj7NLaMKCjTe/CgeIbb3klBOzSTyuxie5vBwk2228Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AjkhkQbQfOBmfnZKkpYN3994ksx5h3kUyrc2kqgflu++j7WdEFvIdWzZnU7wpYyGQzZWuxCqYxzoVBrlb/Om3aMBXuNFaW21gg+tnznl1aHtcWOjOa4KQqTGBXA8Ai3iWCYUdmvXv4Pw/Z0cyIec385983mNgLYUApgeElagMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLH/fux/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3ce556df9so742385a91.0
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 17:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723767806; x=1724372606; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w2WJ6/rpWVzXNRUn8+KxVvP85njmadRPDiq+XOW7LRo=;
        b=JLH/fux/ADxOhgcY6/w4h7jgxrnD8EBo5wT3ucR2JLpVO2LZ5B4uUzHNbe+cGP+Fq9
         JjKeLttfaq391mLftpg1Bj1vcSEeU0G6mC6/rmwBT8zfc2EyGQOy1MxFuRwvpWFOBJfN
         bE1PRko8qGuTId7Fj+bOAk7B+0nNK1Q9f8KaHWSnI1J7fliAWUSfOG+TtonpZe/qtlZe
         hFoAx2/oaI/x7gLqG/VFV3KvVnk0n4c7/QbkqxFVIvG8IvMjvZZuIcvUf28VWqDj8Z+l
         5kJ/h9P5cUFkhp79I0ESpSKXoZdsj6sQ6Wr3flhRKFkKV0yuhEEPOS+5up6rcpdP9hsp
         pxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723767806; x=1724372606;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2WJ6/rpWVzXNRUn8+KxVvP85njmadRPDiq+XOW7LRo=;
        b=PLrXJDNBFDzzsFdmh/EamuBOAc7WfuxvqAmGZJBRzMwL6qrQu6mlyAkNLu2PqJsSWo
         01vWgXm6epDANDCIXBqmZWMj1KuCMhrob1nMvg63f2hjuFX3bRezoN9gPrX987K2b0c/
         HQ+s8aIcJt7s4brNdyptEg1xrqcXbO9CVRQbAJhJQqtbR93BrSz+33pNTJ4fHAFRGnJL
         c5DY0RzUo5u52uar3ZhQnQIbXCYDGuuS3cxLa5emFpdubHkcgyKRVPkWy1zZEP62ATmi
         iQNTpQifYKA5i4kgK2ck+FVILa1DAoxbFleqi9Tzixi8BMuZGpldIxvrRBsqmTPq3XZz
         fuNA==
X-Forwarded-Encrypted: i=1; AJvYcCUImeXlLQstOelfXhHnjE96H/YSe8f5zEShJeXn01IsuYtQblpETt5N31nFm6HdYpYLG6Kzr2XGTF2oHTVX/Otf48ae
X-Gm-Message-State: AOJu0YyQllCgkoliISB0Hzbek8iuyYZacNTFPH9AsWDxA3Yq0teLfjyb
	hGovR4GhEGZJCKWiOTFPhP4kvnvxkoxlKUVkZ+h7DORm09zHIdZa
X-Google-Smtp-Source: AGHT+IFC3Ia353Zz2rMQCtuWCQkFWofisacWvh4as8tqGk5OMKuXK6uxO5o9pmzr9YjoNMs1agSmHw==
X-Received: by 2002:a17:90b:128f:b0:2ca:2c4b:476 with SMTP id 98e67ed59e1d1-2d3dffc8f25mr1557578a91.10.1723767805683;
        Thu, 15 Aug 2024 17:23:25 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3d94fa2sm436342a91.47.2024.08.15.17.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 17:23:25 -0700 (PDT)
Message-ID: <92f724366153f2fbd7d9e92b6ba6f82408970dd7.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next 3/6] selftests/test: test gen_prologue and
 gen_epilogue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
 kernel-team@meta.com, bpf@vger.kernel.org
Date: Thu, 15 Aug 2024 17:23:20 -0700
In-Reply-To: <0625a342-887c-4c27-a7a7-9f0eadc31b9d@linux.dev>
References: <20240813184943.3759630-1-martin.lau@linux.dev>
	 <20240813184943.3759630-4-martin.lau@linux.dev>
	 <b9fc529dbe218419820f1055fed6567e2290201c.camel@gmail.com>
	 <0625a342-887c-4c27-a7a7-9f0eadc31b9d@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-15 at 16:41 -0700, Martin KaFai Lau wrote:

[...]

> >      SEC("struct_ops/test_epilogue")
> >      __naked int test_epilogue(void)
> >      {
> >      	asm volatile (
> >      	"r0 =3D 0;"
>=20
> I also want to test a struct_ops prog making kfunc call, e.g. the=20
> BPF_PROG(test_epilogue_kfunc) in this patch. I have never tried this in a=
sm, so=20
> a n00b question. Do you know if there is an example how to call kfunc?

Here is an example:
progs/verifier_ref_tracking.c, specifically take a look at
acquire_release_user_key_reference(). The main trick is to have
__kfunc_btf_root() with dummy calls, so that there are BTF signatures
for kfuncs included in the object file.

> >      	"exit;"
> >      	::: __clobber_all);
> >      }
> >     =20
> >      SEC(".struct_ops.link")
> >      struct bpf_testmod_st_ops st_ops =3D {
> >      	.test_epilogue =3D (void *)test_epilogue,
> >      };
> >=20
> > (Complete example is in the attachment).
> > test_loader based tests can also trigger program execution via __retval=
() macro.
> > The only (minor) shortcoming that I see, is that test_loader would
> > load/unload st_ops map multiple times because of the following
> > interaction:
> > - test_loader assumes that each bpf program defines a test;
> > - test_loader re-creates all maps before each test;
> > - libbpf struct_ops autocreate logic marks all programs referenced
> >    from struct_ops map as autoloaded.
>=20
> If I understand correctly, there are redundant works but still work?

Yes.

> Potentially the test_loader can check all the loaded struct_ops progs of =
a=20
> st_ops map at once which is an optimization.

Yes, I should look into this.

> Re: __retval(), the struct_ops progs is triggered by a SEC("syscall") pro=
g.=20
> Before calling this syscall prog, the st_ops map needs to be attached fir=
st. I=20
> think the attach part is missing also? or there is a way?

I think libbpf handles the attachment automatically, I'll double check and =
reply.


