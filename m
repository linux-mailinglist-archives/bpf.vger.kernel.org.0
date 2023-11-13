Return-Path: <bpf+bounces-15003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754D57E9E58
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 15:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E2A280D63
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 14:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA26210F3;
	Mon, 13 Nov 2023 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FG2IoRzE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B0D1CF82
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 14:15:15 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B4DD4C
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 06:15:14 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c16f262317so1751497a12.1
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 06:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699884914; x=1700489714; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Mk8WDCUgjWBxKl9jlq4aL9xPelNIJ1UBxyFJ0gNzaY=;
        b=FG2IoRzEewI4k2LWm15gI1o7CkkGFPwpe4Wa0/E+67GS+xmRtJ00rLi2R53n+M8DKx
         KMOI697F19hsMfr5LST+xV6txxs42puFMmEZUX5/3DR7ylIPPlzq1nVRKVOyE9Lo+qWB
         UXAQz97yOcbK+pzU4eYEDKF5GcjPZlXEPCHPB7vK8O9YhRhP1D7F9Tr4QqvR/pRJyacW
         KFV4Y5GcxLIgANFq+qV1eNNwDVk80vuIFWDMR64wqbO2HNOpNfI8DAqPBqbFkuXOsniL
         YV2SMuvAO6xsjyEh8rIucwI6dJ7DIVt/h7a4bP+2V0ITmhvPSCoYzZt+u65kv6I2v9OU
         VP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699884914; x=1700489714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Mk8WDCUgjWBxKl9jlq4aL9xPelNIJ1UBxyFJ0gNzaY=;
        b=tyzT5HOZGBN0BMgrZic5dwlmNNXcZwnNaBxHUThTaEeXVpXLgwbbY7Uqzloa9+Ikf7
         EJlhH2g09pzJ4mDfRESnJRN1ppTQh0YyLnxkUqNUfYcohpBcZ6mEjr5u7wkb3d8MyN8T
         RxyyqX/8PGt6KfqvI17IMi6iGy7ZIGqmKlCWDmIH08K2HiJLkN2XayJLazcFbaBia2CG
         DMeVBXZkFDw5pKeP7jmhpMAI5W9WxhG6DwH8snePvpk3VyC0KIqCq9Tds9rSrn/r9uSe
         YnHqelZfRtC1wg4Vq8GDU/p1X2gzztlYBYhOdupdJkxZcMvYSO7Gp54PsOLqezyUb+JM
         tW8Q==
X-Gm-Message-State: AOJu0YxMum3IwdKn8YhVDI2rCsx0crOjT53u1w5IJm0ztov0yJLVRuMc
	AVda0VZOuRS2cHaWjBvNeDWs+6g=
X-Google-Smtp-Source: AGHT+IG66n8uTzzgWG+eBzgEiAwfulvDnCo3bWDOeIZTHC184x4dKHsFANPV/MPQIGH5HlsQ2dl7WGA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a02:912:b0:5bd:839e:caf1 with SMTP id
 ck18-20020a056a02091200b005bd839ecaf1mr3096512pgb.3.1699884913884; Mon, 13
 Nov 2023 06:15:13 -0800 (PST)
Date: Mon, 13 Nov 2023 06:15:12 -0800
In-Reply-To: <20231113031812.3639430-1-xwlpt@126.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231113031812.3639430-1-xwlpt@126.com>
Message-ID: <ZVIvcM3BDOvKGpwa@google.com>
Subject: Re: [PATCH] bpf: Get the program type by resolve_prog_type() directly
From: Stanislav Fomichev <sdf@google.com>
To: Wenli Xie <xwlpt@126.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	song@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wenli Xie <wlxie7296@gmail.com>
Content-Type: text/plain; charset="utf-8"

On 11/13, Wenli Xie wrote:
> From: Wenli Xie <wlxie7296@gmail.com>
> 
> The bpf program type can be get by resolve_prog_type() directly.

Can we have more details in the change log about why using
resolve_prog_type is better?

Please also take a look at Documentation/bpf/bpf_devel_QA.rst on
how to target the right tree ([PATCH bpf-next]).

