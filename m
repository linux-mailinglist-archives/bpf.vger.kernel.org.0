Return-Path: <bpf+bounces-48026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6321EA032C0
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828911885AF5
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3391E1A33;
	Mon,  6 Jan 2025 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCd7Mmdv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7B51E0DF5
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202755; cv=none; b=hdQtX/iMWdy2OQN9Kyw14DTnrdbX0vzigAl6YVROmY3w1CAv8h74KcvKpMNqgKCVe2lbq7D03HPf9rwhmSxtY5iWYbk4/kmi2aogrEvJIxZm4AF45uRCG6Hd9JIJbqY+h2X1pQvti9otZjIapjYTVjAj8GDkjkFMDxJo3gX7vpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202755; c=relaxed/simple;
	bh=bBZ02WLOV6FPVTpBR01/YctRD9UEltrPh2JpQHbzCyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q33slgtmcy03MgJ+vZ4NueGB58DPzcl/IVPg/OfCTVxVa4QzerI9WuaeAmWQxAtDkhB/IZ0HteQBXe6PmOfkszpZ6/DravpYVLlHAYfpkXJnjQWY+6log/lsrr1tDr1qp0NY90sBJj8ESr46oXMq8YOXnoRfB3AU8L35Y6vUs90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCd7Mmdv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso16581496a91.2
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 14:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736202753; x=1736807553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=46828HyR13kjMy3nm4B22t8eNrftDnPJxyShyK2FF2A=;
        b=SCd7MmdvrU2/8V9cQ7P1+oByd1BiMwouzcyM+BMuIZ2azqewPoOlX8rsYmFvEl/fEw
         zd3rltwvs3BWJJVtip/5WbH2meLtPy8/ZQBi/wvTV+bn6gEsXhR6SegF5fxOIyK2uqtE
         3k34SiV84P267ynhjYboKTlbnENHCB65X//NBQFC9o98bznx/DBpA1POz4goYQ5olYPF
         DxFtf9Pgrot9IzhTYU9gSnkNOd8328tE2A2eIsN5aYs9+pOYxvuGECPwkcL6zOWAmRw/
         xggLpj2mbFaBdNphRFo/5sOCv/cLf++kQ17i8Zp98uug2S9pSLs1gcg8qdMUxUOy0l1E
         5iMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736202753; x=1736807553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46828HyR13kjMy3nm4B22t8eNrftDnPJxyShyK2FF2A=;
        b=FQGP6XVUbBmpMQLc75eT1mlgbiw9E80gr0IRDYn3F6w2tpd1YnE2Xau9iiN5ks/4YS
         dJu9606F+JK3vPPXwVRsuVLMmajfI3ue0ksqolCvFNI0v5nT68ELAdH7TkBPg2N2c5in
         5RYwb3OKpIW9UeiADTBUVSp3TMpKFPGdmKipK/AFdK3VxXeed1Spk6IpcItMWmFT6JN1
         mtPRC/0J5zNEZuVVR3ZN0AZ3TnjHtZaAElS8SLY1lty1VEsrEPKXKozSV17Q6XoiD+F2
         hMiBzybS5trUn5+aqws4L1Grv7lzt4EM/VxSbTSYP+KbrGZbzrPC3gVI4X4nPNJNyu67
         f0Hw==
X-Gm-Message-State: AOJu0YwbVNjs1dTfXkUxitIbosv7pqKJr+h1roLjIQS85uVqI29ImoYE
	4+8L7hOQ20tM9H+NuYvRokHzhBQyBo3CbVCRJYWTixYUCbC+o014VtjgE8jg3x5H/TxwEV517Nx
	/pJCQFa3266l4MQh7MY6KVOH1Kgg=
X-Gm-Gg: ASbGncuq0tDjDoOIFkv9MbOmIw+SNpuI8eooQaiZrfN2zAXwdIB3vU1gR+g49ZCNZIN
	UQzp0rae56bJweLOv6B41+muJnFdEoqVuUYeuwQ==
X-Google-Smtp-Source: AGHT+IGla2xjA5nfHcW4o2JFkSx4YmJFuGYo5ANgfpJDLr/g/l1ouu+aArEgDJK3fjYvw3TawtZ9ujGk3IqaYri8ZjE=
X-Received: by 2002:a17:90b:2dc2:b0:2ee:acb4:fecd with SMTP id
 98e67ed59e1d1-2f452e044damr89602655a91.9.1736202753362; Mon, 06 Jan 2025
 14:32:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGQdkDt9zyQwr5JyftXqL=OLKscNcqUtEteY4hvOkx2S4GdEkQ@mail.gmail.com>
 <d58e28b03ecee04dba5c16c588330741c255cc0c.camel@gmail.com>
