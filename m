Return-Path: <bpf+bounces-7735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D35F77BDC8
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 18:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D802810B4
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0FFC8DE;
	Mon, 14 Aug 2023 16:18:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE1C139
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 16:18:12 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E1212E
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 09:18:10 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E5C44C1524AA
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 09:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1692029889; bh=S17/wgkhVhbmaAwKMyl/CTDhfRxkjtwPA3M17jwYZp8=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Mc6zsM5ycPMeVxkiuxxMzl47TX1jfmpJVsoQXSUANXDEKJDFmBXJDZ6boslf/MdKv
	 JdFqa8UZyJ1qp3lVsyeZUs0kVH7T6RrZCLP1etH65wT4QqZIOu0EoHBwGXtIfQkS6/
	 64F6ViTiW59FDeS0BmtgYsPao2svN6KcKvG27G3A=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Aug 14 09:18:09 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id AC317C151997;
	Mon, 14 Aug 2023 09:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1692029889; bh=S17/wgkhVhbmaAwKMyl/CTDhfRxkjtwPA3M17jwYZp8=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Mc6zsM5ycPMeVxkiuxxMzl47TX1jfmpJVsoQXSUANXDEKJDFmBXJDZ6boslf/MdKv
	 JdFqa8UZyJ1qp3lVsyeZUs0kVH7T6RrZCLP1etH65wT4QqZIOu0EoHBwGXtIfQkS6/
	 64F6ViTiW59FDeS0BmtgYsPao2svN6KcKvG27G3A=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 03DA5C1519B9
 for <bpf@ietfa.amsl.com>; Mon, 14 Aug 2023 09:18:08 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.407
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cONT9Qz5YU31 for <bpf@ietfa.amsl.com>;
 Mon, 14 Aug 2023 09:18:03 -0700 (PDT)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 59825C151997
 for <bpf@ietf.org>; Mon, 14 Aug 2023 09:18:03 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-64726360433so4178586d6.3
 for <bpf@ietf.org>; Mon, 14 Aug 2023 09:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692029882; x=1692634682;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S6pghZcCVmSXG7aFJ1PmYcrKWfTMAcd8O51fDjdEqXY=;
 b=SzNcy4t6erFB+xMxG22UXzI70x9hHcn5S9fOy1jXokPdc+tgZNDcyg3qWwftKxGl/p
 l/r1ECpDlNDN8baIIJIXDTZjpzRUhbvvQsiexFzm0D7K3Z5/wqrJwE5ip7eoJnQmHKz3
 SiakrY9rt7XUFT80ZrjWRDgwJc0r7CyZ7D63OK+OfbbT4Qqsgn1tLFYE3jKX0/WghUYL
 05/oOj1OMpfMs75X52ircACQR4qRqzDFtP/JUIL0kD2FmtSXMVUl4EHEna9PKyREZ1oZ
 rrOTobKuw2kzPLZ6IJ/TVAxCFL6PzhfyCRKhfN9fvfD1Eiyy0HDa0N8F3jgvge/dCxPb
 khXA==
X-Gm-Message-State: AOJu0YzFVsJKT5lIP8+DPJWsramGNYy4sl1hR/vsd+o00TPKRESN120w
 lxxzF4v/c57QzQdHl231B1E=
X-Google-Smtp-Source: AGHT+IEBm0gaVL+UiqRDA2jxrKxIJgbxCGHDXvwhJcVLqJGJkPjzn/riy+kyyz70ZvQwcD47zJUKSA==
X-Received: by 2002:a0c:e1d3:0:b0:641:8cb7:b089 with SMTP id
 v19-20020a0ce1d3000000b006418cb7b089mr10995856qvl.27.1692029882104; 
 Mon, 14 Aug 2023 09:18:02 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:93a1])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a0cf084000000b006301d31e315sm3479721qvk.10.2023.08.14.09.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 09:18:01 -0700 (PDT)
Date: Mon, 14 Aug 2023 11:17:59 -0500
From: David Vernet <void@manifault.com>
To: Watson Ladd <watsonbladd@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Dave Thaler <dthaler@microsoft.com>, Christoph Hellwig <hch@infradead.org>,
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Message-ID: <20230814161759.GF542801@maniforge>
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
 <CAADnVQ+O0CZQ1-5+dBiPWgZig3MVRX92PWPwNCrL7rG+4Xrbag@mail.gmail.com>
 <CACsn0cmvuGBKd3erDQKugygZfhT-Cu8xYBJ3hCETp6a-1HNbYw@mail.gmail.com>
 <20230811172116.GC542801@maniforge>
 <CACsn0cmbDGpj8R98=DF00-hhjAKph+kHofAs3LF=KKonFYZeuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACsn0cmbDGpj8R98=DF00-hhjAKph+kHofAs3LF=KKonFYZeuA@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/eqdpBRdQFYPaNY6rg-jPu8KTidc>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
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

