Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254F161069B
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 02:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJ1AA7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 20:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJ1AA6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 20:00:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50F17332C
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 17:00:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r186-20020a1c44c3000000b003cf4d389c41so2574706wma.3
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 17:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EbzeWIMZEx3oNhhIYAArK5yb037STAP9rjZNl2yiHJ8=;
        b=Q1/RCsg39WoLqX4kjArsJ7+8AHWUni1awZgulYVEaKhWNCIo89HtNe83BeYOdgfIPt
         bDW2D1xvv1CPUG9rGZvXzMHLZ+t4CLcCz9OHwDvfT9UjFZFcIEDUG5Asy/2tImudcH8X
         TEHXjp7JmwurhGqlZ1TqDL2t+qO+9PjQmClpoy8ylRaTVt+R+/lGxRBw5OnrGYHKChyE
         qomgx19QzO3CA4pTM9LzpayJqs7yaxiZF8rPFC8PsQXO9GMPZmuc/Afpeq0fO2Yj0YZw
         NGUwMGPGyxj7Lk4BHWm6wv5uKa+6T/9RiQTvO0IDQL5d3JgMj9CoP1OkzrgLrZy776MO
         pI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbzeWIMZEx3oNhhIYAArK5yb037STAP9rjZNl2yiHJ8=;
        b=sXAi77FCWFQpXC4nEr74v31uz4DObN6LZIOtnzYNXeXR7ajlY09hHBl/TCuQ1Pf3Wn
         JBzpeC60THWwXPzD7HOTN4FpCsC2IBHcjbR1Z7mzxaIP/eQbfW9DZdTG9g/0TARkBhJf
         3kBWl0QDdv+jCZgOCd1ZjaNwsp8QEF1bvVUlige1z6czjPfJpR79R9HFPgDrKwIOs+ZH
         CZH7coJosfNrOcuKEAapYHLoof2fr4wS+GysV/iQfibP+eR8NV8wNdxE6w+eDitZxJYU
         f7Xn7oyF2UvI9JcsKpXam2ngCgM5UM1AolE22kn0+hkVHLME/Xf81IT+akoSyo9jXhyO
         U1SA==
X-Gm-Message-State: ACrzQf17UJb1ZT8bamrkAOIcZi3peQ+ggTTdds4W/6u4d1HxIO4+/mvQ
        OHcCelBv83BAMiat9D2jpr8=
X-Google-Smtp-Source: AMsMyM4ay2MiOXCCu+UrQ8sroLKwvqOUTOgqbIexqqxSsM2lGnpoV2/QxqDHHBKiPKhotzSAHC1RXQ==
X-Received: by 2002:a1c:740c:0:b0:3c6:eb24:c06a with SMTP id p12-20020a1c740c000000b003c6eb24c06amr7742120wmc.194.1666915255283;
        Thu, 27 Oct 2022 17:00:55 -0700 (PDT)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600c354f00b003cdf141f363sm2996423wmq.11.2022.10.27.17.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 17:00:54 -0700 (PDT)
