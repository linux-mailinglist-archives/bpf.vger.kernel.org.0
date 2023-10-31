Return-Path: <bpf+bounces-13711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACF37DD0A8
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 16:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA091C20A48
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 15:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D121E52F;
	Tue, 31 Oct 2023 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA2nvf4o"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B7D1E52B
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 15:37:39 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B465E6
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:37:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e04b17132so9573810a12.0
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698766656; x=1699371456; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bvXYUndANpF4JrACwVEqntIXS8gV+UPy/qIjXTpnmgs=;
        b=GA2nvf4oKzmkm4vmzQXYrrTDsK0LXvchEeBbSydoBXHG1adtMl6MC5VKt5tai8t5gl
         Ok0HQuMJmOBGxpFd6GCOUwRt2MN2/osV4jmx5FgrO8XJOeAD9QYq/93n/uEByksgcjlC
         cWZNTdyMz8851/mDR3UJApvJ7IcbMlr1DUuOCYF14h4lPZDEP6ZJ7FPNUHS03x0bmRJe
         6MXbctWWxwjuYtx+X1SROLI5YPOk9LB3WqzfUyHH/PtqdztBZlW3MlfrQnPbGoP/Fh9y
         tvVrglA4l6W8J9hXX4OtfUKoHOQk4z/VC8a3grCEGQt2+RCCS+o/eJCh4tnQEN82bbh9
         hTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698766656; x=1699371456;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvXYUndANpF4JrACwVEqntIXS8gV+UPy/qIjXTpnmgs=;
        b=S6yopn0FTPU4i3yErIxabR58F+AvfDiWLTcW1DZLisDdifviJN/dPzQKQiPYLeXI5P
         jLiw7+lQIjVlqfVUBkHsAFmQaAjp9fZyvb+7boaazj67Ev/EZ4v0NQiKSs+v+nMKV+7O
         0ZlD08xhdjcO2myY7q+w0HILPrZZEhsKC2yB35X5AaZRP9SPG4+QPDZbInF1BBwoW0TP
         /UshB2Dbt9jRoEh7owaDnjrGlDPY7BKXhSVyOPUHTt9wXesnmGt1jtAAQ1riTRcWLxK5
         49P1TYDaSWqerg6uYHan4RJcrsacr/Y8H3E56GkEoCu75n7TLT35LHZ6q2jw+x5VPT6x
         9TOg==
X-Gm-Message-State: AOJu0Yz2StMEVplswqf7oVy2EjqBY9cpUp2T2oIHS7fcY0WlryMxLiH/
	KJYJjC+f+zP1gYeQzQE/GYmMassLHPRe+w==
X-Google-Smtp-Source: AGHT+IFURGF5XHrB0cjtkJmQpy/sNoRZMZzDwCX+I9zWmpJqZRfOb6HPb13WgOGjUZxt625Jyvjdpg==
X-Received: by 2002:a50:a699:0:b0:543:6eee:2107 with SMTP id e25-20020a50a699000000b005436eee2107mr1685325edc.6.1698766656399;
        Tue, 31 Oct 2023 08:37:36 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d29-20020a50f69d000000b00522828d438csm1353781edn.7.2023.10.31.08.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 08:37:36 -0700 (PDT)
Message-ID: <b5087aeee6b8d429a1a6373803ea7ed30fdc1fda.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 05/23] bpf: derive subreg bounds from full
 bounds when upper 32 bits are constant
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Tue, 31 Oct 2023 17:37:34 +0200
In-Reply-To: <20231027181346.4019398-6-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
	 <20231027181346.4019398-6-andrii@kernel.org>
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

On Fri, 2023-10-27 at 11:13 -0700, Andrii Nakryiko wrote:
> > Comments in code try to explain the idea behind why this is correct.
> > Please check the code and comments.
> >=20
> > Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> > ---
> >  kernel/bpf/verifier.c | 45 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0f66e9092c38..5082ca1ea5dc 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2324,6 +2324,51 @@ static void __update_reg_bounds(struct bpf_reg_s=
tate *reg)
> >  /* Uses signed min/max values to inform unsigned, and vice-versa */
> >  static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
> >  {
> > +	/* If upper 32 bits of u64/s64 range don't change, we can use lower 3=
2
> > +	 * bits to improve our u32/s32 boundaries.
> > +	 *
> > +	 * E.g., the case where we have upper 32 bits as zero ([10, 20] in
> > +	 * u64) is pretty trivial, it's obvious that in u32 we'll also have
> > +	 * [10, 20] range. But this property holds for any 64-bit range as
> > +	 * long as upper 32 bits in that entire range of values stay the same=
.
> > +	 *
> > +	 * E.g., u64 range [0x10000000A, 0x10000000F] ([4294967306, 429496731=
1]
> > +	 * in decimal) has the same upper 32 bits throughout all the values i=
n
> > +	 * that range. As such, lower 32 bits form a valid [0xA, 0xF] ([10, 1=
5])
> > +	 * range.
> > +	 *
> > +	 * Note also, that [0xA, 0xF] is a valid range both in u32 and in s32=
,
> > +	 * following the rules outlined below about u64/s64 correspondence
> > +	 * (which equally applies to u32 vs s32 correspondence). In general i=
t
> > +	 * depends on actual hexadecimal values of 32-bit range. They can for=
m
> > +	 * only valid u32, or only valid s32 ranges in some cases.
> > +	 *
> > +	 * So we use all these insights to derive bounds for subregisters her=
e.
> > +	 */
> > +	if ((reg->umin_value >> 32) =3D=3D (reg->umax_value >> 32)) {
> > +		/* u64 to u32 casting preserves validity of low 32 bits as
> > +		 * a range, if upper 32 bits are the same
> > +		 */
> > +		reg->u32_min_value =3D max_t(u32, reg->u32_min_value, (u32)reg->umin=
_value);
> > +		reg->u32_max_value =3D min_t(u32, reg->u32_max_value, (u32)reg->umax=
_value);
> > +
> > +		if ((s32)reg->umin_value <=3D (s32)reg->umax_value) {
> > +			reg->s32_min_value =3D max_t(s32, reg->s32_min_value, (s32)reg->umi=
n_value);
> > +			reg->s32_max_value =3D min_t(s32, reg->s32_max_value, (s32)reg->uma=
x_value);
> > +		}
> > +	}
> > +	if ((reg->smin_value >> 32) =3D=3D (reg->smax_value >> 32)) {
> > +		/* low 32 bits should form a proper u32 range */
> > +		if ((u32)reg->smin_value <=3D (u32)reg->smax_value) {
> > +			reg->u32_min_value =3D max_t(u32, reg->u32_min_value, (u32)reg->smi=
n_value);
> > +			reg->u32_max_value =3D min_t(u32, reg->u32_max_value, (u32)reg->sma=
x_value);
> > +		}
> > +		/* low 32 bits should form a proper s32 range */
> > +		if ((s32)reg->smin_value <=3D (s32)reg->smax_value) {
> > +			reg->s32_min_value =3D max_t(s32, reg->s32_min_value, (s32)reg->smi=
n_value);
> > +			reg->s32_max_value =3D min_t(s32, reg->s32_max_value, (s32)reg->sma=
x_value);
> > +		}
> > +	}
> >  	/* if u32 range forms a valid s32 range (due to matching sign bit),
> >  	 * try to learn from that
> >  	 */


