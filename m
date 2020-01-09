Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC9A71354F3
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2020 09:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgAII55 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jan 2020 03:57:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37906 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728919AbgAII55 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jan 2020 03:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578560276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K4jGKAx0cxwGJj0+NXRwQRgi8kUP6lo+YsuTTEYbILg=;
        b=BqwOXON9ZSwxfWnewVL5FIGytvr88JL5vQnk6QH6YtE4K6L4f+tM26JOsmvKVgn8yxB9UY
        zyLUOEoytX/hxSvE5Fe7bC755vKXcQHbYdABKDpkBid99RtQOER92ADRm7o8rfmpEYievE
        Wc6LzgCQgZUZqM5Vj96HIdXXPqa+tcA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-7HeeDOBZPR-qePdVfAU2Rw-1; Thu, 09 Jan 2020 03:57:52 -0500
X-MC-Unique: 7HeeDOBZPR-qePdVfAU2Rw-1
Received: by mail-wm1-f69.google.com with SMTP id o24so229576wmh.0
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2020 00:57:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=K4jGKAx0cxwGJj0+NXRwQRgi8kUP6lo+YsuTTEYbILg=;
        b=FcP+zBeNp0Au1c0V088tFphQAy+Q77H1/8mhW90XEofVn73VLBBrhaKpF3Gbj8GJ7Q
         +19+iF31qY5rvtUuC8JgZrZl51dLj0dW6Vaf1ymDV78U6WWKe19Po5eMERSCxo0gJksW
         OcIVzLqEaCv/Ig0JoGEKXGOG5dHTypZ4RSUosbYEzVxbVlYrxsFP85ngM+Us4RU0Gb9a
         ZgpjLhF0J1eWXIInL1B8Ukl4PWBn0CvL/m63bk6/sLvP684hXCvxIcLiYWeV5m1/5RDV
         Oj3EG6/v1eh5FSQPYvDnzYaAZX5NSBVNZUM7FUfoy5jIEG9+8hKRWD9K6TWpEuloaaH/
         dlzQ==
X-Gm-Message-State: APjAAAUy8EJCg6/Kr2AjoqjN80EDvLJSf3PQobEP/C7Vv3u/Gi3dxxwm
        WUdbF4m+Gh4vKBnHS0tW6K0Hpw2hYNCu6s97Tmha9FiNBANC3v4g0TFBdEnqWtdY6m7784mWoXG
        cbHtMKNw6reWf
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr9386635wrt.70.1578560271723;
        Thu, 09 Jan 2020 00:57:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqyapQILqXZvtVH0Ikvgh6f93ibHfoyolrt5IM4shFevzilNMV9H3zPxVEq0M+ZlBoDzJm6M7Q==
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr9386607wrt.70.1578560271428;
        Thu, 09 Jan 2020 00:57:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id x17sm7145345wrt.74.2020.01.09.00.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 00:57:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1E6FE180ADD; Thu,  9 Jan 2020 09:57:50 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net,
        daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 3/6] bpf: Introduce function-by-function verification
In-Reply-To: <20200108200655.vfjqa7pq65f7evkq@ast-mbp>
References: <20200108072538.3359838-1-ast@kernel.org> <20200108072538.3359838-4-ast@kernel.org> <87y2uigs3e.fsf@toke.dk> <20200108200655.vfjqa7pq65f7evkq@ast-mbp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 09 Jan 2020 09:57:50 +0100
Message-ID: <87ftgpgg6p.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Jan 08, 2020 at 11:28:21AM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Alexei Starovoitov <ast@kernel.org> writes:
>>=20
>> > New llvm and old llvm with libbpf help produce BTF that distinguish gl=
obal and
>> > static functions. Unlike arguments of static function the arguments of=
 global
