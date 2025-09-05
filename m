Return-Path: <bpf+bounces-67644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67704B46661
	for <lists+bpf@lfdr.de>; Sat,  6 Sep 2025 00:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDBA1CC5BE7
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 22:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059822F5329;
	Fri,  5 Sep 2025 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXtNFFFz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4186F2877DB
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 22:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757109613; cv=none; b=GUoq9XFvBaIXd+KfvQh2LJt20hHa6Vk+xiXq1D1BFrqAEsGrgKr0YsnQak70FIhiCbacdLRl+z885JZ2TxXwkW/vLzTVjSCVeFNgp9lWBKMH+lbfl2YCJfr9yI7oKV0BVapm0LP8qBDuST/MPzSiPTMPJ5ZA8bOsyVctAU959Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757109613; c=relaxed/simple;
	bh=47WmwHFxwQr5vP/jJ8nmSlh4yukYl1jpyqu5oCpFlvQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CskC9WMaHmkN903380TLkeXPRpZEY23TwzzBZDEDU7yo2MW44l3EOT7c2QgwqAJh77AV4bxCi5aYbGB3olnlk5jNJmhkKkWGV3U09u5gI1Qn5R4d8jk0eOCoG6E5oj6NzMGSV/Wh6qs5uq4/61diVAhmuS0EG/nDvUWXwzgKLhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXtNFFFz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24b1622788dso18973965ad.2
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 15:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757109611; x=1757714411; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X+qLaRMMdaO7U0YTNrs9y/oyInoZuowOTa7hdOk5V6c=;
        b=bXtNFFFzFFCnxRJQuNIr+WhyyWYx2IJJSPm845ddn71XOszdR9i6y7NwxrCr6EtZVB
         +l0YL7gVlzGWRiTGEZjPgm6jfQoF3smP70WwWy/p1o0icm+bcNJBiNCw5RKCgD+qT9lk
         SwKyRC+OfSBpKYJgxoEc2ieAaD03i1ogtvLrI+bH7jpvzwymETQh9PMRS2ebmYgn8t9r
         aCGJqqEPqks552Keli2GUED9ejV62WrahKuXWePmXnlzfZIxonbnsnLuZdWgyqm+wdmJ
         q9zj7Ewc5sQDV5A0R+E7v64kdYMJSqHnwYMUW/X7wDBwTcfrHhn4fzHLwOEU99yKyAGY
         Vbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757109611; x=1757714411;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+qLaRMMdaO7U0YTNrs9y/oyInoZuowOTa7hdOk5V6c=;
        b=L/qS6ZW7jEeq7Cf9hCuu+d93GbIRZXm/14gXOJeti3iIvYVgZCeuDtQnSaCPa0fj41
         p+EMHHDZJBOxf3S5WLJty/DgccNqz1R4syL525M48w5z15IJGzMB19O19QZ8GIRUkMpW
         XwYYkaCI8nHeJoZ4j+RkRMAmGGe6wQaMlnclzW962fUXdU9HuSF6fqTde56cdJqidE4u
         iFsKuauRS90HayFKVI0t3LkHEBnPP/dhyIwPzPuywf4foQJPaLeVemNx7TD2TDhhiAbf
         Vzh5oJViAXWuHlPTfJOcy/KvP4bnoX1k9tp6sbco8qDdtH327acbTI+fMiuD7dkha/Pq
         oXew==
X-Forwarded-Encrypted: i=1; AJvYcCXJraekx6P2RPTzIjg8aeFAp/KVqvhThF2lV3knKBAYh81ac7pX0MCZ21SRHYPxnQheR1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEDQO/Njd8EQ6b0IkEadWaUSMQOuVF2JF9iIey9ohwjrm3gcoD
	i9WCh5OTTN0Cd5m/io+Ms1o1zpkKpCheL1Ij82PuP8L/iN79z8lv8N1d
X-Gm-Gg: ASbGncumDNcc367Qb1dU7FZLWIdTTJiWtrPoFaKTB7eeOEn9AWnPptNR0RKaaLPhw3/
	eVUSLIw+UZM7bQW0EDD45bOfB8AQ/32jVKzApYeGHl0fXjTxfmmx6TOsCb36cUUs9GianynQapc
	DL14jcb643VoOjxyNoE/MJIPip2wmiP7K+aX1fVHik+sfm6FWWiuAdVWIps5m0EQ77ua2dczD06
	yzqegKMwnD9wzJS5F4O8A+0/UX8HInGQnD8Ug2y03Gzaq9B0d0gSg5ubM6Q4n+HPwSGPcqbekUV
	ci1v8bh/XX1TxmHyF6mX1BFOqtSwwnPWwnBamFLcqxGAYL6gUBXXLqGWhSHKKer0uo6fPHcfZQ3
	EtT5B3iSxYvfqayydpmg6H5QLCDMlo9iNYXPIoaM=
X-Google-Smtp-Source: AGHT+IHFpRxSkeL5vP73vckG57P+6vsW43eoX1RoN6lzP+QWKkGNCEqK7BdhsWR/HfxlGB9iO0jQPQ==
X-Received: by 2002:a17:903:2442:b0:24c:b54e:bf0a with SMTP id d9443c01a7336-25166792637mr2570645ad.0.1757109611443;
        Fri, 05 Sep 2025 15:00:11 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b0637d948sm115614635ad.30.2025.09.05.15.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 15:00:10 -0700 (PDT)
Message-ID: <afbadcd26936f5c849a0e8eae66e1d9268453577.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7] selftests/bpf: add BPF program dump in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 05 Sep 2025 15:00:07 -0700
In-Reply-To: <CAEf4Bza5RNDAt0EW4zo27QhHN=qw4CmJakAneCS6T7URxjq-ig@mail.gmail.com>
References: <20250905140835.1416179-1-mykyta.yatsenko5@gmail.com>
	 <ac6e70c96097c677d5689d86dd2bc0dea603a5d1.camel@gmail.com>
	 <CAEf4BzbZg-BqMQV5vKHSDPabZQbpHFbdZhQ4NXCRiAZvh0yc=A@mail.gmail.com>
	 <d38c391c806ed34e9b669e64be4e1c85afdfd6e3.camel@gmail.com>
	 <CAEf4BzawRYXXSJDiK4GzuYo=g-N_-QMgUXQAGN15eaPYuWXBWQ@mail.gmail.com>
	 <84b34c685418234c21bb3c127bb966d5744efc59.camel@gmail.com>
	 <CAEf4Bza5RNDAt0EW4zo27QhHN=qw4CmJakAneCS6T7URxjq-ig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-05 at 14:51 -0700, Andrii Nakryiko wrote:

[...]

> > Yes, but looks like it's a separate binary, not a command:
> >=20
> >   $ strace command -v ls 2>&1 | grep command
> >   execve("/usr/bin/command", ["command", "-v", "ls"], 0x7ffffeaef7b0 /*=
 65 vars */) =3D 0
> >=20
> > (Not that it changes much).
>=20
> You nerd sniped me here :) You get that execve("/usr/bin/command")
> because strace forces the command to be resolved as binary. If you run
> something like execsnoop in background and execute `command -v blah`
> you won't see this execve. =C2=AF\_(=E3=83=84)_/=C2=AF

Interesting, so I should have done this:

  $ strace bash -c 'command -v ls' 2>&1 | grep command

So, it's like 'time' vs '/usr/bin/time' :)

