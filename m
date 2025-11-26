Return-Path: <bpf+bounces-75546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 916F3C88A2E
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17AA33543C3
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 08:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E81B315D3E;
	Wed, 26 Nov 2025 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCcYAjFk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBC3FBF6
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764145791; cv=none; b=qKh1h/HrgJaiJyt7wmTC0TU8u6UzuXpFN21EWlaf0Euq1TdaGx25ukTgsjTuwshBvqLY1yeirVgBhAAIO8p720chdXNalEdiwntn6lai+CrUtGEyo1TY3PX4dulXRhebDYYU6RQu977PcN23369Cr2ZqE2I+PoEpZoKpyshquUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764145791; c=relaxed/simple;
	bh=GFnpp+Wn8hvMjBAq5BQjznKICmYat4XMDiShPx6NwE8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yxmr2ok72EuhbpgKmmmXNOpJ/2yl631HFyMzh06H/4Ad3kNbFrU8l+QooMDgfCciYQKkK0T5Uc352tcpn25AGOTaCU7wedi5inYZKZsTcL/5K/wSrlLU5aj5/wAIzLq33MnAX/ZMHjXiKpxFEkdOAiZcwa6wwpXYqSXvQNJDpUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCcYAjFk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47118259fd8so55936705e9.3
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 00:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764145786; x=1764750586; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=axJwRzJfcZn97VqPk57RHFfW0fq/xUaxkOSSTIHVd0U=;
        b=VCcYAjFkTnyIZ+AcjY28RMrSNaxPWRh/kfj/z05KX0wgULZitpWbJCJ7Xz02mytvd/
         dyE/N9T3YJQTLtSFLsPmIt7ICJz1/z9H94cagzv/F9kDITM7/F76os5YbKZRhVFrIA24
         ESCUQ/DIo5DuUycmg7y8UtT04oFjUet+A3k639awFppQJ5xfl5ky5SO1u7MNP0uwAipW
         qrg8rLkPvQZEWAjKQFRA6YcytKFw2HWdUL2Pl8F/JteicEDkl+pqBSuW+ERObg/gpqT5
         tvT+HCDCiQV0WP40uC+VXyLGKROzqkbTCpaNyydGZ59sQjtBnKTQrHy5TUj2Ro8nlbcg
         0UdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764145786; x=1764750586;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axJwRzJfcZn97VqPk57RHFfW0fq/xUaxkOSSTIHVd0U=;
        b=vZBFLjZyV7IHEBNhPgL47A64I73zkULOh9xnfkgXYfF81B5iNqgWi7fW7MaFY/5JKC
         ZYq62Y6l8yNe8OzyqJNx7q2wcEpUEmtwNi4oPsw8Sqe5kX9ICKFC08SAXhqWcMWAAbBI
         nAtlsBd3fJ0LJAqMJ0RWld7vGmgMpdD/upclZK7vhwS9vyUH6PVX2LgE9lzdfpWflxlJ
         bSIaWGGicNpkJk7toSMEo43375sgVUCoYsiAJt9QKIIKmvU+9AVLCvt5slo7J57+Km3S
         Hh0DmYT0clozpN5DEkr+qa3yap+jCWTrdsBSqF01QimShmpI5gNoSXviaz2FD/6hQfeK
         RfLA==
X-Forwarded-Encrypted: i=1; AJvYcCVXZs65cwTAbp8D4twLB6dDOpFpGYk2y+IIBNasxcNntr3JU14tsWEM1CjneSdVD89OlzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaMK4oDk+RF+pKdewtjVnBtfN0mSpy/qP8MUVblYcTyWCqEW0h
	sRdPa41xstq18A1bVF7CYkBJh4doak1mMSeEscH+YEFSYbBxTIr/A7OEOEGhKA==
X-Gm-Gg: ASbGncsZEDG3Ifo3v4gXR+NVYBgZVTSu9D5iq3f2SOZkpqCyiL5f8G+dpCkdN2NNXPC
	ofcdM0k7YMLqYOgFKCtDaYeBmthlp30oQ43wWUPPSOPuBgaMuNBZ7P7uHlzJ8mOsNJUGVSfXVKa
	WjOgGiEx3DElDca1t6ZoQHdqsUUqRW7G72yQ3D6ppL9htlFjmxln8IaRsLMjLCQUv5KHAt5O3Cm
	TWNxWLDGuNMjuamkgyWdTdFkeUr8Wa/klas/bupa87MOtNkNMXp0FuhjTt1mCGX0Fih4Co64938
	6lLUdvTMsRJfd7cIHT/bo92J6PbbDxHlOamAh2yhAsNSu61EuiPhyJq4hc18uDPSKpEALBSKHsr
	N3TA5it15jiKBCm5uRPQ135ScleoXuO1pJAteNdFzgVzkzAWVaBlx3DsbG5vk
X-Google-Smtp-Source: AGHT+IEfJ/MzYl1IbGxFr5UX2AR0AI31EEtJQe3vfUY7glHzJ5dBJPC16eg0eTPzR1Bx8kAnwqirXQ==
X-Received: by 2002:a05:600c:1c19:b0:477:7bca:8b3c with SMTP id 5b1f17b1804b1-47904b10379mr68289925e9.19.1764145786076;
        Wed, 26 Nov 2025 00:29:46 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47906cb1f60sm34068405e9.1.2025.11.26.00.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:29:45 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 26 Nov 2025 09:29:43 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: Emit nop,nop5 instructions
 for x86_64 usdt probe
