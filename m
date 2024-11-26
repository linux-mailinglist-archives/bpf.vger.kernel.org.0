Return-Path: <bpf+bounces-45651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2EC9D9E7C
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 21:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96500281A7A
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 20:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE0B1DF27C;
	Tue, 26 Nov 2024 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1tZ6HHP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728B3946C;
	Tue, 26 Nov 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732654065; cv=none; b=guLlJsutemi31AERSxd6ligIe++tXMsTAG3I5osGE2/ow6RZQuDoybst82OCphGN7WEgsUFTntqOgBt/g0QI1PCNBDKLRzpOrYjfWI7UNd5Fk8fCrXASYQyZ3fArR36WnIHZx947lfVIPo/fgpKgNLbh69KePp6n9fgeePtQmaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732654065; c=relaxed/simple;
	bh=faBfcmymGPSFibu9nkUfQwNarQQpruvPOzB3wGv4z0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwZ1RGSWnYMPVsKONy79csuDmqmZqNrVgtdMO7ty/3hxAKjkvWZYjJtXaB0Z6A0drEvSnRw6IU1BoNKKd2djCl6xlg9D9ZWVuZiVowNdH3DBKuPXd//3+sr2VMGFg6TT2GaLQbUET8AsAa+AGFC7olWAVTksHFJKFk0jBbBNjaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1tZ6HHP; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ee020ec76dso5222753a12.3;
        Tue, 26 Nov 2024 12:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732654064; x=1733258864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BrfGITBt+MpPudeTvWz/BGOrTPxjx+M/EOPqV0lY91c=;
        b=P1tZ6HHPc9pZS2/sbMYn0rQf6XNuaskRE1jCzy4sx9SEMcwkGeiInFAeV07GEQOLNr
         FQyD3xABBH49QTxTzhJ5I7fWP5nxkHXAATyP6tXnS0jdBrb+0SRLPt6mDBrPA64YxRBn
         6y0lbb6nDIoUGFQnnJNBfDixY4XTSFmq2bBpu2DpaSS+Z7M21Is+RHZmWovfPKkV3zpx
         qrzxOi9cbcPEv/fvfUauloi6mI751CRB4IRe6ghthFxWiI587TPTBNTqV6JNYE1LukHP
         5a+aTbKC1V8UZ7+b8GiorkZcp1ZFQOjKa0vaPqF4QFsjW0B/pWlooc8uvcLtK9DURgjD
         Mtsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732654064; x=1733258864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrfGITBt+MpPudeTvWz/BGOrTPxjx+M/EOPqV0lY91c=;
        b=wOAu4gyxj2LYbZmpYjvG65UWoy2tftwcChtNoke18eHMzQBhFS/QgX2TDyrj5vf3Tc
         P6o8BbYUlM15RZ9x6xmjpHXYFakXXUqOz8a6FgdllICo376t54RQ4k2xZgkti+eCs+IG
         BQ54ZHDa26zJF8bi9N9vGJxIknLfy617KRGjjSsjBjwStDay+blz1gqZsMcOA8AbzjGb
         sqE/GDJgKOpBtzLrCfV0+N31RS+BqPwcnKcB2r/IENbDsjmK3MbsgYQEmC5SznLbDEDQ
         b/RhcWSKmxsIskyUS/mGjZ8jnSTbJKkfbXYjDXWz74n7cQw6CBu5981K/imLPCNHTS1Q
         wseg==
X-Forwarded-Encrypted: i=1; AJvYcCUm1xK2nl9jd++1csBOEG+0e8SUOpek1Q29HmtVEvJK1GyQgpO23GoQQVAxOO/mHUGHZ9dh9U50OA0BklK4vH51F4MK@vger.kernel.org, AJvYcCVYCsngNxz8IFlaL/XWG663LH2eFP9cEAg8r8FBQI/35bN/8KjlR3x1VV2TINeB5MTaff4=@vger.kernel.org, AJvYcCWgt1dK2v2G9yhYzE268JOh8lo2W07D2OaNo7DPuSHR8T48oUUwZyDQ/EQGTmoUa2d/kbrRLGShA8A+nwBu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu2be70I3FEkI2kyRiGJ16awWImOSXUlJteNVH4LWIeN0/LqjH
	phpUqqvl1pJqb4JfBNxTlOyHYOulL7/8OEZhAf8FYhTpcY1qE1ts
X-Gm-Gg: ASbGncuei2z+SfyYUqDkVIeZWEWJci6MDLWHrwbqHlqEg8Zjl/d+Xs9rL0Qq3ezs5s7
	qym7L1viU7ALebve1E6F1DBK0Ga//EFkzd1lIaIox/K/yR8u8M+8CNtGttydu71pPb6g/sBhxJu
	/7fg5/AuYm2jf2ne84PAWvwQROWM3n+n3pb0dKeFzwp1z6PfPDAwGjGZ9Dv4O1QDr3nf/zn20+Q
	anc4aJ0ixCHuLxi8kyIqLDwQBEK5FpEx0rAwmvLQk7Bm7RvA2k=
X-Google-Smtp-Source: AGHT+IHZkU5tXESbsQSufn4K2TA1C1VRT8pQfJ+DevuvUAtbNf2cvrlWnN7YFd0lhrglkU4YceNZQg==
X-Received: by 2002:a05:6a21:78b:b0:1e0:df27:10b9 with SMTP id adf61e73a8af0-1e0e0b004c3mr1123625637.18.1732654063605;
        Tue, 26 Nov 2024 12:47:43 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5155:e4b9:67db:7078])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de47e941sm8824806b3a.78.2024.11.26.12.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 12:47:43 -0800 (PST)
Date: Tue, 26 Nov 2024 12:47:39 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Michael Jeanson <mjeanson@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	Jordan Rife <jrife@google.com>, linux-trace-kernel@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from
 __DO_TRACE()
Message-ID: <Z0Yz6xffDjL6m_KZ@google.com>
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
 <20241123153031.2884933-5-mathieu.desnoyers@efficios.com>
 <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
 <d36281ef-bb8f-4b87-9867-8ac1752ebc1c@efficios.com>
 <20241125142606.GG38837@noisy.programming.kicks-ass.net>
 <c70b4864-737b-4604-a32e-38e0b087917d@intel.com>
 <CAHk-=wjcCQ4-0f68bWMLuFnj9r9Hwg4YnXDBg8-K7z6ygq=iEQ@mail.gmail.com>
 <20241126084556.GI38837@noisy.programming.kicks-ass.net>
 <CAHk-=wg9yCQeGK+1MdSd3RydYApkPuVnoXa0TOGiaO388Nhg0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg9yCQeGK+1MdSd3RydYApkPuVnoXa0TOGiaO388Nhg0g@mail.gmail.com>

On Tue, Nov 26, 2024 at 10:13:43AM -0800, Linus Torvalds wrote:
> On Tue, 26 Nov 2024 at 00:46, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Using that (old) form results in:
> >
> >     error: control reaches end of non-void function [-Werror=return-type]
> 
> Ahh. Annoying, but yeah.
> 
> > Except of course, now we get that dangling-else warning, there is no
> > winning this :-/
> 
> Well, was there any actual problem with the "jump backwards" version?
> Przemek implied some problem, but ..

No, it was based on my feedback with "jump backwards" looking confusing
to me.  But if it gets rid of a warning then we should use it instead.

Thanks.

-- 
Dmitry

