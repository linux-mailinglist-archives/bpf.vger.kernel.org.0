Return-Path: <bpf+bounces-74627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5539DC5FE9D
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 579BF4E9BB6
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582C71F9F7A;
	Sat, 15 Nov 2025 02:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+03AFaD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F848405C
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763174207; cv=none; b=sbNWU5OVYyBbjh2AKn2itNP8lslPO9vnrDpCMbDtJZ9Wdcb2Ped54RgLbvZarVGlYWreXHZeTP8nW7bmsfJK2b6QedBNPe4PZURASJ6v8MPZ5LQ908Inn+9eAXAF9eGoaMiGJ0Ns8JNo8MW0zYiMwlTmGc5ZIVdPqKwXFAFyRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763174207; c=relaxed/simple;
	bh=8DPpuzgUgLbzWtOUVgscddNrvc/g3niB9nXpK4dm2cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibLZFCQLbfMR6VR+p79hcDTNqmt6oqcBfT3KoEgAT4e1zajQ7g4a6s9mt24CnJVVlKNBUNYKb15Qrnqs9pe8TB71jLibtC0HBcS1YGITZousYVTZntmSbch39fAvO7xYjsDPaEq0uKULta1jeyaM5CtOFZHQPIoLelO5wv+0hls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+03AFaD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429c7869704so1969928f8f.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763174205; x=1763779005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DPpuzgUgLbzWtOUVgscddNrvc/g3niB9nXpK4dm2cc=;
        b=h+03AFaDJRnzpQlxQ7/4y/pcDIma+pjcjvDSvuEqiPVzH6RXGVrpRJQbaCoeU0/tUK
         ojVFPAWIfo833439wa7tdwbPw4Cvf7R+pyvIzbcuRnN4HcEK23pgsyMjRm4I01i/coaJ
         PDY5BAHR8p/u/ga3HGUAJL7iAJuPmOIAi1sS6Fc7jgR+Far6cRA8mV/sJaCPm2Bdxxah
         47eN/GnAd3YyuteRsDo15gmpMwVap+Mad8lhOdYAolnuMlPE8aZlsolCoMne95grRYJL
         2v7ZBDFx1k4xPmNjZirklYLYEUmNq4Jz2q/XeU2H5ufaQBQxUb5xqJu1RHtR0ibjrJW6
         Xa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763174205; x=1763779005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8DPpuzgUgLbzWtOUVgscddNrvc/g3niB9nXpK4dm2cc=;
        b=XJzF+1tBFlHj6ZM/NI7j1zhAYZGElssI3QpR/7MGDrgWr61I0jluDguszVauNxItfo
         oWjWwZ5ExxVme5dcGPNAQR+8rllTEnxhhW3Sl3B9j3vfyc550wVDo2W1EjcUZcsQB2At
         j8XdO98kvNY0wI2vCy9k88JcskjO9/WztF/Y/eGhL0s7vxoADHx/UHwM5EdN3jJgfKAy
         FlighCJQ52q56beI5HLDhgpRIciqYpJuJEQHD14Vx6Yv/qF9tE2afUiuPWqtbUqrTsAO
         P3kilbtaqKKqnJsYlZq4S88gLjpTsAyZv4zEuC+Sr16Dx/RsZfH2o18I2wU7jGZ0WELy
         7QrA==
X-Forwarded-Encrypted: i=1; AJvYcCVxlEUBY5LD64rq95Ol76Zz26bcP7HwiiGTGRFPW7t+nbI5a1k/1HjetTVxKgNhQacr48g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN86eRF02cIlmU87LpKkjrc9KSR+AqkjCOH21B4RnjYUErEPhf
	eKqDCglblKvFP60jPEIsNepkmCyPW85msmxi7VnhikliArTrIRcXRM9tyjbu5xNbpMzxWvTNypP
	8vsHobb964yqEgeapbL28b2lu9s0uPZg=
X-Gm-Gg: ASbGnctRIlSgco+28CqTay1MSr91DlvyEZx4Me9uf4C3m3a1tbzWfxul68XdCpqnwZa
	FAZGGn6L3vbQjklBfmmhOwGqQWWoRCosEfY6S6tynpG4LcH9B9Zf/8NaQcOUGpaT5prb+8AjJCs
	t3yXe/8bphLlvyq27cxFxw23tKcTtRBbDOfUF6uf2U5Bn601pHoVhOczgryBzlI2Rb5C1L0M5sW
	gSrN7KM2mqWDLxn8GDzMrcUq0BenWGlTrrxZ/Ha8396qb6sxYTIv+1ghR0RVT04xLZCLe3NNGHb
	h/unAsDRWjSeSlRS6AFy9WLK9G+jdqyvtOTdp8c=
X-Google-Smtp-Source: AGHT+IGdjVOVft0i9MHawiL9ZDWhmz+Kp8hNgq798cxwuaLgKNAyfuoT8WLgFvbZtt+vmVSsVX969c98h0VHsBMS7ok=
X-Received: by 2002:a05:6000:230d:b0:42b:2e94:5a8f with SMTP id
 ffacd0b85a97d-42b5939dc13mr4661462f8f.52.1763174204734; Fri, 14 Nov 2025
 18:36:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69155df5.a70a0220.3124cb.0018.GAE@google.com> <9537276.CDJkKcVGEf@7950hx>
In-Reply-To: <9537276.CDJkKcVGEf@7950hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 18:36:33 -0800
X-Gm-Features: AWmQ_bmmJRmlh1z3f-9dtHoVzu-qamlHYFnpoSgZGqj_ucK56f7oS9mlr1s9mzo
Message-ID: <CAADnVQK8Viv9DTtfSQTm8T4Nuy2zoUyqRvhqTtzZWNc3By2Xpg@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in bpf_lru_push_free (2)
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>, 
	syzbot <syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:08=E2=80=AFPM Menglong Dong <menglong.dong@linux=
.dev> wrote:
>
>
> Hmm...I have not figure out a good idea, and maybe we can
> use some transaction process here. Is there anyone else
> that working on this issue?

yeah. it's not easy. rqspinlock is not a drop-in replacement.
But before we move any further, can you actually reproduce?
I tried the repro.c with lockdep, kasan and all other debug configs
and it doesn't repro.
Maybe it was fixed already by nokprobe-ing lru, but syzbot didn't notice.

