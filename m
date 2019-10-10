Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B424D3182
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2019 21:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfJJTmE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Oct 2019 15:42:04 -0400
Received: from namei.org ([65.99.196.166]:53524 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfJJTmE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Oct 2019 15:42:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x9AJf1pp032000;
        Thu, 10 Oct 2019 19:41:01 GMT
Date:   Fri, 11 Oct 2019 06:41:01 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
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
In-Reply-To: <dc0cacef-fff5-b837-97a4-ed7336934bf6@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1910110637300.31442@namei.org>
References: <20191009203657.6070-1-joel@joelfernandes.org> <710c5bc0-deca-2649-8351-678e177214e9@schaufler-ca.com> <alpine.LRH.2.21.1910100912210.29840@namei.org> <2b94802d-12ea-4f2d-bb65-eda3b3542bb2@schaufler-ca.com> <alpine.LRH.2.21.1910101343470.8343@namei.org>
 <dc0cacef-fff5-b837-97a4-ed7336934bf6@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 10 Oct 2019, Casey Schaufler wrote:

> > Because it is not necessary.
> 
> The logic escapes me, but OK.

We should only extend the stacking infrastructure to what is concretely 
required. We don't yet have a use-case for stacking perf_event so we 
should keep the code as simple as possible. As soon as multiple LSMs 
determine they need to share the blob, we can convert the code to blob 
sharing.


-- 
James Morris
<jmorris@namei.org>

