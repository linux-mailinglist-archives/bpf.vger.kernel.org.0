Return-Path: <bpf+bounces-46266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4E49E6E59
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 13:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3489028575E
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 12:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F53C202C59;
	Fri,  6 Dec 2024 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vwhbf910"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34131202C3F;
	Fri,  6 Dec 2024 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488515; cv=none; b=E4fOHFAi10G8durQraE0FHiDqmwqSAik1TDggw2O1lGWZWtY9EYSsh1lxzNaT5b4kzC0zygstdtMiQgINfpP5ZhOFp5oXnUzOVDw07+bldUUfMWo94+8rzKCCdb6/qN8FeoePYQH/mnNfqlx8Ga72udS6cYXTGwKE9EKma5LAh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488515; c=relaxed/simple;
	bh=tglxYqpw8kY5WRMteTGZtIlEcVhj/Jpqf8p32WV1aVE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAgyPiCpg7oUbjXOeMFMenxZqPobHW9jfBdUXIhmo0YdmotzUwUFcWPK1GTie9tQuIarI7AQfU8U5u64rwqnd+GZg5Hj7S9IGfORdpsz/ll9XCw8NJbpqc2B1Gqr6rTKC76FQUcDMf3sgDyxq8/oe+vHWNMimX59wnoGcmVxOQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vwhbf910; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d0bf77af4dso2079175a12.3;
        Fri, 06 Dec 2024 04:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733488512; x=1734093312; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g6PvnI7O8BCrsugwoXvIAfj4V3SCjwh4w+40SQgRUeo=;
        b=Vwhbf910UqMvZ94GkOWBUpGQuC2qpvivaXzoLobeeG0xyEVkqKT9jyCTjwKjWDhT6I
         NCjwjFhpZF2kp7kG2UTr1E1Kx+hPRHPT1ZV63UX01wD8SSIGqfIvPmrnCK/TKHZQsHVh
         Ma1mAR6diLnLz/d/sf8c95n21KW7KH0V6mF6EaLbtn/yASqzAUMDr7Jp2VSBxEzg6O+O
         LZgOHHVSYDX6G4XpSrtOYuSYKYymIUpellCz8el53NFNvXSMaXvcOVoiYSzkE40WzTY6
         3f425opzMoELFibBXW1OUO91bGt2BioHgSQXtueWLwrd57iWQrzniawA/oVqH/0bRPxo
         VqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733488512; x=1734093312;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6PvnI7O8BCrsugwoXvIAfj4V3SCjwh4w+40SQgRUeo=;
        b=tB5EPEQ/eBzvY/0BbVGDnvQunzWV2EkULEk3DR1a5wqY5pJouttXm6bEh28wakykFO
         YXsEyzFv2YrdT5T2Hrw1zP145nsjasCi0qo7mBoidTcwdAnp/hVjzIa/INyQwOYqEw7O
         i48XZmNXaItROBxIWwYwdBG31Nkwt/RbrGJCHM3Fzm2GWiLhyiSMat6ZVTAPvcXh0zTC
         o6jmcUCNdTgWnh6ZmScy6KjwD4NlMePUYpUE+BHrCt6oBFuje9WlX7/m24ik6j90ez3w
         JvZercCvTqRCqr6HDpXWA4LSIPEQXsZczc0xlx4M7cndxzFfW9vy3gM3+Eb3zGtzCMxf
         2E1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0HDoISc4/yjgooWFH3xk9ULOJbj3Qhbp6D6HyOMNann0uKk8+lY6LAnAmzL5l14y+wpM=@vger.kernel.org, AJvYcCVDDH+Ilg8j5jlDMJZWxzehti2Lvkl9TbO4d1+IEwoOVczHioVbISdXpXaVFRqU5+daqM0vlUA6JH/jE/tm@vger.kernel.org
X-Gm-Message-State: AOJu0YyV84oNQbVRH8DIfMtarYz/Tw3jD1r9lB7//I8eV+O314hs+gE9
	XK0dvIy4KCK6iKwEqRlVW1qjNq3eU4A/8jlbJ20jBDHIbY62GGgf
