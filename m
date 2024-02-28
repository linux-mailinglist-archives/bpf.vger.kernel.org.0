Return-Path: <bpf+bounces-22933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E45C86B9F1
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D641C24D96
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 21:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5C870031;
	Wed, 28 Feb 2024 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hprQCcyy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21C486270
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156015; cv=none; b=cC0J2mRyM0ZdEBX7nQQJBL0Lsp1lGATEtB17KzsjBKJjFIRUHhgBw0W2X2UVULNu16eKYxfbYsy/83ktfFgEjdBLWp0icCbqCYr6fhj4cTiOpqjy3kkW+ghFrpZcmKK3W+sjVMpod6G/Sd2rgDLs+iyyKT5oYUOr+qxN7bOp9as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156015; c=relaxed/simple;
	bh=MUUeiic5liwCmV/zX7mwq+kKPZ3DoHxxuMbKtxzl0ZU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qNxvJE5MGuHY/00ZPqsFOjI6CvUidmqaiiqu8+cSnuMuxvnFE5qj6L5rPlB++SeBAMyceWQE5b1keGrJ+NcIqupDHO7M8VqPUgN/te2KWR1YoD+0RcqY/C1CtrcMRKdJhgPkPsDoL/1mWcPcsMNVZrBp+RJ8L5zLRD/Y93Jbr0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hprQCcyy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc49afb495so2667115ad.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 13:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709156013; x=1709760813; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TCtzvyNu4G5fsQsF/23bf2beDOqfoEzsEUlTUMbgS4A=;
        b=hprQCcyylavYLWqwWMG822oajEGT1RzkLHukSDJqWCLr/NnuVH00J4OBlqfsEewAAQ
         sZJ9KfvjW0biz8gsfxRxF7YUfYe5s2UeC8uWHdr9r15wkiZG1JQYaq/XupaD5ET5B8Xt
         hPbowrWmfZUVeLpeDxEoy6KdLexOgHfQZuR2aHFqdYSw3fdDrzMpzr3SRF8OrGCZUhRs
         s6ovQm+otuOn1DtGdnxSpdduVneIT32WYZCGp/EasJNQajBkVdRLRGMaJ7ld7ER7G/BX
         Eys0MDqaCdLpifOQWqWhAL8ztt5uW40b1Nm5ghXHZwrFyHl5ouyByyyZM+Vb6SS23fJz
         tjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709156013; x=1709760813;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCtzvyNu4G5fsQsF/23bf2beDOqfoEzsEUlTUMbgS4A=;
        b=WZb6L0YJJWMFiwrwdzdcc/6AjvmQt583z2TPk3s6xxQUsD9z1N6lqKu3YUOOExoXYd
         6HtSsTBfcW8hBxUzvI5382JnFpMAXo/yFIwZA0PJWyAw8hJTpi8zczOBc97HrnkCv3wT
         f7MxA0xPMTKkf0ZkdDOENyIRFw6d5OCdw3FiK4LfO1SplraIYgVGvCTG5qdm/G69ZrS9
         DPx+chMLvpF97cor4ckIijAVDKqnrX/PYmNCQ5SaY7HQjiZIyUUoRgUbvtP1PzlYuRIC
         m0UG/qnNHo2WMDMoBy9uDamMesqlGkYpMsaeehXAmPsLqBv55XPU/oOkm/NCsJMda4dG
         j32w==
X-Forwarded-Encrypted: i=1; AJvYcCXBow8Quspiqp0po2fRlieQi7vsPhrvwnc2ZHRvT+rpOWuG2Pau6B8TtZtCZEQkwAqba9QNqam0qa5oDjEETah57i+G
X-Gm-Message-State: AOJu0Yw1Ch4odlM4s/2oe9vOIfT4q6te5Q/HS9yMd70pSEFqqT1EtHHW
	KAJqetmxKo40ZrMwLkb85mM8bE9NIbQ6xv9HGyhVjopMCMpLcvAzkpCvUtTu
X-Google-Smtp-Source: AGHT+IHE5AanMASu9/bkH9Nfj1d+VpZNBTLkYyD+qRjQCPr56Tes3K8qSe2GUQiD/14DrPNGwHAJnQ==
X-Received: by 2002:a17:902:a3c6:b0:1dc:b6bf:fae8 with SMTP id q6-20020a170902a3c600b001dcb6bffae8mr160306plb.59.1709156012860;
        Wed, 28 Feb 2024 13:33:32 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id mg11-20020a170903348b00b001dccaafe249sm1677176plb.220.2024.02.28.13.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 13:33:32 -0800 (PST)
Message-ID: <773a54ed9f0cfb91c1b7c1978070bb86e42ac568.camel@gmail.com>
Subject: Re: [PATCH dwarves v4 2/2] pahole: Inject kfunc decl tags into BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: acme@kernel.org, jolsa@kernel.org, quentin@isovalent.com, 
	alan.maguire@oracle.com, andrii.nakryiko@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, bpf@vger.kernel.org
