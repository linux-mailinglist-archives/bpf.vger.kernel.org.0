Return-Path: <bpf+bounces-11353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3B67B7C94
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 11:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7044F281661
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 09:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042CD10A37;
	Wed,  4 Oct 2023 09:50:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FAC10953
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 09:50:02 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CDDAC
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 02:50:00 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50305abe5f0so2325235e87.2
        for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 02:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696412998; x=1697017798; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WaqABCba+h5Kkdv9mMZsi1R5T6BxGKMMp1DcRAtZMDQ=;
        b=LZeEsh6Chxib7jXPxyaIqwanB1dr8970KTN/8FuA1ZkJ4H6Rt8Ez7/FY/K/g34GSkZ
         ozE7Msy2BkWQUId1OFMniATW+TMUIGHdjflmk/0pROYerQkjIl4kexaVzCrIl4eqcDZu
         Pu+l4zdYmYGO+RrKx75IJsE6L0B2etc/l/2HWqmwxeH8TyZ+RxBf4Gk9qLi33m2S2ZXj
         DFfDhJHXXPGNQvSZVL5A/7Jlp58sdi0VIWPVy08yDI/Bcf5bXnQReGLbfVpicIwGSF2I
         gaf0sJqZ4gewvMdwSBg3d6ACUfj9icuB5GGM51iq28URqySIJ61qqerYB7qlxBic1ACj
         teBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696412998; x=1697017798;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaqABCba+h5Kkdv9mMZsi1R5T6BxGKMMp1DcRAtZMDQ=;
        b=TisssODcYnqHmPElm62AKE9DkIgdkuTo8gs/o0gBDzDmuZbQIguUyJ1ZFX4afsMNkG
         Awo8DexrNDrZSBGrHzTcTcgBnaPWAoy3rVk/EDUZkMfGACC8S1/P1Yvx2O142MnAL2HA
         OGJfGa1QoCJ9J6x2HBS7fqFvfgw0UHxAXnJ9A/PsBzqpq2pbbTeKeKqCg1iASFt0QRCe
         6161fwuGaV2yncJLhm3l755pgPCvpIOo+Nahr05/g7YyYtkT6FY5ivWvzmrQGO+ADkxz
         MoOqUvmEX/WHa6m7GW+gzs9w31/cNWFxbLdgTTUV1dZ1ddwgAnHtWSGWjuL1Togw9Iie
         sAkg==
X-Gm-Message-State: AOJu0YxuinK++7jMJlVioNeBoyToRnPzkeQ7V4Pc03cKMNT2Zkm6MFAS
	K+AjR1QPhoac7CWs4imE3ZMkIjKQj3T2Eg==
X-Google-Smtp-Source: AGHT+IFp9pxXCxSmFsnjkQFfP5V6iBpDCtMnQt/gEzHLuQrHIWh9Abc6ZMPlVTT1+DD3DnkO+R+Vjw==
X-Received: by 2002:a05:6512:118f:b0:500:adbd:43e9 with SMTP id g15-20020a056512118f00b00500adbd43e9mr1861817lfr.15.1696412997942;
        Wed, 04 Oct 2023 02:49:57 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d24-20020ac241d8000000b0050089b26eb0sm526120lfi.132.2023.10.04.02.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 02:49:57 -0700 (PDT)
