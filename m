Return-Path: <bpf+bounces-8838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D637D78B0E1
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 14:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0636E1C20918
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 12:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12308125B8;
	Mon, 28 Aug 2023 12:46:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7111C9A
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 12:46:17 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E72107
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 05:46:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bcf2de59cso418959166b.0
        for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 05:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693226774; x=1693831574;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Ols2QeIXVIPKbiaz+xrKojxZbGbrofL64I1ZOklPX8=;
        b=VWZ/gyCIRzDNbTVabHlHyawkzT1mW7W1ntuUxLK/XhNUXbnJjTR8kuspnOT5qjLJLT
         R+7DnurCRdHBBXb9bEIl1cEKhSlXqJ/fgN8ko4KtFJh/duSIhM6pBg7nc6bWxNhCsFG3
         BcdEGW2CMnBGO6pBeVOcXyApAFHTwZQezB0ZRbvUU7/Mk0dwJwToNHoDIKv0QrIU9yqp
         SU4NXD8dpctVdih0qmDZLTApc/t15g4qIFmUnlSaJKvcZiQh0gVQ2a3GR3mt/IgcV6Sm
         CrbmffNuiBVWteMzxaPnTozIc+ZmHq1+5fZs8yU1dcK48I3F0aWeLjAmDQ8PXQgCdmzy
         H5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693226774; x=1693831574;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Ols2QeIXVIPKbiaz+xrKojxZbGbrofL64I1ZOklPX8=;
        b=KOhis3qntvMW4ePioEAUg6uCxV4jFtJdsadzdWr9S3m1g/04aHAlim50ftuXcgXZ4G
         c3x13XHBmJDpQrBZRC2RjqFHR0t1t4Uows3tCHc7q2xN5YgBp8cgIuFcm8vr1kf7j12J
         g484DTyDuyEc/d1MMomTvae96P8ZLBmoBvKhoqmSipQCVJsnRxCu+E735A6YVpaoXtwy
         btt+OAQ94k2gXJi/yozjWSEKfAHjHwr88oNi3cKYZhdA+eTIp/i0LfxHtRNfJ1windgQ
         Q+GbMWp2Hl+38TgpSWDbhGBK5GZQXyfvvkU2TCzDN9NURXFvf4miDU/0oyY7Yqzk8tqK
         4sHg==
X-Gm-Message-State: AOJu0YwiE4le1gyA12pBVAT9vXU9yiDKsambhGT7zLmtPqr5UzWnAiIc
	NawadwL8FiwTcckGq9JYh70=
X-Google-Smtp-Source: AGHT+IFdRt6GYxsn3dUDjN9RF0cy7F6s4mY7WokEm/DT3WJ2Ne1ifqQbLL5HHRzvIr5Eu2a36y3dTg==
X-Received: by 2002:a17:907:2724:b0:9a1:d087:e0c0 with SMTP id d4-20020a170907272400b009a1d087e0c0mr11369461ejl.42.1693226773798;
        Mon, 28 Aug 2023 05:46:13 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id mh2-20020a170906eb8200b0099b76c3041csm4572561ejb.7.2023.08.28.05.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 05:46:13 -0700 (PDT)
Message-ID: <98af45809e7276431b7d053bfe8b26d98b2f9394.camel@gmail.com>
Subject: Re: [QUESTION] bpf/tc verifier error: invalid access to map value,
 min value is outside of the allowed memory range
