Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4D14BA599
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 17:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243009AbiBQQUJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 11:20:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242998AbiBQQUG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 11:20:06 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C9327374E
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 08:19:51 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j7so218344lfu.6
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 08:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=VJeuuIPHYU1/tEQqOIQyI/rF94+EQB46FuLZOmOG+/I=;
        b=ac4HgF6lbEslHg/xVgSTFRHKyfK/BYICGnm6R2TNcs5JyVvO5UkXYYdvy4BTXZHf9k
         U/HApR4mZBwcZTX5XU1lIdqgeGbLXbJngh66k0/xFjhW2jjVmtaxx6b2hzpJSKmUqJj4
         KzgVbbx6fqanwTCTIJgeKWLTJN6K4MxrvlauI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=VJeuuIPHYU1/tEQqOIQyI/rF94+EQB46FuLZOmOG+/I=;
        b=lhNTpgDj06aRKwonxDHJcEj3+H8eO94QBA/zXatESaPCosW2hSb21kKjJFJ9t6h7gl
         h1qNulXNjzButxSwrWrKgAPqdymlwlmu4wHkWSuPZMLjtF67Muomc1o8I+L9t+LdcOTZ
         rGHo/FnxP27MxrHZnejtmLQIvPM8+z5Wr7VnUdmyafawdx+okuSvCUZJkxYsDrxwtqSk
         wsqeHa0vWe/Smp01KLJ85//oYDv7a4+Hzf+HhgsNKlgLRWr0cVpnTPkV0L3VCK7npfjl
         +wGlIq4EH59iUsscojEqHAZkdO0rNEkduWkupfqyu8QEDCSg7K0qoHNk39M1fXJmFMk9
         0QHg==
X-Gm-Message-State: AOAM532r8DpRKLGFRJGwT5IafKsfMqG80bUNTRey2s4OKVFQcKIzQzC4
        dOcOtUq2lq/HPICfpau2VAw6Xg==
X-Google-Smtp-Source: ABdhPJxDpy91vLYS9JgyBILOe7LAINlJPvBmeN8USpS7jdxgLeY8e4I2AmXQNZwF/RoKaMdYX6yfeg==
X-Received: by 2002:a05:6512:31c:b0:441:a0f6:e091 with SMTP id t28-20020a056512031c00b00441a0f6e091mr2555356lfp.238.1645114790162;
        Thu, 17 Feb 2022 08:19:50 -0800 (PST)
Received: from cloudflare.com ([2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id w8sm7888lfr.242.2022.02.17.08.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:19:49 -0800 (PST)
References: <20220209184333.654927-1-jakub@cloudflare.com>
 <20220209184333.654927-3-jakub@cloudflare.com>
 <CAEf4BzaRNLw9_EnaMo5e46CdEkzbJiVU3j9oxnsemBKjNFf3wQ@mail.gmail.com>
 <e0999e46e5332ca79bdfe4d9b9d7f17e4366a340.camel@linux.ibm.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Cover 4-byte load from
 remote_port in bpf_sk_lookup
Date:   Thu, 17 Feb 2022 17:11:13 +0100
In-reply-to: <e0999e46e5332ca79bdfe4d9b9d7f17e4366a340.camel@linux.ibm.com>
Message-ID: <87fsohea8q.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 17, 2022 at 03:18 PM +01, Ilya Leoshkevich wrote:
> On Wed, 2022-02-16 at 13:44 -0800, Andrii Nakryiko wrote:
>> On Wed, Feb 9, 2022 at 10:43 AM Jakub Sitnicki <jakub@cloudflare.com>
>> wrote:

[...]

>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Load from remote_port field w=
ith zero padding (backward
>> > compatibility) */
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val_u32 =3D *(__u32 *)&ctx->remo=
te_port;
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val_u32 !=3D bpf_htonl(bpf_n=
tohs(SRC_PORT) << 16))
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return SK_DROP;
>> > +
>>=20
>> Jakub, can you please double check that your patch set doesn't break
>> big-endian architectures? I've noticed that our s390x test runner is
>> now failing in the sk_lookup selftest. See [0]. Also CC'ing Ilya.
>
> I agree that this looks like an endianness issue. The new check seems
> to make little sense on big-endian to me, so I would just #ifdef it
> out.

We have a very similar check for a load from context in
progs/test_sock_fields.c, which is not causing problems:

static __noinline bool sk_dst_port__load_word(struct bpf_sock *sk)
{
	__u32 *word =3D (__u32 *)&sk->dst_port;
	return word[0] =3D=3D bpf_htonl(0xcafe0000);
}

So I think I just messed something up here. Will dig into it.

[...]
