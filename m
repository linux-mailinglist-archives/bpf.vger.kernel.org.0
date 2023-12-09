Return-Path: <bpf+bounces-17310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EAF80B20E
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 05:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103451F212F8
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 04:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C8B15AB;
	Sat,  9 Dec 2023 04:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdDw6XuB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0F5193
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 20:44:20 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54f4f7d082cso1793654a12.0
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 20:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702097059; x=1702701859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCMJq+MYSEytTElixe5m61r9B0g5p5XaPpyPcq+n328=;
        b=IdDw6XuBrtCMf4mqL5sBOLu6N7RGNuKXXuD04+X46H/TNTq8Qw7hEYMWD7SKL5xdeQ
         QG0e9xuAIF1rNs4pCdS7yda/DF5yu3eK7/hH6/RUfEmDk02M3skM3XYw4jA7TruA1+BK
         R/hrj7LqxRkEokfCeuEoFgDGZm9L8MUejoLakINo5fKtuqgoNxsCZMTAt+FQGnQwhBgG
         iOK/IrkFDnxzxHxx/u+h+QpCwvCQx9XimL+bgF/Q0AGjiXcB+aGUVgkPPpFJhQtwBgZG
         U8alSDzSFDJuAL5Wy9yd1Tsoo9NcioWY6rzwFXE8LX7PfUq6qha3YI7bEbPsoz3aXV6/
         YYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702097059; x=1702701859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCMJq+MYSEytTElixe5m61r9B0g5p5XaPpyPcq+n328=;
        b=GGEpmPJywPFVnBNMUpuRrk0M+1WFXS2sb9WCHD66y4/yHTuvzU+ImdxylOYf2+9ntB
         JP205sYXtvAx1C7dCFX8jzr/54NhCD/JL/zFAcdP41BkNMPdA+Tkfe2D2qcAbNhd0OSi
         KY/gjGZI8ugBZ5EwXQHffNoC7227APzErXPVKZPljzLJNKlRiClkgTAx+J4iz4Tr78Zl
         3jehFJWfosHGi+Kc/BuYRJgYpz4IxtuVl48hcuWZpiAtxjOSU4Ltvb4m2YMKpIGW+GXO
         IYIBJXAhoQ4M4DHqvJ0wj4CtKBOeeHOU344zttmOR9rMhv4ag93fWvxmjyq+ieL+MOtV
         HNQg==
X-Gm-Message-State: AOJu0YwcYkyl0DasJ+fNxHi/yyrUCMI7SL2h8vMNm0oUmkeu4nofRio7
	KXLXgroSrq/mzEkrxwYMJQQu9+1rZkq5FpxlwxE=
X-Google-Smtp-Source: AGHT+IG+WQ/lewk8vxrh/pulDYbr/nesaiKUwAGABuWA0xAk7Af3hPHqTwQmcPGg3VziJJgXgUBVqtIXNRCD84D+eeg=
X-Received: by 2002:a17:906:4a18:b0:a1d:3858:9c62 with SMTP id
 w24-20020a1709064a1800b00a1d38589c62mr432276eju.102.1702097058511; Fri, 08
 Dec 2023 20:44:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231209010958.66758-1-andrii@kernel.org> <bff7a93dc02d42f71882d023179a1b481f5c884b.camel@gmail.com>
 <CAEf4BzaE6TiThSaq7+=KERW=zP4G6vJz1nQ6-EWQrpnF4Np=-w@mail.gmail.com> <CAADnVQJUNu3MyfqPk2-V8_x6Qqf-UbfnSK2RSQJbfB318WHq-g@mail.gmail.com>
In-Reply-To: <CAADnVQJUNu3MyfqPk2-V8_x6Qqf-UbfnSK2RSQJbfB318WHq-g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Dec 2023 20:44:06 -0800
Message-ID: <CAEf4BzareU4+t_QG0xTpqhS1MdQvqN_aWxbEpaLTN-GCi6u8vA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: handle fake register spill to stack
 with BPF_ST_MEM instruction
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 6:28=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Dec 8, 2023 at 6:15=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > See above, MISC/ZERO is fine as is due to check_stack_read_fixed_off()
> > not setting STACK_ACCESS bit, but I can also send a version that
> > unconditionally sets INSNS_F_STACK_ACCESS in
> > check_stack_write_fixed_off().
>
> but it will significantly increase jmp_history and make
> backtracking slower?

Good point about jmp_history length, so I guess we can leave the patch as i=
s.

I don't think it will make backtracking slower, though, the algorithm
will process the same amount of instructions regardless of jmp_history
length.

