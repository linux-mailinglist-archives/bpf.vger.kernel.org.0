Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE8B127554
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 06:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbfLTFdS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 00:33:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40826 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfLTFdS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 00:33:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so4355561pgt.7
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 21:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yaj8ntc1yVRCkjuif8//+ZZrRhTMRaJwkeaiyiE/Gy4=;
        b=JhHMidNTesdU1Whtya6u4fTJHjc4nKvJcLBA6oBGcUT5L+W7t2Y1DnXxi8zPbwgfKO
         YpIx5nuQ9+mHvp7AuOV77gDkYkIyac0U7VXwxEyjpfploDO6l5uRFPaP6VLyIgRbmaUb
         VslbaaqMJlWnly6W6wwTDLEzeUY/AiofezAv3HXnnr33L/5ALmgpFJRAYxJTDYXkcPEj
         nE2QnpbQawQaig87cXDgGAsyK2OeErbAZaemTUh4MxuaWYuDNPCiJK+FLJpT3WrZMo9g
         CFDenRNoioOgn4LAHxWam/ZdpOoKb4kckcjFPcF34S48/cSdeJu768rvtbMnmD1jiRQL
         6RRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yaj8ntc1yVRCkjuif8//+ZZrRhTMRaJwkeaiyiE/Gy4=;
        b=KxELA5dod0Tw33AxZMMiKIwWq6hEnxja7utMEspZRvM8go3EtITPbH0LefWSHoGWHm
         DZShlzSq40zfREo/yi63x02wLeVEctvv902PlVXRK2xz4bRGrKiO9dbe5Yeek883sBH9
         BVSKWCFyNYdbwDB6W585VYPFbE7rCjmrXcb7iInWS+DM81WASe19lJ7jZ7HLPd9wkY4X
         CSMkzIFpzZM8IyV2TE2OmuXZUtMw6/bSs+88eeSWlVhhwlfjJ9vgk6gZ+lKBRKGpb3ly
         pZeGkK0SNP7wjpf6h5J+PHUiPRPRJZwOpAAd7ae39lvOpqbKaDIjG/B2/VJINkhV3Jxn
         eNuA==
X-Gm-Message-State: APjAAAXs9XgwkqynwlCEkxi1bbidIl7iGkc3xNgnxv1Vepvpk5GoSskY
        ER7fYFmRXiBioPwjQz0wzEE=
X-Google-Smtp-Source: APXvYqwOfRKyucLMHfyzNZzSP8iz7yRhy7zL234Y8cVwcrchwe+VPm/jgch0Iy6YasqCnPJcr0O0ww==
X-Received: by 2002:a62:1552:: with SMTP id 79mr13910097pfv.156.1576819997020;
        Thu, 19 Dec 2019 21:33:17 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::4250])
        by smtp.gmail.com with ESMTPSA id a12sm9359925pga.11.2019.12.19.21.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 21:33:16 -0800 (PST)
Date:   Thu, 19 Dec 2019 21:33:13 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, andriin@fb.com, kernel-team@fb.com
Subject: Re: [PATCH v4 bpf-next 0/6] bpf: Support replacing cgroup-bpf
 program in MULTI mode
Message-ID: <20191220053311.menmpnootqshkzrw@ast-mbp.dhcp.thefacebook.com>
References: <cover.1576741281.git.rdna@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1576741281.git.rdna@fb.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 18, 2019 at 11:44:32PM -0800, Andrey Ignatov wrote:
> v3->v4:
> - use OPTS_VALID and OPTS_GET to handle bpf_prog_attach_opts.
> 
> v2->v3:
> - rely on DECLARE_LIBBPF_OPTS from libbpf_common.h;
> - separate "required" and "optional" arguments in bpf_prog_attach_xattr;
> - convert test_cgroup_attach to prog_tests;
> - move the new selftest to prog_tests/cgroup_attach_multi.
> 
> v1->v2:
> - move DECLARE_LIBBPF_OPTS from libbpf.h to bpf.h (patch 4);
> - switch new libbpf API to OPTS framework;
> - switch selftest to libbpf OPTS framework.
> 
> This patch set adds support for replacing cgroup-bpf programs attached with
> BPF_F_ALLOW_MULTI flag so that any program in a list can be updated to a new
> version without service interruption and order of programs can be preserved.
> 
> Please see patch 3 for details on the use-case and API changes.
> 
> Other patches:
> Patch 1 is preliminary refactoring of __cgroup_bpf_attach to simplify it.
> Patch 2 is minor cleanup of hierarchy_allows_attach.
> Patch 4 extends libbpf API to support new set of attach attributes.
> Patch 5 converts test_cgroup_attach to prog_tests.
> Patch 6 adds selftest coverage for the new API.

Applied, Thanks
