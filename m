Return-Path: <bpf+bounces-20751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953518429C1
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 17:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4225328A148
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2E71272A3;
	Tue, 30 Jan 2024 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MAb1gS3P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1431272C4
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632926; cv=none; b=Y5IY9oWVKhPypy1vtzbeZ3seDf1KgztiAY0lFPuWMS777/DPSYZIj5odlE8+hCQTA93hLzA9GcvaDW9RiDokwMK8nysCc9lD8xjPKykcZ8vYFI3StM//rC247rLVRvwXLWcVUOtpOwzMXe1+7ik+7P+k9pzciDfw2eN3U3ryToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632926; c=relaxed/simple;
	bh=ZfUJt9C8H5C83pT9jKzgglhSVGvwexNcLzoX52cT5vo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tch6dcFdNdEvMFKGBGVIbMeMwhS8DNr+QrFumzU8rhGBeWnJ0efO0pzdELpmRjVG0Ut5THDjBO+s94rIcEb0IpEJiVaOjwzAyMaMVLEX5j4euD8DVIEbULO5BBTpMyGZKAngIGZZOdl0IVSgNLtXqMlSN9geVfzN37BZ2Dk/2iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=MAb1gS3P; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ddc0c02593so1962229b3a.3
        for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 08:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706632924; x=1707237724; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wwt+nkrzFpFAGBz7peNidpEu0qQyu3Q0/t5OxDhzD84=;
        b=MAb1gS3PS+TErgURATQMxYhv/vvMh86TKKM5n3sjXjVKGR/sVH2mLERubT+xfAaKZs
         gtXFscUECmWbyDHMZF5wSaeYEAY7u8GnjdYuPxrcMZpV4bmEcrmA+ZkyQu2yco7fSfig
         e0pYyt1345YeFXaYGRHhp4LXbz+xX+tnJU69jvPQHtUZllPNJS8jXmgPlRzUBvNh/iAg
         SQVgCJ82k2znTppvSUTDAfRzMH2LJxe08a3MT0w5or5shG2BF8WhxVSHLvArJH8OqB0M
         wn3YxIG2LYEsVcAxQh61XEKKmIr6r4/QfmIMrNcSQJhSDU5tzXR63/Fow1h0Y5htEsFg
         DHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706632924; x=1707237724;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwt+nkrzFpFAGBz7peNidpEu0qQyu3Q0/t5OxDhzD84=;
        b=YuzBwzOanuZv67i95p6ftJQBB4o9JcjP4ZgQm0IMKr0wddZNYIbBPwxsVQDVoySGBL
         Pp+2hEel1Jdyu7R4tjfhLN1AydVOnseBzlaWtfK0aRdan3rHGx1ghcZZyD5yrHtk3Vop
         qHDiN8rTcsqKnS4OIZx+V9OufXA6GjwFUoVIMNPXdOpJcnnhs5YX6JgiqYlpZtqJC0c2
         WkcWe1L58ohtMZYdWJw423Xzs2yCrveQHoXJ+QJz+fUP2i8ltrNVE4tZB4ngH355pB5E
         2KIoaA4NrMYe+fj/reUNVlCth5o/Co6qd+WO3sFWxAA7gqLV6+xTUngvDa/okVXey7Yu
         mrOw==
X-Gm-Message-State: AOJu0Yx3E177L5KmcJvkeSMuWmFQ451e6jPLPvHK95zC1defj9ShsTlN
	+LTSRJHQG8Y7B9VcukPi0OPnTsiNU4ZaDXVnzQ1pxFEdlfd1Dl+K
X-Google-Smtp-Source: AGHT+IE3Crn5PmjvTb/24FRQF6Gbs+psxnsp0T1FsTWwr9v0VkJ2bl6JAEiTGYDVTaJHqS/aGL0JhQ==
X-Received: by 2002:a05:6a21:3385:b0:19c:92ef:4d66 with SMTP id yy5-20020a056a21338500b0019c92ef4d66mr5467496pzb.1.1706632924296;
        Tue, 30 Jan 2024 08:42:04 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id h21-20020a056a00219500b006dd8985e7c6sm7981535pfi.1.2024.01.30.08.42.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2024 08:42:03 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>,
	"'Dave Thaler'" <dthaler1968@googlemail.com>
Cc: "'Jose E. Marchesi'" <jose.marchesi@oracle.com>,
	"'Yonghong Song'" <yonghong.song@linux.dev>,
	<bpf@ietf.org>,
	"'bpf'" <bpf@vger.kernel.org>
References: <006601da5151$a22b2bb0$e6818310$@gmail.com> <877cjutxe9.fsf@oracle.com> <8734uitx3m.fsf@oracle.com> <01e601da51b7$92c4ffa0$b84efee0$@gmail.com> <CAADnVQK8JegsSxgbQbO=DR71cRgkvN-y9LH_ZQYxmj1a-hCz5g@mail.gmail.com> <071b01da5394$260dba30$72292e90$@gmail.com> <CAADnVQJ7Phg_89MCVNtjh1EJTxEk5S++rFhpcnukMvn6sL351A@mail.gmail.com>
In-Reply-To: <CAADnVQJ7Phg_89MCVNtjh1EJTxEk5S++rFhpcnukMvn6sL351A@mail.gmail.com>
Subject: RE: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
Date: Tue, 30 Jan 2024 08:42:02 -0800
Message-ID: <073101da539b$40dd6b60$c2984220$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQI/mTVZUZpeNhzShIl9oGl01BkM9QGkD3DnAsdGbroCN+NFGgGJMAgqAYfmIS8CWWZiQq/HlkoA

[...]
> > > Same with MSH. BPF_LDX | BPF_MSH | BPF_B is the only insn ever =
existed.
> > > It's a legacy insn. Just like abs/ind.
> >
> > Should it be listed in the legacy conformance group then?
> >
> > Currently it's not mentioned in instruction-set.rst at all, so the
> > opcode is available to use by any new instruction.  If we do list it
> > in instruction-set.rst then, like abs/ind, it will be avoided by =
anyone proposing
> new instructions.
>=20
> Yeah. The standard needs to mention it as legacy insn.
> It's such a weird ultra specialized insn introduced for one specific =
purpose
> parsing IP header. tcpdump only. Effectively.

Thanks for the quick answer on this one.  Will do.

Dave


