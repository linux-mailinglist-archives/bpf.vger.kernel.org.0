Return-Path: <bpf+bounces-54347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DDDA67E56
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 21:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8EE189FF0D
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 20:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5254212B09;
	Tue, 18 Mar 2025 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="VjCxaG/4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858841CC8B0
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742331427; cv=none; b=ApAyW9GYphWxo9hfia0G6EnYH+KIrY0dNZAPznB+cuFaYUDWm2lUsfeYlFVybGVQkhLx6FyKdg/pc63/A4S5JLs0AhKhbLVuTA2iM0V2o/GIu7O/ugiJmLs62A492whc881WmzDwfh3grfNzWNFxMQHe8dHLuWRTVD/4zO+F8kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742331427; c=relaxed/simple;
	bh=52n6zC2/PqINm12s2qnzhv8Eg0mTLzinsMkYSH3gbUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2DjOndY8HxueCpPYrZ1mAls3DNvVfj3YALtcgv5hqqDfO6+3PVURGUXxLYSAf/WCziy00KnqA04E/ciRD2zrPLGKoBIOgNLjd8rkRh6eZvxWw+w0qt9Wf46mJardlOPZDbbCM7NknWBm6FLN1oA34Pjab+GUEviUGM0MObT/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=VjCxaG/4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-394780e98easo3982050f8f.1
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 13:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742331424; x=1742936224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vS5PxEUdKoezNe74Xkhoavb91+Q59/FtAvz6KAP9rw8=;
        b=VjCxaG/4xcicNPvz+eAPv0Xjr9TpefIOI5PjTKHQCzr8RcSSQIo6iKyjQO6hDoZ2bk
         2N1vON8JoemvDqvr3mHBjH9xxrAUZzZQb7ej59P5jZA9Nk840Ip7cjazq2VhYW7xBSNV
         1bbMaF9rlth0ikxaN8KArMWGUPSY3jmxmGMMCtBbwdguS7AG7bZjHdNDKS/uBuyzcKtF
         nhxC/cOEcAn1SkxhZU3+hVRNOJc9YuETiWUSyc4QnrEV8JeCD97gW9p6gyLNBkg+axGt
         vmkJpX76EWF2iDUY1Nxflb+ztGyRtWoH9/2TstIRt4jgPUhX213/ufzpJTbHlZMI81Gn
         Ch7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742331424; x=1742936224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vS5PxEUdKoezNe74Xkhoavb91+Q59/FtAvz6KAP9rw8=;
        b=OcHWGNu2OebdMiFmdXv73+zxbAHxar5iDcfDT0+/z9w2g8nDdSwNfrvJXcJStRoD+B
         vcLicBHtOTeWO861CB20PpdLuF9SMIk5qc1gGSmZIxIm8cRScRO0b5eGbb/aSjlJUtcN
         Ksd24k0Q5eCVk8LiT1anTt2jzQX41iourfEOe7IFdu2sW5po1ytvQ6q0r/BuQpToYyhK
         mdUSzlO5ynPTC8OZn27I2HkFqQ4TOAFpDT+XbsFQ2+RJxoRT4TNLFPldkij2QC+00Cvg
         WuLwJRvq00ETU7f6wV5ASbdYDnq9p7IYCOaAm1QvacZO8/EKi/nfq6XvXKkhGyfkZjn8
         VZcw==
X-Gm-Message-State: AOJu0Yy1dJESmm7Uww5P6OXWU/8RjTYZyy22ynUERjHiXHHqaKjov/uZ
	eEZKN8coQn+KXhnkUcNuj7joAUBFsk0RieYYC7XshMi05oofDS0kuwDtP/y1tCM=
X-Gm-Gg: ASbGncuhwEUhioSk2ZkiZq2KrtwE/Ax0gFMY5a0YzUuJvsElUGpy85sghiB9/2LEAPj
	TJBX+p24QTH/q/F91J0xLEPwvtBBNniJgHKW5TcDuXsOh64AsGt/7Wcccl/lfnZviLiWmWPyqLm
	Y32KtwvGrL0GnepaQU/kwJID3B5ElsvnQ9RROJRqH10HhGSD7C0Gz19WctphRnVWUhXP/aRYh79
	NpSH28dr5z2msJLTyQkoOHhcelh+cVgrTaYbM0K9EA3ZZvlH4QDjF7c0Cn6m2xzCF38CjoJd85q
	CMg/To9HJybpFjoiJ0cqDhwXDXMfTIkGBAnKHeDaYxV/lXHF
X-Google-Smtp-Source: AGHT+IEnYMSkrEe3ztJHEucthYfCBv4MQCbrEuJ/g0QGCsPv6+CXwPeRtXKe/sm813nU1dwGMwZubA==
X-Received: by 2002:adf:ca93:0:b0:391:42f2:5c82 with SMTP id ffacd0b85a97d-399739d7300mr187460f8f.21.1742331423711;
        Tue, 18 Mar 2025 13:57:03 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebbb7sm19607351f8f.92.2025.03.18.13.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 13:57:03 -0700 (PDT)
