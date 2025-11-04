Return-Path: <bpf+bounces-73440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C49AFC314A5
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 14:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B3A46214D
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4834B329382;
	Tue,  4 Nov 2025 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APrDFe9T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB07632938F
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263970; cv=none; b=IQgPk+WQ8oTJh5Wjsp8HhTSpF6PwsVrWa2Tf+my014UIUlBABaonj6bDXiLc0XJ9ZuVRK6cLqphHqXoGj64nEeAOSZrRTlIrwJmBxn22OvViw31Viupqogt38yefjoQIjaVZs/CH3nW4SeCgbiIEl9f+axFFkxbNIx4M/b/ZE4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263970; c=relaxed/simple;
	bh=EUdIST70JHJOmYV3wHGbnttVHqnrIs4HMI7ONDIZq40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnLqLBXCWFEaV/X/nyO5pEHkRNmnLz/rFd0CVns+rq4wy5COSL7U79jYDGiXAlZX8rB9RdmA6KGesnPstOdzj34wpvRtv1Leew0zXokOfRdj6lurCwZw75BJY7JiGohHfe+mjb8+Ot5XeaYGCw7H7QH8N3jWT3ImMLX16HnhkO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APrDFe9T; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso1011271266b.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 05:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762263965; x=1762868765; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Un5bKYiFKJpB2y3q2fS3IHxAyBmW7wYok3UTWsBMqT0=;
        b=APrDFe9TICqHTCC7WFozIYdkZ31SNFGdNt1qwrI5pOzD+XUcO7gU7/ZcZf8AR0rWSd
         6MgQCV3WVFI8xYpnHjsavId1T0H9qaTG59vKvikSsxKphJZ/ELuNWU9SX/PeUzrpY9NL
         cfWCpjuy7ZQduFNQuaXJvo8iemU3Zn6Bao1AqAkd+oijC+2klYONw/JLg+cli6uf2ok8
         kUBH4mbfI4IQuxbz7CDP9+deuNOtlF2LnMwFMxSZFq75BqBCPhQPbSk3ah792aOea/F0
         I+Ux017AzA8yoELYL9mvFL35AKBv7a09PaBDQCBjNDskeLK8CkjKh2ZXRkS674UOChSU
         GzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263965; x=1762868765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Un5bKYiFKJpB2y3q2fS3IHxAyBmW7wYok3UTWsBMqT0=;
        b=Vfn+Y9a9LNFin/gRRUVfQT7ClS+limbYR2Lcf2Th4DFcoAtbH5OvO21SEawoKzyQL0
         /pJ7v4zPpCLv0vKu88WhqvDAOy7B7EoLgjjWhJeMk7WRXdw/KaX+lb6VtVyyayAJ5L7I
         fQ/apAjW0q22OZwjuuYPxZvH54sbBuYqJv7LsUIUavEIQnepgYnhZpWOGjdogGGuWQ3Z
         sdEKw6++SJ8f7eydeB3PxWd5QHMbB/2MrZ9Gt0p6+0O6zb5Rk8rZQxeB5g3kYVBQRV7D
         hW41X1HdPkt1iJCcH6SE2RSju7KG54ej1HB5rkFDrAFTWbENDfHS9Di9AgXsHD+8Unlr
         VapQ==
X-Gm-Message-State: AOJu0YybtKG0+3a0USvj1QwDTE5aax8POoMDkKD0bcAHAmsgu8dlhDXV
	ZULkAkycmBCdjoeNYo32wG/+/0GEOSdlfwyv1dffF+skv1eXVGpfA8PQ
X-Gm-Gg: ASbGncsvz4sLSieZB7OM2tySp4LGfRNKrWSrjiQdyaH17VTOEcA5ZIiDzFP9aTomTof
	ugzrx6sUOIjAquhPc7csiJfEB82FAfg7WSkVbnJH6JH1cickieIzGc5ShYOJp2ddHHyb3Xl/8iJ
	MW+ukGcOlCJzLT0t7/apHr6otHDt3gyFNsAhMhlhZO2uMojAi69GTm86JX4yirvvdtW/mNEI80z
	iYKSXNnfxiQCIGToovbp8B7gleIukr1Z3Ng25QB8EtO0537ifKBuzOIF4Ge66fQi43kibSwiwm8
	3vZMPgDEA5ZcFoNU2ryGaQTf3P/cUEk0LB3cy7bL8zFBySI20XVG07DqEOJ87dHDmgErMaEiBDG
	7as74g7aT4C62t3zhWHvPeyXNq0bR0ML609VVKAbsf/obYb+xZAd1ElqFsfJIgM3vlhBAKOp26H
	qrwfqXumcSEwLfQS+vQvUy
