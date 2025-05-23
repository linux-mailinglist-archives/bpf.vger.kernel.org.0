Return-Path: <bpf+bounces-58826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B51AC20A5
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 12:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E724E0C9A
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 10:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E31226D09;
	Fri, 23 May 2025 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj+YLWvh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A4C1DD889;
	Fri, 23 May 2025 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747994957; cv=none; b=Ti4URYUUjyQcUN5h9492UWCTLRAcCBSIR3ugIQScXUfSZfEXAQ/3YVifIWuQl77EjU4tXltFspn/3xzU5LTWClr+MiNgGy50kUl4jhERqNMcnVr9c7Sm2nNGncUm7DNrzYSsQ8uZT5Sem6pdqqt3TWLMovWcmFoaJfJ0ZFL+Jg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747994957; c=relaxed/simple;
	bh=1I6DtjbZC3o3/LRbxeNFdl8qxt9vUBVlGlgh5IPe4is=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAxomMtvhs7wOG5kilzlzxRqiqgg2t8j8d6l5krpefH10dU+ywdADw9nBNHuZf1qr+52XPF9txZ+BXI4rg5bTHnXv3GBN2zNZZv5xA31P2qcZHpT2YK+YLEKiu6Xi3XnKJWX3nnR1xhrWmoB+TrcL35mpWBJWDvO/xHlWwBalf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gj+YLWvh; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742b0840d98so5364058b3a.1;
        Fri, 23 May 2025 03:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747994955; x=1748599755; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1T7LVD5MGDvvKlgrE8eh2eu8Xe4qI4IxPWGR3aT1Liw=;
        b=Gj+YLWvhi10qXnYHhetN46NLZLarXyxEGUow/QUBK2iL32fQWoyzqeQEI0bn9xtcWv
         dbBmMlOrlPHpz0VXLdw3RhvyXiWHpCQHLtdZBj8ruZp2eTpPfsmPIUDhZ2xxnIgbf0J9
         NKuH5H+LeHYwAqwAGyJnLboKQ9umBmms980Oycz2BjYIgmqXmm0Tt5QNhig7iNvRtQyB
         bqhF0SqPu7RASghPcX+SeDDEaVlPbwKItjCK2Dp/3ZL4ib/MH2bPpp3hgRsX8KebxPP2
         xhnIcXhe3w77d3Xj3EvDkG1SKzJqN18IpQetFVzTpugwd4hdPmyPwiYgDrEiL1ugeE6I
         Dp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747994955; x=1748599755;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1T7LVD5MGDvvKlgrE8eh2eu8Xe4qI4IxPWGR3aT1Liw=;
        b=hblD30+hTqOfWfYnQE2uBFmeU9K7Td/XcSNmJnf9ENmxFFnHCHwX4lNE/6haBvv3+N
         xRQgHb1a3+Q0TUS78xNqbti2Jto7/fVs+QNdhF+QPVtTJbh5MECLHcgmpVQuQhT+hS7X
         nO7U6S04JBHZNYf8lCYGUFYRha28zrhUU57OWSDSb9R/Ndl3YPnZ75AR/z+/AVk7FMVl
         EjM/JM89MNb8nXv/xZCe981U2CXhOVFd5XzziVK1RXN0L6BDuOMvfDSXELBp/Kq1ndgW
         2VGvyDEiYWgNdfHpKyGy5UqOYuM9oxEWvnjNhfFVFj1ilHCJvAfWkte0Rk6ahOp79184
         Mnmg==
X-Forwarded-Encrypted: i=1; AJvYcCWy2o4OLj3iNNihG64arXrtXy+fBMMnxTzHakdj3p4soKhIb8cL8N2GxWFRfMed5qRyWQflLpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFCSDyEmfLHpHjq95avJNJGnNqyyjTYQUYUlNYlyc2F22sqtno
	pOmD78edqdPKT2Xm1Bw7noH1owsZpmc/k2qwCQOH0BdFLzpwNobMPFOYFtwvkA==
X-Gm-Gg: ASbGncuHyVDfjW6utX4rRzCEnhkP6m6NS+8nR8M8QIWAPwH/nNnALI+5UsMLnXSNy4n
	WRxU7feTIGB8iOE5UN1A8W43KVEvXGDWy7EOezpNkUsu35QaoRAvs8HcU11zxUZGlOpW0+rZZNT
	/I29vgzuAl8KfJdocmFtLQIPScrGvAAaMaYE6VSCt3TSF4eJemq2q5YTywGFWK7hoYMJM2IpWS0
	gJ38aa6WK/Xpehk6KVadEyhEQw5ScRnUagJznH899FLMH3Fnu72ccgwDahiGca54fY+pQLbxpky
	TDyV6lm2Zq7gVzLMAEekz5bUiniiT9bGTND1vlFTmsgT1Glm9gu94qMubJxvdtDiqJpYWxYpULs
	WBdk/Yvlrtz8caw8vQg==
