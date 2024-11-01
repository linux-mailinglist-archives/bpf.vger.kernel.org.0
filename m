Return-Path: <bpf+bounces-43749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D249B96E2
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 18:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FB21F21B15
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 17:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180C21CDA0F;
	Fri,  1 Nov 2024 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8MA+ZPN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5221514AD24;
	Fri,  1 Nov 2024 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483609; cv=none; b=BeIw+PTGcYiw58wS6/OYF5DFPZksdSN0m0/1l3+CDxT2LZonHkgWoCy9/VdK0seMv1w+vhME8DlYijpXFX6d0a/fIdeHzTd7OAM15NfDlcghxzkrcxEoqx8ZVZvTyWVDqTRyuzNCsEmCeo9DCBjGwvxjRJ19CqMmr9AJtzV7zU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483609; c=relaxed/simple;
	bh=K3OY9nIm82xjsXhQmhAiM1K9cCr4K4RhtHXQO6oqgrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nG+z+twgWyNY1q2Kwa4jLW7Df2VBFm/sRJYR+3S6d9vA6A22kby01JQUWNxXWhn/N7GWE29wa860wdkglo7VYzTasQpbDREdibERumOWhzDxLsHIrOF+tWsdhjLE6xt6JyQoU8kuA9D/dll1g899kLptbKQl7XVIlbVl6BvUQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8MA+ZPN; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ede82dbb63so1360009a12.2;
        Fri, 01 Nov 2024 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730483605; x=1731088405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3OY9nIm82xjsXhQmhAiM1K9cCr4K4RhtHXQO6oqgrY=;
        b=H8MA+ZPNzugq1gsqwnVPh1jIfuV7LVkORmm9gPMUElBxZClAbO5KqTJxdhfPNPtX4a
         lDC7tuyCAUqUqeXAXK3VPgwJTBY5zy4qtds/F27cEh+i6C+8Cbl24RHXieY7vT2/5oaP
         oSAiU0TwVFlKxG4fvph8qX2cpVhBCVQOuDqIIDiSDK93396lqvu9gFAoPjSkm9k/gNW9
         rh9pRqovmfmPJ3sBgAI75KuKA4jPdEnay3Ljm/w973h7FbkqLJXN/pTodBdSUgoYmcAg
         4pLhxS5uMiWEQ7U0IFfCdJD4JFCxedTE8FBdqQOzuHbt0MMFFu6xDQaoB9HuFnHQ2zL8
         KCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730483605; x=1731088405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3OY9nIm82xjsXhQmhAiM1K9cCr4K4RhtHXQO6oqgrY=;
        b=ordmqob/uIafYJhW6ULKdIe/x/07tAoZ4CqnGwKBOWxroad4GN0PxNQCGbpQpBCV8Y
         1iJxQrwnymd2zk1Ujax2csQ/BUGnV/8+W/lVBZ7PWP89zk6Kxz1y/xOstoXDwReo53qY
         AC05SSZ6VoQmatrs8IKYKIsDRO7SoXcdxv0mO1LjiqtQTYdiPvoZBcr3463DuXIAdAyt
         vxQfiyEKLYdKD2P2QACniaSLPwJF6Yn7Y8/nUNbCSuBhd3eSef6Dt+k/g2ot3QrRe9bu
         kdnWBFpZc4F28qd9TGbofYKu50hAz2wefLiwBO4417qhqyCqRlxCBboah7k9XZ5Od1Hw
         ZB8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLPHMaNFh+sU0IHS+m7r9rkialHDHxFq+B0efkjNTbGqs96tEU0r1c1trHcX43popZ8AzBvIYOHcyV0UJ8HXZisXuO@vger.kernel.org, AJvYcCWnGQc47y0lMVrcXanIER4tatFTOpdGR6bIJVxd+whTEGhGcSJwFNbMkIPUJ0t2KlZgbxA=@vger.kernel.org, AJvYcCXhFROcZ5AUUcWEH74N4BwCo0FcbHwc675+kP2ZduwF6DTG5nUiAl3cBjNBzB2GT9sk7dyZ7YTVGD4SvJ5U@vger.kernel.org
X-Gm-Message-State: AOJu0YxFL2EtO0e0A1paDDejHqFQpKDiwpWfg0KRuvjrUiLt2GP7xJzd
	uKWmdrlSSJTFhmLa8m7ndWLOV9VLZYvcSKq1BDYJJxM32kIDe71YJ/qEr8/bJWuVzyTiCTOi01V
	IfEvV7rAS/jhGfx+8wrpk1s12XcQ=
X-Google-Smtp-Source: AGHT+IHfTUfsmp63Mj7wZ3PEaXuqPRQiDWwoKAFTd44o48ZF847PcT1Mb4aVri/3akV9nh45nlY5LemismZK4+fr5Nk=
X-Received: by 2002:a17:90b:394b:b0:2e2:ba35:3574 with SMTP id
 98e67ed59e1d1-2e94c2adb7dmr6069746a91.11.1730483605495; Fri, 01 Nov 2024
 10:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031210938.1696639-1-andrii@kernel.org> <20241031210938.1696639-3-andrii@kernel.org>
 <CADKFtnSvogoT0ArYUqUFaBVUoQN4tfX6i_OdHNc4h2kaYvpZcQ@mail.gmail.com>
In-Reply-To: <CADKFtnSvogoT0ArYUqUFaBVUoQN4tfX6i_OdHNc4h2kaYvpZcQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 10:53:13 -0700
Message-ID: <CAEf4BzZXJdsiUXbm+xGADF6qG2aONgDCq99i99NkK-XW0GB6zg@mail.gmail.com>
Subject: Re: [PATCH trace/for-next 3/3] bpf: ensure RCU Tasks Trace GP for
 sleepable raw tracepoint BPF links
To: Jordan Rife <jrife@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, rostedt@goodmis.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, mhiramat@kernel.org, peterz@infradead.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 8:03=E2=80=AFAM Jordan Rife <jrife@google.com> wrote=
:
>
> Just to confirm, I ran the reproducer from [1] after combining this
> series with Mathieu's from [2] and it ran for 20m with no issues.
>
> [1]: https://lore.kernel.org/bpf/67121037.050a0220.10f4f4.000f.GAE@google=
.com/
> [2]: https://lore.kernel.org/bpf/20241031152056.744137-1-mathieu.desnoyer=
s@efficios.com/T/#u
>
> Tested-by: Jordan Rife <jrife@google.com>


Great, thank you, Jordan! I was going to ask you specifically to
double-check, as I couldn't repro the original issue locally with my
setup (and I was too lazy to mess with custom images and stuff).

I need to send a fixed up v2, I'll add your tested-by.

