Return-Path: <bpf+bounces-39806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D847977B2B
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 10:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A694E1C245D4
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 08:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7A21D6C61;
	Fri, 13 Sep 2024 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA6c9rGg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B31D6C4A;
	Fri, 13 Sep 2024 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216574; cv=none; b=oc2GTKG43umHrEuRzLF4RLYTaspABQSFN2x7MkNpy5RkYU6WGeJLr77/vdTJKL6CGb1SpVqLhtvwUVnXGEnqF+EfMPJMbbEI49ks1ZLgRq9F2DwoZkmkoBOVKy86GcxbhkbOYYJRbFbVgyRtWe6Q64s29iCiVZoodcuH1hs36uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216574; c=relaxed/simple;
	bh=j9pOAW8cwI/fwha4wRvRickutoRGMzyYJEzP+pq6Xf0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lH/MSHxPWzvntp73iNG0v4zlxGStcdre5uhVKAkbAeeek38kMeLwEX8isxbdSsC83IAgLxmUYkRbf3v/n787p8gljPNMFqLX/KuYyurBhbDATkYi0zq4sjlxLBS9I/rnD0JcNAyZmwgGnkPeeoae0U/QwmfuFNHiRmLPp8wM6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LA6c9rGg; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c24c92f699so1656333a12.2;
        Fri, 13 Sep 2024 01:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726216571; x=1726821371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wveA+nj2BgaJy9/cSFHUWD2pqlBtdFMz2ROmwA5m+EU=;
        b=LA6c9rGgIKAvm1NPblbUFCcsEJAIi2NqylQ8HlZqY8QGYn/vccFomAa6kNm+h58uAu
         JEkjm3jY8Y3AQEcD4GuOl3AS1ejKEh59JVjqa9anTjCaQXTGDWkf5CHBf2m6WcnQO/Mr
         8ZHYB5Xqr9OTum+FEx8bWudDIjLL/xc4rKNBjRQgq54dRwTcxNnz6HpJHJQqaUShaTGA
         MVisOxeKMdl6RcgZYuNraEj13hlxJKLbkPKdD6mHep/CFhkJIlR3xbg1JdXGppgZwt8c
         mk4NqodCm3Wc/8Mguyp7DoObepPaZcAqNAb7xleGSUBYkZzxMVXIqgxR9JOaXDl6XZnq
         A/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726216571; x=1726821371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wveA+nj2BgaJy9/cSFHUWD2pqlBtdFMz2ROmwA5m+EU=;
        b=dPzcy1Qh133oQ5si7p4D0ZSkbrWo+IVE5D7FHhaUg8atHuqYx6rSeUVytcHu/EIqzi
         MF3l7LW/h5aU5sji/wEb/es925UuYEIlt6fgkrn55VcOgj+tFCh7B3cFeFgmgreHsRNF
         wNNS3h4ECnpb46PsTigQgnMeEqyg3ftEb+ZsFtz7xp0qrvq6D7XqOCko++Od1zert4Ep
         ZzTcqpLsaxnzeIDar+5PGFxxKR70/j9cR9ksxGCAPWKCkfv4lp0/JUASQmohDNtsZS/q
         kKvYxdp6jHImml5lssp215l5B4PUdBcFdFiwtA7vsxlmHZbvoGnEI73iSDdvPBXTDkJb
         /eRg==
X-Forwarded-Encrypted: i=1; AJvYcCUhUOerqkZTCqLvFIK3dQHPzi52c76HfZ643BsD+5BPyB+QLpDsWJJdyRGeYb6CqiDh1eDUbqlV5NxFjGnp@vger.kernel.org, AJvYcCWPADY8Q16JWfk6W/CtP1S4E6QNSc75diGDY7fqpBwU8aDwGObFD/XwARLJAnlaG2Dt4hw=@vger.kernel.org, AJvYcCXT02R/0JEF3N3lXqb7QrHpZlB3O6QaY109jA3CVtVLxiIeAt9/dCWDBoOv0uGLP5dZuDXWr2AZkflzdtSjd/ztq3/q@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUYSBk0iEjnsvQarIXE/vPz6IcBErAMgZRQBPyMm8r4wcDGff
	+/Ws0yuNbLegcNBPpP57oXveZ3AY01d763K9aMDjTiOs1BjLGYaC
X-Google-Smtp-Source: AGHT+IGTFCE/nEEw+ce2OJV1Xz1elvdohFZQSw+HZLbHsTKAJLBKhEihz4/+dkJcOQ44tlFeOzaZHg==
X-Received: by 2002:a05:6402:5106:b0:5c2:4cbe:ac33 with SMTP id 4fb4d7f45d1cf-5c413e0607amr4336357a12.2.1726216570475;
        Fri, 13 Sep 2024 01:36:10 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd46853sm7313635a12.22.2024.09.13.01.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 01:36:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Sep 2024 10:36:07 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/7] uprobe: Add support for session consumer
Message-ID: <ZuP5dyfgT0PHaf_4@krava>
References: <20240909074554.2339984-1-jolsa@kernel.org>
 <20240909074554.2339984-2-jolsa@kernel.org>
 <20240912163539.GE27648@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912163539.GE27648@redhat.com>

On Thu, Sep 12, 2024 at 06:35:39PM +0200, Oleg Nesterov wrote:
> On 09/09, Jiri Olsa wrote:
> >
> >  handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
> >  {
> > +	struct return_consumer *ric = NULL;
> >  	struct uprobe *uprobe = ri->uprobe;
> >  	struct uprobe_consumer *uc;
> > -	int srcu_idx;
> > +	int srcu_idx, iter = 0;
> >
> >  	srcu_idx = srcu_read_lock(&uprobes_srcu);
> >  	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> >  				 srcu_read_lock_held(&uprobes_srcu)) {
> > +		/*
> > +		 * If we don't find return consumer, it means uprobe consumer
> > +		 * was added after we hit uprobe and return consumer did not
> > +		 * get registered in which case we call the ret_handler only
> > +		 * if it's not session consumer.
> > +		 */
> > +		ric = return_consumer_find(ri, &iter, uc->id);
> > +		if (!ric && uc->session)
> > +			continue;
> >  		if (uc->ret_handler)
> > -			uc->ret_handler(uc, ri->func, regs);
> > +			uc->ret_handler(uc, ri->func, regs, ric ? &ric->cookie : NULL);
> 
> So why do we need the new uc->session member and the uc->session above ?
> 
> If return_consumer_find() returns NULL, uc->ret_handler(..., NULL) can handle
> this case itself?

I tried to explain that in the comment above.. we do not want to
execute session ret_handler at all in this case, because its entry
counterpart did not run

jirka

> 
> Oleg.
> 

