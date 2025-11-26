Return-Path: <bpf+bounces-75548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6C7C88A58
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10F314E7367
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 08:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CDC3164D9;
	Wed, 26 Nov 2025 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCfFWicG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC0D4A0C
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764145818; cv=none; b=I0wkljExdXEh/UGW7ama0nZ4mkSX3Cr+R6S8UwDEOLKJqq91C421FQJEMEjmO4DBOCEfs49V2zIf6DptSC7z7IxumFQVnc5WqztFaJ/vLEciHA5ja/GOPnFyL2Fc3kTrRMMYac3rzh+Yh4glc4DHNit7YbXwwaci1651sBIUuJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764145818; c=relaxed/simple;
	bh=R+1IgnqMNp8jM5umrzoBkqXY4tsMqtF8FeDcnhQuDGA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVsZpDfb+s3s4QOerKdD/VIe6xQf5mAMMGLcMPFA3THI0cJFpWNxMnP6b8ozCsHtOXGTUBqq53WHGseDO42hFejJAVF3g7B13hguyoIkDigMwbBCN09tH9uxdljTyeR+NjHSYdRZjftEhyG9CLWUjeVg9aEY+x0GVSf57zyUOvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCfFWicG; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42bb288c17bso3858412f8f.2
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 00:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764145815; x=1764750615; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gz8/UW+ei8i9IKW/FoojjihxydimMNABJs90h2u4QaA=;
        b=fCfFWicGPke70imGUeT9O8sdMXmYw06dlG8AUC5+Lf2CHUiDXkSD6O6g2Dg6IsPIhk
         mhbUikXAcHI5Qe04atTTUvmY3ynL9/yi0Bli2A7sA8pMjnPWIl2ZR6OIUBfxbvv4lgSq
         tJN2no4hutTH2bjI3Mx/jl0YyggwjtIF4UWbp8W7ixO6G75itcVU/zhkvoZWRrJxhyI7
         olCoogF1uMdO4MwNjQ17H78wcGa4VvHDK/iIwExlHtzAhWxkQnHyEjYHWJYQfNAhjxdr
         JLcHn0n15ZW6M5UDnZClIsCPrwFfuX3IwHVB7G3AI9SpgKfbnREOu2DJhLYhKMZ+DJIW
         3Qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764145815; x=1764750615;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gz8/UW+ei8i9IKW/FoojjihxydimMNABJs90h2u4QaA=;
        b=Z8zlVf1jQgbf4iaWbO9oYcqXRQ9MiRrPGpdRuhXJYrXL/JCJrJuCRbX3rJTMJv1cOt
         fI5xf3gE9QdbWmIB2DwBBkj2PSTcdbLxO3jkJQdv5dwweugZCkYbBqCq/hEoFB9O43Bo
         cEvaxff3JiEpMsXlfrUgIcTeK7fcpOYyt7ifKe1X5nepBjOgw+MExkgmiDSzJglC3Nx8
         wHxwh/ufDoJmrlMTBNsK+oqGZWn/tBKUT6AI/SPAuEnPXR4sYy3xoaB31fR2m88OpmcV
         uoZks2/chs8n0WLd9y+iZ1oeWERrQVJCpxX5fBW5/JF9RytCuCfzUdDt2NhnlosCyYc+
         Exvw==
X-Forwarded-Encrypted: i=1; AJvYcCVLpGxWEEPV7jh43xetu8Fo4OkcLfdZPzpfA4oJcAVmoZVnYuEyKcwsUloFLcJ1jlZGG6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YySFhIDK8VAm3Wui6DtAqCLeKV+t7YTu6QEBvBwLy7wqCCqdPoh
	KfbzS4+V8irhUBnSAK+/+QnXQBVuEepMprsvEsZ+fwaK6+c1L4EbiwA4
X-Gm-Gg: ASbGnctFBM1j9WsYdcgvkAcQ6rO/2UfYf6rGQWGeJoCHiab3pU1FYSbyPfazOCEj19q
	m3QN04YFxsDR/oFSBJue15H0AqJrUXENbjGOlL2sB23T8jSh3g1LVCGUJHC5nhN1ENRjwNmOZ4q
	4nSuPlA1mYqEe+4if86flbhEUkzyJoNcw3QEeII44oUU/ogR7NTGaPp48+5yYM8NTHfykvJOiJJ
	ADLtSn7kpJjN7P9HiljbnaPkNPpKIOBjnSOGA/VYwZ+LNiP+Czx3AaRna6TVoaa7WRmYZpF7zOs
	aZ0XeA5fCNPldK/DVnXxin/Ymwe02oKPWBpKGfPBpBR8UHaQC2p9yoR3h3NgdWldZlWV2aKUL9R
	qNndYMCkUTQjzxuJ/4maWpeqC7VZy+BuqMWfeL7MpIacd0NqCsrp2/PAPV4eSbkXLOwb1AUA=
