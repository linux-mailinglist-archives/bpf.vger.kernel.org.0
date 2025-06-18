Return-Path: <bpf+bounces-60977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE135ADF2B4
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6A0160F6D
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974442F0046;
	Wed, 18 Jun 2025 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLvz2Bho"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A862F1980
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750264235; cv=none; b=G7hV2Q3RqDZ7b1d+isQUpiPGOkOla0vIyFK6p6dwpOgQTQMywvlA6ENZw+cT80hafaCZwNJjLE3QYpq2bSMrD8k/z93EbdxQL0yO4qcQ1g9MU0PuHgGZ7RMvw2YwIr9ur/BhFy2+hKtLJWh8Dd2/zDHc5QyqpEk/BGjQAc8++BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750264235; c=relaxed/simple;
	bh=kO+cnWFwKLC0Pze3CGoMIC9KzsnxaGf3JLnJdEjbETI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1nVGybC8v31aCBCwvrkPOr2+gOPYehRzI2eVZ12fKdfcXy0znnjCfhBoG0dehAaVWx97fmMNqfm+CKqDKie0U5R/Pn3iBS3IHTpscdO3DXnY6gbWyghL0KGGmHS6Ge0Q3aBAgwqClFzgVJMugP23xdqP3wunFJe3Q5+LGQTRIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLvz2Bho; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a5123c1533so4068900f8f.2
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 09:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750264231; x=1750869031; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K07rBjofrMbe2PWGL67RpmUV1u8o3IvQGinFyRGxbjY=;
        b=QLvz2BhovH30QkTN0lwdMby6uFK5T6FhYTBwErbdANtWWhDpnBWOgmglpTdllUycRp
         yuNN/tvcHrEXvH3zs9cYGRcY4C/SV93zqMP9rtSnYT12fmMKSK3DrfIk6oVHnbeTAUGh
         O2Gd0uuJ9vSTMbdJB68iM8bTMD0oRJ/5zr292u7kSxpPk0nSNKkUOLjRHLCw72k8Cq8v
         LYfE4logagjnBFDY+eUnj93cqSWA37yS16fVLW2k24KXJ+o5kiVoXgIM1nM5CSojIA9l
         0Br74XSaUTCIAx8wvI7zrl7GSN/SRg43pVZMlfmhFG2LIxlvvY8LA5zMP6Jp5HcVxivW
         74aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750264231; x=1750869031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K07rBjofrMbe2PWGL67RpmUV1u8o3IvQGinFyRGxbjY=;
        b=BpSLiz3BxfA72vnmVIc0JMnf84lN0WfR7lW77uZzS4LxugOmKRdGJmc2E4ch3QXuJp
         Q3SzReKeUDy3amyxWl5vzvi6ui21+4VbLSO+FFMHVtirXSDCTWm9rwnryz39wCjFaEOR
         buBlU0WBo8PZB5KNJ0MD2+hR78RtzusqOJCYEqPY9dc77eeSQX4bS1kQ4WPj00DUYYqn
         Mw1LCQNgpZ9ALfRIeDZJKX72PCbKPpAqo/QWJeHV6kIQQoXJ0AVG571+AETxG1gUCm3c
         gY1hBAy8LaiH4GqBswA531P91A18nNytcV/Tdry+XW+YsVpqipYWa6Mk5iROXTWaB4tX
         aM2Q==
X-Gm-Message-State: AOJu0Yxna40ol3rbCvO3GEtquQvR7J1u/AKwyQA3+sJrgt8X3mH6TQ4P
	m3OID6Mcc+1UMJFBES+HmGRmvfin49y96ApuJ/47VHf2LoHQFDEErm9m
X-Gm-Gg: ASbGncse0Mjwy/oNiLyxmN/BkPegjVjLGyJeSiNCHjJc1u2pVYrbnIhf09xL0v6xlSR
	n9qvb95lEH6doH3nB8ws7OBFX0OgZBGn4jZhV0B8TcLOqgHfTRIPg2jt3d4CxDiS8UULWbTCWsu
	Jr/IrPYuPXf/7X4bluPwLz+KTzOtLwC0cgJWHl4/EoqT8U19Po35P0uwiKs67ezYHnUgzZexFiY
	u0ti12RdVTtJCAVKfEGnqTv5HUGHHUjCfrFS/0Yv8XvninPo3Z/AlflvODHRAeEAU2tM/4qFbcb
	UhQlETOYOaMYof48mZdYEhcILX7kdEUtKAfytF05OrkiQ0HxW2pY0oCKHfTe5SeU346D5vtdXg=
	=
