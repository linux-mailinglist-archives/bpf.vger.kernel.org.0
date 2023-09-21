Return-Path: <bpf+bounces-10582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CA97A9BE7
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D61B28245D
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C780182C5;
	Thu, 21 Sep 2023 18:49:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E31E9CA4C;
	Thu, 21 Sep 2023 18:49:49 +0000 (UTC)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B15EE5BE;
	Thu, 21 Sep 2023 11:49:48 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-79565370aa3so51091039f.0;
        Thu, 21 Sep 2023 11:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322187; x=1695926987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9aPA22jkwf0s+X4hBxdI+HlXauXpRGb+zHkR7JR09A=;
        b=bEHtBw2PIi4UhXLjr9ZonsUHhI+nCF2M8Wo4XP5UKYZQHURL4olx8iaBckLNOlyaIP
         xeuztsW/0oiuI2ilBQ/keowS9sXinzKPnHn4MLEtAjh3cqQuCCQrMX8Ll/18JerBrqN8
         LXWcEh/nNRN4GfKCOjqFTwWgc42OFfLo2/xV6+3YptNPEmy/rh5ZQcBAD6butejSlQM/
         iV9EVYILu3w4/VPN87k7IlDM3WLzlvFi2Ub7qXD6ZvvMoC4E2FJ1zX6dg4dwZ8S1nAv8
         jU2r4tuqmGzmnWrqQ0Y0UO6vAC/ADGkjA7r/apTnHsxqutmDZEWLXjCe4o7Npj2eNVYB
         hgWQ==
X-Gm-Message-State: AOJu0YwV9kliy1jQmSJHni8u8m+MMdEvGzjwi9FTLt3VU9JlfqZ4hVba
	jFJPmT2BAnHHhZbURvZiAnBEkSmv0pj8jvAeCn0=
X-Google-Smtp-Source: AGHT+IEtTCDejNODZhsZ2X7z/2452seSw/T6NaqPLdu41+a1a5s1QReNgnuBARF9Zw1Jwdg8lTAJtKR+bUqMpEFLOBo=
X-Received: by 2002:a05:6602:1592:b0:798:2665:8939 with SMTP id
 e18-20020a056602159200b0079826658939mr8176511iow.20.1695322187550; Thu, 21
 Sep 2023 11:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915063832.120274-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230915063832.120274-1-yang.lee@linux.alibaba.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 21 Sep 2023 11:49:36 -0700
Message-ID: <CAM9d7cgFCHHucHKdtsfn5qDwd80etXPtkKv+0-jE_do6uXo+gg@mail.gmail.com>
Subject: Re: [PATCH -next] perf kwork top: Simplify bool conversion
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 11:38=E2=80=AFPM Yang Li <yang.lee@linux.alibaba.co=
m> wrote:
>
> ./tools/perf/util/bpf_kwork_top.c:120:53-58: WARNING: conversion to bool =
not needed here
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied to perf-tools-next, thanks!

