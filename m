Return-Path: <bpf+bounces-23200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9303B86EB81
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 22:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C681F23A07
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 21:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482C358AD7;
	Fri,  1 Mar 2024 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PaXjJ2TC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D157319
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709330140; cv=none; b=hhfG810082qD44ejdSgt6XjLepog2miQZ0Yp3tr7UgVU75LtICxMNF0b/xi0geyRhS1vkg5Z8KRozLjtZJAlFe3+sel3KtSZsdeR50rYsvZFcT1uqdZEbXp4gmraF5wcwnmwrAwNGfo7ob+LGfvYnEpf/1WFNP66ufDfX7MfXE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709330140; c=relaxed/simple;
	bh=RFXc7Elo3atdmVadJsjAME7W+17ZHGgyGPWeJiLWaCE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=T8ghwdXCRbBUMXv11032RP9ruIzYa65C2QQ2bknXeoEs4k/QMcpg+/qwiB5OoF2FHnhiwMCnWrpVghWwR7rvbaXJCIOcdih00jJHgYmJKFKTnm+XoU2M7GzCrLo4iV+AHBNDZMxF5vvDf1QOZC4eT6RfNg9QX+NxTWM8OvgHDz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PaXjJ2TC; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso2516499a12.3
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 13:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1709330139; x=1709934939; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lmSXi4D7sPEpSkeVvMobsfBRWK3fOq6/QBi0rLCDoPY=;
        b=PaXjJ2TCfyBNIue0ErAvsRSMZDGIV7PLGGhtrYREdf4ygeeWONVol3BOyXoQM5PP91
         93RmcHmnbsU267ofF4hnz89yWL/iN2bqt20YVpX0rpInA5DEBNbGwXzE6KKO/Ipxtubv
         iYe+WBdLxVpTQlIoYiFpFRD7/DmUxIcCY49hezBqsh04Mbi3VkXJrVJRVwHccr0EGg3V
         CIZqXOk4VlWkYOfUXGi1abSXL+EDCx/j9D6RGNubyFIgPW4dNmofO9cdZ0g+DP67yjAg
         FArzP4RRsALOGfdTjerqg71lP3m0vJbJRJVGPQYR1zjltTGdozatbXSslwZVLiT3vDRT
         85GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709330139; x=1709934939;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmSXi4D7sPEpSkeVvMobsfBRWK3fOq6/QBi0rLCDoPY=;
        b=gcAypWooE/mt9gfi4bbpdG2DaQd6xAuKvy1rCRAjQDygEWKO9rasrgCQs4ADXuNGHc
         CCTLK3080ihe8q8FoFf15cEH2+1TZ+qS+ZPUBraiac/VEd3abVW0hms0uj02FAomx7nM
         N7GY7//Nt8G6cXIpfNqlSIZx4kVzNXC5cndh+LPZBlLdMgOjqEThO1UvIxoJU8/41eOM
         Yo7HqL1XeCmGgx56kj9VZYVYGtS5Mxsz9ukDeMihGRplkJYvHwQ6HjHd+plcUTXjYRMe
         gNmVMi0FBkvvues+sfB/ZcyjRzjzjEzT940QguNwh0ZTJc0ukuI536Ae0l8fpC+Tynnh
         D/UQ==
X-Gm-Message-State: AOJu0Yx4VZgptrrGpOkJydbDLdmR7+GssELldXP0W9Gn+HuPBPm7XyQ7
	nsd6yp9GvHlZs/JwmaE+gEfQwUw++W64f4bUhIq0gIxKTrDGvFbq
X-Google-Smtp-Source: AGHT+IFh5xJfNmB8rOn/crUe562ehXXzA6BVOg/iySAQp01mZAIomO+zl4Ed1JCBldmZ+KHg/UreLA==
X-Received: by 2002:a17:90a:ae05:b0:29a:b13a:2455 with SMTP id t5-20020a17090aae0500b0029ab13a2455mr2670928pjq.30.1709330138396;
        Fri, 01 Mar 2024 13:55:38 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id v20-20020a17090ac91400b0029abb8b1265sm3695578pjt.49.2024.03.01.13.55.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2024 13:55:37 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>
Cc: <bpf@vger.kernel.org>,
	<bpf@ietf.org>
References: <20240301192020.15644-1-dthaler1968@gmail.com> <20240301214929.GB192865@maniforge>
In-Reply-To: <20240301214929.GB192865@maniforge>
Subject: RE: [Bpf] [PATCH bpf-next] bpf, docs: Use IETF format for field definitions in instruction-set.rst
Date: Fri, 1 Mar 2024 13:55:34 -0800
Message-ID: <236501da6c23$30b03380$92109a80$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH/ehTCFBulKRgYvS4cKeKGZS5OpwHpwZEgsMoC04A=
Content-Language: en-us

David Vernet <void@manifault.com> wrote:
[...] 
> Very glad that we were able to do this before sending to WG last call.
Thank
> you, Dave. I left a couple of comments below but here's my AB:
> 
> Acked-by: David Vernet <void@manifault.com>
[...]
> > -``BPF_ADD | BPF_X | BPF_ALU`` means::
> > +``{ADD, X, ALU}``, where 'code'=``ADD``, 'source'=``X``, and
'class'=``ALU``,
> means::
> 
> For some reason ``ADD``, ``X`` and ``ALU`` aren't rendering correctly when
> built with sphinx. It looks like we need to do this:
[...] 
> -``{ADD, X, ALU}``, where 'code'=``ADD``, 'source'=``X``, and
'class'=``ALU``,
> means::
> +``{ADD, X, ALU}``, where 'code' = ``ADD``, 'source' = ``X``, and 'class'
=
> ``ALU``, means::

Ack.  Do you want me to submit a v2 now with that change or hold off for a
bit?
Keep in mind the deadline for submitting a draft before the meeting is
end-of-day Monday.

[...]
> > -``BPF_XOR | BPF_K | BPF_ALU64`` means::
> > +``{XOR, K, ALU64}`` means::
> 
> I do certainly personally prefer the notation that was there before, but
if this
> more closely matches IETF norms then LGTM.

The notation before assumed the values were full byte values so you could OR
them together.  When they're not full byte values (and they're not in IETF
convention), OR'ing makes no sense.

The proposed {} notation matches the C struct initialization convention as a
precedent.

Dave


