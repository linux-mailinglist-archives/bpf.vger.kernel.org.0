Return-Path: <bpf+bounces-49681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3AAA1BAD9
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 17:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057423A623C
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFDC1A8F61;
	Fri, 24 Jan 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZseZAzfM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D2F1459E0;
	Fri, 24 Jan 2025 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737196; cv=none; b=QifmcxEugr3Or8n6A4qoucq7uP3bvXduEobxiyh8UL5kzyoencoyTQDnhBClqrtKsXHrdT77XkYofJ6y8dQZDTIm8C80u63b4DGK0rsreLhe8kox/yWilGNHZemDgQtIgOZrG8cXj1D2wxMfX+WnlcZ3n0nICuWtMiQJr/p7hKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737196; c=relaxed/simple;
	bh=3P+9aTiLaHox8mL2ZK+WSxeM0kY5helZLnTFCzt45dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVwkWXHrCCatpzdNEnE0m8knOQizxfLclvAPr5KDviUHDmGGoRdGvyGCd/8RULJvWt9T0i62KAwhyCx96859OnP5cCduWTC82Ldw9z3XtfyMz/93e9JhcW3XHjrVkJ0zJt+1Asoo4lKxf3peOWx063Md1JRz/spFlIjYhibCwjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZseZAzfM; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf60d85238so403607266b.0;
        Fri, 24 Jan 2025 08:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737737193; x=1738341993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3P+9aTiLaHox8mL2ZK+WSxeM0kY5helZLnTFCzt45dc=;
        b=ZseZAzfMABao2yI1/Df7T+OQgrhqV0FBYt4HPa04UO4vBgaQqM3q16korfrKUs/fke
         6vzw8rS3dHd3mCpMPQ5MJ/6S9mb29JMY9XcEz3FmYuSUYD18vNRJNEK3si1ODtkhXtwg
         xn6Pui7uEypaEFHYmPFOgsaWDtIGHh6JaJ3Ir3qBK4MTfZ4w2+NxTKRzvw8DgT5owbo6
         ixtLN2s29Lidt98u9Rw0ZN+oiC30Kq9Yr5KUh1w9ACrKzC7qyoAh73z+EEjdjH8eSu+H
         fCEpFNzUVQI70EyR24oyhpkJZCNHz5pn7v6RJoLn/KFUTxtbb6SwDVA1yeJ4S3AJvCrl
         UGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737737193; x=1738341993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3P+9aTiLaHox8mL2ZK+WSxeM0kY5helZLnTFCzt45dc=;
        b=BmLYerkVUg1Z4UUmCbplxmrpPq0xR7Qy9rOMa1BD7MSHOd994pmCrcbx9qOJcsei0K
         dvKdyDXHa5CuRiJ8CvB/cOo2aIP2BaxgUkpyue6XpiJVRPb47oZwdXBzSp8TIg/8oyw6
         506DIUB4BDVQNgxT6ee/7y0BuPcxnL60yw9ft+19YJGafFGl2b6AJGQj3CqtVpZ208Kk
         P6kXdujJ0O/s7CaKedb1cQylh1C9GQCmTxibO4z720tj+1f1/cl1uuSET6+j4y5QdOih
         HDBRolaHPryVlaHHWsmbZh0efXLbuYJva3EyL0rbTiOMZFYqQEKqOLPK0wnI0EcTAs4z
         JwEw==
X-Forwarded-Encrypted: i=1; AJvYcCUmqn6XIhsJrQUAjd3ORg1x7VXyfTVM2TkaHrGyZkXxbrBjtm2Phh1QuQFwF3WfyowWtnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLKhm2g+9/+ZaHdP1T9oh/MTZ6aGVjRNy3L+rVVhiAvQVUk7V
	1HH8J69JnWAxJTi1drt0zYMvPzvQXtgY+ylPmTPpAYZYL7fu4qlUuSbZXI8PYjSmSsSZwloWT6+
	iTFb6sI2LClWVEFp2bkK9YlQswNs=
X-Gm-Gg: ASbGncvVL4VE1uLMHD4y9LXTfS1+KXI4J2Lz4vfe/ns8B2Ryzt5VbovJ4LsI1B0vkNn
	S3ViQWzBBZJUosPawA5nWrPRtUC1D+ajagjwMDWToIfuWdP4frjTL1ImugQOt9oe6WBAYWgs6Mx
	U=
X-Google-Smtp-Source: AGHT+IGMNi7U+c3YgeTKPqKmkN12vA7tjq7ur6vHq+zBUJB5GBN9ofCptg5c4QoAbKBPKmEwrFGHUESzlJTCsnJlf3Y=
X-Received: by 2002:a17:907:2ce5:b0:aab:cce0:f8b4 with SMTP id
 a640c23a62f3a-ab38b4c6b05mr3017971166b.52.1737737193217; Fri, 24 Jan 2025
 08:46:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124090211.110328-1-sankararaman.jayaraman@broadcom.com>
In-Reply-To: <20250124090211.110328-1-sankararaman.jayaraman@broadcom.com>
From: William Tu <u9012063@gmail.com>
Date: Fri, 24 Jan 2025 08:45:56 -0800
X-Gm-Features: AWEUYZkH6xFaPaEOJR0ohihd2I5L7RV1uXP71LkRO-Lq8_VRerVgOElw7fHJ1H4
Message-ID: <CALDO+SbGYqG6jskUhp-dzxTPa2Mf5ge794Z_L0AC8MLxoKXMnA@mail.gmail.com>
Subject: Re: [PATCH net] vmxnet3: Fix tx queue race condition with XDP
To: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
Cc: netdev@vger.kernel.org, ronak.doshi@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	ast@kernel.org, alexandr.lobakin@intel.com, alexanderduyck@fb.com, 
	bpf@vger.kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 1:00=E2=80=AFAM Sankararaman Jayaraman
<sankararaman.jayaraman@broadcom.com> wrote:
>
> If XDP traffic runs on a CPU which is greater than or equal to
> the number of the Tx queues of the NIC, then vmxnet3_xdp_get_tq()
> always picks up queue 0 for transmission as it uses reciprocal scale
> instead of simple modulo operation.
>
> vmxnet3_xdp_xmit() and vmxnet3_xdp_xmit_frame() use the above
> returned queue without any locking which can lead to race conditions
> when multiple XDP xmits run in parallel on different CPU's.
>
> This patch uses a simple module scheme when the current CPU equals or
> exceeds the number of Tx queues on the NIC. It also adds locking in
> vmxnet3_xdp_xmit() and vmxnet3_xdp_xmit_frame() functions.
>
> Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
> Signed-off-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.co=
m>
> Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
> ---

LGTM
Acked-by: William Tu <u9012063@gmail.com>

