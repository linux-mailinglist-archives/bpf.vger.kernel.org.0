Return-Path: <bpf+bounces-47644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A379FCF12
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 00:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8491882E2B
	for <lists+bpf@lfdr.de>; Thu, 26 Dec 2024 23:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB0F1A8F6B;
	Thu, 26 Dec 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1OpHecNI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B65194094
	for <bpf@vger.kernel.org>; Thu, 26 Dec 2024 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735254438; cv=none; b=cLVxt1yDt+WBKnvVgMP1r5bXw3YRDn4B/lpzzmTK2ZSkFa9oJALIbv6vJMvmwcN1qA7Qm+mi2NYVQRSjN7EZZfm3HA5Afj122JdVpGUS0p5fa7qBpCvPxWliFzjVAvJJGAW0cLD+/nxBeU1gi557Do4L/DUQSoydczJ22/jTKs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735254438; c=relaxed/simple;
	bh=owoiXDwEf0XQjB75NhfATuGiAfQel2mJDnU82ujMV8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soHUiqj+8qadvLqCrSUbqAvZbkdHGUB/sz3e4EDN/GfS1kad885PYT+ntUjBpkpltKO+fX0TbEj6HMyIKnq1dnz4Y4xnk3Gizxc3bY+BJ+QsUbmm63ckCeddt4+25G3XwGdxqgAjqUlf7CKAGTBv2beF/lH0dckLXxHW4b9UA7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1OpHecNI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215740b7fb8so801155ad.0
        for <bpf@vger.kernel.org>; Thu, 26 Dec 2024 15:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735254436; x=1735859236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qHw1Ri1OKyFo2vFi05pherajyU/WZYq/9veyQYAeQzg=;
        b=1OpHecNIDI1KD+YCuo+JK/1krgIffI0BYeOsOEJ/0g8RCI/MOJxk3KCzXMs5unR7S1
         z20drETsgIc4y/FQJ+FfQslszb6POKXZTsFyWBYtjFjEYc3XJf+WR64M1Fbhx345GrUS
         mXkOWSTMezaZZZyhPeKKnawb33JgMt4Tx7JgHaobt5XP98s+ALViMHwwBsjj/l9sFTzQ
         96dzwcfukLZhiLHJuIvf5vWXkt5UXBVmHMEZbZfJd+ZJ+hW474a4QtKvJCSQST4m7IqQ
         RRmmir3KFjEs9ENMjuEnHRASdP+pe4rTSkkIP9Tz31ygpR3zLdiTEuWxtYVjpDg+GwCW
         U6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735254436; x=1735859236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHw1Ri1OKyFo2vFi05pherajyU/WZYq/9veyQYAeQzg=;
        b=D2CfHf4bxogigaBMHkS3DXyRCjHo7ZdaKNrD1oztXRI9jl1lvh+qo+mdZZwqbM524R
         HSPWUtUvNJzAHMwivfZxXXteJYVjbOXAKPhjVa9cMmFSgGtfWBjYxeX8bHzOfob2eOfh
         sb+uPCbU1RZgPuSmPm+aPZmQVCqNScI5WB2z5Cr25EE0Qtm6pVyC10jeDu5sHf9y6p+S
         62z8Q+0i/SV1jXP0FIpjieYmvjIUjpK81BNOOvZ9mzb0tA2+pveqCOO/EFkxZ5g/c2Ew
         Jh/hT9jic9Y21p2Nu7kQVWzvNkK+lUHx/qWwp7g3HwSP8ckajiV+Q6iFFxRcOqRDjdeF
         yMZQ==
X-Gm-Message-State: AOJu0YwwTluzVKc9NLHqdVmywRIh+hkYTt1z0FdKZGiQyZNhGhcYh3wA
	ZrSKynFXCFY9vjXFsFX5qSyciOJTWJIVnf8uhD2WjGVfd+6A5lNuqmPwkRJrxA==
X-Gm-Gg: ASbGncsRSFtaqy3lejT/GebV0uInRIzAya1beBS2ww2k7JPfA8gouSTaUhS3ZiYhfT1
	BzE8BfAamMVWo3zWW2fRVrVZm9o3CQLDnj9092Q10i6D3ibLz3+bHLLeqfN+5rIpRCKUfiPhxQg
	seQ0leLGYf2uBJygmtae+oG5irhPCyMPXYmRL82a5oN2Z39lIYTMCNgXx/wc1TDYIjqBO/s9+is
	m1RezUz2PdmdcTqxtg1R2VJJe3bJiwjTlsMAKArQM3SdmVl10yeWu5/S9mmnLkggMUHjpDab1ZH
	27G4BXDEUXxCFjZ+LH8=
X-Google-Smtp-Source: AGHT+IGfQfKiN97uVwHgjDGT4PXjsKBjYPDx9B79kKC6/Tnx7icupHvR2AqkUCcvVIW2yQNa+/iZOA==
X-Received: by 2002:a17:902:c404:b0:215:7ced:9d66 with SMTP id d9443c01a7336-219e66a0b47mr10852445ad.10.1735254435534;
        Thu, 26 Dec 2024 15:07:15 -0800 (PST)
