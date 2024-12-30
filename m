Return-Path: <bpf+bounces-47720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1623D9FEBA6
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 00:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE3A3A2832
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 23:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAED819DF52;
	Mon, 30 Dec 2024 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sP57/rz/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC8E19C556
	for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735601144; cv=none; b=I/SZLbQFemwLkmbU2Cehis3UruHZJBUCHGwIVRvnugRIvRYwwSUIPf4ov3N5KlcaI1K+jnZqNHn2/P02iO+jBDAnhqwrZXKUFJu4vAESaTUFZCeM97MNeLDIzcB/HQs3X4JKpKHxy5RMEuuQajvlSU0vTdcHVz1rkUQ0fzW5j1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735601144; c=relaxed/simple;
	bh=jQVsSvQIaLqIicN6sFToT/LVgqGJ/QK6/cEOtJDtuZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLshNv/vi9UYmoKGLal51CTjFykB44jCfQz6FVZeuT073MBVTajmN84HbkqlV8hEv+a8uDOmRY0RXL1P/gH/PHF64Mh/OjpnD0dwlQAngPDIeSoL+i6Shs3v4OAKtN/ArEwMvDm1TgzPlRitsbhfw74ywqz9rs1EZ2BLnqHlv3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sP57/rz/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-219f6ca9a81so897025ad.1
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 15:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735601142; x=1736205942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RRzWf4CeAAs2Mfs+2B6JFBzmb1bdAzO9qUU3QTdAEc8=;
        b=sP57/rz/qNTE6rbN60/74yoBc8Hx76LA+jnOs04EaCnQpfvt4DPId05G4GT62YiGTT
         UDyiRmRGZoE6p0wu3Pl3MoPUsdDd1U+mBRohVxi1dB87aUAYUWCHDurBc790HRud76KT
         JV2cIdMLplM4QCsBioMD0aOiF5cvhTn4oEH2CIeoJdFlz+VwDc61ZWcS4jfl3yLQWUfh
         y/hXXSEU2tf4JtKf6qApOdYXkqqXRLY3drvzGaLaS6ClLmblivTkpN8zcbz8T/wOcbK9
         aI4UP7zijyt/ZQWmIjqSAvHGJvujL3NqH5GfSIIIh+WDnwiZWYWsquNLVbLgA/Aevosh
         L15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735601142; x=1736205942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRzWf4CeAAs2Mfs+2B6JFBzmb1bdAzO9qUU3QTdAEc8=;
        b=TVzpl7VRHDqJ9o96cs6WXiG77UDbsdvdcS1ckZLZ94QKflXcnsCAjXx8dmBSRh0DxK
         aAtLY87214EjKJFy5g/mXzUS7NASIKHUb4WsXvhmha11BaJ6/HxDBIbKxkKslUaxaEC7
         XfM/35pDliv9ZIht0h6SvjnweWAMIen16LI8ePFY+nFSKCavIDfjNbWAHKgar4K/cmJH
         TbawVqCBPeyF6uhOPQ6DOIyXEIFXvO6EbcuWY3XyeZs/Gt5QXX5YIJaBt+/Bb8Xys6XC
         ufquOuts1e0rlfMKT7JJx9T00yMUPhBDSodva3VEqyu5v+eoafcEX45SPgjq4Tg/5HXd
         r0fA==
X-Gm-Message-State: AOJu0YwliatZrTDwcw5w8YPABako/+5cP73lk9lA2uL3+raCBUgmqhk1
	n6yXejMzKstcSaYPQi7W6aJcQFllyv6qt5oJ0FjECjoX7DylMCvd626sAQepjw==
X-Gm-Gg: ASbGncucltYl0OeDQmK3fgvDYBwzmWh+n/NM8OxCH7OVUTys+5KlftJo15T4bwF5E40
	8y5rX0LkVvB2lxRE9OYlw+bOvKEz5grkBK5hvx85F6DDzq7t9C/Jsy9LmSGexxQxBOpEOnhdBAM
	eUDYNN4y1FjnximDDo35U1IjEj3xEWYUPbguVcAsUMiYW3uUa+6EktdHtBp2r9py1JpR1CcSLSt
	O68psAfNIxid3yiXOxNYR2n58zB9qbYLaGY40XLGhlbPkub+Ynbb5PfAHtqXpaUmGG5+6GU5Aiv
	SSbEzuvcSXrIqy+9OIo=
X-Google-Smtp-Source: AGHT+IGRp5e+88I/VIGxZjpmzQSJtLaRAWmCvlTAi2UkTOuOHL2cTguNZqZ4pi6cNwhvlNNsVq25FA==
X-Received: by 2002:a17:903:2350:b0:20b:5e34:1850 with SMTP id d9443c01a7336-219e773876bmr15701785ad.23.1735601141982;
        Mon, 30 Dec 2024 15:25:41 -0800 (PST)
Received: from google.com (40.155.125.34.bc.googleusercontent.com. [34.125.155.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fd58asm20315918b3a.145.2024.12.30.15.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 15:25:41 -0800 (PST)
Date: Mon, 30 Dec 2024 23:25:37 +0000
From: Peilin Ye <yepeilin@google.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Josh Don <joshdon@google.com>,
	Barret Rhoden <brho@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] bpf, arm64: Emit A64_{ADD,SUB}_I when
 possible in emit_{lse,ll_sc}_atomic()
Message-ID: <Z3Mr8bqHyjTEFqGm@google.com>
References: <3b84fa17ab72f3f69e09e0032452d17eb13b80db.1735342016.git.yepeilin@google.com>
 <953c7241e82496cb7a8b5a8724028ad646cd0896.1735342016.git.yepeilin@google.com>
 <6763d7c3-7971-477f-aa47-cb2fdf4b08e2@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6763d7c3-7971-477f-aa47-cb2fdf4b08e2@huaweicloud.com>

On Mon, Dec 30, 2024 at 04:44:26PM +0800, Xu Kuohai wrote:
> > @@ -721,7 +727,7 @@ static int emit_ll_sc_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
> >   	const s32 imm = insn->imm;
> >   	const s16 off = insn->off;
> >   	const bool isdw = BPF_SIZE(code) == BPF_DW;
> > -	u8 reg;
> > +	u8 reg = dst;
> >   	s32 jmp_offset;
> >   	if (BPF_MODE(code) == BPF_PROBE_ATOMIC) {
> > @@ -730,11 +736,15 @@ static int emit_ll_sc_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
> >   		return -EINVAL;
> >   	}
> > -	if (!off) {
> > -		reg = dst;
> > -	} else {
> > -		emit_a64_mov_i(1, tmp, off, ctx);
> > -		emit(A64_ADD(1, tmp, tmp, dst), ctx);
> > +	if (off) {
> > +		if (is_addsub_imm(off)) {
> > +			emit(A64_ADD_I(1, tmp, reg, off), ctx);
> > +		} else if (is_addsub_imm(-off)) {
> > +			emit(A64_SUB_I(1, tmp, reg, -off), ctx);
> > +		} else {
> > +			emit_a64_mov_i(1, tmp, off, ctx);
> > +			emit(A64_ADD(1, tmp, tmp, reg), ctx);
> > +		}
> >   		reg = tmp;
> >   	}
> 
> Thanks, this looks good to me, but we now have serveral repetitive code
> snippets like this. It would be better to refactor them into a common
> function.

Sure!  I will do that in v2.

Thanks,
Peilin Ye


