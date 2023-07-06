Return-Path: <bpf+bounces-4361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0143274A7C0
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2267E1C20EE6
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 23:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3B3168D8;
	Thu,  6 Jul 2023 23:32:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF60D2E9
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 23:32:07 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417C3DC
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 16:32:06 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 127E8C13AE47
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 16:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688686326; bh=RpcvCWRNt1hGjfpF1XTCTucI0hME0hIy+J+4sg4TLd8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=o/5fApR9cAvAKjE445sgcsfAbGfRlt4+w6WPepDd/RELaeKgEn4PwTJEUZdxryIyq
	 5gefR7FVpMNu6gB3DPWM0IPh+DVbLnMJXB9Ln8uO2ZxfIPRC9/0o/XPkvsSl0qBjAS
	 akh0EFMQPiN4COJ1RvcW7kHuCbj45dgCBdELp55E=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Jul  6 16:32:05 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DC6E2C151527;
	Thu,  6 Jul 2023 16:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688686325; bh=RpcvCWRNt1hGjfpF1XTCTucI0hME0hIy+J+4sg4TLd8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=D/x3cvFJ5Qo+9oFTt3dhD+k+1ENIezLARzt5q6zdWPQ67OB12XrdC7OthQ2HsidEf
	 JQNAC77eVcznomj502HOXs0dEWHIX06/KtTE6ZVI+UeFtSZHc3EKVQR21mPyCqH6ck
	 hkKkNPV3b93wIqOxkmCIsLxa0mB2T/9gwCnNt2+w=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 80389C151527
 for <bpf@ietfa.amsl.com>; Thu,  6 Jul 2023 16:32:04 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.098
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ysSHtIB_utvr for <bpf@ietfa.amsl.com>;
 Thu,  6 Jul 2023 16:32:04 -0700 (PDT)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 16C81C15109F
 for <bpf@ietf.org>; Thu,  6 Jul 2023 16:32:04 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b63e5f94f1so15883081fa.1
 for <bpf@ietf.org>; Thu, 06 Jul 2023 16:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688686322; x=1691278322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6HGx3BBK3e6NncirqzjfehqKmV8RLD2m05P7jQfvq4=;
 b=T63ZYqhdM8qR/Vsyta6go+eAeIyr6N4yUrP30azBb7axy5Iusz6QvzS9GrcdoxidG9
 BPqzPy7BPs4feaFwNEYhhJv04covUWpjlR/Vrz1h0D+NWjCYC3TkGF4e265jfF0TQImY
 NsZxGAlVSyPJZyGmJxSmTvCYK03pFljjHMqt7XqEAZpwtkCL37tIeV2vrq5Wfu6vqg7y
 a+NznAPFhsSmQiyi+K0P2IH9/WTaliBOeCMmkeU0K3QlS1StN+nNilqZkCRbIHYLcGQw
 Wmk5N3ldacWxAb6nDb5trXcp+1+jAh5QlA8Sr+pcTTmK2iKeP4pD/z+QVJNAkvY54pBU
 rXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688686322; x=1691278322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B6HGx3BBK3e6NncirqzjfehqKmV8RLD2m05P7jQfvq4=;
 b=ONva1B5DM5CtYjTfMwRaIufW3DHIM+6wXXRiH+2BX+Xq6Rn95pHfAOMc9VZ9THd7MS
 vml0zAgDumjzvv7PBu3/sslmPMM+nLIJkGiF7hlYRnMk77YyxXEmSOc9Y0kmsMgRsqBB
 gvb10RtrZdfwigfAtsN4pdIR4vYTuYvu5EMSED44eZQsXxIGQFqrwnEKuVskZ8qbY/fi
 QkJliWAdDfpN6/m+ku4bL2RWSWNej+BXqCpWfzBwMK/QO1pW9NLc8WVhhy2wYcnm12va
 BBrrVGAVAvShneB/GlmhHl8vlHkfxlQ0GFpCE+IAPL0n/I5pvyZNUxsibVAyFqT0xHfc
 +ikQ==
X-Gm-Message-State: ABy/qLYwv7ymaq4kIy9v52n4cVeNFxOU6Gg0xXcqcvQgS4Wn0R/ZX/jp
 7W3Cu+Ss9v8GHu3eVIkzwUT+9x5VddmuDWgn9Ag=
