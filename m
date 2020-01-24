Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA8314908B
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 22:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgAXVzd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 16:55:33 -0500
Received: from namei.org ([65.99.196.166]:59698 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbgAXVzc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jan 2020 16:55:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 00OLtNMn007070;
        Fri, 24 Jan 2020 21:55:23 GMT
Date:   Sat, 25 Jan 2020 08:55:23 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     KP Singh <kpsingh@chromium.org>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 04/10] bpf: lsm: Add mutable hooks list for
 the BPF LSM
In-Reply-To: <20200124012501.GA8709@chromium.org>
Message-ID: <alpine.LRH.2.21.2001250852070.6744@namei.org>
References: <20200123152440.28956-1-kpsingh@chromium.org> <20200123152440.28956-5-kpsingh@chromium.org> <29157a88-7049-906e-fe92-b7a1e2183c6b@schaufler-ca.com> <20200123175942.GA131348@google.com> <5004b3f4-ca5b-a546-4e87-b852cc248079@schaufler-ca.com>
 <20200123222436.GA1598@chromium.org> <f571b719-e11f-416e-4232-f99036e38f15@schaufler-ca.com> <20200124012501.GA8709@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 23 Jan 2020, KP Singh wrote:

> 
> > If you want to put mutable hook handling in the infrastructure
> > you need to make it general mutable hook handling as opposed to
> > BPF hook handling. I don't know if that would be acceptable for
> > all the reasons called out about dynamic module loading.
> 
> We can have generic mutable hook handling and if an LSM doesn't
--> provide a mutable security_hook_heads, it would not allow dynamic
> hooks / dynamic module loading.
> 
> So, in practice it will just be the BPF LSM that allows mutable hooks
> and the other existing LSMs won't. I guess it will be cleaner than
> calling the BPF hooks directly from the LSM code (i.e in security.c)

I'm inclined to only have mutable hooks for KRSI, not for all LSMs. This 
is a special case and we don't need to provide this for anyone else.

Btw, folks, PLEASE trim replies.


-- 
James Morris
<jmorris@namei.org>

