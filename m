Return-Path: <bpf+bounces-62637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B463AFC187
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 05:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCFC1AA494E
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 03:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27068233707;
	Tue,  8 Jul 2025 03:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b+r6Ekcb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E742B9B7
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751945936; cv=none; b=J5eCIzQnjQPS0Z7leGk3QI5mbWKR/UG+Mg85QJdtqu7us+7GTVq9LvFB4g+wkKVUuuSd2FGfJavhJRmfBG3N8GKodV0+vuUmhykj/DKFNKNDs1lUwWhbn1hm24n4eARdpHRGe6LeMI4jjdPjOuoXV3Vz8gLzv6DA70LgWUEN1zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751945936; c=relaxed/simple;
	bh=ngQvRTDNb77/II45kf0Htc4COiMKkjz3h+Tg9M3hNoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pyv0hypkrcpwW7+srsdXhI5O6dVCUJAWlSa/UinLsBmfJ4K7negq7FREmzyqg3+P1VseoxIOrXmTFjIHu7mDN9f10RVUiAz8TPJBTZ6R+EpQEZLW6X/u6bWnjsN8t7bNerwBQNzWRSp8LvcLol39Nb701N7autKsvqV8bJFVc4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b+r6Ekcb; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso7546066a12.0
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 20:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751945932; x=1752550732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OvkINbyTdUcHfBHAuLeuJlwUIwFpUBssPFgUpHXAs88=;
        b=b+r6Ekcbd0b5u9yiyrq2UD17CKjgpp/DHNnt/KTXgFlOP3oew1mzn/itHgLgN8LNZU
         qmoM4PqV+g+QMRvMHLOA2V3suPQbCM1jiK/7cBqSyoyPMxvyJRXSBluKB6KaBkp8wHWx
         SiS3/GIyBRkYyNnN7SQLxN3IepYKtwL7x9RR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751945932; x=1752550732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvkINbyTdUcHfBHAuLeuJlwUIwFpUBssPFgUpHXAs88=;
        b=JyIVyLaO6aJQ1l98Ro7auX8rB7G0t3N7vHVWe2yloR+92+sllCE9opHTYtF6NCshMX
         fN69awLmWWOXCUXcAyr/R+CdrQkB9SRydpRoBVc122W7V5YYsDkIRtlEMiecTGjp/4FX
         GbPKT5FA+3EyKajSyDluHmAydvla1qeO3QtS6ZpIZOPlPWG/lqPcPeVLstT9K9/pEhx7
         shTjFHkHGn3+LqG344k2cgBgVzsQeHiJ+MIlLCwDq0vAK0MXYB7G5+8oig71TZv1Rre1
         wiSxE1byiEU/FWdaGl/15VxWA4G/N17fPG8adftbv/DATUQ1fYzPDKJAGHEBO99g7dzM
         HU9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWtSigXQGgZrWuM3NOu9xhT9cY19QIDI4E3qSJylG3e82m8jYL0kUOb+9SbdozQr+3S8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+d53j7Zhfo1jLOqsygncxB/jXn/nlg42usai8y8I4WeLn/Vt
	9W0JG2Rxb9FlLgd7rNQm0WOBeFRE+Ls+LVpDROsrYdebJeVXEKC4Hx1EhJIxJKhzrk0rN/Z9QzJ
	4AGURhuBYqw==
X-Gm-Gg: ASbGncs8jhtgb7p+biRwYo8YT8XVm0ZO46F0BnpJOVosalnt3XMeCYcgTRaEGVJ/hD3
	Dl9XZSCodh/qvSUpduWtzHaOmbIyMLU9WkOS4K/kJOpc+1gKnWCuEDiVLWLhdo0GWYvLaj2MWCN
	IipIujNt12oahrF30s8/0B8argeQ40orUkSAB7MHjhwUbk74DAWC77Ljl4ZyNokMU56IYsC6gzk
	wLHLhAuBgBeST4x26GNpJCUUlpEeXgmf0PsaQlH/8vnAcKt1Jy39/GwcoAhjTvg2ZpHbjYInEP6
	h3fK2JjJwCFSmpHnrHLdKEIHh0ZJwqzzKNgkUGpoABO6mnBjrOftj9vvXQmRNH+p41G2t1IbZsa
	TEN+mwqfvawCjqvypW0m0fiktQdHoOCx8xdvK
X-Google-Smtp-Source: AGHT+IF7/yRPppC6jOFj4bQ+2ipvS7S33dgdV2IWZhWPkBXDtuJD5SbCVkVGuX/R0E4VFvS7AjUkQA==
X-Received: by 2002:a17:907:6d04:b0:add:ede0:b9d4 with SMTP id a640c23a62f3a-ae6b087336amr130726566b.0.1751945932474;
        Mon, 07 Jul 2025 20:38:52 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b71784sm801498366b.164.2025.07.07.20.38.51
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 20:38:51 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0c571f137so743066266b.0
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 20:38:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7hHZ54VPXe+i6y4bv9jDIH++DiCAPRuJ+LoiMVea/H2bp7GmHQtMQM6CRBw8aK1DbeVE=@vger.kernel.org
X-Received: by 2002:a17:907:c89f:b0:ae0:a483:7b29 with SMTP id
 a640c23a62f3a-ae6b0e7e526mr127666166b.49.1751945931447; Mon, 07 Jul 2025
 20:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708021115.894007410@kernel.org> <20250708021200.058879671@kernel.org>
In-Reply-To: <20250708021200.058879671@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Jul 2025 20:38:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=widGT2M=kJJr6TwWsMjfYSghL9k3LgxJvRard0wtiP62A@mail.gmail.com>
X-Gm-Features: Ac12FXw7XrtMv7eiXSoEnutRZCfRzsH4c97ToPOt-fI15G3BOCR69VhCXEriwaQ
Message-ID: <CAHk-=widGT2M=kJJr6TwWsMjfYSghL9k3LgxJvRard0wtiP62A@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] unwind_user/sframe: Enable debugging in uaccess regions
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 19:12, Steven Rostedt <rostedt@kernel.org> wrote:
>
> From: Josh Poimboeuf <jpoimboe@kernel.org>
>
> Objtool warns about calling pr_debug() from uaccess-enabled regions, and
> rightfully so.  Add a dbg_sec_uaccess() macro which temporarily disables
> uaccess before doing the dynamic printk, and use that to add debug
> messages throughout the uaccess-enabled regions.

Please kill this patch, and stop doing stupid things.

The whole AND ONLY point of using the unsafe user access macros is
performance. You are now actively breaking the whole point of them.

If you need to add debug printouts to user accesses, just don't use
the 'unsafe' ones.

Or add the debug to after the unsafe region has finished. Not this way.

This patch is disgusting, in other words. It's wrong. STOP IT.

              Linus

