Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C975F6531
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 13:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJFL1R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 07:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJFL1Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 07:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83357792DD
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 04:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665055633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gMCO/uEMuqJXUZN55pTZQ9w9DrFg+P+luT3dWud/OsA=;
        b=Bf3CPCN7d8f7pTZ1cpm4tXhTP8URAPcZIoglpFSLAgUass2pgQjKwkP3x0sjsk9qkF42ve
        /Y3C16GA146wlbqoPXAFcVcCmBeaXXA7mFGwzXJ1u9fbzGBBBSkQ/HsZucpuhFFySY7wzg
        3MEGjbmp999zrRW4XbZCwWnvvtS4Wg4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-495-PcRR_claN0yYdcdWcjsiWQ-1; Thu, 06 Oct 2022 07:27:12 -0400
X-MC-Unique: PcRR_claN0yYdcdWcjsiWQ-1
Received: by mail-ed1-f69.google.com with SMTP id s17-20020a056402521100b004511c8d59e3so1348100edd.11
        for <bpf@vger.kernel.org>; Thu, 06 Oct 2022 04:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMCO/uEMuqJXUZN55pTZQ9w9DrFg+P+luT3dWud/OsA=;
        b=5wmBLbRkQfzzhEY4nw+ZEHlEhyd6uHbXqYhxazBkTTHbkv8gzXprUfkqZ/BazPJSNG
         DBJzV8/tYkrk9lvhp3rf5NzV88HbfbTA/XkBm534H0Miuanii/QDwdw8hLPLftN6dUTn
         zDH8ls+S//YtQ/H9K5T/gE+kfSi69sWmfSQ+qALvSqik0TpUII8bhS6brsmrPdfyidzi
         65Hwsy/MrT7ajqChJFrXmdJt0eREouuHKbz7DW+1fTVL+UOoR8mxySZvCtN0MHK9JaD+
         y1RXtTpJau3FaMEZABFipJxq8VmN6gGSm8DthWgRds7lIhvfRdTkS7W9EOKg/HVmpdbR
         j8Jw==
X-Gm-Message-State: ACrzQf0Itplebu/qVOCQv8u3F3mLyEKagSATD1YmpvCJlSdKP34FOJVR
        0prT4aPPeHk3Ia31f4qnndgsw+vCV+lY1IvuvGJG60WUnwH5DBgdWFfYseb+aRhkm+671HVOiNe
        LaKwIgQYLL6Dg
X-Received: by 2002:a17:907:a407:b0:783:5465:902 with SMTP id sg7-20020a170907a40700b0078354650902mr3560126ejc.35.1665055628230;
        Thu, 06 Oct 2022 04:27:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5QMwa1Dsn1Cmf2fD3m1f+JpVvyEYs3GUyxYIJQxwiKDXlj2eOqZBCHAHTnsLKkMv3NhQrhng==
X-Received: by 2002:a17:907:a407:b0:783:5465:902 with SMTP id sg7-20020a170907a40700b0078354650902mr3560025ejc.35.1665055626063;
        Thu, 06 Oct 2022 04:27:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id vv3-20020a170907a68300b0077ab3ca93efsm9985858ejc.223.2022.10.06.04.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 04:27:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A0DD964ECA0; Thu,  6 Oct 2022 13:27:04 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com,
        Quentin Monnet <quentin@isovalent.com>,
        Andrea Terzolo <andrea.terzolo@polito.it>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: explicitly define BPF_FUNC_xxx
 integer values
In-Reply-To: <20221006042452.2089843-1-andrii@kernel.org>
References: <20221006042452.2089843-1-andrii@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 06 Oct 2022 13:27:04 +0200
Message-ID: <87bkqpfb07.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii@kernel.org> writes:

> Historically enum bpf_func_id's BPF_FUNC_xxx enumerators relied on
> implicit sequential values being assigned by compiler. This is
> convenient, as new BPF helpers are always added at the very end, but it
> also has its downsides, some of them being:
>
>   - with over 200 helpers now it's very hard to know what's each helper's=
 ID,
