Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBC1598337
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2019 20:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfHUSiZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Aug 2019 14:38:25 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45824 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfHUSiZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Aug 2019 14:38:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so2714927qki.12
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2019 11:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=XDlPfXRQuCPTCFskR9JG+Wsrqkken/Qm3lzMWM8DxQY=;
        b=E8ncTyp78G09Ml3oDEKWx4WWp1oBs8ewBRvCvHL71PZX4EiuhkfYo+NEOcEFerYYjg
         ME8120Myrk0zxGFkcd+JVQ/Zv40mVmjmwUisMqPWZFxnfikG+0PClD+V8VtjzQdtx9NY
         O82w76IPamf9t/sZioRnBxwDsDpkWF2D7wXjTaFQnhsJL5HQmfXwWH5RNBwL8Riu3B3o
         VeHOFbw3MNfmi6WdDb4tRtBmFl+ZUmOUvZrMEgB6paU/IzQAXIWndWVzhJm2dujx7dQ8
         WCNhzmw1q6cYkCms3I2Ft77m+iZ+nz3SXbFpdv+7m8nZ8xtYHmBa+sJ/q2BktavB8CXH
         W/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=XDlPfXRQuCPTCFskR9JG+Wsrqkken/Qm3lzMWM8DxQY=;
        b=EpJ3HERLIuGnkG9h9hhlpmbXAj2qBw8eJFO5jeIYo9XIsmuYsVfHZOn1O64g6cWbtA
         9gjNKV02cXtxKK8WNu4EJyJQEne2ShLcv+lIvg9V3QqF3yEM5DgwtALZ8nw/KFLych8r
         Oz54fjyY8DOMXr/Z8ZMSXQz7669mPfJW4I/K36MLRofSAQSBl8z/g2Rp/qGtgTnVecuR
         /GMc9ZbXqK9UzhZaw4365fLDNuNHjnXuL6dzqfZ+jSf5FByKTNX4JndFsWNqLmDp0Ol/
         0x1sGwvvqZsAPbNJg7ZKHbeCtVpfERLuIEv4MvI73d0S5UWQ7VrgO5YglxBXk07wg/W2
         2vXQ==
X-Gm-Message-State: APjAAAX4lJNvLNa4F1NtqHuN2Qw3d+pWnosww6g/r6DFVmq8fbTJp9hn
        t+T2Q2HE66gxW6YMe1AHRNNFEg==
X-Google-Smtp-Source: APXvYqxUMD6ESn0CCDKKuMpJDp9Of8FsLAwQpIVdxp6TANQKqRzeiAON5wzfi/oG1vODOtHolL7iaA==
X-Received: by 2002:a37:2f05:: with SMTP id v5mr32971442qkh.143.1566412704245;
        Wed, 21 Aug 2019 11:38:24 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id d22sm10068312qto.45.2019.08.21.11.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:38:24 -0700 (PDT)
Date:   Wed, 21 Aug 2019 11:38:16 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Toshiaki Makita <toshiaki.makita1@gmail.com>
Cc:     Stanislav Fomichev <sdf@fomichev.me>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, William Tu <u9012063@gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/14] xdp_flow: Flow offload to XDP
Message-ID: <20190821113816.4dee030a@cakuba.netronome.com>
In-Reply-To: <250f99fd-7289-a8e2-a710-560305e2d17d@gmail.com>
References: <20190813120558.6151-1-toshiaki.makita1@gmail.com>
        <20190814170715.GJ2820@mini-arch>
        <14c4a876-6f5d-4750-cbe4-19622f64975b@gmail.com>
        <20190815152100.GN2820@mini-arch>
        <20190815122232.4b1fa01c@cakuba.netronome.com>
        <da840b14-ab5b-91f1-df2f-6bdd0ed41173@gmail.com>
        <20190816115224.6aafd4ee@cakuba.netronome.com>
        <5e9bee13-a746-f148-00de-feb7cb7b1403@gmail.com>
        <20190819111546.35a8ed76@cakuba.netronome.com>
        <250f99fd-7289-a8e2-a710-560305e2d17d@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 21 Aug 2019 17:49:33 +0900, Toshiaki Makita wrote:
> > Having an implementation nor support a feature of another implementation
> > and degrade gracefully to the slower one is not necessarily breakage.
> > We need to make a concious decision here, hence the clarifying question.  
> 
> As I described above, breakage can happen in some case, and if the patch 
> breaks xdp_flow I think we need to fix xdp_flow at the same time. If 
> xdp_flow does not support newly added features but it works for existing 
> ones, it is OK. In the first place not all features can be offloaded to 
> xdp_flow. I think this is the same as HW-offload.

I see, that sounds reasonable, yes. Thanks for clarifying.
