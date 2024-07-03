Return-Path: <bpf+bounces-33738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E920925687
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 11:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED74B25786
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 09:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E3C13D88F;
	Wed,  3 Jul 2024 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rmpoh9zf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00813DBA0
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998445; cv=none; b=S3BqVtWCBeiWjK7taNDIKLDTlzaRBkBn6G/cKqq9fU/IQ/mUREEdYavc8ngAFS+W5G+KPwv85Nj+KySGqQkNRmhxgTtNqbhh/UXmcuKn/8nhfX/Rd20GJbGurEtHSB+sqOU6BOkiSwFSRxnxF2S3IUeraGGMIFq9EvRrcvAourQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998445; c=relaxed/simple;
	bh=S0INpvXMyHNv4lgMH0zlFf0Oo754xqVpqqw7Ca0SCdc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SHqzeSKYqdu4nc6cPsth1eYn174CPWE+peMO1RUj0be7zTAlVYPHhYPMskWatfxRooVHthHZMjnpSSyrKmt4EWJgNNt7WOtb7T1Wq1+yfIjQHrFI/ph8HDae8L3+cjw5JPTflQbKc0J8TNjhPMr0r1Bf3eONOoZZ9HyV7QqlZRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rmpoh9zf; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-64f4fd64773so29873527b3.0
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2024 02:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719998443; x=1720603243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S0INpvXMyHNv4lgMH0zlFf0Oo754xqVpqqw7Ca0SCdc=;
        b=Rmpoh9zfoPYkxZNE4vM68PAqnZiGj1KzNrxGuuIbDPETHzld3LrWpUGBfgXDZj2nbA
         x05NfvdrdAsg0AdCfvORnYk/Yag3ibveWHOtIywvbrp5mHof9cGpawNIL9OZn99+wY7a
         xTaAQPcMRHdYvZ841fe/3nlJaeRDmUizLE2AG+xLZHbVmuOg7nVbwqGUvmknsyUm+6Oq
         OUmD6fzDTO+9TxzQzGVjdYdqcPCKPPiwB7hjYjqGxbudMbSAIzk9+OVQqxziCrbry/In
         HCocE2JWxAWZorvyuBk3navtW0YrjsWBJExkIu8FUnpXwHwDH/qkE8zbghacL25APVVO
         cuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719998443; x=1720603243;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0INpvXMyHNv4lgMH0zlFf0Oo754xqVpqqw7Ca0SCdc=;
        b=Lsbdavw6CStQEkBSeHygmf3LVvyRS5CrzoBHCKBfDV6iN37Zc37DRmaodN8xYTSLjI
         ZZLh3FTAswIkwfJdGo6scFOruXIKu5OEILyknapTn3nf3RdFAvB+NYmStkrrouI2xiCt
         +mL2GpeUU3x/B1DPTT1VGPmKgAm/MaA7cW2Qk0nvgNAJsvJmM/CjZTFca79CciXAE7e8
         brObuTJtUhp2vOIgwKkhkm6y2QYB3asv0laUDSSCqNFywW3E9Q7ywL985uw0dyqlwY9D
         fEDT64UPyFLE/hO1Zg77HAikxQYk9OIik26UjADqLb9vYUPFo4g27jFyaybD1QEi69zu
         I0xA==
X-Gm-Message-State: AOJu0YyVphsfF9z3X5QOtsYGizEF82OQO8jVndd/OAgG5J2Wvyf2md0c
	0b8xP/CGzkjtfdEYmrbEUBLnL6+o+rsVrfIqtK2rukLrrpAsBcwpBxOcK5gpE0ePBdCS4j8gV2x
	A8wQt3DyM9UWS6lsJrmlao0DY3E0=
