Return-Path: <bpf+bounces-58096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B80AB4A99
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 06:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D623BE561
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 04:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DA51DF261;
	Tue, 13 May 2025 04:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yzxzex0z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F43826AFB
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 04:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747111221; cv=none; b=hvb80vFSSUkoSQKc2foxTJ8VPtVKw3HCyeOqfkAerzx0vjkfYoiAY5JXQ16o3D/FtRzkkyRL8ZQR5hG5D0sHIzsPCH75NqTZsH6KwqcFM1i1xyoVL+bYj4b28kF3z9YycqSp7wTBOrAZ0yUi9/4sNf2xbhzS8zy6C4D7f1HZJFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747111221; c=relaxed/simple;
	bh=w7iI/U3RDumUi4KFqkTJLHySnkMbnuolbBnEmhEQgN8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eWRknVz805ntUkygN2dLNvegaZedzlpVdTZAK9mOJsQyzJUAx60jdXZEqX6lh+OrOPkgn2+hgltchrw+VeDXlQ79Id9XY+17UwY+ADr53XGCfksltjLKwA9WqQyQyMaogZhRhOvEUpOwFRro2VZHSTs2uAyQxA194t7JPw0h7uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yzxzex0z; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22fa47f295aso33953165ad.0
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 21:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747111218; x=1747716018; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3EWdzwIL1167QTHOu/kkSlwUjmDzT0ANT4kdZOrARG8=;
        b=Yzxzex0z3rYoOndzCNgE2B1EafyNRW5IJJr68XEQRyltiXNQK0a+8yd9xXAS+zIFhW
         tKnymLTVyWzsbtyDZPRBnWWN/GWoPsi9eXKtlVMi1YJPoTfa5fAqI38gmIQ94GRQOrxJ
         r8Zx3fsVt2YuMsmGLNy+khZvFHPZwnOZfMOfJHNrAaMnm/5ie2nwAhH6ue3AKHAspXn5
         7MhFZV1wLrE4ASTKPf1k7cInCtgIiA4nIOWTjbJ60kP198zDRdieGQJRaacXQRY9twSd
         NrwdKNpxOrR9NbsEKGFY4T8g6mTuERzmk5ep8rv7b9PoUFibLHvhBJEgz/AaLzCW35Zp
         KOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747111218; x=1747716018;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3EWdzwIL1167QTHOu/kkSlwUjmDzT0ANT4kdZOrARG8=;
        b=G8RTrmhLupdTeiweR5af5WR36SFS1ogJY80IQJ8/DepIfQfRS4foERfaDse2aerE05
         mIBjg729EH9d8Px13aKmGiZp2HF43D1lC2e727+S4NsjIc4WzpFaVfbvlm78r7PfcLN2
         LlmSgJzHij7F/4ZFTZFGvafr/CLBaYDRGhbyVxA1Z4XsIdfx36JEB/yJlOhZBj/LWuTm
         8er6qMT7ODKzPyfG8Bng8MbXTV51LUAdfxzMj8ZEACOG/66wRd9rEKncgAQ9AraEm/QN
         RVFeY4h8VPL+tC9tYugEij8BitV/nk26U0yFVQZR3ZSFlMwA0yhJyxD9a4MVvVoDtDdG
         Ju8A==
X-Forwarded-Encrypted: i=1; AJvYcCW0ftNmCm/y+MY//5d9Qn8ht4OxWWK5qnkl8xQQ23F8uNVAtsDmc9NsRstyMabtgp7KfPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztQQLSuf1B3R30Py8camTZXLBrg7eYaK35nsp8BwUIqybxMGTw
	Gld6FoL0IL/qpsleLRIndUxjBCmId+GGz1oj0S7Ww8BWzz3EB7hnheG0iDyaWa8=
