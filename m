Return-Path: <bpf+bounces-75058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E9BC6E314
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 12:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEC833491C9
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 11:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526F433E348;
	Wed, 19 Nov 2025 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwK0BLmo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D79930CD88
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763550806; cv=none; b=O8O3q0XB1ADK+ZtqglqmeeKu8XO7NzY+WaRlCgmNRuDYRgcaDXlh8XJDrvX44HacLMWjuBZwjgU9nxVq9aeRDLuBLJLBMOLwDIsKeJeknmKPYS3Uth7XSFszR9kK9a1jHJAbKXF1/5sL7A6grOj7TpZEPddKjiVFaIG9UVF9XfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763550806; c=relaxed/simple;
	bh=nb+mJ6g8xbD56YjmKiO9zA1XoGg1t2NzK6WrpvjSkW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKS+nAyEV4QiZwhRxjyWoGHzfigQV9IMTifIr8iFsUKBLBKbpdxxKY5XnB+cXpfKLtyzXZOBPNsp8U/8vxYizzrMqdO3MBCpARpifYSP45nLCIwjJD8me04srTUf2SYXbf6h93j1wOP5q/z1mN/bll6CgFtZFQ5uEMd9nq0t0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwK0BLmo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b32900c8bso3766138f8f.0
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 03:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763550803; x=1764155603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5IjPLdQYgzo4OkqbW+Jd1GzPleISY9kcaASlAVZ+fqA=;
        b=VwK0BLmoOmvkQXfsdNpRSasuSOWO2h/SrWT0WiDhErPmMsFeTu9Pc4ppbi/X+edSCD
         ibiOXozcAKDJVWGHJJTHZ2ok6GXsldODckwlpa4CMI7AYLJpizbtQ7tSF37Epgg8/1bL
         iws8ouAG2C6UIrHd5HFv/OLo8xM7/hh/AxOvt23ODsKOCDyCZcAL2YSufRP3njZgOnyA
         XL0cNPKBIusmZE8UFr5IMHgsC/eXHsPhCzsXdD8j4HNlHSqNcwiT9HgPxGdnvf6Dbmlt
         wuWNBkSuQSyfHhZ/vmhKyUfayaIZNtOws7mnYWCsylTt/jW/M26prKGhp659ot7ZMENr
         doog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763550803; x=1764155603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IjPLdQYgzo4OkqbW+Jd1GzPleISY9kcaASlAVZ+fqA=;
        b=REao2WmR070e0+TEgRH2Tu9qSA1V6fHovJaBMr/FGzA0ebqYZkHQjtzZQvYdKlsXXC
         x9mqwpsRqNm7MknAKgpdEfo2nAiOKc7ZcGOH7IvguaUvOIb6azAMbdt8MjrwktlS60/Y
         NyapEOVhtVchboJFpB4anIE4kATSlgwJFGyelCIj/gpCE9GF6eT0r0XhFy2d2zNvZlWi
         fSyZS3mpkA/A2svDH0+I63nY1TIHmAuhMyhs9/T9H5VfXFkV5EgNUK0yAU9RpBLXxu+w
         LPtRfNO0J+Q6oNbQYk/8/RKXhOmTx1dGhzWIUDvj6kNidj2ptOS7EhRJdYOMmiVOOX6t
         4F+Q==
X-Gm-Message-State: AOJu0Yw+p2H29F4s+VxnyC1nQ6VRSaQdjB37vJO5o6mrEDOZVvaC9r8h
	nKMxHO8OikP6RuxH8WFb7pRsI2gI7982J2VrbUQF/iz5m9HXfuDFvG8Izwrm1w==
X-Gm-Gg: ASbGncvhuuDTy/Wi/wOSmCt63kZQFjPg7WjncMacn3wfK0qXu0YumLl+H4ubZtJhB2x
	drIbPqXzqvxcwOdaB3n76DxSw97BiXAO/v6ww8I99Rn5xjEdEqLwKlyRPr6ViIxNYY9ZaJzE41j
	XdmkPlJeXLYizNUoyFvVXiBSi/0sHJsgE82dsZttz6I/0imta5JfZOC8bOg7ZEFUoZRWctaC/h0
	LkMEj5VvdkaVz4e3FVAkSBPFhPHPqhrOaBatdwlHlm2Oe/sDtrb2Kgx3sr5zYKO0qs7J7ubCyN3
	UK5rwDbAiodE1LLk4p5JEIsIrUhWVS90hGZ37jkfHd0ZlrjHvmMD+TBaNyVygAM/mz3ca1sj8Jr
	sXmrUkutLiuGjCTsPUOEgkza3eFOL9AYE5dcBA/6uHVnN1yLndk5z46RRdPAvTkDqgGaMFkA2FE
	CORP2kZ81U3Mz02icq26TC
X-Google-Smtp-Source: AGHT+IGF4Hup7dzgZ977iG91B9iMul0xQ5DqW5f4+85XuNqhEZrF/RDq3PvzNREE2BZRD/GHOwqo1w==
X-Received: by 2002:a05:6000:430a:b0:42b:3ed2:c08b with SMTP id ffacd0b85a97d-42cb1fc7b58mr2086363f8f.51.1763550803228;
        Wed, 19 Nov 2025 03:13:23 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f1fd50sm37634471f8f.38.2025.11.19.03.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 03:13:22 -0800 (PST)
Date: Wed, 19 Nov 2025 11:20:14 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: bpf@vger.kernel.org
Subject: Re: [bug report] bpf, x86: add support for indirect jumps
Message-ID: <aR2n7mrFwjucPsYm@mail.gmail.com>
References: <aR2BN1Ix--8tmVrN@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR2BN1Ix--8tmVrN@stanley.mountain>

On 25/11/19 11:35AM, Dan Carpenter wrote:
> Hello Anton Protopopov,
> 
> Commit 493d9e0d6083 ("bpf, x86: add support for indirect jumps") from
> Nov 5, 2025 (linux-next), leads to the following Smatch static
> checker warning:
> 
> 	kernel/bpf/verifier.c:17907 copy_insn_array()
> 	error: 'value' dereferencing possible ERR_PTR()
> 
> kernel/bpf/verifier.c
>     17898 static int copy_insn_array(struct bpf_map *map, u32 start, u32 end, u32 *items)
>     17899 {
>     17900         struct bpf_insn_array_value *value;
>     17901         u32 i;
>     17902 
>     17903         for (i = start; i <= end; i++) {
>     17904                 value = map->ops->map_lookup_elem(map, &i);
>     17905                 if (!value)
>     17906                         return -EINVAL;
> --> 17907                 items[i - start] = value->xlated_off;
> 
> ->map_lookup_elem() returns error pointers on error and it returns NULL
> (I guess if there isn't an error but the element is not found).

I didn't check the value here, because in this case map_lookup_elem()
always returns a correct value or NULL (= index is outside of boundaries).

From BPF point of view, map_lookup_elem must return valid pointer, or
null (see the bpf_map_lookup_elem_proto in kernel/bpf/helpers.c). But
some lookup functions might be called from kernel (as in this case)
or from userspace via the syscall. So I'll send a fix to add a check
here and make the static checker happy.

>     17908         }
>     17909         return 0;
>     17910 }
> 
> regards,
> dan carpenter

