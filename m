Return-Path: <bpf+bounces-19006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0141823B2B
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 04:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2DD1F25719
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 03:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8041C525E;
	Thu,  4 Jan 2024 03:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="AjCUHK4x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ls6hnRla"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584F11192
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 03:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 167F6C151985
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 19:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1704339653; bh=kLqsJ8yG1OMZIHfAaSbdWWS/8eRrokvBQ3QIWqrJFZU=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=AjCUHK4xT5TsM2HJAcLsXyEC1wfyzRitbDw4wvcWEKhWrv2dD4BZFoyoTfMtLyBq7
	 qyb7asJIVdvfGl5QAcUCkZvnY/9KyUMRI2EH6sGB90/BA/AB2vNCehxkpuOzzYv/tm
	 UYeWhcsO62N3pZz+4UAbmuHjJBCfm1iPFheJF1qk=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Jan  3 19:40:52 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 49475C14F74A;
	Wed,  3 Jan 2024 19:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1704339652; bh=kLqsJ8yG1OMZIHfAaSbdWWS/8eRrokvBQ3QIWqrJFZU=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ls6hnRlan7V21dhSMCsGY9o/0+VwTCp5go34dW4Uvt6tY0v2Bfg9a920q+PZYBU1n
	 32ax4HUaYJDawmlUIAGfMiibrFdMGqXg/UPy/oQVz1yYo8VXM+pL/ATDZOvmwHKsHg
	 PZyCfkCjefT2C0uJt+lSHJbpZBsehniFqni/gTag=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 12E8BC14F6B2
 for <bpf@ietfa.amsl.com>; Wed,  3 Jan 2024 19:40:51 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.41
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HvAey-FSWz-Y for <bpf@ietfa.amsl.com>;
 Wed,  3 Jan 2024 19:40:46 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com
 [209.85.219.182])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 8094DC14F74A
 for <bpf@ietf.org>; Wed,  3 Jan 2024 19:39:58 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id
 3f1490d57ef6-dbd99c08cd6so113683276.0
 for <bpf@ietf.org>; Wed, 03 Jan 2024 19:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704339597; x=1704944397;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUqPSUfrIPOL1uXR1pm95hr2+CVxs8yp09wLUY6ssNo=;
 b=r6LS8LbLc7+uoSF3DHMM18QQ1wwat0x3cOybLJ0t2a5zWmMeiBi3Y+JFPmoz+p4Mxj
 KmC2P9Jbqo9E4zIqiTMhD0fnhzG8Ee/P7xigz1J/xOO4RVo+MRkuH/nPUkX1OKmb9M3H
 Bd6UZ74EHP99N8PP4busdoXfN7gW4x/tAU+4y688Qlb+9ycnuGRsMYNqlyaXq0HwuBWU
 aOMPF4QXkty0V5xQH98HKRH04s5LM3/ShTimEQUOCXRYeKRe+uwHo8gfSM/Qbf2SK5xI
 pm5z45lSq9OhBefjiV/d/4lwf5aO52Cqk2uPZhogwVEigaxvpGecPp5f2un557fHDupm
 QOtg==
X-Gm-Message-State: AOJu0YwI+Z4Rmnb7gm+Mnon+iB75d/2n3fUvUhlJWUd3Q6iAs86ASHxh
 gNdniAw8TDFmok1eVvx34oY=
X-Google-Smtp-Source: AGHT+IFO+87vWRR8RS1szy3Pcb6hJD5nj6OhfAJKpOjoGCYle6aBaEw+ugceWsf69tgOiyF8F8midA==
X-Received: by 2002:a25:dc44:0:b0:dbd:b5e8:6303 with SMTP id
 y65-20020a25dc44000000b00dbdb5e86303mr28494ybe.108.1704339597434; 
 Wed, 03 Jan 2024 19:39:57 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 dm6-20020ad44e26000000b0067f6ec98ae9sm11406751qvb.32.2024.01.03.19.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 19:39:56 -0800 (PST)
Date: Wed, 3 Jan 2024 21:39:54 -0600
From: David Vernet <void@manifault.com>
To: "Aoyang Fang (SSE, 222010547)" <aoyangfang@link.cuhk.edu.cn>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "bpf@ietf.org" <bpf@ietf.org>
Message-ID: <20240104033954.GC303539@maniforge>
References: <F349E672-63EB-4DA3-84F8-45E360E02594@link.cuhk.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <F349E672-63EB-4DA3-84F8-45E360E02594@link.cuhk.edu.cn>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/NKuGJKZydvYcfEQL9d6wNwunUw4>
Subject: Re: [Bpf] [PATCH] update the consistency issue in documentation
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============4063553787746461150=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============4063553787746461150==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1brf73tkHEfxX8Ia"
Content-Disposition: inline


