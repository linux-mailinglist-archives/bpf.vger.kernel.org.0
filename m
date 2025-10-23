Return-Path: <bpf+bounces-71877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E43C00051
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 10:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E1F3A2C65
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897C8303C83;
	Thu, 23 Oct 2025 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTGREQTL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1953019B7
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209464; cv=none; b=C+UFbTcRjmvR/Bw9Mg09eg/Rw0rp+lOWnUi0i/qoLlK6gNM8KxdXGzccHqPNhkD2cXca21jsdCwDam6/u/Q5t9lSIbNeiWkT3XxPWh0O9HcyWSZkIm7OIzFlXs7V7nWwRHNC2x6KlwQuVSXl5hXeXnAiF705SWXTOMbFVv7hMwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209464; c=relaxed/simple;
	bh=7bXVp+ziQ2OuWMevH9F65tA6vXhu/lyKjnHU1d6r/0A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dy0IHFDfaPf23OazVojtJLOPunh00Oy/68nKQbjye6qDTTWSHquDg1K7BQZJ1QuxKN6EB/i/t88rAwKAvFQR6g+w2Sbb/ALkpu1Kn0LMrocqf8TW2FR1IGrCLjwFJaF9co/TnsBiDRAzze4PnJBLwU60zGXG2ZCrajlKji7XdyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTGREQTL; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so480009a91.2
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761209462; x=1761814262; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vdZyb8UCmMRD2q+q4inRphVbhFIhxUTaLM0BgmOe21w=;
        b=HTGREQTLQ7d/Z3Pf7SOrx+JWdQ5l5QWrhb5lT6FZtb7VurKJqHXLlVLJkOi6VV8Vo6
         nmvKJ+ePvgB7934NxPUwOJOU9Pt++Wh6+Fv2eUwGGVYqZQJUmqLBfFNTCFQ0UEBtnkoy
         d5a74+jRqGNg2911pkSWgcHYQrn6jRqTakTbkytuqyunMMifdOJPCuBQV+WpV/2STcUh
         GAHoIZ6G0Aa/a63Xg6fDdk+Y9rdgUxe3Y0iG/LNqP2Sg95E/WDMQjd4XVDLB3xbsdgHS
         75SVf3IV5HaQtS4iQapzHYubQNCzpVGgReHIafTQIdD71rBButYN1gqFlBkXiVgVsYKt
         rUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761209462; x=1761814262;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdZyb8UCmMRD2q+q4inRphVbhFIhxUTaLM0BgmOe21w=;
        b=J6efYgIsJt9Q0MuwECL5c3FkTIqtoO5sBpOVtYGIpJQnZ8l5nY3ZAsScJn5Eqzh8cB
         2DD3p5nkM/IJjuZAuZgUbtFy3KY3nu+7QBWpx2ldzP4rXbmZgCsu3CVS5edkvR+hmKb8
         CnL2p5HrE6B3e8tbhG6OAIRZEIRH1IfaO0qlY1BSEdYvnQ/F6QWcAfqHS64qCRd6CG2X
         Tr93vUc1oZHOV1d3hWi/nQLH3kXh0CKzYsa/Ct5iyZ0J+mYbocngCROlMH1jbmuM3MwK
         aTJcjfsVJ5A77+b7lWVYW2YmcXjXvZ+/TEggJ7Df96LP2kN90X8dw7ggBvH9y8JWrL1s
         Zqbg==
X-Forwarded-Encrypted: i=1; AJvYcCUO6IJBOaNI8+FjncZ0SKPzZLIxs3e32v4CTnhoVMUw8pcqIidESA59BboL9pt2XvWYlPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFZ5+qdAkEVBeb7d+iRTtVKUHjN5BXnaz8qhg73l8++XyybzYA
	rNKMr8bvtXQVsv1fqhbSWq/lThJMYjxRSRCuMnWxIhMbmbhINa2wRXM0
X-Gm-Gg: ASbGncvJtPjV1XtOFHbizQ7cg48EMVv3VCdfE4ZBaIbEGXCCW3G8LNLNzcmdUBDaxPF
	6vZLJmsEVefrSVQdBH1lqRNaLX7BPoEHUQza0xW97YcDERgbiryRPmz35ixG6U3+hY4yFNSPaku
	F95uE3J64xFlI9PQuPWyBs0wzOcQ3FZK4kNUdgOTB888DOzPI/VD1JUM6zSGBbJvj7djvSumlrE
	EJ4csynFDnGQrs7cA+Z6psT3xUp+Bt91GjhaSGCNabPCD15gsrXErNTn33V6dCSHkhg1sCeWJnH
	FDdHV3miGquGeqKpgFqGeIazFalcSu6c8YHfOe/mWMVPAZyuwtqcBdvfNIE63AY07IozCpCzcFl
	0xAyet7Anv0n4HhoPScOISltWzhBJxze8LtMNP5n3djqkOwnYByhMtgydmR08LSNISbmqv46x
