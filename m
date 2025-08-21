Return-Path: <bpf+bounces-66251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9868FB3029D
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 21:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB98173C08
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 19:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778CD3451DE;
	Thu, 21 Aug 2025 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMqIWTT/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3BB343D87
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803292; cv=none; b=QMAJd72ILcudYjbAIDC+ST7S9Eh+fSwm1B0SHwodxxH/Sv3J2QZYDem+Oh/CKK7KDNuDUpYPUl5AEWFi2dA8j09Fdt3Nq89JLJrX22+sdct3Vr8xEBv24pH6QQdFBCfJZI5EYXHXDu4A13rjdsRTUnq2Eb6seJ4nuyWXFtKnlbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803292; c=relaxed/simple;
	bh=EisbM3xprVTDuD20KccL7bc4/uoSRBJGq6tUDAt3XIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoCSwuW5DRiqvC0Zf10cf8bF39casrU5tniAJQF7JAiYI7iaRkmNxQ8LWJ3WOCmLpJDuSveeF4SElRsFKfOe6mCy0Jjmv3F65frviDziNS4lM8j+LU/Dyiuruj+Gsyld33JNh+zQE973wGQX5dFih2i/Cy1gM7mlVeKrPLmcC+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMqIWTT/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so7455715e9.2
        for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 12:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755803288; x=1756408088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/DXtcBQWOsAcbHrLZQ8PAJzEp9YjtPAil4az/GYLT2c=;
        b=bMqIWTT/ZQDz/tXRdm92B6Q+tn/7OgkbDEnkOY2Gs9FcpXYDRaQoqXkFblKd3wJQPn
         RSkbbkXMDDqLATPFc2mNmQ5uLtWgG+MKoDiIjjOMLNKpZ6s79tvVs+NCjjEURseQr5Wj
         btfG3rAUeWQd3i9DTmIWMTJt601RQ5JmmLSX1Q1n3uZdtkcPaW/gciZsVBSKBEgSiCcj
         3j/10svoOxDlQHSE7sgGTwsRGWeEMIKnTW6hqrH4HOrspbF77qCHiQMZkR+xVlLLlbFL
         YXcGsHxQbTwAsiGoM3N2m120U/WIgoH7V9toEHk7ait2KR2FKEf/4LZcyF/Z/T7XEIrT
         kJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755803288; x=1756408088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/DXtcBQWOsAcbHrLZQ8PAJzEp9YjtPAil4az/GYLT2c=;
        b=tsDOYaHY7B8cCAVq66UZbQbCFpyNUuAAOUnkMiY1khkytu0jG9auP9PROgfIQSfqoB
         1uM2DAQWf+hpmg//FhpWatwfAU4vgbwofEgsa8p2FbZVd7SJ8SrBByfiv2rMF9UgLbgE
         oWgB8JhwRHZefhPUoMFUYyWWCuGGKYC8rd84obnPt1dm3d+y13BrOWDhe/Vxg/Pixhsr
         P6ss8s7syEMRLgxDK0rkYZwx8NJMlV2LKFO9enesz65y0PYjUpVPOo5jdVh1u8KfUETB
         60aG9o6SnP1pNlpnM7O8cvrUdYXFAIzWyVXelRAmRG4CbQWn1yPMis3v64PlsaFkB29b
         n32Q==
X-Gm-Message-State: AOJu0Yx/mfxndVqcdPBDiTLMELr1bC9PdAU0+qZpBhtfdKZpz2qIh2zK
	i1QjNS3OPFANyf0PSSTwPM9+o75pKLeL8sP//qVPdcQn0ilA3jPPK43C
X-Gm-Gg: ASbGncv8yEUohVmdzTWEgn/kOT5nXWW36DeECuuHjapUS8F7AvR2iKKGGOTMfHa4MiJ
	2EaYcIaqGrumuemrtzgqs+G4AXzEVcXYgl3Yhj51U/BEx9Qy2iQYWX1YIODUKX5x6UTpwgWKgOE
	hLnTwan/Mm4PZkdsvwjsEtjgeGdkOlNCShLUol6heV+zypw3pkxYe9NVTEL3p6VJgpr6/YzMAF8
	FzyvBLi3hHnl3ecrP3+BPYVdg0U+KQr4FeFJ71B8v7iRqe2DiN/93+q5c5ODIUIERp/Lyv8YfRj
	qCzkSnY8of4PGILaCfPcRz+RqiKWubyeSZ39Vh3st41hQ7bU/iRRJ1lJFIBoXYOMIFEB7+pLZ6Q
	6p/DQI3Uyu1uP2yUXm8batBBYQL+s+YsB+Q==
