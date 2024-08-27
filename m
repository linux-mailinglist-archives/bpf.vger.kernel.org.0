Return-Path: <bpf+bounces-38215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EDB961A1C
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 00:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07DE5284EBE
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 22:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB421D4153;
	Tue, 27 Aug 2024 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAeehghO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816271714BC
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724798568; cv=none; b=awXxTcptLe9ZrYtzR7Hr/riKRy5QnSWyWhxOGBdrLdPdNchTltoBvUu6+ahEelb9G81gOMH2KvPaGrMuo5rIoACeo81O85NZ7fAL8216r+jL+3pZzZEjAv80un9SO8O8umAzdilyCT2UYKArEU7KSSWR/WI6BGhAMLnYT/nYjbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724798568; c=relaxed/simple;
	bh=xlvXWk+Xo8gJoAoa/TErrg7p7KssrF15TVYs6ouOhYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Umbgw8HlK8k8V24qNNJeTKX/TQvVK5ehCwASGFQjs16ImVSrNznXSuIhImx8r3k/qXCVW64ePjQVsAKbk4FQP9/1OoTX1iXTTRX1c14KT6YBDB++Oiu4+IP6M0wI9Yip7XWuHwDXAWQ91sH/bxNfdnHAIjRz+Xd/o9wu5/kxrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAeehghO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3e46ba5bcso4427761a91.0
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 15:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724798567; x=1725403367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whF/5sXXv6rEL9GXxWYoJB5qCmtuqRaG/5OD9cJc9wc=;
        b=IAeehghOXLkttWuveARcfnKhbsZn9V2zkLNrtnknfrKnTYyptGdaqtl20j/22/82ER
         MfaUUPAgvoVQ1TwnNEVxf+sdHaV2AoxjAk3UJtAa9COp58Em9M/4F/V5ELN64p+aOVFG
         tG0aXlI9uyQV6DMhn6bYbLgZo0oCT71ynOqbLnAeoOKi3pkAkGogODsH2zAj2N/CiCP0
         rx5/d39B5vaIAAptW7lEIAEU0Hslx7K/ilsmO8httoP82Sv/RzG+FwgiYYSdoTpFYJIf
         0AimV3V3DuRlDRPCWKRqubF7bL+Adz+ffnlIH4DGHOWZ35ZWWFZxvVXeyVM1TvbNFdNv
         5znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724798567; x=1725403367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whF/5sXXv6rEL9GXxWYoJB5qCmtuqRaG/5OD9cJc9wc=;
        b=rFgc2fa3Y0utRB7vViO0HPGcdDVcerhn0lV/380WgC6sfa+9rBsGVlAVcgoBDBLaiS
         pbSJHPEptPPhN9iTsG2AnQtdNOEjkqqRkAn6LC+Hf2EmVjgIxt2IfVbOLwSqqvAKJ69y
         issTFQ66DUKPasQZyCoHyWqT6rdn0537i1AdYddO2C4WEwod/xd4NLLXwkkh+MtcvCSQ
         3s7QozaDbnbD1RPdLSlbZe3ywF8sqbUdE/Lyfi44DJ5UwczDWr1ul0xqKKylUjmqIkao
         ZxvX6AXACo2g90iOlTHDbdhMTDA540APPO1kSDGIcyKsqP0PxnZTvfCp0/0XIyrjxWKE
         Lfkw==
X-Forwarded-Encrypted: i=1; AJvYcCV3f50Dwa2zToJUh8n73d/9c/7omCmuhu27Vwq+luYGYo/UaWRo0WwNt9bFHE4+nncJJV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC4JfM1hEq4dyBgiXGu3848j6KMYmLayUiTg06w7w59qjGQfCi
	WJqYD6alkefCVF/8afrxUzDMU/bEx62tMgtZN3osUR5kYkvVi8WIu4fm+ScQ3ds2yJDbGTslKBq
	+w/0xvC9W0caw2LlKBbSwBVjrNUs=
X-Google-Smtp-Source: AGHT+IEKKV3anTY6Ksrd/6I26roGl2XsD1P3t50ACIqTFXo2sl/9t1WV8hEogXaOgWJMdrHxdcwTbiDHVWb3F1ifhfk=
X-Received: by 2002:a17:90b:33ca:b0:2d3:d09a:630e with SMTP id
 98e67ed59e1d1-2d8440bfa21mr252885a91.1.1724798566773; Tue, 27 Aug 2024
 15:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826224814.289034-1-inwardvessel@gmail.com>
 <20240826224814.289034-2-inwardvessel@gmail.com> <CAADnVQJp3Me_tXRs6Nupbi93bAj2D-sFuN-N7DMfKU=EtMu5ow@mail.gmail.com>
In-Reply-To: <CAADnVQJp3Me_tXRs6Nupbi93bAj2D-sFuN-N7DMfKU=EtMu5ow@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Aug 2024 15:42:34 -0700
Message-ID: <CAEf4BzaaZqiRGwK5=GHrd81HgtVbWfXOSWAeyorHgbCVjsv-jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: new btf kfunc hooks for tracepoint
 and perf event
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: JP Kobryn <inwardvessel@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Eddy Z <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 2:01=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Aug 26, 2024 at 3:48=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com=
> wrote:
> >
> > The additional hooks (and prog-to-hook mapping) for tracepoint and perf
> > event programs allow for registering kfuncs to be used within these
> > program types.
> >
> > Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> > ---
> >  kernel/bpf/btf.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 520f49f422fe..4816e309314e 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -210,6 +210,7 @@ enum btf_kfunc_hook {
> >         BTF_KFUNC_HOOK_TC,
> >         BTF_KFUNC_HOOK_STRUCT_OPS,
> >         BTF_KFUNC_HOOK_TRACING,
> > +       BTF_KFUNC_HOOK_TRACEPOINT,
> >         BTF_KFUNC_HOOK_SYSCALL,
> >         BTF_KFUNC_HOOK_FMODRET,
> >         BTF_KFUNC_HOOK_CGROUP_SKB,
> > @@ -219,6 +220,7 @@ enum btf_kfunc_hook {
> >         BTF_KFUNC_HOOK_LWT,
> >         BTF_KFUNC_HOOK_NETFILTER,
> >         BTF_KFUNC_HOOK_KPROBE,
> > +       BTF_KFUNC_HOOK_PERF_EVENT,
> >         BTF_KFUNC_HOOK_MAX,
> >  };
> >
> > @@ -8306,6 +8308,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_p=
rog_type prog_type)
> >         case BPF_PROG_TYPE_TRACING:
> >         case BPF_PROG_TYPE_LSM:
> >                 return BTF_KFUNC_HOOK_TRACING;
> > +       case BPF_PROG_TYPE_TRACEPOINT:
> > +               return BTF_KFUNC_HOOK_TRACEPOINT;
>
> why special case tp and perf_event and only limit them to cpumask?
> The following would be equally safe, no?

Assuming we don't have kfuncs that accepts program context (like
bpf_get_stack(), if it was a kfunc) and that doesn't access
bpf_run_ctx (like bpf_get_func_ip()). We just need to be careful about
adding new special kfuncs like that going forward (not sure how to
best ensure we don't forget, though). Other than that I agree that
it's all "tracing".

>          case BPF_PROG_TYPE_TRACING:
>          case BPF_PROG_TYPE_LSM:
>  +       case BPF_PROG_TYPE_TRACEPOINT:
>  +       case BPF_PROG_TYPE_PERF_EVENT:
>                 return BTF_KFUNC_HOOK_TRACING;
> ?

