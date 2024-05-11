Return-Path: <bpf+bounces-29595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AF38C3065
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 11:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C47E1C20B85
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 09:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9791D535D2;
	Sat, 11 May 2024 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQwQnpRq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39F02D600
	for <bpf@vger.kernel.org>; Sat, 11 May 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715420422; cv=none; b=jVIG3/ywuvcYsPa/tAWaGd5Gtz7f5bSUnx9OtRUZckoVFeKJqJG/BTi5eubrdAiIWFRtL37bKPCZMHYcVg6JojBbW+1DawaLACRbXkjsWlITcaGkbx7vv9GytvPro88ouMcfMkPOBBLBxz4P0Szizgx5jIFZK8GPj9JLBW4UlMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715420422; c=relaxed/simple;
	bh=5N9nGFhO3sYS1SQMMfLSNCNTyNCpvxwZB/zfpgu7+F8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mHOb3i47PSx0j9xjzqxBApbK5LUq33b+cPta+ohntd57kLKSmbQB0YCKTyu1+gQfuJBHV5QrkVICX8asgpELpkkSEJNSxDfBMUPt7ZMECKKX4ctDlL0pYirMYIc26CDx3TLDLTsCcQAT4ynvXK+emPody89WrPoRuvPzgl1v6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQwQnpRq; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f44b296e02so1798486b3a.2
        for <bpf@vger.kernel.org>; Sat, 11 May 2024 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715420420; x=1716025220; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d7zZ24q83OMM63zb/Ju/JQsWrPKcknTOu+JtvHByTPk=;
        b=UQwQnpRqBxXy1srOR97/00Yune/f/QRcCcFHHgCvlNGUMPgr8+iurXmQ8XYKoHl3NG
         F9B1svJ2oQXqjbG4McTVqnheBmLm44aUnkVpKucCJHEMCYtK1yCW6OaffT8UXYUCSo6c
         e5W6Vn6XhlEmpDo+i4wdXywXg9bjarzSlNdPkcvmls1QXs4VlDG5YPwIVXaPmulPjXhu
         xIO+v8Df19BO6r7OCfprkBMhOHX/+QSlsGwipPmMZQ8dvUByNo/QT9XZSjzf57uOCw6X
         gt6/Wm/C6b/6rIJl1YNjpK4YfaUC0/z/xZMzcnRzpaaW5q2yqdoJCjcj1/3t9IW14LKT
         wnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715420420; x=1716025220;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d7zZ24q83OMM63zb/Ju/JQsWrPKcknTOu+JtvHByTPk=;
        b=NFVwP9QgcCeNrMjsjg3gzoLr8hvKZ1xcChR1G2dEx5Dq1CMxF/kOnWoaM/1bW+GGjp
         a7kIRuP16UdSfmY6f948y+KrdGMBlXQAaepp4eRSXZzk916ILor/vEzRReYyEVtirmFO
         P1xjtZjA9XlEtWPXJuWC1pZOy0p1W3wSZyO92ViC3Ya4ujl1Fk/PQsNmQpqCf3RKEdNg
         gfOFce+kzBceYm7fYjemfx5ghI5uQ0M2KvMvD97fHEmzlkN9+7pG23vYxBk4LUL8g160
         U+ldXDYf2gvNqGDCQGFOl7NQMdlWNOZH/qLAeKLVXt5uvlzshFVMrq6INxatRES8BSXQ
         37hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI0h7M8QgrAoz+H88AnP8RSoaone7MwDHi4l7qvmrw+ZyMv4kIfPUEA+3IvxKTc+aIFsDGUyGwI0zirN4KhnMGFdxR
X-Gm-Message-State: AOJu0YzTxlpyuuE188WjoKs+lHG31bZSAPexwVVyFjlMezswdhbnh1AS
	f1ojMKTbeQmVCZQ9P/gB/tHUZplHLvepFv7su5WfhcHqOq6alpf9
X-Google-Smtp-Source: AGHT+IGdZcQl8/nMlquER9Im6frPpCbswl9Y6KgXqUsdL4pax6aURrGRBf3I7lFMBtsfPVzCaFkBKQ==
X-Received: by 2002:a05:6a00:1409:b0:6e8:f708:4b09 with SMTP id d2e1a72fcca58-6f4e02ca543mr4914144b3a.15.1715420420162;
        Sat, 11 May 2024 02:40:20 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2afeafasm4168966b3a.165.2024.05.11.02.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 02:40:19 -0700 (PDT)
Message-ID: <e161fa605db9eea0f55ccc724051bda6bcc7d058.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/11] libbpf: add btf__parse_opts() API for
 flexible BTF parsing
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Date: Sat, 11 May 2024 02:40:18 -0700
In-Reply-To: <20240510103052.850012-4-alan.maguire@oracle.com>
References: <20240510103052.850012-1-alan.maguire@oracle.com>
	 <20240510103052.850012-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 11:30 +0100, Alan Maguire wrote:
> Options cover existing parsing scenarios (ELF, raw, retrieving
> .BTF.ext) and also allow specification of the ELF section name
> containing BTF.  This will allow consumers to retrieve BTF from
> .BTF.base sections (BTF_BASE_ELF_SEC) also.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

For the sake of discussion, what are the benefits of adding
btf__parse_opts(), compared to modifying btf__parse() to check if
.BTF.base is present and acting accordingly?
btf__parse() already does a guess if passed argument is an ELF or a
RAW file, so such guessing semantics seems to be a natural extension.

