Return-Path: <bpf+bounces-55960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 530A1A8A25E
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 17:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7C93ACA68
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 15:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89985296173;
	Tue, 15 Apr 2025 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKaasSAX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D23136349;
	Tue, 15 Apr 2025 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744729325; cv=none; b=qusMk+hNjKkMvslH0ygfV0ezv09d7pspOXu2J3XrJ3JRJmkJ61ibEq+9BRPYLSV1hMO06Ef6N7ZzHn/CagvWPzbs8G0JedQgAUStkjrz5jHLa/g067kQDZUURsqh3fqspONNi16ICTFdBa1XEDR54WE/M8zVky5d2nrzW4jEMcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744729325; c=relaxed/simple;
	bh=GsenEpf9zvk5P2NHlMMGuoKKYYE9yPtrUU9/iOPSsZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtYokKqgWfOIzwftRKtBqAA+jHJBgPZVHx79Sn1O4JA11Pzg21HpgJvSXeZIw0S6sI/ryczIcDfJ+I7S91ijhKNcrSYz3BAamGIThokNqsM8+ukA+GZ7WcSlE9DphwfIQFsGnV1gwoFEmgX6Neo2o0oMsh/cKC0NZJ0oyz0tcGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKaasSAX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso29249685e9.0;
        Tue, 15 Apr 2025 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744729322; x=1745334122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsenEpf9zvk5P2NHlMMGuoKKYYE9yPtrUU9/iOPSsZw=;
        b=LKaasSAXYYJqNFACIKOiULXkiFaxhBiUOAa2r8nqCgWOCGtnFrpZI7rpu5/9IC67UU
         24qXJRE/LEEOwAYKibK3bXJXmSAgfaEsW00J9npcYPtlaAyO1RwrzMlukVKaQGfx9s0G
         dn07asAW0uNMUiofaZipPNEgO7gv3iFumJboIF1EgO1ZfbT04EOhxrzeWjcFFgbodYjt
         YLgBSEVDA1xoYmhNfQtepwIEGgeCK3kMvyaehs0epn55D2KsotsKXlzuPXPfgZ+CDRyu
         yHBxHz3IEparpTY2poKIEgbRxlTJMfBcGjo8bmtAYx6dQZYiWER+URxv7PWAjsoxb7yL
         GrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744729322; x=1745334122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsenEpf9zvk5P2NHlMMGuoKKYYE9yPtrUU9/iOPSsZw=;
        b=hmwnouogNwqvOwkLmqfn6nbvW5FXbBqDK7KDgeOcTQk97p39+B1mj07t1b29xgVOgf
         TzxPyd/Ave4Wbepb9pBjPL62x1JALHGfaxClXnai7PhycBjCv2tdgSrA7G/K18Xx/MaJ
         gKqYkuAsiqLRsIJqHXJ/m3J8eCodMgeMhUDaZw3aOkVvBOopPvx/g3gYbmyo/efK2y3X
         CWjnmqwzF7LZIE1hGKnjBf7mzud3f8zkG3MDWKuVJDf1HkUhQ4aWLfN2xttWH/wa0r79
         2V6bxMcZlOK3FFmgxKWO4L0v34/fZ4lGWL24vmRj6LC1Upgxtwd01paTmPbr2++tBxfT
         QVig==
X-Forwarded-Encrypted: i=1; AJvYcCUUdAlCyrut+3mezjr8fricmyI/z8OHqV8fhFZISwIsQPvc7lUtZasuG2CWWRIpoQ8mJck=@vger.kernel.org, AJvYcCWMBGsR+boeRCGn9+PyuFxeXnTh6ODsuhLMeu2FCUrpcf4MP4u6xAOiT4brbttgIgQAJQayNCwAXPtLclbK@vger.kernel.org, AJvYcCWQQogQmzhXt4An/IlXNuFDMIfdGZDmw8ixRcuOeqSie11cVUJNBe/Dgpi04hZqbK0JAsHPQEiQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyA6nbeHsHgKDuIMeJ2TYQFO2R1eQIm6po14/S6wVGOtYittskm
	gr5ZkzggaN2HXC/iBgxR7Il/9tfQB9uxC36DtFxmr1fbTt6u13ugmPgxrShu5tXEjb5tfyo694F
	Ftkao0YWanRtcglMbkfaWFs0sfqA=
X-Gm-Gg: ASbGnct7kC5Ua11Mzd/h/6Ki/IMOUjw6Vnl1APu9EmHY6t1O1NZnr3Hnn5BtP9sfBCu
	bdQbqpBvaiYFd/ua5ywQQC9ZY34p1n16hlc0U+a07YaHxNH+jMeDkd9yihdQiub3352wgxDqLAS
	mwh7GL/V1TtqnJxWfR2e5k8Qn6itLyg/y7lsdm
X-Google-Smtp-Source: AGHT+IEEhlDJ89C3taeDQubyKWfbYArOMdjq8xhOrlVTpBQsoWre14ibe31rWsDsbwAwV9z2K2Ku82lM0PdbZnwrGCM=
X-Received: by 2002:a05:600c:502a:b0:43c:e6d1:efe7 with SMTP id
 5b1f17b1804b1-43f3a9a70famr126994785e9.26.1744729321032; Tue, 15 Apr 2025
 08:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415130910.2326537-1-devaanshk840@gmail.com>
 <2025041517-semicolon-aloft-9910@gregkh> <CA+RTe_hfdgPTwVX_pizHVnsDDFJoEOQD=dH3KuBXuDbycU0yXQ@mail.gmail.com>
In-Reply-To: <CA+RTe_hfdgPTwVX_pizHVnsDDFJoEOQD=dH3KuBXuDbycU0yXQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 15 Apr 2025 08:01:49 -0700
X-Gm-Features: ATxdqUGwfpjQ3TEoIluDDdRzEK7VnkQJBv8D-i6PQJaXxr2L8ySLffMkEFa_6W4
Message-ID: <CAADnVQK=z2eWgcH2duiwkkVC-4RctPVZ+fqdC9KYiV7HUy0i8g@mail.gmail.com>
Subject: Re: [PATCH] bpf: Remove tracing program restriction on map types
To: Devaansh Kumar <devaanshk840@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	stable <stable@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kernel-mentees@lists.linuxfoundation.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 6:25=E2=80=AFAM Devaansh Kumar <devaanshk840@gmail.=
com> wrote:
>
> On Tue, 15 Apr 2025 at 18:49, Greg KH <gregkh@linuxfoundation.org> wrote:
> > what kernel tree(s) is this for?
>
> This backport is for v5.15.y stable version. My bad, I should have
> mentioned it in the subject.

Nack.

5.15 doesn't have bpf_mem_alloc.
This backport makes no sense.

