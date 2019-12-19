Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAAE126FEE
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 22:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLSVq3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 16:46:29 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:33873 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfLSVq2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 16:46:28 -0500
Received: by mail-qt1-f177.google.com with SMTP id 5so6367471qtz.1
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 13:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VO6Oa9byymwyW6n23ILZAJDl6f5Ys1IOFf5yRPmHuPo=;
        b=LzRhNFGA5iZor0jf32Zm9YWEhI87EluLTGg6MUh3iGNs6XNwn0UTbGxldDCEF4IOfz
         3DsLwGj94OyxxRUwEXEOz683yvpPPgpXQ8XvqTJ/DnFPn/0tYWAff+ABqyS6abz0CkeH
         cHPthvsyIRSJL8qxrYA9agRd7wyidVd/liGYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VO6Oa9byymwyW6n23ILZAJDl6f5Ys1IOFf5yRPmHuPo=;
        b=I92e+mhUQa4uPtc+JmZx9Ac6tNnhiwL+sf7zH/7tbQ1IWnM3b5MluunPa+UEDtIjZ0
         x5l81fCVMUNx6Nn9qa3hf2TRLRT3uPwU+13f9zqbl4UPKLNr2/95TfuZecKXMEVFz7Io
         pM+ePQlas4fW45S6BAty62luPCRWnTIeSlXnfh5TgU0Zyp1f6/CYvJwNKkelkPgRHVOa
         QK+4t6GOPEosiIjWze2VjjvIokbvstjTmMCaIu/1h2d9QedkF1RYJT4pH51Wy4HFac8n
         ljGcSB+J93l5oNmzCptWLLpKNNUHHAiEZGCw9gPajF/pHO2PVo8H4Yo3n22PVLR/ISh8
         XdMw==
X-Gm-Message-State: APjAAAUjio4YqkirnAsfGortZwQ8QFWX5WOUD+FEoPVij6CMkhIxSG2O
        YE99ithAl86a3X0hY9BUd3xZR9F1JpGKrdoPvzrv+F1+vo06Tg==
X-Google-Smtp-Source: APXvYqwpqC74xeUMj8yQEwAE+ZczgnB/Uh/jOqqfs4iRaiimV06OcME38a4mJLo8X5ezJq61ccNR97lNfS0+INihS/4=
X-Received: by 2002:ac8:602:: with SMTP id d2mr9200816qth.245.1576791987660;
 Thu, 19 Dec 2019 13:46:27 -0800 (PST)
MIME-Version: 1.0
From:   Alex Forster <aforster@cloudflare.com>
Date:   Thu, 19 Dec 2019 15:46:16 -0600
Message-ID: <CAKxSbF2XaqwLAby0BBbhT_8vBviMvkA_7fiK-ivAs2DHWqARxw@mail.gmail.com>
Subject: getsockopt(XDP_MMAP_OFFSETS) syscall ABI breakage?
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The getsockopt(XDP_MMAP_OFFSETS) socket option returns a struct
xdp_mmap_offsets (from uapi/linux/if_xdp.h) which is defined as:

    struct xdp_mmap_offsets {
        struct xdp_ring_offset rx;
        struct xdp_ring_offset tx;
        struct xdp_ring_offset fr; /* Fill */
        struct xdp_ring_offset cr; /* Completion */
    };

Prior to kernel 5.4, struct xdp_ring_offset (from the same header) was
defined as:

    struct xdp_ring_offset {
        __u64 producer;
        __u64 consumer;
        __u64 desc;
    };

A few months ago, in 77cd0d7, it was changed to the following:

    struct xdp_ring_offset {
        __u64 producer;
        __u64 consumer;
        __u64 desc;
        __u64 flags;
    };

I believe this constitutes a syscall ABI breakage, which I did not
think was allowed. Have I misunderstood the current stability
guarantees for AF_XDP?

Alex Forster
