Return-Path: <bpf+bounces-39555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7259697476E
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 02:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD627287C16
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 00:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2626C147;
	Wed, 11 Sep 2024 00:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+3sbUgC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB358BA20;
	Wed, 11 Sep 2024 00:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726015085; cv=none; b=VEGGFQD3V/8VVpqMXrdOP1pVuxsgOBQ9NSLVlXstAVFwD0/7SAsjUxPRvRcbS8w9zNCgaQnRLXlrLrW6sIlBlNjXnDNSEX3dppjl6NKyhhk9wXqUna3yh7O+ZoUpfgfpoYmsc6L8R+fSQPEkpm7WBnSNkX7C+ZaZpHlIvk5olxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726015085; c=relaxed/simple;
	bh=ntNZy9gVp+g/S3Rw9fj9t5cY/QvmijBzVHjXxrMusB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uM0ZgEku6uCdsnW+Zo5zgpKH3ihYJTlcyhPZz2DseSstP8+myLbHWq2aU0GB5fbNcscGf+tQToVITfWQ0/xUsLpodv9DUs75KIEV7gaQfES0ofSae3I0Y3qPGay3V15IFUmxs06abaB3CT0U7eLTSFVmZRj1XNWrDYPtFSw0OXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+3sbUgC; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d87f34a650so264371a91.1;
        Tue, 10 Sep 2024 17:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726015083; x=1726619883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uEZF446y8UFXekIc+a8WzDSWW2PtnQSzLmBNm4ligQ=;
        b=U+3sbUgCx4uaXyEdmsWaqy2u5SsJGlgqPABlKryNMEojJKY6s9SrLZFoApzam2cA6Q
         jlCVLvAfTFoT/An2GY21u8fLAXNgVUNVT4JKxS+SyQDTdEbXgLbDvH+7gkRD0dWqeeFA
         Mg9yyIDsFsx2i7lrJvN6mum+jQWaO9qMXfVBqxBm6ferPxaE6dBBb0mAGOCNGIacTswG
         JAKzGKq2i9cmhua3309aXxuDdHJohJdkHYUd04Km19Xsa054zN4L6zXDcP0KbN1ef5D+
         zwr3zW+5e7jM04FsQa4XitIcG+2yEJxlainO1kY4wdV2ttuh6gCMfEmDKyi3RPEKG4PJ
         oc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726015083; x=1726619883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uEZF446y8UFXekIc+a8WzDSWW2PtnQSzLmBNm4ligQ=;
        b=t1Ru26E/V1FDtQXwtI/VE0bKwsNBLd/6rQ4TTFVeF6058e3y0Wg7hTqZZJz+YEP+2X
         bQICC6kPf8jvCaa5Xbel5CXNFrc3EylDhw4hURAxIvCPJb7xkOmzBjFV1RfsjFFnk4KL
         yo8v9q/Qsbtf0t4B/ylCYjRVkRhPGM/wqShDsTFkNwF/Zb9yOIlmZpK/zK3/P3spB3F5
         JuSUsAF/fTL1Xhy0v12UQR85gWJ/3YlhvMPMIEpm6+P7oiX5Op2o0HxGLrgf90smT59I
         zf0MnxqQUMAPnQSrTU1q0hPE+bXb6J6tALVksutytChqz6EIxxmucP3PQ00EVrM2ygEC
         0fow==
X-Forwarded-Encrypted: i=1; AJvYcCVkwTa8vph99b8QseOjmWAzBOls5zsdzRNWKc167lQ+BYhD43XdwGGJe3LUsC+OtSVsORaHg8O6AEcRi+ZWjxCe9nkm@vger.kernel.org, AJvYcCXVKnYknE3qCpMgpGjzPs1USdtY6mIdoyg0kS2S9hhUKWKBEcZToMbWfsa9qOKGPAZNodI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd4mBeOg7LF9sbbvwCyn8ofmRu22C3vO/FX5ohlWbc39tKeKp5
	5DX1lYz67QY70Y9UTDCBGqVxMibiMsscYNe/9fEbrKzdXoSdyQP9NCBhChJeUp3F/Cp4VuHStQg
	ZPK8grT4QieVM8hF3cn43hBl62H0=
X-Google-Smtp-Source: AGHT+IFnbUMH/jPJGv8/7u9/NdR5/gZOu8WSCGPmPN2WhoZ8cAttEWKZ6YQCtrpiSiUXBTNFm2K8o01919ma3jNBt2o=
X-Received: by 2002:a17:90a:c705:b0:2d8:b043:9414 with SMTP id
 98e67ed59e1d1-2db671fc520mr7565215a91.18.1726015083010; Tue, 10 Sep 2024
 17:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
 <CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com> <20240911091343.77c60bc2e5d96cbfd8787c19@kernel.org>