Message-ID: <aSa6d8bm7Jm6Ojn7@krava>
References: <20251117083551.517393-1-jolsa@kernel.org>
 <20251117083551.517393-2-jolsa@kernel.org>
 <CAEf4BzaETfgoAOuVgA8r37Aso2yxQRVe8=KxGV7+B9LqPzduXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaETfgoAOuVgA8r37Aso2yxQRVe8=KxGV7+B9LqPzduXw@mail.gmail.com>

On Mon, Nov 24, 2025 at 09:29:01AM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 17, 2025 at 12:36 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > We can currently optimize uprobes on top of nop5 instructions,
> > so application can define USDT_NOP to nop5 and use USDT macro
> > to define optimized usdt probes.
> 
> Thanks for working on this and sorry for the delay, I've been
> travelling last week.
> 
> >
> > This works fine on new kernels, but could have performance penalty
> > on older kernels, that do not have the support to optimize and to
> > emulate nop5 instruction.
> >
> >   execution of the usdt probe on top of nop:
> >   - nop -> trigger usdt -> emulate nop -> continue
> >
> >   execution of the usdt probe on top of nop5:
> >   - nop5 -> trigger usdt -> single step nop5 -> continue
> >
> > Note the 'single step nop5' as the source of performance regression.
> 
> nit: I get what you are saying, but I don't think the above
> explanation is actually as clear as it could be. Try to simplify the
> reasoning maybe by saying that until Linux vX.Y kerne's uprobe
> implementation treated nop5 as an instruction that needs to be
> single-stepped. Newer kernels, on the other hand, can handle nop5
> very-very fast (when uprobe is installed on top of them). Which
> creates a dilemma where we want nop5 on new kernels, nop1 on old ones,
> but we can't know upfront which kernel we'll run on. And thus the
> whole patch set that's trying to have the cake and eat it too ;)

ok, will try ;-)

> 
> >
> > To workaround that we change the USDT macro to emit nop,nop5 for
> > the probe (instead of default nop) and make record of that in
> > USDT record (more on that below).
> >
> > This can be detected by application (libbpf) and it can place the
> > uprobe either on nop or nop5 based on the optimization support in
> > the kernel.
> >
> > We make record of using the nop,nop5 instructions in the USDT ELF
> > note data.
> >
> > Current elf note format is as follows:
> >
> >   namesz (4B) | descsz (4B) | type (4B) | name | desc
> >
> > And current usdt record (with "stapsdt" name) placed in the note's
> > desc data look like:
> >
> >   loc_addr  | 8 bytes
> >   base_addr | 8 bytes
> >   sema_addr | 8 bytes
> >   provider  | zero terminated string
> >   name      | zero terminated string
> >   args      | zero terminated string
> >
> > None of the tested parsers (bpftrace-bcc, libbpf) checked that the args
> > zero terminated byte is the actual end of the 'desc' data. As Andrii
> > suggested we could use this and place extra zero byte right there as an
> > indication for the parser we use the nop,nop5 instructions.
> >
> > It's bit tricky, but the other way would be to introduce new elf note type
> > or note name and change all existing parsers to recognize it. With the change
> > above the existing parsers would still recognize such usdt probes.
> 
> ... and use safer (performance-wise) nop1 as uprobe target.
> 
> We can treat this extra zero as a backwards-compatible extension of
> provider+name+args section. If we ever need to have some extra flags
> or extra information (e.g., argument names or whatnot), we can treat
> this as either a fourth string or think about this as a single-byte
> length prefix for a fixed binary extra information that should follow
> (right now it's zero, so forward-compatible). For now just extra zero
> is the least amount of work but good enough to solve the problem,
> while being extendable for the future.

ok, makes sense

> 
> >
> > Note we do not emit this extra byte if app defined its own nop through
> > USDT_NOP macro.
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/usdt.h | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests/bpf/usdt.h
> > index 549d1f774810..57fa2902136c 100644
> > --- a/tools/testing/selftests/bpf/usdt.h
> > +++ b/tools/testing/selftests/bpf/usdt.h
> > @@ -312,9 +312,16 @@ struct usdt_sema { volatile unsigned short active; };
> >  #ifndef USDT_NOP
> >  #if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
> >  #define USDT_NOP                       nop 0
> > +#elif defined(__x86_64__)
> > +#define USDT_NOP                       .byte 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x0 /* nop, nop5 */
> >  #else
> >  #define USDT_NOP                       nop
> >  #endif
> > +#else
> > +/*
> > + * User define its own nop instruction, do not emit extra note data.
> > + */
> > +#define __usdt_asm_extra
> 
> I'd guard this with ifndef, just in case user do want custom USDT_NOP
> while emitting that extra zero (e.g., if they have nop1 + nop5 + some
> extra they need for logging or whatever).

ok

> 
> >  #endif /* USDT_NOP */
> >
> >  /*
> > @@ -403,6 +410,15 @@ struct usdt_sema { volatile unsigned short active; };
> >         __asm__ __volatile__ ("" :: "m" (sema));
> >  #endif
> >
> > +#ifndef __usdt_asm_extra
> > +#ifdef __x86_64__
> > +#define __usdt_asm_extra                                                                       \
> > +       __usdt_asm1(            .ascii "\0")
> 
> nit: keep it single line
> 
> 
> btw, the source of truth for usdt.h is at Github, please send a proper
> PR with these change there, and then we can just sync upstream version
> into selftests?

yes, will do that

thanks,
jirka

