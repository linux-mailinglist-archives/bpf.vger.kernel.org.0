Return-Path: <bpf+bounces-57896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5765AB1B7B
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 19:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC419A283C3
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 17:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DA923958D;
	Fri,  9 May 2025 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmW/81oi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA2D22F766
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746811174; cv=none; b=ug8s7ANZMflFA/HknXOPhRIafj+5zoknFFUAPb0cOW0K6TXZA0W7c9qDrvG2VGP/sjc4eKbaHAupis9wOnwoy6c+kt4Gk7nz2Q4lJ6PC6Dp08RnOeSd487REzEQlC4SEeoCw51d1ZOsjkecRnRX0KfRBIByydt05FGEca8M8hFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746811174; c=relaxed/simple;
	bh=iUbaIi378xcleOYGGPtZQMhB2nakXPsi1FswXZwvpD4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HykDIDTs4GDgqIAp/3hmqEaAS0GqyM6D80Aq31McaBWyIRaZ+cvDJBwJOQPcuKF2AuPRMQaN+yBASXkGwAXi2w1IOg4jvqBLtB0Nm+lJpH1rtyvweiTPacQpAOkNxPKrXUuYpVORMdpW2Hf5QNShWm2YoAZIhcrmm6bX5yTcIyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmW/81oi; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30aa8a259e0so2382719a91.1
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 10:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746811172; x=1747415972; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iUbaIi378xcleOYGGPtZQMhB2nakXPsi1FswXZwvpD4=;
        b=DmW/81oiUu8PQWOArpUgfeawhbntHT5OvEK82ZFJnezv1hKGVIGSwnN5U4NEPvD3A+
         tDs/0wYH/FLj+tD1uy4867kEQMn6bw78ioDQdxz1S3H/UJWHcaYJ8eE6C1zKcFr4fJkD
         hJ3+ukytB30wUzcT+iuSCZk4w62hrWqMRCbwr9CseMoA9xpMFUXkvVuETadRjyypRtfM
         aDvV5p3Vcap67t4Vt01yd5f8pzZfc9WFG7lwaQeMhVb5ehY7rh+KVSM7s9gGGDXc722S
         WjtR4w2vN/senbEUUzgMflVNvnMAcSIoUfs/EIXnfOlz4isqsNlRgFn7RgamKXQngW26
         9i4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746811172; x=1747415972;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iUbaIi378xcleOYGGPtZQMhB2nakXPsi1FswXZwvpD4=;
        b=aNHLeSHPZzW1vQLb32/XA5dZSc8sdoKo74gDMH6YauJ5z96v3xBRqUnNEIyrItClyd
         ZOJdVHDzIXZOpft/Ix9DO6ukgVuVS5Jtj6gTtvFGll8m9WhpaErZv1bw8OnJKAxSzIR9
         Jo6FLehLGOmzufo9qeOB6rsOWbtlcGjxVVBbhA92+xm+jOPo8CeyD7+s6I+RvJPPbrtU
         b1ZM1V96XtMfUPTLZ/Bi9KZerc2htilq6ATJIgAS7tTBQMASGub2tCU0qX2EjmFgCoip
         tumeojnogel38ZEYLZ4fQlxdpoAGmxEXIUeufRu/cISeEiFrBaqj+J8badPxXA1Uykem
         PFnw==
X-Forwarded-Encrypted: i=1; AJvYcCUhURxpPBmYmM7O58kl+16opevRDaGeCS/w3Yevds8HJBC2m93s3fWrt00nayhB/RAXGmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Lfi/DX5HCAUIlZtMT/vSSfQe/hFsc2ssU54Q/ami9mPfmVsx
	FilE5owbKwpn+RUGjghdMqXdcS5kQcN3UzI6dnWiqA1QEzcLvSxL
X-Gm-Gg: ASbGnct7FWFZ3imOwFrli+zb9XlrR5P2hgtxw2gae9pIjIhpfvoyMhhCQM1jjVGzpCV
	6aWVM6i2QDn3is7bumS3XM9ZtmY+9IdnIw/x6WFJsqriYpnPcajHEA0x4IsSegbJdrb51ojuHE6
	GPwG8wa84TkBuj0pE9i/FDlDWRtmKe4TSkKyHtpO3aNbsxojvvLQjKl9d9QlHE/fpeO4qvs4UFF
	CVNh9VeZsuyk7XRsVC7pQYdi8+SVOdtMGrrpwfbwDUrA7K5wlJsb6MI1EbtJZLhdrL1btvyxYcS
	WIrAhJIr91AcNzaWbFmEf1c3SHG1ZMlJCqkg
X-Google-Smtp-Source: AGHT+IEdx+S+YTiJ+EnsR4ICKxq13vIetAVS3xyuFI3NjzkSe4H76EAXi9lvasjUQpLBpklpon3tvg==
X-Received: by 2002:a17:90a:d2ce:b0:2ee:e113:815d with SMTP id 98e67ed59e1d1-30c3ce034f7mr6811980a91.8.1746811171869;
        Fri, 09 May 2025 10:19:31 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39deb39fsm2073918a91.22.2025.05.09.10.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 10:19:31 -0700 (PDT)
Message-ID: <3e62e76ece28b69a2934b239ddc3c1abc4f8c88b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 01/11] bpf: Introduce
 bpf_dynptr_from_mem_slice
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Emil Tsalapatis	 <emil@etsalapatis.com>,
 Barret Rhoden <brho@google.com>, Matt Bobrowski	
 <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
Date: Fri, 09 May 2025 10:19:29 -0700
In-Reply-To: <20250507171720.1958296-2-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
	 <20250507171720.1958296-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-07 at 10:17 -0700, Kumar Kartikeya Dwivedi wrote:
> Add a new bpf_dynptr_from_mem_slice kfunc to create a dynptr from a
> PTR_TO_BTF_ID exposing a variable-length slice of memory, represented by
> the new bpf_mem_slice type. This slice is read-only, for a read-write
> slice we can expose a distinct type in the future.
>=20
> Since this is the first kfunc with potential local dynptr
> initialization, add it to the if-else list in check_kfunc_call.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


