Return-Path: <bpf+bounces-22067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42186855D70
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 10:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23141F21453
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 09:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407A1171CE;
	Thu, 15 Feb 2024 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGjAUcWN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111D513ADD
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988124; cv=none; b=VBjz8Tvs2aq4F1dWErpZgMGIu4QIyCfW27V49NdQyKymi2piT89ZpdyXUltVjMBsmbLOm6fmRNuRsMeKW4MxkUkMVdEHKtbF/hBDqiJQHeOw3ImXQyFMiNfUbLvNeTmyOyXk7FTeWH7AvBK2ekf98GPIamzXMnkRKe9RegdoP+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988124; c=relaxed/simple;
	bh=bBEIV1cBxCJ3hS8tirG0+JX+DH5KxdRy484gLlTDizI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZIzwR8kyChQZT1/7N0+qWt+MSnltXOoIGjVrKb8WenCI7P+mj1WX4sheVYmiMris6CWX7V0agqnpV0FScwo6fmoFG4MpoyWW24AoYF0ls8Re3Fgj4ZVVBuAruSEjtugM7arpc2BdTogreA6rEds0DBCZHqFOQruZCwviEQmJUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGjAUcWN; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5120ecfd75cso799885e87.0
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 01:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707988121; x=1708592921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EBmepH5HqEG5bo+NhXzjNcQva+/AEu2Rw+wtIvUhXtA=;
        b=FGjAUcWNWy7jZ5w2PmoK5YY2PLKtXRaGjLz4qA95uDUzNB/GH/1rjm8xaq8mbpmbE8
         sn1J7iXDwtyA0lhJHhF3VXkBuPxzH31juX9TNrAkrwrbCMfqhRZlcb5C4zJ5HTYYM30w
         tNRguubfWhEdPxE3hJ+zRHjXJBf1UHvsIgRKjl8OZfFT43KHk6cT0HXIC5gzTL9UOyGx
         AlQsaKIYO+MKYcLnBnh06pcPvSH2R+P9fpwgIXaG3QaoWw90xrTWvF0iWVjnDqHA72vz
         0QulwjiDU9uE3c54GdCP8wQHgDUFBMijcQqpsqbbZ/A6JUipvtWseEY0JIl7nigNc0XL
         U+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707988121; x=1708592921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBmepH5HqEG5bo+NhXzjNcQva+/AEu2Rw+wtIvUhXtA=;
        b=Kd/obfo3F9ZmfaVvRKWnvyMKQYAsO+ttWr7GiDBoTmSEbSBczLUPyvbEsJd0NPNgyX
         uVoViysMzBsFC7iWaZFTXoVBs1UfrmMDFBrEd6noRKoD0brjNBtnIifGhdNKJwYgc6kL
         r6KChGX74hwP9+3Q/UvRuc41DZYhx/C9gqaALFEtDcwhfdX8to+yLjD+OnMc00ztG70U
         K+HcOWzoMharcaBPmPir6ZSANgmjk9m/6n4YGbChNAzjb5a49jHHUG2L0CP4aM1wAlbR
         cZQBubosoXBwsTwQVuNOLOlWCyrzR4cFw/+vrlAnVciC+IP3r3U5V2GGBlZQ3t9qKIcP
         K9Ug==
X-Forwarded-Encrypted: i=1; AJvYcCX9urAy/vRcZLsGmPzIx67v5YU8T7E9c7Sh012QZAh6Cqso2IrG1THk5Lvw96PGq+KjJgML4om76lhw0/lfG6ay9wQc
X-Gm-Message-State: AOJu0YxwIRZ/8T7lFdseAYH6/dyXCuKEMYnD5iF5pEaMVYj5OKfRkHiI
	MQr9HK6BwVb1KrtNEE36A7oybMliJkf9lKJKzfPgCD2+nknRLl/K
X-Google-Smtp-Source: AGHT+IGB6D4hm0/YvviZGMeWALzabUUYKsSOdopm9St0H0hzK9E9TjifRRLuDVnKoV6f/arJg1tkTg==
X-Received: by 2002:a05:6512:32b2:b0:511:3a32:4e4f with SMTP id q18-20020a05651232b200b005113a324e4fmr824628lfe.18.1707988120736;
        Thu, 15 Feb 2024 01:08:40 -0800 (PST)
Received: from krava ([2a02:8308:b08e:be00:8f2b:9f9:3953:bf])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c458800b0040fb783ad93sm1288535wmo.48.2024.02.15.01.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:08:40 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 15 Feb 2024 10:08:38 +0100
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH RFC bpf-next 1/4] fprobe: Add entry/exit callbacks types
Message-ID: <Zc3UllfMobF109i7@krava>
References: <20240207153550.856536-1-jolsa@kernel.org>
 <20240207153550.856536-2-jolsa@kernel.org>
 <20240214003546.75688cf56b548a86eb090068@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214003546.75688cf56b548a86eb090068@kernel.org>

On Wed, Feb 14, 2024 at 12:35:46AM +0900, Masami Hiramatsu wrote:
> Hi,
> 
> On Wed,  7 Feb 2024 16:35:47 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > We are going to store callbacks in following change,
> > so this will ease up the code.
> > 
> 
> Yeah, this looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Hmm, can I pick this in my for-next tree?

I don't mind you picking that up, I'll have to send new version of
the rest of the patchset, but I think I'll still need these types

jirka

> 
> Thank you,
> 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/fprobe.h | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
> > index 3e03758151f4..f39869588117 100644
> > --- a/include/linux/fprobe.h
> > +++ b/include/linux/fprobe.h
> > @@ -7,6 +7,16 @@
> >  #include <linux/ftrace.h>
> >  #include <linux/rethook.h>
> >  
> > +struct fprobe;
> > +
> > +typedef int (*fprobe_entry_cb)(struct fprobe *fp, unsigned long entry_ip,
> > +			       unsigned long ret_ip, struct pt_regs *regs,
> > +			       void *entry_data);
> > +
> > +typedef void (*fprobe_exit_cb)(struct fprobe *fp, unsigned long entry_ip,
> > +			       unsigned long ret_ip, struct pt_regs *regs,
> > +			       void *entry_data);
> > +
> >  /**
> >   * struct fprobe - ftrace based probe.
> >   * @ops: The ftrace_ops.
> > @@ -34,12 +44,8 @@ struct fprobe {
> >  	size_t			entry_data_size;
> >  	int			nr_maxactive;
> >  
> > -	int (*entry_handler)(struct fprobe *fp, unsigned long entry_ip,
> > -			     unsigned long ret_ip, struct pt_regs *regs,
> > -			     void *entry_data);
> > -	void (*exit_handler)(struct fprobe *fp, unsigned long entry_ip,
> > -			     unsigned long ret_ip, struct pt_regs *regs,
> > -			     void *entry_data);
> > +	fprobe_entry_cb entry_handler;
> > +	fprobe_exit_cb  exit_handler;
> >  };
> >  
> >  /* This fprobe is soft-disabled. */
> > -- 
> > 2.43.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

