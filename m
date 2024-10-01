Return-Path: <bpf+bounces-40630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B9498B1C2
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 03:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13152833B6
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 01:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE60BA3F;
	Tue,  1 Oct 2024 01:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBLwJU2X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55C6FC08
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 01:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727746024; cv=none; b=JBgO5kd+q8ZA9S/8zvFc84/d67gsWzZC9yB+hhgzzwcRRHYtupR1w073ERKrOpZ+nnTGrctlRIFB+ZmIPwxu7fB09BQZeBBeaNVnpAheu5cWnoDgyZmRvIDP/AwhQTGPOjrN1+iYoxhnzw30ZhwHsnPnFKH+qu2lq8ME1GNLmKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727746024; c=relaxed/simple;
	bh=go0VGygoTdrnm/XNrWSw+fj4C+UYp+qQFVOiTKMnWyU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LuhQAu6yYuvfgonle79fRTBo7D3RfxxUT4Ao2HIZHfTZxe1AeeWHr2tJYvxPpBNWwd4s4DpK9a3cDfTP+5PH8DmftuAwSIvD1I/cY88cHjmaiKneVQcI017okJSkhGZRaUdNeWl7FiC1AwpHV0Ocfs9E66QrqOt/qQNt9qv8WTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBLwJU2X; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso3828932a12.2
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 18:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727746022; x=1728350822; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YRiM11e1VQF3wLbDOqFJHOJkAPcw5bJrQfygXyKfmzg=;
        b=cBLwJU2XxJJtCiHW8soURIe36QN1QiSUOfrE+A3k83+d/AhCxqmAM9PEapSf+VhcW7
         BjNkr2e1kThgFjpTYgef059WCPvGPwoqwMiaGqLhawnCOmacgtleSqMckxnWY5GGSk6b
         Bbe5ll3SSEn4SCeVy4PZ5KSotprAWDWaj655whYENleFjfKoWID7Bfw7UDrvicGtnGfZ
         /dztj088b07Ag5CWCgDBcVbS21V/BAsk1iLT0938VT3jpihGeoj3nOpXON/Sg63qMR8x
         aNRAC2nc8/7+ZTS6UQMf/etR+bUJ6+eaiTsdFqrBgdJXUyMA2/AUpok0GzBrEmvSFjKb
         O3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727746022; x=1728350822;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRiM11e1VQF3wLbDOqFJHOJkAPcw5bJrQfygXyKfmzg=;
        b=pxcdp+k9/EooLd5itl/I0EX4Jhky8z31yVFoAdNMiUo/NglLygdMPuyi9ikC4WstA/
         OuTECRhQc4eELpF+C3cvizrJW+pbSr62kxaPTMJN34CB8+HAvLo42uct01j2/YXu5rwc
         bdrijcdjppFN9BB9eZHFSvURV66VNEP+HcAbNtkDjdbdta2K/PStAFOm3iR0r5znkZCZ
         9syndmSKp3XVmjxsC9+L2eAGCQFtbnKJPp9kf06hBV4+xg0TOI2JcnAINUBnxOENWg4n
         VEvAkZJs11TsCzF5QoB5cHpOfmkcmtA+hamQOhqeTuwpxvIJnurNVfsqsQxsxMcMoBPC
         NahQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzXqdpxf9D3+i8l1Nts3n/tqNP87J0qdZ8kQCa8BGVTMQg55KreX5Tx5F/sdVYWB3zYGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQrMQcpfLUa45gL+AtBnEmYenJuvIXmiZNzuJD2ZuvUVtXft/Z
	pw9bEacAtqfYORtaKb2bvhKG69KGLWIenupo3uy6rb/JZFL0/pvOITA9g0x8
X-Google-Smtp-Source: AGHT+IGbfB66/H3RRCBLRs9v2m8AwuHMSqlmLrEftFZEgPo4gwyvUPnzBw/bN9qGOq+JQs3lrBbNkg==
X-Received: by 2002:a05:6a21:70c8:b0:1d2:bb49:536d with SMTP id adf61e73a8af0-1d4fa6f9a4emr18876182637.24.1727746021989;
        Mon, 30 Sep 2024 18:27:01 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bc86asm6932447b3a.67.2024.09.30.18.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 18:27:01 -0700 (PDT)
Message-ID: <94fa5a81a7ca2ed03822eb59ed3c42d674029090.camel@gmail.com>
Subject: Re: Possible out-of-bounds writing at kernel/bpf/verifier.c:19927
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Kees Bakker
	 <kees@ijzerbout.nl>, bpf <bpf@vger.kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>
Date: Mon, 30 Sep 2024 18:26:56 -0700
In-Reply-To: <CAADnVQK7VfTZNPO4rDDdH0HaD9XEy4-CF7h65i_4oJeeEYwpww@mail.gmail.com>
References: <1058f400-50d8-4799-b5ed-149dba761966@ijzerbout.nl>
	 <CAADnVQK7VfTZNPO4rDDdH0HaD9XEy4-CF7h65i_4oJeeEYwpww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-30 at 18:21 -0700, Alexei Starovoitov wrote:
> On Mon, Sep 30, 2024 at 11:01=E2=80=AFAM Kees Bakker <kees@ijzerbout.nl> =
wrote:
> >=20
> > Hi,
> >=20
> > In the following commit you added a few lines to kernel/bpf/verifier.c
> >=20
> > commit 1f1e864b65554e33fe74e3377e58b12f4302f2eb
> > Author: Yonghong Song <yonghong.song@linux.dev>
> > Date:   Thu Jul 27 18:12:07 2023 -0700
> >=20
> >      bpf: Handle sign-extenstin ctx member accesses
> >=20
> >      Currently, if user accesses a ctx member with signed types,
> >      the compiler will generate an unsigned load followed by
> >      necessary left and right shifts.
> >=20
> >      With the introduction of sign-extension load, compiler may
> >      just emit a ldsx insn instead. Let us do a final movsx sign
> >      extension to the final unsigned ctx load result to
> >      satisfy original sign extension requirement.
> >=20
> >      Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >      Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >      Link:
> > https://lore.kernel.org/r/20230728011207.3712528-1-yonghong.song@linux.=
dev
> >      Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ...
> >=20
> > +               if (mode =3D=3D BPF_MEMSX)
> > +                       insn_buf[cnt++] =3D BPF_RAW_INSN(BPF_ALU64 |
> > BPF_MOV | BPF_X,
> > + insn->dst_reg, insn->dst_reg,
> > +                                                      size * 8, 0);
> >=20
> > However, you forgot to check for array out-of-bounds check. In the if
> > statement
> > right above it, it is possible that insn_buf is filled up to the max.
>=20
> I don't think it's possible.
> There is no need for such a check.
>=20
> Next time pls cc bpf@vger right away.

It shouldn't be possible, but the code above does the same check:

                if (is_narrower_load && size < target_size) {
                        u8 shift =3D bpf_ctx_narrow_access_offset(
                                off, size, size_default) * 8;
                        if (shift && cnt + 1 >=3D INSN_BUF_SIZE) {
                                verbose(env, "bpf verifier narrow ctx load =
misconfigured\n");
                                return -EINVAL;
                        }
                        if (ctx_field_size <=3D 4) {
                                if (shift)
                                        insn_buf[cnt++] =3D BPF_ALU32_IMM(B=
PF_RSH,
                                                                        ins=
n->dst_reg,
                                                                        shi=
ft);
                                ...
                        }
                }

So we are a bit inconsistent here.


