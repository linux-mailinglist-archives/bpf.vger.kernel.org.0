Return-Path: <bpf+bounces-53153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9297FA4D08C
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 02:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2564D16C3B0
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 01:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D2A757F3;
	Tue,  4 Mar 2025 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd/ckAhE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B349BE5E;
	Tue,  4 Mar 2025 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050712; cv=none; b=Qy2e7F+jc/xQD2ywpWsnFv6U4jTk59TiVfHPDTfAmiLyI3tWFeXvuRcmSL5+v4j0DjLk7SD0yJvhwCKDWZUqcHWaVQSUVgmUDyl6OOyfRPBHA3PQIxWDOZQcePF3VZvZPQFuaqMOJbBxfWGGJ6Wxef5GQ8C6lG6jHOvy3OMgnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050712; c=relaxed/simple;
	bh=22ZUGvsm1MOkILYiYuUiikpT/81djVg4T133ITjQ2KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBeaqeFm87XvutRzjX20HJvWJnAToYsPjN+mHCMw8UbSzCcOmYVMNF/2mahsE0N5I+jDRFCXKsHL94ITlNKB1TxjZoWmnIK0wVkcosbp8w5a2J5lCNmgONoG33dkn9XxnQoUsCWkURQF0cSCnPdKZsTHPeha9L9GVrNOAxHBotM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sd/ckAhE; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6f4bc408e49so45537807b3.1;
        Mon, 03 Mar 2025 17:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741050709; x=1741655509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vluR2PPVFCeXo4Pv8qn9Rh/dHaN7yGoTkb474FlFpf8=;
        b=Sd/ckAhE8Vj0xCjVUtnD2mPVlpss5ouJrCl2aHHb22DbPyaOaC4D3wafA2Jd6XxsWA
         Aoy1lTNf1TIRdkGO6zF4iKnEOkSq0gjjpIaqxorqCWLTJWWExejvmZb9WsBUfidtwYG7
         LElJ5eln9t3XIBecv5o7DSKv9ydv70v8AmV1T0UiRZ8Lq6KLnXfC6SFw8P69lMX6rqTq
         /nIT/2kEU9atoNeK6c/QrErPPQUQVAdD04amY5CQw62KVWC7vN3CmOqdLbpoqITnrcHX
         hwyiKW9shmHvPJSflmLFOr7RRQ7e3mWg8pvsjEP8HU1HxWzAsnSnkWch4ZHMahWFrRwJ
         laNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741050709; x=1741655509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vluR2PPVFCeXo4Pv8qn9Rh/dHaN7yGoTkb474FlFpf8=;
        b=k4wNTj4+6PEWyKprT6nRV+bx9SnXhD35aeXrSAfeZwlcjdbjwDBt7QaiKDxuP4d2LI
         kwW61t9A/5ANpwOmznqypSNthzM7DHGkyvmg8rsjC6Xo2oNY3Wu8szfmSyfwRWwS6ufB
         ZgkB0cr7uUEobPsuiqsvKGH1r2NA4eNAuvrS37y3aWqxvJj7hxuQDFgdNQzfcKTxCB7a
         TnmVt1L4NPxfFT8bpX/e2k42f6RTl3wY8xWf8vvMsl1l5N0Hx5h3Z8gGMByGufJtN8xq
         Mc3LjLKW/Wy5O25Hrg6FNByeSb4gKmeWOHb+lxJrLZnb22dAx10/FKkb8yc/hr32dNQR
         fxpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWkvoRPAHpslZhPzj9Qgb6kK3P0GeF9MTXEywue5y8wWONYMxl9Ptrfefn1USF7VO2tbjthO+Z@vger.kernel.org, AJvYcCX7a8b/+IheQ+XstPIdiHY00YjFZMJJtGnzQIWZfIObsNQvcSvBIhAF0hpqVxPOQdTuvDPSVQLkWULDVskd@vger.kernel.org, AJvYcCXGt6vIo7OyrXlmSH4Xey/UovdIg5NOBqKyCMatQiQVHGJsxFs4Mhimhwz95EEo5PzgfAJ4Z99NkLXFAaF6uoXoDDLl@vger.kernel.org, AJvYcCXWDMVwNBsRBjHcuKaLZEbfxMZZKOapRVkVGLlWcpoCsZ88z01WpfaNP+obJGotBKo6tsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjMjilQ9dWlsM6EPrXoL4DhGbwkUvNGRpg56FphHkjFfAQBP2
	a5ZCk+2uSy5QOzAoLIcmcfrExW05EI7c/PEPG+fK6lN6WX3/yPGBpe4wgikH7i4XDika5yzOomK
	Ow9EVCEHCFJyWyWEjG9AVs3b0DkI=
X-Gm-Gg: ASbGncuoCsayyIfS71Izmg2ZrwUZ6dUBB1KTn/SbmWyukXD/LLGcab1wFZmF35GLGTk
	3cXmL6RFCkCIxMOo1OB0LspNjbUlwZ5xwmluEmnlJduJ8OBczVvrbwD1McU6KYVtxPXQzxojTIL
	zV8kA4pE8BSJiDVw/1mcP7PnRNBg==
X-Google-Smtp-Source: AGHT+IEqUJezS4KkYf0hWTwJ3JT9iuB+Kta0och/jWyl/2qKN2Gk9IsJypM5kJk2wrbNcnQ46yEh3gTwcTGIDUZLWQo=
X-Received: by 2002:a05:690c:3808:b0:6f9:78c0:3a5f with SMTP id
 00721157ae682-6fd4a10ff41mr214699267b3.19.1741050709491; Mon, 03 Mar 2025
 17:11:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303132837.498938-1-dongml2@chinatelecom.cn>
 <20250303132837.498938-2-dongml2@chinatelecom.cn> <20250303165454.GB11590@noisy.programming.kicks-ass.net>
