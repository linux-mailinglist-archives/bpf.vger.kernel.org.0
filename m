Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2582B158893
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2020 04:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgBKDMS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Feb 2020 22:12:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40960 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgBKDMS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Feb 2020 22:12:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id j9so4712068pfa.8;
        Mon, 10 Feb 2020 19:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oRkW2XcGN+ZHJ9q4kvQ0RJqBXUTFywBUYhv5rDLEKt4=;
        b=LiFfmrpPkGv8orByK7ryOHRuSbxDPbDtap4XnRxM2WiWbrTLuzoVc1WzE3+7o0+j7a
         96q4pj8s1P7YiIyXttfVHAJMWqN0u4W7UTvLRkCKaF6188tyHJ9Kam0mBBMK2ou11mCt
         jLN51YfcQlpWz3VXPS604ua96Z85QQyG1ZJdSA46P6mdFbCWBR/w0jeBRzP3SDXP0Skw
         ub49gjtxGJARvm2R6E1/Gl6aqCPLKlazBLChN+xS5mcMGEqi7nrXWS4JWjnLnOm3iXqo
         O/BsniCzd3omUK/KMjnsUueVdfdn90UIN2p4vTvbPAac2GeFq4PvayCtIqtYRXcuMRvN
         AAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oRkW2XcGN+ZHJ9q4kvQ0RJqBXUTFywBUYhv5rDLEKt4=;
        b=nvQO1BFOv60It4HHEoSYI+Sfj0r9knR5a//SBwRedbpsljUpPlsr7RhoP27N6g0VTS
         3sBq73SYilnMim4d6FiBpBoy67nSVP/7KxM+ccd61xXyoEX6VH6s8VMK61S+tqdPQ9Te
         o5xedbnQ2Am1uI5TkYc92V0TCkDINJl6bDg7KuOes0CDtxlz61cjwKMEK0Ni7S2D6Sot
         3M+E3SGgHJfQ6fDegATw2/lnnarPHdZib8FSz4oMCo6qLIYfOGXnFr1UPMBZP3G2JQoD
         cRR/WV47H+MVWllS4lMLpNtjqEDafc6NjR8frqxXxgybpH72NDB3KvO0DYdbdnEaFjf9
         ahsQ==
X-Gm-Message-State: APjAAAVPd+9iaLw6BEP4A2C/+enyUZuRCgo3bGrLW+ybVIauK2zdt/55
        cQIe69FlCvfoV7amWsnxOJc=
X-Google-Smtp-Source: APXvYqwc01uHRhO/VzOcwfGgjJ6ss+01OI/rhtKnBbJ8zS2rIV8h2kZFXUDdDbS9ZO4xzuWRtCdwqw==
X-Received: by 2002:aa7:9edd:: with SMTP id r29mr4230502pfq.14.1581390737242;
        Mon, 10 Feb 2020 19:12:17 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::3:8bd])
        by smtp.gmail.com with ESMTPSA id 3sm761134pjg.27.2020.02.10.19.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 19:12:16 -0800 (PST)
Date:   Mon, 10 Feb 2020 19:12:10 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next v3 04/10] bpf: lsm: Add mutable hooks list for
 the BPF LSM
Message-ID: <20200211031208.e6osrcathampoog7@ast-mbp>
References: <20200123152440.28956-1-kpsingh@chromium.org>
 <20200123152440.28956-5-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123152440.28956-5-kpsingh@chromium.org>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 23, 2020 at 07:24:34AM -0800, KP Singh wrote:
> +#define CALL_BPF_LSM_INT_HOOKS(FUNC, ...) ({			\
> +	int _ret = 0;						\
> +	do {							\
> +		struct security_hook_list *P;			\
> +		int _idx;					\
> +								\
> +		if (hlist_empty(&bpf_lsm_hook_heads.FUNC))	\
> +			break;					\
> +								\
> +		_idx = bpf_lsm_srcu_read_lock();		\
> +								\
> +		hlist_for_each_entry(P,				\
> +			&bpf_lsm_hook_heads.FUNC, list) {	\
> +			_ret = P->hook.FUNC(__VA_ARGS__);		\
> +			if (_ret && IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE)) \
> +				break;				\
> +		}						\
> +		bpf_lsm_srcu_read_unlock(_idx);			\
> +	} while (0);						\
> +	IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE) ? _ret : 0;	\
> +})

This extra CONFIG_SECURITY_BPF_ENFORCE doesn't make sense to me.
Why do all the work for bpf-lsm and ignore return code? Such framework already
exists. For audit only case the user could have kprobed security_*() in
security/security.c and had access to exactly the same data. There is no need
in any of these patches if audit the only use case.
Obviously bpf-lsm has to be capable of making go/no-go decision, so
my preference is to drop this extra kconfig knob.
I think the agreement seen in earlier comments in this thread that the prefered
choice is to always have bpf-based lsm to be equivalent to LSM_ORDER_LAST. In
such case how about using bpf-trampoline fexit logic instead?
Pros:
- no changes to security/ directory
- no changes to call_int_hook() macro
- patches 4, 5, 6 no longer necessary
- when security is off all security_*() hooks do single
  if (hlist_empty(&bpf_lsm_hook_heads.FUNC)) check.
  With patch 4 there will two such checks. Tiny perf penalty.
  With fexit approach there will be no extra check.
- fexit approach is fast even on kernels compiled with retpoline, since
  its using direct calls
Cons:
- bpf trampoline so far is x86 only and arm64 support is wip

By plugging into fexit I'm proposing to let bpf-lsm prog type modify return
value. Currently bpf-fexit prog type has read-only access to it. Adding write
access is a straightforward verifier change. The bpf progs from patch 9 will
still look exactly the same way:
SEC("lsm/file_mprotect")
int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
            unsigned long reqprot, unsigned long prot) { ... }
The difference that libbpf will be finding btf_id of security_file_mprotect()
function and adding fexit trampoline to it instead of going via
security_list_options and its own lsm_hook_idx uapi. I think reusing existing
tracing facilities to attach and multiplex multiple programs is cleaner. More
code reuse. Unified testing of lsm and tracing, etc.