X-Gm-Gg: ASbGnctH1uLOe0iGCelC4+oIxCQkQgPAEsoNJpH9LqAcyl8qiTAcCEADX9eID11bWlT
	oc0ITe/uTod+q0i+7+IV8CGjCeVomvPSDFwEa0kGTSVEB5xGmGVDGJfTrybpz/6XL4UJpAsOS13
	1cDOjWlFWrPXu4K0FiXxkZBFpnHpSgHBeWveXHujmU+owHa6N/+EkRr0q68CiF+6mGKBvNTTdDB
	rXW0lKiuL9bAWLvpLDrK+V8h+GbWwnMQbHheMcgVDwgJLWfu/DTBdXTzj0adRyt6pxGh5B+aPGl
	y5al93Mo8Lr9Kvaja9q7C25gIGZ0a+wJGHR3uwciPutKBD8Nk86EL43JmA==
X-Google-Smtp-Source: AGHT+IF97QIu8Pfv6Oayf4Z02Ax0aqk82qIC7vFwDPIC/i8Wvu78Oqm2b682ueSfTd1eTH4X/PwZ5w==
X-Received: by 2002:a17:902:ea0c:b0:223:432b:593d with SMTP id d9443c01a7336-22fc8e94d97mr192471025ad.42.1747111218483;
        Mon, 12 May 2025 21:40:18 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271a9dsm71758855ad.113.2025.05.12.21.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 21:40:18 -0700 (PDT)
Message-ID: <fb5f5ab61dcd12e8e29e84907cb6ec4af28a6dc1.camel@gmail.com>
Subject: Re: [RFC bpf-next 3/4] bpf: Generating a stubbed version of BPF
 program for termination
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Raj Sahu <rjsu26@gmail.com>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko	 <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend	 <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Dan Williams
 <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, rahult@vt.edu,
 doniaghazy@vt.edu, quanzhif@vt.edu,  Jinghao Jia <jinghao7@illinois.edu>,
 Siddharth Chintamaneni <sidchintamaneni@gmail.com>, Kumar Kartikeya Dwivedi
	 <memxor@gmail.com>
Date: Mon, 12 May 2025 21:40:15 -0700
In-Reply-To: <CAADnVQJZpyqY9TWanRKjmViOZxppAeh7FGAnxV_1CKAih7drkA@mail.gmail.com>
References: <20250420105524.2115690-1-rjsu26@gmail.com>
	 <20250420105524.2115690-4-rjsu26@gmail.com> <m27c2l1ihl.fsf@gmail.com>
	 <CAADnVQJZpyqY9TWanRKjmViOZxppAeh7FGAnxV_1CKAih7drkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-12 at 17:20 -0700, Alexei Starovoitov wrote:
> On Mon, May 12, 2025 at 5:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> >=20
> > - From verification point of view:
> >   this function is RET_VOID and is not in
> >   find_in_skiplist(), patch_generator() would replace its call with a
> >   dummy. However, a corresponding bpf_spin_unlock() would remain and th=
us
> >   bpf_check() will exit with error.
> >   So, you would need some special version of bpf_check, that collects
> >   all resources needed for program translation (e.g. maps), but does
> >   not perform semantic checks.
> >   Or patch_generator() has to be called for a program that is already
> >   verified.
>=20
> No. let's not parametrize bpf_check.
>=20
> Here is what I proposed earlier in the thread:
>=20
> the verifier should just remember all places where kfuncs
> and helpers return _OR_NULL,
> then when the verification is complete, copy the prog,
> replaces 'call kfunc/help' with 'call stub',
> run two JITs, and compare JIT artifacts
> to make sure IPs match.

Makes sense, much cleaner compared to special version of bpf_check().

> But thinking about it more...
> I'm not sure any more that it's a good idea to fast execute
> the program on one cpu and let it continue running as-is on
> all other cpus including future invocations on this cpu.
> So far the reasons to terminate bpf program:
> - timeout in rqspinlock
> - fault in arena
> - some future watchdog
>=20
> In all cases the program is buggy, so it's safer
> from kernel pov and from data integrity pov to stop
> all instances now and prevent future invocations.
> So I think we should patch the prog text in run-time
> without cloning.

Stopping all program instances makes sense.

However, this is orthogonal to preparing dummy version of the program.
Atomically converting program to dummy might be useful from the same
data integrity pov.

Also, patching for dummy might be an effort to make program side
effect free, e.g. by masking any map access.

Still curious about PTR_TO_BTF_ID and bpf_spin_lock().

[...]



