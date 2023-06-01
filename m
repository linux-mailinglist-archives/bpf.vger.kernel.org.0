Return-Path: <bpf+bounces-1603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE5371EFE1
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 18:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272E4281887
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B01842535;
	Thu,  1 Jun 2023 16:57:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C8B13AC3
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 16:57:19 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05CF192
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 09:57:17 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f3edc05aa5so1397582e87.3
        for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 09:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685638636; x=1688230636;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G604pGkbCMMTWgC2esRf0pLbX8sUA3xZIjXF59B3rAA=;
        b=fvnBop2xUMgbEH3IS7KOoAoOj+arwCs2FdBMnbBi3Q8QKVOuc2K8OUwBYdFOjyvKRt
         EJLFLq5BYMD86ikxcJvPBe1UKCdJeOHzKDT8W018TaI7DTpJDqRRqoa4ErVEPYqdD8U9
         ruFFgZlv0/h9C76rPz9kWxFJ4Rn5g3kyAtjl9hy7w75Kaip8KPbRZMt98kGT3HRDw4X3
         sN6hqpGpjBenBLnh9PGFl9ivRt4okktGtQIFzHFRx4MWaXBLWH8qklgNE+LSsMJZ+nup
         WRg7NX/RKI6ZsYSEEQU25MdYnPGTzS9rnQZichw6evTKfVgR4pWzKFtLCbBtcc5Y/DV/
         iSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685638636; x=1688230636;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G604pGkbCMMTWgC2esRf0pLbX8sUA3xZIjXF59B3rAA=;
        b=hq3Yuas/5TR55y0m7UglGz5RHCf60MCQk2cI0snAKxV9pBte+Bcv2WuxcgykaJREOi
         HJ51HxaHyZBQCFBRMWTiYdSR2KIaNTc0PRR9aTqA1gGSVVLSyVg6IzZ0TcifIo58FsXw
         eLWrC7m77hHN76mdLbOcbhpD+6Mro/No0ySGnKYjqQzykc0Z5coim715BWQ5kHRJWDIK
         otdNwDYqmmydHPlv+AvoBCW1GZ3ANbRZJ84/qK6y0wLJgOgVKH4J8ZqxHlZSE19Rb64q
         8WNQ3Ylbj8p/7lwkpjuwTSB5jTIaUMMPd8ShWshixeGdGn9C6T8goTk+mbPqJ+tjlDyM
         8dsg==
X-Gm-Message-State: AC+VfDwpg9r0d4SdJ5bMs4ltzppG8bEpY5xh2GZ+9OnOqOSZ1ChUcE8B
	e5ZKuf+ROCUj2WXSiBJDXyg=
X-Google-Smtp-Source: ACHHUZ6eJEX0goDjz60ySHXC9533YeoQEPKiuvFj665zFUjGEQb6t1AKPKQiXikbXH1+GpN06Ye/Uw==
X-Received: by 2002:ac2:454a:0:b0:4f4:b3e2:ff5a with SMTP id j10-20020ac2454a000000b004f4b3e2ff5amr315624lfm.50.1685638635818;
        Thu, 01 Jun 2023 09:57:15 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r26-20020ac252ba000000b004e90dee5469sm1137965lfm.157.2023.06.01.09.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:57:15 -0700 (PDT)
Message-ID: <81e2e47c71b6a0bc014c204e18c6be2736fed338.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  kernel-team@fb.com, yhs@fb.com
Date: Thu, 01 Jun 2023 19:57:14 +0300
In-Reply-To: <20230601020514.vhnlnmowbo6dxwfj@MacBook-Pro-8.local>
References: <20230530172739.447290-1-eddyz87@gmail.com>
	 <20230530172739.447290-2-eddyz87@gmail.com>
	 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
	 <8b0da2244a328f23a78dc73306177ebc6f0eabfd.camel@gmail.com>
	 <20230601020514.vhnlnmowbo6dxwfj@MacBook-Pro-8.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-05-31 at 19:05 -0700, Alexei Starovoitov wrote:
