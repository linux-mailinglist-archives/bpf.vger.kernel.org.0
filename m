Return-Path: <bpf+bounces-57840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315A2AB0A7F
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 08:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804C91C060B8
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 06:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4040626A1BD;
	Fri,  9 May 2025 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4MeGVpL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADFA1D7E41
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746771676; cv=none; b=TGrlw3YI7H3XN1RL9E9xMgnkfuf18KmC/kyvZKQFc30t3EPbyD9uhin6rB0DIk0GxKoIvzQaIshpUSHt/0W1Euz9IzwX91s9ac2Vq6yT0Xy1/S+06o0yCjJFqtKRCKlXvFMoe4Ch0V9lfMzLeZx4vd03xmoGT0xEwj6GS43B6LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746771676; c=relaxed/simple;
	bh=w07MVl9sRxjJPJNBA1v+cwu+bzQxOliXifptXWVhwD0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ozEF0vzpou21eM6+1sxJyVfQ99kRgmwJ6kpYID4W0ANE97laq9GEmCLzJ9eFrP7jVMw/Y9lPp3X6H4iIBzU1VsNwhgXU/NqatfNirlSmpGw9Nm6LUrwO09u3HmCnl/FeqV3WZ7CbdR3P3LxFRqgMecpzXbL3TOLpKLIUZnTe+Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4MeGVpL; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af52a624283so1673990a12.0
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 23:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746771674; x=1747376474; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w07MVl9sRxjJPJNBA1v+cwu+bzQxOliXifptXWVhwD0=;
        b=P4MeGVpLDthLWBlGzuZlksRb3Ei11MjLiabLu9JkNWnWBxt8tiddT/eECM9JLPx8Wg
         /tlhNyR9aG1UzcBmFsZhI9w4q9m1uHpMw+gbB+SbYrXzVUepAr9/j6oPNHTBtRdj9HvO
         DSHFEvEh/kyANDNdb/+AiVFWEeAsgEfkWCZfL5nxSqO+H+17UhlASnmHHFdWXtfL3cAl
         N/LmwCSVBlCo4wJIqx4ivnjsa5OGkUVJEFTgKmsD7qGOjRcHyfpNWr2RntHfvVgvN/Sa
         7LVKuRQuzFmJlVtYiI++JiVCFBR1CUVFWIbQeRMdtbrpN/Yt88KJ69rQ2ms2nWVuhl4D
         ud3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746771674; x=1747376474;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w07MVl9sRxjJPJNBA1v+cwu+bzQxOliXifptXWVhwD0=;
        b=IoNLV+W31tUoQJ+iYdhwX/oD0zu8lHC7XI1MWWS3xdu6dDzKccPDVzr02BKOhFCd11
         ElWvGNBpGdsTjX9HPZjIkVzbZc//ch8gmrVJOEno/5WIYItjYjThtDrFSremC3W1u1jb
         ugR8R5BSjRg0gd1aFrFphvdtc/4IlUAvVSNUdhaE98TcpYgtgjaXazDAAUFtKBessJg8
         UYdz/2P9OOwCmCSpP8WraXSysEeZ4crQBpn9mDYXGUonpdUhXZ2uU3t0IgYE4ISTU+3W
         02FJWGRbICGv9cUn+EzjYdftiatEjyhjMBj6EzkGJ1uGk/D9NxegWlHxD7xTQbPJz/VA
         uC3w==
X-Forwarded-Encrypted: i=1; AJvYcCX9Pyt386dw8U8IXci1xKlV15w4lmUjHzwMcIWy/294Mlr9jurnUfpCxi4fKYu5cp8y2Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFeIz11ngd3l05AwNeLsImLe0Qq2Ky8nJr/KFYv9l6gJxPukQ4
	dATV2nKiQcc9n9N+9gdu2FaEjFok+DGQ885wbW08TCkO77+2XN8O
X-Gm-Gg: ASbGncs/EzEPgSNB4EaZjN2SZ3/w2ZwLXD7wLlxht+e+b0tTBXu6Oac0tV3wjDuxVdo
	l++eEIYLtRfiYcmw5aGY5jf3AdqKkTObgRzECzutQSsJ+w4Q/JGA3FSNb8Ra4Za517OB4B97VUE
	LJTQW9+pOdS712GHkBrI156OFIxoi1KkkuHo/TEZaoXQBqG1VoZfTSYWFmiYX2F936KTaKANWL2
	XJGSfy3NVX1uIBo838RCcmuDe7JkqFYvtFQ0bxiwVqbEQl/6UGWqbATnxXnJacQekE+4cs+jhl6
	U4uxmhTNSje9unaw4kskildM6U/VZAK/vf20
X-Google-Smtp-Source: AGHT+IHtSihc0yGAQvEbEy50ZZ/6j12YOjCngbhmOzkvLix9PBBE3AkV3SYQM9X1WtxAIhfdAVS6YQ==
X-Received: by 2002:a17:902:e806:b0:215:58be:334e with SMTP id d9443c01a7336-22fc9340996mr27641245ad.10.1746771674465;
        Thu, 08 May 2025 23:21:14 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828b183sm9839345ad.162.2025.05.08.23.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 23:21:14 -0700 (PDT)
Message-ID: <04332abfa1e08376c10c2830373638d545fba180.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 10/11] bpftool: Add support for dumping
 streams
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, Barret Rhoden	 <brho@google.com>, Matt
 Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 	kernel-team@meta.com
Date: Thu, 08 May 2025 23:21:12 -0700
In-Reply-To: <20250507171720.1958296-11-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
	 <20250507171720.1958296-11-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-07 at 10:17 -0700, Kumar Kartikeya Dwivedi wrote:
> Add bpftool support for dumping streams of a given BPF program.
> The syntax is `bpftool prog tracelog { stdout | stderr } PROG`.
> The stdout is dumped to stdout, stderr is dumped to stderr.
>=20
> Cc: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Do we want some utility functions for access to streams in libbpf?
I'd say that this would be useful, otherwise many applications
would need to reinvent their own bpftool_dump_prog_stream().

[...]


