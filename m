Return-Path: <bpf+bounces-46695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24529EE2CE
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 10:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5882A2811EB
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 09:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52782210F6E;
	Thu, 12 Dec 2024 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXs4Shio"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAD0210F5E;
	Thu, 12 Dec 2024 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995356; cv=none; b=Em3nDM+pTRd6lxq+Slv5N93SBCTpRu9jPrkyo6/Ylaaumr9JHkKAVwmrpPHyjpqTjpNHi+pWhRQrdSLgsvwSrh239J5rivcqcB/oCmYb8gorIbydElqlK1osscAcjwHoeMWkSTk7uwS8ZDMinQ6j+xdTgRPOoEmUJBr9wRI0YwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995356; c=relaxed/simple;
	bh=MH76A8RrBVeEauyXdzge4bB1tbBOOSK8hzAcOTLGZu4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DG8jGCoEcdatyAjkOOkBqZOGsWbI3XxH0itP6RDVxoXRdlfaUgIiV2S9Pyl6pRcxkVWfAgaI7qoxKkPvEHQNIMo6+/pby3kK1V/J2cpxz+TWGrXd67Ca1yPwjbEYSNrgBhDY+NSmNPc3SyO3qPloqu4zwdYssKEW7+Xhvmd0/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXs4Shio; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso3652785e9.2;
        Thu, 12 Dec 2024 01:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733995353; x=1734600153; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9/8qAprzepzOhI9hq4ABjT0H5BvreqQl8xCmHayUS8c=;
        b=eXs4Shio6ac1r7QEKWNtJP3FrfXt15FR7EuCHN5XatULVJ33jejdBd628nCkHai8wa
         JXHISyqGs/QxfRGhnbfzX2PZMz3wq39/Ce2WaMDeIoJeXyQlMHKnVs33U+1NSjmkvupD
         YbbKZbcmUPX23HRIFS4KLz7ZS7f2iJhpIbhXTorEKAbDnCKLmplxFxYfFc2j1Siakhza
         Iqu5TB38YJ1baeuMTF5SHWJJbJMyop/N+e/L9uXjyVzNnAk3a14PL8XPIW6VcSuE68M3
         rWOGpk3arRzs2j4rEzljNmjbK72+PC6hslhJH0F5NG8fwwJAp/lzDFHF7Gix4YqfhF9n
         gXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733995353; x=1734600153;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/8qAprzepzOhI9hq4ABjT0H5BvreqQl8xCmHayUS8c=;
        b=BzYUk5qicSOYbyuRZKbzllJIijI/Cv2V3wrfg9v65YgF6thmjXae537/nPS+lRmhu8
         8Ywlug1N1unNsrw/M270twQPRksZ3evhcwhNDIu1PF/JwoqJJoZ10DibJxwhjiST9s2S
         Vgpu1ydZLOnL+f6g7FZYKqgVq8tg7IbCgenAh2vkNSf/dPDwODeMXq2qNzUO3OeA0gD1
         oC7mdoIS0ORqEhNWv14QbCSjwZNUiJb2L20f4+RXxq7jaYGXH2EcbuMvMoxUXxNO4Bb7
         BkLklyD/Vyj/c4Gxp4qnoTsWAKxyM5CzoQiQXeEhGwGLAnE/rbsrxNGJRQKuHFyQ6wbv
         WTXw==
X-Forwarded-Encrypted: i=1; AJvYcCUdueEg13+PTcuxqllZoNoEX29xFrGn+ic2fmJ3Koo0kh4DbUpVFg5N9Nq8nl4jtPVVbGw2yE1TXK4YrTJr@vger.kernel.org, AJvYcCUyFjYgl8gWJgybJJimyep9a8jw9xtykd7Fp6q4Wjkt0ABb38ZRl2IHIZMJKilNbbP3Klc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjVECAZ4rQepQM7OxjftmveDphCq0KYB6CKtRYhPwnYBSLeNQW
	1t0g2vtBNkLma+72ZpwvGW6CgNn+FmkQb1Twd1xrI2WpRqZ94LYO
X-Gm-Gg: ASbGncuFxX7v+FRSGZh8DYzl/LmNFdGUylGc9hIbbDXPbyEsl9hQj16EAAtLHahnIlX
	aYGdFIRPYSwnmHeTOy20ddHBCxCaqzZjm8u5pHX7BF4gtoBvm0WlQ1Aw5DjPcqsBtIH5dsfm4p8
	Mw/CaphehA5s7VTxF3tdXiuSffebAYlf2PoRXQAw5oEajChqCS9Ny2MnqzGLq6/hxHWzjMtl+6k
	zEwpZd1FwWC+WcWtxb0RsK4B61D3NXP4FMiPOtvCHKhrZG1wMDkQIfaUiHRK9RqoiFOrtDtgCOc
	u3Zl+H8hA9byrK/k7hoyXNnc1AVwGg==
