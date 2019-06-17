Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F11B548076
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2019 13:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfFQLR7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 17 Jun 2019 07:17:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33795 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbfFQLR7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Jun 2019 07:17:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so15662838edb.1
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2019 04:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=V6M79Bvlfn3Y/3r6Oi9ctX8EPoRwXSGOlJOMMHDPmWM=;
        b=lhaasLpPqfb4oCpMouFWTWXiOKKJNKKppLvTp/QEMgb0VqRZS/4h6iigFd8UubMqce
         qODCzc+jq4WdekrXklz4o7eH1cHiDwWvrTiVheBbgT/SE67IPWYNcJfqMI3RJduJGYvJ
         sII27io8bS36UHYn4FZrjzcBdHM7hy7Oc0xoxQD0OF0dx4VS/dV2uJ+Z1rBL5E7ta/L6
         Xwb5d7IRvlyMhNO+33f9jP4lkaz3MngqmmIx1p9B1Wh7HjQ/r9OmjX4M6Yk6p8Nj56j1
         0LCMmxE7oDhAaESgNg/yyubMSudoGflaNoS2OKfdYftBtPZFzPPdWH01zxZJQ/VBY3ni
         fHaQ==
X-Gm-Message-State: APjAAAVGq+9zJOhCvTARFGsEgY9jqeTRyIKX+vRUnSbUpbnF2qiUYBm8
        3nmN54NXghJAn0kBAD7wSgROig==
X-Google-Smtp-Source: APXvYqybOnw23k91/01uyTY1erdQuXnt4RumEV5SJQxuntvKl1Idy+2CKVinXUELC+WWGYW2kTgDhg==
X-Received: by 2002:a17:906:6a45:: with SMTP id n5mr42843163ejs.61.1560770277849;
        Mon, 17 Jun 2019 04:17:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id f3sm2149878ejo.90.2019.06.17.04.17.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 04:17:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BEA4C1804AF; Mon, 17 Jun 2019 13:17:56 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Anton Protopopov <a.s.protopopov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anton Protopopov <a.s.protopopov@gmail.com>
Subject: Re: [PATCH bpf] bpf: fix the check that forwarding is enabled in bpf_ipv6_fib_lookup
In-Reply-To: <20190615225348.2539-1-a.s.protopopov@gmail.com>
References: <20190615225348.2539-1-a.s.protopopov@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 17 Jun 2019 13:17:56 +0200
Message-ID: <877e9ka2aj.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Anton Protopopov <a.s.protopopov@gmail.com> writes:

> The bpf_ipv6_fib_lookup function should return BPF_FIB_LKUP_RET_FWD_DISABLED
> when forwarding is disabled for the input device.  However instead of checking
> if forwarding is enabled on the input device, it checked the global
> net->ipv6.devconf_all->forwarding flag.  Change it to behave as expected.
>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>

Thanks!

Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
