Return-Path: <bpf+bounces-53154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4678EA4D0B2
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 02:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512113AAAF3
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 01:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3616312F399;
	Tue,  4 Mar 2025 01:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBl1S94a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C14524B0;
	Tue,  4 Mar 2025 01:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051374; cv=none; b=CZ41YDSCeN1v2cZ2WXrsHHST2dEQ5boY/BJzZb67uvs6PveIrzCclkJhrLFw9Y/Wxwd+av9XsG/Gsqes4rRKbo5KwfqQWbrUP7nudbgjVmr6lUQP3RjiARtUsaSYbWQ6QUtUNiqGME5K8kEKcDGTu2g/lC3alVjSKBLNwFN1QpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051374; c=relaxed/simple;
	bh=sj01G89WSKsFpjf/wy7aY/kOlbTksiMMzEm1e033JpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P87NHfm2nSTb6lX11lpVl5pbrUdVRUBM6zb1zRfiVhjwJ2XwXIUWu9yE90ksnIxjo7Mru4aBFbfwg9rN1snM9+OIIGqB8TCJhpcFhLiFWc5ic4XcB+C2fGERTC83sYpVxDD/gdTpv2gnyyDDwuRtROALe9m1T54egTi1XygfNx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBl1S94a; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-6fd6f7f8df9so16510637b3.1;
        Mon, 03 Mar 2025 17:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741051372; x=1741656172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj01G89WSKsFpjf/wy7aY/kOlbTksiMMzEm1e033JpE=;
        b=WBl1S94aUZlMnMpmbZBTghTGHozbnyoDSpF7Y+dt/Urh+TbZ8cV3Sjjs/mZCEMUSHQ
         F2LFEpMsF87oLgzo7IK6tPES4whx+7alaHiFAhnd8HkuYkCKryQvHUOMa+cvnKSRb/uy
         TF7iOlcJYScFMGGbLHz4Nu0IVKz4wtBgIP9etF4Cq3foNY5RP1Bd+Id88Kh3gDx4aHmT
         5UNx9k1CsEwXMHDq8oEOy6tUwflZjUx4chHnukS8xVRPNIGe/TOJG67tyhTaK5V4n+1c
         VXKoGlGtIEmgzhLM20cRQjughXORQelxmAC6Ex8f7MWP0XGNiviSo2+3x226Bnp+09fW
         RQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741051372; x=1741656172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj01G89WSKsFpjf/wy7aY/kOlbTksiMMzEm1e033JpE=;
        b=Td9h7J/a9yJMoJEzhwXOUq0pJtohenP+Aqy68ApufDGFNQIMZ8ZDoP9wHpmQ3k2tex
         ctmc0o9UUi8fOOP49wswunCrG3xtG0aBlAyS+Lbf1FAjmkQMURwrKagKs8TgQeB4DzO3
         xHUrZ82MumAJdhI8b/9J0Md4ViRKkBzwd7aUDUouqfh0bg0bb3DOyH28shp888NvmeKP
         H9dHvWS5OJGiX2J//30pNL7rDVhfgXMIHZNHu9gy4hkiVw3OEgM6XPLqLE8y9Mlf+oIj
         KqzWehrt4EUGKrcOOXzqLhq3e0yowFjtu/u5MoPw38WCrUKoW21JbbY/njeNyKptA3Fz
         /bCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxH/lkEGc28u7PIGZqbOsmox4Pq9kMzrGM45qduQ7/cgQTv9Mjlm6/m5uAb0yLuhGJ+VSvj2pE@vger.kernel.org, AJvYcCVoq8CLEP8ZoZcPj17zBxRKqQkC8KcvEXnAI2BBNdqaclgy/S7zWWF6TR4p+D+ukq3G7MEPKsXE/1fgcCkt@vger.kernel.org, AJvYcCWg4xQZb2ApGwLU8oMM+pTM7bsmcfKzetmRULOXObt29h66j1Edwgqs7eaOJ2UKBIq7SV6b/r2LxA4nrHwkJnx4Itg7@vger.kernel.org, AJvYcCXmQyzP5sPIroQanLn79JNfbVQiRUs7ZDTlRUUENf+Jgjgr2AynuBgplHRoRrudIY6GpBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTtWWBNL7tffOdTtUAtYNGt00TB08QQn6NEvbs/h7EB7bYsbzU
	/hrXy3O0KzktQGK1TeDU6Qy0q6u2ReGZP0fFiv0paf+q4DhOIn7vV6hNNzkpu+T4ZZvYG7LkNIY
	yWhWDnf+0//Waci1ReHByXgBAA9Y=
