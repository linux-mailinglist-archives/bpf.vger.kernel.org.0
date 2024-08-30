Return-Path: <bpf+bounces-38578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9419667A0
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 19:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D34B3B28858
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 17:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF2F1BA86D;
	Fri, 30 Aug 2024 17:08:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AA51B7901;
	Fri, 30 Aug 2024 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037686; cv=none; b=jmon0ieDUbNWdahBsCnXqlJF5Hzm9JKSYGTtKOC6zKAXg6+uz//ooE5Laav+Y1ASNjUCskCiOU3T7xDBALh5QQ808i3OxryJVxGdaGEGvdskYSYnROoFLbh03xFutEZRYO/ax8RpkwuIySn/nq0PUMbQt2xk7eKXqrSR/dRNBvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037686; c=relaxed/simple;
	bh=IJwVWoR9vmDTt73hyzZ3CPkIqCQjz9cth03BUJPMtfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKR7bBLQz8xLIl/15o15q0o2RZK+9WYFkl8Og22dlR0qVC0gZ0H4EvSu5/DhWQukNb88Q4rrOCCE0hGybmk8gip263bzX2+JcllvnmosJVI4MNwEt4JfJD5sPxibtqC+kQju8f6Qy7x/zQ0tZYjVAI0CQ2dHDEfYl+F9PbCpNVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7140ff4b1e9so1796495b3a.3;
        Fri, 30 Aug 2024 10:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725037684; x=1725642484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Kpqff1ZRNEMmL2lakzbO2QH+zWg9/hj7zWPahmr+F4=;
        b=SHe4Ugdwy/DjLLF0lOyfibXGUmmyqHX0r7MLgQtkZrCNSiuFMtZ3oiCNlctD3a5gb4
         g+L0JqZw5n4o6H3xuRSG2zbxxtO3vq8/dtc2/EmxPbGvY0SfGBjslSLB48LXIQTNB9cx
         MDIv5Dg72+g8q6KOy7h5hl/cYr/bXd3co5ILCy3pFlR4dtgpkF4n5YIatQY+OVDwKZNq
         VpI8+tPOQDGQ1pXgI3v5IBOT5W8cuBJTyC6WD1YPzJu5GMJtmlwRsiOeYVdrG7ggoIkc
         GdF/0uRISdqDcFmlARGwpq8C/OzXGo/Xdm/0ZwH4OZwLY4/upPJdhsy6uWPqkzSlVuch
         9ZPw==
X-Forwarded-Encrypted: i=1; AJvYcCV0+7alHsKW84zVEi2b9Z5lBobFtwDwFxBeQ2RqkWbmy5UCRDeBF7OW7sU389sdDuIFOEA/cwHeesnmF94Unm+sHMam@vger.kernel.org, AJvYcCWAQ8Yq8o5/+0kn0pUI1txSmAWgSWtl4tD3DDmePady8TGG0FuojQ7AVoomrgdON9lOzeY=@vger.kernel.org, AJvYcCXcdZNN3yNu6FMgMcaKhu5FCXnOcTmhG7mJdpXzrj5XNaSoxescCf18gEzit3Wf9HFBQ8/8tM3rCBBrGZAS@vger.kernel.org
X-Gm-Message-State: AOJu0YywpnFKiXXTKH6QH/ztFTALToQfFRmf4kLynprs3AEpkYpIHj/F
	Dem/w5RDZkI5+mP4BncLOjvxvej6bkIIzu9VqtLI5WAt2jf5OlE=
X-Google-Smtp-Source: AGHT+IFfkR/mjMqvMYaLtp7RlkJCVTndcSbys5q4XADfYm0UxuG1NuoNqkTIttVF0pdumPS8US+0pg==
X-Received: by 2002:a05:6a20:6f87:b0:1ca:ccd1:281e with SMTP id adf61e73a8af0-1cce0ff268cmr6682387637.7.1725037684432;
        Fri, 30 Aug 2024 10:08:04 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e77554fsm3253456a12.33.2024.08.30.10.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:08:03 -0700 (PDT)
Date: Fri, 30 Aug 2024 10:08:03 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Tianyi Liu <i.pear@outlook.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/2] selftests/bpf: Add uprobe pid filter test
Message-ID: <ZtH8c5EP9S7BByEc@mini-arch>
References: <20240829194505.402807-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829194505.402807-1-jolsa@kernel.org>

On 08/29, Jiri Olsa wrote:
> hi,
> in response to [1] patch, I'm adding bpf selftest that confirms the
> change fixes problem for bpf programs trigered by return uprobe created
> over perf event.
> 
> Oleg pointed out other issues with uprobe_multi pid filter,
> I plan to send another patchset for that.

Not sure whether Oleg or Andrii plan to take a look, but LGTM:

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

