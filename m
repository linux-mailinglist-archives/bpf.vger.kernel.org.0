Return-Path: <bpf+bounces-47851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B599CA00D59
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 19:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E40B3A4227
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 18:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16921FBEAE;
	Fri,  3 Jan 2025 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS+48vn2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CB51E9B01;
	Fri,  3 Jan 2025 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735927586; cv=none; b=sCEeEZzdRBMK2/u3KO8ugGaGtoeuu0Pa0AYz7Z7G/eHmhhwcN97yI6t42vnsliph5CBjHAh4V+qO1EnA8J42XNGqL8XRVM0ZmyJtR9znU1RKNGmokq02KlI1qeVqv9vk2wLKMpKRPvPpplRtXmi6fVQGD71S3N5+DcyZJR78oF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735927586; c=relaxed/simple;
	bh=9CqMjIOxFhBN3jD6PdaMlFMiJVU2kHA0i5HB4Iz/J2c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guJjA3vKjsfZFvfESiIPgSuMCRzLoc6ycR9/JbGZC8JtWpjwkmd+Kz9pzebecuqugbSr8+N2ThgFWfuQBHDdi0sD9LZE0M1elFF+c5ScCNebqwKU79V1Mm6m1Cpvy+KOC1yedKq+BykGRiSwyrViKV7+1Th5vLl91plgSZrPtd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS+48vn2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3863c36a731so9527380f8f.1;
        Fri, 03 Jan 2025 10:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735927583; x=1736532383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xmko7IoDjLUX15CVMky+kxYzvdoxvNioQdtLUcUqU8Q=;
        b=QS+48vn2UQO3fETBWgBHeFL61WDrjRf89mEF0PZn/lhoL82CFxXVw4zewrMfOoYPTN
         5Nhg50QTzvCX4viIe+GJ1UjS4eA18pkKQUOqlgASK4l767uOFRLutWTAL+z0FHApibPi
         VTAFl27dlHta1+MsVKMCg53r8Mz7GqYIdw2R1x36HLvwyPs7PoDN2OwTDPvBd4AlJfph
         /SKc5J7UQDbR3hW08lCqTw4KIWF2r2HXKSvLemaMr+SmXtVNrd6KfIXdkuRwuAxc5x+R
         kJnXXjwljf272n1uppduK9hTChDubud8NGSYyUzak0770P5npedfFYnGObVjpOv8N1ED
         xrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735927583; x=1736532383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xmko7IoDjLUX15CVMky+kxYzvdoxvNioQdtLUcUqU8Q=;
        b=Q1teBv8zTZLbJqB81ZX3R8KWSuFeemqGF303gT1NHOGhbHJ1/Kd45BGW67i/oIEnYR
         UjU9Jy5b9S/MzkCPlGiE0fnSm+/441NkuvpLyMRqrqEWWBwjOXhD+0vCKYDyAlA4YMRB
         zn498+t/GTvxFpWSLqTCuKjWiVG1Ky6xG/IA4kiojRsFE1GRr7Kwkvbb0P7QaVcTxFVe
         SOvFsYYXg5HTKz/L1jOKkEW/G4VrEw5Dr8qfqMfqlLDutvF6QJyf5VoUIcHoW+Bl6Qtg
         MahTZm5DZLbV0MMMhX4RpTzWchGSGalASv1IV+WXa+UzMhYdyuu1HF4kHwYuQc4egXcq
         UKHw==
X-Forwarded-Encrypted: i=1; AJvYcCU/GfBCZ+ZTR2XAyKVxbunRrnJ8H54/CKEjptY0JS4NIrAcWv9glMtptljTRSeKVWQZFSU=@vger.kernel.org, AJvYcCXfYNscEbCTBbBkiEXzGO6J1TyynufGlrBtEuUF1NLhSpffyMuaSAz2jzIJaCm7sLXDQvP9QtHNKPcBcRAS@vger.kernel.org, AJvYcCXja2HiYVaFEgGD1CjkW99gW03tXD97ayWdF8w8TATxlHPSo2BsJMK0aZcrV7ZEw+cQCB8ZHsOaI8i3jqkX@vger.kernel.org, AJvYcCXmpi94dpXUQnjqEO7G/SpvC9eZksMuGKTOnPuc/TKczixf76qdY8GeD2Sj6zOkHzWKK9rsggAaWH4hVczfBQuYIAhr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ndvmcREMGiHJN9I7yAku2Yl46HWNfuoxXav2ULcq0zMU1zIj
	xt1Z0oqORVh17HMdh62SC39JsK+1wbYhH20fjRGICJN2usIPnige
X-Gm-Gg: ASbGncvKQ3mKNsb5fpODJVMBwJ4WJckLL/cyoZV+xcc6G8/DpDk863NWYJD4SWBxgeh
	r4BFmNWrXMliCzeeH4Ggbf40t2hKXZ5cn1jrrZVX4ueKkiYaF/4DZGN7ujLGo+lo82O3DQqhn6Q
	IfnkI/fTn+LIBuHnZeGbNPUsGm9Pm7F0V0n+a8t5DqUHDkf3y4Ef4W2cOWhYiv0fuY8POlX3DWm
	3LuhU2IQ8r7hnRrzncmEpmc+NYCrUbDE7om2/Y81WsjiXQj+ocrEgoBMh3QcMs=
X-Google-Smtp-Source: AGHT+IEfzrZhd8M5VIRJ8FYnTlrKnQJqnt4VFt9ZQKlBWVAabfNUKIvwO14M3WWj0JjsI4T/Y7qxsA==
X-Received: by 2002:a05:6000:4612:b0:385:df5d:622c with SMTP id ffacd0b85a97d-38a221f36e3mr37544770f8f.30.1735927582779;
        Fri, 03 Jan 2025 10:06:22 -0800 (PST)
Received: from krava (85-193-35-38.rib.o2.cz. [85.193.35.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e74sm40636644f8f.30.2025.01.03.10.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 10:06:22 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 3 Jan 2025 19:06:20 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <olsajiri@gmail.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 14/14] scripts/sorttable: ftrace: Do not add weak
 functions to available_filter_functions
Message-ID: <Z3gnHGhNKOT7P4Ga@krava>
References: <20250102185845.928488650@goodmis.org>
 <20250102190105.506164167@goodmis.org>
 <Z3fFkHCPl_68hN4H@krava>
 <20250103114140.GF22934@noisy.programming.kicks-ass.net>
 <20250103071409.47db1479@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103071409.47db1479@batman.local.home>

On Fri, Jan 03, 2025 at 07:14:09AM -0500, Steven Rostedt wrote:
> On Fri, 3 Jan 2025 12:41:40 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> >  
> > > not sure why that fits the condition above for removal  
> > 
> > Check your build, if update_socket_protocol() is no longer in the symbol
> > table for your vmlinux.o then the linker deleted the symbol and things
> > work as advertised.
> > 
> > If its still there, these patches have a wobbly.
> 
> There is a wobbly. I guess I eliminated all weak functions even if they
> were still used :-p
> 
> Jiri, can you add this on top?

yes, that fixed that

thanks,
jirka

> 
> diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> index 506172898fd8..ebcd687a9f0e 100644
> --- a/scripts/sorttable.c
> +++ b/scripts/sorttable.c
> @@ -523,7 +523,7 @@ static int parse_symbols(const char *fname)
>  		uint64_t size;
>  
>  		/* Only care about functions */
> -		if (type != 't' && type != 'T')
> +		if (type != 't' && type != 'T' && type != 'W')
>  			continue;
>  
>  		addr = strtoull(addr_str, NULL, 16);
> 
> 
> -- Steve

