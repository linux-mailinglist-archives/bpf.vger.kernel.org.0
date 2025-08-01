Return-Path: <bpf+bounces-64900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545F1B184F5
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 17:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC75E1C82D1B
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2B6272E7E;
	Fri,  1 Aug 2025 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTjyasX8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C4272E63;
	Fri,  1 Aug 2025 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062144; cv=none; b=q+XuF3sdih3g6tJOrkyCYZoGn8BZwmIhr64qo0EEqXDSwjlY6UqTn2lCEzJ7ok5NauZbAHaD4b6rVDlOXHdiZmsGwucD0MbN7CJBCy1uGdQCFm2wCzTBpz2GfVb5mg/Ov3OWPE14GLgpDjGiQhLrajmHZ77OYDHxbIrLzh/aL8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062144; c=relaxed/simple;
	bh=NTIKi8lZ60Xj5gcTMk/yCBf3AmsqMsjZTIZ8mZ8FT4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4nhSTy++cTjsRtwLoArc8m8HCh2Y2s9gXB9ONIatQpn+s5Tqy3cjGdrogPyatgwm1t1HRnhxjlx1svPZ8SV08svnMjskXYuIBU+pmGvY1B+1w9y5gOBVZjQFj2hTaCP8LqB8zKCmoxjJuS0ako3JPv3ey42jdeFvQJxjayLX3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTjyasX8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45610582d07so15850635e9.0;
        Fri, 01 Aug 2025 08:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754062141; x=1754666941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTIKi8lZ60Xj5gcTMk/yCBf3AmsqMsjZTIZ8mZ8FT4s=;
        b=WTjyasX8K6QKHLv0iqghRl2/YgfIr2kn3DtPUsIcSsMgAvjKwnHJ94Gtmaj7KK0Joe
         iUGTdtBAfgCKHNzV+0UGWwvDVzAO6SIuiueUf33wC966fWtCz1iPLfrDeuIwape3UDt3
         DRRgkaiP/G9CbHF0UZ7ZRWnx/Kvyi13WNKjEAmCgyqOKOeiYqEHP/bL18C1enZTlzQu7
         9vvrY9FY32GknSoSYVQ7rBQh7PRR+l+Pws3oVwJ+4y7kwBFRn0xBk+i/mgL72llIRuq8
         Fi67/IWEWwzLT8J5PKvhTjuKpgmya9w8J9YNbT+q8DngCkI4Y38hcVmo7SykGye24wUj
         m/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062141; x=1754666941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTIKi8lZ60Xj5gcTMk/yCBf3AmsqMsjZTIZ8mZ8FT4s=;
        b=IVDPGyCVr1psR3V5wJKFP1CNetXO740xvXgHYFUFWmbEbFfCjgwtugXiew/6R7xS/Q
         SYseXRkbPYryM31tDZncF8bmEnwIS6dQlkcXonLpRbvo7SuljD4wmz45++WBOHfsfWj+
         vD2Vv43uihPpif20KlyilvYOzenVDJN0xTRGV0mURinULni1oc582tmly0UUv9l33F7Y
         PcUovnF8Tjm/SWuY7AIIly0m8g6ZavnEtbqxQVyVRxE7wWU4Xyl62goLFNTrdLj1sjz/
         udzySvuv01jAtoodKu10BTrIJ6VbxhkHkFZDnVbbGxL2E2RfANEKeiONsVU2O/P48GVq
         ZsmA==
X-Forwarded-Encrypted: i=1; AJvYcCVy01wAmmNmZgBophq3Y3WvX/4+882WPIW7ScKFEw3flXNn13Oc7bXqkB5m2yxgpW9AsJHVlvmFg8FACmVUljhTeamK@vger.kernel.org, AJvYcCWOSdx82TPziItfHlIBYmobu3T2BXS7GVcQWtEO3MFz8SGyRpAR1q2VZs8ZOZZ52NM86cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVRPC6iIf2k6B5AQbgOGSu5uxyshxbNjVe3y+pWbEW6aDltdW6
	aTI4x6XPRrxbv/cHwJnjqJtvWweCSRlpcq1XvQ1rzuZazTTy1mo7hInX/Ftyp9RYt8YCq8AHWfO
	cNzuPZQt6fRPA+fjumbOUHJH1knCEKH8=
X-Gm-Gg: ASbGncuALPJOLZBLaZ3zuGH0Q7R1Lop89ymZi+UTfal+Iwbev7m36QqO4+3jdkQrnat
	aFbL7Z/LawpxOSuglK4VSSo36QW6amVjzt/13FIDyjhRTq9wKay5/E9vg23zK1WOjT+pXBHAYM3
	3Wtf/XSj2EAO7ZQCMBBNC6treG3KQyja19Dphuxigo51qrGN0Hq5YtFGrsewaVMQTp6K2mZdqsf
	P43jjMICO4dAOITIlQXotcM7/zONPKTXg+8Xs9SDGLlwq0=
X-Google-Smtp-Source: AGHT+IG2T/YhcUR3KekRl5NzxsTfZH9iFmJDQ46OoaMdQQbLZPyYnankjz12TKrixBPBhz3almibuyymEAzHEwJSH94=
X-Received: by 2002:a05:600c:6295:b0:442:c993:6f94 with SMTP id
 5b1f17b1804b1-45898c02c1cmr111174545e9.12.1754062141227; Fri, 01 Aug 2025
 08:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801071622.63dc9b78@gandalf.local.home> <CAADnVQLky+R-tfkGaDo-R_-tJ8E3bmWz8Ug7etgTKsCpfXTSKw@mail.gmail.com>
 <20250801110705.373c69b4@gandalf.local.home> <CAADnVQLFLSwrnHKZUtUpwQ1tst71AfYCcbbtK2haxF=R9StpSw@mail.gmail.com>
 <20250801111919.13c0620e@gandalf.local.home>
In-Reply-To: <20250801111919.13c0620e@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Aug 2025 08:28:50 -0700
X-Gm-Features: Ac12FXwLGV93L4m8o72JijGjm5Q2p9eEAeya2RQqP6nlvhe2-kKX9SbrI4cRnEs
Message-ID: <CAADnVQJnTqXLNT9YWWkpLqjxw7MGMrq_CTT7Dhb__R0uO2-COA@mail.gmail.com>
Subject: Re: [PATCH] btf: Simplify BTF logic with use of __free(btf_put)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 8:19=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Fri, 1 Aug 2025 08:12:08 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> >
> > You can use it in kernel/trace/trace_output.c, of course,
>
> I guess that means I should just use the DEFINE_FREE() in that file
> directly and not in the btf.h header file?

yes. I don't want this to proliferate and people spam us
with this kind of "cleanups".

> > but I really think it's a step back in maintainability.
> > All this cleanup.h is not a silver bullet. It needs to be used sparingl=
y.
>
> I have my reservations about the cleanup.h code too. But the more I use i=
t,
> the more I like it. My biggest worry is guard() leak. That is, having a
> lock or interrupt/preemption disabled for longer than they need to be,
> because code was added at the end of the function after the protection is
> needed.

guard() is ok. We use it too,
but __free() is imo garbage. It's essence of what's wrong with C++

