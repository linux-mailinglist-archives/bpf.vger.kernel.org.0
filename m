Return-Path: <bpf+bounces-73164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD53C25CE6
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 16:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43BB14F9312
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 15:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E052526FD9A;
	Fri, 31 Oct 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbKlCy89"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA5B25B1D2
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923657; cv=none; b=lIvInzZxe5HXlFmWU8yyiif0qh5zgYh/ajfqpQ/pasdJbcaXNOKLlTsPAFA1/GFC1G1Ol7BSs2dQidycxxv8zohHx9twDMoboU8schAG3DP84bPM8+6kNQsAEGgFaAcW5RBuZxKZKrZ0DduXU8bdmztan4QbW4R3PtKytEuoOSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923657; c=relaxed/simple;
	bh=1tCvhM5JCsF5Wm5F8el+ulRRy1Nb9S+olGmgV+4J7Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/aHSJgRXGr/xggolvM8FSKHc0FAhpDh7+nWZ5x4VU8voBjVdo92i+jBp5Z5sl1y+STVjwbdbg1NshKC5YiNz1PIrRmo/TzKBswXILaPB58Mr7mymCc3YP2uVwnm13YjQII2t0qoWiVyqZ/pj7han1yPSmrzbSkeVnAN9bNx5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbKlCy89; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so23951345e9.0
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 08:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761923652; x=1762528452; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mmgiI+X/FdBlHrPmmmHwZairGfdFFVTOmxcdRNYa5kA=;
        b=hbKlCy89prLGOGPsbriXmP5aXehjcQ1wrIeYxqjwCAB5BDSJR8LCh57TPvCRSJErMj
         2lVP1xOiqZZdy7i7j275qI3gCeTOJlw2tDpdsK5n9/snea97U1c0RC5axxyFauhgxL4W
         x1Xvwr90MBivyHz2RVQC+HA5zC7eQtLNLg7XcC4Grec9XCCpTz+4uw4XoK/shSCMGh08
         U5Va37WhaWGYljDy5nnUMnmQmG41Esb8Qrhf2mwEZlIGwqmG5ziHEn7shiQatsnnCgN+
         MwzNdjm3yMI1uBV0reAa6D+cFtqd+4kw4Cu1YgAccgNIrg+yNm8RIPCwZQp0SFhbyUHp
         VJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761923652; x=1762528452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmgiI+X/FdBlHrPmmmHwZairGfdFFVTOmxcdRNYa5kA=;
        b=Qw4pP9OGVK4B1kCfKY0XN8wVwbdgCEbdVfcaUl9LmiKwiTC6RIjH9wOHbLf2JxVrKs
         6jhKDK21OuURuOFtv1zXFGD1wdrXeiJfc2vpox4PRbNsuiVm0igaPgZQPlLrqe0xugr6
         nUltcoSBBRtTWsRdnpa/bRztSi/rewRWfWeQ5oluaoqAsXbqopN5zoofbCMf6SgDyeO3
         EHSKUAk6LiHrs2M4TWbg4Tc5WOGQPizgCMBjwXLtXbFyWPWfEPDC/G/4ATxsSulwLt9H
         7FZIP41NAb5t4lmyJCqW+MYX0OuOT16xLH6NoMb4ih93roD+41x7XldK+od3e8BJVXFk
         OQAQ==
X-Gm-Message-State: AOJu0YwYJfO9LV+rmCmYqVs6LLcP/+p6VR2AFz+VSryqpuHqrN/azZHX
	2JwMT9ajUc723Yc7QNOzyCXBz7bnIw6EcuoKNJXKWjpSj9P0tf5ztLvuqtSYIQ==