--1brf73tkHEfxX8Ia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2024 at 03:09:32AM +0000, Aoyang Fang (SSE, 222010547) wrot=
e:
> From fa9f3f47ddeb3e9a615c17aea57d2ecd53a7d201 Mon Sep 17 00:00:00 2001
> From: lincyawer <53161583+Lincyaw@users.noreply.github.com>
> Date: Thu, 4 Jan 2024 10:51:36 +0800
> Subject: [PATCH] The original documentation of BPF_JMP instructions is so=
mehow
> misleading. The code part of instruction, e.g., BPF_JEQ's value is noted =
as
> 0x1, however, in `include/uapi/linux/bpf.h`, the value of BPF_JEQ is 0x10=
=2E At
> the same time, the description convention is inconsistent with the BPF_AL=
U,
> whose code are also 4bit, but the value of BPF_ADD is 0x00
>=20
> Signed-off-by: lincyawer <53161583+Lincyaw@users.noreply.github.com>

Hi Aoyang,

Could you please resend this patch to the lists in plain text? The Linux
kernel mailing lists will drop html-encoded emails. Please see [0] for
more information. You can just use git send-email with a patch file as
follows:

$ git format-patch HEAD~ --subject-prefix=3D'PATCH bpf-next' HEAD~
$ git send-email <patch> --to bpf@vger.kernel.org --cc bpf@ietf.org

[0]: https://docs.kernel.org/process/submitting-patches.html#no-mime-no-lin=
ks-no-compression-no-attachments-just-plain-text

Please make sure that the Signed-off-by tag includes your name and real
email address as well.

Thanks,
David

> ---
> .../bpf/standardization/instruction-set.rst | 34 +++++++++----------
> 1 file changed, 17 insertions(+), 17 deletions(-)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index 245b6defc..dee3b1fa8 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -355,23 +355,23 @@ The 'code' field encodes the operation as below:
> =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> code value src description notes
> =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -BPF_JA 0x0 0x0 PC +=3D offset BPF_JMP class
> -BPF_JA 0x0 0x0 PC +=3D imm BPF_JMP32 class
> -BPF_JEQ 0x1 any PC +=3D offset if dst =3D=3D src
> -BPF_JGT 0x2 any PC +=3D offset if dst > src unsigned
> -BPF_JGE 0x3 any PC +=3D offset if dst >=3D src unsigned
> -BPF_JSET 0x4 any PC +=3D offset if dst & src
> -BPF_JNE 0x5 any PC +=3D offset if dst !=3D src
> -BPF_JSGT 0x6 any PC +=3D offset if dst > src signed
> -BPF_JSGE 0x7 any PC +=3D offset if dst >=3D src signed
> -BPF_CALL 0x8 0x0 call helper function by address see `Helper functions`_
> -BPF_CALL 0x8 0x1 call PC +=3D imm see `Program-local functions`_
> -BPF_CALL 0x8 0x2 call helper function by BTF ID see `Helper functions`_
> -BPF_EXIT 0x9 0x0 return BPF_JMP only
> -BPF_JLT 0xa any PC +=3D offset if dst < src unsigned
> -BPF_JLE 0xb any PC +=3D offset if dst <=3D src unsigned
> -BPF_JSLT 0xc any PC +=3D offset if dst < src signed
> -BPF_JSLE 0xd any PC +=3D offset if dst <=3D src signed
> +BPF_JA 0x00 0x0 PC +=3D offset BPF_JMP class
> +BPF_JA 0x00 0x0 PC +=3D imm BPF_JMP32 class
> +BPF_JEQ 0x10 any PC +=3D offset if dst =3D=3D src
> +BPF_JGT 0x20 any PC +=3D offset if dst > src unsigned
> +BPF_JGE 0x30 any PC +=3D offset if dst >=3D src unsigned
> +BPF_JSET 0x40 any PC +=3D offset if dst & src
> +BPF_JNE 0x50 any PC +=3D offset if dst !=3D src
> +BPF_JSGT 0x60 any PC +=3D offset if dst > src signed
> +BPF_JSGE 0x70 any PC +=3D offset if dst >=3D src signed
> +BPF_CALL 0x80 0x0 call helper function by address see `Helper functions`_
> +BPF_CALL 0x80 0x1 call PC +=3D imm see `Program-local functions`_
> +BPF_CALL 0x80 0x2 call helper function by BTF ID see `Helper functions`_
> +BPF_EXIT 0x90 0x0 return BPF_JMP only
> +BPF_JLT 0xa0 any PC +=3D offset if dst < src unsigned
> +BPF_JLE 0xb0 any PC +=3D offset if dst <=3D src unsigned
> +BPF_JSLT 0xc0 any PC +=3D offset if dst < src signed
> +BPF_JSLE 0xd0 any PC +=3D offset if dst <=3D src signed
> =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> The BPF program needs to store the return value into register R0 before d=
oing a
> --
> 2.42.0
>=20
>=20

--1brf73tkHEfxX8Ia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZZYoigAKCRBZ5LhpZcTz
ZAiTAQCGSefNSKJEKIHA2oxbXKhV97CnsS7R5/MQANdhe+Qk+QEA4ziQyYdU4Zjs
gSjkFSZtyJ1D0ZbmxzLBSMVQq+/EIAM=
=NYDe
-----END PGP SIGNATURE-----

--1brf73tkHEfxX8Ia--


--===============4063553787746461150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============4063553787746461150==--


