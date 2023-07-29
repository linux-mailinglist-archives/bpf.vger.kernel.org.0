Return-Path: <bpf+bounces-6309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429FA767C32
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 06:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAF1282603
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 04:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750D31C01;
	Sat, 29 Jul 2023 04:52:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD9817FC
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 04:52:41 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA73219AF
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 21:52:39 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id AFC00C151544
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 21:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690606359; bh=p0p3hL9HPx5W7nB5UX/5PmgVyw2RrF9FJZVhHl/KdFg=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=OCXyg6IFZNVL7hVsDGxwqAPoPVmlQpKXryMk2FqMwatc2lttZ/y18oUL+ZozNh/84
	 Gqq8MOZY/Ak8MpWHRmc6qsjmgKsKuT+oC7Ju92W9dHojsPmOD3Y3aU98vn0mvjiI+I
	 d5/AEJ7WsBH9A3ClMJDpGLCYFa+swqaBr5NfFcPs=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jul 28 21:52:39 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 952F3C14CE42;
	Fri, 28 Jul 2023 21:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690606359; bh=p0p3hL9HPx5W7nB5UX/5PmgVyw2RrF9FJZVhHl/KdFg=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=OCXyg6IFZNVL7hVsDGxwqAPoPVmlQpKXryMk2FqMwatc2lttZ/y18oUL+ZozNh/84
	 Gqq8MOZY/Ak8MpWHRmc6qsjmgKsKuT+oC7Ju92W9dHojsPmOD3Y3aU98vn0mvjiI+I
	 d5/AEJ7WsBH9A3ClMJDpGLCYFa+swqaBr5NfFcPs=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 3E8FEC14CE42
 for <bpf@ietfa.amsl.com>; Fri, 28 Jul 2023 21:52:38 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.108
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EOBcDRPm3VDO for <bpf@ietfa.amsl.com>;
 Fri, 28 Jul 2023 21:52:37 -0700 (PDT)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id A7707C14CF09
 for <bpf@ietf.org>; Fri, 28 Jul 2023 21:52:37 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b9aa1d3029so41841041fa.2
 for <bpf@ietf.org>; Fri, 28 Jul 2023 21:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690606356; x=1691211156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RmP40yBhEjViAD9Nyb9F4Iw9OdpyGMw/B/5lyQSpVtA=;
 b=pimWZ3Vfe3H/8GIN4S8GIXtD5aPYJJ1sMiyBK3ZxGpaI0BglmABQjX9XaqniYpyuGp
 vSyIvPkq1nino8JFKCrovsirjElRMDqqX5U5kqpU8RB0EcvuH3rMs0p7EcIcwabwaqjX
 RJrPhlKOG9sLATPOUmtQMLjhxKKbvwD8yKMkywE20jmUp5iTmudPmLXT984j+FA2QAGs
 vZNMPE1KQ/bywJjBzfeaRYtqzShjqkVjEIKWvdEYzcGg1xwgZH31enjHTS9kAjoUigoG
 O2am8S0Ye9jvyhDvTOWoNKuEQK43ZDchKhBN5rXXtZ6fM/oGxP9aSTkSt3xkbAbofUSl
 2z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690606356; x=1691211156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RmP40yBhEjViAD9Nyb9F4Iw9OdpyGMw/B/5lyQSpVtA=;
 b=UuYT4vHB7tqYK8GahK9S/YYe0Faqf19S50E298VM6CEv0QnFTLtsZjlIeK/Hm4LzFv
 1hmnf1+almFx91D/XVBuDWGLM4VjJO5VSjMdebHX9stjHEJkWTNl0TzPCBiI9+i83tEF
 IXn3yOAoDbPm9e5EEp2utKsqpOFRjlDnM055olnI8PIe7F8GgCeQiHwhg2BQJ6Nle+fi
 N4jCNlaSG6UdSVoaqLkebpBYbrfWlrCBMFH135ymqsHinv3HFiKCXI08EAHgCyaeUcpY
 gRm5E55TVRaRENPveCiI7oFBpRDArdfLnzD0Yz3XoA7SeHHabikFZzWv/pyclFZ8ZUfZ
 S0KQ==
X-Gm-Message-State: ABy/qLZp8xtYJn8iVQU3nzFdRWs6ebADV11Y0uWdprMbBdJ42/JNQcWD
 Pec5teWyAM57VsEZP8F8lz9yAbm/D1AvDFXhAlc=
