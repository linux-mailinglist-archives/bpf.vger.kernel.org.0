Return-Path: <bpf+bounces-10451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4F07A8282
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 15:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E0C281DBD
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F63341A6;
	Wed, 20 Sep 2023 13:00:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C41B15AE5
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 13:00:14 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FAD91
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 06:00:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-530fa34ab80so1968276a12.0
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695214809; x=1695819609; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUeoV50Y1QAGy1rbgJOwz2l1Heuw6IkYO5VHU7N3r9w=;
        b=D7GAf2LSw4GAjqKA7wBUXC6n9gthqpbuWgJMc4y9lEx4IsFUkFGK2LxSpfoYCTRO65
         s0OAyFQ08rnQykJRCvmj39KOqSTofZyLkSvXTjgd41+PZGmwqyQH8bT2Q3/KLmT1zEoV
         XZZvGiccN89B+DBj8lNeqWKfaZxftzzB9fIs7dbSeczXxxXBDLBoKo2dnyEGxl6zl2Nn
         +WuJdngIBkIhmulR4lgwebo6cmQpbhIllGsWC2qKrHNrnBU8uqXBLOtZKnO+cLLKm967
         rCVHKhhmis4tFXL4n97Ch3JsO8BMlDLCSzZSpC6vZStvq7h8rHc83CgSuHHOnjdFlvYo
         E6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695214809; x=1695819609;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EUeoV50Y1QAGy1rbgJOwz2l1Heuw6IkYO5VHU7N3r9w=;
        b=cwFItznTE5BFIFgjcB8+nG597tskHLR+yoPZw7isZCUdx81NQywk17comUDeSMQBCJ
         fFEL74zxhjhZz+QwEhRMejaftqBSUK5TOs9aD3peUQayDkqZ68etFktNSB7HzE1JKLXA
         FFSh/IfKvaNcnR4qZ3Ec0F80PpOKzzlY7tk8vZZra0bBRbo1oPLMZ0+/UCZqCkt3aRmD
         fx3PRTyju57xFliYJgVMPCjjDQj6NthpaVNA0WyO/HGfmV/WDAIKMh2FNy4b28/6BENK
         tjkwn0mIOMgDKyv5E5vQvaglTXDn0Ajr7RgUCbdS8DfSfS2x4aqbenBEMuYiqFKpO7Ev
         65HQ==
X-Gm-Message-State: AOJu0Yw74D4mO2sH3CcvEZmyp0LGngGkhfApPsuGBDTkikJZG/Ce9CLA
	e2Hs+LmWINVuz94EPKcIHwcKHPUgk8A=
X-Google-Smtp-Source: AGHT+IGx2Mlx2u2XSh6kSc7gIxExMMGB6QxcpKwI6iwz22LcsK0ZD8XnvMFj5pFatIp9qYU2k0NCag==
X-Received: by 2002:a05:6402:518e:b0:530:8942:e830 with SMTP id q14-20020a056402518e00b005308942e830mr7745580edd.2.1695214808652;
        Wed, 20 Sep 2023 06:00:08 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s29-20020a50d49d000000b00532bec5f768sm2312190edi.95.2023.09.20.06.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:00:08 -0700 (PDT)
Message-ID: <ca88434a33a9a54e82cd53f1de3d69a172269ab0.camel@gmail.com>
Subject: Re: How to manually construct a struct bpf_program instance?
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shuyi Cheng <chengshuyi@linux.alibaba.com>, bpf <bpf@vger.kernel.org>
Date: Wed, 20 Sep 2023 16:00:07 +0300
In-Reply-To: <686fce03-cee7-c268-8bfc-ce49230210b9@linux.alibaba.com>
References: <686fce03-cee7-c268-8bfc-ce49230210b9@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
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

On Wed, 2023-09-20 at 10:09 +0800, Shuyi Cheng wrote:
> Hello.
>=20
> I found that libbpf can only construct struct bpf_program instances=20
> through skeleton. Can I manually construct struct bpf_program instances?

Hi Shuyi,

I'm not an expert in libbpf's internals, but looking for places where
`struct bpf_program` objects are initialized in libbpf.c is see the
following call chain:
- bpf_object__open_mem (public) or=20
  bpf_object__open_file (public)
  - bpf_object_open (internal)
    - bpf_object__elf_collect (internal)
      - bpf_object__add_programs (internal)
        - bpf_object__init_prog (internal)
          fills struct bpf_program fields

Both bpf_object__open_{mem,file} assume operation on ELF object,
the rest of the functions is internal. So, it appears that answer to
you question is "no", you will need to create ".maps" section in ELF
in line with libbpf's expectations (not sure if these expectations are
documented).

> We now load our eBPF program by putting the eBPF bytecode into the elf=
=20
> file, and then letting libbpf open the elf file [1]. But adding a map to=
=20
> an elf file is a more complicated matter [2]. Therefore, we hope to=20
> create a bpf_program instance through something like struct bpf_program=
=20
> *bpf_program_new(void *insns, int insns_cnt). After creating the struct=
=20
> bpf_program instance, we can call bpf_program__attach to load our eBPF=
=20
> program bytecode.

On the other hand, if all you want is to create a program from given
set of instructions there is a function `bpf_prog_load()` which
returns program fd. As well as function `bpf_map_create()` which
returns map fd. You can take a look at [3] to see how these functions
are used. (However, you will have to take care of line info, BTF etc
in case you use those).

[3] https://github.com/torvalds/linux/blob/master/tools/testing/selftests/b=
pf/test_verifier.c

>=20
> [1] https://github.com/aliyun/coolbpf/blob/master/lwcb/bpfir/src/object.r=
s
> [2] https://github.com/aliyun/coolbpf/issues/38
>=20
> Thanks in advance!
>=20

Thanks,
Eduard

