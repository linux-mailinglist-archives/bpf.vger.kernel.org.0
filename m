Return-Path: <bpf+bounces-27331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F9E8AC02C
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 18:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A061F20FC2
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 16:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353921A28C;
	Sun, 21 Apr 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="yw0/YaBk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="yw0/YaBk"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B65C1BF3D
	for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713718306; cv=none; b=CJI0d6Q3RXDbl61WG1Ad57QXa9yEyyFxvR3h/BPVrYHvw99F0EDjx0tk4lrJhwFVNrhVsEbWR7XF5Qwly9hmDipNNVTRxyRWxZMneTrUl1ADBrzu73iE2ehtjw69wlAN7A78HkzlLRZ6lQk1Mp53knnrOuf4mXEfRaIK2yJhYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713718306; c=relaxed/simple;
	bh=WezdThISWgbz1ps+5kFu+sjkkWY5LYPGVbzQUxqnHvg=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=ihwuh3vxgecYWZX68A+HNSQs/zLZFyQpsKhzCyyuYMDXxApa4xsVhXbRkmbxiImGH+CjMqqTiuzERZhe/AAJ8hov9HCJ/H+IzP8a7PvioliyPUhhbP+0H0inwDP17ukh1WLxOKuUYyB/fJFyakUfjNt7H6y295lsKCZWr0+UA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=yw0/YaBk; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=yw0/YaBk; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B0C95C14F6B7
	for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 09:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713718304; bh=WezdThISWgbz1ps+5kFu+sjkkWY5LYPGVbzQUxqnHvg=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=yw0/YaBkmkXmOjtQt+QG79zn7sljyDQ6DTTsri4FBtf6hC1PNSCwZnb16DmPfe+Js
	 v4bMadtryv86+tjmi1hOp0eBmXsNiXhCHDDgBNuT1Wz6MTeN0YWmqHnRK5lQRNOI1x
	 fjISGUFQD9BBPtXK06D2qNgfxckG8SkcToh6lEzk=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sun Apr 21 09:51:44 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8C892C14F5FD;
	Sun, 21 Apr 2024 09:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713718304; bh=WezdThISWgbz1ps+5kFu+sjkkWY5LYPGVbzQUxqnHvg=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=yw0/YaBkmkXmOjtQt+QG79zn7sljyDQ6DTTsri4FBtf6hC1PNSCwZnb16DmPfe+Js
	 v4bMadtryv86+tjmi1hOp0eBmXsNiXhCHDDgBNuT1Wz6MTeN0YWmqHnRK5lQRNOI1x
	 fjISGUFQD9BBPtXK06D2qNgfxckG8SkcToh6lEzk=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id CC470C14F5FD
 for <bpf@ietfa.amsl.com>; Sun, 21 Apr 2024 09:51:43 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.648
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OykyS-k9gXxP for <bpf@ietfa.amsl.com>;
 Sun, 21 Apr 2024 09:51:40 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com
 [209.85.219.170])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 1630CC14F5FA
 for <bpf@ietf.org>; Sun, 21 Apr 2024 09:51:40 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id
 3f1490d57ef6-de467733156so3607322276.0
 for <bpf@ietf.org>; Sun, 21 Apr 2024 09:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713718299; x=1714323099;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9lqeLBu6LX+yy0/r6cQpd22J0xctj4Y1RYJ9rxYpDU=;
 b=sS0/dHvl11/lXJWPj9Gm5EH4psQc//wsJVhDqa1RTKX1pT2Y+7fpsaQGbjqS0Vtn3o
 cC+Ore3hFCDou1TZieISBrpAZX0vuKLSMQqlT6Aw4Ol6+c3AzkZFY9AOoEvmpRuw1rGI
 tG5yTKYL/z7q5AwnCQN40n/Qq7unQq82zhSURg0FobW1g5rI3QG7uzZvQC+AlXzjMNWK
 vCFErdc1tfhToRDqpaed13KG8M+Pk32Q4HlfY0drfJB9McDBY213v+ih2VyqjKE8mJEU
 +ROkmbYAJrkHkhjaWWq/TKyrpRN4QXVwTT33VYrtrs3/r/GZ0ExcpIeOp7FSE2xfIdWx
 OCZg==
