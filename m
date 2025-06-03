Return-Path: <bpf+bounces-59516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40540ACCB0A
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 18:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC63B3A874A
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 16:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA66723E338;
	Tue,  3 Jun 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WucwF30l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E971231833;
	Tue,  3 Jun 2025 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748967150; cv=none; b=m2NBRjlloPLjFCWSqEUDMPRG5w61h8uzhrtHXLUX82Z8H8L9YJWnOQ+yZRi6IAVsDW3E+g45BsiE8nB7bYiG0V2ZQMrTsoGiCldiAFlujSOP2CSawHPRCAolhScnkqj2OFKY8jMzIDvVqBsVGWQpOrle3JDYmE3aD00HERRpysE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748967150; c=relaxed/simple;
	bh=ShjHAUQPeBP4/WMOm5I7X7G6jt1PtVLiEdxsJRmu7bs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQNhHcE1uju7MDpbA8ID1enMi1SiFzvl5vgEmj7G0nTqgeJaaNQCz2TfUzRUfb2Kuqzu+qtoDoEWjQAqCpaorGnCGpbhmOFNbyx6buW8g8uXGIj68TY+YL3FzbAO9Xk2ZJndNMRBXsomUjHoxu7XPYScLGRBcZSok8jLJJ+Zf50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WucwF30l; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so122505e9.1;
        Tue, 03 Jun 2025 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748967147; x=1749571947; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uyQHmp3e+dW7x8h9m6zLVBuIFgaw/awy6rHkm7iIyWU=;
        b=WucwF30lgCf/12I7DIcmLJcsEigeYzWJIPyGi8kuuI47Q6HnHToQbiZv9KHIXt1jCg
         0LRHufREmdzBTa8dyW+SKO/23w2pg+H9ecc9cK5eKpz/dIwWApV+qqmKW1qxiqELaxZm
         p1Puv822AviAzGHFZFPRJX1dhjPPNOez7unIsG2xRApLJ+L9f/X8GeKU/WH8nYeBnSxQ
         WtNP0iNqXxFQ2HdaiImPHOqNDRcLv2TUI9Av42ev1uc5OKqJ0PeC1QpilvJ4DvUj/mQi
         l5TH9Wh1JWaLoCghbiiOZr22PnAI69UkihpBzNxHCCGg5gPEAPiAbBrdlOoYLV6SmKJj
         nKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748967147; x=1749571947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uyQHmp3e+dW7x8h9m6zLVBuIFgaw/awy6rHkm7iIyWU=;
        b=HT0MEj/g3mdvQa/78pqZf2mMbtJzTtubwGBPvsz6AE7dg+JTcaL0+RCTmEIn0XMavj
         3dF5M79kELK8Cb9sULO70wj7QuWTVt9M6bgWmXYq6l0yCn9regIP+78axJsoh/vCWw/t
         Yp5RYIhWy5EmTpJaJCfAxOZ+67T5jwdHSOUeZ9+0G6V2XDy5UGsrTAHQDQjhBE+X4tmU
         F5fRgFYUuQrVaRycFk4Zrq6dKR3mMNTWYOmQ/he8y5WFIRI7ecXPBP8Fd36SI5LDPbGs
         2SH9V/fYz2QgzLUOAm6N7MUSSk3ZxaQSX9MRonmY1ARVV3L/wgwXvXrJIasjvdKcakDD
         eCmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNQSMbr0VVRsDh4UjdssR9hRYCkwAvoLKtU+UyAb3Fe3Y7uGUIYHSEQ8XD6r+VnOoKJ+GOiTrdq2bNDB6V@vger.kernel.org, AJvYcCXEPFUDsSwCzQL1IRIlVxjK++M5Nqa6d+QHx6i48OByuXh0XHp6zpZO3BVrlCF3phhVyGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjrs+TIHCScHXBxEy4FZ5bSgql/vqHk8vIXZtqNPQH084wGux+
	KbbWHZj9/c1XeHifbuDpTYzdToFwHXFvxW4dyX+//iQ9JmvtJDpsXUoB
X-Gm-Gg: ASbGncsEvwvAFtajDzJf53p7lDcjK6KEnLGrpjRX924xQcA71yQa+rs4T0kgZinNpmd
	EFE3IFAui1pqaRknTdrDtFy3LfrII6sD1sKHiwvGzb6ErC37kHKnmNqZfdj7byN4KfVCA9bAL9I
	1Pcn50CL5SyuZzvt9OGoGTujaf3w21t1P8mPn+LvT640rhWfQrxjSAw4dtyoyju5qihenTfgBTx
	+qhnVFKYsUMB92PhPywAQYVaIL+hZ93nVrjDbfD3Z022OCf12UjZbTh4/YuZMkwGO60UtM+Jq2f
	DlnfMfG6SLhKTlIvWlVxJKq5F0FeDkp1z5PO/cTorkH2CxRM4w==
