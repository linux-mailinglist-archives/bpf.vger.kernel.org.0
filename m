Return-Path: <bpf+bounces-35296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEBB939767
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6656F1C2198C
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BC0610B;
	Tue, 23 Jul 2024 00:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPNIs8RK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DE57F;
	Tue, 23 Jul 2024 00:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721693951; cv=none; b=Y2GrUOtw/9oeEn0UFTYjtoi4rbZwYKAOEgrlHz7ozrNJOF5z2S/Y0Kk2Q9AsscZ/gwX7sO7QvdOIOKNNZxF7976wZI6GIdYBRr2l+47zLEW3R/NevLsG33gCPw0FlKH6YRoKqt9Tn+fqIgAVmqI2JqgzmwZbhjTA43V09KMxIUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721693951; c=relaxed/simple;
	bh=r5Zw/4RBCXxEaE0lb/bEIqf+UN8bUgHGMFrMlZFpFN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huUBZSFJJObTKgFqeAbrN7UmhTVAMkz7uAfVdM+7RcUuY18RicX3ZIuXTmgwVTvGmsmOndBbqEb4Yco/b6QCXJVhQQxWPfNXDjCClr/5ghQOJRNRbBk2ZS2qgIwnZfgb3eMscSEIVQgxo8P91f78WQv1XygITzqcmGKnLef5+ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPNIs8RK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7a2123e9ad5so181543a12.1;
        Mon, 22 Jul 2024 17:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721693949; x=1722298749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPossxXLu3oe9kv1IyeANXfHgkaVbrFC2XARISEsHuA=;
        b=MPNIs8RKlIBU5SyUer6DELLBddKw+KIN9pYKboh6f7Ev0F5O+hP/yUfNT987qczW8r
         jYSPU+EdQbM7DLwXFwJy9XkEh8bBqbIz7OCEEKijvGfgVSlX7xsD0Err5vhb+7S3iJpL
         VrB2kbdculDaTAUiQVHgkIva3xIUYPo+Fx+1A+rSRvT6qcu1GqEOh/Jcr6Aav8fmaU6R
         4zgubQIPZ5YU81uWYtlxnOFAPFMbgt6Xpo1oyIZ/TkSSg4BKjMQDwiRo9CWKkOu1OXVj
         1AweGTmDBNbpGLHRuA+Z1n+GvSUTMpPjBeYFmZfKzSMFuhyYnEyiYNVqtcuGEptDRgQG
         3Jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721693949; x=1722298749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPossxXLu3oe9kv1IyeANXfHgkaVbrFC2XARISEsHuA=;
        b=pKqMc66tuV0KLBasz4cFXdHRYmQHMeao4qVSt+VVP/VXe4/KQrGP+a4bLIGdAZcW6N
         TW+puji1Qa86o0nK+zUKevgUvH7WI+O/gepkHTeS/C25UHIvnsvb/W+gGDTXttOQPgG2
         5iBwijdJesPcHb9Rd3SE7roVBapOftUeA9dPVW9A4k/jk7kyC8DzTtqrJkFNsdkzn4qU
         ZrJ3AWpg9caPdR+1MUFekdC78mHLCiDbPwL/qQASX3kJZ8ETL4PzijdbLhhZJwtjnXcx
         45c+Rha9wMgrW51yJpqdO4y2lXdxyE3VVPZuB7lbY9awc0L7HzA4nzoZWksmJE5Q2Aki
         drpw==
X-Forwarded-Encrypted: i=1; AJvYcCXxU0SnEKAZ6Rbec87gBJ8h7Y/GGVBLpg28CMNj/o0aauDgqNOkFGWIXj4lZeQQDZbisZnBiN0zxqvyOu9y/yWOrMIV
X-Gm-Message-State: AOJu0YxD+/v/CTFMW2o6Y6D40Bkb3AK2aKq1ugRiIzKfQwdXprX2s+/F
	8OpHM1NTuvAL7jf32FcupowTFwIJn7TphYVWAAEK14nQt13uDzVA
X-Google-Smtp-Source: AGHT+IG0M1KkoDjhb8gc3oK0tqB8nG7Z+HtSEsAQzgOLKSRTH82zzYNOmVbReFo779OSbvvRkAo7aA==
X-Received: by 2002:a17:90b:612:b0:2cb:4c30:51bd with SMTP id 98e67ed59e1d1-2cd8d13508dmr739469a91.19.1721693948867;
        Mon, 22 Jul 2024 17:19:08 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2620:10d:c090:400::5:9d00])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7b30f35sm7667220a91.11.2024.07.22.17.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 17:19:08 -0700 (PDT)
Date: Mon, 22 Jul 2024 17:19:05 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, sinquersw@gmail.com, 
	toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com, 
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Subject: Re: [RFC PATCH v9 00/11] bpf qdisc
Message-ID: <qifh3jfcfn3dviisbalnhetbhe4ms5w6ydjf7ahjvbw4lnasf6@ezeeidt5o7gx>
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714175130.4051012-1-amery.hung@bytedance.com>

On Sun, Jul 14, 2024 at 05:51:19PM +0000, Amery Hung wrote:
> * Miscellaneous notes *
> 
> The bpf qdiscs in selftest requires support of exchanging kptr into
> allocated objects (local kptr), which Dave Marchevsky developed and
> kindly sent me as off-list patchset.

Since there is a dependency pls focus on landing those first.

