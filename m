Return-Path: <bpf+bounces-68946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053ABB8AC24
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 19:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785505A3D62
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 17:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682D6277CA1;
	Fri, 19 Sep 2025 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8Kx1ZG+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B07155A30
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758302851; cv=none; b=ZTwl+/p5APCJJOk7e/8ErwycAZdjSf/9Lr48DEkVKDiSF9z8ke6pqZly42AAbCEeCPHV84qzSxXJ6gYi6e3VTpN/ZIzv2a2yHAHncmpVIkNVlFQOp7yuE1EaKTCgVGcH02TNi27ezDyX6A8A8YFgxDSv1rFgTmgolH8Q0QBXIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758302851; c=relaxed/simple;
	bh=OhJHZplqohakUiyih7gCCqYB82ze4q5YTTYj7v7xRBw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uE2ieHrRKIAtKgbA8ZSN5hYgn7a+VjbkkcnU1kmVSP5HNfqaBcj4mRgRuApYj9R21aYtdTq1mKhuSh3bj3J5IdY6ZfNA33oxAvehPllF8kXUhv0vzJ2MjswJTme2tLuTzwL4X3UVOsTF/rnCwH9N2vxRxBm7F9xo9NOArRdNaUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8Kx1ZG+; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b5516255bedso933884a12.3
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 10:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758302849; x=1758907649; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhJHZplqohakUiyih7gCCqYB82ze4q5YTTYj7v7xRBw=;
        b=V8Kx1ZG+7qXWiufIEPNf7A7nMjnjCEOXQDE6mY9sAVaUpX0N+7Gm9lv7VjQ+SqkzE7
         uEKLjy/yRivTexCT6yXpxg2z6sxlOjprjtkqMGjB8k77WCcj6Gd8gd8njTjgy+cCtzZo
         zrhzygTocJinMCh32hzVYhclb6P3NwsNSSIWMeWrKqpltUKPMz9kkigFDzFPZDcFzZLl
         Sq2Vyqt9PJg+aHw8LBfNsUditHEqT+rW81e6EOBYYcGhbg/t0NJEVcIXK/6PbX4ATW1q
         IiEjt/KeQ+YkTsYVNBhwCKXPaXJH7eF6xNkcBHviZAvxqW8Pb5eqWPqQPdC9p/DMUT4l
         4pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758302849; x=1758907649;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OhJHZplqohakUiyih7gCCqYB82ze4q5YTTYj7v7xRBw=;
        b=jp14o54YcQqrCLBYF9lWxvJ0FQYlYcB6oMgneezRjsne21C63cdD9OoqcMCEYW7Edl
         o1KIZ/vF/KOO6QcuFrmuRZeLsngiYdmEHyuUE+7W+u8Nws/7KT9vYbPkKmH8JroOrNS9
         g0ZBB6V2rqECHQw/SzErupsP4IeTqjwJL4ZnhQyAm5UGhzlcoWJizusGerdn74paOR7P
         mqLdanfda18iQSEhdRTPr8mV0C9yhzfmGfG3Gb/URWVhZYAFY2f8Kc/EwpZFXDI9AOEY
         62rtPM83s8+YsFhFBneFEO85AmoOQfFz6F7R+Az8p7vfj8eWYZCecHwvYGywsPbtIpef
         V9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVPTaDng16TDODYnasWhWT28eofcA5QJ1QKgPQ+UV9x2Y5A6X0cXpdNiOrN/9VABR4uHGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygRRo2YM3trpIROH/D9kAYpINVjHeWgBE9qhT1OtxpggiLnmq8
	C1PmJeg5ThDDqi4TeZei6SalVx0aaiYTcWJOV3q2vuHJu1STgqxUNPmd
X-Gm-Gg: ASbGncuarRU7YrE9VrrbbbvdIRVLQ3XzzU2Csys/ZAZgqO4teHNtjIlwuyaC8JJN/ic
	s5zNsMb7cLyf1hbXdnthGKkIkiyAy1BuI+Xc9LAZezZzeXDIBOnvE2u+ED3n6sTYPFg0Ww/e6i5
	/45qoSvzotACpmhkZAyGWO19OVMAuOBrKeyW+f2POjhkLO+ifWVHZl6aTDopI/XAErlV/OVHUAS
	F6wzB0rljy3/dicBVedo+XVilh5ID5HJoiY83HbYt/Olmjwr0dVzGnKyqIPvbjQMtBip/dTwePX
	qi+yTqvo8sQUxh9hlJjrXTiNtAERbCW3kdFzR7j8tGOXdDEZTEBQdlHZn2m4uA0RfLb7lysW7tQ
	fKCT7YGCefWD4EtIgPCM=
X-Google-Smtp-Source: AGHT+IEuWufP9rTA9iL/Cm0qZeFEa8wsYlYkViFsHg5IKTE/c9I8IkhgzSOpprpyotmxqSD1TgaBKA==
X-Received: by 2002:a17:902:e547:b0:242:9bc6:6bc0 with SMTP id d9443c01a7336-269ba563fa5mr55404505ad.55.1758302848755;
        Fri, 19 Sep 2025 10:27:28 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec3dadbsm5843693b3a.68.2025.09.19.10.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:27:28 -0700 (PDT)
Message-ID: <709be4ad929f096f441130bce22a817a7dbc1098.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/13] BPF indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Fri, 19 Sep 2025 10:27:25 -0700
In-Reply-To: <938446871de1d0b91ca7eb56dd75442b1d58b4b4.camel@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
	 <938446871de1d0b91ca7eb56dd75442b1d58b4b4.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-18 at 23:46 -0700, Eduard Zingerman wrote:
> On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> > This patchset implements a new type of map, instruction set, and uses
> > it to build support for indirect branches in BPF (on x86). (The same
> > map will be later used to provide support for indirect calls and static
> > keys.) See [1], [2] for more context.
>=20
> With this patch-set on top of the bpf-next at commit [1],
> I get a KASAN bug report [2] when running `./test_progs -t tailcalls`.
> Does not happen w/o this series applied.
> Kernel is compiled with gcc 15.2.1, selftests are compiled with clang
> 20.1.8 (w/o gotox support).
>=20
> [1] 3547a61ee2fe ("Merge branch 'update-kf_rcu_protected'")
> [2] https://gist.github.com/eddyz87/8f82545db32223d8a80d2ca69a47bbc2
>=20
> [...]

Bisect points to patch #7 "bpf, x86: allow indirect jumps to r8...r15".

