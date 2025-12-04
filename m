Return-Path: <bpf+bounces-76080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA7BCA4DF3
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 19:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0BEA30EB5F4
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 18:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8827736213B;
	Thu,  4 Dec 2025 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY4ORmZL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179A83612D5
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764871122; cv=none; b=EIKEREBW57ce8DdEudgZy8gR0ZH7DhdpdD99qBHdXclfaLcSxhUd+9BS+VXjUJGwKWH1zw3axheeS4EzSAh5crTeZVxhuynqwqhu7oWOzJkuVtuFGHeQw83HNWIyY7xEplePuTIEwHju50zepFuBf1nvTmbX17PpOhKGIfd+HPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764871122; c=relaxed/simple;
	bh=M61YqHUOtUork5VnW7pM/Mojz5Hm0vLf3JZ2HTVr3lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJMtHxAvjTBYzyElK5xNTVJcuP0dyrElW7p42b50dt903ul2F8PVVxauariHClg2ny4FVVwM2fcWy/Y4UmA0AeWGlsEWmv3xm/PFnBZBYepBEU1ne0PYpNo8B4F6egv5aln5CR4gP1e2uvw7yyHUhVw6mG2H3H2NEpyOUI6rAUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY4ORmZL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3410c86070dso926886a91.1
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 09:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764871119; x=1765475919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1pRj1+5/jO3PLLne9MyCDaDvNW1mVSp/lUv//X24Es=;
        b=HY4ORmZLBYzOdCUWObP7rSVJNZCX+aHieIFOY+XQnM/6dOsnZ02o7P4txafcZlkgGz
         0MbNeFn0fDCTerN5bAfHfJ4Qcqd5VXxaQ8iVWSz8IIYU2P4S/uBspS2fCfqWlAxGrojq
         5RRunddNABa8WgZHRxXDnN1vOnpJcHS5k7PDjFVXd4dpU86HBoNr2K/PCWTVxlKn/2oL
         jIBQvBRatRIVfVU/UogKDCeFlFofcWSQazAzuvl3BnDKt/+XgkxtBsy/0KOKncPDlPYV
         jDbCI1+Qhymnqh5+K4rap1GSp0WckFrLYv/0d/CznRy+CLPwhe8K/iPso6Vy2uA+lJJw
         0p8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764871119; x=1765475919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n1pRj1+5/jO3PLLne9MyCDaDvNW1mVSp/lUv//X24Es=;
        b=cHJ2AH501tIS9PlgIvHcnATHDcAais2i4pGjxd/NBd1QwPuj/qGrp9bX89sQ/1mQIk
         m2ZrKi4Np/JCm4fRIO7z489LM/yt7MTkrjp1vFG6fYrrsO1+gf/MtWO3E9PgSDyZRNJ2
         9zMBbQgJqEwcIthVJIU+lGVPvc+Yut3O9DJYmM/zqFC2k8fuzPVqlLo4JoyXJnl3+BYM
         D4rJaQqrgHu+uwPmiSaylErYlgOoZQGpjvPTt9Cap+4b3gEl7h4kIQfPbdyQ6YSC6K9C
         PfHwB27MvJMVLfEwq9D2mZuuBbfNsYbpEbxWHUTFv70AejuUOZlswO1ztQBJeS6q5GgB
         rHTg==
X-Forwarded-Encrypted: i=1; AJvYcCVvaiEMpgm6Jwj9tIWgXAImoSAmtCDYHC3IROaT130emhWx2Iu8w2iPCcbg5Ar890ETJXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBxizfjMint1ey7Kt8K0xYXfpmnoaNIu9JxeTX8lVRecH2RxpP
	AXiJjqn90EGMLdSp5JV09Pgr2h7YgjFzpYTZ+20ezIEzJqD/29f+icQ0
