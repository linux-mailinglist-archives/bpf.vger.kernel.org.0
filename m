Return-Path: <bpf+bounces-35246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B410939352
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 19:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD4E2820D4
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 17:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC0E16EC0E;
	Mon, 22 Jul 2024 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjYWhvSo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EB3C13C
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721670799; cv=none; b=ZyzBVp9xsuP6dwMRotOeLsp/+J4IHxU7pPC6t3Ws+qN4fF9mx773jroulKnq0N8m5bXbrUuY7Mvnck0S8Do1k6yjhBbP/Cap2JhtF9IX4IwtF9I9XVMPNVkregIOSgCYI+gYSXh0styJMMa/Qsjm/TzSDuenN2VBdNrBLlW7J5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721670799; c=relaxed/simple;
	bh=4wBHtsKb8LC21poJvFc0pQbuUKB1WSThlKVij8eupZM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DO/fUTWf/PqUHiqq2AHPRMGVnu4Ibvm1k0o8X9J5lVeYynINyxwtH9wIlyRznKaxs3qqaVNlhar/Ng3GZO6UVf8RX/5Ps6RDVW3fIwSikwpUCJH+3VYWUaAkTNuShrz7cYvX+A1ORtkERPE2BkeVjdJez+NdJRBXFa8jCxl73G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjYWhvSo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fd6ed7688cso20277025ad.3
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721670797; x=1722275597; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IKx8rvvx1Xei+axcwAR4OLe3uC9Ie0ltwI5cXrskKJQ=;
        b=SjYWhvSoPqhBkMuh08+NP+bFzKygiNxLQY8LnAyKCSInZp1wXsOIJSo6AIQPBrWCvk
         1uN5iRkwpg4FAx2gc/0fGMJf0jR1qIZWHfkbSzvzc947K2rzwMpdi5wDX0FHIAYBsbXx
         1KMbQPXWn340c9AjkWRS8abSUa+s0bxprQ7/J42Vm1gOlA/8ZfadJ/Cl3eXM3Wx1XN5L
         Rk8jSYAfv36Q8fCQidgLOggY2BBVnJeRmowXpojePFUMw5XgdCuF8haUJab+i2mDXPAV
         ZWiXShCEfJvpgEcAbsjpCnlgDXPUbI8+fG5WN7VJrhoNdDHBdRSk5kG6tYIXrydD+kaH
         xSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721670797; x=1722275597;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IKx8rvvx1Xei+axcwAR4OLe3uC9Ie0ltwI5cXrskKJQ=;
        b=w8v3rquZKNkBmNHI6d7t6OFCMdFjJC6ReQuKQjorNPXvdDqfBlHVF7QgYgmhtw5UuG
         n/v0bvzIvzMG+mPdUfntQeO6j2Nj2GxpjsdtOY+LiwwKH+i65OZJ3QE7jidXJan6q2AU
         6l17wnSN9bS3LAneyVRJJ8eqy51B5+jOepRERs9uwMBl8pCjbIXkkRy1wONYoujIWeQI
         9NYN6LjOakOEi4uY9L5+IzxkSiFbUdwdGpnA9LQWfb9dtH2Eijxy4z4WaMM4hsy18eOw
         5BfGYwGxBnGCQH+uY05TZZxM+E39hNE9Mtv6CjxyoRSKPjyzM5XQHiDTwJIN0R3nX1M4
         H5mA==
X-Forwarded-Encrypted: i=1; AJvYcCXHL5KRMx8VANQlmxZgRvWL5v0js5yyW25wrqOO83Od1cOs3bePJmcrmWPK5gIRpKIt9M5R0L0LrtDhEu3KcKM3Jbkz
X-Gm-Message-State: AOJu0Yx82e4suOxwnUKIHCpBK8DdxZQe3I9qRpwweZU8NMDNkLPqUVJL
	IKp+oroAgtKfI9B8j5DvZaOapbgwY9MS/i85XJa69SbDgaY5J3pv
X-Google-Smtp-Source: AGHT+IHplCsRK9yVM4D8GCBdY3oClYLY4WrXwJFXV/39Ju/Dxw4H0In1pWCkd6pLH+KfjiUmeIOtfQ==
X-Received: by 2002:a05:6a21:e94:b0:1c2:8e96:f767 with SMTP id adf61e73a8af0-1c44f86bf82mr432220637.31.1721670796928;
        Mon, 22 Jul 2024 10:53:16 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f42fd1dsm57401925ad.183.2024.07.22.10.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 10:53:16 -0700 (PDT)
Message-ID: <17ab7ea0a1052d271839cc3dbd66ebc4bdf644a7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Mon, 22 Jul 2024 10:53:11 -0700
In-Reply-To: <acb61caf-049b-4304-a083-165c18636587@linux.dev>
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
	 <86b7ae7ea24239db646ba6d6b4988b4a5c8b30cd.camel@gmail.com>
	 <acb61caf-049b-4304-a083-165c18636587@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-22 at 09:54 -0700, Yonghong Song wrote:

[...]

> > For "0156b148b5b4" I opted to do a popen() call and execute bpftool pro=
cess,
> > an alternative would be to:
> > a. either link tools/bpf/bpftool/jit_disasm.c as a part of the
> >     test_progs executable;
> > b. call libbfd (binutils dis-assembler) directly from the bpftool.
> >=20
> > Currently bpftool can use two dis-assemblers: libbfd and llvm library,
> > depending on the build environment. For CI builds libbfd is used.
> > I don't know if llvm and libbfd always produce same output for
> > identical binary code. Imo, if people are Ok with adding libbfd
> > dependency to test_progs, option (b) is the best. If folks on the
> > mailing list agree with this, I can work on updating the patches.
>=20
> I think this is a good idea in the long time.
> Let me try with your patch.

What do you think about direct dependency on libbfd for test_progs,
should I update the disassembly function or popen'ing bpftool is fine?
I'd prefer libbfd dependency, tbh.

[...]


