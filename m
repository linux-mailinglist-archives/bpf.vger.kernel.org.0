Return-Path: <bpf+bounces-45840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC54C9DBC37
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 19:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720C6282019
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 18:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8D81C1F08;
	Thu, 28 Nov 2024 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd1ohPme"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B0D19EED3;
	Thu, 28 Nov 2024 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732819086; cv=none; b=pbClY0ga1erx2WH/6eLpOoe9UeGFIaCWLCFj0tzBgKH8Kaki4yyUecvhkB/0Z91SChMBIIS2JBEjF6M+WlPYIKEk3O3Z2ur8kKT0cJ6SCEqh1VsQCwBKKUTMXeaOuNuDB5RazhoUZBGAXJdaG4pFmn5kbsGFNIoBSPJm1v6128o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732819086; c=relaxed/simple;
	bh=5kHFSIgUt75t6zTwBLU8YLk/bo3MvEHaMsy1SVdn1xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlmrzPZSaQuDKExaSN4rCm4xJz+LK5pr8bJB+/43Nh++6Mbk7vlUEJO2OulBo3+KmAAvIkUK8pw5ABbEWvo13LKYTc0m+P4lAb9E/u5xqUOyhQOKttg/0ZuGW6tHH/xB1+hZmxX1EcnJ/QUGBskZFz3RtYT5nVB5JUnVFFDTuvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sd1ohPme; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ee51d9ae30so699539a12.1;
        Thu, 28 Nov 2024 10:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732819085; x=1733423885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+tE7Xp6FcgLMBVi5JpUkzbSQKbNu8pSIDauMkrQaJw=;
        b=Sd1ohPme+zP0ABo8c3I53CT/jjKR6xv+Zwaev35pDdwZBTN91mQ/Xl8hhTldcWAPBi
         vrmtvyoGfGfEX9oFXoCCAbu95fws8aQGk/n9wW79Sf4U5/6N4WGqCf9TBZvOBjwG4YVr
         mU64FBUW+z+TyWEGHWsw4nsY6vBQMMXEjwxKeBEe9tE4R0m9YAcl9OjQmjfPVsCR2VJn
         sffXCZmynX7QUrUUirFh360MeIy/vy6X0eZvYR5PBtUW8zTb1ZYOBmRJY4CXIeP9xXUQ
         Of+A+B60rSKg931vKI7dABhOPK1OyRkTF/Nsw8BtEtN20mASF1OrLBjR398IhMC+fA9A
         NEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732819085; x=1733423885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+tE7Xp6FcgLMBVi5JpUkzbSQKbNu8pSIDauMkrQaJw=;
        b=DU16x27zmydehRBwHeGrnLHM/XMARvgwOQdA5BPvcjJM/bVogEHELwpOgxOeeOzieI
         BlEVdt6HSISIBZPaRJLJgScoou5R3E3keQ/Yap0IjPtTYVE32DDoHmRDnX/QvUTwW8Ja
         W4JcaVdd1OmU+krEPlniILW3NWfTWSXhJY4xV6o/XafbqhP6Wft3W+SM6GRoA/Vc7Arr
         UzViAMPnqvLwYKZ7ynmbv3jS8e3ZBTyJ5hrM5qPCJA1cUMO5IgHxW4ND/OYPorI4xige
         v2TCCWPJ9iNR7Fn7kshSgIdaDMd8L5mUYIEHTb9ngSIY1iX+v+AoRHM1KHpMFomaL4/P
         k4tw==
X-Forwarded-Encrypted: i=1; AJvYcCUqcyh2/htv1BwyxEJylrkDGlnV5tK/HpBlBqkclOzt707zGQlkrp0cOcz2Uu1WW6wZgo4=@vger.kernel.org, AJvYcCXlBWH6c4xmeDid6bCl1QFoozR0IQqHmeY4zA89X41NCO1iUbzr04OLEU3YvSDr8d0y6Ev6sYVC@vger.kernel.org
X-Gm-Message-State: AOJu0YzwPo/7zebPFLw8XId1JGSpSD2HSdC4ggIc4Urd7YrS8fniSbh9
	I5yuOUMJoEjqh7PpnPvf45hSuA9TENMYnQlEfqos8RFSEyHjn4WtlMI2CQ==
X-Gm-Gg: ASbGncuGnB2FGODo3U6IlL/K3/eUKHZvJb+aUy/2sXN2FG3ZuFMCdqXk+IUSpBrTD5S
	zzFDOEpzLaMpm2IiqmfSa6ZIAJMdITyJZ1LB56j9yMMLVQ08XaEr6dhu3fVctlJWjBUCxTUY56I
	SkgXH0n0w4GFGlTGhMxqBvxozDSmp//aqoX6IeR9sVZwOogO1h+Ye6mZ/SmCN/9A52C92Hs49Zw
	K5EBUikT4C7VCs0FXRTGdNoKHLSQWcMOz/LyO1WlKv9RBqPyYlMXvnd
X-Google-Smtp-Source: AGHT+IHxAgsakWZpaMi/QTj+rwkOiNDU/j/x4CnaTAbnzdeHmOYAfVvEkWxmeXse+hh3jr4pfVnqxw==
X-Received: by 2002:a17:90b:4a4e:b0:2ea:752c:3c2 with SMTP id 98e67ed59e1d1-2ee08eb2f0fmr9640255a91.13.1732819084630;
        Thu, 28 Nov 2024 10:38:04 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:c1c1:c76b:dac2:9d68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee2aff1f28sm1803743a91.7.2024.11.28.10.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 10:38:04 -0800 (PST)
Date: Thu, 28 Nov 2024 10:38:03 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Zijian Zhang <zijianzhang@bytedance.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [External] [Patch bpf 2/2] selftests/bpf: Add a BPF selftest for
 bpf_skb_change_tail()
Message-ID: <Z0i4i0Db8EnRjzZJ@pop-os.localdomain>
References: <20241107034141.250815-1-xiyou.wangcong@gmail.com>
 <20241107034141.250815-2-xiyou.wangcong@gmail.com>
 <67a0fb14-f791-4499-8751-01bbbd1cafcb@bytedance.com>
 <6746cb81870d7_f422208e@john.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6746cb81870d7_f422208e@john.notmuch>

On Tue, Nov 26, 2024 at 11:34:25PM -0800, John Fastabend wrote:
> Zijian Zhang wrote:
> > 
> > LGTM!
> > 
> > I think it will be better if the test could also cover the case you
> > indicated in the first patch, where skb_transport_offset is a negative
> > value.
> > 
> > Thanks,
> > Zijian
> > 
> 
> Hi Cong,
> 
> I agree it would be great to see the skb_transport_offset is
> negative pattern. Could we add it?

Hmm? It is already negative for sockmap, as I already mentioned in patch
1/1:

"skb_transport_offset() and skb_transport_offset() can be negative when
they are called after we pull the transport header, for example, when
we use eBPF sockmap (aka at the point of ->sk_data_ready())."

My test case uses skb verdict, which is one of the sockmap hooks.

Or I guess you mean positive? In that case, we would need hook different
locations, like TC. I can certainly add it, but once again, it would
make backporting this patchset even harder.

Thanks!