Message-ID: <dd7034bb8f51807d812487dd65aff2f909382ff1.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 04 Oct 2023 12:49:55 +0300
In-Reply-To: <CAADnVQK9OjhmXOUSUy4=ZvwUiPBmtB=g99=OcOCnT6ZqsPCJGA@mail.gmail.com>
References: 
	<CAADnVQJbKf5PgL5fokJAB4y5+5iqKd17W9e0P6q=vJPQM+9NJQ@mail.gmail.com>
	 <9dd331b31755632f0528bfb1d0acbf904cedbd98.camel@gmail.com>
	 <CAADnVQLNAzjTpyE7UcnD0Q0-p4fvL6u_3_B54o6ttBBvBv7rFw@mail.gmail.com>
	 <680e69504eabbae2abd5e9e2b745319c561c86ef.camel@gmail.com>
	 <CAADnVQL5ausgq5ERiMKn+Y-Nrp32e2WTq3s5JVJCDojsR0ZF+A@mail.gmail.com>
	 <8b75e01d27696cd6661890e49bdc06b1e96092c7.camel@gmail.com>
	 <CAADnVQLTe2=K1nTk+Ry8WmBU1C724paoT8p8_7jYL9oymchp_A@mail.gmail.com>
	 <5b7f4b6199decf266a9218b674c232662ed13db5.camel@gmail.com>
	 <20231003230820.iazvofhysfmurwon@MacBook-Pro-49.local>
	 <3d88ede5cbe38ae96be0c148770454b2344fdcce.camel@gmail.com>
	 <20231004025731.ft7xjnr2nxdhxjq5@MacBook-Pro-49.local>
	 <CAADnVQK9OjhmXOUSUy4=ZvwUiPBmtB=g99=OcOCnT6ZqsPCJGA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: multipart/mixed; boundary="=-I7sf5AKhnRvgCYTyaHin"
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--=-I7sf5AKhnRvgCYTyaHin
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2023-10-03 at 22:50 -0700, Alexei Starovoitov wrote:
> On Tue, Oct 3, 2023 at 7:57=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >=20
> > ok. discard that idea.
>=20
> Attached is a 3rd version of the same idea I argued earlier.
> Let normal DFS go as normal,
> do states_equal() on V which has 1 looping branch remain
> and all other explored.
> To achieve that when iter_next() is seen do parent->looping_states +=3D 2=
;
>=20
> then when processing any children do parent->looping_states++;
> in the correct parent.
> Since there could be many intermediate states have to walk back
> parentage chain to increment correct parent.
> When the state reaches bpf_exit or safety, walk back
> the parentage chain and do looping_states--.
> The state is ok to use in states_equal() if looping_states=3D=3D1.

But what if each next iteration spawns more than two looping states?
E.g. for the following example:

  0. // full test attached as a patch
  1. while (next(i)) {
  2.   if (random())
  3.     continue;
  4.   if (random())
  5.     continue;
  6.   if (random())
  7.     continue;
  8.   r0 +=3D 0;
  9. }

For me it bails out with the following message:

    run_subtest:FAIL:unexpected_load_failure unexpected error: -28
    ....
    The sequence of 8193 jumps is too complex.
    processed 49161 insns (limit 1000000) max_states_per_insn 4 total_state=
s 2735 peak_states 2735 mark_read 2

(I bumped insn complexity limit back to 1,000,000).

> With this patch all existing iter tests still pass,
> and all Ed's special tests pass or fail as needed.
> Ex: loop_state_deps1 is rejected with misaligned stack,
> loop1 loads with success, num_iter_bug fails with bad pointer.

Are you sure that correct version of the patch was shared?
I get the following log for loop_state_deps1:

    run_subtest:FAIL:unexpected_load_success unexpected success: 0
    from 21 to 22: safe
    ...
    update_br2 80c0 branches=3D0/0
    processed 75 insns (limit 1000000) max_states_per_insn 2 total_states 2=
9 peak_states 29 mark_read 9
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    #104/26  iters/loop_state_deps1:FAIL

The test case is marked as safe.
iter_precision_fixed_point{1,2} and num_iter_bug work as expected.

