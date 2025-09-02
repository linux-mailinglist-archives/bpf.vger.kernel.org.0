Return-Path: <bpf+bounces-67134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52722B3F22E
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 04:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2526D205A46
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 02:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E00A1E2823;
	Tue,  2 Sep 2025 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GN6NibCi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AFD1C68F
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 02:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756779533; cv=none; b=hqYtOc9BGxGlWXzlsWyxdXOp99i31qCLTQRzbfg4V5s5f6htRcxUzxlLn+kc1/A0+omUkHtM0ZXAF8Ph5qJFEaWVZYugsgZ3fsIOdBDPd3cmQ96uY/2t8pXvueDp5fUzKctG1jdURjdp9NauoWSLn5AsVDc1l4rQjLfF5L/g1No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756779533; c=relaxed/simple;
	bh=T8/5IduTcZs5ihF6rafg8Wu6IwknEz6C6KQ0vXOX4Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsF6G+OcrZviGRMWi1IwART0buKE8C6C4RRy9Y+j4dTDv75vBJ7W08+Dt9Ab+30ht8lLKrTEPbpI5O9ZL+oblJLnBoRUK+mALd4KBSo9wmYx59M0hwj2NNaAjjhjrQVw2NlViHpNLYMF1sH/0r0W5yHUeObukUNiFXpy2KzG4F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GN6NibCi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b82a21eeeso30035685e9.2
        for <bpf@vger.kernel.org>; Mon, 01 Sep 2025 19:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756779530; x=1757384330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8/5IduTcZs5ihF6rafg8Wu6IwknEz6C6KQ0vXOX4Zg=;
        b=GN6NibCiv85bMwUXRFmMvoGeOEl1/m5H7+KGWn3ut6rabGCwp5RaIeuNnuki4swUJw
         NxVhZllfgQKKkvdyXoHfmL79T0l9rZa7/2j+d7QfczEyjVpecCILOWnkx9T1080ZceIa
         OGJjIc9kaPS3S9xwc5qyn/mXvR+E7ivUIh27c4MM6qk7D+gu/Oogoc7gysF9ijvQREtt
         G7uVX2dd91cu1EZvFQdzmJ8pASS08TMpa1ukQOtbtgHv1yAZSwfUceyP+zIBGHTZWiyc
         CWpHgsnsWBJzWG8+FEVysZm/9PZjdRLLh9XhJk2WgfUPASLFMmoow4LarhS2QSoSDdhU
         DWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756779530; x=1757384330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8/5IduTcZs5ihF6rafg8Wu6IwknEz6C6KQ0vXOX4Zg=;
        b=h10GABonYp/ZwKB5mdv4Mfjd7zeL3YGWJV8lfa6eaxW6Q3RARr6UYxHPTaqwMgQQ61
         AQE9EmEVpd3KjziLlQU3QJZgDYNOQKZxDpJIMBsP39PgeiVpyTWowo8cVOmCgx1akuZu
         p/uQXaOiYHKZiCXisGqg64YV5tCVpB35Y6asHG6WYL6HNWuL77sitsru5HkFNePkSi7c
         amOfHHVnHr+dL4sww567+98EJdGbNhHXkB46xPRvya0zhmQIe6C2OvBZc3P3Jl5P420F
         wUjR0y01ekBpA6geHGuGCUJtlsbIb7zd68LV9jCTqoDClihXxJQ/MlSsoExRSvmP921p
         mbqA==
X-Forwarded-Encrypted: i=1; AJvYcCUcKagMpfX1Sxjw0ZmeMpvE5y1teXyqfW9YQsqFzzCUvBWOE8crNdCLFy6srnGU65Zpo8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLeEcz23+mZcA6e3pByVYReL+KijmNdA/hH6hk6A9RvTCqaAE2
	SSdKE87PHNXe/0bE2Sz8YWcqu4cFeL1mPp10iacpdTdEQTVrpl882M17hppIYo8RF/eDbkIyBrP
	Yvynix6Qv86c3Nn7vAijApFluEnrkXn0=
X-Gm-Gg: ASbGncvZdjM52aS5nRrrtpiCT8P1gpCjjpJW3f0QhsY107ry7koQRCOgLicJ5EgWOPU
	oaMUNsNHmYPqgi9akccjmOsEB2C9WC5/OOdei4AHdrzLJ8mkZM7RMByTkS+w1OIqVc+XWtk+0BM
	EFz0tgr27RdgijppvXWT4ysfTZO4omGy65l1avDNaVr4G61/HmSy57OD76pB1BXxR0JuAHIMnHs
	V1DpHfJy4F/dDepY3Fg5cwtr+evWT7YvEfx
X-Google-Smtp-Source: AGHT+IGzpHuNb4O7TMI5TlIIKtSbgi6LYZReti29//5nQZfCT7Pxy4iWiFh2IIOnrdZbRCD9DP0+p9bdesyoCrYRsPY=
X-Received: by 2002:a05:600c:354f:b0:459:e094:92c2 with SMTP id
 5b1f17b1804b1-45b855addd6mr66586305e9.27.1756779530167; Mon, 01 Sep 2025
 19:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827153728.28115-1-puranjay@kernel.org> <20250827153728.28115-3-puranjay@kernel.org>
 <99bb1aa8-885b-4819-beb3-723a73960f67@huaweicloud.com> <CAADnVQKp-FXhVtxCSE8rako8BBnAU4Qt-dxviqrJUr-Fpfm+4w@mail.gmail.com>
 <mb61p4itmjnze.fsf@kernel.org> <CAADnVQKPLwGF25YOzA=a4Vr==0UZFycv6GkLbwszkFrBiHGCcw@mail.gmail.com>
 <mb61p1poqj7vd.fsf@kernel.org> <CAP01T74DdVsxtdivHg6hi5Ei8k=iT_FMvRr8XE7zEqBXYyz6EQ@mail.gmail.com>
In-Reply-To: <CAP01T74DdVsxtdivHg6hi5Ei8k=iT_FMvRr8XE7zEqBXYyz6EQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 1 Sep 2025 19:18:37 -0700
X-Gm-Features: Ac12FXwFs9pRQmY1hy0iOB_Vit1GQsfJ0Hx0d8O7LC-s7Po00u7uIAeJfrPRV-U
Message-ID: <CAADnVQJgD2YXkKvOjs2xwJtFyNZ=HzfVAX1SNA4RqCkBkM5j5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] bpf: Report arena faults to BPF stderr
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:45=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
>
> Additionally, I feel the extra pointer is unnecessary. Instead, the
> logic to jump to the main prog from the subprog can be (if I didn't
> miss anything):
>
> prog->aux->func ? prog->aux->func[0]->aux ? prog-aux
>
> When prog->aux->func is not set, that means there are no subprogs. I
> would simply wrap this logic in bpf_main_prog_aux or something.

Good point. Forgot about this one.