X-Google-Smtp-Source: AGHT+IG4GD8e09qnzzVJ8s22bCm7y6e/6j3qYXTt7v2ZeoDVGrqi3ji4Xyqso3daXXUCmOj/GacQMSzoIgbBE+mwZR8=
X-Received: by 2002:a81:c60a:0:b0:64a:69c2:b6e0 with SMTP id
 00721157ae682-64c73229566mr127126877b3.43.1719998443163; Wed, 03 Jul 2024
 02:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Totoro W <tw19881113@gmail.com>
Date: Wed, 3 Jul 2024 17:19:09 +0800
Message-ID: <CAFrM9zuJ6ppS3BewB-4GaETfjshniL-m7DNaU=vQdjw=zhjLhg@mail.gmail.com>
Subject: Re: A question about BTF naming convention
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, Totoro W <tw19881113@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Are there other issues you see aside from the presence of a '.' in a BTF struct/fwd name?

Thanks Alan. There still some problems left I'm afraid, let me list one by one:

case 1:

[1] INT bool size=1 bits_offset=0 nr_bits=8 encoding=BOOL
[2] FUNC_PROTO (anon) return=3 args=(1 ctx)
[3] INT c_long size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
[4] FUNC test_panic type_id=2
[5] STRUCT []u8 size=16 vlen=2 Invalid name

case 2:

[1] PTR (anon) type_id=3
[2] INT u8 size=1 bits_offset=0 nr_bits=8 encoding=(none)
[3] ARRAY (anon) type_id=2 index_type_id=4 nr_elems=2
[4] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
[5] PTR (anon) type_id=6
[6] INT u32 size=4 bits_offset=0 nr_bits=32 encoding=(none)
[7] PTR (anon) type_id=8
[8] INT u64 size=8 bits_offset=0 nr_bits=64 encoding=(none)
[9] PTR (anon) type_id=10
[10] ARRAY (anon) type_id=2 index_type_id=4 nr_elems=1
[11] STRUCT map.Map.Def size=32 vlen=4
type type_id=1 bits_offset=0
key type_id=5 bits_offset=64
value type_id=7 bits_offset=128
max_entries type_id=9 bits_offset=192
[12] VAR entry type_id=11 linkage=1
[13] PTR (anon) type_id=14
[14] INT i64 size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
[15] STRUCT map.Map.Def size=32 vlen=4
type type_id=1 bits_offset=0
key type_id=5 bits_offset=64
value type_id=13 bits_offset=128
max_entries type_id=9 bits_offset=192
[16] VAR exit type_id=15 linkage=1
[17] PTR (anon) type_id=18
[18] STRUCT args.Ctx("path_listxattr"[0..14]) size=40 vlen=5 Invalid name

case 3:

[1] PTR (anon) type_id=3
[2] INT u8 size=1 bits_offset=0 nr_bits=8 encoding=(none)
[3] ARRAY (anon) type_id=2 index_type_id=4 nr_elems=2
[4] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
[5] PTR (anon) type_id=6
[6] INT u32 size=4 bits_offset=0 nr_bits=32 encoding=(none)
[7] PTR (anon) type_id=8
[8] INT u64 size=8 bits_offset=0 nr_bits=64 encoding=(none)
[9] PTR (anon) type_id=10
[10] ARRAY (anon) type_id=2 index_type_id=4 nr_elems=1
[11] STRUCT map.Map.Def size=32 vlen=4
type type_id=1 bits_offset=0
key type_id=5 bits_offset=64
value type_id=7 bits_offset=128
max_entries type_id=9 bits_offset=192
[12] VAR entry type_id=11 linkage=1
[13] PTR (anon) type_id=14
[14] INT i64 size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
[15] STRUCT map.Map.Def size=32 vlen=4
type type_id=1 bits_offset=0
key type_id=5 bits_offset=64
value type_id=13 bits_offset=128
max_entries type_id=9 bits_offset=192
[16] VAR exit type_id=15 linkage=1
[17] PTR (anon) type_id=18
[18] STRUCT args.PT_REGS("_zig_path_listxattr"[0..19],false) size=0
vlen=0 Invalid name