X-Google-Smtp-Source: AGHT+IFgRzsW8ghKtb7EFUF8nVOlONfBvddcXkWxSptC7kq/gcS5jwk/l43rZH5suZ5wCoTb9E2MxQ==
X-Received: by 2002:a05:6000:400c:b0:3a4:d6aa:1277 with SMTP id ffacd0b85a97d-3a572e79d82mr14306442f8f.37.1750264230437;
        Wed, 18 Jun 2025 09:30:30 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e9844a9sm2244855e9.12.2025.06.18.09.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:30:29 -0700 (PDT)
Date: Wed, 18 Jun 2025 16:36:13 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [RFC bpf-next 9/9] selftests/bpf: add selftests for indirect
 jumps
Message-ID: <aFLq/blfEEiIqXGz@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-10-a.s.protopopov@gmail.com>
 <CAADnVQKPbBRGOj2mB5Um80VFUh_vVg=oRJCdYUgyz_DrObuagQ@mail.gmail.com>
 <aFLR7NrdX3gbjC1s@mail.gmail.com>
 <CAADnVQ+nHemrEgeWYHxLi1UVeJ2u7DtSDTpcrPR7w2PgFPgQZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+nHemrEgeWYHxLi1UVeJ2u7DtSDTpcrPR7w2PgFPgQZw@mail.gmail.com>

On 25/06/18 09:01AM, Alexei Starovoitov wrote:
> On Wed, Jun 18, 2025 at 7:43 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > On 25/06/17 08:24PM, Alexei Starovoitov wrote:
> > > On Sun, Jun 15, 2025 at 1:55 AM Anton Protopopov
> > > <a.s.protopopov@gmail.com> wrote:
> > > > +SEC("syscall")
> > > > +int two_towers(struct simple_ctx *ctx)
> > > > +{
> > > > +       switch (ctx->x) {
> > > >
> > >
> > > Not sure why you went with switch() statements everywhere.
> > > Please add few tests with explicit indirect goto
> > > like interpreter does: goto *jumptable[insn->code];
> >
> > This requires to patch libbpf a bit more, as some meta-info
> > accompanying this instruction should be emitted, like LLVM does with
> > jump_table_sizes. And this probably should be a different section,
> > such that it doesn't conflict with LLVM/GCC. I thought to add this
> > later, but will try to add to the next version.
> 
> Hmm. I'm not sure why llvm should handle explicit indirect goto
> any different than the one generated from switch.
> The generated bpf.o should be the same.

For a switch statement LLVM will create a jump table
and create the {,.rel}.llvm_jump_table_sizes tables.

For a direct goto *, say

    static const void *table[] = {
            &&l1, &&l2, &&l3, &&l4, &&l5, 
    };
    if (index > ARRAY_SIZE(table))
            return 0;
    goto *table[index];

it will not generate {,.rel}.llvm_jump_table_sizes. I wonder, does
LLVM emit the size of `table`? (If no, then some assembly needed to
emit it.) In any case it should be easy to add this case, but still
it is a bit of coding, thus a bit different case.)

> > > Remove all bpf_printk() too and get easy on names.
> >
> > The `bpf_printk` is there to emit some instructions which later will
> > be replaced by the verifier with more instructions; this is to
> > additionally test "instruction set" basic functionality
> > (orig->xlated mapping). Do you think this selftest shouldn't have
> > this?
> 
> None of the runnable tests should have bpf_printk() since
> it spams the global trace pipe.
> There are few tests that have printks, but they shouldn't be runnable.
> It's load only.

Ok, thanks, makes total sense now

> > > i_am_a_little_tiny_foo() sounds funny today, but
> > > it won't be funny at all tomorrow.
> >
> > Yeah, thanks, will rename it.

