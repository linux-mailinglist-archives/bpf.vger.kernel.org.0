Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032894EE09F
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 20:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbiCaSgq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 14:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbiCaSgm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 14:36:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C4923407D
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 11:34:51 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f10so362778plr.6
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 11:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14dOC+2hDSS7RaMGjPKm6xBqm5db/f3zBL6/HyEWF0E=;
        b=j3DnHXNDEH+et+P6lJpnVl61llOUMFlRpHk7LBxMscFBXthhCfGm6VFNrockuE2hw5
         kLgV1Y8lGW7NE8qGuGhxEzgTVyFlc7yRAojNS1w0LxEYEgmRuu9YgcfWjoCXB1uAtZTF
         tS9oYGaXbXABBHwh2MlZRhEGg7cYUJ6SiKNSrNDXjMKlTbKKJ5uecz+1D66xvfzE6Avj
         nrLMxaeRUL3B6d3XVihLzDtbRNvtiGVfEJl+te1TRKzXctFyLR7AXa56CZkOA76otC8V
         QfeVVMNladyDcjcC/MKOz+3BRy1VEuCBA8D06aAW3VPuj6GLTLcpofEl5AM3Fw7JcZT6
         NAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14dOC+2hDSS7RaMGjPKm6xBqm5db/f3zBL6/HyEWF0E=;
        b=2EUoimgtu/SEGD5udrIx2eiLggGFqJEACSgBNsgOTubgYMhIz+S3VfVeJf2y8cWMoH
         v3V1LSy52tUKk46VuEvtQYG+ILutQwCkedVNhXmi1uPY+9kjmBB54syeJwMLFQJrekvC
         OTzec86Ssi6Yat585UlqKpzn0iF4RBa6/yTtNmsnEIHC6wP/NWUNluHTT3pJCF3DMtwk
         EDBbiOmLEo3TI8Vl33BhdLzQG/nTj/xf+CnFzfo4g6hcLApYwOwCt2qnyeVUI0+bO0qS
         GL2AQ/1uTXrWmeLvb2HLpM3K/GWUapP3dZF4EVvJOJPhkdnv1pIH9nRW7SOapubicu/n
         Sr7w==
X-Gm-Message-State: AOAM5302CqFQQ12MNsuSJRMQVCX32anwQKFMXkK8Khuy20JyRZ1IqZAo
        Ck8j4JuI8kwxZUpHUYzH48SnEAPJwsaLbKpJayY=
X-Google-Smtp-Source: ABdhPJz66lsLB0AChDoqTShGGzjP38e/APvraocJu6JfiHqb0ieDnJ487lxZhJQS7qxgrodVFcxbcHuhl6Ft2X8Ym2E=
X-Received: by 2002:a17:90b:3003:b0:1c9:9751:cf9c with SMTP id
 hg3-20020a17090b300300b001c99751cf9cmr7511810pjb.20.1648751690950; Thu, 31
 Mar 2022 11:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-2-andrii@kernel.org>
In-Reply-To: <20220325052941.3526715-2-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 31 Mar 2022 11:34:39 -0700
Message-ID: <CAADnVQLkYb6NiEq=bkP_AC4pj8OFC1achC8m9UdEhwWp4ahrFw@mail.gmail.com>
Subject: program local storage. Was: [PATCH bpf-next 1/7] libbpf: add BPF-side
 of USDT support
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 24, 2022 at 10:30 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> +
> +struct __bpf_usdt_arg_spec {
> +       __u64 val_off;
> +       enum __bpf_usdt_arg_type arg_type;
> +       short reg_off;
> +       bool arg_signed;
> +       char arg_bitshift;
> +};
> +
> +/* should match USDT_MAX_ARG_CNT in usdt.c exactly */
> +#define BPF_USDT_MAX_ARG_CNT 12
> +struct __bpf_usdt_spec {
> +       struct __bpf_usdt_arg_spec args[BPF_USDT_MAX_ARG_CNT];
> +       __u64 usdt_cookie;
> +       short arg_cnt;
> +};
> +
> +__weak struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, BPF_USDT_MAX_SPEC_CNT);
> +       __type(key, int);
> +       __type(value, struct __bpf_usdt_spec);
> +} __bpf_usdt_specs SEC(".maps");
> +
> +__weak struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(max_entries, BPF_USDT_MAX_IP_CNT);
> +       __type(key, long);
> +       __type(value, struct __bpf_usdt_spec);
> +} __bpf_usdt_specs_ip_to_id SEC(".maps");
...

> +
> +/* Fetch USDT argument *arg* (zero-indexed) and put its value into *res.
> + * Returns 0 on success; negative error, otherwise.
> + * On error *res is guaranteed to be set to zero.
> + */
> +__hidden __weak
> +int bpf_usdt_arg(struct pt_regs *ctx, int arg, long *res)
> +{
> +       struct __bpf_usdt_spec *spec;
> +       struct __bpf_usdt_arg_spec *arg_spec;
> +       unsigned long val;
> +       int err, spec_id;
> +
> +       *res = 0;
> +
> +       spec_id = __bpf_usdt_spec_id(ctx);
> +       if (spec_id < 0)
> +               return -ESRCH;
> +
> +       spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
> +       if (!spec)
> +               return -ESRCH;
> +
> +       if (arg >= spec->arg_cnt)
> +               return -ENOENT;
> +
> +       arg_spec = &spec->args[arg];
> +       switch (arg_spec->arg_type) {

Without bpf_cookie in the kernel each arg access is two lookups.
With bpf_cookie it's a single lookup in an array that is fast.
Multiply that cost by number of args.
Not a huge cost, but we can do better long term.

How about annotating bpf_cookie with PTR_TO_BTF_ID at prog load time.
So that bpf_get_attach_cookie() returns PTR_TO_BTF_ID instead of long.
This way bpf_get_attach_cookie() can return
"struct __bpf_usdt_spec *".

At attach time libbpf will provide populated 'struct __bpf_usdt_spec'
to the kernel and the kernel will copy the struct's data
in the bpf_link.
At detach time that memory is freed.

Advantages:
- saves an array lookup at runtime
- no need to provide size for __bpf_usdt_specs map.
  That map is no longer needed.
  users don't need to worry about maxing out BPF_USDT_MAX_SPEC_CNT.
- libbpf doesn't need to populate __bpf_usdt_specs map
  libbpf doesn't need to allocate spec_id-s.
  libbpf will keep struct __bpf_usdt_spec per uprobe and
  pass it to the kernel at attach time to store in bpf_link.

"cookie as ptr_to_btf_id" is a generic mechanism to provide a
blob of data to the bpf prog instead of a single "long".
That blob can be read/write too.
It can be used as per-program + per-attach point scratch area.
Similar to task/inode local storage...
That would be (prog, attach_point) local storage.

Thoughts?
