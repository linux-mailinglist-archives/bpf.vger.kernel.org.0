Return-Path: <bpf+bounces-57541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E537AACA8E
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 18:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9453E1C42E77
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB57A28467C;
	Tue,  6 May 2025 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STdT2Amc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67852283FF6
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547884; cv=none; b=OiFMC924/zxBsbwcYQo/Q6T0cy0vyw2bFD/JwV/z9p52SNhklHCNH/Ls9F1RGFYQa67WyyYewf4ViIhukwzTiKhfTBrRWnZLyEO6bazkkgn6gObIMt2QLdTSAdk6bI2TBXkl6NbIRld6KHsFlXn7kktPc/nVZEb1+x7Tu+lhRfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547884; c=relaxed/simple;
	bh=ho0cgeGuKVieGKvFsBHWQ128D7S38+qYmGO013D8/zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuP2iRSKubn/xXqa15QUgpuCCHzcfkj9IBfeEIQlq9+qY7qWi874aBwZmw21+iqJQkirHmsqHSQJbOmWtVYdZlM9FhR5E+JmNhLAq3SPASkqkK++KwCvS8K3zWZfs9z0uyapqaUmYhL41Sn0/PRXbe1BmALN1jQqIS1Vje0+EzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STdT2Amc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39ee57c0b8cso5316823f8f.0
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746547881; x=1747152681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bsmopngm2SLQ7W7DDO0tBHk4cgyWNfeMlB0+ANyvB+M=;
        b=STdT2AmcIoQjWLwJZAmS84immWcs3z5APwJyPMZkglKNQns5EK9FKYpbXxpvATKweu
         DgfGp7FSnim2t8RDHkzNrs3uFhpifbfJ05R6re+rNwu62o4vlL4cRC/l85chNO+41+1Q
         VgsOBbpTd/MgLzetJHYs4o/mgkFYiNI+GtiixKXbxNjGnSDIQ4FrTieYTwfrHriPMSoc
         Ao0c3PwV7ZCS7/LjLJrwzdpnfIonZTqtaKlBmV0RwzjvLBwMnOCRexfPN/PU34pmFBWI
         AYRNpa7Ys5Qan57lTZyXiFTScSC4285gqvdSFoybApeeWbx8DNk4dqvu6jCdcCmTAe7X
         9xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746547881; x=1747152681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bsmopngm2SLQ7W7DDO0tBHk4cgyWNfeMlB0+ANyvB+M=;
        b=Tt9VoKj6u7bTIGMP4H8VPOmIR/8ZQMh9qad3AItJzFxicv1CViQXCZUCgmaBfdtzbi
         b9YabvY8ZJnQD2m5XTDMaz7sDJrFbhGKQ3GtxHvuplaeNXnvB+dLARNTjyRGvmS0qbpl
         2XMdoxcjLtuQJxoOGCtuJS0Nnkcrt5UZ0XQFUFn0ptwdqH+nVWLJirQn3CGAgpjirLNV
         pGMJ3ycRk/8GyeiXUtgmKmXdbEWtiQ98J51GtvJDll7gfKKhL/Jtg2itnUQ1L2Fgmycp
         HMWQqosnZGNRu/p+2uj56m74EHsFjVkYA7hhqi0ogE2XhaR7m5cXxNtL8CWWKejBWoaM
         c72w==
X-Gm-Message-State: AOJu0YyUGcPuTfae3ZIWvPYy58lxe1YMA8SHtlHmCLHfrHBTr2JhE3g6
	HVVeTQaXSMqgXL2tESLhwWRp6nGW0PaXErCQmwE7vSCG9kQIRZOnqd4R8tk+06jkm5fgvVdD7ZN
	bdOgRdo8u5QVap+wx14yjOtq6BXo=
X-Gm-Gg: ASbGncs8OhnahElnerR+TTOqPqF3NpD9amypB/fHW41wMRRh/lKg/ldLhEwUKZoBqMM
	ILZNAzZTTgENNxB/C39nlj35aa0lAv0GHXsdKmZQF7YcbZB1l1JSgd4iJmIEfa/6pTvQVjmht1V
	vKBzBzdX28YARNQ98GsK+WqRSSQH/XFUhJG6AmOA==
X-Google-Smtp-Source: AGHT+IHzJvHpwpTe38dch8/4Mt8b1Rip2Zgm/TujI7PiV31GaTuXoVaqW7clnV8q5ATfTaBanGKM5D9wGFLs178SIaA=
X-Received: by 2002:a05:6000:420f:b0:391:4914:3c6a with SMTP id
 ffacd0b85a97d-3a0b49b2c01mr61009f8f.29.1746547880473; Tue, 06 May 2025
 09:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502190621.41549-1-mykyta.yatsenko5@gmail.com>
 <20250502190621.41549-4-mykyta.yatsenko5@gmail.com> <CAADnVQKLvOeN6sRctgna7BjU=3HeK+6Y1E-f1rmHEH7V8T00dw@mail.gmail.com>
 <e4555bd4-4830-4708-911e-e3cb48fa5815@gmail.com>
