Return-Path: <bpf+bounces-32894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D39149D2
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 14:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E1C2857B2
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 12:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EBB13BC25;
	Mon, 24 Jun 2024 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NFPPCkA2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F64D4776A
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719232127; cv=none; b=ehUQB/9AwVDjU+xYfzl11d+HkuMtp3U/HZKZLTcuZZNi41BZAvbv4f5JJuNMSZOJGD3cy9pkeuwAKvawISoD1xqy5H6hZPvzY5Vcy7syi8OlYZB60N7708wLCRi+bmtHXDBXJRms9cUijmqtdnGLYxD/lrxiEuME/mt4URH9mhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719232127; c=relaxed/simple;
	bh=eTikxpDlKuqsuF8/gBHUxpXZDeVAdLJG6oUT/AI5kiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heRj/HIFxxRlSZDX/DqOCXb1gKUdpYqp/KDYMvHZAbAm/cThSlDkruxfaIe2+mC/AEPgnys7nvobpAxsY8zUhAcLU4SzMgj0HjSN89WqFgVnCwiO0q2JCLqWRf+mXLR/pMGb5JefZMEbV4S2ewMYs3OQsSe3b03b2zib1WktFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NFPPCkA2; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec52fbb50cso21377761fa.2
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 05:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719232123; x=1719836923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1qi/gwQXMchNpMUCwZOoJjZAhLT3mRegAlS+nXYGr9M=;
        b=NFPPCkA2DwCbQtJXUp2S5KHut7O6SBdKeuSTo4omcGkn7Uu5JoF9K52fgAYfL4kPTE
         Hlh6aufve1RfGRE+N+ArQjxiMhHoA9YXM9y0iy0EndgEkQV374Jf0jDsueXc2HX81u4+
         OOOgntSfq1lvQtncYWd5SuUBvrbL6ea9RdmNTjNXn+wxMpDHZRubOeuFjBwF9Kh1Efu/
         PMonmIjHDY0k0Z071WpQp2ENe+P/oQdPQo+xELNXwiQU5Bhi3VMsZRUdtdxY7rLdsXLF
         UNTC7FxXZVS9cMRJvywATNeDcUEdTqkvQe+yQp41xkfVZ1/dc7MA0RaIoTRXE6DFsqVr
         no8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719232123; x=1719836923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qi/gwQXMchNpMUCwZOoJjZAhLT3mRegAlS+nXYGr9M=;
        b=wRTnv6MoX04xa9oUtWGSiIKgCf4J8XMRUCbXDtPEGpVPyrGa+SwQlw4Bpf6u9a+Q+W
         GZD19574TYMjT2vXwxkVHsCl+M/G09jsnXz2RSVIUT4uHweMDrX4EyWIW1dtIH8vZb8V
         Zvru5JfeEcr1NeGMLnY6TO7eYImgNARNMsFLmvdRHG1AByU7TruU1i1fAMKV/B/ec8Wf
         8TfLdEKQ/dQ4NQyLxvP6S6kETsX7Jx5YzdJeDJSBGyclqHxzYy4+Uqdx5cEfcX8qG8gH
         FsReF1+Fp0rV1tml3SCI54qxqUO1FXKQ8LLR13KYYs5XhjMPgdltBUt7yUPg0h4ZzYV7
         PteA==
X-Gm-Message-State: AOJu0YxSeewPDd2A64l3zkuBH7ZyoqjtdSu9Nzx2Iji55og2aHppyo4N
	HhtnG8FbE7aBZQ3EqP82U/VekE9lVFS+EMp0u6XafDGxXsNfq4/OlzI7F9TX99M=
X-Google-Smtp-Source: AGHT+IErJLj3ytNDR8xDnE++UFxJLoEcW1tEDgSF0jpt+gURddetEf2/oX06VdxKzvFO7uN68gLQGA==
X-Received: by 2002:a2e:9e88:0:b0:2ec:18e5:e68f with SMTP id 38308e7fff4ca-2ec5b2f040bmr24754781fa.33.1719232123461;
        Mon, 24 Jun 2024 05:28:43 -0700 (PDT)
Received: from u94a (2001-b011-fa04-1ee3-8904-fd02-5f2e-04fb.dynamic-ip6.hinet.net. [2001:b011:fa04:1ee3:8904:fd02:5f2e:4fb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716baf4bd90sm5451318a12.77.2024.06.24.05.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 05:28:43 -0700 (PDT)
Date: Mon, 24 Jun 2024 20:28:36 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 2/2] bpf: verifier: use check_sub_overflow() to
 check for subtraction overflows
Message-ID: <xirii6of3irrnrqmrlcow7whg6kzsaxjgu3dou5w57siim522w@iowo5t4fbkee>
References: <20240623070324.12634-1-shung-hsi.yu@suse.com>
 <20240623070324.12634-3-shung-hsi.yu@suse.com>
 <ZnkdJCyFlENgSDS2@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnkdJCyFlENgSDS2@krava>

On Mon, Jun 24, 2024 at 09:15:48AM GMT, Jiri Olsa wrote:
> On Sun, Jun 23, 2024 at 03:03:20PM +0800, Shung-Hsi Yu wrote:
> SNIP
> > @@ -13428,15 +13409,16 @@ static void scalar_min_max_sub(struct bpf_reg_state *dst_reg,
> >  	s64 smax_val = src_reg->smax_value;
> >  	u64 umin_val = src_reg->umin_value;
> >  	u64 umax_val = src_reg->umax_value;
> > +	s64 smin_cur, smax_cur;
> >  
> > -	if (signed_sub_overflows(dst_reg->smin_value, smax_val) ||
> > -	    signed_sub_overflows(dst_reg->smax_value, smin_val)) {
> > +	if (check_sub_overflow(dst_reg->smin_value, smax_val, &smin_cur) ||
> > +	    check_sub_overflow(dst_reg->smax_value, smin_val, &smax_cur)) {
> >  		/* Overflow possible, we know nothing */
> >  		dst_reg->smin_value = S64_MIN;
> >  		dst_reg->smax_value = S64_MAX;
> >  	} else {
> > -		dst_reg->smin_value -= smax_val;
> > -		dst_reg->smax_value -= smin_val;
> > +		dst_reg->smin_value = smin_cur;
> > +		dst_reg->smax_value = smax_cur;
> >  	}
> >  	if (dst_reg->umin_value < umax_val) {
> >  		/* Overflow possible, we know nothing */
> 
> could we use dst_reg->smin_* pointers directly as the sum pointer
> arguments in check_add_overflow ? ditto for the check_sub_overflow
> in the other change

Ah, yes. Didn't think of that.

	if (check_add_overflow(dst_reg->smin_value, smin_val, &dst_reg->smin_value) ||
	    check_add_overflow(dst_reg->smax_value, smax_val, &dst_reg->smax_value)) {
		dst_reg->smin_value = S64_MIN;
		dst_reg->smax_value = S64_MAX;
	}

Does look much cleaner, thanks. I'll go with this for v2 unless there's objection.

> ...

