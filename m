Return-Path: <bpf+bounces-21566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D9F84EE33
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 01:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F7E3B218B8
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 00:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D857AA2A;
	Fri,  9 Feb 2024 00:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffOUYO/a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC47F6
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 00:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707437387; cv=none; b=OZ1Zc9o+vR042xHpBpspQ8lXJ23ZIVzav2NsSLP9taztkchvG+6xUWa9Aj8/DnfiCCJRq0P23j8bd9UxEM3AMve4+NfiKoD+dXJ0Dpmb7jMs/LneSh9z3fGH75ushVmbt2xBJ4wRMBJN+LjIXR4Z66aIehvO38TvTxt09Nm5Xwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707437387; c=relaxed/simple;
	bh=9O8ZZK89gU72wNo774u4ElkVFltu6/Ad9iTwR5J8DtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8wlMfEBDCzPby3wygclYhai9HFUzs72mBQ+gXgbZqNfF65IZKLgUQF1WQPMK6QbXEgBwlDdbQfYpH6HXYo2ShvdJ9b1hczj9ck8LY0FsSaWhzSd+On95wlFTUIR/Utn5qOLLiwMLK6SkplUXVLUmfyEduXt42s3O8wTDaqbsag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffOUYO/a; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41065fe9f4dso934975e9.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 16:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707437384; x=1708042184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8HozhgXGzWsxwtidwRDah0to0vUDQRDhf5YZ4ydn+I=;
        b=ffOUYO/aQTmdvhpuUSfzrL/kQ8+jsHFsxZf/YnvgHH8DgonoOBKS9TC7lz93jH804Q
         zuRRk3nBO4nNkbQdj4gOQtb8nAWn+9r0PPoV2qyQc5C7IFMQDpzSxndOz5gSh7A2qM8X
         /eVF3RxPsomL72MPhcGTTw5zDBfaNbc5o41Fu8ALpH1AZjaAvxEC9zLXb0id//rD3MX+
         zc1PaDJr/Ny3lQtXDu/gWFFdO3aDdH7FmjobooQWY7hKWsntl51g7Iysn31NFR0KcMD6
         yrTEGOPa7TVZQk1oPKRdWCA2N4IXREP9q7S8hu5vPEHZZWNiAGeHY7rr+lIeyivITzZJ
         PdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707437384; x=1708042184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8HozhgXGzWsxwtidwRDah0to0vUDQRDhf5YZ4ydn+I=;
        b=WZHpqz+LBiH9vtR0p1TTcgpF1zIFmh3cysMloWWi6qzI99kToTtu4bhya2E5zVY/YA
         glFQxSLcyDuXTg8NsWkJKcGBzVuGXpuYKE0q9GAPtHEJoaUueCQ1f2sMrAX030nPMsRw
         RqeyE7CqCWQbxH52JQicIRO8k7QyoFeYdq/WgOSRN04EDATFJKN7+BV8Nr74/s3tZLKY
         507VpFl+5kz+7PWYrSeYg6AptfSpjO2wkqsXXcZEIktPjvV5WIrYM8k8FriXd8EOF1GV
         nvAqwQd47luMIkXHVRdVVtJNYDEa+ee8qCB2dqtveXUSF6WscpRmPC3XbJEZAdCMRzR8
         FEhA==
X-Gm-Message-State: AOJu0YxVQQ4MToOf7RVfxx1JF4yet9RBf8v+fa/V9QipQvrZ48V6uG+R
	zKgwbMf+7j8Pnl/vPhECn3XWU/zecBxXjjlelAsTevP3ht17FV8HysXzUexb/I/Rq2vXLqAd/W5
	1Kw4Q/iHJc+DsNSZ+0fce/PcLgYvgDSvyJqE=
X-Google-Smtp-Source: AGHT+IEs70zjjHgurDqYMD606eRSQ2hAzMg3oZF1Bo087Wcp7WpaXTG52uZBWYp2IEMIrHuiNgoB0jbiPdxNwTD64P4=
X-Received: by 2002:adf:cc8d:0:b0:33b:1b0b:934a with SMTP id
 p13-20020adfcc8d000000b0033b1b0b934amr617634wrj.47.1707437383609; Thu, 08 Feb
 2024 16:09:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-2-alexei.starovoitov@gmail.com> <CAEf4BzYBjzHL20NU_yuj+en-YF0dJmHuvB1SOPGZc=tnbhjZhQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYBjzHL20NU_yuj+en-YF0dJmHuvB1SOPGZc=tnbhjZhQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Feb 2024 16:09:32 -0800
Message-ID: <CAADnVQLTt5S8HPcLv1hHWZFBXeU7HJNyocg7rE3rGrpnOuwxTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/16] bpf: Allow kfuncs return 'void *'
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 11:40=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Feb 6, 2024 at 2:04=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Recognize return of 'void *' from kfunc as returning unknown scalar.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index ddaf09db1175..d9c2dbb3939f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12353,6 +12353,9 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
> >                                         meta.func_name);
> >                                 return -EFAULT;
> >                         }
> > +               } else if (btf_type_is_void(ptr_type)) {
> > +                       /* kfunc returning 'void *' is equivalent to re=
turning scalar */
> > +                       mark_reg_unknown(env, regs, BPF_REG_0);
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> I think we should do a similar extension when passing `void *` into
> global funcs. It's best to treat it as SCALAR instead of rejecting it
> because we can't calculate the size. Currently users in practice just
> have to define it as `uintptr_t` and then cast (or create static
> wrappers doing the casting). Anyways, my point is that it makes sense
> to treat `void *` as non-pointer.

Makes sense. Will add it to my todo list.

On that note I've been thinking how to get rid of __arg_arena
that I'm adding in this series.

How about the following algorithm?
do_check_main() sees that scalar or ptr_to_arena is passed
into global subprog that has BTF 'struct foo *'
and today would require ptr_to_mem.
Instead of rejecting the prog the verifier would override
(only once and in one direction)
that arg of that global func from ptr_to_mem into scalar.
And will proceed as usual.
do_check_common() of that global subprog will pick up scalar
for that arg, since args are cached.
And verification will proceed successfully without special __arg_arena
.