From: Eduard Zingerman <eddyz87@gmail.com>
To: Justin Iurman <justin.iurman@uliege.be>, bpf@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>
Date: Mon, 28 Aug 2023 15:46:12 +0300
In-Reply-To: <e3783201-3b28-3661-eee3-3b5fecad0964@uliege.be>
References: <e3783201-3b28-3661-eee3-3b5fecad0964@uliege.be>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-08-24 at 22:32 +0200, Justin Iurman wrote:
> Hello,
>=20
> I'm facing a verifier error and don't know how to make it happy (already=
=20
> tried lots of checks). First, here is my env:
>   - OS: Ubuntu 22.04.3 LTS
>   - kernel: 5.15.0-79-generic x86_64 (CONFIG_DEBUG_INFO_BTF=3Dy)
>   - clang version: 14.0.0-1ubuntu1.1
>   - iproute2-5.15.0 with libbpf 0.5.0
>=20
> And here is a simplified example of my program (basically, it will=20
> insert in packets some bytes defined inside a map):
>=20
> #include "vmlinux.h"
> #include <bpf/bpf_endian.h>
> #include <bpf/bpf_helpers.h>
>=20
> #define MAX_BYTES 2048
>=20
> struct xxx_t {
> 	__u32 bytes_len;
> 	__u8 bytes[MAX_BYTES];
> };
>=20
> struct {
> 	__uint(type, BPF_MAP_TYPE_ARRAY);
> 	__uint(max_entries, 1);
> 	__type(key, __u32);
> 	__type(value, struct xxx_t);
> 	__uint(pinning, LIBBPF_PIN_BY_NAME);
> } my_map SEC(".maps");
>=20
> char _license[] SEC("license") =3D "GPL";
>=20
> SEC("egress")
> int egress_handler(struct __sk_buff *skb)
> {
> 	void *data_end =3D (void *)(long)skb->data_end;
> 	void *data =3D (void *)(long)skb->data;
> 	struct ethhdr *eth =3D data;
> 	struct ipv6hdr *ip6;
> 	struct xxx_t *x;
> 	__u32 offset;
> 	__u32 idx =3D 0;
>=20
> 	offset =3D sizeof(*eth) + sizeof(*ip6);
> 	if (data + offset > data_end)
> 		return TC_ACT_OK;
>=20
> 	if (bpf_ntohs(eth->h_proto) !=3D ETH_P_IPV6)
> 		return TC_ACT_OK;
>=20
> 	x =3D bpf_map_lookup_elem(&my_map, &idx);
> 	if (!x)
> 		return TC_ACT_OK;
>=20
> 	if (x->bytes_len =3D=3D 0 || x->bytes_len > MAX_BYTES)
> 		return TC_ACT_OK;
>=20
> 	if (bpf_skb_adjust_room(skb, x->bytes_len, BPF_ADJ_ROOM_NET, 0))
> 		return TC_ACT_OK;
>=20
> 	if (bpf_skb_store_bytes(skb, offset, x->bytes, 8/*x->bytes_len*/,=20
> BPF_F_RECOMPUTE_CSUM))
> 		return TC_ACT_SHOT;
>=20
> 	/* blah blah blah... */
>=20
> 	return TC_ACT_OK;
> }
>=20
> Let's focus on the line where bpf_skb_store_bytes is called. As is, with=
=20
> a constant length (i.e., 8 for instance), the verifier is happy.=20
> However, as soon as I try to use a map value as the length, it fails:
>=20
> [...]
> ; if (bpf_skb_store_bytes(skb, offset, x->bytes, x->bytes_len,
> 34: (bf) r1 =3D r7
> 35: (b7) r2 =3D 54
> 36: (bf) r3 =3D r8
> 37: (b7) r5 =3D 1
> 38: (85) call bpf_skb_store_bytes#9
>   R0=3Dinv0 R1_w=3Dctx(id=3D0,off=3D0,imm=3D0) R2_w=3Dinv54=20
> R3_w=3Dmap_value(id=3D0,off=3D4,ks=3D4,vs=3D2052,imm=3D0)=20
> R4_w=3Dinv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xffffffff)) R5=
_w=3Dinv1=20
> R6_w=3Dinv1 R7=3Dctx(id=3D0,off=3D0,imm=3D0)=20
> R8_w=3Dmap_value(id=3D0,off=3D4,ks=3D4,vs=3D2052,imm=3D0) R10=3Dfp0 fp-8=
=3Dmmmm????
> invalid access to map value, value_size=3D2052 off=3D4 size=3D0
> R3 min value is outside of the allowed memory range
>=20
> I guess "size=3D0" is the problem here, but don't understand why. What=
=20
> bothers me is that it looks like it's about R3 (i.e., x->bytes), not R4.=
=20
> Anyway, I already tried to add a bunch of checks for both, but did not=
=20
> succeed. Any idea?

Hi Justin, John,

The following fragment of C code:

	if (x->bytes_len =3D=3D 0 || x->bytes_len > MAX_BYTES)
		return TC_ACT_OK;

	if (bpf_skb_adjust_room(skb, x->bytes_len, BPF_ADJ_ROOM_NET, 0))
		return TC_ACT_OK;

	if (bpf_skb_store_bytes(skb, offset, x->bytes, x->bytes_len,
				BPF_F_RECOMPUTE_CSUM))
		return TC_ACT_SHOT;

