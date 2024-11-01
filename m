Return-Path: <bpf+bounces-43739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0649B93EB
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 16:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7061C20D0D
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0215D1A7AE3;
	Fri,  1 Nov 2024 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gykLoDI2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E172513B7A1
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473432; cv=none; b=pb9fUU20JKtXsHxIAWxldTwMUS/NQ0Kt+6HJaotq7192ZeeBO0AgfLUz6O7CEg6cSwyMKm4Z2b63RIxzMNyFpUH3cUsju0RO7gAqf/E4Sa+Vn0cot32OiquR1/BT/gN9Oos9MXsksUajZPePSk6BA/7ANzuOv8Rcn/+mZiWkfBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473432; c=relaxed/simple;
	bh=YX5sq6ZheiFtKApdJRRA0qJIqMgD+DQBat0h/g373yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jg+ZxtArpOPepJTmGH1QtQ5X/K/vAiKuaHdPLkG5ccwV16cEz4lVfQOTHEKEr4HN82z37qCzglsfKFCMTvneEyNanLEsheX1pfLDB1OSwm53xOcj2QKLIn4y88OtC6UmFv78z7ir87J7WFNpSuVrpb/Fay9XpPmfBhViwaLNVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gykLoDI2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c87b0332cso114895ad.1
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730473430; x=1731078230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YX5sq6ZheiFtKApdJRRA0qJIqMgD+DQBat0h/g373yk=;
        b=gykLoDI2DuEq5oSSJLE5frs0TT1DzrL9IFrqPAniiyuSw+ZykdIBnw/UHL4dx/GbrE
         hRE2UznsEjvBJ6SIEOyPdmy5xo+1hLNbMHmwLDmWxRjzIiKFhzy8IAeS79c2OoO05oC2
         fYm0ASM1GRpefBFIQHh0pQ0GWq8pLI6XHI26/1AQ44vT/auSOyz3Sz/DZwKgRGqB3Y5l
         08Ux/kwLyrE0DOcMHM3uf5yAi8SLl191LCURJs5Ndz4Y/yDKL+s6XSFjYi+9LePztRxL
         PA1zDeez8146vRU8UJBZ2B7C0U8HpZsF+BzIvnF3bHNdo0Ko2hadbXvpsZPoQXybjuZX
         8d4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730473430; x=1731078230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YX5sq6ZheiFtKApdJRRA0qJIqMgD+DQBat0h/g373yk=;
        b=cWpuEB6n0EBRzNpFztQQsW1tKOuoUW6KppPJ17IDAYO7gKayb+H7bsmEWDiHjg+FHA
         Duk0Nvh7cS3vI4aOlCJllCXDMrNNbINjUalN360kT5fyDi7Rb0FreV1XsG6qyKJSdJuq
         mnCwj3pqlQUcmHDS0XenZWTH1Kt9RcRfnZ0fqledJ5Kyp17WgbBP46m/YxJp55/kWihw
         yUxvirONXTh5j/E9rtyoad0Y1MyKoUEP5R15WViizguWgJgjogX5ItTmeE/J1ljWHSNR
         XbVNPp6ArMTwrsy3LMuOQLFFJ8IgMMpo8GItkR1EsQE9gMzo6adShZmjdDC9qav9dZ3f
         qSLg==
X-Forwarded-Encrypted: i=1; AJvYcCUJetS8OUIrjTk1DmdogqLnN/snV+NzbgQukXpKb78mbIo5f4WUvCj4xnwfCbs3S2qQXZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaSHEKzWrVMpY+B3c8wW00T6/gmKyckrwUWsuy96+dqwSPWULl
	/lnk689xojv0PZrntH9A5jXhsZm2fTWIcwZJhi8BQeligIkXHtcO9tQCJV3rqbq3SHpSSKbJq9C
	H11ROepKf1XrjlbpsZMZEf/haU1i/6FmE7tic
X-Gm-Gg: ASbGncs31uriKpDNH1J43/7u14bxCKmHjHicW4NwoW78E80EA2kl++1+14PHF6tfHAf
	hvQoOK7kNuCTOQVIW1Be5gLnQBWpLsZw=
X-Google-Smtp-Source: AGHT+IHO6aa1H4NDIW0E9d+zicp8WZuquwRCLAb+vHiEevpZxqwYPVoVFHQYByqn3yh/phUy4h+4QI3F3VXJog6wc7c=
X-Received: by 2002:a17:902:f684:b0:1f7:34e4:ebc1 with SMTP id
 d9443c01a7336-21105425eddmr4269565ad.5.1730473429797; Fri, 01 Nov 2024
 08:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031210938.1696639-1-andrii@kernel.org> <20241031210938.1696639-3-andrii@kernel.org>
In-Reply-To: <20241031210938.1696639-3-andrii@kernel.org>
From: Jordan Rife <jrife@google.com>
Date: Fri, 1 Nov 2024 08:03:38 -0700
Message-ID: <CADKFtnSvogoT0ArYUqUFaBVUoQN4tfX6i_OdHNc4h2kaYvpZcQ@mail.gmail.com>
Subject: Re: [PATCH trace/for-next 3/3] bpf: ensure RCU Tasks Trace GP for
 sleepable raw tracepoint BPF links
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	rostedt@goodmis.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, mhiramat@kernel.org, peterz@infradead.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"

Just to confirm, I ran the reproducer from [1] after combining this
series with Mathieu's from [2] and it ran for 20m with no issues.

[1]: https://lore.kernel.org/bpf/67121037.050a0220.10f4f4.000f.GAE@google.com/
[2]: https://lore.kernel.org/bpf/20241031152056.744137-1-mathieu.desnoyers@efficios.com/T/#u

Tested-by: Jordan Rife <jrife@google.com>

