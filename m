Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77BD4D8AFF
	for <lists+bpf@lfdr.de>; Mon, 14 Mar 2022 18:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiCNRoO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Mar 2022 13:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237668AbiCNRoN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Mar 2022 13:44:13 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E832BD0
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 10:43:00 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bn33so23037064ljb.6
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=w2KWEreKl5mlyBON+bxnIkBpBzC/KilmVgVZp81tbjY=;
        b=oNm74Rl/BxrARAglEJHc1uFrMC4dQuxl1Ex8zdkRTW2i9GRswQFhk6jj5u9Xf2KucM
         WkKnly5B/uironYfFjoqFQn+fxtumVomju4ZmZFo691rL7Ra2u+PP9x52ZXEp3TKeEZ4
         cRKekndxVM/beLgoNIfw4bP2gbQK44M+kUbeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=w2KWEreKl5mlyBON+bxnIkBpBzC/KilmVgVZp81tbjY=;
        b=v5Clkjg7RB2XosOCeebzolSnsl8ZTbmLXLOm0pK6ah2959kjsL5ERb44/A1OtVyiCX
         Xz4ETa/EUZOo3ExVuTffV33VdvZnQlnbAfhDGd8zDRsJ1moPrtINeMPGpEUkXF62veev
         Pp6EmB+YEDnVVNHSsXwr2vxSFn2co1BJQiCNmXti7CWahTtjJlESi/xLqEhFZ8UWDnGm
         c117gVmHLcrPIGWHTkk3DdevTvTRdpYZDHn8d8rpEWKN7cJbQWnzXUSJXaop3wMZUpp8
         Uawo01MpeOdiDMkQtcy1+CdzXh3UtQQg6MJ2aWY3lZ9ZqtYgjT1jLoNXhyB0XOKVieE2
         4QtQ==
X-Gm-Message-State: AOAM5327aeEWFmMNlOa+slqmfWLaGCCGxvvRG3IT8hovqExk+/uT2hLr
        o9Nq9qNiPMiJoSh7ypjTYT0Hqw==
