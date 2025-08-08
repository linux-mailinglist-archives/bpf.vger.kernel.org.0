Return-Path: <bpf+bounces-65252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F66CB1E10A
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 05:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8715625F5C
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 03:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5068D1ACED7;
	Fri,  8 Aug 2025 03:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vl7uWE1L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E65E78F34;
	Fri,  8 Aug 2025 03:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754625279; cv=none; b=rogHWkEMIKbfHYyqyppJPd0snE5/blGi4vOXbpoVaqc07+e238O1OePy573bnfngoLU0fO26s1sF8mmHXKndVV4k2gvPWHKK9IxzM8CQGknhphDP8+jpZzgOO70T8dYc27ZvzWj2LR+CSP7wwlx3mrN+K3o0YYHJoDI8i/F3gME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754625279; c=relaxed/simple;
	bh=BEGdoNYtjzXz4ndc8PaWGrovIdg4IcM4D9ddQiCA0d8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KtaXJnGHmfu7HzViTgi6ZdrIYorj46pTaTEimDOFdkc4I3n2wj69XeDUupvOOT5Fnn2oYNxNFumN1kWpsTxuxu0Yx0FHnLNXT6AZoC3c2E3E76GxU//Q3KTNmUOyRYRjctdFd5LRt3bDmXO2LtZ8cF2CFjhfbJHWWaKHqw6KRZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vl7uWE1L; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61568fbed16so2663087a12.3;
        Thu, 07 Aug 2025 20:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754625276; x=1755230076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BEGdoNYtjzXz4ndc8PaWGrovIdg4IcM4D9ddQiCA0d8=;
        b=Vl7uWE1L/fGH+JLhwJ0956zNyxGVMH7bwTN1UVqAm2tE8MMszUTm+T54wuAFBrrR7Z
         G8kKaex4cjcepqIRKJpl9pg2bBnpGa4BnyxfzMLzTsxUaGYwdB7qTp/H5sqoHhveGMAb
         Gqo+7lJsFkrxMMBjMRSfihEOuTmdpGnCep2REX4CKuwd9naJDH1f7JXGFR2FTC3lY8o4
         zqsY2u7G9HhyZLs8SAOuFAWxDHqafJOzEI6LxnP/LB2eNF5lbvsEmFLB9J+v7PLui9qY
         Q93HJd4F+5PCv955QweBNRvHC8P2Ilda7Su4TgcFXruomVrq61j3wnJgaEC0tAWx/MkP
         KNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754625276; x=1755230076;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BEGdoNYtjzXz4ndc8PaWGrovIdg4IcM4D9ddQiCA0d8=;
        b=ZJDQfp6O7Qpv4NIjayLEM8rtPiodX9bBCUovrLqVntsKvKNt6N7xWHPWLxp6Vc5DF6
         WRqDHEK3q5+9CrXcErYmKQMQ1pjuBZpsZgRRFVFe0TXDModcxvpSXYITAfsOo+wsPyXF
         qKw637g1ozgCYmlb81VlASp9UTj64uCvGvz8t1sBroKQe9j1aLQt9HyldyKPmy6mP8VQ
         IAIT2BF9bdOE9Ypr6t3n44zLZk6AFsZ0erkl4XcMI3NCvT6+cRvNNU1GZLHHxY1j+fm7
         BM23l0zpbL9pkzIuaAY73EryWaxZsamhhJDpbwYYkyga/kdokDTDJ1ByCPcvNc+jYdB9
         aJPA==
X-Forwarded-Encrypted: i=1; AJvYcCUD796KoYKwMZ6OegaX5pBC/dypQhbpUlempIfMKVLN6l8nD/QGb3ALxBCNuP5tQv7q0/ChxCcNBQ==@vger.kernel.org, AJvYcCVUVSoDByL9Y6kobhcpJ4ZTx+vI7GO4n1/G4rgvLPnF53ZKosJ+JCo46FkPeXvXQPXyxPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya1Tb7ctozJ/XTiEkLKPrU8IXxFX1iKuvoM3kTxbo3HCRYrpUy
	ZYXGI9O3mEeo03Patc1g661Vrtg7dEYrSTL1ADpjJ+zAZCz744BaNrWafiJfbo5Objt+SA==