In-Reply-To: <20240911091343.77c60bc2e5d96cbfd8787c19@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 17:37:48 -0700
Message-ID: <CAEf4BzbdxSbaK1V10j8t_rjG4ZnYsFQLqPrBSswR8KhjmC=5cg@mail.gmail.com>
Subject: Re: Unsupported CONFIG_FPROBE and CONFIG_RETHOOK on ARM64
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, adubey@linux.ibm.com, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, KP Singh <kpsingh@chromium.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Florent Revest <revest@chromium.org>, 
	Puranjay Mohan <puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 5:13=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Tue, 10 Sep 2024 11:23:29 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > + arm ML and maintainers
> >
> > On Wed, Sep 4, 2024 at 6:02=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > Hey,
> > >
> > > I just recently realized that we are still missing multi-kprobe
> > > support for ARM64, which depends on CONFIG_FPROBE. And CONFIG_FPROBE
> > > seems to require CONFIG_HAVE_RETHOOK, which, it turns out, is not
> > > implemented for ARM64.
> > >
> > > It took me a while to realize what's going on, as I roughly remembere=
d
> > > (and confirmed through lore search) that Masami's original rethook
> > > patches had arm64-specific bits. Long story short:
> > >
> > > 0f8f8030038a Revert "arm64: rethook: Add arm64 rethook implementation=
"
> > > 83acdce68949 arm64: rethook: Add arm64 rethook implementation
> > >
> > > The patch was landed and then reverted. I found some discussion onlin=
e
> > > and it seems like the plan was to land arch-specific bits shortly
> > > after bpf-next PR.
> > >
> > > But it seems like that never happened. Why?
> > >
> > > I see s390x, RISC-V, loongarch (I'm not even mentioning x86-64) all
> > > have CONFIG_HAVE_RETHOOK, even powerpc is getting one (see [0]), it
> > > seems. How come ARM64 is the one left out?
> > >
> > > Can anyone please provide some context? And if that's just an
> > > oversight, can we prioritize landing this for ARM64 ASAP?
> > >
> > >   [0] https://lore.kernel.org/bpf/20240830113131.7597-1-adubey@linux.=
ibm.com/
> > >
> >
> > Masami, Steven,
> >
> > Does Linus have to be in CC to get any reply here? Come on, it's been
> > almost a full week.
>
> Sorry about bothering you, let me check that. But I think we eventually

You don't bother me, but I'd appreciate a bit more timely replies in
the future, if that's OK.

> need my fprobe-on-fgraph patch which allows all architecture uses ftrace_=
regs
> instead of pt_regs for ftrace/fgraph users. That allows arm64 to implemen=
t
> fprobe.

Ok, thanks for a bit more context. I understand the end goal with
fprobe-on-fgraph, but see below.

>
> >
> > Maybe ARM64 folks have some context?... And hopefully desire to see
> > this through so that ARM64 doesn't stick out as a lesser-supported
> > platform as far as tracing goes compared to loongarch, s390x, and
> > powerpc (which just landed rethook support, see [2]).
>
> I think lesser-supported or not is not a matter, but they need to keep
> their architecutre healthy. Mark said that the current rethook
> implementation is not acceptable because arm64 can not manually generate

I don't see Mark's reply in the link you sent. But did he refer to the
code in kprobes_trampoline.S or is it something different?

By lesser-supported I mean that a very important functionality (BPF
multi-kprobe, which relies on CONFIG_FPROBE and thus
{HAVE|CONFIG}_RETHOOK) is currently still missing. And whether x86-64
support landed more than 2 years ago (end of March 2022), the second
practically most popular (and thus important for tools and such) ARM64
platform still doesn't have this functionality.

And that's limiting, BPF multi-kprobes are a huge improvement in
tooling usability. So while I get the desire to have a clean and nice
end goal, and that it might take a bit longer to get everything right.
But, maybe, landing a stop-gap solution meanwhile (especially as
isolated and thus easily backportable as the patch [0] you referenced)
is an OK path forward?

I'm just lacking full understanding on what exactly the issue is/was,
and that's why I'm asking all these questions. I'm not sure if [0] is
just broken for some subtle reason, or it is just suboptimal in some
sense (performance, code duplication, whatnot)?


  [0] https://lore.kernel.org/bpf/164338038439.2429999.17564843625400931820=
.stgit@devnote2/

> pt_regs. So we need to use ftrace_regs for that.
> So eventually, we need my fprobe series.
>
> https://lore.kernel.org/bpf/164338038439.2429999.17564843625400931820.stg=
it@devnote2/
>
> Thank you,
>
> >
> > Note that there was already an implementation (see [1]), but for some
> > reason it never made it.
> >
> >   [1] https://lore.kernel.org/bpf/164338038439.2429999.1756484362540093=
1820.stgit@devnote2/
> >   [2] https://lore.kernel.org/bpf/172562357215.467568.21728589074191051=
55.b4-ty@ellerman.id.au/
> >
> > >
> > > -- Andrii
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

