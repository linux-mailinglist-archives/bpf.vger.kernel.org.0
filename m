Return-Path: <bpf+bounces-12785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30CB7D0691
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 04:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF541C20EAF
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 02:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DEE80E;
	Fri, 20 Oct 2023 02:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="lrq2xWDI";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="lrq2xWDI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="oT8espK8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2F818
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 02:42:22 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39705131
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:42:16 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DA602C17C538
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1697769735; bh=I3GeDSR3x137NGUylfqtV6N0sAOAPCF54px90wIaaLY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=lrq2xWDI4hIryWsXIpOH6Hl+O8QR//EtawVOp7eaf5ZwWcLrLuPu3RllAt2k8HTRt
	 WifrV9MqKOYRoOnFdk6fWgv/C+VPLyaUlYQusEW7icwpbADjeB90aj51pzaHWSCqUS
	 w6q9DKrCsLq2q4WgkZkuXNN2RaRqH4WACXspdA3M=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Oct 19 19:42:15 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7D233C15153C;
	Thu, 19 Oct 2023 19:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1697769735; bh=I3GeDSR3x137NGUylfqtV6N0sAOAPCF54px90wIaaLY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=lrq2xWDI4hIryWsXIpOH6Hl+O8QR//EtawVOp7eaf5ZwWcLrLuPu3RllAt2k8HTRt
	 WifrV9MqKOYRoOnFdk6fWgv/C+VPLyaUlYQusEW7icwpbADjeB90aj51pzaHWSCqUS
	 w6q9DKrCsLq2q4WgkZkuXNN2RaRqH4WACXspdA3M=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 179AAC15153C
 for <bpf@ietfa.amsl.com>; Thu, 19 Oct 2023 19:42:14 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.906
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20230601.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LTgJNtKxoNXe for <bpf@ietfa.amsl.com>;
 Thu, 19 Oct 2023 19:42:13 -0700 (PDT)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 78D59C14CE51
 for <bpf@ietf.org>; Thu, 19 Oct 2023 19:42:13 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7b67fef3fd4so137147241.1
 for <bpf@ietf.org>; Thu, 19 Oct 2023 19:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1697769732; x=1698374532;
 darn=ietf.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVA5fSjdA9V5Jo7c0rF1Ke9rT3L+nX0I3OmN+3HgEuw=;
 b=oT8espK8+55a5Pud6HMd/XiOgqFv1hE0DXXiazgXCr65sSfeCbT7cpvk7ZuXyldiBO
 I/gDcmD7vrj/b/kkaFi19aWIqGj81wwI4o6zOi/KQdjZXslBWlbg+uCX1qKKkkbBAr1w
 r2HROIPV2JWi2w+wa5U1tfojAQL3IvFGztMUs25P8MKSVGjQmMMyEa1oWW5HWIQaQRAT
 krGa3CXjlrhInZih7fRzBqzD85QnW1oD8Z81DLKIiRcYUxG0Si9tdlIrvr5Sm2BObZQ2
 EdSwOveqkn3WVqbQT9nyqB1iyUo8YOUORdlrZtYLRUOyAxp/vmPWHAoUhpw72IWJqCqt
 DEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697769732; x=1698374532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TVA5fSjdA9V5Jo7c0rF1Ke9rT3L+nX0I3OmN+3HgEuw=;
 b=FU0GuNQaCIwUIl9nL4SkEM9kzZjRtde0Pl16NEuVM0xUlIcvBpdcu8B40/p3g5xD9F
 RhEgIQ1cOxO86Q/49c1GAx4tsdSN/eyn2QJ2mR+LDLlTZi1/5PseJ2YEwCWgYErJtf2k
 0nurXJHkdXkDIoopNCTTsEqfTPjN8tW1L4Puvf0DfjrC8BBLimI6Zf7U+2AOPLmTWMUl
 hSYmDEnIVIrByHuz0ReDg26Xx6lxXS6C7NkV/hwb68izhsNb7U8nU0BJsUVNvcw1mJNs
 +0jC75f29ZfhOUKMbDZ7iqYj/vnl9Rt4UxDQh3BR20AW+kfoV/Au/kAAwve0HUXCsDyx
 HbsA==
X-Gm-Message-State: AOJu0YzbqC8nUFdP2+Ef5qjpJR1pg9YmZ7GGke13um1rQb7Fa3ftT74O
 tUwA8pbq8lplLOz/OfRh24CBajS6h4Rwu4Yg8CX0GA==
X-Google-Smtp-Source: AGHT+IGDCGb5MI1ezH7+uuu1/7puQhR8na0yn2tuohMCKuEiXELqjEyNCbHP/8zBSiAq72R00sLq4ahOHMZvHM1sSbs=
X-Received: by 2002:a67:c38b:0:b0:457:eee6:c105 with SMTP id
 s11-20020a67c38b000000b00457eee6c105mr649257vsj.8.1697769732381; Thu, 19 Oct
 2023 19:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002142001.3223261-1-hawkinsw@obs.cr>
 <ZTDGPJFegKuwZiOe@infradead.org>
In-Reply-To: <ZTDGPJFegKuwZiOe@infradead.org>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Thu, 19 Oct 2023 22:42:01 -0400
Message-ID: <CADx9qWhTXgKxBpjY47ufhfs=7Fb+mxGULgXo=JrEyUicZ5JP9g@mail.gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: bpf@ietf.org, bpf@vger.kernel.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/9z7KN5vMB2vGBN8UWZXsFTIQRS4>
Subject: Re: [Bpf] [PATCH] bpf,
 docs: Add additional ABI working draft base text
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

T24gVGh1LCBPY3QgMTksIDIwMjMgYXQgMjowMeKAr0FNIENocmlzdG9waCBIZWxsd2lnIDxoY2hA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj4KPiBBIGxpdHRsZSBzdHlsZSBuaXRwaWNrIG9uIHRvcCBv
ZiBhbGwgdGhlIHVzZWZ1bCBjb21tZW50cyBmcm9tCj4gRGF2aWQ6Cj4KPiA+ICtBbiBhcHBsaWNh
dGlvbiBiaW5hcnkgaW50ZXJmYWNlIChBQkkpIGRlZmluZXMgdGhlIHJlcXVpcmVtZW50cyB0aGF0
IG9uZSBvciBtb3JlIGJpbmFyeSBzb2Z0d2FyZQo+Cj4gVGV4dCBkb2N1bWVudHMgYW5kIGFueSBv
dGhlciBidWxreSB0ZXh0cyBzaG91bGQgYmUgc3BhY2VzIHRvIDgwCj4gY2hhcmFjdGVycy4gIFRo
aXMgc2hvdWxkIGp1c3QgYmUgYSB2ZXJ5IHRyaXZpYWwgcmVmb3JtYXQuCgpUaGFuayB5b3UhCgpB
cyB5b3UgY2FuIHRlbGwsIEkgZ290IGEgbGl0dGxlIGJ1c3kgd2l0aCB0ZWFjaGluZy4gSSBwbGFu
IG9uIHNwZW5kaW5nCnRpbWUgd2l0aCB0aGlzIHRvbW9ycm93IGFmdGVybm9vbiBhbmQgYSBmdXJ0
aGVyIHJldmlzaW9uIHNob3VsZCBiZSBvbgppdHMgd2F5IHRoZW4uIFNvcnJ5IGZvciB0aGUgZGVs
YXkhCgpXaWxsCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cu
aWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

