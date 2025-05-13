Return-Path: <bpf+bounces-58076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3939AB485C
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 02:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2473B190C
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 00:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B7817BD6;
	Tue, 13 May 2025 00:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZj+9B8i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D84A932
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747095621; cv=none; b=Non/YUL+OlVB42I5x0R04ySQCMitS0oSabE3Z67y/35fraAeH3zL5HKDRfe1n8oHGmt1+02qFqsKxN9L/nf5d+C2hJ9ty/nzyoNWlfMLKt/hz+9WHTpTQp986p+uutRizjOEPWdr/js7JcpSsy3JjnQfMaymuKdzj/gVa+m4gJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747095621; c=relaxed/simple;
	bh=NrsYW7dmrfW/olXoPJNbS2A+rQSknzPbKO35ugOzzWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyFDmct0xX8Jdm3/1zGjVODp7ljPpjD+yejynuYITOqeKxkm2Kq9FU/PNo4k3J/+yTsAqpD2buw2GVnicfSRe3THQwRtorcx7+AJiA1D7nO3vkKwxsu32aFSrmfJUQhGQT7GlcLS4GyVKtEJ0K1uacC8rOLZIAcTcBuM5HRX60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZj+9B8i; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a0b9af89f2so2978367f8f.3
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 17:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747095618; x=1747700418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoJbmaN4yPVp6cI6Bhf7SUy3mK3fLVybBaB9jyJ/678=;
        b=RZj+9B8isDsSd/kbpY+CnWWeKUNlKzGKzSW3U/pINQ9GDca/9IMCuLJtkjewewfqg4
         PN+HRMHjVyPZ0MjJ7GdMUWI9f7WK2ZzHP8Ubt2866ZFW6MP7cIGNtosvvfFeLq/ur7tk
         R1n13TH6vFQIGJ97jFuDnmnRaJ/ZV3T7qOkerdPyG4wt+urHEzq9l4NqXy2RdIGwyesn
         SJWxSSCn1gSBzUbWbBCdBCGUMKeh+86QpSwIJK0U8p5Ydhb2LXft17W1UXWFX+k0Zv6v
         7pdzmjRXoNaa4Fy0Odmg71+Z/+1dIdfC0ol5ySi+qNicKLDoL1Zzo4iBTJg7GBPvgdhG
         SMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747095618; x=1747700418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoJbmaN4yPVp6cI6Bhf7SUy3mK3fLVybBaB9jyJ/678=;
        b=SmsCbUPg9+Ms6S+Xrc8b2rw4GHppBFPxn85NEEAgIO5hiC8sHc8w/cJcXmfatplNoS
         ynZmMSGQjXwkXWbwAZukeQfWmUjiwwWvWxzV+Q/pz2xGXR4cd4r8/IkI+DDHQmk910+3
         KJ9+arKtMcj76PSKBINcL+TJ5peSwokrrdHXY2fTJbfsqXDTEl7rhnXV2MB4ReRWwACm
         1AfJkrOSS8JkogCxfxCirhmjqL+RyxhoJ8bWYktgZpAVB+i/6qBPq9Wr1TDeq+J0eD97
         KOOUbJCuM2uzPYJP59cK7xU0fgO9cqxsHtTY+adr9vlSPHzRx1ItvEleFBnKGk9Jvd8F
         u9xw==
X-Forwarded-Encrypted: i=1; AJvYcCU7EjfI8yk5uOJLPvFjL9Qq9wWhv9atNRp+y4LVN5a/ghA4kAlKbO2S4LxshCUa3HiBfmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51cwgTis9WL/1lhhaZWEQFhw3G5xfW4SJEDAAzyUcPlyyWAOL
	DwaPgcw+sa4zUcjvpsDR2W4J2JyZXPRt8lRz2RgWbJKs6hVZwTFGUxtofjAbYFrmi2YNG85VA89
	ciEryBy0d2oT6nrEpjUD2uvbnk+E=
X-Gm-Gg: ASbGnctX2s+LJon+m4r34e47QNT4hdVpL/eY3JlJv/yYhWoY+wBHk9WwhwGSSdn/W/E
	pKEH+NfHYNTSHKq9MYSRVgaMIXeb+xATCXlS40G/fgRdmEdZ4dYeSyvEuz8Yv9gXRtUVDLZEV0q
	bUrAMR9P2xIBWWnTP9u79x1Lg2zdqUJYLfk4R3dmPcltE7YbZNH8fiSfxvB+iQqQ==
X-Google-Smtp-Source: AGHT+IGXXzu6Ol+MNqzrjMhnsrwiqAS0bbxJFgJmse3IdBHtbdZSNzl3LBWJf1aloFpAiw4dxJgacsDnXJq2Re68GuA=
X-Received: by 2002:a5d:64cd:0:b0:3a0:b5ec:f076 with SMTP id
 ffacd0b85a97d-3a1f643106amr13171304f8f.18.1747095618302; Mon, 12 May 2025
 17:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <20250420105524.2115690-4-rjsu26@gmail.com>
 <m27c2l1ihl.fsf@gmail.com>
In-Reply-To: <m27c2l1ihl.fsf@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 May 2025 17:20:07 -0700
X-Gm-Features: AX0GCFuXsGBzJrmTbxA4egatEJkp5ObErkT__hys9SvxfxDhdNCg8d2M1wNrwZU
Message-ID: <CAADnVQJZpyqY9TWanRKjmViOZxppAeh7FGAnxV_1CKAih7drkA@mail.gmail.com>
Subject: Re: [RFC bpf-next 3/4] bpf: Generating a stubbed version of BPF
 program for termination
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Raj Sahu <rjsu26@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, 
	rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu, 
	Jinghao Jia <jinghao7@illinois.edu>, Siddharth Chintamaneni <sidchintamaneni@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 5:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
>
> - From verification point of view:
>   this function is RET_VOID and is not in
>   find_in_skiplist(), patch_generator() would replace its call with a
>   dummy. However, a corresponding bpf_spin_unlock() would remain and thus
>   bpf_check() will exit with error.
>   So, you would need some special version of bpf_check, that collects
>   all resources needed for program translation (e.g. maps), but does
>   not perform semantic checks.
>   Or patch_generator() has to be called for a program that is already
>   verified.

No. let's not parametrize bpf_check.

Here is what I proposed earlier in the thread:

the verifier should just remember all places where kfuncs
and helpers return _OR_NULL,
then when the verification is complete, copy the prog,
replaces 'call kfunc/help' with 'call stub',
run two JITs, and compare JIT artifacts
to make sure IPs match.

But thinking about it more...
I'm not sure any more that it's a good idea to fast execute
the program on one cpu and let it continue running as-is on
all other cpus including future invocations on this cpu.
So far the reasons to terminate bpf program:
- timeout in rqspinlock
- fault in arena
- some future watchdog

In all cases the program is buggy, so it's safer
from kernel pov and from data integrity pov to stop
all instances now and prevent future invocations.
So I think we should patch the prog text in run-time
without cloning.

The verifier should prepare an array of patches in
text_poke_bp_batch() format and when timeout/fault detected
do one call to text_poke_bp_batch() to stub out the whole prog.

At least on x86 we always emit nop5 in the prologue,
so we can patch it with goto exit as well.
Then the prog will be completely gutted.

