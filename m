Return-Path: <bpf+bounces-75561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 183FBC88C7C
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5C33A4DC3
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 08:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2170831A800;
	Wed, 26 Nov 2025 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZDw8FJqx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820CB2DCC03
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147388; cv=none; b=HWu5NV/4832rfaS+3rEcB6eGjw4ItlJHQFS2cYMESjDQfYfgi7PxvgWVCoF5flaqmrwTmqmocAQrNHPErUO4lNZGmjJcjNPLdoe8VlJXIWxA03bmAM9Fy4c2Dt7xuSRoX8HUN8UrqAYeERfkqADe2AqrPZ/ZhOWaVmtS3HVF+Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147388; c=relaxed/simple;
	bh=wRCWcLAf8++kiSWgnxuNZdn8YfU+0EPlLi2265GmYl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Me04zYg2qwclDzbwczIMqqnHKZSFzrxirj1MTUUjZdMtOFZzU4u//D0ERLi0v61mFIP/VRxSXi39Evb5zs1LfdE/1HpmQXrkHNMlzoFIhNi4RfMz/lPLjLPq/TQgUYxhbF+N6lzXPaX3qZ5uczC2/T8UI/9UY3Qtq60uW+DPsBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZDw8FJqx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47796a837c7so42401025e9.0
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 00:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764147385; x=1764752185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BzXuIKGYzwHSs8w3bNM/80h3tW/yXJducqjbqgZEyho=;
        b=ZDw8FJqx7alvUN8ndNOxOKx2EVYe7+KCc4vGrqSURkkZQ6gR+cdEPhH4GRKDceG3eQ
         9VSiU1GwxKtlgvMVAaNiI1+Mjfkj/GDZER3WTcTTgLTKjHp3HbgVPMlRtAW0+sjEvUhW
         vT4/GHEcGK2Vw+dVmF3wzoB6fQQgT4AP1HexgrHRX4XSMowQwA7kmImVtjMtWvWZx2kt
         JYoIOfgx03nb7wsCWAg9I35SaihNada/lYbDpsK43rulaFEmq0MRu0OvA/oUXeC9OL30
         Pq5fjcJy9Gzh8odTh9K2F8ZAiEa/+39DfQQLXySAlbj+gb3oFpv1uaE/P1Dw+OBGD8BX
         nkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147385; x=1764752185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzXuIKGYzwHSs8w3bNM/80h3tW/yXJducqjbqgZEyho=;
        b=mBgN/WfmZpHKyG3egEdtpGouND21vdrOc3q04tnuojHtNClWvnZHrP/l1f6siRR9xG
         ilpYT1no8NSnYylvU3DUyu/h7A3+9S7f/vVNw+Og3Bn4qTDzV7dmUd0fevaGKiOjlOUW
         LLfzTiah28GoSWPttvp61bWh4VwaFnsl9Tv3t+3bK+HJ5ZR7mZIwJVJZN3DvekNdE7Yd
         7THGxfHYkW5ZWqfzq1p3uNClfdSQ1UVIpBtUHNntSctAw4s4szUrNE1wJm8E+bCisMe4
         G9DOaX9c66E7N++oAgaa82pEGmid0LAAlYtSWvspy9JkmUPwaezEScQSdgo4qGb8pFgk
         Q7gg==
X-Forwarded-Encrypted: i=1; AJvYcCXI9rR2yZbbGWlwK+pO0GZ0Og8U6RtaS3L28VS4PfiXpa5s3GNJifigDoNd/hl+pG4Fnzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+hq+/iBGEEVC6TMhY8xBExt4j9lVpiH17WMIUOcP5Qamrxi7g
	+WVtkXYWfo5m3nSA5ns0WpEA+BkwBz5WqAdf1tdfXP29g2xjubl/1hMhg373ExejHMw=
X-Gm-Gg: ASbGncsmUgUd6D/02gumKf9hjRpQUjoykSFAfeOcP/MLeGxYw1ZwxkCrBJ7pHxSeIke
	9us6hRikrMoAuxE6k+rxjb/3fVwapuUqTYL4xHEwZsfsaiieHsO+11wcZ7kUtEPOubNN5PdxXBA
	TKmH5Uh8nhoIAOFGKvtewLHS3jvzL+fFxPMJbgEPFPUqxQhE+eA3ghYPjPlr+uV5Dzl4Wyt1ZNE
	DruztVbhy8jGUvke+cQ3kZqmSSHi4BI+zlkan5iMe5I/h6NsyMM0X2b97dAbdqUsXRt3JlmqLs+
	Nr0lF6DLOdac2nyWQIWJLClKBppCJIhY77ZEJT9bQovjhQFDOJZzkMtdR5bLqg3FYGyWIaxcrWI
	EdfFdcKzkoDOsdmPH0smMIPECmxc2Ckm7HNgp8mO6/ZCh10xOWXil2sPqx1P2My1MV20xW2T7gm
	Sc2YQFW62GsOo1aNqdjw==
