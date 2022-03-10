Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D314D5503
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 00:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344524AbiCJXHC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 18:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344531AbiCJXHB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 18:07:01 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD0FCEA24
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 15:05:59 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id z11so12014607lfh.13
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 15:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=G9J8FmHq2/CqMV+jtudqhKexWT092dl7bgPQcNEIVpI=;
        b=kqOPu49snnEYaDB6NIOJaYGr0ImOIF4OUUO7zYQwrxVSgFaeDAmw1yMD7v0QF3Ryyi
         zjwIbDFydMGbXUIzL5/slUW8ZOfQaKpiWTF6oWeV8JBStCWYdxu+wwf+iL7vtBgE8lB9
         aVnezfHcQLE7M9RNndqono6tZzQ7Oe8fkYXCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=G9J8FmHq2/CqMV+jtudqhKexWT092dl7bgPQcNEIVpI=;
        b=WPHsHyc4IgziLuVIqTp2thDbr49wM0XPN/7KnTQ+x00ipl6lBb7DGt9Fej7yjWmyMr
         EtAIi5BSm0t7HZ8OZGdRBVQztyubTOR8oWVFddbsYU0PFV0Sts8H5McfVBAQE79EkKzf
         c6u1HvZFfrxoIpZVJedEF02ifeJKt98KVpj27RqBC5LeG8ZoFrdoIev+OrfY62hunVCR
         uFumaEB0DZfGeLqJc2obZsVKcvBpphCty5i4ApdXSGP1QPeYS4kYZomTc44zOmIZ01EK
         7eFV2ZO67OXNIJOk/m0HpfbyNek7+xgNgwB8e1sJQyGyt7IbVU47WUMQTiBrDnM2PNPL
         nNlA==
X-Gm-Message-State: AOAM53352nPJN3agyhCqQNMHbEaiZI7X8J+9F7AVsofb1RmYlSLRFv4M
        V+cucay8sgY9yqmwHQDzOTo2kg==
X-Google-Smtp-Source: ABdhPJwBeP1H+YsXCFBZFVSgVJtWDt+BjoUIPA40jh2nJVAjIw1o95VxemmxfNXWhAkJxgNIziKyVA==
X-Received: by 2002:a05:6512:3f95:b0:448:40cd:dcab with SMTP id x21-20020a0565123f9500b0044840cddcabmr4251208lfa.517.1646953557908;
        Thu, 10 Mar 2022 15:05:57 -0800 (PST)
