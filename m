Return-Path: <bpf+bounces-35251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225DC93938E
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511091C21616
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EA316F8F9;
	Mon, 22 Jul 2024 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR7+aZFy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E70016DC06
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721672566; cv=none; b=YPxrasGAcZyhOqDxUwapCSONnXqbVoeF25UaA6YdbrloGH4ouSOIiQBqeg/FJCuoaeP7AvnTlkjIMcbYBkhiRQ824lasRc2iqPsTvvQGFSPP/qI9hg+LaSxZE0bbPbvAI8MPe8mt/mqjBCrxoWWFXKiNTUt6JOvhuD5ycxVIrTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721672566; c=relaxed/simple;
	bh=3jsBJVs21oV5dzNZ2/I6l+os0Jn0vG4qWcG7s7bztcc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GHJGxIA9NJgnJxMslOX7I4vn///y0kRpNo0kKoeyRoEbkEzjJn5UmKFsMkyuMYjuxoEbVP+ILfnFB3UunSSRp374yTYGBBiDDgn116AFjo6MB2i84Umqp9Q3r49Y1V5kvnIbHLnys41e7Hh5urXbIoPbSF9DadnTkPchhJhE0xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR7+aZFy; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so2535397a12.1
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721672564; x=1722277364; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JCbCWzpa6F2+c1e/W5PBRadDin3zRxeE/NLzEmeCsP8=;
        b=BR7+aZFy6n4Tn50tMZ5qYRuoo8hxyqYX2HPoVQb9+ufoM4OscZ74IycLXMdtV9r7Hn
         wVa54W9//ighKCMBfobnKWmmE1I6Hg7LUxN9pcBelauaW437/mX3lY9xW3VMCeZcgLoD
         wLE1/5FPT5ZmXoH6Jb2Qc8an4XaeejczZqx15OJoBMKw4Idxc7eRWWuZhJWHkFwkvf/F
         CKkRGSFX2JGp7hs1PH/IP47u034jvegOAiFXqJ0iFIaHnvlYhRoe61E9rqHoxGrMlwkg
         Y057oCagDfJV0DDjbHkNzZEoYmDVh+jC11Y03D4Pfx/CEBFnCBV1+fAyqqRT4BTicsxR
         Qe/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721672564; x=1722277364;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCbCWzpa6F2+c1e/W5PBRadDin3zRxeE/NLzEmeCsP8=;
        b=OFN1FC5BKbpqUj8V0cDGf2yFd4OQddbvkOHYjJBCSxMFIb3HtW9g0gc7LtBSsAR0pm
         KBNcd+Jf29zyz1DF7zjegSSMrN4lGu/m2ccL61daB5Jf6TnyMrIZKlJ93IRjIlBAZP9L
         g1f9NRUsyswuQ7mUPeq2PEcnnZ1k/B3L28g3WRWK8yzWeisaD+Eo9RQXrZft5h1Hz8e6
         YAvrnqSeOGItoNiOUHSgLxGVOLcnUHUte6WCkksmaLhJQ4wACDhQIu+Rg4kiz1azzNy5
         KdppKGACy+53NKGq2tP2csiJ3ay+14LEHpwxkTJtMG0VVt/UgjKf99N+R3EjySxYbQL3
         URoA==
X-Forwarded-Encrypted: i=1; AJvYcCVIIvJAIQyZp2mOdyocnQQe18pXJeu/gNyLOC5tjO1rBoaORWodlYqS5/p08T55Wz8wyZuKUACbhCsvmWZxWaZlckgi
X-Gm-Message-State: AOJu0YwPCup+SkYJQvgwIJr6WvnpaLyXk8YupL/eNmFO5Z7os/ifcKyq
	5isP1ilA1J3sSDiWIB/e2PuDsMI/HIflmksKkxMcGy5wal8l83tM
X-Google-Smtp-Source: AGHT+IGGgFq4WQRIvhKizdKGmT18OekI760cb3xt4OfR/v2M+QuYM8/Crxh0d3l0uepeBW556f3Rag==
X-Received: by 2002:a05:6a21:9981:b0:1c0:7ec3:c7ae with SMTP id adf61e73a8af0-1c44f968988mr697382637.47.1721672564365;
        Mon, 22 Jul 2024 11:22:44 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fda360473dsm19738855ad.203.2024.07.22.11.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 11:22:43 -0700 (PDT)
Message-ID: <49c7938cc9c3d6047efd8cf30eb66771a6f0fd8d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov
	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
	 <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, Martin KaFai Lau
	 <martin.lau@kernel.org>
Date: Mon, 22 Jul 2024 11:22:39 -0700
In-Reply-To: <CAADnVQLJrCv=2QKRr0g=cL3DzDBw5=tO=ufrA21KK-go-_y+Gw@mail.gmail.com>
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
	 <86b7ae7ea24239db646ba6d6b4988b4a5c8b30cd.camel@gmail.com>
	 <CAADnVQLJrCv=2QKRr0g=cL3DzDBw5=tO=ufrA21KK-go-_y+Gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-22 at 10:51 -0700, Alexei Starovoitov wrote:

[...]

> It's not that simple.
> Above sequence violates -mno-red-zone.
> The part of the fix may look like:
> movabs .., rax
> add %gs.., rax
> mov rbp, qword ptr [rax - ...]
>=20
> mov rax, rsp
> mox rax, rbp
> sub rsp, ...
>=20
> it's probably correct from mno-red-zone pov and
> end result is maybe correct for stack unwind,
> but if irq happens in the middle it won't crash,
> but unwind will not work.
> The main reason to use r9 is to have valid unwind
> at any point of the prog.

Oh, I see, bad things would happen if this sequence:

      movabs $0x...,%rsp
      add %gs:0x...,%rsp

Would be split by an interrupt.
However, I don't understand why 'push %rbp' violates red zone.
In any case, the interrupt argument is sufficient,
thank you for explaining.