X-Gm-Gg: ASbGnctI/KN5gGbZyBRNtSn3NGq6Tut7xvoyL4Su/OTgD35mPiqg94pYk/xxeDkOL3h
	glMdVrWP0sSOBd86v7YUChUPTKAI/U05dkpVZwGE6eJJt+/2qOfp9LMn4iGmn1413OhSTuL/AJD
	ctNXG6/H4rAqobaFsiQE5s+nnj+82T52juV5icniR6PHmwWf7sul3jmFLrq91NRquGcpVm3Ad90
	iVFjqStydbeZugYEGpuCdxUpe+Z2PlkxVJ0dE5PL106SkH2glSbVSE8LsRZUPHo0/hH3Eg3Y/5S
	1XPnx3mfCiJp+ZML3RUDZoHGJ2+FxJLG86XGtTYDsE1+OB24ei4yvGoV2Q0+kGsNgfLJqXlfoB4
	CG2eeH6c9IYfatSEE718AU4mk29/9ECVEgqveRHAShKMiJCosdHRtxtlKLxXks9E6Pxxhr4d1d4
	VS1wPklDNCBRWmpT2V7gAT
X-Google-Smtp-Source: AGHT+IHfMhj3l3dpAHkvjO0wZqGO3Je7RtNivVZmAMmxHWO4Fr+fLCSbFhGT/4KR7iyZbo2RwSm55A==
X-Received: by 2002:a05:600c:190e:b0:471:7a:7922 with SMTP id 5b1f17b1804b1-477305a6bfemr38107745e9.6.1761923651478;
        Fri, 31 Oct 2025 08:14:11 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c110035esm4062688f8f.6.2025.10.31.08.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 08:14:10 -0700 (PDT)
Date: Fri, 31 Oct 2025 15:20:38 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v8 bpf-next 01/11] bpf, x86: add new map type:
 instructions array
Message-ID: <aQTTxmX2PbsnhONc@mail.gmail.com>
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
 <20251028142049.1324520-2-a.s.protopopov@gmail.com>
 <CAADnVQL1nznRsfdSgFPxSf1Rdhq7hpQMcmT7BKaRn9KHwD=P6A@mail.gmail.com>
 <aQRj4bxjbrECVIb9@mail.gmail.com>
 <CAADnVQLbhmGXzjpvt0fQGRbVd=MFTnWkZxub6RPBfD+mfLB=-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLbhmGXzjpvt0fQGRbVd=MFTnWkZxub6RPBfD+mfLB=-A@mail.gmail.com>

On 25/10/31 08:04AM, Alexei Starovoitov wrote:
> On Fri, Oct 31, 2025 at 12:16 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > On 25/10/30 03:50PM, Alexei Starovoitov wrote:
> > > On Tue, Oct 28, 2025 at 7:15 AM Anton Protopopov
> > > <a.s.protopopov@gmail.com> wrote:
> > > >                 }
> > > > +
> > > > +               bpf_prog_update_insn_ptrs(prog, addrs, image);
> > > > +
> > >
> > > I suspect there is off-by-1 bug somewhere in bpf_prog_update_insn_ptrs() math,
> > > since addrs[0] points to function prologue.
> > > addrs[1] is the offset of the first bpf insn.
> > > See how it's called in other place:
> > >    bpf_prog_fill_jited_linfo(prog, addrs + 1);
> >
> > So all the maps I have in all selftests tests point to a wrong ip for
> > every goto, and still work?
> >
> > In fact, addrs[0] points to right after the prologue, see how it is
> > initialized in do_jit:
> >
> >   addrs[0] = proglen;
> >
> > here proglen is the length of prologue. The loop in do_jit startrs
> > with i=1, but all addrs are referenced with i-1:
> >
> >     case BPF_JMP | BPF_CALL: {
> >             u8 *ip = image + addrs[i - 1];
> >
> > The bpf_prog_fill_jited_linfo internally also does the -1 thingy:
> >
> >     insn_to_jit_off[linfo[i].insn_off - insn_start - 1];
> 
> I added that '+ 1' in
> commit 7c2e988f400e ("bpf: fix x64 JIT code generation for jmp to 1st insn")
> 
> Please add a comment to explain what addrs[] are and
> that bpf_prog_update_insn_ptrs() treats this array as
> offsets to 1st byte, while bpf_prog_fill_jited_linfo() is offset to last
> for historical reasons.

Ok, now this makes sense. Thanks!

