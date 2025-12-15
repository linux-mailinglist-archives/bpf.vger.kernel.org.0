Return-Path: <bpf+bounces-76566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D942FCBC436
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 03:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 770EF3007B5E
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 02:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E908A2E9748;
	Mon, 15 Dec 2025 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YdPGQE6O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA0DFBF6
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765766462; cv=none; b=BlNYwFC/hDK98yTqhvRkmTue9Yfkuw69KI7AovDLDif8cjn+moAozZ7gq60sy69Z4QgY1fiwKzODuLzQFfyrXkebOvgUOggD6g3mjMyzVh8HpLe/5YueEWr4Zujda3buzFw51KwIX1Ee/ugAq88WrrH5QADmtBT7G87gnmWHwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765766462; c=relaxed/simple;
	bh=viMt1mh6dI9z8Ho4su0HD87jx95MSKvWDzIBlGmxgHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETBEL6fFqnKHHnJ26EfCMrZMFeatR6YLmk/REIxQMCZtc3yGGPd/u7nZCrLq22YKfM775qByQ6K6EtiqjOdmADIvtYAsrYGCgrXujB+so1GKGaBFbXEd05wXtvZbjETctHBjxEzyWtkiurYTNdUZMBd7yg4lDKjtzNigHY4/zLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YdPGQE6O; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47a80d4a065so18332695e9.2
        for <bpf@vger.kernel.org>; Sun, 14 Dec 2025 18:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765766458; x=1766371258; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Nt40lnZCNh5EpT6VP81s0mK0sVXkDLaiUq8eViqp/I=;
        b=YdPGQE6OlWaW2m5lQDxfPp2tja3nWKMkXH7Mm0YlEX6wOfgNM7pbITVpbOQW0yzrO5
         taUP0g+YVesjk2mw2sLaLcqWCG/wCWaan9YQ1OAvxoiM/VS/Vof9bef+kcJt8O3E2n2u
         L8sAQesWRn2tIQ60BYziomaHTflfgt6n5cJqecvJ/lI6hu6I08GnKx+b1fjhydzYabFr
         Jk8z8eBbA/PdmMmkh2VIk1NqSHadX5f4A66LdtlbS+udpO/p7lJV+YD0FeS3tR6AtJBG
         mQAeHykVBxVqhml9lenQ1DExn0ei6m9Cnxvv0v+UlTQKQnnhvvAMPX4N4FPXFrtzkxBh
         6+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765766458; x=1766371258;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Nt40lnZCNh5EpT6VP81s0mK0sVXkDLaiUq8eViqp/I=;
        b=LpSuPJR7Zy/ai0zqIkaDuj7vPkMcedyvYq2VE23yQY8F/yjsTnLcuOQH/Ogs5JxVlR
         iimrYUq0qOpL4fOQgGJULuAMpnGKVSXOE0ng75QJ3mwCEc5H/njbSO+rryep6lEpYH1v
         W3hV/LoD1PI4t6hSE1LN1nH9dhgPXpPHSEcQTtDYagEb6xc0wCHyv+1iD57IYEKB9MET
         R2weh5YQO2RJMBSP/1MaQnyWeSRtB7IRx4HwJpNXtwdKXJeAqYC0M5iHWkykgbyMFl4f
         eiQ3B0WBRPTlQsA6pjhYmtOiHvSVRCsBHWuQm9d4cIGWYzHsbof3Tos7/242FWH4BxkS
         lKyg==
X-Forwarded-Encrypted: i=1; AJvYcCUbLTqhvGaGkR+3DqWFheKU3Rqe6E5zhcYxKgYy3HobRujkb0ndK4VQC115/h/nFRozv3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJBT8NKHwUHXOR0t6e1ZHQsGY7noE/drOauxTf/c9QVjyyL2zV
	q5iw/+eAq3bKsBrsvb4gMopF8oT6Unxyv9JaMmBVQYsVP6X5kyV5495BjzeGMEIPm2g=
X-Gm-Gg: AY/fxX70XSAh8d6Xw0rG31enRHtMOhuGrfPmgt6mmMB7+wmrnBYrBW9T0iRHgNY+Vpp
	vrpGsp9cpAYZ59qGJIc1j6Fze9wAsy80V4gg0aGZZ3kqqRNOXN5DaqtnWoWT/KaOKGFBJ540Ypd
	NF1dpYdsPpUv880zAX63EjEHb2e7WcJydHw/RMEIUzWc3Ae74DM2iejypKEa5O3pICbTRI/AFFI
	L1YPJLpLWd/QqLKJE4V3bQzv/F3IbxlnwjyDL/DoyjSitSiv9D8QhS9MuqQCl6YyUPDLYn53KWo
	UVW97+VNNUCCcW1yAdjlwHaIcHy/WgsO1zORr1ThZTCCMjJdg4vCFxIw8+JTOhUIsrO8RRtyawq
	jxGScYtG9Jdn5tvux079NT+UedgLaWgKGQWwxmhsgRKsF3pGi8i/I74VIpQ3zdG6f5Hlj8TDl2N
	I6BIzfKGZfVO5gkSTSgyEZGdwh4Nx1IXNnR1Rxml3DPlg+J6hCiF/xk9bLXMGACYdUqsotkNenP
	9F5zI3g
