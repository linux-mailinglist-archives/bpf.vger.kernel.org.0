Return-Path: <bpf+bounces-71639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C21BF8EC7
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 23:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7C95626EA
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 21:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5772874E4;
	Tue, 21 Oct 2025 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPdW7tuw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6E327FB2D
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081557; cv=none; b=YXcze91Ld3VbgrLgKK8cvE/p57ea49EKXXBxvVaiulmfu3N6uZIHeZPUzK0ZM7lHNkpnxoEaCcFWbUy+GmbfCy5/MIi77/xOpaTsFfQdIzC1i+4ASrW7If8yuiO0nERk0ssp4uK2UgscWxllH6HGOg+ddHj/3Tt927yo4V3NW+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081557; c=relaxed/simple;
	bh=Bb8cRIinBqcoriLi4Aiwt8FxLJyVNigRQVgXt1UBEZQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UG9Bh0k1A6Mos0O5T4C9c4657BscFCEXKSXgr5e4PrFJQ9v2d1+FkqRmAVo1eK2h0zBS6X9xPR5MeJ5fZesDxyLndmYaNcorv4vmW50npfraz5TzzXzTme4tiX10cI9I2aA6DccsgtZ6dRrcFGEAHF03IcxgzbBssJZomwsr8ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPdW7tuw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f67ba775aso7943913b3a.3
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 14:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761081555; x=1761686355; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9FTQfcQTEfzB8AnX3nAcBlVxl9QNwNumJpseDIkFME=;
        b=VPdW7tuw8xNEZlr5ngIR6Gb5PNMrBpHrfAhpG3LTdCE8biROXBqALY1T9oukwrZbKW
         lh7wMq1umUJT7C2uS9f4M2oF4+cKaDoZusXqIqbZ6CRZ1gEr61HhRac3KCDY6rFqUGV2
         3O2a/Nw5fZk3GeGMm34ASO4GE1xKrqWgL23uG+Oc5f3WDKht0awciw6JFhDHNvnLN+y1
         RjC8HFFrlXHtuf+XgD/Y1xn5QJfyUydbDP9/trrMGOeMdzYCthHf4cwHINePjjXAHBqV
         We31tqrjy11/5bcmDZFD/twh3ReMrxbbQji1xE0/HEq6vTUEZO3onJzqG+eNjpVebvsP
         IY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761081555; x=1761686355;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O9FTQfcQTEfzB8AnX3nAcBlVxl9QNwNumJpseDIkFME=;
        b=YkJAvQ5Nya0V4CerRuIPmvqtAF/QWPRfcp0MNgc16+eNXFKZrdTGKtJ/AJ4TyIWf+J
         WcH1g6fZPl21F66V2leyJ3lkBMjSJqPp73K0eXYOvOkdUHk/BiexSelmrVZ8SQANSkNz
         2YwEs4vspzVRK1kxFxQjsi7aRsIKjxVrYCZyJd2NLPCVHxV2Y/D2ctxY0WA5eJQX5OKz
         5vGZacOsF6UoJIsHv8XgxsJWHAHcp18tj6HBA5Zu8I9owOYC6nMRFIkV9UJtVO7LQKF1
         tp+ju88solb6lwYxObOQOq4dPZTCvXiM4NUidAIAi2/Um6DCBY120ND0gPU2gSt72rKY
         m2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6I+ETr9Dsj9KlB9kCFB8lhOFkZyzeCsXQ9Jte83v+TmEwA7O8QmRu572MHd/ogYQB2vY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyjkEyR/K6B1ieGQ6eJDckjmHUthNHaAEd36NcnG6xZBgDYLpD
	nk5/I3/nTPhJIdlDlZbt3uOv6SD8lnMMa2CpAyqWwsm+7JfDmSvrR5lN
X-Gm-Gg: ASbGnctlaCpMwJRHQkWSREgbJjWXBxbqtWXqGt72d4660FwpY7PuNcpxcpfDqG46KM3
	RjFvyaJgNQArMXS23o30TwVxWf4viISo7UZtGofkJ0vsC84LG5ElyLJZ+OSkdQhD/zT4KE92w7R
	TFGDnfKGKUefhFAgg8jmgQfSt4ZJAXPsUtZ3a/ewQnNqUSUfgfSjiVUaY2jpZycizhTQEdohx94
	dlkvFzV2NVIJ7eErInQh0jbvlopuNEImlniv0AdzKGWBcoqHCEX4Kkkg7z9xKTSnVEYUEie+60d
	Ote0xdlky1ASsbKHrfQZmKAYFJj0L1tN5SV+4Ec8iV9ibJOvNq+Npq+jdRrQKrjruuw911tm6cu
	jFWdnAq1Z5gQ63q8wD61gBgowoTihmSWQJnH35XzTs5ABAB5vXq0k3hwr+H51HwB6K5fA5286Oe
	Q7X7yvmy1lrxKIHCyqWX98Z42w
X-Google-Smtp-Source: AGHT+IGZTa+ulZUQSNNJcLdO+A/+/Li8Zkmocq/ILQtSm5tc29LX7Qk8YT6M9U5czYN23I2ZZNOvxg==
X-Received: by 2002:a05:6a21:998f:b0:2b8:5f2d:9349 with SMTP id adf61e73a8af0-334a8638132mr23691885637.41.1761081554864;
        Tue, 21 Oct 2025 14:19:14 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:84fc:875:6946:cc56? ([2620:10d:c090:500::7:6bbb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010df83sm12258558b3a.59.2025.10.21.14.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 14:19:14 -0700 (PDT)
Message-ID: <59b9f858879d7249aa4afcc6aab56c445839bd74.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 11/17] bpf: disasm: add support for
 BPF_JMP|BPF_JA|BPF_X
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Tue, 21 Oct 2025 14:19:13 -0700
In-Reply-To: <20251019202145.3944697-12-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
	 <20251019202145.3944697-12-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> Add support for indirect jump instruction.
>=20
> Example output from bpftool:
>=20
>    0: (79) r3 =3D *(u64 *)(r1 +0)
>    1: (25) if r3 > 0x4 goto pc+666
>    2: (67) r3 <<=3D 3
>    3: (18) r1 =3D 0xffffbeefspameggs
>    5: (0f) r1 +=3D r3
>    6: (79) r1 =3D *(u64 *)(r1 +0)
>    7: (0d) gotox r1
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

