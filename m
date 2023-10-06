Return-Path: <bpf+bounces-11592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCBF7BC2CB
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 01:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F99282083
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 23:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA3345F74;
	Fri,  6 Oct 2023 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="VZ9KvLJs";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="VZ9KvLJs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfDDf330"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D66E44487
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 23:07:15 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C439393
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 16:07:13 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 66FD6C1519A5
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 16:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696633633; bh=b94Ief8lZNt1QmGNKn9D4NF1zPGT9fLMKcq0yDUOgxo=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=VZ9KvLJs+xg9VtJIEUOvaBhRkqr4GusJVt8YLET6t4F4OospsZdJNzeKirKmkPOZS
	 k8PiQ0I5gm73uT1NpAGeHxfdOxPDporG7hE6oxYE9c3SLy/XeiPWVzx65yU7x+UfWE
	 R2oB4EdtkpyKMnMj6KpwM0vnDeru3xc1hmBUYsMs=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Oct  6 16:07:13 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 31289C151094;
	Fri,  6 Oct 2023 16:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696633633; bh=b94Ief8lZNt1QmGNKn9D4NF1zPGT9fLMKcq0yDUOgxo=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=VZ9KvLJs+xg9VtJIEUOvaBhRkqr4GusJVt8YLET6t4F4OospsZdJNzeKirKmkPOZS
	 k8PiQ0I5gm73uT1NpAGeHxfdOxPDporG7hE6oxYE9c3SLy/XeiPWVzx65yU7x+UfWE
	 R2oB4EdtkpyKMnMj6KpwM0vnDeru3xc1hmBUYsMs=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 7FFCDC151094
 for <bpf@ietfa.amsl.com>; Fri,  6 Oct 2023 16:07:11 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.108
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PgsU_YYc4Yw1 for <bpf@ietfa.amsl.com>;
 Fri,  6 Oct 2023 16:07:07 -0700 (PDT)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 09F18C14CE54
 for <bpf@ietf.org>; Fri,  6 Oct 2023 16:07:07 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-406619b53caso24127275e9.1
 for <bpf@ietf.org>; Fri, 06 Oct 2023 16:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696633625; x=1697238425; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6IvT8HUUMWyErGis/DYt2jgKfgnESMJvheoFrfgEBGA=;
 b=CfDDf330pkCHuGb7O6RRU1IHqunohKNbyie4b+GXUFlk2NC+CKHtu0HLzIepOA7wxQ
 j4B+IdN/1R+MWrBODLCU2krXnAMY+ISJhMRb2VfQWs/QiEgcBLCAlqi76FlieYfVOzxg
 zevaFeTn8fb1ure79gZMrpmJ3oiEh9QsDUjxd7XIBmVU4iyzkvi5cCv3hQmQfKnuWRTS
 MwJlHfyOyd7LQ7qLdDZG0PTySoyO+0nv3iGMVLIK184s8ic/aMvlUEWOmohBS97EJNpc
 9o+JHfzEroyCCorvHtUUEosfMCQN99+FiCbE7OAdKV7ytUHUDRHu7QZV53AZHOuiE3hg
 wIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696633625; x=1697238425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6IvT8HUUMWyErGis/DYt2jgKfgnESMJvheoFrfgEBGA=;
 b=KHY1tLMh5POfN09XiTCEaPGDXvL/XetgMN/ccDaXAzGt/N7DTKr3KhLiP2gA+CaAvL
 iXaaIDasCbcQw0Hp/+ZlqJQW6o25XyRoZb+YYmhLAzs+bAntvf+Nn664XYurhnhIDoEO
 Uoh7AY9bxhG8BtTcFecGroy3W/c3lMJcOuH2VagWCtQtAF/Cw6pTtaJizPAQmpTUQEl6
 djZtx3UO9xGeixw0vqmgHJ5l8X3x5Ebr8AUW5qvoMGhNTZY4hqaXnntDquYHdEyiGkOf
 t89WauP7VFaoVzm6p9KcF4m0m6LQmb6VjV1XgIhQuAU5m06wgv3TcKOdED4Ft1mY+ZDQ
 PngA==