X-Google-Smtp-Source: AGHT+IEpghFITW2qTDL+dnB3k1wz/FFgM4k7/ms4P2KautIx4XRzh3igSGrOauhmgW6HPhMiIfhsxQ==
X-Received: by 2002:a05:600c:1913:b0:477:a977:b8c5 with SMTP id 5b1f17b1804b1-477c01e92f0mr210592215e9.31.1764147384682;
        Wed, 26 Nov 2025 00:56:24 -0800 (PST)
Received: from u94a ([2401:e180:8d00:1d6b:b712:4f62:bc36:6491])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b787407c0sm127766395ad.49.2025.11.26.00.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:56:24 -0800 (PST)
Date: Wed, 26 Nov 2025 16:56:14 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: dimitar.kanaliev@siteground.com
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mykolal@fb.com, martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v1 1/3] bpf: Introduce tnum_scast as a tnum native sign
 extension helper
Message-ID: <2fb2cuygiz5ljalrbpizk4njnj4dojx53c5fxy36ock5g5w3r7@7pigobi3ymw4>
References: <20251125125634.2671-2-dimitar.kanaliev@siteground.com>
 <b37af1dcde7b7efb4dfc0329ca3ea1c3f4ede7e9b8eb02a1eabd042d561f00fd@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b37af1dcde7b7efb4dfc0329ca3ea1c3f4ede7e9b8eb02a1eabd042d561f00fd@mail.kernel.org>

On Tue, Nov 25, 2025 at 01:22:13PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/tnum.h b/include/linux/tnum.h
> > index c52b862da..ed18ee114 100644
> > --- a/include/linux/tnum.h
> > +++ b/include/linux/tnum.h
> > @@ -63,6 +63,9 @@ struct tnum tnum_union(struct tnum t1, struct tnum t2);
> >  /* Return @a with all but the lowest @size bytes cleared */
> >  struct tnum tnum_cast(struct tnum a, u8 size);
> >
> > +/* Return @a sign-extended from @size bytes */
> > +struct tnum tnum_scast(struct tnum a, u8 size);
> > +
> >  /* Returns true if @a is a known constant */
> >  static inline bool tnum_is_const(struct tnum a)
> >  {
> > diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> > index f8e70e9c3..eabcec2eb 100644
> > --- a/kernel/bpf/tnum.c
> > +++ b/kernel/bpf/tnum.c
> > @@ -199,6 +199,19 @@ struct tnum tnum_cast(struct tnum a, u8 size)
> >  	return a;
> >  }
> >
> > +struct tnum tnum_scast(struct tnum a, u8 size)
> > +{
> > +	u8 s = 64 - size * 8;
> > +	u64 value, mask;
> > +
> > +	if (size >= 8)
> > +		return a;

The unsigned tnum_cast() doesn't have this check. I think we want to be
consistent here, either check size in both or none of them.

Given you next patch added the size check in coerce_reg_to_size_sx(), I
suggest we simply drop this.

> > +	value = ((s64)a.value << s) >> s;
> > +	mask = ((s64)a.mask << s) >> s;
>                                     ^^
> 
> Can this invoke undefined behavior when size is 0? When size==0,
> s becomes 64, and shifting a 64-bit value by 64 bits is undefined
> behavior according to the C standard. The guard only checks size >= 8,
> allowing size==0 to reach the shift operations.
> 
> The similar function tnum_cast() handles size==0 by producing a zero
> value (since (1ULL << 0) - 1 == 0), which is well-defined. Should
> tnum_scast() also handle size==0 explicitly, perhaps by adding
> "size == 0 ||" to the guard condition?

IIUC size should always be one of the values return from
bpf_size_to_bytes() with either BPF_W, BPF_H, or BPF_B (guaranteed by
bpf_opcode_in_insntable and check_mem_access), and thus can't be 0.