Date: Tue, 18 Mar 2025 21:00:46 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [RFC PATCH bpf-next 14/14] selftests/bpf: Add tests for BPF
 static calls
Message-ID: <Z9ne/o9lmIwbVN+3@mail.gmail.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
 <20250318143318.656785-15-aspsk@isovalent.com>
 <543f9e82-b941-4a90-90c8-f559c2e3d908@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <543f9e82-b941-4a90-90c8-f559c2e3d908@linux.dev>

On 25/03/18 01:53PM, Yonghong Song wrote:
> 
> 
> On 3/18/25 7:33 AM, Anton Protopopov wrote:
> > Add self-tests to test new BPF_STATIC_BRANCH_JA jump instructions
> > and the BPF_STATIC_KEY_UPDATE syscall.
> > 
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >   .../bpf/prog_tests/bpf_static_keys.c          | 359 ++++++++++++++++++
> >   .../selftests/bpf/progs/bpf_static_keys.c     | 131 +++++++
> >   2 files changed, 490 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/bpf_static_keys.c
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c b/tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c
> > new file mode 100644
> > index 000000000000..3f105d36743b
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c
> > @@ -0,0 +1,359 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +
> > +#include <sys/syscall.h>
> > +#include <bpf/bpf.h>
> > +
> > +#include "bpf_static_keys.skel.h"
> > +
> > +#define VAL_ON	7
> > +#define VAL_OFF	3
> > +
> > +enum {
> > +	OFF,
> > +	ON
> > +};
> > +
> > +static int _bpf_prog_load(struct bpf_insn *insns, __u32 insn_cnt)
> > +{
> > +	return bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, insn_cnt, NULL);
> > +}
> > +
> > +static int _bpf_static_key_update(int map_fd, __u32 on)
> > +{
> > +	LIBBPF_OPTS(bpf_static_key_update_opts, opts);
> > +
> > +	opts.on = on;
> > +
> > +	return bpf_static_key_update(map_fd, &opts);
> > +}
> > +
> > +#define BPF_JMP32_OR_NOP(IMM, OFF)				\
> > +	((struct bpf_insn) {					\
> > +		.code  = BPF_JMP32 | BPF_JA | BPF_K,		\
> > +		.dst_reg = 0,					\
> > +		.src_reg = BPF_STATIC_BRANCH_JA,		\
> > +		.off   = OFF,					\
> > +		.imm   = IMM })
> > +
> > +#define BPF_JMP_OR_NOP(IMM, OFF)				\
> > +	((struct bpf_insn) {					\
> > +		.code  = BPF_JMP | BPF_JA | BPF_K,		\
> > +		.dst_reg = 0,					\
> > +		.src_reg = BPF_STATIC_BRANCH_JA,		\
> > +		.off   = OFF,					\
> > +		.imm   = IMM })
> > +
> > +#define BPF_NOP_OR_JMP32(IMM, OFF)				\
> > +	((struct bpf_insn) {					\
> > +		.code  = BPF_JMP32 | BPF_JA | BPF_K,		\
> > +		.dst_reg = 0,					\
> > +		.src_reg = BPF_STATIC_BRANCH_JA |		\
> > +			   BPF_STATIC_BRANCH_NOP,		\
> > +		.off   = OFF,					\
> > +		.imm   = IMM })
> > +
> > +#define BPF_NOP_OR_JMP(IMM, OFF)				\
> > +	((struct bpf_insn) {					\
> > +		.code  = BPF_JMP | BPF_JA | BPF_K,		\
> > +		.dst_reg = 0,					\
> > +		.src_reg = BPF_STATIC_BRANCH_JA |		\
> > +			   BPF_STATIC_BRANCH_NOP,		\
> > +		.off   = OFF,					\
> > +		.imm   = IMM })
> > +
> > +static const struct bpf_insn insns0[] = {
> > +	BPF_JMP_OR_NOP(0, 1),
> > +	BPF_NOP_OR_JMP(0, 1),
> > +	BPF_JMP32_OR_NOP(1, 0),
> > +	BPF_NOP_OR_JMP32(1, 0),
> > +};
> > +
> 
> [...]
> 
> > +
> > +static void check_bpf_to_bpf_call(struct bpf_static_keys *skel,
> > +				  struct bpf_map *key1,
> > +				  struct bpf_map *key2)
> > +{
> > +	struct bpf_link *link;
> > +
> > +	link = bpf_program__attach(skel->progs.check_bpf_to_bpf_call);
> 
> there is no progcheck_bpf_to_bpf_call. Compilation will fail.

Oops, thanks! I haven't cleaned it out (have it in my dev branch)...
(Compilation will fail in the first place in progs/bpf_static_keys.c, as
`asm(gotol_or_nop)` will not compile.

> > +	if (!ASSERT_OK_PTR(link, "link"))
> > +		return;
> > +
> > +	__check_multiple_keys(skel, key1, key2, 0, 303, 3030, 3333);
> > +
> > +	bpf_link__destroy(link);
> > +}
> > +
> [...]

