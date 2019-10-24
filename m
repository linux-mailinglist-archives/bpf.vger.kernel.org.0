Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D55D1E3A73
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2019 19:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440044AbfJXRzl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Oct 2019 13:55:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42583 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436672AbfJXRzl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Oct 2019 13:55:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id 21so4344783pfj.9
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2019 10:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=FidDOLCxWh+reFUNqqD+6YZ8xoaPV+WzuM6jWJj2+oQ=;
        b=l5SZyZYt7DFDq+eDkZY2sUG43BXOT8qN9Fyygi12xtrgVDnTJJDgYAHazOTnBWXGop
         EQ7hrh51bahUQH6l7xRcAK38Orhx/qOglPC8P/wUyKzAusIahWNeZgSZOuyZa3forVAh
         M/DtY/jKHK54sRu3kp/xyfP+u+MHi0+gZZZAAFyQregBnfyhkkkmhUTDOH1ZhAooXQul
         PNQgEDrO586P502iTGKRfVNZmM0c8sREtrPYTqW2Vxu2gOCVuBVaIK5iH33op+bf1uIh
         fv6mVdNq59epoCLzUTN4nzo5H2UEAsjAhCk6jPEykHFb1nMZnqGDg5bzHSlObSP4cQv9
         bSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=FidDOLCxWh+reFUNqqD+6YZ8xoaPV+WzuM6jWJj2+oQ=;
        b=FsF2s5l2/SDWxXCi7CEWSOgOP2714riTphAdvHFB0I6jkgLC2XcwzRZoduB8unY8nM
         1VUCbM3opeAvZGFmh+F7bFTcMsCs7qy2TZnCemAgUYcRZg6BVB1xdvdPJDD4P64exZUa
         hvjk+31uFnmgdAg2xVkCnbZN80fCgslbMWzsuLObXODVcc5Fwn9oFfV3qEQCoe8dCA1A
         B17nqI3s8iOB+TsSGginYw88Y6aFqNhQTuMGyKFV4ZMIxD7NM/24BMy4UrOlMsc5Dt5Q
         Y/d3/nrF1YJMPQxDG+0r6jIzu55/qsKdc1eINWlu9nMK/j6WsOCnYb+SIZTnP+Ou/TH8
         Ctcw==
X-Gm-Message-State: APjAAAW6QSCiZTRZOMTCPZAFvbXyGp9kYYPvyPlgoXUlW7dzFzKFpwS9
        0ZK6pTU9qkmyXw1RPrnSkVg8dg==
X-Google-Smtp-Source: APXvYqx7tStZkpyPtmnq86Sk46kPNkjnjRN6vGKRlgzuY5I/jeLaSxTA5xcb2FmTcdOiV9uz3nLKqw==
X-Received: by 2002:a62:1889:: with SMTP id 131mr18927589pfy.235.1571939740772;
        Thu, 24 Oct 2019 10:55:40 -0700 (PDT)
Received: from cakuba.hsd1.ca.comcast.net (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id i123sm16895339pfe.145.2019.10.24.10.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 10:55:40 -0700 (PDT)
Date:   Thu, 24 Oct 2019 10:55:37 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH] bpftool: Allow to read btf as raw data
Message-ID: <20191024105537.0c824bcb@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20191024133025.10691-1-jolsa@kernel.org>
References: <20191024133025.10691-1-jolsa@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 24 Oct 2019 15:30:25 +0200, Jiri Olsa wrote:
> The bpftool interface stays the same, but now it's possible
> to run it over BTF raw data, like:
> 
>   $ bpftool btf dump file /sys/kernel/btf/vmlinux
>   [1] INT '(anon)' size=4 bits_offset=0 nr_bits=32 encoding=(none)
>   [2] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
>   [3] CONST '(anon)' type_id=2
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> v3 changes:
>  - fix title
> 
> v2 changes:
>  - added is_btf_raw to find out which btf__parse_* function to call
>  - changed labels and error propagation in btf__parse_raw
>  - drop the err initialization, which is not needed under this change


Aw, this is v3? Looks like I replied to the older now, such confusion :)
