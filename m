Return-Path: <bpf+bounces-21781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C708520BF
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 22:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D330289F77
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231454D5AC;
	Mon, 12 Feb 2024 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Wvu7yMKo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="xKgNCkLq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="M7EhgOb1"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155B64D108
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774386; cv=none; b=F7t4FCq5Mf/wBzkFfm267E9lpzHW1M7xpqGRuSxH8BEGBhpEVhw+/Os+1qIF6cc3huNRcEwrlxCu25Idsb3pf2xio6Yc+DRkIDWTq6C5z5db5QfuSgdbQHPiKp8e1iaVhFLXuODrJ3VNRhKHUf+yKMTBlYxw4nHlkdAyIlv+V8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774386; c=relaxed/simple;
	bh=9+Y6azJ/V4I7B8saxoFgJd6urNQPrh/7Z5ZQsM+FoHI=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=Ky1LCGCwprTvOJKY8bTRGT8VgU7iJ1FusGXY6Hg2cFRQdY1/23ma1LbQbScP4ndp7hkgHDSPVya+JWggXhT8ipgOqiDhis9t11uxcYp4mgZnLHBiO7HVeaEe77IDLDB7nLgOUM0WTXYa2M+DTStR+1PMv4SadAQ2FzEogdCY9Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Wvu7yMKo; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=xKgNCkLq reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=M7EhgOb1 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 75C74C151989
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 13:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707774383; bh=9+Y6azJ/V4I7B8saxoFgJd6urNQPrh/7Z5ZQsM+FoHI=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wvu7yMKoIox9UC7slw7GYUOmcGjoFX3/yfUs8av68OUVLChyi29XefU/FREgqGG9Q
	 svy+Dt4rmyQkTm5Tb/60BG+e/LovcWeXo1EqQCFG2mcNkjZMY3aNuRX2qdz88m3FI/
	 mXLqPQIi2g8Xle4VPKOhZaQ21BkVWjFWqcNE83us=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 49769C15153E;
 Mon, 12 Feb 2024 13:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1707774383; bh=9+Y6azJ/V4I7B8saxoFgJd6urNQPrh/7Z5ZQsM+FoHI=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=xKgNCkLqlHXfio+AYWkaodXRv3Ig00D/gQnDQlIwSeDOj4e7spyrGapAJ98YDvYIF
 rsEabgzy4VK0wd8geOCH0VXJPTbjFx0EY5N3HeR0QU3TTN72xXrEmPZu1bEU06wbwY
 3qQYMuqXs2VQJoqLirr+9AjM1xuXZUeD0x8jtW3g=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E913AC15153E
 for <bpf@ietfa.amsl.com>; Mon, 12 Feb 2024 13:46:21 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z77mruybGyUt for <bpf@ietfa.amsl.com>;
 Mon, 12 Feb 2024 13:46:18 -0800 (PST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 1EA62C14F697
 for <bpf@ietf.org>; Mon, 12 Feb 2024 13:46:18 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d958e0d73dso25495165ad.1
 for <bpf@ietf.org>; Mon, 12 Feb 2024 13:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1707774377; x=1708379177; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7b8oQHvPmmpHC6nkZrlO2bj8ebBa3bkozc9kVETTD3k=;
 b=M7EhgOb1hzNCaSF7pdOGQkeTN5JsC/x3MNItOGBndzYJdQ9KqHXS2vNY/b59jnzXxQ
 sBOf9+Yi+gGQd77az2vkmKbwz0C7ShusXKqltZSW7p3beHVdeQlhSYV+pbKe0MyOtC3Z
 4vi3J/n96c72g/EYCyxBF8mdiEu4iCk/BI1phcy8k3O3oj9qMW0UMxf55YzGkN+zTInz
 W+sxRKgXgkf9tRYC7JSP6LF1yTOkisjysZjUPmN6T+lOaNIq4NtsGYAAoag/Ivw6Ah5h
 kQ+XNbw2aN2V0jKR/VPCq8TZk6FuZvnCGb62HYY1gva4iv/Sc/A1SOjO3Mq/z1ZXB/Kf
 udlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707774377; x=1708379177;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7b8oQHvPmmpHC6nkZrlO2bj8ebBa3bkozc9kVETTD3k=;
 b=jPjvCM6jhD0zPj+oAuZIhP6ERNLuLBwf0cigEQsZtiDv4hrLVmTV0NWdY0P9Sr8hgP
 0A3a8YYcxLZkZaqmXgHc9HYnmALNhS/IxAw8RbNp/9RmLQtaPuUKNGKkuH4w3drqo/Vk
 c666JrEMcqw5l/gGxKUhpjVU6/8eqkWuZgKRCT1/sa8N4j4OZm4j7oDBhnP0FmCSCdcF
 P6nG9BJf52g4TaG9JfdsMLLsz7rhaD5WC3YI6AyxjEgaeZgfwHBy1v6p8Tb0/qM7OiTm
 /NygoxdaZPlYP2J/jD0XGcAXGxaVfO+NTOiv8IhSTVc3mMxoTIDkR9LuUjIC/uFm2rU+
 6wDA==
X-Gm-Message-State: AOJu0YxVMUGQfW6ktIUiu9tUzOQtlFUYtGEwXkBjozxSBQzkr32smgsv
 enfvVu9QmACH/LpCt1TRi5fPPUPLrmGtISxdxTbjQtR+5QqsN0VROFkeH1h+s9g=
X-Google-Smtp-Source: AGHT+IE/aYEhMtzBCFt6/HKo9p25Zux4aLLPKq1+Iz1f51+Nt27B6YNGA3E/y6265E6FLEH9vKEY9g==
X-Received: by 2002:a17:902:f54e:b0:1d9:2e9d:8cb6 with SMTP id
 h14-20020a170902f54e00b001d92e9d8cb6mr854298plf.15.1707774376831; 
 Mon, 12 Feb 2024 13:46:16 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXontZZQOGvOnVfAKhHq/FlM20tBrtCvC8Tj4QKbKKMWg9XTwJCI3X35VP3T/L2esYiGbkj1n7PRlAzwPg=
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 o13-20020a170902d4cd00b001d7273e380fsm779462plg.153.2024.02.12.13.46.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Feb 2024 13:46:16 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Jose E. Marchesi'" <jose.marchesi@oracle.com>
Cc: <bpf@vger.kernel.org>,
	<bpf@ietf.org>
References: <20240212211310.8282-1-dthaler1968@gmail.com>
 <87le7ptlsq.fsf@oracle.com>
In-Reply-To: <87le7ptlsq.fsf@oracle.com>
Date: Mon, 12 Feb 2024 13:46:14 -0800
Message-ID: <036201da5dfc$e7289830$b579c890$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKk5nBwvPPKgL8m8zzpY/2G4YK4bQLYE4TWr1tq/TA=
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/i3JzXr1fZy1lxaKTUb_K1HNGfAg>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf,
 docs: Add callx instructions in new conformance group
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

