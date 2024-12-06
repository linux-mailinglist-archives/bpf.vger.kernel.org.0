Return-Path: <bpf+bounces-46273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16739E6FD0
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 15:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0263F166C3A
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B71C207DE7;
	Fri,  6 Dec 2024 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd9yycqw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A92E859;
	Fri,  6 Dec 2024 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733494051; cv=none; b=f4Fqi+fmsYIVqFIkRfXQ/W3q7G4SHJJfP9vjF4PVVRDZMq9Vdb9QT9TQXmhqxNrwYImylKsmiaXsXSgSgm+7FDYX8Mp+mJFyLQc2CoFK8CAjr3U2Cz+WrC7uvAUsgBUhy5aA0b0cCF16lR98qxDPwvKByUrCBEQgsp8u2FRH9Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733494051; c=relaxed/simple;
	bh=sx/jta+Wb9ZwVoNEHk1hSDdJmw4dUwOZD7UQQFZ5RCU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG5MB/ZWRgLTh9XlQCXIk6fzPXw50Lx58b9p9+YFwGhe0bgcicb3GcPp5aL9As60iBFuCeIrTkM5N3a2jSmenW0i+eh0a89Z7pH2BvLuNgFfAnjuNbr6I6XPqhIGEBJHPz6LXFbT8RbFtrAe4EVWva1Zw1Rf2XUNoYBMxPayBag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jd9yycqw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4349fd77b33so20193905e9.2;
        Fri, 06 Dec 2024 06:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733494049; x=1734098849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qq2WzUXKXlrtbb9UpnZyt97wp4kPSMya0YHZAW+Hdhs=;
        b=Jd9yycqwn7CtHC9bDGdWev1VatOCCP2PXlHUMvRg6GAlZIsRNjgpC3wLu+2JJ58bYz
         JA5M+bpwsZH+kkYm8Myk/9MU0zeZuGA39DgNvZ69A18T8RSdIW4+EAReBwYmZH+sJsEh
         n4j6gI9tATTUYjLsIoVb91GoIkQD8ACQFpb2WLFJlkmTcfhQlzLd8NOhB3cW5gFACLZY
         j2xao+Jlsqmy+i47jY8zLyYKhYsVeijHyYA2dtSh9nchT3vLOEiCCS5ptVY0EOX9eG3q
         M+bdbq8iPRPY56mFGZHJSQdlt4i0QmCtQGjMvrJu/QudtbeTm/DCa7KJ7f7PyKdLRumm
         2ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733494049; x=1734098849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qq2WzUXKXlrtbb9UpnZyt97wp4kPSMya0YHZAW+Hdhs=;
        b=qTmZjV3npXWv4mmzpWH2zCEcQ4up+b9NlF7i8rVxqfo6M2yGopQIMEz8uZ/vQDxPdS
         xJJKP55OGTf39tXT1clQ9oc27j+Z0s1n1DsVhfrtN5BfhB1+chLwGVm1dhmygTcsofZV
         EaOFf0G7EOdbm8zKSmL6OZSnUA8BujGwpk3basEV01Q3zSHYTFxpjypglOA+DwfLk9Qa
         wbgIkr913cYyd1L5iXZJKkjXQZ/y/CcuyxlqkNnjqQPZsaanko3SXyQTgASCrnEsit+G
         NSLZOCOhuf67Oa37n2XWZBrm5Uu5t/ikIteZ1d5wScVmt9mn1eZeSz3UwHKF9ymssttO
         3ZNg==
X-Forwarded-Encrypted: i=1; AJvYcCX2pb1/8YAbzXLJ0MsWGAtJy++oTD7XKkaGX4KIdZ3GwFuzZIXAXTHN4RQOkM3vBm9JtOp211W5tZa/EF7H@vger.kernel.org, AJvYcCXq42PWTyGnzff1VnBuABcE6DpwTExgiT0ToDNO35rY2KpWZVnKQ5esEZ6RNBDTUNbF/Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz4ndO6l0fPYqnxdVVDdqtpRGorWBP8MMu1tAxg1T6Rxxlo9rw
	FZ9xMhUMblpLjJUY30Fmi+f+/L76lBtvAADm3lI3m6jM8qwmnaEt
X-Gm-Gg: ASbGncvIrFEfF8I3vYoz/MjpQl30TDF2ihBwvqKa775uZumSMpHTgo9FNPNYgRJoVV7
	CUWkbKrpYRhEyZRvhyhReXCMGAgIDW1HH6FenKDIAHuhWrjVNT1R5F3lrO6ISOfQEAR8W3x4OGM
	3Qm1LZgjNLoh97N0mvqcFhyd9fn48w5OxEB2eVZATaTAGTO+TqA0y4pvgSmnmkjW3ybfg+y04fX
	CKUcAWOoV5R7Qxmv0yFm4vFYQO+rt8FMZ5jDxDMS4yOs6FAgS2Z9ClbCn//Ma3ActRfyIkUdF53
	OdqbSwLgwRSSSfM6d6zLEj4=
X-Google-Smtp-Source: AGHT+IEvon1h3M6dJjb6WyrmhEJfYeu2W7XnzmfBThOVPZi0P+Y1DvwmCAYtq90UtDADu3/HfoTEGQ==
X-Received: by 2002:a05:600c:3488:b0:434:da26:e2e2 with SMTP id 5b1f17b1804b1-434ddeddc0cmr24827855e9.32.1733494048406;
        Fri, 06 Dec 2024 06:07:28 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621909748sm4563813f8f.67.2024.12.06.06.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 06:07:27 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 6 Dec 2024 15:07:26 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	mingo@kernel.org, oleg@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, liaochang1@huawei.com,
	kernel-team@meta.com
Subject: Re: [PATCH perf/core 1/4] uprobes: simplify session consumer tracking
Message-ID: <Z1MFHg3fd_BMQtve@krava>
References: <20241206002417.3295533-1-andrii@kernel.org>
 <20241206002417.3295533-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206002417.3295533-2-andrii@kernel.org>

On Thu, Dec 05, 2024 at 04:24:14PM -0800, Andrii Nakryiko wrote:

SNIP

>  static struct return_instance *alloc_return_instance(void)
>  {
>  	struct return_instance *ri;
>  
> -	ri = kzalloc(ri_size(DEF_CNT), GFP_KERNEL);
> +	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
>  	if (!ri)
>  		return ZERO_SIZE_PTR;
>  
> -	ri->consumers_cnt = DEF_CNT;
>  	return ri;
>  }
>  
>  static struct return_instance *dup_return_instance(struct return_instance *old)
>  {
> -	size_t size = ri_size(old->consumers_cnt);
> +	struct return_instance *ri;
> +
> +	ri = kmemdup(old, sizeof(*ri), GFP_KERNEL);

missing ri == NULL check

jirka

> +
> +	if (unlikely(old->cons_cnt > 1)) {
> +		ri->extra_consumers = kmemdup(old->extra_consumers,
> +					      sizeof(ri->extra_consumers[0]) * (old->cons_cnt - 1),
> +					      GFP_KERNEL);
> +		if (!ri->extra_consumers) {
> +			kfree(ri);
> +			return NULL;
> +		}
> +	}
>  
> -	return kmemdup(old, size, GFP_KERNEL);
> +	return ri;
>  }
>  
>  static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
> @@ -2369,25 +2372,28 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
>  	return uprobe;
>  }
>  
> -static struct return_instance*

SNIP