X-Gm-Message-State: AOJu0YyK7nYQhHo5ND77AemEbBHdCy1d+0n4g1HQIYbcddIZjutHhzu0
 W5+5oA7uitRj0JYqOnaF64tu+NXRtFxqcNTFtqJ6iasjy8Go42cy
X-Google-Smtp-Source: AGHT+IEi1LhlBS3gAx+IhPx4Kk2Fsb3UsxSEfKj3v6sIm47Rbpjxtzhi+tu4dIIbS7XGqW0xF+TZzg==
X-Received: by 2002:a05:690c:3386:b0:615:bb7:d59c with SMTP id
 fl6-20020a05690c338600b006150bb7d59cmr11727249ywb.22.1713718297593; 
 Sun, 21 Apr 2024 09:51:37 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
 by smtp.gmail.com with ESMTPSA id
 bx7-20020a05690c080700b006185b34ab9dsm1611540ywb.125.2024.04.21.09.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Apr 2024 09:51:37 -0700 (PDT)
Date: Sun, 21 Apr 2024 11:51:34 -0500
From: David Vernet <void@manifault.com>
To: dthaler1968@googlemail.com
Cc: bpf@ietf.org, bpf@vger.kernel.org
Message-ID: <20240421165134.GA9215@maniforge>
References: <093301da933d$0d478510$27d68f30$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <093301da933d$0d478510$27d68f30$@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/AfUc9L6teLA2vvmZ9hzNMUyC9Rw>
Subject: Re: [Bpf] BPF ISA Security Considerations section
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============4969697575754184130=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============4969697575754184130==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8RgQ+LtZBrdRcnfK"
Content-Disposition: inline


--8RgQ+LtZBrdRcnfK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 09:08:56AM -0700, dthaler1968@googlemail.com wrote:
> Per
> https://authors.ietf.org/en/required-content#security-considerations,
> the BPF ISA draft is required to have a Security Considerations
> section before it can become an RFC.
>=20
> Below is strawman text that tries to strike a balance between
> discussing security issues and solutions vs keeping details out of
> scope that belong in other documents like the "verifier expectations
> and building blocks for allowing safe execution of untrusted BPF
> programs" document that is a separate item on the IETF WG charter.
>=20
> Proposed text:

Hi Dave,

Thanks for writing this up. Overall it looks great, just had one comment
below.

> > Security Considerations
> >
> > BPF programs could use BPF instructions to do malicious things with
> > memory, CPU, networking, or other system resources. This is not
> > fundamentally different  from any other type of software that may run o=
n a device. Execution
> > environments should be carefully designed to only run BPF programs
> > that are trusted or verified, and sandboxing and privilege level
> > separation are key strategies for limiting security and abuse
> > impact. For example, BPF verifiers are well-known and widely
> > deployed and are responsible for ensuring that BPF programs will
> > terminate within a reasonable time, only interact with memory in
> > safe ways, and adhere to platform-specified API contracts. The
> > details are out of scope of this document (but see [LINUX] and
> > [PREVAIL]), but this level of verification can often provide a
> > stronger level of security assurance than for other software and
> > operating system code.
> >
> > Executing programs using the BPF instruction set also requires
> > either an interpreter or a JIT compiler to translate them to
> > hardware processor native instructions. In general, interpreters are
> > considered a source of insecurity (e.g., gadgets susceptible to
> > side-channel attacks due to speculative execution) and are not
> > recommended.

Do we need to say that it's not recommended to use JIT engines? Given
that this is explaining how BPF programs are executed, to me it reads a
bit as saying, "It's not recommended to use BPF." Is it not sufficient
to just explain the risks?

Thanks,
David

--8RgQ+LtZBrdRcnfK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZiVEFgAKCRBZ5LhpZcTz
ZJiOAQCJjS2nHo1vKFz9W/2hwvAyzdsoGJq6emMCW5iLnGMzdQD/bgNd6ThIKv31
V9KCfu5JvQU0qltJgifhXBmvzPeeego=
=2EEt
-----END PGP SIGNATURE-----

--8RgQ+LtZBrdRcnfK--


--===============4969697575754184130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============4969697575754184130==--


