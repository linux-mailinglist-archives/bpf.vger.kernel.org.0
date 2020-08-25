Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718E5252367
	for <lists+bpf@lfdr.de>; Wed, 26 Aug 2020 00:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHYWNS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Aug 2020 18:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHYWNR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Aug 2020 18:13:17 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33406C061574;
        Tue, 25 Aug 2020 15:13:15 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w25so28624ljo.12;
        Tue, 25 Aug 2020 15:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HhJsKBW02BtS7ow2CWHt5zwUeBTuEgT+ywQPrRSabdI=;
        b=YtIqtANnDHeWhG7NcT0yReoTOgBY4QboTpun67yZZHj9DyZHtMHpeAtWAPsc/DoMFx
         7DSRf3AyaoCF+vLJ+iZGSE7UqoF1/26kmRJPkTru5oQ2J3Ydb1kErHH5tBOf8E4rLlnf
         bREUQwadn7XR3FTbFjMF/eUo6YHJwC6DIoJ+0oJZ2Wc4rwZWAMa8AUTGQqvf2FNvEYte
         Xb0kyIqdBqhp9OnierClYc10HO4XWvYjqncixoRV/5YnwNKsrXa1TBBuVGQIQQ1sJBLq
         +TnrM8eIufvT+F9YJs3wkH2YLjQVg/RKO5LBzT+6D6sLkFA36T4TJEN4PQDVKwcJrcyP
         IW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhJsKBW02BtS7ow2CWHt5zwUeBTuEgT+ywQPrRSabdI=;
        b=c2h+x04OOlht3Y7BjVU/9XTmIGraLcRyc1P5C42OTLKG6wMUQ2JnCBie+DFEb79c1+
         lsakFrr3q1xl/a21W2l1/yMD7Dff0dKoAqUKRDq5eiNqqOCZeEGyZONCu3cfczTgRYTn
         QR4zPTx8eKFltw1lXKCIlZZ+KZCQF/bQ0Gn39ser42vdSf7lhuH3I/FsbnLCoqWA/7tq
         cTWshF7Ez9Wa4HajjLLAVCPjqLCJWQViNQocKlHVtM89CxYsJIGKpD8t/o5a+mLrAXLW
         ZrbSNUEbxRutJA2Qk5GQ+i7K7ZPfKmp9lAXaaSm8+7L4rxzpjNWM73htcZnzU4ZDAqOu
         6rYg==
X-Gm-Message-State: AOAM530nkN8isI6kFQ1pvvodgY3cgN4pqzZjAc/JlimUH/xjZci3qahO
        h0/bT/u06HMFwYXLftXYpvvBFkoggte/99gdiHw=
X-Google-Smtp-Source: ABdhPJzz2wF45wgf/FXw/JhSJGsQdVgdCOrsFVQh5ecXi7Q0ljP46EcESueuQP9ZLOVOkt2NOX+z6IHI8EEFINShqYg=
X-Received: by 2002:a2e:4e09:: with SMTP id c9mr5968600ljb.283.1598393593961;
 Tue, 25 Aug 2020 15:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200825182919.1118197-1-kpsingh@chromium.org> <CAADnVQJG+vMTyuNGjWTYnWX11ZqJU-EE30UC5KPJtpv1MC78cw@mail.gmail.com>
In-Reply-To: <CAADnVQJG+vMTyuNGjWTYnWX11ZqJU-EE30UC5KPJtpv1MC78cw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 25 Aug 2020 15:13:02 -0700
Message-ID: <CAADnVQK0sKWa-XMUR9y28KEqMCOQhnRcAu=MDv4rU8iPwLBW1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 0/7] Generalizing bpf_local_storage
To:     KP Singh <kpsingh@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 25, 2020 at 2:05 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 25, 2020 at 11:29 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > # v9 -> v10
> >
> > - Added NULL check for inode_storage_ptr before calling
> >   bpf_local_storage_update
> > - Removed an extraneous include
> > - Rebased and added Acks / Signoff.
>
> Hmm. Though it looks good I cannot apply it, because
> test_progs -t map_ptr
> is broken:
> 2225: (18) r2 = 0xffffc900004e5004
> 2227: (b4) w1 = 58
> 2228: (63) *(u32 *)(r2 +0) = r1
>  R0=map_value(id=0,off=0,ks=4,vs=4,imm=0) R1_w=inv58
> R2_w=map_value(id=0,off=4,ks=4,vs=8,imm=0) R3=inv49 R4=inv63
> R5=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6_w=inv0
> R7=invP8 R8=map_ptr(id=0,off=0,ks=4,vs=4,imm=0) R10=?
> ; VERIFY_TYPE(BPF_MAP_TYPE_SK_STORAGE, check_sk_storage);
> 2229: (18) r1 = 0xffffc900004e5000
> 2231: (b4) w3 = 24
> 2232: (63) *(u32 *)(r1 +0) = r3
>  R0=map_value(id=0,off=0,ks=4,vs=4,imm=0)
> R1_w=map_value(id=0,off=0,ks=4,vs=8,imm=0)
> R2_w=map_value(id=0,off=4,ks=4,vs=8,imm=0) R3_w=inv24 R4=inv63
> R5=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6_w=inv0
> R7=invP8 R8=map_pt?
> 2233: (18) r3 = 0xffff8881f03f7000
> ; VERIFY(indirect->map_type == direct->map_type);
> 2235: (85) call unknown#195896080
> invalid func unknown#195896080
> processed 4678 insns (limit 1000000) max_states_per_insn 9
> total_states 240 peak_states 178 mark_read 11
>
> libbpf: -- END LOG --
> libbpf: failed to load program 'cgroup_skb/egress'
> libbpf: failed to load object 'map_ptr_kern'
> libbpf: failed to load BPF skeleton 'map_ptr_kern': -4007
> test_map_ptr:FAIL:skel_open_load open_load failed
> #43 map_ptr:FAIL
>
> Above 'invalid func unknown#195896080' happens
> when libbpf fails to do a relocation at runtime.
> Please debug.
> It's certainly caused by this set, but not sure why.

So I've ended up bisecting and debugging it.
It turned out that the patch 1 was responsible.
I've added the following hunk to fix it:
diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index 473665cac67e..982a2d8aa844 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -589,7 +589,7 @@ static inline int check_stack(void)
        return 1;
 }

-struct bpf_sk_storage_map {
+struct bpf_local_storage_map {
        struct bpf_map map;
 } __attribute__((preserve_access_index));

@@ -602,8 +602,8 @@ struct {

 static inline int check_sk_storage(void)
 {
-       struct bpf_sk_storage_map *sk_storage =
-               (struct bpf_sk_storage_map *)&m_sk_storage;
+       struct bpf_local_storage_map *sk_storage =
+               (struct bpf_local_storage_map *)&m_sk_storage;
        struct bpf_map *map = (struct bpf_map *)&m_sk_storage;

and pushed the whole set.
In the future please always run test_progs and test_progs-no_alu32
for every patch and submit patches only if _all_ tests are passing.
Do not assume that your change is not responsible for breakage.
