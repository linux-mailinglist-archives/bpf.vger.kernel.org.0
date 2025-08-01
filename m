Return-Path: <bpf+bounces-64941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11154B18969
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 01:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB525A1AA9
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 23:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7DF24169F;
	Fri,  1 Aug 2025 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLIOjx1G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F581917E3;
	Fri,  1 Aug 2025 23:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754090810; cv=none; b=rq6yk+803YVhCPPJAV3YDvU32MchyXJvUHa79c/JMIWa1uLU61lpX60w7nA3ea1eOcqIbPyuieH/459c/Kc0R5ALadylKNjby9wnCFD4FNPzZ25DEBWWekzYCg5Sy/TJzSoH9JJV499SnZbytONIf6gAbBpm70eQMyLOVbCQXs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754090810; c=relaxed/simple;
	bh=CjsEjwLKMohIY6SiNqukeS4bVku8l/Rw19rjVinTH/w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gx/61ZZntiRVRMxv5/DnFsRzosTtnWMcH5DUftvVhmbuLiUbsb80fVh1o99+ct5GMlTVnQ4DFpZOrl30SZGRI21UmPeYS5xXn11u+/9NbONWNXoo0GaTe0vHc+9TW7JGpgtxr6uNmjMrvdLl0Xdz3KEbr0e0t2HLRh4qa2foRnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLIOjx1G; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23fd3fe0d81so22142145ad.3;
        Fri, 01 Aug 2025 16:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754090809; x=1754695609; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CjsEjwLKMohIY6SiNqukeS4bVku8l/Rw19rjVinTH/w=;
        b=FLIOjx1GpV8hVPnG0dUiJbj19duRdU+Ytb6bj5W9FCdarLZqnBWUTD5JFjmbwrXDr2
         c0SaLsP0xlMD4bgavqm5ECRew1R9KWyqvsnGVMg/fMN1H0Rr6P9jRh7J9hDK2zY9AOlG
         wLuNG/SrtSk0e51DBI2i1CJO8N235vxsHxK/OaA88x66+gXOGnemXLc0gnomeaDmpa9s
         em4FxT7I/8YFbpYxffeJ3Ow6qx0RVCoKSveEBT0Y0aTeIBRqEzPn8S5ij7GUpLvKXKIJ
         cEwyxmxuSpL9SOHe58tv+6IlVObiZbobI8aP/ej41P3RgFCKstqDlT4+0tA+zvSZ2VHB
         xdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754090809; x=1754695609;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CjsEjwLKMohIY6SiNqukeS4bVku8l/Rw19rjVinTH/w=;
        b=oFmqaNRv481WFcVS5OhrZVmXEseVgF/7No/wRbXLtx+m9b5f8w2Ssf3VHCPieqxcbK
         0cbeyKCylDApziUkThoz9C/BiR9WIzIY3gbHicwzeIG7WWC+v5jDwvGzFbrg8H9o3DYh
         HDX+OqqDIPFg2l+bdnP8ZFpN9Vq1SoGHjr8KWPzhrLnaI9pT9KW2uHEkg0D98R2/e/2J
         YzKkYfPDYLwAYelRELjMnCNT9dQVl4uW9h0hJMdjkGSu53P3YqbTxglVSIKEbA4RvRYV
         mXEwVsC5mqGtt44LzhFWfWFaZwcEvf/lcE7+A65q9ZDoyrLYt8vEAf2Qs6M6QfXKG0/f
         AwOA==
X-Forwarded-Encrypted: i=1; AJvYcCV+tojIuYaV/cLJ5qY3ACBJnsn+l/1fUP9j75vGRon508UNdS3qTZC64lYWanp7jsL4GRY=@vger.kernel.org, AJvYcCXsgO1d1VYwxZjdfDYweahCOYx5T9C4Ttyldn2jeIzKcNsoy11gH70s4+tuE5TsUPyGCxLLZLAsSG9oaeVh@vger.kernel.org
X-Gm-Message-State: AOJu0YwOvCgTLfcgPzoNhJF1L1wgPonxHklDEwbH/4+PXxuK3RPILmXY
	5joQrRAclRdcxgaRNRcKpyOuhPTPrIjXtb9aPM1Qil8ojL+0AR8K8ADI
X-Gm-Gg: ASbGncvQUr3lfsBv726QkUQ67t3VbIEmOEzbBs0d1VDmrhC1WGDaGPJehY6kTi6sj0q
	ixn0tEw5ip7VRsAhURdhyfLIztcY473hrbze5WPXLJy01BlciDxnHJsjj4OepGwGzgjIV47ifYz
	yEP3dwet/A9hGIsQvGsXqIDw7qiJbQ3kvUuBWahDfD9lTSkhCver18syXKuFDxBIHfQNgzBAj43
	G1MW6crDsQrF28oHELiGO6sf16SNSncdJdPHE9tN40UVc7gLWZqbw/t1sMksgq3tElCgr9Rgpp4
	nnBo3PHxsQsPI8KSv25OJm2iHmMfMXGrts+uSpLBuE7+1nlFZc8r3R0Gm+aktmgdpgYLJlBJmkz
	YJtWhAdeWChQQslD8IQ==
X-Google-Smtp-Source: AGHT+IHO9jIrv2kAux0MKbScAbQT+1RyScN/wJO8AjoqAkeoU07vc0oTFKhW0hqJ4pde5HjVgKyBwg==
X-Received: by 2002:a17:903:2b10:b0:240:1bca:54 with SMTP id d9443c01a7336-2424701a079mr16921255ad.35.1754090808753;
        Fri, 01 Aug 2025 16:26:48 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b491sm52621405ad.131.2025.08.01.16.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 16:26:48 -0700 (PDT)
Message-ID: <64519e18c688d063c26a42788feec2bc0172ce52.camel@gmail.com>
Subject: Re: bpf leaking memory
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jens Axboe
	 <axboe@kernel.dk>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  "open list:XDP SOCKETS (AF_XDP)"	
 <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Date: Fri, 01 Aug 2025 16:26:45 -0700
In-Reply-To: <CAADnVQKXUWg9uRCPD5ebRXwN4dmBCRUFFM7kN=GxymYz3zU25A@mail.gmail.com>
References: <97100307-8297-45b2-8f0b-d3b7ef109805@kernel.dk>
	 <CAADnVQKXUWg9uRCPD5ebRXwN4dmBCRUFFM7kN=GxymYz3zU25A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jens, Alexei,

Thank you for the report, I've reproduced the issue and sent a fix:
https://lore.kernel.org/bpf/20250801232330.1800436-1-eddyz87@gmail.com/T/
This is an embarrassing bug :(