X-Google-Smtp-Source: AGHT+IF5BcgvSTVBRtoBdBseMDIWG1i+t5YhY/Nf3IWtocZuQeNr3CTNju1EKFip3g+LBHDjf7c81A==
X-Received: by 2002:a05:600c:4e4b:b0:434:a0bf:98ea with SMTP id 5b1f17b1804b1-4361c35cc4bmr46472845e9.9.1733995353163;
        Thu, 12 Dec 2024 01:22:33 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625717c9fsm10563025e9.44.2024.12.12.01.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 01:22:32 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Dec 2024 10:22:30 +0100
To: Jiri Olsa <olsajiri@gmail.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Laura Nao <laura.nao@collabora.com>, alan.maguire@oracle.com,
	bpf@vger.kernel.org, chrome-platform@lists.linux.dev,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on
Message-ID: <Z1qrVu2Pv6qXI9tD@krava>
References: <Z1LvfndLE1t1v995@krava>
 <20241210135501.251505-1-laura.nao@collabora.com>
 <Z1n_wGj0CGjh_gLP@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1n_wGj0CGjh_gLP@krava>

On Wed, Dec 11, 2024 at 10:10:24PM +0100, Jiri Olsa wrote:
> On Tue, Dec 10, 2024 at 02:55:01PM +0100, Laura Nao wrote:
> > Hi Jiri,
> > 
> > Thanks for the feedback!
> > 
> > On 12/6/24 13:35, Jiri Olsa wrote:
> > > On Fri, Nov 15, 2024 at 06:17:12PM +0100, Laura Nao wrote:
> > >> On 11/13/24 10:37, Laura Nao wrote:
> > >>>
> > >>> Currently, KernelCI only retains the bzImage, not the vmlinux
> > >>> binary. The
> > >>> bzImage can be downloaded from the same link mentioned above by
> > >>> selecting
> > >>> 'kernel' from the dropdown menu (modules can also be downloaded the
> > >>> same
> > >>> way). I’ll try to replicate the build on my end and share the
> > >>> vmlinux
> > >>> with DWARF data stripped for convenience.
> > >>>
> > >>
> > >> I managed to reproduce the issue locally and I've uploaded the
> > >> vmlinux[1]
> > >> (stripped of DWARF data) and vmlinux.raw[2] files, as well as one of
> > >> the
> > >> modules[3] and its btf data[4] extracted with:
> > >>
> > >> bpftool -B vmlinux btf dump file cros_kbd_led_backlight.ko >
> > >> cros_kbd_led_backlight.ko.raw
> > >>
> > >> Looking again at the logs[5], I've noticed the following is reported:
> > >>
> > >> [    0.415885] BPF: 	 type_id=115803 offset=177920 size=1152
> > >> [    0.416029] BPF:
> > >> [    0.416083] BPF: Invalid offset
> > >> [    0.416165] BPF:
> > >>
> > >> There are two different definitions of rcu_data in '.data..percpu',
> > >> one
> > >> is a struct and the other is an integer:
> > >>
> > >> type_id=115801 offset=177920 size=1152 (VAR 'rcu_data')
> > >> type_id=115803 offset=177920 size=1152 (VAR 'rcu_data')
> > >>
> > >> [115801] VAR 'rcu_data' type_id=115572, linkage=static
> > >> [115803] VAR 'rcu_data' type_id=1, linkage=static
> > >>
> > >> [115572] STRUCT 'rcu_data' size=1152 vlen=69
> > >> [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64
> > >> encoding=(none)
> > >>
> > >> I assume that's not expected, correct?
> > > 
> > > yes, that seems wrong.. but I can't reproduce with your config
> > > together with pahole 1.24 .. could you try with latest one?
> > 
> > I just tested next-20241210 with the latest pahole version (1.28 from
> > the master branch[1]), and the issue does not occur with this version
> > (I can see only one instance of rcu_data in the BTF data, as expected).
> > 
> > I can confirm that the same kernel revision still exhibits the issue
> > with pahole 1.24.
> > 
> > If helpful, I can also test versions between 1.24 and 1.28 to identify
> > which ones work.
> 
> I managed to reproduce finally with gcc-12, but had to use pahole 1.25,
> 1.24 failed with unknown attribute
> 
> 	[95096] VAR 'rcu_data' type_id=94868, linkage=static
> 	[95098] VAR 'rcu_data' type_id=4, linkage=static
> 	type_id=95096 offset=177088 size=1152 (VAR 'rcu_data')
> 	type_id=95098 offset=177088 size=1152 (VAR 'rcu_data')

so for me the difference seems to be using gcc-12 and this commit in linux tree:
  dabddd687c9e percpu: cast percpu pointer in PERCPU_PTR() via unsigned long

which adds extra __pcpu_ptr variable into dwarf, and it has the same
address as the per cpu variable and that confuses pahole

it ends up with adding per cpu variable twice.. one with real type
(type_id=94868) and the other with unsigned long type (type_id=4)

however this got fixed in pahole 1.28 commit:
  47dcb534e253 btf_encoder: Stop indexing symbols for VARs

which filters out __pcpu_ptr variable completely, adding Stephen to the loop

with gcc-14 the __pcpu_ptr variable has VSCOPE_OPTIMIZED scope, so it won't
get into btf even without above pahole fix

I suggest gcc/pahole upgrade ;-)

thanks,
jirka

