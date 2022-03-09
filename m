Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2954D2EC5
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 13:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiCIMKa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 07:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiCIMK3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 07:10:29 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9882E0BD
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 04:09:30 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bu29so3456383lfb.0
        for <bpf@vger.kernel.org>; Wed, 09 Mar 2022 04:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=PvquTpN79DGC6xc9dEZE/GpmBmPQhP2RjoJFwYOoEes=;
        b=EEsaIxHtH8Wb4Jhb8X3bNWGyw3gW+cCLPv3dfK/IfgN26KHeC+8TETx7Rx72MK+PLW
         1vtrsiZuAaJbTc63AofMdjYUWAPHVuozQLp1u9knwWl5UtmSE87049NwQM0acPnHwlZo
         TxK7tIn1P3mB/Yg5VKBMoNAdbdxPX75dgUE0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=PvquTpN79DGC6xc9dEZE/GpmBmPQhP2RjoJFwYOoEes=;
        b=y5zjBSHXHw+VaJ37RYPi53pj/HSCVF/mSdhONXm/7KE/wzKGlKk4xADbfMKyNeMaGw
         wYGkvNwvRaSM0arQ3OO/7AXD7Cb2Uo/Mz1CDMzC55DCnNWPIchq+lFefgsJh118Xa7B9
         L991KsFu39FSpaLHFGmTQYkgS0WR+ly8yj0Tx6HHj3DlJFK/4LB/JSWVguIj/yXoWSrK
         6reLT6KKL64ZW+7T/7Ks+8nblHdr2mTNNOmClbOmBkXDqDpJP8hfp5neO4Y526qdehnv
         8DVmva63bsKXTdbTVrSrj+70E6e3Zi/S87HT3wS9sZDExVNcdMPsutuRrJCe8feEgCih
         YSeA==
X-Gm-Message-State: AOAM531IlwEcsOnJYu0dxAogDfWH2rYJ276q8oRv63yr4S5ZhkXPX0wU
        JttS5zAVR4EHh6VvsqYzsZwhRvApzqakAA==
X-Google-Smtp-Source: ABdhPJwP+/785no0ODvHifbpufQZAtnZL7Fbx5TR6WYEK1G/gcEYOj5eRISAvjBWnFPGlSVd1KJXjg==
X-Received: by 2002:a05:6512:a8f:b0:448:1f28:c8d8 with SMTP id m15-20020a0565120a8f00b004481f28c8d8mr14162966lfu.525.1646827768414;
        Wed, 09 Mar 2022 04:09:28 -0800 (PST)