X-Gm-Message-State: AOJu0YxPwgAzkMwBoXyzymLRPCUoPFOEbblD9BgUfvji+hTKQAwFfjUx
 g3uDkH9AJZkVjv3IlHcNtQN6rQaxG6gLjImR7R8=
X-Google-Smtp-Source: AGHT+IFxxFDXENFsO3nDRIcNThd6pM9Q6AC2KQGdHxMCEjqyZIWvK4DABdZqTi7BsZ7iIa76lIT4zfV1wLyId76k+qc=
X-Received: by 2002:a7b:cd0a:0:b0:405:3dbc:8821 with SMTP id
 f10-20020a7bcd0a000000b004053dbc8821mr8395683wmj.22.1696633625036; Fri, 06
 Oct 2023 16:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <PH7PR21MB3878027C6E6FB01651023912A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQL69iqzxsNRDLKW22B=3sJpO0Yy2yHzioWZmhtQvUwtTQ@mail.gmail.com>
 <PH7PR21MB3878A25F817337EF14FE039FA3CAA@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB3878A25F817337EF14FE039FA3CAA@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Oct 2023 16:06:53 -0700
Message-ID: <CAADnVQ+BOdrU4x3qKHJVbpZCJwTWe6HXWhuMqOk-x5UK22yPDQ@mail.gmail.com>
To: Dave Thaler <dthaler@microsoft.com>
Cc: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/9ltmQm3Fdm9W6khYNxKC-ZWnvEM>
Subject: Re: [Bpf] ISA RFC compliance question
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
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gVGh1LCBPY3QgNSwgMjAyMyBhdCAxOjE04oCvUE0gRGF2ZSBUaGFsZXIgPGR0aGFsZXJAbWlj
cm9zb2Z0LmNvbT4gd3JvdGU6Cj4KPiA+IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YWxleGVpLnN0YXJv
dm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiBPbiBGcmksIFNlcCAyOSwgMjAyMyBhdCAxOjE3
4oCvUE0gRGF2ZSBUaGFsZXIKPiA+IDxkdGhhbGVyPTQwbWljcm9zb2Z0LmNvbUBkbWFyYy5pZXRm
Lm9yZz4gd3JvdGU6Cj4gPiA+IE5vdyB0aGF0IHdlIGhhdmUgc29tZSBuZXcgInY0IiBpbnN0cnVj
dGlvbnMsIGl0IHNlZW1zIGEgZ29vZCB0aW1lIHRvCj4gPiA+IGFzayBhYm91dCB3aGF0IGl0IG1l
YW5zIHRvIHN1cHBvcnQgKG9yIGNvbXBseSB3aXRoKSB0aGUgSVNBIFJGQyBvbmNlCj4gPiA+IHB1
Ymxpc2hlZC4gIERvZXMgaXQgbWVhbiB0aGF0IGEgdmVyaWZpZXIvZGlzYXNzZW1ibGVyL0pJVCBj
b21waWxlci9ldGMuIE1VU1QKPiA+IHN1cHBvcnQgKmFsbCogdGhlCj4gPiA+IG5vbi1kZXByZWNh
dGVkIGluc3RydWN0aW9ucyBpbiB0aGUgZG9jdW1lbnQ/ICAgVGhhdCBpcyBhbnkgcnVudGltZSBv
ciB0b29sIHRoYXQKPiA+ID4gZG9lc24ndCBzdXBwb3J0IHRoZSBuZXcgaW5zdHJ1Y3Rpb25zIGlz
IGNvbnNpZGVyZWQgbm9uLWNvbXBsaWFudCB3aXRoIHRoZSBCUEYKPiA+IElTQT8KPiBbLi4uXQo+
ID4gPiBPciBzaG91bGQgd2UgY3JlYXRlIHNvbWUgdGhpbmdzIHRoYXQgYXJlIFNIT1VMRHMsIG9y
IGZpbmVyIGdyYWluZWQKPiA+ID4gdW5pdHMgb2YgY29tcGxpYW5jZSBzbyBhcyB0byBub3QgZGVj
bGFyZSBleGlzdGluZyBkZXBsb3ltZW50cyBub24tY29tcGxpYW50Pwo+ID4KPiA+IEkgc3VzcGVj
dCAnbm9uLWNvbXBsaWFuY2UnIGxhYmVsIHdpbGwgY2F1c2UgYW4gdW5uZWNlc3NhcnkgYmFja2xh
c2gsIHNvIEkgd291bGQKPiA+IGdvIHdpdGggU0hPVUxEIHdvcmRpbmcuCj4KPiBZZWFoLCBidXQg
aWYgZWFjaCBpbnN0cnVjdGlvbiBpcyBhIHNlcGFyYXRlIFNIT1VMRCwgdGhlbiBhIHJ1bnRpbWUg
Y291bGQgKHNheSkKPiBzdXBwb3J0IG9uZSBhdG9taWMgaW5zdHJ1Y3Rpb24gYW5kIG5vdCBvdGhl
cnMuICBIYXZpbmcgdGhhdCBsZXZlbCBvZiBncmFudWxhcml0eQo+IHdvdWxkIHJlYWxseSBjb21w
bGljYXRlIGludGVyb3BlcmFiaWxpdHkgYW5kIGNyb3NzLXBsYXRmb3JtIHRvb2xpbmcgaW4gbXkg
b3Bpbmlvbi4KPiBTbyBpdCBtaWdodCBiZSBiZXR0ZXIgdG8gbGlzdCBncm91cHMgb2YgaW5zdHJ1
Y3Rpb25zIGFuZCBoYXZlIHRoZSBTSE9VTEQgYmUgYXQgdGhlCj4gZ3JhbnVsYXJpdHkgb2YgYSBn
cm91cD8KCkkgZ3Vlc3Mgd2UgY2FuIGdyb3VwIHRoZW0gYmFzZWQgb24gTExWTSBldm9sdXRpb24g
b2YgdGhlIGluc3RydWN0aW9uIHNldDoKLW1jcHU9djEsdjIsdjMsdjQKYnV0IGl0IHdvdWxkIGhh
dmUgbWFpbmx5IGhpc3RvcmljYWwgYmVuZWZpdHMgYW5kIG5vdCBwcmFjdGljYWwuCkdyb3VwaW5n
IGF0b21pYyB2cyBub3QgaXMgbm90IHJlYWxpc3RpYyBlaXRoZXIsIHNpbmNlIGF0b21pY194YWRk
CndhcyB0aGVyZSBzaW5jZSB0aGUgdmVyeSBiZWdpbm5pbmcuCkkgc3VzcGVjdCBhbnkga2luZCBv
ZiBncm91cGluZyBzY2hlbWUgd2lsbCBlbmQgdXAgaW4gYmlrZSBzaGVkZGluZy4KTXkgcHJlZmVy
ZW5jZSB3b3VsZCBiZSB0byBhZ3JlZSBvbiBlaXRoZXIgU0hPVUxEIG9yIE1VU1QgZm9yCmFsbCBp
bnNucyBjdXJyZW50bHkgZGVzY3JpYmVkIGluIElTQSBkb2MuCldlIGNhbiBnbyB3aXRoIE1VU1Qg
dG8gZm9yY2UgY29tcGxpYW5jZS4KU29tZSBhcmNocywgT1NlcywgSklUcyB3b24ndCBiZSBjb21w
bGlhbnQgaW4gdGhlIHNob3J0IHRlcm0sCmJ1dCBNVVNUIHdvcmRpbmcgd2lsbCBiZSBhIGdvb2Qg
bW90aXZhdGlvbiB0byBkbyB0aGUgd29yayBub3cgaW5zdGVhZCBvZiBsYXRlci4KCi0tIApCcGYg
bWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2JwZgo=

