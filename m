Return-Path: <bpf+bounces-5057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5102B7545A1
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 02:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA1A282303
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 00:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B00A7FA;
	Sat, 15 Jul 2023 00:23:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C36A7EC
	for <bpf@vger.kernel.org>; Sat, 15 Jul 2023 00:23:25 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1FF3A96
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 17:23:24 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8B17EC151099
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 17:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689380604; bh=OpD6uOGlKQy7dNQebp3nOkPcHR+p0QkeQPVaPfVw+Ng=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=t0PxGt5XRGTy6QxvLRgGgxwjEYM8euoIe1eRrp5EnmemERhR+QYb0iPZY7c11wmJd
	 bDUVdevu3yMO4UAx6Ral/hVaSN7npgCLuuFM36RZxuJroomS7KqJbrebqNVOJDxhxl
	 OgCijzgvzHjajA1zyuWFcZiYOMRDZ6+5alsvYONA=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jul 14 17:23:24 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 5B8D7C14CE52;
	Fri, 14 Jul 2023 17:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689380604; bh=OpD6uOGlKQy7dNQebp3nOkPcHR+p0QkeQPVaPfVw+Ng=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=t0PxGt5XRGTy6QxvLRgGgxwjEYM8euoIe1eRrp5EnmemERhR+QYb0iPZY7c11wmJd
	 bDUVdevu3yMO4UAx6Ral/hVaSN7npgCLuuFM36RZxuJroomS7KqJbrebqNVOJDxhxl
	 OgCijzgvzHjajA1zyuWFcZiYOMRDZ6+5alsvYONA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E5182C14CE52
 for <bpf@ietfa.amsl.com>; Fri, 14 Jul 2023 17:23:22 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.098
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5EyWo73NaYNK for <bpf@ietfa.amsl.com>;
 Fri, 14 Jul 2023 17:23:22 -0700 (PDT)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 94DCDC14CEF9
 for <bpf@ietf.org>; Fri, 14 Jul 2023 17:23:22 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b6ff1a637bso37560501fa.3
 for <bpf@ietf.org>; Fri, 14 Jul 2023 17:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689380601; x=1691972601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mN4ioxzNj7bQxuk2vBcEGRf0mcVVJXxZupsQurmYKog=;
 b=bmu1dgzks5b1IPzM3Zu8n8SO5LpdJ9OLkQFVN9TEV5c/fWH/QGC00L74cPWG59TDje
 c3dFhqAWEv+p2rlbnDfWifPiFi17PajSmWelMRaN1AgjB7lsKv3Ut8FWqUMMj37+J1s5
 6/V0+ae+1j6VgyqVzTUYWhVo0YKebYzSPemST0+H28ZkcC7GHWnuAsV+cyIOJny38Pk7
 VMeqG/pp7WkrCfrVw/96EqXH8APwVoEItzG73fJNUnjg+7bM1x+rTCFqBsb3ONX5IRnF
 tefybUyxU169ibrEBV6b3wHy5F/sqOI6e2MhAYDsEVAwT+u/mp21AWHbJA+z7ahfy38A
 CzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689380601; x=1691972601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mN4ioxzNj7bQxuk2vBcEGRf0mcVVJXxZupsQurmYKog=;
 b=eadxKc5QthoDf7r6VycewjIJakAOMUm2WAUrNP03JTZ1FNp78s5knBJKu6dUWmh5fW
 V7RvlQuiRZGc6QqJeROVPTOCJhyfvQETFOluSY0lzsNF6qCNuJYhrmVep1gjrrcumIml
 8F/05n229z4baWnac1FrTkHlog4uMm3XcQRtPx5IzSHHKQmrXFy7KDlrzLm+E0X9lMyV
 HiizDTyd0rLEpcj+H1T45jjXrcAGyMNXLSiwSs6Vyk4FnGwLccK8vRXJt8M/AnOKU/Ay
 q9Fd9dPUb4fFSApc2DSvJqk2rOXQL/7/PTgByG4xzsAZI5asm4+DTZ9CfDV8n9HQdybl
 UG0A==