T24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMDI6MzY6MDRQTSAtMDcwMCwgV2F0c29uIExhZGQgd3Jv
dGU6Cj4gRGVhciBEYXZpZCwKCkhpIFdhdHNvbiwKCj4gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3Ig
eW91ciBsZW5ndGh5IGFuZCBraW5kIGVtYWlsLiBJIGFncmVlIHRoYXQgd2UKCkFuZCB0aGFuayB5
b3UgZm9yIG9mZmVyaW5nIHlvdXIgdGltZSBhbmQgZXhwZXJ0aXNlIGFzIGEgcmV2aWV3ZXIgb2Yg
dGhlCmRvY3VtZW50LgoKPiBzaG91bGQgcHVudCBvbiBjb250ZW50aW91cyBwb2ludHMgYW5kIGFp
bSB0byBzdGFuZGFyZGl6ZSB3aGF0IGhhcwo+IGFscmVhZHkgYmVlbiBpbXBsZW1lbnRlZCBhY3Jv
c3MgYSB3aWRlIHJhbmdlIG9mIGltcGxlbWVudGF0aW9ucy4gTW9zdAo+IG9mIG15IGlzc3VlcyBh
cmUgd2l0aCB0aGUgZm9ybWF0IGFuZCBwcmVzZW50YXRpb24gb2YgdGhlIHRleHQsIGFuZCBJCj4g
dGhpbmsgdGhlIGNvbnRlbnQgY2hhbmdlcyBpdCB3b3VsZCB0YWtlIGFyZSBwcmV0dHkgbm9uY29u
dGVub3VzLiBJCgpBY2ssIHNvdW5kcyBnb29kLiBKdXN0IEZZSSwgSSByZWFsaXplIChhbmQgYXBw
cmVjaWF0ZSkgdGhhdCB5b3UgYXJlCmZ1bGZpbGxpbmcgeW91ciByb2xlIGFzIGEgcmV2aWV3ZXIs
IGFzIHlvdSBvZmZlcmVkIHRvIGRvIGF0IElFVEYxMTcuClRoYXQgc2FpZCwgZXZlbiBqdXN0IGFz
IGEgcmV2aWV3ZXIsIGl0IGNhbiBvZnRlbiBiZSBlYXNpZXIgdG8gZGlzY3Vzcwpwcm9wb3NlZCBj
aGFuZ2VzIGlmIHRoZXJlIGFyZSBhY2NvbXBhbnlpbmcgcGF0Y2hlcyB3aGljaCBpbGx1c3RyYXRl
IHlvdXIKaW50ZW50LiBGb3IgZXhhbXBsZSwgbW92aW5nIHRoZSBNYXBzIHNlY3Rpb24gZnVydGhl
ciB1cCB0aGUgZG9jdW1lbnQsCmV0Yy4gVGhpcyBpcyBub3Qgc3RyaWN0bHkgbmVjZXNzYXJ5LCBl
c3BlY2lhbGx5IGlmIHlvdSdyZSBqdXN0IHJldmlld2luZwp0aGUgZG9jdW1lbnQsIGJ1dCBJIGRv
IHRoaW5rIGl0IHdvdWxkIGhlbHAgdG8gZ3JvdW5kIHNvbWUgb2YgdGhlCmRpc2N1c3Npb25zLiBG
b3Igd2hhdCBpdCdzIHdvcnRoLCB0aGlzIGlzIG1vcmUgdGhlICJMaW51eCBrZXJuZWwgd2F5IiwK
YnV0IEknbSBub3Qgc3VyZSBpZiB0aGlzIGlzIHRoZSBub3JtIGZvciBJRVRGLgoKPiBkb24ndCBy
ZWFsbHkgaGF2ZSBhbnkgaW5zaWdodCBpbnRvIHdoYXQgdGhlIGNvbnRlbnQgc2hvdWxkIGJlLCBh
bmQgSSdtCj4gc3VyZSB0aGF0IGZvciB0aG9zZSB3aG8gbGl2ZSBhbmQgYnJlYXRoIEJQRiBldmVy
eSBkYXksIG11Y2ggb2Ygd2hhdCBJCj4gYW0gY29uZnVzZWQgYWJvdXQgaXMgaW5kZWVkIG9idmlv
dXMuCgpUaGVyZSBpcyBhIGRpZmZlcmVuY2UgYmV0d2VlbiBzb21ldGhpbmcgYmVpbmcgb2J2aW91
cyBhbmQgYmVpbmcgd2VsbApzcGVjaWZpZWQsIHNvIHlvdXIgcmV2aWV3IGlzIGFwcHJlY2lhdGVk
IGVpdGhlciB3YXkuCgo+IENvbmNyZXRlbHkgSSB0aGluayB0aGUgZm9sbG93aW5nIHdvdWxkIGhl
bHAgaW1wcm92ZSB0aGUKPiB1bmRlcnN0YW5kYWJpbGl0eSBvZiB0aGUgZG9jdW1lbnQ6Cj4gKiBB
ZnRlciB0aGUgcmVnaXN0ZXIgcGFyYWdyYXBoLCBkZXNjcmliZSB0aGUgbWVtb3J5LiBBcyBJIHVu
ZGVyc3RhbmQKCkp1c3QgRllJLCB3ZSBhcmUgZ29pbmcgdG8gYmUgbW92aW5nIHRoZSByZWdpc3Rl
ciBwYXJhZ3JhcGggdG8gYSBzZXBhcmF0ZQpBQkkgZG9jdW1lbnQsIGFzIGl0IHJlYWxseSBiZWxv
bmdzIGluIGFuIEFCSSAoSW5mb3JtYXRpb25hbCkgZG9jdW1lbnQKdGhhbiBhIFByb3Bvc2VkIFN0
YW5kYXJkIGZvciB0aGUgSVNBLgoKPiBpdCBpdCBpcyBhIDY0IGJpdCwgYnl0ZSBhZGRyZXNzZWQs
IGZsYXQgc3BhY2UsIGFuZCBtYXBzIGFyZSBqdXN0Cj4gc3BlY2lhbCByZWdpb25zIGluIGl0LiBN
YXliZSBJJ20gd3JvbmcuIFRoZXJlJ3Mgc29tZSBzdHVmZiBhYm91dCB0eXBlcwo+IGluIHRoZSBi
aWcgc3BhY2Ugb2YgaW5zdHJ1Y3Rpb25zIHRoYXQgbWF5YmUgbWFrZXMgbWUgdGhpbmsgSSBhbSB3
cm9uZy4KCkkgdGhpbmsgaXQncyBPSyB0byBzcGVjaWZ5IHRoYXQgaXQncyBhIDY0IGJpdCwgYnl0
ZSBhZGRyZXNzZWQgZmxhdApzcGFjZSwgc28gZm9sa3MgY2FuIGZlZWwgZnJlZSB0byBzdWJtaXQg
YSBwYXRjaCB0byB0aGF0IGVmZmVjdC4gTXkgb25seQp3b3JyeSBpcyB0aGF0IGl0IG1heSBzZXQg
YSBwcmVjZWRlbnQgdGhhdCB3ZSdsbCBoYXZlIHRvIGV4cGxhaW4gYSBsb3Qgb2YKb3RoZXIgYXJj
aGl0ZWN0dXJhbCBkZXRhaWxzIGluIHRoZSBJU0Egc3RhbmRhcmQsIHdoZXJlIHRoZXkgZG9uJ3Qg
cmVhbGx5CmJlbG9uZy4gVGFrZSBhIGxvb2sgYXQgaG93IEFSTSBbMF0gZG9lcyB0aGlzLCBmb3Ig
ZXhhbXBsZS4gVGhlcmUgaXMgYW4KZW50aXJlbHkgc2VwYXJhdGUgZG9jdW1lbnQgWzFdIG9uIHRo
ZSBBQXJjaDY0IG1lbW9yeSBtb2RlbCwgYW5kIGZvciBnb29kCnJlYXNvbi4gSXQgZGVzY3JpYmVz
IHRoZSBoaWVyYXJjaGljYWwgbW9kZWwgb2YgcGFnZSB0YWJsZXMgb24gQVJNLCB3aGF0CnRoZSBt
ZW1vcnkgbW9kZWwgaXMgd2hlbiB0aGVyZSdzIG5vIE1NVSwgaG93IGRldmljZSBtZW1vcnkgd29y
a3MsIGV0Yy4KClswXTogaHR0cHM6Ly93d3cuYXJtLmNvbS9hcmNoaXRlY3R1cmUvbGVhcm4tdGhl
LWFyY2hpdGVjdHVyZS9hLXByb2ZpbGUKWzFdOiBodHRwczovL2RldmVsb3Blci5hcm0uY29tL2Rv
Y3VtZW50YXRpb24vMTAyMzc2L2xhdGVzdC8KClNvIHdoaWxlIEkgZG9uJ3QgZGlzYWdyZWUgdGhh
dCBpdCBzaG91bGQgYmUgbm9uLWNvbnRyb3ZlcnNpYWwgYW5kIHdvdWxkCmhlbHAgY2xhcmlmeSB0
aGUgcHJvZ3JhbW1pbmcgZW52aXJvbm1lbnQgZm9yIHRoZSBpbnN0cnVjdGlvbnMsIEkgd2FudCB0
bwptYWtlIHN1cmUgdGhhdCBmb2xrcyBhcmUgT0sgd2l0aCB1cyBhZGRpbmcgdGhpcywgYnV0IG5v
dCBuZWNlc3NhcmlseQpleHBvdW5kaW5nIG9uIGFsbCBvZiB0aGUgZGV0YWlscyBhbmQgaW1wbGlj
YXRpb25zLiBIb3BlZnVsbHkgdGhpcyBzaG91bGQKYmUgZmluZSwgYXMgaXQncyBiZWVuIHRoZSBu
b3JtIGZvciBvdGhlciBJU0FzIChlLmcuIFJJU0MtVikgYXMgd2VsbC4KCkZXSVcsIEkgdGhpbmsg
dGhpcyBhcHBsaWVzIHRvIG1hcHMgYXMgd2VsbC4gSXQncyBkZWZpbml0ZWx5IHNvbWV0aGluZyB3
ZQpuZWVkIHRvIGV4cGFuZCBvbiBhdCBzb21lIHBvaW50LCBidXQgdGhlIHBvc3NpYmlsaXR5IGZv
ciBzY29wZSBjcmVlcCBpcwpoaWdoLgoKVGhpcyBpcyB3aGF0J3MgdGhlcmUgbm93OgoKPiA9PT09
PT09PT09PT09PT09PT09PT09PT09ICA9PT09PT0gID09PSAgPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0gID09PT09PT09PT09ICA9PT09PT09PT09PT09PQo+IG9wY29k
ZSBjb25zdHJ1Y3Rpb24gICAgICAgIG9wY29kZSAgc3JjICBwc2V1ZG9jb2RlICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaW1tIHR5cGUgICAgIGRzdCB0eXBlCj4gPT09PT09PT09PT09
PT09PT09PT09PT09PSAgPT09PT09ICA9PT0gID09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09ICA9PT09PT09PT09PSAgPT09PT09PT09PT09PT0KPiBCUEZfSU1NIHwgQlBG
X0RXIHwgQlBGX0xEICAweDE4ICAgIDB4MCAgZHN0ID0gaW1tNjQgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGludGVnZXIgICAgICBpbnRlZ2VyCj4gQlBGX0lNTSB8IEJQRl9EVyB8IEJQ
Rl9MRCAgMHgxOCAgICAweDEgIGRzdCA9IG1hcF9ieV9mZChpbW0pICAgICAgICAgICAgICAgICAg
ICAgICBtYXAgZmQgICAgICAgbWFwCj4gQlBGX0lNTSB8IEJQRl9EVyB8IEJQRl9MRCAgMHgxOCAg
ICAweDIgIGRzdCA9IG1hcF92YWwobWFwX2J5X2ZkKGltbSkpICsgbmV4dF9pbW0gICBtYXAgZmQg
ICAgICAgZGF0YSBwb2ludGVyCj4gQlBGX0lNTSB8IEJQRl9EVyB8IEJQRl9MRCAgMHgxOCAgICAw
eDMgIGRzdCA9IHZhcl9hZGRyKGltbSkgICAgICAgICAgICAgICAgICAgICAgICB2YXJpYWJsZSBp
ZCAgZGF0YSBwb2ludGVyCj4gQlBGX0lNTSB8IEJQRl9EVyB8IEJQRl9MRCAgMHgxOCAgICAweDQg
IGRzdCA9IGNvZGVfYWRkcihpbW0pICAgICAgICAgICAgICAgICAgICAgICBpbnRlZ2VyICAgICAg
Y29kZSBwb2ludGVyCj4gQlBGX0lNTSB8IEJQRl9EVyB8IEJQRl9MRCAgMHgxOCAgICAweDUgIGRz
dCA9IG1hcF9ieV9pZHgoaW1tKSAgICAgICAgICAgICAgICAgICAgICBtYXAgaW5kZXggICAgbWFw
Cj4gQlBGX0lNTSB8IEJQRl9EVyB8IEJQRl9MRCAgMHgxOCAgICAweDYgIGRzdCA9IG1hcF92YWwo
bWFwX2J5X2lkeChpbW0pKSArIG5leHRfaW1tICBtYXAgaW5kZXggICAgZGF0YSBwb2ludGVyCj4g
PT09PT09PT09PT09PT09PT09PT09PT09PSAgPT09PT09ICA9PT0gID09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09ICA9PT09PT09PT09PSAgPT09PT09PT09PT09PT0KPgo+
IHdoZXJlCj4KPiAqIG1hcF9ieV9mZChpbW0pIG1lYW5zIHRvIGNvbnZlcnQgYSAzMi1iaXQgZmls
ZSBkZXNjcmlwdG9yIGludG8gYW4gYWRkcmVzcyBvZiBhIG1hcCAoc2VlIGBNYXBzYF8pCj4gKiBt
YXBfYnlfaWR4KGltbSkgbWVhbnMgdG8gY29udmVydCBhIDMyLWJpdCBpbmRleCBpbnRvIGFuIGFk
ZHJlc3Mgb2YgYSBtYXAKPiAqIG1hcF92YWwobWFwKSBnZXRzIHRoZSBhZGRyZXNzIG9mIHRoZSBm
aXJzdCB2YWx1ZSBpbiBhIGdpdmVuIG1hcAo+ICogdmFyX2FkZHIoaW1tKSBnZXRzIHRoZSBhZGRy
ZXNzIG9mIGEgcGxhdGZvcm0gdmFyaWFibGUgKHNlZSBgUGxhdGZvcm0gVmFyaWFibGVzYF8pIHdp
dGggYSBnaXZlbiBpZAo+ICogY29kZV9hZGRyKGltbSkgZ2V0cyB0aGUgYWRkcmVzcyBvZiB0aGUg
aW5zdHJ1Y3Rpb24gYXQgYSBzcGVjaWZpZWQgcmVsYXRpdmUgb2Zmc2V0IGluIG51bWJlciBvZiAo
NjQtYml0KSBpbnN0cnVjdGlvbnMKPiAqIHRoZSAnaW1tIHR5cGUnIGNhbiBiZSB1c2VkIGJ5IGRp
c2Fzc2VtYmxlcnMgZm9yIGRpc3BsYXkKPiAqIHRoZSAnZHN0IHR5cGUnIGNhbiBiZSB1c2VkIGZv
ciB2ZXJpZmljYXRpb24gYW5kIEpJVCBjb21waWxhdGlvbiBwdXJwb3Nlcwo+Cj4gTWFwcwo+IH5+
fn4KPgo+IE1hcHMgYXJlIHNoYXJlZCBtZW1vcnkgcmVnaW9ucyBhY2Nlc3NpYmxlIGJ5IGVCUEYg
cHJvZ3JhbXMgb24gc29tZQo+IHBsYXRmb3Jtcy4gQSBtYXAgY2FuIGhhdmUgdmFyaW91cyBzZW1h
bnRpY3MgYXMgZGVmaW5lZCBpbiBhIHNlcGFyYXRlCj4gZG9jdW1lbnQsIGFuZCBtYXkgb3IgbWF5
IG5vdCBoYXZlIGEgc2luZ2xlIGNvbnRpZ3VvdXMgbWVtb3J5IHJlZ2lvbiwKPiBidXQgdGhlICdt
YXBfdmFsKG1hcCknIGlzIGN1cnJlbnRseSBvbmx5IGRlZmluZWQgZm9yIG1hcHMgdGhhdCBkbyBo
YXZlCj4gYSBzaW5nbGUgY29udGlndW91cyBtZW1vcnkgcmVnaW9uLgoKVGhlcmUgYXJlIGEgbG90
IG9mIGNhdmVhdHMgaGVyZSBhYm91dCB0aGUgc2VtYW50aWNzIG9mIG1hcHMsIHdoZXRoZXIKdGhl
eSBkbyBvciBkb24ndCBoYXZlIGEgY29udGlndW91cyBtZW1vcnkgcmVnaW9uLCBldGMuIFRoZXJl
IGxpa2VseQppc24ndCBhIHNpbmdsZSBkZWZpbml0aW9uIG9mIGEgIm1hcCBtZW1vcnkgcmVnaW9u
IiB0aGF0IHdpbGwgYXBwbHkgdG8KYWxsIG1hcHMuIEZvciBleGFtcGxlLCB0aGVyZSBpcyBhIEJQ
Rl9NQVBfVFlQRV9QRVJDUFVfQVJSQVkgbWFwLCB3aGljaAppbiBjb250cmFzdCB3aXRoIEJQRl9N
QVBfVFlQRV9BUlJBWSwgbmVlZCBub3QgYmUgYSBjb250aWd1b3VzIG1lbW9yeQpyZWdpb24gYW5k
IGNvdWxkIGluc3RlYWQgbGV2ZXJhZ2UgaG93ZXZlciBwZXJjcHUgbWVtb3J5IGlzIGltcGxlbWVu
dGVkCm9uIHRoZSBwbGF0Zm9ybS4gSW4gbXkgcGVyc29uYWwgb3Bpbmlvbiwgd2hhdCBEYXZlIHdy
b3RlIGhlcmUgaXMgcmF0aGVyCmlkZWFsIGluIHRoYXQgaXQncyBnaXZpbmcgdGhlIHJlYWRlciBz
b21lIGNvbnRleHQgb24gd2hhdCBtYXBzIGFyZSwKd2l0aG91dCBvdmVyIHByZXNjcmliaW5nIHRo
ZW0uIFdpdGggdGhhdCBpbiBtaW5kLCBhcmUgeW91IG9rIHdpdGgKbGVhdmluZyB0aGUgbWFwcyBz
ZWN0aW9uIGFzIGlzIChtb2R1bG8gbW92aW5nIGl0IGFzIHlvdSBzdWdnZXN0ZWQKYmVsb3cpLCB3
aXRoIHRoZSBpbnRlbnRpb24gYmVpbmcgdGhhdCB3ZSdsbCBmaWxsIGluIHRoZSBkZXRhaWxzIG9u
IHRoZQp2YXJpb3VzIHR5cGVzIG9mIGNyb3NzLXBsYXRmb3JtIG1hcHMgd2hlbiB3ZSB3cml0ZSB0
aGUgcHJvcG9zZWQgc3RhbmRhcmQKb24gY3Jvc3MtcGxhdGZvcm0gbWFwIHR5cGVzPwoKPiAqIFNh
eSB0aGlzIGlzIGEgMidzIGNvbXBsZW1lbnQgYXJjaGl0ZWN0dXJlCgpIbW1tLCBzbywgSSByZWFs
aXplIHRoYXQgb3RoZXJzIGhhdmUgc3VnZ2VzdGVkIHRoaXMgYXMgd2VsbCAoZS5nLiBXaWxsCnBv
aW50ZWQgb3V0IGluIFsyXSB0aGF0IGhlIGFncmVlcyB0aGF0IHdlIHNob3VsZCBpbmNsdWRlIHRo
aXMpLCBidXQgdG8KYmUgaG9uZXN0IEknbSBzdGlsbCBub3QgcXVpdGUgZm9sbG93aW5nIHdoeSB0
aGlzIGlzIHNvbWV0aGluZyB0aGF0IGZvbGtzCmZlZWwgc2hvdWxkIGJlIGluY2x1ZGVkLgoKWzJd
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FEeDlxV2lKQ1F5TGR6NXJHMzNLMmlXdHNn
WFE2NUszYWl3UWlFc2pTd1kyb2ZOeTFRQG1haWwuZ21haWwuY29tLwoKVGhlIFJJU0MtViBzdGFu
ZGFyZCBkb2VzIGluZGVlZCBzcGVjaWZ5IHRoYXQgc2lnbmVkIHR5cGVzIGFyZQpyZXByZXNlbnRl
ZCB3aXRoIHR3bydzIGNvbXBsZW1lbnQsIGJ1dCBhcyBmYXIgYXMgSSBrbm93IHRoYXQgaXMgdGhl
CmV4Y2VwdGlvbiByYXRoZXIgdGhhbiB0aGUgcnVsZS4gQXMgSm9zZSBleHBsYWluZWQgaW4gWzNd
LCBpdCdzIG1vcmUKY29tbW9uIGZvciBJU0Egc3BlY2lmaWNhdGlvbnMgdG8gc3BlY2lmeSBob3cg
bnVtZXJpY2FsIGltbWVkaWF0ZXMgYXJlCmVuY29kZWQgaW4gc3RvcmVkIGluc3RydWN0aW9ucyBy
YXRoZXIgdGhhbiBkaWN0YXRpbmcgaG93IHNpZ25lZG5lc3MgaXMKcmVwcmVzZW50ZWQgYWNyb3Nz
IHRoZSBlbnRpcmUgYXJjaGl0ZWN0dXJlLgoKWzNdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9i
cGYvODcxcWhlN2Rlcy5mc2ZAZ251Lm9yZwoKVGhlIEFSTTY0IElTQSBbNF0gYWxpZ25zIHdpdGgg
d2hhdCBKb3NlIHNhaWQgYXMgd2VsbC4gVGhlIEludGVsIGFuZCBBTUQKeDg2XzY0IElTQXMgc3Bl
Y2lmeSB0aGF0IGNlcnRhaW4gaW5zdHJ1Y3Rpb25zIHBlcmZvcm0gdHdvJ3MtY29tcGxlbWVudApu
ZWdhdGlvbiwgYnV0IGFzIGZhciBhcyBJIGtub3cgdGhleSBkb24ndCBkaWN0YXRlIHRoZSB0eXBl
IHNlbWFudGljcyBmb3IKdGhlIGVudGlyZSBhcmNoaXRlY3R1cmUuCgpbNF06IGh0dHBzOi8vZGV2
ZWxvcGVyLmFybS5jb20vZG9jdW1lbnRhdGlvbi9kZGkwNjAyL2xhdGVzdAoKVGhlIHJlYXNvbiB0
aGF0IEkgdGhpbmsgaXQgbWF5IGJlIHBydWRlbnQgdG8gbGVhdmUgdGhpcyBvZmYgaXMgdGhhdCBJ
CmRvbid0IHRoaW5rIHdlIHJlYWxseSBnYWluIGFueXRoaW5nIGJ5IHNwZWNpZnlpbmcgaXQuIEkg
ZXhwZWN0IHRoYXQKd2UnbGwgaW5jbHVkZSB0aGlzIGluIHRoZSBwc0FCSSBkb2N1bWVudCwgYnV0
IGl0IHNlZW1zIHVubmVjZXNzYXJpbHkKY29uc3RyYWluaW5nIHRvIGRpY3RhdGUgdHdvJ3MgY29t
cGxlbWVudCBpbiB0aGUgUFMgX0lTQSBkb2N1bWVudF8uIEF0CnRoZSBlbmQgb2YgdGhlIGRheSBJ
IGV4cGVjdCBvdXIgZ29hbCB3aWxsIGJlIHNvdXJjZS1jb2RlIGNvbXBhdGliaWxpdHkKcmF0aGVy
IHRoYW4gYmluYXJ5IGNvbXBhdGliaWxpdHksIGFuZCB3aGlsZSBpdCdzIGVudGlyZWx5IHBvc3Np
YmxlIHRoYXQKd2UnbGwgbmV2ZXIgc2VlIGl0LCBJIHRoaW5rIGl0IHdvdWxkIGJlIHBydWRlbnQg
dG8gZ2l2ZSBwbGF0Zm9ybXMgdGhlCmZsZXhpYmlsaXR5IHRvIGltcGxlbWVudCBzaWduZWRuZXNz
IGluIG90aGVyIHdheXMgaWYgdGhleSBoYXZlIGEgcmVhc29uCnRvIGRvIHNvLgoKQ2FzZSBpbiBw
b2ludCwgd2hpbGUgaXQncyBub3QgYW4gSVNBIHN0YW5kYXJkLCBzZWN0aW9uIDYuMi42CigiUmVw
cmVzZW50YXRpb25zIG9mIHR5cGVzIikgb2YgdGhlIEMgc3RhbmRhcmQgc3BlY2lmaWVzIHRoZSBm
b2xsb3dpbmc6Cgo+IDEgVGhlIHJlcHJlc2VudGF0aW9ucyBvZiBhbGwgdHlwZXMgYXJlIHVuc3Bl
Y2lmaWVkIGV4Y2VwdCBhcyBzdGF0ZWQgaW4gdGhpcyBzdWJjbGF1c2UuCj4gMiBFeGNlcHQgZm9y
IGJpdC1maWVsZHMsIG9iamVjdHMgYXJlIGNvbXBvc2VkIG9mIGNvbnRpZ3VvdXMgc2VxdWVuY2Vz
IG9mIG9uZSBvciBtb3JlIGJ5dGVzLCB0aGUgbnVtYmVyLAo+IG9yZGVyLCBhbmQgZW5jb2Rpbmcg
b2Ygd2hpY2ggYXJlIGVpdGhlciBleHBsaWNpdGx5IHNwZWNpZmllZCBvciBpbXBsZW1lbnRhdGlv
bi1kZWZpbmVkLgo+IC4uLgo+IEZvciBzaWduZWQgaW50ZWdlciB0eXBlcywgdGhlIGJpdHMgb2Yg
dGhlIG9iamVjdCByZXByZXNlbnRhdGlvbiBzaGFsbCBiZSBkaXZpZGVkIGludG8gdGhyZWUgZ3Jv
dXBzOgo+IHZhbHVlIGJpdHMsIHBhZGRpbmcgYml0cywgYW5kIHRoZSBzaWduIGJpdC4gVGhlcmUg
bmVlZCBub3QgYmUgYW55IHBhZGRpbmcgYml0czsgc2lnbmVkIGNoYXIgc2hhbGwKPiBub3QgaGF2
ZSBhbnkgcGFkZGluZyBiaXRzLiBUaGVyZSBzaGFsbCBiZSBleGFjdGx5IG9uZSBzaWduIGJpdC4g
RWFjaCBiaXQgdGhhdCBpcyBhIHZhbHVlIGJpdCBzaGFsbCBoYXZlCj4gdGhlIHNhbWUgdmFsdWUg
YXMgdGhlIHNhbWUgYml0IGluIHRoZSBvYmplY3QgcmVwcmVzZW50YXRpb24gb2YgdGhlIGNvcnJl
c3BvbmRpbmcgdW5zaWduZWQgdHlwZSAoaWYKPiB0aGVyZSBhcmUgTSB2YWx1ZSBiaXRzIGluIHRo
ZSBzaWduZWQgdHlwZSBhbmQgTiBpbiB0aGUgdW5zaWduZWQgdHlwZSwgdGhlbiBNIDw9IE4pLiBJ
ZiB0aGUgc2lnbiBiaXQgaXMKPiB6ZXJvLCBpdCBzaGFsbCBub3QgYWZmZWN0IHRoZSByZXN1bHRp
bmcgdmFsdWUuIElmIHRoZSBzaWduIGJpdCBpcyBvbmUsIHRoZSB2YWx1ZSBzaGFsbCBiZSBtb2Rp
ZmllZCBpbgo+IG9uZSBvZiB0aGUgZm9sbG93aW5nIHdheXM6Cj4KPiDigJQgdGhlIGNvcnJlc3Bv
bmRpbmcgdmFsdWUgd2l0aCBzaWduIGJpdCAwIGlzIG5lZ2F0ZWQgKHNpZ24gYW5kIG1hZ25pdHVk
ZSk7Cj4g4oCUIHRoZSBzaWduIGJpdCBoYXMgdGhlIHZhbHVlIOKIkigyTSkgKHR3bydzIGNvbXBs
ZW1lbnQpOwo+IOKAlCB0aGUgc2lnbiBiaXQgaGFzIHRoZSB2YWx1ZSDiiJIoMk0g4oiSIDEpIChv
bmVzJyBjb21wbGVtZW50KS4KCkluIG15IG9waW5pb24sIHRoZSBpbnRlbnRpb24gb2YgdGhlIHN0
YW5kYXJkIHRvIG5vdCBvdmVyLXNwZWNpZnkgc2hvdWxkCmFwcGx5IGhlcmUgYXMgd2VsbC4KCj4g
KiBJIGZpbmFsbHkgdW5kZXJzdGFuZCB3aHkgdGhlIGNvZGUgZmllbGRzIGhhdmUgdGhlaXIgbG93
IG55YmJsZSB6ZXJvLgo+IFdlIHNob3VsZCBtYXliZSBzYXkgdGhpcy4KCkhtbW0sIHNvcnJ5LCBJ
J20gbm90IHF1aXRlIGZvbGxvd2luZyB0aGlzIHBhcnQuIENvdWxkIHlvdSBwbGVhc2UgY2xhcmlm
eQp3aGljaCBlbmNvZGluZyAvIHNlY3Rpb24geW91J3JlIHJlZmVycmluZyB0byBzcGVjaWZpY2Fs
bHk/Cgo+ICogRXhwbGljaXRseSBjYWxsIG91dCBhZnRlciA1LjIgdGhhdCB0aGVyZSBpcyBubyBt
ZW1vcnkgbW9kZWwgeWV0CgpJJ20gbm90IGZ1bmRhbWVudGFsbHkgb3Bwb3NlZCB0byB0aGlzLCB0
aG91Z2ggSSdsbCBzaGFyZSBteSBzdWJqZWN0aXZlCm9waW5pb24gdGhhdCBzcGVjaWZ5aW5nIHRo
ZSBhYnNlbmNlIG9mIHNvbWV0aGluZyBzZWVtcyB1bm5lY2Vzc2FyeSBmb3IgYQpzdGFuZGFyZC4g
SXQgc2VlbXMgbGlrZSBpdCB3b3VsZCBmaXQgYmV0dGVyIGluIGFuIEluZm9ybWF0aW9uYWwKZG9j
dW1lbnQ/IE5vdCBzdXJlLgoKPiAqIFB1bGwgdXAgc2VjdGlvbiA1LjMuMSB0byB0aGUgdG9wLCBv
ciBmaWd1cmUgb3V0IHNvbWUgd2F5IHRvIHB1bnQgaXQKPiB0byBhbiBleHRlbnNpb24uIE1heWJl
IGludHJvZHVjZSBtYXBzIHVwIHRvcCB0aGVuIGV4cGxhaW4gaG93IHRoZXkgYXJlCj4gaW5kZXhl
ZCBoZXJlLgoKSSdtIGZpbmUgd2l0aCB0aGlzIGJlIHJld29ya2VkIGlmIHlvdSB0aGluayBpdCB3
b3VsZCBjbGFyaWZ5IHRoaW5ncy4KUGxlYXNlIGZlZWwgZnJlZSB0byBzdWJtaXQgcGF0Y2hlcyB0
aGF0IHJlZm9ybWF0cyBpbiBhIHdheSB0aGF0IHlvdQp0aGluayBpcyBjbGVhcmVyLiBPciBXaWxs
LCBvciBzb21lb25lIGVsc2UsIGV0YyA6LSkKCj4gRm9yIGV4dGVuc2lvbnMgaWYgSSB0aGluayBJ
IHVuZGVyc3RhbmQgdGhlIGNvbnZlcnNhdGlvbiBhdCBJRVRGIDExNywKPiBpdCdzIGVhc3kgdG8g
YWRkIG1vcmUgY2FsbHMgdG8gdGhlIGhvc3Qgc3lzdGVtIGFzIGZ1bmN0aW9ucy4gSXQncyBhCgpJ
J2xsIGdpdmUgYSBiaXQgb2YgYmFja2dyb3VuZCBoZXJlIG9uIHRoZSBMaW51eCBzaWRlLiBJdCdz
IGVhc3kgdG8gYWRkCndoYXQgd2UgY2FsbCBrZnVuY3MgWzVdLCB3aGljaCBhcmUgaG9zdC1zeXN0
ZW0gLyBtYWluLWtlcm5lbCBmdW5jdGlvbnMKdGhhdCBjYW4gYmUgY2FsbGVkIGZyb20gQlBGLiBU
aGVzZSBoYXZlIG5vIFVBUEkgZ3VhcmFudGVlcywgc28gd2UgY2FuCnNhZmVseSBhZGQgdGhlbSB3
aXRob3V0IGhhdmluZyB0byB3b3JyeSBhYm91dCBzdXBwb3J0aW5nIHRoZW0gZm9yZXZlciAvCmlu
ZGVmaW5pdGVseS4gSW4gY29udHJhc3QsIHdlIG5vIGxvbmdlciBhZGQgWzZdIGhlbHBlciBmdW5j
dGlvbnMgYmVjYXVzZQp0aGV5IGRvIGNvbWUgd2l0aCBVQVBJIHJlcXVpcmVtZW50cywgYW5kIHRo
dXMgd2l0aCBtdWNoIG1vcmUgc2lnbmlmaWNhbnQKcG90ZW50aWFsIGxvbmctdGVybSBvdmVyaGVh
ZC4KCls1XTogaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvYnBmL2tmdW5j
cy5odG1sCls2XTogaHR0cHM6Ly9tYW43Lm9yZy9saW51eC9tYW4tcGFnZXMvbWFuNy9icGYtaGVs
cGVycy43Lmh0bWwKCk1vcmUgb24gdGhpcyBiZWxvdy4KCj4gbG90IG1vcmUgb2YgYSBkaWZmaWN1
bHR5IHRvIGFkZCBtb3JlIGluc3RydWN0aW9ucywgYnV0IGluIHRoZSB3aWRlCj4gZW5jb2Rpbmcg
c3BhY2UgdGhlcmUgaXMgcm9vbS4gV2UgY291bGQgZGVmaW5pdGVseSBzYXkgdGhhdC4gVGhlIG1l
bW9yeQoKVG8gdGhlIHBvaW50IGFib3ZlIGFib3V0IGhlbHBlcnMgdnMuIGtmdW5jcywgSSB0aGlu
ayB0aGVyZSdzIGEKbm9udHJpdmlhbCBhbW91bnQgb2Ygc3VidGxldHkgd2UnbGwgaGF2ZSB0byBj
YXB0dXJlLiBBbmQgYXQgdGhlIHJpc2sgb2YKYmVpbmcgYSBicm9rZW4gcmVjb3JkLCBJIGRvbid0
IHRoaW5rIHdlIG5lY2Vzc2FyaWx5IHdhbnQgdG8gdHJ5IGFuZApjYXB0dXJlIGFsbCBvZiB0aGUg
bnVhbmNlcyBvZiB0aGUgZGlmZmljdWx0eSBpbiBhZGRpbmcgaW5zdHJ1Y3Rpb25zLApjZXJ0YWlu
IHR5cGVzIG9mIGhvc3Qtc3lzdGVtIGZ1bmN0aW9ucywgZXRjLCBpbiB0aGUgSVNBIGRvY3VtZW50
LiBXaGF0IEkKZmVlbCBkb2VzIGJlbG9uZyBpbiB0aGUgSVNBIGRvY3VtZW50IHdvdWxkIGJlIGEg
dmVyeSBjbGVhciBwcmVzY3JpcHRpb24KZm9yIGhvdyB0aGUgSVNBIGNhbiBiZSBfZXh0ZW5kZWRf
LiBUaGUgZGlmZmljdWx0eSBpbiBleHRlbmRpbmcgdGhlIElTQQpzaG91bGQgaG9wZWZ1bGx5IGJl
IHNlbGYtZXZpZGVudCBmcm9tIHRoYXQuCgpJbiBjb250cmFzdCwgdGhlIFtJXSBhcmNoaXRlY3R1
cmUgYW5kIGZyYW1ld29yayBkb2N1bWVudCBzZWVtcyBsaWtlIGEKbW9yZSBhcHByb3ByaWF0ZSBw
bGFjZSB0byBnbyBpbnRvIGRldGFpbHMgb24gcGxhdGZvcm0tc3BlY2lmaWMKaG9zdC1zeXN0ZW0g
ZnVuY3Rpb25zIHZzLiBoZWxwZXJzLCBldGMuIFdlIGFsc28gaGF2ZSBwbGFucyB0byBpbXBsZW1l
bnQKYW5vdGhlciBwcm9wb3NlZCBzdGFuZGFyZCBvbiB0aGUgY3Jvc3MtcGxhdGZvcm0gaGVscGVy
IGZ1bmN0aW9uczoKCiogW1BTXSBjcm9zcy1wbGF0Zm9ybSBoZWxwZXIgZnVuY3Rpb25zLCBlLmcu
LCBmb3IgbWFuaXB1bGF0aW9uIG9mIG1hcHMsCgphbmQgSSdtIHN1cmUgd2UnbGwgYWxzbyBkZXNj
cmliZSBob3cgdGhhdCBQUyBjYW4gYmUgZXh0ZW5kZWQgaW4gdGhhdApkb2N1bWVudC4KClBsZWFz
ZSBsZXQgbWUga25vdyBpZiBJJ3ZlIG1pc3VuZGVyc3Rvb2QgeW91ciBzdWdnZXN0aW9uLgoKPiBt
b2RlbCBzaG91bGQgb25seSBtb2RpZnkgdGhlIGJlaGF2aW9yIG9mIGVudmlyb25tZW50cyB3aXRo
IHJhY2VzLCBzbwo+IGlmIHRoaW5ncyBhcmVuJ3QgcmFjeSwgbm90aGluZyBjaGFuZ2VzLiBUaGF0
IHNob3VsZCB3b3JrLCBidXQgbWF5YmUgSQoKSnVzdCB0byBiZSBjbGVhciwgSSB0aGluayB5b3Ug
bWVhbiB0aGUgbWVtb3J5IF9jb25zaXN0ZW5jeV8gbW9kZWwsCmNvcnJlY3Q/IEJ1dCB5ZXMsIGlm
IHlvdSdyZSBydW5uaW5nIGluIGUuZy4gYSB1bmlwcm9jZXNzb3IgZW52aXJvbm1lbnQsCndlIHNo
b3VsZG4ndCBoYXZlIHRvIHdvcnJ5IGFib3V0IGFueSBvZiB0aGF0LiBBcyBJIHNhaWQgaW4gdGhl
IHByaW9yCmVtYWlsLCBJIGRlZmluaXRlbHkgYWdyZWUgd2l0aCB5b3UgdGhhdCB3ZSdsbCBuZWVk
IHRvIGZvcm1hbGx5IGRlZmluZQphbGwgb2YgdGhpcyBpbiBhIHN1YnNlcXVlbnQgZXh0ZW5zaW9u
IG9mIHRoZSBkb2N1bWVudCwgYnV0IHRoaW5rIHRoYXQKd2UnbGwgYmUgT0sgd2l0aCBzaWRlc3Rl
cHBpbmcgaXQgZm9yIG5vdy4gSXQgc291bmRzIGxpa2Ugd2UncmUgb24gdGhlCnNhbWUgcGFnZSBm
b3IgdGhpcyBvbmU/Cgo+IGRvbid0IHVuZGVyc3RhbmQgd2hhdCBvdGhlciBleHRlbnNpb25zIHRo
YXQgcGVvcGxlIHdvdWxkIHdhbnQgdG8gYWRkLgo+IFZlcmlmaWNhdGlvbiBtaWdodCBiZSBhbiBl
eHRlbnNpb24sIGJ1dCBwcm9iYWJseSBub3QgaW4gdGhlIHNlbnNlIHdlCj4gbmVlZCB0byB3b3Jy
eSBhYm91dCBpdCBoZXJlPwoKSG1tbSwgSSBkb24ndCBleHBlY3QgdGhhdCB2ZXJpZmljYXRpb24g
d291bGQgZXZlciBiZSByZWxldmFudCB0bwpleHRlbmRpbmcgdGhlIElTQS4gVGhlcmUgbWF5IGJl
IHNvbWUgcGxhdGZvcm1zIHRoYXQgZG9uJ3QgaW1wbGVtZW50CnZlcmlmaWNhdGlvbiBhdCBhbGwu
IFZlcmlmaWNhdGlvbiB3aWxsIGxpa2VseSBiZSByZWxlZ2F0ZWQgdG86CgoqIFtJXSB2ZXJpZmll
ciBleHBlY3RhdGlvbnMgYW5kIGJ1aWxkaW5nIGJsb2NrcyBmb3IgYWxsb3dpbmcgc2FmZQogIGV4
ZWN1dGlvbiBvZiB1bnRydXN0ZWQgQlBGIHByb2dyYW1zLAoKZnJvbSBvdXIgY2hhcnRlciwgYW5k
IHdpbGwgbGlrZWx5IGFsc28gYmUgbWVudGlvbmVkIGluIHRoZSBhcmNoaXRlY3R1cmUKYW5kIGZy
YW1ld29yayBpbmZvcm1hdGlvbmFsIGRvYy4KCkkgZXhwZWN0IHRoYXQgZnV0dXJlIGV4dGVuc2lv
bnMgd291bGQgYmUgc29tZXRoaW5nIGxpa2UgYWRkaW5nIGEgZmVuY2UKaW5zdHJ1Y3Rpb24sIGV0
YyB3ZXJlIHdlIHRvIGRlY2lkZSB0byBnbyB0aGF0IHJvdXRlLgoKPiBJIGhvcGUgdGhlIGFib3Zl
IGlzIGhlbHBmdWw6IGFzIGFsd2F5cyBteSBpZ25vcmFuY2UgY2FuIGNvbXBsZXRlbHkKPiBuZWdh
dGUgdGhlIHZhbHVlIG9mIHRoZSBjb25jcmV0ZSBzdWdnZXN0aW9uLCBidXQgSSBkbyBob3BlIGl0
Cj4gaGlnaGxpZ2h0cyBhcmVhcyB0aGF0IGNvdWxkIHVzZSBzb21lIFRMQy4KCllvdXIgaW5wdXQg
aXMgdmVyeSBtdWNoIGFwcHJlY2lhdGVkLCBhbmQgSSBkb24ndCBkaXNhZ3JlZSB3aXRoIHlvdSB0
aGF0CnRoZSBkb2MgY291bGQgKGFzIHdpdGggYW55IGRvY3VtZW50KSBhbHdheXMgYmUgZnVydGhl
ciBpbXByb3ZlZC4KCkp1c3QgYXMgYSBmcmllbmRseSBzdWdnZXN0aW9uLCBhcyBJIHNhaWQgYWJv
dmUsIGlmIHlvdSBmZWVsIHN0cm9uZ2x5CmFib3V0IHRoZXNlIHByb3Bvc2FscyBJIGV4cGVjdCB0
aGF0IGl0IHdvdWxkIGJlIGVhc2llciB0byBpbmNvcnBvcmF0ZQp0aGVtIGJ5IHN1Ym1pdHRpbmcg
cGF0Y2hlcyB3aXRoIHRoZSBwcm9wb3NlZCBjaGFuZ2VzIHJhdGhlciB0aGFuIHNpbXBseQpkZXNj
cmliaW5nIHRoZSBwZXJjZWl2ZWQgZ2Fwcy4gVGhhdCdzIG5vdCBhIGhhcmQgcmVxdWlyZW1lbnQg
YnkgYW55Cm1lYW5zLCBhbmQgSSBhcHByZWNpYXRlIHlvdSB2b2x1bnRlZXJpbmcgeW91ciB0aW1l
IHRvIHJldmlldyB0aGUKZG9jdW1lbnQgcmVnYXJkbGVzcy4gSnVzdCBhIHN1Z2dlc3Rpb24gZm9y
IGdyZWFzaW5nIHRoZSB3aGVlbHMuCgpLaW5kIHJlZ2FyZHMsCkRhdmlkCgotLSAKQnBmIG1haWxp
bmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5m
by9icGYK

