Return-Path: <bpf+bounces-44867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE119C949E
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 22:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430C9282814
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 21:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103B71A9B3A;
	Thu, 14 Nov 2024 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYVq9yZw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490211ABEC6;
	Thu, 14 Nov 2024 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731620289; cv=none; b=WqgF0Xtpqju2nsXQKPbCsmbQYth/xMuMO2JO3UUZ9UjJIcbVAnhG5Puq/pSnc7TmyJnBVO00Gr6IKWB7gkGYCdSwCqKmiJLqD7TLWVveC98hWEGVDXrFOxf7P3gRnB/sHUauJb3+HwCCDFHvM2YSimdO7OqC/z9TwUZS0WoIib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731620289; c=relaxed/simple;
	bh=7rDEMaejCi2GtR+ux2ViwqoEEufJHItJO0jh4NLwjs8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EdUubSgvphEjs6cYFh5mg+dfyEvwxWcP0cUBMLaUwHMT3b3lO3j4+jGjcOks9qmHrw0isLE4iTh2jPGwDWtiV98PhkbIuHg2CfCeoO7gjzD5V8j7CMWyiYdSfXWGD0NRCJ/a3+ekt2DRgw3Pv6R0YFkbKwUOeVuwbFkFbUk4+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYVq9yZw; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ee4c57b037so876324a12.0;
        Thu, 14 Nov 2024 13:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731620287; x=1732225087; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n1kWZSZUw4ZM1+drislSigduEAAkFVz6/ULAZiZRNtQ=;
        b=lYVq9yZwqnFAiRqWuhRd1Tb0VmD7JzLSmg33LVU1C0/tPbD8GAOlx7g6GRVItqpIX1
         N1BhgIniphWvqrLlsM1ZeMVA1IgApbib7FBd4sNVgW5fz0uBGX2CTDhAwcSwYfER0uf8
         CXxZBEnHJGxxBdPfUMeqzTyeaufziOhcczavqXppMDcCkpJQh5AsuTVN3Enro/Kxn2XJ
         hrbGc/V8K6YxlKBgRCDb/ELKteLe6Cj40zCUXAoyDpJo2SohvrIxV/2G+RLACwYQmrA7
         TcBTTv+t6dE9g/ZGA5Ti62SjmivWRUKoaqHWE82D3oxBXTJD4U2hbWpO09sxpUkcleXm
         sV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731620287; x=1732225087;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1kWZSZUw4ZM1+drislSigduEAAkFVz6/ULAZiZRNtQ=;
        b=cgZkVTVIlO31FofNSq7AlHYGV1I2OQq3wxqraFXPtyIYA/3YEvyqPAYZ/hpJPNyD+b
         tUvK+vR6PLyjcR9iajMG4d2VK1E2Cfhmgo54KVMHSdXUXNO04pLoNKTMWv2lRoG235yp
         3RMUla/scWdwu9KNN8PhIYCIadp8UVr/CPbJSmqFwN+HxvyH4YrcQktiaplx+0h+Nj/d
         +kFvBoVNDYXOJKSNLjOwvvCqBaIAqBHyyqb8Ighqe+HmFht5h0BqcuGgTgkE7Rb/Jf0E
         ybSEWirOg7BWIl3c3Gi4gIAs3J6ZIwFKYVtuXhwBIdZwhLlQukvH6m0J2/ER+3I76sqL
         YZrA==
X-Forwarded-Encrypted: i=1; AJvYcCWtka7gQTeuZm/43RJEN8vbtpJF3O+sUL5E5c9Lxg4aTzYv48Bj/knx0aKczEOtsye8Fiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9xDF/MaMB5Sy0uKQpJAwsXNK+R7oLQpMKeT8Dc4VSy7NyFLO/
	ePV+YdpH8598YYjKA8/ZBRPzSxtX4G13Do1Mtj+t312e+LCxR1Gk
X-Google-Smtp-Source: AGHT+IFgnSKoE3VLrg3wdK3d1LRYUGpagllEdvI/cQ04qrPicbOp6eSnJXf5Wq6vsrY6HVgWwPOZfA==
X-Received: by 2002:a05:6a20:12c7:b0:1d9:21a0:14e0 with SMTP id adf61e73a8af0-1dc90b23666mr301576637.12.1731620287411;
        Thu, 14 Nov 2024 13:38:07 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247711dffasm105558b3a.75.2024.11.14.13.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 13:38:06 -0800 (PST)
Message-ID: <49996d2679fa02a50d3ea7fbe5ccb6271017996c.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 1/2] dwarf_loader: Check
 DW_OP_[GNU_]entry_value for possible parameter matching
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Alan Maguire
	 <alan.maguire@oracle.com>, acme@kernel.org
Cc: dwarves@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 bpf@vger.kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
 song@kernel.org,  olsajiri@gmail.com
Date: Thu, 14 Nov 2024 13:38:02 -0800
In-Reply-To: <fa3f1a9b-7fee-42f4-9827-b28b1bb3eff6@linux.dev>
References: <20241114155822.898466-1-alan.maguire@oracle.com>
	 <20241114155822.898466-2-alan.maguire@oracle.com>
	 <8a08219a-9312-429d-a291-d93a932c849a@linux.dev>
	 <80623f0b630bd3761f0239dbe0f3197dcc6ae575.camel@gmail.com>
	 <fa3f1a9b-7fee-42f4-9827-b28b1bb3eff6@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-14 at 12:04 -0800, Yonghong Song wrote:

[...]

> Should we do
> 			...
> 			dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) =3D=3D 0 &&
> 			entry_len =3D=3D 1 && expr->atom =3D=3D expected_reg) {
> 				ret =3D entry_ops->atom;
> 				goto out;
> 		}
> 		...
> ?

Makes sense to me.


