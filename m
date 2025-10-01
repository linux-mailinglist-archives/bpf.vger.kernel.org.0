Return-Path: <bpf+bounces-70108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5EABB1067
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 17:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806D13A826B
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 15:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129DA262FF3;
	Wed,  1 Oct 2025 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PWFHKz0b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC746BF
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331830; cv=none; b=pl7PsCvxOU2nWPPfLLLhgabAE/VueuqxbjXUyV1ASJHWcT797KjWePneF3SCG5GDBuF6+SSW+K02XL6GJtr3rW7UsOuFbsARPhbbmXLqcAyWD37pznMV4MZ5VrlQWjzP1CDsRb1cX/MPo00Cl+v24Iu5D5Q/9E+SITzh0fjUcEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331830; c=relaxed/simple;
	bh=xsKi9Pi+QT5fVL6eQFIu6l7eEF5T3oEwY+NILjBv18s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uB1TI/MI/WOAl+i+q99dd4O9S6LEjDb90q4JfPligmeeM4oFREh+SwZOWXpQcpQj6xwmP8a+cMxdwqAuyvrabx2ZwiTNgAvTZkEul525FmmN6CkmXj3rGKkXHUm9KmYidAlCqNBgI9IBUGNdFPp7F6UP8b+gs6mTNU0dKeBVGZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PWFHKz0b; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3d5088259eso624619266b.1
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 08:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759331826; x=1759936626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2EhHzMOVl/r7mbcD+woryFmIGoIQn5oJw5TlWrUoNg=;
        b=PWFHKz0bFWJ113CCQSZzIRRYOuyGnxQfjub6XyTqKMSKk1pV7+acqFSdPdKWYWJAAF
         isXJFSxDNlN+YKYB+4TI+vAAex0NC6voRcABzALpwyIaAcP5UHmjCzaSL0Qm1Ae0Z0iV
         Md53d4un0OzpO2Con385FjvclTDffKFoqR2/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759331826; x=1759936626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2EhHzMOVl/r7mbcD+woryFmIGoIQn5oJw5TlWrUoNg=;
        b=uqLGomfXO7vK1B2uR0b67KSWctsLhLnvHQtw6tcIIe7VfrXG0gspmQEw4ZShaghonW
         0ebLP5xCT+S3CDf5BjmhUxc+GTiAIRljBD/wJejXKQFVBtaAV4Zs98vFlKGDsSqHoVYr
         kz3Tey/fK11eAvZSiy21HMwrGBuUfDacWoiDowTortan+2Jl1XMBUJMsAHuMlOmbgGeK
         ddijnIH2M8LJ8ajUENic2SFsU4DPrfbhzZ1HF/AvRZDfcRAQvdjxfP4X2Rw6ACYlLQns
         Mb2Fy+onfcWt9xVwq5TmrPL1VAudFiZKF+60+Z4QE2UiPCDPXHVmBInkslDhpVbKUGR/
         OCLA==
X-Forwarded-Encrypted: i=1; AJvYcCVXszQ4wq8ZnyADnmPY4RcCFwcMF6sCdjJZp0gC9SPmg8fU14i6tZRDZFKR86zwbbemOro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU7YW1I1/OAr2cnnX7kfwiChHCOpwi/2nw9qzyNyyQYeoQWzfN
	jaLiZ32sx1xTMjAuD4gDUO6cMLw8ss68SDrP5sqwwOurl4cMD3qyqOacCd4w+xlUn7PajGhNg4Z
	w3tTzv4I=
X-Gm-Gg: ASbGncsGJ5tfLrpW9w8YIZA4Z7yPSb7pvjU/XhWNo5KFCNHICBE5fDbsIYK1ZwpzdBU
	m4Pj2PbOVnKyo5x3RTrjaoa+awv0VCZILO6JY8Re/baqC3WUBvsBr1SbRdGOJD49ddOsXVjjOQf
	OPqoplc3p1qKP7Nz09iCQZOgpcVynjf1BYXfVfC1ZNnUIe7CwuRatbA0iV+a8hg1wSgynWOoLUX
	JUKQ6Mvx4U1qDgi/1ip+EpeO2bjEgKVL1qTvwlpU4728l0sVYKPag1KS1Mpac2y/cW6yIDWHHov
	ZLZZH7JetgZv9iGVpx6uGPhsNBykRFNc+zCCvsTQq/CboYO0kVLRTMYQe4d8aRuiUFaMbBd9hF9
	1/S1wwP+5Y/QqmAmvPj/G+5/oTeB5LhY21wkZ4MPsQzM0lXTQEKF3G0eZ58nLPIkHIRZjorIcXI
	6Z6ZnTLFbCRAXVv0Y8Gcal
X-Google-Smtp-Source: AGHT+IGvHWmbRmQjWqUSu1TNHOlejByEUSnCtxZXqKQaA1LBAnrFCYYv3ImeuHGQqAzjes+1MkBERg==
X-Received: by 2002:a17:907:86a6:b0:b45:b078:c52f with SMTP id a640c23a62f3a-b46e68109c1mr481098866b.61.1759331826483;
        Wed, 01 Oct 2025 08:17:06 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3c9ab5d70esm803156866b.21.2025.10.01.08.17.05
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 08:17:05 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7a16441so1199915266b.2
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 08:17:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1xjAGBIo27Q7xSuFuwWhnEr9kJoeWpe21e8xm1Tk4+uG5mjpwXKZ5dqnmOPfftycIlyc=@vger.kernel.org
X-Received: by 2002:a17:907:a08a:b0:b0c:1701:bf77 with SMTP id
 a640c23a62f3a-b46e1951101mr469679966b.18.1759331824949; Wed, 01 Oct 2025
 08:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928154606.5773-1-alexei.starovoitov@gmail.com>
 <CAHk-=whR4OLqN_h1Er14wwS=FcETU9wgXVpgvdzh09KZwMEsBA@mail.gmail.com> <aN0JVRynHxqKy4lw@krava>
In-Reply-To: <aN0JVRynHxqKy4lw@krava>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Oct 2025 08:16:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=JCe-4exEH=kJmhf4FfRmbhSqHxMiKiuhL5NWho_4hg@mail.gmail.com>
X-Gm-Features: AS18NWCVZEu0EKX7iTlguIB8o3ke5c2XEXaIJTu7y5nDPGE83H1_P9z9kj4Br4A
Message-ID: <CAHk-=wj=JCe-4exEH=kJmhf4FfRmbhSqHxMiKiuhL5NWho_4hg@mail.gmail.com>
Subject: Re: [GIT PULL] BPF changes for 6.18
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, peterz@infradead.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 03:58, Jiri Olsa <olsajiri@gmail.com> wrote:
>
> yes, either way will work fine, but perhaps the other way round to
> first optimize and then skip uprobe if needed is less confusing

Yes, thanks, that was how I felt looking at that resolution too.

> I ended up with changes below, should I send formal patches?

Please.

> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -142,7 +142,7 @@ static void subtest_basic_usdt(bool optimized)
>                 goto cleanup;
>  #endif
>
> -       alled = TRIGGER(1);
> +       called = TRIGGER(1);

Oops. That's me having fat-fingered things. Sorry.

I would have seen that silly mistake had I gotten the tests to build,
but as mentioned, there were multiple small issues that had unhelpful
error messages that I had given up.

              Linus

