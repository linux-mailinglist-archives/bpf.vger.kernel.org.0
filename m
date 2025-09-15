Return-Path: <bpf+bounces-68441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CA3B586DA
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 23:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1BB20586E
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 21:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984C62773C7;
	Mon, 15 Sep 2025 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixwKfUzN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9E1215F42
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757972427; cv=none; b=hdkB1LqHhTWgR9BPN2xf9h4e7O36Af7UGM1jKzRc9v9ERlVV+p0yFEljJ++A0Cl4F9ADXmPxlykQyu0nA/XdF3+siH48new71B3TGKzD3VvM3oqadjZHCTWmPD5yeSDVO5O3Crt+rZceaL715rzt3INHk9TMkFwwHDiLd/3qJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757972427; c=relaxed/simple;
	bh=Ho7Xx3k3eWS6YpiY6jqyslliyIycI0IusxxS5g85+6w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sr/ApdYcbrNemJYMT7gvl3jA4P/Ox1cElveNvuI+pMBV1xCXFFufp227qYoFEFIj+ugzy8ftkNmIyemn0KzNicmrNn0RVBvRmuEGWF8BCF0WN+eHeyvq/4LrTxgFcAb1JpumAvIEkBiweXCMRmIByMEfvweDHxriL772pds4Z+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixwKfUzN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32e83953989so980346a91.1
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 14:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757972424; x=1758577224; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ho7Xx3k3eWS6YpiY6jqyslliyIycI0IusxxS5g85+6w=;
        b=ixwKfUzNI859v1tALbdeDh234c7/A52RfdDq7QCHVwyZMwvqm5K8MzEirT6LdKcZLT
         BbRgjxaYMI2cnMMbE3vL38QdQsniuVwIh+qLmxDjV/v5Jm1mUy7qgaer/WV3rrT+ZkJF
         AAbxhnOAZwqjkEmaPwmRBZh1DgE9M17go6lvbOC/U+Oix4QTFhnDjussbWTcmiaMajRt
         WxxZDYxn0WYQl3kwJZ2JVnG15FO4EdaEwVJUKqYWb5hdlHUxvnP2hIwIkrJpOQPthMj+
         Ty36nutxwERWzyfocInRZZernOpgRIyz6cSpmnhm4IKW30k7tTSmA1GRs9qDagTcwQRB
         s90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757972424; x=1758577224;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ho7Xx3k3eWS6YpiY6jqyslliyIycI0IusxxS5g85+6w=;
        b=p+PhqeAQpGc1Sm+RS0gKXmtQ7gUMP1mFZW0MpDzfEyBj9UP7E0qz0TbzuBJnxbozAP
         WWgp/xetkBG7LRWHw5zkZC71baDCkM7wQR0UFM0MNKVtbCP7cx0gXRdTT0N+IjyyCKBP
         XQ1ioJLccPKuNvwqLslFRwHzJGWHNdGQGlSrkDTdWKx+zKB/xinG9yTO3uLpINuqGbF+
         szS3wSfCgu2e0EwTRTgGFJAfqiOPhqG1/AUdL76R8ByN5iQmBc9oRzznA9cC8PtNcjqp
         bKz+IDBiBwpIbbH4hVzwqrJUEhhBLoPkzTWIAalNy/oB7rhmuUTVbb5OSuGwu2CSP44b
         JMqg==
X-Forwarded-Encrypted: i=1; AJvYcCXquWhAs2T98ZO+PdSPgmyFQtlBEa+DtD33nbTiY/YIOjggcg0DcQNLXiqs+FAl3t5Nch8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVgA/Fo94hI3pMo2GrqhcYmlJ9COqvNupKIQajbI7H8NEi8DbG
	hPPz9AWXSvqBcI73baXvFDzGOEhBdZMHE6CV8Ib4VQe5/pFND1UYwvM7
X-Gm-Gg: ASbGncsPA5uEqItBD5WKtuqiP4G02aUAeLE3LwB/uZ0Lnq/WLnGbfnVgqaFHqWaZ1cZ
	8vxanmWQXHOJ6rjUu78nYNdkGGbpite1Ra4Vfrai4gDKo1wYUbsImBbCO6UieLlAjTZTBJq3CYh
	UbKmrUWvtMH1PZglxQ43g4AX2tmRoDTAJZxbuA6Pbs9rbtib1BSgHVQPIjEbnH8PNEMKKTzCubK
	9Uq/NoQacYODZzsL7aITxV5AHy5Q3Xur1zkVhYGxqDVST4fRey5C+EytZ+MVFOHDOapc9qpFczo
	omDat0ZMQ6lKKFFcHofBnpT9kq14gPtl7qDFXDIHfnk2QEpxfXOpY62FAqQrPRMdXSDA8FM//Zd
	uKILImeEmeb3vSJuSkvuxnIgO3evXM4wDorT7VZCk66rSgFzO
X-Google-Smtp-Source: AGHT+IGkh5q4p5XV/pPWJZw/QTmoFZCv3rRH7ImSgJXDOWuUWvS/ZJLw9hi65GFS5vcROeIxAG3b4g==
X-Received: by 2002:a17:90b:1d0d:b0:32d:f4cb:7486 with SMTP id 98e67ed59e1d1-32df4cb757cmr14438413a91.19.1757972424424;
        Mon, 15 Sep 2025 14:40:24 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1da5:13e3:3878:69c5? ([2620:10d:c090:500::4:283f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32e4e8ece73sm4727918a91.24.2025.09.15.14.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 14:40:24 -0700 (PDT)
Message-ID: <9166a04be9775e082ee40833b9f66cd8e4a63700.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 5/8] bpf: bpf task work plumbing
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 15 Sep 2025 14:40:22 -0700
In-Reply-To: <20250915201820.248977-6-mykyta.yatsenko5@gmail.com>
References: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
	 <20250915201820.248977-6-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-15 at 21:18 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> This patch adds necessary plumbing in verifier, syscall and maps to
> support handling new kfunc bpf_task_work_schedule and kernel structure
> bpf_task_work. The idea is similar to how we already handle bpf_wq and
> bpf_timer.
> verifier changes validate calls to bpf_task_work_schedule to make sure
> it is safe and expected invariants hold.
> btf part is required to detect bpf_task_work structure inside map value
> and store its offset, which will be used in the next patch to calculate
> key and value addresses.
> arraymap and hashtab changes are needed to handle freeing of the
> bpf_task_work: run code needed to deinitialize it, for example cancel
> task_work callback if possible.
> The use of bpf_task_work and proper implementation for kfuncs are
> introduced in the next patch.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

