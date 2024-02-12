Return-Path: <bpf+bounces-21784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 888608520C5
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 22:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228A31F23599
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82654E1CE;
	Mon, 12 Feb 2024 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WOJ6vr4Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C888C4E1B3
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774740; cv=none; b=c7wUnFSRv80OQq9o5nCfP72vW/8gUh4yD7TAMavrt3izaovJhO2DQD+oNv8mUb2SCGgToFnaPNiCjArAsRsTRaxkF0X8EnuvhK59Xhf6OOdBRH6M4tLK132Rtkl46kKyLY5bajrwnmY3AC/CVapxbfjZEVNeskoHNcHl3Zl3fgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774740; c=relaxed/simple;
	bh=TCXLNZjm9a/AI7NvMnTJGAcntZJIKDfWZBobdC5h7gk=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=t5n8s57b3WVxRr1lvVU+AxGYgS5sHlZ44jUlP/vVzp3iTgfSTSdhWGF8dFXa1WuT65vVHrNicREeRQQ9wpMDpeihTKtQ/fkkK6SleQdmxmYIe0Ep5hp/cN4GzVBh1SIpb3JVP24fFVm2tHdP+WcXt9IFCG8S7VjJk57i4Q7hVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WOJ6vr4Q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7393de183so1753165ad.3
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 13:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707774738; x=1708379538; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xSzzku9O08NX5s9mUmuY4UFBjA/m/rotu9BsWmCKqXI=;
        b=WOJ6vr4QsBMuCNNVX2+wUNjIoMvKolxd7unNl+XiTzFiniXt2TcNXY2OAfQOoWOLaW
         sVXvoWcQ/vVSAziFP/dTUMXRPdDpnd9u04j6jsUiz5B9PJvvPSsg5Le4A97fwRFREhLz
         gBO45iSHeRWaQADqTyHGAZFO9dk1GxQQdROcR3xlYI8rrR4FZfrJRA0kan7rY1iKn2/w
         zVsdMEvcoT6NCpETzQ2sVJXKseFXXSi9Q54vLRBntLFQc6+CeJ1bbkq4SH84iGsIj+h9
         YAZW5uGja94nSyWfUTaQ8HsOMje74YLH4ZCCEvVa2GUQM8ft7ZW3g1KbWSJhbsen8ZY8
         IuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774738; x=1708379538;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSzzku9O08NX5s9mUmuY4UFBjA/m/rotu9BsWmCKqXI=;
        b=wy0NMoVFbZZWeJmX+2xaihsr96lex1NAHbNbx16XjCPfcK2k8GcjBsB8lYAznYC5uE
         DTeGumMzSbsNYT3mPlxR0GjbSxHjxjhkankVcXUb68aTyq7PAgQ+oFpZ166Jm/iujx3V
         AXaLdvb9H4OtJauapWiWzK89bKgDBNT9cRT4jtLLzmOcqudfzfLhz6J/tAh1tjww6aez
         XBSzUjCE5T5EGtAixV8fQTIlqBxdHEYruatBHAuevbdU7zT2/UG6enQ5quFcS0G952o2
         P7uBGtYX1mLf84yi9ywKyzJjlmAVvhWJb4ujoz5+jUyyiOX1KZMMRKchcDEG6aNr5Y0w
         h2qA==
X-Gm-Message-State: AOJu0YwjdH5O3hCW/cCiI6DAddqWYpS/JdGgr/fm+9KpJx7NzA63CODt
	GMquVP/SpuIVE+HRsZyzdutejph33+yEI15O5zUHRoaZ7iRIVvcz
X-Google-Smtp-Source: AGHT+IEd0mvSUzflQGwa1mNVWqzC62QasqHrF/Op9PhvU8QenBNqVes42V3UiTwNEkVizPI87aoE3g==
X-Received: by 2002:a17:90b:890:b0:297:244:94d4 with SMTP id bj16-20020a17090b089000b00297024494d4mr4260706pjb.43.1707774737999;
        Mon, 12 Feb 2024 13:52:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmCt7KTgkpPUbNfyWwNHq7d8cV9jFDz7V4OpBlUBej4IZGLDCwRXDRH2TiZR+c/oRKOBrTiUNfIhfyKtXxjtoz50LKSvp4bKfA4YDUvmnlzu2BDq9dO8AYqMMkQwnBUStJna1Gg2XBzpaoR1CsY3ywvtaQtZvElzSqAJUvMpIC0ph1yQ==
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id so10-20020a17090b1f8a00b00298a259fc26sm74989pjb.51.2024.02.12.13.52.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2024 13:52:17 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>,
	"'Jose E. Marchesi'" <jose.marchesi@oracle.com>,
	"'Dave Thaler'" <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: <bpf@vger.kernel.org>,
	<bpf@ietf.org>
References: <20240212211310.8282-1-dthaler1968@gmail.com> <87le7ptlsq.fsf@oracle.com> <b5072dfb-ab2b-40eb-891e-630a02c58fe8@linux.dev>
In-Reply-To: <b5072dfb-ab2b-40eb-891e-630a02c58fe8@linux.dev>
Subject: RE: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx instructions in new conformance group
Date: Mon, 12 Feb 2024 13:52:15 -0800
Message-ID: <036301da5dfd$be7d1b30$3b775190$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKk5nBwvPPKgL8m8zzpY/2G4YK4bQLYE4TWAif8DTavSi2JsA==
Content-Language: en-us

> -----Original Message-----
> From: Yonghong Song <yonghong.song@linux.dev>
> Sent: Monday, February 12, 2024 1:49 PM
> To: Jose E. Marchesi <jose.marchesi@oracle.com>; Dave Thaler
> <dthaler1968=3D40googlemail.com@dmarc.ietf.org>
> Cc: bpf@vger.kernel.org; bpf@ietf.org; Dave Thaler
> <dthaler1968@gmail.com>
> Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx =
instructions in new
> conformance group
>=20
>=20
> On 2/12/24 1:28 PM, Jose E. Marchesi wrote:
> >> +BPF_CALL  0x8    0x1  call PC +=3D reg_val(imm)          BPF_JMP | =
BPF_X
> only, see `Program-local functions`_
> > If the instruction requires a register operand, why not using one of
> > the register fields?  Is there any reason for not doing that?
>=20
> Talked to Alexei and we think using dst_reg for the register for callx =
insn is
> better. I will craft a llvm patch for this today. Thanks!

Why dst_reg instead of src_reg?
BPF_X is supposed to mean use src_reg.

But this thread is about reserving/documenting the existing practice,
since anyone trying to use it would run into interop issues because
of existing clang.   Should we document both and list one as deprecated?

Dave


