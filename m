Return-Path: <bpf+bounces-55952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F279A89F63
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 15:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186FE44484B
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 13:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D962629A3D6;
	Tue, 15 Apr 2025 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sudt9UFk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45D52DFA2F;
	Tue, 15 Apr 2025 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723543; cv=none; b=gQ6cdLxW4YlcNsDzXVO/7uBqG8N7eFUNIxQpLFZGsfBaimkKMnh7uxpWyTtOCv0e1c0/hil3o4e6uJBsPHIS+q862AQqhLeyA+tyNVY1gwF3mIJTbeDSm4yrd4AWvFrfv/kHX6ttCK2UoFgq9gHp4MBT3PhCrB30C1kF9IeHW00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723543; c=relaxed/simple;
	bh=UYUxPCQcFjA73UAxP9WXueMfGm86K1IfqKd8pR+K0JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2NtYJ8zZ+BQjqdM6BGlhbUN/8wvYx+F52/Lhw0Sp+7kv0qYtwNScl+HmZjtWtmhrzVd5sN0VXXLneOB37NTw31MNRCMRvT0XgSSX6qgiQSPVzjJxAVlm2A2dlod3pzgtNmsPzpG+/7WCU6KE1VgdgcZeSzGvMSd+8CHGWtcxAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sudt9UFk; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c58974ed57so517868885a.2;
        Tue, 15 Apr 2025 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744723540; x=1745328340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UYUxPCQcFjA73UAxP9WXueMfGm86K1IfqKd8pR+K0JM=;
        b=Sudt9UFkwOm3iC6+0xFtcz5wyp1qXSzlMEe/5DOwGNUiTfdmjKVgRmPMaOicE0JgZf
         qzUH/Mplas2/Pm2M+Gj7dB0ouRTOk6pxOqk87r9XjF4IXNWYWCauc3s+ilJAuSYLVv6m
         DfceQ5jWRF5SgK64UrnGQXD3CTSgqCz1La9aO0oZqHdsS0Mgzvp55W5/YY9HLPQix+XQ
         TjJeTsIZaZ+FhwFKYjxIC9rUX5I4v/v1Uah7ZyStIYk/ko1udApYMBaP2vz+v09MjP2Y
         6JMzln2A53JHOlqHKsO4QtQCjSSyGl0PdwgL0p+F3cvp3v6AsANCqVYoUfBsRSDSvr3G
         4Njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744723540; x=1745328340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYUxPCQcFjA73UAxP9WXueMfGm86K1IfqKd8pR+K0JM=;
        b=D7QDiNpkpUlOlHBByU4MeoCUzvyc+8BIvUGspYRVw6Ab5TV1rSFe+Whan7jix5pbqQ
         QkpFgY2yghKR6BpY2uwrww9PY4vPJv+iBwLnsTqfwOcCNoU0DkrVw6sSv17XXECJxylE
         6JTvc+t109k/+kUqhlMmhH5geqwFOHOE7jW68ELuxMeGg8M7EJnj7lj6z0VKlhjEWJEo
         u5Yz6t5Ua5Z3ctVTNd684HoVg6Ocsjw00/aIp/RFlz7/cwTVySUQKHV2MpXaYG4kzo4A
         zUFkNARRIIganKe6Nxukl4RMTyuR/bJNgmBaVvUFf5KQ4ekxfR7ebn8HRoz3no6koZNx
         FtIw==
X-Forwarded-Encrypted: i=1; AJvYcCUDWCoXp4FJpAY6i4wPOscGZe8kT1HLfJRO/cuuIC626F8DjFomtt/OnE5CXOIhNqH8kqzZcAh9@vger.kernel.org, AJvYcCX4MWdpsOy8Ic2GfnUTfHU/toIz45Km/6A1DeTBiKmBpLVV3x9cvGPvTmDqEJ3STa/kgIvwvvFYJLr8m0iL@vger.kernel.org, AJvYcCXV0PREWSz/wzT27adM+Q3KcGiiI9JiDWMbj47F/V5xXIYOEAijhP+u2W6dQgdBNH5tdAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu22IoYl54cHYd2SprVDKaiz5KJ++IDpLO6M3geN/uSo5eqEhH
	rIRn5TIMshtb8hp62sBalzzQvtc4I/OtNtxu8hDgGbZ4NhphgFHUCTE7hNpoLfF1K0CtD9CY4bW
	/YWw8cUHNNiXZAZpm80VgN5VTJHk=
X-Gm-Gg: ASbGncvGs/0TuSts9Jtnrd1JRKLPZaH3D9owQyBQyzb8hmQHEJ1nzQyNP0gDczHrVBX
	P4oid/aEMKhBmOjRBBMSP1TmoaUOYMLFeiWVWqxlupmbSVIaiC4eLmBgNIZQRNEm2YyPJ/8npq5
	W4oUjLhW1sK6y+AFei0ZBy9QVuRBs6AFKvIvbpjCyE
X-Google-Smtp-Source: AGHT+IENUN3q9zUEpgp0yO+rQb1K6OiXAS8mHfuVjSa2hIIBeaF+kQ/tbXuTPbB9DLJpwa+uw5WeJlKVWmA3cg4aR3k=
X-Received: by 2002:a05:6214:23cd:b0:6e8:fb8c:e6dd with SMTP id
 6a1803df08f44-6f230d55533mr226917916d6.5.1744723540626; Tue, 15 Apr 2025
 06:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415130910.2326537-1-devaanshk840@gmail.com> <2025041517-semicolon-aloft-9910@gregkh>
In-Reply-To: <2025041517-semicolon-aloft-9910@gregkh>
From: Devaansh Kumar <devaanshk840@gmail.com>
Date: Tue, 15 Apr 2025 18:55:28 +0530
X-Gm-Features: ATxdqUE4dS_DLldbw8HBu898mJglnFnspTU3D7RHe1XAP46zEEX3kVq6zmxadGs
Message-ID: <CA+RTe_hfdgPTwVX_pizHVnsDDFJoEOQD=dH3KuBXuDbycU0yXQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Remove tracing program restriction on map types
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sashal@kernel.org, stable@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Apr 2025 at 18:49, Greg KH <gregkh@linuxfoundation.org> wrote:
> what kernel tree(s) is this for?

This backport is for v5.15.y stable version. My bad, I should have
mentioned it in the subject.

