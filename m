Return-Path: <bpf+bounces-3970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F737472C0
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 15:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986A91C203A7
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 13:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDCE612B;
	Tue,  4 Jul 2023 13:30:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57EC53B1
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 13:30:25 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1DC99
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 06:30:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-991ef0b464cso1014278366b.0
        for <bpf@vger.kernel.org>; Tue, 04 Jul 2023 06:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688477422; x=1691069422;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/f17efAJREWziN7QYEKaDfbvASJQx0fofzhrC/UyK/4=;
        b=cXdJpP76drfDNrt1dZ657e0bA94fj39IvfF1gptathCzqq7Ag8xgLztVc0qLmMwNKJ
         n5s11KMK0jTpr3mbhvLVC+giHi9+D2PId5U0A7j0KoqzEZb29lwR9tBeWLv3pLkB848X
         opOzHY0RMDY430nvSe+UqC38l1ofctWlBl4snwN/7KAqAt0r250dK/2vsRavwoPjU6FL
         H6VlJbdWowJFnntSw/nCHDq0o2GDWO7yeDdhAJQpWRYsa44YDulKzMZ3ZRkC0o4wPuWR
         6VljZBA/sjUtZ4o/rwILDq11ZaOb2dvAH/2rg0T6NdHexO4LE0VxbzzOVZfraEd0VEZD
         KIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688477422; x=1691069422;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/f17efAJREWziN7QYEKaDfbvASJQx0fofzhrC/UyK/4=;
        b=jSykF2FQHK8qcw6mwL0IGsifcRVfQOvd2gDr2hv8Ob0aCsVwFOcAQQP2p77qk1h5dQ
         VT83qCQgl2b2SOYk5dtf1iUV3sMKeE1ih0qz7WRGV/GLhdC3Xe+D95x/OUtP549tfzCR
         cS42THOuEplhQEjR+CejlkEz/8Cc6vlLuaYapFoLL8QfNoxkW2IanBUuOIy7wbcL21jT
         VsfFbrA3AcBn65Nl47tpjgfpUkl66Xw83DzlDXrSUSKbJQXtiPIherSAjmi/HoBRQ07v
         9jGBN00hVrCIUwsX88uMa4PZ+Yo/nJTcwZrCML0C4JkGtYw9LAk3oLbknHwAA9u7zwSY
         sllQ==
X-Gm-Message-State: ABy/qLYqEzyMXWUptk3Py4wRjR4a5EhDayE96NybvneQtqBcdxy/SAXU
	724V7h8w9D0v9A5Zh3cRwTXp0Bymjrb/X8quUZvkOKcKfhtma86eywMtlw==
X-Google-Smtp-Source: APBJJlFkAYyp+s9q9bLFb8T/31ue3uIYuDobHMlvht4/2DJHVl3T6DgQ/McvCFjheIhHAb1pHCzC7gIyhsAbPLttygo=
X-Received: by 2002:a17:907:7787:b0:977:d660:c5aa with SMTP id
 ky7-20020a170907778700b00977d660c5aamr15744703ejc.31.1688477422199; Tue, 04
 Jul 2023 06:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lorenz Bauer <lmb@isovalent.com>
Date: Tue, 4 Jul 2023 14:30:11 +0100
Message-ID: <CAN+4W8h3yDjkOLJPiuKVKTpj_08pBz8ke6vN=Lf8gcA=iYBM-g@mail.gmail.com>
Subject: bpf_core_type_id_kernel is not consistent with bpf_core_type_id_local
To: bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I think that CO-RE has inconsistent behaviour wrt. BPF_TYPE_ID_LOCAL
and BPF_TYPE_ID_TARGET when dealing with qualifiers (modifiers?) Given
the following C:

enum bpf_type_id_kind {
    BPF_TYPE_ID_LOCAL = 0,        /* BTF type ID in local program */
    BPF_TYPE_ID_TARGET = 1,        /* BTF type ID in target kernel */
};

int foo(void) {
    return __builtin_btf_type_id(*(const int *)0, BPF_TYPE_ID_TARGET)
!= __builtin_btf_type_id(*(const int *)0, BPF_TYPE_ID_LOCAL);
}

That line with __builtin_btf_type_id is just the expansion of
bpf_core_type_id_kernel, etc. clang generates the following BPF:

foo:
 18 01 00 00 02 00 00 00 00 00 00 00 00 00 00 00    r1 = 0x2 ll
 79 11 00 00 00 00 00 00    r1 = *(u64 *)(r1 + 0x0)
 18 02 00 00 04 00 00 00 00 00 00 00 00 00 00 00    r2 = 0x4 ll
 79 22 00 00 00 00 00 00    r2 = *(u64 *)(r2 + 0x0)
 b7 03 00 00 00 00 00 00    r3 = 0x0
 7b 3a f0 ff 00 00 00 00    *(u64 *)(r10 - 0x10) = r3
 b7 03 00 00 01 00 00 00    r3 = 0x1
 7b 3a f8 ff 00 00 00 00    *(u64 *)(r10 - 0x8) = r3
 5d 21 02 00 00 00 00 00    if r1 != r2 goto +0x2 <LBB0_2>
 79 a1 f0 ff 00 00 00 00    r1 = *(u64 *)(r10 - 0x10)
 7b 1a f8 ff 00 00 00 00    *(u64 *)(r10 - 0x8) = r1
LBB0_2:
 79 a0 f8 ff 00 00 00 00    r0 = *(u64 *)(r10 - 0x8)
 95 00 00 00 00 00 00 00    exit

Link to godbolt: https://godbolt.org/z/jr63hKz9E (contains version info)

Note that the first two ldimm64 have distinct type IDs. I added some
debug logging to cilium/ebpf and found that the compiler indeed also
emits distinct CO-RE relocations:

foo {InsnOff:0 TypeID:2 AccessStrOff:69 Kind:local_type_id}
foo {InsnOff:2 TypeID:4 AccessStrOff:69 Kind:target_type_id}

It seems that for BPF_TYPE_ID_TARGET the outer const is peeled, while
this doesn't happen for the local variant.

CORERelocation(local_type_id, Const[0], local_id=4) local_type_id=4->4
CORERelocation(target_type_id, Int:"int"[0], local_id=2) target_type_id=2->2

Similar behaviour exists for BPF_TYPE_EXISTS, probably others.

The behaviour goes away if I drop the pointer casting magic:

__builtin_btf_type_id((const int)0, BPF_TYPE_ID_TARGET) !=
__builtin_btf_type_id((const int)0, BPF_TYPE_ID_LOCAL)

Intuitively I'd say that the root cause is that dereferencing the
pointer drops the constness of the type. Why does TARGET behave
differently than LOCAL though?

Cheers
Lorenz

