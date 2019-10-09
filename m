Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C37D1B7D
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2019 00:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbfJIWPl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 18:15:41 -0400
Received: from namei.org ([65.99.196.166]:53370 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730675AbfJIWPl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Oct 2019 18:15:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x99MEi61030164;
        Wed, 9 Oct 2019 22:14:45 GMT
Date:   Thu, 10 Oct 2019 09:14:44 +1100 (AEDT)
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
In-Reply-To: <710c5bc0-deca-2649-8351-678e177214e9@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1910100912210.29840@namei.org>
References: <20191009203657.6070-1-joel@joelfernandes.org> <710c5bc0-deca-2649-8351-678e177214e9@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 9 Oct 2019, Casey Schaufler wrote:

> Please consider making the perf_alloc security blob maintained
> by the infrastructure rather than the individual modules. This
> will save it having to be changed later.

Is anyone planning on using this with full stacking?

If not, we don't need the extra code & complexity. Stacking should only 
cover what's concretely required by in-tree users.

-- 
James Morris
<jmorris@namei.org>

