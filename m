Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E404C194DFA
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 01:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgC0A3H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 20:29:07 -0400
Received: from namei.org ([65.99.196.166]:43840 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgC0A3H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 20:29:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 02R0SZpQ018015;
        Fri, 27 Mar 2020 00:28:35 GMT
Date:   Fri, 27 Mar 2020 11:28:35 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     KP Singh <kpsingh@chromium.org>
cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v7 2/8] security: Refactor declaration of LSM
 hooks
In-Reply-To: <20200326142823.26277-3-kpsingh@chromium.org>
Message-ID: <alpine.LRH.2.21.2003271128230.17915@namei.org>
References: <20200326142823.26277-1-kpsingh@chromium.org> <20200326142823.26277-3-kpsingh@chromium.org>
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
> The information about the different types of LSM hooks is scattered
> in two locations i.e. union security_list_options and
> struct security_hook_heads. Rather than duplicating this information
> even further for BPF_PROG_TYPE_LSM, define all the hooks with the
> LSM_HOOK macro in lsm_hook_defs.h which is then used to generate all
> the data structures required by the LSM framework.
> 
> The LSM hooks are defined as:
> 
>   LSM_HOOK(<return_type>, <default_value>, <hook_name>, args...)
> 
> with <default_value> acccessible in security.c as:
> 
>   LSM_RET_DEFAULT(<hook_name>)
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

