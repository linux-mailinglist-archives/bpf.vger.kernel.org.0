Return-Path: <bpf+bounces-19464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F8682C51D
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 18:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F206B1F23D2D
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 17:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C02F1AADB;
	Fri, 12 Jan 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0/8IGu6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CD71AAD2;
	Fri, 12 Jan 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-336897b6bd6so6275125f8f.2;
        Fri, 12 Jan 2024 09:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705082222; x=1705687022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnAM9wMRuDbUF70i1sO7UDTTR2XU4ykGa9mCuob7srE=;
        b=f0/8IGu6il5N5X2KjxDfjSTrIpVFA0ZjDkmQ7SJrH1sgC4sKteZXTTPA5mRjIzRxE4
         TslEKLToHFeYCeqMJE/z9Y74E7iYYaebMys1XhD1E0Of/hNwlC/b7Q5uTZfXNKKHjqub
         A968wCZJY3/2oUQeNTuIPZP0me29KtyP1unHzQmYVi1QUrZiFrhjR80XgbozjCXyIqvQ
         BMKf+5XvL5JYXMEvpOlC3SYCm0xyp4Xcr3mzerUh1riYWqF3HI9QcWmrwAigQk/OIpUa
         yyX5LwuLNxGSX9iZc5EAaHU6tgft6ZTnGW1KnNUzz3s2Wm43Xce23mkoqXDT0uAe5yk2
         YSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705082222; x=1705687022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnAM9wMRuDbUF70i1sO7UDTTR2XU4ykGa9mCuob7srE=;
        b=b6B8Q7Dtphfp4pagLTcPCeNJyKOgOlGzvv7mawOBOaugu0vIa71PXMFByo2IblirS6
         ZhUpJlKqEz1Ah1bOBVY5YBmY1g1t2kSX7mOpt+ElP9kBXUd+64AhxgoDckrXVez6MWXA
         5FWP/SX4H1RMRXahr/me79mycTxuNnoi9s5T7O9MgvHjK+1K9ItrPsI/vUvCibMEgdHE
         zxH4uPpKLDVYImeN15TTNd6z+Qp+PU8uQLE1hUztQ5Vktw/chv3+Sdu48uz796vVtvTu
         3+/6qyhMlZGiWkVcaJ9kxuLRiIvMNGGIXmKbg0sDLnz8XUWK0UP2guVTKUx+S8n/mAR3
         Om9w==
X-Gm-Message-State: AOJu0YxRDhaiqR+BE+KhrACb2bxFsRGqI6bwSeq25iUdW4hEFMOdasEC
	rheOO7zcIczg8EvnFDjejOhEjay8Nw9FrUbBIsue/BAo
X-Google-Smtp-Source: AGHT+IFUohHfasoeRDcAum0vBtM5I9vhFkVAA2LzRLQoQpbSc+WqVE3Q+8MHbPS3luCbeC4elupY5Ww0ESxMAzNNpzs=
X-Received: by 2002:adf:f48a:0:b0:337:7086:b70c with SMTP id
 l10-20020adff48a000000b003377086b70cmr975292wro.81.1705082222188; Fri, 12 Jan
 2024 09:57:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112152011.6264-1-sunhao.th@gmail.com>
In-Reply-To: <20240112152011.6264-1-sunhao.th@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jan 2024 09:56:50 -0800
Message-ID: <CAADnVQK4S2roFHP6W+PwT6+CjcCaUVzTHGHs39bwZPU00PEh8w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS
To: Hao Sun <sunhao.th@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 7:20=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wrote=
:
>
> For PTR_TO_FLOW_KEYS, check_flow_keys_access() only uses fixed off
> for validation. However, variable offset ptr alu is not prohibited
> for this ptr kind. So the variable offset is not checked.

Why resend v3?
What changed from v2?

