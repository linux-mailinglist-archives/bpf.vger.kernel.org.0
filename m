Return-Path: <bpf+bounces-20510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF5183F479
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 07:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58551C20C68
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 06:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B62C8F6F;
	Sun, 28 Jan 2024 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YWawXNB3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88CC129
	for <bpf@vger.kernel.org>; Sun, 28 Jan 2024 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706425187; cv=none; b=fwl6gPVdIjFWYebHJYrDUC615Urbv+cnuU7kEWv1auQfvaw2A9Bq9sqU/Oi0i+XKTM5TKpl4ozfu/oOHB4elvjv7TX9ItRGCohE17vM2pWPtqzbd+HNwEUT+vtOE+v7kQrJS4QvN2ohyWx21BwMNL4PG5SHIDLNz6cnPU3lpQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706425187; c=relaxed/simple;
	bh=NaCwsG5QOBlwTlbHfHTJmaegkuowtS4+kn6xU6WIBZ8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=mnkHHZIDaZTeJ5qUQcoGleiS8SlVgjJOWblmN9m+bassB+K9ccvhavquW5kfFQg3JngrzguG2QaV6tZZfLiz1ZavFKyi37qU/eS4d3GFVOPpL9YO12FcrTUVC8Ut+bEZlslHqsk52GZXB77dRiYrUpWwd1tA2IgLhVrrsEjBsn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=YWawXNB3; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6dddfdc3244so1457414a34.1
        for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 22:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706425185; x=1707029985; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LnTcYNWq7DAEeU1tM0wmF+emUDgfwFMcdllxqKIluCs=;
        b=YWawXNB3plwSvlSqN8dd1P8n4Gln7e9yZ6y2kAW3H9XJl3M/2HC7LEdTByoWrwU+zn
         qjhaelr0TfJ0jIjoRMZgdKkaVQETDSV4aqByd0s6Xi/V5mkpQaBq8QFzoBDkU2yQrhR1
         Dv2dPbqYvFGHnf6bGiICgyeogcEabaOuJFEULzzPjrcWo4ObjT8bDNq0ur1+jeR6VxaJ
         EtCESJvs12msY/WpG/42tewKTHV1uzOMMRFWZc8Hw+Tk//DNDy9dqc4b0C4Xi8u/6QZt
         SFC9tzN37G80fF86NS6gTqdYADYEyyIrC1x6NKVx8gDVOYNeWyeRhUJ8LsPFPlogoYuB
         oLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706425185; x=1707029985;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnTcYNWq7DAEeU1tM0wmF+emUDgfwFMcdllxqKIluCs=;
        b=OYgvsrD7hDF484svyYbGtmcExNqA+yoNPOy9deS6XhGmUvbQqFE11tSkbXaqh4eLzJ
         GPl+FU5lS1CGrnes2FqnbaN7yLMo3iXpj5t1tdFIywtEkW9SxuTDDCQzn7qC9Inn4Suu
         DTxDbbqXn1BWRTUdUKR4/VDvsL+Ym3BwfMCMFN5jVbcS2k7Cq7VMQcz6rMiusnv3QmXt
         /hWRmUNU5QH0IC9NBCfkRb9D0WC+sJatn+pN41wjpW9gw4C5Sb+gfB2/Uh6XZ9CAdBxk
         30tau8LOrpuUG14/zUKNIOKMiL2JboSp1045sw3Q+/jyMQG+nuQl9nk/R8DTloEnhNfe
         o7sg==
X-Gm-Message-State: AOJu0Yx3hNwgIIilN4XjhCf5pRMB4g5rUxGag8nuntCPA8s2uIxWGCvu
	EzuS2niFqfWushXkTdrGc4p5bhgLI4Kq2ffHnuPyxqvAZHCk2BeJ
X-Google-Smtp-Source: AGHT+IFhSSJlMCW/eNyRwYplY3bRD3XWSaAffF+N+EdEL7ZGvhdMXezBtXwy/TpABU7zOnHgY1Js0Q==
X-Received: by 2002:a05:6808:308c:b0:3be:307f:eeb with SMTP id bl12-20020a056808308c00b003be307f0eebmr1864221oib.26.1706425185176;
        Sat, 27 Jan 2024 22:59:45 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id u33-20020a056a0009a100b006ddc335ab6fsm3664876pfg.158.2024.01.27.22.59.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jan 2024 22:59:44 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Jose E. Marchesi'" <jose.marchesi@oracle.com>
Cc: "'Yonghong Song'" <yonghong.song@linux.dev>,
	<bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <006601da5151$a22b2bb0$e6818310$@gmail.com> <877cjutxe9.fsf@oracle.com> <8734uitx3m.fsf@oracle.com>
In-Reply-To: <8734uitx3m.fsf@oracle.com>
Subject: RE: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
Date: Sat, 27 Jan 2024 22:59:43 -0800
Message-ID: <01e601da51b7$92c4ffa0$b84efee0$@gmail.com>
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
Thread-Index: AQI/mTVZUZpeNhzShIl9oGl01BkM9QGkD3DnAsdGbrqwAOEW8A==

I asked:
> >> What about DW and LDX variants of BPF_IND and BPF_ABS?

Jose E. Marchesi <jose.marchesi@oracle.com> wrote:
> These we support:
> 
>   /* Absolute load instructions, designed to be used in socket filters.
*/
>   {BPF_INSN_LDABSB, "ldabsb%W%i32", "r0 = * ( u8 * ) skb [ %i32 ]",
>    BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_B|BPF_MODE_ABS},
>   {BPF_INSN_LDABSH, "ldabsh%W%i32", "r0 = * ( u16 * ) skb [ %i32 ]",
>    BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_H|BPF_MODE_ABS},
>   {BPF_INSN_LDABSW, "ldabsw%W%i32", "r0 = * ( u32 * ) skb [ %i32 ]",
>    BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_W|BPF_MODE_ABS},
>   {BPF_INSN_LDABSDW, "ldabsdw%W%i32", "r0 = * ( u64 * ) skb [ %i32 ]",
>    BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_DW|BPF_MODE_ABS},
> 
>   /* Generic load instructions (to register.)  */
>   {BPF_INSN_LDXB, "ldxb%W%dr , [ %sr %o16 ]", "%dr = * ( u8 * ) ( %sr %o16
)",
>    BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_B|BPF_MODE_MEM},
>   {BPF_INSN_LDXH, "ldxh%W%dr , [ %sr %o16 ]", "%dr = * ( u16 * ) ( %sr
%o16
> )",
>    BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_H|BPF_MODE_MEM},
>   {BPF_INSN_LDXW, "ldxw%W%dr , [ %sr %o16 ]", "%dr = * ( u32 * ) ( %sr
%o16
> )",
>    BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_W|BPF_MODE_MEM},
>   {BPF_INSN_LDXDW, "ldxdw%W%dr , [ %sr %o16 ]","%dr = * ( u64 * ) ( %sr
> %o16 )",
>    BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_DW|BPF_MODE_MEM},

Yonghong Song <yonghong.song@linux.dev> wrote:
> I don't know how to do proper wording in the standard. But DW and LDX
> variants of BPF_IND/BPF_ABS are not supported by verifier for now and they
> are considered illegal insns.

Although the Linux verifier doesn't support them, the fact that gcc does
support
them tells me that it's probably safest to list the DW and LDX variants as
deprecated as well, which is what the draft already did in the appendix so
that's good (nothing to change there, I think).

Dave