Received: from cloudflare.com ([2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id f15-20020a2e6a0f000000b0023e429778fasm1346783ljc.56.2022.03.10.15.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:05:57 -0800 (PST)
References: <20220222182559.2865596-1-iii@linux.ibm.com>
 <20220222182559.2865596-2-iii@linux.ibm.com>
 <87bkygzbg5.fsf@cloudflare.com>
 <8d8b464f6c2820989d67f00d24b6003b8b758274.camel@linux.ibm.com>
 <871qzbz5sa.fsf@cloudflare.com>
 <a924d763fe50ec80594ca3fac6b311cf9ec20fca.camel@linux.ibm.com>
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
Date:   Thu, 10 Mar 2022 23:57:43 +0100
In-reply-to: <a924d763fe50ec80594ca3fac6b311cf9ec20fca.camel@linux.ibm.com>
Message-ID: <87wnh1xvaj.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On Wed, Mar 09, 2022 at 01:34 PM +01, Ilya Leoshkevich wrote:
> On Wed, 2022-03-09 at 09:36 +0100, Jakub Sitnicki wrote:

[...]

>>=20
>> Consider this - today the below is true on both LE and BE, right?
>>=20
>> =C2=A0 *(u32 *)&ctx->remote_port =3D=3D *(u16 *)&ctx->remote_port
>>=20
>> because the loads get converted to:
>>=20
>> =C2=A0 *(u16 *)&ctx_kern->sport =3D=3D *(u16 *)&ctx_kern->sport
>>=20
>> IOW, today, because of the bug that you are fixing here, the data
>> layout
>> changes from the PoV of the BPF program depending on the load size.
>>=20
>> With 2-byte loads, without this patch, the data layout appears as:
>>=20
>> =C2=A0 struct bpf_sk_lookup {
>> =C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0 __be16 remote_port;
>> =C2=A0=C2=A0=C2=A0 __be16 remote_port;
>> =C2=A0=C2=A0=C2=A0 ...
>> =C2=A0 }
>
> I see, one can indeed argue that this is also a part of the ABI now.
> So we're stuck between a rock and a hard place.
>
>> While for 4-byte loads, it appears as in your 2nd patch:
>>=20
>> =C2=A0 struct bpf_sk_lookup {
>> =C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0 #if little-endian
>> =C2=A0=C2=A0=C2=A0 __be16 remote_port;
>> =C2=A0=C2=A0=C2=A0 __u16=C2=A0 :16; /* zero padding */
>> =C2=A0=C2=A0=C2=A0 #elif big-endian
>> =C2=A0=C2=A0=C2=A0 __u16=C2=A0 :16; /* zero padding */
>> =C2=A0=C2=A0=C2=A0 __be16 remote_port;
>> =C2=A0=C2=A0=C2=A0 #endif
>> =C2=A0=C2=A0=C2=A0 ...
>> =C2=A0 }
>>=20
>> Because of that I don't see how we could keep complete ABI
>> compatiblity,
>> and have just one definition of struct bpf_sk_lookup that reflects
>> it. These are conflicting requirements.
>>=20
>> I'd bite the bullet for 4-byte loads, for the sake of having an
>> endian-agnostic struct bpf_sk_lookup and struct bpf_sock definition
>> in
>> the uAPI header.
>>=20
>> The sacrifice here is that the access converter will have to keep
>> rewriting 4-byte access to bpf_sk_lookup.remote_port and
>> bpf_sock.dst_port in this unexpected, quirky manner.
>>=20
>> The expectation is that with time users will recompile their BPF
>> progs
>> against the updated bpf.h, and switch to 2-byte loads. That will make
>> the quirk in the access converter dead code in time.
>>=20
>> I don't have any better ideas. Sorry.
>>=20
>> [...]
>
> I agree, let's go ahead with this solution.
>
> The only remaining problem that I see is: the bug is in the common
> code, and it will affect the fields that we add in the future.
>
> Can we either document this state of things in a comment, or fix the
> bug and emulate the old behavior for certain fields?

I think we can fix the bug in the common code, and compensate for the
quirky 4-byte access to bpf_sk_lookup.remote_port and bpf_sock.dst_port
in the is_valid_access and convert_ctx_access.

With the patch as below, access to remote_port gets rewritten to:

* size=3D1, offset=3D0, r2 =3D *(u8 *)(r1 +36)
   0: (69) r2 =3D *(u16 *)(r1 +4)
   1: (54) w2 &=3D 255
   2: (b7) r0 =3D 0
   3: (95) exit

* size=3D1, offset=3D1, r2 =3D *(u8 *)(r1 +37)
   0: (69) r2 =3D *(u16 *)(r1 +4)
   1: (74) w2 >>=3D 8
   2: (54) w2 &=3D 255
   3: (b7) r0 =3D 0
   4: (95) exit

* size=3D1, offset=3D2, r2 =3D *(u8 *)(r1 +38)
   0: (b4) w2 =3D 0
   1: (54) w2 &=3D 255
   2: (b7) r0 =3D 0
   3: (95) exit

* size=3D1, offset=3D3, r2 =3D *(u8 *)(r1 +39)
   0: (b4) w2 =3D 0
   1: (74) w2 >>=3D 8
   2: (54) w2 &=3D 255
   3: (b7) r0 =3D 0
   4: (95) exit

* size=3D2, offset=3D0, r2 =3D *(u16 *)(r1 +36)
   0: (69) r2 =3D *(u16 *)(r1 +4)
   1: (b7) r0 =3D 0
   2: (95) exit

* size=3D2, offset=3D2, r2 =3D *(u16 *)(r1 +38)
   0: (b4) w2 =3D 0
   1: (b7) r0 =3D 0
   2: (95) exit

* size=3D4, offset=3D0, r2 =3D *(u32 *)(r1 +36)
   0: (69) r2 =3D *(u16 *)(r1 +4)
   1: (b7) r0 =3D 0
   2: (95) exit

How does that look to you?

Still need to give it a test on s390x.

--8<--

diff --git a/net/core/filter.c b/net/core/filter.c
index 65869fd510e8..2625a1d2dabc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10856,13 +10856,24 @@ static bool sk_lookup_is_valid_access(int off, in=
t size,
 	case bpf_ctx_range(struct bpf_sk_lookup, local_ip4):
 	case bpf_ctx_range_till(struct bpf_sk_lookup, remote_ip6[0], remote_ip6[3=
]):
 	case bpf_ctx_range_till(struct bpf_sk_lookup, local_ip6[0], local_ip6[3]):
-	case offsetof(struct bpf_sk_lookup, remote_port) ...
-	     offsetof(struct bpf_sk_lookup, local_ip4) - 1:
 	case bpf_ctx_range(struct bpf_sk_lookup, local_port):
 	case bpf_ctx_range(struct bpf_sk_lookup, ingress_ifindex):
 		bpf_ctx_record_field_size(info, sizeof(__u32));
 		return bpf_ctx_narrow_access_ok(off, size, sizeof(__u32));
=20
+	case bpf_ctx_range(struct bpf_sk_lookup, remote_port):
+		/* Allow 4-byte access to 2-byte field for backward compatibility */
+		if (size =3D=3D sizeof(__u32))
+			return off =3D=3D offsetof(struct bpf_sk_lookup, remote_port);
+		bpf_ctx_record_field_size(info, sizeof(__be16));
+		return bpf_ctx_narrow_access_ok(off, size, sizeof(__be16));
+
+	case offsetofend(struct bpf_sk_lookup, remote_port) ...
+	     offsetof(struct bpf_sk_lookup, local_ip4) - 1:
+		/* Allow access to zero padding for backward compatiblity */
+		bpf_ctx_record_field_size(info, sizeof(__u16));
+		return bpf_ctx_narrow_access_ok(off, size, sizeof(__u16));
+
 	default:
 		return false;
 	}
@@ -10944,6 +10955,11 @@ static u32 sk_lookup_convert_ctx_access(enum bpf_a=
ccess_type type,
 						     sport, 2, target_size));
 		break;
=20
+	case offsetofend(struct bpf_sk_lookup, remote_port):
+		*target_size =3D 2;
+		*insn++ =3D BPF_MOV32_IMM(si->dst_reg, 0);
+		break;
+
 	case offsetof(struct bpf_sk_lookup, local_port):
 		*insn++ =3D BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
 				      bpf_target_off(struct bpf_sk_lookup_kern,
