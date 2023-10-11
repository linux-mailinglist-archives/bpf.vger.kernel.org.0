Return-Path: <bpf+bounces-11959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC367C5D67
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 21:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33557282856
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 19:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1141C12E53;
	Wed, 11 Oct 2023 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1Ho6rFh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF912E4C
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 19:08:18 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8DA90
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 12:08:16 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5056ca2b6d1so138129e87.1
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697051294; x=1697656094; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FqSGclUzUTwHj2xi3zIri4n7buav3xHsyWDg3zvXDqw=;
        b=k1Ho6rFhTprL8FqqQzazJcrPkWP1F+UP5pNo54Y1fiAWJZfHgzLyps8WkZACoQGuYJ
         jQux/0kRke7hU2EKkl++ijAaPtHlaX5haTlq+eKzCkTMGwCi83CQIKzFN1PDjqgHfqVv
         qViR9vVA6lxFIcN0aATtA5vALls6YfhZDCmikG+TFeABM7TipQTTbIBhoW6Xw5x6FwG9
         B8T2g5N6CIJbImtR3qJ9KkvMb5pJhbn6AAGXSt1tbWV1mWDDODRP74dNgbpz5mq7Njgo
         of4luopqoGJkeE7Tunf5Slghp+30uSkNjEhnUn88oP28JHcuELTU8n+RreI+zP3cXb12
         whuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697051294; x=1697656094;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FqSGclUzUTwHj2xi3zIri4n7buav3xHsyWDg3zvXDqw=;
        b=c1QEPhCSaeXSWIEImyfcjqpK3nOFA73E++9RPL/vIviYj2GcYZQ7BKX5vXjVLEW7io
         dN223oPHQZ+XphEN22i/ClAJtumWiXbKH1dBgcF6nmj4bgGeIxSozaVzv0HsEG1bBgqK
         tqsicrxL4FE3nz7kJKyuxFRdMa954FawjTtQWIdZd7LV/HAvg4x8KV/iqRUEPi2DHN/y
         j3h0IrQzdZzkP88/yMRqnQ9jLyws+fKt6uhoebGqZ3FTzvrJuL+HnQXOFOoDLlRPlkuu
         YTAA4rUYOtZHRcVez2Bcu+WDsfiIHlUDcICiBZKGnVC42cLHGkHzHhCHGBlZN6xs0oNl
         ADyg==
X-Gm-Message-State: AOJu0Ywnxw0j+8MsrpO6ZveCDcLhcyOvdanYiP//9bHJAmh/2WRr3wkw
	DI7l6ZlGEVTqJChQuudxZGc=
X-Google-Smtp-Source: AGHT+IGEQ0oa/Hcq9im8DdgF/BY09hImNlbDBikdA6tfRQIxBTz4WgGwEJMzoJEahTzKRYvhzrG0EQ==
X-Received: by 2002:a05:6512:314a:b0:4ff:62a4:7aaf with SMTP id s10-20020a056512314a00b004ff62a47aafmr14382811lfi.2.1697051294369;
        Wed, 11 Oct 2023 12:08:14 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k8-20020ac24568000000b004ff8f090057sm2396972lfm.59.2023.10.11.12.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 12:08:13 -0700 (PDT)
Message-ID: <5b40ffbfa5949c24dad44ed6adf70d35cf72f757.camel@gmail.com>
Subject: Re: [RFC dwarves 3/4] pahole: add
 --btf_features=feature1[,feature2...] support
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org,  sdf@google.com,
 haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org, Andrii Nakryiko
 <andrii@kernel.org>
Date: Wed, 11 Oct 2023 22:08:12 +0300
In-Reply-To: <f822334f-335e-bd38-09c7-95c69086ba6f@oracle.com>
References: <20231011091732.93254-1-alan.maguire@oracle.com>
	 <20231011091732.93254-4-alan.maguire@oracle.com>
	 <b7b61031f41ab4082205ed061bb66cb859bd1f0d.camel@gmail.com>
	 <f822334f-335e-bd38-09c7-95c69086ba6f@oracle.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 2023-10-11 at 17:41 +0100, Alan Maguire wrote:
[...]
> > > +		}
> > > +	}
> > > +
> > > +	for (i =3D 0; i < ARRAY_SIZE(btf_features); i++) {
> > > +		bool *bval =3D (bool *)(((void *)conf_load) + btf_features[i].conf=
_load_offset);
> > > +		bool match =3D encode_all;
> > > +
> > > +		if (!match) {
> > > +			for (j =3D 0; j < n; j++) {
> > > +				if (strcmp(feature_list[j], btf_features[i].name) =3D=3D 0) {
> > > +					match =3D true;
> > > +					break;
> > > +				}
> > > +			}
> > > +		}
> > > +		if (match)
> > > +			*bval =3D btf_features[i].skip ? false : true;
> >=20
> > I'm not sure I understand the logic behind "skip" features.
> > Take `decl_tag` for example:
> > - by default conf_load->skip_encoding_btf_decl_tag is 0;
> > - if `--btf_features=3Ddecl_tag` is passed it is still 0 because of the
> >   `skip ? false : true` logic.
> >=20
> > If there is no way to change "skip" features why listing these at all?
> >=20
> You're right; in the case of a skip feature, I think we need the
> following behaviour
>=20
> 1. we skip the encoding by default (so the equivalent of
> --skip_encoding_btf_decl_tag, setting skip_encoding_btf_decl_tag
> to true
>
> 2. if the user however specifies the logical inversion of the skip
> feature in --btf_features (in this case "decl_tag" - or "all")
> skip_encoding_btf_decl_tag is set to false.
>=20
> So in my code we had 2 above but not 1. If both were in place I think
> we'd have the right set of behaviours. Does that sound right?

You mean when --features=3D? is specified we default to
conf_load->skip_encoding_btf_decl_tag =3D true, and set it to false only
if "all" or "decl_tag" is listed in features, right?
=20
> Maybe a better way to express all this would be to rename the "skip"
> field in "struct btf_feature" to "default" - so in the case of a "skip"
> feature, the default is true, but for opt-in features, the default is fal=
se.

Yes, I agree, "default" is better as "skip" is a bit confusing.

[...]

