Return-Path: <bpf+bounces-15832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086497F883C
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 05:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002621C20C07
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 04:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306B62106;
	Sat, 25 Nov 2023 04:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBlK6B3y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02531B5
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 20:11:10 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2859fe4461aso490933a91.1
        for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 20:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700885470; x=1701490270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NqhlfgxGgx9fuK+3cxhiPykwd/Rof6Ckfp7i+cSoLWU=;
        b=fBlK6B3yI2su9C/li2BL1diWwRzT5cvV3f+b+9hozIfN1VUDz6IBgY8N3Chd13SFTL
         aog1E8tK5xe1mdie9bTr3UVj2WW17MaX8AoIcM66wCDyUM4dGW8YZgOhYzcNBdz5TmFD
         hC7m4E52TKVv3/ucmF6TtbWBTPYQU3gvFlnWuSB8d226g1qsIa8z46LDguwk3x8Gqpp3
         7H7GnJ7vDZStaUWO5f13eWv/8YIsResb9i/PjgKE3d8V1snJ602QBuoV8o86lzJSZmdo
         vl8BVxyfrKT1pfsYxu297sLPCzYZcBx7Yn1us9mAnsgcSlhxYKGybgE0OUArZhM9F709
         T8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700885470; x=1701490270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NqhlfgxGgx9fuK+3cxhiPykwd/Rof6Ckfp7i+cSoLWU=;
        b=awSEeMZSDxtB7nlAq69n1tdYp1fnTW9ZH8v6bB20RGLB6D2TigMxgBnWz1FmIAdztC
         rUq7SM8EGsiC+z8eGK1031n1quHBmfPC9iwEDtAwdb9o0xYaRhsmZNAkEhRiSoMkP1sx
         9aBH13+OcX6+BzjctMzDb0O7GbTXxUjkl+qgxrRRLgx19FAka78p37pSUg+aRtdUnJ55
         8agDNiSys/ceFytaEsoB+DrJdyjkmwVj7rLFJznBNO2NRsREVU7sDptM1EC8OpW1RjQP
         c81J5WdCfGTqEeh+wbtNxraOdjcTN/1bmY50viWnlqtFRoXbVEMBGw0ytHR9UgTlwZqd
         /ksg==
X-Gm-Message-State: AOJu0Yyde97KiQEZj3iTU+SV+hsRixy+P3ImY2jyv/lGGIFMGICDLVqO
	CLmRltIpW25z5veoNPfCkNNyy54wF8NODw==
X-Google-Smtp-Source: AGHT+IHq8s6mz+sPLlMJTe9WHXyGt5bseIislyJo3/ZGz2nJmtP8NLMy4Tm9WntMtv7FXyGZAjWnIdQIxSKIng==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:902:e88f:b0:1c9:c879:ee82 with SMTP
 id w15-20020a170902e88f00b001c9c879ee82mr1057524plg.11.1700885470150; Fri, 24
 Nov 2023 20:11:10 -0800 (PST)
Date: Sat, 25 Nov 2023 04:11:07 +0000
In-Reply-To: <20231123193937.11628-2-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231123193937.11628-1-ddrokosov@salutedevices.com> <20231123193937.11628-2-ddrokosov@salutedevices.com>
Message-ID: <20231125041107.wgpskqegywpt7l2o@google.com>
Subject: Re: [PATCH v3 1/2] mm: memcg: print out cgroup ino in the memcg tracepoints
From: Shakeel Butt <shakeelb@google.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	mhocko@suse.com, akpm@linux-foundation.org, kernel@sberdevices.ru, 
	rockosov@gmail.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 23, 2023 at 10:39:36PM +0300, Dmitry Rokosov wrote:
> Sometimes, it becomes necessary to determine the memcg tracepoint event
> that has occurred. This is particularly relevant in scenarios involving
> a large cgroup hierarchy, where users may wish to trace the process of
> reclamation within a specific cgroup(s) by applying a filter.
> 
> The function cgroup_ino() is a useful tool for this purpose.
> To integrate cgroup_ino() into the existing memcg tracepoints, this
> patch introduces a new tracepoint template for the begin() and end()
> events.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Acked-by: Shakeel Butt <shakeelb@google.com>

