Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 357CC194E08
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 01:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgC0AbD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 20:31:03 -0400
Received: from namei.org ([65.99.196.166]:43884 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbgC0AbD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 20:31:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 02R0UVUY018169;
        Fri, 27 Mar 2020 00:30:31 GMT
Date:   Fri, 27 Mar 2020 11:30:31 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     KP Singh <kpsingh@chromium.org>
cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v7 6/8] tools/libbpf: Add support for
 BPF_PROG_TYPE_LSM
In-Reply-To: <20200326142823.26277-7-kpsingh@chromium.org>
Message-ID: <alpine.LRH.2.21.2003271130110.17915@namei.org>
References: <20200326142823.26277-1-kpsingh@chromium.org> <20200326142823.26277-7-kpsingh@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 26 Mar 2020, KP Singh wrote:

> From: KP Singh <kpsingh@google.com>
> 
> Since BPF_PROG_TYPE_LSM uses the same attaching mechanism as
> BPF_PROG_TYPE_TRACING, the common logic is refactored into a static
> function bpf_program__attach_btf_id.
> 
> A new API call bpf_program__attach_lsm is still added to avoid userspace
> conflicts if this ever changes in the future.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

