Return-Path: <bpf+bounces-12471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6927CCB61
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 20:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24EAFB211D3
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0162B45F6F;
	Tue, 17 Oct 2023 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aw7et9ca"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1572D78F
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 18:56:02 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C208AF0
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 11:56:00 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so63108961fa.0
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697568959; x=1698173759; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OM5UY+8owagTe6ihKkUyYU9Y1ISRTUPrkspLl1nU+WU=;
        b=aw7et9caDM+JDdnmSgmviZWoaycuIGvPHJxQyo95OkAPk8YSPBaVD/aKmLilk0TDWD
         G8gWtZjjcbZDkFxJBLsBTULSg6eAg1V1Yr7PD+tWtdWRO5uGsTzNUyyRtgJuyGf1LHt7
         I7C9yQrY3ST8W1tr1J8LzNZ+X3uxIx6y1Q+BJNyQOLz24G8uRwhOZnbJ2skHYxHtaH+8
         N8OqSGZsEJ1LVFWnZHBSozzmDW76jsGT07IRyoeZgoVB9QvcrGN/xX5ywUfk2PGaKNNr
         0l4j9vTmc91qOgLG1hamH78N3ki49chYZeQTk80H2kZQxjxlpxct6eI4RXuMsYkfwG/C
         Npaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697568959; x=1698173759;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OM5UY+8owagTe6ihKkUyYU9Y1ISRTUPrkspLl1nU+WU=;
        b=fbbGDs0bILi/rUp/G2QAl/G6bhMgR72Y/pXDTMtaELzE2lLYOWMisG5wtfPUnmM7Sn
         StBh5sPyTfBuHNk4xz3aW8+9ycxme5B0Z9A//4WVOmNRqRv8wXPdYORCSR1aFw1TGw0H
         nhatPYyeeKDn4Q/+9ZQbBr8sJXkU9TwiaEDZsIIIQSRTD8oQfkLFuC0LnPEEcnYp2mZs
         aD2iM+4Chb22sWnHWeK76sKfXzMjJs6s5vh4np2qJKIuBJYWlWwuWFw91jV3JgcizbGI
         W/VX9lCGDVx1BExfMBtHh4dXLeKl5HnLbQyep/Fb9T2XOVp1zRlSJKbDrEiTGjt4nzhm
         wMPw==
X-Gm-Message-State: AOJu0YyKENXPcoeTcr9BGjvgn0UsA0mj0QB1juxnxNnEwI7xZS/BOINT
	6uT+IM+CBzgCClKDzvIvIGU=
X-Google-Smtp-Source: AGHT+IFS8Rikd6azahCN+G6AfMRWEF8HtH0AS6tH0bK/FN+HnjbQVmNHmOdGcKYRd/4ZDUBI6ZnkHA==
X-Received: by 2002:ac2:4550:0:b0:507:9a13:27bd with SMTP id j16-20020ac24550000000b005079a1327bdmr2358002lfm.7.1697568958572;
        Tue, 17 Oct 2023 11:55:58 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id 23-20020a508757000000b0053f29ba5adesm1043573edv.50.2023.10.17.11.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 11:55:57 -0700 (PDT)
Message-ID: <33927efd0799ee11f576ed6fef2266338185dcfe.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 0/5] pahole, btf_encoder: support
 --btf_features
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org,
 jolsa@kernel.org,  ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org,  yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
 haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
Date: Tue, 17 Oct 2023 21:55:56 +0300
In-Reply-To: <CAEf4BzZJv5OyQ5Hktgj2GKD+usgiDx9R+TjyTScE1wPBWjn4Qg@mail.gmail.com>
References: <20231013153359.88274-1-alan.maguire@oracle.com>
	 <42b74a5e36fa013262138a33ba635afe7c15a085.camel@gmail.com>
	 <CAEf4BzZJv5OyQ5Hktgj2GKD+usgiDx9R+TjyTScE1wPBWjn4Qg@mail.gmail.com>
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

On Tue, 2023-10-17 at 11:53 -0700, Andrii Nakryiko wrote:
> > > if [ "${pahole_ver}" -ge "126" ]; then
> > >         extra_pahole_opt=3D"-j --lang_exclude=3Drust
> > > --btf_features=3Dencode_force,var,float,decl_tag,type_tag,enum64,opti=
mized,consistent"
> > > fi
> >=20
> > Nitpick, could you please update the line above as below?
> >=20
> >   --btf_features_strict=3Dencode_force,var,float,decl_tag,type_tag,enum=
64,optimized_func,consistent_func
>=20
> We do not want "strict" behavior for the kernel build script.

Oh, sorry, my comment was about '_func' suffixes,
it should have been --btf_features, of course.

