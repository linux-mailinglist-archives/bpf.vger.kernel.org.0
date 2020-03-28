Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 027491962C9
	for <lists+bpf@lfdr.de>; Sat, 28 Mar 2020 02:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgC1BIx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 21:08:53 -0400
Received: from namei.org ([65.99.196.166]:44080 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgC1BIx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 21:08:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 02S18Fsm015427;
        Sat, 28 Mar 2020 01:08:15 GMT
Date:   Sat, 28 Mar 2020 12:08:15 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     KP Singh <kpsingh@chromium.org>
cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v8 4/8] bpf: lsm: Implement attach, detach and
 execution
In-Reply-To: <20200327192854.31150-5-kpsingh@chromium.org>
Message-ID: <alpine.LRH.2.21.2003281207420.30073@namei.org>
References: <20200327192854.31150-1-kpsingh@chromium.org> <20200327192854.31150-5-kpsingh@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 27 Mar 2020, KP Singh wrote:

> From: KP Singh <kpsingh@google.com>
> 
> JITed BPF programs are dynamically attached to the LSM hooks
> using BPF trampolines. The trampoline prologue generates code to handle
> conversion of the signature of the hook to the appropriate BPF context.
> 
> The allocated trampoline programs are attached to the nop functions
> initialized as LSM hooks.
> 
> BPF_PROG_TYPE_LSM programs must have a GPL compatible license and
> and need CAP_SYS_ADMIN (required for loading eBPF programs).
> 
> Upon attachment:
> 
> * A BPF fexit trampoline is used for LSM hooks with a void return type.
> * A BPF fmod_ret trampoline is used for LSM hooks which return an
>   int. The attached programs can override the return value of the
>   bpf LSM hook to indicate a MAC Policy decision.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

