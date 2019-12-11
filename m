Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6BD11AC0A
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2019 14:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfLKN0u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Dec 2019 08:26:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27973 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727477AbfLKN0t (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Dec 2019 08:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576070808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EoTSIGW7dIJHgyHfv6VYXZOjhqsmrik9Ca88NM1ooWk=;
        b=QcRm5uojqx3i0dIXL10mDSbMdchdX38TTQ9uVx18yQZ3ePeaF5cXnEU+tjT9yftf7W6K/v
        hkDFOeZ1x9b5OEfmIU73d7kgwb6sbzL8wGC562RtJZWjk5CbHk4FfLzjiYYTQUJIOLbF4Y
        XmP52Y7eI2H4VVM+lOXC+hwxA+1CGVk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-e1_h8MJiPPaQ3GbdTYVBdQ-1; Wed, 11 Dec 2019 08:26:41 -0500
Received: by mail-lf1-f70.google.com with SMTP id d6so2920137lfl.3
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2019 05:26:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Z7qkzCEcLT30vlK9W48ZkVutYS+mgkfmvmct14cHJaU=;
        b=O7K/yg7Ba9YAUuhOVgQcnalHzyKiVdHGn3pQSRfpuGnCsO1bGIy4eNGS7FwMqCOwS+
         xlFTk25zLiAKV2+LKIa/iCxUS8djm3zilni7K6LBwY+Npk4vaJIkez0o19kSwxgQvx6R
         SYauyOhyoMTVgjgw973KsFnZnS9RA5Qc4AMa0Vjpx218X4rDB10XU79kUT9e2S5yQP4M
         VKRlO5o5HBXztCzJEGDymZquP3S+KERUqnZUkyabfZ3u6/Be7MhY/NoXONNTI/ONBZgh
         I7v73FhMLaKTJxRv3YqCHUMXkXtBiWAyQLxsub64TDoHyA+MBQdZtUG6XATkMnTs+fJx
         8O1w==
X-Gm-Message-State: APjAAAWTdWO2nXkNPg9OfJ8ICaWmxvo59NcQNSl0Mf1abKrBEAfHgP3K
        qEsI6yaAXWzdp45L6GGqWrsAmK5F7mEmlUGyNcn5TsBXWaeQ+dUjvZcJqZJHLo7IaFLyoH2K4h9
        JWLcMWH0qd9nD
X-Received: by 2002:a2e:2201:: with SMTP id i1mr2015192lji.110.1576070800609;
        Wed, 11 Dec 2019 05:26:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYVnoqrtZTMQ9wa0n82A5zBywFy+czDxizbC4YxBS0hc+IR5MDsNMNL36dUhYMKqeuop2eqw==
X-Received: by 2002:a2e:2201:: with SMTP id i1mr2015175lji.110.1576070800467;
        Wed, 11 Dec 2019 05:26:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i1sm1186646lji.71.2019.12.11.05.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 05:26:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C395918033F; Wed, 11 Dec 2019 14:26:38 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, magnus.karlsson@gmail.com,
        magnus.karlsson@intel.com, jonathan.lemon@gmail.com,
        ecree@solarflare.com, thoiland@redhat.com, brouer@redhat.com,
        andrii.nakryiko@gmail.com
Subject: Re: [PATCH bpf-next v4 2/6] bpf: introduce BPF dispatcher
In-Reply-To: <20191211123017.13212-3-bjorn.topel@gmail.com>
References: <20191211123017.13212-1-bjorn.topel@gmail.com> <20191211123017.13212-3-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 11 Dec 2019 14:26:38 +0100
Message-ID: <87wob3f0xd.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: e1_h8MJiPPaQ3GbdTYVBdQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[...]
> +/* The BPF dispatcher is a multiway branch code generator. The
> + * dispatcher is a mechanism to avoid the performance penalty of an
> + * indirect call, which is expensive when retpolines are enabled. A
> + * dispatch client registers a BPF program into the dispatcher, and if
> + * there is available room in the dispatcher a direct call to the BPF
> + * program will be generated. All calls to the BPF programs called via
> + * the dispatcher will then be a direct call, instead of an
> + * indirect. The dispatcher hijacks a trampoline function it via the
> + * __fentry__ of the trampoline. The trampoline function has the
> + * following signature:
> + *
> + * unsigned int trampoline(const void *xdp_ctx,
> + *                         const struct bpf_insn *insnsi,
> + *                         unsigned int (*bpf_func)(const void *,
> + *                                                  const struct bpf_ins=
n *));
> + */

Nit: s/xdp_ctx/ctx/

-Toke

