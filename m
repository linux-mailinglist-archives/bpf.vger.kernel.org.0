Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B81D47980B
	for <lists+bpf@lfdr.de>; Sat, 18 Dec 2021 02:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhLRBoP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 20:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhLRBoP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Dec 2021 20:44:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695FEC061574
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 17:44:15 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so4434204pjq.4
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 17:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fSHRWeCblGYobnhDMs41erQYGXWVDLZ4Kl0P4n8z1Y8=;
        b=MHMl3CYqeXruvE6vNjptA8+NbPZjOM6s351hMqhTl/0CzX6tjTGENw6NkT01/Yum0V
         G1TAiT5+qL5qyfcUb2KRkbXYi7VL8xeG9qSFRdXydktARIw918wdlLoGM55irc7V3AwQ
         4VwKuhaVbTBsETp1+/AXv3ChkUWpszfYst95Mx3Z1HFKZ/5G2BcLqtSsd5pF9YcqJqLG
         WbSNu+H04XzWgZvX2g98Rueod1WcThYLRhcukTWJxCtPLN5qANmdUxS0Jxfyng+ypsn1
         qFHnMU9TZOm0YaR9TnN8NRCb7RlwxmydTCZRD/to6sk7KS/6UP/4cIcXZSnCDUPMvt7W
         tQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fSHRWeCblGYobnhDMs41erQYGXWVDLZ4Kl0P4n8z1Y8=;
        b=ytYwQCUf27aK8Iv37ioTFFD2RsqwZpHG3XCYvk8lO0yB/CQbT7CiY4XgVtK3i8Ja9y
         HcDGvWQnqH35Yl+Vgzjf+V0Z1l2cUn3inLRP8EfyjRKThg6olr8k2jGNS7xz0uwkOD46
         Z5RumahblHdld2IBaxRJOcL0GDD31Jy2XM8aUTHJJK+I+Vvhr7TAhvbkQxQZS0SFntNI
         4x0fSw09ZjOLgFo9jqiMGayGjdvLMSLPZcVKL3LxcJk+p1rxc7tlGzeeKzFqnXU4xjPg
         8oU6LO/wOfIRj7bfo4/8UWeD74fxxDRaXIVw53FHEC7xDS6WwOMwULtB8lm/GKRylpa2
         5d/Q==
X-Gm-Message-State: AOAM530QyrnHJb7n9+s86CZmKeU1GgmxY7Aw0Ur5S55zMcmxA1MteNqO
        8du9pduliq072TMwqX3s0hI=
X-Google-Smtp-Source: ABdhPJw1kPdfn1q9W5cbHeESnwr0EMfBK9mUY28aMecbqhlJRh8r3mMfIVtMQfwp9Z6LAlXlrHB4Gg==
X-Received: by 2002:a17:90b:314b:: with SMTP id ip11mr14927249pjb.133.1639791854770;
        Fri, 17 Dec 2021 17:44:14 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:dd94])
        by smtp.gmail.com with ESMTPSA id j7sm11445128pfc.74.2021.12.17.17.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 17:44:14 -0800 (PST)
Date:   Fri, 17 Dec 2021 17:44:12 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Mark Wielaard <mark@klomp.org>
Subject: Re: [PATCH bpf-next v2 00/11] bpf: add support for new btf kind
 BTF_KIND_TAG
Message-ID: <20211218014412.rlbpsvtcqsemtiyk@ast-mbp.dhcp.thefacebook.com>
References: <20210913155122.3722704-1-yhs@fb.com>
 <b59428f2-28cf-f1fd-a02c-730c3a5e453f@fb.com>
 <87sfy82zvd.fsf@oracle.com>
 <fc6e80ec-a823-bee4-7451-2b4d497a64af@fb.com>
 <87ilvncy5x.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilvncy5x.fsf@oracle.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 17, 2021 at 11:40:10AM +0100, Jose E. Marchesi wrote:
> 
> 2) The need for DWARF to convey free-text tags on certain elements, such
>    as members of struct types.
> 
>    The motivation for this was originally the way the Linux kernel
>    generates its BTF information, using pahole, using DWARF as a source.
>    As we discussed in our last exchange on this topic, this is
>    accidental, i.e. if the kernel switched to generate BTF directly from
>    the compiler and the linker could merge/deduplicate BTF, there would
>    be no need for using DWARF to act as the "unwilling conveyer" of this
>    information.  There are additional benefits of this second approach.
>    Thats why we didn't plan to add these extended DWARF DIEs to GCC.
> 
>    However, it now seems that a DWARF consumer, the drgn project, would
>    also benefit from having such a support in DWARF to distinguish
>    between different kind of pointers.

drgn can use .percpu section in vmlinux for global percpu vars.
For pointers the annotation is indeed necessary.

>    So it seems to me that now we have two use-cases for adding support
>    for these free-text tags to DWARF, as a proper extension to the
>    format, strictly unrelated to BTF, BPF or even the kernel, since:
>    - This is not kernel specific.
>    - This is not directly related to BTF.
>    - This is not directly related to BPF.

__percpu annotation is kernel specific.
__user and __rcu are kernel specific too.
Only BPF and BTF can meaningfully consume all three.
drgn can consume __percpu.

In that sense if GCC follows LLVM and emits compiler specific DWARF tag
pahole can convert it to the same BTF regardless whether kernel
was compiled with clang or gcc.
drgn can consume dwarf generated by clang or gcc as well even when BTF
is not there. That is the fastest way forward.

In that sense it would be nice to have common DWARF tag for pointer
annotations, but it's not mandatory. The time is the most valuable asset.
Implementing GCC specific DWARF tag doesn't require committee voting
and the mailing list bikeshedding.

> 3) Addition of C-family language-level constructions to specify
>    free-text tags on certain language elements, such as struct fields.
> 
>    These are the attributes, or built-ins or whatever syntax.
> 
>    Note that, strictly speaking:
>    - This is orthogonal to both DWARF and BTF, and any other supported
>      debugging format, which may or may not be expressive enough to
>      convey the free-form text tag.
>    - This is not specific to BPF.
> 
>    Therefore I would avoid any reference to BTF or BPF in the attribute
>    names.  Something like `__attribute__((btf_tag("arbitrary_str")))'
>    makes very little sense to me; the attribute name ought to be more
>    generic.

Let's agree to disagree.
When BPF ISA was designed we didn't go to Intel, Arm, Mips, etc in order to
come up with the best ISA that would JIT to those architectures the best
possible way. Same thing with btf_tag. Today it is specific to BTF and BPF
only. Hence it's called this way. Whenever actual users will appear that need
free-text tags on a struct field then and only then will be the time to discuss
generic tag name. Just because "free-text tag on a struct field" sounds generic
it doesn't mean that it has any use case beyond what we're using it for in BPF
land. It goes back to the point of coding now instead of talking about coding.
If gcc wants to call it __attribute__((my_precious_gcc_tag("arbitrary_str")))
go ahead and code it this way. The include/linux/compiler.h can accommodate it.
