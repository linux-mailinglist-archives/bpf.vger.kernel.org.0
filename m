Return-Path: <bpf+bounces-62413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B81AF99B9
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 19:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440345A7554
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 17:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277FA20B7F9;
	Fri,  4 Jul 2025 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlnoQtu8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C382E36ED
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751650489; cv=none; b=RjvaWwKSn0550A55Tk9jyaqivpjkT//1m/pTYODtPMVt6o6Ic4/qf4UhOz3lkx6XLO+ivWPvGzRDWkZdHX6m341+UjR8osuRxde7rCFfO92kvV31EIYlcyd0TdCnLBKVGydMASBw3oY59OGYz+jWI1nw584t+jdHmtjm/Uciups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751650489; c=relaxed/simple;
	bh=lZzoMefMJQEHWWMw+S5C81vYcQ4VbPzb+0y4T/3TRUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKybz8YcjWr+1eWLY5fYU45IVhKBYcwSLt7bB7LJED0NLFT2/cX9vWLnuDLAACHmNkn2eykLaL7Df+4sKpmkE4d0iFri/cuCPhD0jS696kKXPUsLY8kQ5E766M4NeKaWEw/jLHq+k0rHVcugbiXNIP3/9rG/fvOhNUQwQfQ7t8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlnoQtu8; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ae0dad3a179so178749666b.1
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 10:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751650486; x=1752255286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lZzoMefMJQEHWWMw+S5C81vYcQ4VbPzb+0y4T/3TRUQ=;
        b=ZlnoQtu8hsKq7rGYd6p0FKl6//RacYLCGjZK97bYk/p+Q5YcKoyVnp0xGH39Vwo3lW
         4KaSpjYtShDDIjbIOeUYWtST+lrDf5zY3TURAwcmuzI9AYVFRVJJ6+gXPbZCaJyX6ECk
         A4qmHSrEnK8Fze6JuOxtzp6JI2d8kO/dEaMRWC+VjgTbiFL4zawmWOqBgx9lK7SXSQ4R
         7yci5w8rFGNNDwbNt0b8Gfw8B/KFUcRMdT5jU1kf4RaMcR7lIcCObMZ4uNTKoQRY8Cmw
         aXPd50oBcXeytfYyxsoFr6ETGxYeHX34pDf+PMUWETuYBPf/RPc83seu/BtMelzvndZo
         ljig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751650486; x=1752255286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZzoMefMJQEHWWMw+S5C81vYcQ4VbPzb+0y4T/3TRUQ=;
        b=TWodqraouf81FAkzpsXrwKU9omfN1XiUGkZ0iTERRaCpo3OK35FOK5XJnZSsTQAR2B
         QHfz9zVwvPbGscB4zvz0lOQh0tGf87CTS3CI4Zo5yeyBcJUFe7in07s+KbJUHjDT2nBC
         zTi0bNNfWY+57Ovr5JZ9RewgQLai09TTv9OivQdafrfxsIt7yZ3H7hZ9b09q99IcmP04
         z+99dBPZhDcSK4rbCFG/0HqASw8dcZkW4Q3Pt0ie8DWnmrXGI1k8EiUYskOD6jEJxtjj
         xvHP2bP3zrpObKoUE5addIquICOq4ugq1QXFkJ8eE36mvL7gwic9SB7kJA0C7hIKsbQT
         o+gQ==
X-Gm-Message-State: AOJu0YxABfh3dlrN5UyabRTD2/EIo/C4uAqQI0E5uKPqXBg66Y5VTB0C
	pvxosmt+adfN2af2vq8RYafHQOF0ntj4DJe/5fPhpi8MfIKdnEo5B5+KO6UJk6JQAWW99xuO7He
	uRLSdqs4DyZTaL4hCSSfT5cCvTifCfXk=
X-Gm-Gg: ASbGnctTSYqwZae54bL7sydn4e2lzKfRDk6c371ORpRKUR1u/b+Mma33B4TAXnEDFgu
	XKEZbp7ERSZzDXCHjpTjUC66dMj24qj2s+jHS16CWm/bBs6CZLR7EE69iN7VNafkyZYXPABvyhF
	EbhNrrkUa9V+LV17GDWb+ZSQJ7bZ6h8bcDL23bz3uDwB+UOyXjSofjn3aW/UH0r+Av1XkzWgryJ
	2s=
X-Google-Smtp-Source: AGHT+IHsLyfIa0E336VnA7wLrv3PVyV6BTC4lkjAUj0hB1qRGB0VS1AGGvY7UGU/vODpPUeIVTJslUhxph/hOz4YMOA=
X-Received: by 2002:a17:907:971a:b0:ae0:9363:4d5d with SMTP id
 a640c23a62f3a-ae3fbc405c7mr331635066b.2.1751650486211; Fri, 04 Jul 2025
 10:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702224209.3300396-1-eddyz87@gmail.com> <20250702224209.3300396-4-eddyz87@gmail.com>
In-Reply-To: <20250702224209.3300396-4-eddyz87@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 4 Jul 2025 19:34:09 +0200
X-Gm-Features: Ac12FXzfWu8djl6ngDY0EafenOjlULAYCL6SsxGeohCMVw3icgxk37ffel8xhRw
Message-ID: <CAP01T74PRV_0tH5GndHtZoySOid8yuPF7xZWA9QoHBh4=-8DAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] selftests/bpf: ptr_to_btf_id struct walk
 ending with primitive pointer
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 00:42, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Validate that reading a PTR_TO_BTF_ID field produces a value of type
> PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED, if field is a pointer to a
> primitive type.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]

