Return-Path: <bpf+bounces-9943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D36179EFC9
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 19:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F081C21583
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 17:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695021F95A;
	Wed, 13 Sep 2023 16:58:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF20AD52
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 16:58:55 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6704230D8
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 09:58:54 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bcc0adab4so8059066b.2
        for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694624333; x=1695229133; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F6wXwotBYvM9QGjHGn2BCIzbRPWgB2JbLfaSh98k4gk=;
        b=cQqBavsb+pscpZB0ziBUKU3lWrytWZY15eEM+iXq04msERcuZq6RSbq5hNTtGMCzHf
         NMghC6sZlimHNv4TEp6fE89k5FDrmR/hkcH4YfbBYzMD3fArSig82SwW4aa7iIcCS7eS
         kNh+b5heYlbIFLN7n6rMIEQmPCBtB+ZGyr0q+uyRuNFu9I4yW7NYR4JdWd+YzlrjrSXO
         qZTPiR6Ot7TA1YfjrBqsViKl3fin2A7QN6wNPtgxqClQtleol+5LTq6zuWEBPNtaAWl/
         HovG2x6kmZ1AkxPsmRybu1WqG3DYbFBB2bI9k53paAbiqbq7xsYHzPnT9yV75IUpSnDI
         KxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694624333; x=1695229133;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6wXwotBYvM9QGjHGn2BCIzbRPWgB2JbLfaSh98k4gk=;
        b=owBdr9pD8frh/CoQprBcd5twcsUVWfktZ9S3Rc2E08IXHdhdywLC4/eGSFAZSczqtX
         9PUk3U6/61mizrabxr8gOWHDgTec5kxCHC/rAxKJmE1GeZOklaMWkQ8ReuTuilJrJkyP
         D/L/+xU1I2L/TnrTpx4RbSAsRBZvaWr/drxSaMZf1m9Shzj1Dd2Y/JX2bBWcLhm724eF
         RIJ7iO73lpQDWoL2lBnGjibhjjUYnZxofn+ZRs35EU8U7LGRRYaB1H58kPNaA1KRrihr
         WmlSG3DOMrwP5GxBiBW03CFJPgoPeSTaSl40/qTlIoYjWzRG6kHMHa9hmc9AnUEJ0J3p
         bHwA==
X-Gm-Message-State: AOJu0YwAXcOegoqFCDgsMPASsDq+sD9PgncHMjsA7CgW7lNI4siPNy3m
	HCDPFDVVzQts2FKGXpmKwhs=
X-Google-Smtp-Source: AGHT+IFDD756AbiG2aSFFel5jiyZtZmYJFtOmcNRBRCYT003+Cl+KITqcg8GWafS6ceLXnAtU9DA0g==
X-Received: by 2002:a17:906:8446:b0:9a1:f96c:4baf with SMTP id e6-20020a170906844600b009a1f96c4bafmr2041083ejy.5.1694624332606;
        Wed, 13 Sep 2023 09:58:52 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s21-20020a170906961500b009937dbabbd5sm8666648ejx.220.2023.09.13.09.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 09:58:52 -0700 (PDT)
Message-ID: <8f91f140d779625e47f425958e186bf255f26b19.camel@gmail.com>
Subject: Re: [PATCH dwarves 3/3] btf_encoder: learn BTF_KIND_MAX value from
 base BTF when generating split BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
 jolsa@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com,  mykolal@fb.com, bpf@vger.kernel.org
Date: Wed, 13 Sep 2023 19:58:50 +0300
In-Reply-To: <20230913142646.190047-4-alan.maguire@oracle.com>
References: <20230913142646.190047-1-alan.maguire@oracle.com>
	 <20230913142646.190047-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-09-13 at 15:26 +0100, Alan Maguire wrote:
> > When creating module BTF, the module likely will not have a DWARF
> > specificiation of BTF_KIND_MAX, so look for it in the base BTF.  For
> > vmlinux base BTF, the enumeration value is present, so the base BTF
> > can be checked to limit BTF kind representation.
> >=20
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  btf_encoder.c | 24 ++++++++++++++++++++++++
> >  btf_encoder.h |  2 ++
> >  pahole.c      |  2 ++
> >  3 files changed, 28 insertions(+)
> >=20
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index ad0158f..6cb3df6 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -1902,3 +1902,27 @@ void dwarves__set_btf_kind_max(struct conf_load =
*conf_load, int btf_kind_max)
> >  	if (btf_kind_max < BTF_KIND_ENUM64)
> >  		conf_load->skip_encoding_btf_enum64 =3D true;
> >  }
> > +
> > +void btf__set_btf_kind_max(struct conf_load *conf_load, struct btf *bt=
f)
> > +{

Nitpick: same function for DWARF has name dwarf__find_btf_kind_max,
 which seems to be a bit inconsistent.

> > +	__u32 id, type_cnt =3D btf__type_cnt(btf);
> > +
> > +	for (id =3D 1; id < type_cnt; id++) {
> > +		const struct btf_type *t =3D btf__type_by_id(btf, id);
> > +		const struct btf_enum *e;
> > +		__u16 vlen, i;
> > +
> > +		if (!t || !btf_is_enum(t))
> > +			continue;
> > +		vlen =3D btf_vlen(t);
> > +		e =3D btf_enum(t);
> > +		for (i =3D 0; i < vlen; e++, i++) {
> > +			const char *name =3D btf__name_by_offset(btf, e->name_off);
> > +
> > +			if (!name || strcmp(name, "BTF_KIND_MAX"))
> > +				continue;
> > +			dwarves__set_btf_kind_max(conf_load, e->val);
> > +			return;
> > +		}
> > +	}
> > +}
> > diff --git a/btf_encoder.h b/btf_encoder.h
> > index 34516bb..e5e12ef 100644
> > --- a/btf_encoder.h
> > +++ b/btf_encoder.h
> > @@ -27,4 +27,6 @@ struct btf *btf_encoder__btf(struct btf_encoder *enco=
der);
> > =20
> >  int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_e=
ncoder *other);
> > =20
> > +void btf__set_btf_kind_max(struct conf_load *conf_load, struct btf *bt=
f);
> > +
> >  #endif /* _BTF_ENCODER_H_ */
> > diff --git a/pahole.c b/pahole.c
> > index aca2704..4d6d059 100644
> > --- a/pahole.c
> > +++ b/pahole.c
> > @@ -3470,6 +3470,7 @@ int main(int argc, char *argv[])
> >  				base_btf_file, libbpf_get_error(conf_load.base_btf));
> >  			goto out;
> >  		}
> > +		btf__set_btf_kind_max(&conf_load, conf_load.base_btf);
> >  		if (!btf_encode && !ctf_encode) {
> >  			// Force "btf" since a btf_base is being informed
> >  			conf_load.format_path =3D "btf";
> > @@ -3513,6 +3514,7 @@ try_sole_arg_as_class_names:
> >  					base_btf_file, libbpf_get_error(conf_load.base_btf));
> >  				goto out;
> >  			}
> > +			btf__set_btf_kind_max(&conf_load, conf_load.base_btf);
> >  		}
> >  	}
> > =20


