Return-Path: <bpf+bounces-23052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F395E86CC73
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 16:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DF5284D13
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 15:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7CB1386C9;
	Thu, 29 Feb 2024 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YH+h0nFC"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273A21384B8
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219390; cv=none; b=nNzivM428F9zoK9jyp6sQKvOXDh0jTNEbT13u8S90CAxFRtvfI/xerdxCAqqsbGHwhjW4jdHoeVKlNFMHd17QusVYP0pIEtf1i8IOQ32+rDVxRAdRivt5zssebgYR5YmBxZDq917/JxVztHcLOUdAEC6XlJ9JXYKojhwMkVKlQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219390; c=relaxed/simple;
	bh=wtWMvzqwhoSnTknvsYjvEnfxMoElLxeKvqdT0BI/8vI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SlIPrvZOJpTgcZ3x7gqtj58V+nU9C5hmtQEOM1dgydWGJsmNDWyi4qKB2n9WOJEnUVWF/vaYkiBUkKNgeTtQcE54+XXEwZyzfz0PQMi404ybcIRjp7p6HqYaThxYVHG7PKUT4kaWxHg7ve7ZKUmGetCx6jA6isaxsiAYL8SE5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YH+h0nFC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709219388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PL0hrSc+ghkS+aZSpl/BtOyD8SiqXS/U1B+lb8pvLzs=;
	b=YH+h0nFCC807UJ+uc6pIHHDvripu98ES2aSo7juxmNr1Bf8u5ZO6oUB+xHMwzHeLaT19JQ
	WpO+2WUMa2YgtyIv4hHiQEhAwERa6XLK5BxJOEaxYURgjQyFMv2dThNZIBygpYUoYIkY4w
	WU7+6sRB3zLoj4CPCcY0SJFBM1Cp7Ig=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-f24JqqviNxCRCP9gmPO61g-1; Thu, 29 Feb 2024 10:09:42 -0500
X-MC-Unique: f24JqqviNxCRCP9gmPO61g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d827f1e04so152766f8f.0
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 07:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709219376; x=1709824176;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PL0hrSc+ghkS+aZSpl/BtOyD8SiqXS/U1B+lb8pvLzs=;
        b=Rv5ItQID8rDVmUTC0c6Lqb39nvGR4+RonwB0UVaiE4aDRJYFrJuj3zqyzcnaSiXaUz
         G76uzDtDseYRMyuOyTvbH+oWXvasNZp/v56J/a05nAWzSxpHJRQ5XVw+PAuVTrgnJmh4
         btaaMieP+KsKdbHarIjUSYkB1jWjVgfjpa2CsLjYTwP394zo4I941D7J6fDQ8+sewSdl
         nUUXSHvfGiMaEh3Bmn+Iaui3bthod/HR/CV+FkoFF0L1mk6HF/BnNzKhuGdos7mHCHia
         7/WBrKH45PMtVUL4wsr7niKHaBRdi0E1tPxZlIqCn+OPDnjuOegj0kLnAzQ46eDnIrnK
         tNAw==
X-Forwarded-Encrypted: i=1; AJvYcCXm4U4lxamq3X6+n8j7FeFSMzDSQzrsSU/sJOYHPvXvGaM3UpdPNauQraZ3hhA03pSIDGPXcWsYKFAGEFFoGaP8YbCN
X-Gm-Message-State: AOJu0YyhxLcL7TmVemXBAf4N/JlN6RJmTWWlTFrhLMBbxe+XhIIMIZvb
	suYZDZy8/V0hlPjCHsA28bAEQZApsFYuWWOtui5p7EnVC4sP/ZiF7RDiBw0Atxg5+iQH3yfHfYz
	Aa3KUPP4amQ7zAI+2AEWJnTCDa/ZseEXazrS1ti63a3iB5GxxXg==
X-Received: by 2002:a05:6000:1286:b0:33d:568f:8986 with SMTP id f6-20020a056000128600b0033d568f8986mr1358990wrx.2.1709219376380;
        Thu, 29 Feb 2024 07:09:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPvDp2tEeycttUv+8+Q/VDHbB7H1MT6NCQE2Slpz3fPzARKF2uZWp4URju7LUld6IJljLBVg==
X-Received: by 2002:a05:6000:1286:b0:33d:568f:8986 with SMTP id f6-20020a056000128600b0033d568f8986mr1358961wrx.2.1709219375988;
        Thu, 29 Feb 2024 07:09:35 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-250-174.dyn.eolo.it. [146.241.250.174])
        by smtp.gmail.com with ESMTPSA id ck17-20020a5d5e91000000b0033e05589096sm2051813wrb.89.2024.02.29.07.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 07:09:33 -0800 (PST)
Message-ID: <9bb827bfc79345d02a063650990de68ce2386ddb.camel@redhat.com>
Subject: Re: [PATCH net-next v12  06/15] p4tc: add P4 data types
From: Paolo Abeni <pabeni@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com, 
 namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
 Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com, 
 jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, vladbu@nvidia.com, horms@kernel.org, 
 khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net,
 victor@mojatatu.com,  pctammela@mojatatu.com, bpf@vger.kernel.org
Date: Thu, 29 Feb 2024 16:09:31 +0100
In-Reply-To: <20240225165447.156954-7-jhs@mojatatu.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
	 <20240225165447.156954-7-jhs@mojatatu.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-25 at 11:54 -0500, Jamal Hadi Salim wrote:
> Introduce abstraction that represents P4 data types.
> This also introduces the Kconfig and Makefile which later patches use.
> Numeric types could be little, host or big endian definitions. The abstra=
ction
> also supports defining:
>=20
> a) bitstrings using P4 annotations that look like "bit<X>" where X
>    is the number of bits defined in a type
>=20
> b) bitslices such that one can define in P4 as bit<8>[0-3] and
>    bit<16>[4-9]. A 4-bit slice from bits 0-3 and a 6-bit slice from bits
>    4-9 respectively.
>=20
> c) speacialized types like dev (which stands for a netdev), key, etc
>=20
> Each type has a bitsize, a name (for debugging purposes), an ID and
> methods/ops. The P4 types will be used by externs, dynamic actions, packe=
t
> headers and other parts of P4TC.
>=20
> Each type has four ops:
>=20
> - validate_p4t: Which validates if a given value of a specific type
>   meets valid boundary conditions.
>=20
> - create_bitops: Which, given a bitsize, bitstart and bitend allocates an=
d
>   returns a mask and a shift value. For example, if we have type
>   bit<8>[3-3] meaning bitstart =3D 3 and bitend =3D 3, we'll create a mas=
k
>   which would only give us the fourth bit of a bit8 value, that is, 0x08.
>   Since we are interested in the fourth bit, the bit shift value will be =
3.
>   This is also useful if an "irregular" bitsize is used, for example,
>   bit24. In that case bitstart =3D 0 and bitend =3D 23. Shift will be 0 a=
nd
>   the mask will be 0xFFFFFF00 if the machine is big endian.
>=20
> - host_read : Which reads the value of a given type and transforms it to
>   host order (if needed)
>=20
> - host_write : Which writes a provided host order value and transforms it
>   to the type's native order (if needed)

The type has a 'print' op, but I can't easily find where such op is
used and its role?!?

Thanks,

Paolo


