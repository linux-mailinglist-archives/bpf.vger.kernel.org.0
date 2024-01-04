Return-Path: <bpf+bounces-19057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BAD8248BE
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 20:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D7AB24E49
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 19:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0973C2C18E;
	Thu,  4 Jan 2024 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="w0gFWA9L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ZA+L76NM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HXsRr9LS"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D395D28E06
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CC263C04B956
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 11:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1704395537; bh=Nf1NAzKq38WLgSv96qGj6DkiAgkRmYQ6qIAh4zvVNRM=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w0gFWA9LNIdY8Yiu2U1x0N+wVON/hTbcfYpkCCBk/PhvpXH5VvH1AbU+NAy8Uq7Mg
	 3qvW9Y64EN3hDQbclCaLceMv6VF3nO9m+FooU+WKIfMNiaQ1T9EU4e66NxA8U49Q1A
	 MYvg/OIdiG77RoBwPR0I4Wn29Tcfo803OIGFw16s=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id ABB88C157924;
 Thu,  4 Jan 2024 11:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1704395537; bh=Nf1NAzKq38WLgSv96qGj6DkiAgkRmYQ6qIAh4zvVNRM=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=ZA+L76NMIdj/2KAWVc+2JE7/djkrMulYmX6mbJnZFvCAK1usA90LmgbriSfoblurP
 D+hHguRB4vw/AjeBE+a9JSd8JGQuCZUKpqB3mInhw6GwhtGraCW65x3ieTunUR/8HC
 DdKanhrV9ntIerE9aKLwBX+sZ5QwSzTXaS6E/WTo=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 89C0BC157924
 for <bpf@ietfa.amsl.com>; Thu,  4 Jan 2024 11:12:16 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VHM0ts5UzZwv for <bpf@ietfa.amsl.com>;
 Thu,  4 Jan 2024 11:12:12 -0800 (PST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id E890AC14CE53
 for <bpf@ietf.org>; Thu,  4 Jan 2024 11:12:12 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d427518d52so5664405ad.0
 for <bpf@ietf.org>; Thu, 04 Jan 2024 11:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1704395532; x=1705000332; darn=ietf.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wiuAbn1hA+wD2zanBuCoA6Xdp/ZRkyF/eu8Vv75E5eo=;
 b=HXsRr9LSGn1PiriFQP9UwCEQJGTm7iqZBpu9Nf6fe+b0Qvr4MP0Pk9Tlvx5PBp49vn
 VYLwiCdb3opiXfTeHTlKMGtkOoIL1np/yWi37tvDGdK+Fc+x1j/Qucy/SZRjrjsz8L10
 KX9FdzgiIiAvW5Y8Lx7n4ZUaC/rPJhpK08vl3sP7Lplo5X/wqPdhV87+pwcjUggyDm9X
 ScG8Zv6tey9etxmPQkTukmsihlgGVkBijVRei7ZvfAqk7r0BsHYvufIQ0AUg8/MHXrE4
 p7aX4uY56AcI9MXS/vvxaX2hE5yZMHoesEagJK6voZt8QL08xc8TiC7TOOeoAUJWP1FE
 4IXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704395532; x=1705000332;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wiuAbn1hA+wD2zanBuCoA6Xdp/ZRkyF/eu8Vv75E5eo=;
 b=oNhHbFmx6uMFRjoF/xD81zSksWtrglWmbqoeWQSz0ltI2CrP9TWibggaYjXTYIm8b6
 vnDs0n4hIQs/an997i84oSU4SapZF8VFdTa22I1KtgkFa01yqUnUh4MjtTau+hu6juh3
 KkxFx7NMniW65nzi65SVuNmHmSgY0PwjHZ3E8Bz6GlwAFIc1P0P1k33FE7+a8pbXgNY6
 dWX4oEF8FhYAZjUaIIYbrEENMx9xYXRKkm2fywvM8XweH1LNTYe7qfht73Hy0ru3FQkT
 j/nhvJU1BdaLuxIBrFvoSO58jQ/K5NYZ6yE4PifxuTU++0NTimt3oh08xsGsaZGX3Zxi
 BrxQ==
X-Gm-Message-State: AOJu0YwMzL5XdDalQUyJHOWNXgrynks9IeY3OCboV1fHM2+qvQ5Ieti/
 18V779PAMRHS9EUvNIn7YKydKKkBL+w=
X-Google-Smtp-Source: AGHT+IF8NBDEzEGYQcF27Qh4/HMfq2Q29GAe84qQeg2jGA8hMXmsXodkyDwrxrzH/bMNHmGnbODQ7A==
X-Received: by 2002:a17:903:484:b0:1d4:e575:520a with SMTP id
 jj4-20020a170903048400b001d4e575520amr165714plb.46.1704395531858; 
 Thu, 04 Jan 2024 11:12:11 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001d4752f5403sm17021666plw.206.2024.01.04.11.12.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jan 2024 11:12:11 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Aoyang Fang \(SSE, 222010547\)'" <aoyangfang@link.cuhk.edu.cn>,
 <bpf@vger.kernel.org>, <bpf@ietf.org>
Cc: <void@manifault.com>
References: <3A7D0A57-02EF-4ACB-A599-1029CFCA7E74@link.cuhk.edu.cn>
In-Reply-To: <3A7D0A57-02EF-4ACB-A599-1029CFCA7E74@link.cuhk.edu.cn>
Date: Thu, 4 Jan 2024 11:12:09 -0800
Message-ID: <015701da3f41$eaab4d10$c001e730$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQJcMuQj7ImLqPZXOVe7T7DiaRKhU6/GHKMQ
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/78B0his_UicOrI51d1XhMEIruaY>
Subject: Re: [Bpf] [PATCH] update the consistency issue in documentation
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

> -----Original Message-----
> From: Aoyang Fang (SSE, 222010547) <aoyangfang@link.cuhk.edu.cn>
> Sent: Wednesday, January 3, 2024 7:13 PM
> To: bpf@vger.kernel.org; bpf@ietf.org
> Cc: void@manifault.com
> Subject: [PATCH] update the consistency issue in documentation
> 
> From fa9f3f47ddeb3e9a615c17aea57d2ecd53a7d201 Mon Sep 17 00:00:00
> 2001
> From: lincyawer <53161583+Lincyaw@users.noreply.github.com>
> Date: Thu, 4 Jan 2024 10:51:36 +0800
> Subject: [PATCH] The original documentation of BPF_JMP instructions is
> somehow misleading. The code part of instruction, e.g., BPF_JEQ's value is
> noted as 0x1, however, in `include/uapi/linux/bpf.h`, the value of BPF_JEQ
is
> 0x10. At the same time, the description convention is inconsistent with
the
> BPF_ALU, whose code are also 4bit, but the value of BPF_ADD is 0x00

https://www.ietf.org/archive/id/draft-ietf-bpf-isa-00.html#section-3 says:
> ==============  ======  =================
> 4 bits (MSB)    1 bit   3 bits (LSB)
> ==============  ======  =================
> code            source  instruction class
> ==============  ======  =================

Hence the code field is 4 bits, and 0x10 cannot fit in a 4 bit field.
The documentation is already internally consistent, and this proposed
change would make the documentation incorrect.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

