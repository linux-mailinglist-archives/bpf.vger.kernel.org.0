Return-Path: <bpf+bounces-21692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1789C8502D1
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 07:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E5D282C8B
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 06:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E41018C3D;
	Sat, 10 Feb 2024 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ/7kQD0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3322B17BD2
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 06:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707547981; cv=none; b=ZAiEqbGAmnR+u2mk6UIxKD28mJaJUjADlX+ioMFclNdGelk2QqwKsqjuYVPv7SmbRbOA3il7Od+gaUWmDKEKZ4cDVsbwcTkPcySNu59wZ1xlApSbN4tHd5a95FIt4PSFpzvYcN0nTvW8RIFxUElPnXyCte7zCYzJdrqaxgoQMdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707547981; c=relaxed/simple;
	bh=kJkY5AHWOqObAweCuP2zdClK0TvjFJhtgwo8JH7kvGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQWuxHmTx9CzHAbtY5WtaJW5twgMHxRAD3WPfwN4XPQe1oZkhYGQO0PqpDhLHsVGNltl88U1hGMKS3edS5fLX1avZtj3xoKVKw3lMJmML3dMnYXzzy/u+hvIjCU9F2+odeHhygknsYpiDFyOJUF6ANXHqQNL9U92uaYS3K6Pw2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ/7kQD0; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a3c3be8c988so8990166b.1
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 22:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707547978; x=1708152778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7dJdLr/sIF3IpU/iFQovedynGnB9w67KGuY5Yb4/uvE=;
        b=RJ/7kQD0DZsftThyiEMkiSCzukKOW5VjQlYhjnt/OiCdRPjBZWwZtZbxnILM6fwHIT
         Xr0zBWSKQa6UtJtv/KE99NeshDz5NaGjmslSY3Wt7zFVmE/wuOOBULIliZ3YmznoDddS
         cRX4uMf2FnDKGOyEWNOeYkrTbdkj7RBRa3KovjPZO+W27/bcnJTcuwTDDq7haYgTM0S4
         eCRn1vH/OvjA4panT/YlreIQhwoL/pqRaGnSItyjwPehUB7UFYHcgxmfVvVz/xkpx9eP
         9gb6noBq2WKEsNr0Qvdu7ssrRluo6QFUhVLBJL7EBCM6ALBnd8i5dkIipWIHqR2JIp0Y
         bs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707547978; x=1708152778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dJdLr/sIF3IpU/iFQovedynGnB9w67KGuY5Yb4/uvE=;
        b=RvV+EuTifKwQBlPrPvtOzvYhrqfZI6XOOUo7Qj64HXlshBC5ajy6BnasV++Qmn1My3
         6KuSxhBdmNNOW+fd0N7Vs4d2up2yG88vc09VMsNC23GQgi36AlceFXJHvha20oTge5WV
         nCPLxDsEYKQuXmdvL76NJ/tTQjaVPmWHcW8kei/xR8SyZ18IgDIAY+7lnJXxzG9TcRxl
         +M0vVyrPsonc321ry2X3vXRTKmPbrap4RMzsU4XsJfqzoweVp1D2EG9CFy83dA21qRTU
         sf9arLoWSGHzCF/X8g4k1TtLBFvQf/TQzzPwaV/l8GxbertD9WwpjEz/9n8Qxe9hHjys
         vp5Q==
X-Gm-Message-State: AOJu0YwoxuU/pX0g4winSAagHht3xBH+t6oXGdYt64OEzTlABQ0gZBBi
	AfWpgtDndcPdXW5N6Pwga9zJBQj/oy27cFfB6rPpQCWA5ysvrP6IvAemFX/k2q2l33Nx0rLatr8
	Q27MmpE760ZoWq9ysH5+CcqbttnU=
X-Google-Smtp-Source: AGHT+IGy4yYJe1tXH3ggJrbUXrfdkuKyEseCtdxmACAT47cb4QZxxka7h//p1T4NY9IAXqOLFl7ZTGlRbzAZFi2xkNQ=
X-Received: by 2002:a17:906:29d6:b0:a38:4869:65cd with SMTP id
 y22-20020a17090629d600b00a38486965cdmr768937eje.71.1707547978240; Fri, 09 Feb
 2024 22:52:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-3-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 10 Feb 2024 07:52:22 +0100
Message-ID: <CAP01T76K5WF+6xOCv-KtgNBcwy7L35MDK-y4MMg27cX45XEZ2w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/20] bpf: Recognize '__map' suffix in kfunc arguments
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, tj@kernel.org, brho@google.com, hannes@cmpxchg.org, 
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com, 
	hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 05:06, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Recognize 'void *p__map' kfunc argument as 'struct bpf_map *p__map'.
> It allows kfunc to have 'void *' argument for maps, since bpf progs
> will call them as:
> struct {
>         __uint(type, BPF_MAP_TYPE_ARENA);
>         ...
> } arena SEC(".maps");
>
> bpf_kfunc_with_map(... &arena ...);
>
> Underneath libbpf will load CONST_PTR_TO_MAP into the register via ld_imm64 insn.
> If kfunc was defined with 'struct bpf_map *' it would pass
> the verifier, but bpf prog would need to use '(void *)&arena'.
> Which is not clean.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]

