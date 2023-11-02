Return-Path: <bpf+bounces-14015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 079327DFB1B
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 20:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A01DB212E7
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 19:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1258219E8;
	Thu,  2 Nov 2023 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRjNz56Q"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB31D200D4
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 19:54:10 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C32DE
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 12:54:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so814835f8f.0
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 12:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698954847; x=1699559647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wt7sYOCabfDTKa4qAVIvhxUVOGUAkfH56wAcPD1+F5I=;
        b=DRjNz56QpEfigXUbvhFYCy2UsYGgJde+BhgP6UNmj+ORJcAVYOLzaA6znvFCaP09nX
         kbPUY2kY1oIcr/Gfn5X1bmVmKnwiTgHqNijETCzSml2YB5Hb6MFZGcxL1JvTG2FiZYBn
         GHp6QinXOqyxjA7OsaepYKGPqmXVrrYby3E9HUAVCD9BdOQ7vRvO/80qq37F236ZYuLz
         l0JXxJIdtdTsKoKIW5/8Eb8MFpGb5YIbYwXF9xpljte5vXjSyyo2H6e9ioPj6WVXuFvY
         5CPV+Tmi8oGTOkCExhYnQRljZ6yKL1gFj37LSuyt2FzDy/U3MTbmeDzIJEPDEtjJN/Gu
         ufrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698954847; x=1699559647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wt7sYOCabfDTKa4qAVIvhxUVOGUAkfH56wAcPD1+F5I=;
        b=tOjdETGyhsRD3DhITpCmRQjDqIZ5iktcszUbVDMhvIJnHxF7JcgV/yubp5fNWkXOq7
         tiF4bzGqtPfmtpkRwI/5V0cXlQUfOJVbXFBwohCY++bxwJEstl0KH6KQMEIuolJv8S4q
         WyDYcWiyAZC9I0TAfJXJhwWZawNGAsfZOxKcYJKE5uja/QFh5zWop/Sa/f6iffkEMvc4
         z31gnuePu3F9j2wOiHIHap4hssUT/WhdV1eshr8WQo0wrbeZe+nEoGyuMNSt2QXMK1Yr
         8gA7EmZbKMaTWfOhucA4Q/OY9fejXTt9CDGb/NwoZ+M8yVEa7esyWd9rKz/0ytefTsJ1
         mV0g==
X-Gm-Message-State: AOJu0YySiSRPx9RJFX2k3kEAq6Cnd1JghtPw0/Ux0OTpElXZtQY/3oTN
	9MKtnKPdPOo546nh42gEmiSLrHwSgApWRNHs+x4=
X-Google-Smtp-Source: AGHT+IEO5HcI1yNQaCuQ4Ua3VDeDjDWZAPWvVobnZkPWendqqYrTyXKJuVe3gM55bFf4ybyzmdHqwV1TmUv1J4b4lQM=
X-Received: by 2002:a5d:4d09:0:b0:32d:9d99:94e7 with SMTP id
 z9-20020a5d4d09000000b0032d9d9994e7mr16542728wrt.49.1698954847410; Thu, 02
 Nov 2023 12:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031012407.51371-1-hengqi.chen@gmail.com> <20231031012407.51371-2-hengqi.chen@gmail.com>
 <6F41D669-AE0C-4CAE-9328-B03BFF7F5643@kernel.org>
In-Reply-To: <6F41D669-AE0C-4CAE-9328-B03BFF7F5643@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Nov 2023 12:53:56 -0700
Message-ID: <CAADnVQ+V_ZVEjrzw80BQjyuf-Y78-raDrOVLSh+CO_G8-Uun-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: Introduce BPF_PROG_TYPE_SECCOMP
To: Kees Cook <kees@kernel.org>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 12:49=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On October 30, 2023 6:24:02 PM PDT, Hengqi Chen <hengqi.chen@gmail.com> w=
rote:
> >This adds minimal support for seccomp eBPF programs
> >which can be hooked into the existing seccomp framework.
> >This allows users to write seccomp filter in eBPF language
> >and enables seccomp filter reuse through bpf prog fd and
> >bpffs. Currently, no helper calls are allowed just like
> >its cBPF version.
>
> I think this is bypassing the seccomp bitmap generation pass, so this wil=
l break (at least) performance.
>
> I continue to prefer sticking to only cBPF for seccomp, so let's just use=
 the seccomp syscall to generate the fds.

That's fine, but let's not mix old things with bpffs, bpftool, etc.
If you want an anon_fd then go ahead and allocate it standalone.
It shouldn't be confused with eBPF fd-s.
No bpffs treatment and no bpftool visibility.

