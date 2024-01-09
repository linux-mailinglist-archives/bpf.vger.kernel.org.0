Return-Path: <bpf+bounces-19248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F9C827CCC
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 03:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5041C233BB
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 02:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC47257B;
	Tue,  9 Jan 2024 02:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="xv5TG1yb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="fjU1cpgI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+aOfY+o"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E3223D5
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 02:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0AF80C236E7E
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 18:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1704766579; bh=p50mTNHsdTXDbB217Xkpc3HOLu68NrRIMPnY2oxPEYQ=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=xv5TG1ybBId+4TG+SJTh8J7VpmwI326gVMkuqw9uJl7iN1joBCxLkpPZSv7obsc57
	 N1fNZeMyFyBbVLHJdgkzqH8ZL8YtaelAvRxvM8U2kJk4q7vMPExeT7UTQ9k034CT2s
	 PvlWC5iFkglMaV2F5stylukrwJcOkRPOhHMoGxSE=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Jan  8 18:16:18 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DFFBCC1CAF2D;
	Mon,  8 Jan 2024 18:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1704766578; bh=p50mTNHsdTXDbB217Xkpc3HOLu68NrRIMPnY2oxPEYQ=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=fjU1cpgIii270hpAwo4QY/I+Bx/LFwXst549oJNVKox0tGts55lCrB6AZcOesvN8x
	 MCiUdfSnM91YNjd15+nHjFXWewEUfWGZ3OczOxInelQVoqmQh9cgS+SBaUjutvrkVY
	 WlTJsRLNkGXywH4phJdKT76NGgh/oEIfeMcYXTGg=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1C686C1CAF2C
 for <bpf@ietfa.amsl.com>; Mon,  8 Jan 2024 18:16:18 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mviMBQzydGON for <bpf@ietfa.amsl.com>;
 Mon,  8 Jan 2024 18:16:16 -0800 (PST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 05EFAC1CAF2A
 for <bpf@ietf.org>; Mon,  8 Jan 2024 18:16:15 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40d8902da73so23170825e9.2
 for <bpf@ietf.org>; Mon, 08 Jan 2024 18:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704766574; x=1705371374; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=05GnswnOa3fKI8+mtz6RQjawxWXtRaMDdItsI0uqcyc=;
 b=L+aOfY+oYl2e4P28EtW8/TbWoXgnZZcYM1jRZDSjXVfsyq2K3oEihmxVwjgBDc/oHt
 Zh1OYJUZ6Cfqwg4gO80bRLXbAYyFaCXAblSP6xpvXrLc+d288tOoOxBQn98iWNC+jsFQ
 J6KmVWViShaP1VSZvLhJnab62w1lo0jT5UzCHvi5PHn0yUKONVlogFXb6qGFH5k99P9A
 fb/2X9o0VB7FHN3TTi+VPXLhGSf6uBjOi+xVlDVyBYnE0twOP63Yu84rQ1xd96F+ET9L
 4Eg4les6pVcftTJmsPEiqsZK2usQEPj81btnG9/NaJohxRa22dZt15jIEATF3im4/3K9
 W03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704766574; x=1705371374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=05GnswnOa3fKI8+mtz6RQjawxWXtRaMDdItsI0uqcyc=;
 b=qDMdmKv9AIM/YeTOWWJzCZc/DUu1zWYxSPYi191kBfcSKtXktFBRfK9XrLd7/Ahr81
 AV7klZOiOVzJN22najt92WfxglbNCLsd8BG+jnnGUsp7rYptqWgHhMNQpbeAHqd4JmXF
 hU+c8Qbqbw0LEvH6IwOgWqfgIXe252AdcjyrhAPdKQKDckUdwcYNz3mi1vXlks1/r2mU
 pzf19Rq+SpeLHJEbFQnqL/faO2Xlr9fhvz6dagucfgthrlkOFkgmnbg7ldcZpq+Wnd1B
 SHVA010j5kewwCzlyTGPPWxS6mx55XtqUi2r4Nhz3ICPS9B5BjqXtmipGpGWUWpJl7fC
 /dWw==
X-Gm-Message-State: AOJu0Yz9a+8/Q07SFD5ZGqNR5hEQjSfiLY+4CErFeZm4bwrr3fc34Z+O
 cskh2aFJbHa8r7U2lkHkC5uWlTIQKxOPWNlyJBE=
X-Google-Smtp-Source: AGHT+IEEIJ9TAUJSJ7ymIiOcJUTyD7Cky7S9ewyqqmyZRT65dKu1c/kk9E6Ty9DKui4OH00bNSJ36afgZYiBNUwfp3A=
X-Received: by 2002:a05:600c:2049:b0:40d:5cea:895f with SMTP id
 p9-20020a05600c204900b0040d5cea895fmr2586700wmg.115.1704766574125; Mon, 08
 Jan 2024 18:16:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108214231.5280-1-dthaler1968@gmail.com>
In-Reply-To: <20240108214231.5280-1-dthaler1968@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Jan 2024 18:16:03 -0800
Message-ID: <CAADnVQ+93dhSwOWUPDa3E5d6CPzBoNVoEsaCEq0PfWrxPYFDAw@mail.gmail.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org,
 Dave Thaler <dthaler1968@gmail.com>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/U-sBJtzUDyw9HvYZWs860wSI02w>
Subject: Re: [Bpf] [PATCH bpf-next] Introduce concept of conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

T24gTW9uLCBKYW4gOCwgMjAyNCBhdCAxOjQy4oCvUE0gRGF2ZSBUaGFsZXIKPGR0aGFsZXIxOTY4
PTQwZ29vZ2xlbWFpbC5jb21AZG1hcmMuaWV0Zi5vcmc+IHdyb3RlOgo+Cj4gVGhlIGRpc2N1c3Np
b24gb2Ygd2hhdCB0aGUgYWN0dWFsIGNvbmZvcm1hbmNlIGdyb3VwcyBzaG91bGQgYmUKPiBpcyBz
dGlsbCBpbiBwcm9ncmVzcywgc28gdGhpcyBpcyBqdXN0IHBhcnQgMSB3aGljaCBvbmx5IHVzZXMK
PiAibGVnYWN5IiBmb3IgZGVwcmVjYXRlZCBpbnN0cnVjdGlvbnMgYW5kICJiYXNpYyIgZm9yIGV2
ZXJ5dGhpbmcKPiBlbHNlLiAgU3Vic2VxdWVudCBwYXRjaGVzIHdpbGwgYWRkIG1vcmUgZ3JvdXBz
IGFzIGRpc2N1c3Npb24KPiBjb250aW51ZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBEYXZlIFRoYWxl
ciA8ZHRoYWxlcjE5NjhAZ21haWwuY29tPgoKTmljZSBzdGFydC4gbGd0bS4KV2FpdGluZyBmb3Ig
YWNrcy4uLgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0dHBzOi8vd3d3Lmll
dGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