X-Gm-Message-State: ABy/qLbUF9oUajKxcxDSsdqD3QhgdGA2kv02GJ16ZrHkXd/+P/KE8yJO
 G3TaxadRY9iQt5kXQnG0dgMkRxdg26PHLMz2g0E=
X-Google-Smtp-Source: APBJJlEtR/O/OebWr2HyF/l3RYvR2nM4QYSQy8wHK+OL/YC5/YE5TwmPzsgwR0sjL/68FjEeyJcmrCwYOR0SGaRj9Rc=
X-Received: by 2002:a2e:9c02:0:b0:2b4:83c3:d285 with SMTP id
 s2-20020a2e9c02000000b002b483c3d285mr5582655lji.38.1689380600507; Fri, 14 Jul
 2023 17:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713060718.388258-1-yhs@fb.com>
 <20230713060847.397969-1-yhs@fb.com>
 <PH7PR21MB38788F07F700A549DEB96F9BA334A@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB38788F07F700A549DEB96F9BA334A@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Jul 2023 17:23:09 -0700
Message-ID: <CAADnVQLtdMw_xk84tTOgXvat9NRi7eceRDbiim21rJeR=LDdrA@mail.gmail.com>
To: Dave Thaler <dthaler@microsoft.com>
Cc: Yonghong Song <yhs@fb.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "bpf@ietf.org" <bpf@ietf.org>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Fangrui Song <maskray@google.com>, 
 "kernel-team@fb.com" <kernel-team@fb.com>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/ibjN22siZXd6G1BOQhXViQ-J5kM>
Subject: Re: [Bpf] [PATCH bpf-next v2 15/15] docs/bpf: Add documentation for
 new instructions
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

T24gRnJpLCBKdWwgMTQsIDIwMjMgYXQgNDozM+KAr1BNIERhdmUgVGhhbGVyIDxkdGhhbGVyQG1p
Y3Jvc29mdC5jb20+IHdyb3RlOgo+Cj4gWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4gd3JvdGU6
Cj4gPiBBZGQgZG9jdW1lbnRhdGlvbiBpbiBpbnN0cnVjdGlvbi1zZXQucnN0IGZvciBuZXcgaW5z
dHJ1Y3Rpb24gZW5jb2RpbmcgYW5kCj4gPiB0aGVpciBjb3JyZXNwb25kaW5nIG9wZXJhdGlvbnMu
IEFsc28gcmVtb3ZlZCB0aGUgcXVlc3Rpb24gcmVsYXRlZCB0byAnbm8KPiA+IEJQRl9TRElWJyBp
biBicGZfZGVzaWduX1FBLnJzdCBzaW5jZSB3ZSBoYXZlIEJQRl9TRElWIGluc24gbm93Lgo+Cj4g
V2h5IGRpZCB5b3UgY2hvb3NlIHRvIGRpZmZlcmVudGlhdGUgdGhlIGluc3RydWN0aW9uIGJ5IG9m
ZnNldCBpbnN0ZWFkIG9mIHVzaW5nIGEgc2VwYXJhdGUKPiBvcGNvZGUgdmFsdWU/ICBJIGRvbid0
IHRoaW5rIHRoZXJlJ3MgYW55IG90aGVyIGluc3RydWN0aW9ucyB0aGF0IGRvIHNvLCBhbmQgdGhl
cmUncyBzcGFyZQo+IG9wY29kZSB2YWx1ZXMgYXMgZmFyIGFzIEkgY2FuIHNlZS4KPgo+IFVzaW5n
IGEgc2VwYXJhdGUgb2Zmc2V0IHdvcmtzIGJ1dCB3b3VsZCBlbmQgdXAgcmVxdWlyaW5nIGFub3Ro
ZXIgY29sdW1uIGluIHRoZSBJQU5BCj4gcmVnaXN0cnkgYXNzdW1pbmcgd2UgaGF2ZSBvbmUuICBT
byB3aHkgdGhlIGV4dHJhIGNvbXBsZXhpdHkgYW5kIGluY29uc2lzdGVuY3kKPiBpbnRyb2R1Y2Vk
IG5vdz8KCiJhbm90aGVyIGNvbHVtbiBpbiBJQU5BIiBpcyB0aGUgbGFzdCB0aGluZyB0byB3b3Jy
eSBhYm91dC4KCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5p
ZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

