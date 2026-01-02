Return-Path: <bpf+bounces-77717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AECDACEF563
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 22:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 669E1300F89E
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 21:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C362D543E;
	Fri,  2 Jan 2026 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bx0wTSk0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC172BD00C
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767387946; cv=none; b=Q8IfY8o/M80XJqqYgbaV9ehKd7LhAVLbq8kR9Wvj/gXtn46bK+ilp8Wlgyy+TIpfNmiigAOAALL/cZsk+i2Kf8gj+Av1+RrCev8x8yCYzdrQBR8H33ax44UFOeRIeo6pDSwjA3k8r+Iz/E6/dne2sQa9WicDN/wBHr6EMEeLS7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767387946; c=relaxed/simple;
	bh=oMenj1WIvFBc1efBVB/EAT+xoBQNl/GMa+8LWlC1ssg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmGW+ilp/XYqcholGWbPHX0iYafhZizCENnohKjI1qGAtI3yW2RVKTabDBwd/AB4VlqHxbjP1S6vIpC1yTwvc1/tehUakZwQtSSVXgcQi3HQ9fUl110hxLT8vFy8dMYNiDwwzznVlnpXzLrvW3aGokm9g1Sf8IRFC2s17zTPiXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bx0wTSk0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64b7a38f07eso16831755a12.0
        for <bpf@vger.kernel.org>; Fri, 02 Jan 2026 13:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767387943; x=1767992743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvccmHN4uzQkztmQSnp++LZAR1yqTbRK/DgNSm5aFQU=;
        b=bx0wTSk0DzVEfTVOUy3YeCD3k1cyAlNi3GBVsowurr1I4cHqlTVMlKW/i66s2vZqZi
         Fit/niTLHL5sfooXCpNZTGYaNwoCWAbANpJXYFzwGWLZ0GFgRtoh5F6CL77b+AF8kE4+
         wIDsmRkfz2eI2IB0RlEBQ1eoRazB/9Vo0VFkRNl4kNa/967T1Hud2TflEH2nUOfZXaZn
         LZCJv73kxJ4BXhW8vSak/I3HgND2liwOQkP4bf/vdLfnpvcLN7KVbn/iz+SVZHPg9ecZ
         jJDSGfUGstCP2MQzawPVZo71+EZmsbOaB0I1AireyYnvlZ6Md4IjAY5VPZ5/CCfLb4Ak
         80hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767387943; x=1767992743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wvccmHN4uzQkztmQSnp++LZAR1yqTbRK/DgNSm5aFQU=;
        b=wt0SDmfUPs2xfCwoMvAkZPpSQhfY2W2x/iNwHpjO4nPdShoyfw/3DEhbdnNgAMas20
         YNtq5323lvRjP1Z967Wzb7rPduFSSBOvFVJXdHRJ5WH8fA7jUFeqqJxrkkmLwyPftNCr
         x7cJ00LNV+SYAlrLNfop4j8uLJKXDcDHK8XNiWHL4ESqoiKOj+4EcQ6yLqLOt523KU1s
         th0jQVY7rkAaVvSDno2zTkNtt/spwYOSGF3ZgutcI/DV5Uig4mEfndbX9m19bljlnUEH
         VKPKFShDnyyn0OPmxqQh7dxiudAE43gnbKpZ3Z6nqVmODCMbmdNiw1L7rr/5jgKfowHz
         yaEg==
X-Gm-Message-State: AOJu0Yy2ctCfQClJYBqEU1bY90RFx7dyGQYPOvCk4gS3n6wFwoy3253u
	pcPwNras3pHSxlI0SY+km9z2pyvsh/MplG9xzxQUNi6bzXdeh1T24lcmumHgaEnvenuNLk1Io38
	460PVsWrDmMolh+tdsWEGhiJUc2gFLj4=
X-Gm-Gg: AY/fxX4TugEDotQR9X4r1E+rp1GXqzU7u3T9kGCBiwy21a5OMZ7H9dDp3DtmhZ8ml3w
	aU0eNn1MXjPyvwpGf+DJPjOLZrTzKURmjPfwp/ZDmCrgHE7d5QSCogAey3nK8LRgbdHG4/ikyUi
	ZimBydT/5Lu+eAm7EU4f0kboEu243H0ZGRldISyUJcgkpnpv6Z98sLoVEDnM+hGstbSCArVGFhT
	U13ec/1Y2sSgrXPUppCsoSDtdX33bGJHngAL/5aMg1G/84IYbm6ilVjyzSlAr91a3v8G3VKah5R
	8/EmS6/5ew==
X-Google-Smtp-Source: AGHT+IGo1MNJVJbDWKNFkrqucpo35WqQZq13v1EevJyFjol3M3+xzEX2c1BP6LLDZeCMKpRwvkqFCmP2qBtOJxj6NzE=
X-Received: by 2002:a05:6402:268a:b0:649:d81b:7b7e with SMTP id
 4fb4d7f45d1cf-64b8eb5fbc9mr38755118a12.8.1767387943368; Fri, 02 Jan 2026
 13:05:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231232623.2713255-1-puranjay@kernel.org> <ec04d110c596af4020d831d3c602371ecf4f3cac.camel@gmail.com>
In-Reply-To: <ec04d110c596af4020d831d3c602371ecf4f3cac.camel@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 2 Jan 2026 21:05:29 +0000
X-Gm-Features: AQt7F2r5OSGid_WUMyMgEVgo10_huAFKl5RsdBlSUiqquoCXGuGAialNmayVNPg
Message-ID: <CANk7y0jxSViSdo0abrKxGssf3UOJxUrs3s+FdJ8exhXEE-hV0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Replace __opt annotation with __nullable
 for kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 9:03=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2025-12-31 at 15:26 -0800, Puranjay Mohan wrote:
> > The __opt annotation was originally introduced specifically for
> > buffer/size argument pairs in bpf_dynptr_slice() and
> > bpf_dynptr_slice_rdwr(), allowing the buffer pointer to be NULL while
> > still validating the size as a constant.  The __nullable annotation
> > serves the same purpose but is more general and is already used
> > throughout the BPF subsystem for raw tracepoints, struct_ops, and other
> > kfuncs.
> >
> > This patch unifies the two annotations by replacing __opt with
> > __nullable.  The key change is in the verifier's
> > get_kfunc_ptr_arg_type() function, where mem/size pair detection is now
> > performed before the nullable check.  This ensures that buffer/size
> > pairs are correctly classified as KF_ARG_PTR_TO_MEM_SIZE even when the
> > buffer is nullable, while adding an !arg_mem_size condition to the
> > nullable check prevents interference with mem/size pair handling.
> >
> > When processing KF_ARG_PTR_TO_MEM_SIZE arguments, the verifier now uses
> > is_kfunc_arg_nullable() instead of the removed is_kfunc_arg_optional()
> > to determine whether to skip size validation for NULL buffers.
> >
> > This is the first documentation added for the __nullable annotation,
> > which has been in use since it was introduced but was previously
> > undocumented.
> >
> > No functional changes to verifier behavior - nullable buffer/size pairs
> > continue to work exactly as before.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
>
> Lgtm, thank you for the quick turnaround.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]

Thanks for the review, I will rebase and send again as the trusted
args series got merged and this needs to be fixed.

