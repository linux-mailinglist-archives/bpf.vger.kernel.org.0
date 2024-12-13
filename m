Return-Path: <bpf+bounces-46910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3699F183C
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4271681B0
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 21:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26721A8F60;
	Fri, 13 Dec 2024 21:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzEGZgAO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BAC1A3AB9;
	Fri, 13 Dec 2024 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734127129; cv=none; b=bZrkZ5/Ko/f61ST32zSIXCvJF1u7QC/sn7+6vz4tagfjGdqG1qwa0s7jSBCjCYna1o/sOTCxXxqAZc7VSfcBQC/4Od9luF4E5hJs+LhK5oUFVhcPhgTptCmiE90O0Tm25i5uXih90MzNZAE8wA+bSg57WBxIs78JGXUDA4KbOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734127129; c=relaxed/simple;
	bh=whKzvbHiKxeCC/3rYer/rnbGk9+z3mtKdtOT1BsRhR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAv82Q/8dDNwxCqpWwZLZ6Jeu64G7e4qZTJhCkZNyN8I220kr+RTQcs87iruj5CNuaIszjG5hE7A5J3bXBn2OluvtZ8peP/6D7KkCIVQ2VTrNBKdUYCtzOxrXLXHniLhMZhj74YTMVcKvJFzunJQdzF9gmeJlWSs/6GfIjNbUsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzEGZgAO; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fd2ff40782so2026239a12.2;
        Fri, 13 Dec 2024 13:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734127127; x=1734731927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yr95RUakwEcPleuuqmspeANUs7SIhOoZhl1wCglUQN0=;
        b=BzEGZgAOJCPzPGIlJPbIzOy+yjmr/0rvS5OR7uL57hGFxSlWjwRxn2/ATfsnv+auMQ
         ZXa8wHeDRRDV7OxUIm3/nou1pceDALVy5tOE+H7EMvL9RMjX+GefUqHdCBNhf3j/Ao0z
         R6oeSXP2Fj4jPsanDvcWz0fUn7t7AvMH5liEe1UtzdJtUdCmRYuE8ra/Ng/QebLAq/Gl
         Fj4Na0YO5V2tb+hvYWrXoi0IuyZ2oSlc9oHsUlslBd2M9/iWVYRhBB8Wtqs6gfSQ5SdG
         VZCxAaCCGaVufo/to/mlaMk/+foEtRy52jJ2pufFpRaA1dyxjZ1JAck9BbAojRU2bjzc
         itRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734127127; x=1734731927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yr95RUakwEcPleuuqmspeANUs7SIhOoZhl1wCglUQN0=;
        b=HLiMV1Psvr52kBUOmzFB7XJDS36of9XHnSCnWVNouQRr6JtNSRYkS6idCYf2DsPImE
         c9mdMl84HopgF4GjZNnINl+iLLT/QivOyHGJVuK4b6fjV++WqYQT2jC6N0qZB1NkXYye
         bnlS90sfqw6dlqgzTOTNds232ei0t8KAYw6RaOvU9Szf1XM947SdAFOuqoqoinNZSSDf
         7MYNf3MBu/lFw+kD1MckrpXuBbqgsSz+79Ja4ArxYqk3596zPq4wySkWNG4MtNBAcki2
         c6I/gv3EH1cN4oWJEJAy6yzZbsS969SK/CTMck9CLpgzhUYCHLUmiTsurPXBTwrzQ3RU
         rgtg==
