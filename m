Return-Path: <bpf+bounces-13027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC537D3CDC
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 18:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306FB1C20A67
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 16:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C6F1C2B2;
	Mon, 23 Oct 2023 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6dvWi4j"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78B1BDEE
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 16:51:16 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38ACDB
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 09:51:12 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso5189339a12.1
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 09:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698079871; x=1698684671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB+PZxf8j7hu3UJpAgvspUDmpHgLpeev03AKkisK/MU=;
        b=i6dvWi4jUgM1VlFqRbE52Qb19JId7Y5H0k9l9PgCPnFIRA02OHLLlaEIEOKKsdaqFd
         knTfnyVr9rwOfG/GdOg70MIvYMLjNuWMLIpev39/8QbPBC1ZZiJzzNpGcney7sxMaXvS
         tQYEi9uCL4Kl1fvSJmO9QjcMwLWURb7qOC1e4VT5uRRpNtxx+l7h00DEnE8/tQMUx7Bw
         ns5hEIVRFyfwFGuTdN2B8E6QKNN3nr8VVQhlQerG1j5+4E3oeCO+aExsG4WVAnRXmCkW
         DMjldzxje9O7O/DzEwLNu0t5F6dmS5VzQslILdRRf8o/HA5+G7GutxAtuSGluk74xAgI
         5a7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698079871; x=1698684671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB+PZxf8j7hu3UJpAgvspUDmpHgLpeev03AKkisK/MU=;
        b=UA3DAT7GQgtpikoYgo5VHWOaL5dGSIqw3pSST3VlM+YA9y5V/12kOjE9PaW68Vhb/A
         D9MUx2AiAIvPtKtQNofAOY5EZnA5nOJzWUsgLcS//dnD8QLPyqfKWVaF5AJs4ZrhxSsV
         MzASw8OcdnCCvhASjHJ9QAXttr1y0aHOk0nTqhKQkPqnp0r1YXemJRWFFecyVv5FbETK
         6Dtvd1rLXK26GRwspHZqrTBypBUf+fTbVQR5FY2oKakoLyoKsty8x7zr0RlTIWEM2rqH
         BLrBIOqTb5RJkLAZfIywtjsBvpGjqkJCdvKXFQhQMYN/Uaj1z0YCzYtdaw2K8R7MpEZu
         MBNw==
X-Gm-Message-State: AOJu0Yx16kSB361B87P+gYh+Z5qAabaI+k0ZrrhYlmK5Ye/HZtqogy2X
	rmSGe2A5MzSKzA2epgfcnPqRzUgoYzM7jV2bXxk=
X-Google-Smtp-Source: AGHT+IEyrVsST0wwPpvlbnQYmBx/9/4KAa2e+yak+T15vBKRw2co40QxEgAPFHakNX/uiV1fiFsn2cmKu24By+JCTvA=
X-Received: by 2002:a50:c314:0:b0:53e:611b:abb3 with SMTP id
 a20-20020a50c314000000b0053e611babb3mr7525145edb.17.1698079871116; Mon, 23
 Oct 2023 09:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTZxoDJJbX9mrQ9w@u94a>
