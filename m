Return-Path: <bpf+bounces-7612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE237799AE
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 23:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8F31C20AFA
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 21:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C410D329D1;
	Fri, 11 Aug 2023 21:41:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A189C8833
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 21:41:42 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF63E213B
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 14:41:41 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 6C1C6C15198E
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 14:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691790101; bh=hfb6hal3W1mBmuZske6AxerR/itqwEAQ6xgjv4fsgXE=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=AxN11tfEdApY6/AllJyc+HBHsoknR2XW1Dt3W9AjXBQ5C9BJtRMTB7CWNbkpTvqR2
	 vAqlTtlBRt5p/5I8ADm+JaKs8qhxzPIUXNDxBUtbY9jFhMWrikUs7EmuIvlKTRO/rP
	 4IuwJ/7KpRLJRMqlnHlBGrGHZh66eAdBnF/81P1E=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Aug 11 14:41:41 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 290F5C15153F;
	Fri, 11 Aug 2023 14:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691790101; bh=hfb6hal3W1mBmuZske6AxerR/itqwEAQ6xgjv4fsgXE=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=AxN11tfEdApY6/AllJyc+HBHsoknR2XW1Dt3W9AjXBQ5C9BJtRMTB7CWNbkpTvqR2
	 vAqlTtlBRt5p/5I8ADm+JaKs8qhxzPIUXNDxBUtbY9jFhMWrikUs7EmuIvlKTRO/rP
	 4IuwJ/7KpRLJRMqlnHlBGrGHZh66eAdBnF/81P1E=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 23F08C15153F
 for <bpf@ietfa.amsl.com>; Fri, 11 Aug 2023 14:41:40 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.903
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2VWBEHBJvJgB for <bpf@ietfa.amsl.com>;
 Fri, 11 Aug 2023 14:41:35 -0700 (PDT)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 8ECA0C151097
 for <bpf@ietf.org>; Fri, 11 Aug 2023 14:41:35 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6430bf73e1cso4630256d6.0
 for <bpf@ietf.org>; Fri, 11 Aug 2023 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691790094; x=1692394894;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXtaaKHxnypfgs/oLbWQkYgVmbOAwz8sg7xsZiTGfbQ=;
 b=krsHfd0UcQW1NZ0taSMM6R3PC1OG48OOCvvMh/7oZtxxIWWlESTizz1Cwe82z/CAyn
 /N98lq0/ptdjlRfrjjOVol4KSL5dqBvU6e34Evak/pj1D0gp9ed1H6Pb4+Dk5/kPsroT
 JunBMasaCckpt2J92lsQo4UgyVX8p0Q6CkuXH/c/M4IZjyjR5keegClefvAnBjrr1leb
 Y8mgp53P/w3bPkk5t3hgtGUyiwevgr5ljsU1PAT47cpg5HeuIvK43aZSR9MrFZ421RCV
 EQQK0zVzCgEvWdvBKhcnEf5O/EQVt++ljpWMEc6sOWrHzBAGPlC/jJPjwgn6bLXd26qs
 ekPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691790094; x=1692394894;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXtaaKHxnypfgs/oLbWQkYgVmbOAwz8sg7xsZiTGfbQ=;
 b=DhDOI0awpMIKydw+0wt5cTq/rSpiebmaxXenK5agLkjvC0OUgP9Qop6kYtFqk8t26M
 +reGCRei1azqo19xe1BP0LiIXJF0m8sx8Grsq/8I0wjZLvV8gSrL6XwLIvzXxVoaIKcf
 mdqfL9S+EFI/Czb5JuXIFXdUdhcrHkiUQngPcfFCHRkxphLfZIUbmc9H1T97scrcR/kN
 StENFsYl5FezM2/jcC9OxVCv6SMW+0lSTPWDSGcm7Ofp1qEjjLLXeeVD2XxDlQTnna9O
 if3mqioH2L40n3ENnCg8+ixaJBlbAno4A+anvWbywm/Qbo8B0Pzwb6iRRIZvX9wrTj76
 uXng==
X-Gm-Message-State: AOJu0YxJ/97C5cjJEWzg6Eb54avQPQqGbzg15vFuKWZeQOkdvcUQqi/Y
 msig+VuPQOH0SQNDh7YnlpZPOdOIDs7QefBWYtzvIw==
X-Google-Smtp-Source: AGHT+IELZq70c2oqQkcGwqmSXXlxVlWtzpNt/UmTAHkCYpRqPjf1MosPsrf8X4+k2O46nG5deyST/VJYdyhDQa+rgWo=
X-Received: by 2002:a0c:b28f:0:b0:646:1b3:7d2c with SMTP id
 r15-20020a0cb28f000000b0064601b37d2cmr650814qve.46.1691790094416; Fri, 11 Aug
 2023 14:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
 <CAADnVQ+O0CZQ1-5+dBiPWgZig3MVRX92PWPwNCrL7rG+4Xrbag@mail.gmail.com>
 <CACsn0cmvuGBKd3erDQKugygZfhT-Cu8xYBJ3hCETp6a-1HNbYw@mail.gmail.com>
 <20230811172116.GC542801@maniforge>
 <CACsn0cmbDGpj8R98=DF00-hhjAKph+kHofAs3LF=KKonFYZeuA@mail.gmail.com>
