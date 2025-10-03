Return-Path: <bpf+bounces-70281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08481BB62B4
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 09:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F1419E832F
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 07:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F9F2417D9;
	Fri,  3 Oct 2025 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYY4vgU+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF560239E67
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759476571; cv=none; b=r1RLuBJoob+ehrmezPV2TQCLKwvCoMRk6lyIxk10tc2jpbvc6W44jgUpfOcIBQD5xGq/2rnh7O7g2qQ1Zfl2eEDq6y2NxY5B3Mz/BcBWPM3FXK9hx7aG+4rC8g29PHx9FqtGzPwgNuxaQj8zGrwJoEwcG8PV6rhM5fJh5OYDOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759476571; c=relaxed/simple;
	bh=ko17QzyktMbGqS7ZAQinrBqKa+5SJAPshE9kKNJoEJ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hgOS0tRfN76WC3KnCNUtwhAWObU76nZuSk5sVLarRARLeJbUxfRMR193nLrjA71U6kU+iqArjvXNMktTbRWYF/Yw4uSM8redl9G/WOMsAVmH+plcQ9GQka7OPopLv3RlzZAK0oAHU8hzmWwiMCE1VWB+lruOltCTiX73CqTGVBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYY4vgU+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78125ed4052so2272751b3a.0
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 00:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759476567; x=1760081367; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ko17QzyktMbGqS7ZAQinrBqKa+5SJAPshE9kKNJoEJ0=;
        b=kYY4vgU+/jy0QCwvNPx4ldji+D0ceE0W19nVryo6B61vjAhxprphMx+3saxjr1WyWM
         U5mr1l+pRA6fTglL5ms+eUvgL4KrGSoAyYPYZvnrYs10pcKyhcGBKAyVD5mCE/t0I94z
         0NpxANRj8A+K6/MkkSr7BOR04ffKCFLZOFDUysG0IrknZnOZwH3aLmwRBOqQk7sUH2vC
         3S44fZSTFbDlMVJPvOlSYdVTamWef8UoqnrEGFf0xJwWd9cn2LX6oVAYR6dSeV315u0n
         xBgJ1mOOcTb1FUr/u6plBsLMJ+W0IuI85veknqFcJ8nAgkNfUOKBTDly5/22Uq9Y5WnW
         SMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759476567; x=1760081367;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ko17QzyktMbGqS7ZAQinrBqKa+5SJAPshE9kKNJoEJ0=;
        b=iQHUzxEp8pDWAPk7QhD6Tjp98iqliIeT4knJx0G0elvS/Qx7g18tPAC6sorF6XNgDO
         YPuRQ9yp1N/bPlmwhCLyps6hv/2nv0gxpVksgKrVBlNiWh/Ebe5/7mIVEkcbsx9W70YU
         HuQFaxlpOMG5XvqgYLr7halRzdtcQ3+gdGsiqmnXl0dno+cLQPMM4oGox8eiKiuMhC/H
         T0LQ8mmr/NFbPFJpRnNfA8KtB+5mmFPWpN7GqTAsDsDWM2CqF3p96c/jpZ1lb/n2HKIB
         TTPRoGZlPEXvaBsi+UjnbJBzIc5ThEnx6wQwlWYYjRDQqUqBq0hJYIbiWqfiOfKxKxmA
         AA/A==
X-Gm-Message-State: AOJu0YwiFUw/sh9zutodr5vzA5BU5+schsvICL7JLkz1reva3gk+vd1C
	UrHY4DsxEmqyGRWPxUHXvnXNqKunJl29QltFXNAADhziXfKv+PJsWjDR
X-Gm-Gg: ASbGncvXnmLoKxGzAA/hv/qRHxt6v+eZBOWaLYzYllThpJW/TNm1oQQ76qpP8hkro0O
	2/n/6RvskbaXH5O9CD8gMAvlDIlUtwWW8JEdHt1F+Q/huZ94bVc89nabC6kla/VODenGS9IlOQz
	gJG1UroTKKLQAS6TpuSjWIBIHZY4AN3ggn2K8PA3Am0RM3kaLmfCk1r7UBSVFD3Wdf27H9CdcF2
	1HkZD9yBiUYLWbXFjAA2zuz8em2vaeU8BP7+QH2c4AN/zG9shq9PGp0YkoVlVhJfvKd8uXyGOKj
	QknKT9uLOd5xaq5ZMouiBGjjVF5t5kE7bKoZNswsaGsUp2zARPF1BfzD90L6KZwGXyi9l4a8aRR
	ovg2gijuPOwMUHmyzwIKvHzNa8m+TlOuwOJhnAWfy11rAtrFIaMzk3uw=
X-Google-Smtp-Source: AGHT+IGZOShtbkyuhg0FOwrMSwtAxO7H7MEIxGSHaX0Xpjsybzi7ZIYM13wW/pBLd3izoMzOgYbBXw==
X-Received: by 2002:a05:6a20:3d05:b0:309:afcd:234d with SMTP id adf61e73a8af0-32b620fec3dmr2717921637.53.1759476567029;
        Fri, 03 Oct 2025 00:29:27 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f599a2sm3752015a12.36.2025.10.03.00.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 00:29:26 -0700 (PDT)
Message-ID: <bb78ba10d6035a3e5756f963985f7224e344fa9e.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 15/15] selftests/bpf: add selftests for
 indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Fri, 03 Oct 2025 00:29:23 -0700
In-Reply-To: <aN95zMTGafXnLXTc@mail.gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
	 <20250930125111.1269861-16-a.s.protopopov@gmail.com>
	 <193001218286e9b833d44e3ecc2f7e3cee0b4011.camel@gmail.com>
	 <aN95zMTGafXnLXTc@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 07:22 +0000, Anton Protopopov wrote:
> On 25/10/02 02:07PM, Eduard Zingerman wrote:
> > On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:
> > > Add selftests for indirect jumps. All the indirect jumps are
> > > generated from C switch statements, so, if compiled by a compiler
> > > which doesn't support indirect jumps, then should pass as well.
> > >=20
> > > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > > ---
> >=20
> > Could you please add proper unit tests in the next revision?
> > The way I commented in v3:
> > https://lore.kernel.org/bpf/8f529733004eed937b92cc7afab25a6f288b29aa.ca=
mel@gmail.com/
> >=20
> > [...]
>=20
> Yes, I plan to split tests into unit tests and libbpf tests, and aslo
> add tests to compute_live_registers. (Just, as I have mentioned in
> the cover letter, I wanted to see that kernel part doesn't change too
> much before starting to write unit tests.)

I think kernel part is pretty solid at this point.
At-least verifier part is solid for sure.

