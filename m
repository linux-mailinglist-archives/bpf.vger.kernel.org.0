Return-Path: <bpf+bounces-62348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE1DAF82ED
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 23:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8A31C820F1
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 21:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F240D23A9BD;
	Thu,  3 Jul 2025 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEQU/3Ew"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46379230D14
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751579705; cv=none; b=EMogoSiY7Beoc90+tGw/5LUusSQbsqxWTKv1QDHiEJpHmH2zamoY2F7IsAS22ua3HIUH5JMwHY6q9FNrBiiS9pYb6tGGV+wQxGLKP4gcoIXsvcYmAsENpow9fEcIHvtYgUgzwUaU3C3N+gJAgMmRC/zQ4xXaGv4+KbIjwQ0jgGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751579705; c=relaxed/simple;
	bh=j4OL81ydWBZ7TSLL4L0DwyWvHhjmVTYafnZkxIPDyfU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fCWoocLzh3YEEYllUdGzJBYglIRmwqNeAT1TKwk78iquHeC8Q9GfN4hTdbWAJdG5H0jc4vqaplnCTMnh8tZyh/3zSzYYqwC25QI11Cf2RXqx/iUXXgeJuz7Hw962MatfONeeKq91FZ3AfrgdpX4TKByYfziG/T1RbK/HJuW3W38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEQU/3Ew; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af6a315b491so307880a12.1
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 14:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751579703; x=1752184503; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ChHQt5GB2q0AlspMz6yEesn/fppVstj6mEKFfpAltv8=;
        b=KEQU/3Ew+t1QBc3bPo+sTysdeEJ+lQXrhILb7rSlFBsw7sPwt5J75cL0bW8iFRSrDd
         rfOLtXd+QoEvwLRKH6Gkd1xtTx56gowTjmDO/Ryajn1UMP+6AL9uT/RaKpbbP/pQLP22
         SghGTvabmXyG86O+faHi8DD0gjMlxKFvO9+mImbV+pQn/C0/FSJRkDCryAUJGeM1QYFY
         ICA4+JaUmg70KZT4m0GGVT+xL/RaBQUrDHg949z7zeNLMhjAnjh+V7jzMHfiHGpB0ML3
         tIlh4neuOMFFcKxVkI9lzvR5yPUjvyrqDzWPWzK5F0ioDPnI9cQguYVqa6r0O5r5VPDe
         cGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751579703; x=1752184503;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ChHQt5GB2q0AlspMz6yEesn/fppVstj6mEKFfpAltv8=;
        b=rKfG2Y9r39YPW1N4z6lRlvGYogHFIxKWF6wHbzjADXnTvTXtLvkSwZcrT4hoHAtZMe
         dypSlEvarVS6CKZT276QOXpa7v8pg736pQk9PzAIuGfPw0J/U9KjkV1lGLrT9UlMBnmN
         N4/0Lzsie1hwo8MkU7JusFPOgJVii6rV4hIPBEHyOXIbHsJ+LxDZAB+hkx688fAiKIC+
         2j3h1ftKPQ25/1bg6sQCcxPLd4IZa0lHuLOja5UcPobPpmlDlNLlrm7miEEOgKc+kAWe
         yVt+7mK9kYRcxYXGEP/Zh3gboHfNYO4JACTuWAYSCR1yT5XNYmNtGDpXUmBoW1DdQlus
         s4xA==
X-Forwarded-Encrypted: i=1; AJvYcCUKijCYn1wGnXpDweqeKAietjvf4gpmYEqPGjoa8EH1iScItpJJnU/9I3vkNd/eOlatXLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTC+G1fkrfRpL+3VAazZB+J2f66fyIPPw2HIFk9AG+vbOLPYCp
	yEsDvvu9deBynnzDL++e4JcsT/riTKigZPfguNjbuSdNsboqpUmQSA5F
X-Gm-Gg: ASbGncufQhg0WTHHq6A6aoYe+0hE1tiCXuq4iOmifFtrQ9n+dLmHVq2CfQ8OatoY0lr
	o5fVN3qm5cQm8x7qjKp3rVkv1dIHGJaet8P7A7ZTuWUMS9xjhsVS+w0zhmIiclKC17+a7DetYoV
	NuewZrmNpXPC/OC3SNDyEbUY0kVPUsv68sLMmd2J6a2rx2sytPzPIhnhZ+cUIRx2gLFm3K7dJkF
	vVhx0gpSma7YKJj8LFPcZoiedYBKy1X4tgBjZnUj6Kq2oXGaelzhxzCgw7PX0zClWMrgCbhsOKG
	pV6l2mAUxItid45wPDRj64WAO/XMLEriGxdqpSrLdCInqNFLdBSReUlLalTL0SY2GEyO
X-Google-Smtp-Source: AGHT+IGYXYDFzIQtJ0AStBtqC4chq3uUb79TVuLIdu4/lgztVWCkEECzlXlkT2fDocEcp5vnHJUGgQ==
X-Received: by 2002:a17:90b:53d0:b0:311:9e59:7aba with SMTP id 98e67ed59e1d1-31aac432834mr363604a91.2.1751579703474;
        Thu, 03 Jul 2025 14:55:03 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:90c4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaaf52c0fsm393323a91.38.2025.07.03.14.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 14:55:03 -0700 (PDT)
Message-ID: <ad62770379cfcb7426a9a765bb59edb6d5d91fd1.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Negative test case for tail
 call map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>
Date: Thu, 03 Jul 2025 14:55:01 -0700
In-Reply-To: <7cec754c8d4cc2d93a50e9091d7ccc7f33d454d4.1751578055.git.paul.chaignon@gmail.com>
References: 
	<1f395b74e73022e47e04a31735f258babf305420.1751578055.git.paul.chaignon@gmail.com>
	 <7cec754c8d4cc2d93a50e9091d7ccc7f33d454d4.1751578055.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-03 at 23:36 +0200, Paul Chaignon wrote:
> This patch adds a negative test case for the following verifier error.
>=20
>     expected prog array map for tail call
>=20
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Nit: selftests/bpf/verifier binary is considered obsolete,
     new tests are mostly added as a part test_progs binary.
     E.g. you can add a file progs/verifier_tailcalls.c,
     register it in test_progs/verifier.c and define
     tests using test_loader framework, e.g. see
     progs/verifier_and.c.

[...]