Date: Wed, 28 Feb 2024 23:33:28 +0200
In-Reply-To: <7bpvkfzqfawuzltt7jicekwlbxokdbprom6io3fxef3rbng4ud@hwohkmt662ar>
References: <cover.1707071969.git.dxu@dxuuu.xyz>
	 <28e81ccf28d6dd33f6db50af6526dc1770502b8d.1707071969.git.dxu@dxuuu.xyz>
	 <1853738ac796d75c53970e21b6d61bf5140a6cc1.camel@gmail.com>
	 <7bpvkfzqfawuzltt7jicekwlbxokdbprom6io3fxef3rbng4ud@hwohkmt662ar>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-28 at 09:07 -0700, Daniel Xu wrote:
> Hi Eduard,
>
> Apologies for long delay - life has been busy.

Hi Daniel,

No problem, thank you for reaching back.

[...]

> > > +static char *get_func_name(const char *sym)
> > > +{
> > > +	char *func, *end;
> > > +
> > > +	if (strncmp(sym, BTF_ID_FUNC_PFX, sizeof(BTF_ID_FUNC_PFX) - 1))
> > > +		return NULL;
> > > +
> > > +	/* Strip prefix */
> > > +	func =3D strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
> > > +
> > > +	/* Strip suffix */
> > > +	end =3D strrchr(func, '_');
> > > +	if (!end || *(end - 1) !=3D '_') {
> >=20
> > Nit: this would do out of bounds access on malformed input
> >      "__BTF_ID__func___"
>=20
> I think this is actually ok. Reason is we have the strncmp() above
> so we know the prefix is there. Then the strdup() in the malformed cased
> returns empty string. And strrchr() will then return NULL, so we don't
> enter the branch.
>=20
> I tested it with: https://pastes.dxuuu.xyz/c3j4kk
>=20
>         $ gcc test.c
>         dxu@kashmir~/scratch $ ./a.out
>         name=3D(null)
>=20

The test is for "__BTF_ID__func__", but nitpick is for "__BTF_ID__func___"
(three underscores in the end).

E.g. here is a repro:

--- 8< ---------------------------------------------------------------

$ cat test.c

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define BTF_ID_FUNC_PFX         "__BTF_ID__func__"

static char *get_func_name(const char *sym)
{
        char *func, *end;

        if (strncmp(sym, BTF_ID_FUNC_PFX, sizeof(BTF_ID_FUNC_PFX) - 1))
                return NULL;

        /* Strip prefix */
        func =3D strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);

        /* Strip suffix */
        end =3D strrchr(func, '_');
        if (!end || *(end - 1) !=3D '_') {
                free(func);
                return NULL;
        }
        *(end - 1) =3D '\0';

        return func;
}

int main(int argc, char *argv[]) {
	if (argc < 2)
		return -1;

	printf("name=3D'%s;\n", get_func_name(argv[1]));
	return 0;
}

$ gcc -g test.c

$ valgrind ./a.out __BTF_ID__func___

=3D=3D16856=3D=3D Memcheck, a memory error detector
=3D=3D16856=3D=3D Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward =
et al.
=3D=3D16856=3D=3D Using Valgrind-3.22.0 and LibVEX; rerun with -h for copyr=
ight info
=3D=3D16856=3D=3D Command: ./a.out __BTF_ID__func___
=3D=3D16856=3D=3D=20
=3D=3D16856=3D=3D Invalid read of size 1
=3D=3D16856=3D=3D    at 0x4011EB: get_func_name (test.c:19)
=3D=3D16856=3D=3D    by 0x401244: main (test.c:32)
=3D=3D16856=3D=3D  Address 0x4a7e03f is 1 bytes before a block of size 2 al=
loc'd
=3D=3D16856=3D=3D    at 0x4845784: malloc (in /usr/libexec/valgrind/vgprelo=
ad_memcheck-amd64-linux.so)
=3D=3D16856=3D=3D    by 0x492176D: strdup (in /usr/lib64/libc.so.6)
=3D=3D16856=3D=3D    by 0x4011C2: get_func_name (test.c:15)
=3D=3D16856=3D=3D    by 0x401244: main (test.c:32)
=3D=3D16856=3D=3D=20
name=3D'(null);
=3D=3D16856=3D=3D=20
=3D=3D16856=3D=3D HEAP SUMMARY:
=3D=3D16856=3D=3D     in use at exit: 0 bytes in 0 blocks
=3D=3D16856=3D=3D   total heap usage: 2 allocs, 2 frees, 1,026 bytes alloca=
ted
=3D=3D16856=3D=3D=20
=3D=3D16856=3D=3D All heap blocks were freed -- no leaks are possible
=3D=3D16856=3D=3D=20
=3D=3D16856=3D=3D For lists of detected and suppressed errors, rerun with: =
-s
=3D=3D16856=3D=3D ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 0 fr=
om 0)

--------------------------------------------------------------- >8 ---

Thanks,
Eduard

