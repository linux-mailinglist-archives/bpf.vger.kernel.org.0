Return-Path: <bpf+bounces-76646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23782CC0494
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 00:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AA4230505AC
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 23:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A2433EB07;
	Mon, 15 Dec 2025 23:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPZfpKcN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4802C146A66
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 23:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842381; cv=none; b=JMiNqMfJWt0DUR67iRGRKF4emuUyjfQgZ5S/33hNU5e8zPQ5aPpwc4kWY2buoM1C6Gct709WQcCnFeEwIMbrGYBK3pPs+p6qrmW9d+useOT4ThTRuK5b3teui2tXZtAoZxTBX0yErVJ1DsfE7ZnYlFdthRuC+R/5JgGrSQ6dokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842381; c=relaxed/simple;
	bh=T/dWoOmA8seiD9LVaPuA3F+DGtRpLxYv6LwKd6PeCv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovqIpSj5ImMQCn2XZEnV5CR1SxOdioaleY7OXqv2BOwx+yZseqZspU1XzMspguHo0jKxVv8L4cfUmz46w5HqAonrJ+kEmcuQFylw00x4lrx7GvSENV0PeYXKiz4ue+rIHX9ODpOUDLD3WVOlq0x41NwmZVzOfclv3/mEbKi+kn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPZfpKcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D035EC4CEF5
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 23:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765842380;
	bh=T/dWoOmA8seiD9LVaPuA3F+DGtRpLxYv6LwKd6PeCv8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GPZfpKcNMuKw7pWZrag/b06V6VSB+WYamBcg9wduO/L1mYnkOtIt8P9bmMpPM+BIy
	 25yYKf5kiMiMKpnz39ZKr3fBfbXibM6Mikd2HD0bUCi7ygF3uD3+JSo4tG4YADgTun
	 P2roxpJrDBCt/KfQW5TCTj6uQxBQbLCnmBWfr3rTfJQaQsEec99FbWT+ODLx7CFAY8
	 hSHI1GebQyexoI3EvuqLnQCshbyTOLxEQkUjcDRESlXQUw7tVPh0ItIqr9V2nbCNQp
	 XW/hr0edSwkJjIIHHsj2T+rpTlkHR5ABZ6Au2NQXQ7lKA5RThL7HmtJ2EzBD2EyhgV
	 +mnd++RR+MiBQ==
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4eda6a8cc12so41007211cf.0
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 15:46:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXl7pfIR/jIA/uRG2uVmRRfsyu1ejMr6jarQGt5YZMdTR4sqZlpsSVO/A0Sw1yM5e/puyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWnjQd9QV6rBqQCZ3owjkXjKtkSNUNq3bSXLxziwNJMiaaQHMO
	KL8Nvv8gN6Spn+musj5IVfmoYKPKKuVRS0nc4a+c+94mkNwiqkC8oK2ParKRq0XCi5FgbfD0v+g
	aDshf8EP1YNMJRmsDxu2yZGQeJ6sHK3c=
X-Google-Smtp-Source: AGHT+IH1fCxstY21x+VOAM8OtWbWU3spYIXTZ3ehZ328TQz5b2gYKiDDBRrEYE0RnOwY8EAMI4RzGD77hL/eiysfK6c=
X-Received: by 2002:ac8:5790:0:b0:4ee:209a:a012 with SMTP id
 d75a77b69052e-4f1d0501a48mr185611811cf.30.1765842380011; Mon, 15 Dec 2025
 15:46:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQK9ZkPC7+R5VXKHVdtj8tumpMXm7BTp0u9CoiFLz_aPTg@mail.gmail.com>
In-Reply-To: <CAADnVQK9ZkPC7+R5VXKHVdtj8tumpMXm7BTp0u9CoiFLz_aPTg@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 16 Dec 2025 08:46:08 +0900
X-Gmail-Original-Message-ID: <CAPhsuW4MDzY6jjw+gaqtnoQ_p+ZqE5cLMZAAs=HbrfprswQk-Q@mail.gmail.com>
X-Gm-Features: AQt7F2o31sk9J0LH_kcs6xpKleg3x2YqrNvYoQ60sZoUtzxFq9VPQ5Pro6qaiTA
Message-ID: <CAPhsuW4MDzY6jjw+gaqtnoQ_p+ZqE5cLMZAAs=HbrfprswQk-Q@mail.gmail.com>
Subject: Re: fms-extensions and bpf
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Quentin Monnet <qmo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 8:30=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Hi All,
>
> The kernel is now built with -fms-extensions and it is
> using them in various places.
> To stop-the-bleed and let selftests/bpf pass
> I applied the short term fix:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=3D=
835a50753579aa8368a08fca307e638723207768
>
> Long term I think we can try to teach bpftool
> to emit __diag_push("-fms-extensions"..)
> at the top of vmlinux.h.
> Not sure whether it's working though.

Something like the following works for me. But I am not sure
whether it is the best solution.

Thanks,
Song

diff --git i/tools/bpf/bpftool/btf.c w/tools/bpf/bpftool/btf.c
index 946612029dee..606886b79805 100644
--- i/tools/bpf/bpftool/btf.c
+++ w/tools/bpf/bpftool/btf.c
@@ -798,6 +798,9 @@ static int dump_btf_c(const struct btf *btf,
        printf("#define __bpf_fastcall\n");
        printf("#endif\n");
        printf("#endif\n\n");
+       printf("#pragma clang diagnostic push\n");
+       printf("#pragma clang diagnostic ignored \"-Wmissing-declarations\"=
\n");
+       printf("\n");

        if (root_type_cnt) {
                for (i =3D 0; i < root_type_cnt; i++) {
@@ -823,6 +826,8 @@ static int dump_btf_c(const struct btf *btf,
                        goto done;
        }

+       printf("\n");
+       printf("#pragma clang diagnostic pop\n");
        printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
        printf("#pragma clang attribute pop\n");
        printf("#endif\n");

