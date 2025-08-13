Return-Path: <bpf+bounces-65566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C465B2560C
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 23:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D77B67A92C4
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 21:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F632EB5A7;
	Wed, 13 Aug 2025 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4t2+s3P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD593009DC
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755122289; cv=none; b=B0Y0EfVebjWsT3WMK2wTuwpaFSVk+dStL/O6xil+BDWUjrynnS8Ua36lpiXv3llFBBM12gM5pIA7opwsJbh/DLDHzFBFUbCVo4rk+mBVataS337i4jN3GazeuUyOfmZi3yUc90tPX0cC+lOvueIONZabP5b++jJ4FlV4fSjIC4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755122289; c=relaxed/simple;
	bh=1zEhJnd82R6DRPcDw1ruJtgtYOd09VgOf+zVYBsY9Do=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kOO9G1AmtXMO3wvxEcDhwea97+D5byg7t1QVnXbyUMot2iu4yCRoD6cMdBJa575mc5y4foGqla9wuL7vjZEbyDlbLKQFjcP7n+EXcE1EA3DZQ/LAdgCTthg9Az51msLwkhQwoxd/+0sXYZp5vnEUv3VHCU2+bOpUFDoWK4qe6+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4t2+s3P; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e57008acd8so2652595ab.3
        for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 14:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755122287; x=1755727087; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1zEhJnd82R6DRPcDw1ruJtgtYOd09VgOf+zVYBsY9Do=;
        b=C4t2+s3P9UEYD+ScX5FC6m5DbRxwC1rUjzGtVXi/O5fGRNhCCAssmwGTGBypuvfZJT
         RGNnqJ8CkOv13qAO/3ZOalNt8ox4hZQZbjMWkO7rearg2fvJCEABGoZaSTZLUZRQJ63q
         1srarIgl0cGub9n231bi/MDBptjoAtVfAq70ggpON0YbOyZzpPxzX4xHvAvq9h5f0g1x
         tZNsYYQ+y7rRaVw0ZpIMrZ0E2SFeB0k6GU/Kq/dVFwIEqt4Z5+jrkQtH4mYWBJrUcmt1
         Rj2DL2XpMSEVVnWlJaOFzJAw1YcwNFxkDnJxFgTH9N7jPgejOE7WDCVDO1yjCcCeACsy
         /31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755122287; x=1755727087;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1zEhJnd82R6DRPcDw1ruJtgtYOd09VgOf+zVYBsY9Do=;
        b=ns54/0yTBuR6k7kV5S9EjMOX4JnQ0VewU/j8vUDwTuoREOzeGXmNEQtDbkFTNvIk60
         LoJIqVzOS0sZfGdRU2K2hrSKhgMfA1gm+OHmZlv1nE4MJ6bkL/qViQa7KID3NN5uOGEi
         0oi6vStQpVmox7C18enV6d3Tz/wKBP4+nD3jFvwVrfNqXx+aeU08XU3ivc8qXVn2IEdX
         ZNr5tddoT3QJg6+hcue2mXKw3ZmJUoAgqK8CdbBAlo1+2FP4ksxi5J8TeiJa1W61e7Mh
         ZgCsk2oMIlBRtsgB2b3wSOa6bn5xC6YexOjAgK2IR4133EWTMpQnPyJGtddVdxaSnGLK
         iFdA==
X-Forwarded-Encrypted: i=1; AJvYcCX6GbzNUkz47UAx+/51FhhyLEeQjqClKp+ZNpsKbCHqc8oF2pdnaf3CKLUm8pMAJZ+4YAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo/3Khx0qTc8ZowqWgUAOnjSVA4XW5S2Ium5RB1x7W3doiOmut
	fY31NZ3ELm3SBNSAm44ECBVMBw0KNoZMQPNoWH7OGoYqtQKBdQiY5BCZ
X-Gm-Gg: ASbGncsVX/E1U+aAPkcDucN5JWvbP9qgJz4O92EIPZkMy4v7VnKyxW7rdsuhXV5duY+
	R1fj1HFilReX5fATuoe86P1jVYf7ep2EqZ+0scvQNB5tNXzfs5Sae0KzbFDDnSG57dA/srSidkg
	OhIqgSi6MqKR9WqnsC/nzIo/WK+92RqNod4E+nV/fGo/jRsVkbtmDCHGwDo9itRIPgIASahWAHi
	BJLVpKchJyRV4OXdGMfH/KhAZvlJR1V+Yxx4ZEz72hMizdgIlSqGLbmpwpMOlU+OAUa6tM5albT
	WvEXss5UntVrxyUQOuO1sAEEStmIXMRBpT8bKlJkfJGyGrFPOW/PIXiK1NPRqC7KgPeMRe82uoF
	1KI3ecn1agb3Eg5FO5iWtlhhN4jd7
X-Google-Smtp-Source: AGHT+IEoSoGGAgBGe1aAcTrhsiZBu8cKeR3K5DHbgUsNxQmcEKv196uWVX/EMh5+gpYJhwhqV0QqFg==
X-Received: by 2002:a05:6e02:2788:b0:3e5:42ec:1378 with SMTP id e9e14a558f8ab-3e57076e539mr13547405ab.2.1755122287175;
        Wed, 13 Aug 2025 14:58:07 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::e47? ([2620:10d:c090:600::1:f146])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9c87f9esm4017019173.84.2025.08.13.14.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:58:06 -0700 (PDT)
Message-ID: <8b850ee32bbbd3a8d38cd9ffbb98ebe6d085d631.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add BPF program dump in veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 13 Aug 2025 14:58:04 -0700
In-Reply-To: <CAEf4BzYVhhX3N0uCB+kOm+yeP_j7bC-mfoDbSdAB5WDq1_=W+g@mail.gmail.com>
References: <20250811212026.310901-1-mykyta.yatsenko5@gmail.com>
	 <c3d641238a669ed2426abdbfa0d7a0f568f7a0fe.camel@gmail.com>
	 <CAEf4BzYVhhX3N0uCB+kOm+yeP_j7bC-mfoDbSdAB5WDq1_=W+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-13 at 14:51 -0700, Andrii Nakryiko wrote:

[...]

> > I have a feature request for this:
> > generate local labels for branch and call targets.
> > E.g. as in the tools/testing/selftests/bpf/jit_disasm_helpers.c.
> > Or as in llvm-objdump -d --symbolize-operands.
>=20
> should we teach bpftool that?

Would be nice to, imo.

> > That aside, it looks like the code is very similar to bpftool's
> > xlated_dumper.c. Is there a way to share the code?
> > There would be now three places where xlated program is printed:
> > - bpftool
> > - veristat
> > - selftests (this one does not handle ksyms, but it would be nice if it=
 could)
>=20
> I was going to ask the question if veristat should just delegate all
> this functionality to bpftool using popen() (it's very likely you'll
> have bpftool installed if you have veristat), but I guess if we can
> share more code between bpftool and veristat, it's fine as well.

If code reuse proves to be convoluted, popen() sounds like a good idea to m=
e.

[...]