X-Google-Smtp-Source: ABdhPJyYgqAJCREexY8xVupLH6E+UWcGKQzzdaH8XpxFbiLOJO9WIUjOGA0XPXNN9ennMjTjmigH2A==
X-Received: by 2002:a2e:a590:0:b0:247:ec4c:489d with SMTP id m16-20020a2ea590000000b00247ec4c489dmr14983962ljp.114.1647279777972;
        Mon, 14 Mar 2022 10:42:57 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-4809-d800-0000-0000-0000-0f9c.aa.ipv6.supernova.orange.pl. [2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id m5-20020a196145000000b004482fed26a4sm3383830lfk.239.2022.03.14.10.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 10:42:57 -0700 (PDT)
References: <20220222182559.2865596-1-iii@linux.ibm.com>
 <20220222182559.2865596-2-iii@linux.ibm.com>
 <87bkygzbg5.fsf@cloudflare.com>
 <8d8b464f6c2820989d67f00d24b6003b8b758274.camel@linux.ibm.com>
 <871qzbz5sa.fsf@cloudflare.com>
 <a924d763fe50ec80594ca3fac6b311cf9ec20fca.camel@linux.ibm.com>
 <87wnh1xvaj.fsf@cloudflare.com>
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
Date:   Mon, 14 Mar 2022 18:35:59 +0100
In-reply-to: <87wnh1xvaj.fsf@cloudflare.com>
Message-ID: <87o828xwf3.fsf@cloudflare.com>
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

On Thu, Mar 10, 2022 at 11:57 PM +01, Jakub Sitnicki wrote:
> On Wed, Mar 09, 2022 at 01:34 PM +01, Ilya Leoshkevich wrote:
>> On Wed, 2022-03-09 at 09:36 +0100, Jakub Sitnicki wrote:
>
> [...]
>
>>>=20
>>> Consider this - today the below is true on both LE and BE, right?
>>>=20
>>> =C2=A0 *(u32 *)&ctx->remote_port =3D=3D *(u16 *)&ctx->remote_port
>>>=20
>>> because the loads get converted to:
>>>=20
>>> =C2=A0 *(u16 *)&ctx_kern->sport =3D=3D *(u16 *)&ctx_kern->sport
>>>=20
>>> IOW, today, because of the bug that you are fixing here, the data
>>> layout
>>> changes from the PoV of the BPF program depending on the load size.
>>>=20
>>> With 2-byte loads, without this patch, the data layout appears as:
>>>=20
>>> =C2=A0 struct bpf_sk_lookup {
>>> =C2=A0=C2=A0=C2=A0 ...
>>> =C2=A0=C2=A0=C2=A0 __be16 remote_port;
>>> =C2=A0=C2=A0=C2=A0 __be16 remote_port;
>>> =C2=A0=C2=A0=C2=A0 ...
>>> =C2=A0 }
>>
>> I see, one can indeed argue that this is also a part of the ABI now.
>> So we're stuck between a rock and a hard place.
>>
>>> While for 4-byte loads, it appears as in your 2nd patch:
>>>=20
>>> =C2=A0 struct bpf_sk_lookup {
>>> =C2=A0=C2=A0=C2=A0 ...
>>> =C2=A0=C2=A0=C2=A0 #if little-endian
>>> =C2=A0=C2=A0=C2=A0 __be16 remote_port;
>>> =C2=A0=C2=A0=C2=A0 __u16=C2=A0 :16; /* zero padding */
>>> =C2=A0=C2=A0=C2=A0 #elif big-endian
>>> =C2=A0=C2=A0=C2=A0 __u16=C2=A0 :16; /* zero padding */
>>> =C2=A0=C2=A0=C2=A0 __be16 remote_port;
>>> =C2=A0=C2=A0=C2=A0 #endif
>>> =C2=A0=C2=A0=C2=A0 ...
>>> =C2=A0 }
>>>=20
>>> Because of that I don't see how we could keep complete ABI
>>> compatiblity,
>>> and have just one definition of struct bpf_sk_lookup that reflects
>>> it. These are conflicting requirements.
>>>=20
>>> I'd bite the bullet for 4-byte loads, for the sake of having an
>>> endian-agnostic struct bpf_sk_lookup and struct bpf_sock definition
>>> in
>>> the uAPI header.
>>>=20
>>> The sacrifice here is that the access converter will have to keep
>>> rewriting 4-byte access to bpf_sk_lookup.remote_port and
>>> bpf_sock.dst_port in this unexpected, quirky manner.
>>>=20
>>> The expectation is that with time users will recompile their BPF
>>> progs
>>> against the updated bpf.h, and switch to 2-byte loads. That will make
>>> the quirk in the access converter dead code in time.
>>>=20
>>> I don't have any better ideas. Sorry.
>>>=20
>>> [...]
>>
>> I agree, let's go ahead with this solution.
>>
>> The only remaining problem that I see is: the bug is in the common
>> code, and it will affect the fields that we add in the future.
>>
>> Can we either document this state of things in a comment, or fix the
>> bug and emulate the old behavior for certain fields?
>
> I think we can fix the bug in the common code, and compensate for the
> quirky 4-byte access to bpf_sk_lookup.remote_port and bpf_sock.dst_port
> in the is_valid_access and convert_ctx_access.
>
> With the patch as below, access to remote_port gets rewritten to:
>
> * size=3D1, offset=3D0, r2 =3D *(u8 *)(r1 +36)
>    0: (69) r2 =3D *(u16 *)(r1 +4)
>    1: (54) w2 &=3D 255
>    2: (b7) r0 =3D 0
>    3: (95) exit
>
> * size=3D1, offset=3D1, r2 =3D *(u8 *)(r1 +37)
>    0: (69) r2 =3D *(u16 *)(r1 +4)
>    1: (74) w2 >>=3D 8
>    2: (54) w2 &=3D 255
>    3: (b7) r0 =3D 0
>    4: (95) exit
>
> * size=3D1, offset=3D2, r2 =3D *(u8 *)(r1 +38)
>    0: (b4) w2 =3D 0
>    1: (54) w2 &=3D 255
>    2: (b7) r0 =3D 0
>    3: (95) exit
>
> * size=3D1, offset=3D3, r2 =3D *(u8 *)(r1 +39)
>    0: (b4) w2 =3D 0
>    1: (74) w2 >>=3D 8
>    2: (54) w2 &=3D 255
>    3: (b7) r0 =3D 0
>    4: (95) exit
>
> * size=3D2, offset=3D0, r2 =3D *(u16 *)(r1 +36)
>    0: (69) r2 =3D *(u16 *)(r1 +4)
>    1: (b7) r0 =3D 0
>    2: (95) exit
>
> * size=3D2, offset=3D2, r2 =3D *(u16 *)(r1 +38)
>    0: (b4) w2 =3D 0
>    1: (b7) r0 =3D 0
>    2: (95) exit
>
> * size=3D4, offset=3D0, r2 =3D *(u32 *)(r1 +36)
>    0: (69) r2 =3D *(u16 *)(r1 +4)
>    1: (b7) r0 =3D 0
>    2: (95) exit
>
> How does that look to you?
>
> Still need to give it a test on s390x.

Context conversion with patch below applied looks correct to me on s390x
as well:

* size=3D1, offset=3D0, r2 =3D *(u8 *)(r1 +36)
   0: (69) r2 =3D *(u16 *)(r1 +4)
   1: (bc) w2 =3D w2
   2: (74) w2 >>=3D 8
   3: (bc) w2 =3D w2
   4: (54) w2 &=3D 255
   5: (bc) w2 =3D w2
   6: (b7) r0 =3D 0
   7: (95) exit

* size=3D1, offset=3D1, r2 =3D *(u8 *)(r1 +37)
   0: (69) r2 =3D *(u16 *)(r1 +4)
   1: (bc) w2 =3D w2
   2: (54) w2 &=3D 255
   3: (bc) w2 =3D w2
   4: (b7) r0 =3D 0
   5: (95) exit

* size=3D1, offset=3D2, r2 =3D *(u8 *)(r1 +38)
   0: (b4) w2 =3D 0
   1: (bc) w2 =3D w2
   2: (74) w2 >>=3D 8
   3: (bc) w2 =3D w2
   4: (54) w2 &=3D 255
   5: (bc) w2 =3D w2
   6: (b7) r0 =3D 0
   7: (95) exit

* size=3D1, offset=3D3, r2 =3D *(u8 *)(r1 +39)
   0: (b4) w2 =3D 0
   1: (bc) w2 =3D w2
   2: (54) w2 &=3D 255
   3: (bc) w2 =3D w2
   4: (b7) r0 =3D 0
   5: (95) exit

* size=3D2, offset=3D0, r2 =3D *(u16 *)(r1 +36)
   0: (69) r2 =3D *(u16 *)(r1 +4)
   1: (bc) w2 =3D w2
   2: (b7) r0 =3D 0
   3: (95) exit

* size=3D2, offset=3D2, r2 =3D *(u16 *)(r1 +38)
   0: (b4) w2 =3D 0
   1: (bc) w2 =3D w2
   2: (b7) r0 =3D 0
   3: (95) exit

* size=3D4, offset=3D0, r2 =3D *(u32 *)(r1 +36)
   0: (69) r2 =3D *(u16 *)(r1 +4)
   1: (bc) w2 =3D w2
   2: (b7) r0 =3D 0
   3: (95) exit

If we go this way, this should unbreak the bpf selftests on BE,
independently of the patch 1 from this series.

Will send it as a patch, so that we continue the review discussion.

>
> --8<--
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 65869fd510e8..2625a1d2dabc 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10856,13 +10856,24 @@ static bool sk_lookup_is_valid_access(int off, =
int size,
>  	case bpf_ctx_range(struct bpf_sk_lookup, local_ip4):
>  	case bpf_ctx_range_till(struct bpf_sk_lookup, remote_ip6[0], remote_ip6=
[3]):
>  	case bpf_ctx_range_till(struct bpf_sk_lookup, local_ip6[0], local_ip6[3=
]):
> -	case offsetof(struct bpf_sk_lookup, remote_port) ...
> -	     offsetof(struct bpf_sk_lookup, local_ip4) - 1:
>  	case bpf_ctx_range(struct bpf_sk_lookup, local_port):
>  	case bpf_ctx_range(struct bpf_sk_lookup, ingress_ifindex):
>  		bpf_ctx_record_field_size(info, sizeof(__u32));
>  		return bpf_ctx_narrow_access_ok(off, size, sizeof(__u32));
>=20=20
> +	case bpf_ctx_range(struct bpf_sk_lookup, remote_port):
> +		/* Allow 4-byte access to 2-byte field for backward compatibility */
> +		if (size =3D=3D sizeof(__u32))
> +			return off =3D=3D offsetof(struct bpf_sk_lookup, remote_port);
> +		bpf_ctx_record_field_size(info, sizeof(__be16));
> +		return bpf_ctx_narrow_access_ok(off, size, sizeof(__be16));
> +
> +	case offsetofend(struct bpf_sk_lookup, remote_port) ...
> +	     offsetof(struct bpf_sk_lookup, local_ip4) - 1:
> +		/* Allow access to zero padding for backward compatiblity */
> +		bpf_ctx_record_field_size(info, sizeof(__u16));
> +		return bpf_ctx_narrow_access_ok(off, size, sizeof(__u16));
> +
>  	default:
>  		return false;
>  	}
> @@ -10944,6 +10955,11 @@ static u32 sk_lookup_convert_ctx_access(enum bpf=
_access_type type,
>  						     sport, 2, target_size));
>  		break;
>=20=20
> +	case offsetofend(struct bpf_sk_lookup, remote_port):
> +		*target_size =3D 2;
> +		*insn++ =3D BPF_MOV32_IMM(si->dst_reg, 0);
> +		break;
> +
>  	case offsetof(struct bpf_sk_lookup, local_port):
>  		*insn++ =3D BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
>  				      bpf_target_off(struct bpf_sk_lookup_kern,