X-Google-Smtp-Source: AGHT+IE8zEZK8YZx46VxHccQb4Iy3sJBVYYEepfTM9OGnNkJ8qxx5SmLIuYbjd6YPBlvINyXZhXm/A==
X-Received: by 2002:a05:600c:4f90:b0:477:b0b8:4dd0 with SMTP id 5b1f17b1804b1-47a8f905680mr98566245e9.17.1765766458551;
        Sun, 14 Dec 2025 18:40:58 -0800 (PST)
Received: from u94a (2001-b011-fa04-1431-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:1431:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c11d3e8af1asm5169995a12.2.2025.12.14.18.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 18:40:57 -0800 (PST)
Date: Mon, 15 Dec 2025 11:40:47 +0900
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mykolal@fb.com, martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v1 1/3] bpf: Introduce tnum_scast as a tnum native sign
 extension helper
Message-ID: <vguvxgnuifn6pgmvtvbqexvibysndwaj7ne3pfwej4a7wjnpta@pv4764o2oikv>
References: <20251125125634.2671-2-dimitar.kanaliev@siteground.com>
 <b37af1dcde7b7efb4dfc0329ca3ea1c3f4ede7e9b8eb02a1eabd042d561f00fd@mail.kernel.org>
 <2fb2cuygiz5ljalrbpizk4njnj4dojx53c5fxy36ock5g5w3r7@7pigobi3ymw4>
 <CAHx3w9J35G0bn-TyKEJ_u0A3NxupzvQZKmq_3JirwFdGk-P_tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHx3w9J35G0bn-TyKEJ_u0A3NxupzvQZKmq_3JirwFdGk-P_tQ@mail.gmail.com>

On Mon, Dec 01, 2025 at 09:43:32AM +0200, Dimitar Kanaliev wrote:
> On Wed, Nov 26, 2025 at 10:56 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > On Tue, Nov 25, 2025 at 01:22:13PM +0000, bot+bpf-ci@kernel.org wrote:
> > > > diff --git a/include/linux/tnum.h b/include/linux/tnum.h
> > > > index c52b862da..ed18ee114 100644
> > > > --- a/include/linux/tnum.h
> > > > +++ b/include/linux/tnum.h
> > > > @@ -63,6 +63,9 @@ struct tnum tnum_union(struct tnum t1, struct tnum t2);
> > > >  /* Return @a with all but the lowest @size bytes cleared */
> > > >  struct tnum tnum_cast(struct tnum a, u8 size);
> > > >
> > > > +/* Return @a sign-extended from @size bytes */
> > > > +struct tnum tnum_scast(struct tnum a, u8 size);
> > > > +
> > > >  /* Returns true if @a is a known constant */
> > > >  static inline bool tnum_is_const(struct tnum a)
> > > >  {
> > > > diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> > > > index f8e70e9c3..eabcec2eb 100644
> > > > --- a/kernel/bpf/tnum.c
> > > > +++ b/kernel/bpf/tnum.c
> > > > @@ -199,6 +199,19 @@ struct tnum tnum_cast(struct tnum a, u8 size)
> > > >     return a;
> > > >  }
> > > >
> > > > +struct tnum tnum_scast(struct tnum a, u8 size)
> > > > +{
> > > > +   u8 s = 64 - size * 8;
> > > > +   u64 value, mask;
[...]
> > > > +   value = ((s64)a.value << s) >> s;
> > > > +   mask = ((s64)a.mask << s) >> s;
> > >                                     ^^
> > >
> > > Can this invoke undefined behavior when size is 0? When size==0,
> > > s becomes 64, and shifting a 64-bit value by 64 bits is undefined
> > > behavior according to the C standard. The guard only checks size >= 8,
> > > allowing size==0 to reach the shift operations.
[...]

Looking into this again I realized that while size can't be 0, we could
still have undefined behavior here. The first is that there could be
left shift on negative value, for example when:

     size =  4
        s = 32
  a.value = -1 (0xffffffffffffffff)
  a.mask  =  0 (0x0000000000000000)

In calculating of `a.value << s`, there is overflow of s64 because we're
doing -1 << 32. Similarly for `a.mask << s`.

IIUC another one is that is that when left shift causes a positive
integer to become a negative one, e.g. ((s64)255 << 56 ==
-72057594037927936). Less sure about this one.

In short, seems best to avoid left shift on signed value by moving the
cast outside of the left shift, and there shouldn't be any difference
when it comes to the intention. We're only interested in arithmatic
right shift since that is where we get signed extension anyway.

  value = (s64)(a.value << s) >> s;
  mask = (s64)(a.mask << s) >> s;

