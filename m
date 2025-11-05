Return-Path: <bpf+bounces-73571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CF3C340EE
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 07:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D2846537C
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 06:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913832BF005;
	Wed,  5 Nov 2025 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chod+co8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C2B2C028C
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 06:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762324177; cv=none; b=ajF0WqzQnkqJG5s8VA89Wf2TuUomT1X4DsKCaiRDgxGcw3mnCWDtKmvnfeWSd30Dk3+DIs7OSC6YYvXbdAhFs9YplYFwRS8Rir6cEoXIWvjeMhHMg7f6hL+LRyJIKBrOH9H1auQHONrxjMGo+Gv785nlu7Ggue51DJ5COdkdvLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762324177; c=relaxed/simple;
	bh=BNnYf31qeFUhA4gTuYtYUuncHt0FJSUistjqrgPQl24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdULoKX4Y9n9sOcnIqNoyRViXHLsA1IB8TqvpwHCRRK04XzLSZD9IsXbha02yTByW3XNbxgxtNUJtiMgg2pA/6EOWoOIkCLUVX7D4PGOpLkAnLzO9h0elPVySN2OZ78hb6zWfNWr4INVh1Kc3u+koPzm40r4//vlnFpx31sfl8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chod+co8; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so7023793a12.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 22:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762324173; x=1762928973; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ty+Gfi/cn+z/Huu8IbahjJOMLzmcD72aj1Rl/wh61ok=;
        b=chod+co8XCvxXbIqQ4pcmUnP9Mcy1VFxAz//YAkIaDvtgPvZyxBADuPGnfKSR7bKnq
         DKpW9QCKi2dssKZW5+S8fhTwI1K1zMHVG0OABZTQoG6L5zDThjFVfztArgtS7eICmj1a
         tca3w+JkvfrANfngJcThzx1iOZmwIneFdRVdmVLoq8exYKTWjacewhWMJbIn6qMK5DO/
         qhCRHWPIAFYTXkt2EMLxHCEtxxpGzF/QiSQaQ+j4Xkku0X6h7Jn/9zLUjASug+ltT1hy
         Dgs4S87sM3EwddUzTWPLf1TV7a+S33Tlbyjz6T7m83VEmSr1h0ibEmGOMgA2FE0M/Ju6
         O5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762324173; x=1762928973;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ty+Gfi/cn+z/Huu8IbahjJOMLzmcD72aj1Rl/wh61ok=;
        b=p/9HgKN+RODYcQ/HBq/b7w9Rm4jubNYR5GSOkNlr/XLPDYwti6mLYU7E0REvP8PoXI
         Ek+mV74eBRtILZu+9Q//d5Wq4nbxs4cU/1CLOudbnn9o49WAePP61+w5MtSjnDKrYlyC
         FMg8xpLvxqwA5uLKg81twzK7Hosid2vFx71fRMlSdAZXuOQZqbHY/tapP9IcwTKObZBu
         Ez+QNSTjrjyQJd5VzROyQ4vlHTdAy2HV2s2NrOY5psPIismP1XfzeMNqmZCxKiqJMdS/
         qLmR105fKUK6yJA7E/ujkFmplFuhsXFTcoGgU8cQWdQl+mkO6CEoZRN85ZQ9ouls700w
         Ch0w==
X-Gm-Message-State: AOJu0YynoEmrUmypiwhbGLV+5TTN00vKsp33l5pHiwnmJuf5kEpRPKJX
	qc1uB2pFhBUmoOr4UHPKKa/UYyoyvjSf4lPwU/wmnA5B3rjcdgptxUbUVuJVxg==
X-Gm-Gg: ASbGncubOlseB+2KGL0r4NZTJxBtdU6ffy5vrcY3UhVI6rHiFP0CpuflNaTbLAbxyFI
	clQ6FJc5XHjO8JxdR18xGr16jf/7JLqBBkkbW0QnnDShJtb2Rz8xvsoKhwrhuPjZzrfRYwBzSN8
	b7x8sVQpPJyVV9VKzRQFFf3GIp2LNwqeuoIj7RIfFcMknyHrred9L+k2Tyx8vwJ1ENAs1qNtgWN
	nHz3Rljbj8Ilm3nMb/GdTDPMDhhDyD44tZrVtzmnwq6LYAF/N/8t8dmdhwJS5QW+psxD8hbXOUy
	YNKLvNndjENQ/cHFuzR3D5E7I5FGAW7P72BJeZzaGSKRq2OrzdFJXqC6+dMhvq8fjYGxOGv5Cpu
	itnSWdFsmKvur5CZzCaScdAqSWnuRttHiM/ZOMfv7H6lo8iZjy2zL9azy4DsE9r458dtrKObO9z
	L/ujqPRh0xMA==
X-Google-Smtp-Source: AGHT+IEBn2JutnXu+Icc8WgjEBXhYxdF2I//20hnWmeK2Fp0/TubS1RJQXLY7i/2evavy9RUBhQqMA==
X-Received: by 2002:a17:906:730f:b0:b70:b7f8:868f with SMTP id a640c23a62f3a-b726543871cmr175689266b.27.1762324173253;
        Tue, 04 Nov 2025 22:29:33 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b725d86b9b1sm249976966b.25.2025.11.04.22.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 22:29:32 -0800 (PST)
