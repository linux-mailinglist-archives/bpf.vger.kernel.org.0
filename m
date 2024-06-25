Return-Path: <bpf+bounces-33109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A182B9174D9
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 01:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37F31C21382
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 23:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C27517F50F;
	Tue, 25 Jun 2024 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaF32HCf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF4817CA0E;
	Tue, 25 Jun 2024 23:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719358925; cv=none; b=Q06YUk0SqFLdFVxEa7QnjCwVQz0CqYAlwJUelTetnEcyRBNuGv+bNkUbi2ekSCIY0/qX3PtsQevLfmHsSJieisPIKA4LcqDGTXd9e53R3NCpmaT24zQaJGt21xBbNA6yEYpK+eLQ5aKvHmH9xtmLC3cAt9EGjpIvOda8/KORYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719358925; c=relaxed/simple;
	bh=rVdYU8JoBts57wubfYhXzYkZrGErVTfVgKBQbWgxr8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rsm4xM+pIHA+VHuOgygHUz5KJsPjV/LJF9M17zQF4Nrqc0RHyG9k7WieomLj9OocqSY/OhVELC0hg9YRsGoknD6retKJ2ZfkcedIC04HDmNWZDSyWaAnTdzWPHW07CJ2h+cbLMXFIiLKUtcKPXbOB09mlCcjYqN6TUaf9fpYI4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaF32HCf; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-364c9ec17d1so3808521f8f.0;
        Tue, 25 Jun 2024 16:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719358922; x=1719963722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCCMFYSQNgZ18UkQoCOBhpHK8o3bt6yWeNViChXa6sA=;
        b=iaF32HCfbuFKCquVm2lTWoLm1SwE3L2ANg9xQBdEhZ6t0cHDFQizhlDPVENy4ytu1e
         z3RNb7/t8nSYBVwJ1KGEg72nAJ2e74NoEC96BeYWiV4Whhuf4jhLhI6biKEsofKsp4J+
         eSCorgqQsmxtc8t9qdqHloMD9DCDUlc3RT0Cbc/IWcwqRfdoSrUq9feaaBIpEuf2f8Ve
         Ne1vAe3Jrfa2HaRIIM5giEKrnmVpJq5SiN477WyAAL0TCyGfsztAMlrcKNX0YOyzbLOE
         XMmxQIAp7oMIDAkLPW4kmbUgNW+52y7BrN4gtFWsteKmidrBM2pYy5CISWPcHG8hu+DR
         YKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719358922; x=1719963722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCCMFYSQNgZ18UkQoCOBhpHK8o3bt6yWeNViChXa6sA=;
        b=ZqX0dB0a2SCvFXOIqz9kz7dWtUITMw6dgEnCl4Uszekm5ouDTqo5B5WVA6/SLjBpPM
         jvXZOB6pRuExqXgD4wb8LQreg46D1NH9vcgLEdFZyrqXiGYFU6FIdM+xZXUr/Hk7KhWC
         TvI4tHvCKWMqiv4iRslANo6N54RJgi+/cRYyFNxJj0Go++L7BBDRb3yoeEHazrGy+Q3O
         ycuUOcepUZfUCOwAq1TFEtTgKzpweyJVTIy15/YxDZv+1u14U2SYtMeDXBP34ErPIVEM
         V5/d/OHOfEz0KMT8uEGDneEZFJr4vaXNqmNl5JRdCl0BmeJ4Fq5aOFzOyKLISgpS61KV
         d57w==
X-Forwarded-Encrypted: i=1; AJvYcCWIyYUrMeB//coVerrGyJp/AciRjaiU59dH0MLqtFKkqn2nyIiRSUdEZk0kdKxtUWnFQu+qDfOCyDuO6bU+PQMlhY4rMkKAO+sAM93y5LG9CYbcZ3XCGmEbnRi6nVMkj8F3Nm+6MeKzWrUEhnPGxbJ0iAEraa5tNIsc
X-Gm-Message-State: AOJu0Yz28VgF7/dkHA5YY3EMGc4IOLVpP58+Ado+V3qiRCFzkJzIXISu
	gMPPAN8l9UeBxF6GurwTc8cHWYv5y6NihCQdxh+rshbE18Flo68UJq/QV97/ZNS9UGGg0buRQD0
	OwxDGTCNaayqiaeSjnoNl6gUN63U=
X-Google-Smtp-Source: AGHT+IE3EMkRjWDPahiQUVEnMfPYjKfFupBJJz3JwYcaapJhrwS/kUVg5K7p2y66TrHsyQsVkFKiplf6CPeEYEuSSCk=
X-Received: by 2002:adf:f003:0:b0:360:9bf5:1eab with SMTP id
 ffacd0b85a97d-366e94cbbf9mr6065181f8f.36.1719358921815; Tue, 25 Jun 2024
 16:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625135216.47007-1-linyunsheng@huawei.com> <20240625162700.56587db3@kernel.org>
In-Reply-To: <20240625162700.56587db3@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 25 Jun 2024 16:41:25 -0700
Message-ID: <CAKgT0Ud1g+KF4JA51n-wnxFNLW5nNkAx4s=Wm+kd+2og7Nx4MA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 00/13] First try to replace page_frag with page_frag_cache
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 4:27=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 25 Jun 2024 21:52:03 +0800 Yunsheng Lin wrote:
> > V9:
> >    1. Add check for test_alloc_len and change perm of module_param()
> >       to 0 as Wang Wei' comment.
> >    2. Rebased on latest net-next.
>
> Please do not post a new version until you get feedback from Alex
> on the previous one. This series consumes all our CI resources,
> we can't get important patches tested :|

Sorry, I didn't realize this patch set was waiting on feedback from
me. I will try to get to it as time permits. Maybe a day or two as I
have been swamped this week with various fbnic related items.

Thanks,

- Alex

