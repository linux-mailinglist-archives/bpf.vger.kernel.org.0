Return-Path: <bpf+bounces-45866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87AA9DC187
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 10:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43894B20C29
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 09:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA143176FB4;
	Fri, 29 Nov 2024 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoKwyjfG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E0714F135
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732872593; cv=none; b=cjMCdFHEciqm2vYW2v8t4aWVx+wDeZlPEVT1f3JIrNpLOo/qFMJIGbipXFwywB+kS/5HMIq4Lo7X5pWCCoLhdoE/R/GPi/6TxpDJV4ZFq6pYE9eKYHiqscSH6Aqhcb0w5XCBPbiPrEbFQ/c7yWvaFPoZmdMjXxxmrxzlXDwZFsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732872593; c=relaxed/simple;
	bh=LPfcs7pBWanXJ1yN2+JeDSnyCulkOfNyq5bwKGomm4M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g9LkFvqhAsGDW36D1RuLSm5tIf1wKN9mHmhRweacMONhg9QdAgeRqNfBDtGrOOeF9vWl9NllV8c8GSlR4oznE9UDc5aZWG4DnIW35J0WCfb4o+IhubgJeCrvOjScFwKHkE+GWGbHXfypTkgge6GXCmH80icDeSXWaFC0lMqN2qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoKwyjfG; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3ea411ef5a9so736651b6e.0
        for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 01:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732872591; x=1733477391; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LPfcs7pBWanXJ1yN2+JeDSnyCulkOfNyq5bwKGomm4M=;
        b=SoKwyjfGfthSVrSitjIIeEBiv7HnssSADC9LsyITp06QDjy/JJ49DrPS9UR4n/bcZD
         a9wThOanQo+oejqngLVpSr5fxQzw4n40l1NDO2MuZaDlv3CTwpFcPI1t0hcFH/admcts
         yJ6UtwfJttl66qa4iOntcgWxACRus1ivt+GM5esVH+OqitU8thO5b6xcdAz9n6ga76EB
         fyk46JuYiSKjmx4lSx1aQp0E+YeNVJ782AWuwXryYSc92t2qAnfCLH9ns9xNHzs12VJA
         Kqznzg8VG/+hCFesXBHg87fie0g6V8kWtyp6MHlv+/4Il3E2O1RRd7khNVYZGpLGhZdu
         17Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732872591; x=1733477391;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPfcs7pBWanXJ1yN2+JeDSnyCulkOfNyq5bwKGomm4M=;
        b=Ha7f7DxVdLQQu/UYKD8VcoEXtQZ76L2a6K23tPrlllUK6opsJFNOklPbYz5eRcLFlz
         a6yuMRvuDVjvFO3hDnT7Mzi8JoMmj4SPDYVOtlnuFrS/lww0v6NyycQX35v5A4QGxU7u
         U27xb0TGdcbHoJaSkL+KOMzcvFFe5ncuYGZJwQLrYg8DGAG727GLO3j3EF0zzwistzQq
         0YkJrwfBkgsS6VU5q0tAqnfA4OmfiCn4hiH+CkBc6Xm7Njc2uexanbB1cTDLfU2/fbiZ
         RQfgA8BTQ6p1ek6wG4t0uddfJT14glEA3rGqiHbIpqWsovxz8L7ektzXau1Zgr2ZYg/g
         kIqw==
X-Forwarded-Encrypted: i=1; AJvYcCXttNyCbQ6rBdxYB01SmW+Zj/vuwdukSpnf/FNAGvB+YmACMpf6L6yvn5UtCOz6HATSaXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHKPAyCXpJaZfnAx3Df82DZ3QAHamzh5ruHv7AyHA0NgMadub9
	37VwpkorhRjgze60mXBhJRImIhw9THgbnZ1UrbWY2j4vCfwYrSlU
X-Gm-Gg: ASbGnctOH7Ohy83Mdz9Eei85CJkon7zyxbGRnG677D/rLnU+2Qhs3IOzKjFXa89hcwV
	tHK174LslquKgXN5TrdNsls/sAb1CAxC86K5kIjJ4ctHPkaSiBOYepqDmZe8mJjY/WAX21QWk1W
	l2ciLeu7d98Z7L17LBY8cQNhyEZDLQZSEZtcOUyKFFLP1HCmpNtZpCZwyBIYNMNor+quSQWHTFf
	kC08bGTsOZJxB8utLhMEIxzZeiAENri8UeVzVbM/eHfFVM=
X-Google-Smtp-Source: AGHT+IFt3xKzaonN+PMYPQ4R7rXIA38B8c5FFLkpWrz0PikSRXUQQ5sTnHGtQPa0+chs0se3BG0nKw==
X-Received: by 2002:a05:6808:1496:b0:3ea:6708:51c4 with SMTP id 5614622812f47-3ea6dbc49eamr7374477b6e.15.1732872590932;
        Fri, 29 Nov 2024 01:29:50 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176f3f6sm3010506b3a.50.2024.11.29.01.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 01:29:50 -0800 (PST)
Message-ID: <50d2626e382ed7a6f1f07f0e259fc923dcc167a2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 2/7] bpf: Refactor
 {acquire,release}_reference_state
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko	
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau	 <martin.lau@kernel.org>, kernel-team@fb.com
Date: Fri, 29 Nov 2024 01:29:45 -0800
In-Reply-To: <20241129001632.3828611-3-memxor@gmail.com>
References: <20241129001632.3828611-1-memxor@gmail.com>
	 <20241129001632.3828611-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-28 at 16:16 -0800, Kumar Kartikeya Dwivedi wrote:
> In preparation for introducing support for more reference types which
> have to add and remove reference state, refactor the
> acquire_reference_state and release_reference_state functions to share
> common logic.
>=20
> The acquire_reference_state function simply handles growing the acquired
> refs and returning the pointer to the new uninitialized element, which
> can be filled in by the caller.
>=20
> The release_reference_state function simply erases a reference state
> entry in the acquired_refs array and shrinks it. The callers are
> responsible for finding the suitable element by matching on various
> fields of the reference state and requesting deletion through this
> function. It is not supposed to be called directly.
>=20
> Existing callers of release_reference_state were using it to find and
> remove state for a given ref_obj_id without scrubbing the associated
> registers in the verifier state. Introduce release_reference_nomark to
> provide this functionality and convert callers. We now use this new
> release_reference_nomark function within release_reference as well.
> It needs to operate on a verifier state instead of taking verifier env
> as mark_ptr_or_null_regs requires operating on verifier state of the
> two branches of a NULL condition check, therefore env->cur_state cannot
> be used directly.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


