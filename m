Return-Path: <bpf+bounces-73873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E39FC3CB2A
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 18:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F905604BA
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 16:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791BB3002B7;
	Thu,  6 Nov 2025 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rtfj2ogm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6420226E6E1
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448302; cv=none; b=Zt++FMS6AdCZGQ4HQ+Roc/TVXBse4+fG9jLMwItPJ8Lwo9zVzSPg3lW66X7EZPCpBcDa6pJPfwaXOVLJnNs+NM0r4gfgetjEpGDp5bgmeBnssGljv+Iwj96C/FexQuDUrtadwrZ4Ef8hNXV1omvko3E8+H0YiG5pusZN79YXVlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448302; c=relaxed/simple;
	bh=kqpThpdpCR24U65u3shZNMCSeHd1AWBJngrBJDxxEi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlgaF9AHmtH2V0d7wSlGoP7UNAANdYXzZHjE+nwZTlMZAFKEjM1Lcv8RD+3qtD/2k4Mid4yLMTLYiI7/Fn8xxt6RAvGr7f5WaCdR8QCozo/7qXi4OLK25RiZ/z1KyknK4xOIT3KuN3OfPT3yL1Ab2fQm6k/4LmZ/UPLbdX/HKFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rtfj2ogm; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47117f92e32so10113125e9.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 08:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762448299; x=1763053099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wbX/VaVaJmq54B2qFPgebBeZKaiek/4l8XYUJ7XsEyE=;
        b=Rtfj2ogmdIdJrAaAdYk0uRJBVlIXW6/7znAhSdElBkfHh5B3l8+Jo2NdPf7183elEH
         IOkJE45qpoy75yshKmFKvjP3b6d+Wa2mLfkofk76yEpkUKe82ScqFqQF/zcCG7gdM/9W
         2rtHnljJKcurWvhVCSqen3smB7FqJXT0rHjGSpT3XqxSP+KjcEkbM1lceXX6cBS1+tot
         zo9Xl0UPLbVncQMrQwCkqM0QN2I+gQ9InnKISREv8il3cFsCilZ3lWLdUU64gr6Wbf4J
         9+lvpT4ZV+iEkGp4eO2MibFnE5BLwgCyQHoT4T46rxXbtUmIDTzuFAFIQJP/fRx9GYE5
         yccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448299; x=1763053099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbX/VaVaJmq54B2qFPgebBeZKaiek/4l8XYUJ7XsEyE=;
        b=j+tsAg7GxcLTf65+U3/eEKmgaDvzy8kL1bzSZoDwYMGxl6x97zNa18QbQwuda3PZ5j
         GiTycw3N0vX2MKJgVYSFwlaI981hBVxTUWYJ3ULagHZtjvtjmFPrhHCqF4r5WqDvS8gX
         SGYt8I1F1U+tP3CxFtkKhs8ZlviwB+lKjxFFpljelPGiA9nqv35hSUR5leMjw/jmiH1y
         7Df0XLF5QmO8cd9o4AaUqEbr9rnk1nT9ztm77tfN/OOEIkY5g0ileTawpeiBMjgHJg1p
         jC3/pEq0U7uR2i9ws+XqxoDE1C6HvtMm5khGXioKhF1FzeLTLjibArr2qgp+JAE2rtIQ
         wZ8w==
X-Gm-Message-State: AOJu0Yz+tNl38X6O3GXvL1PgcznHTPHem2XvxPRjPssJnBebXoULIWni
	Ks46MrKgU2slOO0+0Ue2X+f7lqrIC169wIh6pQ++qQwgob+aKUh0li3ZcH7ifgcinDWVQXWDZMK
	bjq4dncen8reuPKZiDhY6V3nNefKfHVZShim7iQh5PA==
X-Gm-Gg: ASbGncuNpEqBJcUBhwpBc9GdjKEJWyVfOcUYEQ4aNHtdCXYaBuTJLrwJMabQpE7UPma
	0DHuSgrT4FbFwf+M9OmRB7+KsB2DL+lMxjys+oY7iycukSIrbFUMTwcqydI394iBGRFMZMMDohQ
	UYo+9ohqbWfvKTBS0ee1PsjX79r5ih4PWyJJNZxIbf35g3pC81g1VXeiJbEqvyqiyNV7jKkwy+O
	lPKyWdQJiPRU+SVP3VTmrcofTdXEMj4l+hgFt1GS0OpOIGdY3hE8XZcVoCsfWfoYjJunorFeUM+
	mG7Mcl5kZobReLZyMqBIuXV/mPJPOW/h0PeE8SMA3xonOlRCFg==
X-Google-Smtp-Source: AGHT+IHA3hjChE7t9NeXc2o4cBXaVfWgNJNVFc7EQmL+sVsEUKXhcITjC44Apy8+VnYxjak29O2/4PRqCBSxWnRliNs=
X-Received: by 2002:a05:6000:615:b0:429:d6fa:da1e with SMTP id
 ffacd0b85a97d-429e32c5580mr7457476f8f.5.1762448298615; Thu, 06 Nov 2025
 08:58:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com> <20251105-timer_nolock-v2-2-32698db08bfa@meta.com>
In-Reply-To: <20251105-timer_nolock-v2-2-32698db08bfa@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 6 Nov 2025 17:57:40 +0100
X-Gm-Features: AWmQ_bkgnr8ZE3wxAuNK4n_Zyamn9Vq1_wAkUYgJoRsuCGXfrbBnKTHWsq1GynU
Message-ID: <CAP01T77bZrHM88XS5ZuT-po-em-NMns35afPomd4Wdzd8SWpAA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/5] bpf: refactor bpf_async_cb prog swap
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 16:59, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Move the logic that swaps the bpf_prog in struct bpf_async_cb into a
> dedicated helper to make follow-up patches simpler.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]

