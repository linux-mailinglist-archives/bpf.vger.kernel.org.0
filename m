Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 154E4C2AFB
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2019 01:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbfI3XgP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Sep 2019 19:36:15 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34614 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfI3XgO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Sep 2019 19:36:14 -0400
Received: by mail-qk1-f194.google.com with SMTP id q203so9498755qke.1
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2019 16:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=sX8lP/NxKY5NY6OP8Hy/bpDIGodskPAFHGazmkozDMc=;
        b=AmQ+AiEEh204AU33XWczaSvDTBysZ89p78+tc2D+ddHjjrGgPAzq2dwOGX4abk8kaJ
         kYnfQbKQihfw9pc+IPHJujf/Vdh9+DGnSJf7O1SWDXgUe04D4iGe+UdJi6UqVLqgCH2f
         WXb7EFrRtiVTIfM3mQAmgDiLj7Qe5GG6Mq8hg6tp+PCknW2mLkn+pObCs7lZxHzBj/+3
         Ouwp4GTAbolANGXkB08KtpUkyZnb3q/bqf//5reFMrFnpY1aJe9BsVgusnZN44bxWn+Z
         mdkR05ZwphCtQX7p3CKvJtUvYC16ALmT8WOkyr11H/w1tKY8CeU6QO05CEE/kFsK2tHi
         1VSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=sX8lP/NxKY5NY6OP8Hy/bpDIGodskPAFHGazmkozDMc=;
        b=C8FhoSxsly0jNMwfbJnWIs/CjxjEiwejTAGpRdZj2nqhYQAylE+qyNZ9vuvIi34lZg
         8O5TxPYWAUKqvjebePjvn7C3lIZ/sXltBW4bPgSFFWcqAUUxh3t+bLWqTVmi8sLb8BCS
         gLko0Z7fJVcL6E35MKYJEo6AZndsAvJJlxIB8evgJC1n8kRXXepj6LANs0A17W8EBN80
         AAhPvNvZ3bephkhVpp88Znk7dvnpBH5qVXnqbD2AZBFaz+gMNe5h3Mty5F+P5prHxX9T
         GljwhR//Igz0/tw/iqmF2wzV4KfHs2U43sirZkSccl9dTlhSYey/LejnU3219T9J1E+F
         MIPw==
X-Gm-Message-State: APjAAAUqdYHZcdfI8aihft7emrdOsd1eoQ/7uA0nlPuHxo+1UaYJhcfw
        seeareHcLxMVnOdPeYAP+KtcLdb6B0w=
X-Google-Smtp-Source: APXvYqzUbm9zOjImXcz+Z4ky8ISE4hSsZz7ojHltyxLuYM8iiH8VJlG6OTG/V/7NEgRa4ptVdOZkBQ==
X-Received: by 2002:a37:7ac1:: with SMTP id v184mr3029047qkc.129.1569886573901;
        Mon, 30 Sep 2019 16:36:13 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id z200sm7163130qkb.5.2019.09.30.16.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:36:13 -0700 (PDT)
Date:   Mon, 30 Sep 2019 16:36:09 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Song Liu <liu.song.a23@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "Alexei Starovoitov" <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 2/6] libbpf: move bpf_helpers.h, bpf_endian.h
 into libbpf
Message-ID: <20190930163609.52187526@cakuba.netronome.com>
In-Reply-To: <DC8634C7-C69D-48DA-A958-B6E7AC4F1374@fb.com>
References: <20190930185855.4115372-1-andriin@fb.com>
        <20190930185855.4115372-3-andriin@fb.com>
        <CAPhsuW6RHaPceOWdqmL1w_rwz8dqq4CrfY43Gg7qVK0w1rA29w@mail.gmail.com>
        <CAEf4BzaPdA+egnSKveZ_dE=hTU5ZAsOFSRpkBjmEpPsZLM=Y=Q@mail.gmail.com>
        <20190930161814.381c9bb0@cakuba.netronome.com>
        <DC8634C7-C69D-48DA-A958-B6E7AC4F1374@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 30 Sep 2019 23:25:33 +0000, Song Liu wrote:
> > On Sep 30, 2019, at 4:18 PM, Jakub Kicinski <jakub.kicinski@netronome.com> wrote:
> > 
> > On Mon, 30 Sep 2019 15:58:35 -0700, Andrii Nakryiko wrote:  
> >> On Mon, Sep 30, 2019 at 3:55 PM Song Liu <liu.song.a23@gmail.com> wrote:  
> >>> 
> >>> On Mon, Sep 30, 2019 at 1:43 PM Andrii Nakryiko <andriin@fb.com> wrote:    
> >>>> 
> >>>> Make bpf_helpers.h and bpf_endian.h official part of libbpf. Ensure they
> >>>> are installed along the other libbpf headers.
> >>>> 
> >>>> Signed-off-by: Andrii Nakryiko <andriin@fb.com>    
> >>> 
> >>> Can we merge/rearrange 2/6 and 3/6, so they is a git-rename instead of
> >>> many +++ and ---?    
> >> 
> >> I arranged them that way because of Github sync. We don't sync
> >> selftests/bpf changes to Github, and it causes more churn if commits
> >> have a mix of libbpf and selftests changes.
> >> 
> >> I didn't modify bpf_helpers.h/bpf_endian.h between those patches, so
> >> don't worry about reviewing contents ;)  
> > 
> > I thought we were over this :/ Please merge the patches.  
> 
> Andrii changed syntax for BPF_CORE_READ(). I guess that is new?

I meant the battle to not split changes into harder to review, and less
logical form based on what some random, never review upstream script
can or cannot do :)

I was responding to the "don't worry about reviewing contents" - as you
pointed out git would just generate a move..
