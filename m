Return-Path: <bpf+bounces-69113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B576FB8D1CB
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 00:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5661B23638
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 22:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68046264A76;
	Sat, 20 Sep 2025 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYCYjKjI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FB61EFF8D
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 22:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758407276; cv=none; b=udY2YOf5KgN0nmbodIuaz5FyPPWdwRnyrFY5EvChVViAzLIBVSvyTKOCrMuh0Y77Kq0LbgcA8xt5s7FHvefVssXIwyi3CLpFbSt2sdSI5mTlReMjSlyX28znfDxd5XIuELZgBBiJhyMchlcEj3vwxSQvDjguGidlEq3y0jVpljA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758407276; c=relaxed/simple;
	bh=rgGXhjwvpf+vsr1KvrlXK1SU7+NtUeC7YA0fHGFFQIA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PWm1PcLx8MHKh9Xn5kMhvN3YsOwMa7AhdgaLEzIHzzflMRJSlwDG4t13yefQLBo2M0ZJajy2QacWSDbq/DesmfvZXmNyKuwNIghX1s5YzisoKOAaMbKqY9iaP7zbyTga6xytQYYmnd/Z6eVlQ/AxBE9UwIuT+ItIID+KxyNzpVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYCYjKjI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f1f8a114bso393867b3a.0
        for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 15:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758407274; x=1759012074; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3rceCBgWy4NBMp6Z0ZeykHsQCFFAXrCO2PVkeavw4k=;
        b=RYCYjKjIxxi7860TwAaIjqKxrEa0eIVN9MyhbrQlmk2kpBjDTfsrn6LyHXKJeJLnBR
         68nC2mzdbfyLtak1FXEKyyd0x7tHxIDxp3FPn6qwUPGa+ZdDXWhJ/bfkyxbfGjbZb49C
         6vwgsc5IVSVJXryKdYQbcpZBOcrwiT7370oRJd5tcznfhphrG0j21M1NctDbd8LiQcR2
         Zxzf4qaISj3RGB0uqiq6b/EYFL1EhV1u+j6wzck5JgI8bVC6LYomjnBXRFfmS4ds/88S
         drR6zZTv5jDm6hESoZAJ+HrzLk9uOGdD0rBD6fcyJ8XlzXaDLXCTcsifC9ve2TYJHAVx
         0s/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758407274; x=1759012074;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i3rceCBgWy4NBMp6Z0ZeykHsQCFFAXrCO2PVkeavw4k=;
        b=VbHKPKbbqSv56MpIN1TTF+JJo8GRoeHDfJfgZk/4b3Xi4l/+IMdgF4iP1pT5o0Uf7M
         XF29BKld16KEY0qOeWhvcJXi6YRv4Kza1G6b0y5MxHf3PKITfY9eDptbw4ImlufOHYfg
         TAyrvcl4EelbVNlgR8GLD/cmWfObQ9cHQ1xPMJF5QVbiFxgY/F3revGR776ZRNfVejn0
         qP0ejLh3iff05akfv2/wrn8IZoceW0YXo9mTzy565RDhC2UP3vt/0V9cAGNtKpWU3LcF
         ysqFV9Q2A5D/kvSNW9Ekfy4F5KReC7gMJersiySraMHZ5Ce2w9+B6hr+ufUbBSSfWr4a
         mmkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOIkCe4tCn6t0xwrQnxEYenxIGOsF0VfZ1XpcXlccvd6eJVrQW7TaELOYpz55Xdp5jFis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJuUsEsGNwKaPH3j6Dfm9mtV/Awoxf7F8MJEB4Qq1LSvOY3cRC
	1bzdghNIbPW4NwHehEiAfXN5dDgo4RPltb7aaa/WBVSyLYrDHqJxYi5H
X-Gm-Gg: ASbGncubehlR4WiUQSOXkH6dzE1ZUL/+1oC2leEDKlGfa66QJRWb3a5HAL3Fefh/GpE
	yTGkR3JKmvTKPNdKcTZOzw6/WO/3nJio6cOWeD4PEM9UftdZda0u35TcE13BSlCwUD/Sg2iMqIk
	87fw34vOUx2eIX1xRqwK63wkwKx+R7Fipd1WJJcDutaMqCPWolJK9LjLOUaut+qNua+ZTJJWz8s
	Epah8XizfCaqD7obg2q7WBeCm3tD/LEKuVtEO/lOsoX0RQQGJFVvfXeP5w+DA2Rf+YU7rA4Ow/k
	QSog8ZpAVzLEkWI0TSKW/cHSOSROuG83YIxYluRQ//pbSVYraXAqrtdsgo0JJ24asxfG7NcxzO7
	WX+rRqxLRi1U7VpmsVYeHZ1VnYS+Zvw==
