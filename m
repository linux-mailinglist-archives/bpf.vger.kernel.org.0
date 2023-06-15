Return-Path: <bpf+bounces-2619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1257314C9
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 12:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49AA1C20CB2
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 10:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B227F6ADB;
	Thu, 15 Jun 2023 10:04:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8780263B2
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 10:04:28 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C9126AD;
	Thu, 15 Jun 2023 03:04:26 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9827109c6e9so214715866b.3;
        Thu, 15 Jun 2023 03:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686823465; x=1689415465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ok1RCaPEvQ0tJ/tEaiFFRHFRRfRdw+t0MV9fn+13hjA=;
        b=Ysn7ww3yrG2dJ9rSKMG0hlefoaR5S81/hrsrbxUPq7iVBNX02FIP4fRRJZ4bNgzsAo
         K4fNx8B7PWBUFYK20SraE1o5FpD6H9UphKy9KMqiIq1KbXNNO6NozuDXhwWq8znMeQeS
         uoCXgnyLXJ8wOnpeFcau2QO7BSmlrk17GDpE1zzRQvOUY5Jue323/QFANv6GLsoP3J6o
         LDefEUDZVqDl9hQ+AZzoXVtBc+qakl6fsFH0h7TCja9Vr0mjYOTb/BeLONxJqECmQ+GN
         p9ErEI17FljLdKBYUC1AVZgRp/CGpFq1kGahNAxL/pS2PAuaPyTa8yd4kN81ZiSnJwYs
         g0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686823465; x=1689415465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok1RCaPEvQ0tJ/tEaiFFRHFRRfRdw+t0MV9fn+13hjA=;
        b=Ae4MjR+jV7G7wcINQMH7BAoaeGW8atHcklIhZuTbss+xPtisZYpJI3nG15uxeICj61
         bGhBk6vAmK+dZtQigk5eJUGti4mIO/rEdGFLebAqiTSTta2EifAEn/wnZGdtpWtcElkv
         oXrYtxEf7LCetk3Hj1Yo4KpDGjzSnonh3B5JYuaNvB8H6d7CysTvIRnSxGYnT2YG1IAa
         QtZH8EtBfSqTEN9vYJRoa7p+zJI2nJVN0Iet7hMPbZ7m/9avmKtxbPxghZRktT2PLqOO
         kAo3lfVeBw3p2HuIhrSEpCzWhwAqEe/nxeQFuXTLcA5wSrmCZwkD5nJqj39y0Gs3gNp4
         EWhg==
X-Gm-Message-State: AC+VfDxQUz0g/GgblfcgZZz9iqEKORxu/jn/dlV6mowLdRC1+sp4US5e
	P54i7MfRcXg4v9j0xGODN20=
X-Google-Smtp-Source: ACHHUZ4mi4t8qIVEqDZlTWWTCXH/vi5TtE5x4p7rzC66H3mATJ7J+e0u2iGhIOC3pcDT9Ac2DlcZZA==
X-Received: by 2002:a17:907:7b92:b0:982:9b01:a582 with SMTP id ne18-20020a1709077b9200b009829b01a582mr1567985ejc.1.1686823464750;
        Thu, 15 Jun 2023 03:04:24 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id u3-20020a170906654300b0098238141deasm3652662ejn.90.2023.06.15.03.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:04:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 15 Jun 2023 12:04:22 +0200
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 00/10] bpf: Support ->fill_link_info for
 kprobe_multi and perf_event links
