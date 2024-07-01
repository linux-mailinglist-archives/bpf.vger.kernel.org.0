Return-Path: <bpf+bounces-33463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4322191D6BA
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 05:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8EA28268B
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 03:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A5A171C9;
	Mon,  1 Jul 2024 03:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqETq82E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2372F29
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 03:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719805898; cv=none; b=fu//aW769uU029MoICjVk6jppJCTNmTls8pzQrb51RujVMKMs5QX59PylyIfVZBuWGNd1mc30gg96K/AA3/7HemaY2Fkd0OofvEUFloC+KtE2QA2YQCExPiqlBL+iWAuYi/Y18+dh0+4W9CB2LDQsHSC/rU7MHJuAmqwaFUd/tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719805898; c=relaxed/simple;
	bh=XhAkEfPkrmw6Gq18w+kYMVWmGesxQTAjSnmCvKvhdEs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EwO1HRjQ1CK/1ZGb9WTeG4SIjbrum6e1QuMNNXjdMnv/BbhtJZkr8aXE9l/VyR4j7B2I5axj1vvZE9FjWL/U/+zczLEpfSeYWe7MFGuwuByMK83a9Add6H0kLqO7vzFy3L3/I9xS2AHuXw1D8uYkGSYw5LbyP4KKJkcKD1QBBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqETq82E; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-64361817e78so23749057b3.1
        for <bpf@vger.kernel.org>; Sun, 30 Jun 2024 20:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719805896; x=1720410696; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Smnk95iEQeeknKiapz91K3iPQ2cU7pDByvmM22TJzUg=;
        b=FqETq82EIOCzPPq1CX1obqYWCJEMjiANC7HcEfyH5cjBFR4ZvkqmhjJyDXBa5PaiAR
         dgF5raxY9ZIGGSCDJmbO2WgZAsAgHyAHMhMkvgI91hViAK4DIQZFRNzmRo7HE7Ro9MtE
         8gRoEpAz1n/3OjdR4l2txlNCy4AYR7LM2gU9iKO19gmXKR4xZTeFk26dNU64JZx4NaRB
         JGTDDcEahotsu19YGIHiUW8Dmz3xo3by0J+lUmf4bX83Ji41DxOv8xEjhtrXwganMdBj
         wchl8GW2IZ9Mf+fGgRKRK0x7bwaJ+/bXK/6Uw0KcvU52dlZkLW7sN0n+cMGV6bTg2rBv
         Krqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719805896; x=1720410696;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Smnk95iEQeeknKiapz91K3iPQ2cU7pDByvmM22TJzUg=;
        b=aWK/7yMBYMsMycQnaEy7F2Gud73anxl+n11wqmfYCueapsIBFBLfnQaly5yBFaEEWn
         SnmMbwYf9N88JZ0Vr1OZQ/RLINSdVU9bFMl3U2skKSzoNzkmcWaQZ1lCdhc7Nakhtn0f
         Zne1xVc/68KfuuwSQYgQgI/MMeTvoGUGpLBo+Zx+U3eSaHTfYCTaJMKOJcDhdszxD6ER
         Cb8if7EEWYTTP9uVEGrHz5ihw4RVPtocGgS0Mav2SQNc6/A1PLeWWLY5pIJJ8RCh5nWI
         i/6jcsiTA9kNc2PAop4lLdZN9ayilO8HR7t67MRhB68atMVWCNP+yxqDsoLuhLWE54oS
         kJrw==
X-Gm-Message-State: AOJu0Yz7wG8hio7Uj5SbUDwKy/w8kFJEqW56I5w88xjyBAWP3tDPvyR2
	de7NHzKaRJvdsmL0srqMq5gF+sQocRqyXseWmPKxy1+kzGuIT4K8wFh4ofb7aYgfgB8SGxgTNRl
	g5JvoAHWPg0bUcALc0Bgq2JXxNZY=
X-Google-Smtp-Source: AGHT+IECFR0+4WqWBYLZtvJ4Bf4r9KgHeSfl7nKpN/u7IASiHmmT/g4WMBYrmIAutFeg6S/FQWZqcr55wgEPb0bahDU=
X-Received: by 2002:a25:18d5:0:b0:e03:5445:97b7 with SMTP id
 3f1490d57ef6-e036eb1f5femr4385680276.7.1719805896080; Sun, 30 Jun 2024
 20:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Totoro W <tw19881113@gmail.com>
Date: Mon, 1 Jul 2024 11:50:04 +0800
Message-ID: <CAFrM9zsz-FLK5pJW1rL_k8YRqWPafYV3H0L1PGJxXo5YYttkVQ@mail.gmail.com>
Subject: Re: A question about BTF naming convention
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, Totoro W <tw19881113@gmail.com>
Content-Type: text/plain; charset="UTF-8"

You're right Alan, with the above patch, the type name for the pointer
is gone, here's generated BTF the same program:

[1] PTR '(anon)' type_id=3
[2] INT 'u8' size=1 bits_offset=0 nr_bits=8 encoding=(none)
[3] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=4
[4] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
[5] PTR '(anon)' type_id=6
[6] INT 'u32' size=4 bits_offset=0 nr_bits=32 encoding=(none)
[7] STRUCT 'map.Map.Def' size=24 vlen=3
        'type' type_id=1 bits_offset=0
        'key' type_id=5 bits_offset=64
        'value' type_id=5 bits_offset=128
[8] VAR 'events' type_id=7, linkage=global
[9] PTR '(anon)' type_id=10
[10] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=2
[11] PTR '(anon)' type_id=12
[12] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=1
[13] STRUCT 'map.Map.Def' size=32 vlen=4
        'type' type_id=9 bits_offset=0
        'key' type_id=5 bits_offset=64
        'value' type_id=5 bits_offset=128
        'max_entries' type_id=11 bits_offset=192
[14] VAR 'my_pid' type_id=13, linkage=global
[15] FUNC_PROTO '(anon)' ret_type_id=16 vlen=1
        '(anon)' type_id=17
[16] INT 'c_int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[17] PTR '(anon)' type_id=18
[18] STRUCT 'perf_event.test_perf_event_array__opaque_478' size=0 vlen=0
[19] FUNC 'test_perf_event_array' type_id=15 linkage=global
[20] FUNC_PROTO '(anon)' ret_type_id=21 vlen=1
        '(anon)' type_id=21
[21] INT 'usize' size=8 bits_offset=0 nr_bits=64 encoding=(none)
[22] FUNC 'getauxvalImpl' type_id=20 linkage=global
[23] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=3
[24] VAR '_license' type_id=23, linkage=global
[25] DATASEC '.maps' size=0 vlen=2
        type_id=8 offset=0 size=24 (VAR 'events')
        type_id=14 offset=0 size=32 (VAR 'my_pid')
[26] DATASEC 'license' size=0 vlen=1
        type_id=24 offset=0 size=4 (VAR '_license')

