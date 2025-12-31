Return-Path: <bpf+bounces-77646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A658FCEC99C
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 22:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BD123007C8B
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 21:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBB230B508;
	Wed, 31 Dec 2025 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdhIHUCC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C4C12CDBE
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767217276; cv=none; b=HxGvIcsWzBgricZOCalKVpD2AK1xooC+kUSRCxQsZUedHjTreoNQIhwWMJZhIa1xcAXT9d2gD6ZmqDWBVuoejMW2YzrF5lJl3gYZepZywJlVweiriYAMA5WEIhmD+l0LsigRazooUYVagyITmUOEaNkdQVq49ZGJ86uWkA5JDzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767217276; c=relaxed/simple;
	bh=XIu4EGJn5/cjdLujH7igiV+svr4AhRNC/uNoRJb36dU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VmKD275Gu89vboHKJYgZHV3M381k3wo3P7d4PKSc0DSUCe3bRwclgQU3rnS1zJnZeaJCAJ2Vg0rkqU1lpuEnbBxlKT75YkLYDAUolHGnCBOjPrV03wodXDUh5w/NDKxAcX8Q5fUwq1W2edcmISiwF4nJrttJkw9xB0bFt9chdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdhIHUCC; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34b75fba315so12127652a91.3
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 13:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767217274; x=1767822074; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XIu4EGJn5/cjdLujH7igiV+svr4AhRNC/uNoRJb36dU=;
        b=IdhIHUCC2mZr/5e3s4wBJf8nqxTYsYvJjgGT9PMBTKpiBRNwPG3GiF0crCwCwbK7q9
         lzT5EGys3aDzqFZAGoCAm3koxyeaxj7vLjcw10MQsDpYzF3CV9kwshY7fSDf50fpPOw0
         28XksBOID6ez2XEoMaj8a4w6t6Fz3ymc3ty05BZAXRIkspglmuNAeUPnQnT/r9LG71YU
         0W/wRic/BdMCjWNSFjg1JCw69vpPq/s6x8It04M0RWYHrpv/hVcO/F1wnGaYgG9Jm37A
         hmfxXIm9+MWOSa31wyHlwcO6QBD3VDTOcERLKNisvSfojhC+JLsHTXL5JUNzCKGj36yn
         LxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767217274; x=1767822074;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIu4EGJn5/cjdLujH7igiV+svr4AhRNC/uNoRJb36dU=;
        b=dUgSaW1vxCqwEZhuarsvRmdIIxN64Cn6o35CpT7x44txbNDF2hTyjncXsasGBPgc6U
         QTHZE+3RM7b65pcZt9ndWZVr0MWy85vCKhcwvreV5Fo9N+vjvGLgLz+gSvWTEhnSy8xt
         JKD4AVzQsDDR0uPzozDLAgtVciuR1/ZLzliNH6NvTJAhtmoN0Ooxs4FObC/7gUrcOpbZ
         BJaSOAKDgOA8jFoPpLyNCIHTJ0qAJ3WDxtNjjGqu2oTGYk8aoJPVpCOhX7uxuBjpwh3g
         RfV6RTCu7Qa6INuIXLlA5bQ4YWcjP2XZAAPssgtW9vFsxRMFEja0WxNoe35COWxxDodA
         ckYg==
X-Forwarded-Encrypted: i=1; AJvYcCXr9YW/lxsCbbNJ5o0Be2Rx/ftPq1y5FGVDgX/emfSWcJueTQGzfTCmTVk+1Nn4Ib3bXhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3bdEWDMmB5pZWJZuZOqHILxJWgGB/k1TDvP7BVBhVYqkSm8xx
	zWsTKjIfnrBZczNLdMqUpUBi5RX5uTcq7rYiQNiS+ftI0Ri5etG8GgxZ
X-Gm-Gg: AY/fxX50DBOAB3+0OEtLSKYH2dFpu63n2xUQBLRRZPW7+OUwzzMgp4KTOj1S8mgocN9
	o20VFjdevlQGNXDmZhD67vbXc42+hbpXcXvPuPDRiCeac/h4DAiMlVgV8oNs0ff2YDHLZXQtpbZ
	hnNuVcDjd4ZigEN/acbE55ksAgAzEmKdlJ6P1Lt1Q4On7vLLl5X/2MSUMtHc08QvdnDaS6aaluG
	gJi/9nUGZBuu4HfUf/vW4PLF2YpoFVkIRCXGffIUNgd0DRcMY03BFkH1L3bpgcHxvujsvfk/wNr
	JoO5LH/+7Xo0bAEBdhPao8n5uCXtlPT1PN4DlpQ/KpXvOJRuhRTq1Vm7QlQPtMS/FXtKJwDnS0a
	ixAlJhHQgJT8/nYw+lKHc3z2/gNmnO21uvwwsjsv06tHuQRmwIm+I47dt7DsV1OGzFX9tYM1JC9
	T2IP3vgH/n
X-Google-Smtp-Source: AGHT+IFkf/j1O4DXbsozkAFcnxIz+vJVbBzemNhCQT8mB/o5fKx1K8KQJ5GSPrICMikmRwXuY7kvLA==
X-Received: by 2002:a17:90b:582f:b0:340:c4dc:4b8b with SMTP id 98e67ed59e1d1-34e92142aa0mr27204635a91.10.1767217274032;
        Wed, 31 Dec 2025 13:41:14 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e921b165bsm33093086a91.6.2025.12.31.13.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 13:41:13 -0800 (PST)
Message-ID: <9f23c1d865b99ed379b7b3237332554d760921c1.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: veristat: fix printing order in
 output_stats()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, 	kernel-team@meta.com
Date: Wed, 31 Dec 2025 13:41:11 -0800
In-Reply-To: <20251231195207.2801487-1-puranjay@kernel.org>
References: <20251231195207.2801487-1-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-31 at 11:52 -0800, Puranjay Mohan wrote:
> The order of the variables in the printf() doesn't match the text and
> therefore verfistat prints something like this:
>=20
> Done. Processed 24 files, 0 programs. Skipped 62 files, 0 programs.
>=20
> When it should print:
>=20
> Done. Processed 24 files, 62 programs. Skipped 0 files, 0 programs.
>=20
> Fix the order of variables in the printf() call.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