X-Gm-Gg: ASbGncvi9I/MVJ4+dEWr0kQkD4eCAnQOtvLynyklnnN0bwwsKa4NJxrCnP4hIEE0AKV
	lpP1fx9xfSAYabW/aMgdYDmNbAlfEVOm6V57YBYYWNfZPrgqUCNJB52yiBWCTkN3L/DgcpINeqr
	gdPcK+Mo6wS2RRD7oWNfNaO+9E7kUwugGqrSClIGX3oRWMu5F9+/TlCk26y41OkFATeXpcqaAHl
	hgPCrlYGF9QACEwtRZApAiXkVo4rd1z0232RRRCtiUlFkssapxRJbNpZmFbp2O5wW5Ij0nLEA3T
	NkbofNH4m+hJJmxQTkYrGYMlt3rdcYGX+DELASr/t+zjYEumSJreE4MsIxdUlfGY7S3MLq2JPwD
	tzGHX5d+oMlVIC49cOB4VHYu6FaN9oVv0ktW9gsWJibfTDpUMoSHMY5DusFvpKvP5phBa8zJuTr
	LRO0szV4fqi5gz9tlQMf3JNX4=
X-Google-Smtp-Source: AGHT+IHd2CViZquu8rDIVJve8lgSXsL5f4xbCLXW1g3SwVu/83f5GjAIV9Uz6obIchoDu07uphYeuw==
X-Received: by 2002:a17:90b:3852:b0:335:2747:a9b3 with SMTP id 98e67ed59e1d1-349126bd337mr6610930a91.32.1764871119341;
        Thu, 04 Dec 2025 09:58:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6817397d0sm2431869a12.6.2025.12.04.09.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 09:58:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Dec 2025 09:58:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH 06/13] selftest: af_unix: Support compilers without
 flex-array-member-not-at-end support
Message-ID: <f58ae2ae-49f8-46cd-bd24-2d358cb36f15@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
 <20251204161729.2448052-7-linux@roeck-us.net>
 <20251204094054.01c15d1e@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204094054.01c15d1e@kernel.org>

On Thu, Dec 04, 2025 at 09:40:54AM -0800, Jakub Kicinski wrote:
> On Thu,  4 Dec 2025 08:17:20 -0800 Guenter Roeck wrote:
> > -CFLAGS += $(KHDR_INCLUDES) -Wall -Wflex-array-member-not-at-end
> > +CFLAGS += $(KHDR_INCLUDES) -Wall $(call cc-option,-Wflex-array-member-not-at-end)
> 
> Hm, the Claude code review we have hooked up to patchwork says:
> 
>   Is cc-option available in the selftest build environment? Looking at
>   tools/testing/selftests/lib.mk (included at line 14), it doesn't include
>   scripts/Makefile.compiler where cc-option is defined. When cc-option is
>   undefined, $(call cc-option,...) expands to an empty string, which means
>   the -Wflex-array-member-not-at-end flag won't be added even on compilers
>   that support it.
> 
>   This defeats the purpose of commit 1838731f1072c which added the warning
>   flag to catch flexible array issues.
> 
>   For comparison, tools/testing/selftests/nolibc/Makefile explicitly
>   includes scripts/Makefile.compiler before using cc-option.
> 
> Testing it:
> 
> $ make -C tools/testing/selftests/ TARGETS=net/af_unix Q= V=1
> make: Entering directory '/home/kicinski/devel/linux/tools/testing/selftests'
> make[1]: Entering directory '/home/kicinski/devel/linux/tools/testing/selftests/net/af_unix'
> gcc -isystem /home/kicinski/devel/linux/usr/include -Wall  -D_GNU_SOURCE=     diag_uid.c  -o /home/kicinski/devel/linux/tools/testing/selftests/net/af_unix/diag_uid
> 
> looks like the flag just disappears. Even tho:
> 
> gcc version 15.2.1 

Oops :). I didn't expect that, sorry. Thanks for finding!

... and I guess it's time to set up AI in my environment.

Guenter

