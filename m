Return-Path: <bpf+bounces-13717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2E87DD0CC
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 16:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C7C1C20CBB
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 15:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAA91EA8A;
	Tue, 31 Oct 2023 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="KRIYkP8p"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC0D1DFD0
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 15:45:09 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10456E4
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:45:08 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c3c8adb27so869964266b.1
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1698767106; x=1699371906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R9Ynytq8VRUt1Lp6w2HsLsbIh1qnDGn7Vgx8wutqR44=;
        b=KRIYkP8pS/37AIKYhqsntZqSG3qlBu44YT38CsFN/3hi34zYqsgMvdq67j5blOwjoe
         XIBsb5+ZvnRkU71ng8i7qMBjz2Kj9ocKgS16JXB+qC1ECR0eOPSAe+9EQ2X7YNRKHoQv
         ihaV6LTrn8a03E+bogTD8yLbPBD+PLebr5sFf4Pshtftps1tmztXwhNDosN0pR18/3p9
         P0QC+N/Vyc9cSnTT7Otnq21xoRw+bHnnIfI0Pav34XAv7uRUMxG3HWdqx8aVXer+FQJf
         QhjoK0B7/bK7Iwu1vsqnHBClmOozCLhfsasjnSC/qwoY6IEn2mGayhMOC+u2YpE7MB40
         t5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698767106; x=1699371906;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R9Ynytq8VRUt1Lp6w2HsLsbIh1qnDGn7Vgx8wutqR44=;
        b=VYpDIuL6mNla+pCO/NDSX+4TuaoBwArHygUn3fyFahDzPMW1T1yc1UpAWGpXmnU6Pk
         /O/1oK9NTdGAHlriiruATrPYsgfTZHkiK9TKVwDYEQTvMyMAsq7hlvBmVLIaHINng57K
         Nrcf9icgNH9grRCn/iGSClJqQXJXGiQCrvgsqj/zBmNaQldl6Qpn965aZXKW8HTwcBcN
         qc4IVoG6UYl5jHFF0zpXmUrSYunf/PFnPJiG9xNJqxaS8p88dSw/zVjPr7x6d9lSGvIw
         uw+CaKzcUnYxFUwyVb+RE5TJMxA+RlZ0cmNLzrEmzlJOR1x5bYTsDeqKJBnmDbOmuH7Z
         TEkw==
X-Gm-Message-State: AOJu0Yz5WY5rgKeOKdGWdOVNcB04pKIAq0XoSvvf8CGbrkjszCM/olVX
	zevjOVEZGbVdS9n0s8ba7oPZ30qRaNJtrkxBc02bOQ==
X-Google-Smtp-Source: AGHT+IECAbb51klroqXAhl6Or5Y3IAQC4EJ+jy9vj90Jt2DfCCkgKL/6C40rBBRFbIhtnGqMc7c5T4zjmRY4ndU0OKU=
X-Received: by 2002:a17:907:608c:b0:9c4:41c9:6ac6 with SMTP id
 ht12-20020a170907608c00b009c441c96ac6mr10889600ejc.33.1698767106199; Tue, 31
 Oct 2023 08:45:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lorenz Bauer <lorenz.bauer@isovalent.com>
Date: Tue, 31 Oct 2023 15:44:55 +0000
Message-ID: <CAN+4W8i=7Wv2VwvWZGhX_mc8E7EST10X_Z5XGBmq=WckusG_fw@mail.gmail.com>
Subject: BTF_TYPE_ID_LOCAL off by one?
To: Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I think there is something weird going on with BTF_TYPE_ID_LOCAL. A
call to bpf_obj_new is getting the "wrong" type as an argument as
emitted by clang into the instruction stream.

Compiling local_kptr_stash.c from 6.6 selftest with clang-16 and
clang-17 yields the following disassembly for the stash_plain function
(source is at [1]):

00000000000001b0 <stash_plain>:
...
      64:    18 01 00 00 1c 00 00 00 00 00 00 00 00 00 00 00    r1 = 0x1c ll
      66:    b7 02 00 00 00 00 00 00    r2 = 0x0
      67:    85 10 00 00 ff ff ff ff    call -0x1
          ; bpf_obj_new
...

This is looking at local_kptr_stash.bpf.linked3.o specifically, but
local_kptr_stash.bpf.o has the same problem.

0x1c being 28. From bpftool we can see that 28 corresponds to a FUNC
type which doesn't make much sense to me:

[28] FUNC 'unstash_rb_node' type_id=15 linkage=global

The source code actually passes struct plain_local to bpf_obj_new,
which has type ID 27:

[27] STRUCT 'plain_local' size=16 vlen=2
    'key' type_id=16 bits_offset=0
    'data' type_id=16 bits_offset=64

I'm guessing that this works in practice since the CO-RE relo in
ext_infos actually carries the correct local_type_id:

CORERelocation(local_type_id, Struct:"node_data"[0], local_id=18)
CORERelocation(local_type_id, Struct:"node_data"[0], local_id=18)
CORERelocation(local_type_id, Struct:"plain_local"[0], local_id=27)

1: https://elixir.bootlin.com/linux/v6.6/source/tools/testing/selftests/bpf/progs/local_kptr_stash.c#L76

