Return-Path: <bpf+bounces-37086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F43950DAF
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 22:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6625A1C224D2
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 20:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCB51A4F37;
	Tue, 13 Aug 2024 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSVByu0b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99A1A953;
	Tue, 13 Aug 2024 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723579953; cv=none; b=GO9FpWLJaS/9LZScDZqLfB81WoH80F5HyFe0Jt5P2FjI7Wqx1+oTPPD49CP33QDQJLxIAo7aE4ZR7ERBBpnpYlidqu3aHhqpyrs7Ix1+/kfXMSgwGrZIi/BshDpusQeKHScgIZftKUnte45eoX+gNA43+f/PV/nZXQbDOVw8UbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723579953; c=relaxed/simple;
	bh=5u36H725u7YM/yBXV6gv0ADfXGXYgymxFyIZmx+o3E0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tUHGHKCLylaDtM2mvA+f3wNNJ6/mhYKuJupcEbSr1zHnZjCbf9Ze0f8xHJoT610byiNGNKPfhRuY3wlL4WJ4PK8SysbrBxvoz8jCIlCt8AoutuzuzcAIfR0QK9TU6uzUFSevv2rRLWSt9EIxna4q6BOVpcqTvKrRphrmaYHHQWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSVByu0b; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cd34c8c588so3985544a91.0;
        Tue, 13 Aug 2024 13:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723579950; x=1724184750; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B9SLo+DqWSkLbaZ+1FAFDGoEFjdD3wjKHYKFV7J+Y0E=;
        b=mSVByu0bA/vybG67omchQb2zja5yFhKEN4FDRv0hO7D025v0KGhs0HPax77RBMPeY5
         VmidMac2Ox8iJPqP8d3qD6qTs9Ci++ENFBFOCIy8WjTOfaBnNY+1fgTrZWrQyJnD0YiM
         JWkVpm6A/EBNG/a87TMIqe5oPUNTZnBMCLztBFUbMpHmyMsJKD8YyXWkSTc6Xqn369NU
         fnhFUxOg6BaU3a0Llr5DqdEspmA2R2FaBTQwwLryc1cRNLvBcFe5IQ/2mZmAGN7zyaTL
         R0i5FYe5MNPWmGZ9tpSz9BzE0M5JWD0EQgfz1IrWvv/sXr3eL/kFPrxCwvEXheA6kzpX
         PL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723579950; x=1724184750;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9SLo+DqWSkLbaZ+1FAFDGoEFjdD3wjKHYKFV7J+Y0E=;
        b=OxCYXYtB9/hMVrPtj5fPk0gXnaEVAyyAtD1VsxWf/qqDhvLeJbNRygAo1+Tkf+Dyk0
         eaSaeqBRKiijikcE08Xv1kZTw+mO27/8JPRRedlN3lJos68rVlFg+dUcasyeMPTq0kOI
         B/sagv+xxITwilzN53yYABk9YJ5VlzDr7+Op+5pdnYaA0Z+ABRc33RwdqAt1HWAmPo7M
         PjhelMYfrw5HBu5QQs4kaOrPMAY/p0dVFf1WKKty9Fyw0Wm45aYejLduA9urttbSqXIw
         kTp9ZVnMLtF+xhcHevDfM2Ob/cMww+Hl83YBFaHUpwfykn9aztrfAdbEAcemMTIk38+f
         8Bxw==
X-Forwarded-Encrypted: i=1; AJvYcCVYc6pR+t0zkLfGeX9WgHCPFBs4M6lzF73uFsvlvkT4wqmLlS/NKdQhTzydMsPWZBHGUvPwXG/UJFyZMl5UOc/mU9Xu+JL0yN/UAFgDT8q5yZ5LY3YavezEPYSMzeCJnwGGfw+7CfJLdeLf85mRZQrym/ahwCmGhL8csUX3AUhzzHLs
X-Gm-Message-State: AOJu0Yz2I0SZ3Op4CL47d2N0VWNMJvgpasl2scYdDhm6yJh75MCfyZsa
	PCLVs8jRdKLIH2dpW7NhPEw45fZq8Z++iAeDNQoK5SG2RivgBv8m
X-Google-Smtp-Source: AGHT+IEf8jvCbSdbwKuXTm9Y3aCLJaOWfwg3qVgYFfnlfSqSpO01MWdxFX+y1bLDGuEEfou8ART7YA==
X-Received: by 2002:a17:90a:d718:b0:2cd:4100:ef17 with SMTP id 98e67ed59e1d1-2d3aab6bb5fmr721344a91.31.1723579950092;
        Tue, 13 Aug 2024 13:12:30 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fced1838sm7844982a91.23.2024.08.13.13.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 13:12:29 -0700 (PDT)
