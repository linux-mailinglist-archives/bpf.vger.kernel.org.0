Return-Path: <bpf+bounces-20740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE32D84286B
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 16:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18DF1C25C3F
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 15:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E6785C62;
	Tue, 30 Jan 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ObP/XYAP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6EC82D71
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629875; cv=none; b=n/PPaebUMJUEjCcmAUxLJAx+xd/VL+z5E5Q7Hx7u9iqfAhrfWksLP+McCDVrctrEA/4aMrcp4MYeT5eSAP2gpmOSPjhvkUqxGjSKdRhoudDiRinTMZbWVJlbTAz6dHSkRcfDQoSGEEtyq7N8CUnmOP1SgCFbZIYu8tWd5vTiJj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629875; c=relaxed/simple;
	bh=1SK/iKFF9dC7WFtjoWd2U6NyLxJHyjytFSMwsPlwNvA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=I1ngDLT3QPLD0LVRFxAyYUkwVe7qFs/4usLcCrqYswuD09d+GGR6t65PDbUmgjIuGHXCGJM7Qjdi4/P+KLB1Bx7sXeNrqgRy3kVkTO6dg9jqOd8QR10l4QoehyprljSs8CHkVfRXsVuSB3fmYT6A1uxIjiu3cYW7zasuJO5tLzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ObP/XYAP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-295c67ab2ccso276747a91.1
        for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 07:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706629873; x=1707234673; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7E/5TJk4Pep3kQ6nkb6rj/0pdrJMBWMVdz1Vy5fVW38=;
        b=ObP/XYAPLNsNKX4CEN+EoPC/IdFqkQXFdtoJLOEJn4Z8k1bc5mQPW6XohOuXWbwjLC
         DUWtvGzPfKV40o1g24ZTYldI8dAixry+wLARjv8HKvAKgXjpz1tRzpOVbrqyj6GU330G
         fnQLL+3ona69d6kSS8xCNxXhhNOkfsJIt4fPYBB1t7myinYHmT8uEnh5t/AL+0WsCocF
         RzOvn99K0RKYGIOIWDswBUqnYu5dW5jPOiFG++gIIi839XKkCNhBCSHw6lxUTkjrFqLC
         /tbfhBacxCWt5dPgSvjitR/T7wG07Q9Cmod8JWozCbJ9DWHeYdjRd5H4YKCC2iAV2+HA
         +JMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706629873; x=1707234673;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7E/5TJk4Pep3kQ6nkb6rj/0pdrJMBWMVdz1Vy5fVW38=;
        b=Fu6LGG+ML9dKgexw+huB479S9aC2nzcfd8tsAYBzMUC6a0cuzGRFC9+S2ptDy+5Dx8
         DXVkvrI2fBPbv3YaPQGB0vQBaVJymWPhez+nvsvIhsztI/1s4CTfvPnNW6TKYNlV0ANa
         WL+CtDnqHwQCNc4yDmmiWkQ4bORebhC4Y1dRsHccoVvdR3vy1pTaFOBkPzN6EXhzBdRn
         1qN3+vkN5HKGF+T5qlIV2UwqP1PVbKg/+9HB7U3ZyxhqSpSv/MXSeI/SYj4liYf72iuU
         P56NmwJbStwr9n7qcZ/qdZA0saKKLUuJsrMbG872otgyR8w7s7Zpcsq4fLIyCJF4gwI1
         xrTw==
X-Gm-Message-State: AOJu0YwMRH+58DKusJIdEB63ZKV4flZ3jg0L8tmGfzPQEHgewe3NEhAD
	I6rs3IHeBOGwmcSdbJvS8LBhyfm19hFOVwfonQ2oFvUCpqlgY9HILRNznt0zyBw=
X-Google-Smtp-Source: AGHT+IHu0AUuj+hcdj2wLEm4SeFw6qt2hN83uk88jDPyRFA870GoEYnHTFj8sii+6FsC+Q0uF6zZOA==
X-Received: by 2002:a17:90b:88c:b0:290:ab28:807e with SMTP id bj12-20020a17090b088c00b00290ab28807emr4522196pjb.41.1706629872901;
        Tue, 30 Jan 2024 07:51:12 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id in24-20020a17090b439800b00295be790dfesm1327061pjb.17.2024.01.30.07.51.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2024 07:51:12 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>
Cc: "'Jose E. Marchesi'" <jose.marchesi@oracle.com>,
	"'Yonghong Song'" <yonghong.song@linux.dev>,
	<bpf@ietf.org>,
	"'bpf'" <bpf@vger.kernel.org>
References: <006601da5151$a22b2bb0$e6818310$@gmail.com> <877cjutxe9.fsf@oracle.com> <8734uitx3m.fsf@oracle.com> <01e601da51b7$92c4ffa0$b84efee0$@gmail.com> <CAADnVQK8JegsSxgbQbO=DR71cRgkvN-y9LH_ZQYxmj1a-hCz5g@mail.gmail.com>
In-Reply-To: <CAADnVQK8JegsSxgbQbO=DR71cRgkvN-y9LH_ZQYxmj1a-hCz5g@mail.gmail.com>
Subject: RE: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
Date: Tue, 30 Jan 2024 07:51:10 -0800
Message-ID: <071b01da5394$260dba30$72292e90$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQI/mTVZUZpeNhzShIl9oGl01BkM9QGkD3DnAsdGbroCN+NFGgGJMAgqr+aSAyA=

Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
[...]
> > Although the Linux verifier doesn't support them, the fact that gcc
> > does support them tells me that it's probably safest to list the DW
> > and LDX variants as deprecated as well, which is what the draft
> > already did in the appendix so that's good (nothing to change there, =
I
> > think).
>=20
> DW never existed in classic bpf, so abs/ind never had DW flavor.
> If some assembler/compiler decided to "support" them it's on them.
> The standard must not list such things as deprecated. They never =
existed. So
> nothing is deprecated.

Ack, I will remove the ABS/IND + DW lines from the appendix.

> Same with MSH. BPF_LDX | BPF_MSH | BPF_B is the only insn ever =
existed.
> It's a legacy insn. Just like abs/ind.

Should it be listed in the legacy conformance group then?

Currently it's not mentioned in instruction-set.rst at all, so the =
opcode
is available to use by any new instruction.  If we do list it in =
instruction-set.rst
then, like abs/ind, it will be avoided by anyone proposing new =
instructions.

Dave


