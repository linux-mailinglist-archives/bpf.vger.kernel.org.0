Return-Path: <bpf+bounces-46980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9242E9F1C91
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 05:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE5A188CBC0
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 04:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A860153804;
	Sat, 14 Dec 2024 04:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5+jGTvS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B563EA76;
	Sat, 14 Dec 2024 04:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734151317; cv=none; b=MZHGZLo08znmhhH8o1P3GHQRa38GTEDGwy+b50nDig5BV5zmEWKxzQ+9WUpNupVqV6CQuQnXm884ugpFGuK/V1EgaWXABpwAkbbxCiWfytQ7CpIl5HiB3FEMZC4jf/jEUd5tPBWTZSO4mJZwzKAjM8d/kLN+Xqx4ySw4U+LVspk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734151317; c=relaxed/simple;
	bh=+AVELdyzOIHDGoMMlweQ39WqImOFGFNozE95NN8OHiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5AEqq5eSRaaKlFWv7Ho7bf0WR7UhCP4oDbCE9kCDC1BgNMpulDKIDIZKxmrI+evin0fkqsQe3W7V3MJI6n0l1LZw43DtU2bV5GIzH+ZlFsgLkcBb5wCKAKWHFhRv3fXurd4B9h6eHdy1NtJyFAUOOq/8c5evcT6miXhqVt5a64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5+jGTvS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-728f1525565so2867062b3a.1;
        Fri, 13 Dec 2024 20:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734151315; x=1734756115; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EYq4CsNZjrC8jRCckwbN6gR4+uLQRTBuJWwtQHsAlJg=;
        b=U5+jGTvS2b8LA4GOt/rtr2XBPDdQRkdmsDRioeqO5PFUljrbZAcA5pBPDSQYzt1QWu
         z0uG8gUoPqhi1T1Nwb4GC0fdDe9FPAtVxhAVt5AC95h8vC+GQH1TPNj9wxswQIs4mXIT
         i4FkK0DnRv6V9rv6MeY0TXrkOuEYVKfY7CV9iZq5E6DTHSw3exotTd9Hd8I2ARLIvNvp
         AySpwPJ7/WARYpxvBNcPD/hIidsW+ogyHWpOGFcRY9gfhsfIGKGH9FyEuCSrJHwtFnek
         GAPG6L0P+vhIDSSJNO9IMnI90gSuBuV+5LN4c2m2BBCM9SHVnJ44uNeDQ4lYh8xvicR8
         1w9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734151315; x=1734756115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EYq4CsNZjrC8jRCckwbN6gR4+uLQRTBuJWwtQHsAlJg=;
        b=Mha68UT0R18mnOdXJnxbmwj65isXZE2rEpVU9ehBPp+oT1VtmCB0z0rv1U2P4e5SAI
         7yixda2Ft+UwSm8uRrhYpruoSBnTcBHLDCfwBr2PVUGeTAda3B/AxB71T4QpokxIUfCW
         LzzsA8ybxVolQJW6E2HsAuXACe/xLfwEpZbf6QDIXVt0p8eZpuiSAuXKwDkJJTI4nraP
         ryvlpYgaNE7/bMjJhasj4v7a5slsSWppB5FzDXWbobHsIBNMefzvrjrmXqI26K9ipiLP
         0PcW7oClfyjDXBxVqtJD2lOa21g9ps7rtsiikemt4iHGWpoGwqv+RRjZ9qNqlTn0anRM
         9vRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHkJSFmYSf5NtM6EXlUo5aDnvv+8W8W9uIf6edHv+ccykhUamdpsmcNqt+PCJ4H3XUSmo=@vger.kernel.org, AJvYcCXxefNtyr3ZwrtQ6+chAfuH03WY3WkRoceUXWN4DNS441nfJfPYTxJWmlrtmQrWUNA4H4HMDCQYQKuYiv+3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2g36GDKrJIoZtvmJdpadxauWk1PqaqUHPBxoAqS/wNCYZIn/I
	y3ZOPnUDqbX5OWZ5C3tFk++S8G53WTflHd5ZkNaYQ06ey+t4ihES4wglpw==
X-Gm-Gg: ASbGncvW4pHPLaKFpVn941IYiq8pb3uZKrJUMD8ecY6zR3L3EsIxhLG8ehAcnyH5uJu
	LyPWaimWoQ1wChrdbISJdSdpDG8VdNNYiVtxDm5JMiu6Q1rFhphS9YkL0yrQrUTKJeGkK8mF7Bu
	mebQZ5dCi9NK58HOyTV8vaaOom4dBszCc2sgsekxJUEqxB7Cu2hEKuI/PBYy0aJuaFEmV2Q59kL
	geBE6y0B4ZwbP7G9S/DgDTBNbs5ngtofMQJ+KCbD8zXlgpLRBUCD9/nzS6YEpI=
