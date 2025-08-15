Return-Path: <bpf+bounces-65783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC297B28627
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 21:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3A4B07DF5
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 19:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBD521ADA3;
	Fri, 15 Aug 2025 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDyxPErr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99073AC22
	for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285020; cv=none; b=I5WVgVwWr8OExW3UQ/UHiIHCD5y/M44zCsWEK0oGl8W/wZ4t5Out7NLKA4+loNZqi9BkrjdGIqKDyaxJ7WHLrGl2wte4WVZ1/4xY4K3K7AaKNIxJADuDntwX+6MqUrQ4ob0OLTeLZiDB0VuBNo6V9lbO6XyiB5qKmUFjPVis7+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285020; c=relaxed/simple;
	bh=ymr9RbLSJcXMqmgxvjCQRVVwLDd3gYr7JP9OKxYqfMM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SZ5ng2FUMof6yihbdCNmsEHHV1AuxjrZ2isTPE2s+Zr3uqF4eaxlq1s44iVdiwL2wC4qCjfSARmC1xAecJJ1oYqwXw8oGgnXc4qYZ9U/PsODhbKZm8C5I1fCsUcYS5t5epVN1QM0h4JwRCAYEX5biJNnuiw8b60dlvKIvk6HoiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDyxPErr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24457f5835dso25521385ad.0
        for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755285017; x=1755889817; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ymr9RbLSJcXMqmgxvjCQRVVwLDd3gYr7JP9OKxYqfMM=;
        b=IDyxPErrgXujEBnVxh2Gg0Pe3wf8A8YXj3/fxKAYjCHJEBcFKfn6JnIzVqFX9vBHOg
         E/4olveCIO0V+kzNWR3++Big398Do7DwZL8rErkMOUrToa5cIDtm3V8xtDBCuBBd4RHk
         QUqUeg6WL310S+YcXpDvkR+XxK0TBNLmAFBeflIS7BlaNtWI1xl368MfjlGfIFhm1cgC
         HVLjDrN5kYfgtRORVEjqA1lfLwDBGUz07oCUhH0HmLCJzQHxDNB1g6fy+IA2ihAOEOSM
         dHHh/qH/iRXOVDH7wyLoVElCo2sSlUVH5Fbxg+kYZebcdWsBVftwPTD3rFP0zpKEVB8j
         eLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755285017; x=1755889817;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ymr9RbLSJcXMqmgxvjCQRVVwLDd3gYr7JP9OKxYqfMM=;
        b=fO2anWGyCERBQXwzt0D6P5mJ6GG7L6JhZES3m3+qpJmf0da2OAqD3GmplsGxK7Dl14
         i0mOxAUYDqNlkznXIJF5M7MsOWWvL3uUy5fV1oBmBjsu8lNcMBH09zjNYO8HKDkzQmbC
         qKJOZSSx/uJE95jWrTddu6kPgP28OkRxEhfkpHD7CeuGee5+hpSTgCudO0UdQY9jMtJA
         fHsqYE7bWXIS966AmfO0OKrT04jkbSQBqQCQJo8X/137PkQ2EHlaDbeIPl7NaLIIm/xx
         smUbB62pwnU5y354bDSEHcxGAdQLVx5gH0jjviPdUZpr2Gc/+29NIFICAPmGUg4gnE/v
         8HQA==
X-Gm-Message-State: AOJu0YyVZWtJIRBxIlo0xqRndrtj+G/RLPLUFlaSjvNoOVf9GItiij44
	PvhQc1Hfytv7On21wKxdQjTJjc948FSqrviJ/rB5jIHgDdYEr7Y8jpCgAooaQA==
X-Gm-Gg: ASbGncujP4wvZRe0cpc7t8zeTG58I3KBezV3sMEUE/CE3FSDvMjGZf1jrQTH4Gc/Eg3
	+ZFBfWVz1LNADMolpKjWQhUED+S+nhkjuu4dji+ftoByd6QrnV3cNoU1f4XQMv8ZvZzcwceYmHK
	YZZ85LvOhhNPA0RRuGK3fKLH+6jCdYLAD4XueOBsekj+mDNtgwsb7JG4K5vxBE7i3NIh5BZxJ3n
	hkzDIvoHK/U+V3Lu8gh0UsQvIn+U7EmFfLbBteChckpH4U1voEUOdxQnAnubyIv8v6l76aKyvEK
	JZnBKLH1yI0C6P5E7snNHWsnTr0jL+xnGFSu5pwwwfJPtqiyyo9iDLoGZD9z/5W3HniaI84Ep+C
	YyvZbQtpZHbYt4ngcOPY=
X-Google-Smtp-Source: AGHT+IHcdNZlNe47oO7izaGlrdwvtaTkNQs0kpWb0prO/w1+JMZPBkSMwIjqNbXv4oGxpGZHhGKqCA==
X-Received: by 2002:a17:902:ea03:b0:240:3dbb:7603 with SMTP id d9443c01a7336-2446d713295mr48006485ad.19.1755285017041;
        Fri, 15 Aug 2025 12:10:17 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d5d7070sm1901700a12.15.2025.08.15.12.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 12:10:16 -0700 (PDT)
Message-ID: <e7cb82ac838e28620324f70907235d2b8c75262f.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: improve the general precision of
 tnum_mul
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	 <andrii@kernel.org>
Cc: bpf@vger.kernel.org
Date: Fri, 15 Aug 2025 12:10:12 -0700
In-Reply-To: <20250815140510.1287598-1-nandakumar@nandakumar.co.in>
References: <20250815140510.1287598-1-nandakumar@nandakumar.co.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-15 at 19:35 +0530, Nandakumar Edamana wrote:
> This commit addresses a challenge explained in an open question ("How
> can we incorporate correlation in unknown bits across partial
> products?") left by Harishankar et al. in their paper:
> https://arxiv.org/abs/2105.05398
>=20
> When LSB(a) is uncertain, we know for sure that it is either 0 or 1,
> from which we could find two possible partial products and take a
> union. Experiment shows that applying this technique in long
> multiplication improves the precision in a significant number of cases
> (at the cost of losing precision in a relatively lower number of
> cases).
>=20
> This commit also removes the value-mask decomposition technique
> employed by Harishankar et al., as its direct incorporation did not
> result in any improvements for the new algorithm.
>=20
> Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
> ---

Hi Nandakumar,

Could you please provide a selftest demonstrating a difference in behavior?
What technique did you employ to estimate the number of cases when
precision is improved vs worsened? If this is some kind of a program
doing randomized testing, could you please share a link to it?

Thanks,
Eduard

