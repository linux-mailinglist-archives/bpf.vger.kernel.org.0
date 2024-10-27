Return-Path: <bpf+bounces-43253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6442E9B1C9D
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2024 10:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28646281E71
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2024 09:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5306E126BF1;
	Sun, 27 Oct 2024 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVestXT0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF40178C9D;
	Sun, 27 Oct 2024 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730020506; cv=none; b=MNrzISs4zFhH3yBMIpCvlnDJZdGiwDKpMlQ82lKoIcKFQyFXurYCi4xRUSWERXYUEZbLu4+gmDnUgQTW4s+Ggk4LKe8Y0svhkm9v9hPZVlsiAUyF5Kbgk3r9f9j35Q9BykzwA9yguiFxe4YJdKQY1nI3An2qYkjSO8zS3dTwb84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730020506; c=relaxed/simple;
	bh=k1KsRcgzwFXdAtNAW7/FLWTNb3Q1hSDQbTFJH/oZzh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4IvosVkhSCuKwTiRowMvLmuIBxDPu3EgealNPbvMG6fPc9iVDSXOZsZyDvS+jkyPZG2h7bG08VMXI0JNfTEmnLjzJHCQDeg4RsFY/QRcj75oPNQLESZOIWJcq3XXb5hAZVTCmHQVgmC5EsA9cTTpJ9Z21kJ2+JRQz5ilogwj+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVestXT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A03C4CEE9;
	Sun, 27 Oct 2024 09:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730020506;
	bh=k1KsRcgzwFXdAtNAW7/FLWTNb3Q1hSDQbTFJH/oZzh0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XVestXT0+yhJZgVrcJijfqIAW/B+3ykzbo/hyKArqkTlFYaU6ZbPehpw6Xj2KiVti
	 fHfIfnV5I8PxLAe5DLQSCH4gNM1JKWkC0w+iA+NaU+0ducvrvVegTzFsQFcqnhX9qp
	 3zzwj0ebYagGoW4eUHd8J6h8ZnXnpTVVMtP/nOOMQaYhZazxsmBOLxbPYoEUkj6w7v
	 C2NDvqU3PfYyyVqL2mnreCn/cQRF7smkMkLmF7ZTJKw2g2YyknhTViMNK1nTG5/Qej
	 Diyrsvtuu7PThhvWA4EqCHS0YCLRen4Q4IcK7W+6s9rxVjZQVbmTn0jWxhUE0WbF8T
	 HBGDrNlZL5KyQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so2992472e87.3;
        Sun, 27 Oct 2024 02:15:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4ctrcAJT88JCGtqapTiJJ5KWp1PLQw6Q3EkQfnn185fSqmxDe7XEezzUVJbP2lASob/VqCuUPGVnNgtvmZmXOphgi@vger.kernel.org, AJvYcCVZlNVihg78+KwUdAU1tyHecaBMPQEWH9pLedCZotSGrq4rnhC5kdqb36jaV7q+UqqJmsYaHjir8VKduwGB@vger.kernel.org, AJvYcCWwZh7s0naQ0mFZzbzdURbxCYZq2pUFE5GdlYFtD2F7k996h4dl2IFViOXy6SXRpf121qc=@vger.kernel.org, AJvYcCXO5FlG3b5R0Sn3OdZZqdPAuSSKn6n19wL7qZ2yz7r/VfRwryAauGvVYNZDDO4rVoyDzRIZ+UvTVvjVHQWA@vger.kernel.org
X-Gm-Message-State: AOJu0YwFA0gnMi0MFSN8atGBJciHv4tRh1DuP3vxWY02jI82iz7nuosE
	tnJs1+je8kiyhM13oFGT7AlwIRarGBci/Ibqec/LUiW+L3C4eHGTMG53d7KUFvxnk+vAD7X+7lp
	QNB8XdEH3Xw2bB+4vS4btAjKAe3o=
X-Google-Smtp-Source: AGHT+IGJls0rHOV2LU5nnq3z6pVUca+erZrQxZ96fYuXcWPbiROC4rRHM9ZevPYab7r1XRwF1Pk0540wsseF9JTljFE=
X-Received: by 2002:a05:6512:10c7:b0:539:fcb2:2ff4 with SMTP id
 2adb3069b0e04-53b34b373dcmr1403081e87.53.1730020504955; Sun, 27 Oct 2024
 02:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018173632.277333-1-hbathini@linux.ibm.com> <20241018173632.277333-12-hbathini@linux.ibm.com>
In-Reply-To: <20241018173632.277333-12-hbathini@linux.ibm.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 27 Oct 2024 18:14:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQOPgcPsHJVy7vxfRBX0fowMzOhnZ0RLcoerGMUCGdSGQ@mail.gmail.com>
Message-ID: <CAK7LNAQOPgcPsHJVy7vxfRBX0fowMzOhnZ0RLcoerGMUCGdSGQ@mail.gmail.com>
Subject: Re: [PATCH v6 11/17] kbuild: Add generic hook for architectures to
 use before the final vmlinux link
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	"Naveen N. Rao" <naveen@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Nicholas Piggin <npiggin@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Vishal Chourasia <vishalc@linux.ibm.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 2:37=E2=80=AFAM Hari Bathini <hbathini@linux.ibm.co=
m> wrote:
>
> From: Naveen N Rao <naveen@kernel.org>
>
> On powerpc, we would like to be able to make a pass on vmlinux.o and
> generate a new object file to be linked into vmlinux. Add a generic pass
> in Makefile.vmlinux that architectures can use for this purpose.
>
> Architectures need to select CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX and must
> provide arch/<arch>/tools/Makefile with .arch.vmlinux.o target, which
> will be invoked prior to the final vmlinux link step.
>
> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>


> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -100,7 +100,7 @@ vmlinux_link()
>         ${ld} ${ldflags} -o ${output}                                   \
>                 ${wl}--whole-archive ${objs} ${wl}--no-whole-archive    \
>                 ${wl}--start-group ${libs} ${wl}--end-group             \
> -               ${kallsymso} ${btf_vmlinux_bin_o} ${ldlibs}
> +               ${kallsymso} ${btf_vmlinux_bin_o} ${arch_vmlinux_o} ${ldl=
ibs}
>  }
>
>  # generate .BTF typeinfo from DWARF debuginfo
> @@ -198,6 +198,11 @@ fi
>
>  ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=3Dinit init/version-t=
imestamp.o
>
> +arch_vmlinux_o=3D""

Nit:  unnecessary double quotes.

arch_vmlinux_o=3D

is enough.


Other than that,

Acked-by: Masahiro Yamada <masahiroy@kernel.org>








--
Best Regards
Masahiro Yamada

