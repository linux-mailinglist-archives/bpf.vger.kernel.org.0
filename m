Return-Path: <bpf+bounces-63219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABA3B045D7
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 18:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC423B56CA
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 16:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F61B265CBD;
	Mon, 14 Jul 2025 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgcDMvT3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9256426463E
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511551; cv=none; b=GZoL1ij9yZHN9Dghf85nCOYLMI0axdBu35HDf/EkF2ekxbyomw9jtSAnOyWavVWfshXeAADPNQX94jyN4Yzh9d89UAksrdL4D03BXvXrM8Z44ygcSCciErtNrX5oAmeTWneMC0zGRtwGQHe6uAWORoTiXH/hBQ6zd5aofR0QYYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511551; c=relaxed/simple;
	bh=SKXZyPZ9sRI5oAhWs7sOHaIr9KurnfNukfpCVpmJ7oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSoTtLH5hnbKKh2KRMHLH4h/qTrGJNjAdCZJwNBbd+/61ThUU7Nc+J5SZO+oTmBfjeG2QkFOPeYEVlR2QwtFqnJ33eH1rpzdmQ51ks2iBmnksgWha5SBO3lzriM2hQOmUUqbGx1R83jPYvgZW/oCtyEyTR9SGDz1LHLmjSfyvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgcDMvT3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45611a6a706so8417585e9.1
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752511548; x=1753116348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKXZyPZ9sRI5oAhWs7sOHaIr9KurnfNukfpCVpmJ7oQ=;
        b=SgcDMvT3npUuQLeUx6dJnFzRS4Q4i7L7nYrw/AheezGyhORrve9EbHB4WC6/Zc1Ahc
         MAQ7/VQzZJ9Wymx3teyjn4gWPrN1j6p07GFd/B0lVvFQRhmUadOZjckUe4LYHyayPKVt
         kBAKPDDdTHRPSruxaz86Wwn/9CECT9p34lmDIejBLUD6fyL1hofjpojQjTPDxlZLHyVW
         1VvGgFcEdrtZFSe6P/yPBRhLx9FA3Brb3/JcsUEoUjIodczmm/zxd/HOSNPbz1uFTITC
         LmgQMRro79HtBhgjwxHzBimzEnvTOo2Ivq6sN3uHYfbj33J+0ThqLHM7/FmE1krZnQhc
         pG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511548; x=1753116348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKXZyPZ9sRI5oAhWs7sOHaIr9KurnfNukfpCVpmJ7oQ=;
        b=Q2UdnpZ/l/qw0F1coFcTBvMzCz0VG1KmwjUtf0NcLUkPXnGqmTol+350d/OY3/dS7M
         ZQIW2KpBB6RerYsnuFcSt4PgxnNjteyTV7iNbi6/JVwnHR+E6PHyVyiJsr+T6T4dGRQk
         S6fHMA7PDsOuXUuLOUBbEWH36/1HoBdefKyd7X3cSBjEGSjIlW2WmBRmX0aCOiQ140Uz
         AEAWmqwaNMFmH0AKVrI9OvLIBP4e0t3eyhvNbJ9YvhGXE+r9pyllvwyLyniye2adbCn7
         9Hrm1wQ8fF1XiinJF9JG5fVY1TnH+6wZm05AreKcB9JNp86W09LYhKnv1u+Zki/JcJbY
         /GXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRnHS3p5Mc3UuxufeSoeKRA7eNiMTSgnNORd9RuzjaTglXAGGmGa8CbH9NUHg6zK95EDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0BC70QCVD3Vet422UP4K5JWHaoQlYT0rcGA+WS0ZKqltZXC3n
	UrsNMjA4a1/+LNezPSvauoto5Vk1/3mEwtzsbYUOHzy9GyDV0pkguwMnbYQYCTPBMY0Jj52kp1B
	Lyo3615GstkCy3ZhljIgtGKid07cze9k=
X-Gm-Gg: ASbGncuO+GYuCkBDMBfM0DzaVzkSvvc2Zb3EIEXnrFXNGwEQy8gDPEpYAR7YpgaW2Yw
	od0fYlYpk7bWAHtreKu82J2zeum2ch4bHqJAqgT9zhnG+aj/zF8CLF5xVLvBUsr4psfkHvVrKAp
	z+gKxVjf/RYv44M/fS67fYFcfE4X9N01yya4vy9qW26JMt/OJhlVWxgTQ9C9JoM4+ZcthyBAts3
	XBSFk9mN8yViOhdGs4wppQ=
X-Google-Smtp-Source: AGHT+IH7Hc1SXSM8YCUjs4mPsgkWSvKT9CWEETFG63rpIAJ4n+nN0WBsqfBJXd8106awptUHIzJcMDml2Usg61iab80=
X-Received: by 2002:a05:600c:1546:b0:456:58e:31af with SMTP id
 5b1f17b1804b1-456058e33b9mr101670285e9.14.1752511547579; Mon, 14 Jul 2025
 09:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3D54K6bt5J7Mdk2WdX1ixCaR3o5k99Hz2u8mzMxNRpKA8-ag@mail.gmail.com>
 <CAADnVQLrXcrwLhc7Tq2TojWqb6F4epDoH9Ae0OQaTQN8ckzmsQ@mail.gmail.com> <CAL3D54LD9rLHPDG6dMK+YQMs9bdkPrr=SYnPu3ipokU5yXC6Pw@mail.gmail.com>
In-Reply-To: <CAL3D54LD9rLHPDG6dMK+YQMs9bdkPrr=SYnPu3ipokU5yXC6Pw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 14 Jul 2025 09:45:33 -0700
X-Gm-Features: Ac12FXyQoMvrmIFHpC7dKBGtR00tT-NevD0Rs_We07Jaan7JgQjrfPAE1oqLz5M
Message-ID: <CAADnVQ+o15qDBH=jH-nKymBVrVcPY3RnE03_k94XYh9afon9ow@mail.gmail.com>
Subject: Re: Potential bug, uncorrectly accepted cyclyc program by the eBPF verifier
To: Cinthya Celina Tamayo Gonzalez <cinthya.tgonzalez@imtlucca.it>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 9:35=E2=80=AFAM Cinthya Celina Tamayo Gonzalez
<cinthya.tgonzalez@imtlucca.it> wrote:
>
>
> Similarly, the code is slightly changed: same logic, but the presentation=
 is different.
> I thought this kind of cyclic programs without the ''pragma unroll'' or h=
elpers are not allowed in eBPF. This is the reason why I sent the email.

'pragma unroll' was discouraged for years now.
The verifier does support bounded loops and "timed" infinite loops.

