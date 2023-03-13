Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31306B7971
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 14:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCMNuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 09:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMNuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 09:50:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E6423640
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 06:50:17 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j11so15760486lfg.13
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678715415;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KhlJFCvYShV+5di9ZZ6JSfglI2GE01AISp5vRwzgoNI=;
        b=joN1haK1j6WRJxaEMtUGeQ0wg8vkE4XjfhcUjIfdjw8i0OsFB6lQ9grcGK8Wc2RT9n
         b0DP1JCY4POpZY39vC0gKiz1r66yw9ai+xXh3S2tYha05FeQJncg4KxZGV36EOssplE4
         zk5VGGKHNXh2122u7XC30G8urYpl4vfM2cIIZ1rOJiuNDszinEeLO5s3qefSwSfblUyJ
         A/yR3mgQvD0tH309Ekfp9f3sZOZMsEjXdwbcyQqDqsYdd7pN0KpWd7Ux7LKl1HBeAfmd
         FlWfT/wKF0DjJ/sMBbmdj/du2KTL0RqHmHJFqw+CHzE2wmamTDIYZFG2M/V9/34Qn36V
         Yc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678715415;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KhlJFCvYShV+5di9ZZ6JSfglI2GE01AISp5vRwzgoNI=;
        b=n4B+JtSV+v1e45ktHSe7B5A7IEQdekOsdgNquo1LjIQct2kxrNgudhgHoUml2rG9aj
         NohLM3aD8XzZr8fX+Ni5UGmiEaucb2pmZCNQT0INDcKndNJeQATYDTTAuobWpmeJyZmr
         Liel03hpmYTviki1RnWz/0kYiNXSu+FHONG4an+cxHuh9FbXC+7lYJrnZ8zMh4wNh5iI
         pD7AsOtPoiQ5aBKNrexO7ROEDTo4NAlGpw2+FUBRAOg+4Z72XIOY2w6J1Y95OFbMfdn6
         zCV9h5UMe45yAOFApoNfZA7Z/NtWl1Ps65NqKQlon/bB0E/Ksi3n8XCYqEODBtIlI377
         0ttw==
X-Gm-Message-State: AO0yUKV+aKxmR4LN+zxqE07Ml3NwLxTcW7BmqmdrH1I/5dp6CpLTVnoC
        Gpigb3nGPJ1bTmT6kHjQIeg=
X-Google-Smtp-Source: AK7set9bDqtxLIze3Y90P1Cg3me5XoQoBolAhNpjF8peSPU0TqH48qw3IYPmjL1J9qAG6x+J9GhhOg==
X-Received: by 2002:ac2:4114:0:b0:4a4:68b7:deb7 with SMTP id b20-20020ac24114000000b004a468b7deb7mr3462009lfi.19.1678715415383;
        Mon, 13 Mar 2023 06:50:15 -0700 (PDT)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b27-20020a056512025b00b004dbebb3a6fasm984082lfo.175.2023.03.13.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:50:14 -0700 (PDT)
Message-ID: <cba295426f5bd157688b3393a4f528df06d2eca5.camel@gmail.com>
Subject: Re: [PATCH dwarves 2/3] dwarves_fprintf: support skipping modifier
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        haoluo@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
        kpsingh@chromium.org, sinquersw@gmail.com, martin.lau@kernel.org,
        songliubraving@fb.com, sdf@google.com, timo@incline.eu, yhs@fb.com,
        bpf@vger.kernel.org
Date:   Mon, 13 Mar 2023 15:50:13 +0200
In-Reply-To: <1678459850-16140-3-git-send-email-alan.maguire@oracle.com>
References: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
         <1678459850-16140-3-git-send-email-alan.maguire@oracle.com>
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

On Fri, 2023-03-10 at 14:50 +0000, Alan Maguire wrote:
> When doing BTF comparisons between functions defined in multiple
> CUs, it was noticed a few critical functions failed prototype
> comparisons due to multiple "const" modifiers; for example:
>=20
> function mismatch for 'memchr_inv'('memchr_inv'): 'void * ()(const const =
void  * , int, size_t)' !=3D 'void * ()(const void  *, int, size_t)'
>=20
> function mismatch for 'strnlen'('strnlen'): '__kernel_size_t ()(const con=
st char  * , __kernel_size_t)' !=3D '__kernel_size_t ()(const char  *, size=
_t)'
>=20
> (note the "const const" in the first parameter.)

Hi Alan,

