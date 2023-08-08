Return-Path: <bpf+bounces-7270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDBC774D06
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 23:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F12281897
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 21:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C49174C5;
	Tue,  8 Aug 2023 21:26:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D092E569
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 21:26:03 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DEA94
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 14:26:02 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 97865C13AE27
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691529962; bh=U0NYaEpVFtXw/76MOBkDFDZN+fZ3mdsWvjILAvrO5ik=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ajdy+GQDksR6WUL0MZe+3Bbs+j2WLTU+wdFhNdBQlPh9DSj7RjqF+Y6Ho1nTlHWv5
	 KrZIZbQyka6GMb+sEU30nqb83dHTW6foh3LhSxqCNQDE67Y4uRJEQ6gpthU5Q3j13S
	 oPmJrK4R/mLMSeps2lKn9+aby9YpTqOCxy22d5p0=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Aug  8 14:26:02 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 778EFC15C509;
	Tue,  8 Aug 2023 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691529962; bh=U0NYaEpVFtXw/76MOBkDFDZN+fZ3mdsWvjILAvrO5ik=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ajdy+GQDksR6WUL0MZe+3Bbs+j2WLTU+wdFhNdBQlPh9DSj7RjqF+Y6Ho1nTlHWv5
	 KrZIZbQyka6GMb+sEU30nqb83dHTW6foh3LhSxqCNQDE67Y4uRJEQ6gpthU5Q3j13S
	 oPmJrK4R/mLMSeps2lKn9+aby9YpTqOCxy22d5p0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 382C2C15C509
 for <bpf@ietfa.amsl.com>; Tue,  8 Aug 2023 14:26:01 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.907
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wq63BwHGZVJ3 for <bpf@ietfa.amsl.com>;
 Tue,  8 Aug 2023 14:25:56 -0700 (PDT)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id AC325C151530
 for <bpf@ietf.org>; Tue,  8 Aug 2023 14:25:56 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6b9e478e122so5096448a34.1
 for <bpf@ietf.org>; Tue, 08 Aug 2023 14:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691529956; x=1692134756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZdMVUIy7CoMr0jl//wKKkqgHFqN85zKy17qlq02oZI=;
 b=ttepeYR137ozRSfCx9dSRikZ14KF4yKqxIHFiRfIyqSbYlA0TkCEurIi3UHy4f0pZv
 t7yCNilX3DdI3iwQ/KWCfaW6hI00cJMplUj40j27emLAs+fU7qnntXCDENWxFAoC8d+A
 +IH7r82ZZu4VXlIW2UtZiEf81LpLLDJpKGvTNIJINoSP5OEVhRSRM+eaZ0OXmRdzCdUx
 ETtG+tH3TyikJmRr9zZcN7bJVd+nuSYM5dtpGst/xQ0gTmbN+9a83PWFLgS53foCP+c8
 mj3cvNEp152OfT4cCpPY7FxqHxeC5Ty1z69GCMWtb9wq5sGYgnkrjvDKpGaa2D6N/j0V
 1L8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691529956; x=1692134756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MZdMVUIy7CoMr0jl//wKKkqgHFqN85zKy17qlq02oZI=;
 b=CT8iT+UMnCy1YX7rJCvkOL35OAkML613etiL32jSYnVwY0hjs0xReqT2tjiosFk7uS
 x+9e3Ggyt1dr/vTNw9QSDe9BnxRuT0qieaRGshhUKqUj15DYOMZ3x/6B+5LxDmjokMM+
 aRaREvYx3lkGUlxGgT53GY6vFtdc1/IX9rZsNEGhthIYyhWgBKRAj4WtSUT+3QH8/Fzl
 lHA3Lpy0fLQgs/gKa8mtRFLQYs2b57ZXsKp48wVUYAeSfOXl7g/Q1AVZJ1xliTYvXiZL
 AV3cxCEQJlGZG5nZF3V1C167Mea4HoPxUS5zhRwocjg/54q65ILGM8Q/+Ko/3uRUpcmN
 k2fQ==
X-Gm-Message-State: AOJu0YwwCiBAJ/3XsHYUimENsUv8mBGx3xVjqRRBVmF982a+xOYulpNb
 i5Bh+3qakyia4nfeVmxFfqIfRJI9fZcpqx63GfXuAQ==
X-Google-Smtp-Source: AGHT+IEIMOk3jp3ssexrPXM0NGdY7AZpMJ8274d7SgaWz8eQRDqoAESq7fISvhhDYWR85E6WIUA1BoKelvkKuA1cOcs=
X-Received: by 2002:a05:6358:98a9:b0:134:c4dc:9e28 with SMTP id
 q41-20020a05635898a900b00134c4dc9e28mr584432rwa.17.1691529955942; Tue, 08 Aug
 2023 14:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230808052736.182587-1-hawkinsw@obs.cr>
 <20230808182444.GA1158877@maniforge>
In-Reply-To: <20230808182444.GA1158877@maniforge>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Tue, 8 Aug 2023 17:25:45 -0400
Message-ID: <CADx9qWjUFL-019oA9d-W78i2+Wt8MbO5HPMX-x=TJPu5kz1_Xw@mail.gmail.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/6zT9lkJT8oNqqbQCTTmjrxQKy24>
Subject: Re: [Bpf] [PATCH] bpf,
 docs: Fix small typo and define semantics of sign extension
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

T24gVHVlLCBBdWcgOCwgMjAyMyBhdCAyOjI04oCvUE0gRGF2aWQgVmVybmV0IDx2b2lkQG1hbmlm
YXVsdC5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCBBdWcgMDgsIDIwMjMgYXQgMDE6Mjc6MzJBTSAt
MDQwMCwgV2lsbCBIYXdraW5zIHdyb3RlOgo+Cj4gSGkgV2lsbCwKPgo+IFRoaXMgbG9va3MgZ3Jl
YXQsIHRoYW5rcyEKPgo+IEFja2VkLWJ5OiBEYXZpZCBWZXJuZXQgPHZvaWRAbWFuaWZhdWx0LmNv
bT4KPgo+ID4gQWRkIGFkZGl0aW9uYWwgcHJlY2lzaW9uIG9uIHRoZSBzZW1hbnRpY3Mgb2YgdGhl
IHNpZ24gZXh0ZW5zaW9uCj4gPiBvcGVyYXRpb25zIGluIGVCUEYuIEluIGFkZGl0aW9uLCBmaXgg
YSB2ZXJ5IG1pbm9yIHR5cG8uCj4KPiBKdXN0IGZvciBmdXR1cmUgcmVmZXJlbmNlIHNvIHdlIGNh
biBoYXZlIGNvbnNpc3RlbnQgbm9tZW5jbGF0dXJlOgo+Cj4gcy9lQlBGL0JQRgoKU2VudCBhIHYy
IGp1c3QgdG8gbWFrZSBpdCBlYXNpZXIgZm9yIG1haW50YWluZXJzIHRvIGFwcGx5IHRoZSBwYXRj
aC4gSQppbmNsdWRlZCB5b3VyIGFjayAtLSB0aGFuayB5b3UgZm9yIHRoZSByZXZpZXchCldJbGwK
Ci0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2JwZgo=

