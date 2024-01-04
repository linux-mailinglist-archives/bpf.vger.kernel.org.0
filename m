Return-Path: <bpf+bounces-19056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AFD8248BD
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 20:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0278EB251CB
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 19:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D312C1B0;
	Thu,  4 Jan 2024 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RfML0zpv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3092C1AC
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d4ab4e65aeso12296565ad.0
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 11:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1704395532; x=1705000332; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wiuAbn1hA+wD2zanBuCoA6Xdp/ZRkyF/eu8Vv75E5eo=;
        b=RfML0zpvfX0WvcbBFM4tkJjHu4JlaLSfa0/ZBQmuv3iCsyUg6QLLxpc7U8aJfPTflr
         QkCygdaeBzjptmGH8YG6y/v1xtyTpP17NFfjpNa4JZowCjVSwQCR6+HC9SQs7V8EBVvq
         cSjD/LHVp1fa51531fbhsGW86uqDufzsbjjyxZ+CYBYQYz0CUZTPs1MmDz2Ns0u7i79d
         jNNE3koYpzR47UM9IuzKG9r95tM0WaypdoxLAhB391Hdhm3B6kL0sFedcBs4NIP+2zMP
         WHCAPUlwmQiFyoYSMXzd+CSfrSRGrp/fH9SmhB14jR8PAizi7jI88Uan8fgLPwd0SUX+
         U3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704395532; x=1705000332;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiuAbn1hA+wD2zanBuCoA6Xdp/ZRkyF/eu8Vv75E5eo=;
        b=lo66PnOUBMz9ainT7xlxpVyAooH7RhB4tR3DT2s/tV34VHmvbiPcyDPwULa+dkHKGy
         AaiZ2Dg8ttMZFmlE9JtLW2MWAiIeKF3k1+KZX/FX1ekbH3bl7Z72OyHAWSQIvir3plw5
         7R4XEhwRxmluCYRBB+UUXu1P81QlZt0z9CTP7UsyurAo8ITxncjrxOiLh60KQgF9+9NA
         onSi7PlYvrXF7EAJy8biNhneeYJUQjkCU/cLieyjfw5A5Zi1i7Y8REnm7qi7KVwzIDIF
         Iusre8EOcsobsIexu88Wq28GQBY61AEnk2XSd3Un+gfa/bCV/OClcmVcCNsYVstQp6p3
         auow==
X-Gm-Message-State: AOJu0YxKvz3zTYLRj28FwQCLFd5CfKxTSZAxpta6i950UDenOK1VeYyl
	qLTqkOKLWjT+/+OVIQTLuN4=
X-Google-Smtp-Source: AGHT+IF8NBDEzEGYQcF27Qh4/HMfq2Q29GAe84qQeg2jGA8hMXmsXodkyDwrxrzH/bMNHmGnbODQ7A==
X-Received: by 2002:a17:903:484:b0:1d4:e575:520a with SMTP id jj4-20020a170903048400b001d4e575520amr165714plb.46.1704395531858;
        Thu, 04 Jan 2024 11:12:11 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001d4752f5403sm17021666plw.206.2024.01.04.11.12.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2024 11:12:11 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Aoyang Fang \(SSE, 222010547\)'" <aoyangfang@link.cuhk.edu.cn>,
	<bpf@vger.kernel.org>,
	<bpf@ietf.org>
Cc: <void@manifault.com>
References: <3A7D0A57-02EF-4ACB-A599-1029CFCA7E74@link.cuhk.edu.cn>
In-Reply-To: <3A7D0A57-02EF-4ACB-A599-1029CFCA7E74@link.cuhk.edu.cn>
Subject: RE: [PATCH] update the consistency issue in documentation
Date: Thu, 4 Jan 2024 11:12:09 -0800
Message-ID: <015701da3f41$eaab4d10$c001e730$@gmail.com>
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
Thread-Index: AQJcMuQj7ImLqPZXOVe7T7DiaRKhU6/GHKMQ

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


