Return-Path: <bpf+bounces-59185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01577AC6EAF
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 19:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3D34A34FA
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFD928B7E4;
	Wed, 28 May 2025 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd7CSwr3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7D1F461A
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451881; cv=none; b=JY9fUdMu7axqD5zzQSPqmHXIqk6TrHtj5Bt40Jo8V6hTA2nQX45ykc5QTQ8h5kqfw3ZSEhOaZAWnFvAV1I6dCjO8gEDdPP6+dpRnGTcyg6qU/ifFqTAhCeAc7S9IKqZBlcIVUzh6Bw+fXASkFFhRqE1g8tprGyDjqJHIAvbcobY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451881; c=relaxed/simple;
	bh=e3ueJiQl9dSgrfPGUEFBV+g47IT2qbb0RhAhaKlQWto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JJMuV0oHPmlWS7rBk4ynJrzxY9wWTIObz9Rh5jBrRZADb0Tft+XTy+jLJLmWN9TmASqcQGOXt4ILm0UegRMGwAvvHFk13CRc5XAkpKwMaCXpsfOqgb80HHz03dx6MEBmi7EGjZ6TGskFXOAFVaEuoWc+X7fpBltNj0ro0b077Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gd7CSwr3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-310cf8f7301so83417a91.1
        for <bpf@vger.kernel.org>; Wed, 28 May 2025 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748451879; x=1749056679; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lq7CWPjVn72DUN23VbJW/vXDCgcdXdP6g7IA4lvfo8M=;
        b=Gd7CSwr3LkKk3H4zRMcpfaVYAiBbI5lnPxPd8XPlVgCush/ZKhaA28RlPgTb2By0xx
         fc9YBPZwqmBp1owr2AMrJQ/BZ0r4a4HDOXFSZWzA3m1kyddqrAjd3Hkmga7fe59zNB/h
         TdTFpAUvVLtv5jlBRK9SxmSXRqZhkTLH6mtYRc2N/sgSasP+sZpsUo4SEkHiW1z9NpFQ
         tgDjqLxMUqoKHP0dcWgQ1AwvUqCBkkDSc+6hOI1rxIKPbN8rsavnsWUMORqcdd7L5Hhw
         tThXE3+rX++wBE/9lcJwWNpXFmjyfZ2mmh2YqYc+Og9sC6RGXI63VYKi+845aXmyijBp
         357Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748451879; x=1749056679;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lq7CWPjVn72DUN23VbJW/vXDCgcdXdP6g7IA4lvfo8M=;
        b=sIKfG2fUn/dUGwuqC48UmNLxKu4UU7ouwKU6pS4JClvkifE6JD4vIVU5eMFe8mEn3e
         PrKeFIJXRX1Fel/rMwNPpfwZKCahyl9ze7Vl5+LcJZ+1t5hbsNh4vH3GISN4RXFH1QwU
         ySKDPsdvRpn/OHVq11dWwZBKXBGNjLaC3egZ+jkDiD1RfNl7Dv8u/DbbjFOEV6IFYA40
         et+kvRhyGaM87ZTEO8f0OJU5PUF3ZQjbyTpphbYHGxhzUjybiZZJKb3s0fmlw9kjrAIu
         xN1/fSMiK/+G0WqU5UD3dYq6uF099qu1U9Uj9kKzpGWK1gJ8srTNWKktQICkF4P00R38
         MK4w==
X-Gm-Message-State: AOJu0YzjHDFxuVU0+cyld0p0aPGwSWtwUadyg5Xbv0x0CDPaYDr3oxs1
	6aj7nL1tUKSLgPMmUyCLPPk0hB8JoTlFCEugRxiGRaNZ0HLo93WTdDoo
X-Gm-Gg: ASbGncug4xsZylXl6cPYRMZ5+b9HSeKeanUnM6sv+DFJwDDC5/7Xh2ZCA+snZCLVl+9
	bvyvtxf93UOT8KNKDXfyMa+n/HMB10mLHb5WU7QVl5gy7AmM+Klq1+o4T3fLv9WsRFKuuxUIzpn
	kTv5JnJJRMteC0yRWeQHsFJE7lPBMlRbXdMNit/QScxpp5277D6ErrC2qSNqav6qOANkvNes7Ag
	yLnWhkJk0pjA2EvjHO+VdHPjxzhg+OnrPXxZnAV5QvZEPWnKtQi6EmzEol7930gbNWHjTueQECE
	zn0F5hdjKCt2Q/2WKGOFugyTcVAERQYdYChRKcoiKe5fy1iQRCJbYziBx9OvqBlmUw==
X-Google-Smtp-Source: AGHT+IFcsbVRZq7O7wfTS8eN2yBL6jegoV/TJ9TGyanywg9G6Hlo0NbgyJCO06puDarvUBl2hE7J8Q==
X-Received: by 2002:a17:90b:3e8c:b0:311:9cdf:a8a4 with SMTP id 98e67ed59e1d1-31214e4d8f7mr516257a91.8.1748451879238;
        Wed, 28 May 2025 10:04:39 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::4:d651])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-311e47e4288sm1665714a91.43.2025.05.28.10.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 10:04:38 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  kkd@meta.com,  kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 11/11] selftests/bpf: Add tests for prog
 streams
In-Reply-To: <20250524011849.681425-12-memxor@gmail.com> (Kumar Kartikeya
	Dwivedi's message of "Fri, 23 May 2025 18:18:49 -0700")
References: <20250524011849.681425-1-memxor@gmail.com>
	<20250524011849.681425-12-memxor@gmail.com>
Date: Wed, 28 May 2025 10:04:36 -0700
Message-ID: <m2wma01xaz.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

[...]

> +struct {
> +	int prog_off;
> +	const char *errstr;
> +} stream_error_arr[] = {
> +	{
> +		offsetof(struct stream, progs.stream_cond_break),
> +		"ERROR: Timeout detected for may_goto instruction",
> +	},
> +	{
> +		offsetof(struct stream, progs.stream_deadlock),
> +		"ERROR: AA or ABBA deadlock detected",
> +	},
> +};

Wild idea: instead of hand-coding this for each test, maybe add
__bpf_stderr, __bpf_stdout annotations to test_loader.c?
With intent for them to operate like __msg.

[...]

