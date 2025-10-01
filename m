Return-Path: <bpf+bounces-70132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6E5BB1892
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 20:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539563A6CF0
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 18:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF842D7DEE;
	Wed,  1 Oct 2025 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8bnNe0I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376C52D593A
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759344618; cv=none; b=qG+Eva2TtU3hb+Po9vGmhURIgFhRK8ZnItj9sHvboBZ+PdFt0FA15Ie25IIDAyQ0vKchoH98IhfyjTMfqYZiXfgxP5n06gSNDW9xNYnv9Ypz3X4EkHBU+Ps2dZzGV39/JoUFljcVnGBkoJxP5WYstzLOy5JHS2tOJK/wtbW2LOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759344618; c=relaxed/simple;
	bh=nqveELABgCGfmVUMfgG0qIFecaNkdML5yRpMYi+IeKY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LWRXmm8AGk0MbqJ97LI0SBRvMxpJtDTRSMhft5typhNUT+B0x2aOe4KogdbT1CMalHlj5gasicnLHuI4Bn+mGQjX9qv9VTIHQObc7ejiNyJf3EodzRlHvoevEv06jIC27zQCSP9VWbD/PJoObq7WqD+k0BjBd6y7lh8PQVr9z/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8bnNe0I; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so312701b3a.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 11:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759344616; x=1759949416; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nqveELABgCGfmVUMfgG0qIFecaNkdML5yRpMYi+IeKY=;
        b=Q8bnNe0IiyBXBsp59xHqSiBFzGxJ1Ch5Jr2N9q+Z2I2+Y8nXXZrZ0oSOR9jDoOJ475
         I0JQpd425wGE3xOAig4LuA0nXieSka9FzU27oWim3oCHV3rVPvhqUKMLL9rUE3Y8xuS3
         umhZRmEMsj+URr8dPEWqcXlog9kY4KYM3LUvA0APNfjqoDjTq222Ib6Jr/W5uK88y7x/
         z6qGlePvl0yXMJ0YVxdX4gPOCcrvluPEa/Mm5LLA5nrVDvkReFJ541TdSZ8PIJqqAlla
         bBtr6AvoPX8k0eZKIR9FQwvNyDmBOW+0sIPRLKdJF24nnD5hXnbxfBjA3aA8A9FRsop/
         DgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759344616; x=1759949416;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nqveELABgCGfmVUMfgG0qIFecaNkdML5yRpMYi+IeKY=;
        b=AprFdXjCY1A6SjUbmbwQE7OIhjdnCIxY9KiVwI1jXiutZuPwBW3VIGtK9060rcQ1Hi
         w+BDEo4Bloab9rZH52u4PmOLm97KFWxGNFqzu8n17Jwi5i+DM710n7stGZXCJ9Tk07RA
         fbaGMYC/XTcniHumk8KQo5WoU32oCpboqmmwKhUqz5Ai+7Mpx/QIeCnaI7J/m/ZftyYp
         2SkBmivCZRZ/AABPW1eQaG7v0Et+qq6d2bE8rKtaEj2xLbC7Nr95hGeHrIM/XONW/4Ns
         /gEFsD6NCPxnCO9bgniYz7oEBeyj0r2YfxzHdPupy1EhQaIf6ELqxDd5FJyPbuw1Kl0X
         W2YA==
X-Forwarded-Encrypted: i=1; AJvYcCUR84IUfGDqIwEgMzDJ/EDJ8Eh5cdKKqV2ta+grH2feJyUxjX4SUB0ib9gzMrJ9BJ62BLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdOVQsJnmYhbiksk0/Ya2NYeIlpy8dmsL40+F7ZXSWM2n1PU8E
	LzexkU0PCvvLJxpNqIN3UReLywL8WZTv3n43kZCiX4xn51m8CDm3c/CC
X-Gm-Gg: ASbGnctas6vD4zcNLR7vI9NW3PeBhOTzxuzj0XKahIO3Vw5oX3TYPTpKLM8P5uf25ow
	4Z4iDax2CWG/L3mKJ/eWg6WQl46Yt6P4JXGSvvAUmV43V/Ig0Z4tJwcK9BcP963jzqQ6FZUXO9t
	uXzOHcdoQ++h09xJi9P4BRgtXqZlfDT+aSEBtEMvJkGWx+LlhUTKYBfkhb9PuxX4m8tNlFWVscf
	wH+m49BSWq+SLpgTBRhNdA5Fxz36jho/rUydjWuEdRqwvrwSjb+oGIOqmenUAKEg8FtHS8uXzeY
	gaalPxr/+qsDqjWf/595gKMYnq4/0e5eQnFas1nZmxosXTzdskc+QwnoFcTx5+yWlNFcs+mDBax
	781bN10jbihVbNqBPtLU/UahDZIaLEhJEQ3AjhYZFO6WDP+JZK4ivhxy0B9WyXvkkWK7MnYE=
X-Google-Smtp-Source: AGHT+IGs8WixLs9IObZkjZXOCYuQwuv5mMQzbM/9VWrSoPdiW22ANc41egG82+f9kGG7SlxnhlnjFw==
X-Received: by 2002:a05:6a21:6f06:b0:2da:f4be:c8d5 with SMTP id adf61e73a8af0-321da02da83mr6150238637.16.1759344616372;
        Wed, 01 Oct 2025 11:50:16 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099add290sm227587a12.6.2025.10.01.11.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 11:50:16 -0700 (PDT)
Message-ID: <6b2b44ddbec88ae4690b4eae33b712642b73db4c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: verifier: refactor bpf_wq handling
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 01 Oct 2025 11:50:14 -0700
In-Reply-To: <20251001132252.385398-1-mykyta.yatsenko5@gmail.com>
References: <20251001132252.385398-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-01 at 14:22 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Move bpf_wq map-field validation into the common helper by adding a
> BPF_WORKQUEUE case that maps to record->wq_off, and switch
> process_wq_func() to use it instead of doing its own offset math.
>=20
> This de-duplicates logic with other internal structs (task_work, timer),
> keeps error reporting consistent, and makes future changes to the layout
> handling centralized.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Note to reviewers: technically, this makes the check stricter,
but no new correct BPF programs would be rejected.
The cases that are checked by check_map_field_pointer,
but which were not checked before this patch:
- reg value is a constant
- corresponding map has BTF
- map record has BPF_WORKQUEUE field

Not sure if ignoring one of these checks could lead to invalid memory
access at runtime. I'd add fixes tag (and maybe a test), so that this
commit could be grabbed for backporing:

Fixes: d940c9b94d7e ("bpf: add support for KF_ARG_PTR_TO_WORKQUEUE")

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

