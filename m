Return-Path: <bpf+bounces-48781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 119A7A10965
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 15:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D821689AF
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DE814AD0E;
	Tue, 14 Jan 2025 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyPl50sf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6171A81724;
	Tue, 14 Jan 2025 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865081; cv=none; b=biwMGfJxjJmQ6JGjqlFlIwuW1VsTdozelj7nQX5uCswzUkhH1699SCfT4ZtNMApe9c1e/fgv8c2zykqZECWIVuNYRDJSDZg2+6JMoZdj5wu9DzSvqWtN3OZ4CWzGUtB0aZ4EWQ5RAw94eQqCG0ixhyN4brWr15fpQ8U7KhMklRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865081; c=relaxed/simple;
	bh=/1TpfGbS+klWvN/B+XubZ6RDVoM5UsUYB0WEjShvzNU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHf6Qde5F5XHK2Gsxh+bzxTM3XPsA3jJ+eKl65B11f0PhxpTBAwc4qxIwALP03JBfTtmBUbUTjQjyG1hvrSkYweVSGtDgzOZ1VhywQy6/pyGuGRl3Mnsg63whvoL8BpSyvfRCxw349OwkoeD+qAk2plZXgSUpyNyCmO+dBUSUCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyPl50sf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1168666266b.3;
        Tue, 14 Jan 2025 06:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736865078; x=1737469878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8wf9KhMWUUhBxmCClSnH9SWhuo2ZNNuN9RPFjIJ+AIQ=;
        b=YyPl50sfWrr0wQY6kaTGJQ8UIBcukIbd+h7OV4PIYpxGzJ/bWHM12ZCFoJvXu0gbtc
         wz4y6QSa2w1sW6HHCmRMT4g3aTh40BrS9uI2orTkFXE03af7xzOD+h7wetHptUKFUY6+
         FnNsSTRhxnaGeNWKL5/tUdfe/9Dl3IsWSWnnGamrveVEPYC3/lw1Y4/u25aAIAhSlKJL
         J/ClVi5fL7UzwsQJH9irPD4+y69VE/UzWFE30NbfcRMmeEKiFIcgwjGrr0Cu5Wfl97Zb
         1C0Za1u5B5Wqy6o+QYhgbUx3pSOUUJo52SRX6FHD/UlUEB1GVjR/TtpVWy9CqqlvkXhs
         8zWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736865078; x=1737469878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wf9KhMWUUhBxmCClSnH9SWhuo2ZNNuN9RPFjIJ+AIQ=;
        b=ED/beHtWx3IVtdLkFSpgPndksLFWmNNHldiPCmZ9BMWAFysi1Ev/XIvzb6EvcuS1M+
         k+oKDWwhWm5TeAGkAHf9g/c/LlO4TAWLXkVlCeOJFgU5gIWfW9QC1RG8zkl+Mf3lcf66
         qPqwRLOOtjcGovzx16mz68fvG1FKRNWdYh/0DihsTL9HKM+IABzCZrRQvwoF6j8IQ2Lc
         ZKSJpmiEXAU1yOYdfDTrZgv41NrKteAXij0TUe81iIbW9RwEkphduacv9hzB/SkO4COm
         m6/eQC8itXDURVwAgyK5r9dFhUN/eYeOCJN4jI2nY5azjsiGrHJfKdg6x9UiNx+D9x7E
         bgiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIEJuqxP30RRoj54L6sdQziPXMHJG+jCDRjx/D1B62Jz1TVzVpyQswwi6UhPxOvyXFqQ4=@vger.kernel.org, AJvYcCWsAOQpslWhQjKHtAMDPgKOn8uvdEjOS3+ScqYj1TqGOWu8ipe2DJZeOXFcXDYTqvNKelsWWQ7PwI7DwU7M@vger.kernel.org, AJvYcCXJ7FPoiwHwwZrCdZ3b2MtbFJ4IO5ieiUVQvicVf9AjIcoJv6Kq9wchKHe9NfJe+X9XjQzPwaojOSlC5tXa83QCQXtr@vger.kernel.org
X-Gm-Message-State: AOJu0YzdQM/xFnSaaJ0htPB+Pt4VgEaZHHUf295IBtRuzD5lRoSszT+C
	yA4pCj70fHWZsO7AjiiruFL6uoTxtKho90lkZDrDEy5IJ3D2JL8F
X-Gm-Gg: ASbGncvVOrgd748yiqoKnMMfzI+C8ygvBlg/1spnYHAOMJeTdEzJs2/Ne1/8FEGRwQE
	ZiArYF8papziqY+FTzq5R4vnC3/Omzo2YxqlEfBy6Oks656TlxsDY93s4XQuN9V2GUb+9XeesAk
	95bCW9gG+Jcl+5aQDasCOBqS4BiLsmvknpOZC0sE1ja710NToTFPucf3uCGul/WNU9o0pss5T0i
	J6qkGXzY5gIvRmv3rUYLTaJq0P5rrZUbLWNU/G/XHo=
X-Google-Smtp-Source: AGHT+IGhZ3MMF1G9eUhv0KEyD94t94yMGvVJ8v/zgQjIcI+G8X0WH3NsDGQ443njuokVZOYzEeuLZA==
X-Received: by 2002:a17:907:9691:b0:aaf:ab71:67b6 with SMTP id a640c23a62f3a-ab2ab73c487mr2376058566b.31.1736865077146;
        Tue, 14 Jan 2025 06:31:17 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9647711sm641498066b.173.2025.01.14.06.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 06:31:16 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 14 Jan 2025 15:31:14 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	David Laight <David.Laight@aculab.com>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC] x86/alternatives: Merge first and second step in
 text_poke_bp_batch
Message-ID: <Z4Z1MoJV0WW-vIHp@krava>
References: <20250114140237.3506624-1-jolsa@kernel.org>
 <20250114141723.GS5388@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114141723.GS5388@noisy.programming.kicks-ass.net>

On Tue, Jan 14, 2025 at 03:17:23PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 14, 2025 at 03:02:37PM +0100, Jiri Olsa wrote:
> > hi,
> > while checking on similar code for uprobes I was wondering if we
> > can merge first 2 steps of instruction update in text_poke_bp_batch
> > function.
> > 
> > Basically the first step now would be to write int3 byte together
> > with the rest of the bytes of the new instruction instead of doing
> > that separately. And the second step would be to overwrite int3
> > byte with first byte of the new instruction.
> > 
> > Would that work or do I miss some x86 detail that could lead to crash?
> 
> I *think* it will work on most modern systems, but I'm very sure I don't
> have all the details.
> 
> IIRC this is the magic recipe blessed by both Intel and AMD, and
> if we're going to be changing this I would want both vendors to sign off
> on that.

ok

> 
> > I tried to hack it together in attached patch and it speeds up a bit
> > text_poke_bp_batch as shown below.
> 
> Why do we care about performance here?

just a benefit of doing that change.. but mainly I was just curious
on why those first steps are separated

thanks,
jirka

