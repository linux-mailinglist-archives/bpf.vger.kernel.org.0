Return-Path: <bpf+bounces-21780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A718520BE
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 22:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B7A1F22F7F
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C304D9FB;
	Mon, 12 Feb 2024 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SgpIFYek"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B64481AD
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774379; cv=none; b=bzQLI3LihgjFc5/XLVFHuDjkQZ4NtjuE7L8Ln8E7u0II/8BzUwM7eGZ6cP+hqV6KbSvY8/3citBEIxxa64QJ3FkjtHygR7Y5hMXdeDnP1lWr072Rj069rxFD9O1ok+Zo4Jl3A2Pm/QWTb3wr2Mz1gNTZcubtjqglM+tjaSzpfoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774379; c=relaxed/simple;
	bh=CcoAjggYKOmdkw9dbrLyOMzH+E4fpkgQNpxeq4XYgfw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=UC/cskmvQwh3z1OJkQfQXovLZ0g7bBaeoOLc43UMaN6ReioChkvHJz85zgNxI/bRCVuJ1/S7tM229lZ4dvWIXAMx+4NBDuUnk/PPQC81SZO0g5qurhQUO7VJpxWovQrE7IqAj2wecXH0zaeX/Sj0ZwrecAVVq9Rr7D2F6Jphxv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SgpIFYek; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1da0cd9c0e5so26287355ad.0
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 13:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707774377; x=1708379177; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7b8oQHvPmmpHC6nkZrlO2bj8ebBa3bkozc9kVETTD3k=;
        b=SgpIFYekwdDLFY1WTc9ujJtGNYhvlZGCG4wbnEHmv6ee6FZHTxLVvDgddjbnxs9BXQ
         OyNyXMDo8+22UQWc8uo6I1coylw35x9fvrBBsDhrwraXQiofDrAG9p1vviRbnGArwySf
         8YPM7OMAeplHv4WZhdxHkKZ9wzvjwGQEyTXGuYIERGlUFX+rvM9x7XvTx6rMesHFHqGe
         5VyOvqfHpbsKRvwIbQedbzzGu3M8njnrzUE2hzJYg8aEVfOCH7AmkE5ROBmpi2AfjYc/
         onCl2PFI7+EeBAzSvlYn737NH3nXGUkomxCzAeF0CO01Jvbux53rRwGE6VGACCRh2b4p
         Ehdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774377; x=1708379177;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7b8oQHvPmmpHC6nkZrlO2bj8ebBa3bkozc9kVETTD3k=;
        b=OCdzcxGiy7kIIZZhJW4AnW1/kfU0kHaiTjWRJTZEvy8qzZkT5KvorAxomK1co67rwe
         c4Uo2nn5XE5Mw09plcn5EMaNzKEeLq5Pe99jIrYWy1zebuY0VfFthJ9QKTkwoP2xJV4w
         qlE3fBAtw7jV8LnmvOhML/exOo8SILwlu0fWxSX75d5Jj9bfZF+qUg4YYKFIk2NEjZq7
         h442bQ8JhJIZkyLgmMVDAwICOueD25/GFQZXiZS+J2Fk6QNaWyylt21sl+dlcJLoS5X4
         pmhGiPSzhUug1JduuenJn9+Af88cfFfwLqyf8pVS9tDOEfG0q908p2gn/TwQP7DZ4LHs
         tokA==
X-Gm-Message-State: AOJu0YymOg8b06yofu46OX9GoKxvmcD2r+xQkfC521+VLq28TBZfzKOH
	FlJ0eRFU/TQ0IU69kqxX0WsNjAwaz4389iSrEUFcNAvKDu/TGAYCreAq4iaF/I0=
X-Google-Smtp-Source: AGHT+IE/aYEhMtzBCFt6/HKo9p25Zux4aLLPKq1+Iz1f51+Nt27B6YNGA3E/y6265E6FLEH9vKEY9g==
X-Received: by 2002:a17:902:f54e:b0:1d9:2e9d:8cb6 with SMTP id h14-20020a170902f54e00b001d92e9d8cb6mr854298plf.15.1707774376831;
        Mon, 12 Feb 2024 13:46:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXontZZQOGvOnVfAKhHq/FlM20tBrtCvC8Tj4QKbKKMWg9XTwJCI3X35VP3T/L2esYiGbkj1n7PRlAzwPg=
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902d4cd00b001d7273e380fsm779462plg.153.2024.02.12.13.46.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2024 13:46:16 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Jose E. Marchesi'" <jose.marchesi@oracle.com>
Cc: <bpf@vger.kernel.org>,
	<bpf@ietf.org>
References: <20240212211310.8282-1-dthaler1968@gmail.com> <87le7ptlsq.fsf@oracle.com>
In-Reply-To: <87le7ptlsq.fsf@oracle.com>
Subject: RE: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx instructions in new conformance group
Date: Mon, 12 Feb 2024 13:46:14 -0800
Message-ID: <036201da5dfc$e7289830$b579c890$@gmail.com>
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
Thread-Index: AQKk5nBwvPPKgL8m8zzpY/2G4YK4bQLYE4TWr1tq/TA=
Content-Language: en-us

Jose E. Marchesi <jose.marchesi@oracle.com> writes:
> > +BPF_CALL  0x8    0x1  call PC += reg_val(imm)          BPF_JMP | BPF_X
only,
> see `Program-local functions`_
> 
> If the instruction requires a register operand, why not using one of the
> register fields?  Is there any reason for not doing that?

Yeah, the reason is because this is document what clang has done by default
for a long time now.  The IETF WG charter says:

> The BPF working group is initially tasked with documenting the existing
> state of the BPF ecosystem

So extensions can always add new instructions and deprecate old ones
but the initial version of the ISA needs to document "the existing state
of the BPF ecosystem".  I know gcc used a different field but one has to
go out of your way to specify a command line option to get that to happen,
whereas clang uses callx as documented when you don't do -O2, without
requiring any extra command line options.

I agree with you that it would have been better to use the src register
since the BPF_X bit is supposed to mean that, but that ship apparently
sailed long ago with clang.

Dave