Received: from google.com (40.155.125.34.bc.googleusercontent.com. [34.125.155.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fb9fcsm13437535b3a.164.2024.12.26.15.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 15:07:14 -0800 (PST)
Date: Thu, 26 Dec 2024 23:07:10 +0000
From: Peilin Ye <yepeilin@google.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	David Vernet <dvernet@meta.com>,
	Dave Marchevsky <davemarchevsky@meta.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v1 2/4] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <Z23hntYzWuZOnScP@google.com>
References: <cover.1734742802.git.yepeilin@google.com>
 <6ca65dc2916dba7490c4fd7a8b727b662138d606.1734742802.git.yepeilin@google.com>
 <f704019d-a8fa-4cf5-a606-9d8328360a3e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f704019d-a8fa-4cf5-a606-9d8328360a3e@huaweicloud.com>

Hi Xu,

Thanks for reviewing this!

On Tue, Dec 24, 2024 at 06:07:14PM +0800, Xu Kuohai wrote:
> On 12/21/2024 9:25 AM, Peilin Ye wrote:
> > +__AARCH64_INSN_FUNCS(load_acq,  0x3FC08000, 0x08C08000)
> > +__AARCH64_INSN_FUNCS(store_rel, 0x3FC08000, 0x08808000)
> 
> I checked Arm Architecture Reference Manual [1].
> 
> Section C6.2.{168,169,170,371,372,373} state that field Rt2 (bits 10-14) and
> Rs (bits 16-20) for LDARB/LDARH/LDAR/STLRB/STLRH and no offset type STLR
> instructions are fixed to (1).
> 
> Section C2.2.2 explains that (1) means a Should-Be-One (SBO) bit.
> 
> And the Glossary section says "Arm strongly recommends that software writes
> the field as all 1s. If software writes a value that is not all 1s, it must
> expect an UNPREDICTABLE or CONSTRAINED UNPREDICTABLE result."
> 
> Although the pre-index type of STLR is an excetpion, it is not used in this
> series. Therefore, both bits 10-14 and 16-20 in mask and value should be set
> to 1s.
> 
> [1] https://developer.arm.com/documentation/ddi0487/latest/

<...>

> > +	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT2, insn,
> > +					    AARCH64_INSN_REG_ZR);
> > +
> > +	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RS, insn,
> > +					    AARCH64_INSN_REG_ZR);
> 
> As explained above, RS and RT2 fields should be fixed to 1s.

I'm already setting Rs and Rt2 to all 1's here, as AARCH64_INSN_REG_ZR
is defined as 31 (0b11111):

	AARCH64_INSN_REG_ZR = 31,

Similar to how load- and store-exclusive instructions are handled
currently:

> >   __AARCH64_INSN_FUNCS(load_ex,	0x3F400000, 0x08400000)
> >   __AARCH64_INSN_FUNCS(store_ex,	0x3F400000, 0x08000000)

For example, in the manual, Rs is all (1)'s for LDXR{,B,H}, and Rt2 is
all (1)'s for both LDXR{,B,H} and STXR{,B,H}.  However, neither Rs nor
Rt2 bits are in the mask, and (1) bits are set manually, see
aarch64_insn_gen_load_store_ex():

  insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT2, insn,
                                      AARCH64_INSN_REG_ZR);

  return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RS, insn,
                                      state);

(For LDXR{,B,H}, 'state' is A64_ZR, which is just an alias to
AARCH64_INSN_REG_ZR (0b11111).)

- - -

On a related note, I simply grabbed {load,store}_ex's MASK and VALUE,
then set their 15th and 23rd bits to make them load-acquire and
store-release:

  +__AARCH64_INSN_FUNCS(load_acq,  0x3FC08000, 0x08C08000)
  +__AARCH64_INSN_FUNCS(store_rel, 0x3FC08000, 0x08808000)
   __AARCH64_INSN_FUNCS(load_ex,   0x3F400000, 0x08400000)
   __AARCH64_INSN_FUNCS(store_ex,  0x3F400000, 0x08000000)

My question is, should we extend {load,store}_ex's MASK to make them
contain BIT(15) and BIT(23) as well?  As-is, aarch64_insn_is_load_ex()
would return true for a load-acquire.

The only user of aarch64_insn_is_load_ex() seems to be this
arm64-specific kprobe code in arch/arm64/kernel/probes/decode-insn.c:

  #ifdef CONFIG_KPROBES
  static bool __kprobes
  is_probed_address_atomic(kprobe_opcode_t *scan_start, kprobe_opcode_t *scan_end)
  {
          while (scan_start >= scan_end) {
                  /*
                   * atomic region starts from exclusive load and ends with
                   * exclusive store.
                   */
                  if (aarch64_insn_is_store_ex(le32_to_cpu(*scan_start)))
                          return false;
                  else if (aarch64_insn_is_load_ex(le32_to_cpu(*scan_start)))
                          return true;

But I'm not sure yet if changing {load,store}_ex's MASK would affect the
above code.  Do you happen to know the context?

> > +	if (BPF_ATOMIC_TYPE(insn->imm) == BPF_ATOMIC_LOAD)
> > +		ptr = src;
> > +	else
> > +		ptr = dst;
> > +
> > +	if (off) {
> > +		emit_a64_mov_i(true, tmp, off, ctx);
> > +		emit(A64_ADD(true, tmp, tmp, ptr), ctx);
> 
> The mov and add instructions can be optimized to a single A64_ADD_I
> if is_addsub_imm(off) is true.

Thanks!  I'll try this.

> I think it's better to split the arm64 related changes into two separate
> patches: one for adding the arm64 LDAR/STLR instruction encodings, and
> the other for adding jit support.

Got it, in the next version I'll split this patch into (a) core/verifier
changes, (b) arm64 insn.{h,c} changes, and (c) arm64 JIT compiler
support.

Thanks,
Peilin Ye


