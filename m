Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF61D1B6F
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2019 00:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbfJIWNL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 18:13:11 -0400
Received: from namei.org ([65.99.196.166]:53338 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfJIWNL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Oct 2019 18:13:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x99MBdMw030060;
        Wed, 9 Oct 2019 22:11:39 GMT
Date:   Thu, 10 Oct 2019 09:11:39 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH RFC] perf_event: Add support for LSM and SELinux checks
In-Reply-To: <20191009203657.6070-1-joel@joelfernandes.org>
Message-ID: <alpine.LRH.2.21.1910100908260.29840@namei.org>
References: <20191009203657.6070-1-joel@joelfernandes.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 9 Oct 2019, Joel Fernandes (Google) wrote:

>  
> +#ifdef CONFIG_SECURITY
> +	err = security_perf_event_alloc(event);
> +	if (err)
> +		goto err_security;
> +#endif

You should not need this ifdef.

> diff --git a/security/security.c b/security/security.c
> index 1bc000f834e2..7639bca1db59 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2373,26 +2373,32 @@ int security_bpf(int cmd, union bpf_attr *attr, unsigned int size)
>  {
>  	return call_int_hook(bpf, 0, cmd, attr, size);
>  }
> +
>  int security_bpf_map(struct bpf_map *map, fmode_t fmode)
>  {
>  	return call_int_hook(bpf_map, 0, map, fmode);
>  }
> +
>  int security_bpf_prog(struct bpf_prog *prog)
>  {
>  	return call_int_hook(bpf_prog, 0, prog);
>  }
> +
>  int security_bpf_map_alloc(struct bpf_map *map)
>  {
>  	return call_int_hook(bpf_map_alloc_security, 0, map);
>  }
> +
>  int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
>  {
>  	return call_int_hook(bpf_prog_alloc_security, 0, aux);
>  }
> +
>  void security_bpf_map_free(struct bpf_map *map)
>  {
>  	call_void_hook(bpf_map_free_security, map);
>  }
> +
>  void security_bpf_prog_free(struct bpf_prog_aux *aux)
>  {
>  	call_void_hook(bpf_prog_free_security, aux);
> @@ -2404,3 +2410,30 @@ int security_locked_down(enum lockdown_reason what)
>  	return call_int_hook(locked_down, 0, what);
>  }
>  EXPORT_SYMBOL(security_locked_down);

Please avoid unrelated whitespace changes.


-- 
James Morris
<jmorris@namei.org>