X-Google-Smtp-Source: APBJJlFo2XV8VesHg7CLmp7rygmplWsG07ISIewdYwxHH1Hwh4d1GQ7BUr8E8S4dzcJdmq/B1O7szdkOfP2GwH20GnI=
X-Received: by 2002:a2e:9044:0:b0:2b9:af56:f4b8 with SMTP id
 n4-20020a2e9044000000b002b9af56f4b8mr3235700ljg.10.1690606355558; Fri, 28 Jul
 2023 21:52:35 -0700 (PDT)
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
 <CADx9qWi+VQ=do+_Bsd8W4Yc-S1LekVq7Hp4bfD3nz0YP47Sqgg@mail.gmail.com>
 <CAADnVQ+5d8ztfFLraWnZKszAX23Z-12=pHjJfufNbd3qzWVNsQ@mail.gmail.com>
 <CADx9qWhSqb6xAP=nz5N-vmd2N3+h4TBFtFOGdJUWNfX=LapEBw@mail.gmail.com>
 <CAADnVQJ4yzDc0qQExLUO1b23ndEiEjnYYPv5qC7JJYmLr4X3ew@mail.gmail.com>
 <CADx9qWh6ZUKvjkZow6=eB4gvEgP82mBqn+mMZvmDQynCYAfMWw@mail.gmail.com>
 <CAADnVQKOiwm1UB58=8QcowDyfPQct-wuMD19citS7w5PmadZ6g@mail.gmail.com>
 <CADx9qWjYChRf2qBr=Pt5D-RLCb665YFKmjDYX8WOQfqMx1-bag@mail.gmail.com>
 <CAADnVQJDO9MgU2MQQ5NQAE3EwL6PuPp8aAxcV3apf0DHoq8TAw@mail.gmail.com>
 <CADx9qWjOP4-2K3uKBTRmS4Q5V0gTJtoH65fwN-MhZvn6ukFpBg@mail.gmail.com>
 <CAADnVQKbpoeMWdnXzYbBaHoDiNsLDbC0JvDUnVGEQbCigjd1Xg@mail.gmail.com>
 <CADx9qWj4xuYoyz83FphVWU0ZVxy_7Y+SvTWjvChvkMdV290giA@mail.gmail.com>
In-Reply-To: <CADx9qWj4xuYoyz83FphVWU0ZVxy_7Y+SvTWjvChvkMdV290giA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 28 Jul 2023 21:52:24 -0700
Message-ID: <CAADnVQLWKnGbG6XTVEKSto0kEiqHwFaDTp+UkCYipKpov_btRA@mail.gmail.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: Watson Ladd <watsonbladd@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/tNUuUCR4LM5XlIHgO6aI_wvACTo>
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

T24gRnJpLCBKdWwgMjgsIDIwMjMgYXQgODoxNOKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dA
b2JzLmNyPiB3cm90ZToKPgo+IFRoZSBBcHBlbmRpeCAodGhlIG9wY29kZSB0YWJsZSkgaXMgbm90
IGluIHRoZSBrZXJuZWwgcmVwbyBub3cgYW5kCj4gc3RpbGwgaGFzIHRoZSBpc3N1ZXMgdGhhdCBJ
IG91dGxpbmVkIGFib3ZlLiBXaWxsIHRoYXQgbWFrZSBpdCBpbiB0bwo+IHRoZSBrZXJuZWw/Cj4K
PiBodHRwczovL2dpdGh1Yi5jb20vaWV0Zi13Zy1icGYvZWJwZi1kb2NzL2Jsb2IvbWFpbi9yc3Qv
aW5zdHJ1Y3Rpb24tc2V0LW9wY29kZXMucnN0CgpJIHRob3VnaHQgaXQncyBhdXRvIGdlbmVyYXRl
ZCwgc28gaXQgc2hvdWxkIGJlIGVhc3kgdG8gdXBkYXRlLgpJZiBub3QsIGxldCdzIGNlcnRhaW5s
eSBicmluZyBpdCBpbi4KCkkgc3VzcGVjdCBpdCB3aWxsIGJlIHRoZSBzZWVkIGZvciBJQU5BLgoK
RGF2ZSwgdGhvdWdodHM/CgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6
Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

