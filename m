Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61A4BC85F
	for <lists+bpf@lfdr.de>; Sat, 19 Feb 2022 13:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242235AbiBSMLA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Feb 2022 07:11:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240894AbiBSMK6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 07:10:58 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35CA66608
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 04:10:39 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 139so10135066pge.1
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 04:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vjx/YGDRPYh/b/I0MWs283O2cjt32XaVtxZMHlGZxeo=;
        b=bS7rMXI3imnEsUwRtn5JBhfAdUVuWFPxh0qzYm94HwEFCmEjNSP3W7kSJBTWBkEtsL
         LO2gy4Bi1xRqjnwGc8QWatIXf7eJB6zE3RZu/3gP7IpwhvtdKMZjxDFUNYTLfQoBy3Sa
         TGYca1NITNMQdU7hioXTg+Dx+cYeaF4LinGBfGUmwAv27fLm8SpKlsUd3YM/9WMtJBFi
         axlUaXIwD8+OTKJ2J6unvWDCLLN/kopiTfPh4LplFbZI/Fs58/pN/QNwgYQ/u2+qHS7X
         haEdP+PE84WrmowI/q6/yszHTBckSPNEox7DLZnCSreIxppNqolkLT+hWLn4j618YkSb
         qSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vjx/YGDRPYh/b/I0MWs283O2cjt32XaVtxZMHlGZxeo=;
        b=2ZT7D8rbtnhacfKPsuyHJ9vUoTPqLcWDHtnCW24t3v8Akft83vTJ1hz2W2w/PVINJj
         QMoOfTwmpWcmSyL/4eI7y5vtZOzcMQBX2Vr6udlhM5oQDurDLhqubO7QGBSDtVUCuBQB
         siXJSLwInO+xr5jmEvTdiv/e8jnbqzJkZzFAsV0iGyEza2fyEEkIshwaXmvbIYM8nHPl
         8Gp0aFQN5c98UG4QI1L1t7nvF7z8c35sntv3VJ73AiEDOxTVfypMT3c9trHHXVfeV+Rp
         n6BVpLJ/OFAmCCqsPoe3syMCiWl17HszJemrmLjw8jQ5SeGIczPI8woQRFUi0xcnjkbV
         TBmA==
X-Gm-Message-State: AOAM530uJtwwHrRO7zTxCbfEr7hLwgVYi8UcNBEMRQJEAgTpkPcx+Qfc
        xE5YGrY4fmQ48tIgmIZSpTxGSYzKUtM=
X-Google-Smtp-Source: ABdhPJyCk/r0zhMec0f7+QnDuFSDexrZvCbT1SLZiDjmw9RJ+QT0fN1oXXShLwkXKgB58BZLUaJY1A==
X-Received: by 2002:a05:6a00:ad4:b0:4df:ffdd:5099 with SMTP id c20-20020a056a000ad400b004dfffdd5099mr11834532pfl.61.1645272638920;
        Sat, 19 Feb 2022 04:10:38 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id q4sm6337643pfj.113.2022.02.19.04.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 04:10:38 -0800 (PST)
Date:   Sat, 19 Feb 2022 17:40:35 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf v1 0/5] More fixes for crashes due to bad
 PTR_TO_BTF_ID reg->off
Message-ID: <20220219121035.c6c5dmvbchzaqqak@apollo.legion>
References: <20220219113744.1852259-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219113744.1852259-1-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 19, 2022 at 05:07:39PM IST, Kumar Kartikeya Dwivedi wrote:
> A few more fixes for bad PTR_TO_BTF_ID reg->off being accepted in places, that
> can lead to the kernel crashing. Noticed while making sure my own series for BTF
> ID pointer in map won't allow stores for pointers with incorrect offsets.
>
> I include one example where d_path can crash even if you NULL check
> PTR_TO_BTF_ID, and one example of how missing NULL check in helper taking
> PTR_TO_BTF_ID (like bpf_sock_from_file) is a real problem, see the selftest
> patch.
>
> The &f->f_path becomes NULL + offset in case f is NULL, circumventing NULL
> checks in existing helpers. The only thing needed to trigger this finding an
> object that embeds the object of interest, and then somehow obtaining a NULL
> PTR_TO_BTF_ID to it (not hard, esp. due to exception handler for PROBE_MEM loads
> writing 0 to destination register).
>
> However, for the case of patch 2, it is allowed in my series since the next load
> of the bad pointer stored using:
>   struct file *f = ...; // some pointer walking returning NULL pointer
>   map_val->ptr = &f->f_path; // ptr being struct path *
> ... would be marked as PTR_UNTRUSTED, so it won't be allowed to be passed into
> the kernel, and hence can be permitted. In referenced case, the PTR_TO_BTF_ID
> should not be NULL anyway. kptr_get style helper takes PTR_TO_MAP_VALUE in
> referenced ptr case only, so the load either yields NULL or RCU protected
> pointer.
>
> Tests for patch 1 depend on fixup_kfunc_btf_id in test_verifier, hence will be
> sent after merge window opens, some other changes after bpf tree merges into
> bpf-next, but all pending ones can be seen here [0]. Tests for patch 2 are
> included, and try to trigger crash without the fix, but it's not 100% reliable.
> We may need special testing helpers or kfuncs to make it thorough, but wanted to
> wait before getting feedback.
>
> Issue fixed by patch 2 is a bit more broader in scope, and would require proper
> discussion (before being applied) on the correct way forward, as it is
> technically backwards incompatible change, but hopefully never breaks real
> programs, only malicious or already incorrect ones.
>
> Also, please suggest the right "Fixes" tag for patch 2.
>
> As for patch 3 (selftest), please suggest a better way to get a certain type of
> PTR_TO_BTF_ID which can be NULL or NULL+offset. Can we add kfuncs for testing
> that return such pointers and make them available to e.g. TC progs, if the fix
> in patch 2 is acceptable?
>
>   [0]: https://github.com/kkdwivedi/linux/commits/fixes-bpf-next
>