X-Forwarded-Encrypted: i=1; AJvYcCUkAbTqHKEmuSa49p+34oUkWoQ4amzREaa0vrYeE/UdOCuGbEZijTF0e9kL2TXFMJJhMbI=@vger.kernel.org, AJvYcCXLc41Ou4qNrbIuhy9QSmWQRMabRIPAWwxL/d1ppCF8hBkkbsqibW2tsvCNE0N5BoRZB79fvn75LlfVXIIjDMb52ZsJ@vger.kernel.org, AJvYcCXiwNPX2P0UK+ymhGHaw8qGYdAMln62WVPskOxU5OPVEurwYYQPFBZkCrGVpMcAsof3lKSlQZ0GBf1fcCvz@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxI5dy834yJXU5RbCmRB3wteHFx7hJf3opyR0t088hGMUr9Ik
	7UlFmWWMYOt2tQp92bxXgSh8vWQ6Nqb4UUHebLEi6ph8q7JERBdq+j/GPzxaUGW+PFtGTADezBt
	uS1U1wSWztb4i2gpQLyBeY35ABbs=
X-Gm-Gg: ASbGncsKhqf4NI2Lhv2edZO5c8mn8wB8zVRsyE9nlabDmcRp5xtaAwlAh3ydvz0M/RR
	xyBJ3dr3mdHGdmobpdEoZ3/lXF5iDbknuG8F0UlhWzwtM2m8yjz4uiQ==
X-Google-Smtp-Source: AGHT+IGjpAI6TNcQvZLKYATRAnjHfbUhSkYX2nSqoGzZDWwVKddJKODkvdwcIFYS8B2iYD341Rv0x6QfkePn2Ru1ip8=
X-Received: by 2002:a17:90b:1d51:b0:2ee:c4f2:a76d with SMTP id
 98e67ed59e1d1-2f28fd6cd00mr5620194a91.21.1734127127330; Fri, 13 Dec 2024
 13:58:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211133403.208920-1-jolsa@kernel.org> <20241211133403.208920-10-jolsa@kernel.org>
In-Reply-To: <20241211133403.208920-10-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Dec 2024 13:58:33 -0800
Message-ID: <CAEf4BzbF1Ei-MkKOM9N2nCRspVXpVLhpAYZFaaOUpDJ4HgJ6jA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/13] selftests/bpf: Use 5-byte nop for x86 usdt probes
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 5:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Using 5-byte nop for x86 usdt probes so we can switch
> to optimized uprobe them.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/sdt.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>

This change will make it impossible to run latest selftests on older
kernels. Let's do what we did with -DENABLE_ATOMICS_TESTS and allow to
disable this through Makefile, ok?


> diff --git a/tools/testing/selftests/bpf/sdt.h b/tools/testing/selftests/=
bpf/sdt.h
> index ca0162b4dc57..7ac9291f45f1 100644
> --- a/tools/testing/selftests/bpf/sdt.h
> +++ b/tools/testing/selftests/bpf/sdt.h
> @@ -234,6 +234,13 @@ __extension__ extern unsigned long long __sdt_unsp;
>  #define _SDT_NOP       nop
>  #endif
>
> +/* Use 5 byte nop for x86_64 to allow optimizing uprobes. */
> +#if defined(__x86_64__)
> +# define _SDT_DEF_NOP _SDT_ASM_5(990:  .byte 0x0f, 0x1f, 0x44, 0x00, 0x0=
0)
> +#else
> +# define _SDT_DEF_NOP _SDT_ASM_1(990:  _SDT_NOP)
> +#endif
> +
>  #define _SDT_NOTE_NAME "stapsdt"
>  #define _SDT_NOTE_TYPE 3
>
> @@ -286,7 +293,7 @@ __extension__ extern unsigned long long __sdt_unsp;
>
>  #define _SDT_ASM_BODY(provider, name, pack_args, args, ...)             =
     \
>    _SDT_DEF_MACROS                                                       =
     \
> -  _SDT_ASM_1(990:      _SDT_NOP)                                        =
     \
> +  _SDT_DEF_NOP                                                          =
     \
>    _SDT_ASM_3(          .pushsection .note.stapsdt,_SDT_ASM_AUTOGROUP,"no=
te") \
>    _SDT_ASM_1(          .balign 4)                                       =
     \
>    _SDT_ASM_3(          .4byte 992f-991f, 994f-993f, _SDT_NOTE_TYPE)     =
     \
> --
> 2.47.0
>

