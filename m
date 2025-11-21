Return-Path: <bpf+bounces-75229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0091AC79E6A
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 15:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5BF9E382037
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 13:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AFA34D4CE;
	Fri, 21 Nov 2025 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWFxWUUC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A834D4C6
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733179; cv=none; b=p/7vDBOFdOETbC8yRa+/fHeLmx5J0q+oNQ565m1+UCpII59Ahk/n+mXhuBSxbkWrsmKyA68YIUmNkrVoc6FvsgXy1ug+zvYdr1i4s+ET404w6tsTPINL8spPb9LwsO7mvCK9xlTRgicSlT7xZv5MoWcHLMIHl6E/n3Qg9Men6d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733179; c=relaxed/simple;
	bh=7GEwhLRQ1W3Q/9N49gCA8cSzhLGa0qH1tLD6r0XU+zg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcTaImbRehcb+Ld4CkiL0PGoAvifvHARzgJ8VOpYtyqo0Fc+qJwtH+5HKBo3DSuoXxx8ApxDUx51tj34t31C45rPrQK1mUq9Op4RlZB3vNGTlwVHkhS+FGjsQ0gFBnpkWLd0VeDpdbGwUvA6K+eY6eZfeQl4gQHMkGWQ5ynjGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWFxWUUC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b379cd896so1219591f8f.3
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 05:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763733176; x=1764337976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dHb504fa+R3MQSYXb7rM8ukJxMXoBFNQYhj0anYj8Ok=;
        b=RWFxWUUC6GakTEceebcC8u9ik2zHZKjuo+f5jDtu0P1MW7tjDrQTDizZiK8ijXmgnH
         F6IPdRPeUnUXa3C4SigmmGGVPTR2amgzrf3MPyDxI8jHDZJqRLIUzUmGZDaPFIHq11af
         Jb80mO96eYo5UX5oAXebtWMxZ0KEckf2hcXkIKYnYRuzyDKZu6bAuCTjGjGA268cEMb+
         E7eAvT9WaASsVwTrfRMzs5doPSWczyfBKACJxAlJAva1nIttFqN/AI/87b8UTpZo4vJC
         h6TgP9Usl1wJL6P29q+Wsk8CmotM8SDRj8TlRH8Vys9CzpolZxasa+eUbp0ikAys8RDz
         s0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763733176; x=1764337976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHb504fa+R3MQSYXb7rM8ukJxMXoBFNQYhj0anYj8Ok=;
        b=XKmmI84/VcAI7Fmn2RlABfTnNe1x9R8/VSX8RBhHHrDKKyS/q76K5TOrX24rc18ldM
         CKy0S3d1rL157RV0fAjTR2sDPREc+T8VPl800G8fogM0Y1VIarM0LIYoQg/i3IFN3R8g
         76UR8aSkeYBvm6YWjobWjv2pEAwc+ekTKdgz1fxLJjCgnSQ86swHF5jCtoGh+Cn71tqI
         DnxgHfBx6yhg5e+dandRdLrCLSd6G1JBLOWlWz7ww1xRyUUzYatvyWWkr+aj5uTyo13G
         TkHnKxvT+ElDtIEEwPtS9qLI5yaJkjJxxw5pw562KeUlk0AoPJqV0OgA+ueWZr9XCUXz
         qRPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRa7EHU1wI70xPsDnBPSpkbOG3Z5AkmckazVYGBkH8qrkbFJAe87l0xbBjZ3G0Rkr4Ngg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNE2KnWOiKMNYTlTGu8+wD7tvzqytS4PTZbieHDur1P+KcgndL
	nia6/ivmhy1V3WhUUtJ6Ag5RdNeeeEB/ZXXfI2T6BUoFAYlPmSyXTzGH
X-Gm-Gg: ASbGncsYAno1GudAkxJUjWLNPH+sgWRVrqGEMraNxjyQtJ9b2NmvZ3z4QFmJ5ji9fIx
	rD2joIE85wTs2xhw0gxZqtRrVjKV+024FO0Pd3jAw2k+DxnILhp0mK0+EUrcShbceulCkva3bqP
	7BhnK4UX9EmRQY8U6F/tLxo2SaDKcGpufYc4G6CHl6f+9hcjGHoaYub6nOlSBhScRoZ/eslQ9K+
	Cl/xGTvb+YB1zI4kfR52fxjpglFG+sRAwoX6yQ5ekQdHwvvmQULRj1OKyv6hd8pt4HcC+v36HPy
	IFOTryz3ND1udFZjxx1+qW5Ol45Asx+iWhEH+7vUMCqX+DhHJSB+BsZdf/UepTK5HiQLfhCakJj
	glXgRaZwNsGn0IQrIdY/j2C+DYHcQx07vLl93bM5K7YvOhuoelJ1TEWsbJRdP
