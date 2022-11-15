Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2709062A308
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 21:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiKOUfE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 15:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237988AbiKOUeu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 15:34:50 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259D9317CC
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 12:31:38 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id n20so18428337ejh.0
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 12:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6mXQOLeJBGVOTnzysraU5Ywc7/ubdKwT+EU2qDyigrU=;
        b=bpWULRQTIn46sMGU8yKsRfuNodh4710oz3elrkea70Zit//Wj8rXPYA/kboO1zt+Bv
         ZfG/HXeSSF4JNlyenqTrsRE344W6hi3DbrAtd+Nov+khSJEjFrzk9O3oMNXRjG+6FR4g
         8nVTt3kyNswuCuFzDx5unRto7wVzvwrUT6pm91z/qxc+ZlWb2efhkAIuGnQ3IVw5UQvB
         8arR4xtTEVg8RgaeJAzfSgM5tDqE1cNa5E4Jalw1BUvmcdsdkmZc9NSx1HJJYpZ/Qdq0
         2MtuXKsT4w0w1tiQwryjtLIAqFOVRIeJd1ZvBqz5DedhvgIo/z9GXUF6nPMzlQ0e4MJo
         mryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mXQOLeJBGVOTnzysraU5Ywc7/ubdKwT+EU2qDyigrU=;
        b=fD7CQw6b47pJPJWiIpu6Ob41OyGvnepp3Y+sPD/XdreqkBmzTQMK+in7v/L5TS5uVP
         khhF29vvaASGr9v0d4VfQsm4Y/5i9+d/n4rc8Y4hHS3Akro2vFzpNUFfFcEEQLblkX6r
         l8wENx9QMx9gcwA7ERHtpp5Pf0QPHBEb7jIDXRZC+758fxzsTjIEHYwDUOehLyoJGk4H
         XzvA0/JmizfHazhlTOP1BhetY2/FFQYzzHtoUK9KDu/CSlGL50VBv5r4H1YvMwmYv1Bi
         kzH4AaEzZKznSsK9vkTJywMcM4j+H3ecsQFzK4vPNcAJS1Xphg59yH0rKbFfTdK50sVz
         jSqQ==
X-Gm-Message-State: ANoB5pnn9GoC/JaUiaELyXGHOAhbliE4hIhHXj2CKvvye7g3zT2osiBR
        4TI1Z+9p6OjP6ZVJYmRTpQDT18k+eJC2pfUh
X-Google-Smtp-Source: AA0mqf45BgGlZe6iGmw+fpmG0dtFPEF0pub2PMyr+fDK5rvZjnMdcfC0AaMbA4ta+UDnmXntu2BD8g==
X-Received: by 2002:a17:906:dffc:b0:79e:8360:8c3d with SMTP id lc28-20020a170906dffc00b0079e83608c3dmr15958426ejc.146.1668544296587;
        Tue, 15 Nov 2022 12:31:36 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id u14-20020aa7d98e000000b004611c230bd0sm5297232eds.37.2022.11.15.12.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 12:31:36 -0800 (PST)
Message-ID: <9c6f292415c36ea8409eaee466b197bb0ba7f02d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: check nullness propagation
 for reg to reg comparisons
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Date:   Tue, 15 Nov 2022 22:31:34 +0200
In-Reply-To: <CAADnVQLhcEduU3JahFSGEhv3V56FuWhFfwsgGE1JHSrCBiOf2Q@mail.gmail.com>
References: <20220826172915.1536914-1-eddyz87@gmail.com>
         <20220826172915.1536914-3-eddyz87@gmail.com>
         <CAADnVQLhcEduU3JahFSGEhv3V56FuWhFfwsgGE1JHSrCBiOf2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-11-14 at 10:01 -0800, Alexei Starovoitov wrote:
> On Fri, Aug 26, 2022 at 10:30 AM Eduard Zingerman <eddyz87@gmail.com> wro=
te:
> >=20
> > Verify that nullness information is porpagated in the branches of
> > register to register JEQ and JNE operations.
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > Acked-by: Yonghong Song <yhs@fb.com>
> > ---
> >  .../bpf/verifier/jeq_infer_not_null.c         | 166 ++++++++++++++++++
> >  1 file changed, 166 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/verifier/jeq_infer_not_=
null.c
>=20
> These 4 new tests are failing in unpriv.

This is interesting. 'test_verifier' passed for me because of
kernel.unprivileged_bpf_disabled =3D 1 on my test VM.
But It also passed on CI ([1]) with the following log:

2022-11-06T21:15:53.2873411Z #686/u jne/jeq infer not null, PTR_TO_SOCKET_O=
R_NULL -> PTR_TO_SOCKET for JNE false branch SKIP
2022-11-06T21:15:53.2908232Z #686/p jne/jeq infer not null, PTR_TO_SOCKET_O=
R_NULL -> PTR_TO_SOCKET for JNE false branch OK

To skip or not to skip is decided by test_verifier.c:do_test:

		if (test_as_unpriv(test) && unpriv_disabled) {
			printf("#%d/u %s SKIP\n", i, test->descr);
			skips++;
		}

The 'test_as_unpriv(test)' is true for my tests because of the
.prog_type =3D=3D BPF_PROG_TYPE_CGROUP_SKB.
'unpriv_disabled' is a global set by test_verifier.c:get_unpriv_disabled:

static void get_unpriv_disabled()
{
	char buf[2];
	FILE *fd;

	fd =3D fopen("/proc/sys/"UNPRIV_SYSCTL, "r");
        // ...
	if (fgets(buf, 2, fd) =3D=3D buf && atoi(buf))
		unpriv_disabled =3D true;
	fclose(fd);
}

Might it be the case that CI configuration needs an update as below:
sysctl kernel.unprivileged_bpf_disabled=3D0
?

[1] https://github.com/kernel-patches/bpf/actions/runs/3405978658/jobs/5664=
441527

>=20
> Pls fix and respin.