Message-ID: <20ea4046cacfb774b0fe5e9dd3337999da2b63dc.camel@gmail.com>
Subject: Re: [PATCH] bpf: Annotate struct bpf_cand_cache with __counted_by()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Thorsten Blum
	 <thorsten.blum@toblux.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Kees Cook
 <kees@kernel.org>,  "Gustavo A. R. Silva" <gustavoars@kernel.org>, bpf
 <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-hardening@vger.kernel.org
Date: Tue, 13 Aug 2024 13:12:24 -0700
In-Reply-To: <CAADnVQKw5x6sTwj62p4vxSqtjdisHEKhtKdPp_zK4t7rtDuWhQ@mail.gmail.com>
References: <20240813151752.95161-2-thorsten.blum@toblux.com>
	 <CAADnVQKEgG5bXvLMLYupAZO6xahWHU7mc06KFfseNoYUvoJbRQ@mail.gmail.com>
	 <2A7DB1E6-4CCE-446E-B6F1-4A99D3F87B57@toblux.com>
	 <CAADnVQKw5x6sTwj62p4vxSqtjdisHEKhtKdPp_zK4t7rtDuWhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-13 at 11:57 -0700, Alexei Starovoitov wrote:
> On Tue, Aug 13, 2024 at 10:59=E2=80=AFAM Thorsten Blum <thorsten.blum@tob=
lux.com> wrote:
> >
> > On 13. Aug 2024, at 18:28, Alexei Starovoitov <alexei.starovoitov@gmail=
.com> wrote:
> > > On Tue, Aug 13, 2024 at 8:19=E2=80=AFAM Thorsten Blum <thorsten.blum@=
toblux.com> wrote:
> > > >
> > > > Add the __counted_by compiler attribute to the flexible array membe=
r
> > > > cands to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> > > > CONFIG_FORTIFY_SOURCE.
> > > >
> > > > Increment cnt before adding a new struct to the cands array.
> > >
> > > why? What happens otherwise?
> >
> > If you try to access cands->cands[cands->cnt] without incrementing
> > cands->cnt first, you're essentially accessing the array out of bounds
> > which will fail during runtime.
>
> What kind of error/warn do you see ?
> Is it runtime or compile time?
>
> Is this the only place?
> what about:
>         new_cands =3D kmemdup(cands, sizeof_cands(cands->cnt), GFP_KERNEL=
);
>
> cnt field gets copied with other fields.
> Can compiler/runtime catch that?

I think that generated check is mechanical, sanitizer wraps access to
array with size check using the value of associated counter, e.g:

    12:52:20 tmp$ clang -fsanitize=3Dundefined ./test.c
    12:52:53 tmp$ ./a.out
    test.c:11:3: runtime error: index 0 out of bounds for type 'int[]'
    SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior test.c:11:3
    12:52:55 tmp$ cat test.c
    #include <alloca.h>

    struct arr {
      int cnt;
      int items[] __attribute__((__counted_by__(cnt)));
    };

    int main(int argc, char **argv) {
      struct arr *arr =3D alloca(sizeof(struct arr) + sizeof(int));
      arr->cnt =3D 0;
      arr->items[arr->cnt] =3D 42;
      arr->cnt++;
      asm volatile (""::"r"(arr));
      return 0;
    }
    12:53:07 tmp$ clang -fsanitize=3Dundefined ./test.c
    12:53:10 tmp$ ./a.out
    test.c:11:3: runtime error: index 0 out of bounds for type 'int[]'
    SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior test.c:11:3
    12:53:13 tmp$ cat test.c
    #include <alloca.h>

    struct arr {
      int cnt;
      int items[] __attribute__((__counted_by__(cnt)));
    };

    int main(int argc, char **argv) {
      struct arr *arr =3D alloca(sizeof(struct arr) + sizeof(int));
      arr->cnt =3D 1;
      arr->items[arr->cnt - 1] =3D 42;
      asm volatile (""::"r"(arr));
      return 0;
    }
    12:53:34 tmp$ clang -fsanitize=3Dundefined ./test.c
    12:53:36 tmp$ ./a.out
    12:53:38 tmp$ echo $?
    0

Or here is the IR generated for C program:

    struct arr {
      unsigned int cnt;
      int items[] __attribute__((__counted_by__(cnt)));
    };

    void push(int i, struct arr *arr) {
      arr->items[arr->cnt] =3D 42;
      arr->cnt++;
    }

Note the 'cnt' passed as a parameter to '@__ubsan_handle_out_of_bounds':

    define dso_local void @push(i32 noundef %0, ptr noundef %1) local_unnam=
ed_addr #0 !func_sanitize !3 {
      ...
      %11 =3D load i32, ptr %1, align 4
      %12 =3D zext i32 %11 to i64
      tail call void @__ubsan_handle_out_of_bounds(ptr nonnull @6, i64 %12)=
 #2, !nosanitize !4

[...]