X-Google-Smtp-Source: AGHT+IF249voOOYfx+AouCygi+sk+CNnqHeHSXjKdvIzHnjxw92qxxfxbWHtqN+rayBM/d5fmUlVnA==
X-Received: by 2002:a05:6000:2584:b0:42b:2a09:2e59 with SMTP id ffacd0b85a97d-42cc19f0942mr20325783f8f.0.1764145814513;
        Wed, 26 Nov 2025 00:30:14 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e581sm36920854f8f.8.2025.11.26.00.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:30:14 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 26 Nov 2025 09:30:12 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 3/4] libbpf: Add support to parse extra info in
 usdt note record
Message-ID: <aSa6lMkV3VkIM95g@krava>
References: <20251117083551.517393-1-jolsa@kernel.org>
 <20251117083551.517393-4-jolsa@kernel.org>
 <CAEf4BzZg3sWvD7TwP-V=qw78TF5O6SEt=qJB05b0yOs-27fkEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZg3sWvD7TwP-V=qw78TF5O6SEt=qJB05b0yOs-27fkEw@mail.gmail.com>

On Mon, Nov 24, 2025 at 09:29:09AM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 17, 2025 at 12:36 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to parse extra info in usdt note record that
> > indicates there's nop,nop5 emitted for probe.
> >
> > We detect this by checking extra zero byte placed in between
> > args zero termination byte and desc data end. Please see [1]
> > for more details.
> >
> > Together with uprobe syscall feature detection we can decide
> > if we want to place the probe on top of nop or nop5.
> >
> > [1] https://github.com/libbpf/usdt
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/usdt.c | 27 ++++++++++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > index c174b4086673..5730295e69d3 100644
> > --- a/tools/lib/bpf/usdt.c
> > +++ b/tools/lib/bpf/usdt.c
> > @@ -241,6 +241,7 @@ struct usdt_note {
> >         long loc_addr;
> >         long base_addr;
> >         long sema_addr;
> > +       bool nop_combo;
> >  };
> >
> >  struct usdt_target {
> > @@ -262,6 +263,7 @@ struct usdt_manager {
> >         bool has_bpf_cookie;
> >         bool has_sema_refcnt;
> >         bool has_uprobe_multi;
> > +       bool has_uprobe_syscall;
> >  };
> >
> >  struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
> > @@ -301,6 +303,11 @@ struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
> >          * usdt probes.
> >          */
> >         man->has_uprobe_multi = kernel_supports(obj, FEAT_UPROBE_MULTI_LINK);
> > +
> > +       /*
> > +        * Detect kernel support for uprobe syscall to be used to pick usdt attach point.
> > +        */
> 
> nit: single line comment
> 
> but I find the wording confusing, we don't really use uprobe() syscall
> to pick USDT attach point (which is what comment implies in my mind).
> Just say that we detect uprobe() syscall support. It's presence means
> we can take advantage of faster nop5 uprobe handling. Also, please add
> reference commit hash + message, just like for other feature detectors
> here.

ok

> 
> > +       man->has_uprobe_syscall = kernel_supports(obj, FEAT_UPROBE_SYSCALL);
> >         return man;
> >  }
> >
> > @@ -784,6 +791,15 @@ static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *
> >                 target = &targets[target_cnt];
> >                 memset(target, 0, sizeof(*target));
> >
> > +               /*
> > +                * We have usdt with nop,nop5 instruction and we detected uprobe syscall,
> > +                * so we can place the uprobe directly on nop5 (+1) to get it optimized.
> > +                */
> > +               if (note.nop_combo && man->has_uprobe_syscall) {
> > +                       usdt_abs_ip++;
> > +                       usdt_rel_ip++;
> > +               }
> 
> how hard would it be to check nop5 instruction in ELF file to be extra
> safe? I'm just not sure if I'm 100% comfortable just trusting that
> extra zero byte :)

good idea, and we do have the Elf object as argument, so it should be easy enough

> 
> > +
> >                 target->abs_ip = usdt_abs_ip;
> >                 target->rel_ip = usdt_rel_ip;
> >                 target->sema_off = usdt_sema_off;
> > @@ -1144,7 +1160,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
> >  static int parse_usdt_note(GElf_Nhdr *nhdr, const char *data, size_t name_off, size_t desc_off,
> >                            struct usdt_note *note)
> >  {
> > -       const char *provider, *name, *args;
> > +       const char *provider, *name, *args, *end, *extra;
> >         long addrs[3];
> >         size_t len;
> >
> > @@ -1182,6 +1198,15 @@ static int parse_usdt_note(GElf_Nhdr *nhdr, const char *data, size_t name_off, s
> >         if (args >= data + len) /* missing arguments spec */
> >                 return -EINVAL;
> >
> > +       extra = memchr(args, '\0', data + len - args);
> > +       if (!extra) /* non-zero-terminated args */
> > +               return -EINVAL;
> > +       ++extra;
> > +       end = data + len;
> 
> end variable just to use it once in the comparison below? Also, how
> about just this:
> 
> extra++;
> if (extra < data + len & *extra == '\0')
>     note->nop_combo = true;
> 
> ?
> 
> (why assuming extra is the very last byte, maybe we'll have more
> "extensions" in the future :) )

well, it is the very last byte for now ;-) but sure, will change

thanks,
jirka