X-Google-Smtp-Source: AGHT+IFWKo6OwrSpBkhfFt3ciImby+9HMA09bG+Ea0anVlSO+WIy+BpnGWM6MVMv8r27/Vc9yI51GQ==
X-Received: by 2002:a17:903:17c4:b0:231:c6be:19a5 with SMTP id d9443c01a7336-231de31d6d3mr358689965ad.27.1747994954846;
        Fri, 23 May 2025 03:09:14 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed897asm121216525ad.250.2025.05.23.03.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:09:14 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Fri, 23 May 2025 03:09:12 -0700
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com, andrii@kernel.org,
	daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: Introduce task local data
Message-ID: <aDBJSPSL0Oi/SniC@kodidev-ubuntu>
References: <20250515211606.2697271-1-ameryhung@gmail.com>
 <20250515211606.2697271-2-ameryhung@gmail.com>
 <aC7iCGNsG7YuF297@kodidev-ubuntu>
 <CAMB2axO1K3-=oAxfOd4bBopiC6NR_BFf28_jx1y=d9bpenAAgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB2axO1K3-=oAxfOd4bBopiC6NR_BFf28_jx1y=d9bpenAAgw@mail.gmail.com>

On Thu, May 22, 2025 at 09:49:23AM -0700, Amery Hung wrote:
> On Thu, May 22, 2025 at 1:36 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > Hi Amery,
> >
> > I'm trying out your series in an arm32 JIT testing env I'm working on.
> >
> >
> > On Thu, May 15, 2025 at 02:16:00PM -0700, Amery Hung wrote:
> >
> > > +

[...]

> > > +struct u_tld_data *dummy_data;
> > > +struct u_tld_metadata *dummy_metadata;
> >
> > I suspect I've overlooked something, but what are these 2 "dummy" globals
> > used for? The code builds OK without them, although I do see test errors
> > as noted below.
> >
> 
> Hi, sorry for the confusion. The forward declaration is to prevent
> dummy_data/metadata tld_map_value to be fwd_kind. I will explain this
> in the comment.
> 
> The BTF should look like this:
> 
> [9] STRUCT 'tld_map_value' size=16 vlen=2
>         'data' type_id=10 bits_offset=0
>         'metadata' type_id=11 bits_offset=64
> [10] PTR '(anon)' type_id=74
> [11] PTR '(anon)' type_id=73
> [57] STRUCT 'u_tld_data' size=4096 vlen=1
>         'data' type_id=58 bits_offset=0
> [61] STRUCT 'u_tld_metadata' size=4096 vlen=3
>         'cnt' type_id=62 bits_offset=0
>         'padding' type_id=64 bits_offset=8
>         'metadata' type_id=67 bits_offset=512
> [73] TYPE_TAG 'uptr' type_id=61
> [74] TYPE_TAG 'uptr' type_id=57
> 
> Without the forward declaration, the BTF will look like this:
> 
> [9] STRUCT 'tld_map_value' size=16 vlen=2
>         'data' type_id=10 bits_offset=0
>         'metadata' type_id=11 bits_offset=64
> [10] PTR '(anon)' type_id=63
> [11] PTR '(anon)' type_id=61
> [60] FWD 'u_tld_metadata' fwd_kind=struct
> [61] TYPE_TAG 'uptr' type_id=60
> [62] FWD 'u_tld_data' fwd_kind=struct
> [63] TYPE_TAG 'uptr' type_id=62
> 

Oh, I see. Yes, having some commentary/links would be helpful since this
makes for some tricky debugging. Was there ever any discussion of
alternatives to using the forward decl?

I'm afraid I missed the 'uptr' tag introduction and need to understand
the background.

> > I'll also mention the only reason I noticed these is that "bpftool gen
> > skeleton" automatically maps these to user space, but results in an
> > ASSERT() failure during build on 32-bit targets due to lack of support,
> > so dropping them avoids that.
> 
> Can you provide more details of the error?
> 

