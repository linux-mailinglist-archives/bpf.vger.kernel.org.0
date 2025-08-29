Return-Path: <bpf+bounces-67036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EECFB3C3C1
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 22:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD651CC1BED
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 20:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2115F32A3E0;
	Fri, 29 Aug 2025 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INjeQ7We"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA404A11
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499298; cv=none; b=qJ3Yz7QOzf34qOHjiBFhmVXAc5E8ViM3BqTgL0XTbpH0yz9cx2O/1LLt0wBOTAWLnx4SRLaCH1Tb8Zacv8G/fQ3AVt5/Cl2nGa/ArokxkydoU2rTAqHZ4qHl1kq0b8PyjI0vLwaFIycr/2Oh2UYQt66d63dYkLAF8DeAHbghrTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499298; c=relaxed/simple;
	bh=N0ICU/D8kh5l0n3cAkUR0ricP5bOfeIhoNuOTDwlvR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RB91DdLIDukLBn4/tyKLYJA6Md0WB3XrKiLbZVnZxR+ypcd+p552pGTi18ATtQgWJCpQVbNAvdwEHawMt8/T+Aa8CMQQq7tr0sJpPzkShpUKPDiqq3Ulv9L3/vCQ9ZqtJEkpzkREEKEk5ryGcRpLQrU604oxj+/gosOpSu25exo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INjeQ7We; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ce4ed7a73fso1225294f8f.1
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 13:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756499295; x=1757104095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWWarxd9Q9YFnJBwnTjqO785xVsefxmIEy9LEQkKiTI=;
        b=INjeQ7WecmdTPXntbHGdM0oxf7id4NQUd+FQQ5ge9Crny+CBoUZJ09d7iEby2bG8Tu
         s0a70iirG7Z1bNHvuFpqqfxDyGHRTXir8hGBdaDzfmhVc7WzzEcks8swA9eXYS7GVgOG
         OU0OLdUF6Ge4AyqZ2upuy/yzi8EXL/pwYGZKh/4rS49pwIXXvX9ydRKxiZx170AFExhx
         yCKH6PpQ1gOMoo3RJMX9+6fHJZFfNSLIXgRfl4whdZz5GZb1weWxvWAXasaBPLh71Snb
         e1q4rqA1oUcjgj6Mt8LWbCwjZKODdfx1xmPV6OS28+XBJnsA06MEPgZrJBr17rITWGND
         hfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756499295; x=1757104095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWWarxd9Q9YFnJBwnTjqO785xVsefxmIEy9LEQkKiTI=;
        b=l+5CfItn2W6vX47mdI3Z5iRbse8M0Y620lgpeRdAuUqPPRgzhkG7IfomnwXmS9uUIS
         Up7wN0i/K+GsyT+Yy+oKKT/dTrWxBQoofRjbvVCvyHUx40vds9Q0S0dpP0NPmNPy2pHg
         hwfGECNgcMOvy/F5xYaGV9CSSw6jBXfqmI64/Xo2WCFnN/2CUOV3talUSeETmif8FVt/
         e8r/OJT/8bcybW4mklGsF4x1YuPMjqaLUpr+NGMrfbkUdaUypt0yGi8Ny+wLutUT9QvG
         QRPmQ9oiKEeJrej5dwMSloiapQZFKFYoT1f/JKjQhKovezV1/vWjT2HLMVBQne/XhyEd
         MZVg==
X-Forwarded-Encrypted: i=1; AJvYcCU0FbLx80rPx59SQaf1bZDrr4gr/o82smyxTvX5AqiRcxwhGnmkMrwEn/q9JYLY0Fcj7/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZTYj4w73muvuF8nVlbVOuZdRbKL/0iPtkeW193PDu4THHsjkf
	7UVtfVurkoe9KTfr1ZTa+L2mRBZ9vJqL6nLeaco40YiqqXj34NHnXnai9u4vuldYJ5DazLS1Za7
	en8vgEiy2SLbWQ5BovvdiIzgQ1alPIJQ=
X-Gm-Gg: ASbGncs1ruW8leF+9lcMJUJDLu9RxEtB6ecbdYLwjvWjgVxsGinN4kEMi6kBvPKklyG
	5uOqRtwxqKhNDA/xwk82mg1kvqmb4FL6yrVPnlWrABd4A3jXwCH1o+734LkbHqebjx1dxmADiRP
	oehBVUI/CDteXraCJRLIZsbzvE9e7D3CuUhg5FW6bTwfNKYdDsiUF68yfQGv32/kUxPPWiAlCyL
	JPt3vDwvFy8Yj8PdOPqU4IeNOZywUCMnqeT21BCpMTG
X-Google-Smtp-Source: AGHT+IHvDgUR+LZ5GnHw8eOu+1C1OJbKXsUMzPB5USxFpqR7IauWs87sKKg+/THGxwXin5Mjl41w0K/NjVJp5A1A/f8=
X-Received: by 2002:a05:6000:420e:b0:3d1:ce9d:4f9c with SMTP id
 ffacd0b85a97d-3d1ce9d52dbmr70394f8f.31.1756499295198; Fri, 29 Aug 2025
 13:28:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827153728.28115-1-puranjay@kernel.org> <20250827153728.28115-3-puranjay@kernel.org>
 <99bb1aa8-885b-4819-beb3-723a73960f67@huaweicloud.com>
In-Reply-To: <99bb1aa8-885b-4819-beb3-723a73960f67@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Aug 2025 13:28:01 -0700
X-Gm-Features: Ac12FXwlLsc5i03CfGafUHRqTc4meVU_JjjINdZ4YRDpCONVk-reha-OlSTdwR8
Message-ID: <CAADnVQKp-FXhVtxCSE8rako8BBnAU4Qt-dxviqrJUr-Fpfm+4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] bpf: Report arena faults to BPF stderr
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 3:30=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> > +
> > +void bpf_prog_report_arena_violation(bool write, unsigned long addr)
> > +{
> > +     struct bpf_stream_stage ss;
> > +     struct bpf_prog *prog;
> > +     u64 user_vm_start;
> > +
> > +     prog =3D bpf_prog_find_from_stack();
>
> bpf_prog_find_from_stack depends on arch_bpf_stack_walk, which isn't avai=
lable
> on all archs. How about switching to bpf_prog_ksym_find with the fault pc=
?

Out of archs that support bpf arena only riscv doesn't
support arch_bpf_stack_walk(), which is probably fixable.
But I agree that direct bpf_prog_ksym_find() is cleaner here.
We need to make sure it works for subprogs, since streams[2] are
valid only for main prog.
I think we can add:
struct bpf_prog_aux {
  ...
  struct bpf_prog_aux *main_prog;
};
init it during jit_subprogs() and use it for stream access.
We can also remove skipping of subprogs in find_from_stack_cb() then.

Kumar, wdyt?

In a bigger follow up maybe we can split bpf_prog_aux into two
structures for main prog and for subprogs, since we copy
a bunch of pointers from main into subprogs.
With 'main_prog' pointer all these pointers (like linfo, func_info,
kfunc_tab, arena, btf) can stay in 'struct bpf_main_prog_aux',
so 'struct bpf_subprog_aux' can be smaller.

