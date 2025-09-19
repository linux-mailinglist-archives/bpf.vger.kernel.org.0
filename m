Return-Path: <bpf+bounces-68947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B09A7B8AD8D
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8F11CC2C55
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018D824634F;
	Fri, 19 Sep 2025 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgJL0GKg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A31A2392
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305016; cv=none; b=owTBQVOHr3wGI5Xy5DmZBVj3ZQfqt6G97TW/E3HofKz22XgA9HTWbfEoec4lcyol5LT1If18B46+myVmg5KRlOzcbonwbYy/2UQMfVJWgb1PI/qtRXOEZ2xT42U8iQkOXe1EEz2j68MQfttteexwZAUtytnHnfrKgn/qEvqKnr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305016; c=relaxed/simple;
	bh=wcDm9+RxZebYngKNooxtxNeDCdbGICRZYY6rZ2csUXw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ow8SQLwGH4rHDcjoCNJm6WKw31wOll3Me5PUKqPxwJKPJ2ig8pO0yYG4cym6M49sX5w5romJnKxN19KDoVer04Z0RBfl8Nb6OrM3ly4hnT17/RFnRky8THCnSrVZoyM7/LtlkIDB/+wJv4sRecyDil1EK81O7r3Cesx16H2N7fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgJL0GKg; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b54a588ad96so1806708a12.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305014; x=1758909814; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwcEO3YJkcVtuGLXOWitfdO8FgVZ8vZOfPkrxBpUhMQ=;
        b=EgJL0GKgdL67fSkf1RECwSG59TW9ZOswfCys/fbzDx4UJ3hocanIeqqQe6bP0O1XAq
         YoviL8O513FvAWccRfhRJVu3XW54R6UUGJCAcyGqchUYLyTWzDJX730MO/vPVRQEvw+/
         A1Xgy49G5czUz0WVNV9hCcPmiDopj8lVCzmg0H0UjrMgcxAZoK6+zZqR2ykC9mTYa7pa
         QXqRAq43+nwRCRHRCnAC52nhjMWL5u2MeSVvK3KS6o0VPfJuAj7pwfzeItqb1dXyaQq+
         qnXuoK8XcI/15QoHE3pQXtogXL88UxW5MxNLe17QB30V0QaKFnpjsAW9fEgwUMrfS1nW
         pDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305014; x=1758909814;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bwcEO3YJkcVtuGLXOWitfdO8FgVZ8vZOfPkrxBpUhMQ=;
        b=qUeZ2z/c0WYPwvvE6z/vETMC47nfnEHGW1t/PWl8cOtT9gvrgJUJbQa9TNQg+h2bxL
         AmDsvgtD6BKXb4ZwOXH2fednyIquJ8DNwQwBmb+834SQWvDwBJYlvkifp/uWY3HnxOb5
         nXy7W3x8xtCI4Zl+nAtSSqLfzeknVEqTD1HK5T0ZkvHzEKV1LWzDk8nbM7Smnz5fM/Ta
         kK0mEuRmuZBTXGkoM2CBfybvGH0YIKXbQAofWXES6FccDNVEQcX/RUUYlbf1v+Dj56AY
         bsfaXQ4O0hW+w9IgmDxxC67A7SHDnE7Rcj0tRTw7DBzdxuxPMXR4QXQz3Ip4Ys0o6baW
         54MA==
X-Forwarded-Encrypted: i=1; AJvYcCVM32kucG93tly18ypt+QnElWJLkleVZ6DRRS+9YVn9Cneh+AewSn+EIaGzMjZtLXPCXTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypC3i+QPj/32ah6Bz7XwGvGkfQHNRoXnM2LW49k1ibZmMof95G
	VNeJlfqmaUNYW1niO1osy2GBjvUNUm6JSqPVEDT/9RuZPmaiYh+V2Luf0Xe04g==
