Return-Path: <bpf+bounces-37280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196EA953895
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 18:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2AD2853B7
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 16:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6831BA888;
	Thu, 15 Aug 2024 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+pR4VGs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B041A4F0F;
	Thu, 15 Aug 2024 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723740603; cv=none; b=CWcQBsHJPCctiydtENZDdC3mX4P5j41Q93v6+63qjNM7U1CKaeqJ2uIb9n4aqmIh+5n2sKFwapyChUB1CUbM9HJwuY6YslUHiv5e4/NeeMhTuauLI8jtemVk/kQrHmuLmfEEc1te66NActC/dHaGSuubKbG700rghe0wYxeAzhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723740603; c=relaxed/simple;
	bh=C1UGdnX2s10fwwNJhCNJLm9vjYuiEsWO4buAKQMEqdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3mQgVBaTQEnvmZai6A3E+fmQaPGiauVxdAt2KOmYjEsB57yNYYr7CClgrgQF/Y42CitZG/Qn9r9hW8eT+VvtJ8MA4yghhqkOqtpUamt25/KZJJr0NBoiRuGmRSwpmj5kmwei2D5jsbp3RaDlaGhCT2wTvy4gaFH4CbHyM5dM60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+pR4VGs; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3d0b06a2dso439762a91.0;
        Thu, 15 Aug 2024 09:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723740601; x=1724345401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1UGdnX2s10fwwNJhCNJLm9vjYuiEsWO4buAKQMEqdU=;
        b=W+pR4VGs02VUGuhj2P7VSoKhWVnCTiJPrM/SEWdgTQ/RIoBBCW1/XlHV3P34u3KmGO
         xUP2/2fjEoyqzKJQkRsN1PADzvKut/yRKgnT8ox7GCgQ33dcLupxR9fz+zbimjC55FxI
         e5DorR45H4wC1n9Mnr2KSBpxlzAhs11PN7urbqXCqbLKAPs5Gccafx82xs/ldkIbYCyY
         l0wfirjuQ81B6wlHyM4wDIY0wYJcxylLh7waqr7MbpCj65joM9tl7iqg7Vc2zzreYI2z
         mGvgGisL6M2uivWkgOHCblIM2IigfGS38k7XNKOXT+99XQnKeywa6hpNr9q5e+wAivss
         iNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723740601; x=1724345401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1UGdnX2s10fwwNJhCNJLm9vjYuiEsWO4buAKQMEqdU=;
        b=uxs6GOL5iyb5UFIyi4on03INZojBuBsxcHurp2km+Yk3q5V2CX8ToI/7QH9ffFFgjq
         6n3TdyTO4CxWTZuk88NoyBTDnSqPozM1T+0RzwYznxIrll7TtHlLb904s1atMhZ772re
         E8usq/4KzTKHeNg3loUa3R7vAtjMpwmFvmooAq0EeW/trpd7yWNE2mczjZfp1A+stDev
         8wrU6BBESWR5t0aA3o8xH9/VUjXNLfSs4MuOvjhjdoPFVydBtnMPHiqCOEP59ILHhvjG
         MsRzELcuD6jg0CrYT5x/94uqm+e0WwaCfxplNt4iMqUWYLG6Nyw1txD2d2rDiryM+lkm
         8Ztw==
X-Forwarded-Encrypted: i=1; AJvYcCXOo58WUB95p+9b+k2gFpKzDpSOBIpfLZz3ZUjl8LnzvyhluOEelL9qe/grz8D4+ohyQ5Vcxr85Arx6VzLxKzhxQXUJyb+leihbchQl9OJIxspuMqvHHzaCjxD3LZ96g6Q36OktCJO4RPj0xhaQelM2Iv2OYzdviSQRcBgAAoAlKOHosTll
X-Gm-Message-State: AOJu0YwlaMYZGW5kDumKH7kA9+liJ4uIPCKLKCzocGrAb6dkQKx20nK1
	umjNOJ2qlSi0p/aRBFtTnWmW49ilcBLR71pN1u71whV7AGLf2/rHnrAxI9ZG6N1pdHF5UuSQ6RF
	no20/9/gKJQXaMydkrj/55sXkgSs=
X-Google-Smtp-Source: AGHT+IHHpo0FxTY7KNLzO1XrIPTCqsnPC6ResN5JNyt7Yji3YKmasCuY6cbRWro1cx2aWX3tZvVy99xqF4YzcYjCyLI=
X-Received: by 2002:a17:90b:4f85:b0:2d3:d7f4:8ace with SMTP id
 98e67ed59e1d1-2d3dfc2aca8mr294050a91.8.1723740600919; Thu, 15 Aug 2024
 09:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813042917.506057-1-andrii@kernel.org> <20240815132447.GA15970@redhat.com>
In-Reply-To: <20240815132447.GA15970@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 09:49:49 -0700
Message-ID: <CAEf4BzaL4v-tvD9pzcNdnA29SOZbaezjKRRr=ba7_7B=tNBhdg@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] uprobes: RCU-protected hot path optimizations
To: Oleg Nesterov <oleg@redhat.com>, peterz@infradead.org
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 6:25=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/12, Andrii Nakryiko wrote:
> >
> > ( In addition to previously posted first 8 patches, I'm sending 5 more =
as an
> > RFC for people to get the general gist of where this work heading and w=
hat
> > uprobe performance is now achievable. I think first 8 patches are ready=
 to be
> > applied and I'd appreciate early feedback on the remaining 5 ones.
>
> I didn't read the "RFC" patches yet, will try to do on weekend.
>
> As for 1-8, I failed to find any problem:
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>

Great, thanks a lot for all the thorough reviews you've provided (and
hopefully will keep providing ;).

Peter, if you don't see any problems with first 8 patches, could you
please apply them to tip/perf/core some time soon, so that subsequent
work (SRCU+timeout and, separately, lockless VMA->inode->uprobe
lookup) can be split into independent pieces and reviewed/landed
separately? Thanks!

