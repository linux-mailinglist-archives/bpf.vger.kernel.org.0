Return-Path: <bpf+bounces-47052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C712C9F37BF
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 18:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E4116756B
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 17:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B182063C4;
	Mon, 16 Dec 2024 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="U979UuqD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265A320457E
	for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371148; cv=none; b=rFo3i+62++ewx+xBgwpMuioSt6bMSdWUhxh2XmoScl5QrxtpzbLqpHwbUw50uulPcX8KTpAN/rwg63NQtRn8JTa+pPiYGIlUp1PD1Pe6gODJ9AN+RvkZjmJKfuqOzqgQhqAyQ2hWchyY5tYeaZSDuV+yhOuq1QyQLM+iOtNgCf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371148; c=relaxed/simple;
	bh=rOf2IbPgTj0PAVy4isIXX/3/zOijpIime8/4MxMy4w0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ScwKzEyLhWIQZTHbbNrcMeiHxs+9/HFhL2htB6qf3nhunFs/e8b20JnIS2Rlk3LuOTfvN6H1vDpPSFA+mKMKDlooKFsY0F6MoS31DOx4FH6Eo0h28odlFAya6Ov7vmrqamqwJJwR73m/O1nXFpfiDFLgj53vGC0m2El49VueHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=U979UuqD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385de9f789cso3535344f8f.2
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 09:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1734371145; x=1734975945; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOf2IbPgTj0PAVy4isIXX/3/zOijpIime8/4MxMy4w0=;
        b=U979UuqD+zHOKsRqIvbjkfnEyWr9pk5hjoL2eZXjp+lrpxgidbqwholEvIdrjwa2FG
         92D8pvEhFhEnyrItsof0fS1GbX0X2oN9dGVvYvqLin6fh+nPRClLl27d0epR5U0B4cFD
         1jks8z5MigNkZw22lhaYAaESfm/pTLk0Cj88xBthsxRCpHnncu7btdCb5jkfw9p5pw7w
         AKmL+rsbmuSTecAUq7AMQorntG3/fH/B76ATulPynoCY42MPNiE88TMk8gslcUsaSrkx
         pQ/6a5i+fz/KinzMhviTv/+I/7U+YsELBXZ+0YCT7thtqV0NDLWylasYfhZcewuqXG51
         l+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371145; x=1734975945;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rOf2IbPgTj0PAVy4isIXX/3/zOijpIime8/4MxMy4w0=;
        b=VjLEHWsNsx6V/XCKgxzTv/oUYjbVjIuV4xNyaSjLARz/Uw8hI9a/hK36w0Kf8AbwIs
         E3B9xOG2yiYqpt/7l2wR7UyUAnu55oDkkoJX3VjkkduLcULc0/vdg6uIiduoqWYivlvR
         JAn/7wJTpbZAAlfOUTcl6ljd+Zj8rCeM3w+DfgqbcPger5sscjKNEH1WZWE+Im2oe6Vm
         xtXQIpjlEXZFdL+bhmusTtNOlhxVOTcnBduszhQiDtDcDJ7FQUdjr5bHlu9cCkMNZvOY
         DJWmhL+xOjcfbJGhIV65HHRBSiN7DtdNWziUtQ/ER5qhxJEiaf3E+/O/fQapBZCOCeUp
         UmQg==
X-Forwarded-Encrypted: i=1; AJvYcCVS0EMECn4GGWz1QAmePF5ukGbOe5gcDyS8MYnPHQjadSL1zB0zs8sKoB58/FSvuLvR/ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YywVp2H7r/NkXEqz/Zbho9wIGnDKpn5gWjubRRxupOalHV0E2O+
	jGQZrbnbJjC6gTDe/kog+lb/FyJu2oF1k4wXQ247w+xz0de5X/d0rvceomj/Rec=
X-Gm-Gg: ASbGncs6FH2R6Ls5MbVGDV02Rlh3kt2IOkNk2JLV+4kAUFJglC9FCuNQ/wkiI0UCbGR
	SfD8MRuUSWJEn+OfZCQaV4zuPuXgzeDImxPcJvWenNVG2UN5HwWHpmL9+prFyhQ9B/+vLbWN/yY
	HroyE6DMWHbJ9fdwjPV4OTX7LKJTZJGtsLb5hR7h1B7KlxlC6E9KfsMxf8GnDXVvTwIstvzLGKV
	swmRscgfUisnJOrkLIsmls+96L2cYAakXAHQ4ZXog==
X-Google-Smtp-Source: AGHT+IGDG0QcaKITdChobqcvbhYLyrZsXCZa5c0xLgfbsMlIStQcxWTmwQpw929wW+vt0qo6rV6T/w==
X-Received: by 2002:a5d:598c:0:b0:385:ea11:dd92 with SMTP id ffacd0b85a97d-3888dcd4659mr11749005f8f.15.1734371145470;
        Mon, 16 Dec 2024 09:45:45 -0800 (PST)
Received: from localhost ([2a09:bac1:27c0:58::3b6:40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706caesm146383045e9.32.2024.12.16.09.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 09:45:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Dec 2024 18:45:42 +0100
Message-Id: <D6DB9BMTYRIY.2GQMKAM0R1RPN@bobby>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf v2 0/2] Don't trust r0 bounds after BPF to BPF calls
 with abnormal returns
From: "Arthur Fabre" <afabre@cloudflare.com>
To: "Arthur Fabre" <afabre@cloudflare.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.8.2
References: <20241213212717.1830565-1-afabre@cloudflare.com>
In-Reply-To: <20241213212717.1830565-1-afabre@cloudflare.com>

On Fri Dec 13, 2024 at 10:27 PM CET, Arthur Fabre wrote:
> A BPF function can return before its exit instruction: LD_ABS, LD_IND,
> and tail_call() can all cause it to return prematurely.
>
> When such a function is called by another BPF function, the verifier
> doesn't take this into account when calculating the bounds of r0 in the
> caller after the callee returns.

I've just realized r0 isn't he only problem: a caller can pass a
reference to its stack to a callee, and the verifier also tracks the
value of this.

If the callee writes to the caller's stack after the abnormal return
(tail_call, ld_abs), the verifier will also incorrectly assume the=20
write always happens.

I think we need to treat these abnormal returns as a branch that can
exit. That way the verifier will explore both possibilities, and the
combined result will really reflect what can happen.
I'll try that out for a v3.

