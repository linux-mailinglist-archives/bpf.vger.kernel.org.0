Return-Path: <bpf+bounces-61671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498B6AE9F58
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 15:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B424D5A2F0C
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 13:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856A02E7645;
	Thu, 26 Jun 2025 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="I93Fnaph"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801C52E7648
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750945726; cv=none; b=gS/WLP5k7/nqrGeYkOAdbRK601MFtiUJ1AWLbg3iN4Bq0RkIT9EOV8KeJDCYhei0fDB8SXJwocECHyvWLHf87ITO5kBzB2xo8dX15w2LddMuEFkLfzuTOigvytF8XsOzDZZJgPnRjz+R9Yt4TwQsjShzhHMrtazk9czOUOTIEvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750945726; c=relaxed/simple;
	bh=jAU0aOHceKYNcCYExz5XRGz1x3hYT4dCXMxeIfFPfBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/d+Lc8eBFY68pAbsn4/q4N5y4T0Hff7O27VmxHBLggyfuAkMd+pkuVMqD+GC4dv2igxRn0l5VJZjqFQM5Yc3doroXNNBvhFBHj+u9I1QEiG8d1wmmRlZjN5hE8jul85E7kt73LsjdbmSMIqKuMq7jU0vdFuqN25iG1EC9FQ2/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=I93Fnaph; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235ea292956so10965155ad.1
        for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 06:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750945724; x=1751550524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aJtqONCBTd1Gv0wLO+PNarwx+koXGlu1bl6aoxfQ5Ag=;
        b=I93Fnaphw9eN9hWdDLAP264CaWU4stPzjHjAyuKrx1Nnhq6SKOhUo4zsha1HYwh6Fz
         0TbpR1+U/czOEEE5mAqRlVvSHHrraZsmUd9s5uQc3p6qQ+GrKWCzwmXVF8rt5702OikQ
         QmVjjCaKsul0vRW18kpG78IWu6BaTEMHuF5n+VFiDk8zfFllqHe38RunWWg3uPJOALw7
         hT8eOgkjiynEuRkButeNW9arXdg7V6tSkcnjoWnJ7f4INDy2QaKSuDeXfP3ifLcZqnYI
         3OI4nVZEhO00TZ4l3QTZoPB9seWXvzZjH7Sytx4xTF00fF9gFb5Xs2je40FyeHss83Y4
         lU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750945724; x=1751550524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJtqONCBTd1Gv0wLO+PNarwx+koXGlu1bl6aoxfQ5Ag=;
        b=j4O/fzlEXp3yhVxwc6M9qnBZvswr6MCc3Gsozj2jFtDLfT8Zj1t4PHfnGPm7mX+S0d
         kYrzw0PWWztNcEY3X51IV/2AoYYs7lu7/6zcy28JogHyVqamfJzqGLO0Bxa7WwdhBv5a
         uJjQuBuITxspnv9D7i3A8IKULLqpCZstXFbZdSVFi8NpCCaFmqAS0wtkPsuJ2I1fPYCA
         p+k99Cfgi9YUxhgU8YM/RSSCyjo4dhIkq1IHpN80pa9Ha3N+ptuYa7WllaZl+GurmVJC
         xwWWennvPpo4CnsoxJZG9WIcMENrwMckZLYBkIojChWQTn1+UnH377MmfjyGPbvuiDrF
         Ibsg==
X-Forwarded-Encrypted: i=1; AJvYcCWRMpEFrk7LaQxbJ8evYj2GmwhD6evbzqrJoQDMXlGf6e4xVn0ZzaUaPUTnntypjpdWZgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUzBvacC694S4Ktb3zxdqax1S6NF4m/9ZMrpHHKT6DS48zMxRf
	zFpo8dmDt9dcSBMaht3OZVBSsZCL7T3TRli/SmFbhERn3np//5oBOxTj3phjohcTpbc=
X-Gm-Gg: ASbGncs/kiyfKPvRpJRZ10+tn6rpZ1Xkqk6Th4sE+SFSDqDHZzUU7HgqEHHjLtZ+Jop
	69PoIT2cjkjeDWGnRuxSwzf6gOeRorc6Iy0YN/UUCG9g50/e4i71HZWjslgjGymRmJy3FZf8HPE
	m/aAtwYLA1UeJzHl1qY+NOaJRhBEW9eAFLPQTFaB9Is9R86A5j91YfFWbscsoJnICzv8hqyPc+L
	isjw9lcMxVE9prUBIRefF04NQzAI5NYarF0m3mEorbvkINLwZl6Hpdfhb4MBVylldqc/+sW/Bud
	4eGUFWnRSvRPxGkytv2XwaPTMTa2bQCUX0RC62/t1ijuVXibsD2Y5ZHylafwJnrIlHZP
X-Google-Smtp-Source: AGHT+IHaZxlWF+YhElFCAwxYF4cK8J7XWLEsDwhwcGid+kpLovDJu4Tpxovjl6eB2F21LeYzhc7jVw==
X-Received: by 2002:a17:903:1a8d:b0:235:f70:fd37 with SMTP id d9443c01a7336-23823fdfe7cmr116316585ad.19.1750945723795;
        Thu, 26 Jun 2025 06:48:43 -0700 (PDT)
Received: from [172.20.0.228] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237eec29a77sm117429145ad.165.2025.06.26.06.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 06:48:43 -0700 (PDT)
Message-ID: <a3b456f2-deeb-45c9-b509-23bbe5e96cfd@kernel.dk>
Date: Thu, 26 Jun 2025 07:48:40 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/11] perf: Use current->flags & PF_KTHREAD instead
 of current->mm == NULL
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus
 <jremus@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20250625231541.584226205@goodmis.org>
 <20250625231622.172100822@goodmis.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250625231622.172100822@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/25 5:15 PM, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> To determine if a task is a kernel thread or not, it is more reliable to
> use (current->flags & PF_KTHREAD) than to rely on current->mm being NULL.
> That is because some kernel tasks (io_uring helpers) may have a mm field.

This commit message is very odd, imho, and wrong. To check if it's a
kernel thread yes you should use PF_KTHREAD, but that has nothing to do
with PF_USER_WORKER. In fact, as mentioned in a previous reply,
current->mm may be non-NULL for a kthread as well, if it's done
kthread_use_mm().

If the current check for "is kernel thread" was using ->mm to gauge
then, then the current check was just wrong, period.

-- 
Jens Axboe