X-Google-Smtp-Source: AGHT+IH0RLTay3iBphijGyq9M6hDfiTIojDuSEfgKYyBbmYNsyo6tjpzaeXdRaVQCjfEPFDgTK5E4w==
X-Received: by 2002:a05:600c:1548:b0:459:d709:e5b0 with SMTP id 5b1f17b1804b1-45b5178e893mr2244475e9.5.1755803287926;
        Thu, 21 Aug 2025 12:08:07 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074879fe5sm12628439f8f.2.2025.08.21.12.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 12:08:07 -0700 (PDT)
Date: Thu, 21 Aug 2025 19:12:38 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 10/11] libbpf: support llvm-generated
 indirect jumps
Message-ID: <aKdvpu3AVt4KTXW5@mail.gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
 <20250816180631.952085-11-a.s.protopopov@gmail.com>
 <CAEf4BzaZxoz+=_uycH=6rO3U548TF7K8v5zKukDSJjWUgEXSSw@mail.gmail.com>
 <aKcZlBD+Mojmf+6P@mail.gmail.com>
 <CAEf4Bza7G1Ypbg3XcB_i71HYUuySXyaPX9rMGtHN3t7YCpRY2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza7G1Ypbg3XcB_i71HYUuySXyaPX9rMGtHN3t7YCpRY2Q@mail.gmail.com>

On 25/08/21 11:14AM, Andrii Nakryiko wrote:
> On Thu, Aug 21, 2025 at 6:00 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > On 25/08/20 05:20PM, Andrii Nakryiko wrote:
> > > On Sat, Aug 16, 2025 at 11:02 AM Anton Protopopov
> > > <a.s.protopopov@gmail.com> wrote:
> > > >
> > > > For v5 instruction set, LLVM now is allowed to generate indirect
> > > > jumps for switch statements and for 'goto *rX' assembly. Every such a
> > > > jump will be accompanied by necessary metadata, e.g. (`llvm-objdump
> > > > -Sr ...`):
> > > >
> > > >        0:       r2 = 0x0 ll
> > > >                 0000000000000030:  R_BPF_64_64  BPF.JT.0.0
> > > >
> > > > Here BPF.JT.1.0 is a symbol residing in the .jumptables section:
> > > >
> > > >     Symbol table:
> > > >        4: 0000000000000000   240 OBJECT  GLOBAL DEFAULT     4 BPF.JT.0.0
> > > >
> > > > The -bpf-min-jump-table-entries llvm option may be used to control
> > > > the minimal size of a switch which will be converted to an indirect
> > > > jumps.
> > > >
> > > > The code generated by LLVM for a switch will look, approximately,
> > > > like this:
> > > >
> > > >     0: rX <- jump_table_x[i]
> > > >     2: rX <<= 3
> > > >     3: gotox *rX
> > > >
> > > > Right now there is no robust way to associate the jump with the
> > > > corresponding map, so libbpf doesn't insert map file descriptor
> > > > inside the gotox instruction.
> > >
> > > Just from the commit description it's not clear whether that's
> > > something that needs fixing or is OK? If it's OK, why call it out?..
> >
> > Right, will rephrase.
> >
> > The idea here is that if you have, say, a switch, then, most
> > probably, it is compiled into 1 jump table and 1 gotox. And, if
> > compiler can provide enough metadata, then this makes sense for
> > libbpf to also associate JT with gotox by inserting the same map
> > descriptor inside both instructions.  However now this doesn't
> > work, and also there are cases when one gotox can be associated with
> > multiple JTs.
> 
> Ok, and right now we'll basically generate two identical BPF maps? If
> we wanted to optimize this, wouldn't it be sufficient to just reuse
> maps if relocation points to the same symbol?

No, right now the gotox doesn't contain a map, only ldimm64. In
check_cfg when the verifier encounters a gotox instruction it finds
all the potential jump tables for that subprog. In the later stage
for a `gotox Rx` the verifier knows the exact map from which Rx was
loaded, and can verify precisely.

> > > > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > > > ---
> > > >  .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
> > > >  tools/bpf/bpftool/map.c                       |   2 +-
> > > >  tools/lib/bpf/libbpf.c                        | 159 +++++++++++++++---
> > > >  tools/lib/bpf/libbpf_probes.c                 |   4 +
> > > >  tools/lib/bpf/linker.c                        |  12 +-
> > > >  5 files changed, 153 insertions(+), 26 deletions(-)
> > > >
> > > > diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> > > > index 252e4c538edb..3377d4a01c62 100644
> > > > --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> > > > +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> > > > @@ -55,7 +55,7 @@ MAP COMMANDS
> > > >  |     | **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
> > > >  |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
> > > >  |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
> > > > -|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** }
> > > > +|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** | **insn_array** }
> > > >
> > > >  DESCRIPTION
> > > >  ===========
> > > > diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> > > > index c9de44a45778..79b90f274bef 100644
> > > > --- a/tools/bpf/bpftool/map.c
> > > > +++ b/tools/bpf/bpftool/map.c
> > > > @@ -1477,7 +1477,7 @@ static int do_help(int argc, char **argv)
> > > >                 "                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
> > > >                 "                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
> > > >                 "                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
> > > > -               "                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena }\n"
> > > > +               "                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena | insn_array }\n"
> > > >                 "       " HELP_SPEC_OPTIONS " |\n"
> > > >                 "                    {-f|--bpffs} | {-n|--nomount} }\n"
> > > >                 "",
> > >
> > > bpftool changes sifted through into libbpf patch?
> >
> > Yes thanks. I think I've sqhashed the fix here, becase it broke
> > the `test_progs -a libbpf_str` test.
> >
> 
> libbpf_str test doesn't rely on bpftool, so fixing up selftest in the
> same patch makes sense (to not break bisection), but bpftool changes
> still make no change and should be done separately

Yes, seems that you're right. I think I also was fixing the
./test_bpftool.py and squashed similar changes into the libbpf
commit. I will check and split before resending.

> [...]
> 
> > >
> > > > +
> > > > +       return -prog->sec_insn_off;
> > >
> > > why this return value?... can you elaborate?
> >
> > Jump tables generated by LLVM contain offsets relative to the
> > beginning of a section. The offsets inside a BPF_INSN_ARRAY
> > are absolute (for a "load unit", i.e., insns in bpf_prog_load).
> > So if, say, a section A contains two progs, f1 and f2, then,
> > f1 starts at 0 and f2 at F2_START. So when the f2 is loaded
> > jump tables needs to be adjusted by -F2_START such that offsets
> > are correct.
> 
> the thing I missed is that this isn't some sort of error condition,
> it's just when offset falls into main program function
> 
> naming is also a bit misleading, IMO because it doesn't just return
> instruction offset, but rather an *adjustment* to an offset in jump
> table

Yeah, and I think it is even named appropriately in the call site.
I will check how to make this more transparent for the reader.

> [...]
> 
> > > where does .rel.rodata come from?
> > >
> > > and we don't need to adjust the contents of any of those sections, right?...
> > >
> > > can you please add some tests validating that two object files with
> > > jumptables can be linked together and end up with proper combined
> > > .jumptables section?
> > >
> > >
> > > and in terms of code, can we do
> > >
> > > } else if (strcmp(..., JUMPTABLES_REL_SEC) == 0) {
> > >     /* nothing to do for .rel.jumptables */
> > > } else {
> > >     pr_warn(...);
> > > }
> > >
> > > It makes it more apparent what is supported and what's not.
> >
> > Yes, sure. The rodata might be obsolete, I will check, and
> > .rel.jumptables is actually not used. This should be cleaned up
> > once LLVM patch stabilizes. Thanks for noticing this,
> > this way it is for sure added to my checklist :-)
> >
> 
> ok, thanks
> 
> > >
> > > > +                                       pr_warn("relocation against STT_SECTION in section %s is not supported!\n",
> > > > +                                               src_sec->sec_name);
> > > >                                         return -EINVAL;
> > > >                                 }
> > > >                         }
> > > > --
> > > > 2.34.1
> > > >

