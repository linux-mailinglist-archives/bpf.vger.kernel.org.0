Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7729B57112F
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 06:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiGLEUm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 00:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiGLEUc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 00:20:32 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008AF25EA9
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 21:20:28 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x184so6481124pfx.2
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 21:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1zoauR2Gtqa7nKs4wjLqYrbGgRyaMrXxmljClP4wqfU=;
        b=debU4YGnvKTJYmLsfM9NDjTmm0uONvfhbyMtiMz++8tBUrUwZpznOWW6pCzEdFC1hC
         IqUIykgOVOfa1MLL0BBZraJTOBpP46d2iksf6VNdQ8R1i2ndeIUmjcldKO4zzZ/jN6jf
         dpBJrrAJKhH4e6Ar59t5RAguJd42nbpc3OsxO2GvNmE11lJcwl0rF47TC+q4y7+Km+tx
         OIaONGH9b3F620fAllHrqzWkxWD1an5Evi/eUOfivzFEungQQtPbLoO/yDiLZIiw9r4n
         F+wZT6bUkn0shQyk3FGn/7hX8Kq1lFuR+rFXPK0PtV2j26o3nwcdmyOXoNsnf6NjyHVN
         NJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1zoauR2Gtqa7nKs4wjLqYrbGgRyaMrXxmljClP4wqfU=;
        b=BqhIG8T5WGS8MXim0qoAu7SDMRqDdh/W5yY6ag3bunNa3Vh6BrpsGVVwp/lAtz46f1
         M6u3mw8IR8KMAjxKIl2rGU1uQ428A8KFObpkEhBN9cf1pPNKeM9wEQvOJQXe9ES+ebxN
         h1iUuTzVOJ0EYp8YWXyYoHn88fttrtmtAt1ZxYY5RO/O8gutGkMdcLN5Q+tpUmsWInqW
         n3a/vvflzQ8QzT7cH48nZfgK/qEzgmuqS0vLOG0HOL5y9uBNxtR6f859cFCgx0AzMJoZ
         s/FeXJ3gqywQiKhN2Bl7imsWcpo0tUHPKUE4a5ysR8hB9gy72X4H19Vle8pmNC5l831Q
         YTvA==
X-Gm-Message-State: AJIora9HTjuz5Dp0Ym876pdrzEV8DTIVq4yTLu3DdxfbDZMVZ6bHC/0I
        JKwpwxztUkvDzUo+mMp9yTgZt+uavw0=
X-Google-Smtp-Source: AGRyM1v2L76Pgz4Pe2E9tZximfSljd5tTJYN2BoEETPmX6q0WKHPDfVtDQh+Wx/oSZka3zOnAc0ZRg==
X-Received: by 2002:aa7:958d:0:b0:52a:c4d1:2e59 with SMTP id z13-20020aa7958d000000b0052ac4d12e59mr12260730pfj.85.1657599628360;
        Mon, 11 Jul 2022 21:20:28 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:c47b])
        by smtp.gmail.com with ESMTPSA id rt5-20020a17090b508500b001ef8ac4c681sm7966699pjb.0.2022.07.11.21.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 21:20:27 -0700 (PDT)
Date:   Mon, 11 Jul 2022 21:20:25 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Kenta Tada <kenta.tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/3] libbpf: add ksyscall/kretsyscall
 sections support for syscall kprobes
Message-ID: <20220712042025.ku6mxlhk3itthzvf@macbook-pro-3.dhcp.thefacebook.com>
References: <20220707004118.298323-1-andrii@kernel.org>
 <20220707004118.298323-3-andrii@kernel.org>
 <CAADnVQLxWDD3AAp73BcXW4ArWMgJ-fSUzSjw=-gzq=azBrXdqA@mail.gmail.com>
 <CAEf4BzaXBD86k8BYv7q4fFeyHALHcVUCbSpSG4=kfC0orydrCQ@mail.gmail.com>
 <YsgU1kjVndNjJhI8@krava>
 <CAEf4BzapNiTTV18guaXz_e1nY9jbybZVTWXUM7sPNqJd=Cau+w@mail.gmail.com>
 <CAADnVQLeEz8NLf9b4reOKdyrtneHcv4ExSGn7Z8ysk1nYSayYw@mail.gmail.com>
 <CAEf4BzYKkf0A1LqLqbjUqO6CMWDRVqg9OBizfwuZL-0p4ioRJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYKkf0A1LqLqbjUqO6CMWDRVqg9OBizfwuZL-0p4ioRJg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 11, 2022 at 09:28:29AM -0700, Andrii Nakryiko wrote:
