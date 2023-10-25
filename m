Return-Path: <bpf+bounces-13242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B592A7D6C47
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 14:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4535FB21177
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 12:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A32E26E34;
	Wed, 25 Oct 2023 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lb+hckQO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE291D694
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 12:48:40 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF3F8F;
	Wed, 25 Oct 2023 05:48:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99de884ad25so847907866b.3;
        Wed, 25 Oct 2023 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698238117; x=1698842917; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lDBBO9aUCbmnvIZqszT/VX5ewolQMx9uvDoEXdeJOhE=;
        b=lb+hckQOtQWGzMyr7V3MIZ1DzVm8mWTBcThl8Ow9Kt5k4aBqZPq23QCIRv+urhBIea
         GhJ55ui8BCvwde5NwPE9uhjUk6cYzBQRE+62h3L+NN9MO2gWtk3cLnXdjEFo9iRB9mmQ
         yP2pbZfNpeYa09YTZlOTeRq9skipDhy/nFtfhKlYBccWA5kko8J0QIuWkoqDT7j82XXz
         68EiPNBoTCtVLNU2o72zFl0VPsDEBmJbsfcDKl9uxUwCwRXd5JSt0lFQBEmkWJkwLgUl
         vFWvcQHd87jVZF8JPJxeIQmS5GF+UuuvhmZ6P/AdizGUQAshoVeOrfFVAqgxOuH7S/ug
         enuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698238117; x=1698842917;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDBBO9aUCbmnvIZqszT/VX5ewolQMx9uvDoEXdeJOhE=;
        b=jvKmz/VMPVfmjrP+IDAcKvxZ/j0VM1vutn3vG/GTFJZqtUxJp3fjoopazN+KmDHrVf
         EleFxknw5BBAtlX2U/ryPbwSHtgo8kz5ySl9xHjF09g6Lbvkj0luYBnihEkRoytxu2bJ
         NW4L1jWfrp+BN6XNkllNp3+by+KYOmSvB+Ob+iUbzCaz2S/ICznCIk2+TRrVMBUPZBPD
         UdA7jexHFspn3w/bHiuSXUvZN1wvpM3EeE3oQZLnV52RvbOSReusi58C9Gc5EJOIu6L+
         N22+HYbl/UiW4ZKtDlFKCF9BlaTFBYiV2Cv7mZCWEJRAHbufk1rGwSmNtgLuLqq+9ieC
         NMTw==
X-Gm-Message-State: AOJu0YzTRUtSuMfAxiQu2QUwPN4CeevHz+ZULbuJBAZHZLxqUOw24Tvi
	jj4Kt/Td3LgK9I3NVaZ2o68=
X-Google-Smtp-Source: AGHT+IH+xdgf9ka4i9aSARe9WHYkOgLKKx49YPXySZZiohb5wLd1cbMImnZ/gvJA8JPNPVl2YXGE7g==
X-Received: by 2002:a17:907:1c93:b0:9a5:c54f:da1c with SMTP id nb19-20020a1709071c9300b009a5c54fda1cmr12370080ejc.47.1698238117148;
        Wed, 25 Oct 2023 05:48:37 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090606c800b009b27d4153c0sm9874738ejb.178.2023.10.25.05.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 05:48:36 -0700 (PDT)
Message-ID: <940ed5abeb10f8e56d28dd003f2e771fc416fb3b.camel@gmail.com>
Subject: Re: bpf: incorrect value spill in check_stack_write_fixed_off()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux Kernel Mailing List
	 <linux-kernel@vger.kernel.org>
Date: Wed, 25 Oct 2023 15:48:35 +0300
In-Reply-To: <17e03fa708cf0c1d297c2fa3d139a22a358a65e7.camel@gmail.com>
References: 
	<CACkBjsYXA8myxoP0Naz=ZxB0FWG-xS9e28CSFffGk1bA_n5RXw@mail.gmail.com>
	 <17e03fa708cf0c1d297c2fa3d139a22a358a65e7.camel@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-10-25 at 15:14 +0300, Eduard Zingerman wrote:
> On Wed, 2023-10-25 at 11:16 +0200, Hao Sun wrote:
> > Hi,
> >=20
> > In check_stack_write_fixed_off(), the verifier creates a fake reg to st=
ore the
> > imm in a BPF_ST_MEM:
> > ...
> > else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
> > insn->imm !=3D 0 && env->bpf_capable) {
> >         struct bpf_reg_state fake_reg =3D {};
> >=20
> >         __mark_reg_known(&fake_reg, (u32)insn->imm);
> >         fake_reg.type =3D SCALAR_VALUE;
> >         save_register_state(state, spi, &fake_reg, size);
> >=20
> > Here, insn->imm is cast to u32, and used to mark fake_reg, which is inc=
orrect
> > and may lose sign information.
>=20
> This bug is on me.
> Thank you for reporting it along with the example program.
> Looks like the patch below is sufficient to fix the issue.
> Have no idea at the moment why I used u32 cast there.
> Let me think a bit more about it and I'll submit an official patch.

Yeap, I see no drawbacks in that patch, imm field is declared as s32,
so it would be correctly sign extended by compiler before cast to u64,
so there is no need for additional casts.
It would be wrong if I submit the fix, because you've done all the work.
Here is a refined test-case to be placed in verifier/bpf_st_mem.c
(be careful with \t, test_verifier uses those as glob marks inside errstr).

{
	"BPF_ST_MEM stack imm sign",
	/* Check if verifier correctly reasons about sign of an
	 * immediate spilled to stack by BPF_ST instruction.
	 *
	 *   fp[-8] =3D -44;
	 *   r0 =3D fp[-8];
	 *   if r0 s< 0 goto ret0;
	 *   r0 =3D -1;
	 *   exit;
	 * ret0:
	 *   r0 =3D 0;
	 *   exit;
	 */
	.insns =3D {
	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, -44),
	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
	BPF_JMP_IMM(BPF_JSLT, BPF_REG_0, 0, 2),
	BPF_MOV64_IMM(BPF_REG_0, -1),
	BPF_EXIT_INSN(),
	BPF_MOV64_IMM(BPF_REG_0, 0),
	BPF_EXIT_INSN(),
	},
	/* Use prog type that requires return value in range [0, 1] */
	.prog_type =3D BPF_PROG_TYPE_SK_LOOKUP,
	.expected_attach_type =3D BPF_SK_LOOKUP,
	.result =3D VERBOSE_ACCEPT,
	.runs =3D -1,
	.errstr =3D "0: (7a) *(u64 *)(r10 -8) =3D -44        ; R10=3Dfp0 fp-8_w=3D=
-44\
	2: (c5) if r0 s< 0x0 goto pc+2\
	2: R0_w=3D-44",
},