In-Reply-To: <ZTZxoDJJbX9mrQ9w@u94a>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Oct 2023 09:50:59 -0700
Message-ID: <CAEf4Bzb6kLMZo+VsUu=LS5V4WRY-_x-zinv0Pkr6XEbCrHvo-w@mail.gmail.com>
Subject: Re: Unifying signed and unsigned min/max tracking
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Dave Thaler <dthaler@microsoft.com>, Paul Chaignon <paul@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 6:14=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> Hi,
>
> CC those who had worked on bound tracking before for feedbacks, as well a=
s
> Dave who works on PREVAIL (verifier used on Windows) and Paul who've writ=
ten
> about PREVAIL[1], for whether there's existing knowledge on this topic.
>
> Here goes a long one...
>
> ---
>
> While looking at Andrii's patches that improves bounds logic (specificall=
y
> patches [2][3]). I realize we may be able to unify umin/umax/smin/smax in=
to
> just two u64. Not sure if this has already been discussed off-list or is
> being worked upon, but I can't find anything regarding this by searching
> within the BPF mailing list.
>
> For simplicity sake I'll focus on unsigned bounds for now. What we have
> right in the Linux Kernel now is essentially
>
>     struct bounds {
>         u64 umin;
>         u64 umax;
>     }
>
> We can visualize the above as a number line, using asterisk to denote the
> values between umin and umax.
>
>                  u64
>     |----------********************--|
>
> Say if we have umin =3D A, and umax =3D B (where B > 2^63). Representing =
the
> magnitude of umin and umax visually would look like this
>
>     <----------> A
>     |----------********************--|
>     <-----------------------------> B (larger than 2^63)
>
> Now if we go through a BPF_ADD operation and adds 2^(64 - 1) =3D 2^63,
> currently the verifier will detect that this addition overflows, and thus
> reset umin and umax to 0 and U64_MAX, respectively; blowing away existing
> knowledge.
>
>     |********************************|
>
> Had we used u65 (1-bit more than u64) and tracks the bound with u65_min a=
nd
> u65_max, the verifier would have captured the bound just fine. (This idea
> comes from the special case mentioned in Andrii's patch[3])
>
>                                     u65
>     <---------------> 2^63
>                     <----------> A
>     <--------------------------> u65_min =3D A + 2^63
>     |--------------------------********************------------------|
>     <---------------------------------------------> u65_max =3D B + 2^63
>
> Continue on this thought further, let's attempting to map this back to u6=
4
> number lines (using two of them to fit everything in u65 range), it would
> look like
>
>                                     u65
>     |--------------------------********************------------------|
>                                vvvvvvvvvvvvvvvvvvvv
>     |--------------------------******|*************------------------|
>                    u64                              u64
>
> And would seems that we'd need two sets of u64 bounds to preserve our
> knowledge.
>
>     |--------------------------******| u64 bound #1
>     |**************------------------| u64 bound #2
>
> Or just _one_ set of u64 bound if we somehow are able to track the union =
of
> bound #1 and bound #2 at the same time
>
>     |--------------------------******| u64 bound #1
>   U |**************------------------| u64 bound #2
>      vvvvvvvvvvvvvv            vvvvvv  union on the above bounds
>     |**************------------******|
>
> However, this bound crosses the point between U64_MAX and 0, which is not
> semantically possible to represent with the umin/umax approach. It just
> makes no sense.
>
>     |**************------------******| union of bound #1 and bound #2
>
> The way around this is that we can slightly change how we track the bound=
s,
> and instead use
>
>     struct bounds {
>         u64 base; /* base =3D umin */
>         /* Maybe there's a better name other than "size" */
>         u64 size; /* size =3D umax - umin */
>     }
>
> Using this base + size approach, previous old bound would have looked lik=
e
>
>     <----------> base =3D A
>     |----------********************--|
>                <------------------> size =3D B - A
>
> Looking at the bounds this way means we can now capture the union of boun=
d
> #1 and bound #2 above. Here it is again for reference
>
>     |**************------------******| union of bound #1 and bound #2
>
> Because registers are u64-sized, they wraps, and if we extend the u64 num=
ber
> line, it would look like this due to wrapping
>
>                    u64                         same u64 wrapped
>     |**************------------******|*************------------******|
>
> Which can be capture with the base + size semantic
>
>     <--------------------------> base =3D (u64) A + 2^63
>     |**************------------******|*************------------******|
>                                <------------------> size =3D B - A,
>                                                     doesn't change after =
add
>
> Or looking it with just a single u64 number line again
>
>     <--------------------------> base =3D (u64) A + 2^63
>     |**************------------******|
>     <-------------> base + size =3D (u64) (B + 2^32)
>
> This would mean that umin and umax is no longer readily available, we now
> have to detect whether base + size wraps to determin whether umin =3D 0 o=
r
> base (and similar for umax). But the verifier already have the code to do
> that in the existing scalar_min_max_add(), so it can be done by reusing
> existing code.
>
> ---
>
> Side tracking slightly, a benefit of this base + size approach is that
> scalar_min_max_add() can be made even simpler:
>
>     scalar_min_max_add(struct bpf_reg_state *dst_reg,
>                                struct bpf_reg_state *src_reg)
>     {
>         /* This looks too simplistic to have worked */
>         dst_reg.base =3D dst_reg.base + src_reg.base;
>         dst_reg.size =3D dst_reg.size + src_reg.size;
>     }
>
> Say we now have another unsigned bound where umin =3D C and umax =3D D
>
>     <--------------------> C
>     |--------------------*********---|
>     <----------------------------> D
>
> If we want to track the bounds after adding two registers on with umin =
=3D A &
> umax =3D B, the other with umin =3D C and umin =3D D
>
>     <----------> A
>     |----------********************--|
>     <-----------------------------> B
>                      +
>     <--------------------> C
>     |--------------------*********---|
>     <----------------------------> D
>
> The results falls into the following u65 range
>
>     |--------------------*********---|-------------------------------|
>   + |----------********************--|-------------------------------|
>
>     |------------------------------**|**************************-----|
>
> This result can be tracked with base + size approach just fine. Where the
> base and size are as follow
>
>     <------------------------------> base =3D A + C
>     |------------------------------**|**************************-----|
>                                    <--------------------------->
>                                       size =3D (B - A) + (D - C)
>
> ---
>
> Now back to the topic of unification of signed and unsigned range. Using =
the
> union of bound #1 and bound #2 again as an example (size =3D B - A, and
> base =3D (u64) A + 2^63)
>
>     |**************------------******| union of bound #1 and bound #2
>
> And look at it's wrapped number line form again
>
>                    u64                         same u64 wrapped
>     <--------------------------> base
>     |**************------------******|*************------------******|
>                                <------------------> size
>
> Now add in the s64 range and align both u64 range and s64 at 0, we can se=
e
> what previously was a bound that umin/umax cannot track is simply a valid
> smin/smax bound (idea drawn from patch [2]).
>
>                                      0
>     |**************------------******|*************------------******|
>                     |----------********************--|
>                                     s64
>
> The question now is be what is the "signed" base so we proceed to calcula=
te
> the smin/smax. Note that base starts at 0, so for s64 the line that
> represents base doesn't start from the left-most location.
> (OTOH size stays the same, so we know it already)
>
>                                     s64
>                                      0
>                                <-----> signed base =3D ?
>                     |----------********************--|
>                                <------------------> size is the same
>
> If we put u64 range back into the picture again, we can see that the "sig=
ned
> base" was, in fact, just base casted into s64, so there's really no need =
for
> a "signed" base at all
>
>     <--------------------------> base
>     |**************------------******|
>                                      0
>                                <-----> signed base =3D (s64) base
>                     |----------********************--|
>
> Which shows base + size approach capture signed and unsigned bounds at th=
e
> same time. Or at least its the best attempt I can make to show it.
>
> One way to look at this is that base + size is just a generalization of
> umin/umax, taking advantage of the fact that the similar underlying hardw=
are
> is used both for the execution of BPF program and bound tracking.
>
> I wonder whether this is already being done elsewhere, e.g. by PREVAIL or
> some of static code analyzer, and I can just borrow the code from there
> (where license permits).

