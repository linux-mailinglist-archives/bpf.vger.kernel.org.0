Return-Path: <bpf+bounces-50299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1DAA24D5B
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 10:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3A31884CFF
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 09:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0F41D5AA9;
	Sun,  2 Feb 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrvKhGb1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EE54206B;
	Sun,  2 Feb 2025 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738489944; cv=none; b=GUejdgo0TQ8r0KkvKWTFLL4KXC2NjnsDTAUFDFCfinWIolMDdUIKnMSjPM/TFGkwWgtujF5Dcq4TG0NK/NO9v6iAy9ThyUpSwSuMfEMqeHuOx/nr50Z3tn/s+pMFNMFxrlQQeA6taMLzIn78nnmkPh8HEitJrBM/5wK2BCPwM5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738489944; c=relaxed/simple;
	bh=qb9/DFI9nYoBurqmoPahK1dZb+j4psKvRZX5VB8//Pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGQQAP13vOW6tb6i6aTjpA0xTePzdWLD72YMIYKbE3tD+RuKJ14Z3jfFdcF0kexADjshrovFUuqjSiN8E3NoYhngTCMkbM8dKR175PC0AJhceu3Cjz8NifqVIV0uPpxBEKeG10fXNr2yqOmUI7sIUxNu69YSWoRcWku00Yb+vuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrvKhGb1; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385deda28b3so1788642f8f.0;
        Sun, 02 Feb 2025 01:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738489940; x=1739094740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qb9/DFI9nYoBurqmoPahK1dZb+j4psKvRZX5VB8//Pk=;
        b=jrvKhGb1Nlm7zK1T4k9FtFJL5h6EjABGtVLVpGJhbFzrgWcHULce2FXWFHvF0yVTRA
         Lz1DvYGOnbl6mrvUV5qZRLUdlEpjq5sKnzb59Umy0c6ShOKvSje75FAe/Wt2T8MD34nR
         34UHP+LI8zeyOnNtLpnxgS5lqksglK0/MUx3MXwLegsFQWI5CxIrkps23Rax4nBVnioo
         Oxp7168QGR/T8tBQbjermaprshL2An6CbGHc2q5g+jN4nsE2CKZcaFTBheKJMJx8tgAX
         qpvPD2THdZbXGAXJUchInd+uuVv5kW1ZzsAF9vtd6deBKLCVccIXFsSq6GnqTrcWVq/a
         cJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738489940; x=1739094740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qb9/DFI9nYoBurqmoPahK1dZb+j4psKvRZX5VB8//Pk=;
        b=YNNZN22G3XweYETXCUM5DIeT05ix8/EoEp8KhHWWORYTI6QRy+rU8qdrxiBqB5AMTA
         QJBMcbYIbJYyTS4XepVQEjIem8AXcywgoS7z3YNH1K5ydRDf8Ak+mD1geYhBppa95Gwe
         EZF9pT+nRFQIOwk/bfIlrwkiev9KPUxOgHHE5T+Dl4YvrVFbDv4mgi4Za7CvOM5L3ugz
         h6XmI0xtLJXzzQo4b8rn+4JZb8USl4OGSW9hct7tvSGnbG9cFKh6EIWhMHsXK0Z/hvhy
         KEnETdH62s3TlDAVJdzFTfP9gLMZ9sTq5nP2li3QVa0aMrjY/D7VPyk87JF0+rlZBRpO
         kjCw==
X-Forwarded-Encrypted: i=1; AJvYcCVo7j3EMQdk3r5/ujs/HzylU4d366h0bNDmMbhH3M2k0OUiPOlrcqnRlbbpqPnzFGBfzEUPD+Q92d4eRJe9@vger.kernel.org, AJvYcCW6RsUHAzghltqbFrJtI7eMoHCGb4LXhDEsuuKR5o99ZoWOor27ZD8S4pu2zev75EeXiAdx@vger.kernel.org, AJvYcCWfIuen48A7Jh7js1Sbqqg4o8YDof7bB1HY/3UoPi5JyYdFNbXbt7b5Tprw5IMuRmK/oEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+P+q+6bWNoXqxltiE+LECDbgnFAOyrr7oB1CVYruy/U+DY2lt
	xLAlcJUgz2KfrKKzrpN45zyAZGEzEoB/USvG5DXB9hE9STLv6oWa/0seOX8RJf4eRiNs425SsW5
	IdNUEgrhhEENMmDCjX3b1LoFoa/8=
X-Gm-Gg: ASbGncsn/bosMuda3hWz+6DmPfE58O49kMRzUq3qGayybM037oiNMg+TqhqjB1KcLyt
	+9Or+nuoh6KMlOq9kAQjnENR3FYHIYGTk/o0yBPkF8FYL2PwIooH51pUlhvsc2k/3Eq4Gn/7kLV
	27mqUZLlkc2JDQ4Abw+rk7oG7QW3D6
X-Google-Smtp-Source: AGHT+IHh74jVcHyqF8d8QrChgP4XIqVdns1XbM//mD/sRWjfaIY4kKasYogP6Svz8R7gk0l6/7Xl1/jH4n/ddj+yUIo=
X-Received: by 2002:a5d:47c9:0:b0:38b:da31:3e3c with SMTP id
 ffacd0b85a97d-38c5194c567mr13301982f8f.20.1738489940362; Sun, 02 Feb 2025
 01:52:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250202074709.932174-1-sdl@nppct.ru>
In-Reply-To: <20250202074709.932174-1-sdl@nppct.ru>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 2 Feb 2025 10:52:09 +0100
X-Gm-Features: AWEUYZnW68ZJi44Hyvle3KYWw3hzCaNuW8M1rFmJEn1gz0jQca3CzxgvNpaHW3Y
Message-ID: <CAADnVQLakHoNDTV8La+TZtJYPtM22cBRJdk8rp498sHjv3+Ctg@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/16] Fixes bpf and rcu
To: Alexey Nepomnyashih <sdl@nppct.ru>
Cc: stable <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <quic_neeraju@quicinc.com>, Josh Triplett <josh@joshtriplett.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 8:48=E2=80=AFAM Alexey Nepomnyashih <sdl@nppct.ru> w=
rote:
>
> Hi, this series backports fix https://syzkaller.appspot.com/bug?id=3Dd4d4=
abdb121f42913b3a149f2d846a7dd7eeb7e2 linux-6.1.y
>
> Here is the summary with links:

Nack.
These are features. Not fixes.
Not appropriate for backport.

