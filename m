Return-Path: <bpf+bounces-56592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F8FA9ADE4
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 14:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC174670B3
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 12:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAFB27B507;
	Thu, 24 Apr 2025 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ewpv/OpJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805A92701AA;
	Thu, 24 Apr 2025 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498970; cv=none; b=p1AQ4cDpGuZepml+4y7I0CxLn4rjUuJeMhelH8mo21JM0YjFWLy0YVTdgESjN95iCMGlgA3oRD24VVXSZ6fw29pYmIIYuFDnxcw/l3hjMWErQPSK2kmIu27NvDo2m3atYUL6NAx0ZWiiEmXq30IVZHJ6hvFN5y3i3bDpu23ZUNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498970; c=relaxed/simple;
	bh=bapCUSztOVKWJwb+5pwmHdYfJohpxwjaju6SBjsiAbw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gADLTVpY0g29bBNrhgvDxoQ91xNG5ofuGg5Uk7CoGOUpEya3OckTSuH3/PwnN2YwkNP3WCu3hc44UxCUxdzTJbSNZppoIXZtmyVPQZDLR1UYG3nHFINSSfKEtZz7r8hDD1zsOuBjzXDWaiae5ymyzEmjPIyimeZoLyreMEAmbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ewpv/OpJ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so1677065a12.2;
        Thu, 24 Apr 2025 05:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745498967; x=1746103767; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VzmIRZFKUMaF4yUV6r2OHqoHDU/etq8iF8bz/8ZLRl8=;
        b=Ewpv/OpJ58zXE5S3+qEb99AY/Ip6IO1thqyXbDSCLgunu+Ls/53QOXc3CruSudy6qi
         YnsOW/OqJyoWTpJT1auUjnRKT0ysTYursLVEzje3fcle9qw9feri/hC5LG3kGTlJM0m8
         iRdZwo5Xq0IDIJO/TT0qe+pTbydD8WEtI8fBI/SZUT0tq8wmRaE9mtQ+LVKtZqaJShuE
         AYPiBF34PgJba8+ztZpP8FS/NyhXm+zl1Ahne/12zeRayT6Agpbj2JI1jXDRLtARkISU
         PdjnjOAm71tYYF9xm97ERgYIxa0UYoWw393H2+odRg0s9AVIDbM1gQpWATfaFEFTokf9
         2Hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745498967; x=1746103767;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VzmIRZFKUMaF4yUV6r2OHqoHDU/etq8iF8bz/8ZLRl8=;
        b=rDM82wx8dJzyRH955OF6d0xlB6RG/zs14VKxB5JvVbVu/HLiCjhYt5TcCkd85zOviJ
         oA4XoBs9tW1LX5N2V3gP+pX33QMiiKBQYHMqJt8+brqCn+3TI4qJOL185fngEXHv/jX+
         dUaFGea7szw1m/zDWYz2gvyhlQfiSqN9P8GgJBfHCYrH6BNcsmWgZqSoronR8Huf6c9d
         oqqXQ6GXnegI2RYmxfmKP4AIsYrNC/UVU49uPbgtCzazM9ixmSG5bHs/gkB0NyN4ZDMD
         17cd0XDfKbr3H7AvfZxwOC5hdS28aGJ+aEN/RzKLrpia40ZyKYcuiEmsMDDO2Ym51dQM
         6E+g==
X-Forwarded-Encrypted: i=1; AJvYcCUFA+Mq/53D3yBFtYCRQWhF/zl1SI2rXXA+k6u2egJkymHS391C0nsB8zA4W5ALJvhoUZsNArjAoflBo48O@vger.kernel.org, AJvYcCV7WmLCL6tj8o8LUTiq4xLTgVEV3QMSfHa/4ngRSz0hdcJG8K9R0OQbAEiZHJ68Q+CyNCI=@vger.kernel.org, AJvYcCWMYZeVrxvBmm2qLYj7XxoFIVF9P9OHSfSrj35/fRi/kZPCTWtG+yw+JrYM95ptqeQEn1tN2AUSTM4UlXbwDitzSMzK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6orHmLRWCfAF1YFV/M1dkYi+FD5BvYnIhf4W12Hudo1GsYrHY
	4KJqsfR1UiycqogedoanK3U6sxMehk2DG2L4bpaysaA8So0bwASx
