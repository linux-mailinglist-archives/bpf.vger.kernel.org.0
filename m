Return-Path: <bpf+bounces-21889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F4B853C61
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 21:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876D21C230D9
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 20:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC42612F1;
	Tue, 13 Feb 2024 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+3sl07f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B634612ED
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857294; cv=none; b=S1/jVc9inmqVb3bnDO860XzlQ6cvJjx1CjbSyl+Yy8ENgr/Mopj8LTEYY1LQXeazt9R+h7wVrlxoYfHHgjqXckFui/KHt3XoB2D2Fir+En76WFgdGsV97HIzuBMg2lnE4OIGgEefAwP1MbUygPFTkUTFjwb2aTEgEIUdXwkbLjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857294; c=relaxed/simple;
	bh=CyiGuNi1nWyVPqzGc9f7ELqzlOwsG7DFL8lj6NG2RZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0W7OQDLijC1DJxPXd/7oAMPQnfrWvD8ZOOPxC0vR3OsKNVHMunbRDJrLGnB5bd7ZMH2Z9xptg461CQssJHLGiuqfPh7z91O6Ebm2i8z8ThSegiaGqXCKYE639/3QwjEyWsp+9taV4ZyJUk+adoFq0RAycIn9y+BkZvYauFefLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+3sl07f; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so634210966b.1
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 12:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707857291; x=1708462091; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CyiGuNi1nWyVPqzGc9f7ELqzlOwsG7DFL8lj6NG2RZ0=;
        b=K+3sl07fz69TG3VQmwiqTYo3p8WMC9vAyzl2pXLTGeuGvHTjZpHXb0Zcd7a6vLEFRY
         e11hg+0IyVME6daz75pu5JuWs9JaWvXb8VadDNoQ9f429n+qRqkDKZrZOUt8F55zSneG
         PbLjti+KlcNtTTQnFdJQbhHB2glDmS+QzeC4OS9utfNEUag1zBZRYhAll9Gnk4bNqRcN
         9SiKaX3Z1gqQUMaVwrtpNIppHsmD+U+YaUOfsqANd+2ES4YaqdUfwfNkdKpt3by1W8Iy
         rpNR/VVJzs/3VXtp+D0LNw5MOrQjyRWQVxkmWNzhZ16BxyyraV/dNTOMI66pkwfTqnbQ
         tOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707857291; x=1708462091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyiGuNi1nWyVPqzGc9f7ELqzlOwsG7DFL8lj6NG2RZ0=;
        b=KG4vrUkuIQuQ7j4/01iFGBJBrbK48aCT/j/F9Ffu1OOV3nuaMjiXSesyPihTZ6UDyy
         hVEwzT1v6AkMoxO+W2SDudAsleDAoMTdCAQduXMK5QIJUnuk5bpK11RDpNuqHBcczJ/6
         B/AJxU7n/E04dGYSMUGgMNZrL1EjbenqpUK7zNzRpyB2dRRvkZNSt2/F/KX/Hr5H5KO5
         4i0vXWdwt6IIqIJX6dhuIQ47jLupeoXvbs1eCsLsIWNMQw7hAhQU8QGGqi8A+mM2iUAR
         CDdlLVcbmfH5HK4CapkQfgJOKPufy7GSSQGF+sb+DVuExD8YuP9weF8Lhl42mZhxaeEC
         6/Tg==
X-Gm-Message-State: AOJu0YzSeDFinLBRzy1WFuVGyzxy+8hQsUUQapa+zhYwyNjUKn8omf3d
	6KTWifNFN3vavU7E0mrwHaUKS06Jlwuyp8ooeMhyK6HVmSUtTQgIZVnNZsuLvCQ9ogfkJmJ0+q4
	d/NV12YMieOBlgBTc732q91ms4b8=
X-Google-Smtp-Source: AGHT+IGtb87E4NDs02puZveXIGZo330usi88f9r4iipmEcxpygprOHXfY2dL/RfByolEJU4ZbOMvPALrxaVP6eV43NY=
X-Received: by 2002:a17:906:5a96:b0:a3c:8bed:86d5 with SMTP id
 l22-20020a1709065a9600b00a3c8bed86d5mr321846ejq.12.1707857290616; Tue, 13 Feb
 2024 12:48:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcqEB3REkEKJahQu@google.com>
In-Reply-To: <ZcqEB3REkEKJahQu@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 13 Feb 2024 21:47:34 +0100
Message-ID: <CAP01T749SuSVG_JGtFHwVpfp066Vavfj5OcrCiWdhGmoX1Uu+A@mail.gmail.com>
Subject: Re: Generic Data Structure Iterators
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	yonghong.song@linux.dev, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 21:48, Matt Bobrowski <mattbobrowski@google.com> wrote:
>
> [...]
>
> Now having said this, I'm wondering whether anyone here has considered
> possibly solving this iterator based problem a little more
> generically? That is, by exposing a set of kfuncs that allow you to
> iterate over a list_head, hlist_head, rbtree, etc, independent of an
> underlying in-kernel type and similar to your *list_for_each*() based
> helpers that you'd typically find for each of these in-kernel generic
> data structures. If so, what were your findings when exploring this
> problem space?
>

I think I agree with Song that it might be unavoidable to introduce
separate kfuncs to iterate over separate types (due to locking/RCU
requirements, and other minor reasons in how the iterator is supposed
to be initialized).

I think you can use some C11 tricks to make this convenient when
writing programs though.

It's a bit like how iterators work in C++ (the real implementation is
behind the class methods begin, end, operator++), and a templated
function could dispatch to the right ones by monomorphization on call
with different types.

In C, you could use _Generic to dispatch to the right kfunc based on
the type of the struct on the stack.
The only downside is that you need to keep updating the macro with
each new iterator.

Here is a godbolt link demonstrating the idea of a range-for loop like
in C++, copied out and simplified from a BPF program I have which is
not public yet.
https://godbolt.org/z/TWjP636Pv

The idea that Alexei linked to (using a number iterator with high 1M
limit to iterate over in-kernel untrusted/rdonly ptr_to_btf_id) can
also be accommodated into this.

> /M
>

