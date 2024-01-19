Return-Path: <bpf+bounces-19865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A268322C3
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 01:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7826E1C22EAC
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 00:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE88A23;
	Fri, 19 Jan 2024 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBuY7H3+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8E820E8
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625442; cv=none; b=M3LRWPZ4t4Ir4H14GrPcO3Dl4OKlwgsQamMBahuBklsAoW/8zsndqRnQh5uFNIDDZ0vUwmoYlZqjMArpfa5xsADcHQXPE+CWSFBCvzXxjTzP+ijQYxxSJZsjsHPVJtZFw9M66FLrotXfwC4yz/ZIg+nJp3kMbHBiaGFMbaDbhJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625442; c=relaxed/simple;
	bh=ubHqAlZ8xgYYAatsaaY28NER6N43AmupjbI9GXpFb5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQOC2yBEJTulRchUA5GjKhA2sz+o92SSuZNOnJNQrX+Z7J9SzTOHXRd6wXOG9FK5svyH68kpHdSHb/4eDyimpeoMQgQ24o+Wi+RrvJgr+bwJKSFQk3pk8v2WObLUmJY6TDjlMBC93z457LqmRnwH71t+XA2sSjs0mFIBNSffoOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBuY7H3+; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bd6581bca0so216604b6e.0
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 16:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705625440; x=1706230240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qlh+1yhKr1k4OHb3xctuVnxWh8K0JiNY7lDuszWh+4=;
        b=PBuY7H3+199wM0WgU95FNUAgxfm1Qea3KY13Zw2ABtDqRp7SkL04J2DHkuzDFjxOYi
         39G/9Xf+ZnsPUoJ9QnENV4d99GXAA73LEWTQYLi7XoNDTBJt3RbZ8MY4ZP4sU9LUvx9H
         s3Zi7d2WZDadGgpRDqkrJgMj/slhJvxA/k0UgKgp7XqG+b0q19v030BKQQQ/qd9LZK1H
         XqAcUKHxSrklHey0EyhQ66vNlYRv95fGFiYOTW1NeTiBGkqpPd1GR3qjgkyt60jjxzKQ
         ZNWXi4MTtFfj1QyufLtdoImmO+1tdfZkdcgHsTsAHVFqSLyZ7TxWvW8IXd8X1/F9dM/e
         bWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705625440; x=1706230240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qlh+1yhKr1k4OHb3xctuVnxWh8K0JiNY7lDuszWh+4=;
        b=ayFhr7Qjhma4TFAeV4+4nAOYhmoZ4KUPC4uHfHVWGmfHhlY56K3Dx85Da0ggAFCjHd
         xiGmd7V/TTw+K18XqyuIAEA66AfeOrbIAt/4aBgPVo4nVX8hzRqwYJzPaLuz9ql7tV2y
         arKqF8LU07aF2RIbJIIk4lKW9zknBh0UgOSvKHFIx9Rzb1ocu62BKzBdLCBjll7SUzAT
         jajrnp12+MfgMQA52V9SFUmfOJ5hNlCzplkfQ2mMmfIiDU+3NHQUFZnPNlwLyIDkrE+I
         mz76KtXVcaLcYAvXvpAq4/az5OJwFYYWFdbI5RtS0G9Qxy3xau8s5mnqkC0L7NVMvMrd
         h3Xg==
X-Gm-Message-State: AOJu0YxHswZrhY9mFtGvltqxpdg9IACLdD9LOtFswgEfNdW31HB68aOt
	vgZSx5xBYu2ursVVjemHv18szzQW9ipPDm4i2uGtt5n8whSf6FquUqBLp7JbknzQ6pKgQXuJaSH
	bTINLvhVaqsV0MvOd96cMkT+AaCU=
X-Google-Smtp-Source: AGHT+IHlIG873k7RfXA2PbD/iUdwdGyDHgx+h48KTkzKEpQjbC5NeGEppXjfxeijTrCB+Pg1fw0NkyfkNfWzSiD73pg=
X-Received: by 2002:a05:6808:1d0:b0:3bd:4c88:f1c0 with SMTP id
 x16-20020a05680801d000b003bd4c88f1c0mr1665037oic.51.1705625440098; Thu, 18
 Jan 2024 16:50:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117223340.1733595-1-andrii@kernel.org> <20240117223340.1733595-4-andrii@kernel.org>
 <a49d5548efd5766a3b66ef3e6f18bbbc4b1bf677.camel@gmail.com>
In-Reply-To: <a49d5548efd5766a3b66ef3e6f18bbbc4b1bf677.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Jan 2024 16:50:28 -0800
Message-ID: <CAEf4BzaSyHJyofK=5p4vdV7Q9WOG3WscfqQtWaV0E_LnrvkNdw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 3/5] bpf: enforce types for __arg_ctx-tagged
 arguments in global subprogs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:50=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2024-01-17 at 14:33 -0800, Andrii Nakryiko wrote:
> [...]
>
> >   - for kprobes, we always accept `struct pt_regs *`, as that's what
> >     actually is passed as a context to any kprobe program;
> >   - for perf_event, we resolve typedefs down to actual struct type and
> >     accept `struct {pt_regs,user_pt_regs,user_regs_struct} *` if kernel
> >     architecture actually defines `bpf_user_pt_regs_t` as an alias for
> >     the corresponding struct;
> >     otherwise, canonical `struct bpf_perf_event_data *` is expected;
> >   - for raw_tp/raw_tp.w programs, `u64/long *` are accepted, as that's
> >     what's expected with BPF_PROG() usage; otherwise, canonical
> >     `struct bpf_raw_tracepoint_args *` is expected;
> >   - tp_btf supports both `struct bpf_raw_tracepoint_args *` and `u64 *`
> >     formats, both are coded as expections as tp_btf is actually a TRACI=
NG
> >     program type, which has no canonical context type;
> >   - iterator programs accept `struct bpf_iter__xxx *` structs, currentl=
y
> >     with no further iterator-type specific enforcement;
> >   - fentry/fexit/fmod_ret/lsm/struct_ops all accept `u64 *`;
> >   - classic tracepoint programs, as well as syscall and freplace
> >     programs allow any user-provided type.
>
> The "arg:..." rules become quite complex, do you plan to document
> these either in kernel rst's or as doc-strings for relevant macros?

They are meant to be natural extensions of existing expectations, so
users hopefully wouldn't need to worry about them. But you are right,
global subprogs are not documented at all. But no, I didn't have
immediate plans to document them, maybe some time later.

>
> [...]
>
>

