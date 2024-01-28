Return-Path: <bpf+bounces-20528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0151283FB20
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 01:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2280F1C222FC
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 00:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7244596F;
	Mon, 29 Jan 2024 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="U8LS/rVl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="U8LS/rVl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODDwb832"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50553446C7
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706486409; cv=none; b=Ag+oFJikwF0zcYe7eEI29CjIR5CJFaAsweW8YBGEumoE5hS0Hz6RlKpIO3gb9AokbQDPQLeyC6pVIi1axIDx4ue+zeoXdVa2DG6el9CCKxHjbxk48c8inLZpOu4l+VNvWV8N6OXz4BZkShJbWUwTvQm05zbKpszMdt1Do3hDSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706486409; c=relaxed/simple;
	bh=41Jhn8l7pzCTMkZGosw3DCmTRqBTg4XjavH8wslAEQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=nDpPToNeu7Zn12SQ3Pla1OocVoZJOvIHJlpQ4Z/gRNF3qdJWcQ7XPMwukXvn7BzBmk80LxPv4ZGYWQG+CB4dmKOSVTl68Eah5w8E5QYmhU7OqXIgo+VwrpFVfM15X/Q364lJclpd+/uEabx7tX2aoMgXMjnXIpSNodYSJhub9XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=U8LS/rVl; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=U8LS/rVl; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODDwb832 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7FC50C14F6B0
	for <bpf@vger.kernel.org>; Sun, 28 Jan 2024 16:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706486405; bh=41Jhn8l7pzCTMkZGosw3DCmTRqBTg4XjavH8wslAEQY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=U8LS/rVlGlZ5tRM81pLFck5X/6Y/44sUgV5LxiawKmKxWFoksfsZlmfpYRwARMwKR
	 BTJd0eYypeXQRxnHW0zmiXKAYq/omVTU2ZWoCgIvS04rFmthRTOjRym5Mdbe3wMIbw
	 M7+pQsOKUjeUVnHcau5HvfpCnnzH4olPtJ23vRA0=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sun Jan 28 16:00:05 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2B8EFC14F602;
	Sun, 28 Jan 2024 16:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706486405; bh=41Jhn8l7pzCTMkZGosw3DCmTRqBTg4XjavH8wslAEQY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=U8LS/rVlGlZ5tRM81pLFck5X/6Y/44sUgV5LxiawKmKxWFoksfsZlmfpYRwARMwKR
	 BTJd0eYypeXQRxnHW0zmiXKAYq/omVTU2ZWoCgIvS04rFmthRTOjRym5Mdbe3wMIbw
	 M7+pQsOKUjeUVnHcau5HvfpCnnzH4olPtJ23vRA0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id C30FAC14F602
 for <bpf@ietfa.amsl.com>; Sun, 28 Jan 2024 16:00:04 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.107
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qjX5y1NtApIL for <bpf@ietfa.amsl.com>;
 Sun, 28 Jan 2024 16:00:02 -0800 (PST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 24DE1C14F5FF
 for <bpf@ietf.org>; Sun, 28 Jan 2024 16:00:02 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40ee705e9bfso26149415e9.0
 for <bpf@ietf.org>; Sun, 28 Jan 2024 16:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706486400; x=1707091200; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7x21MVZ3T5kHI10+76D9TW9jSjeUQJEv9vhm3J4OBM=;
 b=ODDwb832xDmxr5tXVfkA5QrAQ0EyR8i6RwiNoiI1y11B46tbqD8Op0XsFhJWaADy+N
 Icv5Vqzg1wDHP35uJj8wHPs16wbfZb5fVBqpL6V9FhvIxN+wFpK6TihLffq5KJxBpE7I
 rB69alIq+Esve5L+oeM1Nr07q4gy628ISgRVHIMDXnu+8cWN0+umdrpr/lQPjWq+j7p8
 x9kGZ4IyIXZq09EPOGTaavIl5rqpaAaRJbPFZqXZZrKy83iqMRb8cHiixuTCi16Avk7j
 lFGLXV+1Bkcq9KaZKe2PtH8/ztgC6p3if+a6YDwHwdEs0TR7FEAbZtflKYA+rLSZ2gAd
 2MNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706486400; x=1707091200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a7x21MVZ3T5kHI10+76D9TW9jSjeUQJEv9vhm3J4OBM=;
 b=CG9SQIm5Wevs41xaL2KocnbdfUlk43wsDQ5TodEoSwCdTgO+oMvJVu3GirqzgA06v2
 5XRtGL9RCqi+dWPQ4pceGQodYJ8BgvmFKH1LmDG31VuwT9O/LXTfn/G6vl4pEX0Kpgk+
 Y43Qg5JaprY0KJK5HwS+2+Qu+aAW4yE7XRYTsgVMQrxjsKxHSHfuG20qCcro0Y47BstZ
 aX68r6WqCto86d+5ERW9vCX0WXKkHTR29JfwAkz75PcRlH/BXd8/7g5nxxSYubRZRzpX
 H4kWBTqyhMgX2Q1qxeX0M0mbuIl4RsWBUUUFPZL2G1+NPDEdWkd0frfnpw2Dach3k+AC
 Sydw==
X-Gm-Message-State: AOJu0YzmS+LKWtV/AfGXs7yMUyZO0jIICYtug6S/+rVW2puY3YuSa+Sm
 QNxYuwLnI6lvc34G7/MKVO0rmve8OKpwVICZEEfmVdU/lOr1/Hx3P6c/vxIPILUHNHQMz493p06
 NHySg+ogZ63sToaMXa8oLpq7sFc8=
X-Google-Smtp-Source: AGHT+IFNtPAKt8KhgVradSii0nSxKnv8/biZEE3dhq9G0z33hQn3nO3baMhjK5bh6oK7tZl//2Bhs8HvpUbpX7a9IBY=
X-Received: by 2002:a5d:51ca:0:b0:33a:ee39:5b4a with SMTP id
 n10-20020a5d51ca000000b0033aee395b4amr719969wrv.36.1706486400236; Sun, 28 Jan
 2024 16:00:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <006601da5151$a22b2bb0$e6818310$@gmail.com>
 <877cjutxe9.fsf@oracle.com>
 <8734uitx3m.fsf@oracle.com> <01e601da51b7$92c4ffa0$b84efee0$@gmail.com>
In-Reply-To: <01e601da51b7$92c4ffa0$b84efee0$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 28 Jan 2024 15:59:48 -0800
Message-ID: <CAADnVQK8JegsSxgbQbO=DR71cRgkvN-y9LH_ZQYxmj1a-hCz5g@mail.gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Yonghong Song <yonghong.song@linux.dev>, bpf@ietf.org, 
 bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/ogmS9qFhdBCxC4VrOWL7nzjSiXU>
Subject: Re: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
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

T24gU2F0LCBKYW4gMjcsIDIwMjQgYXQgMTA6NTnigK9QTSA8ZHRoYWxlcjE5NjhAZ29vZ2xlbWFp
bC5jb20+IHdyb3RlOgo+Cj4gSSBhc2tlZDoKPiA+ID4+IFdoYXQgYWJvdXQgRFcgYW5kIExEWCB2
YXJpYW50cyBvZiBCUEZfSU5EIGFuZCBCUEZfQUJTPwo+Cj4gSm9zZSBFLiBNYXJjaGVzaSA8am9z
ZS5tYXJjaGVzaUBvcmFjbGUuY29tPiB3cm90ZToKPiA+IFRoZXNlIHdlIHN1cHBvcnQ6Cj4gPgo+
ID4gICAvKiBBYnNvbHV0ZSBsb2FkIGluc3RydWN0aW9ucywgZGVzaWduZWQgdG8gYmUgdXNlZCBp
biBzb2NrZXQgZmlsdGVycy4KPiAqLwo+ID4gICB7QlBGX0lOU05fTERBQlNCLCAibGRhYnNiJVcl
aTMyIiwgInIwID0gKiAoIHU4ICogKSBza2IgWyAlaTMyIF0iLAo+ID4gICAgQlBGX1YxLCBCUEZf
Q09ERSwgQlBGX0NMQVNTX0xEfEJQRl9TSVpFX0J8QlBGX01PREVfQUJTfSwKPiA+ICAge0JQRl9J
TlNOX0xEQUJTSCwgImxkYWJzaCVXJWkzMiIsICJyMCA9ICogKCB1MTYgKiApIHNrYiBbICVpMzIg
XSIsCj4gPiAgICBCUEZfVjEsIEJQRl9DT0RFLCBCUEZfQ0xBU1NfTER8QlBGX1NJWkVfSHxCUEZf
TU9ERV9BQlN9LAo+ID4gICB7QlBGX0lOU05fTERBQlNXLCAibGRhYnN3JVclaTMyIiwgInIwID0g
KiAoIHUzMiAqICkgc2tiIFsgJWkzMiBdIiwKPiA+ICAgIEJQRl9WMSwgQlBGX0NPREUsIEJQRl9D
TEFTU19MRHxCUEZfU0laRV9XfEJQRl9NT0RFX0FCU30sCj4gPiAgIHtCUEZfSU5TTl9MREFCU0RX
LCAibGRhYnNkdyVXJWkzMiIsICJyMCA9ICogKCB1NjQgKiApIHNrYiBbICVpMzIgXSIsCj4gPiAg
ICBCUEZfVjEsIEJQRl9DT0RFLCBCUEZfQ0xBU1NfTER8QlBGX1NJWkVfRFd8QlBGX01PREVfQUJT
fSwKPiA+Cj4gPiAgIC8qIEdlbmVyaWMgbG9hZCBpbnN0cnVjdGlvbnMgKHRvIHJlZ2lzdGVyLikg
ICovCj4gPiAgIHtCUEZfSU5TTl9MRFhCLCAibGR4YiVXJWRyICwgWyAlc3IgJW8xNiBdIiwgIiVk
ciA9ICogKCB1OCAqICkgKCAlc3IgJW8xNgo+ICkiLAo+ID4gICAgQlBGX1YxLCBCUEZfQ09ERSwg
QlBGX0NMQVNTX0xEWHxCUEZfU0laRV9CfEJQRl9NT0RFX01FTX0sCj4gPiAgIHtCUEZfSU5TTl9M
RFhILCAibGR4aCVXJWRyICwgWyAlc3IgJW8xNiBdIiwgIiVkciA9ICogKCB1MTYgKiApICggJXNy
Cj4gJW8xNgo+ID4gKSIsCj4gPiAgICBCUEZfVjEsIEJQRl9DT0RFLCBCUEZfQ0xBU1NfTERYfEJQ
Rl9TSVpFX0h8QlBGX01PREVfTUVNfSwKPiA+ICAge0JQRl9JTlNOX0xEWFcsICJsZHh3JVclZHIg
LCBbICVzciAlbzE2IF0iLCAiJWRyID0gKiAoIHUzMiAqICkgKCAlc3IKPiAlbzE2Cj4gPiApIiwK
PiA+ICAgIEJQRl9WMSwgQlBGX0NPREUsIEJQRl9DTEFTU19MRFh8QlBGX1NJWkVfV3xCUEZfTU9E
RV9NRU19LAo+ID4gICB7QlBGX0lOU05fTERYRFcsICJsZHhkdyVXJWRyICwgWyAlc3IgJW8xNiBd
IiwiJWRyID0gKiAoIHU2NCAqICkgKCAlc3IKPiA+ICVvMTYgKSIsCj4gPiAgICBCUEZfVjEsIEJQ
Rl9DT0RFLCBCUEZfQ0xBU1NfTERYfEJQRl9TSVpFX0RXfEJQRl9NT0RFX01FTX0sCj4KPiBZb25n
aG9uZyBTb25nIDx5b25naG9uZy5zb25nQGxpbnV4LmRldj4gd3JvdGU6Cj4gPiBJIGRvbid0IGtu
b3cgaG93IHRvIGRvIHByb3BlciB3b3JkaW5nIGluIHRoZSBzdGFuZGFyZC4gQnV0IERXIGFuZCBM
RFgKPiA+IHZhcmlhbnRzIG9mIEJQRl9JTkQvQlBGX0FCUyBhcmUgbm90IHN1cHBvcnRlZCBieSB2
ZXJpZmllciBmb3Igbm93IGFuZCB0aGV5Cj4gPiBhcmUgY29uc2lkZXJlZCBpbGxlZ2FsIGluc25z
Lgo+Cj4gQWx0aG91Z2ggdGhlIExpbnV4IHZlcmlmaWVyIGRvZXNuJ3Qgc3VwcG9ydCB0aGVtLCB0
aGUgZmFjdCB0aGF0IGdjYyBkb2VzCj4gc3VwcG9ydAo+IHRoZW0gdGVsbHMgbWUgdGhhdCBpdCdz
IHByb2JhYmx5IHNhZmVzdCB0byBsaXN0IHRoZSBEVyBhbmQgTERYIHZhcmlhbnRzIGFzCj4gZGVw
cmVjYXRlZCBhcyB3ZWxsLCB3aGljaCBpcyB3aGF0IHRoZSBkcmFmdCBhbHJlYWR5IGRpZCBpbiB0
aGUgYXBwZW5kaXggc28KPiB0aGF0J3MgZ29vZCAobm90aGluZyB0byBjaGFuZ2UgdGhlcmUsIEkg
dGhpbmspLgoKRFcgbmV2ZXIgZXhpc3RlZCBpbiBjbGFzc2ljIGJwZiwgc28gYWJzL2luZCBuZXZl
ciBoYWQgRFcgZmxhdm9yLgpJZiBzb21lIGFzc2VtYmxlci9jb21waWxlciBkZWNpZGVkIHRvICJz
dXBwb3J0IiB0aGVtIGl0J3Mgb24gdGhlbS4KVGhlIHN0YW5kYXJkIG11c3Qgbm90IGxpc3Qgc3Vj
aCB0aGluZ3MgYXMgZGVwcmVjYXRlZC4gVGhleSBuZXZlcgpleGlzdGVkLiBTbyBub3RoaW5nIGlz
IGRlcHJlY2F0ZWQuClNhbWUgd2l0aCBNU0guIEJQRl9MRFggfCBCUEZfTVNIIHwgQlBGX0IgaXMg
dGhlIG9ubHkgaW5zbiBldmVyIGV4aXN0ZWQuCkl0J3MgYSBsZWdhY3kgaW5zbi4gSnVzdCBsaWtl
IGFicy9pbmQuCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cu
aWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