Received: from cloudflare.com ([2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id v7-20020a2e9f47000000b0024802e6f480sm344014ljk.130.2022.03.09.04.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 04:09:27 -0800 (PST)
References: <20220222182559.2865596-1-iii@linux.ibm.com>
 <20220222182559.2865596-2-iii@linux.ibm.com>
 <87bkygzbg5.fsf@cloudflare.com>
 <8d8b464f6c2820989d67f00d24b6003b8b758274.camel@linux.ibm.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: Fix certain narrow loads with
 offsets
Date:   Wed, 09 Mar 2022 09:36:33 +0100
In-reply-to: <8d8b464f6c2820989d67f00d24b6003b8b758274.camel@linux.ibm.com>
Message-ID: <871qzbz5sa.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 09, 2022 at 12:58 AM +01, Ilya Leoshkevich wrote:
> On Tue, 2022-03-08 at 16:01 +0100, Jakub Sitnicki wrote:
>> On Tue, Feb 22, 2022 at 07:25 PM +01, Ilya Leoshkevich wrote:
>> > Verifier treats bpf_sk_lookup.remote_port as a 32-bit field for
>> > backward compatibility, regardless of what the uapi headers say.
>> > This field is mapped onto the 16-bit bpf_sk_lookup_kern.sport
>> > field.
>> > Therefore, accessing the most significant 16 bits of
>> > bpf_sk_lookup.remote_port must produce 0, which is currently not
>> > the case.
>> >=20
>> > The problem is that narrow loads with offset - commit 46f53a65d2de
>> > ("bpf: Allow narrow loads with offset > 0"), don't play nicely with
>> > the masking optimization - commit 239946314e57 ("bpf: possibly
>> > avoid
>> > extra masking for narrower load in verifier"). In particular, when
>> > we
>> > suppress extra masking, we suppress shifting as well, which is not
>> > correct.
>> >=20
>> > Fix by moving the masking suppression check to BPF_AND generation.
>> >=20
>> > Fixes: 46f53a65d2de ("bpf: Allow narrow loads with offset > 0")
>> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> > ---
>> > =C2=A0kernel/bpf/verifier.c | 14 +++++++++-----
>> > =C2=A01 file changed, 9 insertions(+), 5 deletions(-)
>> >=20
>> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> > index d7473fee247c..195f2e9b5a47 100644
>> > --- a/kernel/bpf/verifier.c
>> > +++ b/kernel/bpf/verifier.c
>> > @@ -12848,7 +12848,7 @@ static int convert_ctx_accesses(struct
>> > bpf_verifier_env *env)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
return -EINVAL;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> > =C2=A0
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (is_narrower_load && size < target_size) {
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (is_narrower_load) {
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
u8 shift =3D bpf_ctx_narrow_access_offset(
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0off, size, size_default) * =
8;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
if (shift && cnt + 1 >=3D
>> > ARRAY_SIZE(insn_buf)) {
>> > @@ -12860,15 +12860,19 @@ static int convert_ctx_accesses(struct
>> > bpf_verifier_env *env)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0insn_buf[cnt++] =3D
>> > BPF_ALU32_IMM(BPF_RSH,
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0insn->dst_reg,
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0shift);
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0insn_buf[cnt++] =3D
>> > BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0(1
>> > << size * 8) - 1);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (size < target_size)
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0insn_buf[cnt++] =3D
>> > BPF_ALU32_IMM(
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BPF_AND, ins=
n-
>> > >dst_reg,
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(1 << size *=
 8) -
>> > 1);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
} else {
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (shift)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0insn_buf[cnt++] =3D
>> > BPF_ALU64_IMM(BPF_RSH,
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0insn->dst_reg,
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0shift);
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0insn_buf[cnt++] =3D
>> > BPF_ALU64_IMM(BPF_AND, insn->dst_reg,
>> > -
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0(1ULL
>> >  << size * 8) - 1);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (size < target_size)
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0insn_buf[cnt++] =3D
>> > BPF_ALU64_IMM(
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BPF_AND, ins=
n-
>> > >dst_reg,
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(1ULL << siz=
e * 8)
>> > - 1);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>=20
>> Thanks for patience. I'm coming back to this.
>>=20
>> This fix affects the 2-byte load from bpf_sk_lookup.remote_port.
>> Dumping the xlated BPF code confirms it.
>>=20
>> On LE (x86-64) things look well.
>>=20
>> Before this patch:
>>=20
>> * size=3D2, offset=3D0, 0: (69) r2 =3D *(u16 *)(r1 +36)
>> =C2=A0=C2=A0 0: (69) r2 =3D *(u16 *)(r1 +4)
>> =C2=A0=C2=A0 1: (b7) r0 =3D 0
>> =C2=A0=C2=A0 2: (95) exit
>>=20
>> * size=3D2, offset=3D2, 0: (69) r2 =3D *(u16 *)(r1 +38)
>> =C2=A0=C2=A0 0: (69) r2 =3D *(u16 *)(r1 +4)
>> =C2=A0=C2=A0 1: (b7) r0 =3D 0
>> =C2=A0=C2=A0 2: (95) exit
>>=20
>> After this patch:
>>=20
>> * size=3D2, offset=3D0, 0: (69) r2 =3D *(u16 *)(r1 +36)
>> =C2=A0=C2=A0 0: (69) r2 =3D *(u16 *)(r1 +4)
>> =C2=A0=C2=A0 1: (b7) r0 =3D 0
>> =C2=A0=C2=A0 2: (95) exit
>>=20
>> * size=3D2, offset=3D2, 0: (69) r2 =3D *(u16 *)(r1 +38)
>> =C2=A0=C2=A0 0: (69) r2 =3D *(u16 *)(r1 +4)
>> =C2=A0=C2=A0 1: (74) w2 >>=3D 16
>> =C2=A0=C2=A0 2: (b7) r0 =3D 0
>> =C2=A0=C2=A0 3: (95) exit
>>=20
>> Which works great because the JIT generates a zero-extended load
>> movzwq:
>>=20
>> * size=3D2, offset=3D0, 0: (69) r2 =3D *(u16 *)(r1 +36)
>> bpf_prog_5e4fe3dbdcb18fd3:
>> =C2=A0=C2=A0 0:=C2=A0=C2=A0 nopl=C2=A0=C2=A0 0x0(%rax,%rax,1)
>> =C2=A0=C2=A0 5:=C2=A0=C2=A0 xchg=C2=A0=C2=A0 %ax,%ax
>> =C2=A0=C2=A0 7:=C2=A0=C2=A0 push=C2=A0=C2=A0 %rbp
>> =C2=A0=C2=A0 8:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 %rsp,%rbp
>> =C2=A0=C2=A0 b:=C2=A0=C2=A0 movzwq 0x4(%rdi),%rsi
>> =C2=A0 10:=C2=A0=C2=A0 xor=C2=A0=C2=A0=C2=A0 %eax,%eax
>> =C2=A0 12:=C2=A0=C2=A0 leave
>> =C2=A0 13:=C2=A0=C2=A0 ret
>>=20
>>=20
>> * size=3D2, offset=3D2, 0: (69) r2 =3D *(u16 *)(r1 +38)
>> bpf_prog_4a6336c64a340b96:
>> =C2=A0=C2=A0 0:=C2=A0=C2=A0 nopl=C2=A0=C2=A0 0x0(%rax,%rax,1)
>> =C2=A0=C2=A0 5:=C2=A0=C2=A0 xchg=C2=A0=C2=A0 %ax,%ax
>> =C2=A0=C2=A0 7:=C2=A0=C2=A0 push=C2=A0=C2=A0 %rbp
>> =C2=A0=C2=A0 8:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 %rsp,%rbp
>> =C2=A0=C2=A0 b:=C2=A0=C2=A0 movzwq 0x4(%rdi),%rsi
>> =C2=A0 10:=C2=A0=C2=A0 shr=C2=A0=C2=A0=C2=A0 $0x10,%esi
>> =C2=A0 13:=C2=A0=C2=A0 xor=C2=A0=C2=A0=C2=A0 %eax,%eax
>> =C2=A0 15:=C2=A0=C2=A0 leave
>> =C2=A0 16:=C2=A0=C2=A0 ret
>>=20
>> Runtime checks for bpf_sk_lookup.remote_port load and the 2-bytes of
>> zero padding following it, like below, pass with flying colors:
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ok =3D ctx->remote_port =
=3D=3D bpf_htons(8008);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ok)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return SK_DROP;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ok =3D *((__u16 *)&ctx->=
remote_port + 1) =3D=3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ok)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return SK_DROP;
>>=20
>> (The above checks compile to half-word (2-byte) loads.)
>>=20
>>=20
>> On BE (s390x) things look different:
>>=20
>> Before the patch:
>>=20
>> * size=3D2, offset=3D0, 0: (69) r2 =3D *(u16 *)(r1 +36)
>> =C2=A0=C2=A0 0: (69) r2 =3D *(u16 *)(r1 +4)
>> =C2=A0=C2=A0 1: (bc) w2 =3D w2
>> =C2=A0=C2=A0 2: (b7) r0 =3D 0
>> =C2=A0=C2=A0 3: (95) exit
>>=20
>> * size=3D2, offset=3D2, 0: (69) r2 =3D *(u16 *)(r1 +38)
>> =C2=A0=C2=A0 0: (69) r2 =3D *(u16 *)(r1 +4)
>> =C2=A0=C2=A0 1: (bc) w2 =3D w2
>> =C2=A0=C2=A0 2: (b7) r0 =3D 0
>> =C2=A0=C2=A0 3: (95) exit
>>=20
>> After the patch:
>>=20
>> * size=3D2, offset=3D0, 0: (69) r2 =3D *(u16 *)(r1 +36)
>> =C2=A0=C2=A0 0: (69) r2 =3D *(u16 *)(r1 +4)
>> =C2=A0=C2=A0 1: (bc) w2 =3D w2
>> =C2=A0=C2=A0 2: (74) w2 >>=3D 16
>> =C2=A0=C2=A0 3: (bc) w2 =3D w2
>> =C2=A0=C2=A0 4: (b7) r0 =3D 0
>> =C2=A0=C2=A0 5: (95) exit
>>=20
>> * size=3D2, offset=3D2, 0: (69) r2 =3D *(u16 *)(r1 +38)
>> =C2=A0=C2=A0 0: (69) r2 =3D *(u16 *)(r1 +4)
>> =C2=A0=C2=A0 1: (bc) w2 =3D w2
>> =C2=A0=C2=A0 2: (b7) r0 =3D 0
>> =C2=A0=C2=A0 3: (95) exit
>>=20
>> These compile to:
>>=20
>> * size=3D2, offset=3D0, 0: (69) r2 =3D *(u16 *)(r1 +36)
>> bpf_prog_fdd58b8caca29f00:
>> =C2=A0=C2=A0 0:=C2=A0=C2=A0 j=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0000=
000000000006
>> =C2=A0=C2=A0 4:=C2=A0=C2=A0 nopr
>> =C2=A0=C2=A0 6:=C2=A0=C2=A0 stmg=C2=A0=C2=A0=C2=A0 %r11,%r15,112(%r15)
>> =C2=A0=C2=A0 c:=C2=A0=C2=A0 la=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %r13,64(%r1=
5)
>> =C2=A0 10:=C2=A0=C2=A0 aghi=C2=A0=C2=A0=C2=A0 %r15,-96
>> =C2=A0 14:=C2=A0=C2=A0 llgh=C2=A0=C2=A0=C2=A0 %r3,4(%r2,%r0)
>> =C2=A0 1a:=C2=A0=C2=A0 srl=C2=A0=C2=A0=C2=A0=C2=A0 %r3,16
>> =C2=A0 1e:=C2=A0=C2=A0 llgfr=C2=A0=C2=A0 %r3,%r3
>> =C2=A0 22:=C2=A0=C2=A0 lgfi=C2=A0=C2=A0=C2=A0 %r14,0
>> =C2=A0 28:=C2=A0=C2=A0 lgr=C2=A0=C2=A0=C2=A0=C2=A0 %r2,%r14
>> =C2=A0 2c:=C2=A0=C2=A0 lmg=C2=A0=C2=A0=C2=A0=C2=A0 %r11,%r15,208(%r15)
>> =C2=A0 32:=C2=A0=C2=A0 br=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %r14
>>=20
>>=20
>> * size=3D2, offset=3D2, 0: (69) r2 =3D *(u16 *)(r1 +38)
>> bpf_prog_5e3d8e92223c6841:
>> =C2=A0=C2=A0 0:=C2=A0=C2=A0 j=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0000=
000000000006
>> =C2=A0=C2=A0 4:=C2=A0=C2=A0 nopr
>> =C2=A0=C2=A0 6:=C2=A0=C2=A0 stmg=C2=A0=C2=A0=C2=A0 %r11,%r15,112(%r15)
>> =C2=A0=C2=A0 c:=C2=A0=C2=A0 la=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %r13,64(%r1=
5)
>> =C2=A0 10:=C2=A0=C2=A0 aghi=C2=A0=C2=A0=C2=A0 %r15,-96
>> =C2=A0 14:=C2=A0=C2=A0 llgh=C2=A0=C2=A0=C2=A0 %r3,4(%r2,%r0)
>> =C2=A0 1a:=C2=A0=C2=A0 lgfi=C2=A0=C2=A0=C2=A0 %r14,0
>> =C2=A0 20:=C2=A0=C2=A0 lgr=C2=A0=C2=A0=C2=A0=C2=A0 %r2,%r14
>> =C2=A0 24:=C2=A0=C2=A0 lmg=C2=A0=C2=A0=C2=A0=C2=A0 %r11,%r15,208(%r15)
>> =C2=A0 2a:=C2=A0=C2=A0 br=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %r14
>>=20
>> Now, we right shift the value when loading
>>=20
>> =C2=A0 *(u16 *)(r1 +36)
>>=20
>> which in C BPF is equivalent to
>>=20
>> =C2=A0 *((__u16 *)&ctx->remote_port + 0)
>>=20
>> due to how the shift is calculated by bpf_ctx_narrow_access_offset().
>
> Right, that's exactly the intention here.
> The way I see the situation is: the ABI forces us to treat remote_port
> as a 32-bit field, even though the updated header now says otherwise.
> And this:
>
>     unsigned int remote_port;
>     unsigned short result =3D *(unsigned short *)remote_port;
>
> should be the same as:
>
>     unsigned short result =3D remote_port >> 16;
>
> on big-endian. Note that this is inherently non-portable.





>
>> This makes the expected typical use-case
>>=20
>> =C2=A0 ctx->remote_port =3D=3D bpf_htons(8008)
>>=20
>> fail on s390x because llgh (Load Logical Halfword (64<-16)) seems to
>> lay
>> out the data in the destination register so that it holds
>> 0x0000_0000_0000_1f48.
>>=20
>> I don't know that was the intention here, as it makes the BPF C code
>> non-portable.
>>=20
>> WDYT?
>
> This depends on how we define the remote_port field. I would argue that
> the definition from patch 2 - even though ugly - is the correct one.
> It is consistent with both the little-endian (1f 48 00 00) and
> big-endian (00 00 1f 48) ABIs.
>
> I don't think the current definition is correct, because it expects
> 1f 48 00 00 on big-endian, and this is not the case. We can verify this
> by taking 9a69e2^ and applying
>
> --- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
> +++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
> @@ -417,6 +417,8 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
>                 return SK_DROP;
>         if (LSW(ctx->remote_port, 0) !=3D SRC_PORT)
>                 return SK_DROP;
> +       if (ctx->remote_port !=3D SRC_PORT)
> +               return SK_DROP;
>=20=20
>         /* Narrow loads from local_port field. Expect DST_PORT. */
>         if (LSB(ctx->local_port, 0) !=3D ((DST_PORT >> 0) & 0xff) ||
>
> Therefore that
>
>   ctx->remote_port =3D=3D bpf_htons(8008)
>
> fails without patch 2 is as expected.
>

Consider this - today the below is true on both LE and BE, right?

  *(u32 *)&ctx->remote_port =3D=3D *(u16 *)&ctx->remote_port

because the loads get converted to:

  *(u16 *)&ctx_kern->sport =3D=3D *(u16 *)&ctx_kern->sport

IOW, today, because of the bug that you are fixing here, the data layout
changes from the PoV of the BPF program depending on the load size.

With 2-byte loads, without this patch, the data layout appears as:

  struct bpf_sk_lookup {
    ...
    __be16 remote_port;
    __be16 remote_port;
    ...
  }

While for 4-byte loads, it appears as in your 2nd patch:

  struct bpf_sk_lookup {
    ...
    #if little-endian
    __be16 remote_port;
    __u16  :16; /* zero padding */
    #elif big-endian
    __u16  :16; /* zero padding */
    __be16 remote_port;
    #endif
    ...
  }

Because of that I don't see how we could keep complete ABI compatiblity,
and have just one definition of struct bpf_sk_lookup that reflects
it. These are conflicting requirements.

I'd bite the bullet for 4-byte loads, for the sake of having an
endian-agnostic struct bpf_sk_lookup and struct bpf_sock definition in
the uAPI header.

The sacrifice here is that the access converter will have to keep
rewriting 4-byte access to bpf_sk_lookup.remote_port and
bpf_sock.dst_port in this unexpected, quirky manner.

The expectation is that with time users will recompile their BPF progs
against the updated bpf.h, and switch to 2-byte loads. That will make
the quirk in the access converter dead code in time.

I don't have any better ideas. Sorry.

[...]
