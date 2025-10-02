Return-Path: <bpf+bounces-70211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE53BB470F
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 18:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 398AF7A8E56
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 16:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC8E24167F;
	Thu,  2 Oct 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfZizu+E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B94151991
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421242; cv=none; b=TTMG+lc28soVIIp8lNFzcwZn7dz1LQix7j0HzR3oI5j90c1nan6SP18Z2q44rkTPjl8CmV9tXWdcxiv/n7N+HNDRgxoZLBjdKhC2dJ525V9gtr9+VH/lytnVbR7U+EH1mDnQiz7CSYjrDsVskWhxUNmkW2g1LnMg5qRYfx8yM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421242; c=relaxed/simple;
	bh=K8Sj+uvpdVgbBtR8tKwyqZUW3QNOsqiQ30IMqZMUQyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9LG6RTX5dCv5weRflEy89lgrU0in3T9Qhry3hou7kWYVQ8hbDNgs8k667Zkeb3fTh108lGbDDmDQzsAiDxl0n1CFClTfhN48MObmEKEK2VkL9pZ4fehqmTU696H52e5b6DBSQtxpO8LC+bGZ37SCNNxlTXZcq2+DLL1k6scc2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfZizu+E; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46b303f755aso9483135e9.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759421239; x=1760026039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8Sj+uvpdVgbBtR8tKwyqZUW3QNOsqiQ30IMqZMUQyM=;
        b=DfZizu+EknUCR19H+NYKnW8xSSjCiQpr3NGxmzC629fyJ9vrIL7VweqUZctlbsxxIV
         JFacKdeA1dffiEfjysf+Yoc9bFKtw5NRy4gkW7ooxknbIpQ7ytsw6uH/fr/PdzLI4Yg9
         flW6Sp1cIslBo4htKiQRRWpuoSIrK/rD44dF2dgpLQlLq5qIp2StP+aBAQc7bILBFZlp
         IXt1wCwBxo+d1u54Wd4cAWSijf5gXLh3fLD5Lv12MGsUJ3RWsvzQ+755b1a3qU8sWAbF
         Ad+oaF8LDgZFW8bMEJrKuQKeWJgjV5jBCHnWzgRfk0aKQJDitqY8kxbCczTTF6BOiai2
         INbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759421239; x=1760026039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8Sj+uvpdVgbBtR8tKwyqZUW3QNOsqiQ30IMqZMUQyM=;
        b=crboTtmQZtLh7k3D9aGr5zAZ/VkQW4/4HhjOKnZUJk0IV4xCSCiJERbm+nAJ9okn9l
         bgyxOmEuDS1UUYVMofNB4zDuhyYG1HConu5aklm51xfPLaWityBl1M3P7359jYhPVFT/
         krjxf7MHqJ/h581z3FTUff8jtBKjNVxBoN8StZFkEUlOeJbU6G09zhgMyYUb4ydX7Zi0
         CQ7xFUlWXcaBAZP1C8JHUjRUhGpfcYNI7aPnKOcZcs3hZNnY/AD6Jw6hX4XsZiVKE4i/
         TXETp+6x9Vzff14JQ9AO0T3turSh0sqooOh7fxIkHj7WOvLNBHLXQfXL/LZgP3Yroz9c
         ZOXw==
X-Forwarded-Encrypted: i=1; AJvYcCXCh7OoZ2oAvMrTWXE42QrvFC3/wf7DkSOgOaL9pGK92uHTVUpq5F0fFsoPGt7Rceen/eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP5QTK9zJKKjzIaukL7lIwP7tH5JQrCvEQokUDwkykUmHhO5S+
	FBJ1Vz3sP51S8zDn2v43kPAuylfbNKYASVIHYG5ZBhy/2iux85eDS5WAFgDqNfD2spBotUvdFH1
	zkN5obsbH0ppic1CKNINd/C9LzroGnr8=
X-Gm-Gg: ASbGnctxkgdR1smsQv7dopkAY4zhsjtif5ADy31lLyW6FAXcYpYrplAcv7z1gU8n14W
	6e6Pl9RPIHfYsu015QtQ8Ki0brTSXyshXZHmztrW7mxdIQr+0ZqPjc4CgeJ4NuGuMqXpnWQ9kwg
	LLUJdqnHC+RepGnQWzKvD4OtA7r79IQVgpRrkm9CBFU7JlJNNZYId2OvFymbHXK6SEEZRnj0dGy
	gyiVvT8QZpfQoKL0bAxcXwO58UWPV5Znh+x0Xs/DBD9pIM=
X-Google-Smtp-Source: AGHT+IFIEYiRyagqRChzVb78/7xI1xRJ5+9tZiJFFmZAQgm31P2sZR89kzrvE/BESSBq2e3x3dmw8ReMMZVu4+xMQzo=
X-Received: by 2002:a5d:5887:0:b0:3ec:8c8:7b79 with SMTP id
 ffacd0b85a97d-42557820131mr5306481f8f.61.1759421239095; Thu, 02 Oct 2025
 09:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
 <20250930125111.1269861-10-a.s.protopopov@gmail.com> <eddce884140f3df9e6c3c7e1b873a570b163ce1d.camel@gmail.com>
 <CAADnVQ+K9hYhwxLO3+2xAcm04=SeyCQuYZtHmKMkmkKTUDQG4Q@mail.gmail.com> <aN41dbxNPIUrKzNz@mail.gmail.com>
In-Reply-To: <aN41dbxNPIUrKzNz@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Oct 2025 09:07:07 -0700
X-Gm-Features: AS18NWBSsoe4915EK6Q5I4WqtUePwUD6iEyxEgqvHW5BaEZ4Yog7k3-YzAXWtKg
Message-ID: <CAADnVQL+zYscdgj4x2XT+PFXPoySg=NxCQxAR8dJKPePxONjGw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 09/15] bpf: make bpf_insn_successors to return
 a pointer
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Anton Protopopov <aspsk@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:12=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> >
> > Speaking of IS_ERR checks...
> > https://github.com/kernel-patches/bpf/pull/9895#issuecomment-3352016682
> >
> > AI for-the-win!
>
> Nice! Won't be surprised if it was trained just based on Eduard's reviews=
 :)
>
> (Actually, are there any details anywhere about this AI?)

you mean where to find it?
It runs for every patch. If 'Logs for ai-review' is red, click on it,
or better click on 'PR summary' and scroll down.
The actual mechanism is still being fleshed out,
but the false positive rate is quite low.
Eventually it will start sending emails with reviews.

