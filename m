Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01B1E60B0A
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2019 19:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfGERY6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Jul 2019 13:24:58 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:40754 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbfGERY6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Jul 2019 13:24:58 -0400
Received: by mail-pf1-f180.google.com with SMTP id p184so4579371pfp.7
        for <bpf@vger.kernel.org>; Fri, 05 Jul 2019 10:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=d3s3SBENazi+neNuUbKyg+zpRgK2bMmKyLp7qJigkjQ=;
        b=eD41D5uDvC8UNeSc5PMBlcznYeOm16lFlrKDT/hAC/XZW6wdAqWvCN3poxd1OPNuc+
         H++y4+Cvpg6EK0JPQ1TnpD0HF8qF8K4F3m8yXB9uqcehljdC+ppIZIrjDdmBwuN+/cIP
         U63C4ZAG8fgDi0dZ4nZkd2Sm0vquNF9eJTAoiyJ+bWs8mVBZWltF2HZeBzQTdsma7Fih
         0MwFZdiz0uOQe6KX+jlGH8DhoFSTETKVMo0WNcaamzSF/jdnoMIYfczIx6wRNFayqesp
         g6mdgA7CLwyM+OciKZOB/7Jj9LOeO7LR+vl6XQPNJ+sCNYkAqn4OYxVe5elDV44LP5kp
         sXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=d3s3SBENazi+neNuUbKyg+zpRgK2bMmKyLp7qJigkjQ=;
        b=Poo9jSwUzidezXGG4gY2dF2w2e53WzFl3uGJN/5vL45iIhavQxSDrJEu1BriTKhwxx
         skFTQAmoyj/2bV8+Up2j3deHMLr1neOfeWAPdczztIVVvESf26+NSkIHWnfftwdUfjqI
         Oh+Ga6Yng8aWCD+SgVesr7RlYNHq2gwQdkU0cleJkrk0Bmd2THWlbgfTFcOepWmt/Nms
         Grfq530YTH/b+TEgb/DYxSi0VV4YzVbxsBuftNqey02mWlg7tztuqm9QcyO1qUKVUNjy
         E3FK/c4/9ovLNxB3Od7Pvf0e/BcNf6xeEiACQp5HOmT93Ia/MMvOUSODPOCq4r7Weeuu
         KtAA==
X-Gm-Message-State: APjAAAVLkOntng9/nl3BpfBTKIxft+L2wYKK+/2vw8lssFnq2+VEhuMZ
        tHVgx/ysHKztlUnawrE/EXH8s/CZuVk=
X-Google-Smtp-Source: APXvYqxuSCrHFZC8mkY7J6hcuNUgpA5qQ2s7xKC/7jrVdDxIChwrH+8wstDBJ9Iv6cyT7cqWFx1lgg==
X-Received: by 2002:a63:7e1d:: with SMTP id z29mr6690802pgc.346.1562347497395;
        Fri, 05 Jul 2019 10:24:57 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 30sm11577802pjk.17.2019.07.05.10.24.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 10:24:57 -0700 (PDT)
Date:   Fri, 5 Jul 2019 10:24:52 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Michael Petlan <mpetlan@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: Re: [PATCHv2] tools bpftool: Fix json dump crash on powerpc
Message-ID: <20190705102452.0831942a@cakuba.netronome.com>
In-Reply-To: <20190705121031.GA10777@krava>
References: <20190704085856.17502-1-jolsa@kernel.org>
        <20190704134210.17b8407c@cakuba.netronome.com>
        <20190705121031.GA10777@krava>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 5 Jul 2019 14:10:31 +0200, Jiri Olsa wrote:
> Michael reported crash with by bpf program in json mode on powerpc:
> 
>   # bpftool prog -p dump jited id 14
>   [{
>         "name": "0xd00000000a9aa760",
>         "insns": [{
>                 "pc": "0x0",
>                 "operation": "nop",
>                 "operands": [null
>                 ]
>             },{
>                 "pc": "0x4",
>                 "operation": "nop",
>                 "operands": [null
>                 ]
>             },{
>                 "pc": "0x8",
>                 "operation": "mflr",
>   Segmentation fault (core dumped)
> 
> The code is assuming char pointers in format, which is not always
> true at least for powerpc. Fixing this by dumping the whole string
> into buffer based on its format.
> 
> Please note that libopcodes code does not check return values from
> fprintf callback, but as per Jakub suggestion returning -1 on allocation
> failure so we do the best effort to propagate the error. 
> 
> Reported-by: Michael Petlan <mpetlan@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Thanks, let me repost all the tags (Quentin, please shout if you're
not ok with this :)):

Fixes: 107f041212c1 ("tools: bpftool: add JSON output for `bpftool prog dump jited *` command")
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
