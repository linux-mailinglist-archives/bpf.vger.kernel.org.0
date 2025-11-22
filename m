Return-Path: <bpf+bounces-75286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FD3C7C1C8
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 02:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAE524EA73E
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 01:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3602BF3DB;
	Sat, 22 Nov 2025 01:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcfJBqWD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A40218AAD
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 01:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763775883; cv=none; b=F/aauhbSYLcUK/5kZnMkFs69AjUJNZ60EYLLDPi0BhUggC0pNb+Fd5DtZ3Va+z0XUq+S/bMIhmBxfoNFD3t6tU8iLyKkWUJ0/JvejuH9iyVbtqVGDUbWuvpGPyfm1FWqClUix8TFqCKiP/xOQEqlibKPD1xKpVlB1ba2swOZFGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763775883; c=relaxed/simple;
	bh=BofqOJ6I2sq2jq3S21oCuHzKaAJ1Kg+W39B7PbvAFvY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tvIaa5YdOImHKXrTn7K2No0wPWwHhAqzUhUsG73uAVHEYsksvp/rumF3CXLsRmgG+xiu/h0cdcm13hJQiWvSza+YE2S/1gDpRa038IGC4ARyd5wG51SkRt3SnJo8ryaMvZIV+tNcqtiJj5BUccjtuAY1Q5PMsDwSuLnYDOKbSQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcfJBqWD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29586626fbeso31601395ad.0
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 17:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763775881; x=1764380681; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BofqOJ6I2sq2jq3S21oCuHzKaAJ1Kg+W39B7PbvAFvY=;
        b=AcfJBqWDzhYyOBth3l38ougskatXS8NIMv+jK2xDghPlmYckCv8MIrmkgoddtcofQ1
         I5+CfcHsZ4efy/OUYmu7UYrIeAPrOcK5JSrRj7JRBDOikFj4JfOrFRFcsS0jM15E2csP
         oqw0+tWLWZYhRicgBkdy9e0HwCTnVn+wzMlgjpogIPbxm+Si30B0mSYGD+17k6ZrcPq0
         3SXTxFA6KpekME+Z2QpEqUNbj99fhjv5oTofT8+mlI4aU1s/JFCuuwBlc/4OMfrn7II5
         jlBumT2AAP7OLVp12l0xuCxvlzdBZpsJyc1uOhdK+QCOD2ZrReOKV+yf4iLDt/98Ykox
         cnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763775881; x=1764380681;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BofqOJ6I2sq2jq3S21oCuHzKaAJ1Kg+W39B7PbvAFvY=;
        b=GeT//wu4W6Q7iAGBS1/0svx8wqmJhpQG0J+cad8+E4M2sac13KfuQ6EaZjRGt2iZcl
         q2lgnAy4S42Ydre2yb6KGgiSPfbY6QVO90fYnKzrjoiwLJQZf/ORKMGPi7/bM8Ou4AED
         ZgnS8sPfwBySruC2jGgdj2s52gOT8vBwkuw982LbKBISUVCZrMAbAv+M/IR9FK88z5Tb
         bMt2G3daBKLBrZUD2LJahZXV7OVYpRgcoLrkVpGGsJewH4EBhiL+K+8cIg6zS+hC4+x/
         LOSXBBGNQEZgGh66zQcUcv6imjR/aiIgHFFh5MdlI1fWjSI8OE4x91wJEqWPAwvRN3qr
         dHMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU26jAB1nn4DZTKwD7fUKIj1k1EcIy3S98HagAMChLEIUCHizeDbBjb9BoUQ++S89YoJS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmcw1JzM/H1Lo1cQrsglzcXqhHWf5E1hWhduohcmzflBFq3bKB
	ijYg063AIASQ5/dPwqsbJhe6GU2006RtNVxQNq82inqwWed94ECTzKUL
X-Gm-Gg: ASbGncsjnkdZYYNh4sj8jnD5cYwEBVXlS70Mb+vKShuwqh1wpvvqsfcHfPtOWNCofTh
	BD81y5AiHifDyf+Z88s7M61vv7pkhCUuEVTlGG/8IE+Tb0jc6K4W/8hS6FxN4hhvLrW89O30sC6
	vB80CCoWfFU+D8mCWgmNWEy59bO1FtEHLRf7GaneUtLUBVdMnfbMOyfkRjIOR/h8s665BEh2dRG
	FN3ueqoLZauxr6S3qr81X2BY9roqcBpopO3lYMP/gZ9IDi7gA+gNQ+hZYz+8FVOttyyS/0zWdjY
	yA3bo5PhGIpCPBUWCG8zGQUe8jzrI9O5EwmpXVRCQSmCKMpp7NYX4UkSHdy4Dc0f+Mf4wfQba8T
	K0sbNGsiwSlxKEyXyqMWbWecl+PH1DXsnOyqTLo4D2mfZPPZF0rOTK8GYlMc1z3VF2A6BOizuZP
	tVkFIQees=
X-Google-Smtp-Source: AGHT+IHthu6KxnYyHRS+kvhdVGD7BcvtvibX50NYviUpstWCskyGOODE+reiixR87ITPozG16hUJ9Q==
X-Received: by 2002:a17:902:ce0f:b0:298:4718:909f with SMTP id d9443c01a7336-29b6bf7db7amr43437395ad.51.1763775880902;
        Fri, 21 Nov 2025 17:44:40 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b107effsm70014055ad.14.2025.11.21.17.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 17:44:40 -0800 (PST)
Message-ID: <1f18cdddbbf1d1273ff045d769c54fbc4dfe4a6a.camel@gmail.com>
Subject: Re: [PATCH v2 1/4] selftests/bpf: explicitly account for globals in
 verifier_arena_large
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	memxor@gmail.com, andrii@kernel.org, yonghong.song@linux.dev
Date: Fri, 21 Nov 2025 17:44:37 -0800
In-Reply-To: <20251118030058.162967-2-emil@etsalapatis.com>
References: <20251118030058.162967-1-emil@etsalapatis.com>
	 <20251118030058.162967-2-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-17 at 22:00 -0500, Emil Tsalapatis wrote:
> The big_alloc1 test in verifier_arena_large assumes that the arena base
> and the first page allocated by bpf_arena_alloc_pages are identical.
> This is not the case, because the first page in the arena is populated
> by global arena data. The test still passes because the code makes the
> tacit assumption that the first page is on offset PAGE_SIZE instead of
> 0.
>=20
> Make this distinction explicit in the code, and adjust the page offsets
> requested during the test to count from the beginning of the arena
> instead of using the address of the first allocated page.
>=20
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Seems correct.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

