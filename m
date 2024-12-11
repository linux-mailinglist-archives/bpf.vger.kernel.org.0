Return-Path: <bpf+bounces-46615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139369ECA90
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 11:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355062875AB
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 10:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A991239BD1;
	Wed, 11 Dec 2024 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b="Ye19dIQG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE17D239BA1
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914028; cv=none; b=DrIq2Vd91d9XrS4Q8TCuef9iy1jMnJyhsfK4YmASJeMirPPZOIXOJphzAQ9pWjkfDH4TYkYqFzoPndNi0GCaOrzmNRy4KyR+laNnk7Kk+w/Pi/vk/WsoXe4qf/YMbxxyRuJ7kmVBCZ6rGkwqo7Fj0vTMSjDRNx4z7XJvigjYHZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914028; c=relaxed/simple;
	bh=nKjcDcJB4jySgsM+5Bv4lh0SR2eEjEafuclhhXKVV5Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=S9HO1aJFOAAV1q3mZfXTYKSmZLWYLBJEXZJeRiQte1/049oWsM0bchDpa+bYKbzD//lKsySKPDeIZm9aMSm+04wPYapixiI/h2HQw9+VkWzgEih31Go9/Iplgp61pcU3GB6lG4YtchF9eEYSuRM3VjZcDJiS6TJp0xg3SGkr9I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b=Ye19dIQG; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fd45005a09so2386975a12.2
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 02:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20230601.gappssmtp.com; s=20230601; t=1733914026; x=1734518826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nKjcDcJB4jySgsM+5Bv4lh0SR2eEjEafuclhhXKVV5Y=;
        b=Ye19dIQG393nM8RDbMcfNqLa6sVAhNCHanOC9iIAZc5ijxmQVYWlidQ+3rHpdrnunY
         YAmwC/bFvZ9ptLCznDGH6/fxKXHr/r4nGQloBvEGH5OQ/Ny6BHlNLTMdHYK29lHe3mzq
         bjYLsjZxUtyG3E+h5ucNeULAujS7m9p1hpUBJL2P5IH2m8T8i/oQPyNUaeyeKqqSYFVu
         E2h23nDJveeVvMWTqdBNturic5O0Fx1AgT/yOOSDG0Nf1ve/modFcg32hFUTpI92vxUi
         cWVIZVHzcAqCR/TGDIUkkYPnxtbulSmHh9g13Yyv7gaBy8XIK9kBDnzH4kTgaHD2E8mf
         2kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733914026; x=1734518826;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKjcDcJB4jySgsM+5Bv4lh0SR2eEjEafuclhhXKVV5Y=;
        b=nxwz3h8DkaErAfYvJQ+xnzy9vsbspnQKpM4C70pt/ZQdfbRkxZtKzjbu3sdGa7GbHv
         +tSVl5ts8wOYpOch1OE7GmaLem6BrNvtGc3tfegSJVtTsAFQdH4sOUdDSg2A4Vnhnj6K
         hHEzW4KafgnKoRDq6ILFYbrNO+NGR2zYeuNmhIGsxP3Aid7sXhaH4BUG135LGik8mKh0
         O+TzJd3J5mMfQiACvSypI1AnUwWfC+dxuBIme2k89kMjTIsbbFiguiRYk8srFt4dPuGo
         Ar75PTDyUKTiHvC2KAzZZr6QBwicwaqk8UHonOz4RtmHF2gOkizax7T6rGHD7Q7yyzqI
         /DkA==
X-Forwarded-Encrypted: i=1; AJvYcCWsFciuVdFOcByk7aX3kSRSp86XafPGdqNt5m8+CafDdwOXya7ITbgQrCqZdFFrwx+bq2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBm1i98yw/qcLJccH2/d9onz2Up2YonP3U1Yu+Rwt3B3A6w0oU
	yOA/ll2hR+Cem2PsqvVtnmtNrJjQTfyuBbT6fDBpKvsgbyWsHmiUyPVOainMXpNRFekQG5sF4aC
	qsKNXEowjR/MF9eil4qWqr4hVqCz+pSfSTKbX
X-Gm-Gg: ASbGncvouorcjccgf1G+YRxq6ZiFLmtxAJYyxJ7wYVcKGtKpltaOHKEmT2WEjqjFTVN
	jXwUauI67i/C4xo5dq1866RmAbFr+fe0bG3dzg5qh4S1Ny2hyEFVXuDTP9zuYbXjoX9a7Rw==
X-Google-Smtp-Source: AGHT+IEfc10uei7wMAJXp3wNIDyhS3tTRIVNGgwU+Xml++f4NrLtyZznzfdG3yC/KG2xrJEx7qUX2s8l+mP+Egmyjxk=
X-Received: by 2002:a17:90b:1b47:b0:2ee:5bc9:75b5 with SMTP id
 98e67ed59e1d1-2f127f8debbmr3550949a91.4.1733914026227; Wed, 11 Dec 2024
 02:47:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Lothian <mike@fireburn.co.uk>
Date: Wed, 11 Dec 2024 10:46:55 +0000
Message-ID: <CAHbf0-FQCNkOg4F=cjOCGsD0QzxrSj99ssYaH+9A=GnSn+PqrQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: replace deprecated strncpy with strscpy
To: justinstitt@google.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-hardening@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev, martin.lau@linux.dev, 
	morbo@google.com, Nathan Chancellor <nathan@kernel.org>, ndesaulniers@google.com, 
	sdf@google.com, song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi

I'm not sure if it was this patch or an older one but I'm seeing the
following warning when compiling/linking with Clang 19.1.5

vmlinux.o: warning: objtool: ___bpf_prog_run+0x44: sibling call from
callable instruction

Cheers

Mike