Could you please share which command/flags do you use to generate the
'memchr_inv' with 'const const'?
I tried the ones used in 'btfdiff':
- pahole -F dwarf  --flat_arrays --sort --jobs --suppress_aligned_attribute=
 \
  --suppress_force_paddings --suppress_packed --lang_exclude rust \
  --show_private_classes ./vmlinux
- pahole -F btf --sort --suppress_aligned_attribute --suppress_packed ./vml=
inux

But don't see any function prototypes generated with 'const const'.

On the other hand, I see it in a few structure definitions, e.g. here
is original C code (include/linux/sysrq.h:32):

    struct sysrq_key_op {
    	void (* const handler)(int);
    	const char * const help_msg;
    	const char * const action_msg;
    	const int enable_mask;
    };

And here is how it is reconstructed from DWARF (same happens when
reconstructed from BTF):

    struct sysrq_key_op {
            const void                 (*handler)(int);      /*     0     8=
 */
            const const char  *        help_msg;             /*     8     8=
 */
            const const char  *        action_msg;           /*    16     8=
 */
            const int                  enable_mask;          /*    24     4=
 */
   =20
            /* size: 32, cachelines: 1, members: 4 */
            /* padding: 4 */
            /* last cacheline: 32 bytes */
    };

So it seems to be a general issue with modifiers printing.

Thanks,
Eduard
>=20
> As such it would be useful to omit modifiers for comparison
> purposes.  Also noted was the fact that for the "no_parm_names"
> case, an extra space was being emitted in some cases, also
> throwing off string comparisons of prototypes.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  dwarves.h         |  1 +
>  dwarves_fprintf.c | 26 ++++++++++++++++----------
>  2 files changed, 17 insertions(+), 10 deletions(-)
>=20
> diff --git a/dwarves.h b/dwarves.h
> index d04a36d..7a319d1 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -134,6 +134,7 @@ struct conf_fprintf {
>  	uint8_t	   strip_inline:1;
>  	uint8_t	   skip_emitting_atomic_typedefs:1;
>  	uint8_t	   skip_emitting_errors:1;
> +	uint8_t    skip_emitting_modifier:1;
>  };
> =20
>  struct cus;
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index 5c6bf9c..b20a473 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -506,7 +506,8 @@ static const char *tag__ptr_name(const struct tag *ta=
g, const struct cu *cu,
>  				struct tag *next_type =3D cu__type(cu, type->type);
> =20
>  				if (next_type && tag__is_pointer(next_type)) {
> -					const_pointer =3D "const ";
> +					if (!conf->skip_emitting_modifier)
> +						const_pointer =3D "const ";
>  					type =3D next_type;
>  				}
>  			}
> @@ -580,13 +581,16 @@ static const char *__tag__name(const struct tag *ta=
g, const struct cu *cu,
>  				   *type_str =3D __tag__name(type, cu, tmpbf,
>  							   sizeof(tmpbf),
>  							   pconf);
> -			switch (tag->tag) {
> -			case DW_TAG_volatile_type: prefix =3D "volatile "; break;
> -			case DW_TAG_const_type:    prefix =3D "const ";	 break;
> -			case DW_TAG_restrict_type: suffix =3D " restrict"; break;
> -			case DW_TAG_atomic_type:   prefix =3D "_Atomic ";  break;
> +			if (!conf->skip_emitting_modifier) {
> +				switch (tag->tag) {
> +				case DW_TAG_volatile_type: prefix =3D "volatile "; break;
> +				case DW_TAG_const_type: prefix =3D "const"; break;
> +				case DW_TAG_restrict_type: suffix =3D " restrict"; break;
> +				case DW_TAG_atomic_type:   prefix =3D "_Atomic ";  break;
> +				}
>  			}
> -			snprintf(bf, len, "%s%s%s ", prefix, type_str, suffix);
> +			snprintf(bf, len, "%s%s%s%s", prefix, type_str, suffix,
> +				 conf->no_parm_names ? "" : " ");
>  		}
>  		break;
>  	case DW_TAG_array_type:
> @@ -818,9 +822,11 @@ print_default:
>  	case DW_TAG_const_type:
>  		modifier =3D "const";
>  print_modifier: {
> -		size_t modifier_printed =3D fprintf(fp, "%s ", modifier);
> -		tconf.type_spacing -=3D modifier_printed;
> -		printed		   +=3D modifier_printed;
> +		if (!conf->skip_emitting_modifier) {
> +			size_t modifier_printed =3D fprintf(fp, "%s ", modifier);
> +			tconf.type_spacing -=3D modifier_printed;
> +			printed		   +=3D modifier_printed;
> +		}
> =20
>  		struct tag *ttype =3D cu__type(cu, type->type);
>  		if (ttype) {