X-Gm-Gg: ASbGncsl76/I99AnOsPq6DRpUYDbbihbESzyvCnn/aaOKKdvghN+8/Iwn+YXl0BC+Hp
	lSBcW7nD5z2Odu4co5OP6Nrdr7MHlWb/rqekl5tkzgPNsqP0eLLqxeY2jtmkKnVmLEO3DlGKUku
	d2yNqZHHKiR/TFilJ99FYmMNz5gvhbEbmV0aueuEPrapCsP+ZzZeYKgq2dcBdKMn0TzVtWXVffg
	SEqshFe5lYgRqfsBKXVNhwD3aFPrnOrjm3Nssb1ia8Y7UearIqy7mQu0NSTiFIxMK41sZZnyYIU
	c/yrarwsD1A8+XIA1e/skn1GcKj37sMrNqCRkw==
X-Google-Smtp-Source: AGHT+IH+Cy898lAbutMnyRVhjNZkSE8Zdnp6n2x+yfAHOuR14CPAFq0RKw/wQ2T8cMTfQytRbjY0Ag==
X-Received: by 2002:a05:6402:84d:b0:5f4:c8b9:cd2c with SMTP id 4fb4d7f45d1cf-5f6df6329a4mr3031881a12.34.1745498966657;
        Thu, 24 Apr 2025 05:49:26 -0700 (PDT)
Received: from krava ([173.38.220.55])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f6ebbfa79csm1099746a12.42.2025.04.24.05.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:49:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 24 Apr 2025 14:49:23 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 11/22] selftests/bpf: Use 5-byte nop for x86
 usdt probes
Message-ID: <aAozU3alQYU0vNkw@krava>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-12-jolsa@kernel.org>
 <CAEf4BzbxCqgPErQVBV7Ojz23ZEqYKvxi0Y4j8hq6FgXVvdQo9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbxCqgPErQVBV7Ojz23ZEqYKvxi0Y4j8hq6FgXVvdQo9A@mail.gmail.com>

On Wed, Apr 23, 2025 at 10:33:18AM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 21, 2025 at 2:46 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Using 5-byte nop for x86 usdt probes so we can switch
> > to optimized uprobe them.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/sdt.h | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> 
> So sdt.h is an exact copy/paste from systemtap-sdt sources. I'd prefer
> to not modify it unnecessarily.
> 
> How about we copy/paste usdt.h ([0]) and use *that* for your
> benchmarks? I've already anticipated the need to change nop
> instruction, so you won't even need to modify the usdt.h file itself,
> just
> 
> #define USDT_NOP .byte 0x0f, 0x1f, 0x44, 0x00, 0x00
> 
> before #include "usdt.h"


sounds good, but it seems we need bit more changes for that,
so far I ended up with:

-       __usdt_asm1(990:        USDT_NOP)                                                       \
+       __usdt_asm5(990:        USDT_NOP)                                                       \

but it still won't compile, will need to spend more time on that,
unless you have better solution

thanks,
jirka

> 
> 
>   [0] https://github.com/libbpf/usdt/blob/main/usdt.h
> 
> > diff --git a/tools/testing/selftests/bpf/sdt.h b/tools/testing/selftests/bpf/sdt.h
> > index 1fcfa5160231..1d62c06f5ddc 100644
> > --- a/tools/testing/selftests/bpf/sdt.h
> > +++ b/tools/testing/selftests/bpf/sdt.h
> > @@ -236,6 +236,13 @@ __extension__ extern unsigned long long __sdt_unsp;
> >  #define _SDT_NOP       nop
> >  #endif
> >
> > +/* Use 5 byte nop for x86_64 to allow optimizing uprobes. */
> > +#if defined(__x86_64__)
> > +# define _SDT_DEF_NOP _SDT_ASM_5(990:  .byte 0x0f, 0x1f, 0x44, 0x00, 0x00)
> > +#else
> > +# define _SDT_DEF_NOP _SDT_ASM_1(990:  _SDT_NOP)
> > +#endif
> > +
> >  #define _SDT_NOTE_NAME "stapsdt"
> >  #define _SDT_NOTE_TYPE 3
> >
> > @@ -288,7 +295,7 @@ __extension__ extern unsigned long long __sdt_unsp;
> >
> >  #define _SDT_ASM_BODY(provider, name, pack_args, args, ...)                  \
> >    _SDT_DEF_MACROS                                                            \
> > -  _SDT_ASM_1(990:      _SDT_NOP)                                             \
> > +  _SDT_DEF_NOP                                                               \
> >    _SDT_ASM_3(          .pushsection .note.stapsdt,_SDT_ASM_AUTOGROUP,"note") \
> >    _SDT_ASM_1(          .balign 4)                                            \
> >    _SDT_ASM_3(          .4byte 992f-991f, 994f-993f, _SDT_NOTE_TYPE)          \
> > --
> > 2.49.0
> >