In-Reply-To: <20250303165454.GB11590@noisy.programming.kicks-ass.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 4 Mar 2025 09:10:12 +0800
X-Gm-Features: AQ5f1JpFMtKlVjq9NnfZ6GpKN1o8CsUv-3k7tk0XiqG3kcbonZw3mKyWyXRBiyA
Message-ID: <CADxym3aVtKx_mh7aZyZfk27gEiA_TX6VSAvtK+YDNBtuk_HigA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] x86/ibt: factor out cfi and fineibt offset
To: Peter Zijlstra <peterz@infradead.org>
Cc: rostedt@goodmis.org, mark.rutland@arm.com, alexei.starovoitov@gmail.com, 
	catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, mathieu.desnoyers@efficios.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, samitolvanen@google.com, 
	kees@kernel.org, dongml2@chinatelecom.cn, akpm@linux-foundation.org, 
	riel@surriel.com, rppt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 12:55=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Mar 03, 2025 at 09:28:34PM +0800, Menglong Dong wrote:
> > For now, the layout of cfi and fineibt is hard coded, and the padding i=
s
> > fixed on 16 bytes.
> >
> > Factor out FINEIBT_INSN_OFFSET and CFI_INSN_OFFSET. CFI_INSN_OFFSET is
> > the offset of cfi, which is the same as FUNCTION_ALIGNMENT when
> > CALL_PADDING is enabled. And FINEIBT_INSN_OFFSET is the offset where we
> > put the fineibt preamble on, which is 16 for now.
> >
> > When the FUNCTION_ALIGNMENT is bigger than 16, we place the fineibt
> > preamble on the last 16 bytes of the padding for better performance, wh=
ich
> > means the fineibt preamble don't use the space that cfi uses.
> >
> > The FINEIBT_INSN_OFFSET is not used in fineibt_caller_start and
> > fineibt_paranoid_start, as it is always "0x10". Note that we need to
> > update the offset in fineibt_caller_start and fineibt_paranoid_start if
> > FINEIBT_INSN_OFFSET changes.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>
> I'm confused as to what exactly you mean.
>
> Preamble will have __cfi symbol and some number of NOPs right before
> actual symbol like:
>
> __cfi_foo:
>   mov $0x12345678, %reg
>   nop
>   nop
>   nop
>   ...
> foo:
>
> FineIBT must be at foo-16, has nothing to do with performance. This 16
> can also be spelled: fineibt_preamble_size.
>
> The total size of the preamble is FUNCTION_PADDING_BYTES + CFI_CLANG*5.
>
> If you increase FUNCTION_PADDING_BYTES by another 5, which is what you
> want I think, then we'll have total preamble of 21 bytes; 5 bytes kCFI,
> 16 bytes nop.

Hello, sorry that I forgot to add something to the changelog. In fact,
I don't add extra 5-bytes anymore, which you can see in the 3rd patch.

The thing is that we can't add extra 5-bytes if CFI is enabled. Without
CFI, we can make the padding space any value, such as 5-bytes, and
the layout will be like this:

__align:
  nop
  nop
  nop
  nop
  nop
foo: -- __align +5

However, the CFI will always make the cfi insn 16-bytes aligned. When
we set the FUNCTION_PADDING_BYTES to (11 + 5), the layout will be
like this:

__cfi_foo:
  nop (11)
  mov $0x12345678, %reg
  nop (16)
foo:

and the padding space is 32-bytes actually. So, we can just select
FUNCTION_ALIGNMENT_32B instead, which makes the padding
space 32-bytes too, and have the following layout:

__cfi_foo:
  mov $0x12345678, %reg
  nop (27)
foo:

And the layout will be like this if fineibt and function metadata is both
used:

__cfi_foo:
        mov     --      5       -- cfi, not used anymore if fineibt is used
        nop
        nop
        nop
        mov     --      5       -- function metadata
        nop
        nop
        nop
        fineibt --      16      -- fineibt
foo:
        nopw    --      4
        ......

The things that I make in this commit is to make sure that
the code in arch/x86/kernel/alternative.c can find the location
of cfi hash and fineibt depends on the FUNCTION_ALIGNMENT.
the offset of cfi and fineibt is different now, so we need to do
some adjustment here.

In the beginning, I thought to make the layout like this to ensure
that the offset of cfi and fineibt the same:

__cfi_foo:
        fineibt  --   16  --  fineibt
        mov    --    5    -- function metadata
        nop(11)
foo:
        nopw    --      4
        ......

The adjustment will be easier in this mode. However, it may have
impact on the performance. That way I say it doesn't impact the
performance in this commit.

Sorry that I didn't describe it clearly in the commit log, and I'll
add the things above to the commit log too in the next version.

Thanks!
Menglong Dong

>
> Then kCFI expects hash to be at -20, while FineIBT must be at -16.
>
> This then means there is no unambiguous hole for you to stick your
> meta-data thing (whatever that is).
>
> There are two options: make meta data location depend on cfi_mode, or
> have __apply_fineibt() rewrite kCFI to also be at -16, so that you can
> have -21 for your 5 bytes.
>
> I think I prefer latter.
>
> In any case, I don't think we need *_INSN_OFFSET. At most we need
> PREAMBLE_SIZE.
>
> Hmm?

