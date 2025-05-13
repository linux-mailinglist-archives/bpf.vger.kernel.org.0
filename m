Return-Path: <bpf+bounces-58079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CFBAB48E9
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 03:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232661B41406
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 01:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2B918A959;
	Tue, 13 May 2025 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2ObjQxv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829A0139CFA
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747100833; cv=none; b=a98o5Ri6krtqRjDM/QyDXrMM6fnbM81UJmgZFonGKQLdr52sQN+Q2xNBpPf6c8gVbKXS20Un0MLf9OeRkwGzEMsLFpC7X8F/hF8xp4Fxlu0gfNPA9dByTVlTT+ZiuKwVww/N353pifan74b7UO6KvUKjovX3uv82O6m4ziRRc90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747100833; c=relaxed/simple;
	bh=GCQPPthJdXb8fQwirgkhKmZ6pJezzxCf42lt35lI7YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwvpEfuZYn3zPJ0099icl2+hZsIkShscmAyt8ks9j9dknWOFIud3XoZGg0rNXXsrzkoSZRcNpxehnV8SXdcLr771sCqp1YiLbIth5oKbUMEwhblqipuQzD2bYZboLiIt113jT3eSMgHLfgg4zj3QdR3pnyUeR/sf9tqf0/UKRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2ObjQxv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so57716455e9.3
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 18:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747100830; x=1747705630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCQPPthJdXb8fQwirgkhKmZ6pJezzxCf42lt35lI7YU=;
        b=d2ObjQxvNYWn18P3kXcQSZn5O9MWgwTiSYh3b461qOjOZyN5CYDZ3Zg219BS39b4KD
         6HIIyfIhZMKsReA4Bbp06rrluRkeeyj2fKHlayJtzcXM2FZ0k0J5TK9ghuMVgp7Ie+5B
         Nsk4i0YFJC5CHg29WECu5RHgOvPuOnfPDlKTYsed6iepfCXUlkk7P+DuTNnBrXa287Ir
         RE2UgorOmLEpfjntNw+BySprWPoNKNerkt4UQ6wC+dR5mftnWAzoSPgOu5G3sv0yYlQW
         q/O3JxwJCSFpn/ScCCBTsg7nU7/m5Rrh9Tsx1Xxn2PZauouk/epqgd/nzV/5PyK2CnO4
         uv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747100830; x=1747705630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCQPPthJdXb8fQwirgkhKmZ6pJezzxCf42lt35lI7YU=;
        b=huIrBmp9KSc5q4/LEA+0meWSdhiik0xFmFKPVS1tUobafeAiUKzocxww5XQyEDL1+1
         6ozctM+Vn4Rk9KROiaoHizctI0IdkBWizc+j7ymRF6ewA5DHKTQjioHvG9908eeeo8pG
         hRlHeb+OvpRPJIsVBS2weT8ecA3G4sLqBgtF2qAPUzKIwmVUeIXmZq93mW0GO/peFOZg
         U0ZIC6beAYIX/8h546gsH5fF2iZNxzAJzPUfNpNjdPxkvcDUJxkyvD+Zz6fmHvANTR5H
         QRnFXvi4kX7v1J6bj9A/0wUx+XKGEHQZGc1Z9qvrSUSaHXVcat2Kxz7bJ+5RJ6prtG1B
         +pRQ==
X-Gm-Message-State: AOJu0Yyd1sSS+zfdkDudJkKqbyNsgNBnR0ITTgw4C+7oMqU0Q0FRYXwU
	dWO2ptSz5eMSbHo9kbcBpReKG8iKQmYFN1iM+/X3Sywb3WONr08OUdpYyeD7SmTcTdDoT0wggsy
	29wUwLYewigbbJ/G8Fwl+IYWn3to=
X-Gm-Gg: ASbGnctwI8N3HCBBu4w1DK08piq9L6rT51GK0XAIIRdBoWvN4RqGC+DRur0gmfM39W9
	4pymndKaEAqN6ZmwWPKsWREluuFSrQ1eEjlie87d74VluWuE8Spwl9wKrP70HgJ7nRicsgy4ezZ
	cYMeDbnHn9IZbYkmnntIb3dN8sB42t1vmAW2FdqjIYE95wiiuAEulKLTE2lAHrXw==
X-Google-Smtp-Source: AGHT+IFUJYJ/0Cw9NlNv1TYLRyu5DblQNq/NmeN4Ic5fLyYQai6FHGDKvYGVm39f81C5MjbFfiea6SZQQgsZG76RBjo=
X-Received: by 2002:a05:6000:2502:b0:3a0:aed9:e39 with SMTP id
 ffacd0b85a97d-3a1f646c6e3mr12395082f8f.28.1747100829635; Mon, 12 May 2025
 18:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512205348.191079-1-mykyta.yatsenko5@gmail.com> <20250512205348.191079-4-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250512205348.191079-4-mykyta.yatsenko5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 May 2025 18:46:58 -0700
X-Gm-Features: AX0GCFsKq7GzO2_IWlCONK4W_P96mQN5xHg7EBjWsJWQZCyYslj4rQAB9shdScM
Message-ID: <CAADnVQKTVvXUXygnFASdoZc3d1WEPnVuxQWO8Fe8iQW6J9piMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: introduce tests for dynptr
 copy kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 1:54=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> +dynptr/test_probe_read_user_str_dynptr # disabled until https://patchwor=
k.kernel.org/project/linux-mm/patch/20250422131449.57177-1-mykyta.yatsenko5=
@gmail.com/ makes it into the bpf-next

What is the status of it ?
I don't see it in any trees.

