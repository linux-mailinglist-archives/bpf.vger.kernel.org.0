Return-Path: <bpf+bounces-21943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF47854198
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 03:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB2C1F2A485
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 02:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24797B645;
	Wed, 14 Feb 2024 02:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPpONUQZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F378F8F56
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 02:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707878755; cv=none; b=NYIJsNiDV8xYCIvmXHYieTQZtowJwzIyL5UwBKkCLrfpJt+GdwPaMbE9hqtLRuTtDF0d/b0xtZbOC1tJucJIyHnZkUNy8JAmrTnfwvOxtdZBrZdzELfvH/Z8SEvgB+B/NTWcIWEy4UZHqwTPs5KtmC9HDEZhNKKihEmt2bWz2LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707878755; c=relaxed/simple;
	bh=o5DTkd7ULyihymkuwOkvQHw4EkE4LyVFYETLHBa9kIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvJltB49jOFeUFNIf9VWZ62VjxaGT7rMG9r+ynm+yqZlmIkzhwxGBqY7CEgW0yl9jZiCK3NnOksv58Gp5sUFbATTuTC6Hpxx/u+PKOJ0vKQ9W95iQpGfCDjRb5O1/ng0rlZcrEGf0OTxL2MpkXxTB8cAD8otVGacRaqJEVrTvY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPpONUQZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33b29b5ea96so138906f8f.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 18:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707878752; x=1708483552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEluJz/8cGGKVFyjzYVeh7y3m5ULmKhtpErc8O50rz4=;
        b=bPpONUQZrjDX11EI9MiGFUbSaaEC8L/2HLv/c0I/Qo5+TMX0k7ibd/5aTY+/XrAX6g
         JUDhMu+YUwLgiwL43njsevchd9E0EokjMPI7x9+4OqFzeKWUfGo9GugGWJUHBnU0uKbS
         p6vmdaE9O7hxQ+dxWvKJTC8YZquPyE/iKID1U4PBfbZDRb8kxVMDO5Jkbt3h0NXG20MD
         /ZJCf/SIfB/FyGP2iMIYpqH011CrfvNEVmFIbG2UW0UDK9oMaPbQI+9hJWDFgU87KJ/E
         UJQ0mD8vi8vz683zbD6V4VzsMQZuptzvZOuxJa8hk6CUlwCMpdKJOsi3WJwRN4MEQ7qT
         bkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707878752; x=1708483552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEluJz/8cGGKVFyjzYVeh7y3m5ULmKhtpErc8O50rz4=;
        b=mH6iSgPkYYxBgkDm6sLFjn/C9WJ/FX7aQYxo/1AneJKCBKAgt8SK4YanCgJ+hVe7ln
         ST/o3BS5c2rR8hHzV+4j0uT4vwqudRlTiy9tIItmKzabJxFE+yOD1+izCcw5KtcIz28J
         Gj7B3HJ2TsGJGip/CaddCsTIUDKwABnvuOA1H7niK9vu9ahdZFRaWpnuCVpBjIvjBEj7
         Fvzx546pTlqxzI/5xTFjK0spNWTAc0GCAVUYFLNa/pkGwUlhN2ozSr8FnQx35r642/J9
         ElPKQ24vjIa5gwRmrbAGRcyCCVVYG1t0vmfbnl1W32wT20e9rZ8WExZGJJs40uOmywnP
         Jg3Q==
X-Gm-Message-State: AOJu0Yz8TN1qwyuEtK0NVgK0bJZ3HGQhsxGxp/HsgDDsclJhEA1tn0x3
	sgiI30BHkE7EcPLdPbFJLHlrdcSCj6e5LnwfzOWx3CHlaQSQG7VwQqtmbZhZW/B2MAZA9tZSWMJ
	DhZaAyKBY0eFFO5LDuA2m2pGovfc=
X-Google-Smtp-Source: AGHT+IFtYnr6wIkD9xJta5yh9L78D2fPgCMgkIJXFHnj1cAZt31ldtE3+ToaNAy1cnD0sw9Tr/4VGsC4WeT7Kebobc4=
X-Received: by 2002:a5d:522d:0:b0:33a:f503:30b3 with SMTP id
 i13-20020a5d522d000000b0033af50330b3mr452513wra.24.1707878752045; Tue, 13 Feb
 2024 18:45:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213175141.10347-1-dthaler1968@gmail.com>
In-Reply-To: <20240213175141.10347-1-dthaler1968@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Feb 2024 18:45:40 -0800
Message-ID: <CAADnVQLffY3C-qmuiQj=beiFM1Q0UAeVtKmc=e=8SO6t6H+9jA@mail.gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next v3] bpf, docs: Add callx instructions in
 new conformance group
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 9:51=E2=80=AFAM Dave Thaler
<dthaler1968=3D40googlemail.com@dmarc.ietf.org> wrote:
>
> * Add a "callx" conformance group
> * Add callx rows to table
> * Update helper function to section to be agnostic between BPF_K vs
>   BPF_X
> * Rename "legacy" conformance group to "packet"
>
> Based on mailing list discussion at
> https://mailarchive.ietf.org/arch/msg/bpf/l5tNEgL-Wo7qSEuaGssOl5VChKk/
>
> v1->v2: Incorporated feedback from Will Hawkins
>
> v2->v3: Use "dst" not "imm" field
>
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> ---
>  .../bpf/standardization/instruction-set.rst   | 31 ++++++++++++-------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index bdfe0cd0e..4bba656b6 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -127,7 +127,7 @@ This document defines the following conformance group=
s:
>  * divmul32: includes 32-bit division, multiplication, and modulo instruc=
tions.
>  * divmul64: includes divmul32, plus 64-bit division, multiplication,
>    and modulo instructions.
> -* legacy: deprecated packet access instructions.
> +* packet: deprecated packet access instructions.
>
>  Instruction encoding
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -404,9 +404,12 @@ BPF_JSET  0x4    any  PC +=3D offset if dst & src
>  BPF_JNE   0x5    any  PC +=3D offset if dst !=3D src
>  BPF_JSGT  0x6    any  PC +=3D offset if dst > src        signed
>  BPF_JSGE  0x7    any  PC +=3D offset if dst >=3D src       signed
> -BPF_CALL  0x8    0x0  call helper function by address  BPF_JMP | BPF_K o=
nly, see `Helper functions`_
> +BPF_CALL  0x8    0x0  call_by_address(imm)             BPF_JMP | BPF_K o=
nly
> +BPF_CALL  0x8    0x0  call_by_address(dst)             BPF_JMP | BPF_X o=
nly
>  BPF_CALL  0x8    0x1  call PC +=3D imm                   BPF_JMP | BPF_K=
 only, see `Program-local functions`_
> -BPF_CALL  0x8    0x2  call helper function by BTF ID   BPF_JMP | BPF_K o=
nly, see `Helper functions`_
> +BPF_CALL  0x8    0x1  call PC +=3D dst                   BPF_JMP | BPF_X=
 only, see `Program-local functions`_
> +BPF_CALL  0x8    0x2  call_by_btfid(imm)               BPF_JMP | BPF_K o=
nly
> +BPF_CALL  0x8    0x2  call_by_btfid(dst)               BPF_JMP | BPF_X o=
nly

Sorry, but this takes it too far.
This is way too early to define exactly what callx will do.
Especially with all the flavors.
gcc/llvm generate callx when it's an indirect call.
PC +=3D dst and other combinations don't match to what real CPU would do.

let's reserve callx BPF_CALL|BPF_X with any src_reg and imm as reserved
without defining what it does.

pw-bot: cr