Message-ID: <ZIriJs5qvMYBq7DZ@krava>
References: <20230612151608.99661-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612151608.99661-1-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 12, 2023 at 03:15:58PM +0000, Yafang Shao wrote:
> This patchset enhances the usability of kprobe_multi programs by introducing
> support for ->fill_link_info. This allows users to easily determine the
> probed functions associated with a kprobe_multi program. While
> `bpftool perf show` already provides information about functions probed by
> perf_event programs, supporting ->fill_link_info ensures consistent access to
> this information across all bpf links.
> 
> In addition, this patch extends support to generic perf events, which are
> currently not covered by `bpftool perf show`. While userspace is exposed to
> only the perf type and config, other attributes such as sample_period and
> sample_freq are disregarded.
> 
> To ensure accurate identification of probed functions, it is preferable to
> expose the address directly rather than relying solely on the symbol name.
> However, this implementation respects the kptr_restrict setting and avoids
> exposing the address if it is not permitted.
> 
> v2->v3:
> - Expose flags instead of retporbe (Andrii)
> - Simplify the check on kmulti_link->cnt (Andrii)
> - Use kallsyms_show_value() instead (Andrii)
> - Show also the module name for kprobe_multi (Andrii)
> - Add new enum bpf_perf_link_type (Andrii)
> - Move perf event names into bpftool (Andrii, Quentin, Jiri)
> - Keep perf event names in sync with perf tools (Jiri) 

hi,
I'm getting some failing tests with this version:

#11/2    bpf_cookie/multi_kprobe_link_api:FAIL
#11/3    bpf_cookie/multi_kprobe_attach_api:FAIL
#11      bpf_cookie:FAIL

#104/1   kprobe_multi_test/skel_api:FAIL
#104/2   kprobe_multi_test/link_api_addrs:FAIL
#104/3   kprobe_multi_test/link_api_syms:FAIL
#104/4   kprobe_multi_test/attach_api_pattern:FAIL
#104/5   kprobe_multi_test/attach_api_addrs:FAIL
#104/6   kprobe_multi_test/attach_api_syms:FAIL
#104     kprobe_multi_test:FAIL
#105/1   kprobe_multi_testmod_test/testmod_attach_api_syms:FAIL
#105/2   kprobe_multi_testmod_test/testmod_attach_api_addrs:FAIL
#105     kprobe_multi_testmod_test:FAIL

jirka

> 
> v1->v2:
> - Fix sparse warning (Stanislav, lkp@intel.com)
> - Fix BPF CI build error
> - Reuse kernel_syms_load() (Alexei)
> - Print 'name' instead of 'func' (Alexei)
> - Show whether the probe is retprobe or not (Andrii)
> - Add comment for the meaning of perf_event name (Andrii)
> - Add support for generic perf event
> - Adhere to the kptr_restrict setting
> 
> RFC->v1:
> - Use a single copy_to_user() instead (Jiri)
> - Show also the symbol name in bpftool (Quentin, Alexei)
> - Use calloc() instead of malloc() in bpftool (Quentin)
> - Avoid having conditional entries in the JSON output (Quentin)
> - Drop ->show_fdinfo (Alexei)
> - Use __u64 instead of __aligned_u64 for the field addr (Alexei)
> - Avoid the contradiction in perf_event name length (Alexei)
> - Address a build warning reported by kernel test robot <lkp@intel.com>
> 
> Yafang Shao (10):
>   bpf: Support ->fill_link_info for kprobe_multi
>   bpftool: Dump the kernel symbol's module name
>   bpftool: Show probed function in kprobe_multi link info
>   bpf: Protect probed address based on kptr_restrict setting
>   bpf: Clear the probe_addr for uprobe
>   bpf: Expose symbol's respective address
>   bpf: Add a common helper bpf_copy_to_user()
>   bpf: Support ->fill_link_info for perf_event
>   bpftool: Add perf event names
>   bpftool: Show probed function in perf_event link info
> 
>  include/uapi/linux/bpf.h          |  37 +++++
>  kernel/bpf/syscall.c              | 158 +++++++++++++++++--
>  kernel/trace/bpf_trace.c          |  32 +++-
>  kernel/trace/trace_kprobe.c       |   7 +-
>  tools/bpf/bpftool/link.c          | 322 +++++++++++++++++++++++++++++++++++++-
>  tools/bpf/bpftool/perf.c          | 107 +++++++++++++
>  tools/bpf/bpftool/perf.h          |  11 ++
>  tools/bpf/bpftool/xlated_dumper.c |   6 +-
>  tools/bpf/bpftool/xlated_dumper.h |   2 +
>  tools/include/uapi/linux/bpf.h    |  37 +++++
>  10 files changed, 700 insertions(+), 19 deletions(-)
>  create mode 100644 tools/bpf/bpftool/perf.h
> 
> -- 
> 1.8.3.1
> 

