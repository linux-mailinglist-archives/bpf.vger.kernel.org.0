Return-Path: <bpf+bounces-57837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AB1AB09AC
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 07:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CD54E4454
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 05:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEF4267B97;
	Fri,  9 May 2025 05:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqu/wKC4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF496267B88;
	Fri,  9 May 2025 05:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746768156; cv=none; b=iHgP2nLdTn4W3cTwqyIp1kfWLgUoNk1b20a7IRhhU8gqkqenO4I74dbACz6hymMhJxGQ5NqKcddjHdd4cljL9BvYjumF0fw0UGuviaTegjzX9HZYZIUpdwOYIksIUwURH8OOzcYsSuXnhtXC6hJFo7Oc9dfhcgs3MWR1KTVqMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746768156; c=relaxed/simple;
	bh=XfQTvmSjyPyy+6CH9FZOiwueHBOUm+MO52lytT4GMpI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGfaMGAZft/rHZru7XiwpBfc87PUSMZ70szGTyO4i5wJUaHu6WBsAYPJvrb6Io73OLNZpVKsPuOtlcyVpUFLinGckmvGw+M4oZLK5z0nI9HbNsmpn+zc8fd1+a5VIv7eOOXzJ+iIoKNySfaolpkF2QhUpyf5a4r+qST7RFQEi5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqu/wKC4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso2427586b3a.2;
        Thu, 08 May 2025 22:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746768153; x=1747372953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qz/HS8+9weEmQtB/EToBhh7O2Op5WXQd1ak9xeydgJk=;
        b=mqu/wKC48boDfXAvonuPeuPGLu8Az41OES6xBXtxLPFiv1w+eVruOBW4OI7Wpzefn2
         EFOK7LpUP5Q079tskRwBSJf5nVeFJCkCFg7JTsHDGecUCk/MAn0Gnr7aiN17+ocx9O/q
         ErSO9la/KOaXGnm4hL+3nT5YjigGfAGvT8NYd3TTXfmuuJvsauAbMPS7GQdKULpsP/bG
         SD9r0FqPTArlLKMrH/7+cEsRcEmdygzKX2aE3K54VkTjmkOroPsFHMi1O/ZJDhZblfBR
         uNWWIG21YiLmGF9sMI6NSq0iHngx8Rd7UdwsaSifOsGZzxvvce8ZC9IalYVC8QFEQ972
         PrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746768153; x=1747372953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qz/HS8+9weEmQtB/EToBhh7O2Op5WXQd1ak9xeydgJk=;
        b=JJuc66oIxUm1kp6WrbptDL8ZqvmCcPSD3fY1+ojzVljZ8VYoKnOiHhsmoiS8ZAmH1y
         2SojYCvM+Bw4cYDZvkqgjgY6fJJ7nqlU/WG4B54BdyjGoCHlTH4xakKPm1vY7vJeN1kh
         aIRIgC+M0yCuaC/LOiZjr55j+7LQ1xzFSERWEKJ0KA3uIo86+sd27RfpBGi7+Dgjy0A2
         wbygT22zR4BMAzVfEVvN1Tw74RB73N10Ej9kvny62uHQ3tuJSqDj5WjxiCJwllmt0BBF
         qZu6l/064LRrrK6WbRWsoP3TO+NQeVTkw+xk68GDGdYcvNNyS2FN2RJ5kB98S6NT+xX3
         lbsw==
X-Forwarded-Encrypted: i=1; AJvYcCXx7PcGKd7MarUoXBWhju1U7PozFPqSNJdv9ULQTg6lHjmlD+u8b16UGEPhJxoUQUe7jyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKqPWug61PFZ64eA8BmhaP6oVhmvJPhCRQtft12riVn7F5qNUq
	vnhqN/Bxmxi260kUS1F830n3Hoyn44PTwqHTUkXfRxm27fBqtiaL
