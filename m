Return-Path: <bpf+bounces-31749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 178D3902A93
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 23:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A5D282DDA
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 21:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C206BB33;
	Mon, 10 Jun 2024 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/T/MhE0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB3F1B7FD
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718054891; cv=none; b=E3yy0AGDQFIwUeC86m27Utj2VgwTOQoUnYW5BSCHIj9A7GEWoKJRD25HsGyyUCYUql2OYV/adLSSiJ8IJre4RkKeqjGngUnQEuhvVvP5Ydb/8u7Oi3Fff8/QjFd6SxFWGWnHLfrEmWHm/FNWCqr1Utsuq3BE+TpVRyHIP/Uhxzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718054891; c=relaxed/simple;
	bh=1e7yOjnU4xxbD+d9jUHrfbsfQFXLH9r2pWdjQ+VR3gI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NDavzWP4pqzfcUY9ixpbwTXzRg+0+g6xK2SjxOcadKTM6Hkckkp7DJRUXUJ+R6/MQ/mGP7U3drYdMx1kCliYYak6cOySaecu3qcTqvjBF9bxrTAqFuqignjD62CB5wpfeBPNJ2iCLJcywyeCWMNrQIozENxqEuWLQ9LVZ0fuUCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/T/MhE0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7042cb2abc8so1577210b3a.0
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 14:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718054889; x=1718659689; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8Lf+iy8YdPtGfsUOGoGsjMhTfWpGlWpYXVFAiuim6mM=;
        b=C/T/MhE0mU92XciZCmWVFwukIgMNHtP7vUJZACwxvem3/EwdmCOIWwgdfpqFiCml4E
         ua/5Cf+VySBXwnzAKqkS8RenZn5IrXV6/r8MRNPNhHruB+FZiOnAnasRdfj59n5EQBpM
         wBk3X/daJwLBiwEj5w4v6FLNEqSsluVkP1eTWUAv/HeNMU6TEiWcncbWbLV65jYFvdzG
         YiEUsFo9EY3KHuO0YGr28tM0Y4Hgkc1f5KoARyaEyA1GgKxjwV0bPdN/zh0TVYeTjc9t
         PR7crrJLOhrnHPW1D6vmUZCbKoerIcgPBnzhXd4NupsPd3GH+b21UoMcHCh6WPhctQMc
         +ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718054889; x=1718659689;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Lf+iy8YdPtGfsUOGoGsjMhTfWpGlWpYXVFAiuim6mM=;
        b=VLPbOKoxEP9jnjsBEDIXLw73LQ6o4gpoqae34p6dUI5L0Ee7xanYR9H4fFTAzqfxYP
         Npm8qHSEB6VK8W3FeHJXvSZL/suq8I54tt4OVirdCv7JC0sniPQJgTqUx2NDU9e24X/X
         Hox3iebh3bvO+aMvZB2UoP9TYj2O2apn4JZ9BIjkWtXbR94w3z1gO7qNhXRV5OjOZMXx
         GYwcrNK/5gNYTRxastFdPl8l2E7iQaLAy6hPcNy51eF2IatAFe0X7OGpLGEChuMNGB3p
         yTQuoR0zc4rBGSICqKVaGUZJEv1FjyZCbjEl9o5e1cK5+UiijaHmZ2WDVxGMRXVpi2o+
         vswA==
X-Forwarded-Encrypted: i=1; AJvYcCXnkIrRKGlQzQH+eJ+184yuqptgIMbiodIDkM0Kn1W/dfw8IEsZcur6pSub918HvUFBEULDBEBeOYiEbxpL4n6By4QU
X-Gm-Message-State: AOJu0YxDHTWLvNjeh5p+PD9099nVdVqzumGCq1mOoJByCmIIrGlITl/8
	JZqFZp26JPjSBE0wqcgaDf8L0tHqIUseqGrYXs6wp/jETw2fcRRp/8RcTQ==
X-Google-Smtp-Source: AGHT+IG7DKv8oFj9k54pSE1wc1x3OHwIkaYuTk1QA0Dx97VBxVjfcIcisOVM6MAuPmJ4QdcVRU2oHQ==
X-Received: by 2002:a05:6a20:7345:b0:1b6:73b1:b15f with SMTP id adf61e73a8af0-1b673b1e559mr5461072637.32.1718054889271;
        Mon, 10 Jun 2024 14:28:09 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70420fdaa28sm4782491b3a.143.2024.06.10.14.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 14:28:08 -0700 (PDT)
Message-ID: <8d49a2b993e971106d76d85fb18a934b380c0593.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/2] bpf, verifier: Correct
 tail_call_reachable for bpf prog
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yonghong.song@linux.dev, kernel-patches-bot@fb.com
Date: Mon, 10 Jun 2024 14:28:03 -0700
In-Reply-To: <20240610124224.34673-1-hffilwlqm@gmail.com>
References: <20240610124224.34673-1-hffilwlqm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-10 at 20:42 +0800, Leon Hwang wrote:
> It's confusing to inspect 'prog->aux->tail_call_reachable' with drgn[0],
> when bpf prog has tail call but 'tail_call_reachable' is false.
>=20
> This patch corrects 'tail_call_reachable' when bpf prog has tail call.
>=20
> Therefore, it's unnecessary to detect tail call in x86 jit. Let's remove
> it.
>=20
> Changes:
> v1 -> v2:
> * Address comment from Yonghong:
>   * Remove unnecessary tail call detection in x86 jit.
>=20
> ---

All seems correct.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

