Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A816D08AA
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 16:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjC3OtC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 10:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjC3OtA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 10:49:00 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB9A1FE8
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 07:48:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id q16so24834643lfe.10
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680187736; x=1682779736;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bT9/KweIFxMOi9SPU4gCo6npfpog5ox2uB4T4GUBbNA=;
        b=jwAOIKyu2d/Asp8txUD2Xe7+ez4MNYflVXd+IxpMcJ8MZMTitXaN1QQgqlnMJeQIxf
         gg6eR0N95COEQnGbkSnPR1p5SaBL47jlVvF6MOhannAUgmr9q/y+l1FLflgA56evMckB
         zgfsuL2IqmRu3vruz+qX6cGPsQRWOdNQ0iPM/B8KgcNm0zZ6tlxhTDzJj370lVlgnXJJ
         GjN4Q/KYINKaypiKmLXrT+w+kYqtgaauI522EjBnKDVb81PXvcPP/DgwJqKwjjfzCuqg
         WK+PK0gQVBPUrncwXkvvMTYHyulYXEUEKKxsNzvBPfGtXYd2Z4MDvKjyiaH66eGoc3QB
         MohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680187736; x=1682779736;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bT9/KweIFxMOi9SPU4gCo6npfpog5ox2uB4T4GUBbNA=;
        b=ySqn7dbKje0zoU61v6BJQHmTIbZ44KPIIozzbnAFwxE9wVHMXiZxHcZeOhkj8/+9ji
         EN7GVeYHpyH3GuQychFKXEjVENGJxoLW6Lltm104kodxljNiimqDWPsiATs25CwnpzUl
         9G5vt6CvbNq9H9mnhS+qRN7lSbKqlTmG+sTSJczMyE6J3O+M8vZCaFuwMlVyRHC/R0cb
         hePoYftoS6Jf0BAx5PTKlepzNd5TWf9qHzXsDoxq5uU5T+CBsOD3udfkKPzKy1oyoQAY
         mPtiW/7lqh8LgE9wFXTQ6lZgB+J0WDPNTNpZhW7p5/kkmIZTpDDcFdtfz2G/b2jEHCEx
         g7EA==
X-Gm-Message-State: AAQBX9dkl0mppmj0OJEvJanoVe52SYShcn3mXhKOENn3uIaspbGAaxIf
        TUVlhvpRGiNbzLm5gC3UJG0=
X-Google-Smtp-Source: AKy350aadBSAV6+q+vAuuVZVb6KIepMCBMfO0Cx6NsCaarYrBb7SYmiyR62XFDvNSvUc8NKl51yNpw==
X-Received: by 2002:a05:6512:991:b0:4eb:29b0:1ca3 with SMTP id w17-20020a056512099100b004eb29b01ca3mr792849lft.6.1680187736203;
        Thu, 30 Mar 2023 07:48:56 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004d85789cef1sm5937290lfn.49.2023.03.30.07.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 07:48:55 -0700 (PDT)
Message-ID: <b4b8406f9a08283308d4c3d597db158319801aff.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/3] veristat: guess and substitue
 underlying program type for freplace (EXT) progs
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@meta.com>
Date:   Thu, 30 Mar 2023 17:48:53 +0300
In-Reply-To: <CAADnVQ+hSFfkcJ=Ni_4UnW5sx93GdBMKSGcT1RujWkaonZN-OQ@mail.gmail.com>
References: <20230327185202.1929145-1-andrii@kernel.org>
         <20230327185202.1929145-4-andrii@kernel.org>
         <09709d267f92856f5fd5293bd81bbe1ada4b41bc.camel@gmail.com>
         <CAADnVQ+hSFfkcJ=Ni_4UnW5sx93GdBMKSGcT1RujWkaonZN-OQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2023-03-29 at 22:38 -0700, Alexei Starovoitov wrote:
