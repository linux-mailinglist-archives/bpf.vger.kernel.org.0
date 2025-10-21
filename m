Return-Path: <bpf+bounces-71592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03700BF7BEA
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 18:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B1875058F3
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 16:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB5D1C8606;
	Tue, 21 Oct 2025 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dafZPmg4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA4A2FD667
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064805; cv=none; b=CjzQxqe1QJ/HFg33b9tgbZNsv1NPQx+liDVwVj/DW1/JBfwODwn6ilnwOEGQsZYrFXA6oxpcEMKa/Jl4D+kl2UpOUyYivKWHSG4mGCK+386vPO8+ktjGqqYQJ0DSS37gIWeHI2voEWbpjISa65qYaurXHs4PzuEAxJWHTn5u2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064805; c=relaxed/simple;
	bh=+rPT4cVW1QRHRBum+PnBJS9lY1Sx1LVxWZctxjuri4U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eiqYWfc9SsYLmjDo/D60MyaOqLxRd4tsHtAbqu7gox3Zny8k0xDKA8QQHjDyyAHQnBTW8vUnu3o5sogL9cbLP0ljWseqIYdAfFNb0RHo3OtnwtRZRy5zB5quBWdWnMZkDaWnfpUXcl9Acr/IV0jjn12C7ZBcB1wquc3chPjrfRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dafZPmg4; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so3795584a12.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 09:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761064803; x=1761669603; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bCLu9+dIkRoNKMSpyvxSZg4qr5TX62il7v5zsULCta0=;
        b=dafZPmg4qedybgl90Ftt+IAJ1vbbQAz5gti6kBJALI23pVxUv9AdVfFHBFNBGRucTn
         viGjJ+whB/gtmAxsatYxokueT4+naPi5y97BQifuM1CMXGUomEaIorrEqdqerG2DiY2g
         nQfJcpP8D1wRNpOSYfoh7YtdsPfsNQ63RlJQg4zU6cjtlOi+f45698d+EEiaSyk2qlfW
         WiDfBuE7uRy/5r6EVBC27+3sOFgP7cO/W9jXmyglmwPVFvVDubosyB5lyVGfT8rtNU2z
         n2PHC3nBTS6l/nZ+MqUPzm3w+ZAbOR2UrJuwb3W9Py7sZ/R8weikrQRaXyaO4giTyxCG
         d1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761064803; x=1761669603;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bCLu9+dIkRoNKMSpyvxSZg4qr5TX62il7v5zsULCta0=;
        b=U/HzByOwHNT/495LyCjCqgwiOTf19ljy1GJmg0ADPrg0AtIl7UjIHQnOnvTtI6Df5S
         mp9fS2oUFj/7b7judAKodC0cXEB3nhpo0Wh2VsDQndNzbIzp4hCajCfpFqnebFQq4pja
         2Nkwy7juxtGZSsxcOXCEY+/MeKdE1Yx04hBPFBxC8vdn/Pz+IWX5UAOMQCeZzRQK/pe2
         dR+rrfgSjYbnu07xkVoSb7ersIZZTmKgyGJEZytEJ9CB7kUTZZYX8Hia1YOnOxZUk0wq
         OIL1B0si6nsRcG3F48ryMe2s9pgc2CwPEtO0/jrbQTi09P/shRlI7sgQtzUComTcx1+Z
         gUEw==
X-Forwarded-Encrypted: i=1; AJvYcCVbtx9sDYANfucSRtY2XKJbnGWL4xXyzxZd2XKiiI9WQ0lgk8riNgod5wV9VDaJ0PqIHFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+tKC7ldnWS0bXBa8LyjHAuHMcK2AtczlU+ZfZl6BbHcA8pPCe
	3wLVXMFFXAJSCRFDWcCsn/imkGf3y1Baa81otQwtA2XnUTO0QEM/KF+q
X-Gm-Gg: ASbGnculSpvTjt2FVg1eplZI+dfGCv5c3YAGElQQLskFl3MwBERQB97WdXO5aQujCYF
	uklvkf5eHqz3TvlCRVpliokmQYyYewvPEnYqIc1N7iDz05m2HW5UG5kScVXvCxm6cHS8MQY9IGO
	Q6UotH9kErbHK8Y8LQh6gGSfzy4h8tF96SB0pxAKWBChpsvp8lRbe/VQBTTAMqwkh+JL3d+OXGr
	OIeMrB7uUh9unln0Vka3aBtZ+0aFfhWTgOFLyOGll6XNCg3wKwsRslMnBfqvIbCX0itPGuZpVq0
	nqbi1xzD2y/KJaVLNuVbIOef13ahvqWb4f0fc4vXjlHY1dAG0c9jobwORZXUr/+ro1FewWWNM6z
	xZytWxF33A5Jb3kKK3UKmTb44dA6hrX/sgcETUVj+5nO3vp8zYcqNxGyZOSmmALSvhNwUYQ5Z+O
	MLH83J1846AdGItoCKvXzZkJ0h/Q==
X-Google-Smtp-Source: AGHT+IHEi2iX3CmFWyx3IwV1SRaNqnzqQxuzSD8GynPK4j/vnqSUQ6/or7Gq6qotdXYffYr5mptXig==
X-Received: by 2002:a17:902:f647:b0:24b:11c8:2d05 with SMTP id d9443c01a7336-290cb65c5b1mr191305955ad.45.1761064802706;
        Tue, 21 Oct 2025 09:40:02 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5f45:f3d3:dde4:d0ab? ([2620:10d:c090:500::6:82c0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b59d0csm10543711a12.30.2025.10.21.09.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:40:02 -0700 (PDT)
Message-ID: <9d682b66318060267e6ca6e90c0aa985e9e0f853.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 10/10] selftests/bpf: add file dynptr tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 21 Oct 2025 09:40:00 -0700
In-Reply-To: <b682bacf-8b61-42b2-9f4c-d617f9f56d17@gmail.com>
References: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
	 <20251020222538.932915-11-mykyta.yatsenko5@gmail.com>
	 <006a3fe8ca7072ac35e083ee070408d9a12eadfc.camel@gmail.com>
	 <b682bacf-8b61-42b2-9f4c-d617f9f56d17@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 14:55 +0100, Mykyta Yatsenko wrote:

[...]

> > > +struct {
> > > +	__uint(type, BPF_MAP_TYPE_RINGBUF);
> > > +	__uint(max_entries, 10000000);
> > > +} ringbuf SEC(".maps");
>
> > The test case lgtm, but a question: will it be possible to use an
> > array map instead of a ringbuf?  Just to avoid the need to allocate
> > and discard the pointer.
>
> How do I use array map here? Should I set a map value to be a buffer of
> needed length (256KB) or use 1 byte value and 256K elements in the map?
> Honestly, both options seem a little awkward to me, but I'm not sure=20
> maybe it is an
> expected way to get a big buffer.

I think you can declare a top level char array of needed length and
libbpf will create an array map with a single element of that size.
E.g. see arrays `arr` and `small_arr` in progs/iters.c.
If, instead, you declare an array with 1-byte elements, verifier will
reject access past offset 0 for each lookup result.

> I like allocation/discard, as it guarantees that this temporary buffer=
=20
> is local to the
> current func execution and we need to run non-trivial deinitialization=
=20
> anyway.

If the goal is to memset the buffer to zero, I don't think that
ringbuf guarantees that newly allocated or discarded buffer are reset.

[...]

