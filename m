Return-Path: <bpf+bounces-50358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9025AA269F5
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 03:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3253E3A5A2C
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 02:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DB7139CFF;
	Tue,  4 Feb 2025 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdBpwQgV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05595179BD
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738634432; cv=none; b=sHfw0sLHcnVE2mpoX7TM9ZtgQP1OLxkgXU7pM6cTrMzUmtOPQaGUpNqCFzpOad04syCAG0gxyomcdVw9KgX2dsWIWupVWSVUwQuur0K2O9SfUY17ZHd8OhJe4bxLX8qJk0YKEUNePheOIFisz6o+TCvffk3+gqhtSgGveXzOado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738634432; c=relaxed/simple;
	bh=7xY1Vvh6L3sTjI5GbL9Xme1xscIWowvdH3kqDIXLviI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=N6ezpxs+1hN6xV1NpA/08b/fPjOMzDEJQJOc6/9E4GXfNY1Y8dn4VcjDu2LTjQwJ31vv30KVhm7zZtOFbJeaFHDga4naJS6WJjG1atrWk719YIF9QwntioLfOiJVQIt2JVc4OB5Vw4hyr4HyE3/ZAgfFTDk0mevNY6ZTo40F240=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdBpwQgV; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f2e31139d9so2388703eaf.0
        for <bpf@vger.kernel.org>; Mon, 03 Feb 2025 18:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738634430; x=1739239230; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xY1Vvh6L3sTjI5GbL9Xme1xscIWowvdH3kqDIXLviI=;
        b=LdBpwQgVsEDcF/QixJ0Q24s93lEVmrPtAXl6MwPAr6njP8KIFbbOJbrGTFxGaX+Ry1
         9UWLJuH1fMi9kg0UgShMCW/NkJbExMgBcaqeSIUuud9k0eG2y2hMpLyXkHO58Ry6azrn
         d3Vx4G/Unqo5GzKS7ub9dLLOmAy3OX3AupRMlIckC9OEBx481T+Kro7o1OOsYVJiTkcg
         xjaX4WvyYR5bT8dk++qNTbGcESIoSSNAXzpam07q+SneKbUCWRkd6vAZxq540ZouMPcA
         TBZjjCatAbQrY0pHiQxEjXmTSx+o7Vbp0JucVvcjIerGbp1uMnIwBgY0YhnAfRo8C79q
         9bJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738634430; x=1739239230;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xY1Vvh6L3sTjI5GbL9Xme1xscIWowvdH3kqDIXLviI=;
        b=bJ2qtPY+VaI8rK9GNq/DS274Xbl/MP1BrCtLFgnHvM5T/eD2X3TDWWranz8PdKFa9t
         mZh5ki2h7zGzSsiZspVcLc2m4949beR55Sh4On2p+KfRRGY6UAfpD72Duu4Y9sSJe6FX
         idTVRUBusgtFtVpZsBJpfTbEQGz+FGbaoW2kAUhPyipgezUE1dNOhg6tZD1+LEMgMdrC
         himFBl2AQrhPPZEktrlU10oFY1WRmroMg7yQj8pzgK+UyhUhKkC99Ovp0ZRwqNrj7Bk+
         H+w8P3R4sHbDyjNrJuUA9bk1q5tCVsSC11hgfTWilQpoUPdAw8QTXnVD7hn7QVZJqya0
         0MgQ==
X-Gm-Message-State: AOJu0YwK6GHZ5UYgnLO6FAim7+EGr8slFFb4OTy1zbsQ4WbNY0Ojhb+H
	mMAHY/lKeJJznEWcIo1cgb/weQJfR2dL1FtLhcs4/+L98y3iQMxi3MZVjFyoNXhFfWY3QAUCiAZ
	PsCoCVd2tByazXnbH3Igu51WjPPJcTkR+C+M=
X-Gm-Gg: ASbGncsPZk/TsRYDnVf7suLCMk1JP06AscuNwNDR0e0VAlbDCEMY/3EEfltJs6SUyxl
	2fbkEkMPrmf59ofIoODPG8BxjiY08YPUDPM71KxOX5p2fhHG+fXOJFrFwwn6FvjVA45tEWaHk68
	DIVUkW4xtmEj+oft2hIgiz1xHQ1rDKdg==
X-Google-Smtp-Source: AGHT+IGfrrBgaz9Tft4K85pGPP1VMgAMImvkVzGZDMlpj3PJkP1awOyqY+eBfCyUhtwl2lGlGGpeoIFnRehqB+wTyaA=
X-Received: by 2002:a4a:e849:0:b0:5f7:3654:4595 with SMTP id
 006d021491bc7-5fc0040feffmr15611935eaf.5.1738634429818; Mon, 03 Feb 2025
 18:00:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHnJ_vj-bbZhUqoDrf0wXEh8gEUVwq34WMXfHRo5=nx5FAL4OA@mail.gmail.com>
In-Reply-To: <CAHnJ_vj-bbZhUqoDrf0wXEh8gEUVwq34WMXfHRo5=nx5FAL4OA@mail.gmail.com>
From: Aryan Kaushik <aryankaushik666@gmail.com>
Date: Tue, 4 Feb 2025 02:00:19 +0000
X-Gm-Features: AWEUYZn1GQVRcWLOdtQ0nQ1fVyeCTIHPKdX7OqqgW-V7d1OaLZnakvGSDY4zmjk
Message-ID: <CAHnJ_vhEwtqFtjjEX3DN03e1_vKSBu4e2cOAdinzgtrs2aPjUw@mail.gmail.com>
Subject: Fwd: LSF/MM + BPF ATTEND - Topic 1 for discussion
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Team

Hope this mail find you well.

Topic 1: Practical Applications of WebAssembly (WASM) in Filesystems,
Memory Management, and eBPF

Description: WebAssembly (WASM) is emerging as a powerful technology
for secure, efficient execution in various computing environments.
This session will focus on how WASM can be leveraged in filesystems,
memory management, and eBPF.

Key discussion points include:

1. WASM=E2=80=99s lightweight execution model and its impact on memory effi=
ciency
2. How WASM interacts with filesystems and operates within sandboxed
environments
3. Potential synergies between WASM and eBPF for secure, efficient
execution in cloud-native and kernel-space applications
4. Real-world examples of WASM implementations in security and
performance-critical environments
5. Challenges and opportunities in integrating WASM into Linux subsystems

My Contribution: Given my interest in both WASM and security-focused
computing, I=E2=80=99d like to explore how WASM can enhance performance and
security in system-level applications.
I=E2=80=99m particularly interested in discussing its potential for secure
execution, memory isolation, and integration with eBPF for
next-generation cloud and kernel-space workloads.

Please feel free to share your insights on this topic.

Regards
Aryan

