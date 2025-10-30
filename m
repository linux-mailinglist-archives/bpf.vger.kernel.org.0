Return-Path: <bpf+bounces-72954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D969BC1DF1C
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873DF189E804
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EF91FC0EA;
	Thu, 30 Oct 2025 00:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJeLP0eT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671E81F9F51
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 00:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761785051; cv=none; b=Dp5VVdi8hhaCpda8dRyRESnk/cdW+RepAvUuZjC+N+2pcrN1fm3WHYgTm04J8rTmgTb+aA4AWrk9znbunYVzoXub3lzNEttjRZOSB+MlAq3Fk/WjOEwMLem5EEFFM1VGqlx+O4kX/NINBBOBHRGIeBt8gU2gLkN/rKrBgZw3Aow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761785051; c=relaxed/simple;
	bh=I+WgTPaNnSzDBETHmmnN0SSttG2OMYV1Sg6AU3YNRyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V+q30+pSmqNcBc/XqqKlsM7KmPJD175OreQL+sMlzd6XtxXL3bZ1uFJmUvGGnJITFO2O7UfHtlqFDNsJ9IMwDXonmgkEzdybClEqBRZ+UDCOaSEStSoMwjoiToM8snMDDKbZlL3xRL8IetfCgT58Mr4SCz5cvEoOtFyYpwTQTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJeLP0eT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6ceb3b68feso416541a12.0
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 17:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761785049; x=1762389849; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cJAFdiNGbg/PA+Qv0N/d0kPPmEjoCTtUxDRG6LiXmBY=;
        b=BJeLP0eTlx6A18BPHHK9G01Asxvi08J4Meq3LFvsjbJEEvUXkT1lkCx5HFGrcEWTr9
         dJwEbyZH+XSz/ic3BiTjCmfkCzwk9y8vLa4vsbAWMX6ufZbaUV6Plu1mzR1OMi3LADP4
         1uWhVD8JR1osusntG8WJwiNAf3wa0ep5pQYclWX1vQyaA0BgRQ1ZDyYAOfd7YkAqKUdL
         TXnhgInXiaOS1V7CAyOz2+MLgWqlJ0rfqun9vAQcU2x+BDvDswCKwp5fBO7i6pGQdFa4
         kkBSjM3p2xXiQ4yq4/JxKa7k56R3O+x9734b+dm7ng4OAg0R8WOmdTfRYeoUhoWytWYu
         rMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761785049; x=1762389849;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJAFdiNGbg/PA+Qv0N/d0kPPmEjoCTtUxDRG6LiXmBY=;
        b=tKd6r5IP+L30iynY4IX4hCyzgJ/wl4LXZh6XhYHuMeJpl6HePKgxRBMrGwcsyhs3Nn
         qzru90YimXoaiERPJsco0DIV9xCeuwhwIpwoW4aTTGJ9yiG0sELAngpHzxIg9ptDCMj+
         IsFT0WCC5IIcgLAKXmGhhtaTHR/VBBMxOSt29iX2CqQ2/dpQpyTyO7LqIJGZOqqSGmY3
         uVW8uWf/wzy1XX5J7kxCzSEHV3fVTpPVGgHm9g8BITM3a7dcRDmei2qIX2bX51ocBmRl
         0N8pK5kQvdPepqvN8KSAfzVi2hRiZkXilOq1hQKYh6/T9ZfgYagnwgXguU2PsmxDA5wX
         hFvg==
X-Forwarded-Encrypted: i=1; AJvYcCUK1iMXTDJrh8uhP8rLC7uoVKQg9shNOY1rjUyHRFNpHJTP280ev0itn2nF3FiuoMgJjqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdJKdKoefqMxRWPc6jsh5Blx98S1O7g5SMrhcIRvNzE37DPJpB
	1duGCMe7hS8i4sck0bSgLdBpPA6H9Xn1X1pYB6JgPGXt0dgBNq4IOCMy
X-Gm-Gg: ASbGncsnHI6p5ALWbl61Rcdd2uN1nRYvsDMMvGcw4/RX5jRfKe3I4rArnQyse36EiJE
	BXriqK0FfgvN6sKPIeqO7BrUsOVnlVqU7VGnGqYgQQgZIhU+20Xgrp/MjfWtUnI/vMxiL2YWnxK
	7Z7M+3e2KWOKcjBGyDtVgnva0EvJI9oTFFfxUs0rFyx+X1x+J2to1z2jSuU1+ecEEgovYyAiBKw
	Y8VgdnkeBarix0zomSuT47WQvwD4vxz6MJRt2wh47u0o6RlBHHq9b80fv5YzS9tqtLJ/ppAzMML
	n5zZGVVWHu7B00u1/xXY0/R3EpN7+IrU//LjLj0k57yGfIpKgaYbpLRfsYYSMJ71IuLVg78VHCj
	QGaMLuX1D2xw4lSVDyHt0YkyVh4BRR1GDkkn372HeNUYKwSQp26Wfgsiip3R7RgNSEz8ikbYUvp
	ZYYsDGGWr/+AfOr01ndsCnpzm8tg==
X-Google-Smtp-Source: AGHT+IGCbbG0NDrHaKAWMisnV6NPj2EnZJOkjrA78/MDp4MssYSmrC/T9/+kg7TlIICD72V8eRm7Jw==
X-Received: by 2002:a17:902:ea10:b0:294:fbe5:89ef with SMTP id d9443c01a7336-294fbe59666mr1934105ad.28.1761785049369;
        Wed, 29 Oct 2025 17:44:09 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3086:7e8a:8b32:fa24? ([2620:10d:c090:500::5:6b34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d27433sm164768845ad.58.2025.10.29.17.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:44:09 -0700 (PDT)
Message-ID: <50ddff79d33d6e2d57e104f610273d647530ddbc.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/8] bpf: magic kernel functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Date: Wed, 29 Oct 2025 17:44:07 -0700
In-Reply-To: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:

Do we break compatibility with old pahole versions after this
patch-set? Old paholes won't synthesize the _impl kfuncs, so:
- binary compatibility between new-kernel/old-pahole + old-bpf
  will be broken, as there would be no _impl kfuncs;
- new-kernel/old-pahole + new-bpf won't work either, as kernel will be
  unable to find non-_impl function names for existing kfuncs.

[...]