X-Google-Smtp-Source: APBJJlEFFF7M+y06+VP2GGB4Fq3B08az07f0fRoWhnGEqrWxhCs6cKkZl1kBcjsx1Nx50cvsRrjmslgeO26pG6LDSqs=
X-Received: by 2002:a2e:81c8:0:b0:2b7:118:a1bc with SMTP id
 s8-20020a2e81c8000000b002b70118a1bcmr1142457ljg.25.1688686321990; Thu, 06 Jul
 2023 16:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706222020.268136-1-hawkinsw@obs.cr>
 <20230706222020.268136-2-hawkinsw@obs.cr>
In-Reply-To: <20230706222020.268136-2-hawkinsw@obs.cr>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Jul 2023 16:31:50 -0700
Message-ID: <CAADnVQ+kfTPYE1kbUuxsaoEZBCHKG2SLDkcs62RXqEo8Jhi9+Q@mail.gmail.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/F9lWtevv1hVKmf6cofVHa-7lFa4>
Subject: Re: [Bpf] [PATCH 1/1] bpf,
 docs: Describe stack contents of function calls
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

T24gVGh1LCBKdWwgNiwgMjAyMyBhdCAzOjIw4oCvUE0gV2lsbCBIYXdraW5zIDxoYXdraW5zd0Bv
YnMuY3I+IHdyb3RlOgo+Cj4gVGhlIGV4ZWN1dGlvbiBvZiBldmVyeSBmdW5jdGlvbiBwcm9jZWVk
cyBhcyBpZiBpdCBoYXMgYWNjZXNzIHRvIGl0cyBvd24KPiBzdGFjayBzcGFjZS4KPgo+IFNpZ25l
ZC1vZmYtYnk6IFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPgo+IC0tLQo+ICBEb2N1bWVu
dGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQucnN0IHwgNSArKysrKwo+ICAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9icGYvaW5z
dHJ1Y3Rpb24tc2V0LnJzdCBiL0RvY3VtZW50YXRpb24vYnBmL2luc3RydWN0aW9uLXNldC5yc3QK
PiBpbmRleCA3NTFlNjU3OTczZjAuLjcxNzI1OTc2N2E0MSAxMDA2NDQKPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQucnN0Cj4gKysrIGIvRG9jdW1lbnRhdGlvbi9icGYv
aW5zdHJ1Y3Rpb24tc2V0LnJzdAo+IEBAIC0zMCw2ICszMCwxMSBAQCBUaGUgZUJQRiBjYWxsaW5n
IGNvbnZlbnRpb24gaXMgZGVmaW5lZCBhczoKPiAgUjAgLSBSNSBhcmUgc2NyYXRjaCByZWdpc3Rl
cnMgYW5kIGVCUEYgcHJvZ3JhbXMgbmVlZHMgdG8gc3BpbGwvZmlsbCB0aGVtIGlmCj4gIG5lY2Vz
c2FyeSBhY3Jvc3MgY2FsbHMuCj4KPiArRXZlcnkgZnVuY3Rpb24gaW52b2NhdGlvbiBwcm9jZWVk
cyBhcyBpZiBpdCBoYXMgZXhjbHVzaXZlIGFjY2VzcyB0byBhbgo+ICtpbXBsZW1lbnRhdGlvbi1k
ZWZpbmVkIGFtb3VudCBvZiBzdGFjayBzcGFjZS4gUjEwIGlzIGEgcG9pbnRlciB0byB0aGUgYnl0
ZSBvZgo+ICttZW1vcnkgd2l0aCB0aGUgaGlnaGVzdCBhZGRyZXNzIGluIHRoYXQgc3RhY2sgc3Bh
Y2UuIFRoZSBjb250ZW50cwo+ICtvZiBhIGZ1bmN0aW9uIGludm9jYXRpb24ncyBzdGFjayBzcGFj
ZSBkbyBub3QgcGVyc2lzdCBiZXR3ZWVuIGludm9jYXRpb25zLgoKU3VjaCBkZXNjcmlwdGlvbiBi
ZWxvbmdzIGluIGEgZnV0dXJlIHBzQUJJIGRvYy4KaW5zdHJ1Y3Rpb24tc2V0LnJzdCBpcyBub3Qg
YSBwbGFjZSB0byBkZXNjcmliZSBob3cgcmVnaXN0ZXJzIGFyZSB1c2VkLgpGb3IgZXhhbXBsZSB4
ODYtNjQgSklUIG1hcHMgQlBGIFIxMCB0byBSQlAuCllldCB0aGVyZSBpcyAtZm9taXQtZnJhbWUt
cG9pbnRlci4KU28gd2UgbWlnaHQgdmVyeSB3ZWxsIGRvIHNvbWV0aGluZyBsaWtlIHRoYXQgaW4g
dGhlIGZ1dHVyZS4KCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3
dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