Looking at BPF CI [1], it seems it surfaces another problem I was seeing locally
but couldn't craft a reliable test case for, that it forms a non-NULL but
invalid pointer using pointer walking, in some cases RCU read lock provides
protection for those cases, but not all (esp. if kernel doesn't clear the old
pointer that was in use before, and has it sitting in some location). RDI (arg1)
seems to be pointing somewhere behind the faulting address, which means the
&f->f_path is bad.

But this requires a larger discussion.

In that case, PAGE_SIZE thing won't help. We may have to introduce a PTR_BPF_REF
flag (e.g. set for ctx args of tracing progs, set based on BTF tagging in other
places) which tells the verifier that the pointer for the duration of program
will be valid, so it can be passed into helpers.

So for cases like &f->f_path it will work, since file + off will still have
PTR_BPF_REF set in reg state. In case of pointer walking, where dst_reg state
is updated on walk, we may have to explicitly tag members where PTR_BPF_REF can
be inherited if parent object has PTR_BPF_REF (i.e. ref to parent implies ref to
child cases).

Something like:

struct foo {
	...
	struct bar __bpf_ref *p;
	struct baz *q;
	...
}

... then if getting:

	struct foo *f = ...; // PTR_TO_BTF_ID | PTR_BPF_REF
	struct bar *p = f->p; // Inherits PTR_BPF_REF
	struct baz *q = f->q; // Does not inherit PTR_BPF_REF

Thoughts?

  [1]: https://github.com/kernel-patches/bpf/runs/5258413028?check_suite_focus=true

> Kumar Kartikeya Dwivedi (5):
>   bpf: Fix kfunc register offset check for PTR_TO_BTF_ID
>   bpf: Restrict PTR_TO_BTF_ID offset to PAGE_SIZE when calling helpers
>   bpf: Use bpf_ptr_is_invalid for all helpers taking PTR_TO_BTF_ID
>   selftests/bpf: Add selftest for PTR_TO_BTF_ID NULL + off case
>   selftests/bpf: Adjust verifier selftest for updated message
>
>  include/linux/bpf.h                           | 19 ++++
>  include/linux/bpf_verifier.h                  |  3 +
>  kernel/bpf/bpf_inode_storage.c                |  4 +-
>  kernel/bpf/bpf_lsm.c                          |  4 +-
>  kernel/bpf/bpf_task_storage.c                 |  4 +-
>  kernel/bpf/btf.c                              | 24 ++++-
>  kernel/bpf/stackmap.c                         |  3 +
>  kernel/bpf/task_iter.c                        |  2 +-
>  kernel/bpf/verifier.c                         | 99 +++++++++++++------
>  kernel/trace/bpf_trace.c                      | 12 +++
>  net/core/bpf_sk_storage.c                     |  9 +-
>  net/core/filter.c                             | 52 ++++++----
>  net/ipv4/bpf_tcp_ca.c                         |  4 +-
>  .../selftests/bpf/prog_tests/d_path_crash.c   | 19 ++++
>  .../selftests/bpf/progs/d_path_crash.c        | 26 +++++
>  .../selftests/bpf/verifier/bounds_deduction.c |  2 +-
>  tools/testing/selftests/bpf/verifier/ctx.c    |  8 +-
>  17 files changed, 226 insertions(+), 68 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/d_path_crash.c
>  create mode 100644 tools/testing/selftests/bpf/progs/d_path_crash.c
>
> --
> 2.35.1
>

--
Kartikeya