X-Gm-Gg: ASbGncta5f5KW2Xh5we8TchUQS66LD1d56Oxl2O00vJ0a+3/TRWH32q8IcsH8aBjM/Z
	Vj1CZ9L6avFhGZVbGZaN9oLTu2Vs6ioSdYHqa6kJyOZ27ZYEd08r8DnR978thN9ryRsELgGqVf7
	7BGnyTCLyJOCfnSbp3rBoh6kUV64UvssfXLQfaFVeWLLLpYtsgMSgK3a5n2xrBdCWLxGKyqKjTU
	k/wacXYz/580N5WXVOjELkt1cO3uIZ4tyYb+S/HJAa03eJwQ/fxcmClo5bWQgBwUl5C7lgxvJWD
	s0vD9Z5KZ8O1+8cY2xGEh3mIUFPeRhqZx7DKHxKJ4rX7PrRQC+4FVTx1Bg5QvvrMxdMJ1Y6Grfr
	RnB4SKc0C/DwkarE+8NE=
X-Google-Smtp-Source: AGHT+IFUz4xT/zUSHbMvOiN/KBzBoudhAyO7BcS1BjmHZtRE2pVZhxmvTTL6EdWS5WXz1xniBgtK2w==
X-Received: by 2002:a17:902:cec8:b0:267:99be:628e with SMTP id d9443c01a7336-2697c7ea3c2mr102679075ad.2.1758305014157;
        Fri, 19 Sep 2025 11:03:34 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803163a1sm59751645ad.117.2025.09.19.11.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:03:33 -0700 (PDT)
Message-ID: <2f7aa23aa3d9e5e026831f2b80789295ad4dd3e1.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/13] BPF indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Fri, 19 Sep 2025 11:03:31 -0700
In-Reply-To: <709be4ad929f096f441130bce22a817a7dbc1098.camel@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
		 <938446871de1d0b91ca7eb56dd75442b1d58b4b4.camel@gmail.com>
	 <709be4ad929f096f441130bce22a817a7dbc1098.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-19 at 10:27 -0700, Eduard Zingerman wrote:
> On Thu, 2025-09-18 at 23:46 -0700, Eduard Zingerman wrote:
> > On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> > > This patchset implements a new type of map, instruction set, and uses
> > > it to build support for indirect branches in BPF (on x86). (The same
> > > map will be later used to provide support for indirect calls and stat=
ic
> > > keys.) See [1], [2] for more context.
> >=20
> > With this patch-set on top of the bpf-next at commit [1],
> > I get a KASAN bug report [2] when running `./test_progs -t tailcalls`.
> > Does not happen w/o this series applied.
> > Kernel is compiled with gcc 15.2.1, selftests are compiled with clang
> > 20.1.8 (w/o gotox support).
> >=20
> > [1] 3547a61ee2fe ("Merge branch 'update-kf_rcu_protected'")
> > [2] https://gist.github.com/eddyz87/8f82545db32223d8a80d2ca69a47bbc2
> >=20
> > [...]
>=20
> Bisect points to patch #7 "bpf, x86: allow indirect jumps to r8...r15".

And this does not happen on my other machine.
I inserted a few printks, on the good machine #3 is printed,
on the bad machine #4 is printed:

  static void emit_indirect_jump(u8 **pprog, int bpf_reg, u8 *ip)
  {
	u8 *prog =3D *pprog;
	int reg =3D reg2hex[bpf_reg];
	bool ereg =3D is_ereg(bpf_reg);

	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
+		printk("emit_indirect_jump #1\n");
		OPTIMIZER_HIDE_VAR(reg);
		emit_jump(&prog, its_static_thunk(reg), ip);
	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
+		printk("emit_indirect_jump #2\n");
		EMIT_LFENCE();
		__emit_indirect_jump(pprog, reg, ereg);
	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
+		printk("emit_indirect_jump #3\n");
		OPTIMIZER_HIDE_VAR(reg);
		if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
			emit_jump(&prog, &__x86_indirect_jump_thunk_array[reg + 8*ereg], ip);
		else
			emit_jump(&prog, &__x86_indirect_thunk_array[reg + 8*ereg], ip);
	} else {
+		printk("emit_indirect_jump #4\n");
		__emit_indirect_jump(pprog, reg, ereg);
		if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) || IS_ENABLED(CONFIG_MITIGATI=
ON_SLS))
			EMIT1(0xCC);		/* int3 */
	}

	*pprog =3D prog;
  }