A slight alternative, but the same idea, that I had (though after
looking at reg_bounds_sync() I became less enthusiastic about this)
was to unify signed/unsigned ranges by allowing umin u64> umax. That
is, invalid range where umin is greater than umax would mean the wrap
around case (which is also basically smin/smax case when it covers
negative and positive parts of s64/s32 range).

Taking your diagram and annotating it a bit differently:

|**************------------******|
             umax        umin


It will make everything more tricky, but if someone is enthusiastic
enough to try it out and see if we can make this still understandable,
why not?


>
> The glaring questions left to address are:
> 1. Lots of talk with no code at all:
>      Will try to work on this early November and send some result as RFC.=
 In
>      the meantime if someone is willing to give it a try I'll do my best =
to
>      help.
>
> 2. Whether the same trick applied to scalar_min_max_add() can be applied =
to
>    other arithmetic operations such as BPF_MUL or BPF_DIV:
>      Maybe not, but we should be able to keep on using most of the existi=
ng
>      bound inferring logic we have scalar_min_max_{mul,div}() since base =
+
>      size can be viewed as a generalization of umin/umax/smin/smax.
>
> 3. (Assuming this base + size approach works) how to integrate it into ou=
r
>    existing codebase:
>      I think we may need to refactor out code that touches
>      umin/umax/smin/smax and provide set-operation API where possible. (i=
.e.
>      like tnum's APIs)
>
> 4. Whether the verifier loss to ability to track certain range that comes
>    out of mixed u64 and s64 BPF operations, and this loss cause some BPF
>    program that passes the verfier to now be rejected.

Very well might be, I've seen some crazy combinations in my testing.
Good thing is that I'm adding a quite exhaustive tests that try all
different boundary conditions. If you check seeds values I used, most
of them are some sort of boundary for signed/unsigned 32/64 bit
numbers. Add to that abstract interpretation model checking, and you
should be able to validate your ideas pretty easily.

>
> 5. Probably more that I haven't think of, feel free to add or comments :)
>
>
> Shung-Hsi
>
> 1: https://pchaigno.github.io/ebpf/2023/09/06/prevail-understanding-the-w=
indows-ebpf-verifier.html
> 2: https://lore.kernel.org/bpf/20231022205743.72352-2-andrii@kernel.org/
> 3: https://lore.kernel.org/bpf/20231022205743.72352-4-andrii@kernel.org/

