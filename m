Return-Path: <bpf+bounces-68583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B09A1B7E6B6
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E9F460E64
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBADC2F3600;
	Tue, 16 Sep 2025 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7w1IQds"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015112F0C7F
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066289; cv=none; b=CGBkePgYEZTDPOhKPs0Sg1ltYc+O0PpV0FwiXKMI/RI9//OAhboZxqeM9uIxykEB7zaGzFcAQnxmf6DZcp3CVISnDbpptBYbHCJtnpOverOWZCgNvpX5W/jSUeW84jJ9xw5+8YO/dmRLrIyUnhAjDWxE8dUH+ELjW6hRI04CfnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066289; c=relaxed/simple;
	bh=zL7Ig5E/oUyvBETIHQYup0dYDAmFRrX6kbDh3kaWzSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMmeCVZp8iwb2C1YUT/NyYEIIs/WOaNjIB42ZBHg0lhOIKhhsL3zy8tpbtkrIYxiugfAiQIJRxVd+1JgMQCuMdZ+bbFCixkSxpiYlVyLgBeGvDtpgrEVgK1R/qiMJ8uRDWrN5jauztqhm3NliBIaTjknIiYhj2t+gydOHMnj16M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7w1IQds; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-329e1c8e079so5172239a91.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066287; x=1758671087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJYO4uTDtugNj5o15AbOb79DDPGii3QwX7K8JDoA/9I=;
        b=N7w1IQdslm4mQV5z7aNmDx5YfvEkkFLxUw0XIVUsgAFzfH0PyuwsrwnjIuCZs5aBNm
         KbI6jv2LNQTjKk/jS0q8lrc+Eo7oy34jYVtOZqVNxlJwIUmlZu++6YCDZoyFGzd4hGQI
         36re3lFX10V1EWnvUbwKnTPtpjtehFyodoIxdZaQMVYn/RgWamtwmcRuNahgCwYCNLlt
         QJjwHfLNIfsfTSaucR+uJi24Ss1O/JeXk2B43RXY9IlhZtRoq9WlXeshzTBDyHQ0y1fi
         A/RnP7nLDC2woi4Pp9wDCSSdypnBbNw56jm1lVC2CgDXtbFB/tr/m0tPpgmj/e8EqoUz
         kerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066287; x=1758671087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJYO4uTDtugNj5o15AbOb79DDPGii3QwX7K8JDoA/9I=;
        b=j0ukue+ksBlBIyOMvw2goNfb+rewuNYru4D0XcSO4CWA6ITyclG4XhzkUFLXuDO+OQ
         tgjz0eDUgNyPpPQRbRdLITPikkJ8dIRmnllzW4N0EngmgIAzvgYW5Tr3ZDMh8qvRXiTK
         CN77z9rixJygEnWqWGQW0B5uADq7PmtURXljB5Z3cuszku9vt0sgzw7Tcyvp/O3BkEaV
         owKNjAdANTSjaFT+Vx7Ksa+QI1wvj0ecEAgErOn+1xbqRhdHU9rTsD6FUo2s7h0MZaXa
         P8CigtteourD2bSGHYOIsD9+vYg14E5C8GbqF5Sy0je0GyQt3DvqsZoqKGVWGV/g5ntA
         WXFQ==
X-Gm-Message-State: AOJu0Yz/zvmieDFU3C6uIszoHaOKRZ4qOCZffmlbb0/t0hcuLUhFHiLv
	lUjWGI8qThRKdUJ88om0+TIH4hzTewl1g3Z30Qn0worpA8fK8oKdOLru1xzI+2K2+pKmHgzO4tX
	tTZIDSqnTxqQuQHoXjVeXN/zqQOBEQys=
X-Gm-Gg: ASbGncsGJAM6cA5QtPJYBCwqm5V0fwelil/6a6u+DdBhQxZJ61qyNJZ7SRsVL614wJ6
	1mdQUs0Otog4SvTibOpT1i7Am2nZe1tfV185s/HRPfNb1uVNRLrb9iZK9Mdk901S1EE/wpGvJFv
	FSsNelVdQePydN5DvNiJvisO/P7r7Bta1MKwzVP9tx5tVYYLB7UgOaZeoufpbvFcfasYRxAOC97
	dFayPYu64wiuUfsYGf2VEs=
X-Google-Smtp-Source: AGHT+IFiO3w1yCRHtIxXU4kwyW9+LnJaBuqVRBhXgSubXVoVfN3l1Pt/wLf6LwgCGWkvkMgaHg4B3Rz/DUmbsh3/5i0=
X-Received: by 2002:a17:90b:2fc5:b0:32d:b64b:c4 with SMTP id
 98e67ed59e1d1-32ee3fa31b5mr142292a91.32.1758066287359; Tue, 16 Sep 2025
 16:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910162733.82534-1-leon.hwang@linux.dev> <20250910162733.82534-2-leon.hwang@linux.dev>
In-Reply-To: <20250910162733.82534-2-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Sep 2025 16:44:31 -0700
X-Gm-Features: AS18NWDPUJXPQDHFBrJG1WMjR8QTgvq9VyqUv4lhg-f6J1hKK7RNjNrL4S8qw88
Message-ID: <CAEf4BzZ82nyF_=Zu_OyiV7ZyPJECr9c8LM=RUTXy7ih24EPVwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/7] bpf: Introduce internal
 bpf_map_check_op_flags helper function
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 9:28=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> It is to unify map flags checking for lookup_elem, update_elem,
> lookup_batch and update_batch APIs.
>
> Therefore, it will be convenient to check BPF_F_CPU and BPF_F_ALL_CPUS
> flags in it for these APIs in next patch.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h  | 11 +++++++++++
>  kernel/bpf/syscall.c | 34 +++++++++++-----------------------
>  2 files changed, 22 insertions(+), 23 deletions(-)
>

lgtm

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

