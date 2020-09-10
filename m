Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520782645EB
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 14:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgIJMX6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 08:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730559AbgIJMVt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Sep 2020 08:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599740507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/cfir9CzXXwefn6FCiNZ3lOaycB3VAxPu8Gd+zbqHR8=;
        b=BPRpAjHQN5i87jO8yMFT0AvlZykpE6SxypzIRC0jwnXPPWbLBSququtnkeR6hg6B3gNL0z
        keZVEQ0V46cuR9XrF31Fu+XYsLtWWSbhgtpXRkKeTE4MbO4nFv75mUoxtcHXl+C2uDlpKS
        +2gFeTMDDX4BoagCdSMOin8+8hOtBiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-lLl075SrPbifxKLIV0g0hQ-1; Thu, 10 Sep 2020 08:21:44 -0400
X-MC-Unique: lLl075SrPbifxKLIV0g0hQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42AFE1882FB6;
        Thu, 10 Sep 2020 12:21:43 +0000 (UTC)
Received: from carbon (unknown [10.40.208.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7969E7E17A;
        Thu, 10 Sep 2020 12:21:34 +0000 (UTC)
Date:   Thu, 10 Sep 2020 14:21:32 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        jakub@cloudflare.com, bpf@vger.kernel.org,
        kernel-team@cloudflare.com, Stefano Brivio <sbrivio@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: [PATCH bpf] bpf: plug hole in struct bpf_sk_lookup_kern
Message-ID: <20200910142132.3a901194@carbon>
In-Reply-To: <20200910110248.198326-1-lmb@cloudflare.com>
References: <20200910110248.198326-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 10 Sep 2020 12:02:48 +0100
Lorenz Bauer <lmb@cloudflare.com> wrote:

> As Alexei points out, struct bpf_sk_lookup_kern has two 4-byte holes.
> This leads to suboptimal instructions being generated (IPv4, x86):
> 
>     1372                    struct bpf_sk_lookup_kern ctx = {
>        0xffffffff81b87f30 <+624>:   xor    %eax,%eax
>        0xffffffff81b87f32 <+626>:   mov    $0x6,%ecx
>        0xffffffff81b87f37 <+631>:   lea    0x90(%rsp),%rdi
>        0xffffffff81b87f3f <+639>:   movl   $0x110002,0x88(%rsp)
>        0xffffffff81b87f4a <+650>:   rep stos %rax,%es:(%rdi)
>        0xffffffff81b87f4d <+653>:   mov    0x8(%rsp),%eax
>        0xffffffff81b87f51 <+657>:   mov    %r13d,0x90(%rsp)
>        0xffffffff81b87f59 <+665>:   incl   %gs:0x7e4970a0(%rip)
>        0xffffffff81b87f60 <+672>:   mov    %eax,0x8c(%rsp)
>        0xffffffff81b87f67 <+679>:   movzwl 0x10(%rsp),%eax
>        0xffffffff81b87f6c <+684>:   mov    %ax,0xa8(%rsp)
>        0xffffffff81b87f74 <+692>:   movzwl 0x38(%rsp),%eax
>        0xffffffff81b87f79 <+697>:   mov    %ax,0xaa(%rsp)
> 
> Fix this by moving around sport and dport. pahole confirms there
> are no more holes:
> 
>     struct bpf_sk_lookup_kern {
>         u16                        family;       /*     0     2 */
>         u16                        protocol;     /*     2     2 */
>         __be16                     sport;        /*     4     2 */
>         u16                        dport;        /*     6     2 */
>         struct {
>                 __be32             saddr;        /*     8     4 */
>                 __be32             daddr;        /*    12     4 */
>         } v4;                                    /*     8     8 */
>         struct {
>                 const struct in6_addr  * saddr;  /*    16     8 */
>                 const struct in6_addr  * daddr;  /*    24     8 */
>         } v6;                                    /*    16    16 */
>         struct sock *              selected_sk;  /*    32     8 */
>         bool                       no_reuseport; /*    40     1 */
> 
>         /* size: 48, cachelines: 1, members: 8 */
>         /* padding: 7 */
>         /* last cacheline: 48 bytes */
>     };
> 
> The assembly also doesn't contain the pesky rep stos anymore:
> 
>     1372                    struct bpf_sk_lookup_kern ctx = {
>        0xffffffff81b87f60 <+624>:   movzwl 0x10(%rsp),%eax
>        0xffffffff81b87f65 <+629>:   movq   $0x0,0xa8(%rsp)
>        0xffffffff81b87f71 <+641>:   movq   $0x0,0xb0(%rsp)
>        0xffffffff81b87f7d <+653>:   mov    %ax,0x9c(%rsp)
>        0xffffffff81b87f85 <+661>:   movzwl 0x38(%rsp),%eax
>        0xffffffff81b87f8a <+666>:   movq   $0x0,0xb8(%rsp)
>        0xffffffff81b87f96 <+678>:   mov    %ax,0x9e(%rsp)
>        0xffffffff81b87f9e <+686>:   mov    0x8(%rsp),%eax
>        0xffffffff81b87fa2 <+690>:   movq   $0x0,0xc0(%rsp)
>        0xffffffff81b87fae <+702>:   movl   $0x110002,0x98(%rsp)
>        0xffffffff81b87fb9 <+713>:   mov    %eax,0xa0(%rsp)
>        0xffffffff81b87fc0 <+720>:   mov    %r13d,0xa4(%rsp)
> 
> 1: https://lore.kernel.org/bpf/CAADnVQKE6y9h2fwX6OS837v-Uf+aBXnT_JXiN_bbo2gitZQ3tA@mail.gmail.com/
> 
> Fixes: e9ddbb7707ff ("bpf: Introduce SK_LOOKUP program type with a dedicated attach point")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

I'm very happy to see others have also discovered the slowdown of 'rep stos',
as I've been hunting these for years.  My understanding is that the
'rep-stos' slowdown comes from the CPU-instruction saving the CPU-flags
to allow it to be interrupted.  That makes sense when memset zeroing
large areas, but for small mem size structs this is slower than
clearing them in other ways.  I have a micro-benchmark as a
kernel-module here[2], where I explore different methods of memset.

[2] https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/time_bench_memset.c

As you have discovered the GCC compiler will generate these rep stos
for clearing a struct if not all members are initialized. If you want
to fix some more of these, then I remember there were some in the
net/core/flow_dissector.c code.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

