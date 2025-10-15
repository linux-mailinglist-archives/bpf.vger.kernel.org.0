Return-Path: <bpf+bounces-71033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 963D9BDFDAE
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 19:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85D8F4F0DCD
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 17:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4084933CE81;
	Wed, 15 Oct 2025 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ei4gRLdn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA29833439D
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549348; cv=none; b=Xxg+bgsvNoFkm2LmZEQgjxyFlQB8lbq3Sc6SO4GNXS/GOUdXoKqe2lBw7e8krbJxtyLg0MbaRkRcThXF55qwmeBdBPxXI+i6EaGueWfv9iEbDC4+H/ptS25vjyxTb9TiqjmWMvAIKtnOjs0QKVnxXpwvnQqm5odnZelk9HronzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549348; c=relaxed/simple;
	bh=Jv6+NCZ+nS1cBr+AvMbuIEZ/SzyIe/dExl75fldglWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlqoqcgJS/La8HTt8PjwdxfbYLDMjkA9RsA2j8YxXL0XTy9Gz3vHFv94MIc8amWOV+C2clYvzv4Y7gOa8iFSOJupB6fxleMaDpvuaX60lEesVONn4XUz0ZhURnJ11mbaOVk2g6WfoNza9DAbvgG6plFrSRGNXKsUKyFUxAd84rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ei4gRLdn; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so5054931a12.3
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 10:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760549341; x=1761154141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PFr/R+iQvZCbHsrqL2J/+vRylbNodNHeHelx7cyYBEU=;
        b=ei4gRLdnnEtNpgOTPVH02g8w2+PHCIKI8NNPDksrtfqpbknawRiL1jOVYq4gvebTh9
         9nSAIoGgjdUAHgrDHKOTyTGyB7dVci1Rs6+VqIusk8cNy0A6J8UlXAqScaIvThKNVXcn
         Ti2lBzzqCRb4W5JzBvI8N2Cq7QpyqCsxISKHiQdGpB8Vou8egsCmW5W9jVXOrmUXRPcH
         ilBJcs7vrdM3WOyec/ujWJnqYME23pVuuZGwsT7hW02huEoVMFJpBbnoYTIH807Ov2rO
         x+keZlMzCZr1ppslvi4XRW5F124ar+n32UqXTqoNFL1ILeHRiLJJDHIhgQIVlxw3rwxX
         F5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760549341; x=1761154141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFr/R+iQvZCbHsrqL2J/+vRylbNodNHeHelx7cyYBEU=;
        b=dumSFopqg7D387nhEjWpLBGfkEa2ihP4rHRyiBoN88ajaIZqs64EdhdvvJWalYXlgL
         yB9JRGE/+ec19C9MSUarzfmHWSHF1Na3VKMwHXZ1iIYPyd0LVCLYSYObUV97Dxxddmzl
         P2E89M9EnR6tXa8DSZGOdMoLaLLe5/FofGjXeV2twuYPoCf1Dx5w/9te+ii2qn0NiaVB
         QikoTudlImcSY0Zv+pD6OuDE46Hz8Ui8nPf58c5rm5kTpLjrzhdnCAkR1jhxKvaIyP7F
         bKkf9ihUnBBew4k/ENXM/4Cnqa1GmA8UgLF/k6gPRbfmQAEQI6TfhrlIKJ8IZI8ZSlfO
         HG6Q==
X-Gm-Message-State: AOJu0YyXiRnV/x9OKzHPHzvnjNokA9Zx+Kaq1nD/0vTu1obXbMi0M3FR
	HgiKRmtWI7oALCabX5COc4z9spwTFd5TK1+9r0FpgQTiLn7YB6U6DC+l
X-Gm-Gg: ASbGncuyVIBBNnZ/XsTJTKAAkaj63tkf8gErO7tz1HjwOslaRAssouQnIN4/aK5TJQr
	OGOLadss9WUHlM9B+d7s23ONxXNecSJuSl91uymXfrPXrf8YR3EsZ2uv9uudmiLBqiSu91y4iGJ
	FSB9KI0xL2RBkYaixh+CwyjAoAFLFraYICC6GBiON21M9CXYN8zqPrAAzX/5XqvH012yERijgZt
	udxewJtAFlj7ZNcFpapIIJh0PipHjnu84b6NSzabg6dCSJnCoDnXN4b65iISKfnoSw+1M4eHjyj
	rwTd9Macb6R7KhT5HpPd11eGxLPA8m0hVgS7JOPnaSf+Rl4Kck05Iq1XSgGU17jTjBSSCyNbeRJ
	OR8l2zHFCGOj+IJV1ba4S5Q9AKd2JsIqp2zRPEREFm47Gm6uFVMuIWhUC7AmCZQ==
X-Google-Smtp-Source: AGHT+IEwHWpR5pS6MWV5DiElNaioQN4xdIoxQq17Fdi+Z71Xrr4Uskq48/WBodX4p3eOXRu99O6mfQ==
X-Received: by 2002:a17:907:7e88:b0:b3f:9e3d:daa4 with SMTP id a640c23a62f3a-b50ac9f3424mr2888682466b.65.1760549340787;
        Wed, 15 Oct 2025 10:29:00 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cccdaa082sm267715766b.50.2025.10.15.10.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 10:29:00 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:35:34 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v5 bpf-next 13/15] libbpf: support llvm-generated
 indirect jumps
Message-ID: <aO/bZkQ+cL3Cxn30@mail.gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
 <20250930125111.1269861-14-a.s.protopopov@gmail.com>
 <4a536cda-0ba5-437f-82ae-60468a75a62c@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a536cda-0ba5-437f-82ae-60468a75a62c@linux.dev>

On 25/10/15 08:32AM, Yonghong Song wrote:
> 
> 
> On 9/30/25 5:51 AM, Anton Protopopov wrote:
> > For v5 instruction set LLVM is allowed to generate indirect jumps for
> 
> FYI. The llvm jump table support is still cpu v4.

Yes, thanks! I've fixed the message.

> > switch statements and for 'goto *rX' assembly. Every such a jump will
> > be accompanied by necessary metadata, e.g. (`llvm-objdump -Sr ...`):
> > 
> >         0:       r2 = 0x0 ll
> >                  0000000000000030:  R_BPF_64_64  BPF.JT.0.0
> > 
> > Here BPF.JT.1.0 is a symbol residing in the .jumptables section:
> > 
> >      Symbol table:
> >         4: 0000000000000000   240 OBJECT  GLOBAL DEFAULT     4 BPF.JT.0.0
> > 
> > The -bpf-min-jump-table-entries llvm option may be used to control the
> > minimal size of a switch which will be converted to an indirect jumps.
> > 
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> [...]
> 