In-Reply-To: <CACsn0cmbDGpj8R98=DF00-hhjAKph+kHofAs3LF=KKonFYZeuA@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Fri, 11 Aug 2023 17:41:23 -0400
Message-ID: <CADx9qWiJCQyLdz5rG33K2iWtsgXQ65K3aiwQiEsjSwY2ofNy1Q@mail.gmail.com>
To: Watson Ladd <watsonbladd@gmail.com>
Cc: void@manifault.com, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Dave Thaler <dthaler@microsoft.com>, Christoph Hellwig <hch@infradead.org>,
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/rvRW1nmUceq6RknkuFm6P2esB-k>
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

V2F0c29uLCB0aGFuayB5b3UhCgpPbiBGcmksIEF1ZyAxMSwgMjAyMyBhdCA1OjM24oCvUE0gV2F0
c29uIExhZGQgPHdhdHNvbmJsYWRkQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBEZWFyIERhdmlkLAo+
Cj4gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBsZW5ndGh5IGFuZCBraW5kIGVtYWlsLiBJ
IGFncmVlIHRoYXQgd2UKPiBzaG91bGQgcHVudCBvbiBjb250ZW50aW91cyBwb2ludHMgYW5kIGFp
bSB0byBzdGFuZGFyZGl6ZSB3aGF0IGhhcwo+IGFscmVhZHkgYmVlbiBpbXBsZW1lbnRlZCBhY3Jv
c3MgYSB3aWRlIHJhbmdlIG9mIGltcGxlbWVudGF0aW9ucy4gTW9zdAo+IG9mIG15IGlzc3VlcyBh
cmUgd2l0aCB0aGUgZm9ybWF0IGFuZCBwcmVzZW50YXRpb24gb2YgdGhlIHRleHQsIGFuZCBJCj4g
dGhpbmsgdGhlIGNvbnRlbnQgY2hhbmdlcyBpdCB3b3VsZCB0YWtlIGFyZSBwcmV0dHkgbm9uY29u
dGVub3VzLiBJCj4gZG9uJ3QgcmVhbGx5IGhhdmUgYW55IGluc2lnaHQgaW50byB3aGF0IHRoZSBj
b250ZW50IHNob3VsZCBiZSwgYW5kIEknbQo+IHN1cmUgdGhhdCBmb3IgdGhvc2Ugd2hvIGxpdmUg
YW5kIGJyZWF0aCBCUEYgZXZlcnkgZGF5LCBtdWNoIG9mIHdoYXQgSQo+IGFtIGNvbmZ1c2VkIGFi
b3V0IGlzIGluZGVlZCBvYnZpb3VzLgo+Cj4gQ29uY3JldGVseSBJIHRoaW5rIHRoZSBmb2xsb3dp
bmcgd291bGQgaGVscCBpbXByb3ZlIHRoZQo+IHVuZGVyc3RhbmRhYmlsaXR5IG9mIHRoZSBkb2N1
bWVudDoKPiAqIEFmdGVyIHRoZSByZWdpc3RlciBwYXJhZ3JhcGgsIGRlc2NyaWJlIHRoZSBtZW1v
cnkuIEFzIEkgdW5kZXJzdGFuZAo+IGl0IGl0IGlzIGEgNjQgYml0LCBieXRlIGFkZHJlc3NlZCwg
ZmxhdCBzcGFjZSwgYW5kIG1hcHMgYXJlIGp1c3QKPiBzcGVjaWFsIHJlZ2lvbnMgaW4gaXQuIE1h
eWJlIEknbSB3cm9uZy4gVGhlcmUncyBzb21lIHN0dWZmIGFib3V0IHR5cGVzCj4gaW4gdGhlIGJp
ZyBzcGFjZSBvZiBpbnN0cnVjdGlvbnMgdGhhdCBtYXliZSBtYWtlcyBtZSB0aGluayBJIGFtIHdy
b25nLgo+ICogU2F5IHRoaXMgaXMgYSAyJ3MgY29tcGxlbWVudCBhcmNoaXRlY3R1cmUKCkkganVz
dCB3YW50ZWQgdG8gcXVpY2tseSBmb2xsb3cgdXAgb24gdGhpcyAuLi4gSSwgdG9vLCBiZWxpZXZl
IHRoYXQgd2UKc2hvdWxkIHNheSB0aGlzIGluIHRoZSBJU0EgYW5kIHB1dCBmb3J3YXJkIGEgcGF0
Y2ggd2l0aCBzb21lIGxhbmd1YWdlLgpZb3UgY2FuIHNlZSB0aGUgZGlzY3Vzc2lvbiBhYm91dCB0
aGF0IGhlcmU6Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2JwZi8yMDIzMDcxMDIxNTgxOC5nQ1BW
emdhSy1ZRVhSRk5peHdjVnJNTEtsa2lNMEZxa1FiVXl0RmxEVFFRQHovCgpUaGFuayB5b3UsIGFn
YWluLCBmb3IgdGhlIGNvbnZlcnNhdGlvbiEKV2lsbAoKCj4gKiBJIGZpbmFsbHkgdW5kZXJzdGFu
ZCB3aHkgdGhlIGNvZGUgZmllbGRzIGhhdmUgdGhlaXIgbG93IG55YmJsZSB6ZXJvLgo+IFdlIHNo
b3VsZCBtYXliZSBzYXkgdGhpcy4KPiAqIEV4cGxpY2l0bHkgY2FsbCBvdXQgYWZ0ZXIgNS4yIHRo
YXQgdGhlcmUgaXMgbm8gbWVtb3J5IG1vZGVsIHlldAo+ICogUHVsbCB1cCBzZWN0aW9uIDUuMy4x
IHRvIHRoZSB0b3AsIG9yIGZpZ3VyZSBvdXQgc29tZSB3YXkgdG8gcHVudCBpdAo+IHRvIGFuIGV4
dGVuc2lvbi4gTWF5YmUgaW50cm9kdWNlIG1hcHMgdXAgdG9wIHRoZW4gZXhwbGFpbiBob3cgdGhl
eSBhcmUKPiBpbmRleGVkIGhlcmUuCj4KPiBGb3IgZXh0ZW5zaW9ucyBpZiBJIHRoaW5rIEkgdW5k
ZXJzdGFuZCB0aGUgY29udmVyc2F0aW9uIGF0IElFVEYgMTE3LAo+IGl0J3MgZWFzeSB0byBhZGQg
bW9yZSBjYWxscyB0byB0aGUgaG9zdCBzeXN0ZW0gYXMgZnVuY3Rpb25zLiBJdCdzIGEKPiBsb3Qg
bW9yZSBvZiBhIGRpZmZpY3VsdHkgdG8gYWRkIG1vcmUgaW5zdHJ1Y3Rpb25zLCBidXQgaW4gdGhl
IHdpZGUKPiBlbmNvZGluZyBzcGFjZSB0aGVyZSBpcyByb29tLiBXZSBjb3VsZCBkZWZpbml0ZWx5
IHNheSB0aGF0LiBUaGUgbWVtb3J5Cj4gbW9kZWwgc2hvdWxkIG9ubHkgbW9kaWZ5IHRoZSBiZWhh
dmlvciBvZiBlbnZpcm9ubWVudHMgd2l0aCByYWNlcywgc28KPiBpZiB0aGluZ3MgYXJlbid0IHJh
Y3ksIG5vdGhpbmcgY2hhbmdlcy4gVGhhdCBzaG91bGQgd29yaywgYnV0IG1heWJlIEkKPiBkb24n
dCB1bmRlcnN0YW5kIHdoYXQgb3RoZXIgZXh0ZW5zaW9ucyB0aGF0IHBlb3BsZSB3b3VsZCB3YW50
IHRvIGFkZC4KPiBWZXJpZmljYXRpb24gbWlnaHQgYmUgYW4gZXh0ZW5zaW9uLCBidXQgcHJvYmFi
bHkgbm90IGluIHRoZSBzZW5zZSB3ZQo+IG5lZWQgdG8gd29ycnkgYWJvdXQgaXQgaGVyZT8KPgo+
IEkgaG9wZSB0aGUgYWJvdmUgaXMgaGVscGZ1bDogYXMgYWx3YXlzIG15IGlnbm9yYW5jZSBjYW4g
Y29tcGxldGVseQo+IG5lZ2F0ZSB0aGUgdmFsdWUgb2YgdGhlIGNvbmNyZXRlIHN1Z2dlc3Rpb24s
IGJ1dCBJIGRvIGhvcGUgaXQKPiBoaWdobGlnaHRzIGFyZWFzIHRoYXQgY291bGQgdXNlIHNvbWUg
VExDLgo+Cj4gU2luY2VyZWx5LAo+IFdhdHNvbiBMYWRkCj4KPiAtLQo+IEFzdHJhIG1vcnRlbXF1
ZSBwcmFlc3RhcmUgZ3JhZGF0aW0KPgo+IC0tCj4gQnBmIG1haWxpbmcgbGlzdAo+IEJwZkBpZXRm
Lm9yZwo+IGh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCgotLSAKQnBm
IG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9icGYK

