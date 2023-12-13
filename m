Return-Path: <bpf+bounces-17635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB72B8107AD
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 02:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8B51C20E62
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 01:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAA31109;
	Wed, 13 Dec 2023 01:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="J27kcE73";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="J27kcE73";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mt/G5TLP"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B9DB7
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 17:32:50 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8E7C9C15C28C
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 17:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702431170; bh=aARpjDakdCAF1a7XknnrY/4e+GpLUlLrOL29MsQvu84=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=J27kcE73XtNoQBFSdI46qRzfQl4fgi3V87Avh8qeDHyg3vYLa+yXfP6ypZRsggYed
	 K+rZbl0T8+lg/5J0mowfWQ0N/ZCyx0JyM2WMIu8UDPGFHrLhUcA4F4re0eDCOprmMC
	 1lFzXdfrnhEHw4B1eCCooCAFjk7GKwQ5emuJJ2eQ=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Dec 12 17:32:50 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 647FFC151079;
	Tue, 12 Dec 2023 17:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702431170; bh=aARpjDakdCAF1a7XknnrY/4e+GpLUlLrOL29MsQvu84=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=J27kcE73XtNoQBFSdI46qRzfQl4fgi3V87Avh8qeDHyg3vYLa+yXfP6ypZRsggYed
	 K+rZbl0T8+lg/5J0mowfWQ0N/ZCyx0JyM2WMIu8UDPGFHrLhUcA4F4re0eDCOprmMC
	 1lFzXdfrnhEHw4B1eCCooCAFjk7GKwQ5emuJJ2eQ=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 88345C151079
 for <bpf@ietfa.amsl.com>; Tue, 12 Dec 2023 17:32:49 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Giejo_aeqchv for <bpf@ietfa.amsl.com>;
 Tue, 12 Dec 2023 17:32:47 -0800 (PST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 398EAC14CE24
 for <bpf@ietf.org>; Tue, 12 Dec 2023 17:32:47 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-336221efdceso2194558f8f.3
 for <bpf@ietf.org>; Tue, 12 Dec 2023 17:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702431165; x=1703035965; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGTpQmu3GXE7DHNoF7J3vSFJThQGo8kjepksHBry8bc=;
 b=mt/G5TLP4sBfbb8lHn9OqNHMs0DRZ1XBjXx+85dzuGsRXtNtLJq2jY5fCl/73aibV3
 MYssFq+s1AWGfdYQZAP27jt7dLwHDd0zzvNAZs5jYjkAqnS8hTPloftm7+8fqQQZYefi
 SC/+yDminkzDJDf/Q15O5Q/Jb5t9KfYyxAlEvT/JX9mgCte19n0SMsQJ31GjoYQoKZbl
 PFcVK/t3gUugS41hdblmnbVebgYS57erAW6VRY2QWHP0NoLy3mR4FgpO0Ky8tmnHfCRW
 4GU8hMtYf74dutoER8p2jaD1vNRGYfza68V0fdITXCofXeCqIoTI6R2+uSptGpM8ElEU
 R5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702431165; x=1703035965;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QGTpQmu3GXE7DHNoF7J3vSFJThQGo8kjepksHBry8bc=;
 b=oH2/8JhqnkaPWPiRvToHXIM3SHPJq3UntNJPtPWnQkwmLv9q3cfd48YuIHwnWPO9ky
 Rc6TeUlRkoql6m6awbK/V4DBa8dFI0SiWPY+m6vwrMwlAys551vwvRPJfhaJfMcGxYbX
 SptL/Sff+kfT41/WaLAE25vNH69N2IFFhdRDWgEyxzXhghI1BmCv4x+TW+Op5zpnBoyP
 WUKQRDpp7KTjfjowp5RgKmRyH3GuIUu1dGUWC7ZhOSDAC8ySaCVQEfjSPRhvUtvBzYFU
 IsOLMPla6YQf+UhF9k6M3mEFIUvZNqg/UCijdcz5s6UCFiDFtzKNLHuFoEoyr6OySX5a
 Hrfg==
X-Gm-Message-State: AOJu0YwA37FVu+6xOBGXoQ8dJKGOBa/GT6IOtdUsxS/hQjMsx/0J7v11
 6rG1gxh+qyaWdQMlLwUoJHQ/jAzilRG4+WaTLGo=
X-Google-Smtp-Source: AGHT+IFsJBK3NJijxkElIbph59esV9Ms4A/ssi/wmtpGUnUY07juV0rmchatiXkFT22EiVOk8mPyrEzs79FblC7YMXI=
X-Received: by 2002:adf:fb49:0:b0:333:53b9:441b with SMTP id
 c9-20020adffb49000000b0033353b9441bmr2138961wrs.47.1702431165398; Tue, 12 Dec
 2023 17:32:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127201817.GB5421@maniforge>
 <072101da2558$fe5f5020$fb1df060$@gmail.com>
 <20231207215152.GA168514@maniforge>
 <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
 <20231212214532.GB1222@maniforge> <157b01da2d46$b7453e20$25cfba60$@gmail.com>
 <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com>
 <20231212233555.GA53579@maniforge>
In-Reply-To: <20231212233555.GA53579@maniforge>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Dec 2023 17:32:33 -0800
Message-ID: <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
To: David Vernet <void@manifault.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org,
 bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/rmADK_FvNRDFF3pPuRjgPLsHY20>
Subject: Re: [Bpf] BPF ISA conformance groups
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

T24gVHVlLCBEZWMgMTIsIDIwMjMgYXQgMzozNuKAr1BNIERhdmlkIFZlcm5ldCA8dm9pZEBtYW5p
ZmF1bHQuY29tPiB3cm90ZToKPgo+ID4gSXQgb25seSBzdXBwb3J0cyBhdG9taWNfYWRkIGFuZCBu
byBvdGhlciBhdG9taWNzLgo+Cj4gQWhoLCBJIG1pc3VuZGVyc3Rvb2Qgd2hlbiBJIGRpc2N1c3Nl
ZCB3aXRoIEt1YmEuIEkgZ3Vlc3MgdGhleSBzdXBwb3J0ZWQKPiBvbmx5IGF0b21pY19hZGQgYmVj
YXVzZSBwYWNrZXRzIGNhbiBiZSBkZWxpdmVyZWQgb3V0IG9mIG9yZGVyLgoKTm90IHN1cmUgd2h5
IGl0IGhhcyBhbnl0aGluZyB0byBkbyB3aXRoIHBhY2tldHMuCgo+IFNvIGZhaXIKPiBlbm91Z2gg
b24gdGhhdCBwb2ludCwgYnV0IEkgc3RpbGwgc3RhbmQgYnkgdGhlIGNsYWltIHRob3VnaCB0aGF0
IGlmIHlvdQo+IG5lZWQgb25lIHR5cGUgb2YgYXRvbWljLCBpdCdzIHJlYXNvbmFibGUgdG8gaW5m
ZXIgdGhhdCB5b3UgbWF5IG5lZWQgYWxsCj4gb2YgdGhlbS4gSSB3b3VsZCBiZSBjdXJpb3VzIHRv
IGhlYXIgaG93IG11Y2ggd29yayBpdCB3b3VsZCBoYXZlIGJlZW4gdG8KPiBhZGQgc3VwcG9ydCBm
b3IgdGhlIG90aGVycy4gSWYgdGhlcmUgd2FzIGFuIGF0b21pYyBjb25mb3JtYW5jZSBncm91cCwK
PiBtYXliZSB0aGV5IHdvdWxkIGhhdmUuCgpUaGUgbmV0cm9ub21lIHdhc24ndCB0cnlpbmcgdG8g
b2ZmbG9hZCB0aGlzIG9yIHRoYXQgaW5zbiB0byBiZQppbiBjb21wbGlhbmNlLiBUb2dldGhlciwg
bmV0cm9ub21lIGFuZCBicGYgZm9sa3MgZGVjaWRlZCB0byBmb2N1cwpvbiBhIHNldCBvZiByZWFs
IFhEUCBhcHBsaWNhdGlvbnMgYW5kIHRyeSB0byBvZmZsb2FkIGFzIG11Y2ggYXMgcHJhY3RpY2Fs
LgpBdCB0aGF0IHRpbWUgdGhlcmUgd2VyZSAtbWNwdT12MSBhbmQgdjIgaW5zbiBzZXRzIG9ubHkg
YW5kIG9mZmxvYWRpbmcKd2Fzbid0IHJlYWxseSB3b3JraW5nIHdlbGwuIGFsdTMyIGluIGxsdm0s
IHZlcmlmaWVyIGFuZCBuZnAgd2FzIGFkZGVkCnRvIG1ha2Ugb2ZmbG9hZCBwcmFjdGljYWwuIEV2
ZW50dWFsbHkgaXQgYmVjYW1lIC1tY3B1PXYzLgpTbyBjb21wbGlhbmNlIHdpdGggYW55IGZ1dHVy
ZSBncm91cCAoYmFzaWMsIGF0b21pYywgZXRjKSBpbiBJU0EgY2Fubm90CmJlIGV2YWx1YXRlZCBp
biBpc29sYXRpb24sIGJlY2F1c2UgbmZwIGlzIG5vdCBjb21wbGlhbnQgd2l0aCAtbWNwdT12NAph
bmQgbm90IGNvbXBsaWFudCB3aXRoIC1tY3B1PXYxLApidXQgd29ya3Mgd2VsbCB3aXRoIC1tY3B1
PXYzIHdoaWxlIHYzIGlzIGFuIGV4dGVuc2lvbiBvZiB2MSBhbmQgdjIuCldoaWNoIGlzIG5vbnNl
bnNpY2FsIGZyb20gc3RhbmRhcmQgY29tcGxpYW5jZSBwb3YuCm5ldHJvbm9tZSBvZmZsb2FkIGlz
IGEgc3VjY2VzcyBiZWNhdXNlIGl0IGRlbW9uc3RyYXRlZApob3cgcmVhbCBwcm9kdWN0aW9uIFhE
UCBhcHBsaWNhdGlvbnMgY2FuIHJ1biBpbiBhIE5JQyBhdCBzcGVlZHMKdGhhdCB0cmFkaXRpb25h
bCBDUFVzIGNhbm5vdCBkcmVhbSBvZi4KSXQncyBhIHN1Y2Nlc3MgZGVzcGl0ZSB0aGUgY29tcGxl
eGl0eSBhbmQgdWdsaW5lc3Mgb2YgQlBGIElTQS4KSXQncyB3b3JraW5nIGJlY2F1c2UgcHJhY3Rp
Y2FsIGFwcGxpY2F0aW9ucyBjb21waWxlZCB3aXRoIC1tY3B1PXYzIHByb2R1Y2UKImNvbXBsaWFu
dCBlbm91Z2giIGJwZiBjb2RlLgoKPiBXZWxsLCBtYXliZSBub3QgZm9yIE5ldHJvbm9tZSwgb3Ig
bWF5YmUgbm90IGV2ZW4gZm9yIGFueSB2ZW5kb3IgKHRob3VnaAo+IHdlIGhhdmUgbm8gd2F5IG9m
IGtub3dpbmcgdGhhdCB5ZXQpLCBidXQgd2hhdCBhYm91dCBmb3Igb3RoZXIgY29udGV4dHMKPiBs
aWtlIFdpbmRvd3MgLyBMaW51eCBjcm9zcy1wbGF0Zm9ybSBjb21wYXQ/CgpicGYgb24gd2luZG93
cyBzdGFydGVkIHNpbWlsYXIgdG8gbmV0cm9ub21lLiBUaGUgZ29hbCB3YXMgdG8KZGVtb25zdHJh
dGUgcmVhbCBjaWxpdW0gcHJvZ3MgcnVubmluZyBvbiB3aW5kb3dzLiBBbmQgaXQgd2FzIGRvbmUu
ClNpbmNlIHdpbmRvd3MgaXMgYSBzb2Z0d2FyZSB0aGVyZSB3YXMgbm8gbmVlZCB0byBhZGQgb3Ig
cmVtb3ZlIGFueXRoaW5nCmZyb20gSVNBLCBidXQgZHVlIHRvIGxpY2Vuc2luZyB0aGUgcHJldmFp
bCB2ZXJpZmllciBoYWQgdG8gYmUgdXNlZCB3aGljaApkb2Vzbid0IHN1cHBvcnQgYSB3aG9sZSBi
dW5jaCBvZiB0aGluZ3MuClRoaXMgc29mdHdhcmUgZGVmaWNpZW5jaWVzIG9mIG5vbi1saW51eCB2
ZXJpZmllciBzaG91bGRuJ3QgYmUKZGljdGF0aW5nIGdyb3VwaW5nIG9mIHRoZSBpbnNucyBpbiB0
aGUgc3RhbmRhcmQuCklmIGxpbnV4IGNhbiBkbyBpdCwgd2luZG93cyBzaG91bGQgYmUgYWJsZSB0
byBkbyBpdCBqdXN0IGFzIHdlbGwuClNvIEkgc2VlIG5vIHByb2JsZW0gc2F5aW5nIHRoYXQgYnBm
IG9uIHdpbmRvd3Mgd2lsbCBiZSBub24tY29tcGxpYW50CnVudGlsIHRoZXkgc3VwcG9ydCBhbGwg
b2YgLW1jcHU9djQgaW5zbnMuIEl0J3MgYSBzb2Z0d2FyZSBwcm9qZWN0CndpdGggYSBkZXRlcm1p
bmlzdGljIHRpbWVsaW5lLgoKVGhlIHN0YW5kYXJkIHNob3VsZCBmb2N1cyBvbiBjb21wYXRpYmls
aXR5IGJldHdlZW4KSFctaXNoIG9mZmxvYWRzIHdoZXJlIG5vIGFtb3VudCBvZiBzb2Z0d2FyZSBj
YW4gYWRkIHN1cHBvcnQgZm9yCmFsbCBvZiAtbWNwdT12NC4KQW5kIGhlcmUgSSBiZWxpZXZlIGNv
bXBsaWFuY2Ugd2l0aCAiYmFzaWMiIGlzIG5vdCBwcmFjdGljYWwuCldoZW4gbnZtZSBIVyBhcmNo
aXRlY3RzIHdpbGwgZ2V0IHRvIGltcGxlbWVudCAiYmFzaWMiIElTQSB0aGV5IG1pZ2h0CnJlYWxp
emUgdGhhdCBpdCBoYXMgdG9vIG11Y2guClByb2R1Y2luZyAiY29uZm9ybWFuY2UgZ3JvdXBzIiB3
aXRob3V0IEhXIGZvbGtzIHRoaW5raW5nIHRocm91Z2ggdGhlCmltcGxlbWVudGF0aW9uIGlzIG5v
dCBnb2luZyB0byBiZSBhIHN1Y2Nlc3MuCkkgd29ycnkgdGhhdCBpdCB3aWxsIGhhdmUgdGhlIG9w
cG9zaXRlIGVmZmVjdC4KV2UnbGwgaGF2ZSBhIHN0YW5kYXJkIHdpdGggYmFzaWMsIGF0b21pYywg
ZXRjLgpUaGVuIGZvbGtzIHdpbGwgZGVsaXZlciB0aGlzIHN0YW5kYXJkIG9uIHRoZSBkZXNrIG9m
IEhXIGFyY2hpdGVjdHMuClRoZXkgd2lsbCBnaXZlIGl0IGEgdHJ5IGFuZCB3aWxsIHJlamVjdCB0
aGUgaWRlYSBvZiBpbXBsZW1lbnRpbmcgQlBGIGluIEhXLApiZWNhdXNlIG5vdCBpbXBsZW1lbnRp
bmcgImJhc2ljIiB3b3VsZCBtZWFuIHRoYXQgdGhpcyB2ZW5kb3IKaXMgbm90IGluIGNvbXBsaWFu
Y2Ugd2hpY2ggbWVhbnMgbm8gYnVzaW5lc3MuCkhlbmNlIHRoZSBzdGFuZGFyZCBzaG91bGRuJ3Qg
b3ZlcmZvY3VzIG9uIGNvbXBsaWFuY2UgYW5kIGdyb3Vwcy4KSnVzdCBsZWdhY3kgYW5kIHRoZSBy
ZXN0IHdpbGwgZG8gZm9yIG52bWUuCmxlZ2FjeSBtZWFucyAiZG9uJ3QgYm90aGVyIGxvb2tpbmcg
YXQgdGhvc2UiLgp0aGUgcmVzdCBtZWFucyAicGxzIGltcGxlbWVudCB0aGVzZSBpbnNucyBiZWNh
dXNlIHRoZXkgYXJlIHVzZWZ1bCwKdGhlaXIgc2VtYW50aWNzIGFuZCBlbmNvZGluZyBpcyBzdGFu
ZGFyZGl6ZWQsCmJ1dCBwaWNrIHdoYXQgbWFrZXMgc2Vuc2UgZm9yIHlvdXIgdXNlIGNhc2UgYW5k
IHlvdXIgSFciLgoKQW5kIHRvIG1ha2Ugc3VjaCBIVyBvZmZsb2FkIGEgc3VjY2VzcyB3ZSdkIG5l
ZWQgdG8gd29yayB0b2dldGhlci4KY29tcGlsZXIsIGtlcm5lbCwgcnVuLXRpbWUsIGh3IGZvbGtz
LgoiSGVyZSBpcyBhIHN0YW5kYXJkLiBHbyBpbXBsZW1lbnQgaXQiIHdvbid0IHdvcmsuCgotLSAK
QnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1h
bi9saXN0aW5mby9icGYK

