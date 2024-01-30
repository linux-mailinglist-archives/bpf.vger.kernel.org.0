Return-Path: <bpf+bounces-20776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7961A842E51
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 22:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C8D287CC1
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 21:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEDD71B52;
	Tue, 30 Jan 2024 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dk4H/xDk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6096771B3A
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648496; cv=none; b=IGMewlRDXrGjDt6SGX6cdW655X3lUT+/F21wncDqEVQmMq+4kxl0sR2WUmjXG1QmcGU12NFgFwKIC9inJMl89pmhRs47L8EYM3/FhoFipJwR71mPcEIF3XEF5MjG1plKLWpL2iH2dDkp7pYjyzC3UDeBU9Qz2fnAnS2LjYTRIIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648496; c=relaxed/simple;
	bh=UfGFi4ol/jcX04a0OeY+TZfFMRUmrcheyMeveSp66pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRmPoQwOTjJM6//Q6PDW7hwnppgu67RUVOat8gT+7KKttTDxqQ+8n7DRPXsqDTVPbJ1IVW11ik9GdcVhedjzXaZOjKp9voPAHlBfJXpQddBJoTqgzOaqgIg2jR3Ynqg1SggdJjrY9fJMJ3D2FVYgfZXiPEdz28XqJA+Yd48VXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dk4H/xDk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3394bec856fso134608f8f.0
        for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 13:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706648492; x=1707253292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQ7J7exrLBJFWUFLbts2Y5W7nlYiKPxLj7+LYCLHJCc=;
        b=Dk4H/xDkcyroTUbjwi6woBlZxPUVMQmxQ0126tkKUlYUsoU5bXQCp/2XCw8ChkD7Ol
         TeN1bn634Dk5WO1KiL6TGCDrIJsWoAYUhzJCqoYXxwqV/IK/KN39g33d+KqSavkguTzz
         xjmTIrgNvxHE4/gMsXaFiOgj68ErcAVxVJSpwobJ3LDEpjfYJeyPgK2NpPBCuX7wQyKI
         4W1Q1rGRmyDF5lYgxZR9Y0RfWZIfjXrjJnY7xaVbP359zjkwQcowXI8urdBiXWXKsWj9
         rR9ovCuiD6c+ITrUcNj/a14dI6w4njkGAhrWXJeFezqcJNJYAKh9LAsXTkozwRhbB4vK
         LSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706648492; x=1707253292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQ7J7exrLBJFWUFLbts2Y5W7nlYiKPxLj7+LYCLHJCc=;
        b=Bq5maErRnGE9p6PpEGAiNspqCiUMpM6vDpragabGD/lburp7V+pJ/KaMYLuAQkQJY+
         44hKboCgCSNoI8p/CxbuFg3SBP2IDVjx612j89sFOMf0XpeKjYSNoIsD2MX4MV89wqvw
         R9QJr6EUdWRd396lMJ7dIFhO3DjRCWP4JdG8ybtYZU3m5ZkM26C2iqCe6Cg48dF4NmXM
         BTyfohBXhS5fDjtUX1SyBao0WyK6ajOqiDfRIpOdatwopLLWS4yFp/nZnA94Z0QgFhi9
         +zCcU/5d19KVKVH2e/A6L6QOUQZ29VQGzAI4sZjHBuehUlHCnUAcwq4LuqnhZuTgvmMB
         sZZQ==
X-Gm-Message-State: AOJu0YzSBPITcx+wS05Us86HO7cLjjtsrmkV1uTjBwBpd0jc9VV4ypOj
	B3fWqe3AZ7pxvlYjtzbA982wJOBL1m2o3IoUdgRcJA0zQk9sm6MBdfB8ht52FvkJO2UZ6rsdfZK
	K5UNNtOVubgjkz39eW7gPPRcChaM=
X-Google-Smtp-Source: AGHT+IG+EVQPQ6EN1V/MbW2cpUmaQrp3Z//E40beAt0YY6rW2i+RwXALPdsZ4jyQJ8l8GxzG3SLisIJKWkWw47g9B50=
X-Received: by 2002:adf:fccb:0:b0:338:8892:fbdd with SMTP id
 f11-20020adffccb000000b003388892fbddmr2676836wrs.4.1706648492349; Tue, 30 Jan
 2024 13:01:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <076001da53a1$9ebfa210$dc3ee630$@gmail.com> <87wmrqiotx.fsf@oracle.com>
In-Reply-To: <87wmrqiotx.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Jan 2024 13:01:20 -0800
Message-ID: <CAADnVQJDDHEVjrDeXyY+GOncnG+CFY=TBspuZUPzDU6nDLyo9Q@mail.gmail.com>
Subject: Re: [Bpf] ISA: BPF_CALL | BPF_X
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>, bpf <bpf@vger.kernel.org>, 
	bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 11:49=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > clang generates BPF code with opcode 0x8d (BPF_CALL | BPF_X, which it
> > calls "callx"), when compiling with -O0 or -O1.  Of course -O2 is
> > recommended, but if anyone later defines opcode 0x8d for anything
> > other than what clang means by it, it could cause problems.
>
> GCC also generates BPF_CALL|BPF_X also named callx, but only if the
> experimental -mxbpf option is passed to the compiler.
>
> I recommend this particular encoding to be specifically reserved for a
> future `call REG' for when/if a time comes when the BPF verifier
> supports some form of indirect calls.

+1.
Same thinking from llvm pov.
CALL|X is what we will use when the kernel supports indirect calls.
I think it means we need to add a 'reserved' category to the spec.