X-Google-Smtp-Source: AGHT+IHIKsSvSfa1+ZbUDNCYKlsyDC3jcKsp3idlMiqBnS+Tnv1Cp4R3C7DPDnAvmyuSnvhG2XJnXA==
X-Received: by 2002:a05:600c:21c6:b0:450:c9e3:91fe with SMTP id 5b1f17b1804b1-451e6145d37mr25093085e9.0.1748967146524;
        Tue, 03 Jun 2025 09:12:26 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00972d9sm19279289f8f.64.2025.06.03.09.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 09:12:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 3 Jun 2025 18:12:24 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: Yonghong Song <yonghong.song@linux.dev>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, qmo@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add cookie to raw_tp bpf_link_info
Message-ID: <aD8e6BU1qMeQFay0@krava>
References: <20250603022610.3005963-1-chen.dylane@linux.dev>
 <48e85d82-e5c7-463a-aef3-f1ecbe863524@linux.dev>
 <029e657a-cbf5-4db1-9ddb-5fbf75ea8f4e@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <029e657a-cbf5-4db1-9ddb-5fbf75ea8f4e@linux.dev>

On Tue, Jun 03, 2025 at 11:07:03PM +0800, Tao Chen wrote:
> 在 2025/6/3 22:52, Yonghong Song 写道:
> > 
> > 
> > On 6/2/25 7:26 PM, Tao Chen wrote:
> > > After commit 68ca5d4eebb8 ("bpf: support BPF cookie in raw tracepoint
> > > (raw_tp, tp_btf) programs"), we can show the cookie in bpf_link_info
> > > like kprobe etc.
> > > 
> > > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > > ---
> > >   include/uapi/linux/bpf.h       | 2 ++
> > >   kernel/bpf/syscall.c           | 1 +
> > >   tools/include/uapi/linux/bpf.h | 2 ++
> > >   3 files changed, 5 insertions(+)
> > > 
> > > Change list:
> > > - v1 -> v2:
> > >      - fill the hole in bpf_link_info.(Jiri)
> > > - v1:
> > >      https://lore.kernel.org/bpf/20250529165759.2536245-1-
> > > chen.dylane@linux.dev
> > > 
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 07ee73cdf9..f3e2aae302 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -6644,6 +6644,8 @@ struct bpf_link_info {
> > >           struct {
> > >               __aligned_u64 tp_name; /* in/out: tp_name buffer ptr */
> > >               __u32 tp_name_len;     /* in/out: tp_name buffer len */
> > > +            __u32 reserved; /* just fill the hole */
> > 
> > See various examples in uapi/linux/bpf.h, '__u32 :32;' is the preferred
> > apporach to fill the hole.
> 
> Well, it looks better, will change it in v3, thanks.

ugh, sry.. forgot about this one

jirka

> 
> > 
> > > +            __u64 cookie;
> > >           } raw_tracepoint;
> > >           struct {
> > >               __u32 attach_type;
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index 9794446bc8..1c3dbe44ac 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -3687,6 +3687,7 @@ static int
> > > bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
> > >           return -EINVAL;
> > >       info->raw_tracepoint.tp_name_len = tp_len + 1;
> > > +    info->raw_tracepoint.cookie = raw_tp_link->cookie;
> > >       if (!ubuf)
> > >           return 0;
> > > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/
> > > linux/bpf.h
> > > index 07ee73cdf9..f3e2aae302 100644
> > > --- a/tools/include/uapi/linux/bpf.h
> > > +++ b/tools/include/uapi/linux/bpf.h
> > > @@ -6644,6 +6644,8 @@ struct bpf_link_info {
> > >           struct {
> > >               __aligned_u64 tp_name; /* in/out: tp_name buffer ptr */
> > >               __u32 tp_name_len;     /* in/out: tp_name buffer len */
> > > +            __u32 reserved; /* just fill the hole */
> > > +            __u64 cookie;
> > >           } raw_tracepoint;
> > >           struct {
> > >               __u32 attach_type;
> > 
> 
> 
> -- 
> Best Regards
> Tao Chen