Date: Wed, 5 Nov 2025 06:35:47 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v10 bpf-next 02/11] selftests/bpf: add selftests for new
 insn_array map
Message-ID: <aQrwQz30+gxWjQ7C@mail.gmail.com>
References: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
 <20251102205722.3266908-3-a.s.protopopov@gmail.com>
 <CAADnVQ+soo36eMJxcnLhbU+jTz053vd7NU-Dm46U+EJnWAzuTA@mail.gmail.com>
 <aQoFFPSIDLW0YDK1@mail.gmail.com>
 <CAADnVQLvAFt3VUo0vfp8cx-xd7dY0Mx08R5-ezmw3p6e7WnxFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLvAFt3VUo0vfp8cx-xd7dY0Mx08R5-ezmw3p6e7WnxFA@mail.gmail.com>

On 25/11/04 08:49AM, Alexei Starovoitov wrote:
> On Tue, Nov 4, 2025 at 5:46 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > On 25/11/03 06:10PM, Alexei Starovoitov wrote:
> > > On Sun, Nov 2, 2025 at 12:52 PM Anton Protopopov
> > > <a.s.protopopov@gmail.com> wrote:
> > > >
> > > > Add the following selftests for new insn_array map:
> > > >
> > > >   * Incorrect instruction indexes are rejected
> > > >   * Two programs can't use the same map
> > > >   * BPF progs can't operate the map
> > > >   * no changes to code => map is the same
> > > >   * expected changes when instructions are added
> > > >   * expected changes when instructions are deleted
> > > >   * expected changes when multiple functions are present
> > > >
> > > > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > ---
> > > >  .../selftests/bpf/prog_tests/bpf_insn_array.c | 409 ++++++++++++++++++
> > > >  1 file changed, 409 insertions(+)
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > > > new file mode 100644
> > > > index 000000000000..96ee9c9984f1
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > > > @@ -0,0 +1,409 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +#include <bpf/bpf.h>
> > > > +#include <test_progs.h>
> > > > +
> > > > +#ifdef __x86_64__
> > > > +static int map_create(__u32 map_type, __u32 max_entries)
> > > > +{
> > > > +       const char *map_name = "insn_array";
> > > > +       __u32 key_size = 4;
> > > > +       __u32 value_size = sizeof(struct bpf_insn_array_value);
> > > > +
> > > > +       return bpf_map_create(map_type, map_name, key_size, value_size, max_entries, NULL);
> > > > +}
> > > > +
> > > > +static int prog_load(struct bpf_insn *insns, __u32 insn_cnt, int *fd_array, __u32 fd_array_cnt)
> > > > +{
> > > > +       LIBBPF_OPTS(bpf_prog_load_opts, opts);
> > > > +
> > > > +       opts.fd_array = fd_array;
> > > > +       opts.fd_array_cnt = fd_array_cnt;
> > > > +
> > > > +       return bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, insn_cnt, &opts);
> > > > +}
> > > > +
> > > > +static void __check_success(struct bpf_insn *insns, __u32 insn_cnt, __u32 *map_in, __u32 *map_out)
> > > > +{
> > > > +       struct bpf_insn_array_value val = {};
> > > > +       int prog_fd = -1, map_fd, i;
> > > > +
> > > > +       map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, insn_cnt);
> > > > +       if (!ASSERT_GE(map_fd, 0, "map_create"))
> > > > +               return;
> > > > +
> > > > +       for (i = 0; i < insn_cnt; i++) {
> > > > +               val.orig_off = map_in[i];
> > > > +               if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0, "bpf_map_update_elem"))
> > > > +                       goto cleanup;
> > > > +       }
> > > > +
> > > > +       if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> > > > +               goto cleanup;
> > > > +
> > > > +       prog_fd = prog_load(insns, insn_cnt, &map_fd, 1);
> > > > +       if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> > > > +               goto cleanup;
> > > > +
> > > > +       for (i = 0; i < insn_cnt; i++) {
> > > > +               char buf[64];
> > > > +
> > > > +               if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
> > > > +                       goto cleanup;
> > > > +
> > > > +               snprintf(buf, sizeof(buf), "val.xlated_off should be equal map_out[%d]", i);
> > > > +               ASSERT_EQ(val.xlated_off, map_out[i], buf);
> > > > +       }
> > > > +
> > > > +cleanup:
> > > > +       close(prog_fd);
> > > > +       close(map_fd);
> > > > +}
> > > > +
> > > > +/*
> > > > + * Load a program, which will not be anyhow mangled by the verifier.  Add an
> > > > + * insn_array map pointing to every instruction. Check that it hasn't changed
> > > > + * after the program load.
> > > > + */
> > > > +static void check_one_to_one_mapping(void)
> > > > +{
> > > > +       struct bpf_insn insns[] = {
> > > > +               BPF_MOV64_IMM(BPF_REG_0, 4),
> > > > +               BPF_MOV64_IMM(BPF_REG_0, 3),
> > > > +               BPF_MOV64_IMM(BPF_REG_0, 2),
> > > > +               BPF_MOV64_IMM(BPF_REG_0, 1),
> > > > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > > > +               BPF_EXIT_INSN(),
> > > > +       };
> > > > +       __u32 map_in[] = {0, 1, 2, 3, 4, 5};
> > > > +       __u32 map_out[] = {0, 1, 2, 3, 4, 5};
> > > > +
> > > > +       __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
> > > > +}
> > > > +
> > > > +/*
> > > > + * Load a program with two patches (get jiffies, for simplicity). Add an
> > > > + * insn_array map pointing to every instruction. Check how it was changed
> > > > + * after the program load.
> > > > + */
> > > > +static void check_simple(void)
> > > > +{
> > > > +       struct bpf_insn insns[] = {
> > > > +               BPF_MOV64_IMM(BPF_REG_0, 2),
> > > > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
> > > > +               BPF_MOV64_IMM(BPF_REG_0, 1),
> > > > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
> > > > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > > > +               BPF_EXIT_INSN(),
> > > > +       };
> > > > +       __u32 map_in[] = {0, 1, 2, 3, 4, 5};
> > > > +       __u32 map_out[] = {0, 1, 4, 5, 8, 9};
> > > > +
> > > > +       __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
> > > > +}
> > > > +
> > > > +/*
> > > > + * Verifier can delete code in two cases: nops & dead code. From insn
> > > > + * array's point of view, the two cases are the same, so test using
> > > > + * the simplest method: by loading some nops
> > > > + */
> > > > +static void check_deletions(void)
> > > > +{
> > > > +       struct bpf_insn insns[] = {
> > > > +               BPF_MOV64_IMM(BPF_REG_0, 2),
> > > > +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > > > +               BPF_MOV64_IMM(BPF_REG_0, 1),
> > > > +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > > > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > > > +               BPF_EXIT_INSN(),
> > > > +       };
> > > > +       __u32 map_in[] = {0, 1, 2, 3, 4, 5};
> > > > +       __u32 map_out[] = {0, -1, 1, -1, 2, 3};
> > > > +
> > > > +       __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
> > > > +}
> > > > +
> > > > +/*
> > > > + * Same test as check_deletions, but also add code which adds instructions
> > > > + */
> > > > +static void check_deletions_with_functions(void)
> > > > +{
> > > > +       struct bpf_insn insns[] = {
> > > > +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > > > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
> > > > +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > > > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
> > > > +               BPF_MOV64_IMM(BPF_REG_0, 1),
> > > > +               BPF_EXIT_INSN(),
> > > > +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > > > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
> > > > +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > > > +               BPF_MOV64_IMM(BPF_REG_0, 2),
> > > > +               BPF_EXIT_INSN(),
> > > > +       };
> > > > +       __u32 map_in[] =  { 0, 1,  2, 3, 4, 5, /* func */  6, 7,  8, 9, 10};
> > > > +       __u32 map_out[] = {-1, 0, -1, 3, 4, 5, /* func */ -1, 6, -1, 9, 10};
> > > > +
> > > > +       __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
> > > > +}
> > >
> > > I was thinking of taking the first 5 patches, but this one fails:
> > > ./test_progs -t bpf_insn_array
> > > ...
> > > #19/4    bpf_insn_array/deletions-with-functions:FAIL
> > > #19/5    bpf_insn_array/blindness:OK
> > > #19/6    bpf_insn_array/incorrect-index:OK
> > > #19/7    bpf_insn_array/load-unfrozen-map:OK
> > > #19/8    bpf_insn_array/no-map-reuse:OK
> > > #19/9    bpf_insn_array/bpf-side-ops:OK
> > > #19      bpf_insn_array:FAIL
> > >
> > > I don't see what you're changing later in the patches
> > > to make it pass, but the failure highlights the issue with
> > > bisectability. Pls take a look.
> >
> > Thanks! I've found the chunk, it was
> >
> > @@ -21664,2 +21705,4 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> >                 func[i]->aux->arena = prog->aux->arena;
> > +               func[i]->aux->used_maps = env->used_maps;
> > +               func[i]->aux->used_map_cnt = env->used_map_cnt;
> >                 num_exentries = 0;
> 
> argh. No need for this copy. Pls use prog->aux->main_prog_aux instead.

It might be called before the used_maps are copied into aux...

> > > This one also fails:
> > > #170/3   libbpf_str/bpf_map_type_str:FAIL
> > > #170     libbpf_str:FAIL
> > >
> > > I was thinking of hacking it as an extra patch
> > > (without full support in patch 8), but gave up when I saw
> > > deletions-with-functions failing.
> > >
> > > Maybe also split the main libbpf patch into prep patch
> > > with basic introduction of insn_array ?
> >
> > I've split a commit that teaches libbpf about insn_array + moved
> > the bpftool commit lower. All the tests pass now.
> >
> > > Or keep it as-is, if respin comes soon.
> >
> > I can send the first chunk separately today,
> > or the whole thing a few days later.
> 
> Up to you. Smaller chunks are easier to review.

