Return-Path: <bpf+bounces-45396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 966DB9D522C
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 18:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4046F1F22795
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 17:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADAA19DF62;
	Thu, 21 Nov 2024 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhVgRyBz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3076CDAF
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732211682; cv=none; b=DfsW9aBSiW+vb7uTVcVRIFOEVyN0NgJK/GqlllWjeIrKpnq/XeOcxlCI7Oo8Mu0oSwfIGR0RIM9OQfcYbxqfO4ov+jOgApTErAyjMv44s82qdRaTL0UDdf6t1WA1BqzfHdwMNQEFOHx9aqPhyC6jeMnVtrTxqbolPu9+b6WF+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732211682; c=relaxed/simple;
	bh=tVLpzwfmgW6OHnlV5ONU0L69G/0ruKLDmhSRAHSo228=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ra1B0i0SZQkfWdWEPgn66oSfnjEMsZqloCDg9xlJICDfRrDCsaWRqTVoYHZv8U8uMoadm8tbwlDdo271ytQ4OIQWV51Ph9DYbCuR6CYRzV4o04X33eyrYfx1G/RjPuMN5JUYarDhnuXKRJrFvfhllsUy9GhMiPltoE8vsN4BlUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhVgRyBz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-212008b0d6eso10582935ad.3
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 09:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732211681; x=1732816481; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tVLpzwfmgW6OHnlV5ONU0L69G/0ruKLDmhSRAHSo228=;
        b=hhVgRyBz9jhAwZlL7e6snJAgxRW1x3fkO+eQbgW3nzIu56IFcla4fODO86PT3ZuzKU
         jCCor8LsB3iOYZzopLlFWSxwtIZsHuFB7u3yLHKt4+ta69FEBhiwYzE9Ln4MOT3LA1nE
         ffHpRCg/mNt5YRMhucrT/tGgyK+nog7NooR/7rhDYdrr0fsVBN2KZV2/UPM0gA1nb7QX
         wQSXGRNEHEsXFA+r0FOBbyOMyQdioUghxs5gKbDURKU9cpWwj49vX9/bKD8pcmUA0fIe
         GFljyrwC39EmdbpZFxFNVXho/1Jg6wtVhT0irinPrtDWYuNRnLztQBDDsAahqN14uJyk
         gDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732211681; x=1732816481;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVLpzwfmgW6OHnlV5ONU0L69G/0ruKLDmhSRAHSo228=;
        b=vfBtROjc5DcsHfxj8wgrzxAaP7+ngku3ClWo/U25+BkWPXHVy8bgFXMN4Fk+iU7KP9
         2mOZdES13m4NbVTKngqjrv8Y7gLgkxqSlzm6zNrqgh0BqrJNMc5n1UNNpDBhlGiqwkC1
         SEygzCZvqqfgMDs1DcmKiVqfUdDNiMWTTtAhloRX9tmWeEiuPeEKzRQk+B1X6z8058Jj
         teAKMwL+r4FOYm2T79rL+edyVGSWimGxS7UyUGtOcbGjm2NZzXRiKz01z7uATwImF3g/
         ycBq0E9JxcgezFIlzw1QR3wiGkhLkHrOV9wK6v7DFz3mGCKpzD4Nw2uJLPHcTJ0s1IZ3
         1NOA==
X-Forwarded-Encrypted: i=1; AJvYcCWTzCHhDuevHwPR3gJTHKIWDk7rNp9tM9MyN67IbYu61Fnw0Xwkaa8n+ZB6DAcPDjZiurg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyncpcG0jkhxSaGAI4Kw8o06V8psZhjdI3LsSI+PtpfMJdleHG
	5a4Vsrc1aYg86SsEGSOnKC6uzTh/X8u0kbT0pEwN/+nwncbqgSql
X-Gm-Gg: ASbGnctr+p8tsBKlT08Mqc4bwyh052osqsZX6pfhOird3VxrwfFFPtx06Jd0Srer0Uz
	F9v2cFuVK0qNZbvdpJo+Rfd96WfayyKTI47C/Oty639ZhWL55+k5mHexvY+jt/qACu8LSOMqaCx
	76u29GEGOyRROrOPlaShzGNShZ63FiT3uBgXOjEtQiuQ4JDD7+EcswYngUkMlYqmwaah0yIleQO
	TSyVhLSpivVHKbWOejc8+BA4jjHMHqz4PsRKDjiXP83IAk=
X-Google-Smtp-Source: AGHT+IGSfSujXvYWeOpbrmeu3o2GLZskBFjdBE57cn9Nh9pCNVNhm6/HKYbxUhHwa1ZItJHoMeP2SQ==
X-Received: by 2002:a17:902:e842:b0:212:20c2:387f with SMTP id d9443c01a7336-2126c97868dmr98435715ad.49.1732211680777;
        Thu, 21 Nov 2024 09:54:40 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8c804sm1121805ad.52.2024.11.21.09.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 09:54:40 -0800 (PST)
Message-ID: <a7514df04ca56eaba233d53069a834441e242d67.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/7] bpf: Be consistent between
 {acquire,find,release}_lock_state
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kernel-team@fb.com
Date: Thu, 21 Nov 2024 09:54:35 -0800
In-Reply-To: <20241121005329.408873-3-memxor@gmail.com>
References: <20241121005329.408873-1-memxor@gmail.com>
	 <20241121005329.408873-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-20 at 16:53 -0800, Kumar Kartikeya Dwivedi wrote:
> Both acquire_lock_state and release_lock_state take the bpf_func_state
> as a parameter, while find_lock_state does not. Future patches will end
> up requiring operating on non-cur_func(env) bpf_func_state (for
> resilient locks), hence just make the prototype consistent and take
> bpf_func_state directly.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