X-Google-Smtp-Source: AGHT+IGD0l/sDBSKWTl/6labt0D+JZ9x1G6HBPH9Etp974M/uN/Acb/6mNtu/KVlwnu9bTJz8bLqfw==
X-Received: by 2002:a05:6a00:4645:b0:725:e057:c3dd with SMTP id d2e1a72fcca58-7290c2657d8mr6941902b3a.22.1734151314933;
        Fri, 13 Dec 2024 20:41:54 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:ede9:5cb0:814a:63a6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b79066sm637525b3a.129.2024.12.13.20.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 20:41:54 -0800 (PST)
Date: Fri, 13 Dec 2024 20:41:53 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Laura Nao <laura.nao@collabora.com>, alan.maguire@oracle.com,
	bpf@vger.kernel.org, chrome-platform@lists.linux.dev,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on next
Message-ID: <Z10MkXtzyY9RDqSp@pop-os.localdomain>
References: <20241115171712.427535-1-laura.nao@collabora.com>
 <20241204155305.444280-1-laura.nao@collabora.com>
 <CAFULd4a+GjfN5EgPM-utJNfwo5vQ9Sq+uqXJ62eP9ed7bBJ50w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4a+GjfN5EgPM-utJNfwo5vQ9Sq+uqXJ62eP9ed7bBJ50w@mail.gmail.com>

On Thu, Dec 05, 2024 at 08:36:33AM +0100, Uros Bizjak wrote:
> On Wed, Dec 4, 2024 at 4:52 PM Laura Nao <laura.nao@collabora.com> wrote:
> >
> > On 11/15/24 18:17, Laura Nao wrote:
> > > I managed to reproduce the issue locally and I've uploaded the vmlinux[1]
> > > (stripped of DWARF data) and vmlinux.raw[2] files, as well as one of the
> > > modules[3] and its btf data[4] extracted with:
> > >
> > > bpftool -B vmlinux btf dump file cros_kbd_led_backlight.ko > cros_kbd_led_backlight.ko.raw
> > >
> > > Looking again at the logs[5], I've noticed the following is reported:
> > >
> > > [    0.415885] BPF:    type_id=115803 offset=177920 size=1152
> > > [    0.416029] BPF:
> > > [    0.416083] BPF: Invalid offset
> > > [    0.416165] BPF:
> > >
> > > There are two different definitions of rcu_data in '.data..percpu', one
> > > is a struct and the other is an integer:
> > >
> > > type_id=115801 offset=177920 size=1152 (VAR 'rcu_data')
> > > type_id=115803 offset=177920 size=1152 (VAR 'rcu_data')
> > >
> > > [115801] VAR 'rcu_data' type_id=115572, linkage=static
> > > [115803] VAR 'rcu_data' type_id=1, linkage=static
> > >
> > > [115572] STRUCT 'rcu_data' size=1152 vlen=69
> > > [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> > >
> > > I assume that's not expected, correct?
> > >
> > > I'll dig a bit deeper and report back if I can find anything else.
> >
> > I ran a bisection, and it appears the culprit commit is:
> > https://lore.kernel.org/all/20241021080856.48746-2-ubizjak@gmail.com/
> >
> > Hi Uros, do you have any suggestions or insights on resolving this issue?
> 
> There is a stray ";" at the end of the #define, perhaps this makes a difference:
> 
> +#define PERCPU_PTR(__p) \
> + (typeof(*(__p)) __force __kernel *)(__p);
> +
> 
> and SHIFT_PERCPU_PTR macro now expands to:
> 
> RELOC_HIDE((typeof(*(p)) __force __kernel *)(p);, (offset))
> 
> A follow-up patch in the series changes PERCPU_PTR macro to:
> 
> #define PERCPU_PTR(__p) \
> ({ \
> unsigned long __pcpu_ptr = (__force unsigned long)(__p); \
> (typeof(*(__p)) __force __kernel *)(__pcpu_ptr); \
> })
> 
> so this should again correctly cast the value.

Hm, I saw a similar bug but with pahole 1.28. My kernel complains about
BTF invalid offset:

[    7.785788] BPF: 	 type_id=2394 offset=0 size=1
[    7.786411] BPF:
[    7.786703] BPF: Invalid offset
[    7.787119] BPF:

Dumping the vmlinux (there is no module invovled), I saw it is related to
percpu pointer too:

[2394] VAR '__pcpu_unique_cpu_hw_events' type_id=2, linkage=global
...
[163643] DATASEC '.data..percpu' size=2123280 vlen=808
        type_id=2393 offset=0 size=1 (VAR '__pcpu_scope_cpu_hw_events')
        type_id=2394 offset=0 size=1 (VAR '__pcpu_unique_cpu_hw_events')
...

I compiled and installed the latest pahole from its git repo:

$ pahole --version
v1.28

Thanks.