X-Gm-Gg: ASbGnct9nwKjZ1lEinRyyU1bep7Q16TOIA1lZNcZngJp6kdvI+rb1feZBH3aMZ7fYOG
	wz0RaF6wlTB4r156aLxvaly/HBjW5pxbWLzvK8JrslMKfapSJ1IvD+s4OA3uh9v4U5dL1wIjxFA
	pYm+a3HUTy7Q2KCy1vKIG/3MfKgmnRbDlxmhEnNz/fXNKRmIxB89fskYKu2sLc/JoyZgQ4LCMCx
	gBZT636EvY7gE1dkWAyYka22KPCdSr6qlED1CzFQ6OJe7MSDEot89k2vm8mFQhKi8PI4DzVuAF3
	YOb7zSUj1gKonLtO2UwlSEM=
X-Google-Smtp-Source: AGHT+IHPxphMS4Qk/qebUjsQnqXB+pmqqV+jQbEkFsAiVmVVudNvGQtOHi6M0kzkTx8dBwklanyjTQ==
X-Received: by 2002:a17:906:2931:b0:aa6:313b:469e with SMTP id a640c23a62f3a-aa63a3776bdmr171084666b.52.1733488512309;
        Fri, 06 Dec 2024 04:35:12 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e0389sm232510066b.174.2024.12.06.04.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 04:35:11 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 6 Dec 2024 13:35:10 +0100
To: Laura Nao <laura.nao@collabora.com>
Cc: alan.maguire@oracle.com, bpf@vger.kernel.org,
	chrome-platform@lists.linux.dev, kernel@collabora.com,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on next
Message-ID: <Z1LvfndLE1t1v995@krava>
References: <20241113093703.9936-1-laura.nao@collabora.com>
 <20241115171712.427535-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115171712.427535-1-laura.nao@collabora.com>

On Fri, Nov 15, 2024 at 06:17:12PM +0100, Laura Nao wrote:
> On 11/13/24 10:37, Laura Nao wrote:
> > 
> > Currently, KernelCI only retains the bzImage, not the vmlinux binary. The
> > bzImage can be downloaded from the same link mentioned above by selecting
> > 'kernel' from the dropdown menu (modules can also be downloaded the same
> > way). I’ll try to replicate the build on my end and share the vmlinux
> > with DWARF data stripped for convenience.
> > 
> 
> I managed to reproduce the issue locally and I've uploaded the vmlinux[1]
> (stripped of DWARF data) and vmlinux.raw[2] files, as well as one of the 
> modules[3] and its btf data[4] extracted with:
> 
> bpftool -B vmlinux btf dump file cros_kbd_led_backlight.ko > cros_kbd_led_backlight.ko.raw
> 
> Looking again at the logs[5], I've noticed the following is reported:
> 
> [    0.415885] BPF: 	 type_id=115803 offset=177920 size=1152
> [    0.416029] BPF:  
> [    0.416083] BPF: Invalid offset
> [    0.416165] BPF: 
> 
> There are two different definitions of rcu_data in '.data..percpu', one
> is a struct and the other is an integer:
> 
> type_id=115801 offset=177920 size=1152 (VAR 'rcu_data')
> type_id=115803 offset=177920 size=1152 (VAR 'rcu_data')
> 
> [115801] VAR 'rcu_data' type_id=115572, linkage=static
> [115803] VAR 'rcu_data' type_id=1, linkage=static
> 
> [115572] STRUCT 'rcu_data' size=1152 vlen=69
> [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> 
> I assume that's not expected, correct?

yes, that seems wrong.. but I can't reproduce with your config
together with pahole 1.24 .. could you try with latest one?

jirka

> 
> I'll dig a bit deeper and report back if I can find anything else.
> 
> [1] https://people.collabora.com/~laura.nao/dbg-btf-mismatch-next-20241113/vmlinux
> [2] https://people.collabora.com/~laura.nao/dbg-btf-mismatch-next-20241113/vmlinux.raw
> [3] https://people.collabora.com/~laura.nao/dbg-btf-mismatch-next-20241113/cros_kbd_led_backlight.ko
> [4] https://people.collabora.com/~laura.nao/dbg-btf-mismatch-next-20241113/cros_kbd_led_backlight.ko.raw
> [5] https://pastebin.com/raw/FvvrPhAY
> 
> Best,
> 
> Laura
> 

