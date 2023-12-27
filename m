Return-Path: <bpf+bounces-18700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1B581F17A
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 20:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4591F2306F
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 19:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36A646B91;
	Wed, 27 Dec 2023 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1PxHi+2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA420306;
	Wed, 27 Dec 2023 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33677fb38a3so5587481f8f.0;
        Wed, 27 Dec 2023 11:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703703661; x=1704308461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucqUcU3zyNkG6GcytVS0lrdLXAph5hA8OQMhhs/vvSA=;
        b=J1PxHi+2PBPWjNO6+NKRLaOg6VYuLDHkCPLhaMKms5rxCVyGwsGUJDBElxsxAtlQ1m
         ss5/oA2NkN4ktMw8u4SasZPcUlGtRbgz8kgCVMcSX4Qa/c+rO8hti8/HBEV8d5yk6hXT
         tu7yk0efySuTods+EfWWzTn4AxRnIJOtB2dPnYE7uObwxQz8kP5hw2qIbbhRhsGLHBvh
         4liSeJyfAE6NEvxz13b9zOoh50pfIEEFA67PEYIc0MNzF9ujZ+kj79Vj8Z/s1xVqfFCJ
         YKpXYSJWbR+7WDEcOrFueJkZBiql2yIbG88rCBnkdXD5VxhJXZg0fd2MeeT3SrPTc/QS
         IqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703703661; x=1704308461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucqUcU3zyNkG6GcytVS0lrdLXAph5hA8OQMhhs/vvSA=;
        b=Gbz0TGaC6UoiDs63vGDXrDsL8qI5bpzDeocEaN4Ul9nW5olIn58WI8//9h4zA/Wle0
         sqFSqhv13OvCZjvemMAr/qxmB7N8P4jJ9R/iphN/cio+12V6IYTybOkQgrw/Xg0UHEAB
         ZAGEjFck9Z66gL6ICb+DMfLEK+YYxAPbVX+jwZLDc48PKLvSFUKDGXlfix67RCHxYf+t
         y/zOUir2ENFZYRBWM7k8iE/jlzLJBNaBZXmh8CcNQS5/pVFScPQ5ukWMA7jXTfTC3iU3
         ggLdmi5z3a64zPcIpH59xL+m8zpOuEpS/bSB2xHdfS1PJMkUccIAUtXOzTHrFP3QV9G1
         zaCg==
X-Gm-Message-State: AOJu0YyLtGWMIkK0nmgFnivZRYuYyyQaEt42798cVNG41FyJSKsBLSPr
	cdu56I/AAq+0Bol88OwEOUn1xmunMf+8Ms47/wc=
X-Google-Smtp-Source: AGHT+IHOggBkRyaEe//vGD99Ke0t5serq4JbHTjRngBnmLcxHoOnOHk4W8zcf7JDq5LUBIW6gsSqPNOrLWLzzjsa0Yk=
X-Received: by 2002:a5d:6d05:0:b0:336:b717:3b5a with SMTP id
 e5-20020a5d6d05000000b00336b7173b5amr6193973wrq.77.1703703660869; Wed, 27 Dec
 2023 11:01:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1703081351-85579-1-git-send-email-alibuda@linux.alibaba.com>
 <1703081351-85579-2-git-send-email-alibuda@linux.alibaba.com>
 <CAADnVQK3Wk+pKbvc5_7jgaQ=qFq3y0ozgnn+dbW56DaHL2ExWQ@mail.gmail.com>
 <1d3cb7fc-c1dc-a779-8952-cdbaaf696ce3@linux.alibaba.com> <CAADnVQJEUEo3g7knXtkD0CNjazTpQKcjrAaZLJ4utk962bjmvw@mail.gmail.com>
 <d5879c57-634f-4973-b52d-4994d0929de6@linux.alibaba.com>
In-Reply-To: <d5879c57-634f-4973-b52d-4994d0929de6@linux.alibaba.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Dec 2023 11:00:49 -0800
Message-ID: <CAADnVQJZsJujDH=YAoZ6ieQQ2pVo0wvc-ppwRC7y2X=ggibsEw@mail.gmail.com>
Subject: Re: [RFC nf-next v3 1/2] netfilter: bpf: support prog update
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, coreteam@netfilter.org, 
	netfilter-devel <netfilter-devel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 12:20=E2=80=AFAM D. Wythe <alibuda@linux.alibaba.co=
m> wrote:
>
>
> Hi Alexei,
>
>
> IMMO, nf_unregister_net_hook does not wait for the completion of the
> execution of the hook that is being removed,
> instead, it allocates a new array without the very hook to replace the
> old arrayvia rcu_assign_pointer() (in __nf_hook_entries_try_shrink),
> then it use call_rcu() to release the old one.
>
> You can find more details in commit
> 8c873e2199700c2de7dbd5eedb9d90d5f109462b.
>
> In other words, when nf_unregister_net_hook returns, there may still be
> contexts executing hooks on the
> old array, which means that the `link` may still be accessed after
> nf_unregister_net_hook returns.
>
> And that's the reason why we use kfree_rcu() to release the `link`.
> >>                                                        nf_hook_run_bpf
> >>                                                        const struct
> >> bpf_nf_link *nf_link =3D bpf_link;
> >>
> >> bpf_nf_link_release
> >>       nf_unregister_net_hook(nf_link->net, &nf_link->hook_ops);
> >>
> >> bpf_nf_link_dealloc
> >>       free(link)
> >> bpf_prog_run(link->prog);

Got it.
Sounds like it's an existing bug. If so it should be an independent
patch with Fixes tag.

Also please craft a test case to demonstrate UAF.

>
> I must admit that it is indeed feasible if we eliminate the mutex and
> use cmpxchg to swap the prog (we need to ensure that there is only one
> bpf_prog_put() on the old prog).
> However, when cmpxchg fails, it means that this context has not
> outcompeted the other one, and we have to return a failure. Maybe
> something like this:
>
> if (!cmpxchg(&link->prog, old_prog, new_prog)) {
>      /* already replaced by another link_update */
>      return -xxx;
> }
>
> As a comparison, The version with the mutex wouldn't encounter this
> error, every update would succeed. I think that it's too harsh for the
> user to receive a failure
> in that case since they haven't done anything wrong.

Disagree. The mutex doesn't prevent this issue.
There is always a race.
It happens when link_update.old_prog_fd and BPF_F_REPLACE
were specified.
One user space passes an FD of the old prog and
another user space doing the same. They both race and one of them
gets
if (old_prog && link->prog !=3D old_prog) {
               err =3D -EPERM;

it's no different with dropping the mutex and doing:
if (old_prog) {
    if (!cmpxchg(&link->prog, old_prog, new_prog))
      -EPERM
} else {
   old_prog =3D xchg(&link->prog, new_prog);
}