>     which is often important to know when working with BPF assembly (e.g.,
>     by dumping raw bpf assembly instructions with llvm-objdump -d
>     command). it's possible to work around this by looking into vmlinux.h,
>     dumping /sys/btf/kernel/vmlinux, looking at libbpf-provided
>     bpf_helper_defs.h, etc. But it always feels like an unnecessary step
>     and one should be able to quickly figure this out from UAPI header.
>
>   - when backporting and cherry-picking only some BPF helpers onto older
>     kernels it's important to be able to skip some enum values for helpers
>     that weren't backported, but preserve absolute integer IDs to keep BPF
>     helper IDs stable so that BPF programs stay portable across upstream
>     and backported kernels.
>
> While neither problem is insurmountable, they come up frequently enough
> and are annoying enough to warrant improving the situation. And for the
> backporting the problem can easily go unnoticed for a while, especially
> if backport is done with people not very familiar with BPF subsystem over=
all.
>
> Anyways, it's easy to fix this by making sure that __BPF_FUNC_MAPPER
> macro provides explicit helper IDs. Unfortunately that would potentially
> break existing users that use UAPI-exposed __BPF_FUNC_MAPPER and are
> expected to pass macro that accepts only symbolic helper identifier
> (e.g., map_lookup_elem for bpf_map_lookup_elem() helper).
>
> As such, we need to introduce a new macro (___BPF_FUNC_MAPPER) which
> would specify both identifier and integer ID, but in such a way as to
> allow existing __BPF_FUNC_MAPPER be expressed in terms of new
> ___BPF_FUNC_MAPPER macro. And that's what this patch is doing. To avoid
> duplication and allow __BPF_FUNC_MAPPER stay *exactly* the same,
> ___BPF_FUNC_MAPPER accepts arbitrary "context" arguments, which can be
> used to pass any extra macros, arguments, and whatnot. In our case we
> use this to pass original user-provided macro that expects single
> argument and __BPF_FUNC_MAPPER is using it's own three-argument
> __BPF_FUNC_MAPPER_APPLY intermediate macro to impedance-match new and
> old "callback" macros.
>
> Once we resolve this, we use new ___BPF_FUNC_MAPPER to define enum
> bpf_func_id with explicit values. The other users of __BPF_FUNC_MAPPER
> in kernel (namely in kernel/bpf/disasm.c) are kept exactly the same both
> as demonstration that backwards compat works, but also to avoid
> unnecessary code churn.
>
> Note that new ___BPF_FUNC_MAPPER() doesn't forcefully insert comma
> between values, as that might not be appropriate in all possible cases
> where ___BPF_FUNC_MAPPER might be used by users. This doesn't reduce
> usability, as it's trivial to insert that comma inside "callback" macro.
>
> To validate all the manually specified IDs are exactly right, we used
> BTF to compare before and after values:
>
>   $ bpftool btf dump file ~/linux-build/default/vmlinux | rg bpf_func_id =
-A 211 > after.txt
>   $ git stash # stach UAPI changes
>   $ make -j90
>   ... re-building kernel without UAPI changes ...
>   $ bpftool btf dump file ~/linux-build/default/vmlinux | rg bpf_func_id =
-A 211 > before.txt
>   $ diff -u before.txt after.txt
>   --- before.txt  2022-10-05 10:48:18.119195916 -0700
>   +++ after.txt   2022-10-05 10:46:49.446615025 -0700
>   @@ -1,4 +1,4 @@
>   -[14576] ENUM 'bpf_func_id' encoding=3DUNSIGNED size=3D4 vlen=3D211
>   +[9560] ENUM 'bpf_func_id' encoding=3DUNSIGNED size=3D4 vlen=3D211
>           'BPF_FUNC_unspec' val=3D0
>           'BPF_FUNC_map_lookup_elem' val=3D1
>           'BPF_FUNC_map_update_elem' val=3D2
>
> As can be seen from diff above, the only thing that changed was resulting=
 BTF
> type ID of ENUM bpf_func_id, not any of the enumerators, their names or i=
nteger
> values.
>
> The only other place that needed fixing was scripts/bpf_doc.py used to ge=
nerate
> man pages and bpf_helper_defs.h header for libbpf and selftests. That scr=
ipt is
> tightly-coupled to exact shape of ___BPF_FUNC_MAPPER macro definition, so=
 had
> to be trivially adapted.
>
> Cc: Quentin Monnet <quentin@isovalent.com>
> Reported-by: Andrea Terzolo <andrea.terzolo@polito.it>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Nice! Thanks for fixing this!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

