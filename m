Return-Path: <bpf+bounces-62693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC30AFCFC9
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 17:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB12164799
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 15:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCA32E2675;
	Tue,  8 Jul 2025 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YzQ7EWlE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECDA2E3383
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989959; cv=none; b=Prtl/wfildeZzCFhgfFdVUXC/gA7G+4AeNhoXAgrjPRKwA4TsryMcR6V1j4Zttpfqf8KWVoV8e03RMYeR8l9MU5FULw36M1/67CrlCJS6lYgn7Qdu0pNkQDm9pkFBQLXRalaNYumjTCbLnVKhygYPGhJRKUPHEHBkZyVWp9qjik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989959; c=relaxed/simple;
	bh=VB4DKDbnFxxhgT4wajWqmZ83svuBw+tft3pDkE9FqT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oL9Gm7KBtMMOKmsMclakDpesEM7A05n8DNdRUyIjdgFBL7QaOMld2XCjNP4Aci60a1cbEXW5gVuuQzZusvsQ9SmommE6P2cAihN/UI1Ab8oDPcScfAiM+lrpoFLTqaOobdp7mxcnKXyyA/nwYQAC2ue1Sij93UW5l+whgGWadFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YzQ7EWlE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad572ba1347so690117366b.1
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751989956; x=1752594756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e1jzCZfbh+UOZgumo9HhTaPJort8G39J3Qx1CDHd6zY=;
        b=YzQ7EWlEtcKZa/3LOXZpR5O85tf7xQhvd0zQTWE5DHJ+j+oVUh/1HcqjiIU8MtSo4R
         W1pDQS42iRoGEQOKMcJDC9wCJYIF+GQJH9CfiZiqYFPOoPyme7Fo0mwC/roeKouERhjS
         vDOTINm4toDzwX/vOgp4NIqXeB1orCW7UkL24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751989956; x=1752594756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1jzCZfbh+UOZgumo9HhTaPJort8G39J3Qx1CDHd6zY=;
        b=Y7JjgJghghKiWuss0BcHe6hDRFlQuEEkhB5gQyB6GUDIf8YJmOr4YDClzRJXlbGOJ+
         MLbQ7RvNoo22Ej0/kI9cDTIc7p9r2oY2YiMVJRhrg1d3KZo/CYbv2jH366ObkbYzubXV
         o7ucCcvIB4AaIstVOy628fL2D79R3lA4GSA8/XHZ27MpVPBfSNRS2CmvMlrG1jH2ICWf
         eaI48CSX52YJ44XH/G6guscnueLW2MR4fyeiYejiWcjXniaprsH9lmAy/4dYVMYZocjm
         wu74pocWjJq+UrMRQmwsOpkMir9qj3P+hQo+UpAIKXC1V0DFwoeWzzKddGnyg9lZ65uq
         wleA==
X-Forwarded-Encrypted: i=1; AJvYcCWnVsJ+pSpEC2kWzzTYmO+padIoAFgQhBiXGbmywQjZwsF//7eTor57mRv9WMSvKcodqBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhdZAalNZv3Wv973UTXujxRNamSnGpjV4sX/zoOSrkd6/pYwL+
	lGbDciOHCdmPjFtQRuTDoNcglrTAhJPPCQfxRRIN6mxFbXlucTGs7NvhoaBMq9tcmyyqHi1IVoH
	cGYZ2f14hpQ==
X-Gm-Gg: ASbGncsEbQNWM+OWGceotYYdAHi5NG4P00n5d+g2CxMCe4HsaWydiTpU6LgHv0czAha
	BnFbLIR1NZVe04QbxzBuGHdJf3+5LAKrh3H3SYm9+BvbtDqvkiIyIoCAAY0Jg72z1s9oUpBC9vv
	X2d51Pg5WJtvYGMW+m/jhhr0c2oUcHmEC20YvOBg1beBHVI+gJ/P+4mTAS6vKyXucXTbrBXs8Z5
	6hv0XMtGQahRF4oNU7oQCjO1mIiKruElG7ZowuKn6fNglKri85eQ/6BZ5GwWIgAdZZnGSWu9xHC
	560imSCuMxLHWs548DcmoV5TRBH8KuMktDpzD+qihFPHcOz429s7B34T4P2LEhlgclCv8ezc0VQ
	Kjb+wmTC9AFy/9FDwIGcXBaVKKqpxVl4hFjp6
X-Google-Smtp-Source: AGHT+IHDeeOiIdjZswrjGcFlowyzGjb4hmrq1McXw5FnIAblsFoN5+o+1N0v7bYU/0QGr/BZs6Kc9A==
X-Received: by 2002:a17:907:d01:b0:ae0:a116:b9d3 with SMTP id a640c23a62f3a-ae3fe8320a6mr1468661866b.60.1751989955669;
        Tue, 08 Jul 2025 08:52:35 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b08d11sm921142266b.138.2025.07.08.08.52.34
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 08:52:34 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so6193537a12.0
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 08:52:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXb8WsrT8Gm7yfC+AEEdpq1TC0qAlYlZaL8wSecAvhQh0Su0sS135b8B9aMXSx3JwDOJlw=@vger.kernel.org
X-Received: by 2002:a05:6402:5191:b0:60b:9f77:e514 with SMTP id
 4fb4d7f45d1cf-60fd6510ce0mr14317873a12.10.1751989953772; Tue, 08 Jul 2025
 08:52:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708021115.894007410@kernel.org> <20250708021200.058879671@kernel.org>
 <CAHk-=widGT2M=kJJr6TwWsMjfYSghL9k3LgxJvRard0wtiP62A@mail.gmail.com>
 <20250708092351.4548c613@gandalf.local.home> <orpxec72lzxzkwhcu3gateqbcw6cdlojxvxmvopa2jxr67d4az@rvgfflvrbzk5>
In-Reply-To: <orpxec72lzxzkwhcu3gateqbcw6cdlojxvxmvopa2jxr67d4az@rvgfflvrbzk5>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 8 Jul 2025 08:52:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOnFbRJ9V81VEeSK+=HuD8ODSq+S3STTh1JwYQLWXXXg@mail.gmail.com>
X-Gm-Features: Ac12FXyovZoowk3cIPdznURFGER3H1uO2rBwoO22YC_nLxVaqUCimxKTzLI7nYw
Message-ID: <CAHk-=wjOnFbRJ9V81VEeSK+=HuD8ODSq+S3STTh1JwYQLWXXXg@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] unwind_user/sframe: Enable debugging in uaccess regions
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Steven Rostedt <rostedt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Jul 2025 at 07:34, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> I had found those debug printks really useful for debugging
> corrupt/missing .sframe data, but yeah, this patch is ridiculously bad.
> Sorry for putting that out into the world ;-)

I suspect that code that is still needs that level of debugging should
just not use the 'unsafe' user access helpers.

They really are meant for "this sequence turns into three CPU
instructions" kind of uses, and the "unsafe" part of the naming was
very much intended to be a "please don't use this unless you are being
very careful and limited" marker.

Now, I do think that the "goto label for exceptions" part of the
unsafe accessors can be very convenient, so maybe we should make
_that_ part of the interface more widely available. IOW, without the
whole user_read_access_begin/user_read_access_end dance?

That model is already used by "__{get,put}_kernel_nofault()", but I
think it's limited to just some unusual code in mm/maccess.c.

             Linus

