Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A218D194DF3
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 01:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgC0AYq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 20:24:46 -0400
Received: from namei.org ([65.99.196.166]:43802 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgC0AYq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 20:24:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 02R0OCMP017800;
        Fri, 27 Mar 2020 00:24:12 GMT
Date:   Fri, 27 Mar 2020 11:24:12 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     KP Singh <kpsingh@chromium.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v7 4/8] bpf: lsm: Implement attach, detach and
 execution
In-Reply-To: <20200326142823.26277-5-kpsingh@chromium.org>
Message-ID: <alpine.LRH.2.21.2003271119420.17089@namei.org>
References: <20200326142823.26277-1-kpsingh@chromium.org> <20200326142823.26277-5-kpsingh@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 26 Mar 2020, KP Singh wrote:

> +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> +			const struct bpf_prog *prog)
> +{
> +	/* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
> +	 */
> +	if (!capable(CAP_MAC_ADMIN))
> +		return -EPERM;
> +

Stephen, can you confirm that your concerns around this are resolved 
(IIRC, by SELinux implementing a bpf_prog callback) ?


-- 
James Morris
<jmorris@namei.org>