X-Gm-Gg: ASbGncvvIv6m6BfpG5zR+ZmazIOtryL2QLJSl4CKAcedUXW7xG3Y0x3i7sGB7gxvL/K
	UDOuwIAK3bAOFQ778buKZ+agfiVlcetTLwNSBsUE3maYNLHnzRZebjdQ5Yb6K8uQoCk9EGdhdZy
	Cr39EJNuRWdVmlWeGv50iRJ9EP7v1spC4fjP6LhSCmTEp9Wt+YiHaK23ZOGv2xGNVLC62pcTgio
	wrgGAFEplkPJhvhx3P1c3S+jc3Gy2qBvPUA41z9aoh0ve5ve6Iu9ar9wM3jQlVrmdIh6CgyQCzs
	D3FFTZDMj9OduH1muKIeroq3oe8Qr5Z5kxEzI+t9OLgrmL7j9Ut71l73AC154e9VIqqv3UBfow3
	2iToV3Q+9R1m6WlvBz6UiV+T5nqvQfNdjVgP6
X-Google-Smtp-Source: AGHT+IGSgNO3uUWuqcsUexbBiwhKAv8c2gQkvnflLoMikxkRVL2X1rT1hLRXad9dNVCfSLx8ENMSrQ==
X-Received: by 2002:a17:907:7ba2:b0:af9:3e23:831 with SMTP id a640c23a62f3a-af9c64d40a3mr110381766b.39.1754625276284;
        Thu, 07 Aug 2025 20:54:36 -0700 (PDT)
Received: from ehlo.thunderbird.net ([94.101.114.216])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e82bbsm1425084366b.81.2025.08.07.20.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 20:54:35 -0700 (PDT)
Date: Fri, 08 Aug 2025 00:54:28 -0300
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To: Sam James <sam@gentoo.org>
CC: alan.maguire@oracle.com, alexei.starovoitov@gmail.com, andrii@kernel.org,
 bpf@vger.kernel.org, dwarves@vger.kernel.org, jolsa@kernel.org,
 jose.marchesi@oracle.com, kcarcia@redhat.com, namhyung@kernel.org,
 nick.alcock@oracle.com, williams@redhat.com, yonghong.song@linux.dev,
 Guilherme Amadio <amadio@gentoo.org>
Subject: Re: [RFC 0/4] BTF archive with unmodified pahole+toolchain
User-Agent: Thunderbird for Android
In-Reply-To: <87a54azdvp.fsf@gentoo.org>
References: <87a54azdvp.fsf@gentoo.org>
Message-ID: <915A7FEB-CF07-4121-8A22-A95D0A4C0085@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 8, 2025 12:33:14 AM GMT-03:00, Sam James <sam@gentoo=2Eorg> wrot=
e:
>FWIW, as a source-based distro, we'd love to have BTF-only be quite
>cheap, because right now, having DWARF makes it challenging for us to
>enable it by default as users build on a range of different hardware and
>the increased size of the unstripped vmlinux binary plus build-time
>requirements doesn't make it worth it=2E
>
>(Not every distro is building once and shipping to many and has the
>luxury of stripping out components ;))

That is so cool, to have feedback from distros at this stage!=20

Myself, I think this is interesting as putting the stepping stones for all=
owing the selection of features that may affect build time, disk space used=
 at build time and in the resulting deliverables=2E

I think that a DWARF-less system is something desirable in some cases, so =
worth supporting=2E

With sframe, ORC, BTF and hardware alternatives, when available and usable=
, such as the various things called LBR, and Intel PT subsets, ditto for ar=
m's coresight, etc, DWARF support can in some cases be disabled, and someti=
mes this may be wanted or useful, so should be an option=2E

>Thanks for working on this=2E

Glad you find it useful,

- Arnaldo