In-Reply-To: <e4555bd4-4830-4708-911e-e3cb48fa5815@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 May 2025 09:11:08 -0700
X-Gm-Features: ATxdqUFQjqotOkpUBfh_AQ-R3IVyXmk-roQcwMdqys573Lp5ZxCAFb9WTXTRV-c
Message-ID: <CAADnVQKMDw8F3Qv3OFSLNKWrN4djzpbD5C2WWzY2KHfbd0M+eQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: introduce tests for dynptr
 copy kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 6:32=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 02/05/2025 22:34, Alexei Starovoitov wrote:
> > On Fri, May 2, 2025 at 12:06=E2=80=AFPM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Introduce selftests verifying newly-added dynptr copy kfuncs.
> >> Covering contiguous and non-contiguous memory backed dynptrs.
> >>
> >> Disable test_probe_read_user_str_dynptr that triggers bug in
> >> strncpy_from_user_nofault. Patch to fix the issue [1].
> >>
> >> [1] https://patchwork.kernel.org/project/linux-mm/patch/20250422131449=
.57177-1-mykyta.yatsenko5@gmail.com/
> >>
> >> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   tools/testing/selftests/bpf/DENYLIST          |   1 +
> >>   .../testing/selftests/bpf/prog_tests/dynptr.c |  13 ++
> >>   .../selftests/bpf/progs/dynptr_success.c      | 201 ++++++++++++++++=
++
> >>   3 files changed, 215 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/bpf/DENYLIST b/tools/testing/self=
tests/bpf/DENYLIST
> >> index f748f2c33b22..1789a61d0a9b 100644
> >> --- a/tools/testing/selftests/bpf/DENYLIST
> >> +++ b/tools/testing/selftests/bpf/DENYLIST
> >> @@ -1,5 +1,6 @@
> >>   # TEMPORARY
> >>   # Alphabetical order
> >> +dynptr/test_probe_read_user_str_dynptr # disabled until https://patch=
work.kernel.org/project/linux-mm/patch/20250422131449.57177-1-mykyta.yatsen=
ko5@gmail.com/ makes it into the bpf-next
> >>   get_stack_raw_tp    # spams with kernel warnings until next bpf -> b=
pf-next merge
> >>   stacktrace_build_id
> >>   stacktrace_build_id_nmi
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/t=
esting/selftests/bpf/prog_tests/dynptr.c
> >> index e29cc16124c2..62e7ec775f24 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> >> @@ -33,10 +33,19 @@ static struct {
> >>          {"test_dynptr_skb_no_buff", SETUP_SKB_PROG},
> >>          {"test_dynptr_skb_strcmp", SETUP_SKB_PROG},
> >>          {"test_dynptr_skb_tp_btf", SETUP_SKB_PROG_TP},
> >> +       {"test_probe_read_user_dynptr", SETUP_XDP_PROG},
> >> +       {"test_probe_read_kernel_dynptr", SETUP_XDP_PROG},
> >> +       {"test_probe_read_user_str_dynptr", SETUP_XDP_PROG},
> >> +       {"test_probe_read_kernel_str_dynptr", SETUP_XDP_PROG},
> >> +       {"test_copy_from_user_dynptr", SETUP_SYSCALL_SLEEP},
> >> +       {"test_copy_from_user_str_dynptr", SETUP_SYSCALL_SLEEP},
> >> +       {"test_copy_from_user_task_dynptr", SETUP_SYSCALL_SLEEP},
> >> +       {"test_copy_from_user_task_str_dynptr", SETUP_SYSCALL_SLEEP},
> >>   };
> >>
> >>   static void verify_success(const char *prog_name, enum test_setup_ty=
pe setup_type)
> >>   {
> >> +       char user_data[384] =3D {[0 ... 382] =3D 'a', '\0'};
> >>          struct dynptr_success *skel;
> >>          struct bpf_program *prog;
> >>          struct bpf_link *link;
> >> @@ -58,6 +67,10 @@ static void verify_success(const char *prog_name, e=
num test_setup_type setup_typ
> >>          if (!ASSERT_OK(err, "dynptr_success__load"))
> >>                  goto cleanup;
> >>
> >> +       skel->bss->user_ptr =3D user_data;
> >> +       skel->data->test_len[0] =3D sizeof(user_data);
> >> +       memcpy(skel->bss->expected_str, user_data, sizeof(user_data));
> >> +
> >>          switch (setup_type) {
> >>          case SETUP_SYSCALL_SLEEP:
> >>                  link =3D bpf_program__attach(prog);
> >> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tool=
s/testing/selftests/bpf/progs/dynptr_success.c
> >> index e1fba28e4a86..753d35eb47d9 100644
> >> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> >> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> >> @@ -680,3 +680,204 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
> >>          bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
> >>          return XDP_DROP;
> >>   }
> >> +
> >> +void *user_ptr;
> >> +char expected_str[384]; /* Contains the copy of the data pointed by u=
ser_ptr */
> > what so magic about 384?
> It's MAX_BPF_STACK, but leaving some space for other things (temp buffer
> of this size is allocated on stack of each bpf prog)
> The reason to use large buffer, is because when kfunc implementation
> falls back onto copying data chunk by chunk, the length of
> chunk is 256 bytes, so I'm trying to force it copy more than 1 chunk.
> >> +__u32 test_len[7] =3D {0/* placeholder */, 0, 1, 2, 255, 256, 257};
> >> +
> >> +typedef int (*bpf_read_dynptr_fn_t)(struct bpf_dynptr *dptr, u32 off,
> >> +                                   u32 size, const void *unsafe_ptr);
> >> +
> >> +static __always_inline void test_dynptr_probe(void *ptr, bpf_read_dyn=
ptr_fn_t bpf_read_dynptr_fn)
> > More __always_inline in the prog too?
> > Why?
> This one is a little bit tricky:
> When removing always_inline, the generated bpf code does indirect call
> into bpf_read_dynptr_fn_t,
> which errors out with "unknown opcode 8d", when trying to load the progra=
m.
> An example of the generated code that fails to load:
>
> 89: 79 a5 58 fe 00 00 00 00 r5 =3D *(u64 *)(r10 - 0x1a8) 90: 8d 05 00 00
> 00 00 00 00 callx r5
>
> I could not find another way of fixing this, I'll appreciate any
> alternative.

So the always inline is to avoid indirect call?
That makes sense. Please add a comment.

>
> >> +{
> >> +       char buf[sizeof(expected_str)];
> >> +       struct bpf_dynptr ptr_buf;
> >> +       int i;
> >> +
> >> +       err =3D bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(buf), 0, &=
ptr_buf);
> >> +
> >> +       bpf_for(i, 0, ARRAY_SIZE(test_len)) {
> >> +               __u32 len =3D test_len[i];
> >> +
> >> +               err =3D err ?: bpf_read_dynptr_fn(&ptr_buf, 0, test_le=
n[i], ptr);
> >> +               if (len > sizeof(buf))
> >> +                       break;
> >> +               err =3D err ?: bpf_dynptr_read(&buf, len, &ptr_buf, 0,=
 0);
> >> +
> >> +               if (err || bpf_memcmp(expected_str, buf, len))
> >> +                       err =3D 1;
> >> +
> >> +               /* Reset buffer and dynptr */
> >> +               __builtin_memset(buf, 0, sizeof(buf));
> >> +               err =3D err ?: bpf_dynptr_write(&ptr_buf, 0, buf, len,=
 0);
> >> +       }
> >> +       bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
> >> +}
> >> +
> >> +static __always_inline void test_dynptr_probe_str(void *ptr,
> >> +                                                 bpf_read_dynptr_fn_t=
 bpf_read_dynptr_fn)