> On Sat, Jul 9, 2022 at 5:38 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jul 8, 2022 at 3:05 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Jul 8, 2022 at 4:28 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Thu, Jul 07, 2022 at 12:10:30PM -0700, Andrii Nakryiko wrote:
> > > >
> > > > SNIP
> > > >
> > > > > > Maybe we should do the other way around ?
> > > > > > cat /proc/kallsyms |grep sys_bpf
> > > > > >
> > > > > > and figure out the prefix from there?
> > > > > > Then we won't need to do giant
> > > > > > #if defined(__x86_64__)
> > > > > > ...
> > > > > >
> > > > >
> > > > > Unfortunately this won't work well due to compat and 32-bit APIs (and
> > > > > bpf() syscall is particularly bad with also bpf_sys_bpf):
> > > > >
> > > > > $ sudo cat /proc/kallsyms| rg '_sys_bpf$'
> > > > > ffffffff811cb100 t __sys_bpf
> > > > > ffffffff811cd380 T bpf_sys_bpf
> > > > > ffffffff811cd520 T __x64_sys_bpf
> > > > > ffffffff811cd540 T __ia32_sys_bpf
> > > > > ffffffff8256fce0 r __ksymtab_bpf_sys_bpf
> > > > > ffffffff8259b5a2 r __kstrtabns_bpf_sys_bpf
> > > > > ffffffff8259bab9 r __kstrtab_bpf_sys_bpf
> > > > > ffffffff83abc400 t _eil_addr___ia32_sys_bpf
> > > > > ffffffff83abc410 t _eil_addr___x64_sys_bpf
> > > > >
> > > > > $ sudo cat /proc/kallsyms| rg '_sys_mmap$'
> > > > > ffffffff81024480 T __x64_sys_mmap
> > > > > ffffffff810244c0 T __ia32_sys_mmap
> > > > > ffffffff83abae30 t _eil_addr___ia32_sys_mmap
> > > > > ffffffff83abae40 t _eil_addr___x64_sys_mmap
> > > > >
> > > > > We have similar arch-specific switches in few other places (USDT and
> > > > > lib path detection, for example), so it's not a new precedent (for
> > > > > better or worse).
> > > > >
> > > > >
> > > > > > /proc/kallsyms has world read permissions:
> > > > > > proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
> > > > > > unlike available_filter_functions.
> > > > > >
> > > > > > Also tracefs might be mounted in a different dir than
> > > > > > /sys/kernel/tracing/
> > > > > > like
> > > > > > /sys/kernel/debug/tracing/
> > > > >
> > > > > Yeah, good point, was trying to avoid parsing more expensive kallsyms,
> > > > > but given it's done once, it might not be a big deal.
> > > >
> > > > we could get that also from BTF?
> > >
> > > I'd rather not add dependency on BTF for this.
> >
> > A weird and non technical reason.
> > Care to explain this odd excuse?
> 
> Quite technical reason: minimizing unrelated dependencies. It's not
> necessary to have vmlinux BTF to use kprobes (especially for kprobing
> syscalls), so adding dependency on vmlinux BTF just to use
> SEC("ksyscall") seems completely unnecessary, given we have other
> alternatives.

If BTF and kallsyms were alternatives then it indeed would make
sense to avoid implement different schemes for old kernels and recent.
But libbpf already loads vmlinux BTF for other reasons.
It caches it and search in it is fast.
While libbpf also parses kallsyms it doesn't cache it.
Yet another search through kallsyms will slow down libbpf loading,
while another search in cached BTF is close to be free.
Also we have bpf_btf_find_by_name_kind() in-kernel helper.
We can prog_run it and optimize libbpf's BTF search to be even faster.
