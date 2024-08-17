Return-Path: <bpf+bounces-37421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8F3955685
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 10:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D6F1F21EFC
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 08:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FC6145B35;
	Sat, 17 Aug 2024 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2c76Nea"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87C61459FA;
	Sat, 17 Aug 2024 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723885102; cv=none; b=oOQuB/zOOiGSE4PB+6SImslSei7KZ+9kZ6xmJzDlGeqnvOLZuiDdlu+mDFpUdo6pr3UoJ/PfHWWjhr25UNgA7wPjFSnmMRYGjrp5ZGueJ5rzAjyVhrIR64kfggp4NrezoB4eiPhMvFn7RtUMyAxktbx3I7DpLZTICD3oi6A70/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723885102; c=relaxed/simple;
	bh=2Pq9C5IPW660mygnX9oIyuuVWv8qtJEXNGjXTr8fJO4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcCyqpUwuZav7+4aBj9Q4Cr1Y0VV/MHhooA30/wqeHu1H9qoo8gQ3i+pya53V5OtTD00hBq1fy69iieYSDw0/i0V72HZbw9Np7x7TADrfSeNA+A4UjlluoZDJu/AqA4X8mPPNAspQ2k55aWV3P5p2zXvK7k5FCrIFwEu7XixF7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2c76Nea; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-371936541caso963067f8f.0;
        Sat, 17 Aug 2024 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723885099; x=1724489899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hrv4H1dCJwtdoZUxlozPpn/SA8hHGjZJ+RyaiCWe+Ig=;
        b=j2c76NeaEFMZyfhDZWiRFppZBw87XARUk/llF9TdpyWQU1V0qV0lyfWIMAr4hocnBn
         kv4Df6lOrjkMP55XD8vlPNjNLVIRROPSkUp0Auj0Q3KH3gHqMLJXE2gR9ujUEkX8Ck7k
         TZ7LK7M1XxxCTpU/x9XbxHx3iskfL7l5LoeNaExTyqj6R/3MQiEhFilk+NAxjgc2UK04
         r5vD1HMVDhRPEs/5VQhU9eHr0HF4NQ5KLEtGuP9+iMAjffg9UsglsD1E1Gs2QZg1MB5S
         OzdwNF5X1GYVcVjxHSj4adYhL4IN3jEPONBR9KToPv7hwvPxM5q0P+u2XddwQ3G99uo8
         YApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723885099; x=1724489899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrv4H1dCJwtdoZUxlozPpn/SA8hHGjZJ+RyaiCWe+Ig=;
        b=qfoGejNefJASlm3o9QGuOEOWouOwCwaEhZSfVUYys421hKZ03YUMWprtoFtLr/xUkd
         pQeNUfvvCUJD+w1fQ7WTYmeraCty/Hg87YEj2R8HokGB4t6TwrJEGrIzcgl9Dxai2Bat
         yGuTQt6p21oM1WpRr0/nvpShcSfDab8WuNpQ+/UOyboylY85dh7rTmxjX6wMC3Uyownr
         Cy/frFFnlapVHvsNXWIZCjbsdjisMHE7Ic1eBpYiaI0kM/8Y32rrJlfPY9A3PLNeVHty
         TIBMPoHHdUAJNXdV2UiMl7q6E9fFchMHz0e33phhzdPQma86usvoFihAu9afZvlZ1M0l
         UWFA==
X-Forwarded-Encrypted: i=1; AJvYcCXl0v5JYR0CckSMpucfYdNshIexSGKcTWtutsphgG/taZZ0oYkPzcWIJ6oc1O/a87uOXSLYFQUWzFjZIKHpSsk/BC0CkKyBH99UW3mqOyhHCI7vMiZxl1oAP/zY0/dBc4yVg9Qzm55m/SCdB6kwtmUqD/vAbU61b9dK8LbUPkOVFHoMVoMYeLE2IT+YMYlixMYMwV83qaSSkeBXhmQTfKJtr6sGQF8sccjWkDdAPlsApNha/UP6FVdmtxJN
X-Gm-Message-State: AOJu0YxXQr8GGxg+uzVeAhdGCtMN4CKMvY7GTW6WqjEWfn2+TbZnACiG
	7hW1byVJG3PRZ3krgDTEAHhNqf/93fhvneLrN+JqPpp+DJjtOStE
X-Google-Smtp-Source: AGHT+IHvMHDQOsgSZ2XMN8wNomoexC5wBk0XKsWfNZmIyBVBMrfzO4yJfF5IMQzpCT58qbYNrUxHsA==
X-Received: by 2002:a5d:5f42:0:b0:36b:b297:1419 with SMTP id ffacd0b85a97d-371a73ea90emr1484428f8f.20.1723885098855;
        Sat, 17 Aug 2024 01:58:18 -0700 (PDT)
Received: from krava (dynamic-2a00-1028-83ac-367a-fff8-e06b-b9cd-8053.ipv6.o2.cz. [2a00:1028:83ac:367a:fff8:e06b:b9cd:8053])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed78481asm44247765e9.32.2024.08.17.01.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 01:58:18 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 17 Aug 2024 10:58:15 +0200
To: Alejandro Colomar <alx@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCHv8 9/9] man2: Add uretprobe syscall page
Message-ID: <ZsBmJzX7BaHJB_oc@krava>
References: <20240611112158.40795-1-jolsa@kernel.org>
 <20240611112158.40795-10-jolsa@kernel.org>
 <20240611233022.82e8abfa2ff0e43fd36798b2@kernel.org>
 <3pc746tolavkbac4n62ku5h4qqkbcinvttvcnkib6nxvzzfzym@k6vozf6totdw>
 <20240807162734.100d3b55@gandalf.local.home>
 <ygpwfyjvhuctug2bsibvc7exbirahojuivglcfjusw4rrqeqhc@44h23muvk3xb>
 <Zr-Gf3EEganRSzGM@krava>
 <c7v4einpsvpswvj3rqn5esap2e5lpeiwacylqlzwdcp7slsgvg@jfmchkiqru4u>
 <ht6hc5dbvgx3ny22pvhiazs7vxjhiockr6glpho5bpp6hrwn4f@oew3iu7a62j2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ht6hc5dbvgx3ny22pvhiazs7vxjhiockr6glpho5bpp6hrwn4f@oew3iu7a62j2>

On Fri, Aug 16, 2024 at 11:56:39PM +0200, Alejandro Colomar wrote:
> Hi Jiri, Steven,
> 
> On Fri, Aug 16, 2024 at 08:55:47PM GMT, Alejandro Colomar wrote:
> > > hi,
> > > there are no args for x86.. it's there just to note that it might
> > > be different on other archs, so not sure what man page should say
> > > in such case.. keeping (void) is fine with me
> > 
> > Hmmm, then I'll remove that paragraph.  If that function is implemented
> > in another arch and the args are different, we can change the manual
> > page then.
> > 
> > > 
> > > > 
> > > > Please add the changes proposed below to your patch, tweak anything if
> > > > you consider it appropriate) and send it as v10.
> > > 
> > > it looks good to me, thanks a lot
> > > 
> > > Acked-by: From: Jiri Olsa <jolsa@kernel.org>
> 
> I have applied your patch with the tweaks I mentioned, and added several
> tags to the commit message.
> 
> It's currently here:
> <https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/commit/?h=contrib&id=977e3eecbb81b7398defc4e4f41810ca31d63c1b>
> 
> and will $soon be pushed to master.
> 
> Have a lovely night!
> Alex

great, thanks

jirka

