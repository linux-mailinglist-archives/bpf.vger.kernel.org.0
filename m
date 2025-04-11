Return-Path: <bpf+bounces-55741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBB0A861A9
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 17:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC9218937F7
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 15:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF84203714;
	Fri, 11 Apr 2025 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX3TYLJN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E384378F45
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384875; cv=none; b=buQDYTYvet9YdYHrYzrkjUIkpVZWTROaUUP1wva38G49fKSAk1bqmxE4ov+rAcvrxBGJKZMKvd+k3V35pTsOlg8DfDWOVjBiB8MDLb1jNNHa+G4FdWtLVkUX0tke45qFScZytKoHF0QctopiOrrsgnLDf0uv6Z2+vWTZ2F+IKlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384875; c=relaxed/simple;
	bh=qOgGmAsgZIMa7FNlNAA2NdtqExya/8jb5xsuLPJaKJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SW9Ald8nCys565VtTD0lI0iD7bALOX0XhsaYuNZ3NVonYoOFcJGqZhKb9fkxsNYrxBuBsnu7wJMOtpyUDrVMIlW+xDy+dzR8vMoOHzhY347m9OyUBV+FzUu1zPsRLFqe6bWq1lpvz1Xgc7rvPpZHv9bvgfMOnjY957q/i6iga+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DX3TYLJN; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso2290304f8f.1
        for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744384872; x=1744989672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//kUh0Sqivbkp7XaIuVsXm5fUxi4NMnVBkILbu8Id0Y=;
        b=DX3TYLJNe69Zy9ZHeLPz+uCQB5tV6jHJlizuOIvlcb6RGHa+H6TUcEk6q1b58I7VKv
         vfRBIvfBOSCj9A7GdD1vlMgZtE6ME3HS+AM4oYvylRWaBik77qjMcbgzFnaD8F3sy216
         N76/I1rhhBv4O2/rC1E+3XrUGE3KCUi7SNzXB+ZqIP8jHZYxhbZ02hwFxW96gMV2NWsZ
         VnAY6/dorC7Qx5aR0Xao1sfkq3pQVaHtt3yao19RAq+dTAPXrujnJAwp/Ap9xlm6AmTl
         3LGv8ONO87+Fo425n4xY7veYuLjTQqkaT/dpRSQupXuIOgp39DOovmJnj8ETeRlXUd6o
         +etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744384872; x=1744989672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//kUh0Sqivbkp7XaIuVsXm5fUxi4NMnVBkILbu8Id0Y=;
        b=IfzJk08v+mHf84uKsE77aMfTt+dAylfTlP3oXci5nIhsdKJiOF+vnyISFhowzTOlZ0
         +X652Xt+bRRIP990YFbkSWwzFwprMM5sPseuISesvYF9DyRVx/y8s0QC7NtxcappBh40
         nFiHjvdVIkLaeoQtfuzAucN07WRXAfmJfJr/o256zdpoq5ENjiPJn8Ibe6XT47FQpFjL
         bTqYfAIW3UsjEAFnAiSyvRq6FLU8ZTTU5Nr98jUkf7UnNaVfg+SOFU11yu86cLiFYIN4
         1Q0+o+iQTKVy+9D6K/lYHy53PsQiJomJPqfjzj6+4l4NsbGroupY6dRDPaJPAjfB9AUy
         NKig==
X-Gm-Message-State: AOJu0YyvOaR0rOvyPMoknyxcHhBegCdFEhGVrK+vR3FnGUvdxfq65p10
	f3x++sYdTHOgK0gp3GSmDiv3JKAjJd2qRrtHNsNMMLn9Gr0tMjcF0+dFVvYkG6jwArRZ4rEJEsv
	FwP9G3Wss73Lu4jkc5MtKCQCQSds=
X-Gm-Gg: ASbGnctCqkKj4UoCJ8wh9j8OcyNoC7f2pRFIP3PE2I9wPkoGGIuh0+kbGmXsoNjEcn2
	5emIdGmj2QnGxEn+NBzqeFIwrwo2BYdMC22RyUo6ZwSEMQahOaG9A20aMN149El/Kwlpwt/sLjr
	DmlJUktBah2AzTUpNo25U5DZ/yfKcofVf1hlBJkQ==
X-Google-Smtp-Source: AGHT+IGbod14EnwFTZ9UMGyrj8NvZi4S08uAnLdyxpmZ/+3MlH1J/5UHAPrlys0lMqgiNDc7VCiqyqJHvPc4ARDAnMM=
X-Received: by 2002:a5d:59ad:0:b0:391:21e2:ec3b with SMTP id
 ffacd0b85a97d-39e6e45d55dmr2638056f8f.3.1744384871954; Fri, 11 Apr 2025
 08:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <525d54bc-5259-49f2-acbf-7396bab48dec@gmail.com>
 <CAADnVQ+ip7yB-8deWjHNBQxZHhV1Xi-5gTiYJVRy4gU5+Chkqw@mail.gmail.com> <aa2e2b6f-5db8-4ef9-bad9-dddf699afae5@gmail.com>
In-Reply-To: <aa2e2b6f-5db8-4ef9-bad9-dddf699afae5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 11 Apr 2025 08:20:59 -0700
X-Gm-Features: ATxdqUHOB_oeNW87DqgBvwRbLAMRILJAfjWH7tBqQ16QMc8LUuFqDVFD8lVH6mQ
Message-ID: <CAADnVQJD1yc=ymX54fjON9ti4DpzOy7M10YE2T1nw750f3FcFQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: filter: remove dead instructions in filter code
To: Lion Ackermann <nnamrec@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 11:24=E2=80=AFPM Lion Ackermann <nnamrec@gmail.com>=
 wrote:
>
> On 4/10/25 5:05 PM, Alexei Starovoitov wrote:
> > On Thu, Apr 10, 2025 at 1:32=E2=80=AFAM Lion Ackermann <nnamrec@gmail.c=
om> wrote:
> >>
> >> It is well-known to be possible to abuse the eBPF JIT to construct
> >> gadgets for code re-use attacks. To hinder this constant blinding was
> >> added in "bpf: add generic constant blinding for use in jits". This
> >> mitigation has one weakness though: It ignores jump instructions due t=
o
> >> their correct offsets not being known when constant blinding is applie=
d.
> >> This can be abused to construct "jump-chains" with crafted offsets so
> >> that certain desirable instructions are generated by the JIT compiler.
> >> F.e. two consecutive BPF_JMP | BPF_JA codes with an appropriate offset
> >> might generate the following jumps:
> >>
> >>     ...
> >>     0xffffffffc000f822:    jmp    0xffffffffc00108df
> >>     0xffffffffc000f827:    jmp    0xffffffffc0010861
> >>     ...
> >>
> >> If those are hit unaligned we can get two consecutive useful
> >> instructions:
> >>
> >>     ...
> >>     0xffffffffc000f823:    mov    $0xe9000010,%eax
> >>     0xffffffffc000f828:    xor    $0xe9000010,%eax
> >>     ...
> >
> > Nack.
> > This is not exploitable.
> > We're not going to complicate classic bpf because of theoretical concer=
ns.
> >
> > pw-bot: cr
>
> This is not a theoretical concern, it is actually very practical. Sorry
> for not making this clearer. I would rather not share full payloads
> publicly at this point, though.

Do share.
JIT spraying is nothing new. Blinding only made it harder.
There are lots of usable gadgets without it as well.
Turn off JIT completely and nothing changes from security pov.

