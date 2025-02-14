Return-Path: <bpf+bounces-51505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8252EA35377
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CE3188E45A
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC9B38F82;
	Fri, 14 Feb 2025 01:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GldEmJSn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1C22338;
	Fri, 14 Feb 2025 01:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739495064; cv=none; b=o7JK203URZ4o/JHHoTPl13/q9eQE1PqcL2MZIa3YeeknUPLEsM3XUn9Eq8L96CLGPqdlX8r/0Ht+nAXz0LOx6KlUs7E4Nh6wqjnQ4+wOzR2MJz0SBpugRgt0lDyzBCkCZii8+Y1RXlILTWqg3VUsiZ4CJdS8SZXjh1T59qCbPCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739495064; c=relaxed/simple;
	bh=4SxNyIpPy1es7eOQ0/hRmJBWFkA2D7/NfW3YpxcpIZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ku3rSjM5vjwqgZ2f1Ty7QKTtPR3JRq2sMML8tzR58t1IztEnkVMHNmR8M7DYCwgHERZyndzsPHSUQH5yBve/IAwWPS7oDN3g9GGYdWt7hJnOdasorD2w6JwcP+qgMO8NJhIZoViPxQLcaSP/hXXkid9ahjrw6qUT3MTY5vD2geo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GldEmJSn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43937cf2131so10373265e9.2;
        Thu, 13 Feb 2025 17:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739495061; x=1740099861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SxNyIpPy1es7eOQ0/hRmJBWFkA2D7/NfW3YpxcpIZM=;
        b=GldEmJSnTHSCFOx3KYVG+50kAhjV/1jlF5NHn5lJUh0y6t0X6T79Ocf1YZWs5YdTHU
         z9ROX68Whq0eLI5syljPnxOZuZ5l9pYrqm0fmKY7pTGf0RV0xiSHo093ocUajFWhKbMi
         00tftOttDbiCsvjxuduRxWNyVak5EMTNbcBnJIWk8JAYFA7eui5kFnPnRogx7mdT2iBu
         LE/oknZ7Q4PmmOyvH2GsPrqKId2iyCUfZlOwEORv6/dCtusFJGJ4+Gz0mEXXZGCK6SJ2
         6JfwGBKBSdpZjpPJrvLb8mrUEUr9XZoc2lMemSbBRdxU1j3AWn+VEzSjuSEvESS5uwTC
         BZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739495061; x=1740099861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SxNyIpPy1es7eOQ0/hRmJBWFkA2D7/NfW3YpxcpIZM=;
        b=NGtuD+3bXTzMs3tSwZR3XRyyu31aVGvV7226KvX8pmnwTKnkZYzeq/LEzNQT88EN4Q
         Q9EkUk7SNJtZhci/tsKxgGOT7SOYFZRUzi21xk+gPLvL/kvxIhOYDpYvIsR+Ae4GTca3
         oKL0Z6f7k+NlVC7J67UlArJR5lEmAJMZeK7FoQg9NzVnnqqFXmkE5eq/rXQGoX87Oq/o
         yKH9EPZoZp32fmQj5iwKb7kDfcIFlNApxdfyN55qRzWrlJWigYTJi65XIm140zTy961a
         kzPYZeXBoeejy4iTtQyE0uuBbrkgrjdu7BuPYwGyEtCa59wFb7WeSNTkyCw4L3IxwSPl
         n3eA==
X-Forwarded-Encrypted: i=1; AJvYcCVqPVBSjomGQzd9JAQ10BoNCE7fQWvGkA3SIvASEpitTG5xcRcvuCWwp6eqaLsG/HNp8V4=@vger.kernel.org, AJvYcCVvsEydrqhXJg1u+nfWWDhgrzqC6TE+vg7l/fDgQGymoatKHK5lBiJYEP35Ci7K6q3f5AvhhJj29QL0Da7z/GsK2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+ATVRU4ZlU+oU1EGsE9i/7Hfgbf2djFszwhr5Wdb7ti9DrMi
	5wurLvteUFTOxeov7toIIBS5Tntf9cONhFnazJad0W6Ep3C7J+bzuh8zSDohBGLHUXMadaWBFNG
	BBscRgo701zfBdJV3qi/Nj9ZYvac=
X-Gm-Gg: ASbGncsXBvYb0V6WpsVWDIbSveHFRsI526q3jtEodcJrduOSlp/RBEFFU7BqoNprMNE
	nKCRiI9itBonNeWKVK5HFuqgTxj5U4oR3760aKNdhExmHM6gVR9+rqaKpZsSQdoki68WTuPaVgE
	2vsxI/OHNZmRwz0xAnwVVdQn6vb1lg
X-Google-Smtp-Source: AGHT+IEZ/ciRXIE9T7E/v1ZJSOJRWe9OKqDdM3wFTuITG/PoTeZejBQ9F59gyHPJa9bAXiP1VY/hGpNcSoD0eyvCNeE=
X-Received: by 2002:a05:600c:1d02:b0:434:9934:575 with SMTP id
 5b1f17b1804b1-43959a480e7mr104732875e9.16.1739495060387; Thu, 13 Feb 2025
 17:04:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210175913.2893549-1-jolsa@kernel.org>
In-Reply-To: <20250210175913.2893549-1-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Feb 2025 17:04:09 -0800
X-Gm-Features: AWEUYZl3qFnJ6gd92S_UGmeX7aEjjd69x-H1n70xDuSOp8VLHQpX8mMDb6JbGrM
Message-ID: <CAADnVQJD1UeMZrRrrQEZ-_twryA61Au5oxacvamL+HwT+v9=oQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add tracepoints with null-able arguments
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 9:59=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Some of the tracepoints slipped when we did the first scan, adding them n=
ow.
>
> Fixes: 838a10bd2ebf ("bpf: Augment raw_tp arguments with PTR_MAYBE_NULL")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Applied, but at this point we better switch to Ed's llvm-based tool
to generate this automatically.

