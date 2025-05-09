Return-Path: <bpf+bounces-57926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1CFAB1DD5
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 22:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC4B4C6DB1
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 20:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BA32609E9;
	Fri,  9 May 2025 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqWkfo0w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA1225F968
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821868; cv=none; b=XDmaDrrFAVycn68rjLa63beoMF93gHKAUjpJx2ilMDGjvciKrxB4Q3SzEywPnYSF3eKB2sF4IFbq8TaqrMXAodMFXrl2Vob5zbDlNDEZCIuwnJYiWzoL99107GOOkXv2MIJlOsoeTMMUbJfUHG92n4sLyRadtwz8MxCRaivSa24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821868; c=relaxed/simple;
	bh=aXaYtOilDbcJPJ+W0IptEWoUeSslZypmpojlegsMbk8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F/+fyvXjPlSI6/zinzQEub2LgknFg395ld+N6HpC1liCkVgtbpb6YnVfeVW8bcQ3fhXf9cZhJY5+d4aDDKKlyckewY98Yredge142DQFWvPe3zU/+wXLeTZ0BCGv6ydgt/Iu7ZcbRRym1rvgjse+RyDZImhI4JctdjJaTHEu9Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqWkfo0w; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7394945d37eso2379863b3a.3
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 13:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746821866; x=1747426666; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Q8eMfVKF4jbKtQwlxfFfb4HKuvQkI7DFY4bLdLNB7g=;
        b=PqWkfo0w1zr6uOpxQKqnggT8O2YkyJfSp23RZJ/skp5Did/2h69JWQB8446GYjf7f9
         MPtHZ+kv/xcRKyYASypqmN6XsAiotRrG/NNu5ZOJN9sBPs14+kM9eDET5iHTGqRZM8s/
         9i5jP0l6uoiJqSC05g2mGkisJUp8jEke0VwFMRRAekIHl5lYLgnpDi0YI0oL9LJVvQZh
         fzLNsEmPZH9rfQ1D1USJxL5N/gyO15lHBy/jGyhaaKcgIiC+D481sJBrlFO82yt7v6BO
         p4mdDyPKTq85XAbZ4To7idX1law0jp6Eag18fBSHecGvzxHdRpQCQotDaw+HMAo/WRbN
         mtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746821866; x=1747426666;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Q8eMfVKF4jbKtQwlxfFfb4HKuvQkI7DFY4bLdLNB7g=;
        b=oYSnUiJLtripFzWMrHEvL+vLVlGinPJIuKKkiNU2aURJjMeSiy+9YXPaAFJmDGbEUK
         ybPFeTxXOFs1EkOI09rvVfCVOB1OBsYjYxnpMHHpx1AlVsvuPRAQ4tXj8DBtq7f5QYP7
         Ldfd0P1FefF4KyphRd71SXCXQoRvUKJnXp2G2piAe0TnQdiFBcwRxkhcs1yJFEI3sGw2
         ijHpgIZ3MAxWpZYg6aedNOi8JTTxfm+RE51Hr0qTXbKjAFecyk3uZjUROfLV6IzDMfCq
         WtijVCsnV33MF4qDTIzTuYqNZh9a5Oom+zx6JlWu4W8onvrI9wwzLu8b/HISRxd2BDX+
         F68g==
X-Gm-Message-State: AOJu0Yz3oG/oBaehVS+pNCCBMNFt1SFo9AXwECUWDN7CuLz4rlRDkS4N
	lbSI6gshgzPBy90opUznSejwXuADo25IDONbfUtF1OszWnnPzYjdnoR6xQ==
X-Gm-Gg: ASbGncs3RvApw1o+l42A1OOLplGF36jmGM8FdZUsdWQKGdJwGnRDONUs0ZfHG1vneSM
	DCqtzkk0Waz3bZjSojPT6DVUPuqsP7IfYjJ9YmXF6cn3Vd8yPCZiFGkWRdJUROA3aVFcFrGNlz6
	GqiVim4aK/9nmAYHQHNR69KDuRRZpz7JvBxjv4b+OxIULDXq9+gFmUhkekwTo3TTs1O+zeSxFUC
	rLuSBavok+tf5u9QB27sOzU511HvgfnNOKni+8h8B0hC6wsLVYIznaVl7YsFoHkJeKwNqi+zKkf
	Bgjobf6L9Oua3AIEqf2TTUww4f15vTUUuvpwxjWS+8/6u7M=
X-Google-Smtp-Source: AGHT+IEyORV935qBRcaChcFeC6THk9mSeMtqRzgbAWx8/847CAzL4odiU7b34XwJ5DNsepO9qoH44w==
X-Received: by 2002:a05:6a00:2e1e:b0:740:596e:1489 with SMTP id d2e1a72fcca58-7423c09fbc0mr6595205b3a.23.1746821866311;
        Fri, 09 May 2025 13:17:46 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a8efa2sm2131436b3a.165.2025.05.09.13.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 13:17:46 -0700 (PDT)
Message-ID: <e83130562a65c3112d0428d4d1b83ec4dd16e8e1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 08/11] bpf: Report arena faults to BPF stderr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Barret Rhoden	 <brho@google.com>, Matt Bobrowski
 <mattbobrowski@google.com>, kkd@meta.com, 	kernel-team@meta.com
Date: Fri, 09 May 2025 13:17:44 -0700
In-Reply-To: <CAP01T770Qt4-S6hVvxzMsyDhsOm3-fEJ1+HgsjikdBfkUjdyFg@mail.gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
	 <20250507171720.1958296-9-memxor@gmail.com>
	 <a071c33a195642de5530f897880e44bc1416a86b.camel@gmail.com>
	 <CAP01T74uq5Uyy6VHXyA_yVeO9rdU7svnQv90Z7auerApjbRfQA@mail.gmail.com>
	 <e78b2cf09f6931ec8e7791e35c8b49f19bf1d4b5.camel@gmail.com>
	 <CAP01T770Qt4-S6hVvxzMsyDhsOm3-fEJ1+HgsjikdBfkUjdyFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-09 at 22:10 +0200, Kumar Kartikeya Dwivedi wrote:

[...]

> > Arena access is translated as an instruction with three operands, e.g.:
> >=20
> >   `movzx <dst>, byte ptr [<src> + r12 + <off>]`
> >=20
> > As far as I understand the code, currently `addr` takes into account
> > `<src>` value, but not the `<off>` value.
>=20
> Ah, good point. We could certainly reconstruct it.
> I'll look into it.
> For prog authors I think giving them src + off in the output is the clear=
est?
> IIUC that's what they'll see when they bpf_printk the pointer, too, right=
?

Yes, the final address where access occurred.

> LLVM wouldn't insert cast insns unless the pointer is being loaded from.

I think so, have the following docstring in the BPFCheckAndAdjustIR.cpp:

// Support for BPF address spaces:
// - for each function in the module M, update pointer operand of
//   each memory access instruction (load/store/cmpxchg/atomicrmw)
//   by casting it from non-zero address space to zero address space, e.g:
//
//   (load (ptr addrspace (N) %p) ...)
//     -> (load (addrspacecast ptr addrspace (N) %p to ptr))


