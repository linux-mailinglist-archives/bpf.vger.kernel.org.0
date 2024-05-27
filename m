Return-Path: <bpf+bounces-30685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 966508D08F6
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 18:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68661C21C31
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 16:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A41A15A857;
	Mon, 27 May 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFD/E+Y5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6611E4BF
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716828772; cv=none; b=n5O47RyBeAYB6UnSSOgbbWuzSQlR2m+2I65zfAD99qxM+ajAHMlFHHVjyfFL6d+/rwq93fRtS/KSqVdII8B5uqyCfu3ysKLodwSiYa8y0fmpW/Re/DoEMFMgcy2qJEUcPIvJNWaYnIApKNVvSnndOvfyENmTw5ds8a5mUOV1TUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716828772; c=relaxed/simple;
	bh=Xfzhprpn2/1jvN2HF4Wdn147/vP2my6gAEX6tVH1H+0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Q3YEYoqfM5xXrJwTB3T0LHGCiE/dFm7GNtGeu6W+GTv2PSONeM3GPSr3dufFo/Ds1Ts4s4b3t1PFGz/1u3mYnvDfcWie5jI0+VCL9WJv6J8Nr9Q4nkpnuCJ2st+DAboqXM2Gqyn/TNbaG4quXqOxk6lVc0Qw8bSLRx2uC2zfbBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFD/E+Y5; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2bdf11888a5so3222254a91.0
        for <bpf@vger.kernel.org>; Mon, 27 May 2024 09:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716828771; x=1717433571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLQpnwYPCA8D152wyrglyZUyUZVXkAPry0kezXYUSqE=;
        b=LFD/E+Y5WXYno2lQUuy3rO14qua9GrPFyddTPubt5j8TtTlq8Vh+AIYwUz56SVwYIO
         aNJi1ofSLvfPwcEJOTWiZSTxggiL4K83kD+JBbUB140/tnzwhx93xro1cErrkSlrYUGB
         n8wAlOF4Pa1jjvAfqNgrGAPHqnVLU26hRbnmEv/WHiTyQIpHTmdeCsclyQvnqWyaMM+1
         xszNVwk+t3ELrX9nEV69VHfXslxdDvhmZ7+FG2NUAGfo32mJObaBpGE8PXeRGi+Xsvny
         OXY6fjJyVf6tF+Ja7Xt23i45lek9YwRZow09iSgo7AElYbt2nN0XHVe1PHrbs9tbPLFR
         1UGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716828771; x=1717433571;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wLQpnwYPCA8D152wyrglyZUyUZVXkAPry0kezXYUSqE=;
        b=qDBFyqWJ6Z4A/X3ogZ9RT3Eb6KwXVnQNUItje0q9Nzm0mb2Q1cZjhXIfGXV8op8f84
         lUB3ipf98TWsAWnTBLOTcCbU2NH/bZq7m/rlCY161RbytyJioIO0nR4Y3JiUW99iPWBw
         l2AF2XFqPNC9pqbEyyQE1+6p49imSg+iSEPmQm5KvpUKQvH9LNhUCftVbgxKZh7aUoOM
         NUheBnCOwns8PN1MzGb9fGnj9SZnwdWg6fX0mEIlDu4ZYTPUQuNpQ5vsk/+97R5dJcFq
         AZVCiksBAe0B0j721NoGklTtItpMVl6mUlE+yFjLlZ56fgr5H0E+ite+uGCSqaw3EWJb
         UyXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNOh0qnwbtu7kwFyfIA+VPmcB2Y5Mnq6tIs6FNl4+UROS3GvVK0VC08QW0mDepGGMEdohJC9UseqoQfcdmmevufsWO
X-Gm-Message-State: AOJu0Yw7VKBVRoqAMwRc3vV1CVLP+m0atXRdviy5ErLfRFs3EQeNTfIS
	8oQTibUTpmfZzAZre99AnOUC68TDciYEZfnY7gif9oS04p54N6wN
X-Google-Smtp-Source: AGHT+IFe7YRk7eLXz8A7nNEehy5DXv1XLOtpsRUdizQc3V6NMtOAOTctznzHyqtVW/O9h5kcdA4wbw==
X-Received: by 2002:a17:90a:d184:b0:2b6:228a:3d83 with SMTP id 98e67ed59e1d1-2bf5f20809emr8692525a91.39.1716828770752;
        Mon, 27 May 2024 09:52:50 -0700 (PDT)
Received: from localhost ([98.97.41.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f50d2a0sm6043111a91.22.2024.05.27.09.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 09:52:50 -0700 (PDT)
Date: Mon, 27 May 2024 09:52:49 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Hillf Danton <hdanton@sina.com>, 
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
 kernel-team@cloudflare.com
Message-ID: <6654ba618009f_1c76208cc@john.notmuch>
In-Reply-To: <20240527-sockmap-verify-deletes-v1-3-944b372f2101@cloudflare.com>
References: <20240527-sockmap-verify-deletes-v1-0-944b372f2101@cloudflare.com>
 <20240527-sockmap-verify-deletes-v1-3-944b372f2101@cloudflare.com>
Subject: RE: [PATCH bpf 3/3] selftests/bpf: Cover verifier checks for mutating
 sockmap/sockhash
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> Verifier enforces that only certain program types can mutate sock{map,hash}
> maps, that is update it or delete from it. Add test coverage for these
> checks so we don't regress.
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Acked-by: John Fastabend <john.fastabend@gmail.com>

