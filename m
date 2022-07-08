Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B887B56B886
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 13:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbiGHL23 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 07:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbiGHL22 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 07:28:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF595390
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 04:28:27 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id eq6so26477477edb.6
        for <bpf@vger.kernel.org>; Fri, 08 Jul 2022 04:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qfcra8dp/WqcWbHWPJN9873xIFza9RyRRhiMmAwAopU=;
        b=Fn+9vBmaTdOB/l+GFW5srXibpo3G4tscy6sdd9lfYos5V+X9Hj/ovlHItf+vj7Rmp8
         DnEOZfAVga1rEGujbDhoIyI85byHCfjjHdRbZXEzXDqW5wAMUyic3lbO70gmvjgQEw6I
         0g27Plns2f0CZhcvbLyz9CbY0+5+4NpvLCmAfOvCmcx+IADaSgBg9eZeGzfqY8rZ9l6V
         y3fwlQyl44auutMzMwW8kEyODmPcXec1+xreGf/ycML6qVEhFFNUW0vTbtxHvFwlNlhW
         eZf4/0SYin6zPyhpeCmHRtYIsXNXLX8QAaJQqgfetsvW2JEDYQO9WOmObmLijSH+eHSo
         BVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qfcra8dp/WqcWbHWPJN9873xIFza9RyRRhiMmAwAopU=;
        b=j6d0WmxXU688w/K5+B5m3XU8NEdL1CiEZwhgiP+P0OMYWa3Qx178+2O2p6mad4l+20
         8NQ5BHA4M4vQKwmmtmayvjZMbMD6HmRIB+vs/dlNwXvv0igrPDHXUjtAREqkh3eJ3m8I
         L91D8uZG2aIGrAau4h9yXNOMjCrFp7ODrbtE6WTXwDWcT/xIvKBdDwwzegaNbdNHeXU5
         GdpXjs9u/arktnaG/zzyRYhUCbwZre6DA2QQ0KvQIrrIEeUe3Gsga54pFTMWKIdWgCAf
         bI2BgWI/Rfc6JPEZtTjw9fWQh2EkSLBO71MD33399eh1KI2+08djEMbzjxiTqxJlhALZ
         G40w==
X-Gm-Message-State: AJIora/SYJxFhtuewqSCCTv3K+HBQd0Q0ZF9TMJeITjhBA066iLqDS3O
        LwXS0ScF5YB8GQL67+mhxxs=
X-Google-Smtp-Source: AGRyM1uYPdap8y6kRkdqzFyhmtuDTk9mtL7krNzC9dXyelZzmAelYZOP7PEHymbwA+uEm2s0vz8aZQ==
X-Received: by 2002:aa7:db09:0:b0:43a:7353:94a6 with SMTP id t9-20020aa7db09000000b0043a735394a6mr4139425eds.191.1657279706245;
        Fri, 08 Jul 2022 04:28:26 -0700 (PDT)
Received: from krava ([151.14.22.253])
        by smtp.gmail.com with ESMTPSA id lc3-20020a170906f90300b00705976bcd01sm20113322ejb.206.2022.07.08.04.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 04:28:25 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 8 Jul 2022 13:28:22 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Kenta Tada <kenta.tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/3] libbpf: add ksyscall/kretsyscall
 sections support for syscall kprobes
Message-ID: <YsgU1kjVndNjJhI8@krava>
References: <20220707004118.298323-1-andrii@kernel.org>
 <20220707004118.298323-3-andrii@kernel.org>
 <CAADnVQLxWDD3AAp73BcXW4ArWMgJ-fSUzSjw=-gzq=azBrXdqA@mail.gmail.com>
 <CAEf4BzaXBD86k8BYv7q4fFeyHALHcVUCbSpSG4=kfC0orydrCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaXBD86k8BYv7q4fFeyHALHcVUCbSpSG4=kfC0orydrCQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 07, 2022 at 12:10:30PM -0700, Andrii Nakryiko wrote:

SNIP

> > Maybe we should do the other way around ?
> > cat /proc/kallsyms |grep sys_bpf
> >
> > and figure out the prefix from there?
> > Then we won't need to do giant
> > #if defined(__x86_64__)
> > ...
> >
> 
> Unfortunately this won't work well due to compat and 32-bit APIs (and
> bpf() syscall is particularly bad with also bpf_sys_bpf):
> 
> $ sudo cat /proc/kallsyms| rg '_sys_bpf$'
> ffffffff811cb100 t __sys_bpf
> ffffffff811cd380 T bpf_sys_bpf
> ffffffff811cd520 T __x64_sys_bpf
> ffffffff811cd540 T __ia32_sys_bpf
> ffffffff8256fce0 r __ksymtab_bpf_sys_bpf
> ffffffff8259b5a2 r __kstrtabns_bpf_sys_bpf
> ffffffff8259bab9 r __kstrtab_bpf_sys_bpf
> ffffffff83abc400 t _eil_addr___ia32_sys_bpf
> ffffffff83abc410 t _eil_addr___x64_sys_bpf
> 
> $ sudo cat /proc/kallsyms| rg '_sys_mmap$'
> ffffffff81024480 T __x64_sys_mmap
> ffffffff810244c0 T __ia32_sys_mmap
> ffffffff83abae30 t _eil_addr___ia32_sys_mmap
> ffffffff83abae40 t _eil_addr___x64_sys_mmap
> 
> We have similar arch-specific switches in few other places (USDT and
> lib path detection, for example), so it's not a new precedent (for
> better or worse).
> 
> 
> > /proc/kallsyms has world read permissions:
> > proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
> > unlike available_filter_functions.
> >
> > Also tracefs might be mounted in a different dir than
> > /sys/kernel/tracing/
> > like
> > /sys/kernel/debug/tracing/
> 
> Yeah, good point, was trying to avoid parsing more expensive kallsyms,
> but given it's done once, it might not be a big deal.

we could get that also from BTF?

jirka