X-Gm-Gg: ASbGncsH+fjdQu5/6BiWLBxVFITXMaK++0MV1KhIDVk+G+qA7VQKfWJ2Rpz/Xy/sEOh
	sT1ymz8UbAboQGUUF4J2aNxu6cHT8SEbTjLwUs51/eFw0P9Xy6llTftnWGWFTl5XYsXK/cEOYps
	6Y9QWxSJ+hIaafT6GTM1bbL0iOj0OwBLUw5xxnzgRqgkeAJCYpZBeBVlQaV+CMg/1IorBMFRQ5z
	ImIbXNjenbtzdK6lYpR5FQC7W1kI3WfuupeBdj1xQdkHkBGwTXxyig+zx0WeKEiafxV3muDCVP7
	qtavDCOwvzZ8iCu/0+TCzeEcBXR4bjpxHyZg0AxaqAAubOv+DZyiFN9QgzA2XaIBpOpiz08Jmtm
	haSzDxR9lnDYM41Xi1A==
X-Google-Smtp-Source: AGHT+IEKgSif6w19zsbhecMYy44wc8CoONleaUrfWV2y5zBCsQ6//kITI8Ncb01WlEJD8faflQM43Q==
X-Received: by 2002:a05:6a21:6d82:b0:1f5:72eb:8b62 with SMTP id adf61e73a8af0-215abb3ba6dmr2570543637.20.1746768153089;
        Thu, 08 May 2025 22:22:33 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234a0b29casm619943a12.28.2025.05.08.22.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 22:22:32 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Thu, 8 May 2025 22:22:30 -0700
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH dwarves v2] dwarf_loader: Fix skipped encoding of
 function BTF on 32-bit systems
Message-ID: <aB2RFj62fLMJPEKS@kodidev-ubuntu>
References: <Z/+HZ3w2KmbK5OAi@kodidev-ubuntu>
 <20250502070318.1561924-1-tony.ambardar@gmail.com>
 <e0754d8f-4ac0-4e03-88f3-2901d49ca4e6@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0754d8f-4ac0-4e03-88f3-2901d49ca4e6@oracle.com>

On Thu, May 08, 2025 at 02:24:57PM +0100, Alan Maguire wrote:
> On 02/05/2025 08:03, Tony Ambardar wrote:
> > I encountered an issue building BTF kernels for 32-bit armhf, where many
> > functions are missing in BTF data:
> > 
> >   LD      vmlinux
> >   BTFIDS  vmlinux
> > WARN: resolve_btfids: unresolved symbol vfs_truncate

[...]

> > 
> > Fixes: a53c58158b76 ("dwarf_loader: Mark functions that do not use expected registers for params")
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> 

Hello Alan,

> I've tried this on x86_64 and the issue of missing functions has
> disappeared; I get the exact same number of functions encoded. From a
> pahole perspective
> 
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> 

Thanks for reviewing the latest update and putting it through its paces.
I was noticing many small changes in my own testing so this is welcome
confirmation.

> However as mentioned previously I think we need to think a bit about how
> libbpf for example might accommodate such representations, as the
> implict assumption for fentry in BPF_PROG() is that the function call
> register conventions apply. BPF_PROG2() handles the struct case, but not
> the 0-sized struct case, and in fact there are checks in btf.c that also
> need to be fixed to enable verification once we have 0-sized struct
> argument support.
> 
> So in investigating this I've put together a short RFC series [1] that
> seems to do the job in
> 
> 1. fixing up the BPF_PROG2() handling of 0-sized structs.
> 2. fixing the verification failures with 0-sized parameters, carving out
> an exception for 0-sized structs.
> 3. testing the 0-sized struct case to ensure we get the correct data by
> adding a function with a 0-sized struct parameter to bpf_testmod and
> adding a tracing_struct test to verify the subsequent arguments are correct.
>

OK, I'll try looking at this for 32-bit armhf since I'm in the middle of
that, and comment in the RFC thread.

> In terms of cadence, I would propose that if the BPF folks are happy
> with the approach, we land this patch in pahole, then after that try to
> land the BPF changes. Does that work from your side? Thanks!
> 
> [1]
> https://lore.kernel.org/bpf/20250508132237.1817317-1-alan.maguire@oracle.com/
> 
> Alan
> 

Thanks,
Tony

[...]

