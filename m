Return-Path: <bpf+bounces-73757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE91C38ADC
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 02:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41E13B82BF
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 01:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33E31E9B35;
	Thu,  6 Nov 2025 01:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzHhomhd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D361E1E00
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762391764; cv=none; b=NtEwZ/2H47X+jDcyiz8jUQZX3+FaEfaULssGC6ZFzskIftssc3K7wJjhY1Ev8wNP5HSDJhjld8rrci9IPDWeqzyVLqEgJ1qSkjIntj9sjkqjL628TKpvpBaDGi9+maTYA1LQosehP06AxiBPRz827LU0dOQJAZpqsA1jK0bEbtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762391764; c=relaxed/simple;
	bh=sScwC5J9gcWja5lx4I7NtcSR1bu3zkgvzjbBKH7PL+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlUbYZEZocu9YgP3/2FB9fZiZI2IjauxEAG5rHSVf91OkvUEQMIT3fi6HILGripQ+pjUAzc0SOVH3fDpO5HxzNWz9GHmWCPs7kSQ9QKB5vYnEyq6y7nyObXqo22FTlpALVHu+qT8/mrTx6hTR0npaHKVX5H/a1LmBJdMFLQ+spE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzHhomhd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-421851bca51so342060f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 17:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762391761; x=1762996561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sScwC5J9gcWja5lx4I7NtcSR1bu3zkgvzjbBKH7PL+w=;
        b=jzHhomhdlmEYwqLjhmAXzuXfkTf5v4CSwXo//4ZyBq9xVNkM9vpS9ew4ydjmLEf9B3
         d8aj9kpMsDkNgGmHARrjtdHUix3Yk6wtNOiTI4RxPtkQFlF72KWeAE15CqXRzuF8KbFU
         UTEW+BibjFbqAOZ1+eN03eR/grg0rabxwhVlQ2jo3J+zxLFfsMpovouJ1TjbQJ8wyaff
         oYueo90g+4bws/ncaFTcMngKGAyUApM3e8otzBk75txVwSmobTxHM5C6Y55Ce31IZerQ
         D0XDYNWhJzAvNpg/jw6M0N52MAyiCmdch43TKcpoPDIqwIhmx9uKWJxHmnBs1+5opBph
         Tgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762391761; x=1762996561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sScwC5J9gcWja5lx4I7NtcSR1bu3zkgvzjbBKH7PL+w=;
        b=nfvLaDTFYEEbaGTImcpjDIoeGiqGJQcjS7Nob76udIdttWsIPlyVD7bsIMcMTtITel
         gM5p04XJ0cIf0Qv/bNt5c4RpIcqYXXQNtPdnxS9iFWxAIQWEhuXTEhlwoK/hFz+KMJ0T
         e4ViaWfeYM61C/3dAxJHVUBeOBpSFkFiw6bfOfT+eaA2It8d0gFJXRBjkUvLZTNaBTxa
         Gq6czuLdcDPRdp5tuhi/BcxD/HKOuWoSfkW7/0NzMFStB39u6dngezEB8B0g8Hv8ayDv
         WUSB4JLAVjWzsR9l0Jjwvw/xCz2hGkV2S1SwX0kJxzNf/EMtJlgIr7alsSGqhOQ9HwIF
         gOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjcmrRBAz0rvjDSwkLLyn1kKWCKPufaEG9RgFu9wLUQIVPXgvri9mWdJFSArFMs0JVaMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPJ22eWnqWZEzThEOErTuSwf7HA1ZD6qZTLou0cjEZHK5PUg/o
	Da4gM25J930fvq6afdEpQGaVAFhBRNPW2HHH/HnDUO1gregB00T8SW/uYWdMam/BPsIemHdhZ9q
	f6Ah4HWQpozt31M4n3Bm+t7dnDPelTUI=
X-Gm-Gg: ASbGnctuY97zhxmlqu8+hcM1AawNN0Tm2yiL1URAz6tLJV2DD4/GLIe2uqksSibTY/N
	GWo6C+eZnAwKaJRqVk3ly/mBBRSMv5/krye0EUmNELi5PUiF1EuGqQZwjXFYzEOJyCa+dYDyL4D
	XFOpWKCZcdvKRYk4fE0BmJnlNHaeeguD7JykcBDBSQcVA7/uCQexv+fpCa5KKW3XldIFp/SEmQs
	RftZ6UaVNDq4VZfjY/HIpnTMtwliPZqRnfZQkVg6bq2jfFm9BHfOut1zG9VUd0qQfITvHDYPFN4
	KizCzUhBklfdWWxO+Q==
X-Google-Smtp-Source: AGHT+IHh2sDshLNmqDEmy7BbJ5cTdAvuAOdPqoxaY2sjpbctDzSymGzC6WNsncDo/8BxKIayC4E9em6MkxZeBSmo1Ts=
X-Received: by 2002:a05:6000:258a:b0:427:526:16aa with SMTP id
 ffacd0b85a97d-429e3311c0dmr4604870f8f.58.1762391760385; Wed, 05 Nov 2025
 17:16:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104215405.168643-1-jolsa@kernel.org> <CAADnVQJRv+2NT2TGd7nXbOtx_Cnsg=kOJuikOtL9aEdUVmwvag@mail.gmail.com>
 <20251105100359.2e6eeae5@gandalf.local.home> <20251105180436.369bef64@gandalf.local.home>
In-Reply-To: <20251105180436.369bef64@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 17:15:49 -0800
X-Gm-Features: AWmQ_bm6CvZzMiP5kwn6kO1G2SRE_SOftXbYCMJwbyDdpH0jhvVrL384rgUxlOc
Message-ID: <CAADnVQLHz5dwn=m5XeA7qc=jvD7Nf96drmKGDsx+o7zK9-GHWg@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] x86/fgraph,bpf: Fix ORC stack unwind from return probe
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 3:04=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 5 Nov 2025 10:03:59 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > Let me run this through my tests and then I'll give you an Acked-by and=
 you
> > can take it through your tree.
>
> It passed.
>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks. Applied.
Will send to Linus in a day or two.

