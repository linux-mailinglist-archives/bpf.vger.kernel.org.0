Return-Path: <bpf+bounces-19232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F038827B5C
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 00:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7D30B22AE5
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 23:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC7754BE8;
	Mon,  8 Jan 2024 23:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6JEm8VW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1141DDDC
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso2709049a12.3
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 15:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704755948; x=1705360748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Afg0AcqhIevhmFxuBteeGJ2HWHgx2Jjye14ZXducJlc=;
        b=f6JEm8VWkuAmrZ4rX8E+lWjQJV9NZTPg6SmfQWaB0Tukj3p3g6Xph+CbKqa8HiVIs9
         XRM11cdB3p5CxilO6+3xKHgNMER8DsqIE5Puxd4/ahNZjokw8QVer2wZv481fzUwEwlX
         YE/GCjBts4hGR4oeME4dX5ROnEc4XBAECl8nEcP25MGP+236aCVlkAP1MouYZSujVj77
         FZZZgpQLlptWWxD8cEDlVRAzSSuw3ETAAc6fDF4dZLr2uoOSNhG/rQ16SNrF6Agi3sq/
         4jGdS2Cx5FNI3QqSRKIhRnjBmnMZXx1OjI54/WGIb3N6Nz9josHKLMCTAv3GpF7Ug7EF
         zttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704755948; x=1705360748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Afg0AcqhIevhmFxuBteeGJ2HWHgx2Jjye14ZXducJlc=;
        b=TDdTiHeZ6IG4s+ekUg7nP98qOF24LiSuURnw7T+aXGYmnRW7KgOz94FG/uYGMFCCR/
         gNkjsFvlXyhFy/ZdTu1DSNfvNsRESLoGOF3BbAFupNfAAlCbUBHo79nSQaXUAbUFRI7k
         Dsir6zLby7DQqFLRM4pomaUnk5ACkrB+MbmRm5VtXrKDnnDhKcQwSZkN6TaCInXrGCT9
         eh0iWUkAR8mrU0bMsiMgfdOWG/D2g7m6eACWHnwr+8prIyXjpNABtnbxW6VYUSLttogY
         MmlXLDLjtIYC4CG5Ez2FBHry3KjMJK35ttiCfJFClyyoxRcOABKIaGQdYyZufHuhkdZd
         SK/Q==
X-Gm-Message-State: AOJu0Yzah1mswroXFRUuNRRxGC8WFSJtW7pBhWcVLwWCfUbqOjjCnMFd
	SGyUpGvMjtE8RiGzgL6F43zqjjHKn0JHVP0p3PI=
X-Google-Smtp-Source: AGHT+IFdDOXyH6MoNeiJiKCckpSduG1dtTsq2UkaVBxHSAfANzNM1nKOjCJXynTXQE8MW7sbi4C5WzJSLhqcNunTnco=
X-Received: by 2002:aa7:cd76:0:b0:556:e2c8:d693 with SMTP id
 ca22-20020aa7cd76000000b00556e2c8d693mr1483093edb.124.1704755947587; Mon, 08
 Jan 2024 15:19:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
 <f4c1ebf73ccf4099f44045e8a5b053b7acdffeed.camel@gmail.com>
 <cbff1224-39c0-4555-a688-53e921065b97@linux.dev> <69410e766d68f4e69400ba9b1c3b4c56feaa2ca2.camel@gmail.com>
 <CAEf4Bzb0LdSPnFZ-kPRftofA6LsaOkxXLN4_fr9BLR3iG-te-g@mail.gmail.com>
 <67a4b5b8bdb24a80c1289711c7c156b6c8247403.camel@gmail.com>
 <CAEf4BzZ8tAXQtCvUEEELy8S26Wf7OEO6APSprQFEBND7M_FXrQ@mail.gmail.com> <1c2e09212c4ac27345083a3c374dd82b0bbfdf2f.camel@gmail.com>
In-Reply-To: <1c2e09212c4ac27345083a3c374dd82b0bbfdf2f.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jan 2024 15:18:55 -0800
Message-ID: <CAEf4BzbxX6=oDjZS+uecSWerfR6Ob2h8sA6Y57jV_VE+Ep7GQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as imprecise
 spilled registers
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 3:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2024-01-04 at 17:05 -0800, Andrii Nakryiko wrote:
> [...]
> > > The test is actually quite minimal, the longest part is conjuring of
> > > varying offset pointer in r2, here it is with additional comments:
> > >
> > >     /* Write 0 or 100500 to fp-16, 0 is on the first verification pas=
s */
> > >     "call %[bpf_get_prandom_u32];"
> > >     "r9 =3D 100500;"
> > >     "if r0 > 42 goto +1;"
> > >     "r9 =3D 0;"
> > >     "*(u64 *)(r10 - 16) =3D r9;"
> > >     /* prepare a variable length access */
> > >     "call %[bpf_get_prandom_u32];"
> > >     "r0 &=3D 0xf;" /* r0 range is [0; 15] */
> > >     "r1 =3D -1;"
> > >     "r1 -=3D r0;"  /* r1 range is [-16; -1] */
> > >     "r2 =3D r10;"
> > >     "r2 +=3D r1;"  /* r2 range is [fp-16; fp-1] */
> > >     /* do a variable length write of constant 0 */
> > >     "r0 =3D 0;"
> > >     "*(u8 *)(r2 + 0) =3D r0;"
> [...]
> > Yes, and the test fails, but if you read the log, you'll see that fp-8
> > is never marked precise, but it should. So we need more elaborate test
> > that would somehow exploit fp-8 imprecision.
>
> Sorry, I don't understand why fp-8 should be precise for this particular =
test.
> Only value read from fp-16 is used in precise context.
>
> [...]
> > So keep both read and write as variable offset. And we are saved by
> > some missing logic in read_var_off that would set r2 as known zero
> > (because it should be for the branch where both fp-8 and fp-16 are
> > zero). But that fails in the branch that should succeed, and if that
> > branch actually succeeds, I suspect the branch where we initialize
> > with non-zero r9 will erroneously succeed.
> >
> > Anyways, I still claim that we are mishandling a precision of spilled
> > register when doing zero var_off writes.
>
> Currently check_stack_read_var_off() has two possible outcomes:
> - if all bytes at varying offset are STACK_ZERO destination register
>   is set to zero;
> - otherwise destination register is set to unbound scalar.
>
> Unless I missed something, STACK_ZERO is assigned to .slot_type only
> in check_stack_write_fixed_off(), and there the source register is
> marked as precise immediately.
>
> So, it appears to me that current state of patch #1 is ok.

I agree. Thinking some more I agree with you, what I was concerned
about should be handled properly at read time. So I think what we have
in this patch is ok. Sorry for the noise :)

>
> In case if check_stack_read_var_off() would be modified to check not
> only for STACK_ZERO, but also for zero spills, I think that all such
> spills would have to be marked precise at the time of read,
> as backtracking would not be able to find those later.
> But that is not related to change in check_stack_write_var_off()
> introduced by this patch.