--=-I7sf5AKhnRvgCYTyaHin
Content-Disposition: attachment; filename="hydra1.patch"
Content-Type: text/x-patch; name="hydra1.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvdmVyaWZpZXIuYyBiL2tlcm5lbC9icGYvdmVyaWZpZXIu
YwppbmRleCAwMTljOGRkZTVmYTIuLmNmOTA0MWZhYzI3MiAxMDA2NDQKLS0tIGEva2VybmVsL2Jw
Zi92ZXJpZmllci5jCisrKyBiL2tlcm5lbC9icGYvdmVyaWZpZXIuYwpAQCAtMTY4MjEsNyArMTY4
MjEsNyBAQCBzdGF0aWMgaW50IGRvX2NoZWNrKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYp
CiAJCWluc24gPSAmaW5zbnNbZW52LT5pbnNuX2lkeF07CiAJCWNsYXNzID0gQlBGX0NMQVNTKGlu
c24tPmNvZGUpOwogCi0JCWlmICgrK2Vudi0+aW5zbl9wcm9jZXNzZWQgPiAxMDAwKSB7Ly9CUEZf
Q09NUExFWElUWV9MSU1JVF9JTlNOUykgeworCQlpZiAoKytlbnYtPmluc25fcHJvY2Vzc2VkID4g
QlBGX0NPTVBMRVhJVFlfTElNSVRfSU5TTlMpIHsKIAkJCXZlcmJvc2UoZW52LAogCQkJCSJCUEYg
cHJvZ3JhbSBpcyB0b28gbGFyZ2UuIFByb2Nlc3NlZCAlZCBpbnNuXG4iLAogCQkJCWVudi0+aW5z
bl9wcm9jZXNzZWQpOwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3By
b2dzL2l0ZXJzLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvaXRlcnMuYwpp
bmRleCA5YWRkNzFkNzlhM2EuLmYwODI4OGMwYjc0YSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL3Byb2dzL2l0ZXJzLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvYnBmL3Byb2dzL2l0ZXJzLmMKQEAgLTk5MSw0ICs5OTEsNDIgQEAgaW50IG51bV9pdGVyX2J1
Zyhjb25zdCB2b2lkICpjdHgpIHsKICAgICAgcmV0dXJuIDA7CiB9CiAKK1NFQygiP3Jhd190cCIp
CitfX3N1Y2Nlc3MKK19fbmFrZWQgaW50IGh5ZHJhMSh2b2lkKQoreworCWFzbSB2b2xhdGlsZSAo
CisJCSJyMSA9IHIxMDsiCisJCSJyMSArPSAtODsiCisJCSJyMiA9IDA7IgorCQkicjMgPSAxMDsi
CisJCSJjYWxsICVbYnBmX2l0ZXJfbnVtX25ld107IgorCSJsb29wXyU9OiIKKwkJInIxID0gcjEw
OyIKKwkJInIxICs9IC04OyIKKwkJImNhbGwgJVticGZfaXRlcl9udW1fbmV4dF07IgorCQkiaWYg
cjAgPT0gMCBnb3RvIGxvb3BfZW5kXyU9OyIKKwkJImNhbGwgJVticGZfZ2V0X3ByYW5kb21fdTMy
XTsiCisJCSJpZiByMCAhPSA0MiBnb3RvIGxvb3BfJT07IgorCQkiY2FsbCAlW2JwZl9nZXRfcHJh
bmRvbV91MzJdOyIKKwkJImlmIHIwICE9IDQyIGdvdG8gbG9vcF8lPTsiCisJCSJjYWxsICVbYnBm
X2dldF9wcmFuZG9tX3UzMl07IgorCQkiaWYgcjAgIT0gNDIgZ290byBsb29wXyU9OyIKKwkJInIw
ICs9IDA7IgorCQkiZ290byBsb29wXyU9OyIKKwkibG9vcF9lbmRfJT06IgorCQkicjEgPSByMTA7
IgorCQkicjEgKz0gLTg7IgorCQkiY2FsbCAlW2JwZl9pdGVyX251bV9kZXN0cm95XTsiCisJCSJy
MCA9IDA7IgorCQkiZXhpdDsiCisJCToKKwkJOiBfX2ltbShicGZfZ2V0X3ByYW5kb21fdTMyKSwK
KwkJICBfX2ltbShicGZfaXRlcl9udW1fbmV3KSwKKwkJICBfX2ltbShicGZfaXRlcl9udW1fbmV4
dCksCisJCSAgX19pbW0oYnBmX2l0ZXJfbnVtX2Rlc3Ryb3kpCisJCTogX19jbG9iYmVyX2FsbAor
CSk7Cit9CisKIGNoYXIgX2xpY2Vuc2VbXSBTRUMoImxpY2Vuc2UiKSA9ICJHUEwiOwo=


--=-I7sf5AKhnRvgCYTyaHin--