> [...]
> > Suppose that current verification path is 1-7:
> > - On a way down 1-6 r7 will not be marked as precise, because
> >   condition (r7 > X) is not predictable (see check_cond_jmp_op());
> > - When (7) is reached mark_chain_precision() will start moving up
> >   marking the following registers as precise:
> >=20
> >   4: if (r6 > r7) goto +1 ; r6, r7
> >   5: r7 =3D r6              ; r6
> >   6: if (r7 > X) goto ... ; r6
> >   7: r9 +=3D r6             ; r6
> >=20
> > - Thus, if checkpoint is created for (6) r7 would be marked as read,
> >   but will not be marked as precise.
> >  =20
> > Next, suppose that jump from 4 to 6 is verified and checkpoint for (6)
> > is considered:
> > - r6 is not precise, so check_ids() is not called for it and it is not
> >   added to idmap;
> > - r7 is precise, so check_ids() is called for it, but it is a sole
> >   register in the idmap;
>=20
> typos in above?
> r6 is precise and r7 is not precise.

Yes, it should be the other way around in the description:
r6 precise, r7 not precise. Sorry for confusion.

> > - States are considered equal.
> >=20
> > Here is the log (I added a few prints for states cache comparison):
> >=20
> >   from 10 to 13: safe
> >     steq hit 10, cur:
> >       R0=3Dscalar(id=3D2) R6=3Dscalar(id=3D2) R7=3Dscalar(id=3D1) R9=3D=
fp-8 R10=3Dfp0 fp-8=3D00000000
> >     steq hit 10, old:
> >       R6_rD=3DPscalar(id=3D2) R7_rwD=3Dscalar(id=3D2) R9_rD=3Dfp-8 R10=
=3Dfp0 fp-8_rD=3D00000000
>=20
> the log is correct, thouhg.
> r6_old =3D Pscalar which will go through check_ids() successfully and bot=
h are unbounded.
> r7_old is not precise. different id-s don't matter and different ranges d=
on't matter.
>=20
> As another potential fix...
> can we mark_chain_precision() right at the time of R1 =3D R2 when we do
> src_reg->id =3D ++env->id_gen
> and copy_register_state();
> for both regs?

This won't help, e.g. for the original example precise markings would be:

  4: if (r6 > r7) goto +1 ; r6, r7
  5: r7 =3D r6              ; r6, r7
  6: if (r7 > X) goto ... ; r6     <-- mark for r7 is still missing
  7: r9 +=3D r6             ; r6

What might help is to call mark_chain_precision() from
find_equal_scalars(), but I expect this to be very expensive.

> I think
> if (rold->precise && !check_ids(rold->id, rcur->id, idmap))
> would be good property to have.
> I don't like u32_hashset either.
> It's more or less saying that scalar id-s are incompatible with precision=
.
>=20
> I hope we don't need to do:
> +       u32 reg_ids[MAX_CALL_FRAMES];
> for backtracking either.
> Hacking id-s into jmp history is equally bad.
>=20
> Let's figure out a minimal fix.

Solution discussed with Andrii yesterday seems to work.
There is still a performance regression, but much less severe:

$ ./veristat -e file,prog,states -f "states_pct>5" -C master-baseline.log c=
urrent.log
File                      Program                         States (A)  State=
s (B)  States     (DIFF)
------------------------  ------------------------------  ----------  -----=
-----  -----------------
bpf_host.o                cil_to_host                            188       =
  198       +10 (+5.32%)
bpf_host.o                tail_handle_ipv4_from_host             225       =
  243       +18 (+8.00%)
bpf_host.o                tail_ipv6_host_policy_ingress           98       =
  104        +6 (+6.12%)
bpf_xdp.o                 tail_handle_nat_fwd_ipv6               648       =
  806     +158 (+24.38%)
bpf_xdp.o                 tail_lb_ipv4                          2491       =
 2930     +439 (+17.62%)
bpf_xdp.o                 tail_nodeport_nat_egress_ipv4          749       =
  868     +119 (+15.89%)
bpf_xdp.o                 tail_nodeport_nat_ingress_ipv4         375       =
  477     +102 (+27.20%)
bpf_xdp.o                 tail_rev_nodeport_lb4                  398       =
  486      +88 (+22.11%)
loop6.bpf.o               trace_virtqueue_add_sgs                226       =
  251      +25 (+11.06%)
pyperf600.bpf.o           on_event                             22200       =
45095  +22895 (+103.13%)
pyperf600_nounroll.bpf.o  on_event                             34169       =
37235     +3066 (+8.97%)

I need to add a bunch of tests and take a look at pyperf600.bpf.o
before submitting next patch-set version.

