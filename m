Return-Path: <bpf+bounces-73877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577D8C3CBD2
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 18:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E03B621934
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 17:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57DE34B677;
	Thu,  6 Nov 2025 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+RKSIdW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBFE34D4CD
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448676; cv=none; b=f1gCYlP4tvt0HpY2u89YtJhFRrt17J3gHpG3cMzzx1REHVo0kwc6/jAYusMKlh16Sfn57d62bMDgmdl8d44EwVKFZOJAPJs4kDJPsvuY1PR8Mtb31NjYemAjxeY2M318LGpxEPVNDfYFZYzk2HrOqX6Zn41SEZO2JsRMCjNi7vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448676; c=relaxed/simple;
	bh=YuYdmBDghipGmE1nbpNPBAT77OvjYzoGqMfR4JiIoOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNmZDtB6tOf8EhXMvsh7lQ2KPg86cvCf28f4ldz6OLoFGlb6EGKhDhmry2qYv1E52ZYgJHFHKd2Jm1zJUUYViqL6Oy3VYRE+jh22KYyqexhVFZfiXT6ykZdEP+WdXAYY6jRHUDIzMtUm082UbBLiw69kFzKgEZjfKfNXpypAgYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+RKSIdW; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-429c82bf86bso869082f8f.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 09:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762448673; x=1763053473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QOyS8/T+hfErsv9KKz8wCj9HdmxmsdppWqkOVGYx7mk=;
        b=D+RKSIdWxv3hgLZh0WjeS6w9/2gFKMeOuUxXrvYVBLO3FXGHVDzA6K5EXaWduxfSLZ
         2nmr71el+SHVv1jz1EkjRDsSGE9hdPQ3mQM5K7vW87bxl2dQDewwmTgIwOvwQst4hTQ7
         yIhVsvUBsXdNHwbP5Zx/ke52Qb6Jv9wiBAwbrvvo1BCi3qn+qvpMx7WAZPMWwdKIXvQA
         eP9qm3Nj3k1IMQvQmrBR/1oV+N1buKg9l+Y/OoiFhxH3ZIsOReZperLPJ+rxthbk8PPG
         2fFBBNAbuwKNwChcdtLkvQizRsPtaTMTuz1SCFhYqF18WAVK0d4ky2hn87JpywcEhTym
         oGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448673; x=1763053473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOyS8/T+hfErsv9KKz8wCj9HdmxmsdppWqkOVGYx7mk=;
        b=QDhcTzwEVbJglHFycCzTAxhMLa13vxmMznSk75R3DiSS4fAoTrcwgFEZGqXQ9FdVuE
         qLu3eCfi2MLMxtSFz2OebMAEZurTmnG4KS5ae/OfPppsT6ZSrgHKDp/60Odvxi8fAWx7
         mSO6MCcugxYJR7OHxGlsLzwO4wMdqszj6YsOPjEKITIznEiSfr5T87EAomwUmC9z8+Js
         /0Xkad8q7/yXaBRRZ4q5UrACx293gaGHU5guXoiH79WqFJz34Pgm7K3gjp2W3Kgh554d
         EsoFVoRlYqqibBj5m4X6G4hvnKWynqO/qkLEO0JXnRYQQFSnQpGS0dqdxjsj59bXA9jj
         c+DA==
X-Gm-Message-State: AOJu0YxxCZfjW/w25Z8dl74O6xaOtiTMpt5sE9WzpGlLW3q5ts4ZbJyr
	Ujsy9R9foDxJ1ALmNnDmURg4uPolQOfxi9IVk9D9uCmVtz2KQ/65TRI7mdfTmMkXnhju4Fj+GVa
	SpIdQFvVulQgHZkl7mVJ2i0gujX123kk=
X-Gm-Gg: ASbGncvp5eXPTmUdmcUpQyPEZKj0rcz56qiOFgPKAllvpYeSvcqImsevS/XtowA2Tkz
	BuThpGBl7XAVl4x/WVkKvP5fzLO2iE9v/zzg7rh0ewfRUftzIe36TbqIYWKPoUpVEivMn4x20Ra
	p6V15qkZ6psLDenyWfpTlfLnSJqgipX3MurGGvW6N8k4uGr4NvVgldB8hGQtev9JHUDZqZO9dR5
	LD2BqpZiO+KKSMdBqqVeyAAbuI0vNrRc2Lx64YoUk0zZKirF+ZDSk6yzP8RWAQjI1pT9G8Ra1OD
	VVFji4X0g3Xgv313MLga0mKpYwdUdJhc6jVyckCX+Iqn/r/ZPLTRf4ufUg3b
X-Google-Smtp-Source: AGHT+IFCQ9rTMRZYFeYklML5BzjOGwGm32LRyqsWJCzVTDOZyWw3bZZyxEd2B5GdRo6xDd/vSiYOHiu0KqEc8Y+Ssb8=
X-Received: by 2002:a05:6000:2885:b0:429:cf86:1247 with SMTP id
 ffacd0b85a97d-429e331395dmr6865705f8f.57.1762448673095; Thu, 06 Nov 2025
 09:04:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com> <20251105-timer_nolock-v2-1-32698db08bfa@meta.com>
In-Reply-To: <20251105-timer_nolock-v2-1-32698db08bfa@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 6 Nov 2025 18:03:56 +0100
X-Gm-Features: AWmQ_blMES0j3uo3Xx7NNf3ZaKyXDZaDa7frQZAEaPe2sz-eRxBzDuxPa8lhIDU
Message-ID: <CAP01T74rM9T1p68PbSS16_w0kWY1_mPKSTDEetqDQ9hHHjTMww@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/5] bpf: refactor bpf_async_cb callback update
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 16:59, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Move logic for updating callback and prog owning it into a separate
> function: bpf_async_update_callback(). This helps to localize data race
> and will be reused in the next patches.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]

