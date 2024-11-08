Return-Path: <bpf+bounces-44400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A76449C27EE
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 00:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95291C21712
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 23:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314F51C460C;
	Fri,  8 Nov 2024 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7+cF8MF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F691CF291
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731106889; cv=none; b=J63cpEyqU5MRj6pz/O5dmoEvN738FcWzy5xR9EVzBthinfyijQFhqmWx4YDLdal0K1d+lhaiMu1LFb4F6Ly6yLGhwKaAhMA1hKz+ZxrFgSpeqIG60V2u2mHRgNSSw8E3dO6UHB1h58RbF7FTcUPxAZTHQVrtfLR4fXEwM8j8ns0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731106889; c=relaxed/simple;
	bh=wgyU7rEHjpp+6aA9UV1Q1YUNV45NSLMDEgSYKjTCrOQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B4y7l9dlSUGkjVT6Pzr5qoZSz2WmdxrDrzjl9cY2vpMyEfnbBjFx/HhtExiDq8HJ6oy6AIJ02SRGvX8L5SfEnNNo0OSqS3nnvJWdYePY3rklREQTp6Iph3dVDTyEVC7QrRftRO7xSW8NRjjVVj9UGft2dYpT2ovZgktkBN9Yojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7+cF8MF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cb47387ceso30080545ad.1
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2024 15:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731106886; x=1731711686; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wgyU7rEHjpp+6aA9UV1Q1YUNV45NSLMDEgSYKjTCrOQ=;
        b=F7+cF8MFDheS1fxLtuVq6aLrI9pe5cmMffLJY42jcXKBInXGTjedWxBQyPjh5Zde18
         3wgsNZTwdhPn9In2Tk2kezVNOPu9CCCUUMROEMsD9SSTAaEm1hZk9CkQVPGAGZmM5VFy
         ttQxH/scG0BHpP77RUE4K9hr7y+tN2tVXjsINhnlpzNcBknKhZG06hUwFnyfreH9zNkf
         yxYZupGvxg8QAVmbMyh95LqiYHkHX409/Vt4IDUAjvEty8JOqRdyWt9nzGqfna0zhRQx
         gmBcDnjlMztapqfoQQfG2AekSNkPx00reGA9sRWHUP1CfSLxG/iGgY2ZfyIfRpaCGIWY
         yH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731106886; x=1731711686;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wgyU7rEHjpp+6aA9UV1Q1YUNV45NSLMDEgSYKjTCrOQ=;
        b=Wu9YlKDixhqfWTgyprRjEwQu6KPMD8iRuQdWV0e9s+2IgS6OzOXhtLHF8H+Ug83D79
         C+2w5+S1WAOmCQcCIwDlkZx6dxctPrSdHo3nfVmSM9VxnICXf7czhL8N/jnCD+Efy9Qm
         uMRruwTORAEHjasdpoWcWdwtu6n5FjDJW3zRI2m2LyWK3aeNJGq+YZrioxW29pKKz77K
         2P1xwoRUwy7cjw2ojVa2sjC9Scp9KC6DXIMt+wpcR6kIxcwD94pI4Rr31DNdQYLq5ePl
         wSGov22rEHGrsPohL2YAKgN/uXd4e0/znNdJ9iNj6vvNm3Mk+ei60OMerPdHzW3ipBi4
         DeKA==
X-Forwarded-Encrypted: i=1; AJvYcCXSivTbwFQw42pYznz6/H25ivYe3UqaEdLusGofbozY4VcmHQWJnxRM8s5CJViCg5wzaRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMCJHgWE4qaklqooMmF9A7kNKjgQdVz+eHrLit0fYhs7s/5Mgs
	JShA0f6GnvCiluH3XqMOHY4bSGuVgwE2xTHpYsAAat7CVjCBPrZw
X-Google-Smtp-Source: AGHT+IFwzYmyOYXh0VfQt/xXgVcO24ReCAi2RuukicEIwYOAJ2QsJZ4VVrm9G5pX6+jnODW7SLlwBg==
X-Received: by 2002:a17:903:24e:b0:20c:e8df:2516 with SMTP id d9443c01a7336-2118359c161mr46637055ad.42.1731106886492;
        Fri, 08 Nov 2024 15:01:26 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dde1b8sm36110325ad.60.2024.11.08.15.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 15:01:26 -0800 (PST)
Message-ID: <df225223880f0afe898d6e766da22f1c4df6b580.camel@gmail.com>
Subject: Re: [RFC bpf-next 00/11] bpf: inlinable kfuncs for BPF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>, 
	bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
 kernel-team@fb.com, yonghong.song@linux.dev, memxor@gmail.com, Jesper
 Dangaard Brouer <hawk@kernel.org>
Date: Fri, 08 Nov 2024 15:01:21 -0800
In-Reply-To: <87v7wx5uh7.fsf@toke.dk>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
	 <87v7wx5uh7.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-08 at 21:41 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:

[...]

Hi Toke,

> Back when we settled on the kfunc approach to reading metadata, we were
> discussing this overhead, obviously, and whether we should do the
> bespoke BPF assembly type inlining that we currently do for map lookups
> and that sort of thing. We were told that the "right" way to do the
> inlining is something along the lines of what you are proposing here, so
> I would very much encourage you to continue working on this!
>=20
> One complication for the XDP kfuncs is that the kfunc that the BPF
> program calls is actually a stub function in the kernel core; at
> verification time, the actual function call is replaced with one from
> the network driver (see bpf_dev_bound_resolve_kfunc()). So somehow
> supporting this (with kfuncs defined in drivers, i.e., in modules) would
> be needed for the XDP use case.

Thank you for the pointer to bpf_dev_bound_resolve_kfunc().
Looking at specialize_kfunc(), I will have to extend the interface for
selecting inlinable function body. The inlinable kfuncs already could
be defined in modules, so this should be a relatively small adjustment.

> Happy to help with benchmarking for the XDP use case when/if this can be
> supported, of course! :)
>=20
> (+Jesper, who I'm sure will be happy to help as well)

Thank you, help with benchmarking is most welcome.
Very interested in real-world benchmarks, as I'm not fully sold on
this feature, it adds significant layer of complexity to the verifier.
I'll reach to you and Jesper after adding support for inlining of XDP
metadata kfuncs.

Thanks,
Eduard


