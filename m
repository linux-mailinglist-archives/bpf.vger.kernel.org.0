Return-Path: <bpf+bounces-17747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD2B8123BE
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D721F21880
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B65381;
	Thu, 14 Dec 2023 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="oEcwp1bS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="oEcwp1bS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ih+zceMg"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B555DD
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 16:12:48 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 438DBC151063
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 16:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702512768; bh=0wsTkRREqubL8pE/75i+IH0do9fx5nkuSWGkwcDSY5g=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=oEcwp1bSRq5O+Ddusm9P3e5+T8utnoNJT22oiSqzR25KEpZi/xRtOErmaFB7qycG+
	 7w02IvGuhRzQXLdiVUm5wJ1ijFvSS8OgSFWqiYXj+DRJLCCj0mh/ytGCirPPS/YIKL
	 KKkuueC1fVsqLtHb3V4hyhtO9FUj19VjAID9d2bg=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Dec 13 16:12:48 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 18B82C14CEFD;
	Wed, 13 Dec 2023 16:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702512768; bh=0wsTkRREqubL8pE/75i+IH0do9fx5nkuSWGkwcDSY5g=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=oEcwp1bSRq5O+Ddusm9P3e5+T8utnoNJT22oiSqzR25KEpZi/xRtOErmaFB7qycG+
	 7w02IvGuhRzQXLdiVUm5wJ1ijFvSS8OgSFWqiYXj+DRJLCCj0mh/ytGCirPPS/YIKL
	 KKkuueC1fVsqLtHb3V4hyhtO9FUj19VjAID9d2bg=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 8DB63C14CEFD
 for <bpf@ietfa.amsl.com>; Wed, 13 Dec 2023 16:12:46 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P9o-Fm_5CSvT for <bpf@ietfa.amsl.com>;
 Wed, 13 Dec 2023 16:12:42 -0800 (PST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 1C0FBC14F604
 for <bpf@ietf.org>; Wed, 13 Dec 2023 16:12:42 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3332efd75c9so6519056f8f.2
 for <bpf@ietf.org>; Wed, 13 Dec 2023 16:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702512760; x=1703117560; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AITTsgzKebJPE9iH4uhS3DRrLR8rSFHxKISxf0g6VbM=;
 b=Ih+zceMgmQX2xM6Z8LSKh05In8xKAr/hk1Yran+DzpO0b9TK3ur596076CtL7j97Ry
 S4cS2UwFAfaDmGNuv4o/w8IBdbhFUh6jy0EmDjbeQgPpqirL8nawHprq63GZgP2D+qp5
 KAfxLaOeA6QWBOa0OUwc8vvdONBqsdR04rN16odBOe5dpwA65Hi2PkX4ykxrhUdMtpqO
 zdcregKpRUHDgpNcg8tAKT5SEFG/Cvxyax753HgqGqQlLGfUAXGiP3WZu8fxmepqaseC
 G26e+PuDdGWrF2HxgsApeKZqFg3KfO2olF5rxaCCb2zLoED/QaGxWSOdxRlHkPWKc4eG
 yXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702512760; x=1703117560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AITTsgzKebJPE9iH4uhS3DRrLR8rSFHxKISxf0g6VbM=;
 b=XAMVpIPE0ZXGaGsbaEAnixiPGwZ//rRQ8umZGOrsk2ZHxH9eN+bBVkO6SMpRbVqdR+
 lOItV2sJVru285iEy5wUrnXJHALZKoqp4A7XbhhNx+dOIbABOSYnEGtnVHh6qCQx6NLt
 SUSlVS0BD6Xn1dqA9qEaAs4WzkByeq2QV/49BmJaODcPq64VObVDAlRpDMWoL2zRTHgc
 lCjSkeDRR/YgRNyiVPcIsrjwtCCz72Fb9pNNnh1Fm1j4QJmitf8Nb0jbdk/pY111JCI+
 KqPgB073Rzpz26WbSi3wgSaoPt3h8hA9z+OSf2H8hfdtSfCA0mlRygbAIcs1fvH7l7px
 1c4A==
X-Gm-Message-State: AOJu0Yz+FWjDgX+fn43RswP1p4MOv0ATxsh0nkXMUBiRDNg3NU3lEEyr
 TV9KbPxmILUAX4udp9GDlSgvs9wpGTcEOWtGevw=
X-Google-Smtp-Source: AGHT+IEXBiT9YVJZOOt/YR3L8JfnHSAhRTjZqCY5lNeuDZ8Rl84u5JwJzcTxjWfED8j45jL3OhW0/Ro+LyvDF5A3C6g=
X-Received: by 2002:adf:ec85:0:b0:336:424a:ebce with SMTP id
 z5-20020adfec85000000b00336424aebcemr332970wrn.274.1702512760209; Wed, 13 Dec
 2023 16:12:40 -0800 (PST)
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
 <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
 <20231213185603.GA1968@maniforge>
In-Reply-To: <20231213185603.GA1968@maniforge>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 Dec 2023 16:12:28 -0800
Message-ID: <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
To: David Vernet <void@manifault.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org,
 bpf <bpf@vger.kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@infradead.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/ZUQN6mKoAEJauQ9I9DV36Sav3xU>
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

T24gV2VkLCBEZWMgMTMsIDIwMjMgYXQgMTA6NTbigK9BTSBEYXZpZCBWZXJuZXQgPHZvaWRAbWFu
aWZhdWx0LmNvbT4gd3JvdGU6Cj4KPiBTb21ldGhpbmcgSSB3YW50IHRvIG1ha2Ugc3VyZSBpcyBj
bGVhcmx5IHNwZWxsZWQgb3V0OiBhcmUgeW91IG9mIHRoZQo+IG9waW5pb24gdGhhdCBhIHByb2dy
YW0gd3JpdHRlbiBmb3Igb2ZmbG9hZCB0byBhIE5ldHJvbm9tZSBkZXZpY2UgY2Fubm90Cj4gYW5k
IHNob3VsZCBub3QgZXZlciBiZSBhYmxlIHRvIHJ1biBvbiBhbnkgb3RoZXIgTklDIHdpdGggQlBG
IG9mZmxvYWQ/CgpJdCdzIGNlcnRhaW5seSBmaW5lIGZvciB2ZW5kb3JzIHRvIHRyeSB0byByZXBs
aWNhdGUgTmV0cm9ub21lIG9mZmxvYWQuClRoZSBwb2ludCBpcyB0aGF0IGl0IHdhcyBkb25lIGJl
Zm9yZSBhbnkgc3RhbmRhcmQgZXhpc3RlZC4KSWYgd2UgYWRkIGNvbXBsaWFuY2UgZ3JvdXBzIHRv
IHRoZSBzdGFuZGFyZCBub3cgdGhleSB3b24ndCBmaXQKbmV0cm9ub21lIGFuZCB3b24ndCBoZWxw
IGFueW9uZSB0cnlpbmcgdG8gYmUgY29tcGF0aWJsZSB3aXRoIGl0LgpTZWUgdGhlIHBvaW50IGFi
b3V0IGNvbXBhdGliaWxpdHkgd2l0aCAtbWNwdT12MyBhbmQgbm90IHYxLgoKPiBXaHkgZWxzZSB3
b3VsZCB0aGV5IGJlIGFza2luZyBmb3IgYSBzdGFuZGFyZCBpZiBub3QgdG8KPiBoYXZlIHNvbWUg
Z3VpZGVsaW5lcyBvZiB3aGF0IHRvIGltcGxlbWVudD8KCkV4Y2VsbGVudCBxdWVzdGlvbi4gSSBk
b24ndCBrbm93IHdoeSBudm1lIGZvbGtzIG5lZWQgYSBzdGFuZGFyZC4KTGFjayBvZiBzdGFuZGFy
ZCBkaWRuJ3Qgc3RvcCBuZXRyb25vbWUuCgo+Cj4gSG93IGRvIHdlIGtub3cgdGhlIHNlbWFudGlj
cyBvZiB0aGUgaW5zdHJ1Y3Rpb25zIHdvbid0IGJlIHByb2hpYml0aXZlbHkKPiBleHBlbnNpdmUg
b3IgaW1wcmFjdGljYWwgZm9yIGNlcnRhaW4gdmVuZG9ycz8gV2hhdCB2YWx1ZSBkbyB3ZSBnZXQg
b3V0Cj4gb2YgZGljdGF0aW5nIHNlbWFudGljcyBpbiB0aGUgc3RhbmRhcmQgaWYgd2UncmUgbm90
IGV4cGVjdGluZyBhbnkgb2YKPiB0aGVzZSBwcm9ncmFtcyB0byBiZSBjcm9zcy1jb21wYXRpYmxl
IGFueXdheXM/CgphbmQgdGhhdCdzIGEgcHJvYmxlbS4gaHcgZm9sa3MgYXJlIG5vdCBwYXJ0aWNp
cGF0aW5nIGluIHRoaXMgZGlzY3Vzc2lvbi4KV2l0aG91dCBpbXBsZW1lbnRlcnMgdGhlcmUgaXMg
bGl0dGxlIGNoYW5jZSB0byBoYXZlIHN1Y2Nlc3NmdWwgZ3VpZGVsaW5lcwpmb3IgY29tcGF0aWJp
bGl0eSBsZXZlbHMuCnBlci1pbnN0cnVjdGlvbiBjb21wYXRpYmlsaXR5IGlzIGFscmVhZHkgYWNj
b21wbGlzaGVkLgpXZSBkb24ndCBuZWVkIGdyb3VwcyBmb3IgdGhhdC4KCj4gPiAiSGVyZSBpcyBh
IHN0YW5kYXJkLiBHbyBpbXBsZW1lbnQgaXQiIHdvbid0IHdvcmsuCj4KPiBXaGF0IGlzIHRoZSBw
b2ludCBvZiBhIHN0YW5kYXJkIGlmIG5vdCB0byBzYXksICJIZXJlJ3Mgd2hhdCB5b3Ugc2hvdWxk
Cj4gZ28gaW1wbGVtZW50Ij8KClJlcGhyYXNpbmcuLi4gImdvIGltcGxlbWVudCBpdCBfYWxsXyIg
d29uJ3Qgd29yay4KVGhlIHN0YW5kYXJkIGhhcyB2YWx1ZSB3aXRob3V0IGluc24gZ3JvdXBzLgpF
dmVyeSBpbnN0cnVjdGlvbiBoYXMgc3BlY2lmaWMgbWVhbmluZyBhbmQgZW5jb2RpbmcuClRoYXQn
cyB3aGF0IGNvbXBhdGliaWxpdHkgaXMgYWJvdXQuIEJvdGggc3cgYW5kIGh3IG5lZWQgdG8KcGVy
Zm9ybSB0aGF0IG9wZXJhdGlvbi4KCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpo
dHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

