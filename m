Return-Path: <bpf+bounces-20753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744BE842ADF
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 18:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B09285BFA
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 17:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F391292DC;
	Tue, 30 Jan 2024 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kio2Kk3s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF0167E88
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635661; cv=none; b=pJC4Z8Ehvu7Ab27cK3DFNKUViF1LmnEzClNJwFcrDQp/je+l6TcOBuciVbPev3godY4VDuSAsQ7rwzVLwpdk7qq0yfZTVKUphEcPFu+Gqxg4o5iqviv+6DXnsI/ZcZlLtLw6tNj+opNQFNndG1/WCXbJZqZ1ViBaW3cBMfzbGzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635661; c=relaxed/simple;
	bh=8HlImFzLx7SehWFMyYsWJ+dgW5VIHkXGomQDi1zpqMc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I3/MW+XcMAw7Ki7S+ZNTMwodXQ1EuUJiWBOi8/nSmN6fBMTbEiZY5iPn/QcUWAUVTUmn5TLL0d9GRyfkcRVbJZftHRzrOQuPumSSCfaN9cEYycushD2IrZ40En0nEargmnBB7UJXnDPGjdTamj5oUyZA0wSUmPYlxB5uS2T2K+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kio2Kk3s; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so1873103a12.3
        for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 09:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706635659; x=1707240459; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9F7EALf2gYWxPbKNSGKMU2hL0Yhx5L3Q6w99eWQcjro=;
        b=kio2Kk3s70kgzIaztzeErHtV8sZWC/1CCgwkca0D2fpYDk4CDtYrC6l6gmqjaRfo0i
         tw3nBlUp2E1NrO7Wb2LlW0b11tUw1dv1WWBOR3e0n2CZXdj5pIfTJ91O2e51iqe92CMz
         iDV0h8EPb/3R2+YJDQEjTfjus+u9Wt0kuzNADSJkVKpPm0WOIwYP7P/q78PPvQSphu+7
         AI1QshrhXBIoyDffI9+ZbwG1NO5hOjsSA0O4Oz6SXsqWDWZ49lA0TT7dAyJQFhIrJnJ5
         ZbeQbhWYWqjCpaR/b16XYLuNpWqbCNGC8IUlDOkZmyYovKtPtPVqBSKVGi1sjGfcQasb
         4QeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706635659; x=1707240459;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9F7EALf2gYWxPbKNSGKMU2hL0Yhx5L3Q6w99eWQcjro=;
        b=kCk5A86iTUm5tlwuaHXTv2dIaoXA0mq8OBOFArUQwKushjlR59RjoG33RQAvOx5U6k
         ATt+qfYGgpbq3A1b5KVMlTQpHpeFOdAaNQzT687WbkUU3WP43G7dNI1q/vsDPa/H+NQ1
         TNiEA/fpq8W3VPb5EXCL/kmpwFRaPaTq+9WqxfV+d2iLeUUnUE4nkY+sPt/bFzSIaJ8c
         4qo9UTSw4SZcfh9mY3n5F+3xg00sq2Nvnt8rPR0vdIXlDFuVfcEQ4TXcCLVYfTmkdSDl
         ferpn1uYLsn6BrYHD+2PZuQ1SOC2XkUCm//N+xWJ7UYuxkw1Vq1JbPg8+89ebNMvFmNg
         ka0w==
X-Gm-Message-State: AOJu0YwJRYPJGu8kXP9LK2eQdY9X5Ugnz6cokkSu+dNe+arJ7cy4pmvx
	MmifmifvDd49Lg35/ttBD5liqBCbyArD5bJ+NwXFhWiSu1FYPCXOJPiwrEGrMhA=
X-Google-Smtp-Source: AGHT+IG4EGrzvcMtmwAXP1ze5GvGEX5ZCEel40w6VH2UXLOSslITdPqgztEQyjpSKZWn2yDxkoU9GQ==
X-Received: by 2002:a05:6a20:d488:b0:19c:9d37:ec59 with SMTP id im8-20020a056a20d48800b0019c9d37ec59mr5955721pzb.28.1706635658825;
        Tue, 30 Jan 2024 09:27:38 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id m1-20020a62f201000000b006ddc03c425bsm8004664pfh.180.2024.01.30.09.27.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2024 09:27:38 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'bpf'" <bpf@vger.kernel.org>,
	<bpf@ietf.org>
Subject: ISA: BPF_CALL | BPF_X
Date: Tue, 30 Jan 2024 09:27:36 -0800
Message-ID: <076001da53a1$9ebfa210$dc3ee630$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AdpTn/i/+Jdzpl/jQ0iLyOHFFXfaaQ==

clang generates BPF code with opcode 0x8d (BPF_CALL | BPF_X, which it calls
"callx"),
when compiling with -O0 or -O1.  Of course -O2 is recommended, but if anyone
later
defines opcode 0x8d for anything other than what clang means by it, it could
cause
problems.

On the BPF_MSH thread at
https://mailarchive.ietf.org/arch/msg/bpf/ogmS9qFhdBCxC4VrOWL7nzjSiXU/
Alexei wrote regarding BPF_ABS and BPF_IND:
> DW never existed in classic bpf, so abs/ind never had DW flavor.
> If some assembler/compiler decided to "support" them it's on them.
> The standard must not list such things as deprecated. They never existed.

Technically BPF_CALL | BPF_X never existed either, so can be omitted from
the IANA registry.  But given the widespread deployment of clang's
use, and the WG charter statement:
> The BPF working group is initially tasked with documenting the existing
> state of the BPF ecosystem
I could see a potential argument to list it as reserved or something.

Today, the document doesn't reserve it, so it's open for future use for any
purpose.  I just wanted to verify that the WG is ok with not listing it
in the IANA registry, given the above information.

Dave



