Return-Path: <bpf+bounces-47862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0FCA01170
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 02:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED821884D78
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 01:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D074F20C;
	Sat,  4 Jan 2025 01:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvinKyi0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284E433C8;
	Sat,  4 Jan 2025 01:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735953079; cv=none; b=d4cQA1+cWJU+q7CKi89x41unmqvX4AnoLInQuoLqyB5pBtZ9mw9mfGsjqwM/PWWXIWfDQJOsiKeUwzKMWsolfSROPgX4l7tYgnhzD1RZbVBxKa+prtW7dcuKAYnS5bNQm4lD4xKF6I/jp8CZ+cJ5UQ3bnA9IQs8Ux8xcwyeq4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735953079; c=relaxed/simple;
	bh=2EpnNetxqH/D4qbwT9OFXRl3vp1kKCyglNgnLl3biXo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pfLei24cGdl3+WEfiLQTuxcMNMKsVJDjqdzCI31kGsid76zmQ5IgM8c70GHktLe8F3W1v/Nu5cK7g4Uek/AFWe9fMvdB2EBPTph6V8EoL07+gBtbKe+aIJPa780PtlaOF61ZfCifw4G93d4M7vsJr5pCwq63Ls7e29QWz64zTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvinKyi0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2efded08c79so14184862a91.0;
        Fri, 03 Jan 2025 17:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735953077; x=1736557877; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TUldVnHTOHNAP3JaH3NOtKCjNJsdk+p6miUk6yL58iw=;
        b=DvinKyi0q2sBbF9eosSXOxaF/4F4dupmokALjji36qnQxuW+xaEDZ85Q+Kb/ljNrog
         utEjDt3JvQi2U0YXzH+5CsnMzsDEDmePkzaOyiZgBsTxotPmKW14P68XevNtEsIJ9di3
         F74VwjOWLWriPBGH/pgn6kV2IlrelMo3Vr4N5iRTN9k4wR8VtjZPd0tB6loIDiBjMwmc
         ZfGt1oC6h1vKe+4WJ6bXYT4uGtjRbjj6tT6OKXekiS7ZMfuQs5YNRScms4xfmxqVOGox
         RzYcBgwzx5q4tJSpzl14eWA7aVyMusnZHmOiZhZmbNFoUDAh0wkuHUQMt88RWOouGmTD
         keGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735953077; x=1736557877;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TUldVnHTOHNAP3JaH3NOtKCjNJsdk+p6miUk6yL58iw=;
        b=maPfCZFZma6mcDr2cKQpPWkgZYtaUpHW2XOOTiQycEG+3jcl8kyawKjGJ812NBaXrJ
         EPHU2mwwzdqqKFIcJ8cIKO5WoQU43JsvolzFNli9vvEuZ/wjwu0eZi1QwuEiNsYHv+gt
         SbYZsUqV79KkXJ0N6lrIBhtVvsW3QY/oYE6Q17pvyN+NSrMfesgq4xKfM92ViPAxQdx0
         huOGaej/pbS6FYFGB8WC4tY8lTmyNR7el3x0Bnvn5hUoBZnEf6EP+Z9kRZemxa8wFKGx
         YEy5f9ZIR/D3Yrc8RPt9QmRuTWwOHuN7qNo3UdKWCrwI01fMYeHECmlur/tRAhBe33GG
         Uyrw==
X-Forwarded-Encrypted: i=1; AJvYcCW8XVvoOj1+MMXTWkjTwPUGVQXX08xzh1fse7FWmyT5mxXwqSYeaNafx3AtDew/n+5XhZVWxZYvp008VdVq@vger.kernel.org, AJvYcCXqTOikrGgA8gvDPxvn7cHjRaYEocD+O3DxWTsLIMMHwMZ4DBecJ3dCzCufOKbR18xpyYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2G5B3S/b3YgqOiRHRmz94wGD+5Cdfw4M8o5Xp0gXuxZtlPMRQ
	S3jDasMIIPPUFXIYKZGJsYV1zZG22kMMR9t2n1QNUANOww/W0yah
X-Gm-Gg: ASbGncvoxJ+KBuqnUgpasyGYZeJ0N9cfEW0vyoR596o+gX8bjVz68CNnsYg02y5fQZc
	ZFa+xHuGON1g6VW+geiowg7B42X/XUdITeEBx2/e+tWOmOcoTIJxSqvYMoZnA1UWiA8ODgakpxD
	cYg4FapRrJbg7AoSij95LQBTtWl8yCPafkXJqWc+l3kVgl8nC6Rg0FTt4lvD9P/4T85QCfbAfjD
	kA+TrdVPaj9EnsaKgwLlssMTWq5TzM3tjOh+9XAGRTWbzZw0G/BaA==
X-Google-Smtp-Source: AGHT+IHhmqivSnANgMu4oJiGPu5Pk8xZEvg3QDaBtm6NzdeFKIpGVOzpaZNuanEWqOYYeelnmYVfBQ==
X-Received: by 2002:a17:90a:d00b:b0:2ee:9a82:5a93 with SMTP id 98e67ed59e1d1-2f452e1d13amr76394225a91.14.1735953077050;
        Fri, 03 Jan 2025 17:11:17 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed641ed7sm30914762a91.23.2025.01.03.17.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 17:11:16 -0800 (PST)
Message-ID: <eab308952286a2eee443fdd368fd05b6e6389df0.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 4/4] selftests/bpf: Add selftests for
 load-acquire and store-release instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Peilin Ye <yepeilin@google.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko	 <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, John Fastabend	 <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  "Paul E. McKenney"	
 <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai	
 <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>, Josh Don
 <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu	
 <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>, David Vernet	
 <dvernet@meta.com>, linux-kernel@vger.kernel.org
Date: Fri, 03 Jan 2025 17:11:11 -0800
In-Reply-To: <114f23ac20d73eeb624a9677e39a87b766f4bcc2.1734742802.git.yepeilin@google.com>
References: <cover.1734742802.git.yepeilin@google.com>
	 <114f23ac20d73eeb624a9677e39a87b766f4bcc2.1734742802.git.yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-12-21 at 01:26 +0000, Peilin Ye wrote:
> Add the following ./test_progs tests:
>=20
>   * atomics/load_acquire
>   * atomics/store_release
>   * arena_atomics/load_acquire
>   * arena_atomics/store_release

[...]

> ---
>  include/linux/filter.h                        |  2 +
>  .../selftests/bpf/prog_tests/arena_atomics.c  | 61 +++++++++++++++-
>  .../selftests/bpf/prog_tests/atomics.c        | 57 ++++++++++++++-
>  .../selftests/bpf/progs/arena_atomics.c       | 62 +++++++++++++++-
>  tools/testing/selftests/bpf/progs/atomics.c   | 62 +++++++++++++++-
>  .../selftests/bpf/verifier/atomic_invalid.c   | 26 +++----
>  .../selftests/bpf/verifier/atomic_load.c      | 71 +++++++++++++++++++
>  .../selftests/bpf/verifier/atomic_store.c     | 70 ++++++++++++++++++
>  8 files changed, 393 insertions(+), 18 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/verifier/atomic_load.c
>  create mode 100644 tools/testing/selftests/bpf/verifier/atomic_store.c

test_verifier tests runner is currently in a maintenance mode,
new tests should be added as parts of a test_progs runner.
Please take a look at selftests/bpf/progs/verifier_ldsx.c,
selftests/bpf/prog_tests/verifier.c and selftests/bpf/bpf_misc.h.

[...]


