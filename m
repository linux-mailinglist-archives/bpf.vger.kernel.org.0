Return-Path: <bpf+bounces-39328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43483971ED6
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 18:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA321C21577
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 16:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC5213B294;
	Mon,  9 Sep 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImVdWrHN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBF013633B
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898248; cv=none; b=mEQ33ZSMpe4NRMSJBC5wA/MdI21QHx7pjcVIHNijNBQraY0j4Kn8p4HvCyKgNB/U1sowf3Y89w13/Gzu+Ke4naL7qQdlz9hvssYOBc8UK8OuvyTJ1ccPFkHDlNfJIW52GErn6bMrh5Ntw+G+pQPuFT4Vl4UDwfOha7/Q3AG+pJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898248; c=relaxed/simple;
	bh=4l2b4H3wxaudKrmVAw+/X+53o2bpyMIn54CDkBxopd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7La3ASpWCl5PS1l+UEeWcOLt+3NUbgOh3gRF12LwJAZ7s2/ugEVv0PHutfx4rL1WeFDtWG7TjJ4hxhq7T10NQX1cjIDeaLYnAdFKZTDsVH/eljE1e1S2/qMrg4hEelVebkx2eTX/s4uDirCkBIFMF/QHv/E8vMDzXMtk5y798Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImVdWrHN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso22378835e9.2
        for <bpf@vger.kernel.org>; Mon, 09 Sep 2024 09:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725898245; x=1726503045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YL8CzzMUO8FxrsSAfqIasVhXwa/8+xOERBEAK5EwSvk=;
        b=ImVdWrHNycEKAGjz+3o2DF8b313BNr6u+kCu7pgXVqZGn0mU3mR6KMupsudJ1jIuPA
         Zjk18mW1zw2WQ6DtYyxWYBWpgHBVM8roxVfWlHBhJt0T1N/88BPC554Uc2mE33aiAWF3
         l+17BQmyKYt+4iKMH5MZKY+eJSRUwJ1bAyjn0hcTI2Lfh3LjiAnGRRJvufggu03KyLTK
         juC5bJNm9H4xv+XRZUOfnCa82tn5YihbAaIPDaoP+tapFkdRCIL1qBpUpSjY99+sHI09
         qY2THgTsdq6R19NE3RXRTDYfl1IxYqn2Bb4s2sbkOVOG974JcdSNSJbJcQVGaV3Ax53m
         8dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725898245; x=1726503045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YL8CzzMUO8FxrsSAfqIasVhXwa/8+xOERBEAK5EwSvk=;
        b=qsW5Tnju/hrSN1eNk5ZBLu6v8jyXUbpeHBAauSAjzryzJA1n5+EwxSFtcmfOsrA3e/
         Vw0epFmak+RCJ/t++AlomZ+6Ipe9N9nROPhO8BFlPQVmKqTrRP0fnOMr0uOkMgWJErBE
         +TQ2qnL3HbhQ4+Y+ZplJDvgbS8JbaiENflYeppc9GWo4nsv5x6JmmauCuF7lKTFe7XPv
         VGt35VrDaTjEqrIhqITvqm9ez8GdWVSEclpGL1NbQlutUgJsh05bSoOqZ5UQ+jmhPRcE
         /pCYtBk7xnWGWLacjcKBiRqVtvXPpYb6k/w0UbO7lpIqpzQRT3XNSKe2az009FA6y/YM
         GO4A==
X-Gm-Message-State: AOJu0YyUY7c+hoCFhU97QWFFQUzISKc+zPN92JqERmmLwtvH08gi+zj9
	ZuFXpOCQ1CctBnc29GyYquaNgxKbzkjk75B4m7eL92ofPEm7jnia/fBRZqiCrqas++ec+xDNa/q
	PlOQuO3nu8R4L0MANZJtsE6YySv1l7Q==
X-Google-Smtp-Source: AGHT+IFJCS1UBVdNCSb8hiaErqZxvkZD6/mZ6Hlyoyn9q15LLwAwSYokwihWRz+imPW3lZ80IWeZiKzR3raLq7v+RFU=
X-Received: by 2002:a05:600c:4f8d:b0:42a:a6aa:4135 with SMTP id
 5b1f17b1804b1-42cad76a0dfmr58856785e9.20.1725898244958; Mon, 09 Sep 2024
 09:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908014340.49466-1-yunwei356@gmail.com>
In-Reply-To: <20240908014340.49466-1-yunwei356@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Sep 2024 09:10:33 -0700
Message-ID: <CAADnVQKzMAvRVpVgHLPLz5X_h_2jDfEMVNidC9sG5ykioYEhOA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: fix some typos in comments
To: yunwei37 <yunwei356@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 6:43=E2=80=AFPM yunwei37 <yunwei356@gmail.com> wrote=
:
>
>  Fix some spelling errors in the code comments of libbpf:
>
> betwen -> between
> paremeters -> parameters
> knowning -> knowing
> definiton -> definition
> compatiblity -> compatibility
> overriden -> overridden
> occured -> occurred
> proccess -> process
> managment -> management
> nessary -> necessary
>
> Signed-off-by: yunwei37 <yunwei356@gmail.com>

Pls use your full name in author and SOB fields.

pw-bot: cr

