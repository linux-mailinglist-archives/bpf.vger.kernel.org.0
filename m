Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B28133F47
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2020 11:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgAHK20 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jan 2020 05:28:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31982 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726252AbgAHK20 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Jan 2020 05:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578479305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MNGDZns2ilLSfr48E7yoNRzq8Fd6UWaEPFdNZ92q+EM=;
        b=byyXOBaST6oojCSLkAurl33knGg9NaARYJdty1ah+93akF9kF62Iquq5x7ppZGqqES4La4
        1qoeQqvR+edYnd8XJI3IxT26s+y434zlD8TWStT/1KXWGLAORUJ265qoHKFF6Jxu0VgkXV
        4kgTTfgyxltDEaEcRb0zTKhkUknEndA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-RNiUYJFFNUOAPOssImv6tw-1; Wed, 08 Jan 2020 05:28:24 -0500
X-MC-Unique: RNiUYJFFNUOAPOssImv6tw-1
Received: by mail-wr1-f69.google.com with SMTP id k18so1260090wrw.9
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2020 02:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MNGDZns2ilLSfr48E7yoNRzq8Fd6UWaEPFdNZ92q+EM=;
        b=fVIuAHcED4AEPt0+AvAD7/txHb1g4Ch7gtTUTmSnNL1hhWTF0EugFT/o8tPsMixeIa
         tXI0ba3ZOzOjWkiq16991OR3ID2rKm2rydrbbJ2ZQ7YRZVL3TErjq9h6N8l7fXPqP6ZF
         x4Ei14botH5x/jhk5hDu+bT6Nc7CymKKzUOOin/tPXzb2+CkR+34/SYMMrn/hhE2tnj6
         0uxREdIOlEQllXUZcd1d6QPvL0f+TB4TXgxQ4lVXjz2ZEqfU5j193js+VtY3C8Rqnawu
         CKIfAucfOaFeKRietMmcmPCg1/vckKo1S/3VOayozcBKqfbq0MjrapI94OpIa9EzBpXY
         7oUA==
X-Gm-Message-State: APjAAAXFypzrgRTcg7+wCXQlD7Re04yYzUHP3fuTsOdNmNbdKgJqPS6v
        cmPfUce1RnT4/syv3HcX8pClvXxG2bsO308o8qAcSOV2rdPK8A+5rZ0eqeTEn2+tMhloy5vuhm1
        qxmC+Zq5Fqv1/
X-Received: by 2002:adf:b60f:: with SMTP id f15mr3497112wre.372.1578479302636;
        Wed, 08 Jan 2020 02:28:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqyzqsPwXfyOcm3NxKFAaVRaLs0CUHKMTEnMraxEUcq/d617J06uJrn13035DvVqHR47WUdaNQ==
X-Received: by 2002:adf:b60f:: with SMTP id f15mr3497085wre.372.1578479302409;
        Wed, 08 Jan 2020 02:28:22 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i5sm3235432wml.31.2020.01.08.02.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 02:28:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3CDD7180ADD; Wed,  8 Jan 2020 11:28:21 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 3/6] bpf: Introduce function-by-function verification
In-Reply-To: <20200108072538.3359838-4-ast@kernel.org>
References: <20200108072538.3359838-1-ast@kernel.org> <20200108072538.3359838-4-ast@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 08 Jan 2020 11:28:21 +0100
Message-ID: <87y2uigs3e.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <ast@kernel.org> writes:

> New llvm and old llvm with libbpf help produce BTF that distinguish global and
> static functions. Unlike arguments of static function the arguments of global
> functions cannot be removed or optimized away by llvm. The compiler has to use
> exactly the arguments specified in a function prototype. The argument type
> information allows the verifier validate each global function independently.
> For now only supported argument types are pointer to context and scalars. In
> the future pointers to structures, sizes, pointer to packet data can be
> supported as well. Consider the following example:
>
> static int f1(int ...)
> {
>   ...
> }
>
> int f3(int b);
>
> int f2(int a)
> {
>   f1(a) + f3(a);
> }
>
> int f3(int b)
> {
>   ...
> }
>
> int main(...)
> {
>   f1(...) + f2(...) + f3(...);
> }
>
> The verifier will start its safety checks from the first global function f2().
> It will recursively descend into f1() because it's static. Then it will check
> that arguments match for the f3() invocation inside f2(). It will not descend
> into f3(). It will finish f2() that has to be successfully verified for all
> possible values of 'a'. Then it will proceed with f3(). That function also has
> to be safe for all possible values of 'b'. Then it will start subprog 0 (which
> is main() function). It will recursively descend into f1() and will skip full
> check of f2() and f3(), since they are global. The order of processing global
> functions doesn't affect safety, since all global functions must be proven safe
> based on their arguments only.
>
> Such function by function verification can drastically improve speed of the
> verification and reduce complexity.
>
> Note that the stack limit of 512 still applies to the call chain regardless whether
> functions were static or global. The nested level of 8 also still applies. The
> same recursion prevention checks are in place as well.
>
> The type information and static/global kind is preserved after the verification
> hence in the above example global function f2() and f3() can be replaced later
> by equivalent functions with the same types that are loaded and verified later
> without affecting safety of this main() program. Such replacement (re-linking)
> of global functions is a subject of future patches.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Great to see this progressing; and thanks for breaking things up, makes
it much easier to follow along!

One question:

> +enum btf_func_linkage {
> +	BTF_FUNC_STATIC = 0,
> +	BTF_FUNC_GLOBAL = 1,
> +	BTF_FUNC_EXTERN = 2,
> +};

What's supposed to happen with FUNC_EXTERN? That is specifically for the
re-linking follow-up?

>  /* BTF_KIND_VAR is followed by a single "struct btf_var" to describe
>   * additional information related to the variable such as its linkage.
>   */
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index ed2075884724..e28ec89971ce 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -2621,8 +2621,8 @@ static s32 btf_func_check_meta(struct btf_verifier_env *env,
>  		return -EINVAL;
>  	}
>  
> -	if (btf_type_vlen(t)) {
> -		btf_verifier_log_type(env, t, "vlen != 0");
> +	if (btf_type_vlen(t) > BTF_FUNC_EXTERN) {
> +		btf_verifier_log_type(env, t, "invalid func linkage");

This doesn't reject linkage==BTF_FUNC_EXTERN; so for this patch
FUNC_EXTERN will be treated the same as FUNC_STATIC (it'll fail the
is_global check below)? Or did I miss somewhere else where
BTF_FUNC_EXTERN is rejected?

-Toke