X-Google-Smtp-Source: AGHT+IFnF333gU28tmFT0iEISdOKX4H+tDOAwM1DHgNx6gTki6gKjSLwb1OISFBmKIusgeE+aJ//Ow==
X-Received: by 2002:a17:90b:3f10:b0:330:84dc:d11b with SMTP id 98e67ed59e1d1-33bcf8e4e19mr28048551a91.18.1761209461809;
        Thu, 23 Oct 2025 01:51:01 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff373easm1680778a91.5.2025.10.23.01.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:51:01 -0700 (PDT)
Message-ID: <c13cbc214c55d17b86f4fed486c4ada5faf6cfec.camel@gmail.com>
Subject: Re: [RFC bpf-next 05/15] bpftool: Add ability to dump LOC_PARAM,
 LOC_PROTO and LOCSEC
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Date: Thu, 23 Oct 2025 01:50:58 -0700
In-Reply-To: <b2aa8474-cc33-451d-8529-6efdc5cd9810@oracle.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
	 <20251008173512.731801-6-alan.maguire@oracle.com>
	 <bc3b203185107bd68c64458e0c71f68cd16e8595.camel@gmail.com>
	 <b2aa8474-cc33-451d-8529-6efdc5cd9810@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-23 at 09:38 +0100, Alan Maguire wrote:
> On 23/10/2025 01:57, Eduard Zingerman wrote:
> > On Wed, 2025-10-08 at 18:35 +0100, Alan Maguire wrote:
> >=20
> > [...]
> >=20
> > > @@ -420,6 +423,98 @@ static int dump_btf_type(const struct btf *btf, =
__u32 id,
> > >  		}
> > >  		break;
> > >  	}
> > > +	case BTF_KIND_LOC_PARAM: {
> > > +		const struct btf_loc_param *p =3D btf_loc_param(t);
> > > +		__s32 sz =3D (__s32)t->size;
> > > +
> > > +		if (btf_kflag(t)) {
> > > +			__u64 uval =3D btf_loc_param_value(t);
> > > +			__s64 sval =3D (__s64)uval;
> > > +
> > > +			if (json_output) {
> > > +				jsonw_int_field(w, "size", sz);
> > > +				if (sz >=3D 0)
> > > +					jsonw_uint_field(w, "value", uval);
> > > +				else
> > > +					jsonw_int_field(w, "value", sval);
> > > +			} else {
> > > +				if (sz >=3D 0)
> > > +					printf(" size=3D%d value=3D%llu", sz, uval);
> > > +				else
> > > +					printf(" size=3D%d value=3D%lld", sz, sval);
> > > +			}
> > > +		} else {
> > > +			if (json_output) {
> > > +				jsonw_int_field(w, "size", sz);
> > > +				jsonw_uint_field(w, "reg", p->reg);
> > > +				jsonw_uint_field(w, "flags", p->flags);
> > > +				jsonw_int_field(w, "offset", p->offset);
> > > +			} else {
> > > +				printf(" size=3D%d reg=3D%u flags=3D0x%x offset=3D%d",
> > > +				       sz, p->reg, p->flags, p->offset);
> >=20
> > Did you consider printing this in a more user readable form?
> > E.g. `*(u64 *)(rbp - 8)`?
> >=20
>=20
> That's a good idea. However currently we use register numbers we get
> from DWARF, so would it be more confusing to see something like
>=20
> 	*(u64 *)(reg1 -8)
>=20
> Not sure (we could translate reg# -> regname but I'm not sure where the
> right place to host such a translation might be).

We can start with hosting the table in bpftool.
Additionally, bpftool can check which architecture the ELF file
containing BPF is built for, and decide whether to apply the
translation.

For x86 you can just grab the table from here:
https://github.com/eddyz87/inline-address-printer/blob/master/main.c#L107

> > > +			}
> > > +		}
> > > +		break;
> > > +	}
> >=20
> > [...]
> >=20
> >=20