> On Wed, Mar 29, 2023 at 11:36=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Mon, 2023-03-27 at 11:52 -0700, Andrii Nakryiko wrote:
> > > SEC("freplace") (i.e., BPF_PROG_TYPE_EXT) programs are not loadable a=
s
> > > is through veristat, as kernel expects actual program's FD during
> > > BPF_PROG_LOAD time, which veristat has no way of knowing.
> > >=20
> > > Unfortunately, freplace programs are a pretty important class of
> > > programs, especially when dealing with XDP chaining solutions, which
> > > rely on EXT programs.
> > >=20
> > > So let's do our best and teach veristat to try to guess the original
> > > program type, based on program's context argument type. And if guessi=
ng
> > > process succeeds, we manually override freplace/EXT with guessed prog=
ram
> > > type using bpf_program__set_type() setter to increase chances of prop=
er
> > > BPF verification.
> > >=20
> > > We rely on BTF and maintain a simple lookup table. This process is
> > > obviously not 100% bulletproof, as valid program might not use contex=
t
> > > and thus wouldn't have to specify correct type. Also, __sk_buff is ve=
ry
> > > ambiguous and is the context type across many different program types=
.
> > > We pick BPF_PROG_TYPE_CGROUP_SKB for now, which seems to work fine in
> > > practice so far. Similarly, some program types require specifying att=
ach
> > > type, and so we pick one out of possible few variants.
> > >=20
> > > Best effort at its best. But this makes veristat even more widely
> > > applicable.
> > >=20
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >=20
> > I left one nitpick below, otherwise looks good.
> >=20
> > I tried in on freplace programs from selftests and only 3 out 18
> > programs verified correctly, others complained about unavailable
> > functions or exit code not in range [0, 1], etc.
> > Not sure, if it's possible to select more permissive attachment kinds, =
though.
> >=20
> > Tested-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> Thanks for testing and important feedback.
> I've applied the set. The nits can be addressed in the follow up.
>=20
> What do you have in mind as 'more permissive attach' ?
> What are those 15 out of 18 with invalid exit code?
> What kind of attach_type will help?

TLDR: I apologize, it was a bad comment.
      Should have done more analysis yesterday and withheld from commenting=
.

---

Inspected each program and it turned out that most of the failing ones
are either not programs but separate functions, or have __skb_buf parameter=
.
The summary table is at the end of the email, here is the list of those
that should load but fail:

- Have __skb_buf parameter and attach to SEC("tc")
  - fexit_bpf2bpf.bpf.o:new_get_skb_len
  - freplace_cls_redirect.bpf.o:freplace_cls_redirect_test
  - freplace_global_func.bpf.o:new_test_pkt_access
- Need ifindex to be specified prior loading:
  - xdp_metadata2.bpf.o:freplace_rx
                                                                           =
 Should
File                            Program                            Verdict =
 fail?   Reason
------------------------------  ---------------------------------  ------- =
 ------  -----------------------
fexit_bpf2bpf.bpf.o             new_get_constant                   failure =
     no  Function, not a program
fexit_bpf2bpf.bpf.o             new_get_skb_ifindex                failure =
     no  Function, not a program
fexit_bpf2bpf.bpf.o             new_get_skb_len                    failure =
     no  __sk_buff parameter
fexit_bpf2bpf.bpf.o             new_test_pkt_write_access_subprog  failure =
     no  Function, not a program
fexit_bpf2bpf.bpf.o             test_main                          failure =
     no  Function, not a program
fexit_bpf2bpf.bpf.o             test_subprog1                      failure =
     no  Function, not a program
fexit_bpf2bpf.bpf.o             test_subprog2                      failure =
     no  Function, not a program
fexit_bpf2bpf.bpf.o             test_subprog3                      failure =
     no  Function, not a program
freplace_attach_probe.bpf.o     new_handle_kprobe                  failure =
    yes
freplace_cls_redirect.bpf.o     freplace_cls_redirect_test         failure =
     no  __sk_buff parameter
freplace_connect4.bpf.o         new_do_bind                        failure =
    yes=20
freplace_connect_v4_prog.bpf.o  new_connect_v4_prog                failure =
    yes
freplace_get_constant.bpf.o     security_new_get_constant          failure =
     no  Function, not a program
freplace_global_func.bpf.o      new_test_pkt_access                failure =
     no  __sk_buff parameter
freplace_progmap.bpf.o          xdp_cpumap_prog                    success
freplace_progmap.bpf.o          xdp_drop_prog                      success
test_trace_ext.bpf.o            test_pkt_md_access_new             success
xdp_metadata2.bpf.o             freplace_rx                        failure =
     no  needs ifindex
------------------------------  ---------------------------------  ------- =
 ------- -----------------------