X-Google-Smtp-Source: AGHT+IH2wkjONavFhZfH1lpyY01lIDQReuyqhmOJ6gjsvMX2YuvqPyErSE0eHWIJIZpI3Xug6xzC9A==
X-Received: by 2002:a05:6a00:1582:b0:77e:4534:7f1c with SMTP id d2e1a72fcca58-77e45347f9emr9356590b3a.0.1758407273691;
        Sat, 20 Sep 2025 15:27:53 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77dc606e10fsm7456853b3a.65.2025.09.20.15.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 15:27:53 -0700 (PDT)
Message-ID: <8f529733004eed937b92cc7afab25a6f288b29aa.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 13/13] selftests/bpf: add selftests for
 indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Sat, 20 Sep 2025 15:27:50 -0700
In-Reply-To: <71cc9b1aaae03dc948f2543b44efab2ed6c1b74f.camel@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
		 <20250918093850.455051-14-a.s.protopopov@gmail.com>
	 <71cc9b1aaae03dc948f2543b44efab2ed6c1b74f.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-19 at 17:58 -0700, Eduard Zingerman wrote:
> On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> > Add selftests for indirect jumps. All the indirect jumps are
> > generated from C switch statements, so, if compiled by a compiler
> > which doesn't support indirect jumps, then should pass as well.
> >
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
>
> Patch #8 adds a lot of error conditions that are effectively untested
> at the moment. I think we need to figure out a way to express gotox
> tests in inline assembly, independent of clang version, and add a
> bunch of correctness tests.
>
> [...]

Here is an example (I modifier verifier_and.c, the patch should use
some verifier_gotox.c, of course):

  #include <linux/bpf.h>
  #include <bpf/bpf_helpers.h>
  #include "bpf_misc.h"
  #include "../../../include/linux/filter.h"

  SEC("socket")
  __success
  __retval(1)
  __naked void jump_table1(void)
  {
  	asm volatile (
  ".pushsection .jumptables,\"\",@progbits;\n"
  "jt0_%=3D:\n"
  	".quad ret0_%=3D;\n"
  	".quad ret1_%=3D;\n"
  ".size jt0_%=3D, 16;\n"
  ".global jt0_%=3D;\n"
  ".popsection;\n"

  	"r0 =3D jt0_%=3D ll;\n"
  	"r0 +=3D 8;\n"
  	"r0 =3D *(u64 *)(r0 + 0);\n"
  	".8byte %[gotox_r0];\n"
  "ret0_%=3D:\n"
  	"r0 =3D 0;\n"
  	"exit;\n"
  "ret1_%=3D:\n"
  	"r0 =3D 1;\n"
  	"exit;\n"
  	:
  	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0,=
 0, 0 , 0))
  	: __clobber_all);
  }

  char _license[] SEC("license") =3D "GPL";

It verifies and executes (having fix for emit_indirect_jump() applied):

  VERIFIER LOG:
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  func#0 @0
  Live regs before insn:
        0: .......... (18) r0 =3D 0xffff888108c66700
        2: 0......... (07) r0 +=3D 8
        3: 0......... (79) r0 =3D *(u64 *)(r0 +0)
        4: .......... (0d) gotox r0
        5: .......... (b7) r0 =3D 0
        6: 0......... (95) exit
        7: .......... (b7) r0 =3D 1
        8: 0......... (95) exit
  Global function jump_table1() doesn't return scalar. Only those are suppo=
rted.
  0: R1=3Dctx() R10=3Dfp0
  ; asm volatile ( @ verifier_and.c:122
  0: (18) r0 =3D 0xffff888108c66700       ; R0_w=3Dmap_value(map=3Djt,ks=3D=
4,vs=3D8)
  2: (07) r0 +=3D 8                       ; R0_w=3Dmap_value(map=3Djt,ks=3D=
4,vs=3D8,off=3D8)
  3: (79) r0 =3D *(u64 *)(r0 +0)          ; R0_w=3Dinsn(off=3D8)
  4: (0d) gotox r0
  7: (b7) r0 =3D 1                        ; R0_w=3D1
  8: (95) exit
  processed 6 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
  #488/1   verifier_and/jump_table1:OK
  #488     verifier_and:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

This example can be mutated in various ways to check behaviour and
error conditions.

Having such complete set of such tests, I'd only keep a few canary
C-level tests.