>> > functions cannot be removed or optimized away by llvm. The compiler ha=
s to use
>> > exactly the arguments specified in a function prototype. The argument =
type
>> > information allows the verifier validate each global function independ=
ently.
>> > For now only supported argument types are pointer to context and scala=
rs. In
>> > the future pointers to structures, sizes, pointer to packet data can be
>> > supported as well. Consider the following example:
>> >
>> > static int f1(int ...)
>> > {
>> >   ...
>> > }
>> >
>> > int f3(int b);
>> >
>> > int f2(int a)
>> > {
>> >   f1(a) + f3(a);
>> > }
>> >
>> > int f3(int b)
>> > {
>> >   ...
>> > }
>> >
>> > int main(...)
>> > {
>> >   f1(...) + f2(...) + f3(...);
>> > }
>> >
>> > The verifier will start its safety checks from the first global functi=
on f2().
>> > It will recursively descend into f1() because it's static. Then it wil=
l check
>> > that arguments match for the f3() invocation inside f2(). It will not =
descend
>> > into f3(). It will finish f2() that has to be successfully verified fo=
r all
>> > possible values of 'a'. Then it will proceed with f3(). That function =
also has
>> > to be safe for all possible values of 'b'. Then it will start subprog =
0 (which
>> > is main() function). It will recursively descend into f1() and will sk=
ip full
>> > check of f2() and f3(), since they are global. The order of processing=
 global
>> > functions doesn't affect safety, since all global functions must be pr=
oven safe
>> > based on their arguments only.
>> >
>> > Such function by function verification can drastically improve speed o=
f the
>> > verification and reduce complexity.
>> >
>> > Note that the stack limit of 512 still applies to the call chain regar=
dless whether
>> > functions were static or global. The nested level of 8 also still appl=
ies. The
>> > same recursion prevention checks are in place as well.
>> >
>> > The type information and static/global kind is preserved after the ver=
ification
>> > hence in the above example global function f2() and f3() can be replac=
ed later
>> > by equivalent functions with the same types that are loaded and verifi=
ed later
>> > without affecting safety of this main() program. Such replacement (re-=
linking)
>> > of global functions is a subject of future patches.
>> >
>> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>=20
>> Great to see this progressing; and thanks for breaking things up, makes
>> it much easier to follow along!
>>=20
>> One question:
>>=20
>> > +enum btf_func_linkage {
>> > +	BTF_FUNC_STATIC =3D 0,
>> > +	BTF_FUNC_GLOBAL =3D 1,
>> > +	BTF_FUNC_EXTERN =3D 2,
>> > +};
>>=20
>> What's supposed to happen with FUNC_EXTERN? That is specifically for the
>> re-linking follow-up?
>
> I was thinking to complete the whole thing with re-linking and then send =
it,
> but llvm 10 feature cut off date is end of this week, so we have to land =
llvm
> bits asap. I'd like to land patch 1 with libbpf sanitization first before
> landing llvm. llvm release cadence is ~4 month and it would be sad to
> miss it.

Agreed, it would be sad to miss the cutoff!

> Note we will be able to tweak encoding if really necessary after next wee=
k.
> (BTF encoding gets fixed in ABI only after full kernel release).
> It's unlikely though. I think the encoding is good. I've played with few
> different variants and this one fits the best. FUNC_EXTERN encoding as 2 =
is
> kinda obvious when encoding for global vs static is selected. The kernel =
and
> libbpf will not be using FUNC_EXTERN yet, but llvm is tested to do the ri=
ght
> thing already, so I think it's fine to add it to btf.h now.

Sure, OK. Don't have any objections (or opinions on the encoding,
really), just want to understand how this all fits together.

> As far as future plans when libbpf sees FUNC_EXTERN it will do the linkin=
g the
> way we discussed in the other thread. The kernel will support FUNC_EXTERN=
 when
> we introduce dynamic libraries. A collection of bpf functions will be loa=
ded
> into the kernel first (like libc.so) and later programs will have FUNC_EX=
TERN
> as part of their BTF to be resolved while loading. The func name to btf_id
> resolution will be done by libbpf. The kernel verifier will do the type
> checking on BTFs.

Right, FUNC_EXTERN will be rejected by the kernel unless it's patched up
with "target" btf_ids by libbpf before load? So it'll be
FUNC_GLOBAL-linked functions that will be replaceable after the fact
with the "dynamic re-linking" feature?

> So the kernel side of FUNC_EXTERN support will be minimal,
> but to your point below...
>
>> This doesn't reject linkage=3D=3DBTF_FUNC_EXTERN; so for this patch
>> FUNC_EXTERN will be treated the same as FUNC_STATIC (it'll fail the
>> is_global check below)? Or did I miss somewhere else where
>> BTF_FUNC_EXTERN is rejected?
>
> ... is absolutely correct. My bad. Added this bit too soon.
> Will remove. The kernel should accept FUNC_GLOBAL only in this patch set.

Great, thanks!

-Toke

