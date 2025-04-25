Return-Path: <bpf+bounces-56725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77062A9D2FE
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 22:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C8146621D
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 20:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50580221DB5;
	Fri, 25 Apr 2025 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfe7sE0f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867E71DDE9;
	Fri, 25 Apr 2025 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745613029; cv=none; b=KoyikSLnY6kz9IbSkz/yZ8NFgZ/zXh/LhU47aRtPxCL0vgF/fqtICPAf/1G/tOuG2wSpK1b+5OPz+DhOP8/u6Zr1H+bPue5XDywqB/0VrSj4yPbMPD/1+4ex4q1wBRfBlnKjJJ3ZDVtttQBVrD0e2ksoeTJ8U60kviOAI39Zb2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745613029; c=relaxed/simple;
	bh=Cgq8+pmUyzR+EHhTAJNbLO8Aqjkkf9nn6Y9It4EZ+SY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tpPCqeYYljt2buXvNcEbaPce4k5dTIhelB7gTJgaghMNjLH6lzboysN7wrEL8diuXSRyaL5f3T3aXgrIvIJnANkJq/xqjpz9O+bDo52Q08jNK5FZhVddEzADV5UkpDjQEDqNQf6eaykCB22Plgpa+UlVvy7XVcH6lBC6smhirEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfe7sE0f; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ae727e87c26so1811360a12.0;
        Fri, 25 Apr 2025 13:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745613028; x=1746217828; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bhBfUD3sWImIawi4Ciq4vzBsamIJLFJadyszlqxZxdM=;
        b=hfe7sE0fQm7pT07RvePvjhzXAqmtOn+EUT+2o+t0m0b37mXbbnI3i/N4+9f3lt5fwP
         qjv0E9HU/Q65EazvL7qNgq8DoydHxvUn5Xyif92NQ36zsaGVCH3t8wcp2p22JEGHJ7o6
         rhFBtk2Pi+uHMdY1MnRLodSjVnUkK2BLJgsQ2kFI0zBYi6xnf449kL8ml4iCn4dHG0MG
         GOlo1cHucZVaH19SkVYeK15E0LfuRf66vS3ZjRhpmB/RF3pEIpG+XUT99SsBeCS+cnE8
         vOyBoI13QV31mvqonq2mZUh6JOG5YvPigaRtGRC5UGGdInCXmGWj6B0UNab2PJvhhzOY
         58WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745613028; x=1746217828;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhBfUD3sWImIawi4Ciq4vzBsamIJLFJadyszlqxZxdM=;
        b=R6S73GMzwfXJJ0FXKUOncp3DLlKJ6xVXCUCx0W60HuAgrQUQNVl0+CwZh05158YW1Z
         Y9eFijawuXv+euB8BJOA4DjSRrA6sjaAWA8OtdL8z/OTnrU6irFTmdC9BWU9EjNlA7KD
         Q4O+JWbzsL02vVcBL+nSCKKMoQHv3zY3egA95Uy+kTFuDp2CGj/HEQUdRM7OiO6WeXnR
         UdXY/myzzZKIWeFQ7+dqRXxTWtFcaLsRbLzzBWXnvz1dHNj+Zbdxl+g8UhSYQ6RGuMjy
         flX7ryJoAIHxQpWAm8WzhEhjpE6LF8WK4dm5OJfRzrLbXrzElr9ZhRCxKA6an/gFZJBf
         Tkbw==
X-Forwarded-Encrypted: i=1; AJvYcCU7HtEmHB10WOXXUVfX5Fz6b1uByelwGO8qrXKS1e68ubU3xiWwGYIEswio9hgt9MH5Nng=@vger.kernel.org, AJvYcCWhphwXomGdmw+QwMHiMkBSph3U11rffq5hT+RuH56m+nksxRdbObmHwQLzvESSJHePqYpJwQ9VpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ASvTn/HCXBtsMlcHZyQfBPjEMbsQY/Dqw/cN1lwobix4RDHr
	XtlHaIy/QQprjXhz20/Au1K1gTHzc1KC49E/BGduvawvxJiVy8Zu
X-Gm-Gg: ASbGncsuGYY3mAjUk/e9Lnk0mfQQQR9X9RtfaR6Ly3GDlYyPOZ41pWgTRbUGhLdqf4e
	pUXpPmmtQxudsvIRQtSuWFdDnpPprfucZNA9CSxwzo2go4zd2Uqc0dnVzATqeZ/aRsaBWkAExlM
	nGWcOThhWZGHnPJxxCDbavB4Bx3lZo/s9IOQakheDkZiO3hA5S7qR26Uem3UcO0zrxny6HhILix
	v2wFUAjSjKqNHTXKQ2JQwg1CdzaoMQaomZKUeriUOd7GEeQlvefbgaY7fEJ4VJeb2HtPDQR9nQg
	yUh56mzgHO/MwbCT4yKWN15AJZ44wR2Mwl43gL54CELGYUcujA==
X-Google-Smtp-Source: AGHT+IGGObygnBsr/YJDowxOHeHndQX99qG8U4qsMAAs/QQBvUmQDbngNWbv6I83LaQNF8MOpz3wGw==
X-Received: by 2002:a17:90b:1807:b0:2ff:6ac2:c5a6 with SMTP id 98e67ed59e1d1-309f8e0b4f7mr4224782a91.31.1745613027627;
        Fri, 25 Apr 2025 13:30:27 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::5:5728])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef124cf4sm3976563a91.37.2025.04.25.13.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 13:30:27 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,  Arnaldo Carvalho de Melo
 <acme@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,  Ihor Solodrai
 <ihor.solodrai@linux.dev>,  bpf <bpf@vger.kernel.org>,
  dwarves@vger.kernel.org,  Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: pahole and gcc-14 issues
In-Reply-To: <m2r01gf0pn.fsf@gmail.com> (Eduard Zingerman's message of "Fri,
	25 Apr 2025 13:25:08 -0700")
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
	<m2v7qsglbx.fsf@gmail.com> <m2h62cgh7y.fsf@gmail.com>
	<CAADnVQJQuAkmE_D_ATp-hZeTtUK4Tn=BOOOx+wPtUB1QpzeQuA@mail.gmail.com>
	<m2r01gf0pn.fsf@gmail.com>
Date: Fri, 25 Apr 2025 13:30:25 -0700
Message-ID: <m2ldrof0gu.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

[...]

>> Once I disabled it and did
>> bpftool btf dump file ./bpf_testmod.ko --base-btf .../vmlinux format c
>> the task_struct from vmlinux.h and from testmod.h became exactly the same.
>> So it sounds like the 3rd issue :)
>> bpftool dump of distilled btf needs work.
>
> Mystery upon mystery.
> Here is a continuation of the last one.
> This is raw BTF for .ko:
>
>   [509] STRUCT 'task_struct' size=10496 vlen=268
>           ...
>           'rt_priority' type_id=3 bits_offset=960
>           ...
>

Nah, this refers to id in the distilled base.
Sorry for the noise.

[...]

