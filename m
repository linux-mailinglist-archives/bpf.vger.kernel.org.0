Return-Path: <bpf+bounces-70027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564BFBACBF6
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 13:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B5F192818A
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364F92F5465;
	Tue, 30 Sep 2025 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj7WuViC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE9523C51D
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759233574; cv=none; b=PLKo+OxRj+Zl47hdBiNynhHVvTI8LwgzMgbmm4gRLSnoHEkLsgebd5BSU6FNF5d9mN66hOO/cC6pdTPfWxfavr0Q2kyvBn00MOnqu3YzLU5FRnwqKi7xGDJmZeB+680wQrZ6pdTClCPpX281Pjc5nx2xK+yAZ7sksm9F+/ScXuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759233574; c=relaxed/simple;
	bh=+Xm2PL1udUhRLQvZ1GMIb68+0pqhYjUCefnCyHQSl40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAhmV55xN5suhD6qR1K3KVyA2f2PdVxIi/QGAkbm97yemigpRAeZ1FRwUFLbuM2SLFtMhQsPZwPZw5LzdPSF2TDqEhMfz0fkLKdRQ9d7/Xi708WoP2snj7kvq8h8krf0jDNXL+PU2JBa9FMqltd6o5V3FUTUevoGn0r/x/DPAgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lj7WuViC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so33402195e9.0
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 04:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759233571; x=1759838371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Xm2PL1udUhRLQvZ1GMIb68+0pqhYjUCefnCyHQSl40=;
        b=lj7WuViCRH1xi3dS4zMxJTQVRCPQLZztzo2yhAwkw57olN1X5/G+c2WawQNKT2F1zS
         UofFSRCam2BaUdI8umr0YdXfcYRgh8IjoqZdx7ke26OVioEg+kri3xqExtek1PYvMrka
         bg76CeG7wSodkUut9yI9lmi3MPi0sYBWZ4BzqwqkE73gnZEg742mdh2KpuB+0thuYCLJ
         xSBw0i0SCnan1oKDojtA2FTb3hTnCwnkVhjroUj8ozlt+/DlfRA+EJ2BsLCUWKrdvTXr
         Z/e+9AcsOjdn2ha34jcbeBHr+6qyFSYTP79nas3RUwMtbM926a98WOQVf7bcZG2t37hU
         zIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759233571; x=1759838371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Xm2PL1udUhRLQvZ1GMIb68+0pqhYjUCefnCyHQSl40=;
        b=T1GXMu2JmJ4joQjou7DU7j2Ze6hwwzPM2LaYYyJg+Wze3temPzCz1JFpxYRov4PPMr
         hjWYLphhIFHmJIeh2dwueeB2E6bTAHSNDAiY2XZ2S0CHH0ZE6O5p+Jv4ws57+zqPhZ8r
         Q7KDsy7Lapjc/RLg1fEFnddXT9nf2Kv0+T59ulpfg9L7JZ8hRsghHyxYo5n4fNuX8evx
         ORnSz2GATKBFdVwfIxNPX0lLx5htvBbXdP2R60WDtTQfwynnN5I2csGng1/CbZfXWx8q
         2MrdqGFLbvod4YVnlBUNiaD3PHm16KhnfkqolKy7CWbbXaHra/VjDOZnNXwZaz0tR6zF
         /49A==
X-Gm-Message-State: AOJu0YyMxFA2ry9xNFU/ATuT/3vWtxostXlSAJmhfyiAC0XhH9NfV8PQ
	7Ooh45ZEA5oHdIjkI3klwnziabNXsjlBNuuqT28YQ6Vl+3M0fEkGY9GBtsTFrc+v2qnJKQjIgF2
	jeDB74+Vza+oLouBPNfvYVL0Q5AliKZw=
X-Gm-Gg: ASbGncuyIWA1ng+0CKVirxMrKgrS7S4N5d2KPgYHERuGquqQhpQ6tiD78JJHmAR055R
	fOiKRjP9Y1qV723YV9dcqEQ/hZI2W7jAsnTOo+92iY4RoaVULjXQPptXbHgG3yQMtnvCt0qJvkM
	w70N5a1GTu4GGePgu6nBhhkWUnzDu32/jhvoLmh4c4lixwmqgggXqvJV0EJjL3r/0phNsmmW5ow
	aTg200EvHCZfrU9mf2Kd75VPyxFi/L2A9wDE7pXYAY=
X-Google-Smtp-Source: AGHT+IHc9qHoHNcAbqUw3zRQyL6ntP5MY6eqJLUbXBT4Rvhu787gXnw0M+qXXxrqjXXEueVTVvLKUZCOANmg6EN9U2Y=
X-Received: by 2002:a05:600c:3b0a:b0:46e:3cd9:e56f with SMTP id
 5b1f17b1804b1-46e3cd9e7cfmr146166595e9.6.1759233571274; Tue, 30 Sep 2025
 04:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
In-Reply-To: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Sep 2025 13:59:20 +0200
X-Gm-Features: AS18NWCI7UJgx5lQPivjiHcFxRlkn3VuNGXr-BG69USa93Zrs3_CfWEFf5TVlxo
Message-ID: <CAADnVQLvH8bjVYh4XiAvt=8+QKGY3imEuLjm9+zEe3744HM-Fw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/15] BPF indirect jumps
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 12:49=E2=80=AFPM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> v3 -> v4 (this series):

Doesn't apply to bpf-next :(

pw-bot: cr