Message-ID: <237df1d8b2c0bf546ab81abb73ae0b78e2c0cbaa.camel@gmail.com>
Subject: Re: [RFC bpf-next 09/12] kbuild: Header guards for types from
 include/uapi/*.h in kernel BTF
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, arnaldo.melo@gmail.com
Date:   Fri, 28 Oct 2022 03:00:53 +0300
In-Reply-To: <7a3ebc5f-b07f-0336-abb1-627f7a73b2cb@meta.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
         <20221025222802.2295103-10-eddyz87@gmail.com>
         <dacaeb37-c55a-a328-61f2-77324efbc822@meta.com>
         <6e57811b-229a-e4f8-ca7e-fe826cde4be4@meta.com>
         <7a3ebc5f-b07f-0336-abb1-627f7a73b2cb@meta.com>
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

On Thu, 2022-10-27 at 15:44 -0700, Yonghong Song wrote:
>=20
> On 10/27/22 11:55 AM, Yonghong Song wrote:
> >=20
> >=20
> > On 10/27/22 11:43 AM, Yonghong Song wrote:
> > >=20
> > >=20
> > > On 10/25/22 3:27 PM, Eduard Zingerman wrote:
> > > > Use pahole --header_guards_db flag to enable encoding of header gua=
rd
> > > > information in kernel BTF. The actual correspondence between header
> > > > file and guard string is computed by the scripts/infer_header_guard=
s.pl.
> > > >=20
> > > > The encoded header guard information could be used to restore the
> > > > original guards in the vmlinux.h, e.g.:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 include/uapi/linux/tcp.h:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #ifndef _UAPI_LINUX_TCP_H
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #define _UAPI_LINUX_TCP_H
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 union tcp_word_hdr {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tcphdr hdr;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __be32=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 words[5];
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #endif /* _UAPI_LINUX_TCP_H */
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 vmlinux.h:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #ifndef _UAPI_LINUX_TCP_H
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 union tcp_word_hdr {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tcphdr hdr;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __be32 words[5];
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #endif /* _UAPI_LINUX_TCP_H */
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > > >=20
> > > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > ---
> > > > =C2=A0 scripts/link-vmlinux.sh | 13 ++++++++++++-
> > > > =C2=A0 1 file changed, 12 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > > > index 918470d768e9..f57f621eda1f 100755
> > > > --- a/scripts/link-vmlinux.sh
> > > > +++ b/scripts/link-vmlinux.sh
> > > > @@ -110,6 +110,7 @@ vmlinux_link()
> > > > =C2=A0 gen_btf()
> > > > =C2=A0 {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local pahole_ver
> > > > +=C2=A0=C2=A0=C2=A0 local extra_flags
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ! [ -x "$(command -v ${PAHOLE})" =
]; then
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo >&2 "BT=
F: ${1}: pahole (${PAHOLE}) is not available"
> > > > @@ -122,10 +123,20 @@ gen_btf()
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
> > > > +=C2=A0=C2=A0=C2=A0 if [ "${pahole_ver}" -ge "124" ]; then
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scripts/infer_header_gu=
ards.pl \
> > >=20
> > > We should have full path like
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0${srctree}/scripts/infer_header_guards.=
pl
> > > so it can work if build directory is different from source directory.
> >=20
> > handling arguments for infer_header_guards.pl should also take
> > care of full file path.
> >=20
> > + /home/yhs/work/bpf-next/scripts/infer_header_guards.pl include/uapi=
=20
> > include/generated/uapi arch/x86/include/uapi=20
> > arch/x86/include/generated/uapi
> > + return 1
>=20
> Also, please pay attention to bpf selftest result. I see quite a
> few selftest failures with this patch set.

Hi Yonghong,

Could you please copy-paste some of the error reports? I just re-run
the selftests locally and have test_maps, test_verifier, test_progs
and test_progs-no_alu32 passing.

Thanks,
Eduard

>=20
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 include/uapi \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 include/generated/uapi \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 arch/${SRCARCH}/include/uapi \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 arch/${SRCARCH}/include/generated/uapi \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 > .btf.uapi_header_guards || return 1;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extra_flags=3D"--header=
_guards_db .btf.uapi_header_guards"
> > > > +=C2=A0=C2=A0=C2=A0 fi
> > > > +
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmlinux_link ${1}
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info "BTF" ${2}
> > > > -=C2=A0=C2=A0=C2=A0 LLVM_OBJCOPY=3D"${OBJCOPY}" ${PAHOLE} -J ${PAHO=
LE_FLAGS} ${1}
> > > > +=C2=A0=C2=A0=C2=A0 LLVM_OBJCOPY=3D"${OBJCOPY}" ${PAHOLE} -J ${PAHO=
LE_FLAGS}=20
> > > > ${extra_flags} ${1}
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Create ${2} which contains just .B=
TF section but no symbols. Add
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # SHF_ALLOC because .BTF will be par=
t of the vmlinux image.=20
> > > > --strip-all