> >> +{
> >> +       char buf[sizeof(expected_str)];
> >> +       struct bpf_dynptr ptr_buf;
> >> +       __u32 cnt, i;
> >> +
> >> +       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(buf), 0, &ptr_buf)=
;
> >> +
> >> +       bpf_for(i, 0, ARRAY_SIZE(test_len)) {
> >> +               __u32 len =3D test_len[i];
> >> +
> >> +               cnt =3D bpf_read_dynptr_fn(&ptr_buf, 0, len, ptr);
> >> +               if (cnt !=3D len)
> >> +                       err =3D 1;
> >> +
> >> +               if (len > sizeof(buf))
> >> +                       continue;
> >> +               err =3D err ?: bpf_dynptr_read(&buf, len, &ptr_buf, 0,=
 0);
> >> +               if (!len)
> >> +                       continue;
> >> +               if (err || bpf_memcmp(expected_str, buf, len - 1) || b=
uf[len - 1] !=3D '\0')
> >> +                       err =3D 1;
> >> +       }
> >> +       bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
> >> +}
> >> +
> >> +static __always_inline void test_dynptr_probe_xdp(struct xdp_md *xdp,=
 void *ptr,
> >> +                                                 bpf_read_dynptr_fn_t=
 bpf_read_dynptr_fn)
> >> +{
> >> +       struct bpf_dynptr ptr_xdp;
> >> +       char buf[sizeof(expected_str)];
> >> +       __u32 off, i;
> >> +
> >> +       /* Set offset near the seam between buffers */
> >> +       off =3D 3500;
> > what is 3500 ?
> This is an offset into the xdp-backed dynptr that is close to the end of
> the first fragment.
> As far as I understand the size of the fragment is: `max_data_sz =3D 4096
> - headroom - tailroom;`,
> I found it in `bpf_prog_test_run_xdp()` from net/bpf/test_run.c. I'd
> like my writes to go into multiple
> fragments so that dynptr does not have a contiguous buffer of the
> requested size and chunking logic is hit.

That's far from obvious. A detailed comment is necessary.
Also, I recall, there were some patches to fix:
max_data_sz =3D 4096 - headroom - tailroom;
since it's wrong on archs with different page size.

Would be good to make it more robust.