X-Google-Smtp-Source: AGHT+IFQ2PJAV2V/f/yufGQdBh2mTA4a80qGAW4aT6F0XegW/TNsy0SedHzzQNPnq9UvVkxWMsAwzg==
X-Received: by 2002:a05:6000:4202:b0:42b:2a41:f1a with SMTP id ffacd0b85a97d-42cc1cc2a7amr2525379f8f.26.1763733175918;
        Fri, 21 Nov 2025 05:52:55 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34fe8sm11228058f8f.15.2025.11.21.05.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 05:52:55 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 21 Nov 2025 14:52:53 +0100
To: bot+bpf-ci@kernel.org
Cc: rostedt@kernel.org, revest@google.com, mark.rutland@arm.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, menglong8.dong@gmail.com,
	song@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv3 bpf-next 4/8] ftrace: Add update_ftrace_direct_del
 function
Message-ID: <aSButfibgD140NXI@krava>
References: <20251120212402.466524-5-jolsa@kernel.org>
 <35e436ca1a638c9e30456c2a3645c23a20b2483160e3bb34b7c73fe42776f4df@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35e436ca1a638c9e30456c2a3645c23a20b2483160e3bb34b7c73fe42776f4df@mail.kernel.org>

On Thu, Nov 20, 2025 at 10:23:46PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 9cf4cd56d..c571deeff 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -551,6 +551,7 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
> >  int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
> >
> >  int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash);
> > +int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash);
> >
> >  void ftrace_stub_direct_tramp(void);
> >
> > @@ -583,6 +584,11 @@ static inline int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace
> >  	return -ENODEV;
> >  }
> >
> > +static inline int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
> > +{
> > +	return -ENODEV;
> > +}
> > +
> 
> [ ... ]
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 850ff55ff..cc730a8fd 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> 
> [ ... ]
> 
> > +/**
> > + * hash_sub - substracts @b from @a and returns the result
> > + * @a: struct ftrace_hash object
> > + * @b: struct ftrace_hash object
> > + *
> > + * Returns struct ftrace_hash object on success, NULL on error.
> > + */
> > +static struct ftrace_hash *hash_sub(struct ftrace_hash *a, struct ftrace_hash *b)
> > +{
> > +	struct ftrace_func_entry *entry, *del;
> > +	struct ftrace_hash *sub;
> > +	int size, i;
> > +
> > +	sub = alloc_and_copy_ftrace_hash(a->size_bits, a);
>                                            ^^^^^^^^^^^^
> 
> Can hash_sub() handle a NULL hash pointer in parameter a?  I notice the
> parallel function hash_add() safely handles NULL via hash_count() and
> alloc_and_copy_ftrace_hash() which checks ftrace_hash_empty().
> 
> However, hash_sub() directly dereferences a->size_bits before passing a
> to alloc_and_copy_ftrace_hash().  This will crash if a is NULL.
> 
> This matters because update_ftrace_direct_del() calls hash_sub() with
> old_filter_hash which can be NULL:
> 
>     old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
>     ...
>     new_filter_hash = hash_sub(old_filter_hash, hash);
> 
> The existing update_ftrace_direct_add() has the same defensive check and
> passes the potentially-NULL old_filter_hash to hash_add(), which handles
> it correctly.

so we never call update_ftrace_direct_del without having
update_ftrace_direct_add called, which ensures the existence of filter_hash,
but it's probably good idea to do explicit check for future

thanks,
jirka


> 
> > +	if (!sub)
> > +		goto error;
> > +
> > +	size = 1 << b->size_bits;
> > +	for (i = 0; i < size; i++) {
> > +		hlist_for_each_entry(entry, &b->buckets[i], hlist) {
> > +			del = __ftrace_lookup_ip(sub, entry->ip);
> > +			if (WARN_ON_ONCE(!del))
> > +				goto error;
> > +			remove_hash_entry(sub, del);
> > +			kfree(del);
> > +		}
> > +	}
> > +	return sub;
> > +
> > + error:
> > +	free_ftrace_hash(sub);
> > +	return NULL;
> > +}
> > +
> > +int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
> > +{
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19552032346


