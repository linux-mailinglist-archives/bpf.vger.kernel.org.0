Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7159B124596
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2019 12:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfLRLTr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Dec 2019 06:19:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51151 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726682AbfLRLTr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Dec 2019 06:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576667986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n07B+kXgoJYUs4D8MS+09AAL4+VW4I9tgy+52pR36io=;
        b=gPI+3svHun27Mcb8v84k2VzhkNdxjWLIdHRNWSiZBcEm+1+L21OfxfG3vXbuLAtuQnXTcK
        mYwDXvziL1dfgx1hrf0ZV2vv0HzpIQ2N7U8hxUjgaKScVhIQzo42GW0SSI2bkDcLAoVXlH
        cxGC4MCgOqUCGpqRzKEP4QqIpuL+DjQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-oOBZ2T-bOTiZSgq3VsfV9A-1; Wed, 18 Dec 2019 06:19:45 -0500
X-MC-Unique: oOBZ2T-bOTiZSgq3VsfV9A-1
Received: by mail-lf1-f70.google.com with SMTP id t3so186107lfp.15
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 03:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=n07B+kXgoJYUs4D8MS+09AAL4+VW4I9tgy+52pR36io=;
        b=qzyWqhd8YZYKFVt5b3t/jMuO5oI6ML6ir1O0CW9ZbfjfGsKdgqWVarRYqMinM4BM/t
         Cta8NN6qyIZMkwmi1z6yrPYwVeCAPkvZZYWz/Roa6DoPBOqBWRgBBriRLBF0dnB23jDn
         T/sMdN5mJUHXMPjBmx7zTwTO0WFaPnVgNg89kTFEIeFgg/xkbxtSBn9I+UjiKJaABYuj
         ic2B3RfIP/sppr4WWN6PQ1h6EOgIbgpFTTZvN4bySMefI2lTnvTbjFLeDn7oYDpaY08U
         IUKo1/nnIA5yekqeiv09/JkMdgoWPxAF28kpjdxfE9GLddQt5ktecSI3GgwlAzJcFev0
         OSAw==
X-Gm-Message-State: APjAAAXn6YhiFQKhGdj0frQPHDZxceNNSzkJmqNPk84LJq4bNoQMqPn3
        xV0oeIE3dm3wFyEBmHhKB0nUHmXy10QRHT+di51B6n2D2xMLVV0Xn9JtE9k2zt20Zrc81ZrcLCO
        IpWIN5rtvgMwz
X-Received: by 2002:ac2:531b:: with SMTP id c27mr1364569lfh.91.1576667983686;
        Wed, 18 Dec 2019 03:19:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTpse7JbFjgVn/7mZKYkYaCYefEQmTfJFMx8+24/+Xfes+KhZMurnFLwgWiT3NkBtHs46+Tw==
X-Received: by 2002:ac2:531b:: with SMTP id c27mr1364563lfh.91.1576667983552;
        Wed, 18 Dec 2019 03:19:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q27sm906436ljm.25.2019.12.18.03.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:19:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0EB88180969; Wed, 18 Dec 2019 12:19:42 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, davem@davemloft.net,
        jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, magnus.karlsson@intel.com,
        jonathan.lemon@gmail.com
Subject: Re: [PATCH bpf-next 4/8] xsk: make xskmap flush_list common for all map instances
In-Reply-To: <20191218105400.2895-5-bjorn.topel@gmail.com>
References: <20191218105400.2895-1-bjorn.topel@gmail.com> <20191218105400.2895-5-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 18 Dec 2019 12:19:42 +0100
Message-ID: <87tv5x6fu9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> The xskmap flush list is used to track entries that need to flushed
> from via the xdp_do_flush_map() function. This list used to be
> per-map, but there is really no reason for that. Instead make the
> flush list global for all xskmaps, which simplifies __xsk_map_flush()
> and xsk_map_alloc().
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

