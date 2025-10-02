Return-Path: <bpf+bounces-70233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D1ABB4F88
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 21:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90C4325F94
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 19:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3F7270542;
	Thu,  2 Oct 2025 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O47sbYyy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A92126BF1
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759432538; cv=none; b=dRaHx7HVcqST2srBv7NO0ytfSCRLhD2xLOcH+MtHUULTHrMqN22qaFXsjnp/BoaDAheQ8eE9Ntw9r2poMP9B5JkD4omP0KvIb0Cr2NYxJ1dvjB1dnxr25jG2aBtiU3Nfw5LX1egay0w5NsI+hqwQUx8Fqz9QD6Eluw2BwVhMAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759432538; c=relaxed/simple;
	bh=NZUaf+M7Q14pYnkZ9PbOXt6dhpEwedRFHIEu672gs6c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RxqLZNStRt1erYMuPrf2MGtYJGRiP+/4jpgAj3AiaKhaAZLBSvgoNfitLWcnJd+OVivMyRNXhay7FQRkMpb9+xmsC/7ADeF6hqgJsUVh3D7yLO8QoIeGd7Vt95AZ8v55mBiy7L5erZ+BKNDMnsgWA2/zfSgH3MCRojSldbqWybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O47sbYyy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33067909400so1064810a91.2
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 12:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759432536; x=1760037336; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NZUaf+M7Q14pYnkZ9PbOXt6dhpEwedRFHIEu672gs6c=;
        b=O47sbYyylYzH0F6EjTp+q3gAUnZjqIS5aNGs1smUzpVihb+NouDr6tDI+4TaTFRQqM
         4nLA8l7JImE44S4AYLlKnHSfTDrXnYALGWbXl4S4B3m8UAue1Sx6UZNEgGeIXcRUvfA5
         f9mYckXNrTtwl8cMkNl1U+WUeiw+by/7sa5Le++26lI3ByBbAAA82ONcReR1zPitVGx9
         E7LTR5586QP/+7on0Z+CkXjpj0mV0zymotrVDPygNckU6YWqOYdtsLV7AtxAvl4M2Mfu
         iH+g3puATtvHcs/WooNrrWHs5mndKtPhCZFuI+iv2/KbHE+uFQDFqH2+H8v3DVaLSw5L
         pmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759432536; x=1760037336;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZUaf+M7Q14pYnkZ9PbOXt6dhpEwedRFHIEu672gs6c=;
        b=feNjQ7ApnAyflhuD/t2I7VtEflZh4JF0V2vP9lWGyciNdDUcQZZ1di0khsZFkobesO
         3yMfh3p1HW3JDQYWzDIsL19KJqN587pzTV8FcBFQaYyKOA98YpcEoSOGcx8VyTInvukh
         LX6o8feJr2sRnhGkogSMsvsPVQtyk6UPfyUvahZ7frEGKX1kgbiGCe1Il/zR221/tXi0
         I0GqhKyCqsjDtVSTtk6dk82VqV0dU+PK8a+Ofz5FC6h4YwWGhfHwAhXQfjqrZV27S0so
         illdypOMJMnSRE8t0aFY3hapYw1LAcr2cr8g8ARoSSiceqhNcFKdXKtpIrR909sV9Dw4
         9z5g==
X-Forwarded-Encrypted: i=1; AJvYcCUPDzdOtJHkeB8vkfIKRUztFwNmkEqHro+qu9zCPUepJki5rN2FodL7hFkQFyMwCdFvYBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLUVjvXzvKDTECGMexVxKyfE61o2MNJcc3CYnHf61XNXebCffL
	rQLoC3lLfs3J5rZD2eJmaRcr8hGFSeBheS2lWvEnaDiiymzef7OyJ+Xl
X-Gm-Gg: ASbGncs92aQtukfvmOMDJOk2+Y1HziNUBrXCjuZ7s3czTdFd1S5rH7lP2Bb+dxJCwLz
	Q4ru1Vepz0zgjaWABDxADavQzsLvhtYm25ZUxV7SsYW7gpKx465VlxdkRC+TgGp19i4YR2kPvLG
	WUQ9+MbRyqkvPJtG5Usz9stRZ+v40YBC6kauUw1Z4lrElGF1DPqReLaUxbrgFoCJZWywmxw2C9q
	ZfHrC3jf5WO3CqyH9ev5exJHn5gTh4fYI3BZVstBi6lhaNxNNFzejpJA52jB2eI6dbn5NedKmsh
	/X4+tJ04YNDfEcHw5nud1bWdVJjL2jUGXRAx28t6jLOqa51fY0/Reiq43vOFj6E/7SX6zOD4cYJ
	yd422L2StXW9gowm5ZnTfSlPRAWgB0LxlnplDQSShAFVX
X-Google-Smtp-Source: AGHT+IHUbqaAsc5hFMMF/9468LMyCwolUKcI0Gc94xHlOuT8/nZ8Elk0PdSQ/8U4JKnSo5EBAuB0qw==
X-Received: by 2002:a17:90b:1c0d:b0:32e:23e8:2869 with SMTP id 98e67ed59e1d1-339c27a18cdmr453505a91.30.1759432536370;
        Thu, 02 Oct 2025 12:15:36 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a7037f9asm5589499a91.25.2025.10.02.12.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 12:15:36 -0700 (PDT)
Message-ID: <77da14fed4467c76d6f8f55a620f79988f0fe04d.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Correctly reject negative offsets for ALU ops
From: Eduard Zingerman <eddyz87@gmail.com>
To: yazhoutang@foxmail.com, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, Yazhou Tang
 <tangyazhou518@outlook.com>, Shenghao Yuan <shenghaoyuan0928@163.com>,
 Tianci Cao	 <ziye@zju.edu.cn>
Date: Thu, 02 Oct 2025 12:15:33 -0700
In-Reply-To: <ce95e0574660f0f9d8cc2a280957aa4f922e6458.camel@gmail.com>
References: <tencent_70D024BAE70A0A309A4781694C7B764B0608@qq.com>
	 <ce95e0574660f0f9d8cc2a280957aa4f922e6458.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-01 at 11:14 -0700, Eduard Zingerman wrote:
> On Tue, 2025-09-30 at 23:04 +0800, yazhoutang@foxmail.com wrote:
> > From: Yazhou Tang <tangyazhou518@outlook.com>
> >=20
> > When verifying BPF programs, the check_alu_op() function validates
> > instructions with ALU operations. The 'offset' field in these
> > instructions is a signed 16-bit integer.
> >=20
> > The existing check 'insn->off > 1' was intended to ensure the offset is
> > either 0, or 1 for BPF_MOD/BPF_DIV. However, because 'insn->off' is
> > signed, this check incorrectly accepts all negative values (e.g., -1).
> >=20
> > This commit tightens the validation by changing the condition to
> > '(insn->off !=3D 0 && insn->off !=3D 1)'. This ensures that any value
> > other than the explicitly permitted 0 and 1 is rejected, hardening the
> > verifier against malformed BPF programs.
> >=20
> > Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> > Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> > Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> > Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> > Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> > ---
>=20
> The change makes sense to me.
> Could you please add a selftest?
> Something like this:

Hi Yazhou,

I've sent a patch with test cases [1], sorry for not waiting for you,
we need to proceed with sending BPF PR to Linus tree.
Thanks again for the fix.

[1] https://lore.kernel.org/bpf/20251002191140.327353-1-eddyz87@gmail.com/T=
/#u

Thanks,
Eduard