X-Gm-Gg: ASbGnctpm2m+AZ8NNotPO2hzLUy8PX0Gks/l9ivGBHAeqSyVHto5MEJTCJi6TOyZfAt
	LsvIQMcsZC6qmiUVXt91SJRMhq6x2pbiBKl90MGqg6Ndfnpzn3qCUPzgcZUDdZDYzaXUkApW6qn
	On2pozPgQzBvTRR7mee9QvQrKV8A==
X-Google-Smtp-Source: AGHT+IElMAk21PoBw46zmvLTxOIKzrTm436wI79ItKGnS7B37hL1mh91tHN7JBEL3hC27FIUVigt3qCLJ8UVxsKzHIY=
X-Received: by 2002:a05:690c:802:b0:6f9:5552:6b20 with SMTP id
 00721157ae682-6fd93fe85c0mr16592127b3.0.1741051372144; Mon, 03 Mar 2025
 17:22:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303132837.498938-1-dongml2@chinatelecom.cn>
 <20250303132837.498938-5-dongml2@chinatelecom.cn> <20250303214048.GA570570@google.com>
In-Reply-To: <20250303214048.GA570570@google.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 4 Mar 2025 09:21:15 +0800
X-Gm-Features: AQ5f1JpZvyop7dLuEaHSyJ9xfDPdFhBsxp1mwPgCCs2RQqwOnwzgm0G2X_76n64
Message-ID: <CADxym3Z76bm9wXPjX=9c95eZtWjODwz70xN1KUR92NuC6vzrwg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] arm64: implement per-function metadata storage for arm64
To: Sami Tolvanen <samitolvanen@google.com>
Cc: peterz@infradead.org, rostedt@goodmis.org, mark.rutland@arm.com, 
	alexei.starovoitov@gmail.com, catalin.marinas@arm.com, will@kernel.org, 
	mhiramat@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, mathieu.desnoyers@efficios.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, kees@kernel.org, 
	dongml2@chinatelecom.cn, akpm@linux-foundation.org, riel@surriel.com, 
	rppt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:40=E2=80=AFAM Sami Tolvanen <samitolvanen@google.c=
om> wrote:
>
> On Mon, Mar 03, 2025 at 09:28:37PM +0800, Menglong Dong wrote:
> > The per-function metadata storage is already used by ftrace if
> > CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS is enabled, and it store the pointe=
r
> > of the callback directly to the function padding, which consume 8-bytes=
,
> > in the commit
> > baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS").
> > So we can directly store the index to the function padding too, without
> > a prepending. With CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS enabled, the
> > function is 8-bytes aligned, and we will compile the kernel with extra
> > 8-bytes (2 NOPS) padding space. Otherwise, the function is 4-bytes
> > aligned, and only extra 4-bytes (1 NOPS) is needed.
> >
> > However, we have the same problem with Mark in the commit above: we can=
't
> > use the function padding together with CFI_CLANG, which can make the cl=
ang
> > compiles a wrong offset to the pre-function type hash. He said that he =
was
> > working with others on this problem 2 years ago. Hi Mark, is there any
> > progress on this problem?
>
> I don't think there's been much progress since the previous
> discussion a couple of years ago. The conclusion seemed to be
> that adding a section parameter to -fpatchable-function-entry
> would allow us to identify notrace functions while keeping a
> consistent layout for functions:
>
> https://lore.kernel.org/lkml/Y1QEzk%2FA41PKLEPe@hirez.programming.kicks-a=
ss.net/

Thank you for your information, which helps me a lot.
I'll dig deeper to find a way to keep CFI working together
with this function.

Thanks!
Menglong Dong

>
> Sami