bpftool skeleton includes checks when mapping global vars to user space.
These fail on 32-bit archs for types whose sizes differ from the BPF VM
(i.e. longs, pointers):

   In file included from .../tools/testing/selftests/bpf/prog_tests/test_task_local_data.c:13:
   ./test_task_local_data.skel.h: In function ‘test_task_local_data__assert’:
   ./test_task_local_data.skel.h:531:9: error: static assertion failed: "unexpected size of \'dummy_data\'"
     531 |         _Static_assert(sizeof(s->bss->dummy_data) == 8, "unexpected size of 'dummy_data'");
         |         ^~~~~~~~~~~~~~
   ./test_task_local_data.skel.h:532:9: error: static assertion failed: "unexpected size of \'dummy_metadata\'"
     532 |         _Static_assert(sizeof(s->bss->dummy_metadata) == 8, "unexpected size of 'dummy_metadata'");
         |         ^~~~~~~~~~~~~~


On a whim, I tried making the dummy_xxxxxxx vars static but this still
leaves the fwd_kind and leads to verifier rejection.

> >
> >
> > 24: (85) call pc+25
> > caller:
> >  R6_w=map_value(map=tld_key_map,ks=4,vs=6) R7=1 R10=fp0 fp-8_w=map_value(map=tld_key_map,ks=4,vs=6) fp-16=map_value(map=tld_data_map,ks=4,vs=16)
> > callee:
> >  frame1: R1_w=fp[0]-16 R2_w=map_value(map=.rodata.str1.1,ks=4,vs=30) R10=fp0
> > 50: frame1: R1_w=fp[0]-16 R2_w=map_value(map=.rodata.str1.1,ks=4,vs=30) R10=fp0
> > ; static u16 __tld_fetch_key(struct tld_object *tld_obj, const char *name) @ task_local_data.bpf.h:163
> > 50: (7b) *(u64 *)(r10 -16) = r2       ; frame1: R2_w=map_value(map=.rodata.str1.1,ks=4,vs=30) R10=fp0 fp-16_w=map_value(map=.rodata.str1.1,ks=4,vs=30)
> > 51: (b4) w7 = 0                       ; frame1: R7_w=0
> > ; if (!tld_obj->data_map || !tld_obj->data_map->metadata) @ task_local_data.bpf.h:169
> > 52: (79) r1 = *(u64 *)(r1 +0)         ; frame1: R1=map_value(map=tld_data_map,ks=4,vs=16) fp-16=map_value(map=.rodata.str1.1,ks=4,vs=30)
> > 53: (15) if r1 == 0x0 goto pc+36      ; frame1: R1=map_value(map=tld_data_map,ks=4,vs=16)
> > 54: (79) r6 = *(u64 *)(r1 +8)         ; frame1: R1=map_value(map=tld_data_map,ks=4,vs=16) R6_w=scalar()
> > 55: (15) if r6 == 0x0 goto pc+34      ; frame1: R6_w=scalar(umin=1)
> > ; cnt = tld_obj->data_map->metadata->cnt; @ task_local_data.bpf.h:172
> > 56: (71) r8 = *(u8 *)(r6 +0)
> > R6 invalid mem access 'scalar'
> > processed 29 insns (limit 1000000) max_states_per_insn 0 total_states 3 peak_states 3 mark_read 1
> > -- END PROG LOAD LOG --
> > libbpf: prog 'task_init': failed to load: -EACCES
> > libbpf: failed to load object 'test_task_local_data'
> > libbpf: failed to load BPF skeleton 'test_task_local_data': -EACCES
> > test_task_local_data_basic:FAIL:skel_open_and_load unexpected error: -13
> > #409/1   task_local_data/task_local_data_basic:FAIL
> >
> >
> > I'm unsure if this verifier error is related to the dummy pointers, but
> > it does seem there's a pointer issue...
> >
> 
> The error is exactly caused by removing the dummy_xxx.
> 
> > Further thoughts or suggestions (from anyone) would be most welcome.
> >
> > Thanks,
> > Tony
> >
> > > +
> > > +struct tld_metadata {
> > > +     char name[TLD_NAME_LEN];
> > > +     __u16 size;
> > > +};
> > > +
> > > +struct u_tld_metadata {
> > > +     __u8 cnt;
> > > +     __u8 padding[63];
> > > +     struct tld_metadata metadata[TLD_DATA_CNT];
> > > +};
> > > +
> > > +struct u_tld_data {
> > > +     char data[TLD_DATA_SIZE];
> > > +};
> > > +
> > > +struct tld_map_value {
> > > +     struct u_tld_data __uptr *data;
> > > +     struct u_tld_metadata __uptr *metadata;
> > > +};
> > > +
> > > +struct tld_object {
> > > +     struct tld_map_value *data_map;
> > > +     struct tld_keys *key_map;
> > > +};
> > > +
> >
> > [...]