X-Google-Smtp-Source: AGHT+IFaMgNCsaW0L2N8xXR4gKiH8fK/+TKXTJAJ5lilaO/vCyuYn2bEp+D4w4sAk6EIXjBGMIJpWg==
X-Received: by 2002:a17:907:9455:b0:b71:df18:9fcc with SMTP id a640c23a62f3a-b71df18a530mr451812766b.39.1762263964728;
        Tue, 04 Nov 2025 05:46:04 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fe37b7asm213766566b.60.2025.11.04.05.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:46:04 -0800 (PST)
Date: Tue, 4 Nov 2025 13:52:20 +0000
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
Message-ID: <aQoFFPSIDLW0YDK1@mail.gmail.com>
References: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
 <20251102205722.3266908-3-a.s.protopopov@gmail.com>
 <CAADnVQ+soo36eMJxcnLhbU+jTz053vd7NU-Dm46U+EJnWAzuTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+soo36eMJxcnLhbU+jTz053vd7NU-Dm46U+EJnWAzuTA@mail.gmail.com>

On 25/11/03 06:10PM, Alexei Starovoitov wrote:
> On Sun, Nov 2, 2025 at 12:52 PM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > Add the following selftests for new insn_array map:
> >
> >   * Incorrect instruction indexes are rejected
> >   * Two programs can't use the same map
> >   * BPF progs can't operate the map
> >   * no changes to code => map is the same
> >   * expected changes when instructions are added
> >   * expected changes when instructions are deleted
> >   * expected changes when multiple functions are present
> >
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/bpf_insn_array.c | 409 ++++++++++++++++++
> >  1 file changed, 409 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > new file mode 100644
> > index 000000000000..96ee9c9984f1
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > @@ -0,0 +1,409 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <bpf/bpf.h>
> > +#include <test_progs.h>
> > +
> > +#ifdef __x86_64__
> > +static int map_create(__u32 map_type, __u32 max_entries)
> > +{
> > +       const char *map_name = "insn_array";
> > +       __u32 key_size = 4;
> > +       __u32 value_size = sizeof(struct bpf_insn_array_value);
> > +
> > +       return bpf_map_create(map_type, map_name, key_size, value_size, max_entries, NULL);
> > +}
> > +
> > +static int prog_load(struct bpf_insn *insns, __u32 insn_cnt, int *fd_array, __u32 fd_array_cnt)
> > +{
> > +       LIBBPF_OPTS(bpf_prog_load_opts, opts);
> > +
> > +       opts.fd_array = fd_array;
> > +       opts.fd_array_cnt = fd_array_cnt;
> > +
> > +       return bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, insn_cnt, &opts);
> > +}
> > +
> > +static void __check_success(struct bpf_insn *insns, __u32 insn_cnt, __u32 *map_in, __u32 *map_out)
> > +{
> > +       struct bpf_insn_array_value val = {};
> > +       int prog_fd = -1, map_fd, i;
> > +
> > +       map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, insn_cnt);
> > +       if (!ASSERT_GE(map_fd, 0, "map_create"))
> > +               return;
> > +
> > +       for (i = 0; i < insn_cnt; i++) {
> > +               val.orig_off = map_in[i];
> > +               if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0, "bpf_map_update_elem"))
> > +                       goto cleanup;
> > +       }
> > +
> > +       if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> > +               goto cleanup;
> > +
> > +       prog_fd = prog_load(insns, insn_cnt, &map_fd, 1);
> > +       if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> > +               goto cleanup;
> > +
> > +       for (i = 0; i < insn_cnt; i++) {
> > +               char buf[64];
> > +
> > +               if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
> > +                       goto cleanup;
> > +
> > +               snprintf(buf, sizeof(buf), "val.xlated_off should be equal map_out[%d]", i);
> > +               ASSERT_EQ(val.xlated_off, map_out[i], buf);
> > +       }
> > +
> > +cleanup:
> > +       close(prog_fd);
> > +       close(map_fd);
> > +}
> > +
> > +/*
> > + * Load a program, which will not be anyhow mangled by the verifier.  Add an
> > + * insn_array map pointing to every instruction. Check that it hasn't changed
> > + * after the program load.
> > + */
> > +static void check_one_to_one_mapping(void)
> > +{
> > +       struct bpf_insn insns[] = {
> > +               BPF_MOV64_IMM(BPF_REG_0, 4),
> > +               BPF_MOV64_IMM(BPF_REG_0, 3),
> > +               BPF_MOV64_IMM(BPF_REG_0, 2),
> > +               BPF_MOV64_IMM(BPF_REG_0, 1),
> > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > +               BPF_EXIT_INSN(),
> > +       };
> > +       __u32 map_in[] = {0, 1, 2, 3, 4, 5};
> > +       __u32 map_out[] = {0, 1, 2, 3, 4, 5};
> > +
> > +       __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
> > +}
> > +
> > +/*
> > + * Load a program with two patches (get jiffies, for simplicity). Add an
> > + * insn_array map pointing to every instruction. Check how it was changed
> > + * after the program load.
> > + */
> > +static void check_simple(void)
> > +{
> > +       struct bpf_insn insns[] = {
> > +               BPF_MOV64_IMM(BPF_REG_0, 2),
> > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
> > +               BPF_MOV64_IMM(BPF_REG_0, 1),
> > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
> > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > +               BPF_EXIT_INSN(),
> > +       };
> > +       __u32 map_in[] = {0, 1, 2, 3, 4, 5};
> > +       __u32 map_out[] = {0, 1, 4, 5, 8, 9};
> > +
> > +       __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
> > +}
> > +
> > +/*
> > + * Verifier can delete code in two cases: nops & dead code. From insn
> > + * array's point of view, the two cases are the same, so test using
> > + * the simplest method: by loading some nops
> > + */
> > +static void check_deletions(void)
> > +{
> > +       struct bpf_insn insns[] = {
> > +               BPF_MOV64_IMM(BPF_REG_0, 2),
> > +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > +               BPF_MOV64_IMM(BPF_REG_0, 1),
> > +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > +               BPF_EXIT_INSN(),
> > +       };
> > +       __u32 map_in[] = {0, 1, 2, 3, 4, 5};
> > +       __u32 map_out[] = {0, -1, 1, -1, 2, 3};
> > +
> > +       __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
> > +}
> > +
> > +/*
> > + * Same test as check_deletions, but also add code which adds instructions
> > + */
> > +static void check_deletions_with_functions(void)
> > +{
> > +       struct bpf_insn insns[] = {
> > +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
> > +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
> > +               BPF_MOV64_IMM(BPF_REG_0, 1),
> > +               BPF_EXIT_INSN(),
> > +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
> > +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > +               BPF_MOV64_IMM(BPF_REG_0, 2),
> > +               BPF_EXIT_INSN(),
> > +       };
> > +       __u32 map_in[] =  { 0, 1,  2, 3, 4, 5, /* func */  6, 7,  8, 9, 10};
> > +       __u32 map_out[] = {-1, 0, -1, 3, 4, 5, /* func */ -1, 6, -1, 9, 10};
> > +
> > +       __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
> > +}
> 
> I was thinking of taking the first 5 patches, but this one fails:
> ./test_progs -t bpf_insn_array
> ...
> #19/4    bpf_insn_array/deletions-with-functions:FAIL
> #19/5    bpf_insn_array/blindness:OK
> #19/6    bpf_insn_array/incorrect-index:OK
> #19/7    bpf_insn_array/load-unfrozen-map:OK
> #19/8    bpf_insn_array/no-map-reuse:OK
> #19/9    bpf_insn_array/bpf-side-ops:OK
> #19      bpf_insn_array:FAIL
> 
> I don't see what you're changing later in the patches
> to make it pass, but the failure highlights the issue with
> bisectability. Pls take a look.

Thanks! I've found the chunk, it was

@@ -21664,2 +21705,4 @@ static int jit_subprogs(struct bpf_verifier_env *env)
                func[i]->aux->arena = prog->aux->arena;
+               func[i]->aux->used_maps = env->used_maps;
+               func[i]->aux->used_map_cnt = env->used_map_cnt;
                num_exentries = 0;

> This one also fails:
> #170/3   libbpf_str/bpf_map_type_str:FAIL
> #170     libbpf_str:FAIL
> 
> I was thinking of hacking it as an extra patch
> (without full support in patch 8), but gave up when I saw
> deletions-with-functions failing.
> 
> Maybe also split the main libbpf patch into prep patch
> with basic introduction of insn_array ?

I've split a commit that teaches libbpf about insn_array + moved
the bpftool commit lower. All the tests pass now.

> Or keep it as-is, if respin comes soon.

I can send the first chunk separately today,
or the whole thing a few days later.

> [...]