In-Reply-To: <d58e28b03ecee04dba5c16c588330741c255cc0c.camel@gmail.com>
From: andrea terzolo <andreaterzolo3@gmail.com>
Date: Mon, 6 Jan 2025 23:32:22 +0100
Message-ID: <CAGQdkDv6nMs-9Jzf6+R=c9d7ApP3pc3Y9ucN15C+ofRm1vWKkg@mail.gmail.com>
Subject: Re: [QUESTION] Check bpf_loop support on kernels < 5.13
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for the detailed explanation!
One alternative could be to use two different eBPF programs, one with
bpf_loop and the other with a simple loop, but I was looking for
possible alternatives. I tried using a const variable.
eBPF side:
```
volatile const int has_bpf_loop = 0;

static int loop_cb(int i, void *ctx) {
  return 0;
}

SEC("raw_tp")
int test_prog(void *ctx) {
  if (has_bpf_loop == 1) {
    bpf_loop(10, loop_cb, NULL, 0);
  } else {
    for (int i = 0; i < 10; ++i)
      loop_cb(i, NULL);
  }
  return 0;
}
```

Userspace side:
```
...
  if (libbpf_probe_bpf_helper(BPF_PROG_TYPE_RAW_TRACEPOINT,
BPF_FUNC_loop, NULL) == 1) {
    skel->rodata->has_bpf_loop = 1;
  } else {
    skel->rodata->has_bpf_loop = 0;
  }
...
```

But I ended up with the same error as before
```
libbpf: prog 'test_prog': BPF program load failed: Invalid argument
libbpf: prog 'test_prog': -- BEGIN PROG LOAD LOG --
number of funcs in func_info doesn't match number of subprogs
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'test_prog': failed to load: -22
```

I will try to dig a little bit more into it but I'm not sure we can
avoid using 2 different ebpf programs. Even if we were able to
overcome this error I suspect that the verifier will reject the
program when we try to load into r2 the pointer to `loop_cp` as you
correctly highlighted.

On Fri, 3 Jan 2025 at 21:31, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Fri, 2025-01-03 at 12:03 +0100, andrea terzolo wrote:
> > Hi folks! I would like to check with you if the verifier failure I'm
> > facing is expected. The verifier rejects the following eBPF program on
> > kernel 5.10.232.
> >
> > ```
> > static long loop_fn(uint32_t index, void *ctx) {
> >   bpf_printk("handle_exit\n");
> >   return 0;
> > }
> >
> > SEC("tp/raw_syscalls/sys_enter")
> > int test(void *ctx) {
> >   if (bpf_core_enum_value_exists(enum bpf_func_id, BPF_FUNC_loop)) {
> >     bpf_printk("loop\n");
> >     bpf_loop(12, loop_fn, NULL, 0);
> >   } else {
> >     bpf_printk("skip loop\n");
> >   }
> >   return 0;
> > }
> > ```
> >
> > With this error:
> >
> > ```
> > libbpf: prog 'test': BPF program load failed: Invalid argument
> > libbpf: prog 'test': -- BEGIN PROG LOAD LOG --
> > number of funcs in func_info doesn't match number of subprogs
> > processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > peak_states 0 mark_read 0
> > -- END PROG LOAD LOG --
> > libbpf: prog 'test': failed to load: -22
> > ```
> >
> > This sounds like a valid use case. I would like to use bpf_loop if
> > supported by the running kernel otherwise I can fall back to a simple
> > loop. This issue goes away on kernel 5.13 with the introduction of
> > PTR_TO_FUNC [0]. Is there a way I can use CO-RE features to avoid this
> > issue? I would expect the verifier to prune the dead code inside the
> > `if` but the error seems to be triggered before the control flow
> > analysis.
> >
> > [0]: https://github.com/torvalds/linux/commit/69c087ba6225b574afb6e505b72cb75242a3d844
>
> bpf_loop was introduced by commit [1] and released as a part of 5.17.
>
> The error you see is indeed caused by the lack of PTR_TO_FUNC register
> type in an old kernel. In your program the call to bpf_loop would look
> like below in the assembly:
>
>   ...
>   r2 = loop_fn  ;; here function pointer is taken
>   ...
>   call bpf_loop
>
> Before main verification pass verifier.c:add_subprog_and_kfunc()
> discovers subprogram entries by looking at function calls and function
> pointer assignments and compares it to function information provided
> via bpf_attr->func_info. The kernel that does not know about
> PTR_TO_FUNC would not find the loop_fn entry, hence the error message
> about mismatch.
>
> Additionally, verifier.c:check_cfg() looks for parts of the program
> that can't be reached by jump and call instructions. For this purpose
> pointers to functions are treated as function calls. The kernel that
> does not know about PTR_TO_FUNC it would seem that loop_fn is unreachable,
> this would cause another error message.
>
> Even if you add a dummy call to loop_fn verifier would most likely
> reject the program at 'r2 = loop_fn'.
>
> The approach libbpf uses to detect running kernel features is based on
> programs accept/reject status [2]. E.g. your program could be simplified to:
>
>   static int loop_fn(int i, void *c) { return 0; }
>
>   SEC("tp/raw_syscalls/sys_enter")
>   int test(void *ctx) {
>     bpf_loop(1, loop_fn, NULL, 0);
>     return 0;
>   }
>
> And checked if load is successful.
>
> [1] e6f2dd0f8067 ("bpf: Add bpf_loop helper")
> [2] see <kernel>/tools/lib/bpf/features.c
>

