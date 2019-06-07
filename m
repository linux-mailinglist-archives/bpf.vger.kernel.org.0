Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 575B93825A
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2019 03:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfFGBC7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 21:02:59 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42120 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfFGBC7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 21:02:59 -0400
Received: by mail-qk1-f195.google.com with SMTP id b18so272173qkc.9
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2019 18:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=NrAnYTxkjRMR+gM3/dcFTpPS7hSLSL0S+FrhuGixOfI=;
        b=t5s3VwxdA6EcyHjRXFNTQYSxmzSokwEkbbEUfq5E88W7yGNfyiDwqlpVtoZRw/aZEm
         8qW9WEZ8DGzeQMcMR5sxYz/qGGvT6lt15alJrXnymKSCOOBnrAeLwUsk3txMfbu32Dmz
         wxNxBzQ2MpbrIIfsUreDgicNKIHMVZiFAtuPoBNASQJrYOxbxXLrkzvEpzVYCd4ArxQT
         hBkRVCE61TEGMf+zlpaljedQfaVkt752+rGZw6Uj2kFHP2QMDldIrJYfnB7rRrKT5/rc
         WBShWrQy2n4vnJOGEZQMXUelpvgQ6m9LldmtVyExwJA699KaVEf1vu+f1jU6nC+9CdgU
         TnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=NrAnYTxkjRMR+gM3/dcFTpPS7hSLSL0S+FrhuGixOfI=;
        b=AW7Mm1taKuM7JqC3xVQVTen2Bi5EIygGKDvb0Ecwi1Cd0jOhbRwB5YzU4+mnRTVCfj
         rBoLZ2RGBxV5GHuzqjfQpOktEjYF1EqyRnqu6vnx7LgSidyakFm4/kWn1e/G6Ybz6o3A
         XDalAMDg7CkFwn5qV8Px5ozgiRimXE0B/eVZ+zoTaCEGk0n1897CUqBxzLlzI9nJYodA
         a6yJBdJNdo4lKAwo+5xfV8RsqBmW5cMkq17hnWjjri0b0y9Uazlt/RbaGLUhoAZ4xb+j
         IKswD/UWBzrCMcyaA3l/gn3CT2d0+y5yUZiiYaLjNlBZraE4z/TAqbn32qQYUM8oSZmf
         Qk0A==
X-Gm-Message-State: APjAAAX+n87rgpRv3r2VNqgJxKmy4h64vju6ppfG5Rbx+k9JPBdKiI8A
        JR3uh6Pt8esEyUDW9FrjYEb24Q==
X-Google-Smtp-Source: APXvYqyaOH/EspPQktJD4GAi+HsZybCNuYRBTGpsDImN/UnOjJUIUXgZb5ds4hbjlkoIlziSem+m1w==
X-Received: by 2002:a37:bd46:: with SMTP id n67mr33689727qkf.266.1559869378560;
        Thu, 06 Jun 2019 18:02:58 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id s35sm361416qts.10.2019.06.06.18.02.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 18:02:58 -0700 (PDT)
Date:   Thu, 6 Jun 2019 18:02:53 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [RFC PATCH bpf-next 6/8] libbpf: allow specifying map
 definitions using BTF
Message-ID: <20190606180253.36f6d2ae@cakuba.netronome.com>
In-Reply-To: <4553f579-c7bb-2d4c-a1ef-3e4fbed64427@fb.com>
References: <20190531202132.379386-1-andriin@fb.com>
        <20190531202132.379386-7-andriin@fb.com>
        <20190531212835.GA31612@mini-arch>
        <CAEf4Bza38VEh9NWTLEReAR_J0eqjsvH1a2T-0AeWqDZpE8YPfA@mail.gmail.com>
        <20190603163222.GA14556@mini-arch>
        <CAEf4BzbRXAZMXY3kG9HuRC93j5XhyA3EbWxkLrrZsG7K4abdBg@mail.gmail.com>
        <20190604010254.GB14556@mini-arch>
        <f2b5120c-fae7-bf72-238a-b76257b0c0e4@fb.com>
        <20190604042902.GA2014@mini-arch>
        <20190604134538.GB2014@mini-arch>
        <CAEf4BzZEqmnwL0MvEkM7iH3qKJ+TF7=yCKJRAAb34m4+B-1Zcg@mail.gmail.com>
        <3ff873a8-a1a6-133b-fa20-ad8bc1d347ed@iogearbox.net>
        <CAEf4BzYr_3heu2gb8U-rmbgMPu54ojcdjMZu7M_VaqOyCNGR5g@mail.gmail.com>
        <9d0bff7f-3b9f-9d2c-36df-64569061edd6@fb.com>
        <20190606171007.1e1eb808@cakuba.netronome.com>
        <4553f579-c7bb-2d4c-a1ef-3e4fbed64427@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 7 Jun 2019 00:27:52 +0000, Alexei Starovoitov wrote:
> the solution we're discussing should solve BPF_ANNOTATE_KV_PAIR too.
> That hack must go.

I see.

> If I understood your objections to Andrii's format is that
> you don't like pointer part of key/value while Andrii explained
> why we picked the pointer, right?
> 
> So how about:
> 
> struct {
>    int type;
>    int max_entries;
>    struct {
>      __u32 key;
>      struct my_value value;
>    } types[];
> } ...

My objection is that k/v fields are never initialized, so they're 
"metafields", mixed with real fields which hold parameters - like 
type, max_entries etc.

But I thought about this 3 times now, and I see no better solution.
FWIW my best shot was relos:

extern struct my_key my_key;
extern int type_int;

struct map_def {
    int type;
    int max_entries;
    void *btf_key_ref;
    void *btf_val_ref;
} = {
    ...
    .btf_key_ref = &my_key,
    .btf_val_ref = &type_int,
};

The advantage being that map_def is no longer modified for each
instance and k/v combination.  And I get my assignment to k/v members :)

But really, I give up, I can't come up with anything better :)