Gets compiled to the following BPF:

    ; r8 is `x` at this point
    ; if (x->bytes_len =3D=3D 0 || x->bytes_len > MAX_BYTES)
    17: (61) r2 =3D *(u32 *)(r8 +0)           ; R2_w=3Dscalar(umax=3D429496=
7295,var_off=3D(0x0; 0xffffffff))
                                            ; R8_w=3Dmap_value(off=3D0,ks=
=3D4,vs=3D2052,imm=3D0)
    18: (bc) w1 =3D w2                        ; R1_w=3Dscalar(id=3D2,umax=
=3D4294967295,var_off=3D(0x0; 0xffffffff))
                                            ; R2_w=3Dscalar(id=3D2,umax=3D4=
294967295,var_off=3D(0x0; 0xffffffff))
    19: (04) w1 +=3D -2049                    ; R1_w=3Dscalar(umax=3D429496=
7295,var_off=3D(0x0; 0xffffffff))
    20: (a6) if w1 < 0xfffff800 goto pc+16  ; R1_w=3Dscalar(umin=3D42949652=
48,umax=3D4294967295,
                                            ;             var_off=3D(0xffff=
f800; 0x7ff),s32_min=3D-2048,s32_max=3D-1)

    ; if (bpf_skb_adjust_room(skb, x->bytes_len, BPF_ADJ_ROOM_NET, 0))
    21: (bf) r1 =3D r6                        ; R1_w=3Dctx(off=3D0,imm=3D0)=
 R6=3Dctx(off=3D0,imm=3D0)
    22: (b4) w3 =3D 0                         ; R3_w=3D0
    23: (b7) r4 =3D 0                         ; R4_w=3D0
    24: (85) call bpf_skb_adjust_room#50    ; R0=3Dscalar()
    25: (55) if r0 !=3D 0x0 goto pc+11        ; R0=3D0

    ; if (bpf_skb_store_bytes(skb, offset, x->bytes, x->bytes_len,
    26: (61) r4 =3D *(u32 *)(r8 +0)           ; R4_w=3Dscalar(umax=3D429496=
7295,var_off=3D(0x0; 0xffffffff))
                                            ; R8=3Dmap_value(off=3D0,ks=3D4=
,vs=3D2052,imm=3D0)
    27: (07) r8 +=3D 4                        ; R8_w=3Dmap_value(off=3D4,ks=
=3D4,vs=3D2052,imm=3D0)
    28: (bf) r1 =3D r6                        ; R1_w=3Dctx(off=3D0,imm=3D0)=
 R6=3Dctx(off=3D0,imm=3D0)
    29: (b4) w2 =3D 54                        ; R2_w=3D54
    30: (bf) r3 =3D r8                        ; R3_w=3Dmap_value(off=3D4,ks=
=3D4,vs=3D2052,imm=3D0) R8_w=3Dmap_value(off=3D4,ks=3D4,vs=3D2052,imm=3D0)
    31: (b7) r5 =3D 1                         ; R5_w=3D1
    32: (85) call bpf_skb_store_bytes#9

Note the following instructions:
- (17): x->bytes_len access;
- (18,19,20): a curious way in which clang translates the (_ =3D=3D 0 || _ =
> MAX_BYTES);
- (26): x->bytes_len is re-read.

Several observations:
- because of (20) verifier can infer range for w1, but this range is
  not propagated to w2;
- even if it was propagated verifier does not track range for values
  stored in "general memory", only for values in registers and values
  spilled to stack =3D> known range for w2 does not imply known range
  for x->bytes_len.

I can make it work with the following modification:

    int egress_handler(struct __sk_buff *skb)
    {
    	void *data_end =3D (void *)(long)skb->data_end;
    	void *data =3D (void *)(long)skb->data;
    	struct ethhdr *eth =3D data;
    	struct ipv6hdr *ip6;
    	struct xxx_t *x;
    	__s32 bytes_len;   // <------ signed !
    	__u32 offset;
    	__u32 idx =3D 0;
   =20
    	offset =3D sizeof(*eth) + sizeof(*ip6);
    	if (data + offset > data_end)
    		return TC_ACT_OK;
   =20
    	if (bpf_ntohs(eth->h_proto) !=3D ETH_P_IPV6)
    		return TC_ACT_OK;
   =20
    	x =3D bpf_map_lookup_elem(&my_map, &idx);
    	if (!x)
    		return TC_ACT_OK;
   =20
    	bytes_len =3D x->bytes_len; // <----- use bytes_len everywhere below !
   =20
    	if (bytes_len <=3D 0 || bytes_len > MAX_BYTES)
    		return TC_ACT_OK;
   =20
    	if (bpf_skb_adjust_room(skb, bytes_len, BPF_ADJ_ROOM_NET, 0))
    		return TC_ACT_OK;
   =20
    	if (bpf_skb_store_bytes(skb, offset, x->bytes, bytes_len,
    				BPF_F_RECOMPUTE_CSUM))
    		return TC_ACT_SHOT;
   =20
    	/* blah blah blah... */
   =20
    	return TC_ACT_OK;
    }

After such change the following BPF is generated:

    ; bytes_len =3D x->bytes_len;
    17: (61) r9 =3D *(u32 *)(r8 +0)         ; R8_w=3Dmap_value(off=3D0,ks=
=3D4,vs=3D2052,imm=3D0)
                                          ; R9_w=3Dscalar(umax=3D4294967295=
,var_off=3D(0x0; 0xffffffff))

    ; if (bytes_len <=3D 0 || bytes_len > MAX_BYTES)
    18: (c6) if w9 s< 0x1 goto pc+18      ; R9_w=3Dscalar(umin=3D1,umax=3D2=
147483647,var_off=3D(0x0; 0x7fffffff))
    19: (66) if w9 s> 0x800 goto pc+17    ; R9_w=3Dscalar(umin=3D1,umax=3D2=
048,var_off=3D(0x0; 0xfff))
    ; if (bpf_skb_adjust_room(skb, bytes_len, BPF_ADJ_ROOM_NET, 0))
    20: (bf) r1 =3D r6                      ; R1_w=3Dctx(off=3D0,imm=3D0) R=
6=3Dctx(off=3D0,imm=3D0)
    21: (bc) w2 =3D w9                      ; R2_w=3Dscalar(id=3D2,umin=3D1=
,umax=3D2048,var_off=3D(0x0; 0xfff))
                                          ; R9_w=3Dscalar(id=3D2,umin=3D1,u=
max=3D2048,var_off=3D(0x0; 0xfff))
    22: (b4) w3 =3D 0                       ; R3_w=3D0
    23: (b7) r4 =3D 0                       ; R4_w=3D0
    24: (85) call bpf_skb_adjust_room#50          ; R0=3Dscalar()
    25: (55) if r0 !=3D 0x0 goto pc+11      ; R0=3D0

    ; if (bpf_skb_store_bytes(skb, offset, x->bytes, bytes_len,
    26: (07) r8 +=3D 4                      ; R8_w=3Dmap_value(off=3D4,ks=
=3D4,vs=3D2052,imm=3D0)
    27: (bf) r1 =3D r6                      ; R1_w=3Dctx(off=3D0,imm=3D0) R=
6=3Dctx(off=3D0,imm=3D0)
    28: (b4) w2 =3D 54                      ; R2_w=3D54
    29: (bf) r3 =3D r8                      ; R3_w=3Dmap_value(off=3D4,ks=
=3D4,vs=3D2052,imm=3D0)
                                          ; R8_w=3Dmap_value(off=3D4,ks=3D4=
,vs=3D2052,imm=3D0)
    30: (bc) w4 =3D w9                      ; R4_w=3Dscalar(id=3D2,umin=3D1=
,umax=3D2048,var_off=3D(0x0; 0xfff))
                                          ; R9=3Dscalar(id=3D2,umin=3D1,uma=
x=3D2048,var_off=3D(0x0; 0xfff))
    31: (b7) r5 =3D 1                       ; R5_w=3D1
    32: (85) call bpf_skb_store_bytes#9
   =20
Note the following:
- (17): x->bytes_len is in w9;
- (18,19): range check is done w/o -=3D 2049 trick and verifier infers
  range for w9 as [1,2048];
- (30): w9 is reused as a parameter to bpf_skb_store_bytes with
  correct range.

I think that main pain point here is "clever" (_ =3D=3D 0 || _ > MAX_BYTES)
translation, need to think a bit if it is possible to dissuade clang
from such transformation (via change in clang).

Alternatively, I think that doing (_ =3D=3D 0 || _ > MAX_BYTES) check in
inline assembly as two compare instructions should also work.

Thanks,
Eduard

